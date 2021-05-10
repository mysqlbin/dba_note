


环境
	延迟12个小时的复制从库
	数据库环境没有任何业务
	
现象

	从库的SQL线程处于MDL锁状态

	ibdata的大小为60GB

	select 3034642/60/60/24=35天
	

相关监控
	1. 每天的9点和18点查询一次数据库并发送邮件
		0 9 * * * /usr/bin/python /home/coding001/scripts/data_monitor_db3_py2.py -beforeDay=-1
		0 18 * * * /usr/bin/python /home/coding001/scripts/data_monitor_db3_py2.py -beforeDay=0

		select tEndTime from table_clubgamescoredetail order by id desc limit 1
		
		最近一次邮件通知的时间和内容：
			时间：2021-04-03 09:00
			内容：last_insert_date: 2021-04-02 15:29:11
			-- 2021-04-02 15:29:11 减去12个小时等于=2021-04-02 03:29:11     select DATE_SUB('2021-04-02 15:29:11', INTERVAL 12 hour) 		
	
		
		正常邮件通知的时间和内容：
			时间：2021-04-03 09:00
			内容：last_insert_date: 2021-04-02 21:00:01
		
		
		4月2号做的操作
			
			删除1月份的数据表
			
			drop table if exists table_clublogscore20201001;
			drop table if exists table_clubgamescoredetail20201001;
			drop table if exists table_third_score_detail20201001;
			......................................................
			drop table if exists table_clublogscore20201031;
			drop table if exists table_clubgamescoredetail20201031;
			drop table if exists table_third_score_detail20201031;

	2. 每隔2分钟监控一次主从复制的状态
		IO线程或者SQL线程的状态为NO，就触发邮件报警。


还需要添加相关监控

	1. second behind master 的状态值大于 43200 则报警

	2. 还要监控长事务
	

未执行的命令
	查看长事务的状态
	select * from information_schema.innodb_trx\G;
	

疑问
	从库SQL单线程，MDL锁是怎么来的
	
	
	

mysql> show slave status\G;
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.1.10
                  Master_User: repl
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.001243
          Read_Master_Log_Pos: 282434691
               Relay_Log_File: db-c-relay-bin.002798
                Relay_Log_Pos: 88670300
        Relay_Master_Log_File: mysql-bin.001218
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
          Exec_Master_Log_Pos: 88670087
              Relay_Log_Space: 27127132671
              Until_Condition: None
               Until_Log_File: 
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File: 
           Master_SSL_CA_Path: 
              Master_SSL_Cert: 
            Master_SSL_Cipher: 
               Master_SSL_Key: 
        Seconds_Behind_Master: 3034642
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error: 
               Last_SQL_Errno: 0
               Last_SQL_Error: 
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 1
                  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
             Master_Info_File: mysql.slave_master_info
                    SQL_Delay: 43200
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: Waiting for table metadata lock
           Master_Retry_Count: 86400
                  Master_Bind: 
      Last_IO_Error_Timestamp: 
     Last_SQL_Error_Timestamp: 
               Master_SSL_Crl: 
           Master_SSL_Crlpath: 
           Retrieved_Gtid_Set: 
            Executed_Gtid_Set: 
                Auto_Position: 0
         Replicate_Rewrite_DB: 
                 Channel_Name: 
           Master_TLS_Version: 
1 row in set (0.00 sec)


mysql> show slave status\G;
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.1.10
                  Master_User: repl
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.001243
          Read_Master_Log_Pos: 282563058
               Relay_Log_File: db-c-relay-bin.002798
                Relay_Log_Pos: 88670300
        Relay_Master_Log_File: mysql-bin.001218
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
          Exec_Master_Log_Pos: 88670087
              Relay_Log_Space: 27127261038
              Until_Condition: None
               Until_Log_File: 
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File: 
           Master_SSL_CA_Path: 
              Master_SSL_Cert: 
            Master_SSL_Cipher: 
               Master_SSL_Key: 
        Seconds_Behind_Master: 3034659
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error: 
               Last_SQL_Errno: 0
               Last_SQL_Error: 
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 1
                  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
             Master_Info_File: mysql.slave_master_info
                    SQL_Delay: 43200
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: Waiting for table metadata lock
           Master_Retry_Count: 86400
                  Master_Bind: 
      Last_IO_Error_Timestamp: 
     Last_SQL_Error_Timestamp: 
               Master_SSL_Crl: 
           Master_SSL_Crlpath: 
           Retrieved_Gtid_Set: 
            Executed_Gtid_Set: 
                Auto_Position: 0
         Replicate_Rewrite_DB: 
                 Channel_Name: 
           Master_TLS_Version: 
