
1. 先创建表过几分钟再插入数据
2. 先创建表并且插入数据过20秒再看统计信息
3. 表已经有15行记录再插入15行记录后是否会更新统计信息
4. 通过GDB打断点验证表已经有15行记录再插入15行记录后是否会更新统计信息


1. 先创建表过几分钟再插入数据
	1.1 创建表
		select now();
		drop table  if exists t;
		CREATE TABLE `t` (
		  `id` bigint(11) NOT NULL AUTO_INCREMENT,
		  `c` int(11) DEFAULT NULL,
		  `d` int(11) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `c` (`c`)
		) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;


		select * from mysql.innodb_table_stats  where database_name='test_db' and table_name = 't';
		select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 't';

		mysql> select now();
		+---------------------+
		| now()               |
		+---------------------+
		| 2021-10-09 00:31:43 |
		+---------------------+
		1 row in set (0.00 sec)

		mysql> drop table  if exists t;
		Query OK, 0 rows affected (0.04 sec)

		mysql> CREATE TABLE `t` (
			->   `id` bigint(11) NOT NULL AUTO_INCREMENT,
			->   `c` int(11) DEFAULT NULL,
			->   `d` int(11) DEFAULT NULL,
			->   PRIMARY KEY (`id`),
			->   KEY `c` (`c`)
			-> ) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;
		Query OK, 0 rows affected (0.10 sec)

		mysql> select * from mysql.innodb_table_stats  where database_name='test_db' and table_name = 't';
		+---------------+------------+---------------------+--------+----------------------+--------------------------+
		| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
		+---------------+------------+---------------------+--------+----------------------+--------------------------+
		| test_db       | t          | 2021-10-09 00:31:44 |      0 |                    1 |                        1 |
		+---------------+------------+---------------------+--------+----------------------+--------------------------+
		1 row in set (0.08 sec)

		mysql> select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 't';
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| test_db       | t          | PRIMARY    | 2021-10-09 00:31:44 | n_diff_pfx01 |          0 |           1 | id                                |
		| test_db       | t          | PRIMARY    | 2021-10-09 00:31:44 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
		| test_db       | t          | PRIMARY    | 2021-10-09 00:31:44 | size         |          1 |        NULL | Number of pages in the index      |
		| test_db       | t          | c          | 2021-10-09 00:31:44 | n_diff_pfx01 |          0 |           1 | c                                 |
		| test_db       | t          | c          | 2021-10-09 00:31:44 | n_diff_pfx02 |          0 |           1 | c,id                              |
		| test_db       | t          | c          | 2021-10-09 00:31:44 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
		| test_db       | t          | c          | 2021-10-09 00:31:44 | size         |          1 |        NULL | Number of pages in the index      |
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		7 rows in set (0.07 sec)



	1.2 大约3分钟后执行下面的语句

		select now();

		insert into t(c,d) values(1,1);
		insert into t(c,d) values(2,2);
		insert into t(c,d) values(3,3);
		insert into t(c,d) values(4,4);
		insert into t(c,d) values(5,5);
		insert into t(c,d) values(6,6);
		insert into t(c,d) values(7,7);
		insert into t(c,d) values(8,8);
		insert into t(c,d) values(9,9);
		insert into t(c,d) values(10,10);
		insert into t(c,d) values(11,11);
		insert into t(c,d) values(12,12);
		insert into t(c,d) values(13,13);
		insert into t(c,d) values(14,14);
		insert into t(c,d) values(15,15);

		select * from mysql.innodb_table_stats  where database_name='test_db' and table_name = 't';
		select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 't';

			mysql> 
			mysql> select now();
			+---------------------+
			| now()               |
			+---------------------+
			| 2021-10-09 00:34:44 |
			+---------------------+
			1 row in set (0.00 sec)

			mysql> 
			mysql> insert into t(c,d) values(1,1);
			) values(8,8);
			insert into t(c,d) values(9,9);
			insert into t(c,d) values(10,10);
			insert into t(c,d) values(11,11);
			insert into t(c,d) values(12,12);
			insert into t(c,d) values(13,13);
			insert into t(c,d) values(14,14);
			insert into t(c,d) values(15,15);

			select * from mysql.innodb_table_stats  where database_name='test_db' and table_name = 't';
			select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 't';
			Query OK, 1 row affected (0.01 sec)

			mysql> insert into t(c,d) values(2,2);
			Query OK, 1 row affected (0.02 sec)

			mysql> insert into t(c,d) values(3,3);
			Query OK, 1 row affected (0.02 sec)

			mysql> insert into t(c,d) values(4,4);
			Query OK, 1 row affected (0.01 sec)

			mysql> insert into t(c,d) values(5,5);
			Query OK, 1 row affected (0.00 sec)

			mysql> insert into t(c,d) values(6,6);
			Query OK, 1 row affected (0.01 sec)

			mysql> insert into t(c,d) values(7,7);
			Query OK, 1 row affected (0.01 sec)

			mysql> insert into t(c,d) values(8,8);
			Query OK, 1 row affected (0.01 sec)

			mysql> insert into t(c,d) values(9,9);
			Query OK, 1 row affected (0.00 sec)

			mysql> insert into t(c,d) values(10,10);
			Query OK, 1 row affected (0.01 sec)

			mysql> insert into t(c,d) values(11,11);
			Query OK, 1 row affected (0.01 sec)

			mysql> insert into t(c,d) values(12,12);
			Query OK, 1 row affected (0.01 sec)

			mysql> insert into t(c,d) values(13,13);
			Query OK, 1 row affected (0.00 sec)

			mysql> insert into t(c,d) values(14,14);
			Query OK, 1 row affected (0.01 sec)

			mysql> insert into t(c,d) values(15,15);
			Query OK, 1 row affected (0.01 sec)

			mysql> 
			mysql> select * from mysql.innodb_table_stats  where database_name='test_db' and table_name = 't';
			+---------------+------------+---------------------+--------+----------------------+--------------------------+
			| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
			+---------------+------------+---------------------+--------+----------------------+--------------------------+
			| test_db       | t          | 2021-10-09 00:34:44 |      2 |                    1 |                        1 |
			+---------------+------------+---------------------+--------+----------------------+--------------------------+
			1 row in set (0.00 sec)
			
			-- innodb_table_stats.n_rows 这个值明显不准确。
			
			mysql> select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 't';
			+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
			| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
			+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
			| test_db       | t          | PRIMARY    | 2021-10-09 00:34:44 | n_diff_pfx01 |          2 |           1 | id                                |
			| test_db       | t          | PRIMARY    | 2021-10-09 00:34:44 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
			| test_db       | t          | PRIMARY    | 2021-10-09 00:34:44 | size         |          1 |        NULL | Number of pages in the index      |
			| test_db       | t          | c          | 2021-10-09 00:34:44 | n_diff_pfx01 |          2 |           1 | c                                 |
			| test_db       | t          | c          | 2021-10-09 00:34:44 | n_diff_pfx02 |          2 |           1 | c,id                              |
			| test_db       | t          | c          | 2021-10-09 00:34:44 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
			| test_db       | t          | c          | 2021-10-09 00:34:44 | size         |          1 |        NULL | Number of pages in the index      |
			+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
			7 rows in set (0.00 sec)
			
			-- 纯insert操作，统计信息会有变化。
			
		----------------------------------------------------------------------------------------------------------------------------------------------------

