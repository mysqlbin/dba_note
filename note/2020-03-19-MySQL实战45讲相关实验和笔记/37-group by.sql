
group by语句的代价和效率:
	不论是使用内存临时表还是磁盘临时表, group by逻辑都需要构造一个带唯一索引的表, 执行代价都是比较高的; 
	如果表的数据量比较大, group by语句执行起来就会很慢.

group by 语句为什么需要临时表:
	group by的语义逻辑, 是统计不同的值出现的个数; 
	但是, 由于第一行的 id%100的结果是无序的, 因此需要有一个临时表, 来记录并统计结果.
	

sort buffer、内存临时表和 join buffer:
	这三个数据结构都是用来存放语句执行过程中的中间数据，以辅助 SQL语句的执行。
	在排序的时候用到了 sort buffer，在使用 join 语句的时候用到了 join buffer。

	
为什么 group by 会产生 Using filesort？
	
	group  by是做分组，但是group  by分组好之后默认会对结果集做升序排序。

	group by .. order by  null;  就可以消除 filesort; 

先 group by 后 order by,那么 order by 会没有意义 .



	
create table t1(
id int primary key, 
a int,
b int, 
index(a)
);


delimiter ;;
create procedure idata()
begin
  declare i int;

  set i=1;
  while(i<=1000)do
    insert into t1 values(i, i, i);
    set i=i+1;
  end while;
end;;
delimiter ;
call idata();


mysql> desc (select 1000 as f) union (select id from t1 order by id desc limit 2);
+----+--------------+------------+------------+-------+---------------+---------+---------+------+------+----------+-----------------+
| id | select_type  | table      | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra           |
+----+--------------+------------+------------+-------+---------------+---------+---------+------+------+----------+-----------------+
|  1 | PRIMARY      | NULL       | NULL       | NULL  | NULL          | NULL    | NULL    | NULL | NULL |     NULL | No tables used  |
|  2 | UNION        | t1         | NULL       | index | NULL          | PRIMARY | 4       | NULL |    2 |   100.00 | Using index     |
| NULL | UNION RESULT | <union1,2> | NULL       | ALL   | NULL          | NULL    | NULL    | NULL | NULL |     NULL | Using temporary |
+----+--------------+------------+------------+-------+---------------+---------+---------+------+------+----------+-----------------+
3 rows in set, 1 warning (0.00 sec)


union的概念:
	表示取这两个子查询结果的并集;
	并集的意思就是这两个集合加起来，重复的行只保留一行。


	
mysql> desc (select 1000 as f) union all (select id from t1 order by id desc limit 2);
+----+-------------+-------+------------+-------+---------------+---------+---------+------+------+----------+----------------+
| id | select_type | table | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra          |
+----+-------------+-------+------------+-------+---------------+---------+---------+------+------+----------+----------------+
|  1 | PRIMARY     | NULL  | NULL       | NULL  | NULL          | NULL    | NULL    | NULL | NULL |     NULL | No tables used |
|  2 | UNION       | t1    | NULL       | index | NULL          | PRIMARY | 4       | NULL |    2 |   100.00 | Using index    |
+----+-------------+-------+------------+-------+---------------+---------+---------+------+------+----------+----------------+
2 rows in set, 1 warning (0.00 sec)
	
	
	
group by:

select id%10 as m, count(*) as c from t1 group by m;
	
mysql> desc select id%10 as m, count(*) as c from t1 group by m;
+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+----------------------------------------------+
| id | select_type | table | partitions | type  | possible_keys | key  | key_len | ref  | rows | filtered | Extra                                        |
+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+----------------------------------------------+
|  1 | SIMPLE      | t1    | NULL       | index | PRIMARY,a     | a    | 5       | NULL | 1000 |   100.00 | Using index; Using temporary; Using filesort |
+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+----------------------------------------------+
1 row in set, 1 warning (0.00 sec)
	
	
	
