
1. GTID的作用
2. GTID的基本表示
3. server_uuid
4. Previous_gtids_log_event 和 GTID_LOG_EVENT 简介
	4.1 Previous_gtids_log_event	
	4.2 GTID_LOG_EVENT 这个event主要记录的部分有3个即作用
5. mysql.gtid_executed 表
	5.1 GTID的两种持久化介质	
	5.2 验证主库修改 mysql.gtid_executed 的时机
	 

1. GTID的作用
	基本概念： 
		全称是 global transaction identifed 即全局事务ID， 是一个事务在提交的时候生成的， 是全局唯一标识。
	
		MySQL 会为每一个 DML/DDL 操作增加一个唯一标识叫做 GTID , 这个标记在整个复制环境都是唯一的。
		
		主从环境中的 dump 线程可以直接通过 GTID 定位到需要发送的 binary log 位置，而不再需要指定 binary log 的文件名和位置， 因此切换极为方便
		
		# 关于DUMP线程是如何通过GTID定位到binary log位置的，我们将在第17节进行讨论。

		
2. GTID的基本表示

	GTID：
		单个GTID，比如 '2996ce66-62b4-11ea-8c40-08002792110f:1-24'
		对应源码中的类结构Gtid。注意源码中用 sid 代表前面的 server_uuid ，gno 则用来表示后面的序号。

		mysql> select @@server_uuid;
		+--------------------------------------+
		| @@server_uuid                        |
		+--------------------------------------+
		| 2996ce66-62b4-11ea-8c40-08002792110f |
		+--------------------------------------+
		1 row in set (0.00 sec)

		mysql> show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000004
				 Position: 2183
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: 2996ce66-62b4-11ea-8c40-08002792110f:1-24
		1 row in set (0.00 sec)
		
	gno：
		单个 GTID 后面的序号，比如上面的 GTID 其 gno 就是24。
		这个 gno 实际上从全局计数器 next_free_gno 中获取的。
	
	GTID SET：
		一个GTID的集合，可以包含多个 server_uuid，比如我们常见的 execute_gtid 、gtid_purged 就是一个GTID SET。
		类似 '24985463-a536-11e8-a30c-5254008138e4:1-5:7-10' 就是一个GTID SET。
		对应源码中的类结构Gtid_set，其中还包含一个 sid_map 用于表示多个 server_uuid 。
	
	GTID SET Interval：
		GTID SET中某个server_uuid可能包含多个区间比如‘1-5:7-10’，比如这里就有2个GTID SET Interval分别是‘1-5’和‘7-10’。
		当然通常只有一个GTID SET Interval如‘1-10’。对应源码中的结构体 Gtid_set::Interval。

