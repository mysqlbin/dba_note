
大纲 
	0. 环境
	1. 初始化表结构和数据
	2. slave1的相关参数
	3. slave2的相关参数
	4. pt-osc 
		4.1 主库执行耗时
		4.2 slave1的延迟 
		4.3 slave2的延迟
		4.4 master的CPU负载和IO负载
	5. gh-ost 
		5.1 主库执行耗时
		5.2 slave1的延迟 
		5.3 slave2的延迟 
		5.4 查看CPU负载和IO负载	
			5.4.1 master的CPU负载和IO负载	
			5.4.2 slave1的CPU负载和IO负载
			5.4.3 slave2的CPU负载和IO负载
			
	6. 遇到的一些问题
	7. 一些收获和小结
	8. 部分general_log日志
		8.1 pt-osc
		8.2 gh-ost	
		

0. 环境

	mysql> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.26-log |
	+------------+
	1 row in set (0.00 sec)

	复制架构：1主2从
	
	3台主机的硬件配置
		CPU		物理内存	数据库内存缓冲池大小	数据盘大小	剩余空间大小
		4核		16GB内存	8GB						100GB		78GB
		是否是SSD盘		文件系统	MySQL 版本		部署MySQL所在的设备
		是				ext4		5.7.21			/dev/vdb1
		
		顺序读IOPS	顺序写IOPS	随机读/写的IOPS
		4800		1000		750/775


