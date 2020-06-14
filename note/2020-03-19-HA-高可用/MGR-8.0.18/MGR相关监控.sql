


监控组复制
	1. 服务器状态
	2. performance_schema.replication_group_members 表
	3. performance_schema.replication_group_member_stats 表
	4. performance_schema.replication_connection_status 表
	5. performance_schema.replication_applier_status 表
	6. 相关参考
	
	
1. 服务器状态

	领域            描述         														组同步

	ONLINE          该成员已准备好充当功能齐全的组成员,                                  是
					这意味着客户端可以连接并开始执行事务。            

	RECOVERING      该成员正在成为该组织的积极成员，                                    没有
					目前正在进行恢复过程，从捐赠者那里接收国家信息。

	OFFLINE			插件已加载但该成员不属于任何组。									没有

	ERROR			会员的状态。 只要恢复阶段或应用更改时出现错误，						没有
					服务器就会进入此状态。
		
	UNREACHABLE     每当本地故障检测器怀疑某个服务器无法访问时，						没有
					例如它被非自愿断开，它就会显示服务器的状态为 UNREACHABLE 。
					(失联了)

	重要: 
	实例进入 ERROR 状态后，该 super_read_only 选项将设置为 ON 。 要离开 ERROR 状态，您必须手动配置实例 super_read_only=OFF 。

	请注意，组复制 不是 同步的，但最终是同步的。 
		更确切地说，事务以相同的顺序传递给所有组成员，但是它们的执行不同步，这意味着在接受提交事务之后，每个成员按照自己的进度提交。

		
2. performance_schema.replication_group_members 表
	mysql> select * from performance_schema.replication_group_members;
	+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
	| CHANNEL_NAME              | MEMBER_ID                            | MEMBER_HOST | MEMBER_PORT | MEMBER_STATE | MEMBER_ROLE | MEMBER_VERSION |
	+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
	| group_replication_applier | 5497bb23-a3c5-11e8-8f8f-080027d80ec1 | mgr02       |        3306 | ONLINE       | PRIMARY     | 8.0.18         |
	| group_replication_applier | acdadf61-0426-11ea-ba4c-080027c52883 | mgr03       |        3306 | ONLINE       | SECONDARY   | 8.0.18         |
	| group_replication_applier | e136faa2-eeab-11e9-9494-080027cb3816 | mgr01       |        3306 | ONLINE       | SECONDARY   | 8.0.18         |
	+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
	3 rows in set (0.01 sec)

3. performance_schema.replication_group_member_stats 表
	mysql> select * from performance_schema.replication_group_member_stats\G;
	*************************** 1. row ***************************
								  CHANNEL_NAME: group_replication_applier
									   VIEW_ID: 15717522551068938:9
									 MEMBER_ID: 5497bb23-a3c5-11e8-8f8f-080027d80ec1
				   COUNT_TRANSACTIONS_IN_QUEUE: 0
					COUNT_TRANSACTIONS_CHECKED: 0
					  COUNT_CONFLICTS_DETECTED: 0
			COUNT_TRANSACTIONS_ROWS_VALIDATING: 0
			TRANSACTIONS_COMMITTED_ALL_MEMBERS: ce9be252-2b71-17e6-b8f4-00212844f856:1-24
				LAST_CONFLICT_FREE_TRANSACTION: 
	COUNT_TRANSACTIONS_REMOTE_IN_APPLIER_QUEUE: 0
			 COUNT_TRANSACTIONS_REMOTE_APPLIED: 0
			 COUNT_TRANSACTIONS_LOCAL_PROPOSED: 0
			 COUNT_TRANSACTIONS_LOCAL_ROLLBACK: 0
	*************************** 2. row ***************************
								  CHANNEL_NAME: group_replication_applier
									   VIEW_ID: 15717522551068938:9
									 MEMBER_ID: acdadf61-0426-11ea-ba4c-080027c52883
				   COUNT_TRANSACTIONS_IN_QUEUE: 0
					COUNT_TRANSACTIONS_CHECKED: 0
					  COUNT_CONFLICTS_DETECTED: 0
			COUNT_TRANSACTIONS_ROWS_VALIDATING: 0
			TRANSACTIONS_COMMITTED_ALL_MEMBERS: ce9be252-2b71-17e6-b8f4-00212844f856:1-24
				LAST_CONFLICT_FREE_TRANSACTION: 
	COUNT_TRANSACTIONS_REMOTE_IN_APPLIER_QUEUE: 0
			 COUNT_TRANSACTIONS_REMOTE_APPLIED: 1
			 COUNT_TRANSACTIONS_LOCAL_PROPOSED: 0
			 COUNT_TRANSACTIONS_LOCAL_ROLLBACK: 0
	*************************** 3. row ***************************
								  CHANNEL_NAME: group_replication_applier
									   VIEW_ID: 15717522551068938:9
									 MEMBER_ID: e136faa2-eeab-11e9-9494-080027cb3816
				   COUNT_TRANSACTIONS_IN_QUEUE: 0
					COUNT_TRANSACTIONS_CHECKED: 0
					  COUNT_CONFLICTS_DETECTED: 0
			COUNT_TRANSACTIONS_ROWS_VALIDATING: 0
			TRANSACTIONS_COMMITTED_ALL_MEMBERS: ce9be252-2b71-17e6-b8f4-00212844f856:1-24
				LAST_CONFLICT_FREE_TRANSACTION: 
	COUNT_TRANSACTIONS_REMOTE_IN_APPLIER_QUEUE: 0
			 COUNT_TRANSACTIONS_REMOTE_APPLIED: 5
			 COUNT_TRANSACTIONS_LOCAL_PROPOSED: 0
			 COUNT_TRANSACTIONS_LOCAL_ROLLBACK: 0
	3 rows in set (0.00 sec)


