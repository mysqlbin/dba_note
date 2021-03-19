

主节点退出:
	2019-10-19T16:47:36.705010Z 0 [Warning] [MY-011493] [Repl] Plugin group_replication reported: 'Member with address mgr02:3306 has become unreachable.'
	2019-10-19T16:47:36.707073Z 0 [Warning] [MY-011493] [Repl] Plugin group_replication reported: 'Member with address mgr03:3306 has become unreachable.'
	2019-10-19T16:47:36.707099Z 0 [ERROR] [MY-011495] [Repl] Plugin group_replication reported: 'This server is not able to reach a majority of members in the group. This server will now block all updates. The server will remain blocked until contact with the majority is restored. It is possible to use group_replication_force_members to force a new group membership.'
	2019-10-20T19:05:44.370509Z 0 [Warning] [MY-011494] [Repl] Plugin group_replication reported: 'Member with address mgr02:3306 is reachable again.'
	2019-10-20T19:05:44.370825Z 0 [Warning] [MY-011498] [Repl] Plugin group_replication reported: 'The member has resumed contact with a majority of the members in the group. Regular operation is restored and transactions are unblocked.'
	2019-10-20T19:05:50.370824Z 0 [Warning] [MY-011493] [Repl] Plugin group_replication reported: 'Member with address mgr02:3306 has become unreachable.'
	2019-10-20T19:05:50.370948Z 0 [ERROR] [MY-011495] [Repl] Plugin group_replication reported: 'This server is not able to reach a majority of members in the group. This server will now block all updates. The server will remain blocked until contact with the majority is restored. It is possible to use group_replication_force_members to force a new group membership.'
	2019-10-20T19:06:00.366858Z 0 [Warning] [MY-011494] [Repl] Plugin group_replication reported: 'Member with address mgr02:3306 is reachable again.'
	2019-10-20T19:06:00.366890Z 0 [Warning] [MY-011498] [Repl] Plugin group_replication reported: 'The member has resumed contact with a majority of the members in the group. Regular operation is restored and transactions are unblocked.'
	############################################################################################ 成员因网络故障被除名，会员状态改为错误。
	2019-10-20T19:11:17.244250Z 0 [ERROR] [MY-011505] [Repl] Plugin group_replication reported: 'Member was expelled from the group due to network failures, changing member status to ERROR.'
	############################################################################################ 在检测到错误后，服务器被自动设置为只读模式。	
	2019-10-20T19:11:17.244356Z 0 [ERROR] [MY-011712] [Repl] Plugin group_replication reported: 'The server was automatically set into read only mode after an error was detected.'


