

在读写分离中测试Mycat对事务的支持
	
	
	1. 当前环境 
		主机        IP 地址           用途                分库分表模式                  分库分表规则
		mgr9        192.168.0.55      部署 Mycat           mycat: test1                  test1: 按天分片， 每10天一个分片。
	 
		mycat01     192.168.0.201     分库分表             db1: test1, db2: test1	

		mycat02     192.168.0.202	  分库分表	           db1: test1
		
		mycat03     192.168.0.203	  分库分表	           db1: test1
					
			
		主机        IP 地址           用途                分库分表模式                  分库分表规则
		mgr9        192.168.0.55      部署 Mycat           mycat: test4                  按月份分片
	 
		mycat01     192.168.0.201     分库分表             db1 db2 db3 db4			

		mycat02     192.168.0.202	  分库分表	           db1 db2 db3 db4
		
		mycat03     192.168.0.203	  分库分表	           db1 db2 db3 db4
		
	2. 事务语句
		truncate table test1;
		truncate table test4;
		
		start transaction;
			
			INSERT INTO `test1` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2020-03-01');
			INSERT INTO `test1` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2020-03-11');
			INSERT INTO `test1` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2020-03-22');

			INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-01-02');
			INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-02-02');
			INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-03-02');
			INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-04-02');
			INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-05-02');
			INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-06-02');
			INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-07-02');
			INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-08-02');
			INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-09-02');
			INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-10-02');
			INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-11-02');
			INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-12-02');
	
	
			select * from test1 limit 1;    # 这里查的是主库还是从库的数据？   答: 主库.  
			
		commit or rollback;
	
	
	3. 测试跨库、跨表的 commit
		mycat_user@mysqldb 01:11:  [mycat_db]> start transaction;
		11');
					INSERT INTO `test1` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2020-03-22');

					INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-01-02');
					INSERT INTQuery OK, 0 rows affected (0.01 sec)

		mycat_user@mysqldb 01:11:  [mycat_db]> 
		mycat_user@mysqldb 01:11:  [mycat_db]> INSERT INTO `test1` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2020-03-01');
		O `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-02-02');
					INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-03-02');
					INSERT INTO `test4` (`id`, `naQuery OK, 1 row affected (0.02 sec)

		mycat_user@mysqldb 01:11:  [mycat_db]> INSERT INTO `test1` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2020-03-11');
		Query OK, 1 row affected (0.00 sec)

		mycat_user@mysqldb 01:11:  [mycat_db]> INSERT INTO `test1` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2020-03-22');
		Query OK, 1 row affected (0.01 sec)

		mycat_user@mysqldb 01:11:  [mycat_db]> 
		mycat_user@mysqldb 01:11:  [mycat_db]> INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-01-02');
		me`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-04-02');
					INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-05-02');
					INSERT INTO `test4` (`id`, `name`, `CreateTime`) VQuery OK, 1 row affected (0.01 sec)

		mycat_user@mysqldb 01:11:  [mycat_db]> INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-02-02');
		ALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-06-02');
					INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-07-02');
					INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value fQuery OK, 1 row affected (0.00 sec)

		mycat_user@mysqldb 01:11:  [mycat_db]> INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-03-02');
		Query OK, 1 row affected (0.00 sec)

		mycat_user@mysqldb 01:11:  [mycat_db]> INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-04-02');
		or MYCATSEQ_GLOBALS', 'lujb', '2019-08-02');
					INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-09-02');
					INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS'Query OK, 1 row affected (0.01 sec)

		mycat_user@mysqldb 01:11:  [mycat_db]> INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-05-02');
		, 'lujb', '2019-10-02');
					INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-11-02');
					INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-12-0Query OK, 1 row affected (0.01 sec)

		mycat_user@mysqldb 01:11:  [mycat_db]> INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-06-02');
		2');
			
			
					select * from test1 limit 1;Query OK, 1 row affected (0.00 sec)

		mycat_user@mysqldb 01:11:  [mycat_db]> INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-07-02');
		Query OK, 1 row affected (0.01 sec)

		mycat_user@mysqldb 01:11:  [mycat_db]> INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-08-02');
		Query OK, 1 row affected (0.00 sec)

		mycat_user@mysqldb 01:11:  [mycat_db]> INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-09-02');
		Query OK, 1 row affected (0.00 sec)

		mycat_user@mysqldb 01:11:  [mycat_db]> INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-10-02');
		Query OK, 1 row affected (0.00 sec)

		mycat_user@mysqldb 01:11:  [mycat_db]> INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-11-02');
		Query OK, 1 row affected (0.00 sec)

		mycat_user@mysqldb 01:11:  [mycat_db]> INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-12-02');
		Query OK, 1 row affected (0.01 sec)

		mycat_user@mysqldb 01:11:  [mycat_db]> 
		mycat_user@mysqldb 01:11:  [mycat_db]> 
		mycat_user@mysqldb 01:11:  [mycat_db]> select * from test1 limit 1;
		+-----+------+---------------------+
		| ID  | name | CreateTime          |
		+-----+------+---------------------+
		| 302 | lujb | 2020-03-01 00:00:00 |
		+-----+------+---------------------+
		1 row in set (0.05 sec)

		mycat_user@mysqldb 01:11:  [mycat_db]> commit;
		Query OK, 0 rows affected (0.65 sec)


	
		查看结果：
					
		
			mycat_user@mysqldb 01:11:  [mycat_db]>  select * from test1;
			+-----+------+---------------------+
			| ID  | name | CreateTime          |
			+-----+------+---------------------+
			| 302 | lujb | 2020-03-01 00:00:00 |
			| 303 | lujb | 2020-03-11 00:00:00 |
			| 304 | lujb | 2020-03-22 00:00:00 |
			+-----+------+---------------------+
			3 rows in set (0.03 sec)

			mycat_user@mysqldb 01:12:  [mycat_db]>  select * from test4;
			+-----+------+---------------------+
			| id  | name | CreateTime          |
			+-----+------+---------------------+
			| 305 | lujb | 2019-01-02 00:00:00 |
			| 314 | lujb | 2019-10-02 00:00:00 |
			| 315 | lujb | 2019-11-02 00:00:00 |
			| 316 | lujb | 2019-12-02 00:00:00 |
			| 306 | lujb | 2019-02-02 00:00:00 |
			| 307 | lujb | 2019-03-02 00:00:00 |
			| 308 | lujb | 2019-04-02 00:00:00 |
			| 309 | lujb | 2019-05-02 00:00:00 |
			| 310 | lujb | 2019-06-02 00:00:00 |
			| 311 | lujb | 2019-07-02 00:00:00 |
			| 312 | lujb | 2019-08-02 00:00:00 |
			| 313 | lujb | 2019-09-02 00:00:00 |
			+-----+------+---------------------+
			12 rows in set (0.04 sec)



			192.168.0.201 
				select * from db1.test1;
				select * from db2.test1;
		
				root@mysqldb 09:10:  [(none)]> select * from db1.test1;
				+-----+------+---------------------+
				| ID  | name | CreateTime          |
				+-----+------+---------------------+
				| 302 | lujb | 2020-03-01 00:00:00 |
				+-----+------+---------------------+
				1 row in set (0.00 sec)

				root@mysqldb 09:11:  [(none)]> select * from db2.test1;
				+-----+------+---------------------+
				| ID  | name | CreateTime          |
				+-----+------+---------------------+
				| 303 | lujb | 2020-03-11 00:00:00 |
				+-----+------+---------------------+
				1 row in set (0.00 sec)

			192.168.0.203
				root@mysqldb 11:49:  [(none)]> select * from db1.test4;
				+-----+------+---------------------+
				| id  | name | CreateTime          |
				+-----+------+---------------------+
				| 313 | lujb | 2019-09-02 00:00:00 |
				+-----+------+---------------------+
				1 row in set (0.00 sec)

				root@mysqldb 11:49:  [(none)]> select * from db2.test4;
				+-----+------+---------------------+
				| id  | name | CreateTime          |
				+-----+------+---------------------+
				| 314 | lujb | 2019-10-02 00:00:00 |
				+-----+------+---------------------+
				1 row in set (0.00 sec)

		
		从结果中可以看到， Mycat 支持分布式事务的提交。
		
		
		通过下面的 general_log 可以知道, 尽管配置了读写分离, 但是同一个事务中有读写, 都会路由到写节点.
			[root@mycat01 data]# tail -f mycat01.log 

			2020-03-27T09:15:41.524180+08:00	   42 Query	SET autocommit=0;
			2020-03-27T09:15:41.524447+08:00	   42 Query	INSERT INTO `test1` (`id`, `name`, `CreateTime`)
			VALUES ('317', 'lujb', '2020-03-01')
			2020-03-27T09:15:41.537655+08:00	   29 Query	INSERT INTO `test1` (`id`, `name`, `CreateTime`)
			VALUES ('318', 'lujb', '2020-03-11')
			2020-03-27T09:15:41.560167+08:00	   42 Query	INSERT INTO `test4` (`id`, `name`, `CreateTime`)
			VALUES ('320', 'lujb', '2019-01-02')
			2020-03-27T09:15:41.575243+08:00	   29 Query	INSERT INTO `test4` (`id`, `name`, `CreateTime`)
			VALUES ('321', 'lujb', '2019-02-02')
			2020-03-27T09:15:41.580927+08:00	   28 Query	INSERT INTO `test4` (`id`, `name`, `CreateTime`)
			VALUES ('322', 'lujb', '2019-03-02')
			2020-03-27T09:15:41.586165+08:00	   30 Query	INSERT INTO `test4` (`id`, `name`, `CreateTime`)
			VALUES ('323', 'lujb', '2019-04-02')
			2020-03-27T09:15:42.684981+08:00	   42 Query	SELECT *
			FROM test1
			LIMIT 1
			2020-03-27T09:15:42.685947+08:00	   29 Query	SELECT *
			FROM test1
			LIMIT 1
			2020-03-27T09:15:45.194165+08:00	   42 Query	commit

			
	4. 测试跨库、跨表的 rollback
		mycat_user@mysqldb 00:44:  [mycat_db]> start transaction;
				INSERT INTO `test1` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2020-03-22');

				INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-01-02');
				INSERT INTO `test4`Query OK, 0 rows affected (0.00 sec)

		mycat_user@mysqldb 00:46:  [mycat_db]> 
		mycat_user@mysqldb 00:46:  [mycat_db]> INSERT INTO `test1` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2020-03-01');
		 (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-02-02');
				INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-03-02');
				INSERT INTO `test4` (`id`, `name`, `CreatQuery OK, 1 row affected (0.01 sec)

		mycat_user@mysqldb 00:46:  [mycat_db]> INSERT INTO `test1` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2020-03-11');
		Query OK, 1 row affected (0.01 sec)

		mycat_user@mysqldb 00:46:  [mycat_db]> INSERT INTO `test1` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2020-03-22');
		eTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-04-02');
				INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-05-02');
				INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next Query OK, 1 row affected (0.01 sec)

		mycat_user@mysqldb 00:46:  [mycat_db]> 
		mycat_user@mysqldb 00:46:  [mycat_db]> INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-01-02');
		Query OK, 1 row affected (0.00 sec)

		mycat_user@mysqldb 00:46:  [mycat_db]> INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-02-02');
		value for MYCATSEQ_GLOBALS', 'lujb', '2019-06-02');
				INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-07-02');
				INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOQuery OK, 1 row affected (0.00 sec)

		mycat_user@mysqldb 00:46:  [mycat_db]> INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-03-02');
		BALS', 'lujb', '2019-08-02');
				INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-09-02');
				INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-1Query OK, 1 row affected (0.00 sec)

		mycat_user@mysqldb 00:46:  [mycat_db]> INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-04-02');
		0-02');
				INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-11-02');
				INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-12-02');Query OK, 1 row affected (0.01 sec)

		mycat_user@mysqldb 00:46:  [mycat_db]> INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-05-02');
		Query OK, 1 row affected (0.00 sec)

		mycat_user@mysqldb 00:46:  [mycat_db]> INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-06-02');
		Query OK, 1 row affected (0.01 sec)

		mycat_user@mysqldb 00:46:  [mycat_db]> INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-07-02');
		Query OK, 1 row affected (0.01 sec)

		mycat_user@mysqldb 00:46:  [mycat_db]> INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-08-02');
		Query OK, 1 row affected (0.01 sec)

		mycat_user@mysqldb 00:46:  [mycat_db]> INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-09-02');
		Query OK, 1 row affected (0.00 sec)

		mycat_user@mysqldb 00:46:  [mycat_db]> INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-10-02');
		Query OK, 1 row affected (0.01 sec)

		mycat_user@mysqldb 00:46:  [mycat_db]> INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-11-02');
		Query OK, 1 row affected (0.01 sec)

		mycat_user@mysqldb 00:46:  [mycat_db]> INSERT INTO `test4` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2019-12-02');
		Query OK, 1 row affected (0.01 sec)

		mycat_user@mysqldb 00:46:  [mycat_db]> rollback;
		Query OK, 0 rows affected (0.03 sec)



		mycat_user@mysqldb 00:47:  [mycat_db]> select * from test1;
		Empty set (0.01 sec)

		mycat_user@mysqldb 00:47:  [mycat_db]> select * from test4;
		Empty set (0.01 sec)

		
		从结果中可以看到， Mycat 支持分布式事务的回滚操作。
		