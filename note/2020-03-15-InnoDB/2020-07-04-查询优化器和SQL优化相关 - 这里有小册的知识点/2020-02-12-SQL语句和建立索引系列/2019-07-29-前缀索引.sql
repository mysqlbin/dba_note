

mysql> show create table table_testtestlog\G;
*************************** 1. row ***************************
       Table: table_testtestlog
Create Table: CREATE TABLE `table_testtestlog` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `szToken` varchar(64) NOT NULL COMMENT 'clubid-roomid-time-round',
  `tStartTime` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) COMMENT '开始时间',
  `tEndTime` timestamp(3) NULL DEFAULT NULL COMMENT '结束时间',
  PRIMARY KEY (`ID`),
  KEY `idx_szToken` (`szToken`(26))
) ENGINE=InnoDB AUTO_INCREMENT=89088 DEFAULT CHARSET=utf8mb4 COMMENT='';
1 row in set (0.00 sec)

ERROR: 
No query specified

1. 算出这个列上有多少个不同的值：
mysql> select count(distinct szToken) as L from table_testtestlog;
+-------+
| L     |
+-------+
| 89087 |
+-------+
1 row in set (0.26 sec)

2. 设定一个可以接受的损失比例，比如 5%；
mysql> SELECT 89087*0.95;
+------------+
| 89087*0.95 |
+------------+
|   84632.65 |
+------------+
1 row in set (0.00 sec)

设定一个可以接受的损失比例，比如 10%；
mysql> SELECT 89087*0.9;
+-----------+
| 89087*0.9 |
+-----------+
|   80178.3 |
+-----------+
1 row in set (0.00 sec)



3. 找出不小于 L * 95% 的值
select 
  count(distinct left(szToken,20)) as L20,
  count(distinct left(szToken,21)) as L21,
  count(distinct left(szToken,22)) as L22,
  count(distinct left(szToken,23)) as L23,
  count(distinct left(szToken,24)) as L24,
  count(distinct left(szToken,25)) as L25
from table_testtestlog;

mysql> select 
    ->   count(distinct left(szToken,20)) as L20,
    ->   count(distinct left(szToken,21)) as L21,
    ->   count(distinct left(szToken,22)) as L22,
    ->   count(distinct left(szToken,23)) as L23,
    ->   count(distinct left(szToken,24)) as L24,
    ->   count(distinct left(szToken,25)) as L25
    -> from table_testtestlog;
+-------+-------+-------+-------+-------+-------+
| L20   | L21   | L22   | L23   | L24   | L25   |
+-------+-------+-------+-------+-------+-------+
| 74132 | 77279 | 85118 | 85384 | 85941 | 86551 |
+-------+-------+-------+-------+-------+-------+
1 row in set (1.18 sec)

4.建立前缀索引
	L22=85118 不小于并且最近 L * 95%= 84632
	alter table table_testtestlog add index idx_szToken(`szToken`(22));
	


用不到覆盖索引:	
mysql> desc select ID from table_testtestlog where szToken='10010-799240-1554810956-1-1';
+----+-------------+-------------------+------------+------+---------------+-------------+---------+-------+------+----------+-------------+
| id | select_type | table             | partitions | type | possible_keys | key         | key_len | ref   | rows | filtered | Extra       |
+----+-------------+-------------------+------------+------+---------------+-------------+---------+-------+------+----------+-------------+
|  1 | SIMPLE      | table_testtestlog | NULL       | ref  | idx_szToken   | idx_szToken | 106     | const |    1 |   100.00 | Using where |
+----+-------------+-------------------+------------+------+---------------+-------------+---------+-------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)