2. 先创建表并且插入数据过20秒再看统计信息

	select now();

	drop table  if exists t;
	CREATE TABLE `t` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

	insert into t(c,d) values(1,1);
	insert into t(c,d) values(2,2);
	insert into t(c,d) values(3,3);
	insert into t(c,d) values(4,4);
	insert into t(c,d) values(5,5);
	insert into t(c,d) values(6,6);
	insert into t(c,d) values(7,7);
	insert into t(c,d) values(8,8);
	insert into t(c,d) values(9,9);
	insert into t(c,d) values(10,10);
	insert into t(c,d) values(11,11);
	insert into t(c,d) values(12,12);
	insert into t(c,d) values(13,13);
	insert into t(c,d) values(14,14);
	insert into t(c,d) values(15,15);

	select * from mysql.innodb_table_stats  where database_name='test_db' and table_name = 't';
	select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 't';


		mysql> select now();
		+---------------------+
		| now()               |
		+---------------------+
		| 2021-10-09 00:59:56 |
		+---------------------+
		1 row in set (0.00 sec)

		mysql> select * from mysql.innodb_table_stats  where database_name='test_db' and table_name = 't';
		+---------------+------------+---------------------+--------+----------------------+--------------------------+
		| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
		+---------------+------------+---------------------+--------+----------------------+--------------------------+
		| test_db       | t          | 2021-10-09 00:59:56 |      2 |                    1 |                        1 |
		+---------------+------------+---------------------+--------+----------------------+--------------------------+
		1 row in set (0.01 sec)

		mysql> select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 't';
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| test_db       | t          | PRIMARY    | 2021-10-09 00:59:56 | n_diff_pfx01 |          2 |           1 | id                                |
		| test_db       | t          | PRIMARY    | 2021-10-09 00:59:56 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
		| test_db       | t          | PRIMARY    | 2021-10-09 00:59:56 | size         |          1 |        NULL | Number of pages in the index      |
		| test_db       | t          | c          | 2021-10-09 00:59:56 | n_diff_pfx01 |          2 |           1 | c                                 |
		| test_db       | t          | c          | 2021-10-09 00:59:56 | n_diff_pfx02 |          2 |           1 | c,id                              |
		| test_db       | t          | c          | 2021-10-09 00:59:56 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
		| test_db       | t          | c          | 2021-10-09 00:59:56 | size         |          1 |        NULL | Number of pages in the index      |
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		7 rows in set (0.00 sec)
		
		-- 过20秒左右再看
		
		mysql> select * from mysql.innodb_table_stats  where database_name='test_db' and table_name = 't';
		+---------------+------------+---------------------+--------+----------------------+--------------------------+
		| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
		+---------------+------------+---------------------+--------+----------------------+--------------------------+
		| test_db       | t          | 2021-10-09 01:00:06 |     15 |                    1 |                        1 |
		+---------------+------------+---------------------+--------+----------------------+--------------------------+
		1 row in set (0.00 sec)

		mysql> select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 't';
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| test_db       | t          | PRIMARY    | 2021-10-09 01:00:06 | n_diff_pfx01 |         15 |           1 | id                                |
		| test_db       | t          | PRIMARY    | 2021-10-09 01:00:06 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
		| test_db       | t          | PRIMARY    | 2021-10-09 01:00:06 | size         |          1 |        NULL | Number of pages in the index      |
		| test_db       | t          | c          | 2021-10-09 01:00:06 | n_diff_pfx01 |         15 |           1 | c                                 |
		| test_db       | t          | c          | 2021-10-09 01:00:06 | n_diff_pfx02 |         15 |           1 | c,id                              |
		| test_db       | t          | c          | 2021-10-09 01:00:06 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
		| test_db       | t          | c          | 2021-10-09 01:00:06 | size         |          1 |        NULL | Number of pages in the index      |
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		7 rows in set (0.00 sec)


