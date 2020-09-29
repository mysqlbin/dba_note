
mysql> show master status\G;
*************************** 1. row ***************************
             File: mysql-bin.000003
         Position: 154
     Binlog_Do_DB: 
 Binlog_Ignore_DB: 
Executed_Gtid_Set: 
1 row in set (0.00 sec)


grant replication slave on *.* to 'rpl'@'192.168.0.202' identified by '123546abc';

mysql> show master status\G;
*************************** 1. row ***************************
             File: mysql-bin.000003
         Position: 448
     Binlog_Do_DB: 
 Binlog_Ignore_DB: 
Executed_Gtid_Set: 
1 row in set (0.00 sec)


CHANGE MASTER TO MASTER_HOST='192.168.0.201',MASTER_USER='rpl',MASTER_PASSWORD='123546abc',MASTER_LOG_FILE='mysql-bin.000003',MASTER_LOG_POS=154;

mysql> show slave status\G;
*************************** 1. row ***************************
               Slave_IO_State: Connecting to master
                  Master_Host: 192.168.0.201
                  Master_User: rpl
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000003
          Read_Master_Log_Pos: 154
               Relay_Log_File: localhost-relay-bin.000001
                Relay_Log_Pos: 4
        Relay_Master_Log_File: mysql-bin.000003
             Slave_IO_Running: Connecting
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
          Exec_Master_Log_Pos: 154
              Relay_Log_Space: 154
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
                Last_IO_Errno: 1130
                Last_IO_Error: error connecting to master 'rpl@192.168.0.201:3306' - retry-time: 60  retries: 1
               Last_SQL_Errno: 0
               Last_SQL_Error: 
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 0
                  Master_UUID: 
             Master_Info_File: mysql.slave_master_info
                    SQL_Delay: 0
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
           Master_Retry_Count: 86400
                  Master_Bind: 
      Last_IO_Error_Timestamp: 200928 12:22:53
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


[root@localhost data]# mysql -h192.168.0.201 -urpl -p123456abc
mysql: [Warning] Using a password on the command line interface can be insecure.
ERROR 1130 (HY000): Host '192.168.0.90' is not allowed to connect to this MySQL server
[root@localhost data]# 
[root@localhost data]# 
[root@localhost data]# ip addr show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 08:00:27:0c:8f:40 brd ff:ff:ff:ff:ff:ff
    inet 192.168.0.90/24 brd 192.168.0.255 scope global dynamic enp0s3
       valid_lft 85305sec preferred_lft 85305sec
    inet 192.168.0.202/24 brd 192.168.0.255 scope global secondary enp0s3
       valid_lft forever preferred_lft forever
    inet6 fe80::a8d8:f16e:6995:e368/64 scope link 
       valid_lft forever preferred_lft forever

https://www.cnblogs.com/ys15/p/10815761.html
	NM_CONTROLLED=no


slave：

	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: Waiting for master to send event
					  Master_Host: 192.168.0.201
					  Master_User: rpl
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: mysql-bin.000003
			  Read_Master_Log_Pos: 448
				   Relay_Log_File: localhost-relay-bin.000003
					Relay_Log_Pos: 320
			Relay_Master_Log_File: mysql-bin.000003
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
			  Exec_Master_Log_Pos: 448
				  Relay_Log_Space: 991
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
			   Retrieved_Gtid_Set: 
				Executed_Gtid_Set: 
					Auto_Position: 0
			 Replicate_Rewrite_DB: 
					 Channel_Name: 
			   Master_TLS_Version: 
	1 row in set (0.00 sec)
	
	mysql>   select concat("\'", user, "\'", '@', "\'", host,"\'") as query from mysql.user;
	+-----------------------------+
	| query                       |
	+-----------------------------+
	| 'rpl'@'192.168.0.202'       |
	| 'mysql.session'@'localhost' |
	| 'mysql.sys'@'localhost'     |
	| 'root'@'localhost'          |
	+-----------------------------+
	4 rows in set (0.05 sec)