1 row in set (0.01 sec)


mysql> show processlist;
+--------+-----------------+--------------------+-------------+---------+----------+----------------------------------+--------------
| Id     | User            | Host               | db          | Command | Time     | State                            | Info         
+--------+-----------------+--------------------+-------------+---------+----------+----------------------------------+--------------
|      3 | event_scheduler | localhost          | NULL        | Daemon  | 54740231 | Waiting on empty queue           | NULL         
|  33786 | system user     |                    | NULL        | Connect | 49187729 | Waiting for master to send event | NULL         
|  33788 | system user     |                    | niuniuh5_db | Connect |  3034679 | Waiting for table metadata lock  | DROP TABLE IF
| 226241 | read_user       | 192.168.1.11:48380 | niuniuh5_db | Sleep   | 17713630 |                                  | NULL         
| 334495 | root            | localhost          | NULL        | Query   |        0 | starting                         | show processl
+--------+-----------------+--------------------+-------------+---------+----------+----------------------------------+--------------
5 rows in set (0.00 sec)

drop table if exists table_clubgamescoredetail20201004;

mysql> kill 33788;
Query OK, 0 rows affected (0.00 sec)

mysql> show processlist;
+--------+-----------------+--------------------+-------------+---------+----------+----------------------------------+--------------
| Id     | User            | Host               | db          | Command | Time     | State                            | Info         
+--------+-----------------+--------------------+-------------+---------+----------+----------------------------------+--------------
|      3 | event_scheduler | localhost          | NULL        | Daemon  | 54740284 | Waiting on empty queue           | NULL         
|  33786 | system user     |                    | NULL        | Connect | 49187782 | Waiting for master to send event | NULL         
| 226241 | read_user       | 192.168.1.11:48380 | niuniuh5_db | Sleep   | 17713683 |                                  | NULL         
| 334495 | root            | localhost          | NULL        | Query   |        0 | starting                         | show processl
+--------+-----------------+--------------------+-------------+---------+----------+----------------------------------+--------------
4 rows in set (0.00 sec)

mysql> show slave status\G;
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.1.10
                  Master_User: repl
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.001243
          Read_Master_Log_Pos: 283153122
               Relay_Log_File: db-c-relay-bin.002798
                Relay_Log_Pos: 88670300
        Relay_Master_Log_File: mysql-bin.001218
             Slave_IO_Running: Yes
            Slave_SQL_Running: No
              Replicate_Do_DB: 
          Replicate_Ignore_DB: 
           Replicate_Do_Table: 
       Replicate_Ignore_Table: 
      Replicate_Wild_Do_Table: 
  Replicate_Wild_Ignore_Table: 
                   Last_Errno: 1317
                   Last_Error: Error 'Query execution was interrupted' on query. Default database: 'niuniuh5_db'. Query: 'DROP TABLE 
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 88670087
              Relay_Log_Space: 27127851102
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
               Last_SQL_Errno: 1317
               Last_SQL_Error: Error 'Query execution was interrupted' on query. Default database: 'niuniuh5_db'. Query: 'DROP TABLE 
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 1
                  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
             Master_Info_File: mysql.slave_master_info
                    SQL_Delay: 43200
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: 
           Master_Retry_Count: 86400
                  Master_Bind: 
      Last_IO_Error_Timestamp: 
     Last_SQL_Error_Timestamp: 210507 18:28:00
               Master_SSL_Crl: 
           Master_SSL_Crlpath: 
           Retrieved_Gtid_Set: 
            Executed_Gtid_Set: 
                Auto_Position: 0
         Replicate_Rewrite_DB: 
                 Channel_Name: 
           Master_TLS_Version: 
1 row in set (0.00 sec)

-- Query execution was interrupted： 查询执行被中断
	原因：
		有执行 kill 1个从库SQL线程将要执行的事务
		mysql> kill 33788;
		Query OK, 0 rows affected (0.00 sec)


