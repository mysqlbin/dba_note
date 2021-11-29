


mysql> select version();
+------------+
| version()  |
+------------+
| 5.7.22-log |
+------------+
1 row in set (0.00 sec)


DROP TABLE IF EXISTS `t`;
CREATE TABLE `t` (
  `id` int(11) NOT NULL ,
  `a` int(11) DEFAULT NULL,
  `b` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `a` (`a`),
  KEY `b` (`b`)
) ENGINE=InnoDB;



DROP PROCEDURE IF EXISTS `idata`;
DELIMITER ;;
create procedure idata()
begin
  declare i int;
  set i=1;
  while(i<=100000)do
    insert into t values(i, i, i);
    set i=i+1;
  end while;
end
;;
DELIMITER ;

call idata();


----------------------------------------------------------------------------------------------------------------------
session A 						session B
start transaction with consistent snapshot;
								
								explain select * from t where a between 10000 and 20000;
								delete from t;    --旧版本(undo)是 delete 之前的数据，新版本是标记为 deleted 的数据。
								call idata();
								explain select * from t where a between 10000 and 20000; 
								explain select * from t force index(a) where a between 10000 and 20000; 

commit;
								
								root@mysqldb 12:26:  [test_db]> explain select * from t where a between 10000 and 20000;
								+----+-------------+-------+------------+-------+---------------+------+---------+------+-------+----------+-----------------------+
								| id | select_type | table | partitions | type  | possible_keys | key  | key_len | ref  | rows  | filtered | Extra                 |
								+----+-------------+-------+------------+-------+---------------+------+---------+------+-------+----------+-----------------------+
								|  1 | SIMPLE      | t     | NULL       | range | a             | a    | 5       | NULL | 10001 |   100.00 | Using index condition |
								+----+-------------+-------+------------+-------+---------------+------+---------+------+-------+----------+-----------------------+
								1 row in set, 1 warning (0.00 sec)

								root@mysqldb 12:28:  [test_db]> delete from t;    
								Query OK, 100000 rows affected (0.55 sec)

								root@mysqldb 12:28:  [test_db]> call idata();
								Query OK, 1 row affected (3.55 sec)

								root@mysqldb 12:26:  [test_db]> explain select * from t where a between 10000 and 20000; 
								+----+-------------+-------+------------+------+---------------+------+---------+------+--------+----------+-------------+
								| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows   | filtered | Extra       |
								+----+-------------+-------+------------+------+---------------+------+---------+------+--------+----------+-------------+
								|  1 | SIMPLE      | t     | NULL       | ALL  | a             | NULL | NULL    | NULL | 100255 |    17.95 | Using where |
								+----+-------------+-------+------------+------+---------------+------+---------+------+--------+----------+-------------+
								1 row in set, 1 warning (0.00 sec)
	
								-- 偶现场景，`id` int(11) NOT NULL ,
								-- 必现场景，`id` int(11) NOT NULL AUTO_INCREMENT,
								
								root@mysqldb 12:28:  [test_db]> explain select * from t force index(a) where a between 10000 and 20000; 
								+----+-------------+-------+------------+-------+---------------+------+---------+------+-------+----------+-----------------------+
								| id | select_type | table | partitions | type  | possible_keys | key  | key_len | ref  | rows  | filtered | Extra                 |
								+----+-------------+-------+------------+-------+---------------+------+---------+------+-------+----------+-----------------------+
								|  1 | SIMPLE      | t     | NULL       | range | a             | a    | 5       | NULL | 10001 |   100.00 | Using index condition |
								+----+-------------+-------+------------+-------+---------------+------+---------+------+-------+----------+-----------------------+
								1 row in set, 1 warning (0.00 sec)


								

----------------------------------------------------------------------------------------------------------------------

set long_query_time=0;
delete from t;
call idata();
explain select * from t where a between 10000 and 20000; 
explain select * from t force index(a) where a between 10000 and 20000;

root@mysqldb 11:18:  [test_db]> set long_query_time=0;
Query OK, 0 rows affected (0.00 sec)

root@mysqldb 11:18:  [test_db]> delete from t;
Query OK, 100000 rows affected (0.87 sec)

root@mysqldb 11:18:  [test_db]> call idata();
Query OK, 1 row affected (3.25 sec)

root@mysqldb 11:18:  [test_db]> explain select * from t where a between 10000 and 20000; 
+----+-------------+-------+------------+------+---------------+------+---------+------+--------+----------+-------------+
| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows   | filtered | Extra       |
+----+-------------+-------+------------+------+---------------+------+---------+------+--------+----------+-------------+
|  1 | SIMPLE      | t     | NULL       | ALL  | a             | NULL | NULL    | NULL | 100000 |    18.00 | Using where |
+----+-------------+-------+------------+------+---------------+------+---------+------+--------+----------+-------------+
1 row in set, 1 warning (0.00 sec)

