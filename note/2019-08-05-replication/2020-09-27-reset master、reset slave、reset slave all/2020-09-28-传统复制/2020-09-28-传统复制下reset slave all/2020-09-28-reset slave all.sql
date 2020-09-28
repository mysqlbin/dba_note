

slave
	shell> ll
	-rw-r-----. 1 mysql mysql        211 9月  28 17:26 localhost-relay-bin.000001
	-rw-r-----. 1 mysql mysql        527 9月  28 17:26 localhost-relay-bin.000002
	-rw-r-----. 1 mysql mysql         58 9月  28 17:26 localhost-relay-bin.index

mysql> select * from mysql.slave_master_info\G;
*************************** 1. row ***************************
       Number_of_lines: 25
       Master_log_name: mysql-bin.000003
        Master_log_pos: 2407
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
                  Uuid: 
           Retry_count: 86400
               Ssl_crl: 
           Ssl_crlpath: 
 Enabled_auto_position: 0
          Channel_name: 
           Tls_version: 
1 row in set (0.00 sec)



mysql> select * from mysql.slave_relay_log_info\G;
*************************** 1. row ***************************
  Number_of_lines: 7
   Relay_log_name: ./localhost-relay-bin.000002
    Relay_log_pos: 527
  Master_log_name: mysql-bin.000003
   Master_log_pos: 2614
        Sql_delay: 0
Number_of_workers: 0
               Id: 1
     Channel_name: 
1 row in set (0.01 sec)



mysql> show slave status\G;
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.0.201
                  Master_User: rpl
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000003
          Read_Master_Log_Pos: 2614
               Relay_Log_File: localhost-relay-bin.000002
                Relay_Log_Pos: 527
        Relay_Master_Log_File: mysql-bin.000003
             Slave_IO_Running: Yes
            Slave_SQL_Running: Yes
			
	..............................................
	
          Exec_Master_Log_Pos: 2614
              Relay_Log_Space: 738
			  
	..............................................
	
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 330607
                  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
             Master_Info_File: mysql.slave_master_info
                    SQL_Delay: 0
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
           Master_Retry_Count: 86400
		   
	..............................................
	
1 row in set (0.00 sec)




master:

mysql> show master status\G;
*************************** 1. row ***************************
             File: mysql-bin.000003
         Position: 2614
     Binlog_Do_DB: 
 Binlog_Ignore_DB: 
Executed_Gtid_Set: 
1 row in set (0.00 sec)



reset slave all

	stop slave;
	reset slave all;


	mysql> select * from mysql.slave_master_info\G;
	Empty set (0.00 sec)

	mysql> select * from mysql.slave_relay_log_info\G;
	Empty set (0.00 sec)
	
	mysql> show slave status\G;
	Empty set (0.00 sec)





