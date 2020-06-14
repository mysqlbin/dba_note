
	

手动修改从库系统时间，导致 seconds_behind_master 为 0

	初始化表结构和数据：
		root@mysqldb 12:12:  [test_20191101]> select version();
		+-----------+
		| version() |
		+-----------+
		| 8.0.18    |
		+-----------+
		1 row in set (0.00 sec)


		CREATE TABLE `t3` (
		  `id` int(11) NOT NULL AUTO_INCREMENT,
		  `a` int(11) DEFAULT NULL,
		  `b` int(11) DEFAULT NULL,
		  `c` int(11) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `a` (`a`)
		) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

			
		delimiter ;;
		create procedure idata()
		begin
		  declare i int;
		  set i=1;
		  while(i<=740000)do
			insert into t3 values(i, i, i, i);
			set i=i+1;
		  end while;
		end;;
		delimiter ;
		call idata();


		mysql>  select count(*) from t3;
		+----------+
		| count(*) |
		+----------+
		|   740000 |
		+----------+
		1 row in set (0.31 sec)

	master:
		
		mysql> update t3 set a=1;
		Query OK, 739870 rows affected (12.00 sec)
		Rows matched: 740000  Changed: 739870  Warnings: 0


	slave:
		1. show slave status\G
		mysql> show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: Waiting for master to send event
					  Master_Log_File: mysql-bin.000006
				  Read_Master_Log_Pos: 64798485
					   Relay_Log_File: kp05-relay-bin.000002
						Relay_Log_Pos: 39541681
				Relay_Master_Log_File: mysql-bin.000006
					 Slave_IO_Running: Yes
					Slave_SQL_Running: Yes
				  Exec_Master_Log_Pos: 39543996
					  Relay_Log_Space: 64796369
				Seconds_Behind_Master: 27
						  Master_UUID: 48c3fa1e-06a6-11ea-a25d-0800275219f4
					 Master_Info_File: mysql.slave_master_info
							SQL_Delay: 0
				  SQL_Remaining_Delay: NULL
			  Slave_SQL_Running_State: Applying batch of row changes (update)
				   Master_Retry_Count: 86400
				   Retrieved_Gtid_Set: 48c3fa1e-06a6-11ea-a25d-0800275219f4:71-100143
					Executed_Gtid_Set: 48c3fa1e-06a6-11ea-a25d-0800275219f4:1-100142,
		bebc6d54-fc75-11e9-8ea8-080027e2e489:1-13,
		e136faa2-eeab-11e9-9494-080027cb3816:1-14
						Auto_Position: 1

		1 row in set (0.00 sec)

		ERROR: 
		No query specified



		2. 手动修改从库系统时间
			[root@kp05 ~]# date
			Wed Jan  8 04:09:11 CST 2020
			[root@kp05 ~]# 
			[root@kp05 ~]# date -s 01:00:00
			Wed Jan  8 01:00:00 CST 2020

		3. show slave status\G
		mysql> show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: Waiting for master to send event
		
					  Master_Log_File: mysql-bin.000006
				  Read_Master_Log_Pos: 64798485
					   Relay_Log_File: kp05-relay-bin.000002
						Relay_Log_Pos: 39541681
				Relay_Master_Log_File: mysql-bin.000006
					 Slave_IO_Running: Yes
					Slave_SQL_Running: Yes
				  Exec_Master_Log_Pos: 39543996
					  Relay_Log_Space: 64796369
				Seconds_Behind_Master: 0
					 Master_Info_File: mysql.slave_master_info
							SQL_Delay: 0
				  SQL_Remaining_Delay: NULL
			  Slave_SQL_Running_State: Applying batch of row changes (update)
				   Master_Retry_Count: 86400
				   Retrieved_Gtid_Set: 48c3fa1e-06a6-11ea-a25d-0800275219f4:71-100143
					Executed_Gtid_Set: 48c3fa1e-06a6-11ea-a25d-0800275219f4:1-100142,
		bebc6d54-fc75-11e9-8ea8-080027e2e489:1-13,
		e136faa2-eeab-11e9-9494-080027cb3816:1-14
						Auto_Position: 1
		1 row in set (0.01 sec)

		ERROR: 
		No query specified

		mysql> show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: Waiting for master to send event
					  Master_Log_File: mysql-bin.000006
				  Read_Master_Log_Pos: 64798485
					   Relay_Log_File: kp05-relay-bin.000002
						Relay_Log_Pos: 39541681
				Relay_Master_Log_File: mysql-bin.000006
					 Slave_IO_Running: Yes
					Slave_SQL_Running: Yes
				  Exec_Master_Log_Pos: 39543996
					  Relay_Log_Space: 64796369
					   Master_SSL_Key: 
				Seconds_Behind_Master: 0
						  Master_UUID: 48c3fa1e-06a6-11ea-a25d-0800275219f4
					 Master_Info_File: mysql.slave_master_info
							SQL_Delay: 0
				  SQL_Remaining_Delay: NULL
			  Slave_SQL_Running_State: waiting for handler commit
				   Master_Retry_Count: 86400
				   Retrieved_Gtid_Set: 48c3fa1e-06a6-11ea-a25d-0800275219f4:71-100143
					Executed_Gtid_Set: 48c3fa1e-06a6-11ea-a25d-0800275219f4:1-100142,
		bebc6d54-fc75-11e9-8ea8-080027e2e489:1-13,
		e136faa2-eeab-11e9-9494-080027cb3816:1-14

		1 row in set (0.00 sec)

		
		IO 线程： 
			    Master_Log_File: mysql-bin.000006
			Read_Master_Log_Pos：64798485
			
		SQL 线程：
			Relay_Master_Log_File: mysql-bin.000006
			Exec_Master_Log_Pos: 39543996
		
		差值：select 64798485 - 39543996 = 25254489;
			
		
		GTID的差值：select 100143 - 100142 = 1; 表示SQL线程还有一个事务没有执行完成。

				
			
