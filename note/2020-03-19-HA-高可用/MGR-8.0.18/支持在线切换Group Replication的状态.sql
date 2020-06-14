

从MySQL 8.0.17版本开始，MGR的兼容性策略将从小版本号考虑，而之前则是从主版本号考虑。


在线切换Group Replication的状态:
    指定某个节点为新的Primary节点。
		用法：SELECT group_replication_set_as_primary(member_uuid)。 MySQL 8.0.17 版本引入
		比MHA方便多了.
    在线Single Primary和Multi Primary切换。
    而在以前版本需要停止集群中的所有成员才能做到。	
	MySQL MGR 可以直接的进行自主选主的工作。
	
实战：
在主节点执行： 
	root@mysqldb 12:24:  [(none)]>  select * from performance_schema.replication_group_members;
	+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
	| CHANNEL_NAME              | MEMBER_ID                            | MEMBER_HOST | MEMBER_PORT | MEMBER_STATE | MEMBER_ROLE | MEMBER_VERSION |
	+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
	| group_replication_applier | 5497bb23-a3c5-11e8-8f8f-080027d80ec1 | mgr02       |        3306 | ONLINE       | SECONDARY   | 8.0.18         |
	| group_replication_applier | acdadf61-0426-11ea-ba4c-080027c52883 | mgr03       |        3306 | ONLINE       | SECONDARY   | 8.0.18         |
	| group_replication_applier | e136faa2-eeab-11e9-9494-080027cb3816 | mgr01       |        3306 | ONLINE       | PRIMARY     | 8.0.18         |
	+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
	3 rows in set (0.00 sec)
	
	把 mgr02 切换为 PRIMARY: 
		SELECT group_replication_set_as_primary('5497bb23-a3c5-11e8-8f8f-080027d80ec1');
		root@mysqldb 12:34:  [(none)]> SELECT group_replication_set_as_primary('5497bb23-a3c5-11e8-8f8f-080027d80ec1');
		+--------------------------------------------------------------------------+
		| group_replication_set_as_primary('5497bb23-a3c5-11e8-8f8f-080027d80ec1') |
		+--------------------------------------------------------------------------+
		| Primary server switched to: 5497bb23-a3c5-11e8-8f8f-080027d80ec1         |
		+--------------------------------------------------------------------------+
		1 row in set (0.11 sec)
	
	查看切换之后的状态:
		root@mysqldb 12:34:  [(none)]> select * from performance_schema.replication_group_members;
		+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
		| CHANNEL_NAME              | MEMBER_ID                            | MEMBER_HOST | MEMBER_PORT | MEMBER_STATE | MEMBER_ROLE | MEMBER_VERSION |
		+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
		| group_replication_applier | 5497bb23-a3c5-11e8-8f8f-080027d80ec1 | mgr02       |        3306 | ONLINE       | PRIMARY     | 8.0.18         |
		| group_replication_applier | acdadf61-0426-11ea-ba4c-080027c52883 | mgr03       |        3306 | ONLINE       | SECONDARY   | 8.0.18         |
		| group_replication_applier | e136faa2-eeab-11e9-9494-080027cb3816 | mgr01       |        3306 | ONLINE       | SECONDARY   | 8.0.18         |
		+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
		3 rows in set (0.00 sec)

	查看切换进度:	
		root@mysqldb 19:47:  [(none)]> SELECT event_name, work_completed, work_estimated FROM performance_schema.events_stages_current WHERE event_name LIKE "%stage/group_rpl%";
		+-----------------------------------------------------+----------------+----------------+
		| event_name                                          | work_completed | work_estimated |
		+-----------------------------------------------------+----------------+----------------+
		| stage/group_rpl/Group Replication Module: Executing |           NULL |           NULL |
		+-----------------------------------------------------+----------------+----------------+
		1 row in set (0.00 sec)


相关参考:
	https://dev.mysql.com/doc/refman/8.0/en/group-replication-functions-for-new-primary.html
	
	