4. performance_schema.replication_connection_status 表

	mysql> select * from performance_schema.replication_connection_status\G;
	*************************** 1. row ***************************
										  CHANNEL_NAME: group_replication_applier
											GROUP_NAME: ce9be252-2b71-17e6-b8f4-00212844f856
										   SOURCE_UUID: ce9be252-2b71-17e6-b8f4-00212844f856
											 THREAD_ID: NULL
										 SERVICE_STATE: ON
							 COUNT_RECEIVED_HEARTBEATS: 0
							  LAST_HEARTBEAT_TIMESTAMP: 0000-00-00 00:00:00.000000
							  RECEIVED_TRANSACTION_SET: ce9be252-2b71-17e6-b8f4-00212844f856:1-24
									 LAST_ERROR_NUMBER: 0
									LAST_ERROR_MESSAGE: 
								  LAST_ERROR_TIMESTAMP: 0000-00-00 00:00:00.000000
							   LAST_QUEUED_TRANSACTION: ce9be252-2b71-17e6-b8f4-00212844f856:24
	 LAST_QUEUED_TRANSACTION_ORIGINAL_COMMIT_TIMESTAMP: 0000-00-00 00:00:00.000000
	LAST_QUEUED_TRANSACTION_IMMEDIATE_COMMIT_TIMESTAMP: 0000-00-00 00:00:00.000000
		 LAST_QUEUED_TRANSACTION_START_QUEUE_TIMESTAMP: 2019-11-04 15:44:48.780601
		   LAST_QUEUED_TRANSACTION_END_QUEUE_TIMESTAMP: 2019-11-04 15:44:48.780618
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
	2 rows in set (0.00 sec)



5. performance_schema.replication_applier_status 表

	root@mysqldb 10:32:  [(none)]> select * from performance_schema.replication_applier_status;
	+----------------------------+---------------+-----------------+----------------------------+
	| CHANNEL_NAME               | SERVICE_STATE | REMAINING_DELAY | COUNT_TRANSACTIONS_RETRIES |
	+----------------------------+---------------+-----------------+----------------------------+
	| group_replication_applier  | ON            |            NULL |                          0 |
	| group_replication_recovery | OFF           |            NULL |                          0 |
	+----------------------------+---------------+-----------------+----------------------------+
	2 rows in set (0.02 sec)

	

6. 相关参考
	https://mp.weixin.qq.com/s/iuQgZIoCa5_LD86_NQ-rlw   MySQL Group Replication官方文档译文 (三)
	http://www.deituicms.com/mysql8cn/cn/group-replication.html#group-replication-monitoring    监控组复制
	https://yq.aliyun.com/articles/687012               组复制官方翻译四、Monitoring Group Replication
	https://dev.mysql.com/doc/refman/8.0/en/group-replication-monitoring.html  
	
	