从节点提升为主节点:
	2019-10-30T04:15:02.411063Z 17 [System] [MY-010597] [Repl] 'CHANGE MASTER TO FOR CHANNEL 'group_replication_recovery' executed'. Previous state master_host='mgr01', master_port= 3306, master_log_file='', master_log_pos= 4, master_bind=''. New state master_host='mgr01', master_port= 3306, master_log_file='', master_log_pos= 4, master_bind=''.
	2019-10-30T04:15:02.454665Z 18 [Warning] [MY-010897] [Repl] Storing MySQL user name or password information in the master info repository is not secure and is therefore not recommended. Please consider using the USER and PASSWORD connection options for START SLAVE; see the 'START SLAVE Syntax' in the MySQL Manual for more information.
	2019-10-30T04:15:02.456181Z 18 [System] [MY-010562] [Repl] Slave I/O thread for channel 'group_replication_recovery': connected to master 'rpl_users@mgr01:3306',replication started in log 'FIRST' at position 4
	2019-10-30T04:15:02.659930Z 17 [System] [MY-010597] [Repl] 'CHANGE MASTER TO FOR CHANNEL 'group_replication_recovery' executed'. Previous state master_host='mgr01', master_port= 3306, master_log_file='', master_log_pos= 4, master_bind=''. New state master_host='<NULL>', master_port= 0, master_log_file='', master_log_pos= 4, master_bind=''.
	2019-10-31T22:19:54.086682Z 0 [Warning] [MY-011493] [Repl] Plugin group_replication reported: 'Member with address mgr01:3306 has become unreachable.'
	2019-10-31T22:19:55.910791Z 0 [Warning] [MY-011493] [Repl] Plugin group_replication reported: 'Member with address mgr03:3306 has become unreachable.'
	2019-10-31T22:19:56.745190Z 0 [ERROR] [MY-011495] [Repl] Plugin group_replication reported: 'This server is not able to reach a majority of members in the group. This server will now block all updates. The server will remain blocked until contact with the majority is restored. It is possible to use group_replication_force_members to force a new group membership.'
	2019-10-31T22:20:25.065789Z 0 [Warning] [MY-011494] [Repl] Plugin group_replication reported: 'Member with address mgr01:3306 is reachable again.'
	2019-10-31T22:20:25.065924Z 0 [Warning] [MY-011498] [Repl] Plugin group_replication reported: 'The member has resumed contact with a majority of the members in the group. Regular operation is restored and transactions are unblocked.'
	2019-10-31T22:20:42.062856Z 0 [ERROR] [MY-011495] [Repl] Plugin group_replication reported: 'This server is not able to reach a majority of members in the group. This server will now block all updates. The server will remain blocked until contact with the majority is restored. It is possible to use group_replication_force_members to force a new group membership.'
	2019-10-31T22:25:32.984991Z 0 [Warning] [MY-011494] [Repl] Plugin group_replication reported: 'Member with address mgr03:3306 is reachable again.'
	2019-10-31T22:25:32.985052Z 0 [Warning] [MY-011498] [Repl] Plugin group_replication reported: 'The member has resumed contact with a majority of the members in the group. Regular operation is restored and transactions are unblocked.'
	2019-10-31T22:25:55.116548Z 0 [Warning] [MY-011499] [Repl] Plugin group_replication reported: 'Members removed from the group: mgr01:3306'
	2019-10-31T22:36:55.586564Z 33 [Warning] [MY-013360] [Server] Plugin sha256_password reported: ''sha256_password' is deprecated and will be removed in a future release. Please use caching_sha2_password instead'

	查看成员的状态: 
		root@mysqldb 06:38:  [(none)]> select * from performance_schema.replication_group_members;
		+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
		| CHANNEL_NAME              | MEMBER_ID                            | MEMBER_HOST | MEMBER_PORT | MEMBER_STATE | MEMBER_ROLE | MEMBER_VERSION |
		+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
		| group_replication_applier | 5497bb23-a3c5-11e8-8f8f-080027d80ec1 | mgr02       |        3306 | ONLINE       | PRIMARY     | 8.0.18         |
		| group_replication_applier | 8058ac83-a45d-11e8-a661-0800275004ea | mgr03       |        3306 | ONLINE       | SECONDARY   | 8.0.18         |
		+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
		2 rows in set (0.00 sec)

	

错误: 启动第一个节点的姿势不对:
	
		
	2019-10-22T13:41:32.909926Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.56:63306 on local port: 53306.'
	2019-10-22T13:41:32.910288Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.58:17770 on local port: 53306.'
	2019-10-22T13:41:32.910617Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.56:63306 on local port: 53306.'
	2019-10-22T13:41:32.910886Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.58:17770 on local port: 53306.'
	2019-10-22T13:41:32.911387Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.56:63306 on local port: 53306.'
	2019-10-22T13:41:32.911798Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.58:17770 on local port: 53306.'
	2019-10-22T13:41:32.912197Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.56:63306 on local port: 53306.'
	2019-10-22T13:41:32.912513Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.58:17770 on local port: 53306.'
	2019-10-22T13:41:32.912786Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.56:63306 on local port: 53306.'
	2019-10-22T13:41:32.913225Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.58:17770 on local port: 53306.'
	2019-10-22T13:41:32.913492Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.56:63306 on local port: 53306.'
	2019-10-22T13:41:32.913747Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.58:17770 on local port: 53306.'
	2019-10-22T13:41:32.914116Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.56:63306 on local port: 53306.'
	2019-10-22T13:41:32.914301Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.58:17770 on local port: 53306.'
	2019-10-22T13:41:32.914627Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.56:63306 on local port: 53306.'
	2019-10-22T13:41:32.914907Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.58:17770 on local port: 53306.'
	2019-10-22T13:41:32.915103Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.56:63306 on local port: 53306.'
	2019-10-22T13:41:32.915638Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.58:17770 on local port: 53306.'
	2019-10-22T13:41:32.915987Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.56:63306 on local port: 53306.'
	2019-10-22T13:41:32.916286Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error on opening a connection to 192.168.0.58:17770 on local port: 53306.'
	2019-10-22T13:41:32.916299Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] Error connecting to all peers. Member join failed. Local port: 53306'
	2019-10-22T13:41:32.963331Z 0 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] The member was unable to join the group. Local port: 53306'
	2019-10-22T13:42:32.834103Z 205 [ERROR] [MY-011640] [Repl] Plugin group_replication reported: 'Timeout on wait for view after joining group'
	2019-10-22T13:42:32.834196Z 205 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] The member is leaving a group without bei


	正确姿势:
		set global group_replication_bootstrap_group=ON;
		start group_replication;
		
	
