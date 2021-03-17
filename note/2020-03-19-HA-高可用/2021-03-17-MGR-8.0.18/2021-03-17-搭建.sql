

hostname    主机          端口号  通信端口号(server-id)    server_uuid 
mgr01		192.168.0.55  3306   330655				      e136faa2-eeab-11e9-9494-080027cb3816 
mgr02       192.168.0.56  3306   330656                   5497bb23-a3c5-11e8-8f8f-080027d80ec1
mgr03       192.168.0.58  3306   330658                   8058ac83-a45d-11e8-a661-0800275004ea





1. 先各自搭建 MySQL 8.0.18版本的环境

alter user 'root'@'localhost' identified by '123456abc';


2. 配置第一个节点
	my.cnf
		# Group Replication
		log_bin = mysql-bin
		server_id = 330655
		gtid_mode = ON
		enforce_gtid_consistency = ON
		master_info_repository = TABLE
		relay_log_info_repository = TABLE
		binlog_checksum = NONE
		log_slave_updates = ON
		transaction_write_set_extraction = XXHASH64
		loose-group_replication_group_name = 'ce9be252-2b71-17e6-b8f4-00212844f856'
		loose-group_replication_start_on_boot = off
		loose-group_replication_local_address = '192.168.0.55:53306'
		loose-group_replication_group_seeds ='192.168.0.55:53306,192.168.0.56:63306,192.168.0.58:83306'
		loose-group_replication_bootstrap_group = off
		
	授权
		set sql_log_bin=0;
		create user rpl_users@'%' identified by '123456abc';
		grant replication slave on *.* to rpl_users@'%';
		set sql_log_bin=1;
		
		change master to master_user='rpl_users',master_password='123456abc' for channel 'group_replication_recovery';
		
		
	安装插件：
		INSTALL PLUGIN group_replication SONAME 'group_replication.so';

	启动 第一个节点 的 Group Replication : 
		set global group_replication_bootstrap_group=ON;
		start group_replication;
		#set global group_replication_bootstrap_group=OFF;
		
		查看日志：
		
			2019-10-14T18:29:20.745507Z 12 [System] [MY-010597] [Repl] 'CHANGE MASTER TO FOR CHANNEL 'group_replication_applier' executed'. Previous state master_host='', master_port= 3306, master_log_file='', master_log_pos= 4, master_bind=''. New state master_host='<NULL>', master_port= 0, master_log_file='', master_log_pos= 4, master_bind=''.
		
		
		关闭数据库后再次启动：
			2019-10-17T22:34:55.842116Z 62 [System] [MY-010597] [Repl] 'CHANGE MASTER TO FOR CHANNEL 'group_replication_applier' executed'. Previous state master_host='<NULL>', master_port= 0, master_log_file='', master_log_pos= 4, master_bind=''. New state master_host='<NULL>', master_port= 0, master_log_file='', master_log_pos= 4, master_bind=''.
			2019-10-17T22:34:55.981792Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.56:63306 on local port: 53306.'
			2019-10-17T22:34:55.982119Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.58:17770 on local port: 53306.'
			2019-10-17T22:34:55.982510Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.56:63306 on local port: 53306.'
			2019-10-17T22:34:55.983361Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.58:17770 on local port: 53306.'
			2019-10-17T22:34:55.983811Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.56:63306 on local port: 53306.'
			2019-10-17T22:34:55.984186Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.58:17770 on local port: 53306.'
			2019-10-17T22:34:55.984385Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.56:63306 on local port: 53306.'
			2019-10-17T22:34:55.984708Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.58:17770 on local port: 53306.'
			2019-10-17T22:34:55.984976Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.56:63306 on local port: 53306.'
			2019-10-17T22:34:55.985823Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.58:17770 on local port: 53306.'
			2019-10-17T22:34:55.986100Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.56:63306 on local port: 53306.'
			2019-10-17T22:34:55.986259Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.58:17770 on local port: 53306.'
			2019-10-17T22:34:55.986614Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.56:63306 on local port: 53306.'
			2019-10-17T22:34:55.986800Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.58:17770 on local port: 53306.'
			2019-10-17T22:34:55.987138Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.56:63306 on local port: 53306.'
			2019-10-17T22:34:55.987861Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.58:17770 on local port: 53306.'
			2019-10-17T22:34:55.988332Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.56:63306 on local port: 53306.'
			2019-10-17T22:34:55.988689Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.58:17770 on local port: 53306.'
			2019-10-17T22:34:55.989285Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.56:63306 on local port: 53306.'
			2019-10-17T22:34:55.989589Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.58:17770 on local port: 53306.'
			2019-10-17T22:34:55.989607Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error connecting to all peers. Member join failed. Local port: 53306'
			2019-10-17T22:34:56.054022Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] The member was unable to join the group. Local port: 53306'

			2019-10-17T22:35:55.886370Z 15 [ERROR] [MY-011640] [Repl] Plugin group_replication reported: 'Timeout on wait for view after joining group'
			2019-10-17T22:35:55.886485Z 15 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] The member is leaving a group without being on one.'
			
			分析：
				在数据库重启之后， 没有执行 set global group_replication_bootstrap_group=ON;	
			

		
		
	确认节点的加入情况：
		mysql>  select * from performance_schema.replication_group_members;
		+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
		| CHANNEL_NAME              | MEMBER_ID                            | MEMBER_HOST | MEMBER_PORT | MEMBER_STATE | MEMBER_ROLE | MEMBER_VERSION |
		+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
		| group_replication_applier | e136faa2-eeab-11e9-9494-080027cb3816 | mgr01       |        3306 | ONLINE       | PRIMARY     | 8.0.18         |
		+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
		1 row in set (0.01 sec)
	
	查看主节点：	
		mysql> SELECT VARIABLE_VALUE FROM performance_schema.global_status WHERE VARIABLE_NAME= 'group_replication_primary_member';
		+--------------------------------------+
		| VARIABLE_VALUE                       |
		+--------------------------------------+
		| e136faa2-eeab-11e9-9494-080027cb3816 |
		+--------------------------------------+
		1 row in set (0.00 sec)

	查看MGR相关参数：
		mysql> show variables like '%group_replication%';
		+-----------------------------------------------------+----------------------------------------------------------+
		| Variable_name                                       | Value                                                    |
		+-----------------------------------------------------+----------------------------------------------------------+
		| group_replication_allow_local_lower_version_join    | OFF                                                      |
		| group_replication_auto_increment_increment          | 7                                                        |
		| group_replication_autorejoin_tries                  | 0                                                        |
		| group_replication_bootstrap_group                   | ON                                                       |
		| group_replication_clone_threshold                   | 9223372036854775807                                      |
		| group_replication_communication_debug_options       | GCS_DEBUG_NONE                                           |
		| group_replication_communication_max_message_size    | 10485760                                                 |
		| group_replication_components_stop_timeout           | 31536000                                                 |
		| group_replication_compression_threshold             | 1000000                                                  |
		| group_replication_consistency                       | EVENTUAL                                                 |
		| group_replication_enforce_update_everywhere_checks  | OFF                                                      |
		| group_replication_exit_state_action                 | READ_ONLY                                                |
		| group_replication_flow_control_applier_threshold    | 25000                                                    |
		| group_replication_flow_control_certifier_threshold  | 25000                                                    |
		| group_replication_flow_control_hold_percent         | 10                                                       |
		| group_replication_flow_control_max_quota            | 0                                                        |
		| group_replication_flow_control_member_quota_percent | 0                                                        |
		| group_replication_flow_control_min_quota            | 0                                                        |
		| group_replication_flow_control_min_recovery_quota   | 0                                                        |
		| group_replication_flow_control_mode                 | QUOTA                                                    |
		| group_replication_flow_control_period               | 1                                                        |
		| group_replication_flow_control_release_percent      | 50                                                       |
		| group_replication_force_members                     |                                                          |
		| group_replication_group_name                        | ce9be252-2b71-17e6-b8f4-00212844f856                     |
		| group_replication_group_seeds                       | 192.168.0.55:53306,192.168.0.56:63306,192.168.0.58:83306 |
		| group_replication_gtid_assignment_block_size        | 1000000                                                  |
		| group_replication_ip_whitelist                      | AUTOMATIC                                                |
		| group_replication_local_address                     | 192.168.0.55:53306                                       |
		| group_replication_member_expel_timeout              | 0                                                        |
		| group_replication_member_weight                     | 50                                                       |
		| group_replication_message_cache_size                | 1073741824                                               |
		| group_replication_poll_spin_loops                   | 0                                                        |
		| group_replication_recovery_complete_at              | TRANSACTIONS_APPLIED                                     |
		| group_replication_recovery_compression_algorithms   | uncompressed                                             |
		| group_replication_recovery_get_public_key           | OFF                                                      |
		| group_replication_recovery_public_key_path          |                                                          |
		| group_replication_recovery_reconnect_interval       | 60                                                       |
		| group_replication_recovery_retry_count              | 10                                                       |
		| group_replication_recovery_ssl_ca                   |                                                          |
		| group_replication_recovery_ssl_capath               |                                                          |
		| group_replication_recovery_ssl_cert                 |                                                          |
		| group_replication_recovery_ssl_cipher               |                                                          |
		| group_replication_recovery_ssl_crl                  |                                                          |
		| group_replication_recovery_ssl_crlpath              |                                                          |
		| group_replication_recovery_ssl_key                  |                                                          |
		| group_replication_recovery_ssl_verify_server_cert   | OFF                                                      |
		| group_replication_recovery_use_ssl                  | OFF                                                      |
		| group_replication_recovery_zstd_compression_level   | 3                                                        |
		| group_replication_single_primary_mode               | ON                                                       |
		| group_replication_ssl_mode                          | DISABLED                                                 |
		| group_replication_start_on_boot                     | OFF                                                      |
		| group_replication_transaction_size_limit            | 150000000                                                |
		| group_replication_unreachable_majority_timeout      | 0                                                        |
		+-----------------------------------------------------+----------------------------------------------------------+
		53 rows in set (0.00 sec)


