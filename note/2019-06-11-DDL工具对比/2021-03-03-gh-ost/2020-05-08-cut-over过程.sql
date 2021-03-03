

copy完数据之后进行原始表和影子表cut-over切换

1. gh-ost的切换是原子性切换，基本是通过两个会话的操作来完成 

	session 1                           session 2                 session 3

	begin;
	lock tables t1 write, _t1_del write;
										新的DML请求进来，关于原表的请求被blocked


																  rename table `t1` to `_t1_del`, `_t1_gho` to `t1` 
																  --会被阻塞
										  
	drop table if exists _t1_del; 

	unlock tables;
									  
	session1释放锁后，session3会 rename 成功

2. 其原理是基于MySQL 内部机制:
	被lock table 阻塞之后，执行rename的优先级高于dml，也即先执行rename table ，然后执行dml 。假设gh-ost操作的会话是c10 和c20 ，其他业务的dml请求的会话是c1-c9,c11-c19,c21-c29。
	
	1 会话 c1..c9: 对b表正常执行DML操作。
	2 会话 c10 : 创建_b_del 防止提前rename 表，导致数据丢失。
		  create /* gh-ost */ table `test`.`_b_del` (
				id int auto_increment primary key
			) engine=InnoDB comment='ghost-cut-over-sentry'
			
	3 会话 c10 执行LOCK TABLES b WRITE, `_b_del` WRITE。
	4 会话c11-c19 新进来的dml或者select请求，但是会因为表b上有锁而等待。
	5 会话c20:设置锁等待时间并执行rename
		set session lock_wait_timeout:=1
		rename /* gh-ost */ table `test`.`b` to `test`.`_b_20190908220120_del`, `test`.`_b_gho` to `test`.`b`
	  c20 的操作因为c10锁表而等待。
	  
	6 c21-c29 对于表 b 新进来的请求因为lock table和rename table 而等待。
	7 会话c10 通过sql 检查会话c20 在执行rename操作并且在等待mdl锁。
	select id
				from information_schema.processlist
				where
					id != connection_id()
					and 17765 in (0, id)
					and state like concat('%', 'metadata lock', '%')
					and info  like concat('%', 'rename', '%')

	8 c10 基于步骤7 执行drop table `_b_del` ,删除命令执行完，b表依然不能写。所有的dml请求都被阻塞。

	9 c10 执行UNLOCK TABLES; 此时c20的rename命令第一个被执行。而其他会话c1-c9,c11-c19,c21-c29的请求可以操作新的表b。


3. 如果cut-over过程的各个环节执行失败会发生什么？ 其实除了安全，什么都不会发生。

	1. 如果c10的create `_b_del` 失败，gh-ost 程序退出。

	2. 如果c10的加锁语句失败，gh-ost 程序退出，因为表还未被锁定，dml请求可以正常进行。

	3. 如果c10在c20执行rename之前出现异常
	 
	 A. c10持有的锁被释放，查询c1-c9，c11-c19的请求可以立即在b执行。
	 B. 因为`_b_del`表存在, c20的rename table b to  `_b_del`会失败。
	 C. 整个操作都失败了，但没有什么可怕的事情发生，有些查询被阻止了一段时间，我们需要重试。

	4. 如果c10在c20执行rename被阻塞时失败退出,与上述类似，锁释放，则c20执行rename操作因为——b_old表存在而失败，所有请求恢复正常。

	5. 如果c20异常失败，gh-ost会捕获不到rename，会话c10继续运行，释放lock，所有请求恢复正常。

	6. 如果c10和c20都失败了，没问题: lock被清除，rename锁被清除。 c1-c9，c11-c19，c21-c29可以在b上正常执行。


4. 整个过程对应用程序的影响

	应用程序对表的写操作被阻止，直到交换影子表成功或直到操作失败。如果成功，则应用程序继续在新表上进行操作。如果切换失败，应用程序继续在原表上进行操作。

5. 对复制的影响

	slave因为binlog文件中不会复制lock语句，只能应用rename 语句进行原子操作,对复制无损。


这里可以通过实验验证下.


6. 相关参考
	https://mp.weixin.qq.com/s/VMAMhaEN6TXANc29Qc0rPA  gh-ost的cut-over过程
	https://www.cnblogs.com/yangyi402/p/11557878.html

	