100W数据对比 group by 和 group by order by null的查询性能:	
mysql> desc select id%10 as m, count(*) as c from t10 group by m;
+----+-------------+-------+------------+-------+---------------+------+---------+------+--------+----------+----------------------------------------------+
| id | select_type | table | partitions | type  | possible_keys | key  | key_len | ref  | rows   | filtered | Extra                                        |
+----+-------------+-------+------------+-------+---------------+------+---------+------+--------+----------+----------------------------------------------+
|  1 | SIMPLE      | t10   | NULL       | index | PRIMARY,a     | a    | 5       | NULL | 998623 |   100.00 | Using index; Using temporary; Using filesort |
+----+-------------+-------+------------+-------+---------------+------+---------+------+--------+----------+----------------------------------------------+
1 row in set, 1 warning (0.00 sec)

mysql>  select id%10 as m, count(*) as c from t10 group by m;
10 rows in set (0.36 sec)

mysql> select id%10 as m, count(*) as c from t10 group by m order by null;
10 rows in set (0.35 sec)
	
#100W数据对比
mysql> select id%1000 as m, count(*) as c from t10 group by m;
1000 rows in set (6.15 sec)
mysql> select id%1000 as m, count(*) as c from t10 group by m order by null;
1000 rows in set (6.63 sec)	
	
	
1000W数据对比 group by 和 group by order by null的查询性能:	
mysql> desc select id%10 as m, count(*) as c from t1000 group by m;
+----+-------------+-------+------------+-------+---------------+------+---------+------+---------+----------+----------------------------------------------+
| id | select_type | table | partitions | type  | possible_keys | key  | key_len | ref  | rows    | filtered | Extra                                        |
+----+-------------+-------+------------+-------+---------------+------+---------+------+---------+----------+----------------------------------------------+
|  1 | SIMPLE      | t1000 | NULL       | index | PRIMARY,a     | a    | 5       | NULL | 9980686 |   100.00 | Using index; Using temporary; Using filesort |
+----+-------------+-------+------------+-------+---------------+------+---------+------+---------+----------+----------------------------------------------+
1 row in set, 1 warning (0.00 sec)


mysql> select id%10 as m, count(*) as c from t1000 group by m;
+------+---------+
10 rows in set (3.45 sec)


mysql> select id%10 as m, count(*) as c from t1000 group by m order by null;

10 rows in set (3.45 sec)



mysql> select id%1000 as m, count(*) as c from t1000 group by m;
1000 rows in set (1 min 2.01 sec)

mysql> select id%1000 as m, count(*) as c from t1000 group by m order by null;
1000 rows in set (1 min 6.41 sec)


说明了group by分组有10或者1000条记录, group by 之后不管加不加 order by null, 目前看来查询性能是差不多的, 只是说加上 order by null 就可以消除 filesort;	
	
	

group by 优化方法 -- 索引

generated column机制:
    用来实现列数据的关联更新。

alter table t1 add column z int generated always as(id % 10), add index(z);

alter table t10 add column z int generated always as(id % 10), add index(z);
	
alter table t1000 add column z int generated always as(id % 10), add index(z);

表t10即100W数据的表:
mysql> desc select z, count(*) as c from t10 group by z;
+----+-------------+-------+------------+-------+---------------+------+---------+------+--------+----------+-------------+
| id | select_type | table | partitions | type  | possible_keys | key  | key_len | ref  | rows   | filtered | Extra       |
+----+-------------+-------+------------+-------+---------------+------+---------+------+--------+----------+-------------+
|  1 | SIMPLE      | t10   | NULL       | index | z             | z    | 5       | NULL | 973163 |   100.00 | Using index |
+----+-------------+-------+------------+-------+---------------+------+---------+------+--------+----------+-------------+
1 row in set, 1 warning (0.00 sec)

mysql> select z, count(*) as c from t10 group by z;
10 rows in set (0.18 sec)

查询时间缩短1半;


表t1000即1000W数据的表:

mysql> desc select z, count(*) as c from t1000 group by z;
+----+-------------+-------+------------+-------+---------------+------+---------+------+---------+----------+-------------+
| id | select_type | table | partitions | type  | possible_keys | key  | key_len | ref  | rows    | filtered | Extra       |
+----+-------------+-------+------------+-------+---------------+------+---------+------+---------+----------+-------------+
|  1 | SIMPLE      | t1000 | NULL       | index | z             | z    | 5       | NULL | 9979810 |   100.00 | Using index |
+----+-------------+-------+------------+-------+---------------+------+---------+------+---------+----------+-------------+
1 row in set, 1 warning (0.00 sec)