mysql> show processlist;
+--------+-----------------+--------------------+-------------+---------+----------+----------------------------------+------------------+
| Id     | User            | Host               | db          | Command | Time     | State                            | Info             |
+--------+-----------------+--------------------+-------------+---------+----------+----------------------------------+------------------+
|      3 | event_scheduler | localhost          | NULL        | Daemon  | 54741249 | Waiting on empty queue           | NULL             |
|  33786 | system user     |                    | NULL        | Connect | 49188747 | Waiting for master to send event | NULL             |
| 226241 | read_user       | 192.168.1.11:48380 | niuniuh5_db | Sleep   | 17714648 |                                  | NULL             |
| 334495 | root            | localhost          | NULL        | Query   |        0 | starting                         | show processlist |
+--------+-----------------+--------------------+-------------+---------+----------+----------------------------------+------------------+
4 rows in set (0.00 sec)

mysql> stop slave;
Query OK, 0 rows affected (0.01 sec)

mysql> set global sql_slave_skip_counter=1;
Query OK, 0 rows affected (0.00 sec)

mysql> start slave;
Query OK, 0 rows affected (0.01 sec)

mysql> show slave status\G;
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.1.10
                  Master_User: repl
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.001243
          Read_Master_Log_Pos: 289305748
               Relay_Log_File: db-c-relay-bin.002798
                Relay_Log_Pos: 91651013
        Relay_Master_Log_File: mysql-bin.001218
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
          Exec_Master_Log_Pos: 91650800
              Relay_Log_Space: 27134004100
              Until_Condition: None
               Until_Log_File: 
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File: 
           Master_SSL_CA_Path: 
              Master_SSL_Cert: 
            Master_SSL_Cipher: 
               Master_SSL_Key: 
        Seconds_Behind_Master: 3035427
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error: 
               Last_SQL_Errno: 0
               Last_SQL_Error: 
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 1
                  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
             Master_Info_File: mysql.slave_master_info
                    SQL_Delay: 43200
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: Opening tables
           Master_Retry_Count: 86400
                  Master_Bind: 
      Last_IO_Error_Timestamp: 
     Last_SQL_Error_Timestamp: 
               Master_SSL_Crl: 
           Master_SSL_Crlpath: 
           Retrieved_Gtid_Set: 
            Executed_Gtid_Set: 
                Auto_Position: 0
         Replicate_Rewrite_DB: 
                 Channel_Name: 
           Master_TLS_Version: 
1 row in set (0.00 sec)

ERROR: 
No query specified

mysql> show slave status\G;
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.1.10
                  Master_User: repl
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.001243
          Read_Master_Log_Pos: 289360633
               Relay_Log_File: db-c-relay-bin.002798
                Relay_Log_Pos: 93968947
        Relay_Master_Log_File: mysql-bin.001218
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
          Exec_Master_Log_Pos: 93968734
              Relay_Log_Space: 27134058985
              Until_Condition: None
               Until_Log_File: 
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File: 
           Master_SSL_CA_Path: 
              Master_SSL_Cert: 
            Master_SSL_Cipher: 
               Master_SSL_Key: 
        Seconds_Behind_Master: 3035203
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error: 
               Last_SQL_Errno: 0
               Last_SQL_Error: 
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 1
                  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
             Master_Info_File: mysql.slave_master_info
                    SQL_Delay: 43200
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: System lock
           Master_Retry_Count: 86400
                  Master_Bind: 
      Last_IO_Error_Timestamp: 
     Last_SQL_Error_Timestamp: 
               Master_SSL_Crl: 
           Master_SSL_Crlpath: 
           Retrieved_Gtid_Set: 
            Executed_Gtid_Set: 
                Auto_Position: 0
         Replicate_Rewrite_DB: 
                 Channel_Name: 
           Master_TLS_Version: 
1 row in set (0.00 sec)

mysql> show slave status\G;
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.1.10
                  Master_User: repl
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.001243
          Read_Master_Log_Pos: 289377764
               Relay_Log_File: db-c-relay-bin.002798
                Relay_Log_Pos: 94592314
        Relay_Master_Log_File: mysql-bin.001218
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
          Exec_Master_Log_Pos: 94592101
              Relay_Log_Space: 27134076116
              Until_Condition: None
               Until_Log_File: 
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File: 
           Master_SSL_CA_Path: 
              Master_SSL_Cert: 
            Master_SSL_Cipher: 
               Master_SSL_Key: 
        Seconds_Behind_Master: 3035145
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error: 
               Last_SQL_Errno: 0
               Last_SQL_Error: 
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 1
                  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
             Master_Info_File: mysql.slave_master_info
                    SQL_Delay: 43200
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: invalidating query cache entries (table)
           Master_Retry_Count: 86400
                  Master_Bind: 
      Last_IO_Error_Timestamp: 
     Last_SQL_Error_Timestamp: 
               Master_SSL_Crl: 
           Master_SSL_Crlpath: 
           Retrieved_Gtid_Set: 
            Executed_Gtid_Set: 
                Auto_Position: 0
         Replicate_Rewrite_DB: 
                 Channel_Name: 
           Master_TLS_Version: 