root@mysqldb 09:55:  [(none)]> select * from performance_schema.replication_group_members;
+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
| CHANNEL_NAME              | MEMBER_ID                            | MEMBER_HOST | MEMBER_PORT | MEMBER_STATE | MEMBER_ROLE | MEMBER_VERSION |
+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
| group_replication_applier | e1d9ad45-0425-11ea-ac11-080027c52883 | mgr03       |        3306 | ERROR        |             | 8.0.18         |
+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
1 row in set (0.15 sec)
	
	# 看错误日志
	2019-11-11T01:51:03.388914Z 0 [ERROR] [MY-011516] [Repl] Plugin group_replication reported: 'There is already a member with server_uuid 5497bb23-a3c5-11e8-8f8f-080027d80ec1. The member will now exit the group.'
	2019-11-11T01:53:31.813855Z 0 [Warning] [MY-011493] [Repl] Plugin group_replication reported: 'Member with address mgr01:3306 has become unreachable.'
	2019-11-11T01:53:35.442887Z 0 [ERROR] [MY-011505] [Repl] Plugin group_replication reported: 'Member was expelled from the group due to network failures, changing member status to ERROR.'
	2019-11-11T01:53:35.485829Z 0 [ERROR] [MY-011712] [Repl] Plugin group_replication reported: 'The server was automatically set into read only mode after an error was detected.
	
	
运行一段时间之后某个节点报错：
	root@mysqldb 15:38:  [(none)]> select * from performance_schema.replication_group_members;
	+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
	| CHANNEL_NAME              | MEMBER_ID                            | MEMBER_HOST | MEMBER_PORT | MEMBER_STATE | MEMBER_ROLE | MEMBER_VERSION |
	+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
	| group_replication_applier | 5497bb23-a3c5-11e8-8f8f-080027d80ec1 | mgr02       |        3306 | ERROR        |             | 8.0.18         |
	+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
	1 row in set (0.00 sec)
	
	查看该节点的日志：
		2019-11-03T21:00:33.760299Z 0 [Warning] [MY-011493] [Repl] Plugin group_replication reported: 'Member with address mgr01:3306 has become unreachable.'
		2019-11-03T21:00:52.344488Z 0 [Warning] [MY-011493] [Repl] Plugin group_replication reported: 'Member with address mgr03:3306 has become unreachable.'
		2019-11-03T21:00:52.344604Z 0 [ERROR] [MY-011495] [Repl] Plugin group_replication reported: '
			This server is not able to reach a majority of members in the group. This server will now block all updates.
			The server will remain blocked until contact with the majority is restored. 
			It is possible to use group_replication_force_members to force a new group membership.'
		2019-11-03T21:00:55.042006Z 0 [ERROR] [MY-011505] [Repl] Plugin group_replication reported: '
			Member was expelled from the group due to network failures, changing member status to ERROR.'
			# 会员因网络故障被除名，会员状态改为错误															
		2019-11-03T21:00:55.081846Z 0 [ERROR] [MY-011712] [Repl] Plugin group_replication reported: '
			The server was automatically set into read only mode after an error was detected.'
			# 检测到错误后，服务器自动设置为只读模式
			
	原因：
		该成员节点的网络问题导致被从组复制离开 
		
	解决办法：

		root@mysqldb 15:38:  [(none)]> stop group_replication;
		Query OK, 0 rows affected (1.28 sec)

		root@mysqldb 15:44:  [(none)]> start group_replication;
		Query OK, 0 rows affected (4.07 sec)

		root@mysqldb 15:44:  [(none)]> select * from performance_schema.replication_group_members;
		+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
		| CHANNEL_NAME              | MEMBER_ID                            | MEMBER_HOST | MEMBER_PORT | MEMBER_STATE | MEMBER_ROLE | MEMBER_VERSION |
		+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
		| group_replication_applier | 5497bb23-a3c5-11e8-8f8f-080027d80ec1 | mgr02       |        3306 | ONLINE       | SECONDARY   | 8.0.18         |
		| group_replication_applier | acdadf61-0426-11ea-ba4c-080027c52883 | mgr03       |        3306 | ONLINE       | SECONDARY   | 8.0.18         |
		| group_replication_applier | e136faa2-eeab-11e9-9494-080027cb3816 | mgr01       |        3306 | ONLINE       | PRIMARY     | 8.0.18         |
		+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
		3 rows in set (0.01 sec)
		
		
	
