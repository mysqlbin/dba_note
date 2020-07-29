
1. 环境
2. 第一次测试	
3. 小结


1. 环境
	mysql> set global sync_binlog=1;
	Query OK, 0 rows affected (0.00 sec)

	mysql> set global innodb_flush_log_at_trx_commit=1;
	Query OK, 0 rows affected (0.00 sec)


	mysql> show global variables like '%sync_binlog%';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| sync_binlog   | 1     |
	+---------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%innodb_flush_log_at_trx_commit%';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| innodb_flush_log_at_trx_commit | 1     |
	+--------------------------------+-------+
	1 row in set (0.00 sec)

	2核CPU
	物理内存4GB
	BP缓冲池大小为2GB
	磁盘类型为 SSD云盘， 200GB

2. 第一次测试

	有自增列做主键
		drop procedure idata;
		delimiter ;;
		create procedure idata()
		begin
		  declare i int;
		  set i=1;
		  while(i<=100000)do
			insert into t_20200728(name, age, ismale, id_card, test1, test2) values(substring(md5(rand()),1,10), i, FLOOR(1 + (RAND() * 100)), substring(md5(rand()),1,30), concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '这里是做普通索引和唯一索引的插入性能对比测试'), concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '这里是做普通索引和唯一索引的插入性能对比测试'));
			set i=i+1;
		  end while;

		end;;
		delimiter ;
		
		drop table t_20200728;
		CREATE TABLE `t_20200728` (
		  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',  
		  `name` varchar(32) not NULL default '',
		  `age` int(11) not NULL default 0,
		  `ismale` tinyint(1) not null default 0,
		  `id_card` varchar(32) not NULL default '',
		  `test1` text COMMENT '',
		  `test2` text COMMENT '',
		  `createTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  PRIMARY KEY (`id`),
		  KEY `idx_age` (`age`),
		  KEY `idx_name` (`name`),
		  KEY `idx_card` (`id_card`),
		  KEY `idx_createTime` (`createTime`)
		) ENGINE=InnoDB;

		mysql> call idata();
		Query OK, 1 row affected (7 min 20.12 sec)

		mysql> select * from mysql.innodb_index_stats  where database_name='niuniu_db' and table_name = 't_20200728';
		+---------------+------------+----------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| database_name | table_name | index_name     | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
		+---------------+------------+----------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| niuniu_db     | t_20200728 | PRIMARY        | 2020-07-28 18:18:52 | n_diff_pfx01 |      92450 |          20 | id                                |
		| niuniu_db     | t_20200728 | PRIMARY        | 2020-07-28 18:18:52 | n_leaf_pages |       2150 |        NULL | Number of leaf pages in the index |
		| niuniu_db     | t_20200728 | PRIMARY        | 2020-07-28 18:18:52 | size         |       2212 |        NULL | Number of pages in the index      |
		| niuniu_db     | t_20200728 | idx_age        | 2020-07-28 18:18:52 | n_diff_pfx01 |      93752 |          20 | age                               |
		| niuniu_db     | t_20200728 | idx_age        | 2020-07-28 18:18:52 | n_leaf_pages |         80 |        NULL | Number of leaf pages in the index |
		| niuniu_db     | t_20200728 | idx_age        | 2020-07-28 18:18:52 | size         |         97 |        NULL | Number of pages in the index      |
		| niuniu_db     | t_20200728 | idx_card       | 2020-07-28 18:18:52 | n_diff_pfx01 |      94800 |          20 | id_card                           |
		| niuniu_db     | t_20200728 | idx_card       | 2020-07-28 18:18:52 | n_diff_pfx02 |      93573 |          20 | id_card,id                        |
		| niuniu_db     | t_20200728 | idx_card       | 2020-07-28 18:18:52 | n_leaf_pages |        323 |        NULL | Number of leaf pages in the index |
		| niuniu_db     | t_20200728 | idx_card       | 2020-07-28 18:18:52 | size         |        417 |        NULL | Number of pages in the index      |
		| niuniu_db     | t_20200728 | idx_createTime | 2020-07-28 18:18:52 | n_diff_pfx01 |      95277 |          20 | createTime                        |
		| niuniu_db     | t_20200728 | idx_createTime | 2020-07-28 18:18:52 | n_diff_pfx02 |      95277 |          20 | createTime,id                     |
		| niuniu_db     | t_20200728 | idx_createTime | 2020-07-28 18:18:52 | n_leaf_pages |         91 |        NULL | Number of leaf pages in the index |
		| niuniu_db     | t_20200728 | idx_createTime | 2020-07-28 18:18:52 | size         |         97 |        NULL | Number of pages in the index      |
		| niuniu_db     | t_20200728 | idx_name       | 2020-07-28 18:18:52 | n_diff_pfx01 |      90541 |          20 | name                              |
		| niuniu_db     | t_20200728 | idx_name       | 2020-07-28 18:18:52 | n_diff_pfx02 |     100266 |          20 | name,id                           |
		| niuniu_db     | t_20200728 | idx_name       | 2020-07-28 18:18:52 | n_leaf_pages |        158 |        NULL | Number of leaf pages in the index |
		| niuniu_db     | t_20200728 | idx_name       | 2020-07-28 18:18:52 | size         |        225 |        NULL | Number of pages in the index      |
		+---------------+------------+----------------+---------------------+--------------+------------+-------------+-----------------------------------+
		18 rows in set (0.00 sec)
		
		
	没有自增列做主键
	
		drop procedure idata;
		delimiter ;;
		create procedure idata()
		begin
		  declare i int;
		  set i=1;
		  while(i<=100000)do
			insert into t_20200729(name, age, ismale, id_card, test1, test2) values(substring(md5(rand()),1,10), i, FLOOR(1 + (RAND() * 100)), substring(md5(rand()),1,30), concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '这里是做普通索引和唯一索引的插入性能对比测试'), concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '这里是做普通索引和唯一索引的插入性能对比测试'));
			set i=i+1;
		  end while;

		end;;
		delimiter ;
	
		drop table t_20200729;
		CREATE TABLE `t_20200729` (
		  `name` varchar(32) not NULL default '',
		  `age` int(11) not NULL default 0,
		  `ismale` tinyint(1) not null default 0,
		  `id_card` varchar(32) not NULL default '',
		  `test1` text COMMENT '',
		  `test2` text COMMENT '',
		  `createTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
		  KEY `idx_age` (`age`),
		  KEY `idx_name` (`name`),
		  KEY `idx_card` (`id_card`),
		  KEY `idx_createTime` (`createTime`)
		) ENGINE=InnoDB;


		mysql> call idata();
		Query OK, 1 row affected (7 min 24.55 sec)

	
		select * from mysql.innodb_index_stats  where database_name='biubiu_db' and table_name = 't_20200729';
		mysql> select * from mysql.innodb_index_stats  where database_name='biubiu_db' and table_name = 't_20200729';
		+---------------+------------+-----------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| database_name | table_name | index_name      | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
		+---------------+------------+-----------------+---------------------+--------------+------------+-------------+-----------------------------------+
		| biubiu_db     | t_20200729 | GEN_CLUST_INDEX | 2020-07-29 15:35:31 | n_diff_pfx01 |      89096 |          20 | DB_ROW_ID                         |
		| biubiu_db     | t_20200729 | GEN_CLUST_INDEX | 2020-07-29 15:35:31 | n_leaf_pages |       2072 |        NULL | Number of leaf pages in the index |
		| biubiu_db     | t_20200729 | GEN_CLUST_INDEX | 2020-07-29 15:35:31 | size         |       2084 |        NULL | Number of pages in the index      |
		| biubiu_db     | t_20200729 | idx_age         | 2020-07-29 15:35:31 | n_diff_pfx01 |      92136 |          20 | age                               |
		| biubiu_db     | t_20200729 | idx_age         | 2020-07-29 15:35:31 | n_diff_pfx02 |      89830 |          20 | age,DB_ROW_ID                     |
		| biubiu_db     | t_20200729 | idx_age         | 2020-07-29 15:35:31 | n_leaf_pages |         88 |        NULL | Number of leaf pages in the index |
		| biubiu_db     | t_20200729 | idx_age         | 2020-07-29 15:35:31 | size         |         97 |        NULL | Number of pages in the index      |
		| biubiu_db     | t_20200729 | idx_card        | 2020-07-29 15:35:31 | n_diff_pfx01 |      86972 |          20 | id_card                           |
		| biubiu_db     | t_20200729 | idx_card        | 2020-07-29 15:35:31 | n_diff_pfx02 |      87618 |          20 | id_card,DB_ROW_ID                 |
		| biubiu_db     | t_20200729 | idx_card        | 2020-07-29 15:35:31 | n_leaf_pages |        340 |        NULL | Number of leaf pages in the index |
		| biubiu_db     | t_20200729 | idx_card        | 2020-07-29 15:35:31 | size         |        417 |        NULL | Number of pages in the index      |
		| biubiu_db     | t_20200729 | idx_createTime  | 2020-07-29 15:35:31 | n_diff_pfx01 |      89476 |          20 | createTime                        |
		| biubiu_db     | t_20200729 | idx_createTime  | 2020-07-29 15:35:31 | n_diff_pfx02 |      91773 |          20 | createTime,DB_ROW_ID              |
		| biubiu_db     | t_20200729 | idx_createTime  | 2020-07-29 15:35:31 | n_leaf_pages |         99 |        NULL | Number of leaf pages in the index |
		| biubiu_db     | t_20200729 | idx_createTime  | 2020-07-29 15:35:31 | size         |        161 |        NULL | Number of pages in the index      |
		| biubiu_db     | t_20200729 | idx_name        | 2020-07-29 15:35:31 | n_diff_pfx01 |      98718 |          20 | name                              |
		| biubiu_db     | t_20200729 | idx_name        | 2020-07-29 15:35:31 | n_diff_pfx02 |      92759 |          20 | name,DB_ROW_ID                    |
		| biubiu_db     | t_20200729 | idx_name        | 2020-07-29 15:35:31 | n_leaf_pages |        188 |        NULL | Number of leaf pages in the index |
		| biubiu_db     | t_20200729 | idx_name        | 2020-07-29 15:35:31 | size         |        225 |        NULL | Number of pages in the index      |
		+---------------+------------+-----------------+---------------------+--------------+------------+-------------+-----------------------------------+
		19 rows in set (0.00 sec)


	
3. 小结
	
	有自增列做主键和没有自增列做主键在插入速度上几乎没区别。
	






-------------------
root@mysqldb 16:49:  [(none)]> select concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '这里是做普通索引和唯一索引的插入性能对比测试');
+------------------------------------------------------------------------------------------------------------------------------------------+
| concat(substring(md5(rand()),1,100), substring(md5(rand()),1,100), '这里是做普通索引和唯一索引的插入性能对比测试') |
+------------------------------------------------------------------------------------------------------------------------------------------+
| 0262f399a384c545da3d73ba640a500cc6a092adfc0c0359f63c12c03a50dc55这里是做普通索引和唯一索引的插入性能对比测试       |
+------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.01 sec)
