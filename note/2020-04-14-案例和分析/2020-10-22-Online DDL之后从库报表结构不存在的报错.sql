  
  
master
	
	mysql> flush logs;
	Query OK, 0 rows affected (0.02 sec)

	mysql> flush logs;
	Query OK, 0 rows affected (0.02 sec)

	mysql> alter table t_20201021 add column b int(11) default null;
	Query OK, 0 rows affected (3 min 43.11 sec)
	Records: 0  Duplicates: 0  Warnings: 0

	mysql> show binary logs;
	+------------------+-----------+
	| Log_name         | File_size |
	+------------------+-----------+
	| mysql-bin.000008 |      1179 |
	| mysql-bin.000009 |       839 |
	| mysql-bin.000010 |       241 |
	| mysql-bin.000011 |       446 |
	| mysql-bin.000012 |       194 |
	+------------------+-----------+
	5 rows in set (0.03 sec)


	ysql> show global variables like '%recovery%';
	+-----------------------------+-------+
	| Variable_name               | Value |
	+-----------------------------+-------+
	| binlog_gtid_simple_recovery | ON    |
	| innodb_force_recovery       | 0     |
	| relay_log_recovery          | ON    |
	+-----------------------------+-------+
	3 rows in set (0.01 sec)



	mysql> show tables;
	+-------------------+
	| Tables_in_test_db |
	+-------------------+
	| t_20201019        |
	| t_20201021        |
	+-------------------+
	2 rows in set (0.00 sec)

	mysql> select * from t_20201019 limit 1;
	+----+----+------+---------------------+
	| ID | t1 | t2   | t3                  |
	+----+----+------+---------------------+
	|  3 |  3 |    3 | 2020-10-02 23:45:20 |
	+----+----+------+---------------------+
	1 row in set (0.00 sec)








mysql> show slave status\G;

*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.0.201
                  Master_User: rpl
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000012
          Read_Master_Log_Pos: 194
               Relay_Log_File: localhost-relay-bin.000020
                Relay_Log_Pos: 367
        Relay_Master_Log_File: mysql-bin.000011
             Slave_IO_Running: Yes
            Slave_SQL_Running: No
	..........................................................................
                   Last_Errno: 1146
                   Last_Error: Error 'Table 'test_db.t_20201021' doesn t exist on query. Default database: 'test_db'. Query: 'alter table t_20201021 add column b int(11) default null'
    ..........................................................................  
               Last_SQL_Error: Error 'Table 'test_db.t_20201021' doesn't exist' on query. Default database: 'test_db'. Query: 'alter table t_20201021 add column b int(11) default null'
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 330607
                  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
             Master_Info_File: mysql.slave_master_info
                    SQL_Delay: 0
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: 
           Master_Retry_Count: 86400
                  Master_Bind: 
      Last_IO_Error_Timestamp: 
     Last_SQL_Error_Timestamp: 201022 11:08:34
               Master_SSL_Crl: 
           Master_SSL_Crlpath: 
           Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:79
            Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-78
                Auto_Position: 1
	..........................................................................
1 row in set (0.12 sec)


	mysql> use test_db;
	Reading table information for completion of table and column names
	You can turn off this feature to get a quicker startup with -A

	Database changed
	mysql> show tables;
	+-------------------+
	| Tables_in_test_db |
	+-------------------+
	| t_20201019        |
	| t_20201021        |
	+-------------------+
	2 rows in set (0.00 sec)


	
	mysql> mysql> select * from test_db.t_20201021 limit 1;
	ERROR 1146 (42S02): Table 'test_db.t_20201021' doesnt exist

	mysql> select * from t_20201021 limit 1;
	ERROR 1146 (42S02): Table 'test_db.t_20201021' doesnt exists


	mysql> select * from information_schema.tables where TABLE_SCHEMA='test_db' and table_name='t_20201021';
	Empty set (0.00 sec)



