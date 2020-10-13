
使用 slave_master_info 表中的用户名 密码 IP 端口号信息进行连接主库


mysql> select * from mysql.slave_master_info\G;
	*************************** 1. row ***************************
		   Number_of_lines: 25
		   Master_log_name: mysql-bin.000002
			Master_log_pos: 154
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


	mysql> 
	mysql> select * from mysql.slave_relay_log_info\G;
	*************************** 1. row ***************************
	  Number_of_lines: 7
	   Relay_log_name: ./localhost-relay-bin.000002
		Relay_log_pos: 637
	  Master_log_name: mysql-bin.000002
	   Master_log_pos: 424
			Sql_delay: 0
	Number_of_workers: 0
				   Id: 1
		 Channel_name: 
	1 row in set (0.00 sec)

