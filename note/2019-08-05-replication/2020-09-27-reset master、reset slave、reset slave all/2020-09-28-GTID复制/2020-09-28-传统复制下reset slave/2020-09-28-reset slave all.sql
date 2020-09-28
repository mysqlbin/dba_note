






mysql> show slave status\G;
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.0.201
                  Master_User: rpl
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000002
          Read_Master_Log_Pos: 696
               Relay_Log_File: localhost-relay-bin.000003
                Relay_Log_Pos: 686
        Relay_Master_Log_File: mysql-bin.000002
             Slave_IO_Running: Yes
            Slave_SQL_Running: Yes
              Replicate_Do_DB: 
          Replicate_Ignore_DB: 
           Replicate_Do_Table: 
       Replicate_Ignore_Table: 
      Replicate_Wild_Do_Table: 
  Replicate_Wild_Ignore_Table: 
                   Last_Errno: 0
                   Last_Error: 
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 696
              Relay_Log_Space: 897
              Until_Condition: None
               Until_Log_File: 
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File: 
           Master_SSL_CA_Path: 
              Master_SSL_Cert: 
            Master_SSL_Cipher: 
               Master_SSL_Key: 
        Seconds_Behind_Master: 0
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error: 
               Last_SQL_Errno: 0
               Last_SQL_Error: 
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 330607
                  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
             Master_Info_File: mysql.slave_master_info
                    SQL_Delay: 0
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
           Master_Retry_Count: 86400
                  Master_Bind: 
      Last_IO_Error_Timestamp: 
     Last_SQL_Error_Timestamp: 
               Master_SSL_Crl: 
           Master_SSL_Crlpath: 
           Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:2
            Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-2
                Auto_Position: 1
         Replicate_Rewrite_DB: 
                 Channel_Name: 
           Master_TLS_Version: 
1 row in set (0.00 sec)


mysql> select * from mysql.gtid_executed;
+--------------------------------------+----------------+--------------+
| source_uuid                          | interval_start | interval_end |
+--------------------------------------+----------------+--------------+
| 9e520b78-013c-11eb-a84c-0800271bf591 |              1 |            1 |
| 9e520b78-013c-11eb-a84c-0800271bf591 |              2 |            2 |
+--------------------------------------+----------------+--------------+
2 rows in set (0.00 sec)

mysql> show global variables  like '%gtid%';
+----------------------------------+------------------------------------------+
| Variable_name                    | Value                                    |
+----------------------------------+------------------------------------------+
| binlog_gtid_simple_recovery      | ON                                       |
| enforce_gtid_consistency         | ON                                       |
| gtid_executed                    | 9e520b78-013c-11eb-a84c-0800271bf591:1-2 |
| gtid_executed_compression_period | 1000                                     |
| gtid_mode                        | ON                                       |
| gtid_owned                       |                                          |
| gtid_purged                      | 9e520b78-013c-11eb-a84c-0800271bf591:1-2 |
| session_track_gtids              | OFF                                      |
+----------------------------------+------------------------------------------+
8 rows in set (0.00 sec)

mysql> select * from mysql.slave_master_info\G;
*************************** 1. row ***************************
       Number_of_lines: 25
       Master_log_name: mysql-bin.000002
        Master_log_pos: 424
                  Host: 192.168.0.201
             User_name: rpl
         User_password: 123546abc
                  Port: 3306
         Connect_retry: 60
           Enabled_ssl: 0
                Ssl_ca: 
            Ssl_capath: 
              Ssl_cert: 
            Ssl_cipher: 
               Ssl_key: 
Ssl_verify_server_cert: 0
             Heartbeat: 30
                  Bind: 
    Ignored_server_ids: 0
                  Uuid: 9e520b78-013c-11eb-a84c-0800271bf591
           Retry_count: 86400
               Ssl_crl: 
           Ssl_crlpath: 
 Enabled_auto_position: 1
          Channel_name: 
           Tls_version: 
1 row in set (0.00 sec)



mysql> select * from mysql.slave_relay_log_info\G;
*************************** 1. row ***************************
  Number_of_lines: 7
   Relay_log_name: ./localhost-relay-bin.000003
    Relay_log_pos: 686
  Master_log_name: mysql-bin.000002
   Master_log_pos: 696
        Sql_delay: 0
Number_of_workers: 0
               Id: 1
     Channel_name: 
1 row in set (0.00 sec)


reset slave all


mysql> stop slave;
Query OK, 0 rows affected (0.00 sec)

mysql> reset slave all;
Query OK, 0 rows affected (0.03 sec)

mysql> 
mysql> 
mysql> 
mysql> 
mysql> 
mysql> 
mysql> 
mysql> 
mysql> 
mysql> 
mysql> show slave status\G;
Empty set (0.00 sec)

ERROR: 
No query specified

mysql> select * from mysql.gtid_executed;
+--------------------------------------+----------------+--------------+
| source_uuid                          | interval_start | interval_end |
+--------------------------------------+----------------+--------------+
| 9e520b78-013c-11eb-a84c-0800271bf591 |              1 |            1 |
| 9e520b78-013c-11eb-a84c-0800271bf591 |              2 |            2 |
+--------------------------------------+----------------+--------------+
2 rows in set (0.00 sec)

