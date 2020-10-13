
1. MySQL 版本
2. 有唯一索引并且唯一索引不为NULL
3. 有唯一索引并且唯一索引为NULL
4. 有2个唯一索引并且唯一索引不为NULL
5. 小结
6. 相关参考

1. MySQL 版本
	mysql> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.22-log |
	+------------+
	1 row in set (0.00 sec)


2. 有唯一索引并且唯一索引不为NULL
	drop table t_20200729;
	CREATE TABLE `t_20200729` (
	  `name` varchar(32) not NULL default '',
	  `age` int(11) not NULL default 0,
	  `ismale` tinyint(1) not null default 0,
	  `id_card` varchar(32) not NULL default '',
	  `test1` text COMMENT '',
	  `test2` text COMMENT '',
	  `createTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
	  unique KEY `idx_age` (`age`),
	  KEY `idx_createTime` (`createTime`)
	) ENGINE=InnoDB;

	mysql> select * from mysql.innodb_index_stats  where database_name='audit_db' and table_name = 't_20200729';
	+---------------+------------+----------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name     | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+----------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| audit_db      | t_20200729 | idx_age        | 2020-07-29 15:46:09 | n_diff_pfx01 |          0 |           1 | age                               |
	| audit_db      | t_20200729 | idx_age        | 2020-07-29 15:46:09 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| audit_db      | t_20200729 | idx_age        | 2020-07-29 15:46:09 | size         |          1 |        NULL | Number of pages in the index      |
	| audit_db      | t_20200729 | idx_createTime | 2020-07-29 15:46:09 | n_diff_pfx01 |          0 |           1 | createTime                        |
	| audit_db      | t_20200729 | idx_createTime | 2020-07-29 15:46:09 | n_diff_pfx02 |          0 |           1 | createTime,age                    |
	| audit_db      | t_20200729 | idx_createTime | 2020-07-29 15:46:09 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| audit_db      | t_20200729 | idx_createTime | 2020-07-29 15:46:09 | size         |          1 |        NULL | Number of pages in the index      |
	+---------------+------------+----------------+---------------------+--------------+------------+-------------+-----------------------------------+
	7 rows in set (0.00 sec)
	
	-- 选择了 age列 作为主键。
	

3. 有唯一索引并且唯一索引为NULL
	drop table t_20200729;
	CREATE TABLE `t_20200729` (
	  `name` varchar(32) not NULL default '',
	  `age` int(11)  default NULL,
	  `ismale` tinyint(1) not null default 0,
	  `id_card` varchar(32) not NULL default '',
	  `test1` text COMMENT '',
	  `test2` text COMMENT '',
	  `createTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
	  unique KEY `idx_age` (`age`),
	  KEY `idx_createTime` (`createTime`)
	) ENGINE=InnoDB;

	mysql> select * from mysql.innodb_index_stats  where database_name='audit_db' and table_name = 't_20200729';
	+---------------+------------+-----------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name      | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+-----------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| audit_db      | t_20200729 | GEN_CLUST_INDEX | 2020-07-29 15:47:21 | n_diff_pfx01 |          0 |           1 | DB_ROW_ID                         |
	| audit_db      | t_20200729 | GEN_CLUST_INDEX | 2020-07-29 15:47:21 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| audit_db      | t_20200729 | GEN_CLUST_INDEX | 2020-07-29 15:47:21 | size         |          1 |        NULL | Number of pages in the index      |
	| audit_db      | t_20200729 | idx_age         | 2020-07-29 15:47:21 | n_diff_pfx01 |          0 |           1 | age                               |
	| audit_db      | t_20200729 | idx_age         | 2020-07-29 15:47:21 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| audit_db      | t_20200729 | idx_age         | 2020-07-29 15:47:21 | size         |          1 |        NULL | Number of pages in the index      |
	| audit_db      | t_20200729 | idx_createTime  | 2020-07-29 15:47:21 | n_diff_pfx01 |          0 |           1 | createTime                        |
	| audit_db      | t_20200729 | idx_createTime  | 2020-07-29 15:47:21 | n_diff_pfx02 |          0 |           1 | createTime,DB_ROW_ID              |
	| audit_db      | t_20200729 | idx_createTime  | 2020-07-29 15:47:21 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| audit_db      | t_20200729 | idx_createTime  | 2020-07-29 15:47:21 | size         |          1 |        NULL | Number of pages in the index      |
	+---------------+------------+-----------------+---------------------+--------------+------------+-------------+-----------------------------------+
	10 rows in set (0.00 sec)

	-- 选择了 DB_ROW_ID 作为主键。
	

4. 有2个唯一索引并且唯一索引不为NULL
	
	drop table t_20200729;
	CREATE TABLE `t_20200729` (
	  `name` varchar(32) not NULL default '',
	  `age` int(11) not NULL default 0,
	  `ismale` tinyint(1) not null default 0,
	  `id_card` varchar(32) not NULL default '',
	  `test1` text COMMENT '',
	  `test2` text COMMENT '',
	  `createTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
	  unique KEY `idx_age` (`age`),
	  unique KEY `idx_ismale` (`ismale`),
	  KEY `idx_createTime` (`createTime`)
	) ENGINE=InnoDB;
	
	root@mysqldb 15:51:  [audit_db]> select * from mysql.innodb_index_stats  where database_name='audit_db' and table_name = 't_20200729';
	+---------------+------------+----------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name     | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+----------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| audit_db      | t_20200729 | idx_age        | 2020-07-29 15:51:57 | n_diff_pfx01 |          0 |           1 | age                               |
	| audit_db      | t_20200729 | idx_age        | 2020-07-29 15:51:57 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| audit_db      | t_20200729 | idx_age        | 2020-07-29 15:51:57 | size         |          1 |        NULL | Number of pages in the index      |
	| audit_db      | t_20200729 | idx_createTime | 2020-07-29 15:51:57 | n_diff_pfx01 |          0 |           1 | createTime                        |
	| audit_db      | t_20200729 | idx_createTime | 2020-07-29 15:51:57 | n_diff_pfx02 |          0 |           1 | createTime,age                    |
	| audit_db      | t_20200729 | idx_createTime | 2020-07-29 15:51:57 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| audit_db      | t_20200729 | idx_createTime | 2020-07-29 15:51:57 | size         |          1 |        NULL | Number of pages in the index      |
	| audit_db      | t_20200729 | idx_ismale     | 2020-07-29 15:51:57 | n_diff_pfx01 |          0 |           1 | ismale                            |
	| audit_db      | t_20200729 | idx_ismale     | 2020-07-29 15:51:57 | n_leaf_pages |          1 |        NULL | Number of leaf pages in the index |
	| audit_db      | t_20200729 | idx_ismale     | 2020-07-29 15:51:57 | size         |          1 |        NULL | Number of pages in the index      |
	+---------------+------------+----------------+---------------------+--------------+------------+-------------+-----------------------------------+
	10 rows in set (0.00 sec)

	-- 选择了 age列 作为主键。
	

5. 小结

	1. InnoDB是聚集索引组织表， InnoDB存储引擎表根据主键顺序以索引的形式进行存储。
	
	2. 表有显示的主键，那么这个主键会成为聚集索引
	
	3. 如果表没有显示的主键，那么表的第一个非NULL的唯一索引会成为聚集索引
	
	4. 如果没显示的主键，也没有唯一非NULL的索引，那么会选择6个字节的 DB_ROW_ID 成为聚集索引
	

6. 相关参考

	https://dev.mysql.com/doc/refman/5.7/en/innodb-index-types.html
	https://www.cnblogs.com/duzhentong/p/8639223.html  MySQL聚集索引和非聚集索引

	