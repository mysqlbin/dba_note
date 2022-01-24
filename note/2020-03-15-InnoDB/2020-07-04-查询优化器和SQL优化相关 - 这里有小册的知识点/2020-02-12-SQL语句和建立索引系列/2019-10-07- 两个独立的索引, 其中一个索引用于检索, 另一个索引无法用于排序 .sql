

DROP TABLE IF EXISTS `t2019100702`;
CREATE TABLE `t2019100702` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '账号编号',
  `tableid` int(11) NOT NULL,
  `playerid` int(11) NOT NULL,
   `szEndTime` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_szEndTime` (`szEndTime`),
  KEY `idx_playerid` (`playerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `t2019100702` VALUES ('1', '1', '1', '2019-09-26 20:38:35');
INSERT INTO `t2019100702` VALUES ('2', '2', '2', '2019-09-30 20:38:43');
INSERT INTO `t2019100702` VALUES ('3', '3', '3', '2019-09-30 20:38:57');


mysql> desc select playerid  from t2019100702 where szEndTime='2019-09-30 20:38:57' group by playerid;
+----+-------------+-------------+------------+------+----------------------------+---------------+---------+-------+------+----------+--------------------------------------------------------+
| id | select_type | table       | partitions | type | possible_keys              | key           | key_len | ref   | rows | filtered | Extra                                                  |
+----+-------------+-------------+------------+------+----------------------------+---------------+---------+-------+------+----------+--------------------------------------------------------+
|  1 | SIMPLE      | t2019100702 | NULL       | ref  | idx_szEndTime,idx_playerid | idx_szEndTime | 4       | const |    1 |   100.00 | Using index condition; Using temporary; Using filesort |
+----+-------------+-------------+------------+------+----------------------------+---------------+---------+-------+------+----------+--------------------------------------------------------+
1 row in set, 1 warning (0.00 sec)



总结：
    验证了两个独立的索引, 其中一个索引用于检索, 另一个索引无法用于排序 。
	
	-- 之前没有理解B+树数据结构，现在理解了。自然也知道这个现象的原因。 by 2022-01-22 
	-- 明白底层原理/工作原理还是有好处的。
	
	