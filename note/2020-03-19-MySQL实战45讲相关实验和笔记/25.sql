

  
use test_20191101;
show create table t1;


MySQL Server层的MDL锁造成的延迟
主库											从库
												session 1;
												begin; 
												root@mysqldb 02:24:  [test_20191101]> select * from t1 limit 1;
												+------+
												| a    |
												+------+
												|    1 |
												+------+
												1 row in set (0.00 sec)
												
												root@mysqldb 02:23:  [(none)]> select * from information_schema.innodb_trx\G;
												*************************** 1. row ***************************
																	trx_id: 421884146676896
																 trx_state: RUNNING
															   trx_started: 2020-01-08 02:24:14
													 trx_requested_lock_id: NULL
														  trx_wait_started: NULL
																trx_weight: 0
													   trx_mysql_thread_id: 28
																 trx_query: NULL
													   trx_operation_state: NULL
														 trx_tables_in_use: 0
														 trx_tables_locked: 0
														  trx_lock_structs: 0
													 trx_lock_memory_bytes: 1136
														   trx_rows_locked: 0
														 trx_rows_modified: 0
												   trx_concurrency_tickets: 0
													   trx_isolation_level: REPEATABLE READ
														 trx_unique_checks: 1
													trx_foreign_key_checks: 1
												trx_last_foreign_key_error: NULL
												 trx_adaptive_hash_latched: 0
												 trx_adaptive_hash_timeout: 0
														  trx_is_read_only: 0
												trx_autocommit_non_locking: 0
												1 row in set (0.00 sec)
												
												root@mysqldb 02:24:  [(none)]> show full processlist;
												+----+-----------------+-----------------+---------------+---------+-------+--------------------------------------------------------+-----------------------+
												| Id | User            | Host            | db            | Command | Time  | State                                                  | Info                  |
												+----+-----------------+-----------------+---------------+---------+-------+--------------------------------------------------------+-----------------------+
												|  4 | event_scheduler | localhost       | NULL          | Daemon  | 79910 | Waiting on empty queue                                 | NULL                  |
												|  5 | system user     |                 | NULL          | Query   | -2347 | Slave has read all relay log; waiting for more updates | NULL                  |
												|  8 | system user     | connecting host | NULL          | Connect | 79910 | Waiting for master to send event                       | NULL                  |
												| 10 | root            | localhost       | NULL          | Query   |     0 | starting                                               | show full processlist |
												| 28 | root            | localhost       | test_20191101 | Sleep   |    60 |                                                        | NULL                  |
												+----+-----------------+-----------------+---------------+---------+-------+--------------------------------------------------------+-----------------------+
												5 rows in set (0.00 sec)

session 2
															
mysql> alter table t1 add column b int(11) not null;
Query OK, 0 rows affected, 1 warning (0.21 sec)
Records: 0  Duplicates: 0  Warnings: 1



												mysql> show slave status\G;
												*************************** 1. row ***************************
															   Slave_IO_State: Waiting for master to send event
																  Master_Host: 192.168.0.91
																  Master_User: keepalived
																  Master_Port: 3306
																Connect_Retry: 60
															  Master_Log_File: mysql-bin.000006
														  Read_Master_Log_Pos: 951
															   Relay_Log_File: kp05-relay-bin.000009
																Relay_Log_Pos: 858
														Relay_Master_Log_File: mysql-bin.000006
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
														  Exec_Master_Log_Pos: 732
															  Relay_Log_Space: 1482
															  Until_Condition: None
															   Until_Log_File: 
																Until_Log_Pos: 0
														   Master_SSL_Allowed: No
														   Master_SSL_CA_File: 
														   Master_SSL_CA_Path: 
															  Master_SSL_Cert: 
															Master_SSL_Cipher: 
															   Master_SSL_Key: 
														Seconds_Behind_Master: 22
												Master_SSL_Verify_Server_Cert: No
																Last_IO_Errno: 0
																Last_IO_Error: 
															   Last_SQL_Errno: 0
															   Last_SQL_Error: 
												  Replicate_Ignore_Server_Ids: 
															 Master_Server_Id: 330691
																  Master_UUID: 48c3fa1e-06a6-11ea-a25d-0800275219f4
															 Master_Info_File: mysql.slave_master_info
																	SQL_Delay: 0
														  SQL_Remaining_Delay: NULL
													  Slave_SQL_Running_State: Waiting for table metadata lock
														   Master_Retry_Count: 86400
																  Master_Bind: 
													  Last_IO_Error_Timestamp: 
													 Last_SQL_Error_Timestamp: 
															   Master_SSL_Crl: 
														   Master_SSL_Crlpath: 
														   Retrieved_Gtid_Set: 48c3fa1e-06a6-11ea-a25d-0800275219f4:62-64
															Executed_Gtid_Set: 48c3fa1e-06a6-11ea-a25d-0800275219f4:1-63,
												bebc6d54-fc75-11e9-8ea8-080027e2e489:1-13,
												e136faa2-eeab-11e9-9494-080027cb3816:1-14
																Auto_Position: 1
														 Replicate_Rewrite_DB: 
																 Channel_Name: 
														   Master_TLS_Version: 
													   Master_public_key_path: 
														Get_master_public_key: 0
															Network_Namespace: 
												1 row in set (0.00 sec)

												ERROR: 
												No query specified

slave:
mysql> show processlist;
+----+-----------------+-----------------+---------------+---------+----------+----------------------------------+----------------------------------------------+
| Id | User            | Host            | db            | Command | Time     | State                            | Info                                         |
+----+-----------------+-----------------+---------------+---------+----------+----------------------------------+----------------------------------------------+
|  4 | event_scheduler | localhost       | NULL          | Daemon  |    80026 | Waiting on empty queue           | NULL                                         |
|  5 | system user     |                 | test_20191101 | Query   | -1844672 | Waiting for table metadata lock  | alter table t1 add column b int(11) not null |
|  8 | system user     | connecting host | NULL          | Connect |    80026 | Waiting for master to send event | NULL                                         |
| 10 | root            | localhost       | NULL          | Query   |        0 | starting                         | show processlist                             |
| 28 | root            | localhost       | test_20191101 | Sleep   |      176 |                                  | NULL                                         |
+----+-----------------+-----------------+---------------+---------+----------+----------------------------------+----------------------------------------------+
5 rows in set (0.00 sec)


