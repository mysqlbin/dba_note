select里用rand()，怎么优化效率？

案例：
select id from t1 where id = round(rand()*13241324);
其中id列是IINT类型的主键

一、问题点
该SQL的问题点主要在于当使用rand()匹配时，实际上是逐行提取数据，rand()每次生成一个随机数进行单行匹配，即如果t1表有100万数据就会匹配100万次，即便有索引也没用，也要全表扫描

二、优化方式
优化方式主要有2种思路，第一种是通过子查询关联，第二种是通过范围查询加limit 1，如下所示：
1、select id from t1 join (select round(rand()*13241324) as id2) as t2 where t1.id = t2.id2

2、select id from t1 where id > (select round(rand()*(select max(id) from t1)) as nid) limit 1

再次提醒，不要用rand()直接进行匹配或者排序，会引发性能灾难

参考：http://imysql.com/2014/07/04/mysql-optimization-case-rand-optimize.shtml



CREATE TABLE `sbtest1` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `k` int(10) unsigned NOT NULL DEFAULT '0',
  `c` char(120) NOT NULL DEFAULT '',
  `pad` char(60) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20521633 DEFAULT CHARSET=utf8mb4 MAX_ROWS=1000000;


mysql> alter table sbtest1 drop primary key;
ERROR 1075 (42000): Incorrect table definition; there can be only one auto column and it must be defined as a key

# 重做主键ID, 让主键ID从1开始
alter table sbtest1 drop id;

alter table sbtest1 add id int(11) not null first;

alter table sbtest1 modify column id int(11) not null auto_increment,add primary key(id);

表的总记录数:
mysql> select count(*) from sbtest1;
+----------+
| count(*) |
+----------+
| 18320632 |
+----------+
1 row in set (3.86 sec)


mysql> desc select id from sbtest1 where id = round(rand()*13241324);
+----+-------------+---------+------------+-------+---------------+---------+---------+------+----------+----------+--------------------------+
| id | select_type | table   | partitions | type  | possible_keys | key     | key_len | ref  | rows     | filtered | Extra                    |
+----+-------------+---------+------------+-------+---------------+---------+---------+------+----------+----------+--------------------------+
|  1 | SIMPLE      | sbtest1 | NULL       | index | NULL          | PRIMARY | 4       | NULL | 18069768 |    10.00 | Using where; Using index |
+----+-------------+---------+------------+-------+---------------+---------+---------+------+----------+----------+--------------------------+
1 row in set, 1 warning (0.00 sec)

# type=index, key=PRIMARY: 表示把主键索引列的值全部扫描一遍

#执行时间
mysql> select id from sbtest1 where id = round(rand()*13241324);
Empty set (5.63 sec)

优化方法1: 
mysql> desc select id from sbtest1 join (select round(rand()*13241324) as id2) as t2 where sbtest1.id = t2.id2;
+----+-------------+------------+------------+--------+---------------+---------+---------+-------+------+----------+----------------+
| id | select_type | table      | partitions | type   | possible_keys | key     | key_len | ref   | rows | filtered | Extra          |
+----+-------------+------------+------------+--------+---------------+---------+---------+-------+------+----------+----------------+
|  1 | PRIMARY     | <derived2> | NULL       | system | NULL          | NULL    | NULL    | NULL  |    1 |   100.00 | NULL           |
|  1 | PRIMARY     | sbtest1    | NULL       | const  | PRIMARY       | PRIMARY | 4       | const |    1 |   100.00 | Using index    |
|  2 | DERIVED     | NULL       | NULL       | NULL   | NULL          | NULL    | NULL    | NULL  | NULL |     NULL | No tables used |
+----+-------------+------------+------------+--------+---------------+---------+---------+-------+------+----------+----------------+
3 rows in set, 1 warning (0.00 sec)

# 查看SQL的执行时间
mysql> select id from sbtest1 join (select round(rand()*13241324) as id2) as t2 where sbtest1.id = t2.id2;
+--------+
| id     |
+--------+
| 714668 |
+--------+
1 row in set (0.00 sec)


优化方法2:
mysql> desc select id from sbtest1 where id > (select round(rand()*(select max(id) from sbtest1)) as nid) limit 1;
+----+-------------+---------+------------+-------+---------------+---------+---------+------+----------+----------+------------------------------+
| id | select_type | table   | partitions | type  | possible_keys | key     | key_len | ref  | rows     | filtered | Extra                        |
+----+-------------+---------+------------+-------+---------------+---------+---------+------+----------+----------+------------------------------+
|  1 | PRIMARY     | sbtest1 | NULL       | index | NULL          | PRIMARY | 4       | NULL | 18069768 |    33.33 | Using where; Using index     |
|  3 | SUBQUERY    | NULL    | NULL       | NULL  | NULL          | NULL    | NULL    | NULL |     NULL |     NULL | Select tables optimized away |
+----+-------------+---------+------------+-------+---------------+---------+---------+------+----------+----------+------------------------------+
2 rows in set, 2 warnings (0.00 sec)

mysql> select id from sbtest1 where id > (select round(rand()*(select max(id) from sbtest1)) as nid) limit 1;
+------+
| id   |
+------+
| 4576 |
+------+
1 row in set (0.00 sec)



