

1. idx_name(name(2)) 表示只取前2个字符
2. 对比建立完整索引和前缀索引，前缀索引能省下多少的空间
3. 验证前缀索引是否用得上覆盖索引


1. idx_name(name(2)) 表示只取前2个字符

	CREATE TABLE `t` (
	  `nPlayerId` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
	  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '昵称',
	  PRIMARY KEY (`nPlayerId`),
	  KEY `idx_name`(name(2))
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


	INSERT INTO `t` VALUES ('1', '卢建斌');
	INSERT INTO `t` VALUES ('2', 'ttttttttttttt');

			  
	desc select * from t where name='卢建斌';

	mysql>desc select * from t where name='卢建斌';
	+----+-------------+-------+------------+------+---------------+----------+---------+-------+------+----------+-------------+
	| id | select_type | table | partitions | type | possible_keys | key      | key_len | ref   | rows | filtered | Extra       |
	+----+-------------+-------+------------+------+---------------+----------+---------+-------+------+----------+-------------+
	|  1 | SIMPLE      | t     | NULL       | ref  | idx_name      | idx_name | 10      | const |    1 |   100.00 | Using where |
	+----+-------------+-------+------------+------+---------------+----------+---------+-------+------+----------+-------------+
	1 row in set, 1 warning (0.00 sec)

	mysql>desc select * from t where name='ttttttttttttt';
	+----+-------------+-------+------------+------+---------------+----------+---------+-------+------+----------+-------------+
	| id | select_type | table | partitions | type | possible_keys | key      | key_len | ref   | rows | filtered | Extra       |
	+----+-------------+-------+------------+------+---------------+----------+---------+-------+------+----------+-------------+
	|  1 | SIMPLE      | t     | NULL       | ref  | idx_name      | idx_name | 10      | const |    1 |   100.00 | Using where |
	+----+-------------+-------+------------+------+---------------+----------+---------+-------+------+----------+-------------+
	1 row in set, 1 warning (0.00 sec)


	key_len = 10：2*4+2


	 where 条件中 name='ttttttttttttt'; 值的字节数不管有没有大于`idx_name`(name(2))的前2个字符，都是可以用上索引的。
		

---------------------------------------------------------------------------------------------------------------------------------------


对于InnoDB 表，前缀最长可达767字节; 如果启用 innodb_large_prefix 该选项，则前缀最长可为3072字节 

使用索引的列前缀可以使索引文件更小，这可以节省大量磁盘空间并且还可以加快 INSERT操作。


---------------------------


2. 对比建立完整索引和前缀索引，前缀索引能省下多少的空间

--全字段索引
	CREATE TABLE `sbtest2` (
	  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	  `k` int(10) unsigned NOT NULL DEFAULT '0',
	  `c` char(120) NOT NULL DEFAULT '',
	  `pad` char(60) NOT NULL DEFAULT '',
	  PRIMARY KEY (`id`),
	  KEY `idx_c` (`c`)
	) ENGINE=InnoDB AUTO_INCREMENT=1000001 DEFAULT CHARSET=utf8mb4 MAX_ROWS=1000000;

	mysql> alter table sbtest2 add index idx_c(`c`);

	查看sbtest2表 idx_c索引 的大小:

	mysql> select * from information_schema.tables where TABLE_SCHEMA='sbtest' and table_name='sbtest2';
	+---------------+--------------+------------+------------+--------+---------+------------+------------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+-------------+------------+--------------------+----------+------------------+---------------+
	| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | TABLE_TYPE | ENGINE | VERSION | ROW_FORMAT | TABLE_ROWS | AVG_ROW_LENGTH | DATA_LENGTH | MAX_DATA_LENGTH | INDEX_LENGTH | DATA_FREE | AUTO_INCREMENT | CREATE_TIME         | UPDATE_TIME | CHECK_TIME | TABLE_COLLATION    | CHECKSUM | CREATE_OPTIONS   | TABLE_COMMENT |
	+---------------+--------------+------------+------------+--------+---------+------------+------------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+-------------+------------+--------------------+----------+------------------+---------------+
	| def           | sbtest       | sbtest2    | BASE TABLE | InnoDB |      10 | Dynamic    |     986328 |            261 |   257654784 |               0 |    153075712 |   4194304 |        1000001 | 2019-08-19 09:22:14 | NULL        | NULL       | utf8mb4_general_ci |     NULL | max_rows=1000000 |               |
	+---------------+--------------+------------+------------+--------+---------+------------+------------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+-------------+------------+--------------------+----------+------------------+---------------+
	1 row in set (0.00 sec)

	mysql> select concat(round(index_length / 1024 / 1024, 2),'M') from information_schema.tables where TABLE_SCHEMA='sbtest' and table_name='sbtest2';
	+--------------------------------------------------+
	| concat(round(index_length / 1024 / 1024, 2),'M') |
	+--------------------------------------------------+
	| 145.98M                                          |
	+--------------------------------------------------+
	1 row in set (0.00 sec)

	#索引统计信息的更新时间
	mysql> select * from mysql.innodb_table_stats where database_name='sbtest' and table_name='sbtest2';
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	| sbtest        | sbtest2    | 2019-08-19 09:22:14 | 986328 |                15726 |                     9343 |
	+---------------+------------+---------------------+--------+----------------------+--------------------------+
	1 row in set (0.00 sec)


--前缀索引
	1. 算出这个列上有多少个不同的值：
		mysql> select count(distinct c) as L from sbtest2;
		+-------+
		| L     |
		+-------+
		| 999999 |
		+-------+
		1 row in set (0.26 sec)

	2. 设定一个可以接受的损失比例，比如 5%；
		mysql> SELECT 999999*0.95;
		+------------+
		| 999999*0.95|
		+------------+
		|   949999   |
		+------------+
		1 row in set (0.00 sec)

	3. 找出不小于 L * 95% 的值

		select 
		  count(distinct left(c,7)) as L7,
		  count(distinct left(c,10)) as L10
		from sbtest2;

		mysql> select 
			->   count(distinct left(c,7)) as L7,
			->   count(distinct left(c,10)) as L10
			-> from sbtest2;
		+--------+--------+
		| L7     | L10    |
		+--------+--------+
		| 951314 | 999949 |
		+--------+--------+
		1 row in set (3.66 sec)


	4.建立前缀索引
	
		L7=951314 不小于并且最接近 L * 95%= 949999
		alter table sbtest2 drop index idx_c;
		alter table sbtest2 add index idx_c(`c`(7));
		analyze table sbtest2;
		
	5. 索引统计信息的更新时间
		mysql>  select * from mysql.innodb_table_stats where database_name='sbtest' and table_name='sbtest2';
		+---------------+------------+---------------------+--------+----------------------+--------------------------+
		| database_name | table_name | last_update         | n_rows | clustered_index_size | sum_of_other_index_sizes |
		+---------------+------------+---------------------+--------+----------------------+--------------------------+
		| sbtest        | sbtest2    | 2019-08-19 09:57:18 | 986328 |                15726 |                     1251 |
		+---------------+------------+---------------------+--------+----------------------+--------------------------+
		1 row in set (0.00 sec)

	6. 查看	sbtest2表 idx_c索引的大小:
		mysql> select * from information_schema.tables where TABLE_SCHEMA='sbtest' and table_name='sbtest2';
		+---------------+--------------+------------+------------+--------+---------+------------+------------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+-------------+------------+--------------------+----------+------------------+---------------+
		| TABLE_CATALOG | TABLE_SCHEMA | TABLE_NAME | TABLE_TYPE | ENGINE | VERSION | ROW_FORMAT | TABLE_ROWS | AVG_ROW_LENGTH | DATA_LENGTH | MAX_DATA_LENGTH | INDEX_LENGTH | DATA_FREE | AUTO_INCREMENT | CREATE_TIME         | UPDATE_TIME | CHECK_TIME | TABLE_COLLATION    | CHECKSUM | CREATE_OPTIONS   | TABLE_COMMENT |
		+---------------+--------------+------------+------------+--------+---------+------------+------------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+-------------+------------+--------------------+----------+------------------+---------------+
		| def           | sbtest       | sbtest2    | BASE TABLE | InnoDB |      10 | Dynamic    |     986328 |            261 |   257654784 |               0 |     20496384 | 137363456 |        1000001 | 2019-08-19 09:56:29 | NULL        | NULL       | utf8mb4_general_ci |     NULL | max_rows=1000000 |               |
		+---------------+--------------+------------+------------+--------+---------+------------+------------+----------------+-------------+-----------------+--------------+-----------+----------------+---------------------+-------------+------------+--------------------+----------+------------------+---------------+
		1 row in set (0.00 sec)


		mysql> select concat(round(index_length / 1024 / 1024, 2),'M') from information_schema.tables where TABLE_SCHEMA='sbtest' and table_name='sbtest2';
		+--------------------------------------------------+
		| concat(round(index_length / 1024 / 1024, 2),'M') |
		+--------------------------------------------------+
		| 19.55M                                           |
		+--------------------------------------------------+
		1 row in set (0.00 sec)



		mysql> desc select * from sbtest2 where c='99357217743-27579710696-29634161678-68490301784-71286199462-01615674543-02927167839-64721672329-91298439062-10531459749';
		+----+-------------+---------+------------+------+---------------+-------+---------+-------+------+----------+-------------+
		| id | select_type | table   | partitions | type | possible_keys | key   | key_len | ref   | rows | filtered | Extra       |
		+----+-------------+---------+------------+------+---------------+-------+---------+-------+------+----------+-------------+
		|  1 | SIMPLE      | sbtest2 | NULL       | ref  | idx_c         | idx_c | 28      | const |    1 |   100.00 | Using where |
		+----+-------------+---------+------------+------+---------------+-------+---------+-------+------+----------+-------------+
		1 row in set, 1 warning (0.00 sec)


	146M:20M = 146/20 = 7; 节省了约7倍左右的磁盘空间.



3. 验证前缀索引是否用得上覆盖索引

	root@mysqldb 12:14:  [(none)]> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.22-log |
	+------------+
	1 row in set (0.00 sec)

	CREATE TABLE `t_20200729` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID', 
	  `nPlayerId` int(10)  NOT NULL DEFAULT 0 COMMENT 'nPlayerId',
	  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '昵称',
	  PRIMARY KEY (`ID`),
	  KEY `idx_name`(name(5))
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


	INSERT INTO `t_20200729`(`nPlayerId`, `name`) VALUES ('1', 'mysqlbin');
	INSERT INTO `t_20200729`(`nPlayerId`, `name`) VALUES ('2', 'lujianbin');

			  
	mysql> desc select id,name from t_20200729 where name='mysqlbin';
	+----+-------------+------------+------------+------+---------------+----------+---------+-------+------+----------+-------------+
	| id | select_type | table      | partitions | type | possible_keys | key      | key_len | ref   | rows | filtered | Extra       |
	+----+-------------+------------+------------+------+---------------+----------+---------+-------+------+----------+-------------+
	|  1 | SIMPLE      | t_20200729 | NULL       | ref  | idx_name      | idx_name | 22      | const |    1 |   100.00 | Using where |
	+----+-------------+------------+------------+------+---------------+----------+---------+-------+------+----------+-------------+
	1 row in set, 1 warning (0.01 sec)
	
	key_len=22=5*4+2
	
	alter table t_20200729 add index `idx_name`(name), drop index idx_name;
	
	mysql> desc select id,name from t_20200729 where name='mysqlbin';
	+----+-------------+------------+------------+------+---------------+----------+---------+-------+------+----------+-------------+
	| id | select_type | table      | partitions | type | possible_keys | key      | key_len | ref   | rows | filtered | Extra       |
	+----+-------------+------------+------------+------+---------------+----------+---------+-------+------+----------+-------------+
	|  1 | SIMPLE      | t_20200729 | NULL       | ref  | idx_name      | idx_name | 258     | const |    1 |   100.00 | Using index |
	+----+-------------+------------+------------+------+---------------+----------+---------+-------+------+----------+-------------+
	1 row in set, 1 warning (0.00 sec)
