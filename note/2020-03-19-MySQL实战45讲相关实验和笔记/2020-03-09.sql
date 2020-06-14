



session a
begin;
delete from t1 where a=1;
commit;   -- 10分钟后提交事务



root@mysqldb 11:17:  [(none)]>  select * from information_schema.innodb_trx\G;
*************************** 1. row ***************************
                    trx_id: 6977
                 trx_state: RUNNING
               trx_started: 2020-01-29 11:16:07
     trx_requested_lock_id: NULL
          trx_wait_started: NULL
                trx_weight: 3
       trx_mysql_thread_id: 162
                 trx_query: NULL
       trx_operation_state: NULL
         trx_tables_in_use: 0
         trx_tables_locked: 1
          trx_lock_structs: 2
     trx_lock_memory_bytes: 1136
           trx_rows_locked: 8
         trx_rows_modified: 1
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
  while(i<=100000)do
	insert into t3 values(i, i, i, i);
	set i=i+1;
  end while;
end;;
delimiter ;
call idata();


INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 100000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;


INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;



INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;



INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;
INSERT INTO `test_20191101`.`t3` (`a`, `b`, `c`) select `a`, `b`, `c` from t3 limit 10000;




root@mysqldb 04:02:  [test_20191101]> show slave status\G;
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.0.91
                  Master_User: keepalived
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000006
          Read_Master_Log_Pos: 39541085
               Relay_Log_File: kp05-relay-bin.000002
                Relay_Log_Pos: 24646752
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
          Exec_Master_Log_Pos: 24649067
              Relay_Log_Space: 39538969
              Until_Condition: None
               Until_Log_File: 
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File: 
           Master_SSL_CA_Path: 
              Master_SSL_Cert: 
            Master_SSL_Cipher: 
               Master_SSL_Key: 
        Seconds_Behind_Master: 214
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
      Slave_SQL_Running_State: waiting for handler commit
           Master_Retry_Count: 86400
                  Master_Bind: 
      Last_IO_Error_Timestamp: 
     Last_SQL_Error_Timestamp: 
               Master_SSL_Crl: 
           Master_SSL_Crlpath: 
           Retrieved_Gtid_Set: 48c3fa1e-06a6-11ea-a25d-0800275219f4:71-100139
            Executed_Gtid_Set: 48c3fa1e-06a6-11ea-a25d-0800275219f4:1-86246,
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

root@mysqldb 04:02:  [test_20191101]> show processlist;
+----+-----------------+-----------------+---------------+---------+----------+----------------------------------+------------------+
| Id | User            | Host            | db            | Command | Time     | State                            | Info             |
+----+-----------------+-----------------+---------------+---------+----------+----------------------------------+------------------+
|  4 | event_scheduler | localhost       | NULL          | Daemon  |     1865 | Waiting on empty queue           | NULL             |
| 83 | root            | localhost       | test_20191101 | Sleep   |      599 |                                  | NULL             |
| 84 | root            | localhost       | test_20191101 | Query   |        0 | starting                         | show processlist |
| 85 | system user     | connecting host | NULL          | Connect |      568 | Waiting for master to send event | NULL             |
| 86 | system user     |                 | NULL          | Query   | -1844525 | waiting for handler commit       | NULL             |
+----+-----------------+-----------------+---------------+---------+----------+----------------------------------+------------------+
5 rows in set (0.00 sec)



root@mysqldb 12:20:  [test_20191101]>  select count(*) from t3;
+----------+
| count(*) |
+----------+
|   740000 |
+----------+
1 row in set (0.31 sec)


master:
	alter table t3 add column d int(11) not null;
	
	alter table t3 drop column d;

	update t3 set a=1;

date

date -s 01:00:00



root@mysqldb 04:09:  [test_20191101]> show slave status\G;
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.0.91
                  Master_User: keepalived
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000006
          Read_Master_Log_Pos: 64798485
               Relay_Log_File: kp05-relay-bin.000002
                Relay_Log_Pos: 39541681
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
          Exec_Master_Log_Pos: 39543996
              Relay_Log_Space: 64796369
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
             Master_Server_Id: 330691
                  Master_UUID: 48c3fa1e-06a6-11ea-a25d-0800275219f4
             Master_Info_File: mysql.slave_master_info
                    SQL_Delay: 0
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: Applying batch of row changes (update)
           Master_Retry_Count: 86400
                  Master_Bind: 
      Last_IO_Error_Timestamp: 
     Last_SQL_Error_Timestamp: 
               Master_SSL_Crl: 
           Master_SSL_Crlpath: 
           Retrieved_Gtid_Set: 48c3fa1e-06a6-11ea-a25d-0800275219f4:71-100143
            Executed_Gtid_Set: 48c3fa1e-06a6-11ea-a25d-0800275219f4:1-100142,
bebc6d54-fc75-11e9-8ea8-080027e2e489:1-13,
e136faa2-eeab-11e9-9494-080027cb3816:1-14
                Auto_Position: 1
         Replicate_Rewrite_DB: 
                 Channel_Name: 
           Master_TLS_Version: 
       Master_public_key_path: 
        Get_master_public_key: 0
            Network_Namespace: 
1 row in set (0.01 sec)

ERROR: 
No query specified

root@mysqldb 01:00:  [test_20191101]> show slave status\G;
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.0.91
                  Master_User: keepalived
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000006
          Read_Master_Log_Pos: 64798485
               Relay_Log_File: kp05-relay-bin.000002
                Relay_Log_Pos: 39541681
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
          Exec_Master_Log_Pos: 39543996
              Relay_Log_Space: 64796369
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
             Master_Server_Id: 330691
                  Master_UUID: 48c3fa1e-06a6-11ea-a25d-0800275219f4
             Master_Info_File: mysql.slave_master_info
                    SQL_Delay: 0
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: waiting for handler commit
           Master_Retry_Count: 86400
                  Master_Bind: 
      Last_IO_Error_Timestamp: 
     Last_SQL_Error_Timestamp: 
               Master_SSL_Crl: 
           Master_SSL_Crlpath: 
           Retrieved_Gtid_Set: 48c3fa1e-06a6-11ea-a25d-0800275219f4:71-100143
            Executed_Gtid_Set: 48c3fa1e-06a6-11ea-a25d-0800275219f4:1-100142,
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

root@mysqldb 01:00:  [test_20191101]> show slave status\G;
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.0.91
                  Master_User: keepalived
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000006
          Read_Master_Log_Pos: 64798485
               Relay_Log_File: kp05-relay-bin.000002
                Relay_Log_Pos: 64796170
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
          Exec_Master_Log_Pos: 64798485
              Relay_Log_Space: 64796369
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
             Master_Server_Id: 330691
                  Master_UUID: 48c3fa1e-06a6-11ea-a25d-0800275219f4
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
           Retrieved_Gtid_Set: 48c3fa1e-06a6-11ea-a25d-0800275219f4:71-100143
            Executed_Gtid_Set: 48c3fa1e-06a6-11ea-a25d-0800275219f4:1-100143,
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

root@mysqldb 01:00:  [test_20191101]> ^DBye
[root@kp05 ~]# 



[root@kp05 ~]# date
Wed Jan  8 04:09:11 CST 2020
[root@kp05 ~]# 
[root@kp05 ~]# date -s 01:00:00
Wed Jan  8 01:00:00 CST 2020

