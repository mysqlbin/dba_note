
表结构和记录数
	CREATE TABLE `table_web_loginlog` (
	  `Idx` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
	  `nPlayerId` int(11) NOT NULL,
	  `nClubID` int(11) NOT NULL DEFAULT '0' COMMENT '俱乐部ID',
	  `szNickName` varchar(64) DEFAULT NULL,
	  `nAction` int(11) NOT NULL DEFAULT '0',
	  `szTime` timestamp NULL DEFAULT NULL,
	  `loginIp` varchar(64) DEFAULT NULL,
	  `strRe1` varchar(128) DEFAULT NULL,
	  PRIMARY KEY (`Idx`),
	  KEY `web_loginlog_idx_nPlayerId` (`nPlayerId`),
	  KEY `web_loginlog_idx_szTime` (`szTime`),
	  KEY `idx_loginIp_szTime` (`loginIp`,`szTime`)
	) ENGINE=InnoDB AUTO_INCREMENT=38222414 DEFAULT CHARSET=utf8mb4;


	mysql> SELECT count(*) FROM `table_web_loginlog` WHERE loginIp = '10.66.92.215'  AND sztime > DATE_SUB(NOW(),INTERVAL 3 DAY);
	+----------+
	| count(*) |
	+----------+
	|   445721 |
	+----------+
	1 row in set (0.61 sec)

	mysql> SELECT count(*) FROM `table_web_loginlog`;
	+----------+
	| count(*) |
	+----------+
	| 21774811 |
	+----------+
	1 row in set (14.16 sec)

	
下面的SQL语句如何优化：
	mysql>  desc SELECT count(*) FROM `table_web_loginlog` WHERE loginIp = '10.66.92.215'  AND sztime > DATE_SUB(NOW(),INTERVAL 3 DAY) and nPlayerId != 131473;
	+----+-------------+--------------------+------------+-------+-----------------------------------------------------------------------+--------------------+---------+------+--------+----------+------------------------------------+
	| id | select_type | table              | partitions | type  | possible_keys                                                         | key                | key_len | ref  | rows   | filtered | Extra                              |
	+----+-------------+--------------------+------------+-------+-----------------------------------------------------------------------+--------------------+---------+------+--------+----------+------------------------------------+
	|  1 | SIMPLE      | table_web_loginlog | NULL       | range | web_loginlog_idx_nPlayerId,web_loginlog_idx_szTime,idx_loginIp_szTime | idx_loginIp_szTime | 264     | NULL | 904450 |    51.71 | Using index condition; Using where |
	+----+-------------+--------------------+------------+-------+-----------------------------------------------------------------------+--------------------+---------+------+--------+----------+------------------------------------+
	1 row in set, 1 warning (0.00 sec)


	alter table table_web_loginlog add index idx_loginIp_szTime_nPlayerId(`loginIp`,`szTime`,`nPlayerId`);
	
	
	
	
	desc SELECT count(*) FROM `table_web_loginlog` WHERE loginIp = '192.168.0.209'  AND sztime > DATE_SUB(NOW(),INTERVAL 3 DAY) and nPlayerId != 130590;
	