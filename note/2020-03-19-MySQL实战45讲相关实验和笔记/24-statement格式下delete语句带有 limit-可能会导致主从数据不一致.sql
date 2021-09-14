


drop table if exists t_20210910;
CREATE TABLE `t_20210910` (
  `id` int(11) NOT NULL,
  `a` int(11) DEFAULT NULL,
  `t_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_a` (`a`),
  KEY `idx_t_modified`(`t_modified`)
) ENGINE=InnoDB;

insert into t_20210910 values(1,1,'2018-11-13');
insert into t_20210910 values(2,2,'2018-11-12');
insert into t_20210910 values(3,3,'2018-11-11');
insert into t_20210910 values(4,4,'2018-11-10');
insert into t_20210910 values(5,5,'2018-11-09');


mysql> select * from t_20210910;
+----+------+---------------------+
| id | a    | t_modified          |
+----+------+---------------------+
|  1 |    1 | 2018-11-13 00:00:00 |
|  2 |    2 | 2018-11-12 00:00:00 |
|  3 |    3 | 2018-11-11 00:00:00 |
|  4 |    4 | 2018-11-10 00:00:00 |
|  5 |    5 | 2018-11-09 00:00:00 |
+----+------+---------------------+
5 rows in set (0.00 sec)


delete from t_20210910 force index(idx_a) where a>=4 and t_modified<='2018-11-10' limit 1;
delete from t_20210910 force index(idx_t_modified) where a>=4 and t_modified<='2018-11-10' limit 1;

mysql> select * from t_20210910 force index(idx_a) where a>=4 and t_modified<='2018-11-10' limit 1;
+----+------+---------------------+
| id | a    | t_modified          |
+----+------+---------------------+
|  4 |    4 | 2018-11-10 00:00:00 |
+----+------+---------------------+
1 row in set (0.05 sec)

mysql> select * from t_20210910 force index(idx_t_modified) where a>=4 and t_modified<='2018-11-10' limit 1;
+----+------+---------------------+
| id | a    | t_modified          |
+----+------+---------------------+
|  5 |    5 | 2018-11-09 00:00:00 |
+----+------+---------------------+
1 row in set (0.00 sec)


statement格式下delete语句带有 limit，可能会出现主备数据不一致的情况。 
	0. 条件：2个以上的条件都是范围更新或者范围删除 同时 语句带有 limit 
	1. 如果 delete 语句使用的是索引 a，那么会根据索引 a 找到第一个满足条件的行，也就是说删除的是 a=4 这一行；
	2. 如果使用的是索引 t_modified，那么删除的就是 t_modified='2018-11-09'也就是 a=5 这一行。
	3. 主库执行SQL 语句用的是索引 a; 备库执行SQL 语句用的是索引 t_modified;
    4. 因此,会造成主备数据不一致的情况发生。
	   
	   