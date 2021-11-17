
1. Command列
2. State列
3. Show proceslist时发现大量的sleep，有什么风险吗，该如何处理？
4. 相关参考


1. Command列
	command 表示连接状态，一般是休眠（sleep），查询（query），连接（connect）

	1. Sleep：
		线程正在等待客户端发送新的请求；

	2. Query：
		线程正在执行查询或者正在将结果发送给客户端；

	3. Locked：
		在MySQL服务器层， 该线程正在等待表锁；
		InnoDB的行锁， 不会体现在线程状态中；

	4. Analyzing and statistics：
		线程正在收集存储引擎的统计信息， 并生成查询的执行计划；

	5. copy to tmp table：

		 正在将结果集拷贝到一个临时表中；

		 copy to tmp table的场景：
				
			1. Online DDL 
				alter table sbtest1 drop column id;
				mysql>show processlist;
				+----+------+---------------------+--------+------------------+------+---------------------------------------------------------------+------------------------------------+
				| Id | User | Host                | db     | Command          | Time | State                                                         | Info                               |
				+----+------+---------------------+--------+------------------+------+---------------------------------------------------------------+------------------------------------+
				| 19 | repl | 192.168.1.29:55692  | NULL   | Binlog Dump GTID | 3002 | Master has sent all binlog to slave; waiting for more updates | NULL                               |
				| 39 | lujb | 192.168.1.100:63704 | sbtest | Sleep            |    2 |                                                               | NULL                               |
				| 40 | root | localhost           | sbtest | Query            |   62 | copy to tmp table                                             | alter table sbtest1 drop column id |
				| 42 | root | localhost           | NULL   | Query            |    0 | starting                                                      | show processlist                   |
				+----+------+---------------------+--------+------------------+------+---------------------------------------------------------------+------------------------------------+
				4 rows in set (0.00 sec)
				
				State=copy to tmp table： 表示需要拷贝原表的数据到临时表中。		
			2. group by操作

			3. 文件排序操作

			4. UNION操作
			
			
	6. Copying to tmp table on disk：

		内存临时表的结果集太大，需要转换成磁盘临时表进行存储数据；

		增大sort buffer和tmp_table_size

	  
	7. Sorting Result：

		线程正在对结果集进行排序；

		类似Creating sort index，但是是在表内，而不是在临时表中，建议加索引。