3. 配置第二个节点
	
	my.cnf
		# Group Replication
		log_bin = mysql-bin
		server_id = 330656
		gtid_mode = ON
		enforce_gtid_consistency = ON
		master_info_repository = TABLE
		relay_log_info_repository = TABLE
		binlog_checksum = NONE
		log_slave_updates = ON
		transaction_write_set_extraction = XXHASH64
		loose-group_replication_group_name = 'ce9be252-2b71-17e6-b8f4-00212844f856'
		loose-group_replication_start_on_boot = off
		loose-group_replication_local_address = '192.168.0.56:63306'
		loose-group_replication_group_seeds ='192.168.0.55:53306,192.168.0.56:63306,192.168.0.58:83306'
		loose-group_replication_bootstrap_group = off

		
	授权
		set sql_log_bin=0;
		create user rpl_users@'%' identified by '123456abc';
		grant replication slave on *.* to rpl_users@'%';
		set sql_log_bin=1;
		
		change master to master_user='rpl_users',master_password='123456abc' for channel 'group_replication_recovery';
		
		
	安装插件：
		INSTALL PLUGIN group_replication SONAME 'group_replication.so';

	启动 第二个节点 的 Group Replication : 
		start group_replication;
		
		查看日志：
		
			2019-10-30T01:31:15.603065Z 13 [System] [MY-010597] [Repl] 'CHANGE MASTER TO FOR CHANNEL 'group_replication_recovery' executed'. Previous state master_host='<NULL>', master_port= 0, master_log_file='', master_log_pos= 4, master_bind=''. New state master_host='<NULL>', master_port= 0, master_log_file='', master_log_pos= 4, master_bind=''.
			2019-10-30T01:31:35.292283Z 15 [System] [MY-010597] [Repl] 'CHANGE MASTER TO FOR CHANNEL 'group_replication_applier' executed'. Previous state master_host='<NULL>', master_port= 0, master_log_file='', master_log_pos= 68, master_bind=''. New state master_host='<NULL>', master_port= 0, master_log_file='', master_log_pos= 4, master_bind=''.
			2019-10-30T01:31:39.553640Z 22 [System] [MY-010597] [Repl] 'CHANGE MASTER TO FOR CHANNEL 'group_replication_recovery' executed'. Previous state master_host='<NULL>', master_port= 0, master_log_file='', master_log_pos= 4, master_bind=''. New state master_host='mgr01', master_port= 3306, master_log_file='', master_log_pos= 4, master_bind=''.
			2019-10-30T01:31:39.597694Z 23 [Warning] [MY-010897] [Repl] Storing MySQL user name or password information in the master info repository is not secure and is therefore not recommended. Please consider using the USER and PASSWORD connection options for START SLAVE; see the 'START SLAVE Syntax' in the MySQL Manual for more information.
			2019-10-30T01:31:39.599203Z 23 [ERROR] [MY-010584] [Repl] Slave I/O for channel 'group_replication_recovery': error connecting to master 'rpl_users@mgr01:3306' - retry-time: 60 retries: 1 message: Authentication plugin 'caching_sha2_password' reported error: Authentication requires secure connection. Error_code: MY-002061
			2019-10-30T01:31:39.648199Z 22 [ERROR] [MY-011582] [Repl] Plugin group_replication reported: 'There was an error when connecting to the donor server. Please check that group_replication_recovery channel credentials and all MEMBER_HOST column values of performance_schema.replication_group_members table are correct and DNS resolvable.'
			2019-10-30T01:31:39.648219Z 22 [ERROR] [MY-011583] [Repl] Plugin group_replication reported: 'For details please check performance_schema.replication_connection_status table and error log messages of Slave I/O for channel group_replication_recovery.'

			原因：
				配置的集群成员，通信时会把主机名与ip地址进行对应（建立hostname和ip映射），需要在 /etc/hosts 配置并且每个节点都配置：
				shell> vim /etc/hosts
				192.168.0.55 mgr01
				192.168.0.56 mgr02
				192.168.0.58 mgr03
				
		
	确认节点的加入情况：
		mysql> select * from performance_schema.replication_group_members;
		+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
		| CHANNEL_NAME              | MEMBER_ID                            | MEMBER_HOST | MEMBER_PORT | MEMBER_STATE | MEMBER_ROLE | MEMBER_VERSION |
		+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
		| group_replication_applier | 5497bb23-a3c5-11e8-8f8f-080027d80ec1 | mgr02       |        3306 | ONLINE       | SECONDARY   | 8.0.18         |
		| group_replication_applier | e136faa2-eeab-11e9-9494-080027cb3816 | mgr01       |        3306 | ONLINE       | PRIMARY     | 8.0.18         |
		+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
		2 rows in set (0.04 sec)
		
		