1 row in set (0.00 sec)


mysql> show slave status\G;
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.1.10
                  Master_User: repl
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.001243
          Read_Master_Log_Pos: 289407465
               Relay_Log_File: db-c-relay-bin.002798
                Relay_Log_Pos: 95237205
        Relay_Master_Log_File: mysql-bin.001218
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
          Exec_Master_Log_Pos: 95236992
              Relay_Log_Space: 27134105817
              Until_Condition: None
               Until_Log_File: 
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File: 
           Master_SSL_CA_Path: 
              Master_SSL_Cert: 
            Master_SSL_Cipher: 
               Master_SSL_Key: 
        Seconds_Behind_Master: 3035071
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error: 
               Last_SQL_Errno: 0
               Last_SQL_Error: 
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 1
                  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
             Master_Info_File: mysql.slave_master_info
                    SQL_Delay: 43200
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: System lock
           Master_Retry_Count: 86400
                  Master_Bind: 
      Last_IO_Error_Timestamp: 
     Last_SQL_Error_Timestamp: 
               Master_SSL_Crl: 
           Master_SSL_Crlpath: 
           Retrieved_Gtid_Set: 
            Executed_Gtid_Set: 
                Auto_Position: 0
         Replicate_Rewrite_DB: 
                 Channel_Name: 
           Master_TLS_Version: 
1 row in set (0.00 sec)


mysql> show slave status\G;
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.1.10
                  Master_User: repl
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.001243
          Read_Master_Log_Pos: 289417189
               Relay_Log_File: db-c-relay-bin.002798
                Relay_Log_Pos: 95698688
        Relay_Master_Log_File: mysql-bin.001218
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
          Exec_Master_Log_Pos: 95698475
              Relay_Log_Space: 27134115541
              Until_Condition: None
               Until_Log_File: 
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File: 
           Master_SSL_CA_Path: 
              Master_SSL_Cert: 
            Master_SSL_Cipher: 
               Master_SSL_Key: 
        Seconds_Behind_Master: 3035021
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error: 
               Last_SQL_Errno: 0
               Last_SQL_Error: 
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 1
                  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
             Master_Info_File: mysql.slave_master_info
                    SQL_Delay: 43200
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: System lock
           Master_Retry_Count: 86400
                  Master_Bind: 
      Last_IO_Error_Timestamp: 
     Last_SQL_Error_Timestamp: 
               Master_SSL_Crl: 
           Master_SSL_Crlpath: 
           Retrieved_Gtid_Set: 
            Executed_Gtid_Set: 
                Auto_Position: 0
         Replicate_Rewrite_DB: 
                 Channel_Name: 
           Master_TLS_Version: 
1 row in set (0.00 sec)


mysql> show slave status\G;
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.1.10
                  Master_User: repl
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.001243
          Read_Master_Log_Pos: 289425817
               Relay_Log_File: db-c-relay-bin.002798
                Relay_Log_Pos: 96042644
        Relay_Master_Log_File: mysql-bin.001218
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
          Exec_Master_Log_Pos: 96042431
              Relay_Log_Space: 27134124169
              Until_Condition: None
               Until_Log_File: 
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File: 
           Master_SSL_CA_Path: 
              Master_SSL_Cert: 
            Master_SSL_Cipher: 
               Master_SSL_Key: 
        Seconds_Behind_Master: 3034991
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error: 
               Last_SQL_Errno: 0
               Last_SQL_Error: 
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 1
                  Master_UUID: 7664fad8-49fd-11e8-a546-4201c0a8010a
             Master_Info_File: mysql.slave_master_info
                    SQL_Delay: 43200
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: System lock
           Master_Retry_Count: 86400
                  Master_Bind: 
      Last_IO_Error_Timestamp: 
     Last_SQL_Error_Timestamp: 
               Master_SSL_Crl: 
           Master_SSL_Crlpath: 
           Retrieved_Gtid_Set: 
            Executed_Gtid_Set: 
                Auto_Position: 0
         Replicate_Rewrite_DB: 
                 Channel_Name: 
           Master_TLS_Version: 
1 row in set (0.00 sec)