mysql> show global variables  like '%gtid%';
+----------------------------------+------------------------------------------+
| Variable_name                    | Value                                    |
+----------------------------------+------------------------------------------+
| binlog_gtid_simple_recovery      | ON                                       |
| enforce_gtid_consistency         | ON                                       |
| gtid_executed                    | 9e520b78-013c-11eb-a84c-0800271bf591:1-2 |
| gtid_executed_compression_period | 1000                                     |
| gtid_mode                        | ON                                       |
| gtid_owned                       |                                          |
| gtid_purged                      | 9e520b78-013c-11eb-a84c-0800271bf591:1-2 |
| session_track_gtids              | OFF                                      |
+----------------------------------+------------------------------------------+
8 rows in set (0.00 sec)

mysql> select * from mysql.slave_master_info\G;
Empty set (0.00 sec)


mysql> select * from mysql.slave_relay_log_info\G;
Empty set (0.00 sec)



修复：
	
	master:
		mysql> INSERT INTO `test_db`.`t` (`id`, `c`, `d`) VALUES ('9', '9', '9');
		Query OK, 1 row affected (0.01 sec)

		mysql> select * from t;
		+----+------+------+
		| id | c    | d    |
		+----+------+------+
		|  1 |    1 |    1 |
		|  2 |    2 |    2 |
		|  3 |    3 |    3 |
		|  4 |    4 |    4 |
		|  5 |    5 |    5 |
		|  6 |    6 |    6 |
		|  7 |    7 |    7 |
		|  8 |    8 |    8 |
		|  9 |    9 |    9 |
		+----+------+------+
		9 rows in set (0.00 sec)

		mysql> show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000002
				 Position: 968
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-3
		1 row in set (0.00 sec)

	

	slave
		
		mysql> CHANGE MASTER TO MASTER_HOST='192.168.0.201',MASTER_USER='rpl',MASTER_PASSWORD='123546abc',master_auto_position=1;
		Query OK, 0 rows affected, 2 warnings (0.03 sec)

		mysql> start slave;
		Query OK, 0 rows affected (0.07 sec)

		mysql> show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: Waiting for master to send event
						  Master_Host: 192.168.0.201
						  Master_User: rpl
						  Master_Port: 3306
						Connect_Retry: 60
					  Master_Log_File: mysql-bin.000002
				  Read_Master_Log_Pos: 968
					   Relay_Log_File: localhost-relay-bin.000002
						Relay_Log_Pos: 686
				Relay_Master_Log_File: mysql-bin.000002
					 Slave_IO_Running: Yes
					Slave_SQL_Running: Yes
					  Replicate_Do_DB: 
				  Replicate_Ignore_DB: 
				   Replicate_Do_Table: 
			   Replicate_Ignore_Table: 
			  Replicate_Wild_Do_Table: 
		  Replicate_Wild_Ignore_Table: 
						   Last_Errno: 0
						   Last_Error: 
						 Skip_Counter: 0
				  Exec_Master_Log_Pos: 968
					  Relay_Log_Space: 897
					  Until_Condition: None
					   Until_Log_File: 
						Until_Log_Pos: 0
				   Master_SSL_Allowed: No
				   Master_SSL_CA_File: 
				   Master_SSL_CA_Path: 
					  Master_SSL_Cert: 
					Master_SSL_Cipher: 
					   Master_SSL_Key: 
				Seconds_Behind_Master: 0
		Master_SSL_Verify_Server_Cert: No
						Last_IO_Errno: 0
						Last_IO_Error: 
					   Last_SQL_Errno: 0
					   Last_SQL_Error: 
		  Replicate_Ignore_Server_Ids: 
					 Master_Server_Id: 330607
						  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
					 Master_Info_File: mysql.slave_master_info
							SQL_Delay: 0
				  SQL_Remaining_Delay: NULL
			  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
				   Master_Retry_Count: 86400
						  Master_Bind: 
			  Last_IO_Error_Timestamp: 
			 Last_SQL_Error_Timestamp: 
					   Master_SSL_Crl: 
				   Master_SSL_Crlpath: 
				   Retrieved_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:3
					Executed_Gtid_Set: 9e520b78-013c-11eb-a84c-0800271bf591:1-3
						Auto_Position: 1
				 Replicate_Rewrite_DB: 
						 Channel_Name: 
				   Master_TLS_Version: 
		1 row in set (0.00 sec)

		
		mysql> select * from test_db.t;
		+----+------+------+
		| id | c    | d    |
		+----+------+------+
		|  1 |    1 |    1 |
		|  2 |    2 |    2 |
		|  3 |    3 |    3 |
		|  4 |    4 |    4 |
		|  5 |    5 |    5 |
		|  6 |    6 |    6 |
		|  7 |    7 |    7 |
		|  8 |    8 |    8 |
		|  9 |    9 |    9 |
		+----+------+------+
		9 rows in set (0.00 sec)




