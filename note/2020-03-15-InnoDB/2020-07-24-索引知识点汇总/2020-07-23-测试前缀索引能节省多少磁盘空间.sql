

0. 表的DDL

	CREATE TABLE `aaaaaaaaaaaaaaaaaaa` (
	  `ID` bigint(20) unsigned NOT NULL COMMENT '索引',
	  ...........................
	  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
	  ...........................
	  PRIMARY KEY (`ID`),
	  KEY `idx_szToken` (`szToken`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='';


	alter table bak_liuliuh5_db.aaaaaaaaaaaaaaaaaaa engine=InnoDB;

1. varchar(64) 的索引大小

	用 navicat 工具查看该表的： 索引大小：297.98 MB (312,459,264)

	SELECT table_schema,table_name,(data_length/1024/1024/1024) AS data_mb,(index_length/1024/1024/1024) AS index_mb,((data_length + index_length)/1024/1024/1024) AS all_mb,table_rows FROM 
	information_schema.tables  where table_schema = 'bak_liuliuh5_db' and table_name='aaaaaaaaaaaaaaaaaaa';

	root@mysqldb 17:18:  [(none)]> SELECT table_schema,table_name,(data_length/1024/1024/1024) AS data_mb,(index_length/1024/1024/1024) AS index_mb,((data_length + index_length)/1024/1024/1024) AS all_mb,table_rows FROM 
		-> information_schema.tables  where table_schema = 'bak_liuliuh5_db' and table_name='aaaaaaaaaaaaaaaaaaa';
	+-----------------+---------------------------+----------------+----------------+----------------+------------+
	| table_schema    | table_name                | data_mb        | index_mb       | all_mb         | table_rows |
	+-----------------+---------------------------+----------------+----------------+----------------+------------+
	| bak_liuliuh5_db | aaaaaaaaaaaaaaaaaaa | 1.814437866211 | 0.291000366211 | 2.105438232422 |    7234754 |
	+-----------------+---------------------------+----------------+----------------+----------------+------------+
	1 row in set (0.00 sec)

	
2. 建立前缀索引
	
	1. 算出这个列上有多少个不同的值：

		root@mysqldb 17:32:  [(none)]> select count(distinct szToken) as L from bak_liuliuh5_db.aaaaaaaaaaaaaaaaaaa;
		+---------+
		| L       |
		+---------+
		| 7283200 |
		+---------+
		1 row in set (6.82 sec)
					

	2. 设定一个可以接受的损失比例，比如 5%；
		
		select 7283200*0.9;    -- 6554880
		select 7283200*0.95;   -- 6919040
		
	3. 找出不小于 L * 95% 的值

		select 
			count(distinct left(szToken,20)) as L20,
			count(distinct left(szToken,21)) as L21,
			count(distinct left(szToken,22)) as L22,
			count(distinct left(szToken,23)) as L23,
			count(distinct left(szToken,24)) as L24,
			count(distinct left(szToken,25)) as L25,
			count(distinct left(szToken,26)) as L26,
			count(distinct left(szToken,27)) as L27,
			count(distinct left(szToken,28)) as L28
		from bak_liuliuh5_db.aaaaaaaaaaaaaaaaaaa;	

		+---------+---------+---------+---------+---------+---------+---------+---------+---------+
		| L20     | L21     | L22     | L23     | L24     | L25     | L26     | L27     | L28     |
		+---------+---------+---------+---------+---------+---------+---------+---------+---------+
		| 5696137 | 6104305 | 7104978 | 7283200 | 7283200 | 7283200 | 7283200 | 7283200 | 7283200 |
		+---------+---------+---------+---------+---------+---------+---------+---------+---------+
		1 row in set (5 min 3.84 sec)
	
	4. 建立字符串最左22个字符的前缀索引
	
		alter table bak_liuliuh5_db.aaaaaaaaaaaaaaaaaaa drop index idx_szToken,
		add index `idx_szToken` (`szToken`(22));

		alter table bak_liuliuh5_db.aaaaaaaaaaaaaaaaaaa engine=InnoDB;
		
		CREATE TABLE `aaaaaaaaaaaaaaaaaaa` (
		  `ID` bigint(20) unsigned NOT NULL COMMENT '索引',
		  ...........................
		  `szToken` varchar(64) DEFAULT NULL COMMENT 'clubid-roomid-time-round',
		  ...........................
		  PRIMARY KEY (`ID`),
		  KEY `idx_szToken` (`szToken`(22))
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='';
		
	5. 前缀索引的大小 

		root@mysqldb 18:00:  [(none)]> SELECT table_schema,table_name,(data_length/1024/1024/1024) AS data_mb,(index_length/1024/1024/1024) AS index_mb,((data_length + index_length)/1024/1024/1024) AS all_mb,table_rows FROM  information_schema.tables  where table_schema = 'bak_liuliuh5_db' and table_name='aaaaaaaaaaaaaaaaaaa';
		+-----------------+---------------------------+----------------+----------------+----------------+------------+
		| table_schema    | table_name                | data_mb        | index_mb       | all_mb         | table_rows |
		+-----------------+---------------------------+----------------+----------------+----------------+------------+
		| bak_liuliuh5_db | aaaaaaaaaaaaaaaaaaa | 1.814437866211 | 0.265609741211 | 2.080047607422 |    7084138 |
		+-----------------+---------------------------+----------------+----------------+----------------+------------+
		1 row in set (0.06 sec)
		
		用 navicat 工具查看该表的索引大小：271.98 MB (285,196,288)
		
		
3. 小结

	全字段索引的索引大小：297.98 MB (312,459,264)
	前缀索引  的索引大小：271.98 MB (285,196,288)
	
	index `idx_szToken` (`szToken`(22)) 表示 只取szToken字段的前22个字节作为索引。
	
	
		