4. 配置第三个节点
	
	my.cnf
		# Group Replication
		log_bin = mysql-bin
		server_id = 330656
		gtid_mode = ON
		enforce_gtid_consistency = ON
		master_info_repository = TABLE
		relay_log_info_repository = TABLE
		binlog_checksum = NONE
		log_slave_updates = ON
		transaction_write_set_extraction = XXHASH64
		loose-group_replication_group_name = 'ce9be252-2b71-17e6-b8f4-00212844f856'
		loose-group_replication_start_on_boot = off
		loose-group_replication_local_address = '192.168.0.58:83306'
		loose-group_replication_group_seeds ='192.168.0.55:53306,192.168.0.56:63306,192.168.0.58:83306'
		loose-group_replication_bootstrap_group = off

		
	授权
		set sql_log_bin=0;
		create user rpl_users@'%' identified by '123456abc';
		grant replication slave on *.* to rpl_users@'%';
		set sql_log_bin=1;
		
		change master to master_user='rpl_users',master_password='123456abc' for channel 'group_replication_recovery';
		
		
	安装插件：
		INSTALL PLUGIN group_replication SONAME 'group_replication.so';

	启动 第三个节点 的 Group Replication : 
		start group_replication;
		
		查看日志：
			2018-09-09T03:15:49.349725Z 17 [System] [MY-010597] [Repl] 'CHANGE MASTER TO FOR CHANNEL 'group_replication_recovery' executed'. Previous state master_host='<NULL>', master_port= 0, master_log_file='', master_log_pos= 4, master_bind=''. New state master_host='mgr01', master_port= 3306, master_log_file='', master_log_pos= 4, master_bind=''.
			2018-09-09T03:15:49.386159Z 18 [Warning] [MY-010897] [Repl] Storing MySQL user name or password information in the master info repository is not secure and is therefore not recommended. Please consider using the USER and PASSWORD connection options for START SLAVE; see the 'START SLAVE Syntax' in the MySQL Manual for more information.
			2018-09-09T03:15:49.387293Z 18 [System] [MY-010562] [Repl] Slave I/O thread for channel 'group_replication_recovery': connected to master 'rpl_users@mgr01:3306',replication started in log 'FIRST' at position 4
			2018-09-09T03:15:49.617886Z 17 [System] [MY-010597] [Repl] 'CHANGE MASTER TO FOR CHANNEL 'group_replication_recovery' executed'. Previous state master_host='mgr01', master_port= 3306, master_log_file='', master_log_pos= 4, master_bind=''. New state master_host='<NULL>', master_port= 0, master_log_file='', master_log_pos= 4, master_bind=''.

		
	确认节点的加入情况：
		mysql> select * from performance_schema.replication_group_members;
		+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
		| CHANNEL_NAME              | MEMBER_ID                            | MEMBER_HOST | MEMBER_PORT | MEMBER_STATE | MEMBER_ROLE | MEMBER_VERSION |
		+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
		| group_replication_applier | 5497bb23-a3c5-11e8-8f8f-080027d80ec1 | mgr02       |        3306 | ONLINE       | SECONDARY   | 8.0.18         |
		| group_replication_applier | 8058ac83-a45d-11e8-a661-0800275004ea | mgr03       |        3306 | ONLINE       | SECONDARY   | 8.0.18         |
		| group_replication_applier | e136faa2-eeab-11e9-9494-080027cb3816 | mgr01       |        3306 | ONLINE       | PRIMARY     | 8.0.18         |
		+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
		3 rows in set (0.02 sec)

		

