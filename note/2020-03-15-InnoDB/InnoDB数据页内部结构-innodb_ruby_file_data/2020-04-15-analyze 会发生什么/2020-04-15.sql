

CREATE TABLE `t_20200415` (
	  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	  `name` varchar(32) NOT NULL default '',
	  PRIMARY KEY (`id`),
	  KEY `idx_name` (`name`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;
	
-- 创建存储过程
DROP PROCEDURE IF EXISTS insertbatch;
CREATE PROCEDURE insertbatch()
BEGIN
DECLARE i INT;
SET i=1;
WHILE(i<=2000) DO
INSERT INTO zst.t_20200415(name)VALUES('lujb');
SET i=i+1; 
END WHILE;
END;

-- 调用存储过程
call insertbatch();
		
		
	
root@localhost [zst]>show index from t_20200415;
+------------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
| Table      | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
+------------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
| t_20200415 |          0 | PRIMARY  |            1 | id          | A         |          89 |     NULL | NULL   |      | BTREE      |         |               |
| t_20200415 |          1 | idx_name |            1 | name        | A         |           1 |     NULL | NULL   |      | BTREE      |         |               |
+------------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
2 rows in set (0.01 sec)




2.2 通过 space-indexes 查看索引信息

	[root@env27 data]# innodb_space -s ibdata1 -T zst/t_20200415 space-indexes
	id          name                            root        fseg        used        allocated   fill_factor 
	329         PRIMARY                         3           internal    1           1           100.00%     
	329         PRIMARY                         3           leaf        5           5           100.00%     
	330         idx_name                        4           internal    1           1           100.00%     
	330         idx_name                        4           leaf        3           3           100.00%   
	
2.3 通过 index-recurse 查看主键的递归索引
	[root@env27 data]#innodb_space -s ibdata1 -T zst/t_20200415 -I PRIMARY index-recurse  > 1.sql

	innodb_space -s ibdata1 -T zst/t_20200415 -I idx_name index-recurse > 2.sql
 
 
2.4 统计某一页中的数据(有多少行)	
	主键索引的根节点
		[root@env27 data]# innodb_space -s ibdata1 -T zst/t_20200415 -p 3 page-records 
		Record 125: (id=1) ?.#5
		Record 138: (id=277) ?.#6
		Record 151: (id=830) ?.#7
		Record 164: (id=1383) ?.#10
		Record 177: (id=1936) ?.#12
		
	辅助索引的根节点
		[root@env27 data]# innodb_space -s ibdata1 -T zst/t_20200415 -p 4 page-records 
		Record 126: (name="lujb") ?.#8
		Record 144: (name="lujb") ?.#9
		Record 162: (name="lujb") ?.#11
		
		
root@localhost [zst]>select * from mysql.innodb_index_stats  where table_name = 't_20200415';
+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
| zst           | t_20200415 | PRIMARY    | 2020-03-31 05:55:23 | n_diff_pfx01 |       2000 |           5 | id                                |
| zst           | t_20200415 | PRIMARY    | 2020-03-31 05:55:23 | n_leaf_pages |          5 |        NULL | Number of leaf pages in the index |
| zst           | t_20200415 | PRIMARY    | 2020-03-31 05:55:23 | size         |          6 |        NULL | Number of pages in the index      |
| zst           | t_20200415 | idx_name   | 2020-03-31 05:55:23 | n_diff_pfx01 |          1 |           3 | name                              |
| zst           | t_20200415 | idx_name   | 2020-03-31 05:55:23 | n_diff_pfx02 |       2000 |           3 | name,id                           |
| zst           | t_20200415 | idx_name   | 2020-03-31 05:55:23 | n_leaf_pages |          3 |        NULL | Number of leaf pages in the index |
| zst           | t_20200415 | idx_name   | 2020-03-31 05:55:23 | size         |          4 |        NULL | Number of pages in the index      |
+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
7 rows in set (0.00 sec)

analyze

	analyze table t_20200415;
	root@localhost [zst]>analyze table t_20200415;
	+----------------+---------+----------+----------+
	| Table          | Op      | Msg_type | Msg_text |
	+----------------+---------+----------+----------+
	| zst.t_20200415 | analyze | status   | OK       |
	+----------------+---------+----------+----------+
	1 row in set (0.04 sec)
	
	root@localhost [zst]>select * from mysql.innodb_index_stats  where table_name = 't_20200415';
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| database_name | table_name | index_name | last_update         | stat_name    | stat_value | sample_size | stat_description                  |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	| zst           | t_20200415 | PRIMARY    | 2020-03-31 06:11:16 | n_diff_pfx01 |       2000 |           5 | id                                |
	| zst           | t_20200415 | PRIMARY    | 2020-03-31 06:11:16 | n_leaf_pages |          5 |        NULL | Number of leaf pages in the index |
	| zst           | t_20200415 | PRIMARY    | 2020-03-31 06:11:16 | size         |          6 |        NULL | Number of pages in the index      |
	| zst           | t_20200415 | idx_name   | 2020-03-31 06:11:16 | n_diff_pfx01 |          1 |           3 | name                              |
	| zst           | t_20200415 | idx_name   | 2020-03-31 06:11:16 | n_diff_pfx02 |       2000 |           3 | name,id                           |
	| zst           | t_20200415 | idx_name   | 2020-03-31 06:11:16 | n_leaf_pages |          3 |        NULL | Number of leaf pages in the index |
	| zst           | t_20200415 | idx_name   | 2020-03-31 06:11:16 | size         |          4 |        NULL | Number of pages in the index      |
	+---------------+------------+------------+---------------------+--------------+------------+-------------+-----------------------------------+
	7 rows in set (0.00 sec)
	
	[root@env27 data]# innodb_space -s ibdata1 -T zst/t_20200415 space-indexes
	id          name                            root        fseg        used        allocated   fill_factor 
	329         PRIMARY                         3           internal    1           1           100.00%     
	329         PRIMARY                         3           leaf        5           5           100.00%     
	330         idx_name                        4           internal    1           1           100.00%     
	330         idx_name                        4           leaf        3           3           100.00
			
		
	root@localhost [zst]>show index from t_20200415;
	+------------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table      | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+------------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| t_20200415 |          0 | PRIMARY  |            1 | id          | A         |        2000 |     NULL | NULL   |      | BTREE      |         |               |
	| t_20200415 |          1 | idx_name |            1 | name        | A         |           1 |     NULL | NULL   |      | BTREE      |         |               |
	+------------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	2 rows in set (0.00 sec)
	
	
	innodb_space -s ibdata1 -T zst/t_20200415 -I PRIMARY index-recurse  > 3.sql
	innodb_space -s ibdata1 -T zst/t_20200415 -I idx_name index-recurse > 4.sql
	
		
	[root@env27 data]# innodb_space -s ibdata1 -T zst/t_20200415 -p 3 page-records 
	Record 125: (id=1) ?.#5
	Record 138: (id=277) ?.#6
	Record 151: (id=830) ?.#7
	Record 164: (id=1383) ?.#10
	Record 177: (id=1936) ?.#12
	[root@env27 data]# innodb_space -s ibdata1 -T zst/t_20200415 -p 4 page-records 
	Record 126: (name="lujb") ?.#8
	Record 144: (name="lujb") ?.#9
	Record 162: (name="lujb") ?.#11
	
	
	

思考：
	analyze table 命令是否会更新 mysql.innodb_table_stats 信息
	会。
	
为什么 analyze table 命令执行速度很快：它只是做了一些索引统计信息的操作：

	