错误日志： 
	2020-10-22T03:08:32.252034Z 0 [Warning] Neither --relay-log nor --relay-log-index were used; so replication may break when this MySQL server acts as a slave and has his hostname changed!! Please use '--relay-log=localhost-relay-bin' to avoid this problem.
	2020-10-22T03:08:32.353483Z 0 [Warning] Recovery from master pos 4 and file mysql-bin.000011 for channel ''. Previous relay log pos and relay log file had been set to 241, ./localhost-relay-bin.000015 respectively.
	2020-10-22T03:08:32.620426Z 1 [Warning] Storing MySQL user name or password information in the master info repository is not secure and is therefore not recommended. Please consider using the USER and PASSWORD connection options for START SLAVE; see the 'START SLAVE Syntax' in the MySQL Manual for more information.
	2020-10-22T03:08:32.859657Z 2 [Note] Slave SQL thread for channel '' initialized, starting replication in log 'mysql-bin.000011' at position 4, relay log './localhost-relay-bin.000019' position: 4
	2020-10-22T03:08:33.562402Z 1 [Note] Slave I/O thread for channel '': connected to master 'rpl@192.168.0.201:3306',replication started in log 'mysql-bin.000011' at position 4
	2020-10-22T03:08:33.825293Z 0 [Note] Event Scheduler: Loaded 0 events
	2020-10-22T03:08:33.825632Z 0 [Note] /usr/local/mysql/bin/mysqld: ready for connections.
	Version: '5.7.22-log'  socket: '/home/mysql/3306/data/3306.sock'  port: 3306  MySQL Community Server (GPL)
	2020-10-22T03:08:33.861987Z 3 [Note] Event Scheduler: scheduler thread started with id 3
	2020-10-22T03:08:34.573145Z 2 [Warning] InnoDB: Table test_db/t_20201021 contains 9 user defined columns in InnoDB, but 8 columns in MySQL. Please check INFORMATION_SCHEMA.INNODB_SYS_COLUMNS and http://dev.mysql.com/doc/refman/5.7/en/innodb-troubleshooting.html for how to resolve the issue.
	2020-10-22T03:08:34.573172Z 2 [Warning] InnoDB: Cannot open table test_db/t_20201021 from the internal data dictionary of InnoDB though the .frm file for the table exists. Please refer to http://dev.mysql.com/doc/refman/5.7/en/innodb-troubleshooting.html for how to resolve the issue.
	2020-10-22T03:08:34.573221Z 2 [ERROR] Slave SQL for channel '': Error 'Table 'test_db.t_20201021' doesn't exist' on query. Default database: 'test_db'. Query: 'alter table t_20201021 add column b int(11) default null', Error_code: 1146
	2020-10-22T03:08:34.768203Z 2 [Warning] Slave: Table 'test_db.t_20201021' doesn't exist Error_code: 1146
	2020-10-22T03:08:34.768229Z 2 [ERROR] Error running query, slave SQL thread aborted. Fix the problem, and restart the slave SQL thread with "SLAVE START". We stopped at log 'mysql-bin.000011' position 194
	2020-10-22T03:42:50.517843Z 5 [Note] InnoDB: Table `test_db`.`t_20201021` is corrupted. Please drop the table and recreate it
	2020-10-22T03:42:50.517876Z 5 [Warning] InnoDB: Cannot open table test_db/t_20201021 from the internal data dictionary of InnoDB though the .frm file for the table exists. Please refer to http://dev.mysql.com/doc/refman/5.7/en/innodb-troubleshooting.html for how to resolve the issue.
	2020-10-22T03:55:16.812644Z 1 [Note] Slave I/O thread killed while reading event for channel ''
	2020-10-22T03:55:16.812664Z 1 [Note] Slave I/O thread exiting for channel '', read up to log 'mysql-bin.000012', position 194
	2020-10-22T03:55:19.536231Z 6 [Warning] Storing MySQL user name or password information in the master info repository is not secure and is therefore not recommended. Please consider using the USER and PASSWORD connection options for START SLAVE; see the 'START SLAVE Syntax' in the MySQL Manual for more information.
	2020-10-22T03:55:19.623862Z 7 [Note] Slave SQL thread for channel '' initialized, starting replication in log 'mysql-bin.000011' at position 194, relay log './localhost-relay-bin.000020' position: 367
	2020-10-22T03:55:19.675775Z 7 [Note] InnoDB: Table `test_db`.`t_20201021` is corrupted. Please drop the table and recreate it
	2020-10-22T03:55:19.675836Z 7 [Warning] InnoDB: Cannot open table test_db/t_20201021 from the internal data dictionary of InnoDB though the .frm file for the table exists. Please refer to http://dev.mysql.com/doc/refman/5.7/en/innodb-troubleshooting.html for how to resolve the issue.
	2020-10-22T03:55:19.675929Z 7 [ERROR] Slave SQL for channel '': Error 'Table 'test_db.t_20201021' doesn't exist' on query. Default database: 'test_db'. Query: 'alter table t_20201021 add column b int(11) default null', Error_code: 1146
	2020-10-22T03:55:19.790672Z 7 [Warning] Slave: Table 'test_db.t_20201021' doesn't exist Error_code: 1146
	2020-10-22T03:55:19.790695Z 7 [ERROR] Error running query, slave SQL thread aborted. Fix the problem, and restart the slave SQL thread with "SLAVE START". We stopped at log 'mysql-bin.000011' position 194
	2020-10-22T03:55:19.961548Z 6 [Note] Slave I/O thread for channel '': connected to master 'rpl@192.168.0.201:3306',replication started in log 'mysql-bin.000012' at position 194
	2020-10-22T03:57:19.811652Z 5 [Note] InnoDB: Table `test_db`.`t_20201021` is corrupted. Please drop the table and recreate it
	2020-10-22T03:57:19.811678Z 5 [Warning] InnoDB: Cannot open table test_db/t_20201021 from the internal data dictionary of InnoDB though the .frm file for the table exists. Please refer to http://dev.mysql.com/doc/refman/5.7/en/innodb-troubleshooting.html for how to resolve the issue.
	2020-10-22T03:57:21.554034Z 5 [Note] InnoDB: Table `test_db`.`t_20201021` is corrupted. Please drop the table and recreate it
	2020-10-22T03:57:21.554062Z 5 [Warning] InnoDB: Cannot open table test_db/t_20201021 from the internal data dictionary of InnoDB though the .frm file for the table exists. Please refer to http://dev.mysql.com/doc/refman/5.7/en/innodb-troubleshooting.html for how to resolve the issue.
	2020-10-22T03:58:44.458734Z 5 [Note] InnoDB: Table `test_db`.`t_20201021` is corrupted. Please drop the table and recreate it
	2020-10-22T03:58:44.458761Z 5 [Warning] InnoDB: Cannot open table test_db/t_20201021 from the internal data dictionary of InnoDB though the .frm file for the table exists. Please refer to http://dev.mysql.com/doc/refman/5.7/en/innodb-troubleshooting.html for how to resolve the issue.
	2020-10-22T03:59:45.475944Z 8 [Note] InnoDB: Table `test_db`.`t_20201021` is corrupted. Please drop the table and recreate it
	2020-10-22T03:59:45.476046Z 8 [Warning] InnoDB: Cannot open table test_db/t_20201021 from the internal data dictionary of InnoDB though the .frm file for the table exists. Please refer to http://dev.mysql.com/doc/refman/5.7/en/innodb-troubleshooting.html for how to resolve the issue.
	2020-10-22T03:59:49.297959Z 8 [Note] InnoDB: Table `test_db`.`t_20201021` is corrupted. Please drop the table and recreate it
	2020-10-22T03:59:49.297985Z 8 [Warning] InnoDB: Cannot open table test_db/t_20201021 from the internal data dictionary of InnoDB though the .frm file for the table exists. Please refer to http://dev.mysql.com/doc/refman/5.7/en/innodb-troubleshooting.html for how to resolve the issue.



	[root@localhost test_db]# ll
	总用量 1724572
	-rw-r-----. 1 mysql mysql        67 9月  28 14:25 db.opt
	-rw-r-----. 1 mysql mysql      8828 10月 22 10:56 #sql-233c_b.frm
	-rw-r-----. 1 mysql mysql 876609536 10月 22 11:08 #sql-ib69-600475077.ibd
	-rw-r-----. 1 mysql mysql      8696 10月  2 23:44 t_20201019.frm
	-rw-r-----. 1 mysql mysql    114688 10月  3 09:36 t_20201019.ibd
	-rw-r-----. 1 mysql mysql      8804 10月  4 13:44 t_20201021.frm
	-rw-r-----. 1 mysql mysql 889192448 10月 22 11:05 t_20201021.ibd