root@mysqldb 11:55:  [(none)]> select * from performance_schema.replication_connection_status\G;
*************************** 1. row ***************************
                                      CHANNEL_NAME: group_replication_applier
                                        GROUP_NAME: ce9be252-2b71-17e6-b8f4-00212844f856
                                       SOURCE_UUID: ce9be252-2b71-17e6-b8f4-00212844f856
                                         THREAD_ID: NULL
                                     SERVICE_STATE: ON
                         COUNT_RECEIVED_HEARTBEATS: 0
                          LAST_HEARTBEAT_TIMESTAMP: 0000-00-00 00:00:00.000000
                          RECEIVED_TRANSACTION_SET: ce9be252-2b71-17e6-b8f4-00212844f856:1-13
                                 LAST_ERROR_NUMBER: 0
                                LAST_ERROR_MESSAGE: 
                              LAST_ERROR_TIMESTAMP: 0000-00-00 00:00:00.000000
                           LAST_QUEUED_TRANSACTION: 
 LAST_QUEUED_TRANSACTION_ORIGINAL_COMMIT_TIMESTAMP: 0000-00-00 00:00:00.000000
LAST_QUEUED_TRANSACTION_IMMEDIATE_COMMIT_TIMESTAMP: 0000-00-00 00:00:00.000000
     LAST_QUEUED_TRANSACTION_START_QUEUE_TIMESTAMP: 0000-00-00 00:00:00.000000
       LAST_QUEUED_TRANSACTION_END_QUEUE_TIMESTAMP: 0000-00-00 00:00:00.000000
                              QUEUEING_TRANSACTION: 
    QUEUEING_TRANSACTION_ORIGINAL_COMMIT_TIMESTAMP: 0000-00-00 00:00:00.000000
   QUEUEING_TRANSACTION_IMMEDIATE_COMMIT_TIMESTAMP: 0000-00-00 00:00:00.000000
        QUEUEING_TRANSACTION_START_QUEUE_TIMESTAMP: 0000-00-00 00:00:00.000000