3. 表已经有15行记录再插入15行记录后是否会更新统计信息

	select now();
	
	drop table  if exists t1;
	CREATE TABLE `t1` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

	
	insert into t1(c,d) select c,d from t;

	select count(*) from t;
	select count(*) from t1;

	select * from mysql.innodb_table_stats  where database_name='test_db' and table_name = 't';
	select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 't';

		mysql> select now();
		+---------------------+
		| now()               |
		+---------------------+
		| 2021-10-09 01:02:20 |
		+---------------------+
		1 row in set (0.00 sec)


		mysql> select * from mysql.innodb_table_stats  where database_name='test_db' and table_name = 't';
		+---------------+------------+---------------------+--------+----------------------+--------------------------+
		| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
		+---------------+------------+---------------------+--------+----------------------+--------------------------+
		| test_db       | t          | 2021-10-09 01:00:06 |     15 |                    1 |                        1 |
		+---------------+------------+---------------------+--------+----------------------+--------------------------+
		1 row in set (0.01 sec)

		mysql> select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 't';
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| test_db       | t          | PRIMARY    | 2021-10-09 01:00:06 | n_diff_pfx01 |         15 |           1 | id                                |
		| test_db       | t          | PRIMARY    | 2021-10-09 01:00:06 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
		| test_db       | t          | PRIMARY    | 2021-10-09 01:00:06 | size         |          1 |        NULL | Number of pages in the index      |
		| test_db       | t          | c          | 2021-10-09 01:00:06 | n_diff_pfx01 |         15 |           1 | c                                 |
		| test_db       | t          | c          | 2021-10-09 01:00:06 | n_diff_pfx02 |         15 |           1 | c,id                              |
		| test_db       | t          | c          | 2021-10-09 01:00:06 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
		| test_db       | t          | c          | 2021-10-09 01:00:06 | size         |          1 |        NULL | Number of pages in the index      |
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		7 rows in set (0.00 sec)


	-- 再插入15行记录
	
	select now();
	insert into t(c,d) select c,d from t1;
	select * from mysql.innodb_table_stats  where database_name='test_db' and table_name = 't';
	select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 't';

		mysql> select now();
		+---------------------+
		| now()               |
		+---------------------+
		| 2021-10-09 01:04:34 |
		+---------------------+
		1 row in set (0.00 sec)

		mysql> insert into t(c,d) select c,d from t1;
		Query OK, 15 rows affected (0.02 sec)

		mysql> select * from mysql.innodb_table_stats  where database_name='test_db' and table_name = 't';
		+---------------+------------+---------------------+--------+----------------------+--------------------------+
		| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
		+---------------+------------+---------------------+--------+----------------------+--------------------------+
		| test_db       | t          | 2021-10-09 01:04:34 |     30 |                    1 |                        1 |
		+---------------+------------+---------------------+--------+----------------------+--------------------------+
		1 row in set (0.00 sec)

		mysql> select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 't';
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| test_db       | t          | PRIMARY    | 2021-10-09 01:04:34 | n_diff_pfx01 |         30 |           1 | id                                |
		| test_db       | t          | PRIMARY    | 2021-10-09 01:04:34 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
		| test_db       | t          | PRIMARY    | 2021-10-09 01:04:34 | size         |          1 |        NULL | Number of pages in the index      |
		| test_db       | t          | c          | 2021-10-09 01:04:34 | n_diff_pfx01 |         15 |           1 | c                                 |
		| test_db       | t          | c          | 2021-10-09 01:04:34 | n_diff_pfx02 |         30 |           1 | c,id                              |
		| test_db       | t          | c          | 2021-10-09 01:04:34 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
		| test_db       | t          | c          | 2021-10-09 01:04:34 | size         |          1 |        NULL | Number of pages in the index      |
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		7 rows in set (0.00 sec)


	-- 30秒后再看统计信息的更新时间
	select now();
	select * from mysql.innodb_table_stats  where database_name='test_db' and table_name = 't';
	select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 't';

		mysql> select now();
		+---------------------+
		| now()               |
		+---------------------+
		| 2021-10-09 01:05:07 |
		+---------------------+
		1 row in set (0.00 sec)

		mysql> select * from mysql.innodb_table_stats  where database_name='test_db' and table_name = 't';
		+---------------+------------+---------------------+--------+----------------------+--------------------------+
		| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
		+---------------+------------+---------------------+--------+----------------------+--------------------------+
		| test_db       | t          | 2021-10-09 01:04:34 |     30 |                    1 |                        1 |
		+---------------+------------+---------------------+--------+----------------------+--------------------------+
		1 row in set (0.00 sec)

		mysql> select * from mysql.innodb_index_stats  where database_name='test_db' and table_name = 't';
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| test_db       | t          | PRIMARY    | 2021-10-09 01:04:34 | n_diff_pfx01 |         30 |           1 | id                                |
		| test_db       | t          | PRIMARY    | 2021-10-09 01:04:34 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
		| test_db       | t          | PRIMARY    | 2021-10-09 01:04:34 | size         |          1 |        NULL | Number of pages in the index      |
		| test_db       | t          | c          | 2021-10-09 01:04:34 | n_diff_pfx01 |         15 |           1 | c                                 |
		| test_db       | t          | c          | 2021-10-09 01:04:34 | n_diff_pfx02 |         30 |           1 | c,id                              |
		| test_db       | t          | c          | 2021-10-09 01:04:34 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
		| test_db       | t          | c          | 2021-10-09 01:04:34 | size         |          1 |        NULL | Number of pages in the index      |
		+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
		7 rows in set (0.00 sec)


