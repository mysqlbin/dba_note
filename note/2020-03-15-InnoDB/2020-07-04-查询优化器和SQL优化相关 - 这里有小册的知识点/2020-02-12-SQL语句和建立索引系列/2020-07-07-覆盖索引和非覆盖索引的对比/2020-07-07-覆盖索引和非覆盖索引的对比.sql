

1. 环境
2. 表的DDL和对应的执行计划
3. 云服务器生产环境下并且query_cache_type = 0
4. 物理机测试环境下并且query_cache_type = 0
5. 小结

1. 环境
	云服务器环境
		磁盘顺序读IOPS：7000 
		磁盘顺序读IOPS：1100 
		磁盘随机读写IOPS：750/700
		物理内存：16GB
		bp缓冲池：8GB
		
	物理机环境	
		磁盘顺序读IOPS：350
		磁盘顺序读IOPS：120
		磁盘随机读写IOPS：50/50
		物理内存：16GB
		bp缓冲池：4GB
	
2. 表的DDL和对应的执行计划
 
	table_cm 表对应的SQL有使用到覆盖索引，table_dm 表对应的SQL 没有使用到覆盖索引。
	
	mysql> select count(*) from table_cm;
	+----------+
	| count(*) |
	+----------+
	|    93708 |
	+----------+
	1 row in set (0.02 sec)

	mysql> select count(*) from table_dm;
	+----------+
	| count(*) |
	+----------+
	|    93708 |
	+----------+
	1 row in set (0.02 sec)
	
	
	表的DDL
	
		CREATE TABLE `table_cm` (
		  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `tJoinTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
		  `nExtenID` int(11) DEFAULT '0' COMMENT '上线用户ID',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_nExtenID_nPlayerID` (`nClubID`,`nExtenID`,`nPlayerID`)
		) ENGINE=InnoDB AUTO_INCREMENT=93798 DEFAULT CHARSET=utf8mb4 COMMENT='使用到覆盖索引对应的表';

		CREATE TABLE `table_cm` (
		  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `szNickName` varchar(64) DEFAULT NULL COMMENT '玩家昵称',
		  `nLevel` tinyint(4) DEFAULT '3' COMMENT '',
		  `nStatus` tinyint(4) NOT NULL DEFAULT '1' COMMENT '',
		  `tJoinTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
		  `tEixtTime` timestamp NULL DEFAULT NULL COMMENT '',
		  `nScore` bigint(20) NOT NULL DEFAULT '0' COMMENT '',
		  `nFreeScore` bigint(20) NOT NULL DEFAULT '0' COMMENT '',
		  `nExtenRate` int(11) NOT NULL DEFAULT '0' COMMENT '',
		  `LineCode` varchar(64) DEFAULT NULL COMMENT '',
		  `nExtenID` int(11) DEFAULT '0' COMMENT '',
		  `tExtenBindingTime` timestamp NULL DEFAULT NULL COMMENT '',
		  `nExtenDivision` tinyint(4) DEFAULT '1' COMMENT '',
		  `nFreeServiceFee` tinyint(4) DEFAULT '0' COMMENT '',
		  `nSafeScore` bigint(20) unsigned DEFAULT '0' COMMENT '',
		  `updateScore` bigint(20) NOT NULL DEFAULT '0' COMMENT '',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '',
		  `nExLevel` int(10) NOT NULL DEFAULT '1' COMMENT '',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_nExtenID_nPlayerID` (`nClubID`,`nExtenID`,`nPlayerID`)
		) ENGINE=InnoDB AUTO_INCREMENT=93817 DEFAULT CHARSET=utf8mb4 COMMENT='使用到覆盖索引对应的表';
	
	
		CREATE TABLE `table_dm` (
		  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `nClubID` int(11) NOT NULL COMMENT '俱乐部ID',
		  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
		  `szNickName` varchar(64) DEFAULT NULL COMMENT '玩家昵称',
		  `nLevel` tinyint(4) DEFAULT '3' COMMENT '',
		  `nStatus` tinyint(4) NOT NULL DEFAULT '1' COMMENT '',
		  `tJoinTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
		  `tEixtTime` timestamp NULL DEFAULT NULL COMMENT '',
		  `nScore` bigint(20) NOT NULL DEFAULT '0' COMMENT '',
		  `nFreeScore` bigint(20) NOT NULL DEFAULT '0' COMMENT '',
		  `nExtenRate` int(11) NOT NULL DEFAULT '0' COMMENT '',
		  `LineCode` varchar(64) DEFAULT NULL COMMENT '',
		  `nExtenID` int(11) DEFAULT '0' COMMENT '',
		  `tExtenBindingTime` timestamp NULL DEFAULT NULL COMMENT '',
		  `nExtenDivision` tinyint(4) DEFAULT '1' COMMENT '',
		  `nFreeServiceFee` tinyint(4) DEFAULT '0' COMMENT '',
		  `nSafeScore` bigint(20) unsigned DEFAULT '0' COMMENT '',
		  `updateScore` bigint(20) NOT NULL DEFAULT '0' COMMENT '',
		  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '',
		  `nExLevel` int(10) NOT NULL DEFAULT '1' COMMENT '',
		  PRIMARY KEY (`ID`),
		  KEY `idx_nClubID_nExtenID` (`nClubID`,`nExtenID`)
		) ENGINE=InnoDB AUTO_INCREMENT=93817 DEFAULT CHARSET=utf8mb4 COMMENT='没有使用到覆盖索引对应的表';
				

	使用到覆盖索引的执行计划和对应表的索引基数和实际的记录数
	
		mysql> desc SELECT nClubId, nExtenID, nPlayerID FROM table_cm WHERE nClubId = 10017 AND nExtenID = 132806;
		+----+-------------+----------+------------+------+--------------------------------+--------------------------------+---------+-------------+-------+----------+-------------+
		| id | select_type | table    | partitions | type | possible_keys                  | key                            | key_len | ref         | rows  | filtered | Extra       |
		+----+-------------+----------+------------+------+--------------------------------+--------------------------------+---------+-------------+-------+----------+-------------+
		|  1 | SIMPLE      | table_cm | NULL       | ref  | idx_nClubID_nExtenID_nPlayerID | idx_nClubID_nExtenID_nPlayerID | 9       | const,const | 18088 |   100.00 | Using index |
		+----+-------------+----------+------------+------+--------------------------------+--------------------------------+---------+-------------+-------+----------+-------------+
		1 row in set, 1 warning (0.00 sec)
	
		mysql> show index from table_cm;
		+----------+------------+--------------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
		| Table    | Non_unique | Key_name                       | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
		+----------+------------+--------------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
		| table_cm |          0 | PRIMARY                        |            1 | ID          | A         |       94214 |     NULL | NULL   |      | BTREE      |         |               |
		| table_cm |          1 | idx_nClubID_nExtenID_nPlayerID |            1 | nClubID     | A         |         112 |     NULL | NULL   |      | BTREE      |         |               |
		| table_cm |          1 | idx_nClubID_nExtenID_nPlayerID |            2 | nExtenID    | A         |         756 |     NULL | NULL   | YES  | BTREE      |         |               |
		| table_cm |          1 | idx_nClubID_nExtenID_nPlayerID |            3 | nPlayerID   | A         |       94214 |     NULL | NULL   |      | BTREE      |         |               |
		+----------+------------+--------------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
		9 rows in set (0.00 sec)
	
		mysql> SELECT count(*) FROM table_cm WHERE nClubId = 10017 AND nExtenID = 132806;
		+----------+
		| count(*) |
		+----------+
		|    10066 |
		+----------+
		1 row in set (0.01 sec)


	
	没有使用到覆盖索引的执行计划和对应表的索引基数和实际的记录数
		mysql> desc SELECT nClubId, nExtenID, nPlayerID FROM table_dm WHERE nClubId = 10017 AND nExtenID = 132806;
		+----+-------------+----------+------------+------+----------------------+----------------------+---------+-------------+-------+----------+-------+
		| id | select_type | table    | partitions | type | possible_keys        | key                  | key_len | ref         | rows  | filtered | Extra |
		+----+-------------+----------+------------+------+----------------------+----------------------+---------+-------------+-------+----------+-------+
		|  1 | SIMPLE      | table_dm | NULL       | ref  | idx_nClubID_nExtenID | idx_nClubID_nExtenID | 9       | const,const | 18284 |   100.00 | NULL  |
		+----+-------------+----------+------------+------+----------------------+----------------------+---------+-------------+-------+----------+-------+
		1 row in set, 1 warning (0.00 sec)
		
		mysql> show index from table_dm;
		+----------+------------+-------------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
		| Table    | Non_unique | Key_name                      | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
		+----------+------------+-------------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
		| table_dm |          0 | PRIMARY                       |            1 | ID          | A         |       91587 |     NULL | NULL   |      | BTREE      |         |               |
		| table_dm |          1 | idx_nClubID_nExtenID          |            1 | nClubID     | A         |         193 |     NULL | NULL   |      | BTREE      |         |               |
		| table_dm |          1 | idx_nClubID_nExtenID          |            2 | nExtenID    | A         |        1154 |     NULL | NULL   | YES  | BTREE      |         |               |
		+----------+------------+-------------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
		8 rows in set (0.00 sec)

		mysql> SELECT count(*) FROM table_dm WHERE nClubId = 10017 AND nExtenID = 132806;
		+----------+
		| count(*) |
		+----------+
		|    10066 |
		+----------+
		1 row in set (0.00 sec)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

3. 云服务器生产环境下并且query_cache_type = 0

	mysql> show global variables like '%query_cache_type%';
	+------------------+-------+
	| Variable_name    | Value |
	+------------------+-------+
	| query_cache_type | OFF   |
	+------------------+-------+
	1 row in set (0.00 sec)

	查看执行计划
		mysql> desc SELECT nClubId, nExtenID, nPlayerID FROM table_cm WHERE nClubId = 10017 AND nExtenID = 132806;
		+----+-------------+----------+------------+------+--------------------------------+--------------------------------+---------+-------------+-------+----------+-------------+
		| id | select_type | table    | partitions | type | possible_keys                  | key                            | key_len | ref         | rows  | filtered | Extra       |
		+----+-------------+----------+------------+------+--------------------------------+--------------------------------+---------+-------------+-------+----------+-------------+
		|  1 | SIMPLE      | table_cm | NULL       | ref  | idx_nClubID_nExtenID_nPlayerID | idx_nClubID_nExtenID_nPlayerID | 9       | const,const | 18088 |   100.00 | Using index |
		+----+-------------+----------+------------+------+--------------------------------+--------------------------------+---------+-------------+-------+----------+-------------+
		1 row in set, 1 warning (0.00 sec)

		mysql> desc SELECT nClubId, nExtenID, nPlayerID FROM table_dm WHERE nClubId = 10017 AND nExtenID = 132806;
		+----+-------------+----------+------------+------+----------------------+----------------------+---------+-------------+-------+----------+-------+
		| id | select_type | table    | partitions | type | possible_keys        | key                  | key_len | ref         | rows  | filtered | Extra |
		+----+-------------+----------+------------+------+----------------------+----------------------+---------+-------------+-------+----------+-------+
		|  1 | SIMPLE      | table_dm | NULL       | ref  | idx_nClubID_nExtenID | idx_nClubID_nExtenID | 9       | const,const | 18284 |   100.00 | NULL  |
		+----+-------------+----------+------------+------+----------------------+----------------------+---------+-------------+-------+----------+-------+
		1 row in set, 1 warning (0.00 sec)

	查看 show profile
		using index
			set profiling = 1;
			SELECT nClubId, nExtenID, nPlayerID FROM table_cm WHERE nClubId = 10017 AND nExtenID = 132806;
			show profiles;
			show profile cpu,block io for query 1;
			+----------------------+----------+----------+------------+--------------+---------------+
			| Status               | Duration | CPU_user | CPU_system | Block_ops_in | Block_ops_out |
			+----------------------+----------+----------+------------+--------------+---------------+
			| starting             | 0.000079 | 0.000050 |   0.000028 |            0 |             0 |
			| checking permissions | 0.000013 | 0.000008 |   0.000004 |            0 |             0 |
			| Opening tables       | 0.000021 | 0.000013 |   0.000008 |            0 |             0 |
			| init                 | 0.000027 | 0.000017 |   0.000009 |            0 |             0 |
			| System lock          | 0.000010 | 0.000006 |   0.000004 |            0 |             0 |
			| optimizing           | 0.000013 | 0.000008 |   0.000004 |            0 |             0 |
			| statistics           | 0.000088 | 0.000057 |   0.000032 |            0 |             0 |
			| preparing            | 0.000015 | 0.000009 |   0.000005 |            0 |             0 |
			| executing            | 0.000003 | 0.000002 |   0.000001 |            0 |             0 |
			| Sending data         | 0.007518 | 0.007860 |   0.000000 |            0 |             0 |
			| end                  | 0.000006 | 0.000000 |   0.000000 |            0 |             0 |
			| query end            | 0.000008 | 0.000000 |   0.000000 |            0 |             0 |
			| closing tables       | 0.000007 | 0.000000 |   0.000000 |            0 |             0 |
			| freeing items        | 0.000033 | 0.000000 |   0.000000 |            0 |             0 |
			| cleaning up          | 0.000011 | 0.000000 |   0.000000 |            0 |             0 |
			+----------------------+----------+----------+------------+--------------+---------------+
			15 rows in set, 1 warning (0.00 sec)
		
		not using index
			set profiling = 1;
			SELECT nClubId, nExtenID, nPlayerID FROM table_dm WHERE nClubId = 10017 AND nExtenID = 132806;
			show profiles;
			show profile cpu,block io for query 3;
			+----------------------+----------+----------+------------+--------------+---------------+
			| Status               | Duration | CPU_user | CPU_system | Block_ops_in | Block_ops_out |
			+----------------------+----------+----------+------------+--------------+---------------+
			| starting             | 0.000061 | 0.000040 |   0.000020 |            0 |             0 |
			| checking permissions | 0.000007 | 0.000004 |   0.000002 |            0 |             0 |
			| Opening tables       | 0.000015 | 0.000010 |   0.000005 |            0 |             0 |
			| init                 | 0.000026 | 0.000018 |   0.000009 |            0 |             0 |
			| System lock          | 0.000010 | 0.000006 |   0.000003 |            0 |             0 |
			| optimizing           | 0.000012 | 0.000009 |   0.000004 |            0 |             0 |
			| statistics           | 0.000104 | 0.000432 |   0.000000 |            0 |             0 |
			| preparing            | 0.000017 | 0.000000 |   0.000000 |            0 |             0 |
			| executing            | 0.000003 | 0.000000 |   0.000000 |            0 |             0 |
			| Sending data         | 0.016610 | 0.015844 |   0.000459 |            0 |             0 |
			| end                  | 0.000007 | 0.000004 |   0.000001 |            0 |             0 |
			| query end            | 0.000008 | 0.000005 |   0.000003 |            0 |             0 |
			| closing tables       | 0.000008 | 0.000005 |   0.000002 |            0 |             0 |
			| freeing items        | 0.000034 | 0.000024 |   0.000012 |            0 |             0 |
			| cleaning up          | 0.000018 | 0.000012 |   0.000006 |            0 |             0 |
			+----------------------+----------+----------+------------+--------------+---------------+
			15 rows in set, 1 warning (0.00 sec)


		从 sending data 看，大概有一倍的性能提升：
			using index：     Sending data 的持续时间: 0.007518
			not using index： Sending data 的持续时间: 0.016610
			
			同时, 这里通过 Sending data 的差别, 可以发现覆盖索引需要扫描的数据和非覆盖索引需要扫描的数据是有差别的.
			使用覆盖索引，不需要回表，扫描的数据会更少。

		正确情况下，使用到了 using index 估计会有一倍以上的查询性能提升。
		
		但是从实际的 navicat 连接数据库查询做对比：两者的查询耗时一样，如下所示
			---- 通过Navicat工具执行
			
			SELECT nClubId, nExtenID, nPlayerID FROM table_dm WHERE nClubId = 10017 AND nExtenID = 132806;
				--没有使用到覆盖索引的平均耗时约平均耗时约： 0.15秒
				
			SELECT nClubId, nExtenID, nPlayerID FROM table_cm WHERE nClubId = 10017 AND nExtenID = 132806;
				--有使用到覆盖索引的平均耗时约： 0.15秒
					
		这个就是我疑惑的地方。
		
			[root@localhost data]#  innodb_space -s ibdata1 -T base_db/table_cm space-indexes
			id          name                            root        fseg        fseg_id     used        allocated   fill_factor 
			5791        PRIMARY                         3           internal    1           1           1           100.00%     
			5791        PRIMARY                         3           leaf        2           603         736         81.93%      
			5792        idx_nClubID_nExtenID_nPlayerID  4           internal    3           1           1           100.00%     
			5792        idx_nClubID_nExtenID_nPlayerID  4           leaf        4           125         160         78.12%  


			主键索引一共使用了603个page
			表一共有93708行记录，主键索引每个page能存储多少行： select 93708/603=155
			查询到的记录数一共有10066行， 预估扫描了多少个主键索引page: select 10066/155=64

			估计在 SSD云盘下，回表需要访问64个主键索引page, 也不会有多大的性能影响。
			
			并且经过了多次查询, 这些主键索引的Page也可能在内存中.
			
		
		在本地客户端执行：
			SELECT nClubId, nExtenID, nPlayerID FROM table_cm WHERE nClubId = 10017 AND nExtenID = 132806;  -- 使用到覆盖索引耗时：0.01秒
			SELECT nClubId, nExtenID, nPlayerID FROM table_dm WHERE nClubId = 10017 AND nExtenID = 132806;  -- 没有使用到覆盖索引耗时：0.02秒
		
		
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


4. 物理机测试环境下并且query_cache_type = 0

	查看执行计划

		root@mysqldb 11:07:  [base_db]> desc SELECT nClubId, nExtenID, nPlayerID  FROM table_cm WHERE nClubId = 10017 AND nExtenID = 132806;
		+----+-------------+------------------+------------+------+--------------------------------+--------------------------------+---------+-------------+-------+----------+-------------+
		| id | select_type | table            | partitions | type | possible_keys                  | key                            | key_len | ref         | rows  | filtered | Extra       |
		+----+-------------+------------------+------------+------+--------------------------------+--------------------------------+---------+-------------+-------+----------+-------------+
		|  1 | SIMPLE      | table_cm         | NULL       | ref  | idx_nClubID_nExtenID_nPlayerID | idx_nClubID_nExtenID_nPlayerID | 8       | const,const | 18720 |   100.00 | Using index |
		+----+-------------+------------------+------------+------+--------------------------------+--------------------------------+---------+-------------+-------+----------+-------------+
		1 row in set, 1 warning (0.00 sec)

		root@mysqldb 11:06:  [base_db]> desc SELECT nClubId, nPlayerID, tJoinTime FROM table_dm WHERE nClubId = 10017 AND nExtenID = 132806;
		+----+-------------+------------------+------------+------+--------------------------------+--------------------------------+---------+-------------+-------+----------+-------+
		| id | select_type | table            | partitions | type | possible_keys                  | key                            | key_len | ref         | rows  | filtered | Extra |
		+----+-------------+------------------+------------+------+--------------------------------+--------------------------------+---------+-------------+-------+----------+-------+
		|  1 | SIMPLE      | table_dm         | NULL       | ref  | idx_nClubID_nExtenID_nPlayerID | idx_nClubID_nExtenID_nPlayerID | 8       | const,const | 18720 |   100.00 | NULL  |
		+----+-------------+------------------+------------+------+--------------------------------+--------------------------------+---------+-------------+-------+----------+-------+
		1 row in set, 1 warning (0.00 sec)
	
	查看 show profile
		using index
			set profiling = 1;
			SELECT nClubId, nExtenID, nPlayerID  FROM table_cm WHERE nClubId = 10017 AND nExtenID = 132806;
			show profiles;
			show profile cpu,block io for query 1;
			+----------------------+----------+----------+------------+--------------+---------------+
			| Status               | Duration | CPU_user | CPU_system | Block_ops_in | Block_ops_out |
			+----------------------+----------+----------+------------+--------------+---------------+
			| starting             | 0.000117 | 0.000065 |   0.000045 |            0 |             0 |
			| checking permissions | 0.000017 | 0.000010 |   0.000007 |            0 |             0 |
			| Opening tables       | 0.000033 | 0.000020 |   0.000014 |            0 |             0 |
			| init                 | 0.000049 | 0.000029 |   0.000019 |            0 |             0 |
			| System lock          | 0.000021 | 0.000011 |   0.000009 |            0 |             0 |
			| optimizing           | 0.000025 | 0.000015 |   0.000010 |            0 |             0 |
			| statistics           | 0.000161 | 0.000096 |   0.000066 |            0 |             0 |
			| preparing            | 0.000030 | 0.000017 |   0.000012 |            0 |             0 |
			| executing            | 0.000010 | 0.000006 |   0.000004 |            0 |             0 |
			| Sending data         | 0.016163 | 0.018084 |   0.000000 |            0 |             0 |
			| end                  | 0.000011 | 0.000000 |   0.000000 |            0 |             0 |
			| query end            | 0.000015 | 0.000000 |   0.000000 |            0 |             0 |
			| closing tables       | 0.000014 | 0.000000 |   0.000000 |            0 |             0 |
			| freeing items        | 0.000027 | 0.000000 |   0.000000 |            0 |             0 |
			| cleaning up          | 0.000030 | 0.000000 |   0.000000 |            0 |             0 |
			+----------------------+----------+----------+------------+--------------+---------------+
			15 rows in set, 1 warning (0.00 sec)

		not using index
			set profiling = 1;
			SELECT nClubId, nExtenID, tJoinTime  FROM table_dm WHERE nClubId = 10017 AND nExtenID = 132806;
			show profiles;
			show profile cpu,block io for query 3;
			+----------------------+----------+----------+------------+--------------+---------------+
			| Status               | Duration | CPU_user | CPU_system | Block_ops_in | Block_ops_out |
			+----------------------+----------+----------+------------+--------------+---------------+
			| starting             | 0.000109 | 0.000064 |   0.000044 |            0 |             0 |
			| checking permissions | 0.000019 | 0.000011 |   0.000007 |            0 |             0 |
			| Opening tables       | 0.000032 | 0.000019 |   0.000013 |            0 |             0 |
			| init                 | 0.000050 | 0.000029 |   0.000020 |            0 |             0 |
			| System lock          | 0.000020 | 0.000011 |   0.000009 |            0 |             0 |
			| optimizing           | 0.000026 | 0.000015 |   0.000010 |            0 |             0 |
			| statistics           | 0.000146 | 0.000088 |   0.000061 |            0 |             0 |
			| preparing            | 0.000031 | 0.000017 |   0.000012 |            0 |             0 |
			| executing            | 0.000010 | 0.000006 |   0.000004 |            0 |             0 |
			| Sending data         | 0.045932 | 0.051658 |   0.000000 |            0 |             0 |
			| end                  | 0.000013 | 0.000000 |   0.000000 |            0 |             0 |
			| query end            | 0.000014 | 0.000000 |   0.000000 |            0 |             0 |
			| closing tables       | 0.000013 | 0.000000 |   0.000000 |            0 |             0 |
			| freeing items        | 0.000028 | 0.000000 |   0.000000 |            0 |             0 |
			| cleaning up          | 0.000024 | 0.000000 |   0.000000 |            0 |             0 |
			+----------------------+----------+----------+------------+--------------+---------------+
			15 rows in set, 1 warning (0.00 sec)
		
		
		从 sending data 看，大概有2倍+的性能提升：
			using index：     Sending data: 0.016163
			not using index： Sending data: 0.045932
		
		正确情况下，使用到了 using index 估计会有一倍以上的查询性能提升，这里也得到了验证。
		
		---- 通过Navicat工具执行
			SELECT nClubId, nExtenID, tJoinTime  FROM table_dm WHERE nClubId = 10017 AND nExtenID = 132806;
				--没有使用到覆盖索引的平均耗时约 0.5S
				
			SELECT nClubId, nExtenID, nPlayerID  FROM table_cm WHERE nClubId = 10017 AND nExtenID = 132806;
				--有使用到覆盖索引的平均耗时约 0.24S
		
		在本地客户端执行：
			SELECT nClubId, nExtenID, nPlayerID FROM table_cm WHERE nClubId = 10017 AND nExtenID = 132806;  -- 使用到覆盖索引耗时：0.01秒
			SELECT nClubId, nExtenID, nPlayerID FROM table_dm WHERE nClubId = 10017 AND nExtenID = 132806;  -- 没有使用到覆盖索引耗时：0.03秒
			
5. 小结
	
	高并发场景下, 数据库瓶颈是在IO上, 所以 磁盘的性能好坏往往可以决定数据库跑得多快.
	使用覆盖索引，在扫描行数较多的情况下，才会看到明显的查询速度的性能提升。
	SQL查询语句访问内存数据页比访问磁盘的数据页的速度快得多。
	
	



	
	
	




	