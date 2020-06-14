

用150W行数据测试一下：

1. DDL:
root@mysqldb 09:35: [admin_db]> show create table words\G;
*************************** 1. row ***************************
       Table: words
Create Table: CREATE TABLE `words` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_word` (`word`)
) ENGINE=InnoDB AUTO_INCREMENT=1938094 DEFAULT CHARSET=utf8mb4
1 row in set (0.00 sec)

2. 数据表的总行数:
root@mysqldb 09:35: [admin_db]> select count(*) from words;
+----------+
| count(*) |
+----------+
| 1592727 |
+----------+
1 row in set (0.23 sec)

3. 查看执行计划:
root@mysqldb 19:43:  [admin_db]> desc select word from words order by rand() limit 3;
+----+-------------+-------+------------+-------+---------------+----------+---------+------+---------+----------+----------------------------------------------+
| id | select_type | table | partitions | type  | possible_keys | key      | key_len | ref  | rows    | filtered | Extra                                        |
+----+-------------+-------+------------+-------+---------------+----------+---------+------+---------+----------+----------------------------------------------+
|  1 | SIMPLE      | words | NULL       | index | NULL          | idx_word | 259     | NULL | 1598502 |   100.00 | Using index; Using temporary; Using filesort |
+----+-------------+-------+------------+-------+---------------+----------+---------+------+---------+----------+----------------------------------------------+
1 row in set, 1 warning (0.00 sec)


4. 查看SQL语句随机排序取3条记录所需要的时间:
root@mysqldb 19:41:  [admin_db]> select word from words order by rand() limit 3;
+----------+
| word     |
+----------+
| abc8575  |
| abc13321 |
| abc41990 |
+----------+
3 rows in set (2.91 sec)

root@mysqldb 19:41:  [admin_db]> select word from words order by rand() limit 3;
+-----------+
| word      |
+-----------+
| abc346720 |
| abc153768 |
| abc456048 |
+-----------+
3 rows in set (1.15 sec)

root@mysqldb 19:41:  [admin_db]> select word from words order by rand() limit 3;
+-----------+
| word      |
+-----------+
| abc57708  |
| abc355702 |
| abc44464  |
+-----------+
3 rows in set (1.15 sec)

经过多少测试, 平均所需要时间约为 1.25秒.


select count(*) into @C from words;
set @Y1 = floor(@C * rand());
set @Y2 = floor(@C * rand());
set @Y3 = floor(@C * rand());
select * from words limit @Y1, 1; // 在应用代码里面取 Y1、Y2、Y3 值，拼出 SQL 后执行
select * from words limit @Y2, 1;
select * from words limit @Y3, 1;


#单个处理
select count(*) into @C from words;
set @Y = floor(@C * rand());
set @sql = concat("select * from words limit ", @Y, ",1");
prepare stmt from @sql;
execute stmt;
DEALLOCATE prepare stmt;



#处理全部
select count(*) into @C from words;
set @Y1 = floor(@C * rand());
set @Y2 = floor(@C * rand());
set @Y3 = floor(@C * rand());
set @sql1 = concat("select word from words limit ", @Y1, ",1");
set @sql2 = concat("select word from words limit ", @Y2, ",1");
set @sql3 = concat("select word from words limit ", @Y3, ",1");
prepare stmt1 from @sql1;
execute stmt1;
DEALLOCATE prepare stmt1;

prepare stmt2 from @sql2;
execute stmt2;
DEALLOCATE prepare stmt2;

prepare stmt3 from @sql3;
execute stmt3;
DEALLOCATE prepare stmt3;



select 0.21+0.11+0.24+0.12 = 0.68; 
经过多少测试, 平均所需要时间约为 0.6秒.

查询性能提升一倍. 









