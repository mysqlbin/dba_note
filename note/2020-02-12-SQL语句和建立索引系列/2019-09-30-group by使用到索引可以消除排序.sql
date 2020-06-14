

DROP TABLE IF EXISTS `t20190930`;
CREATE TABLE `t20190930` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '账号编号',
  `tableid` int(11) NOT NULL,
  `playerid` int(11) NOT NULL,
   `szEndTime` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_playerid_tableid_szEndTime` (`playerid`,`tableid`,`szEndTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `t20190930` VALUES ('1', '1', '1', '2019-09-26 20:38:35');
INSERT INTO `t20190930` VALUES ('2', '2', '2', '2019-09-30 20:38:43');
INSERT INTO `t20190930` VALUES ('3', '3', '3', '2019-09-30 20:38:57');

SQL1: 
mysql> desc select playerid from t20190930 where szEndTime >= '2019-09-28 00:00:00' and szEndTime < '2019-09-29 23:59:59' group by playerid;
+----+-------------+-----------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+--------------------------+
| id | select_type | table     | partitions | type  | possible_keys                  | key                            | key_len | ref  | rows | filtered | Extra                    |
+----+-------------+-----------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+--------------------------+
|  1 | SIMPLE      | t20190930 | NULL       | index | idx_playerid_tableid_szEndTime | idx_playerid_tableid_szEndTime | 12      | NULL |    3 |    33.33 | Using where; Using index |
+----+-------------+-----------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+--------------------------+
1 row in set, 1 warning (0.00 sec)

SQL2: 

mysql> desc select playerid from t20190930  group by playerid;
+----+-------------+-----------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+-------------+
| id | select_type | table     | partitions | type  | possible_keys                  | key                            | key_len | ref  | rows | filtered | Extra       |
+----+-------------+-----------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | t20190930 | NULL       | index | idx_playerid_tableid_szEndTime | idx_playerid_tableid_szEndTime | 12      | NULL |    3 |   100.00 | Using index |
+----+-------------+-----------+------------+-------+--------------------------------+--------------------------------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)

SQL3: 
mysql> desc select playerid from t20190930 where playerid=1 and tableid=1 and szEndTime='2019-09-26 20:38:35';
+----+-------------+-----------+------------+------+--------------------------------+--------------------------------+---------+-------------------+------+----------+-------------+
| id | select_type | table     | partitions | type | possible_keys                  | key                            | key_len | ref               | rows | filtered | Extra       |
+----+-------------+-----------+------------+------+--------------------------------+--------------------------------+---------+-------------------+------+----------+-------------+
|  1 | SIMPLE      | t20190930 | NULL       | ref  | idx_playerid_tableid_szEndTime | idx_playerid_tableid_szEndTime | 12      | const,const,const |    1 |   100.00 | Using index |
+----+-------------+-----------+------------+------+--------------------------------+--------------------------------+---------+-------------------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)


三列组成的联合索引，SQL1 中联合索引的最后一列作为where 条件， group by 为第一列， 为什么不会产生 temporary：
	答：因为 SQL1 只用到了 联合索引的playerid列，where条件列并没有用到索引。


mysql> alter table t20190930 add index idx_playerid(`playerid`);
	
mysql> desc select playerid from t20190930 force index(`idx_playerid`) where szEndTime >= '2019-09-28 00:00:00' and szEndTime < '2019-09-29 23:59:59' group by playerid;
+----+-------------+-----------+------------+-------+---------------------------------------------+--------------+---------+------+------+----------+-------------+
| id | select_type | table     | partitions | type  | possible_keys                               | key          | key_len | ref  | rows | filtered | Extra       |
+----+-------------+-----------+------------+-------+---------------------------------------------+--------------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | t20190930 | NULL       | index | idx_playerid_tableid_szEndTime,idx_playerid | idx_playerid | 4       | NULL |    3 |    33.33 | Using where |
+----+-------------+-----------+------------+-------+---------------------------------------------+--------------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)	