2. State列

	set profiling = 1;
	SELECT count(*) FROM `table_web_loginlog` force index(idx_loginIp_szTime) WHERE loginIp = '192.168.0.71'  AND sztime  > '2020-06-25 16:08:36' and nPlayerId != 1000;
	show profiles;
	show profile for query 1;
	    Status 类似于 show processlist.State 的值
		+----------------------+----------+
		| Status               | Duration |
		+----------------------+----------+
		| starting             | 0.000068 |
		| checking permissions | 0.000009 |
		| checking permissions | 0.000004 |
		| Opening tables       | 0.000013 |
		| init                 | 0.000038 |
		| System lock          | 0.000007 |
		| optimizing           | 0.000028 |
		| statistics           | 0.000112 |
		| preparing            | 0.000033 |
		| executing            | 0.000003 |
		| Sending data         | 0.192259 |
		| end                  | 0.000012 |
		| query end            | 0.000010 |
		| closing tables       | 0.000008 |
		| freeing items        | 0.000019 |
		| cleaning up          | 0.000010 |
		+----------------------+----------+
		16 rows in set, 1 warning (0.00 sec)
	

	set profiling = 1;
	select word from words order by rand() limit 3;
	show profiles;
		root@localhost [db1]>show profile cpu,block io for query 1;
		+---------------------------+----------+----------+------------+--------------+---------------+
		| Status                    | Duration | CPU_user | CPU_system | Block_ops_in | Block_ops_out |
		+---------------------------+----------+----------+------------+--------------+---------------+
		| starting                  | 0.000240 | 0.000236 |   0.000000 |            0 |             0 |
		| checking permissions      | 0.000025 | 0.000022 |   0.000000 |            0 |             0 |
		| checking permissions      | 0.000009 | 0.000009 |   0.000000 |            0 |             0 |
		| Opening tables            | 0.000030 | 0.000030 |   0.000000 |            0 |             0 |
		| init                      | 0.000059 | 0.000059 |   0.000000 |            0 |             0 |
		| System lock               | 0.000018 | 0.000018 |   0.000000 |            0 |             0 |
		| optimizing                | 0.000016 | 0.000015 |   0.000000 |            0 |             0 |
		| statistics                | 0.000127 | 0.000131 |   0.000000 |            0 |             0 |
		| preparing                 | 0.000055 | 0.000051 |   0.000000 |            0 |             0 |
		| Creating tmp table        | 0.000104 | 0.000108 |   0.000000 |            0 |             0 |
		| Sorting result            | 0.000024 | 0.000020 |   0.000000 |            0 |             0 |
		| executing                 | 0.000007 | 0.000007 |   0.000000 |            0 |             0 |
		| Sending data              | 0.000121 | 0.000122 |   0.000000 |            0 |             0 |
		| converting HEAP to ondisk | 0.000328 | 0.000327 |   0.000000 |            0 |             0 |    -- 该线程正在将内部临时表从 MEMORY 表转换为磁盘表, 考虑优化SQL或者增加tmp_table_size参数的大小
		| Sending data              | 0.019617 | 0.019609 |   0.000000 |            0 |             0 |
		| Creating sort index       | 0.005121 | 0.005121 |   0.000000 |            0 |             0 |
		| end                       | 0.000053 | 0.000047 |   0.000000 |            0 |             0 |
		| query end                 | 0.000020 | 0.000018 |   0.000000 |            0 |             0 |
		| removing tmp table        | 0.000220 | 0.000222 |   0.000000 |            0 |             0 |
		| query end                 | 0.000011 | 0.000009 |   0.000000 |            0 |             0 |
		| closing tables            | 0.000015 | 0.000015 |   0.000000 |            0 |             0 |
		| freeing items             | 0.000032 | 0.000032 |   0.000000 |            0 |             0 |
		| cleaning up               | 0.000019 | 0.000019 |   0.000000 |            0 |             0 |
		+---------------------------+----------+----------+------------+--------------+---------------+
		23 rows in set, 1 warning (0.00 sec)
					
				
	表示用于显示当前sql语句的状态

	1. Sending data：

		这表示多种情况：
			1. 线程可能在多个状态之间传送数据
			2. 在生成结果集
			3. 在向客户端返回数据；

        是什么：-- by丁奇
            表示语句正在执行，其中有两种正在执行的情况：
                1. 正在向客户端发送/返回数据；
                2. 可能是处于 执行器 过程中的任意阶段；
        	
		官方文档： 

			Sending data 表示在读取以及处理行数据以及发送数据到客户端；
			https://dev.mysql.com/doc/refman/5.7/en/general-thread-states.html

		
		7. 执行器：
		 1. 先判断对表有没有执行/操作权限
		 2. 如果没有权限，返回权限的错误
				mysql> select * from T where ID=10;
				ERROR 1142 (42000): SELECT command denied to user 'b'@'localhost' for table 'T' 
		 3. 如果有权限，打开表继续执行
		 4. 调用存储引擎接口：   
			打开表的时候，执行器就会根据表的引擎定义，去使用这个引擎提供的接口。
			比如我们这个例子中的表 T 中，ID 字段没有索引，那么执行器的执行流程如下所示：
				1. 调用 InnoDB 引擎接口取这个表的第一行，判断 ID 值是不是 10，如果不是则跳过，如果是则将这行存在结果集中；
				2. 调用引擎接口取 下一行，重复相同的判断逻辑，直到取到这个表的最后一行。
				3. 执行器将上述遍历过程中所有满足条件的行组成的记录集作为结果集返回给客户端。
				4. 这个语句执行完成
				 
		执行器的作用：操作引擎，返回结果
	
	
	2. Sending to client：

		表示线程处于 等待客户端接收结果 的状态；

		《2021-02-08-Writing to net-Sending data和Sending to client》
		
		
	3. Creating sort index，当前的SELECT需要用到临时表进行order by，建议加索引
		
		Creating sort index 表示需要用到临时表进行order by辅助排序

	4. Creating tmp table，建议创建适当的索引，少用UNION,VIEW,SUBQUERY


	5. altering table : DDL语句 正在 执行


	6. query end
		
		在我遇到的案例中有大事物造成的小事物commit慢的情况，且状态也是query end
		2种query end(或者显示commit为starting)状态下小事物提交慢的可能
			1、某个大事物提交引起偶尔的提交慢
			2、binlog_group_commit_sync_delay和binlog_group_commit_sync_no_delay_count 设置不正确引起提交慢

			作者：gaopengtttt
			链接：https://www.jianshu.com/p/bfd4a88307f2
			来源：简书
			著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
	
	7. Waiting for table metadata lock
		表示需要获取元数据锁，但是处于等待状态
		
	8. Waiting for table flush
		 表示 现在有一个线程正要对 某个表 做 flush操作; 
		 参考笔记 《19：分析只查询一行记录，为什么执行慢》
		 
	9. Waiting for commit lock
		由于 flush table with read lock 调用函数 make_global_read_lock_block_commit 导致事务不能提交   
		
		https://www.jianshu.com/p/56d268983822    MySQL：简单记录一下Waiting for commit lock
		
	10. Waiting for global read lock
		
		由于flush table with read lock调用函数lock_global_read_lock导致DML操作堵塞。
		https://www.jianshu.com/p/56d268983822    MySQL：简单记录一下Waiting for commit lock
		
	11. Waiting for semi-sync ACK from slave

	12. system lock 
		https://mp.weixin.qq.com/s/ltpoCqbFqa07TlmM2DEc7Q  《叶问》第19期
		MySQL从库show processlist出现system lock的原因以及解决方法有哪些？

	
		Slave_SQL_Running_State: System lock                 -- 正在应用relay log
			参考笔记: <2020-10-22-DML事务在从库延迟的现象追踪.sql>
		
	
	13. Opening tables

		The thread is trying to open a table. This is should be very fast procedure, unless something prevents opening. 
		For example, an ALTER TABLE or a LOCK TABLE statement can prevent opening a table until the statement is finished. 
		怎么知道SQL语句使用到了磁盘临时表估辅助排序？
			通过 show profiles 查看。
	
	15. checking permissions 
		The thread is checking whether the server has the required privileges to execute the statement.

		线程正在检查服务器是否具有执行语句所需的权限。
		