3. server_uuid
	
	在数据库第一次初始化后启动的时候生成，默认保存在数据目录中，文件名为 auto.cnf，可以修改。
		
	root@localhost [(none)]>select @@server_uuid;
	+--------------------------------------+
	| @@server_uuid                        |
	+--------------------------------------+
	| c27f419e-cecd-27e7-9649-0800279d4f09 |
	+--------------------------------------+
	1 row in set (0.00 sec)


	root@localhost [(none)]>show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000040
			 Position: 234
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: c27f419e-cecd-27e7-9649-0800279d4f09:1-1613,
	c39f419e-cecd-26e7-9649-0800279d4f09:1-922364
	1 row in set (0.00 sec)

	ERROR: 
	No query specified

	root@localhost [(none)]> show global variables  like '%gtid%';
	+----------------------------------+--------------------------------------------------------------------------------------------+
	| Variable_name                    | Value                                                                                      |
	+----------------------------------+--------------------------------------------------------------------------------------------+
	| binlog_gtid_simple_recovery      | ON                                                                                         |
	| enforce_gtid_consistency         | ON                                                                                         |
	| gtid_executed                    | c27f419e-cecd-27e7-9649-0800279d4f09:1-1613,
	c39f419e-cecd-26e7-9649-0800279d4f09:1-922364 |
	| gtid_executed_compression_period | 1000                                                                                       |
	| gtid_mode                        | ON                                                                                         |
	| gtid_owned                       |                                                                                            |
	| gtid_purged                      | c27f419e-cecd-27e7-9649-0800279d4f09:1-620,
	c39f419e-cecd-26e7-9649-0800279d4f09:1-922364  |
	| session_track_gtids              | OFF                                                                                        |
	+----------------------------------+--------------------------------------------------------------------------------------------+
	8 rows in set (0.01 sec)

	修改 server_uuid
		[root@env data]# ls -lht auto.cnf 
		-rw-r----- 1 mysql mysql 56 Feb  4  2018 auto.cnf
		[root@env data]# pwd
		/data/mysql/mysql3306/data
		[root@env data]# cat auto.cnf 
		[auto]
		server-uuid=c27f419e-cecd-27e7-9649-0800279d4f09
	
		[root@env data]# rm auto.cnf 
		rm: remove regular file ?.uto.cnf?. y
		
		[root@env data]# /etc/init.d/mysql restart
		Shutting down MySQL.... SUCCESS! 
		Starting MySQL.......... SUCCESS! 
		[root@env data]# cat auto.cnf 
		[auto]
		server-uuid=f7323d17-6442-11ea-8a77-080027758761

		root@localhost [(none)]>select @@server_uuid;
		+--------------------------------------+
		| @@server_uuid                        |
		+--------------------------------------+
		| f7323d17-6442-11ea-8a77-080027758761 |
		+--------------------------------------+
		1 row in set (0.00 sec)

		root@localhost [(none)]>show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000043
				 Position: 234
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: c27f419e-cecd-27e7-9649-0800279d4f09:1-1613,
		c39f419e-cecd-26e7-9649-0800279d4f09:1-922364
		1 row in set (0.00 sec)

		ERROR: 
		No query specified
		root@localhost [(none)]> show global variables  like '%gtid%';
		+----------------------------------+--------------------------------------------------------------------------------------------+
		| Variable_name                    | Value                                                                                      |
		+----------------------------------+--------------------------------------------------------------------------------------------+
		| binlog_gtid_simple_recovery      | ON                                                                                         |
		| enforce_gtid_consistency         | ON                                                                                         |
		| gtid_executed                    | c27f419e-cecd-27e7-9649-0800279d4f09:1-1613,
		c39f419e-cecd-26e7-9649-0800279d4f09:1-922364 |
		| gtid_executed_compression_period | 1000                                                                                       |
		| gtid_mode                        | ON                                                                                         |
		| gtid_owned                       |                                                                                            |
		| gtid_purged                      | c27f419e-cecd-27e7-9649-0800279d4f09:1-620,
		c39f419e-cecd-26e7-9649-0800279d4f09:1-922364  |
		| session_track_gtids              | OFF                                                                                        |
		+----------------------------------+--------------------------------------------------------------------------------------------+
		8 rows in set (0.00 sec)

		删除数据
			root@localhost [(none)]>delete  from zst.t where id=1;
			Query OK, 1 row affected (0.03 sec)

			root@localhost [(none)]>select @@server_uuid;\
			+--------------------------------------+
			| @@server_uuid                        |
			+--------------------------------------+
			| f7323d17-6442-11ea-8a77-080027758761 |
			+--------------------------------------+
			1 row in set (0.00 sec)

			root@localhost [(none)]>show master status\G;
			*************************** 1. row ***************************
						 File: mysql-bin.000043
					 Position: 492
				 Binlog_Do_DB: 
			 Binlog_Ignore_DB: 
			Executed_Gtid_Set: c27f419e-cecd-27e7-9649-0800279d4f09:1-1613,
			c39f419e-cecd-26e7-9649-0800279d4f09:1-922364,
			f7323d17-6442-11ea-8a77-080027758761:1
			1 row in set (0.00 sec)

			ERROR: 
			No query specified

			root@localhost [(none)]> show global variables  like '%gtid%';
			+----------------------------------+------------------------------------------------------------------------------------------------------------------------------------+
			| Variable_name                    | Value                                                                                                                              |
			+----------------------------------+------------------------------------------------------------------------------------------------------------------------------------+
			| binlog_gtid_simple_recovery      | ON                                                                                                                                 |
			| enforce_gtid_consistency         | ON                                                                                                                                 |
			| gtid_executed                    | c27f419e-cecd-27e7-9649-0800279d4f09:1-1613,
			c39f419e-cecd-26e7-9649-0800279d4f09:1-922364,
			f7323d17-6442-11ea-8a77-080027758761:1 |
			| gtid_executed_compression_period | 1000                                                                                                                               |
			| gtid_mode                        | ON                                                                                                                                 |
			| gtid_owned                       |                                                                                                                                    |
			| gtid_purged                      | c27f419e-cecd-27e7-9649-0800279d4f09:1-620,
			c39f419e-cecd-26e7-9649-0800279d4f09:1-922364                                          |
			| session_track_gtids              | OFF                                                                                                                                |
			+----------------------------------+------------------------------------------------------------------------------------------------------------------------------------+
			8 rows in set (0.00 sec)


