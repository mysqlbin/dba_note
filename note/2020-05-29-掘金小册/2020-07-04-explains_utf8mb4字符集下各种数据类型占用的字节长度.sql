
1. 目的
2. 初始化表结构
3. 执行的SQL语句
4. 各种数据类型
	4.1 char_not_null
	4.2 char_null 
	4.3 varchar_not_null
	4.4 varchar_null
	4.5 timestamp_not_null
	4.6 timestamp_null
	4.7 timestamp_not_null_3
	4.8 timestamp_null_3
	4.9 datetime_not_null
	4.10 datetime_null
	4.11 tinyint_not_null
	4.12 tinyint_null
	4.13 smallint_not_null
	4.14 smallint_null
	4.15 int_not_null
	4.16 int_null
	4.17 bigint_not_null
	4.18 big_null
5. 小结

1. 目的
	utf8mb4字符集下各种数据类型占用的字节长度

2. 初始化表结构
	
	root@mysqldb 22:37:  [test_db]> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.22-log |
	+------------+
	1 row in set (0.00 sec)


	DROP TABLE IF EXISTS `explains_utf8mb4`;
	root@mysqldb 22:17:  [test_db]> show create table explains_utf8mb4\G;
	*************************** 1. row ***************************
		   Table: explains_utf8mb4
	Create Table: CREATE TABLE `explains_utf8mb4` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
	  `char_not_null` char(10) NOT NULL COMMENT 'char_not_null',
	  `char_null` char(10) DEFAULT NULL COMMENT 'char_null',
	  `varchar_not_null` varchar(10) NOT NULL COMMENT 'varchar_not_null',
	  `varchar_null` varchar(10) DEFAULT NULL COMMENT 'varchar_null',
	  `timestamp_not_null` timestamp NOT NULL COMMENT 'timestamp_not_null',
	  `timestamp_null` timestamp NULL DEFAULT NULL COMMENT 'timestamp_null',
	  `timestamp_not_null_3` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT 'timestamp_not_null_3',
	  `timestamp_null_3` timestamp(3) NULL DEFAULT '0000-00-00 00:00:00.000' COMMENT 'timestamp_null_3',
	  `datetime_not_null` datetime NOT NULL COMMENT 'datetime_not_null',
	  `datetime_null` datetime DEFAULT NULL COMMENT 'datetime_null',
	  `tinyint_not_null` tinyint(4) NOT NULL COMMENT 'tinyint_not_null',
	  `tinyint_null` tinyint(4) DEFAULT NULL COMMENT 'tinyint_null',
	  `smallint_not_null` smallint(8) NOT NULL COMMENT 'smallint_not_null',
	  `smallint_null` smallint(8) DEFAULT NULL COMMENT 'smallint_null',
	  `int_not_null` int(11) NOT NULL COMMENT 'int_not_null',
	  `int_null` int(11) DEFAULT NULL COMMENT 'int_null',
	  `bigint_not_null` bigint(20) NOT NULL COMMENT 'bigint_not_null',
	  `big_null` bigint(20) DEFAULT NULL COMMENT 'big_null',
	  PRIMARY KEY (`ID`),
	  KEY `idx_char_not_null` (`char_not_null`),
	  KEY `idx_char_null` (`char_null`),
	  KEY `idx_varchar_not_null` (`varchar_not_null`),
	  KEY `idx_varchar_null` (`varchar_null`),
	  KEY `idx_timestamp_not_null` (`timestamp_not_null`),
	  KEY `idx_timestamp_null` (`timestamp_null`),
	  KEY `idx_timestamp_not_null_3` (`timestamp_not_null_3`),
	  KEY `idx_timestamp_null_3` (`timestamp_null_3`),
	  KEY `idx_datetime_not_null` (`datetime_not_null`),
	  KEY `idx_datetime_null` (`datetime_null`),
	  KEY `idx_tinyint_not_null` (`tinyint_not_null`),
	  KEY `idx_tinyint_null` (`tinyint_null`),
	  KEY `idx_smallint_not_null` (`smallint_not_null`),
	  KEY `idx_smallint_null` (`smallint_null`),
	  KEY `idx_int_not_null` (`int_not_null`),
	  KEY `idx_int_null` (`int_null`),
	  KEY `idx_bigint_not_null` (`bigint_not_null`),
	  KEY `idx_big_null` (`big_null`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
	1 row in set (0.00 sec)

3. 执行的SQL语句

	explain select ID from explains_utf8mb4 where char_not_null='a';
	explain select ID from explains_utf8mb4 where char_null='a';
	explain select ID from explains_utf8mb4 where varchar_not_null='a';
	explain select ID from explains_utf8mb4 where varchar_null='a';
	explain select ID from explains_utf8mb4 where timestamp_not_null='a';
	explain select ID from explains_utf8mb4 where timestamp_null='a';
	explain select ID from explains_utf8mb4 where timestamp_not_null_3='a';
	explain select ID from explains_utf8mb4 where timestamp_null_3='a';
	explain select ID from explains_utf8mb4 where datetime_not_null='a';
	explain select ID from explains_utf8mb4 where datetime_null='a';
	explain select ID from explains_utf8mb4 where tinyint_not_null=1;
	explain select ID from explains_utf8mb4 where tinyint_null=1;
	explain select ID from explains_utf8mb4 where smallint_not_null=1;
	explain select ID from explains_utf8mb4 where smallint_null=1;
	explain select ID from explains_utf8mb4 where int_not_null=1;
	explain select ID from explains_utf8mb4 where int_null=1;
	explain select ID from explains_utf8mb4 where bigint_not_null=1;
	explain select ID from explains_utf8mb4 where big_null=1;


4.1 char_not_null

	root@mysqldb 20:16:  [test_db]> explain select ID from explains_utf8mb4 where char_not_null='a';
	+----+-------------+----------+------------+------+-------------------+-------------------+---------+-------+------+----------+-------------+
	| id | select_type | table    | partitions | type | possible_keys     | key               | key_len | ref   | rows | filtered | Extra       |
	+----+-------------+----------+------------+------+-------------------+-------------------+---------+-------+------+----------+-------------+
	|  1 | SIMPLE      | explains_utf8mb4 | NULL       | ref  | idx_char_not_null | idx_char_not_null | 40      | const |    1 |   100.00 | Using index |
	+----+-------------+----------+------------+------+-------------------+-------------------+---------+-------+------+----------+-------------+
	1 row in set, 1 warning (0.00 sec)

4.2 char_null 

	root@mysqldb 20:16:  [test_db]> explain select ID from explains_utf8mb4 where char_null='a';
	+----+-------------+----------+------------+------+---------------+---------------+---------+-------+------+----------+-------------+
	| id | select_type | table    | partitions | type | possible_keys | key           | key_len | ref   | rows | filtered | Extra       |
	+----+-------------+----------+------------+------+---------------+---------------+---------+-------+------+----------+-------------+
	|  1 | SIMPLE      | explains_utf8mb4 | NULL       | ref  | idx_char_null | idx_char_null | 41      | const |    1 |   100.00 | Using index |
	+----+-------------+----------+------------+------+---------------+---------------+---------+-------+------+----------+-------------+
	1 row in set, 1 warning (0.00 sec)

4.3 varchar_not_null

	root@mysqldb 20:16:  [test_db]> explain select ID from explains_utf8mb4 where varchar_not_null='a';
	+----+-------------+----------+------------+------+----------------------+----------------------+---------+-------+------+----------+-------------+
	| id | select_type | table    | partitions | type | possible_keys        | key                  | key_len | ref   | rows | filtered | Extra       |
	+----+-------------+----------+------------+------+----------------------+----------------------+---------+-------+------+----------+-------------+
	|  1 | SIMPLE      | explains_utf8mb4 | NULL       | ref  | idx_varchar_not_null | idx_varchar_not_null | 42      | const |    1 |   100.00 | Using index |
	+----+-------------+----------+------------+------+----------------------+----------------------+---------+-------+------+----------+-------------+
	1 row in set, 1 warning (0.00 sec)

4.4 varchar_null

	root@mysqldb 20:16:  [test_db]> explain select ID from explains_utf8mb4 where varchar_null='a';
	+----+-------------+----------+------------+------+------------------+------------------+---------+-------+------+----------+-------------+
	| id | select_type | table    | partitions | type | possible_keys    | key              | key_len | ref   | rows | filtered | Extra       |
	+----+-------------+----------+------------+------+------------------+------------------+---------+-------+------+----------+-------------+
	|  1 | SIMPLE      | explains_utf8mb4 | NULL       | ref  | idx_varchar_null | idx_varchar_null | 43      | const |    1 |   100.00 | Using index |
	+----+-------------+----------+------------+------+------------------+------------------+---------+-------+------+----------+-------------+
	1 row in set, 1 warning (0.00 sec)

4.5 timestamp_not_null

	root@mysqldb 20:17:  [test_db]> explain select ID from explains_utf8mb4 where timestamp_not_null='a';
	+----+-------------+----------+------------+------+------------------------+------------------------+---------+-------+------+----------+--------------------------+
	| id | select_type | table    | partitions | type | possible_keys          | key                    | key_len | ref   | rows | filtered | Extra                    |
	+----+-------------+----------+------------+------+------------------------+------------------------+---------+-------+------+----------+--------------------------+
	|  1 | SIMPLE      | explains_utf8mb4 | NULL       | ref  | idx_timestamp_not_null | idx_timestamp_not_null | 4       | const |    1 |   100.00 | Using where; Using index |
	+----+-------------+----------+------------+------+------------------------+------------------------+---------+-------+------+----------+--------------------------+
	1 row in set, 6 warnings (0.00 sec)

4.6 timestamp_null

	root@mysqldb 20:17:  [test_db]> explain select ID from explains_utf8mb4 where timestamp_null='a';
	+----+-------------+----------+------------+------+--------------------+--------------------+---------+-------+------+----------+--------------------------+
	| id | select_type | table    | partitions | type | possible_keys      | key                | key_len | ref   | rows | filtered | Extra                    |
	+----+-------------+----------+------------+------+--------------------+--------------------+---------+-------+------+----------+--------------------------+
	|  1 | SIMPLE      | explains_utf8mb4 | NULL       | ref  | idx_timestamp_null | idx_timestamp_null | 5       | const |    1 |   100.00 | Using where; Using index |
	+----+-------------+----------+------------+------+--------------------+--------------------+---------+-------+------+----------+--------------------------+
	1 row in set, 6 warnings (0.00 sec)

4.7 timestamp_not_null_3

	root@mysqldb 20:19:  [test_db]> explain select ID from explains_utf8mb4 where timestamp_not_null_3='a';
	+----+-------------+----------+------------+------+--------------------------+--------------------------+---------+-------+------+----------+--------------------------+
	| id | select_type | table    | partitions | type | possible_keys            | key                      | key_len | ref   | rows | filtered | Extra                    |
	+----+-------------+----------+------------+------+--------------------------+--------------------------+---------+-------+------+----------+--------------------------+
	|  1 | SIMPLE      | explains_utf8mb4 | NULL       | ref  | idx_timestamp_not_null_3 | idx_timestamp_not_null_3 | 6       | const |    1 |   100.00 | Using where; Using index |
	+----+-------------+----------+------------+------+--------------------------+--------------------------+---------+-------+------+----------+--------------------------+
	1 row in set, 6 warnings (0.01 sec)

4.8 timestamp_null_3

	root@mysqldb 20:19:  [test_db]> explain select ID from explains_utf8mb4 where timestamp_null_3='a';
	+----+-------------+----------+------------+------+----------------------+----------------------+---------+-------+------+----------+--------------------------+
	| id | select_type | table    | partitions | type | possible_keys        | key                  | key_len | ref   | rows | filtered | Extra                    |
	+----+-------------+----------+------------+------+----------------------+----------------------+---------+-------+------+----------+--------------------------+
	|  1 | SIMPLE      | explains_utf8mb4 | NULL       | ref  | idx_timestamp_null_3 | idx_timestamp_null_3 | 7       | const |    1 |   100.00 | Using where; Using index |
	+----+-------------+----------+------------+------+----------------------+----------------------+---------+-------+------+----------+--------------------------+
	1 row in set, 6 warnings (0.00 sec)

4.9 datetime_not_null

	root@mysqldb 20:18:  [test_db]> explain select ID from explains_utf8mb4 where datetime_not_null='a';
	+----+-------------+----------+------------+------+-----------------------+-----------------------+---------+-------+------+----------+--------------------------+
	| id | select_type | table    | partitions | type | possible_keys         | key                   | key_len | ref   | rows | filtered | Extra                    |
	+----+-------------+----------+------------+------+-----------------------+-----------------------+---------+-------+------+----------+--------------------------+
	|  1 | SIMPLE      | explains_utf8mb4 | NULL       | ref  | idx_datetime_not_null | idx_datetime_not_null | 5       | const |    1 |   100.00 | Using where; Using index |
	+----+-------------+----------+------------+------+-----------------------+-----------------------+---------+-------+------+----------+--------------------------+
	1 row in set, 6 warnings (0.00 sec)

4.10 datetime_null

	root@mysqldb 20:18:  [test_db]> explain select ID from explains_utf8mb4 where datetime_null='a';
	+----+-------------+----------+------------+------+-------------------+-------------------+---------+-------+------+----------+--------------------------+
	| id | select_type | table    | partitions | type | possible_keys     | key               | key_len | ref   | rows | filtered | Extra                    |
	+----+-------------+----------+------------+------+-------------------+-------------------+---------+-------+------+----------+--------------------------+
	|  1 | SIMPLE      | explains_utf8mb4 | NULL       | ref  | idx_datetime_null | idx_datetime_null | 6       | const |    1 |   100.00 | Using where; Using index |
	+----+-------------+----------+------------+------+-------------------+-------------------+---------+-------+------+----------+--------------------------+
	1 row in set, 6 warnings (0.00 sec)


4.11 tinyint_not_null

	root@mysqldb 21:53:  [test_db]> explain select ID from explains_utf8mb4 where tinyint_not_null=1;
	+----+-------------+----------+------------+------+----------------------+----------------------+---------+-------+------+----------+-------------+
	| id | select_type | table    | partitions | type | possible_keys        | key                  | key_len | ref   | rows | filtered | Extra       |
	+----+-------------+----------+------------+------+----------------------+----------------------+---------+-------+------+----------+-------------+
	|  1 | SIMPLE      | explains_utf8mb4 | NULL       | ref  | idx_tinyint_not_null | idx_tinyint_not_null | 1       | const |    1 |   100.00 | Using index |
	+----+-------------+----------+------------+------+----------------------+----------------------+---------+-------+------+----------+-------------+
	1 row in set, 1 warning (0.00 sec)

4.12 tinyint_null

	root@mysqldb 21:53:  [test_db]> explain select ID from explains_utf8mb4 where tinyint_null=1;
	+----+-------------+----------+------------+------+------------------+------------------+---------+-------+------+----------+-------------+
	| id | select_type | table    | partitions | type | possible_keys    | key              | key_len | ref   | rows | filtered | Extra       |
	+----+-------------+----------+------------+------+------------------+------------------+---------+-------+------+----------+-------------+
	|  1 | SIMPLE      | explains_utf8mb4 | NULL       | ref  | idx_tinyint_null | idx_tinyint_null | 2       | const |    1 |   100.00 | Using index |
	+----+-------------+----------+------------+------+------------------+------------------+---------+-------+------+----------+-------------+
	1 row in set, 1 warning (0.00 sec)

4.13 smallint_not_null
 
	root@mysqldb 21:53:  [test_db]> explain select ID from explains_utf8mb4 where smallint_not_null=1;
	+----+-------------+----------+------------+------+-----------------------+-----------------------+---------+-------+------+----------+-------------+
	| id | select_type | table    | partitions | type | possible_keys         | key                   | key_len | ref   | rows | filtered | Extra       |
	+----+-------------+----------+------------+------+-----------------------+-----------------------+---------+-------+------+----------+-------------+
	|  1 | SIMPLE      | explains_utf8mb4 | NULL       | ref  | idx_smallint_not_null | idx_smallint_not_null | 2       | const |    1 |   100.00 | Using index |
	+----+-------------+----------+------------+------+-----------------------+-----------------------+---------+-------+------+----------+-------------+
	1 row in set, 1 warning (0.00 sec)

4.14 smallint_null

	root@mysqldb 21:53:  [test_db]> explain select ID from explains_utf8mb4 where smallint_null=1;
	+----+-------------+----------+------------+------+-------------------+-------------------+---------+-------+------+----------+-------------+
	| id | select_type | table    | partitions | type | possible_keys     | key               | key_len | ref   | rows | filtered | Extra       |
	+----+-------------+----------+------------+------+-------------------+-------------------+---------+-------+------+----------+-------------+
	|  1 | SIMPLE      | explains_utf8mb4 | NULL       | ref  | idx_smallint_null | idx_smallint_null | 3       | const |    1 |   100.00 | Using index |
	+----+-------------+----------+------------+------+-------------------+-------------------+---------+-------+------+----------+-------------+
	1 row in set, 1 warning (0.00 sec)

4.15 int_not_null

	root@mysqldb 21:53:  [test_db]> explain select ID from explains_utf8mb4 where int_not_null=1;
	+----+-------------+----------+------------+------+------------------+------------------+---------+-------+------+----------+-------------+
	| id | select_type | table    | partitions | type | possible_keys    | key              | key_len | ref   | rows | filtered | Extra       |
	+----+-------------+----------+------------+------+------------------+------------------+---------+-------+------+----------+-------------+
	|  1 | SIMPLE      | explains_utf8mb4 | NULL       | ref  | idx_int_not_null | idx_int_not_null | 4       | const |    1 |   100.00 | Using index |
	+----+-------------+----------+------------+------+------------------+------------------+---------+-------+------+----------+-------------+
	1 row in set, 1 warning (0.00 sec)

4.16 int_null

	root@mysqldb 21:53:  [test_db]> explain select ID from explains_utf8mb4 where int_null=1;
	+----+-------------+----------+------------+------+---------------+--------------+---------+-------+------+----------+-------------+
	| id | select_type | table    | partitions | type | possible_keys | key          | key_len | ref   | rows | filtered | Extra       |
	+----+-------------+----------+------------+------+---------------+--------------+---------+-------+------+----------+-------------+
	|  1 | SIMPLE      | explains_utf8mb4 | NULL       | ref  | idx_int_null  | idx_int_null | 5       | const |    1 |   100.00 | Using index |
	+----+-------------+----------+------------+------+---------------+--------------+---------+-------+------+----------+-------------+
	1 row in set, 1 warning (0.00 sec)

4.17 bigint_not_null

	root@mysqldb 21:53:  [test_db]> explain select ID from explains_utf8mb4 where bigint_not_null=1;
	+----+-------------+----------+------------+------+---------------------+---------------------+---------+-------+------+----------+-------------+
	| id | select_type | table    | partitions | type | possible_keys       | key                 | key_len | ref   | rows | filtered | Extra       |
	+----+-------------+----------+------------+------+---------------------+---------------------+---------+-------+------+----------+-------------+
	|  1 | SIMPLE      | explains_utf8mb4 | NULL       | ref  | idx_bigint_not_null | idx_bigint_not_null | 8       | const |    1 |   100.00 | Using index |
	+----+-------------+----------+------------+------+---------------------+---------------------+---------+-------+------+----------+-------------+
	1 row in set, 1 warning (0.00 sec)

4.18 big_null

	root@mysqldb 21:53:  [test_db]> explain select ID from explains_utf8mb4 where big_null=1;
	+----+-------------+----------+------------+------+---------------+--------------+---------+-------+------+----------+-------------+
	| id | select_type | table    | partitions | type | possible_keys | key          | key_len | ref   | rows | filtered | Extra       |
	+----+-------------+----------+------------+------+---------------+--------------+---------+-------+------+----------+-------------+
	|  1 | SIMPLE      | explains_utf8mb4 | NULL       | ref  | idx_big_null  | idx_big_null | 9       | const |    1 |   100.00 | Using index |
	+----+-------------+----------+------------+------+---------------+--------------+---------+-------+------+----------+-------------+
	1 row in set, 1 warning (0.00 sec)


5. 小结
	tinyint 1

	smallint 2

	int 4

	bigint 8

	date 3

	char *4 —不用加2，定长

	datetime 5  —若可以为null，再加1，即为6

	null + 1

	varchar * 4 + 2(256 截取)  null再加1 即为+3 

	timestamp 4 —null+1
