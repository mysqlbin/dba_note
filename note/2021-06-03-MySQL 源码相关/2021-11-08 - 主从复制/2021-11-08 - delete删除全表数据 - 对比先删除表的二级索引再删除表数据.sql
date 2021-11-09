

1. 通过delete删除有普通索引表的所有数据
2. 通过delete删除没有普通索引表的所有数据
3. 耗时对比



1. 通过delete删除有普通索引表的所有数据
	
	mysql> show create table niuniuh5_db.table_web_loginlog_debug\G;
	*************************** 1. row ***************************
		   Table: table_web_loginlog_debug
	Create Table: CREATE TABLE `table_web_loginlog_debug` (
	  `Idx` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
	  `nPlayerId` int(11) NOT NULL,
	  `nClubID` int(11) NOT NULL DEFAULT '0' COMMENT '俱乐部ID',
	  `szNickName` varchar(64) DEFAULT NULL,
	  `nAction` int(11) NOT NULL DEFAULT '0',
	  `szTime` timestamp NULL DEFAULT NULL,
	  `loginIp` varchar(64) DEFAULT NULL,
	  `strRe1` varchar(128) DEFAULT NULL,
	  PRIMARY KEY (`Idx`),
	  KEY `web_loginlog_idx_szTime` (`szTime`),
	  KEY `idx_nPlayerId_szTime` (`nPlayerId`,`szTime`),
	  KEY `idx_loginIp_szTime` (`loginIp`,`szTime`)
	) ENGINE=InnoDB AUTO_INCREMENT=21704304 DEFAULT CHARSET=utf8mb4
	1 row in set (0.00 sec)


	全表删除的记录数
		mysql> select count(*) from niuniuh5_db.table_web_loginlog_debug;
		+----------+
		| count(*) |
		+----------+
		|  5265967 |
		+----------+
		1 row in set (0.83 sec)


	在主库执行 delete from niuniuh5_db.table_web_loginlog_debug;
		mysql> delete from niuniuh5_db.table_web_loginlog_debug;
		Query OK, 5265967 rows affected (1 min 22.07 sec)
		


2. 通过delete删除没有普通索引表的所有数据
	
	alter table niuniuh5_db.table_web_loginlog_debug drop index web_loginlog_idx_szTime,  drop index idx_nPlayerId_szTime,  drop index idx_loginIp_szTime;

	
	mysql> show create table niuniuh5_db.table_web_loginlog_debug\G;
	*************************** 1. row ***************************
		   Table: table_web_loginlog_debug
	Create Table: CREATE TABLE `table_web_loginlog_debug` (
	  `Idx` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键Id',
	  `nPlayerId` int(11) NOT NULL,
	  `nClubID` int(11) NOT NULL DEFAULT '0' COMMENT '俱乐部ID',
	  `szNickName` varchar(64) DEFAULT NULL,
	  `nAction` int(11) NOT NULL DEFAULT '0',
	  `szTime` timestamp NULL DEFAULT NULL,
	  `loginIp` varchar(64) DEFAULT NULL,
	  `strRe1` varchar(128) DEFAULT NULL,
	  PRIMARY KEY (`Idx`)
	) ENGINE=InnoDB AUTO_INCREMENT=21704304 DEFAULT CHARSET=utf8mb4
	1 row in set (0.00 sec)



	mysql> alter table niuniuh5_db.table_web_loginlog_debug drop index web_loginlog_idx_szTime,  drop index idx_nPlayerId_szTime,  drop index idx_loginIp_szTime;
	Query OK, 0 rows affected (0.28 sec)
	Records: 0  Duplicates: 0  Warnings: 0


	delete from niuniuh5_db.table_web_loginlog_debug;

	mysql> delete from niuniuh5_db.table_web_loginlog_debug;
	Query OK, 5265967 rows affected (17.81 sec)



3. 耗时对比
				方式									 	耗时对比
	通过delete删除有普通索引表的所有数据   					80秒
	通过delete删除没有普通索引表的所有数据					18秒
	
	