root@mysqldb 12:27:  [test_db]> explain select * from t force index(a) where a between 10000 and 20000;
+----+-------------+-------+------------+-------+---------------+------+---------+------+-------+----------+-----------------------+
| id | select_type | table | partitions | type  | possible_keys | key  | key_len | ref  | rows  | filtered | Extra                 |
+----+-------------+-------+------------+-------+---------------+------+---------+------+-------+----------+-----------------------+
|  1 | SIMPLE      | t     | NULL       | range | a             | a    | 5       | NULL | 18000 |   100.00 | Using index condition |
+----+-------------+-------+------------+-------+---------------+------+---------+------+-------+----------+-----------------------+
1 row in set, 1 warning (0.00 sec)

root@mysqldb 12:27:  [test_db]> show index from t;
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
| t     |          0 | PRIMARY  |            1 | id          | A         |      101293 |     NULL | NULL   |      | BTREE      |         |               |
| t     |          1 | a        |            1 | a           | A         |      101293 |     NULL | NULL   | YES  | BTREE      |         |               |
| t     |          1 | b        |            1 | b           | A         |      101293 |     NULL | NULL   | YES  | BTREE      |         |               |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
3 rows in set (0.00 sec)





----------------------------------------------------------------------------------------------------------------------


主键是直接按照表的行数来估计的。而表的行数，优化器直接用的是 show table status = information_schema.tables 的rows值。

	mysql> show table status like 't'\G;
	*************************** 1. row ***************************
			   Name: t
			 Engine: InnoDB
			Version: 10
		 Row_format: Dynamic
			   Rows: 97739
	 Avg_row_length: 37
		Data_length: 3686400
	Max_data_length: 0
	   Index_length: 3178496
		  Data_free: 4194304
	 Auto_increment: NULL
		Create_time: 2021-03-02 11:38:55
		Update_time: 2021-03-02 11:40:34
		 Check_time: NULL
		  Collation: utf8mb4_general_ci
		   Checksum: NULL
	 Create_options: 
			Comment: 
	1 row in set (0.00 sec)

	mysql> select * from information_schema.tables  where table_schema = 'test_db' and table_name='t'\G;
	*************************** 1. row ***************************
	  TABLE_CATALOG: def
	   TABLE_SCHEMA: test_db
		 TABLE_NAME: t
		 TABLE_TYPE: BASE TABLE
			 ENGINE: InnoDB
			VERSION: 10
		 ROW_FORMAT: Dynamic
		 TABLE_ROWS: 97739
	 AVG_ROW_LENGTH: 37
		DATA_LENGTH: 3686400
	MAX_DATA_LENGTH: 0
	   INDEX_LENGTH: 3178496
		  DATA_FREE: 4194304
	 AUTO_INCREMENT: NULL
		CREATE_TIME: 2021-03-02 11:38:55
		UPDATE_TIME: 2021-03-02 11:40:34
		 CHECK_TIME: NULL
	TABLE_COLLATION: utf8mb4_general_ci
		   CHECKSUM: NULL
	 CREATE_OPTIONS: 
	  TABLE_COMMENT: 
	1 row in set (0.01 sec)


1.为什么没有session A,session B扫描的行数是1W

	由于mysql是使用标记删除来删除记录的,并不从索引和数据文件中真正的删除。
	如果delete和insert中间的间隔相对较小,purge线程还没有来得及清理该记录。
		-- purge 线程清理该记录之后，该记录的空间才可以复用。
	如果主键相同的情况下,新插入的insert会沿用之前删除的delete的记录的空间。
	由于相同的数据量以及表大小,所以导致了统计信息没有变化
	
2.为什么开启了session A,session B扫描行数变成3W

	由于session A开启了一致性读,目的为了保证session A的可重复读,insert只能
	另起炉灶,不能占用delete的空间。所以出现的情况就是delete虽然删除了,但是
	未释放空间,insert又增加了空间。导致统计信息有误
	
	
	
斜面镜子 Bill
问题的思考：
	我理解 session A 开启的事务对 session B的delete操作后的索引数据的统计时效产生了影响，因为需要保证事务A的重复读，在数据页没有实际删除，
	而索引的统计选择了N个数据页，这部分数据页不收到前台事务的影响，所以整体统计值会变大，直接影响了索引选择的准确性。
作者回复: 👍🏿
@斜面镜子 Bill 的评论最接近答案；

-- 把一致性读、索引统计信息的修改机制、delete删除是打删除标记 这些结合起来了。













