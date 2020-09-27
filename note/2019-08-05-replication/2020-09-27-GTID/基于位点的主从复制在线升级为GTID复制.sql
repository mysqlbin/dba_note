
参考： http://wubx.net/mysql-5-7-class-repl-online-2-gtid-repl/

1. 所有的Server执行
	set @@global.enforce_gtid_consistency = warn;

	确定操作都支持GTID; 
	特别注意： 这一步是关建的一步使用不能出现警告。

2. 所有的server上执行：
	set @@global.enforce_gtid_consistency = on;


3.所有的Server上执行（不关心最先最后，但要执行完）：

	set @@global.gtid_mode = off_permissive;
	
	主库生成的是匿名事务，从库可以应用匿名和GTID事务。
 
4. 所有的Server上执行
	set @@global.gtid_mode=	on_permissive;
	
	主库生成的是GTID事务，从库可以应用匿名和GTID事务。
		

5. 在所有的Server上确定已经没有匿名的事务
	show status like 'ongoing_anonymous_transaction_count';
		
	多观察一段时间, 确认基于位点的复制执行完毕, 即确认这个该ongoing_anonymous_transaction_count统计值为0，
	如果不为0，强行修改可能导致数据丢失，然后确认从库 Retrieved_Gtid_Set/Executed_Gtid_Set 正常增长。
	到这一步实际上GTID已经开始使用了。
	所有的节点也可以执行一下: flush logs; 用于切换一下日志。

 
6. 所有的节点启用gtid_mode
	set @@global.gtid_mode=on;


	如果执行 mysql> set @@global.gtid_mode=on; 报错:
	ERROR 1788 (HY000): The value of @@GLOBAL.GTID_MODE can only be changed one step at a time: OFF <-> OFF_PERMISSIVE <-> ON_PERMISSIVE <-> ON. Also note that this value must be stepped up or down simultaneously on all servers. See the Manual for instructions.

	解决办法:
		在这个步骤之前先执行: set @@global.gtid_mode=on_permissive;
		 然后确定已经没有匿名的事务: show status like 'ongoing_anonymous_transaction_count';	


7. 从库执行启用Gtid的自动查找复制：

	stop slave;
	change master to master_auto_position=1;
	start slave;
	show slave status\G;
	
	一旦到这一部分所有的老的 relay log 都清理掉了, 新的 relay log 包含的全是GTID 操作 event.
	
8. 把 gtid_mode = on 相关配置写入主从的配置文件

	gtid_mode=on
	enforce_gtid_consistency=on

	mysql> show global variables  like '%gtid_mode%';
	mysql> show global variables like '%enforce_gtid_consistency%';