尝试表空间传输恢复：
	mysql> create table t_20201021_new like t_20201021;
	ERROR 1146 (42S02): Table 'test_db.t_20201021' doesn t exist


测试删除DDL生成的临时文件：

	[root@localhost test_db]# rm \#sql-233c_b.frm 
	rm：是否删除普通文件 "#sql-233c_b.frm"？y
	[root@localhost test_db]# rm \#sql-ib69-600475077.ibd 
	rm：是否删除普通文件 "#sql-ib69-600475077.ibd"？y


	mysql> start slave;

	mysql> show slave status\G;

	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.0.201
					  Master_User: rpl
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000012
			  Read_Master_Log_Pos: 194
				   Relay_Log_File: localhost-relay-bin.000020
					Relay_Log_Pos: 367
			Relay_Master_Log_File: mysql-bin.000011
				 Slave_IO_Running: Yes
				Slave_SQL_Running: No
		..........................................................................
					   Last_Errno: 1146
					   Last_Error: Error 'Table 'test_db.t_20201021' doesn t exist on query. Default database: 'test_db'. Query: 'alter table t_20201021 add column b int(11) default null'
		..........................................................................  
				   Last_SQL_Error: Error 'Table 'test_db.t_20201021' doesn't exist' on query. Default database: 'test_db'. Query: 'alter table t_20201021 add column b int(11) default null'
	  Replicate_Ignore_Server_Ids: 
				 Master_Server_Id: 330607
					  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: 
			   Master_Retry_Count: 86400
					  Master_Bind: 
		  Last_IO_Error_Timestamp: 
		 Last_SQL_Error_Timestamp: 201022 11:08:34
				   Master_SSL_Crl: 
			   Master_SSL_Crlpath: 
			   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:79
				Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-78
					Auto_Position: 1
		..........................................................................
	1 row in set (0.12 sec)