4. 通过GDB打断点验证表已经有15行记录再插入15行记录后是否会更新统计信息
	-- 初始化表结构和数据
		drop table  if exists t;
		CREATE TABLE `t` (
		  `id` bigint(11) NOT NULL AUTO_INCREMENT,
		  `c` int(11) DEFAULT NULL,
		  `d` int(11) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `c` (`c`)
		) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

		insert into t(c,d) values(1,1);
		insert into t(c,d) values(2,2);
		insert into t(c,d) values(3,3);
		insert into t(c,d) values(4,4);
		insert into t(c,d) values(5,5);
		insert into t(c,d) values(6,6);
		insert into t(c,d) values(7,7);
		insert into t(c,d) values(8,8);
		insert into t(c,d) values(9,9);
		insert into t(c,d) values(10,10);
		insert into t(c,d) values(11,11);
		insert into t(c,d) values(12,12);
		insert into t(c,d) values(13,13);
		insert into t(c,d) values(14,14);
		insert into t(c,d) values(15,15);


		drop table  if exists t1;
		CREATE TABLE `t1` (
		  `id` bigint(11) NOT NULL AUTO_INCREMENT,
		  `c` int(11) DEFAULT NULL,
		  `d` int(11) DEFAULT NULL,
		  PRIMARY KEY (`id`),
		  KEY `c` (`c`)
		) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;


		insert into t1(c,d) select c,d from t;

		select count(*) from t;
		select count(*) from t1;

		mysql> select count(*) from t;
		+----------+
		| count(*) |
		+----------+
		|       15 |
		+----------+
		1 row in set (0.00 sec)

		mysql> select count(*) from t1;
		+----------+
		| count(*) |
		+----------+
		|       15 |
		+----------+
		1 row in set (0.00 sec)


	-- 打断点
	
	
		session A              session B      

		b dict_stats_recalc_pool_add		
							  
							  insert into t(c,d) select c,d from t1;
							  (Blocked)
							  


		(gdb) b dict_stats_recalc_pool_add
		Breakpoint 2 at 0x1bc7fbc: file /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc, line 130.
		(gdb) info b
		Num     Type           Disp Enb Address            What
		1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
			breakpoint already hit 1 time
		2       breakpoint     keep y   0x0000000001bc7fbc in dict_stats_recalc_pool_add(dict_table_t const*) at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:130
		(gdb) bt
		#0  0x00007ff092589ccd in poll () from /lib64/libc.so.6
		#1  0x0000000001661e73 in Mysqld_socket_listener::listen_for_connection_event (this=0x612cad0) at /usr/local/mysql/sql/conn_handler/socket_connection.cc:852
		#2  0x0000000000eab46c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x613f550) at /usr/local/mysql/sql/conn_handler/connection_acceptor.h:66
		#3  0x0000000000ea2eea in mysqld_main (argc=111, argv=0x484a948) at /usr/local/mysql/sql/mysqld.cc:5149
		#4  0x0000000000e9a05d in main (argc=2, argv=0x7ffc44fccf98) at /usr/local/mysql/sql/main.cc:25
		(gdb) c
		Continuing.
		[Switching to Thread 0x7ff06c258700 (LWP 10666)]

		Breakpoint 2, dict_stats_recalc_pool_add (table=0x7ff06802d3f0) at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:130
		130		ut_ad(!srv_read_only_mode);
		(gdb) bt
		#0  dict_stats_recalc_pool_add (table=0x7ff06802d3f0) at /usr/local/mysql/storage/innobase/dict/dict0stats_bg.cc:130
		#1  0x0000000001a10167 in row_update_statistics_if_needed (table=0x7ff06802d3f0) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:1209
		#2  0x0000000001a1176c in row_insert_for_mysql_using_ins_graph (mysql_rec=0x7ff0680281d0 "\371\022", prebuilt=0x7ff06802afd0) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:1833
		#3  0x0000000001a118c5 in row_insert_for_mysql (mysql_rec=0x7ff0680281d0 "\371\022", prebuilt=0x7ff06802afd0) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:1859
		#4  0x00000000018bf0b0 in ha_innobase::write_row (this=0x7ff068027ee0, record=0x7ff0680281d0 "\371\022") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:7598
		#5  0x0000000000f367b1 in handler::ha_write_row (this=0x7ff068027ee0, buf=0x7ff0680281d0 "\371\022") at /usr/local/mysql/sql/handler.cc:8062
		#6  0x0000000001758940 in write_record (thd=0x7ff06800a8c0, table=0x7ff068028b60, info=0x7ff068011140, update=0x7ff0680111b8) at /usr/local/mysql/sql/sql_insert.cc:1873
		#7  0x0000000001759da5 in Query_result_insert::send_data (this=0x7ff0680110f8, values=...) at /usr/local/mysql/sql/sql_insert.cc:2271
		#8  0x00000000014f1233 in end_send (join=0x7ff0689718e8, qep_tab=0x7ff068971fb8, end_of_records=false) at /usr/local/mysql/sql/sql_executor.cc:2927
		#9  0x00000000014edf39 in evaluate_join_record (join=0x7ff0689718e8, qep_tab=0x7ff068971e40) at /usr/local/mysql/sql/sql_executor.cc:1645
		#10 0x00000000014ed379 in sub_select (join=0x7ff0689718e8, qep_tab=0x7ff068971e40, end_of_records=false) at /usr/local/mysql/sql/sql_executor.cc:1297
		#11 0x00000000014ecbfa in do_select (join=0x7ff0689718e8) at /usr/local/mysql/sql/sql_executor.cc:950
		#12 0x00000000014eab61 in JOIN::exec (this=0x7ff0689718e8) at /usr/local/mysql/sql/sql_executor.cc:199
		#13 0x0000000001583b64 in handle_query (thd=0x7ff06800a8c0, lex=0x7ff06800cbe0, result=0x7ff0680110f8, added_options=1342177280, removed_options=0) at /usr/local/mysql/sql/sql_select.cc:184
		#14 0x000000000175c91e in Sql_cmd_insert_select::execute (this=0x7ff068011080, thd=0x7ff06800a8c0) at /usr/local/mysql/sql/sql_insert.cc:3218
		#15 0x0000000001535155 in mysql_execute_command (thd=0x7ff06800a8c0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3596
		#16 0x000000000153a849 in mysql_parse (thd=0x7ff06800a8c0, parser_state=0x7ff06c257690) at /usr/local/mysql/sql/sql_parse.cc:5570
		#17 0x00000000015302d8 in dispatch_command (thd=0x7ff06800a8c0, com_data=0x7ff06c257df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
		#18 0x000000000152f20c in do_command (thd=0x7ff06800a8c0) at /usr/local/mysql/sql/sql_parse.cc:1025
		#19 0x000000000165f7c8 in handle_connection (arg=0x5ef4170) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
		#20 0x0000000001ce7612 in pfs_spawn_thread (arg=0x6310330) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
		#21 0x00007ff0936ceea5 in start_thread () from /lib64/libpthread.so.0
		#22 0x00007ff0925949fd in clone () from /lib64/libc.so.6


							  