mysql> select z, count(*) as c from t1000 group by z;
10 rows in set (1.64 sec)

查询时间缩短1半;



group by 优化方法 -- 直接排序

desc select SQL_BIG_RESULT id%10 as m, count(*) as c from t10 group by m;

mysql> desc select SQL_BIG_RESULT id%10 as m, count(*) as c from t10 group by m;
+----+-------------+-------+------------+-------+---------------+------+---------+------+--------+----------+-----------------------------+
| id | select_type | table | partitions | type  | possible_keys | key  | key_len | ref  | rows   | filtered | Extra                       |
+----+-------------+-------+------------+-------+---------------+------+---------+------+--------+----------+-----------------------------+
|  1 | SIMPLE      | t10   | NULL       | index | z             | z    | 5       | NULL | 973163 |   100.00 | Using index; Using filesort |
+----+-------------+-------+------------+-------+---------------+------+---------+------+--------+----------+-----------------------------+
1 row in set, 1 warning (0.00 sec)


mysql> select SQL_BIG_RESULT id%10 as m, count(*) as c from t10 group by m;
10 rows in set (0.45 sec)

mysql> select SQL_BIG_RESULT id%1000 as m, count(*) as c from t10 group by m;
1000 rows in set (0.46 sec)



mysql> desc select SQL_BIG_RESULT id%10 as m, count(*) as c from t1000 group by m;
+----+-------------+-------+------------+-------+---------------+------+---------+------+---------+----------+-----------------------------+
| id | select_type | table | partitions | type  | possible_keys | key  | key_len | ref  | rows    | filtered | Extra                       |
+----+-------------+-------+------------+-------+---------------+------+---------+------+---------+----------+-----------------------------+
|  1 | SIMPLE      | t1000 | NULL       | index | z             | z    | 5       | NULL | 9979810 |   100.00 | Using index; Using filesort |
+----+-------------+-------+------------+-------+---------------+------+---------+------+---------+----------+-----------------------------+
1 row in set, 1 warning (0.00 sec)

mysql> select SQL_BIG_RESULT id%10 as m, count(*) as c from t1000 group by m;
+------+---------+
10 rows in set (5.5 sec)


root@mysqldb 17:49:  [archery6]>  desc select  id%1000 as m, count(*) as c from t10 group by m;
+----+-------------+-------+------------+-------+---------------+------+---------+------+--------+----------+----------------------------------------------+
| id | select_type | table | partitions | type  | possible_keys | key  | key_len | ref  | rows   | filtered | Extra                                        |
+----+-------------+-------+------------+-------+---------------+------+---------+------+--------+----------+----------------------------------------------+
|  1 | SIMPLE      | t10   | NULL       | index | PRIMARY,a,z   | a    | 5       | NULL | 973163 |   100.00 | Using index; Using temporary; Using filesort |
+----+-------------+-------+------------+-------+---------------+------+---------+------+--------+----------+----------------------------------------------+
1 row in set, 1 warning (0.00 sec)

root@mysqldb 17:49:  [archery6]>  desc select SQL_BIG_RESULT id%1000 as m, count(*) as c from t10 group by m;
+----+-------------+-------+------------+-------+---------------+------+---------+------+--------+----------+-----------------------------+
| id | select_type | table | partitions | type  | possible_keys | key  | key_len | ref  | rows   | filtered | Extra                       |
+----+-------------+-------+------------+-------+---------------+------+---------+------+--------+----------+-----------------------------+
|  1 | SIMPLE      | t10   | NULL       | index | PRIMARY,a,z   | a    | 5       | NULL | 973163 |   100.00 | Using index; Using filesort |
+----+-------------+-------+------------+-------+---------------+------+---------+------+--------+----------+-----------------------------+
1 row in set, 1 warning (0.00 sec)



