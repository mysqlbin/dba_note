

1. RC 隔离级别的加锁单位也是 next-key lock 吗
	
2. ICP 对应加锁的影响

3. 原地更新是怎么加锁的？--加锁。



CREATE TABLE `t2` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `t1` int(10) NOT NULL,
  `t2` int(10) NOT NULL,
  `order_no` varchar(64) NOT NULL DEFAULT '' COMMENT 'order no',
  `status` int(10) NOT NULL COMMENT '状态',
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
  PRIMARY KEY (`ID`),
  KEY `idx_order_no` (`order_no`),
  KEY `idx_status_createtime` (`status`,`createtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


mysql> desc UPDATE t2 SET `status` = 5 WHERE `status` = 0 AND (createtime BETWEEN DATE_SUB(NOW(),INTERVAL 90 MINUTE)  AND DATE_SUB(NOW(),INTERVAL 60 MINUTE));
+----+-------------+-------+------------+-------+-----------------------+-----------------------+---------+-------------+------+----------+------------------------------+
| id | select_type | table | partitions | type  | possible_keys         | key                   | key_len | ref         | rows | filtered | Extra                        |
+----+-------------+-------+------------+-------+-----------------------+-----------------------+---------+-------------+------+----------+------------------------------+
|  1 | UPDATE      | t2    | NULL       | range | idx_status_createtime | idx_status_createtime | 8       | const,const |    1 |   100.00 | Using where; Using temporary |
+----+-------------+-------+------------+-------+-----------------------+-----------------------+---------+-------------+------+----------+------------------------------+
1 row in set (0.01 sec)



范围更新需要临时表做辅助。
更新语句：先查询出来，再更新；意味着查询出来的数据会先放在临时表中做辅助更新。




