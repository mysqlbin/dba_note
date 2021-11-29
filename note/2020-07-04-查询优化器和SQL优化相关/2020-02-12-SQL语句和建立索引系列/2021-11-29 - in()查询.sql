




假如要查 A in () AND B in (), 怎么建索引?

where A in (a,b,c) AND B in (x,y,z)
会转成
 
(A=a and B=x) or (A=a and B=y) or (A=a and B=z) or
(A=b and B=x) or (A=b and B=y) or (A=b and B=z) or
(A=c and B=x) or (A=c and B=y) or (A=c and B=z)


借助 show warnings; 命令就可以看到 A in (a, b, c) 会转成  A=a or A=b or A=c


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
  while(i<=1000)do
    insert into t values(i, i, i);
    set i=i+1;
  end while;
end
;;
DELIMITER ;

call idata();




mysql> select version();
+-----------+
| version() |
+-----------+
| 8.0.18    |
+-----------+
1 row in set (0.00 sec)

	select * from t where a in(5,4,1);

	mysql> desc select * from t where a in(5,4,1);
	+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-----------------------+
	| id | select_type | table | partitions | type  | possible_keys | key  | key_len | ref  | rows | filtered | Extra                 |
	+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-----------------------+
	|  1 | SIMPLE      | t     | NULL       | range | a             | a    | 5       | NULL |    3 |   100.00 | Using index condition |
	+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-----------------------+
	1 row in set, 1 warning (0.00 sec)

	mysql> show warnings\G;
	*************************** 1. row ***************************
	  Level: Note
	   Code: 1003
	Message: /* select#1 */ select `sbtest`.`t`.`id` AS `id`,`sbtest`.`t`.`a` AS `a`,`sbtest`.`t`.`b` AS `b` from `sbtest`.`t` where (`sbtest`.`t`.`a` in (5,4,1))
	1 row in set (0.00 sec)


mysql> select version();
+------------------+
| version()        |
+------------------+
| 5.7.26-debug-log |
+------------------+
1 row in set (0.00 sec)

	mysql> desc select * from t where a in(5,4,1);
	+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-----------------------+
	| id | select_type | table | partitions | type  | possible_keys | key  | key_len | ref  | rows | filtered | Extra                 |
	+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-----------------------+
	|  1 | SIMPLE      | t     | NULL       | range | a             | a    | 5       | NULL |    3 |   100.00 | Using index condition |
	+----+-------------+-------+------------+-------+---------------+------+---------+------+------+----------+-----------------------+
	1 row in set, 1 warning (0.00 sec)

	mysql>  show warnings\G;
	*************************** 1. row ***************************
	  Level: Note
	   Code: 1003
	Message: /* select#1 */ select `test_db`.`t`.`id` AS `id`,`test_db`.`t`.`a` AS `a`,`test_db`.`t`.`b` AS `b` from `test_db`.`t` where (`test_db`.`t`.`a` in (5,4,1))
	1 row in set (0.00 sec)



-----------------------------------------------------------------------------------------------------------------------------------------------------

select * from T where id in (a,b,d,c,e,f); id是主键。

1、为什么查询出来的结果集会按照id排一次序呢（是跟去重有关系么）？

2、如果 in 里面的值较多的时候，就会比较慢啊（是还不如全表扫描么）？问我们公司很多后端的，都不太清楚，问我们DBA，他说默认就是这样（这不跟没说一样吗）。



作者回复: 
	1. 优化器会排个序，目的是如果这几个记录对应的数据都不在内存里，可以触发顺序读盘，后面文章我们介绍到join的时候，会提到MRR，你关注下

	2. in里面值多就是多次执行树搜索，跟全表扫描的速度对比，就看in里面的数据个数的比例了。 你的in里面一般多少个value呀	
		主要看总数据量和in里面的数据量之比




