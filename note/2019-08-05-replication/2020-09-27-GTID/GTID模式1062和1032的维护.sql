


1. 1032
2. 1062


master host
[root@123456abc-05 data]# cat auto.cnf 
[auto]
server-uuid=64f06970-098a-11e9-aee6-00163e020f37


slave host: 
[root@123456abc-06 data]# cat auto.cnf 
[auto]
server-uuid=53ebf01e-bbec-11e8-9a62-00163e087d10


2. 1062

	主库
		mysql> show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000255
				 Position: 747
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: 64f06970-098a-11e9-aee6-00163e020f37:1-2
		1 row in set (0.00 sec)

	从库
		mysql> show slave status\G;
		*************************** 1. row ***************************
				   Retrieved_Gtid_Set: 64f06970-098a-11e9-aee6-00163e020f37:1-2
					Executed_Gtid_Set: 64f06970-098a-11e9-aee6-00163e020f37:1-2
						Auto_Position: 1
		1 row in set (0.00 sec)

		slave:
			
		mysql> show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000171
				 Position: 747
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: 64f06970-098a-11e9-aee6-00163e020f37:1-2
		1 row in set (0.00 sec)


		INSERT INTO `sbtest`.`sbtest1` (`id`, `k`, `c`, `pad`) VALUES ('1', '501885', '08566691963-88624912351-16662227201-46648573979-64646226163-77505759394-75470094713-41097360717-15161106334-50535565977', '63188288836-92351140030-06390587585-66802097351-49282961843');

		mysql> show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000171
				 Position: 1644
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: 53ebf01e-bbec-11e8-9a62-00163e087d10:1,
		64f06970-098a-11e9-aee6-00163e020f37:1-3
		1 row in set (0.00 sec)

	主库：

		INSERT INTO `sbtest`.`sbtest1` (`id`, `k`, `c`, `pad`) VALUES ('1', '501885', '08566691963-88624912351-16662227201-46648573979-64646226163-77505759394-75470094713-41097360717-15161106334-50535565977', '63188288836-92351140030-06390587585-66802097351-49282961843');



	从库:
		mysql> show slave status\G;
		*************************** 1. row ***************************
					   
					   Last_SQL_Errno: 1062
					   Last_SQL_Error: Coordinator stopped because there were error(s) in the worker(s). The most recent failure being: Worker 1 failed executing transaction '64f06970-098a-11e9-aee6-00163e020f37:4' at master log mysql-bin.000255, end_log_pos 1624. See error log and/or performance_schema.replication_applier_status_by_worker table for more details about this failure or others, if any.
		  Replicate_Ignore_Server_Ids: 

						  Master_UUID: 64f06970-098a-11e9-aee6-00163e020f37
					 Master_Info_File: mysql.slave_master_info
			  
				   Retrieved_Gtid_Set: 64f06970-098a-11e9-aee6-00163e020f37:1-4
					Executed_Gtid_Set: 53ebf01e-bbec-11e8-9a62-00163e087d10:1,
		64f06970-098a-11e9-aee6-00163e020f37:1-3
						Auto_Position: 1

		1 row in set (0.00 sec)

		ERROR: 
		No query specified

	解决办法

		跳过一个GTID:

			Executed_Gtid_Set: 53ebf01e-bbec-11e8-9a62-00163e087d10:1,
			64f06970-098a-11e9-aee6-00163e020f37:1-3
			可以看到, 已经执行到 事务编号为3的事务了, 所以跳过编号为4的事务


			set gtid_next='64f06970-098a-11e9-aee6-00163e020f37:4';
			begin;commit;
			set gtid_next='automatic';
			start slave;;


		
		
		
		
		
		