3. Show proceslist时发现大量的sleep，有什么风险吗，该如何处理？

	答：

	（一）可能的风险有：

		1、大量sleep线程会占用连接数，当超过max_connections后，新连接无法再建立，业务不可用；

		2、这些sleep线程中，有些可能有未提交事务，可能还伴随着行锁未释放，有可能会造成严重锁等待；

		3、这些sleep线程中，可能仍有一些内存未释放，数量太多的话，是会消耗大量无谓的内存的，影响性能。



	（二）建议应对措施：

		1、升级到5.7及以上版本，连接性能有所提升；

		2、采用MariaDB/Percona版本，根据情况决定是否启用thread pool功能；

		3、适当调低wait_timeout/interactive_timeout值，例如只比java连接池的timeout时间略高些即可；

		4、利用pt-kill或辅助脚本/工具巡查并杀掉无用sleep进程；

		5、利用5.7的新特性，适当设置max_execution_time阈值，消除长时间执行的SQL；

		6、定期检查show processlist的结果，找到长时间sleep的线程，根据host&port反推找到相关应用负责人，协商优化方案
		
	
4. 相关参考

	https://www.cnblogs.com/zping/p/11002275.html    MySQL线程状态详解
	高性能MySQL 第3版 第207页
    https://dev.mysql.com/doc/refman/5.7/en/general-thread-states.html
	https://www.jb51.net/article/156313.htm  MySQL SHOW PROCESSLIST协助故障诊断全过程
	https://zhuanlan.zhihu.com/p/30743094    mysql: show processlist 详解
	https://mp.weixin.qq.com/s/2nNoe2S0nWTPPIT86XJH8w  玩转processlist，高效追溯MySQL活跃连接数飙升根因
	https://www.jianshu.com/p/56d268983822    MySQL：简单记录一下Waiting for commit lock
	06 | 全局锁和表级锁
	19：分析只查询一行记录，为什么执行慢
	
	http://www.bubuko.com/infodetail-3089022.html   MySQL线程状态详解
	
	https://dev.mysql.com/doc/refman/5.7/en/query-cache-thread-states.html
	