尝试在从库生成跟原表一样的frm表结构文件
	
	[root@localhost test_db]# ll
	总用量 868496
	-rw-r-----. 1 mysql mysql        67 9月  28 14:25 db.opt
	-rw-r-----. 1 mysql mysql      8696 10月  2 23:44 t_20201019.frm
	-rw-r-----. 1 mysql mysql    114688 10月  3 09:36 t_20201019.ibd
	-rw-r-----. 1 mysql mysql      8804 10月  4 13:44 t_20201021.frm.bak
	-rw-r-----. 1 mysql mysql 889192448 10月 22 11:05 t_20201021.ibd


	CREATE TABLE `t_20201021_re` (
	  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
	  `name` varchar(32) NOT NULL DEFAULT '',
	  `age` int(11) NOT NULL DEFAULT '0',
	  `ismale` tinyint(1) NOT NULL DEFAULT '0',
	  `id_card` varchar(32) NOT NULL DEFAULT '',
	  `test1` text,
	  `test2` text,
	  `createTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
	  `b` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `idx_age` (`age`),
	  KEY `idx_name` (`name`),
	  KEY `idx_card` (`id_card`),
	  KEY `idx_createTime` (`createTime`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;



	mysql> show create table t_20201021_re;
	+---------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| Table         | Create Table                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
	+---------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| t_20201021_re | CREATE TABLE `t_20201021_re` (
	  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
	  `name` varchar(32) NOT NULL DEFAULT '',
	  `age` int(11) NOT NULL DEFAULT '0',
	  `ismale` tinyint(1) NOT NULL DEFAULT '0',
	  `id_card` varchar(32) NOT NULL DEFAULT '',
	  `test1` text,
	  `test2` text,
	  `createTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
	  `b` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `idx_age` (`age`),
	  KEY `idx_name` (`name`),
	  KEY `idx_card` (`id_card`),
	  KEY `idx_createTime` (`createTime`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4     |
	+---------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	1 row in set (0.00 sec)



	rename  TABLE t_20201021_re TO t_20201021;

	mysql> rename  TABLE t_20201021_re TO t_20201021;
	ERROR 1050 (42S01): Table './test_db/t_20201021' already exists
	mysql> select * from information_schema.tables where TABLE_SCHEMA='test_db' and table_name='t_20201021';
	Empty set (0.00 sec)



从主库把frm表结构拷贝到从库并修改用户组和用户
	
	[root@localhost test_db]# chown -R mysql:mysql t_20201021.frm
	[root@localhost test_db]# ll
	总用量 868680
	-rw-r-----. 1 mysql mysql        67 9月  28 14:25 db.opt
	-rw-r-----. 1 mysql mysql      8696 10月  2 23:44 t_20201019.frm
	-rw-r-----. 1 mysql mysql    114688 10月  3 09:36 t_20201019.ibd
	-rw-r--r--. 1 mysql mysql      8828 10月 22 10:53 t_20201021.frm
	-rw-r-----. 1 mysql mysql      8804 10月  4 13:44 t_20201021.frm.bak
	-rw-r-----. 1 mysql mysql 889192448 10月 22 11:05 t_20201021.ibd
	-rw-r-----. 1 mysql mysql      8828 10月 22 14:56 t_20201021_re.frm
	-rw-r-----. 1 mysql mysql    163840 10月 22 14:56 t_20201021_re.ibd
	
	
	[root@localhost test_db]# /etc/init.d/mysql restart
	Shutting down MySQL......... SUCCESS! 
	Starting MySQL......... SUCCESS! 
		
	对应的错误日志
	
		2020-10-22T07:21:32.209717Z 0 [Note] Giving 3 client threads a chance to die gracefully
		2020-10-22T07:21:32.209741Z 0 [Note] Shutting down slave threads
		2020-10-22T07:21:32.251639Z 1 [Note] Slave I/O thread killed while reading event for channel ''
		2020-10-22T07:21:32.251675Z 1 [Note] Slave I/O thread exiting for channel '', read up to log 'mysql-bin.000012', position 194
		2020-10-22T07:21:34.306580Z 0 [Note] Forcefully disconnecting 2 remaining clients
		2020-10-22T07:21:34.306614Z 0 [Warning] /usr/local/mysql/bin/mysqld: Forcing close of thread 7  user: 'root'

		2020-10-22T07:21:34.318307Z 0 [Note] Event Scheduler: Killing the scheduler thread, thread id 3
		2020-10-22T07:21:34.318348Z 0 [Note] Event Scheduler: Waiting for the scheduler thread to reply
		2020-10-22T07:21:34.318829Z 0 [Note] Event Scheduler: Stopped
		2020-10-22T07:21:34.318844Z 0 [Note] Event Scheduler: Purging the queue. 0 events
		2020-10-22T07:21:34.321395Z 0 [Note] Binlog end
		2020-10-22T07:21:34.324086Z 0 [Note] Shutting down plugin 'ngram'
		2020-10-22T07:21:34.324209Z 0 [Note] Shutting down plugin 'ARCHIVE'
		2020-10-22T07:21:34.324217Z 0 [Note] Shutting down plugin 'partition'
		2020-10-22T07:21:34.324221Z 0 [Note] Shutting down plugin 'BLACKHOLE'
		2020-10-22T07:21:34.324225Z 0 [Note] Shutting down plugin 'PERFORMANCE_SCHEMA'
		2020-10-22T07:21:34.324247Z 0 [Note] Shutting down plugin 'CSV'
		2020-10-22T07:21:34.324252Z 0 [Note] Shutting down plugin 'MEMORY'
		2020-10-22T07:21:34.324256Z 0 [Note] Shutting down plugin 'MRG_MYISAM'
		2020-10-22T07:21:34.324261Z 0 [Note] Shutting down plugin 'MyISAM'
		2020-10-22T07:21:34.324268Z 0 [Note] Shutting down plugin 'INNODB_SYS_VIRTUAL'
		2020-10-22T07:21:34.324273Z 0 [Note] Shutting down plugin 'INNODB_SYS_DATAFILES'
		2020-10-22T07:21:34.324276Z 0 [Note] Shutting down plugin 'INNODB_SYS_TABLESPACES'
		2020-10-22T07:21:34.324279Z 0 [Note] Shutting down plugin 'INNODB_SYS_FOREIGN_COLS'
		2020-10-22T07:21:34.324282Z 0 [Note] Shutting down plugin 'INNODB_SYS_FOREIGN'
		2020-10-22T07:21:34.324285Z 0 [Note] Shutting down plugin 'INNODB_SYS_FIELDS'
		2020-10-22T07:21:34.324288Z 0 [Note] Shutting down plugin 'INNODB_SYS_COLUMNS'
		2020-10-22T07:21:34.324291Z 0 [Note] Shutting down plugin 'INNODB_SYS_INDEXES'
		2020-10-22T07:21:34.324302Z 0 [Note] Shutting down plugin 'INNODB_SYS_TABLESTATS'
		2020-10-22T07:21:34.324305Z 0 [Note] Shutting down plugin 'INNODB_SYS_TABLES'
		2020-10-22T07:21:34.324308Z 0 [Note] Shutting down plugin 'INNODB_FT_INDEX_TABLE'
		2020-10-22T07:21:34.324311Z 0 [Note] Shutting down plugin 'INNODB_FT_INDEX_CACHE'
		2020-10-22T07:21:34.324315Z 0 [Note] Shutting down plugin 'INNODB_FT_CONFIG'
		2020-10-22T07:21:34.324318Z 0 [Note] Shutting down plugin 'INNODB_FT_BEING_DELETED'
		2020-10-22T07:21:34.324321Z 0 [Note] Shutting down plugin 'INNODB_FT_DELETED'
		2020-10-22T07:21:34.324324Z 0 [Note] Shutting down plugin 'INNODB_FT_DEFAULT_STOPWORD'
		2020-10-22T07:21:34.324327Z 0 [Note] Shutting down plugin 'INNODB_METRICS'
		2020-10-22T07:21:34.324330Z 0 [Note] Shutting down plugin 'INNODB_TEMP_TABLE_INFO'
		2020-10-22T07:21:34.324333Z 0 [Note] Shutting down plugin 'INNODB_BUFFER_POOL_STATS'
		2020-10-22T07:21:34.324336Z 0 [Note] Shutting down plugin 'INNODB_BUFFER_PAGE_LRU'
		2020-10-22T07:21:34.324339Z 0 [Note] Shutting down plugin 'INNODB_BUFFER_PAGE'
		2020-10-22T07:21:34.324342Z 0 [Note] Shutting down plugin 'INNODB_CMP_PER_INDEX_RESET'
		2020-10-22T07:21:34.324345Z 0 [Note] Shutting down plugin 'INNODB_CMP_PER_INDEX'
		2020-10-22T07:21:34.324349Z 0 [Note] Shutting down plugin 'INNODB_CMPMEM_RESET'
		2020-10-22T07:21:34.324352Z 0 [Note] Shutting down plugin 'INNODB_CMPMEM'
		2020-10-22T07:21:34.324355Z 0 [Note] Shutting down plugin 'INNODB_CMP_RESET'
		2020-10-22T07:21:34.324358Z 0 [Note] Shutting down plugin 'INNODB_CMP'
		2020-10-22T07:21:34.324361Z 0 [Note] Shutting down plugin 'INNODB_LOCK_WAITS'
		2020-10-22T07:21:34.324364Z 0 [Note] Shutting down plugin 'INNODB_LOCKS'
		2020-10-22T07:21:34.324367Z 0 [Note] Shutting down plugin 'INNODB_TRX'
		2020-10-22T07:21:34.324370Z 0 [Note] Shutting down plugin 'InnoDB'
		2020-10-22T07:21:34.324402Z 0 [Note] InnoDB: FTS optimize thread exiting.
		2020-10-22T07:21:34.324674Z 0 [Note] InnoDB: Starting shutdown...
		2020-10-22T07:21:34.425558Z 0 [Note] InnoDB: Dumping buffer pool(s) to /home/mysql/3306/data/ib_buffer_pool
		2020-10-22T07:21:34.426293Z 0 [Note] InnoDB: Buffer pool(s) dump completed at 201022 15:21:34
		2020-10-22T07:21:40.891652Z 0 [Note] InnoDB: Shutdown completed; log sequence number 1310509256
		2020-10-22T07:21:40.891730Z 0 [Note] InnoDB: Removed temporary tablespace data file: "ibtmp1"
		2020-10-22T07:21:40.891741Z 0 [Note] Shutting down plugin 'sha256_password'
		2020-10-22T07:21:40.921066Z 0 [Note] Shutting down plugin 'mysql_native_password'
		2020-10-22T07:21:40.939465Z 0 [Note] Shutting down plugin 'binlog'
		2020-10-22T07:21:41.004515Z 0 [Note] /usr/local/mysql/bin/mysqld: Shutdown complete

		2020-10-22T07:21:42.691013Z 0 [Warning] 'NO_ZERO_DATE', 'NO_ZERO_IN_DATE' and 'ERROR_FOR_DIVISION_BY_ZERO' sql modes should be used with strict mode. They will be merged with strict mode in a future release.
		2020-10-22T07:21:42.691064Z 0 [Warning] 'NO_AUTO_CREATE_USER' sql mode was not set.
		2020-10-22T07:21:42.691089Z 0 [Note] --secure-file-priv is set to NULL. Operations related to importing and exporting data are disabled
		2020-10-22T07:21:42.691117Z 0 [Note] /usr/local/mysql/bin/mysqld (mysqld 5.7.22-log) starting as process 16449 ...
		2020-10-22T07:21:42.730325Z 0 [Note] InnoDB: PUNCH HOLE support available
		2020-10-22T07:21:42.730414Z 0 [Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins
		2020-10-22T07:21:42.730443Z 0 [Note] InnoDB: Uses event mutexes
		2020-10-22T07:21:42.730463Z 0 [Note] InnoDB: GCC builtin __sync_synchronize() is used for memory barrier
		2020-10-22T07:21:42.730483Z 0 [Note] InnoDB: Compressed tables use zlib 1.2.3
		2020-10-22T07:21:42.730502Z 0 [Note] InnoDB: Using Linux native AIO
		2020-10-22T07:21:42.731969Z 0 [Note] InnoDB: Number of pools: 1
		2020-10-22T07:21:42.732349Z 0 [Note] InnoDB: Using CPU crc32 instructions
		2020-10-22T07:21:42.736357Z 0 [Note] InnoDB: Initializing buffer pool, total size = 10G, instances = 2, chunk size = 128M
		2020-10-22T07:21:45.577121Z 0 [Note] InnoDB: Completed initialization of buffer pool
		2020-10-22T07:21:50.743117Z 0 [Note] InnoDB: If the mysqld execution user is authorized, page cleaner thread priority can be changed. See the man page of setpriority().
		2020-10-22T07:21:51.280004Z 0 [Note] InnoDB: Highest supported file format is Barracuda.
		2020-10-22T07:21:52.815272Z 0 [ERROR] InnoDB: Operating system error number 2 in a file operation.
		2020-10-22T07:21:52.815309Z 0 [ERROR] InnoDB: The error means the system cannot find the path specified.
		2020-10-22T07:21:52.815317Z 0 [ERROR] InnoDB: If you are installing InnoDB, remember that you must create directories yourself, InnoDB does not create them.
		2020-10-22T07:21:52.815324Z 0 [ERROR] InnoDB: Cannot open datafile for read-only: './test_db/#sql-ib69-600475077.ibd' OS error: 71
		2020-10-22T07:21:52.815331Z 0 [ERROR] InnoDB: Operating system error number 2 in a file operation.
		2020-10-22T07:21:52.815336Z 0 [ERROR] InnoDB: The error means the system cannot find the path specified.
		2020-10-22T07:21:52.815341Z 0 [ERROR] InnoDB: If you are installing InnoDB, remember that you must create directories yourself, InnoDB does not create them.
		2020-10-22T07:21:52.815353Z 0 [ERROR] InnoDB: Could not find a valid tablespace file for `test_db/#sql-ib69-600475077`. Please refer to http://dev.mysql.com/doc/refman/5.7/en/innodb-troubleshooting-datadict.html for how to resolve the issue.
		2020-10-22T07:21:52.815365Z 0 [Warning] InnoDB: Ignoring tablespace `test_db/#sql-ib69-600475077` because it could not be opened.
		2020-10-22T07:21:52.860917Z 0 [Note] InnoDB: Creating shared tablespace for temporary tables
		2020-10-22T07:21:52.861085Z 0 [Note] InnoDB: Setting file './ibtmp1' size to 64 MB. Physically writing the file full; Please wait ...
		2020-10-22T07:21:53.041911Z 0 [Note] InnoDB: File './ibtmp1' size is now 64 MB.
		2020-10-22T07:21:53.044252Z 0 [Note] InnoDB: 96 redo rollback segment(s) found. 96 redo rollback segment(s) are active.
		2020-10-22T07:21:53.044280Z 0 [Note] InnoDB: 32 non-redo rollback segment(s) are active.
		2020-10-22T07:21:53.044472Z 0 [Note] InnoDB: Waiting for purge to start
		2020-10-22T07:21:53.094618Z 0 [Note] InnoDB: Waiting for purge to start
		2020-10-22T07:21:53.144717Z 0 [Note] InnoDB: Waiting for purge to start
		2020-10-22T07:21:53.195674Z 0 [Note] InnoDB: Waiting for purge to start
		2020-10-22T07:21:53.262964Z 0 [Note] InnoDB: 5.7.22 started; log sequence number 1310509256
		2020-10-22T07:21:53.265653Z 0 [Note] InnoDB: Loading buffer pool(s) from /home/mysql/3306/data/ib_buffer_pool
		2020-10-22T07:21:53.362227Z 0 [Note] Plugin 'FEDERATED' is disabled.
		2020-10-22T07:21:53.587429Z 0 [Note] InnoDB: Buffer pool(s) load completed at 201022 15:21:53
		2020-10-22T07:21:53.628605Z 0 [Warning] Failed to set up SSL because of the following SSL library error: SSL context is not usable without certificate and private key
		2020-10-22T07:21:53.628649Z 0 [Note] Server hostname (bind-address): '*'; port: 3306
		2020-10-22T07:21:53.628743Z 0 [Note] IPv6 is available.
		2020-10-22T07:21:53.628782Z 0 [Note]   - '::' resolves to '::';
		2020-10-22T07:21:53.628820Z 0 [Note] Server socket created on IP: '::'.
		2020-10-22T07:21:53.670682Z 0 [Warning] 'user' entry 'root@localhost' ignored in --skip-name-resolve mode.
		2020-10-22T07:21:53.670737Z 0 [Warning] 'user' entry 'mysql.session@localhost' ignored in --skip-name-resolve mode.
		2020-10-22T07:21:53.670750Z 0 [Warning] 'user' entry 'mysql.sys@localhost' ignored in --skip-name-resolve mode.
		2020-10-22T07:21:53.671411Z 0 [Warning] 'db' entry 'performance_schema mysql.session@localhost' ignored in --skip-name-resolve mode.
		2020-10-22T07:21:53.671437Z 0 [Warning] 'db' entry 'sys mysql.sys@localhost' ignored in --skip-name-resolve mode.
		2020-10-22T07:21:53.671926Z 0 [Warning] 'proxies_priv' entry '@ root@localhost' ignored in --skip-name-resolve mode.
		2020-10-22T07:21:53.707263Z 0 [Warning] 'tables_priv' entry 'user mysql.session@localhost' ignored in --skip-name-resolve mode.
		2020-10-22T07:21:53.707319Z 0 [Warning] 'tables_priv' entry 'sys_config mysql.sys@localhost' ignored in --skip-name-resolve mode.
		2020-10-22T07:21:53.715712Z 0 [Warning] Neither --relay-log nor --relay-log-index were used; so replication may break when this MySQL server acts as a slave and has his hostname changed!! Please use '--relay-log=localhost-relay-bin' to avoid this problem.
		2020-10-22T07:21:53.743107Z 0 [Warning] Recovery from master pos 194 and file mysql-bin.000011 for channel ''. Previous relay log pos and relay log file had been set to 367, ./localhost-relay-bin.000025 respectively.
		2020-10-22T07:21:53.831868Z 0 [Note] Event Scheduler: Loaded 0 events
		2020-10-22T07:21:53.852806Z 1 [Note] Event Scheduler: scheduler thread started with id 1
		2020-10-22T07:21:53.862031Z 0 [Note] /usr/local/mysql/bin/mysqld: ready for connections.
		Version: '5.7.22-log'  socket: '/home/mysql/3306/data/3306.sock'  port: 3306  MySQL Community Server (GPL)
		2020-10-22T07:21:53.862733Z 3 [Warning] Storing MySQL user name or password information in the master info repository is not secure and is therefore not recommended. Please consider using the USER and PASSWORD connection options for START SLAVE; see the 'START SLAVE Syntax' in the MySQL Manual for more information.
		2020-10-22T07:21:53.871485Z 3 [Note] Slave I/O thread for channel '': connected to master 'rpl@192.168.0.201:3306',replication started in log 'mysql-bin.000011' at position 194
		2020-10-22T07:21:53.881221Z 2 [Note] Slave SQL thread for channel '' initialized, starting replication in log 'mysql-bin.000011' at position 194, relay log './localhost-relay-bin.000028' position: 4
		2020-10-22T07:21:55.230836Z 2 [ERROR] Slave SQL for channel '': Error 'Duplicate column name 'b'' on query. Default database: 'test_db'. Query: 'alter table t_20201021 add column b int(11) default null', Error_code: 1060
		2020-10-22T07:21:55.280233Z 2 [Warning] Slave: Duplicate column name 'b' Error_code: 1060
		2020-10-22T07:21:55.280293Z 2 [ERROR] Error running query, slave SQL thread aborted. Fix the problem, and restart the slave SQL thread with "SLAVE START". We stopped at log 'mysql-bin.000011' position 194


	查看表结构的注册
		mysql> select * from information_schema.tables where TABLE_SCHEMA='test_db' and table_name='t_20201021';
		+---------------+--------------+------------+------------+--------+---------+------------+------------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+-------------+------------+--------------------+----------+----------------+---------------+
		| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | TABLE_TYPE | ENGINE | VERSION | ROW_FORMAT | TABLE_ROWS | AVG_ROW_LENGTH | DATA_LENGTH | MAX_DATA_LENGTH | INDEX_LENGTH | DATA_FREE | AUTO_INCREMENT | CREATE_TIME         | UPDATE_TIME | CHECK_TIME | TABLE_COLLATION    | CHECKSUM | CREATE_OPTIONS | TABLE_COMMENT |
		+---------------+--------------+------------+------------+--------+---------+------------+------------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+-------------+------------+--------------------+----------+----------------+---------------+
		| def           | test_db      | t_20201021 | BASE TABLE | InnoDB |      10 | Dynamic    |    1606609 |            436 |   701480960 |               0 |    172359680 |   3145728 |        1643936 | 2020-10-22 15:20:43 | NULL        | NULL       | utf8mb4_general_ci |     NULL |                |               |
		+---------------+--------------+------------+------------+--------+---------+------------+------------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+-------------+------------+--------------------+----------+----------------+---------------+
		1 row in set (0.00 sec)


	查看数据
		mysql> use test_db;
		Reading table information for completion of table and column names
		You can turn off this feature to get a quicker startup with -A

		Database changed
		

		mysql> select * from t_20201021 limit 1\G;
		*************************** 1. row ***************************
				id: 1
			  name: 13f94a8edb
			   age: 1
			ismale: 2
		   id_card: e3dedf84fb490f2334b219b043603b
			 test1: a0f157eb2e39ee3a546085771e829d065758eec63c9fc5fe1efe863d4fc5ca03这里是做普通索引和唯一索引的插入性能对比测试
			 test2: dc0fec1ecea82878b20e68ab98aa082b4c1b03d9d19f1cb67b5a85f176675b75这里是做普通索引和唯一索引的插入性能对比测试
		createTime: 2020-10-04 13:46:19.201
				 b: NULL
		1 row in set (0.00 sec)


		master:

			mysql> select count(*) from t_20201021;

			+----------+
			| count(*) |
			+----------+
			|  1643935 |
			+----------+
			1 row in set (1.18 sec)


		slave：

			mysql> select count(*) from t_20201021;

			+----------+
			| count(*) |
			+----------+
			|  1643935 |
			+----------+
			1 row in set (1.18 sec)


	查看复制情况


		mysql> show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: Waiting for master to send event
	..........................................................................

					 Slave_IO_Running: Yes
					Slave_SQL_Running: No
	..........................................................................
						   Last_Errno: 1060
						   Last_Error: Error 'Duplicate column name 'b'' on query. Default database: 'test_db'. Query: 'alter table t_20201021 add column b int(11) default null'
						 Skip_Counter: 0
				  Exec_Master_Log_Pos: 194
					  Relay_Log_Space: 1545
	..........................................................................
				Seconds_Behind_Master: NULL
		Master_SSL_Verify_Server_Cert: No
						Last_IO_Errno: 0
						Last_IO_Error: 
					   Last_SQL_Errno: 1060
					   Last_SQL_Error: Error 'Duplicate column name 'b'' on query. Default database: 'test_db'. Query: 'alter table t_20201021 add column b int(11) default null'
	..........................................................................
			 Last_SQL_Error_Timestamp: 201022 15:21:55
					   Master_SSL_Crl: 
				   Master_SSL_Crlpath: 
				   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:79
					Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-78,
		9f50ba55-0141-11eb-98ab-0800270c8f40:1
						Auto_Position: 1
	..........................................................................

		1 row in set (0.00 sec)

		set gtid_next='9e520b78-013c-11eb-a84c-0800271bf591:79';
		begin;
		commit;
		set gtid_next=automatic;

		mysql> start slave;
		Query OK, 0 rows affected (0.05 sec)

		mysql> show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: Waiting for master to send event
						  Master_Host: 192.168.0.201
						  Master_User: rpl
						  Master_Port: 3306
						Connect_Retry: 60
					  Master_Log_File: mysql-bin.000012
				  Read_Master_Log_Pos: 194
					   Relay_Log_File: localhost-relay-bin.000031
						Relay_Log_Pos: 407
				Relay_Master_Log_File: mysql-bin.000012
					 Slave_IO_Running: Yes
					Slave_SQL_Running: Yes
	..........................................................................
				  Exec_Master_Log_Pos: 194
					  Relay_Log_Space: 705
	..........................................................................

				Seconds_Behind_Master: 0
	..........................................................................

					 Master_Server_Id: 330607
						  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
					 Master_Info_File: mysql.slave_master_info
							SQL_Delay: 0
				  SQL_Remaining_Delay: NULL
			  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
	..........................................................................
				   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:79
					Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-79,
		9f50ba55-0141-11eb-98ab-0800270c8f40:1
						Auto_Position: 1
	..........................................................................
		1 row in set (0.00 sec)






相关参考：

	http://dev.mysql.com/doc/refman/5.7/en/innodb-troubleshooting.html
	https://dev.mysql.com/doc/refman/5.7/en/innodb-troubleshooting-datadict.htmlIf 
	
		this occurs, try the following procedure to resolve the problem:
			如果发生这种情况，请尝试以下步骤解决问题：
		Create a matching .frm file in some other database directory and copy it to the database directory where the orphan table is located.
			在其他一些数据库目录中创建一个匹配的.frm文件，并将其复制到孤立表所在的数据库目录中。
			-- 的例子就是这么干的。
		Issue DROP TABLE for the original table. That should successfully drop the table and InnoDB should print a warning to the error log that the .ibd file was missing.
			发出原始表的DROP TABLE。 那应该成功删除该表，并且InnoDB应该在错误日志中显示一个警告，指出.ibd文件丢失。


----------------------------------------------------------------------------------------------------