表结构和数据
	create  database test_db DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;
	use test_db;
	CREATE TABLE `t` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;
	INSERT INTO `test_db`.`t` (`id`, `c`, `d`) VALUES ('1', '1', '1');
	INSERT INTO `test_db`.`t` (`id`, `c`, `d`) VALUES ('2', '2', '2');
	INSERT INTO `test_db`.`t` (`id`, `c`, `d`) VALUES ('3', '3', '3');
	INSERT INTO `test_db`.`t` (`id`, `c`, `d`) VALUES ('4', '4', '4');
	INSERT INTO `test_db`.`t` (`id`, `c`, `d`) VALUES ('5', '5', '5');

master
	mysql> show master status\G;
	*************************** 1. row ***************************
				 File: mysql-bin.000003
			 Position: 2342
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: 
	1 row in set (0.00 sec)

slave
	mysql> select * from slave_master_info\G;
	*************************** 1. row ***************************
		   Number_of_lines: 25
		   Master_log_name: mysql-bin.000003
			Master_log_pos: 448
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
	 Enabled_auto_position: 0
			  Channel_name: 
			   Tls_version: 
	1 row in set (0.00 sec)

	
	mysql> select * from slave_relay_log_info\G;
	*************************** 1. row ***************************
	  Number_of_lines: 7
	   Relay_log_name: ./localhost-relay-bin.000003
		Relay_log_pos: 2214
	  Master_log_name: mysql-bin.000003
	   Master_log_pos: 2342
			Sql_delay: 0
	Number_of_workers: 0
				   Id: 1
		 Channel_name: 
	1 row in set (0.00 sec)


	shell> ll
	-rw-r-----. 1 mysql mysql        671 9月  28 12:30 localhost-relay-bin.000002
	-rw-r-----. 1 mysql mysql       2214 9月  28 14:27 localhost-relay-bin.000003
	-rw-r-----. 1 mysql mysql         58 9月  28 12:30 localhost-relay-bin.index
	
	
	shell> stop slave;
	shell> reset slave;
	
	
	
	mysql> show slave status\G;
	*************************** 1. row ***************************
				   Slave_IO_State: 
					  Master_Host: 192.168.0.201
					  Master_User: rpl
					  Master_Port: 3306
					Connect_Retry: 60
				  Master_Log_File: 
			  Read_Master_Log_Pos: 4
				   Relay_Log_File: localhost-relay-bin.000001
					Relay_Log_Pos: 4
			Relay_Master_Log_File: 
				 Slave_IO_Running: No
				Slave_SQL_Running: No
				  Replicate_Do_DB: 
			  Replicate_Ignore_DB: 
			   Replicate_Do_Table: 
		   Replicate_Ignore_Table: 
		  Replicate_Wild_Do_Table: 
	  Replicate_Wild_Ignore_Table: 
					   Last_Errno: 0
					   Last_Error: 
					 Skip_Counter: 0
			  Exec_Master_Log_Pos: 0
				  Relay_Log_Space: 177
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
				   Last_SQL_Errno: 0
				   Last_SQL_Error: 
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
		 Last_SQL_Error_Timestamp: 
				   Master_SSL_Crl: 
			   Master_SSL_Crlpath: 
			   Retrieved_Gtid_Set: 
				Executed_Gtid_Set: 
					Auto_Position: 0
			 Replicate_Rewrite_DB: 
					 Channel_Name: 
			   Master_TLS_Version: 




	mysql> select * from slave_master_info\G;
	Empty set (0.00 sec)

	ERROR: 
	No query specified

	mysql> select * from slave_relay_log_info\G;
	Empty set (0.00 sec)


	shell> ll
	总用量 4259928
	srwxrwxrwx. 1 mysql mysql          0 9月  28 12:18 3306.sock
	-rw-------. 1 mysql mysql          5 9月  28 12:18 3306.sock.lock
	-rw-r-----. 1 mysql mysql         56 9月  28 12:18 auto.cnf
	-rw-r-----. 1 mysql mysql      21901 9月  28 16:59 error.log
	-rw-r-----. 1 mysql mysql        363 9月  28 11:46 ib_buffer_pool
	-rw-r-----. 1 mysql mysql 1073741824 9月  28 16:59 ibdata1
	-rw-r-----. 1 mysql mysql 1073741824 9月  28 16:59 ib_logfile0
	-rw-r-----. 1 mysql mysql 1073741824 9月  28 11:42 ib_logfile1
	-rw-r-----. 1 mysql mysql 1073741824 9月  28 11:42 ib_logfile2
	-rw-r-----. 1 mysql mysql   67108864 9月  28 12:18 ibtmp1
	-rw-r-----. 1 mysql mysql       5771 9月  28 17:00 innodb_status.3616
	-rw-r-----. 1 mysql mysql        177 9月  28 16:59 localhost-relay-bin.000001
	-rw-r-----. 1 mysql mysql         29 9月  28 16:59 localhost-relay-bin.index

	
	master:
	
		INSERT INTO `test_db`.`t` (`id`, `c`, `d`) VALUES ('6', '6', '6');
		
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
		+----+------+------+
		6 rows in set (0.00 sec)
		
		
	slave:

		mysql> start slave;
		Query OK, 0 rows affected (0.07 sec)

		mysql> show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: Waiting for master to send event
						  Master_Host: 192.168.0.201
						  Master_User: rpl
						  Master_Port: 3306
						Connect_Retry: 60
					  Master_Log_File: mysql-bin.000003
				  Read_Master_Log_Pos: 2614
					   Relay_Log_File: localhost-relay-bin.000005
						Relay_Log_Pos: 661
				Relay_Master_Log_File: mysql-bin.000003
					 Slave_IO_Running: Yes
					Slave_SQL_Running: No
					  Replicate_Do_DB: 
				  Replicate_Ignore_DB: 
				   Replicate_Do_Table: 
			   Replicate_Ignore_Table: 
			  Replicate_Wild_Do_Table: 
		  Replicate_Wild_Ignore_Table: 
						   Last_Errno: 1007
						   Last_Error: Error 'Can't create database 'test_db'; database exists' on query. Default database: 'test_db'. Query: 'create  database test_db DEFAULT CHARSET utf8mb4'
						 Skip_Counter: 0
				  Exec_Master_Log_Pos: 448
					  Relay_Log_Space: 3511
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
					   Last_SQL_Errno: 1007
					   Last_SQL_Error: Error 'Can't create database 'test_db'; database exists' on query. Default database: 'test_db'. Query: 'create  database test_db DEFAULT CHARSET utf8mb4'
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
			 Last_SQL_Error_Timestamp: 200928 17:05:18
					   Master_SSL_Crl: 
				   Master_SSL_Crlpath: 
				   Retrieved_Gtid_Set: 
					Executed_Gtid_Set: 
						Auto_Position: 0
				 Replicate_Rewrite_DB: 
						 Channel_Name: 
				   Master_TLS_Version: 
		1 row in set (0.00 sec)
		
		
		mysql> show databases;
		+--------------------+
		| Database           |
		+--------------------+
		| information_schema |
		| mysql              |
		| performance_schema |
		| sys                |
		| test_db            |
		+--------------------+
		5 rows in set (0.00 sec)

	show binlog events in 'localhost-relay-bin.000005';
	ERROR 1220 (HY000): Error when executing command SHOW BINLOG EVENTS: Could not find target log
	
	master:

		mysql> show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000003
				 Position: 2614
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: 
		1 row in set (0.00 sec)
		
			
	修复主从关系：
	
		mysql> stop slave;
		Query OK, 0 rows affected (0.00 sec)

		mysql> reset slave all;
		Query OK, 0 rows affected (0.02 sec)
			
		mysql> select * from t;
		+----+------+------+
		| id | c    | d    |
		+----+------+------+
		|  1 |    1 |    1 |
		|  2 |    2 |    2 |
		|  3 |    3 |    3 |
		|  4 |    4 |    4 |
		|  5 |    5 |    5 |
		+----+------+------+
		5 rows in set (0.00 sec)
	
	
	CHANGE MASTER TO MASTER_HOST='192.168.0.201',MASTER_USER='rpl',MASTER_PASSWORD='123546abc',MASTER_LOG_FILE='mysql-bin.000003',MASTER_LOG_POS=2407;



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
		..................................
			  Exec_Master_Log_Pos: 2614
				  Relay_Log_Space: 738
		..................................
				 Master_Server_Id: 330607
					  Master_UUID: 9e520b78-013c-11eb-a84c-0800271bf591
				 Master_Info_File: mysql.slave_master_info
						SQL_Delay: 0
			  SQL_Remaining_Delay: NULL
		  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
			   Master_Retry_Count: 86400
		..................................
	1 row in set (0.00 sec)


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
	+----+------+------+
	6 rows in set (0.00 sec)
	
	