*************************** 2. row ***************************
                                      CHANNEL_NAME: group_replication_recovery
                                        GROUP_NAME: 
                                       SOURCE_UUID: 
                                         THREAD_ID: NULL
                                     SERVICE_STATE: OFF
                         COUNT_RECEIVED_HEARTBEATS: 0
                          LAST_HEARTBEAT_TIMESTAMP: 0000-00-00 00:00:00.000000
                          RECEIVED_TRANSACTION_SET: 
                                 LAST_ERROR_NUMBER: 2061
                                LAST_ERROR_MESSAGE: error connecting to master 'rpl_users@mgr01:3306' - retry-time: 60 retries: 1 message: Authentication plugin 'caching_sha2_password' reported error: Authentication requires secure connection.
                              LAST_ERROR_TIMESTAMP: 2019-11-01 11:55:32.805692
                           LAST_QUEUED_TRANSACTION: 
 LAST_QUEUED_TRANSACTION_ORIGINAL_COMMIT_TIMESTAMP: 0000-00-00 00:00:00.000000
LAST_QUEUED_TRANSACTION_IMMEDIATE_COMMIT_TIMESTAMP: 0000-00-00 00:00:00.000000
     LAST_QUEUED_TRANSACTION_START_QUEUE_TIMESTAMP: 0000-00-00 00:00:00.000000
       LAST_QUEUED_TRANSACTION_END_QUEUE_TIMESTAMP: 0000-00-00 00:00:00.000000
                              QUEUEING_TRANSACTION: 
    QUEUEING_TRANSACTION_ORIGINAL_COMMIT_TIMESTAMP: 0000-00-00 00:00:00.000000
   QUEUEING_TRANSACTION_IMMEDIATE_COMMIT_TIMESTAMP: 0000-00-00 00:00:00.000000
        QUEUEING_TRANSACTION_START_QUEUE_TIMESTAMP: 0000-00-00 00:00:00.000000
2 rows in set (0.02 sec)

ERROR: 
No query specified


	ALTER USER 'rpl_users'@'%' IDENTIFIED WITH mysql_native_password BY '123456abc'; #更新一下用户密码 
		
		
				
		