4. Previous_gtids_log_event 和 GTID_LOG_EVENT 简介
	4.1 Previous_gtids_log_event
		包含在每一个 binary log 的开头，用于描述直到上一个 binary log 所包含的全部 GTID（包括已经删除的 binary log）
		在 5.7 中即便不开启 GTID 也会包含这个 Previous_gtids_log_event
		为快速扫描 binary log 获得正确 gtid_executed 变量提供了基础， 否则可能扫描大量的 binary log 才能得到（比如关闭 GTID 的情况）
		
		root@mysqldb 15:02:  [niuniuh5_db]> show binlog events in 'mysql-bin.000008';
		+------------------+------+----------------+-----------+-------------+----------------------------------------------------------------------+
		| Log_name         | Pos  | Event_type     | Server_id | End_log_pos | Info                                                                 |
		+------------------+------+----------------+-----------+-------------+----------------------------------------------------------------------+
		| mysql-bin.000008 |    4 | Format_desc    |    330640 |         123 | Server ver: 5.7.22-log, Binlog ver: 4                                |
		| mysql-bin.000008 |  123 | Previous_gtids |    330640 |         194 | 7af746a1-5c2d-11ea-bc75-00163e08b460:1-5600                          |
		| mysql-bin.000008 |  194 | Gtid           |    330640 |         259 | SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:5601' |
		| mysql-bin.000008 |  259 | Query          |    330640 |         346 | BEGIN                                                                |
		| mysql-bin.000008 |  346 | Table_map      |    330640 |         400 | table_id: 562 (niuniuh5_db.t)                                        |
		| mysql-bin.000008 |  400 | Write_rows     |    330640 |         448 | table_id: 562 flags: STMT_END_F                                      |
		| mysql-bin.000008 |  448 | Xid            |    330640 |         479 | COMMIT /* xid=36095 */                                               |
		
		上一个 binary log(mysql-bin.000007) 所包含的全部 GTID : 7af746a1-5c2d-11ea-bc75-00163e08b460:1-5600
		
		
	4.2 GTID_LOG_EVENT 这个event主要记录的部分有3个即作用
		1. 记录GTID的详细信息
		2. 记录逻辑时钟详细信息，即 last commit 和 seq number
		3. 是否为行模式，比如 DDL 语句就不是行模式	

		GTID_LOG_EVENT 在 mysqlbinlog 中的样式:

			#200307 15:01:33 server id 330640  end_log_pos 829 CRC32 0x0a8ab72f 	GTID	last_committed=2	sequence_number=3	rbr_only=yes  
			/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
			SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:5603'/*!*/;															  # gtid event
			
			# gtid_next=automatic，代表使用默认值。MySQL 就会把 server_uuid:gno 分配给这个事务：
				a. 记录 binlog 的时候，先记录一行 SET @@SESSION.GTID_NEXT=‘server_uuid:gno’;
				b. 把这个GTID加入本实例的GTID集合
				
				 