1. 初始化表结构和数据

	CREATE TABLE `t_20201021` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',  
	`name` varchar(32) not NULL default '',
	`age` int(11) not NULL default 0,
	`ismale` tinyint(1) not null default 0,
	`id_card` varchar(32) not NULL default '',
	`test1` text COMMENT '',
	`test2` text COMMENT '',
	`createTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
	PRIMARY KEY (`id`),
	KEY `idx_age` (`age`),
	KEY `idx_name` (`name`),
	KEY `idx_card` (`id_card`),
	KEY `idx_createTime` (`createTime`)
	) ENGINE=InnoDB;


	drop procedure if exists idata ;
	delimiter ;;
	create procedure idata()
	begin
	  declare i int;
	  set i=1;
	  start transaction;
		  while(i<=500000)do
			insert into t_20201021(name, age, ismale, id_card, test1, test2) values(substring(md5(rand()),1,10), i, FLOOR(1 + (RAND() * 100)), substring(md5(rand()),1,30), concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '这里是做普通索引和唯一索引的插入性能对比测试'), concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '这里是做普通索引和唯一索引的插入性能对比测试'));
			set i=i+1;
		  end while;
	  commit;
	end;;
	delimiter ;



	mysql> call idata();
	Query OK, 0 rows affected (47.09 sec)

	mysql> call idata();
	Query OK, 0 rows affected (47.81 sec)

	mysql> call idata();call idata();call idata();call idata();call idata();call idata();call idata();call idata();
	Query OK, 0 rows affected (47.52 sec)

	Query OK, 0 rows affected (49.72 sec)

	Query OK, 0 rows affected (53.93 sec)

	Query OK, 0 rows affected (49.77 sec)

	Query OK, 0 rows affected (51.98 sec)

	Query OK, 0 rows affected (50.30 sec)

	Query OK, 0 rows affected (49.81 sec)

	Query OK, 0 rows affected (52.77 sec)

	mysql> call idata();call idata();call idata();call idata();
	Query OK, 0 rows affected (49.25 sec)

	Query OK, 0 rows affected (49.98 sec)

	Query OK, 0 rows affected (51.76 sec)

	Query OK, 0 rows affected (51.18 sec)

	mysql> call idata();call idata();call idata();call idata();call idata();call idata();call idata();call idata();
	Query OK, 0 rows affected (50.32 sec)

	Query OK, 0 rows affected (50.26 sec)

	Query OK, 0 rows affected (52.48 sec)

	Query OK, 0 rows affected (51.36 sec)

	Query OK, 0 rows affected (51.62 sec)

	Query OK, 0 rows affected (50.21 sec)

	Query OK, 0 rows affected (53.14 sec)

	Query OK, 0 rows affected (56.22 sec)

	mysql> call idata();call idata();call idata();call idata();call idata();call idata();call idata();call idata();
	Query OK, 0 rows affected (50.27 sec)

	Query OK, 0 rows affected (50.95 sec)

	Query OK, 0 rows affected (53.57 sec)

	Query OK, 0 rows affected (1 min 3.07 sec)

	Query OK, 0 rows affected (1 min 4.71 sec)

	Query OK, 0 rows affected (1 min 4.59 sec)

	Query OK, 0 rows affected (1 min 7.34 sec)

	Query OK, 0 rows affected (1 min 1.14 sec)

	mysql> SELECT table_schema,table_name,(data_length/1024/1024/1024) AS data_mb,(index_length/1024/1024/1024) AS index_mb,((data_length + index_length)/1024/1024/1024) AS all_mb,table_rows FROM  information_schema.tables  where table_schema = 'consistency_db' and table_name='t_20201021';
	+----------------+------------+----------------+----------------+----------------+------------+
	| table_schema   | table_name | data_mb        | index_mb       | all_mb         | table_rows |
	+----------------+------------+----------------+----------------+----------------+------------+
	| consistency_db | t_20201021 | 4.944335937500 | 1.907943725586 | 6.852279663086 |   14676368 |
	+----------------+------------+----------------+----------------+----------------+------------+
	1 row in set (0.00 sec)


	mysql> select count(*) from consistency_db.t_20201021;
	+----------+
	| count(*) |
	+----------+
	| 15000000 |
	+----------+
	1 row in set (2.76 sec)
	
	约1500W行记录，数据+索引大小约7GB。
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	mysql> call idata();
	Query OK, 0 rows affected (47.09 sec)
	
	slave:
		Seconds_Behind_Master: 47
	-- 验证了DML大事务造成的延迟，其延迟不会从0开始增加，而是直接从主库执行了多久开始。比如主库执行这个事务耗时20秒，那么延迟就从20开始，这是因为query event中没有准确的执行时间，可以参考第8节和第27节。
	-- 从库的延迟时间就从DML事务在主库执行的耗时开始。
	-- 说明了 Seconds_Behind_Master 不是完全准确.
	
	
2. slave1的相关参数

	show global variables like '%master_info_repository%';
	show global variables like '%relay_log_info_repository%';
	show global variables like '%relay_log_recovery%';
	show global variables like '%sync_master_info%';
	show global variables like '%sync_relay_log%';
	show global variables like '%sync_relay_log_info%';
	show global variables like '%updates%';
	show global variables like '%innodb_flush_log_at_trx_commit%';
	show global variables like '%sync_binlog%';
		
	
	mysql> show global variables like '%master_info_repository%';
	+------------------------+-------+
	| Variable_name          | Value |
	+------------------------+-------+
	| master_info_repository | TABLE |
	+------------------------+-------+
	1 row in set (0.00 sec)
	
	mysql> show global variables like '%relay_log_info_repository%';
	+---------------------------+-------+
	| Variable_name             | Value |
	+---------------------------+-------+
	| relay_log_info_repository | TABLE |
	+---------------------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%relay_log_recovery%';
	+--------------------+-------+
	| Variable_name      | Value |
	+--------------------+-------+
	| relay_log_recovery | OFF   |
	+--------------------+-------+
	1 row in set (0.01 sec)

	mysql> show global variables like '%sync_master_info%';
	+------------------+-------+
	| Variable_name    | Value |
	+------------------+-------+
	| sync_master_info | 10000 |
	+------------------+-------+
	1 row in set (0.01 sec)

	mysql> show global variables like '%sync_relay_log%';
	+---------------------+-------+
	| Variable_name       | Value |
	+---------------------+-------+
	| sync_relay_log      | 10000 |
	| sync_relay_log_info | 10000 |
	+---------------------+-------+
	2 rows in set (0.00 sec)

	mysql> show global variables like '%sync_relay_log_info%';
	+---------------------+-------+
	| Variable_name       | Value |
	+---------------------+-------+
	| sync_relay_log_info | 10000 |
	+---------------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%updates%';
	+-----------------------------------------+-------+
	| Variable_name                           | Value |
	+-----------------------------------------+-------+
	| binlog_direct_non_transactional_updates | OFF   |
	| log_slave_updates                       | ON    |
	| low_priority_updates                    | OFF   |
	| sql_safe_updates                        | OFF   |
	+-----------------------------------------+-------+
	4 rows in set (0.00 sec)

	mysql> show global variables like '%innodb_flush_log_at_trx_commit%';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| innodb_flush_log_at_trx_commit | 2     |
	+--------------------------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%sync_binlog%';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| sync_binlog   | 1000  |
	+---------------+-------+
	1 row in set (0.00 sec)

3. slave2的相关参数

	mysql> show global variables like '%master_info_repository%';
	+------------------------+-------+
	| Variable_name          | Value |
	+------------------------+-------+
	| master_info_repository | TABLE |
	+------------------------+-------+
	1 row in set (0.02 sec)

	mysql> show global variables like '%master_info_repository%';
	+------------------------+-------+
	| Variable_name          | Value |
	+------------------------+-------+
	| master_info_repository | TABLE |
	+------------------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%relay_log_info_repository%';
	+---------------------------+-------+
	| Variable_name             | Value |
	+---------------------------+-------+
	| relay_log_info_repository | TABLE |
	+---------------------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%relay_log_recovery%';
	+--------------------+-------+
	| Variable_name      | Value |
	+--------------------+-------+
	| relay_log_recovery | OFF   |
	+--------------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%sync_master_info%';
	+------------------+-------+
	| Variable_name    | Value |
	+------------------+-------+
	| sync_master_info | 10000 |
	+------------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%sync_relay_log%';
	+---------------------+-------+
	| Variable_name       | Value |
	+---------------------+-------+
	| sync_relay_log      | 10000 |
	| sync_relay_log_info | 10000 |
	+---------------------+-------+
	2 rows in set (0.01 sec)

	mysql> show global variables like '%sync_relay_log_info%';
	+---------------------+-------+
	| Variable_name       | Value |
	+---------------------+-------+
	| sync_relay_log_info | 10000 |
	+---------------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%updates%';
	+-----------------------------------------+-------+
	| Variable_name                           | Value |
	+-----------------------------------------+-------+
	| binlog_direct_non_transactional_updates | OFF   |
	| log_slave_updates                       | OFF   |
	| low_priority_updates                    | OFF   |
	| sql_safe_updates                        | OFF   |
	+-----------------------------------------+-------+
	4 rows in set (0.00 sec)

	mysql> show global variables like '%innodb_flush_log_at_trx_commit%';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| innodb_flush_log_at_trx_commit | 2     |
	+--------------------------------+-------+
	1 row in set (0.00 sec)



4. pt-osc 
	4.1 主库执行耗时
			sudo  pt-online-schema-change  --no-check-replication-filters  --charset=utf8mb4 --execute --alter "add column filed_04 int(10) not null default 0 comment 'filed_04'" --user=root --password=123456abc --host=192.168.0.20 D=consistency_db,t=t_20201021
			2020-10-21T10:48:00 Creating triggers...
			2020-10-21T10:48:00 Created triggers OK.
			2020-10-21T10:48:00 Copying approximately 13917535 rows...
			..........................................................
			2020-10-21T11:10:22 Dropped triggers OK.
			Successfully altered `consistency_db`.`t_20201021`.
		
			-- 耗时22分22秒


	4.2 slave1的延迟 
		mysql> show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: Waiting for master to send event
						  Master_Host: 192.168.0.20
						  Master_User: repl_user
						  Master_Port: 3306
						Connect_Retry: 60
					  Master_Log_File: mysql-bin.000252
				  Read_Master_Log_Pos: 178832041
					   Relay_Log_File: db-b-relay-bin.000047
						Relay_Log_Pos: 83189524
				Relay_Master_Log_File: mysql-bin.000252
					 Slave_IO_Running: Yes
					Slave_SQL_Running: Yes
		....................................................................
				  Exec_Master_Log_Pos: 83189311
					  Relay_Log_Space: 178832547
		....................................................................
				Seconds_Behind_Master: 24
		....................................................................
					 Master_Server_Id: 1
						  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
					 Master_Info_File: mysql.slave_master_info
							SQL_Delay: 0
		....................................................................
				   Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13797-2420984
					Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-2420939,
		90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-533915
						Auto_Position: 1
		....................................................................
		1 row in set (0.01 sec)


		-- 延迟一直维持在 20-24秒.

	4.3 slave2的延迟 	
		mysql> show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: Waiting for master to send event
						  Master_Host: 192.168.0.20
						  Master_User: repl_user
						  Master_Port: 3306
						Connect_Retry: 60
					  Master_Log_File: mysql-bin.000253
				  Read_Master_Log_Pos: 906774305
					   Relay_Log_File: voice-relay-bin.000050
						Relay_Log_Pos: 906774518
				Relay_Master_Log_File: mysql-bin.000253
					 Slave_IO_Running: Yes
					Slave_SQL_Running: Yes
		....................................................................
				  Exec_Master_Log_Pos: 906774305
					  Relay_Log_Space: 906774812
		....................................................................
				Seconds_Behind_Master: 0
		....................................................................
					 Master_Server_Id: 1
						  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
					 Master_Info_File: mysql.slave_master_info
							SQL_Delay: 0
		....................................................................
				   Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13798-2421932
					Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-2421932,
		76dcdf7c-2873-11ea-a58e-4201c0a8010c:1-47,
		90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-415
						Auto_Position: 1
		....................................................................
		1 row in set (0.00 sec)
		
		-- 几乎没有延迟，最大延迟为1秒。
		

	4.4 master的CPU负载和IO负载
		shell> top
		top - 10:57:19 up 907 days, 16:44,  3 users,  load average: 1.19, 1.03, 0.72
		Tasks: 116 total,   2 running, 114 sleeping,   0 stopped,   0 zombie
		%Cpu0  :  9.5 us,  2.7 sy,  0.0 ni, 51.5 id, 36.3 wa,  0.0 hi,  0.0 si,  0.0 st
		%Cpu1  : 14.4 us,  3.3 sy,  0.0 ni, 71.9 id, 10.4 wa,  0.0 hi,  0.0 si,  0.0 st
		%Cpu2  :  9.1 us,  1.3 sy,  0.0 ni, 81.9 id,  7.7 wa,  0.0 hi,  0.0 si,  0.0 st
		%Cpu3  :  6.7 us,  1.0 sy,  0.0 ni, 87.0 id,  5.4 wa,  0.0 hi,  0.0 si,  0.0 st
		KiB Mem : 16267704 total,   249036 free,  7516792 used,  8501876 buff/cache
		KiB Swap:        0 total,        0 free,        0 used.  7525576 avail Mem 

		  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                             
		29200 mysql     20   0 8761408   6.3g   6480 S  48.8 40.7 196:16.63 mysqld                                                                                                                                                              
		   41 root      20   0       0      0      0 S   0.7  0.0   7:39.19 kswapd0        


		shell> iostat -dmx 1
		Linux 3.10.0-693.21.1.el7.x86_64 (db-a) 	10/21/2020 	_x86_64_	(4 CPU)

		..........................................................................................................................
		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sda               0.00     0.00    0.00   11.00     0.00     1.38   256.00     0.05    4.73    0.00    4.73   0.55   0.60
		sdb               0.00     0.00    2.00  382.00     0.03    56.04   299.04     4.54   11.65    1.00   11.70   1.92  73.70
		..........................................................................................................................
		Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
		sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
		sdb              27.00     0.00   70.00  349.00    11.87    51.82   311.29     4.78   11.50    3.56   13.09   1.84  77.30


		shell> iostat 1
		Linux 3.10.0-693.21.1.el7.x86_64 (db-a) 	10/21/2020 	_x86_64_	(4 CPU)

		avg-cpu:  %user   %nice %system %iowait  %steal   %idle
				   0.12    0.00    0.07    0.05    0.00   99.76

		Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
		sda               0.27         1.15         5.37   89886812  421050668
		sdb               9.40         0.82       161.58   64661456 12672259112

		avg-cpu:  %user   %nice %system %iowait  %steal   %idle
				  10.25    0.00    2.00   11.25    0.00   76.50

		......................................................................
		avg-cpu:  %user   %nice %system %iowait  %steal   %idle
				  10.08    0.00    2.27   13.60    0.00   74.06

		Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
		sda               7.00         0.00      1632.00          0       1632



		-- 主要占用的是IO资源，所以还是要在业务低峰期执行，此时对业务的影响最小。

		



shell> sudo  pt-online-schema-change  --no-check-replication-filters  --charset=utf8mb4 --execute --alter "drop column filed_04" --user=root --password=123456abc --host=localhost D=consistency_db,t=t_20201021

2020-10-21T11:26:22 Creating triggers...
2020-10-21T11:26:22 Created triggers OK.
2020-10-21T11:26:22 Copying approximately 14659130 rows...
...................................................
2020-10-21T11:48:28 Dropped triggers OK.
Successfully altered `consistency_db`.`t_20201021`.




-----------------------------------------------------------------


5. gh-ost 
	create user 'temp_test'@'%' identified by '123456abc';
	grant all privileges on *.* to 'temp_test'@'%' with grant option;
	5.1 主库执行耗时
		time /home/coding001/scripts/gh-ost \
		--max-load=Threads_running=20 \
		--critical-load=Threads_running=50 \
		--critical-load-interval-millis=5000 \
		--chunk-size=6500 \
		--user="temp_test" \
		--password="123456abc" \
		--host='192.168.0.20' \
		--port=3306 \
		--database="consistency_db" \
		--table="t_20201021" \
		--verbose \
		--alter="add column filed_04 int(10) not null default 0 comment 'filed_04'" \
		--assume-rbr \
		--cut-over=default \
		--cut-over-lock-timeout-seconds=1 \
		--dml-batch-size=10 \
		--allow-on-master \
		--concurrent-rowcount \
		--default-retries=10 \
		--heartbeat-interval-millis=2000 \
		--panic-flag-file=/tmp/ghost.panic.flag \
		--postpone-cut-over-flag-file=/tmp/ghost.postpone.flag \
		--timestamp-old-table \
		--execute 2>&1 | tee  /tmp/rebuild_t2.log

		22m25s(copy)
		
	5.2 slave1的延迟 
	
		mysql> show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: Waiting for master to send event
						  Master_Host: 192.168.0.20
						  Master_User: repl_user
						  Master_Port: 3306
						Connect_Retry: 60
					  Master_Log_File: mysql-bin.000263
				  Read_Master_Log_Pos: 173531150
					   Relay_Log_File: db-b-relay-bin.000080
						Relay_Log_Pos: 113874593
				Relay_Master_Log_File: mysql-bin.000263
					 Slave_IO_Running: Yes
					Slave_SQL_Running: Yes
		....................................................................
				  Exec_Master_Log_Pos: 113874380
					  Relay_Log_Space: 173531656
		....................................................................
				Seconds_Behind_Master: 26
		....................................................................
						  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
					 Master_Info_File: mysql.slave_master_info
							SQL_Delay: 0
		....................................................................
				   Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13797-2428924
					Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-2428862,
		90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-533952
						Auto_Position: 1
		....................................................................
		1 row in set (0.00 sec)

		-- 延迟一直维持在 20-24秒.
		
		
	5.3 slave2的延迟 
	
		-- 几乎没有延迟，最大延迟为1秒。
		

	5.4 查看CPU负载和IO负载	

		5.4.1 master的CPU负载和IO负载	
			shell> top
			top - 12:08:37 up 907 days, 17:56,  3 users,  load average: 1.80, 1.33, 0.93
			Tasks: 120 total,   1 running, 119 sleeping,   0 stopped,   0 zombie
			%Cpu0  : 10.5 us,  4.8 sy,  0.0 ni, 64.3 id, 20.1 wa,  0.0 hi,  0.3 si,  0.0 st
			%Cpu1  : 16.1 us,  4.4 sy,  0.0 ni, 61.4 id, 18.1 wa,  0.0 hi,  0.0 si,  0.0 st
			%Cpu2  : 14.7 us,  3.0 sy,  0.0 ni, 64.5 id, 17.4 wa,  0.0 hi,  0.3 si,  0.0 st
			%Cpu3  : 15.8 us,  3.0 sy,  0.0 ni, 70.5 id, 10.4 wa,  0.0 hi,  0.3 si,  0.0 st
			KiB Mem : 16267704 total,   187184 free,  7546492 used,  8534028 buff/cache
			KiB Swap:        0 total,        0 free,        0 used.  7491092 avail Mem 

			  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                             
			29200 mysql     20   0 8761408   6.3g   6680 S  59.5 40.9 217:54.49 mysqld                                                                                                                                                              
			  619 coding0+  20   0  996208  11652   3816 S  16.3  0.1   1:12.14 gh-ost                                                                                                                                                              
			32241 mongodb   20   0 2413664 467160   5840 S   0.7  2.9   1114:35 mongod   


			shell> iostat -dmx 1
			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
			sdb               0.00     0.00    0.00  359.00     0.00    51.82   295.62     3.94   10.97    0.00   10.97   1.99  71.60

			..........................................................................................................................
			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
			sdb               0.00     0.00    0.00  363.00     0.00    52.01   293.44     6.11   16.71    0.00   16.71   2.63  95.60

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00     0.00    0.00    8.00     0.00     1.00   256.00     0.03    3.25    0.00    3.25   0.50   0.40
			sdb               0.00     0.00    0.00  327.00     0.00    48.09   301.19     5.72   17.06    0.00   17.06   2.90  94.80

			shell> iostat 1
			Linux 3.10.0-693.21.1.el7.x86_64 (db-a) 	10/21/2020 	_x86_64_	(4 CPU)

			avg-cpu:  %user   %nice %system %iowait  %steal   %idle
					   0.12    0.00    0.07    0.05    0.00   99.76

			Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
			sda               0.27         1.15         5.38   90445856  421969016
			sdb               9.42         1.01       163.73   79300484 12841544088

			avg-cpu:  %user   %nice %system %iowait  %steal   %idle
					   5.56    0.00    2.02   18.43    0.00   73.99

			Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
			sda               0.00         0.00         0.00          0          0
			sdb             310.00         0.00     49048.00          0      49048

			avg-cpu:  %user   %nice %system %iowait  %steal   %idle
					   5.56    0.00    3.03   22.22    0.00   69.19

			Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
			sda               0.00         0.00         0.00          0          0
			sdb             389.00      4096.00     52952.00       4096      52952

			avg-cpu:  %user   %nice %system %iowait  %steal   %idle
					   7.09    0.00    2.53   20.00    0.00   70.38

			Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
			sda               0.00         0.00         0.00          0          0
			sdb             360.00      4096.00     49656.00       4096      49656


		5.4.2 slave1的CPU负载和IO负载	
			shell> top
			top - 12:10:01 up 485 days, 18:38,  2 users,  load average: 1.52, 1.19, 0.88
			Tasks: 121 total,   1 running, 120 sleeping,   0 stopped,   0 zombie
			%Cpu0  :  9.8 us,  2.7 sy,  0.0 ni, 55.6 id, 31.5 wa,  0.0 hi,  0.3 si,  0.0 st
			%Cpu1  :  7.6 us,  2.6 sy,  0.0 ni, 78.8 id, 10.9 wa,  0.0 hi,  0.0 si,  0.0 st
			%Cpu2  : 13.6 us,  2.7 sy,  0.0 ni, 77.1 id,  6.6 wa,  0.0 hi,  0.0 si,  0.0 st
			%Cpu3  :  6.7 us,  1.3 sy,  0.0 ni, 84.3 id,  7.7 wa,  0.0 hi,  0.0 si,  0.0 st
			KiB Mem : 16266528 total,   170132 free,  7750964 used,  8345432 buff/cache
			KiB Swap:        0 total,        0 free,        0 used.  7346184 avail Mem 

			  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                             
			14195 mysql     20   0 8675852   6.6g   6764 S  44.2 42.8 186:22.03 mysqld                                                                                                                                                              
			   46 root      20   0       0      0      0 S   0.7  0.0   3:49.76 kswapd0                                                                                                                                                             
			13238 mongodb   20   0 2251112 463388   6604 S   0.7  2.8   1022:25 mongod                      


			shell> iostat -dmx 1
			Linux 3.10.0-957.10.1.el7.x86_64 (db-b) 	10/21/2020 	_x86_64_	(4 CPU)

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sdb               0.00     0.02    0.01    1.42     0.00     0.04    61.25     0.01    6.72   12.13    6.68   0.66   0.09
			sda               0.00     0.05    0.00    0.41     0.00     0.01    31.51     0.00    6.79   17.15    6.69   0.70   0.03

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sdb               0.00     0.00    0.00  277.00     0.00    48.00   354.92     3.74   13.46    0.00   13.46   3.40  94.30
			sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sdb               0.00     0.00    0.00  291.00     0.00    52.13   366.87     3.69   12.92    0.00   12.92   3.18  92.60
			sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sdb               0.00     0.00    0.00  280.00     0.00    51.91   379.71     3.46   12.38    0.00   12.38   3.00  84.10
			sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

			..........................................................................................................................

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sdb               0.00     0.00    0.00  286.00     0.00    56.55   404.95     3.29   11.42    0.00   11.42   2.58  73.90
			sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

			^XDevice:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sdb               0.00     0.00    0.00  299.00     0.00    55.99   383.52     3.25   10.93    0.00   10.93   2.47  73.80
			sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
			
			
			shell> iostat 1
			Linux 3.10.0-957.10.1.el7.x86_64 (db-b) 	10/21/2020 	_x86_64_	(4 CPU)

			avg-cpu:  %user   %nice %system %iowait  %steal   %idle
					   0.09    0.00    0.04    0.01    0.00   99.86

			Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
			sdb               1.43         0.98        43.15   41186800 1811172524
			sda               0.41         0.18         6.31    7412268  264708404

			avg-cpu:  %user   %nice %system %iowait  %steal   %idle
					   4.52    0.00    1.51   20.85    0.00   73.12

			......................................................................

			avg-cpu:  %user   %nice %system %iowait  %steal   %idle
					   9.05    0.00    1.76   15.33    0.00   73.87

			Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
			sdb             276.00         0.00     53264.00          0      53264
			sda               0.00         0.00         0.00          0          0


			-- binlog 刷盘占用的IO资源还是挺多的.
			
			
		5.4.3 slave2的CPU负载和IO负载	
			shell> top
			top - 12:10:17 up 908 days, 21:58,  2 users,  load average: 0.32, 0.37, 0.32
			Tasks: 109 total,   1 running, 108 sleeping,   0 stopped,   0 zombie
			%Cpu0  : 15.6 us,  1.7 sy,  0.0 ni, 79.7 id,  3.1 wa,  0.0 hi,  0.0 si,  0.0 st
			%Cpu1  : 13.7 us,  3.0 sy,  0.0 ni, 81.3 id,  1.7 wa,  0.0 hi,  0.3 si,  0.0 st
			%Cpu2  : 10.7 us,  1.3 sy,  0.0 ni, 87.3 id,  0.7 wa,  0.0 hi,  0.0 si,  0.0 st
			%Cpu3  :  1.0 us,  1.3 sy,  0.0 ni, 96.7 id,  1.0 wa,  0.0 hi,  0.0 si,  0.0 st
			KiB Mem : 16267704 total,   187720 free,  9902972 used,  6177012 buff/cache
			KiB Swap:        0 total,        0 free,        0 used.  5222776 avail Mem 

			  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                             
			31266 mysql     20   0   10.8g   8.8g   3820 S  44.3 57.0  58:00.29 mysqld                                                                                                                                                              
			 2251 coding0+  20   0  147768  28772   1108 S   3.3  0.2 311:22.15 skynet                                                                                                                                                              
			 2214 coding0+  20   0  174352  22468    892 S   3.0  0.1 306:08.08 skynet                             


			shell> iostat -dmx 1
			Linux 3.10.0-693.21.1.el7.x86_64 (voice) 	10/21/2020 	_x86_64_	(4 CPU)

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00     0.04    0.00    0.59     0.00     0.01    38.71     0.00    3.00    3.80    3.00   0.39   0.02
			sdb               0.00     0.00    0.00    0.00     0.00     0.00 533909.29     0.00   10.17    0.79   15.81   3.25   0.00

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00     0.00    0.00  207.00     0.00    24.94   246.76     0.84    4.07    0.00    4.07   0.39   8.10
			sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00     0.00   14.00  308.00     0.05    27.06   172.45     1.02    3.17    0.71    3.28   0.28   8.90
			sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

			.......................................................................................................................

			sda               0.00     0.00    0.00  195.05     0.00    26.98   283.25     0.77    3.96    0.00    3.96   0.46   8.91
			sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00     0.00    0.00  211.00     0.00    26.49   257.14     0.96    4.55    0.00    4.55   0.42   8.90
			sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00     0.00    0.00  196.00     0.00    26.38   275.67     0.96    4.90    0.00    4.90   0.48   9.50
			sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sda               0.00     0.00    0.00  220.00     0.00    30.04   279.64     1.06    4.82    0.00    4.82   0.44   9.70
			sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
			 
	 
			shell> iostat 1
			Linux 3.10.0-693.21.1.el7.x86_64 (voice) 	10/21/2020 	_x86_64_	(4 CPU)

			avg-cpu:  %user   %nice %system %iowait  %steal   %idle
					   0.54    0.00    1.59    0.00    0.00   97.87

			Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
			sda               0.59         0.03        11.50    2735350  903064452
			sdb               0.00         0.00         2.67       9360  209816992

			avg-cpu:  %user   %nice %system %iowait  %steal   %idle
					   8.77    0.00    1.75    1.50    0.00   87.97

			Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
			sda             205.00         0.00     27120.00          0      27120
			sdb               0.00         0.00         0.00          0          0

			avg-cpu:  %user   %nice %system %iowait  %steal   %idle
					   9.37    0.00    3.04    6.33    0.00   81.27

			Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
			sda             580.00        20.00     80776.00         20      80776
			sdb               0.00         0.00         0.00          0          0

			avg-cpu:  %user   %nice %system %iowait  %steal   %idle
					   8.82    0.00    1.76    1.26    0.00   88.16

			Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
			sda             194.00         0.00     27160.00          0      27160
			sdb               0.00         0.00         0.00          0          0

			avg-cpu:  %user   %nice %system %iowait  %steal   %idle
					   9.62    0.00    1.77    1.27    0.00   87.34

			Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
			sda             208.00         0.00     27340.00          0      27340
			sdb               0.00         0.00         0.00          0          0

			avg-cpu:  %user   %nice %system %iowait  %steal   %idle
					  12.88    0.00    1.77    2.02    0.00   83.33

			Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
			sda             277.00         0.00     34840.00          0      34840
			sdb               0.00         0.00         0.00          0          0

			avg-cpu:  %user   %nice %system %iowait  %steal   %idle
					   9.09    0.00    1.77    2.02    0.00   87.12

			Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
			sda             267.00         0.00     32292.00          0      32292
			sdb               0.00         0.00         0.00          0          0


6. 遇到的一些问题

	Copy: 14657500/14659130 100.0%; Applied: 0; Backlog: 0/1000; Time: 21m10s(total), 21m10s(copy); streamer: mysql-bin.000269:183797050; Lag: 0.00s, State: migrating; ETA: 0s
	Copy: 14852500/14659130 101.3%; Applied: 0; Backlog: 0/1000; Time: 21m30s(total), 21m30s(copy); streamer: mysql-bin.000269:247882246; Lag: 0.00s, State: migrating; ETA: due
	2020-10-21 16:28:29 INFO Row copy complete
	Copy: 15000000/15000000 100.0%; Applied: 0; Backlog: 0/1000; Time: 21m48s(total), 21m48s(copy); streamer: mysql-bin.000269:294953185; Lag: 1.00s, State: migrating; ETA: due
	Copy: 15000000/15000000 100.0%; Applied: 0; Backlog: 0/1000; Time: 21m50s(total), 21m48s(copy); streamer: mysql-bin.000269:296359592; Lag: 0.00s, State: postponing cut-over; ETA: due
	Copy: 15000000/15000000 100.0%; Applied: 0; Backlog: 0/1000; Time: 21m55s(total), 21m48s(copy); streamer: mysql-bin.000269:296363941; Lag: 0.00s, State: postponing cut-over; ETA: due
	Copy: 15000000/15000000 100.0%; Applied: 0; Backlog: 0/1000; Time: 22m0s(total), 21m48s(copy); streamer: mysql-bin.000269:296368699; Lag: 0.00s, State: postponing cut-over; ETA: due
	Copy: 15000000/15000000 100.0%; Applied: 0; Backlog: 0/1000; Time: 22m5s(total), 21m48s(copy); streamer: mysql-bin.000269:296375750; Lag: 0.00s, State: postponing cut-over; ETA: due
	Copy: 15000000/15000000 100.0%; Applied: 0; Backlog: 0/1000; Time: 22m10s(total), 21m48s(copy); streamer: mysql-bin.000269:296380097; Lag: 0.00s, State: postponing cut-over; ETA: due
	Copy: 15000000/15000000 100.0%; Applied: 0; Backlog: 0/1000; Time: 22m15s(total), 21m48s(copy); streamer: mysql-bin.000269:296384446; Lag: 0.00s, State: postponing cut-over; ETA: due
	Copy: 15000000/15000000 100.0%; Applied: 0; Backlog: 0/1000; Time: 22m20s(total), 21m48s(copy); streamer: mysql-bin.000269:296388795; Lag: 0.00s, State: postponing cut-over; ETA: due
	Copy: 15000000/15000000 100.0%; Applied: 0; Backlog: 0/1000; Time: 22m25s(total), 21m48s(copy); streamer: mysql-bin.000269:296393853; Lag: 0.00s, State: postponing cut-over; ETA: due
	Copy: 15000000/15000000 100.0%; Applied: 0; Backlog: 0/1000; Time: 22m30s(total), 21m48s(copy); streamer: mysql-bin.000269:296398200; Lag: 0.00s, State: postponing cut-over; ETA: due
	Copy: 15000000/15000000 100.0%; Applied: 0; Backlog: 0/1000; Time: 22m35s(total), 21m48s(copy); streamer: mysql-bin.000269:296404321; Lag: 0.00s, State: postponing cut-over; ETA: due
	Copy: 15000000/15000000 100.0%; Applied: 0; Backlog: 0/1000; Time: 22m40s(total), 21m48s(copy); streamer: mysql-bin.000269:296411378; Lag: 0.00s, State: postponing cut-over; ETA: due
	Copy: 15000000/15000000 100.0%; Applied: 0; Backlog: 0/1000; Time: 22m45s(total), 21m48s(copy); streamer: mysql-bin.000269:296415727; Lag: 0.00s, State: postponing cut-over; ETA: due
	Copy: 15000000/15000000 100.0%; Applied: 0; Backlog: 0/1000; Time: 23m0s(total), 21m48s(copy); streamer: mysql-bin.000269:296426853; Lag: 0.00s, State: postponing cut-over; ETA: due
	^C


	shell> go version
	go version go1.15.2 linux/amd64

	[coding001@db-a scripts]$ ./gh-ost --version
	1.1.0

	GA release v1.1.0
	@timvaillancourt timvaillancourt released this on 28 Aug

	Changes since 1.0.49: v1.0.49...v1.1.0

	Notable:

		Add a check to rows.Err after processing all rows, #835, thanks @ajm188
		Support a complete ALTER TABLE statement in --alter, #865 / #878, thanks @shlomi-noach
		Support --mysql-timeout flag, #824, thanks @shlomi-noach
		Update go-sql-driver to latest, #823, thanks @shlomi-noach
		Update build to Golang 1.14, #861 / #876, thanks @shlomi-noach
		Add error checking for an err variable that was left unchecked, #810, thanks @yaserazfar
		Implement a logging interface, #789 / #864, thanks @abeyum and @jfudally
		Throttle on HTTP error to throttling API, #833, thanks @jfudally
		Additional testing:
		Add latin1 tests with TEXT columns, #291 / #455, thanks @shlomi-noach
		Add BINARY / VARBINARY tests, #655, thanks @shlomi-noach
		Add NULL-able INT tests, #692, thanks @shlomi-noach

	-- 以为是 Golang 版本要用 1.14 的， 1.15 的太新了。
	
	
	https://github.com/github/gh-ost/issues/804
	
	
7. 一些收获和小结
	7.1 验证了一个从库延迟是从主库执行完成DML的时长开始的观点
		mysql> call idata();
		Query OK, 0 rows affected (47.09 sec)
		
		slave:
			Seconds_Behind_Master: 47
		-- 验证了DML大事务造成的延迟，其延迟不会从0开始增加，而是直接从主库执行了多久开始。比如主库执行这个事务耗时20秒，那么延迟就从20开始，这是因为query event中没有准确的执行时间，可以参考第8节和第27节。
		-- 说明了 Seconds_Behind_Master 不是完全准确.
		
		-- 未完成：验证下DDL的延迟
		
	7.2 两者的执行耗时
		pt-osc：耗时22分22秒
		gh-ost：耗时22分25秒 22m25s(copy)
		
		两者的执行耗时相差不大。
		
	7.3 两个从库的延迟对比
		slave1：20-24秒
		slave2: 无延迟
		
	7.4 两个从库的CPU负载和IO负载
		
		slave1:
			load：1.5, CPU利用率：44%, IO利用率：75%, IO等待：18% 。
		
		slave2:
			load：0.3, CPU利用率：44%, IO利用率：8%, IO等待：2% 。
			
		slave1从库开启了记录binlog功能也就是开启了参数 log_slave_updates，尽管设置sync_binlog=1000，但是binlog刷盘占用的IO资源还是挺多的，同时也是造成主从延迟的重要因素。
		
	7.5 主库的CPU负载和IO负载
		load：1.8, CPU利用率：60%, IO利用率：80%, IO等待：20% 。
		
		可以看到，gh-ost或者pt-osc 主要占用的是IO资源，所以还是要在业务低峰期执行，此时对业务的影响最小。
		
	
8. 部分general_log日志

	8.1 pt-osc
		shell> sudo tail -200 db-a.log 
		2020-10-21T03:01:44.927178Z	106714 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
		2020-10-21T03:01:44.929218Z	106714 Query	EXPLAIN SELECT /*!40001 SQL_NO_CACHE */ `id` FROM `consistency_db`.`t_20201021` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '10865192')) ORDER BY `id` LIMIT 6227, 2 /*next chunk boundary*/
		2020-10-21T03:01:44.930453Z	106714 Query	SELECT /*!40001 SQL_NO_CACHE */ `id` FROM `consistency_db`.`t_20201021` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '10865192')) ORDER BY `id` LIMIT 6227, 2 /*next chunk boundary*/
		2020-10-21T03:01:44.934041Z	106714 Query	EXPLAIN SELECT `id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createtime` FROM `consistency_db`.`t_20201021` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '10865192')) AND ((`id` <= '10871419')) LOCK IN SHARE MODE /*explain pt-online-schema-change 28202 copy nibble*/
		2020-10-21T03:01:44.934596Z	106714 Query	INSERT LOW_PRIORITY IGNORE INTO `consistency_db`.`_t_20201021_new` (`id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createtime`) SELECT `id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createtime` FROM `consistency_db`.`t_20201021` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '10865192')) AND ((`id` <= '10871419')) LOCK IN SHARE MODE /*pt-online-schema-change 28202 copy nibble*/
		2020-10-21T03:01:45.500047Z	94839 Query	call pr_third_query_order('10458637262316212692471test12010',@nAmount,@nStatus,@returnVal,@returnMsg);
		2020-10-21T03:01:45.500719Z	94839 Query	select @nAmount,@nStatus,@returnVal,@returnMsg
		2020-10-21T03:01:45.668459Z	106714 Query	SHOW WARNINGS
		2020-10-21T03:01:45.669024Z	106714 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
		2020-10-21T03:01:45.670789Z	106714 Query	EXPLAIN SELECT /*!40001 SQL_NO_CACHE */ `id` FROM `consistency_db`.`t_20201021` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '10871420')) ORDER BY `id` LIMIT 5553, 2 /*next chunk boundary*/
		2020-10-21T03:01:45.671244Z	106714 Query	SELECT /*!40001 SQL_NO_CACHE */ `id` FROM `consistency_db`.`t_20201021` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '10871420')) ORDER BY `id` LIMIT 5553, 2 /*next chunk boundary*/
		2020-10-21T03:01:45.675244Z	106714 Query	EXPLAIN SELECT `id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createtime` FROM `consistency_db`.`t_20201021` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '10871420')) AND ((`id` <= '10876973')) LOCK IN SHARE MODE /*explain pt-online-schema-change 28202 copy nibble*/
		2020-10-21T03:01:45.675794Z	106714 Query	INSERT LOW_PRIORITY IGNORE INTO `consistency_db`.`_t_20201021_new` (`id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createtime`) SELECT `id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createtime` FROM `consistency_db`.`t_20201021` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '10871420')) AND ((`id` <= '10876973')) LOCK IN SHARE MODE /*pt-online-schema-change 28202 copy nibble*/
		2020-10-21T03:01:45.999920Z	106714 Query	SHOW WARNINGS
		2020-10-21T03:01:46.001343Z	106714 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
		2020-10-21T03:01:46.003300Z	106714 Query	EXPLAIN SELECT /*!40001 SQL_NO_CACHE */ `id` FROM `consistency_db`.`t_20201021` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '10876974')) ORDER BY `id` LIMIT 6055, 2 /*next chunk boundary*/
		2020-10-21T03:01:46.003902Z	106714 Query	SELECT /*!40001 SQL_NO_CACHE */ `id` FROM `consistency_db`.`t_20201021` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '10876974')) ORDER BY `id` LIMIT 6055, 2 /*next chunk boundary*/
		2020-10-21T03:01:46.011192Z	106714 Query	EXPLAIN SELECT `id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createtime` FROM `consistency_db`.`t_20201021` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '10876974')) AND ((`id` <= '10883029')) LOCK IN SHARE MODE /*explain pt-online-schema-change 28202 copy nibble*/
		2020-10-21T03:01:46.011917Z	106714 Query	INSERT LOW_PRIORITY IGNORE INTO `consistency_db`.`_t_20201021_new` (`id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createtime`) SELECT `id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createtime` FROM `consistency_db`.`t_20201021` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '10876974')) AND ((`id` <= '10883029')) LOCK IN SHARE MODE /*pt-online-schema-change 28202 copy nibble*/
		2020-10-21T03:01:46.677345Z	106714 Query	SHOW WARNINGS
		2020-10-21T03:01:46.677934Z	106714 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
		2020-10-21T03:01:46.679828Z	106714 Query	EXPLAIN SELECT /*!40001 SQL_NO_CACHE */ `id` FROM `consistency_db`.`t_20201021` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '10883030')) ORDER BY `id` LIMIT 5584, 2 /*next chunk boundary*/
		2020-10-21T03:01:46.680405Z	106714 Query	SELECT /*!40001 SQL_NO_CACHE */ `id` FROM `consistency_db`.`t_20201021` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '10883030')) ORDER BY `id` LIMIT 5584, 2 /*next chunk boundary*/
		2020-10-21T03:01:46.684597Z	106714 Query	EXPLAIN SELECT `id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createtime` FROM `consistency_db`.`t_20201021` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '10883030')) AND ((`id` <= '10888614')) LOCK IN SHARE MODE /*explain pt-online-schema-change 28202 copy nibble*/
		2020-10-21T03:01:46.685243Z	106714 Query	INSERT LOW_PRIORITY IGNORE INTO `consistency_db`.`_t_20201021_new` (`id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createtime`) SELECT `id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createtime` FROM `consistency_db`.`t_20201021` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '10883030')) AND ((`id` <= '10888614')) LOCK IN SHARE MODE /*pt-online-schema-change 28202 copy nibble*/
		2020-10-21T03:01:47.328845Z	106714 Query	SHOW WARNINGS
		2020-10-21T03:01:47.329477Z	106714 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
		2020-10-21T03:01:47.331505Z	106714 Query	EXPLAIN SELECT /*!40001 SQL_NO_CACHE */ `id` FROM `consistency_db`.`t_20201021` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '10888615')) ORDER BY `id` LIMIT 5226, 2 /*next chunk boundary*/
		2020-10-21T03:01:47.331986Z	106714 Query	SELECT /*!40001 SQL_NO_CACHE */ `id` FROM `consistency_db`.`t_20201021` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '10888615')) ORDER BY `id` LIMIT 5226, 2 /*next chunk boundary*/
		2020-10-21T03:01:47.335291Z	106714 Query	EXPLAIN SELECT `id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createtime` FROM `consistency_db`.`t_20201021` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '10888615')) AND ((`id` <= '10893841')) LOCK IN SHARE MODE /*explain pt-online-schema-change 28202 copy nibble*/
		2020-10-21T03:01:47.335886Z	106714 Query	INSERT LOW_PRIORITY IGNORE INTO `consistency_db`.`_t_20201021_new` (`id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createtime`) SELECT `id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createtime` FROM `consistency_db`.`t_20201021` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '10888615')) AND ((`id` <= '10893841')) LOCK IN SHARE MODE /*pt-online-schema-change 28202 copy nibble*/
		2020-10-21T03:01:47.727082Z	106714 Query	SHOW WARNINGS
		2020-10-21T03:01:47.727711Z	106714 Query	SHOW GLOBAL STATUS LIKE 'Threads_running'
		2020-10-21T03:01:47.729534Z	106714 Query	EXPLAIN SELECT /*!40001 SQL_NO_CACHE */ `id` FROM `consistency_db`.`t_20201021` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '10893842')) ORDER BY `id` LIMIT 5501, 2 /*next chunk boundary*/
		2020-10-21T03:01:47.730061Z	106714 Query	SELECT /*!40001 SQL_NO_CACHE */ `id` FROM `consistency_db`.`t_20201021` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '10893842')) ORDER BY `id` LIMIT 5501, 2 /*next chunk boundary*/
		2020-10-21T03:01:47.738182Z	106714 Query	EXPLAIN SELECT `id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createtime` FROM `consistency_db`.`t_20201021` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '10893842')) AND ((`id` <= '10899343')) LOCK IN SHARE MODE /*explain pt-online-schema-change 28202 copy nibble*/
		2020-10-21T03:01:47.738934Z	106714 Query	INSERT LOW_PRIORITY IGNORE INTO `consistency_db`.`_t_20201021_new` (`id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createtime`) SELECT `id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createtime` FROM `consistency_db`.`t_20201021` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '10893842')) AND ((`id` <= '10899343')) LOCK IN SHARE MODE /*pt-online-schema-change 28202 copy nibble*/

		-- 每次迁移 select 10883029-10876974 = 6055 条记录。
		

	8.2 gh-ost
		shell> sudo tail -200 db-a.log 
		2020-10-21T08:14:10.547399Z	108901 Query	SET autocommit=true
		2020-10-21T08:14:10.547566Z	108901 Query	SET NAMES utf8mb4
		2020-10-21T08:14:10.547786Z	108901 Query	select hint, value from `consistency_db`.`_t_20201021_ghc` where hint = 'heartbeat' and id <= 255
		2020-10-21T08:14:10.548903Z	108901 Query	show global status like 'Threads_running'
		2020-10-21T08:14:10.550332Z	108901 Query	show global status like 'Threads_running'
		2020-10-21T08:14:11.072178Z	108899 Query	COMMIT
		2020-10-21T08:14:11.106580Z	108901 Query	select  /* gh-ost `consistency_db`.`t_20201021` iteration:1104 */
								`id`
							from
								`consistency_db`.`t_20201021`
							where ((`id` > _binary'7176000')) and ((`id` < _binary'15000000') or ((`id` = _binary'15000000')))
							order by
								`id` asc
							limit 1
							offset 6499
		2020-10-21T08:14:11.108487Z	108899 Quit	
		2020-10-21T08:14:11.153806Z	108900 Query	START TRANSACTION
		2020-10-21T08:14:11.154085Z	108900 Query	SET SESSION time_zone = 'SYSTEM', sql_mode = CONCAT(@@session.sql_mode, ',,NO_AUTO_VALUE_ON_ZERO,STRICT_ALL_TABLES')
		2020-10-21T08:14:11.154448Z	108900 Query	insert /* gh-ost `consistency_db`.`t_20201021` */ ignore into `consistency_db`.`_t_20201021_gho` (`id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createTime`)
			  (select `id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createTime` from `consistency_db`.`t_20201021` force index (`PRIMARY`)
				where (((`id` > _binary'7176000')) and ((`id` < _binary'7182500') or ((`id` = _binary'7182500')))) lock in share mode
			  )
		2020-10-21T08:14:11.543965Z	108901 Query	insert /* gh-ost */ into `consistency_db`.`_t_20201021_ghc`
						(id, hint, value)
					values
						(NULLIF(1, 0), 'heartbeat', '2020-10-21T16:14:11.543613579+08:00')
					on duplicate key update
						last_update=NOW(),
						value=VALUES(value)
		2020-10-21T08:14:11.547255Z	108902 Connect	temp_test@192.168.0.20 on consistency_db using TCP/IP
		2020-10-21T08:14:11.547510Z	108902 Query	SET autocommit=true
		2020-10-21T08:14:11.547625Z	108902 Query	SET NAMES utf8mb4
		2020-10-21T08:14:11.547753Z	108902 Query	select hint, value from `consistency_db`.`_t_20201021_ghc` where hint = 'heartbeat' and id <= 255
		2020-10-21T08:14:11.548914Z	108902 Query	show global status like 'Threads_running'
		2020-10-21T08:14:11.550232Z	108902 Query	show global status like 'Threads_running'
		2020-10-21T08:14:11.553530Z	108902 Query	insert /* gh-ost */ into `consistency_db`.`_t_20201021_ghc`
						(id, hint, value)
					values
						(NULLIF(0, 0), 'copy iteration 1104 at 1603268051', 'Copy: 7176000/14659130 49.0%; Applied: 0; Backlog: 0/1000; Time: 7m30s(total), 7m30s(copy); streamer: mysql-bin.000266:948396773; Lag: 1.00s, State: migrating; ETA: 7m49s')
					on duplicate key update
						last_update=NOW(),
						value=VALUES(value)
		2020-10-21T08:14:12.474841Z	108900 Query	COMMIT
		2020-10-21T08:14:12.544068Z	108901 Query	insert /* gh-ost */ into `consistency_db`.`_t_20201021_ghc`
						(id, hint, value)
					values
						(NULLIF(1, 0), 'heartbeat', '2020-10-21T16:14:12.543693537+08:00')
					on duplicate key update
						last_update=NOW(),
						value=VALUES(value)
		2020-10-21T08:14:12.546847Z	108902 Query	select hint, value from `consistency_db`.`_t_20201021_ghc` where hint = 'heartbeat' and id <= 255
		2020-10-21T08:14:12.548993Z	108902 Query	show global status like 'Threads_running'
		2020-10-21T08:14:12.550613Z	108902 Query	show global status like 'Threads_running'
		2020-10-21T08:14:12.598393Z	108902 Query	select  /* gh-ost `consistency_db`.`t_20201021` iteration:1105 */
								`id`
							from
								`consistency_db`.`t_20201021`
							where ((`id` > _binary'7182500')) and ((`id` < _binary'15000000') or ((`id` = _binary'15000000')))
							order by
								`id` asc
							limit 1
							offset 6499
		2020-10-21T08:14:12.608644Z	108900 Query	START TRANSACTION
		2020-10-21T08:14:12.609064Z	108900 Query	SET SESSION time_zone = 'SYSTEM', sql_mode = CONCAT(@@session.sql_mode, ',,NO_AUTO_VALUE_ON_ZERO,STRICT_ALL_TABLES')
		2020-10-21T08:14:12.609428Z	108900 Query	insert /* gh-ost `consistency_db`.`t_20201021` */ ignore into `consistency_db`.`_t_20201021_gho` (`id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createTime`)
			  (select `id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createTime` from `consistency_db`.`t_20201021` force index (`PRIMARY`)
				where (((`id` > _binary'7182500')) and ((`id` < _binary'7189000') or ((`id` = _binary'7189000')))) lock in share mode
			  )
		2020-10-21T08:14:13.543975Z	108902 Query	insert /* gh-ost */ into `consistency_db`.`_t_20201021_ghc`
						(id, hint, value)
					values
						(NULLIF(1, 0), 'heartbeat', '2020-10-21T16:14:13.543677668+08:00')
					on duplicate key update
						last_update=NOW(),
						value=VALUES(value)
		2020-10-21T08:14:13.546898Z	108901 Query	select hint, value from `consistency_db`.`_t_20201021_ghc` where hint = 'heartbeat' and id <= 255
		2020-10-21T08:14:13.548981Z	108901 Query	show global status like 'Threads_running'
		2020-10-21T08:14:13.550463Z	108901 Query	show global status like 'Threads_running'
		2020-10-21T08:14:14.544036Z	108901 Query	insert /* gh-ost */ into `consistency_db`.`_t_20201021_ghc`
						(id, hint, value)
					values
						(NULLIF(1, 0), 'heartbeat', '2020-10-21T16:14:14.543692754+08:00')
					on duplicate key update
						last_update=NOW(),
						value=VALUES(value)
		2020-10-21T08:14:14.546890Z	108902 Query	select hint, value from `consistency_db`.`_t_20201021_ghc` where hint = 'heartbeat' and id <= 255
		2020-10-21T08:14:14.549543Z	108903 Connect	temp_test@192.168.0.20 on consistency_db using TCP/IP
		2020-10-21T08:14:14.549772Z	108903 Query	SET autocommit=true
		2020-10-21T08:14:14.549882Z	108903 Query	SET NAMES utf8mb4
		2020-10-21T08:14:14.549985Z	108903 Query	show global status like 'Threads_running'
		2020-10-21T08:14:14.551371Z	108903 Query	show global status like 'Threads_running'
		2020-10-21T08:14:14.612743Z	108901 Quit	
		2020-10-21T08:14:14.836373Z	108900 Query	COMMIT
		2020-10-21T08:14:14.899566Z	108903 Query	select  /* gh-ost `consistency_db`.`t_20201021` iteration:1106 */
								`id`
							from
								`consistency_db`.`t_20201021`
							where ((`id` > _binary'7189000')) and ((`id` < _binary'15000000') or ((`id` = _binary'15000000')))
							order by
								`id` asc
							limit 1
							offset 6499
		2020-10-21T08:14:14.901182Z	108900 Quit	
		2020-10-21T08:14:14.915733Z	108902 Query	START TRANSACTION
		2020-10-21T08:14:14.916267Z	108902 Query	SET SESSION time_zone = 'SYSTEM', sql_mode = CONCAT(@@session.sql_mode, ',,NO_AUTO_VALUE_ON_ZERO,STRICT_ALL_TABLES')
		2020-10-21T08:14:14.916681Z	108902 Query	insert /* gh-ost `consistency_db`.`t_20201021` */ ignore into `consistency_db`.`_t_20201021_gho` (`id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createTime`)
			  (select `id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createTime` from `consistency_db`.`t_20201021` force index (`PRIMARY`)
				where (((`id` > _binary'7189000')) and ((`id` < _binary'7195500') or ((`id` = _binary'7195500')))) lock in share mode
			  )
		2020-10-21T08:14:15.543957Z	108903 Query	insert /* gh-ost */ into `consistency_db`.`_t_20201021_ghc`
						(id, hint, value)
					values
						(NULLIF(1, 0), 'heartbeat', '2020-10-21T16:14:15.543647342+08:00')
					on duplicate key update
						last_update=NOW(),
						value=VALUES(value)
		2020-10-21T08:14:15.547233Z	108904 Connect	temp_test@192.168.0.20 on consistency_db using TCP/IP
		2020-10-21T08:14:15.547457Z	108904 Query	SET autocommit=true
		2020-10-21T08:14:15.547585Z	108904 Query	SET NAMES utf8mb4
		2020-10-21T08:14:15.547812Z	108904 Query	select hint, value from `consistency_db`.`_t_20201021_ghc` where hint = 'heartbeat' and id <= 255
		2020-10-21T08:14:15.548976Z	108904 Query	show global status like 'Threads_running'
		2020-10-21T08:14:15.550380Z	108904 Query	show global status like 'Threads_running'
		2020-10-21T08:14:15.681775Z	94857 Query	call pr_third_query_order('10458637262352250557578test12010',@nAmount,@nStatus,@returnVal,@returnMsg);
		2020-10-21T08:14:15.682407Z	94857 Query	select @nAmount,@nStatus,@returnVal,@returnMsg
		2020-10-21T08:14:16.544036Z	108904 Query	insert /* gh-ost */ into `consistency_db`.`_t_20201021_ghc`
						(id, hint, value)
					values
						(NULLIF(1, 0), 'heartbeat', '2020-10-21T16:14:16.54369557+08:00')
					on duplicate key update
						last_update=NOW(),
						value=VALUES(value)
		2020-10-21T08:14:16.546868Z	108903 Query	select hint, value from `consistency_db`.`_t_20201021_ghc` where hint = 'heartbeat' and id <= 255
		2020-10-21T08:14:16.549379Z	108905 Connect	temp_test@192.168.0.20 on consistency_db using TCP/IP
		2020-10-21T08:14:16.549593Z	108905 Query	SET autocommit=true
		2020-10-21T08:14:16.549707Z	108905 Query	SET NAMES utf8mb4
		2020-10-21T08:14:16.549827Z	108905 Query	show global status like 'Threads_running'
		2020-10-21T08:14:16.551366Z	108905 Query	show global status like 'Threads_running'
		2020-10-21T08:14:16.594875Z	108904 Quit	
		2020-10-21T08:14:16.860102Z	108902 Query	COMMIT
		2020-10-21T08:14:16.862455Z	94838 Query	call pr_get_agent_key('10426',@deskey,@md5key,@msg,@rval);
		2020-10-21T08:14:16.862953Z	94838 Query	select @deskey,@md5key,@msg,@rval
		2020-10-21T08:14:16.981372Z	108905 Query	select  /* gh-ost `consistency_db`.`t_20201021` iteration:1107 */
								`id`
							from
								`consistency_db`.`t_20201021`
							where ((`id` > _binary'7195500')) and ((`id` < _binary'15000000') or ((`id` = _binary'15000000')))
							order by
								`id` asc
							limit 1
							offset 6499
		2020-10-21T08:14:16.981833Z	108902 Quit	
		2020-10-21T08:14:16.994478Z	108903 Query	START TRANSACTION
		2020-10-21T08:14:16.994802Z	108903 Query	SET SESSION time_zone = 'SYSTEM', sql_mode = CONCAT(@@session.sql_mode, ',,NO_AUTO_VALUE_ON_ZERO,STRICT_ALL_TABLES')
		2020-10-21T08:14:16.995132Z	108903 Query	insert /* gh-ost `consistency_db`.`t_20201021` */ ignore into `consistency_db`.`_t_20201021_gho` (`id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createTime`)
			  (select `id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createTime` from `consistency_db`.`t_20201021` force index (`PRIMARY`)
				where (((`id` > _binary'7195500')) and ((`id` < _binary'7202000') or ((`id` = _binary'7202000')))) lock in share mode
			  )
		2020-10-21T08:14:17.050714Z	94839 Query	call pr_get_agent_key('10420',@deskey,@md5key,@msg,@rval);
		2020-10-21T08:14:17.051476Z	94839 Query	select @deskey,@md5key,@msg,@rval
		2020-10-21T08:14:17.544100Z	108905 Query	insert /* gh-ost */ into `consistency_db`.`_t_20201021_ghc`
						(id, hint, value)
					values
						(NULLIF(1, 0), 'heartbeat', '2020-10-21T16:14:17.543712204+08:00')
					on duplicate key update
						last_update=NOW(),
						value=VALUES(value)
		2020-10-21T08:14:17.547148Z	108906 Connect	temp_test@192.168.0.20 on consistency_db using TCP/IP
		2020-10-21T08:14:17.547395Z	108906 Query	SET autocommit=true
		2020-10-21T08:14:17.547575Z	108906 Query	SET NAMES utf8mb4
		2020-10-21T08:14:17.547788Z	108906 Query	select hint, value from `consistency_db`.`_t_20201021_ghc` where hint = 'heartbeat' and id <= 255
		2020-10-21T08:14:17.548961Z	108906 Query	show global status like 'Threads_running'
		2020-10-21T08:14:17.550367Z	108906 Query	show global status like 'Threads_running'
		2020-10-21T08:14:18.544048Z	108906 Query	insert /* gh-ost */ into `consistency_db`.`_t_20201021_ghc`
						(id, hint, value)
					values
						(NULLIF(1, 0), 'heartbeat', '2020-10-21T16:14:18.543697685+08:00')
					on duplicate key update
						last_update=NOW(),
						value=VALUES(value)
		2020-10-21T08:14:18.546897Z	108905 Query	select hint, value from `consistency_db`.`_t_20201021_ghc` where hint = 'heartbeat' and id <= 255
		2020-10-21T08:14:18.549008Z	108905 Query	show global status like 'Threads_running'
		2020-10-21T08:14:18.550473Z	108905 Query	show global status like 'Threads_running'
		2020-10-21T08:14:19.074291Z	108903 Query	COMMIT
		2020-10-21T08:14:19.150894Z	108903 Quit	
		2020-10-21T08:14:19.151252Z	108905 Query	select  /* gh-ost `consistency_db`.`t_20201021` iteration:1108 */
								`id`
							from
								`consistency_db`.`t_20201021`
							where ((`id` > _binary'7202000')) and ((`id` < _binary'15000000') or ((`id` = _binary'15000000')))
							order by
								`id` asc
							limit 1
							offset 6499
		2020-10-21T08:14:19.159818Z	108906 Query	START TRANSACTION
		2020-10-21T08:14:19.160117Z	108906 Query	SET SESSION time_zone = 'SYSTEM', sql_mode = CONCAT(@@session.sql_mode, ',,NO_AUTO_VALUE_ON_ZERO,STRICT_ALL_TABLES')
		2020-10-21T08:14:19.160497Z	108906 Query	insert /* gh-ost `consistency_db`.`t_20201021` */ ignore into `consistency_db`.`_t_20201021_gho` (`id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createTime`)
			  (select `id`, `name`, `age`, `ismale`, `id_card`, `test1`, `test2`, `createTime` from `consistency_db`.`t_20201021` force index (`PRIMARY`)
				where (((`id` > _binary'7202000')) and ((`id` < _binary'7208500') or ((`id` = _binary'7208500')))) lock in share mode
			  )

		-- 每次迁移 select 10883029-10876974 = 6499 记录。
		
		
drop user 'temp_test'@'%';