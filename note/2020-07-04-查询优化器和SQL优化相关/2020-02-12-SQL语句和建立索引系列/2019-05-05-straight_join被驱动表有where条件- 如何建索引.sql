
表的DDL和初始化数据
单列索引
联合索引
	根据被驱动列和被驱动表where条件组成的联合索引
	根据被驱动表where条件和被驱动列组成的联合索引
	
表的DDL和初始化数据
CREATE TABLE `t1` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `a` int(11) DEFAULT NULL,
  `b` int(11) DEFAULT NULL,
  `c` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_a` (`a`),
  KEY `idx_c` (`c`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `t2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `a` int(11) DEFAULT NULL,
  `b` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_a` (`a`),
  KEY `idx_d` (`d`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


drop procedure if exists idata ;
delimiter ;;
create procedure idata()
begin
  declare i int;
  set i=1;
  while(i<=50)do
    insert into t1 values(i, i, i, i);
    set i=i+1;
  end while;
end;;
delimiter ;
call idata();


mysql>insert  into t1(a,b,c) select a,b,c from t1;   # 执行到 共有 2803443 条记录


mysql> insert into t2 select * from t1;

mysql> select count(*) from t1;
+----------+
| count(*) |
+----------+
|   619115 |
+----------+
1 row in set (0.10 sec)

mysql> select count(*) from t2;
+----------+
| count(*) |
+----------+
|   587929 |
+----------+
1 row in set (0.11 sec)

mysql>  select count(*) from t1   where t1.c=10;

+----------+
| count(*) |
+----------+
|      329 |
+----------+
1 row in set (0.00 sec)

mysql> select count(*) from t2   where t2.d=10;
+----------+
| count(*) |
+----------+
|     2591 |
+----------+
1 row in set (0.13 sec)






单列索引: 

t2表的 t2.a和t2.d是两个独立的索引
在join查询中，当t2是被驱动表，t2.a是被驱动表列，t2.d是被驱动表的where条件列， 只能用到t2.a这个索引。

# 即被驱动表的连接列和where条件列都是单列索引

mysql> desc select * from t1 straight_join t2  ON t1.a=t2.a where t1.c=10 and t2.d=10;
+----+-------------+-------+------------+------+---------------+-------+---------+-------+------+----------+-------------+
| id | select_type | table | partitions | type | possible_keys | key   | key_len | ref   | rows | filtered | Extra       |
+----+-------------+-------+------------+------+---------------+-------+---------+-------+------+----------+-------------+
|  1 | SIMPLE      | t1    | NULL       | ref  | idx_a,idx_c   | idx_c | 5       | const |  329 |   100.00 | NULL        |
|  1 | SIMPLE      | t2    | NULL       | ref  | idx_a,idx_d   | idx_d | 5       | const | 2591 |     2.86 | Using where |
+----+-------------+-------+------------+------+---------------+-------+---------+-------+------+----------+-------------+
2 rows in set, 1 warning (0.01 sec)

#执行时间:
	852439 rows in set (1.22 sec)
	
# group by
mysql> desc select * from t1 straight_join t2  ON t1.a=t2.a where t1.c=10 and t2.d=10 group by t2.d;
+----+-------------+-------+------------+------+---------------+-------+---------+-------+------+----------+-------------+
| id | select_type | table | partitions | type | possible_keys | key   | key_len | ref   | rows | filtered | Extra       |
+----+-------------+-------+------------+------+---------------+-------+---------+-------+------+----------+-------------+
|  1 | SIMPLE      | t1    | NULL       | ref  | idx_a,idx_c   | idx_c | 5       | const |  329 |   100.00 | NULL        |
|  1 | SIMPLE      | t2    | NULL       | ref  | idx_a,idx_d   | idx_d | 5       | const | 2591 |     2.86 | Using where |
+----+-------------+-------+------------+------+---------------+-------+---------+-------+------+----------+-------------+
2 rows in set, 1 warning (0.00 sec)

#执行时间:
	1 row in set (0.68 sec)


联合索引:


根据被驱动列和被驱动表where条件组成的联合索引： t2.a和t2.d组成的联合索引
	
alter table t2 drop index idx_a, drop index idx_d, add index idx_a_d(`a`,`d`);

mysql> desc select * from t1 straight_join t2  ON t1.a=t2.a where t1.c=10 and t2.d=10;
+----+-------------+-------+------------+------+---------------+---------+---------+----------------+-------+----------+-------------+
| id | select_type | table | partitions | type | possible_keys | key     | key_len | ref            | rows  | filtered | Extra       |
+----+-------------+-------+------------+------+---------------+---------+---------+----------------+-------+----------+-------------+
|  1 | SIMPLE      | t1    | NULL       | ref  | idx_a,idx_c   | idx_c   | 5       | const          |   930 |   100.00 | Using where |
|  1 | SIMPLE      | t2    | NULL       | ref  | idx_a_d       | idx_a_d | 10      | db1.t1.a,const | 18270 |   100.00 | NULL        |
+----+-------------+-------+------------+------+---------------+---------+---------+----------------+-------+----------+-------------+
2 rows in set, 1 warning (0.02 sec)


#执行时间: 
mysql> select * from t1 straight_join t2  ON t1.a=t2.a where t1.c=10 and t2.d=10;

852439 rows in set (1.21 sec)



# group by
mysql> desc select * from t1 straight_join t2  ON t1.a=t2.a where t1.c=10 and t2.d=10 group by t2.d;
+----+-------------+-------+------------+------+---------------+---------+---------+----------------+-------+----------+-------------+
| id | select_type | table | partitions | type | possible_keys | key     | key_len | ref            | rows  | filtered | Extra       |
+----+-------------+-------+------------+------+---------------+---------+---------+----------------+-------+----------+-------------+
|  1 | SIMPLE      | t1    | NULL       | ref  | idx_a,idx_c   | idx_c   | 5       | const          |   329 |   100.00 | Using where |
|  1 | SIMPLE      | t2    | NULL       | ref  | idx_a_d       | idx_a_d | 10      | db1.t1.a,const | 17189 |   100.00 | NULL        |
+----+-------------+-------+------------+------+---------------+---------+---------+----------------+-------+----------+-------------+
2 rows in set, 1 warning (0.00 sec)

#执行时间: 
mysql> select * from t1 straight_join t2  ON t1.a=t2.a where t1.c=10 and t2.d=10 group by t2.d;

+----+------+------+------+----+------+------+------+
| id | a    | b    | c    | id | a    | b    | d    |
+----+------+------+------+----+------+------+------+
| 10 |   10 |   10 |   10 | 10 |   10 |   10 |   10 |
+----+------+------+------+----+------+------+------+
1 row in set (0.68 sec)


联合索引调整顺序:

根据被驱动表where条件和被驱动列组成的联合索引:  t2.d和t2.a组成的联合索引

alter table t2 drop index idx_a_d, add index idx_d_a(`d`,`a`);

mysql> desc select * from t1 straight_join t2  ON t1.a=t2.a where t1.c=10 and t2.d=10;
+----+-------------+-------+------------+------+---------------+---------+---------+----------------+-------+----------+-------------+
| id | select_type | table | partitions | type | possible_keys | key     | key_len | ref            | rows  | filtered | Extra       |
+----+-------------+-------+------------+------+---------------+---------+---------+----------------+-------+----------+-------------+
|  1 | SIMPLE      | t1    | NULL       | ref  | idx_a,idx_c   | idx_c   | 5       | const          |   329 |   100.00 | Using where |
|  1 | SIMPLE      | t2    | NULL       | ref  | idx_d_a       | idx_d_a | 10      | const,db1.t1.a | 16734 |   100.00 | NULL        |
+----+-------------+-------+------------+------+---------------+---------+---------+----------------+-------+----------+-------------+
2 rows in set, 1 warning (0.00 sec)


#执行时间: 
852439 rows in set (1.22 sec)

# group by
mysql> desc select * from t1 straight_join t2  ON t1.a=t2.a where t1.c=10 and t2.d=10 group by t2.d;
+----+-------------+-------+------------+------+---------------+---------+---------+----------------+-------+----------+-------------+
| id | select_type | table | partitions | type | possible_keys | key     | key_len | ref            | rows  | filtered | Extra       |
+----+-------------+-------+------------+------+---------------+---------+---------+----------------+-------+----------+-------------+
|  1 | SIMPLE      | t1    | NULL       | ref  | idx_a,idx_c   | idx_c   | 5       | const          |   329 |   100.00 | Using where |
|  1 | SIMPLE      | t2    | NULL       | ref  | idx_d_a       | idx_d_a | 10      | const,db1.t1.a | 16734 |   100.00 | NULL        |
+----+-------------+-------+------------+------+---------------+---------+---------+----------------+-------+----------+-------------+
2 rows in set, 1 warning (0.00 sec)

#执行时间
mysql> select * from t1 straight_join t2  ON t1.a=t2.a where t1.c=10 and t2.d=10 group by t2.d;
+----+------+------+------+----+------+------+------+
| id | a    | b    | c    | id | a    | b    | d    |
+----+------+------+------+----+------+------+------+
| 10 |   10 |   10 |   10 | 10 |   10 |   10 |   10 |
+----+------+------+------+----+------+------+------+
1 row in set (0.69 sec)





初步结论：
	join查询中，被驱动表如果有where条件列，那么不需要根据被驱动表的连接列和where条件列建立组合索引。
	-- 理解正确。
	
	


mysql> desc select * from t1 straight_join t2  ON t1.a=t2.a where t1.c=10 and t2.d=10;
+----+-------------+-------+------------+------+---------------+-------+---------+-------+------+----------+-------------+
| id | select_type | table | partitions | type | possible_keys | key   | key_len | ref   | rows | filtered | Extra       |
+----+-------------+-------+------------+------+---------------+-------+---------+-------+------+----------+-------------+
|  1 | SIMPLE      | t1    | NULL       | ref  | idx_a,idx_c   | idx_c | 5       | const |  329 |   100.00 | NULL        |
|  1 | SIMPLE      | t2    | NULL       | ref  | idx_a,idx_d   | idx_d | 5       | const | 2591 |     2.86 | Using where |
+----+-------------+-------+------------+------+---------------+-------+---------+-------+------+----------+-------------+
2 rows in set, 1 warning (0.01 sec)



alter table t1 add index idx_a_c(`a`, `c`), drop index idx_a, drop index idx_c;

alter table t2 add index idx_a(`a`),add index idx_d(`d`), drop index idx_d_a;
	
mysql> desc select * from t1 straight_join t2  ON t1.a=t2.a where t1.c=10 and t2.d=10;
+----+-------------+-------+------------+------+---------------+-------+---------+-------+--------+----------+-------------+
| id | select_type | table | partitions | type | possible_keys | key   | key_len | ref   | rows   | filtered | Extra       |
+----+-------------+-------+------------+------+---------------+-------+---------+-------+--------+----------+-------------+
|  1 | SIMPLE      | t1    | NULL       | ALL  | idx_a_c       | NULL  | NULL    | NULL  | 622544 |    10.00 | Using where |
|  1 | SIMPLE      | t2    | NULL       | ref  | idx_a,idx_d   | idx_d | 5       | const |   2591 |     2.86 | Using where |
+----+-------------+-------+------------+------+---------------+-------+---------+-------+--------+----------+-------------+
2 rows in set, 1 warning (0.00 sec)

	