5. mysql.gtid_executed 表
	5.1 GTID的两种持久化介质：
		1. gtid_executed表
			gtid_executed 表是GTID持久化的一个介质
			实例重启后所有的内存信息都会丢失， GTID模块初始化就需要读取GTID持久化介质。
			
		2. binary log中的 GTID_LOG_EVENT
			5.6 中使用GTID做从库，从库必须开启 binary log 并且设置 log_slave_updates=true:
				因为从库执行过的GTID操作都需要保留在 binary log中， 当GTID模块初始化的时候会读取它获取正确的 GTID SET
				
			
			mysql.gtid_executed表示5.7.5才开始的一个优化，在没有这个表之前gtid持久化介质就只有binlog，但是针对于复制中的slave有时候并不需要设置级联主从，所以没有必要开启log_slave_update参数，没有开启的这个参数的话就会减少了磁盘和IO。减轻了负担，提高了性能。
	
			因此， 我们需要另外一种GTID持久化介质，而不是 binlog 中的 GTID_LOG_EVENT, gtid_executed 表正是这样一种GTID持久化的介质。
			
			
			
	5.2 验证主库修改 mysql.gtid_executed 的时机：
	 
	 
		root@mysqldb 19:37:  [(none)]> show binlog events in 'mysql-bin.000004';
		+------------------+------+----------------+-----------+-------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| Log_name         | Pos  | Event_type     | Server_id | End_log_pos | Info                                                                                                                                                                                                                                   |
		+------------------+------+----------------+-----------+-------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| mysql-bin.000004 |    4 | Format_desc    |    330601 |         123 | Server ver: 5.7.26-debug-log, Binlog ver: 4                                                                                                                                                                                            |
		| mysql-bin.000004 |  123 | Previous_gtids |    330601 |         194 | 2996ce66-62b4-11ea-8c40-08002792110f:1-16   
		
		.................................................. 此处省略.............................................................................
		
		| mysql-bin.000004 | 2545 | Gtid           |    330601 |        2610 | SET @@SESSION.GTID_NEXT= '2996ce66-62b4-11ea-8c40-08002792110f:26'                                                                                                                                                                     |
		| mysql-bin.000004 | 2610 | Query          |    330601 |        2693 | BEGIN                                                                                                                                                                                                                                  |
		| mysql-bin.000004 | 2693 | Table_map      |    330601 |        2743 | table_id: 113 (lujb_db.t)                                                                                                                                                                                                              |
		| mysql-bin.000004 | 2743 | Write_rows     |    330601 |        2791 | table_id: 113 flags: STMT_END_F                                                                                                                                                                                                        |
		| mysql-bin.000004 | 2791 | Xid            |    330601 |        2822 | COMMIT /* xid=111 */                                                                                                                                                                                                                   |
		+------------------+------+----------------+-----------+-------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		37 rows in set (0.07 sec)

		root@mysqldb 19:38:  [(none)]> select * from mysql.gtid_executed;
		+--------------------------------------+----------------+--------------+
		| source_uuid                          | interval_start | interval_end |
		+--------------------------------------+----------------+--------------+
		| 2996ce66-62b4-11ea-8c40-08002792110f |              1 |           16 |
		+--------------------------------------+----------------+--------------+
		1 row in set (0.00 sec)

		 
		binlog 切换
			root@mysqldb 19:38:  [(none)]> flush logs;
			Query OK, 0 rows affected (0.12 sec)

			root@mysqldb 19:38:  [(none)]> select * from mysql.gtid_executed;
			+--------------------------------------+----------------+--------------+
			| source_uuid                          | interval_start | interval_end |
			+--------------------------------------+----------------+--------------+
			| 2996ce66-62b4-11ea-8c40-08002792110f |              1 |           26 |
			+--------------------------------------+----------------+--------------+
			1 row in set (0.00 sec)

		
		
		说明了 在binlog打开的情况下， mysql.gtid_executed表修改时机
			在binlog发生切换(rotate)的时候保存直到上一个binlog文件执行过的全部Gtid，它不是实时更新的。

			作者：重庆八怪
			链接：https://www.jianshu.com/p/905d7e89a305

	
	
	
	
gtid_executed (执行过的所有GTID)
在当前实例上执行过的GTID集合; 实际上包含了所有记录到binlog中的事务。所以，设置set sql_log_bin=0后执行的事务不会生成binlog 事件，也不会被记录到gtid_executed中。

执行 RESET MASTER 可以将该变量置空。reset master命令除了完成上述功能还会清理binlog，重新初始化binlog从序号1开始。


https://www.jianshu.com/p/905d7e89a305  Mysql 5.7 Gtid内部学习(五) mysql.gtid_executed表/gtid_executed变量/gtid_purged变量的更改时机



root@mysqldb 17:09:  [(none)]> show global variables  like '%gtid%';
+----------------------------------+------------------------------------------------+
| Variable_name                    | Value                                          |
+----------------------------------+------------------------------------------------+
| binlog_gtid_simple_recovery      | ON                                             |
| enforce_gtid_consistency         | ON                                             |
| gtid_executed                    | 7af746a1-5c2d-11ea-bc75-00163e08b460:1-1487595 |
| gtid_executed_compression_period | 1000                                           |
| gtid_mode                        | ON                                             |
| gtid_owned                       |                                                |
| gtid_purged                      | 7af746a1-5c2d-11ea-bc75-00163e08b460:1         |
| session_track_gtids              | OFF                                            |
+----------------------------------+------------------------------------------------+
8 rows in set (0.00 sec)


root@mysqldb 17:09:  [(none)]> select * from mysql.gtid_executed;
+--------------------------------------+----------------+--------------+
| source_uuid                          | interval_start | interval_end |
+--------------------------------------+----------------+--------------+
| 7af746a1-5c2d-11ea-bc75-00163e08b460 |              1 |      1486985 |
| 7af746a1-5c2d-11ea-bc75-00163e08b460 |        1486986 |      1487459 |
+--------------------------------------+----------------+--------------+
2 rows in set (0.00 sec)


[root@voice ~]# cat /mydata/mysql/mysql3306/data/auto.cnf 
[auto]
server-uuid=7af746a1-5c2d-11ea-bc75-00163e08b460


