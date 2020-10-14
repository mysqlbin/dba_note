

mysql> show slave status\G;
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.1.10
                  Master_User: repl_user
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000239
          Read_Master_Log_Pos: 77160655
               Relay_Log_File: db-b-relay-bin.000008
                Relay_Log_Pos: 76924523
        Relay_Master_Log_File: mysql-bin.000239
             Slave_IO_Running: Yes
            Slave_SQL_Running: No
              Replicate_Do_DB: 
          Replicate_Ignore_DB: 
           Replicate_Do_Table: 
       Replicate_Ignore_Table: 
      Replicate_Wild_Do_Table: 
  Replicate_Wild_Ignore_Table: 
                   Last_Errno: 1062
                   Last_Error: Could not execute Write_rows event on table niuniuh5_db.table_clubgoodsoperatlog; Duplicate entry '46' for key 'PRIMARY', Error_code: 1062; handler error HA_ERR_FOUND_DUPP_KEY; the event's master log mysql-bin.000239, end_log_pos 76925054
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 76924310
              Relay_Log_Space: 77162202
              Until_Condition: None
               Until_Log_File: 
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File: 
           Master_SSL_CA_Path: 
              Master_SSL_Cert: 
            Master_SSL_Cipher: 
               Master_SSL_Key: 
        Seconds_Behind_Master: NULL
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error: 
               Last_SQL_Errno: 1062
               Last_SQL_Error: Could not execute Write_rows event on table niuniuh5_db.table_clubgoodsoperatlog; Duplicate entry '46' for key 'PRIMARY', Error_code: 1062; handler error HA_ERR_FOUND_DUPP_KEY; the event's master log mysql-bin.000239, end_log_pos 76925054
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 1
                  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
             Master_Info_File: mysql.slave_master_info
                    SQL_Delay: 0
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: 
           Master_Retry_Count: 86400
                  Master_Bind: 
      Last_IO_Error_Timestamp: 
     Last_SQL_Error_Timestamp: 201014 15:28:56
               Master_SSL_Crl: 
           Master_SSL_Crlpath: 
           Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13797-1279459
            Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-1279139,
90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-523920
                Auto_Position: 1
         Replicate_Rewrite_DB: 
                 Channel_Name: 
           Master_TLS_Version: 
1 row in set (0.00 sec)

ERROR: 
No query specified


INSERT INTO `niuniuh5_db`.`table_clubgoodsoperatlog` (`ID`, `orderID`, `nClubID`, `nPlayerID`, `nGoodsID`, `num`, `AfterMbNum`, `CreateTime`, `nState`, `nOperatType`, `OpratAccount`, `nGameType`, `nServerID`, `ReMark`) VALUES ('47', '10457_1602581750728410_b', '10457', '91552', '1', '8', '16', '2020-10-13 17:35:51', '1', '1', '91552', '0', '0', '第三方加物品');
INSERT INTO `niuniuh5_db`.`table_clubgoodsoperatlog` (`ID`, `orderID`, `nClubID`, `nPlayerID`, `nGoodsID`, `num`, `AfterMbNum`, `CreateTime`, `nState`, `nOperatType`, `OpratAccount`, `nGameType`, `nServerID`, `ReMark`) VALUES ('46', '10457_1602581503246963_b', '10457', '91552', '1', '8', '8', '2020-10-13 17:31:43', '1', '1', '91552', '0', '0', '第三方加物品');

delete from `niuniuh5_db`.`table_clubgoodsoperatlog` where id=46;
delete from `niuniuh5_db`.`table_clubgoodsoperatlog` where id=47;


mysql> stop slave;
Query OK, 0 rows affected (0.00 sec)

mysql> delete from `niuniuh5_db`.`table_clubgoodsoperatlog` where id=46;
Query OK, 1 row affected (0.00 sec)

mysql> delete from `niuniuh5_db`.`table_clubgoodsoperatlog` where id=47;
Query OK, 1 row affected (0.00 sec)

mysql> start slave;
Query OK, 0 rows affected (0.00 sec)

slave:
	mysql> select count(*) from `niuniuh5_db`.`table_clubgoodsoperatlog`;
	+----------+
	| count(*) |
	+----------+
	|       50 |
	+----------+
	1 row in set (0.00 sec)

master:

	mysql> select count(*) from `niuniuh5_db`.`table_clubgoodsoperatlog`;
	+----------+
	| count(*) |
	+----------+
	|       50 |
	+----------+
	1 row in set (0.00 sec)
	
	

mysql> show slave status\G;
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.1.10
                  Master_User: repl_user
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000239
          Read_Master_Log_Pos: 77242498
               Relay_Log_File: db-b-relay-bin.000008
                Relay_Log_Pos: 77187094
        Relay_Master_Log_File: mysql-bin.000239
             Slave_IO_Running: Yes
            Slave_SQL_Running: No
              Replicate_Do_DB: 
          Replicate_Ignore_DB: 
           Replicate_Do_Table: 
       Replicate_Ignore_Table: 
      Replicate_Wild_Do_Table: 
  Replicate_Wild_Ignore_Table: 
                   Last_Errno: 1062
                   Last_Error: Could not execute Write_rows event on table niuniuh5_db.table_clubgoods; Duplicate entry '4' for key 'PRIMARY', Error_code: 1062; handler error HA_ERR_FOUND_DUPP_KEY; the event's master log mysql-bin.000239, end_log_pos 77187311
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 77186881
              Relay_Log_Space: 77244551
              Until_Condition: None
               Until_Log_File: 
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File: 
           Master_SSL_CA_Path: 
              Master_SSL_Cert: 
            Master_SSL_Cipher: 
               Master_SSL_Key: 
        Seconds_Behind_Master: NULL
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error: 
               Last_SQL_Errno: 1062
               Last_SQL_Error: Could not execute Write_rows event on table niuniuh5_db.table_clubgoods; Duplicate entry '4' for key 'PRIMARY', Error_code: 1062; handler error HA_ERR_FOUND_DUPP_KEY; the event's master log mysql-bin.000239, end_log_pos 77187311
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 1
                  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
             Master_Info_File: mysql.slave_master_info
                    SQL_Delay: 0
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: 
           Master_Retry_Count: 86400
                  Master_Bind: 
      Last_IO_Error_Timestamp: 
     Last_SQL_Error_Timestamp: 201014 15:52:31
               Master_SSL_Crl: 
           Master_SSL_Crlpath: 
           Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13797-1279569
            Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-1279494,
90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-523922
                Auto_Position: 1
         Replicate_Rewrite_DB: 
                 Channel_Name: 
           Master_TLS_Version: 
1 row in set (0.00 sec)

ERROR: 
No query specified




set gtid_next='7664fad8-49fd-11e8-a546-4201c0a8010a:1279495';
begin;commit;
set gtid_next='automatic';
start slave;;



mysql> show slave status\G;
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.1.10
                  Master_User: repl_user
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000239
          Read_Master_Log_Pos: 77291887
               Relay_Log_File: db-b-relay-bin.000009
                Relay_Log_Pos: 53089
        Relay_Master_Log_File: mysql-bin.000239
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
          Exec_Master_Log_Pos: 77291887
              Relay_Log_Space: 77292606
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
             Master_Server_Id: 1
                  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
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
           Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13797-1279631
            Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-1279631,
90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-523930
                Auto_Position: 1
         Replicate_Rewrite_DB: 
                 Channel_Name: 
           Master_TLS_Version: 
1 row in set (0.00 sec)

ERROR: 
No query specified

