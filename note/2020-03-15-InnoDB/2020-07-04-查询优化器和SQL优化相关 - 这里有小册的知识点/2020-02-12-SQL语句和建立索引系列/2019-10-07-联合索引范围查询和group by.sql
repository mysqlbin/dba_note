

DROP TABLE IF EXISTS `t20191007`;
CREATE TABLE `t20191007` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '账号编号',
  `tableid` int(11) NOT NULL,
  `playerid` int(11) NOT NULL,
   `szEndTime` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_szEndTime_playerid` (`szEndTime`, `playerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `t20191007` VALUES ('1', '1', '1', '2019-09-26 20:38:35');
INSERT INTO `t20191007` VALUES ('2', '2', '2', '2019-09-30 20:38:43');
INSERT INTO `t20191007` VALUES ('3', '3', '3', '2019-09-30 20:38:57');


mysql> desc select playerid from t20191007 where szEndTime >= '2019-09-28 00:00:00' and szEndTime < '2019-09-29 23:59:59' group by playerid;
+----+-------------+-----------+------------+-------+------------------------+------------------------+---------+------+------+----------+-----------------------------------------------------------+
| id | select_type | table     | partitions | type  | possible_keys          | key                    | key_len | ref  | rows | filtered | Extra                                                     |
+----+-------------+-----------+------------+-------+------------------------+------------------------+---------+------+------+----------+-----------------------------------------------------------+
|  1 | SIMPLE      | t20191007 | NULL       | range | idx_szEndTime_playerid | idx_szEndTime_playerid | 4       | NULL |    1 |   100.00 | Using where; Using index; Using temporary; Using filesort |
+----+-------------+-----------+------------+-------+------------------------+------------------------+---------+------+------+----------+-----------------------------------------------------------+
1 row in set, 1 warning (0.00 sec)


两列组成的联合索引，最左列为范围查询，group by 为第二列 会产生 Using temporary、Using filesort


两列组成的联合索引，第一列作为where条件的范围查询 ， 为什么 group by 为第二列 会产生 Using temporary、Using filesort？
    这里主要是对联合索引更深入的理解
	索引 (`szEndTime`, `playerid`) 的组织是先按 szEndTime 排序，再按 playerid 排序，同时记录主键
    非最左列的天然有序， 是指 当第一列是等值查询的时候，对应的第二列才是天然有序的。 （丁奇的 MySQL 实战45讲 中有提到）
	
为什么 group by 会产生 filesort？
    Using temporary、Using filesort 同时出现，是指使用了临时表，并且在临时表上进行排序。
	
	
	
降序索引可以优化这个 Using temporary; Using filesort 吗


DROP TABLE IF EXISTS `t20191007`;
CREATE TABLE `t20191007` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '账号编号',
  `tableid` int(11) NOT NULL,
  `playerid` int(11) NOT NULL,
   `szEndTime` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_szEndTime_playerid` (`szEndTime`, `playerid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



INSERT INTO `t20191007` VALUES ('1', '1', '1', '2019-09-26 20:38:35');
INSERT INTO `t20191007` VALUES ('2', '2', '2', '2019-09-30 20:38:43');
INSERT INTO `t20191007` VALUES ('3', '2', '5', '2019-09-30 20:38:43');
INSERT INTO `t20191007` VALUES ('4', '3', '2', '2019-09-30 20:38:57');
INSERT INTO `t20191007` VALUES ('5', '3', '6', '2019-09-30 20:38:59');


idx_szEndTime_playerid：
	szEndTime           playerid
	2019-09-26 20:38:35  1
	2019-09-30 20:38:43  2
	2019-09-30 20:38:43  5
	2019-09-30 20:38:57  2
	2019-09-30 20:38:59  6
	
	
	