节点启动报错:	

	root@mysqldb 11:12:  [(none)]> start group_replication;
	ERROR 3094 (HY000): The START GROUP_REPLICATION command failed as the applier module failed to start.



	2019-10-26T01:36:58.840330Z 580 [ERROR] [MY-010584] [Repl] Slave SQL for channel 'group_replication_applier': Error 'Unknown database 'test_db'' on query. Default database: 'test_db'. Query: 'CREATE TABLE `tmp_test` (
	  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
	  `price` bigint(20) not null default 0,
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4', Error_code: MY-001049
	2019-10-26T01:36:58.840399Z 580 [Warning] [MY-010584] [Repl] Slave: Integer display width is deprecated and will be removed in a future release. Error_code: MY-001681
	2019-10-26T01:36:58.840407Z 580 [Warning] [MY-010584] [Repl] Slave: Integer display width is deprecated and will be removed in a future release. Error_code: MY-001681
	2019-10-26T01:36:58.840412Z 580 [Warning] [MY-010584] [Repl] Slave: Unknown database 'test_db' Error_code: MY-001049
	2019-10-26T01:36:58.840423Z 580 [ERROR] [MY-011451] [Repl] Plugin group_replication reported: 'The applier thread execution was aborted. Unable to process more transactions, this member will now leave the group.'
	2019-10-26T01:36:58.840437Z 580 [ERROR] [MY-010586] [Repl] Error running query, slave SQL thread aborted. Fix the problem, and restart the slave SQL thread with "SLAVE START". We stopped at log 'FIRST' position 0
	2019-10-26T01:36:58.840829Z 577 [ERROR] [MY-011452] [Repl] Plugin group_replication reported: 'Fatal error during execution on the Applier process of Group Replication. The server will now leave the group.'
	2019-10-26T01:36:58.840884Z 577 [ERROR] [MY-011712] [Repl] Plugin group_replication reported: 'The server was automatically set into read only mode after an error was detected.'
	2019-10-26T03:12:27.589019Z 173181 [System] [MY-010597] [Repl] 'CHANGE MASTER TO FOR CHANNEL 'group_replication_applier' executed'. Previous state master_host='<NULL>', master_port= 0, master_log_file='', master_log_pos= 2429, master_bind=''. New state master_host='<NULL>', master_port= 0, master_log_file='', master_log_pos= 4, master_bind=''.
	2019-10-26T03:12:27.663680Z 173184 [ERROR] [MY-010584] [Repl] Slave SQL for channel 'group_replication_applier': Error 'Unknown database 'test_db'' on query. Default database: 'test_db'. Query: 'CREATE TABLE `tmp_test` (
	  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
	  `price` bigint(20) not null default 0,
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4', Error_code: MY-001049
	2019-10-26T03:12:27.663729Z 173184 [Warning] [MY-010584] [Repl] Slave: Integer display width is deprecated and will be removed in a future release. Error_code: MY-001681
	2019-10-26T03:12:27.663735Z 173184 [Warning] [MY-010584] [Repl] Slave: Integer display width is deprecated and will be removed in a future release. Error_code: MY-001681
	2019-10-26T03:12:27.663738Z 173184 [Warning] [MY-010584] [Repl] Slave: Unknown database 'test_db' Error_code: MY-001049
	2019-10-26T03:12:27.663759Z 173184 [ERROR] [MY-011451] [Repl] Plugin group_replication reported: 'The applier thread execution was aborted. Unable to process more transactions, this member will now leave the group.'
	2019-10-26T03:12:27.663766Z 173184 [ERROR] [MY-010586] [Repl] Error running query, slave SQL thread aborted. Fix the problem, and restart the slave SQL thread with "SLAVE START". We stopped at log 'FIRST' position 0
	2019-10-26T03:12:27.664201Z 173130 [ERROR] [MY-011669] [Repl] Plugin group_replication reported: 'Unable to initialize the Group Replication applier module.'
	2019-10-26T03:12:27.664262Z 173130 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] The member is leaving a group without being on one.'
	2019-10-26T03:12:43.266530Z 173194 [System] [MY-010597] [Repl] 'CHANGE MASTER TO FOR CHANNEL 'group_replication_applier' executed'. Previous state master_host='<NULL>', master_port= 0, master_log_file='', master_log_pos= 4, master_bind=''. New state master_host='<NULL>', master_port= 0, master_log_file='', master_log_pos= 4, master_bind=''.
	2019-10-26T03:12:43.451012Z 173197 [ERROR] [MY-010584] [Repl] Slave SQL for channel 'group_replication_applier': Error 'Unknown database 'test_db'' on query. Default database: 'test_db'. Query: 'CREATE TABLE `tmp_test` (
	  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
	  `price` bigint(20) not null default 0,
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4', Error_code: MY-001049
	2019-10-26T03:12:43.451085Z 173197 [Warning] [MY-010584] [Repl] Slave: Integer display width is deprecated and will be removed in a future release. Error_code: MY-001681
	2019-10-26T03:12:43.451096Z 173197 [Warning] [MY-010584] [Repl] Slave: Integer display width is deprecated and will be removed in a future release. Error_code: MY-001681
	2019-10-26T03:12:43.451100Z 173197 [Warning] [MY-010584] [Repl] Slave: Unknown database 'test_db' Error_code: MY-001049
	2019-10-26T03:12:43.451111Z 173197 [ERROR] [MY-011451] [Repl] Plugin group_replication reported: 'The applier thread execution was aborted. Unable to process more transactions, this member will now leave the group.'
	2019-10-26T03:12:43.451120Z 173197 [ERROR] [MY-010586] [Repl] Error running query, slave SQL thread aborted. Fix the problem, and restart the slave SQL thread with "SLAVE START". We stopped at log 'FIRST' position 0
	2019-10-26T03:12:43.451446Z 173130 [ERROR] [MY-011669] [Repl] Plugin group_replication reported: 'Unable to initialize the Group Replication applier module.'
	2019-10-26T03:12:43.451552Z 173130 [ERROR] [MY-011735] [Repl] Plugin group_replication reported: '[GCS] The member is leaving a group without being on one.'

	尝试解决:  # 不建议
		root@mysqldb 11:16:  [(none)]> create  database test_db DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;
			-> ;
		ERROR 1290 (HY000): The MySQL server is running with the --super-read-only option so it cannot execute this statement
		root@mysqldb 11:17:  [(none)]> set global super-read-only=0;
		ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '-read-only=0' at line 1
		root@mysqldb 11:17:  [(none)]> set global super_read_only=0;
		Query OK, 0 rows affected (0.00 sec)

		root@mysqldb 11:17:  [(none)]> 
		root@mysqldb 11:17:  [(none)]> 
		root@mysqldb 11:17:  [(none)]> create  database test_db DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;
			-> ;
		Query OK, 1 row affected (0.02 sec)

		root@mysqldb 11:17:  [(none)]> 
		root@mysqldb 11:17:  [(none)]> 
		root@mysqldb 11:17:  [(none)]> set global super_read_only=1;
		Query OK, 0 rows affected (0.00 sec)

		root@mysqldb 11:18:  [(none)]> start group_replication;
		Query OK, 0 rows affected (3.13 sec)

		root@mysqldb 11:20:  [(none)]> select * from performance_schema.replication_group_members;
		+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
		| CHANNEL_NAME              | MEMBER_ID                            | MEMBER_HOST | MEMBER_PORT | MEMBER_STATE | MEMBER_ROLE | MEMBER_VERSION |
		+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
		| group_replication_applier | e136faa2-eeab-11e9-9494-080027cb3816 | mgr01       |        3306 | ONLINE       | PRIMARY     | 8.0.18         |
		+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
		1 row in set (0.00 sec)

	
	解决办法:
		通过全备份的形式, 让组成员重新加入组.
		
	

	

