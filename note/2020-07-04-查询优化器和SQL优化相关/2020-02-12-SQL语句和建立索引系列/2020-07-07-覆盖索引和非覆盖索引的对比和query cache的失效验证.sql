0. 主要对比覆盖索引和非覆盖索引的查询性能对比
1. 云服务器生产环境下并且query_cache_type = 0
2. 物理机测试环境下并且query_cache_type = 0

0. 主要对比覆盖索引和非覆盖索引的查询性能对比

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


	mysql> show index from table_cm;
	+----------+------------+--------------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table    | Non_unique | Key_name                       | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+----------+------------+--------------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| table_cm |          0 | PRIMARY                        |            1 | ID          | A         |       94214 |     NULL | NULL   |      | BTREE      |         |               |
	| table_cm |          1 | index_tJoinTime                |            1 | tJoinTime   | A         |       92023 |     NULL | NULL   |      | BTREE      |         |               |
	| table_cm |          1 | idx_nLevel                     |            1 | nLevel      | A         |           1 |     NULL | NULL   | YES  | BTREE      |         |               |
	| table_cm |          1 | idx_nPlayerID_nClubID_nStatus  |            1 | nPlayerID   | A         |       94214 |     NULL | NULL   |      | BTREE      |         |               |
	| table_cm |          1 | idx_nPlayerID_nClubID_nStatus  |            2 | nClubID     | A         |       94214 |     NULL | NULL   |      | BTREE      |         |               |
	| table_cm |          1 | idx_nPlayerID_nClubID_nStatus  |            3 | nStatus     | A         |       94214 |     NULL | NULL   |      | BTREE      |         |               |
	| table_cm |          1 | idx_nClubID_nExtenID_nPlayerID |            1 | nClubID     | A         |         112 |     NULL | NULL   |      | BTREE      |         |               |
	| table_cm |          1 | idx_nClubID_nExtenID_nPlayerID |            2 | nExtenID    | A         |         756 |     NULL | NULL   | YES  | BTREE      |         |               |
	| table_cm |          1 | idx_nClubID_nExtenID_nPlayerID |            3 | nPlayerID   | A         |       94214 |     NULL | NULL   |      | BTREE      |         |               |
	+----------+------------+--------------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	9 rows in set (0.00 sec)
	
	mysql> show index from table_dm;
	+----------+------------+-------------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| Table    | Non_unique | Key_name                      | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
	+----------+------------+-------------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	| table_dm |          0 | PRIMARY                       |            1 | ID          | A         |       91587 |     NULL | NULL   |      | BTREE      |         |               |
	| table_dm |          1 | index_tJoinTime               |            1 | tJoinTime   | A         |       91626 |     NULL | NULL   |      | BTREE      |         |               |
	| table_dm |          1 | idx_nLevel                    |            1 | nLevel      | A         |           1 |     NULL | NULL   | YES  | BTREE      |         |               |
	| table_dm |          1 | idx_nPlayerID_nClubID_nStatus |            1 | nPlayerID   | A         |       91626 |     NULL | NULL   |      | BTREE      |         |               |
	| table_dm |          1 | idx_nPlayerID_nClubID_nStatus |            2 | nClubID     | A         |       91490 |     NULL | NULL   |      | BTREE      |         |               |
	| table_dm |          1 | idx_nPlayerID_nClubID_nStatus |            3 | nStatus     | A         |       91626 |     NULL | NULL   |      | BTREE      |         |               |
	| table_dm |          1 | idx_nClubID_nExtenID          |            1 | nClubID     | A         |         193 |     NULL | NULL   |      | BTREE      |         |               |
	| table_dm |          1 | idx_nClubID_nExtenID          |            2 | nExtenID    | A         |        1154 |     NULL | NULL   | YES  | BTREE      |         |               |
	+----------+------------+-------------------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
	8 rows in set (0.00 sec)


	使用到覆盖索引的执行计划
		mysql> desc SELECT nClubId, nExtenID, nPlayerID FROM table_cm WHERE nClubId = 10017 AND nExtenID = 132806;
		+----+-------------+----------+------------+------+--------------------------------+--------------------------------+---------+-------------+-------+----------+-------------+
		| id | select_type | table    | partitions | type | possible_keys                  | key                            | key_len | ref         | rows  | filtered | Extra       |
		+----+-------------+----------+------------+------+--------------------------------+--------------------------------+---------+-------------+-------+----------+-------------+
		|  1 | SIMPLE      | table_cm | NULL       | ref  | idx_nClubID_nExtenID_nPlayerID | idx_nClubID_nExtenID_nPlayerID | 9       | const,const | 18088 |   100.00 | Using index |
		+----+-------------+----------+------------+------+--------------------------------+--------------------------------+---------+-------------+-------+----------+-------------+
		1 row in set, 1 warning (0.00 sec)
		
	没有使用到覆盖索引的执行计划
		mysql> desc SELECT nClubId, nExtenID, nPlayerID FROM table_dm WHERE nClubId = 10017 AND nExtenID = 132806;
		+----+-------------+----------+------------+------+----------------------+----------------------+---------+-------------+-------+----------+-------+
		| id | select_type | table    | partitions | type | possible_keys        | key                  | key_len | ref         | rows  | filtered | Extra |
		+----+-------------+----------+------------+------+----------------------+----------------------+---------+-------------+-------+----------+-------+
		|  1 | SIMPLE      | table_dm | NULL       | ref  | idx_nClubID_nExtenID | idx_nClubID_nExtenID | 9       | const,const | 18284 |   100.00 | NULL  |
		+----+-------------+----------+------------+------+----------------------+----------------------+---------+-------------+-------+----------+-------+
		1 row in set, 1 warning (0.00 sec)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

1. 云服务器生产环境下并且query_cache_type = 0

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
			using index：     Sending data: 0.007518
			not using index： Sending data: 0.016610
		
		按正确情况来说，使用到了 using index 会有一倍以上的查询性能提升。
		
		但是从实际的 navicat 连接数据库查询做对比：两者的查询耗时一样，如下所示
			
			SELECT nClubId, nExtenID, nPlayerID FROM table_cm WHERE nClubId = 10017 AND nExtenID = 132806;
				--耗时约： 0.15秒
				
			SELECT nClubId, nExtenID, nPlayerID FROM table_dm WHERE nClubId = 10017 AND nExtenID = 132806;
				--耗时约： 0.15秒
				
		这个就是我疑惑的地方。
		
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


2. 物理机测试环境下并且query_cache_type = 0

	查看执行计划

		root@mysqldb 11:07:  [base_db]> desc SELECT nClubId, nExtenID, nPlayerID  FROM table_clubmember WHERE nClubId = 10017 AND nExtenID = 132806;
		+----+-------------+------------------+------------+------+--------------------------------+--------------------------------+---------+-------------+-------+----------+-------------+
		| id | select_type | table            | partitions | type | possible_keys                  | key                            | key_len | ref         | rows  | filtered | Extra       |
		+----+-------------+------------------+------------+------+--------------------------------+--------------------------------+---------+-------------+-------+----------+-------------+
		|  1 | SIMPLE      | table_clubmember | NULL       | ref  | idx_nClubID_nExtenID_nPlayerID | idx_nClubID_nExtenID_nPlayerID | 8       | const,const | 18720 |   100.00 | Using index |
		+----+-------------+------------------+------------+------+--------------------------------+--------------------------------+---------+-------------+-------+----------+-------------+
		1 row in set, 1 warning (0.00 sec)

		root@mysqldb 11:06:  [base_db]> desc SELECT nClubId, nPlayerID, tJoinTime FROM table_clubmember WHERE nClubId = 10017 AND nExtenID = 132806;
		+----+-------------+------------------+------------+------+--------------------------------+--------------------------------+---------+-------------+-------+----------+-------+
		| id | select_type | table            | partitions | type | possible_keys                  | key                            | key_len | ref         | rows  | filtered | Extra |
		+----+-------------+------------------+------------+------+--------------------------------+--------------------------------+---------+-------------+-------+----------+-------+
		|  1 | SIMPLE      | table_clubmember | NULL       | ref  | idx_nClubID_nExtenID_nPlayerID | idx_nClubID_nExtenID_nPlayerID | 8       | const,const | 18720 |   100.00 | NULL  |
		+----+-------------+------------------+------------+------+--------------------------------+--------------------------------+---------+-------------+-------+----------+-------+
		1 row in set, 1 warning (0.00 sec)
	
	查看 show profile
		using index
			set profiling = 1;
			SELECT nClubId, nExtenID, nPlayerID  FROM table_clubmember WHERE nClubId = 10017 AND nExtenID = 132806;
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
			SELECT nClubId, nExtenID, tJoinTime  FROM table_clubmember WHERE nClubId = 10017 AND nExtenID = 132806;
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


			SELECT nClubId,nPlayerId,nExLevel,nExtenID,tJoinTime FROM table_clubmember WHERE nClubId = 10017 AND nExtenID = 132806;	
				--耗时约 0.5S
			SELECT nClubId,nPlayerId,nExtenID FROM table_clubmember WHERE nClubId = 10017 AND nExtenID = 132806;	
				--耗时约 0.24S
				
			---- 通过Navicat执行	
				
	
-------------------------------------------------------------------------------------------------------------------

生产环境 

mysql> desc SELECT nClubId, nExtenID, nPlayerID FROM table_clubmember WHERE nClubId = 10017 AND nExtenID = 132806;
+----+-------------+------------------+------------+------+----------------------+----------------------+---------+-------------+-------+----------+-------+
| id | select_type | table            | partitions | type | possible_keys        | key                  | key_len | ref         | rows  | filtered | Extra |
+----+-------------+------------------+------------+------+----------------------+----------------------+---------+-------------+-------+----------+-------+
|  1 | SIMPLE      | table_clubmember | NULL       | ref  | idx_nClubID_nExtenID | idx_nClubID_nExtenID | 9       | const,const | 18284 |   100.00 | NULL  |
+----+-------------+------------------+------------+------+----------------------+----------------------+---------+-------------+-------+----------+-------+
1 row in set, 1 warning (0.00 sec)

mysql> desc SELECT nClubId, nExtenID, nPlayerID FROM table_cm WHERE nClubId = 10017 AND nExtenID = 132806;
+----+-------------+----------+------------+------+--------------------------------+--------------------------------+---------+-------------+-------+----------+-------------+
| id | select_type | table    | partitions | type | possible_keys                  | key                            | key_len | ref         | rows  | filtered | Extra       |
+----+-------------+----------+------------+------+--------------------------------+--------------------------------+---------+-------------+-------+----------+-------------+
|  1 | SIMPLE      | table_cm | NULL       | ref  | idx_nClubID_nExtenID_nPlayerID | idx_nClubID_nExtenID_nPlayerID | 9       | const,const | 18088 |   100.00 | Using index |
+----+-------------+----------+------------+------+--------------------------------+--------------------------------+---------+-------------+-------+----------+-------------+
1 row in set, 1 warning (0.00 sec)


SELECT nClubId, nExtenID, nPlayerID FROM table_clubmember WHERE nClubId = 10017 AND nExtenID = 132806;
	-- 0.02S
	
SELECT nClubId, nExtenID, nPlayerID FROM table_cm WHERE nClubId = 10017 AND nExtenID = 132806;
	-- 0.01S
---- 通过命令行执行
	
	
set profiling = 1;
SELECT nClubId, nExtenID, nPlayerID FROM table_cm WHERE nClubId = 10017 AND nExtenID = 132806;
show profiles;
mysql> show profile cpu,block io for query 4;
+--------------------------------+----------+----------+------------+--------------+---------------+
| Status                         | Duration | CPU_user | CPU_system | Block_ops_in | Block_ops_out |
+--------------------------------+----------+----------+------------+--------------+---------------+
| starting                       | 0.000097 | 0.000088 |   0.000000 |            0 |             0 |
| Waiting for query cache lock   | 0.000024 | 0.000013 |   0.000000 |            0 |             0 |
| starting                       | 0.000009 | 0.000008 |   0.000000 |            0 |             0 |
| checking query cache for query | 0.000150 | 0.000155 |   0.000000 |            0 |             0 |
| checking privileges on cached  | 0.000042 | 0.000039 |   0.000000 |            0 |             0 |
| checking permissions           | 0.000026 | 0.000024 |   0.000000 |            0 |             0 |
| sending cached result to clien | 0.001238 | 0.000240 |   0.000000 |            0 |             0 |
| cleaning up                    | 0.000050 | 0.000029 |   0.000000 |            0 |             0 |
+--------------------------------+----------+----------+------------+--------------+---------------+
8 rows in set, 1 warning (0.00 sec)

-- 修改table_cm表的数据，让 query cache 缓存失效
-- 验证了只要表中有数据修改，query cache 缓存就会失效
mysql> show profile cpu,block io for query 6;
+--------------------------------+----------+----------+------------+--------------+---------------+
| Status                         | Duration | CPU_user | CPU_system | Block_ops_in | Block_ops_out |
+--------------------------------+----------+----------+------------+--------------+---------------+
| starting                       | 0.000078 | 0.000057 |   0.000000 |            0 |             0 |
| Waiting for query cache lock   | 0.000022 | 0.000013 |   0.000000 |            0 |             0 |
| starting                       | 0.000010 | 0.000010 |   0.000000 |            0 |             0 |
| checking query cache for query | 0.000113 | 0.000117 |   0.000000 |            0 |             0 |
| checking permissions           | 0.000019 | 0.000015 |   0.000000 |            0 |             0 |
| Opening tables                 | 0.000035 | 0.000035 |   0.000000 |            0 |             0 |
| init                           | 0.000032 | 0.000031 |   0.000000 |            0 |             0 |
| System lock                    | 0.000048 | 0.000000 |   0.000049 |            0 |             0 |
| Waiting for query cache lock   | 0.000010 | 0.000000 |   0.000008 |            0 |             0 |
| System lock                    | 0.000034 | 0.000000 |   0.000034 |            0 |             0 |
| optimizing                     | 0.000018 | 0.000000 |   0.000017 |            0 |             0 |
| statistics                     | 0.000184 | 0.000156 |   0.000038 |            0 |             0 |
| preparing                      | 0.000037 | 0.000028 |   0.000000 |            0 |             0 |
| executing                      | 0.000009 | 0.000009 |   0.000000 |            0 |             0 |
| Sending data                   | 0.000490 | 0.000350 |   0.000146 |            0 |             0 |
| Waiting for query cache lock   | 0.000017 | 0.000010 |   0.000000 |            0 |             0 |
| Sending data                   | 0.000403 | 0.000258 |   0.000146 |            0 |             0 |
| Waiting for query cache lock   | 0.000012 | 0.000010 |   0.000000 |            0 |             0 |
| Sending data                   | 0.000386 | 0.000240 |   0.000147 |            0 |             0 |
| Waiting for query cache lock   | 0.000009 | 0.000009 |   0.000000 |            0 |             0 |
| Sending data                   | 0.000380 | 0.000380 |   0.000000 |            0 |             0 |
| Waiting for query cache lock   | 0.000009 | 0.000008 |   0.000000 |            0 |             0 |
| Sending data                   | 0.000387 | 0.000241 |   0.000146 |            0 |             0 |
| Waiting for query cache lock   | 0.000009 | 0.000009 |   0.000000 |            0 |             0 |
| Sending data                   | 0.000383 | 0.000237 |   0.000146 |            0 |             0 |
| Waiting for query cache lock   | 0.000009 | 0.000008 |   0.000000 |            0 |             0 |
| Sending data                   | 0.000380 | 0.000235 |   0.000146 |            0 |             0 |
| Waiting for query cache lock   | 0.000009 | 0.000009 |   0.000000 |            0 |             0 |
| Sending data                   | 0.000385 | 0.000386 |   0.000000 |            0 |             0 |
| Waiting for query cache lock   | 0.000009 | 0.000008 |   0.000000 |            0 |             0 |
| Sending data                   | 0.000376 | 0.000230 |   0.000147 |            0 |             0 |
| Waiting for query cache lock   | 0.000009 | 0.000008 |   0.000000 |            0 |             0 |
| Sending data                   | 0.000417 | 0.000274 |   0.000146 |            0 |             0 |
| Waiting for query cache lock   | 0.000012 | 0.000008 |   0.000000 |            0 |             0 |
| Sending data                   | 0.000379 | 0.000233 |   0.000146 |            0 |             0 |
| Waiting for query cache lock   | 0.000009 | 0.000008 |   0.000000 |            0 |             0 |
| Sending data                   | 0.000381 | 0.000382 |   0.000000 |            0 |             0 |
| Waiting for query cache lock   | 0.000010 | 0.000009 |   0.000000 |            0 |             0 |
| Sending data                   | 0.000386 | 0.000241 |   0.000146 |            0 |             0 |
| Waiting for query cache lock   | 0.000010 | 0.000009 |   0.000000 |            0 |             0 |
| Sending data                   | 0.000392 | 0.000246 |   0.000147 |            0 |             0 |
| Waiting for query cache lock   | 0.000010 | 0.000009 |   0.000000 |            0 |             0 |
| Sending data                   | 0.000315 | 0.000169 |   0.000146 |            0 |             0 |
| end                            | 0.000013 | 0.000011 |   0.000000 |            0 |             0 |
| query end                      | 0.000019 | 0.000020 |   0.000000 |            0 |             0 |
| closing tables                 | 0.000017 | 0.000017 |   0.000000 |            0 |             0 |
| freeing items                  | 0.000033 | 0.000032 |   0.000000 |            0 |             0 |
| Waiting for query cache lock   | 0.000008 | 0.000009 |   0.000000 |            0 |             0 |
| freeing items                  | 0.000025 | 0.000023 |   0.000000 |            0 |             0 |
| Waiting for query cache lock   | 0.000008 | 0.000008 |   0.000000 |            0 |             0 |
| freeing items                  | 0.000008 | 0.000008 |   0.000000 |            0 |             0 |
| storing result in query cache  | 0.000009 | 0.000009 |   0.000000 |            0 |             0 |
| cleaning up                    | 0.000029 | 0.000028 |   0.000000 |            0 |             0 |
+--------------------------------+----------+----------+------------+--------------+---------------+
53 rows in set, 1 warning (0.00 sec)



-------------------------------------------------------------------------------------------------------------------

set profiling = 1;
SELECT nClubId, nExtenID, nPlayerID FROM table_clubmember WHERE nClubId = 10017 AND nExtenID = 132806;
show profiles;
mysql>  show profile cpu,block io for query 1;
+--------------------------------+----------+----------+------------+--------------+---------------+
| Status                         | Duration | CPU_user | CPU_system | Block_ops_in | Block_ops_out |
+--------------------------------+----------+----------+------------+--------------+---------------+
| starting                       | 0.000075 | 0.000041 |   0.000000 |            0 |             0 |
| Waiting for query cache lock   | 0.000013 | 0.000009 |   0.000000 |            0 |             0 |
| starting                       | 0.000011 | 0.000011 |   0.000000 |            0 |             0 |
| checking query cache for query | 0.000087 | 0.000089 |   0.000000 |            0 |             0 |
| checking permissions           | 0.000017 | 0.000015 |   0.000000 |            0 |             0 |
| Opening tables                 | 0.000031 | 0.000031 |   0.000000 |            0 |             0 |
| init                           | 0.000036 | 0.000036 |   0.000000 |            0 |             0 |
| System lock                    | 0.000017 | 0.000017 |   0.000000 |            0 |             0 |
| Waiting for query cache lock   | 0.000010 | 0.000010 |   0.000000 |            0 |             0 |
| System lock                    | 0.000034 | 0.000034 |   0.000000 |            0 |             0 |
| optimizing                     | 0.000025 | 0.000025 |   0.000000 |            0 |             0 |
| statistics                     | 0.000101 | 0.000104 |   0.000000 |            0 |             0 |
| preparing                      | 0.000023 | 0.000020 |   0.000000 |            0 |             0 |
| executing                      | 0.000010 | 0.000009 |   0.000000 |            0 |             0 |
| Sending data                   | 0.001148 | 0.001162 |   0.000000 |            0 |             0 |
| Waiting for query cache lock   | 0.000028 | 0.000015 |   0.000000 |            0 |             0 |
| Sending data                   | 0.000916 | 0.000929 |   0.000000 |            0 |             0 |
| Waiting for query cache lock   | 0.000026 | 0.000012 |   0.000000 |            0 |             0 |
| Sending data                   | 0.000932 | 0.000936 |   0.000000 |            0 |             0 |
| Waiting for query cache lock   | 0.000015 | 0.000011 |   0.000000 |            0 |             0 |
| Sending data                   | 0.000897 | 0.000899 |   0.000000 |            0 |             0 |
| Waiting for query cache lock   | 0.000014 | 0.000011 |   0.000000 |            0 |             0 |
| Sending data                   | 0.000944 | 0.000947 |   0.000000 |            0 |             0 |
| Waiting for query cache lock   | 0.000015 | 0.000011 |   0.000000 |            0 |             0 |
| Sending data                   | 0.000916 | 0.000919 |   0.000000 |            0 |             0 |
| Waiting for query cache lock   | 0.000014 | 0.000011 |   0.000000 |            0 |             0 |
| Sending data                   | 0.000876 | 0.000877 |   0.000000 |            0 |             0 |
| Waiting for query cache lock   | 0.000012 | 0.000010 |   0.000000 |            0 |             0 |
| Sending data                   | 0.000882 | 0.000885 |   0.000000 |            0 |             0 |
| Waiting for query cache lock   | 0.000013 | 0.000010 |   0.000000 |            0 |             0 |
| Sending data                   | 0.000878 | 0.000881 |   0.000000 |            0 |             0 |
| Waiting for query cache lock   | 0.000012 | 0.000009 |   0.000000 |            0 |             0 |
| Sending data                   | 0.000878 | 0.000880 |   0.000000 |            0 |             0 |
| Waiting for query cache lock   | 0.000012 | 0.000009 |   0.000000 |            0 |             0 |
| Sending data                   | 0.000912 | 0.000917 |   0.000000 |            0 |             0 |
| Waiting for query cache lock   | 0.000015 | 0.000010 |   0.000000 |            0 |             0 |
| Sending data                   | 0.001049 | 0.001056 |   0.000000 |            0 |             0 |
| Waiting for query cache lock   | 0.000019 | 0.000012 |   0.000000 |            0 |             0 |
| Sending data                   | 0.000935 | 0.000941 |   0.000000 |            0 |             0 |
| Waiting for query cache lock   | 0.000018 | 0.000012 |   0.000000 |            0 |             0 |
| Sending data                   | 0.001050 | 0.001055 |   0.000000 |            0 |             0 |
| Waiting for query cache lock   | 0.000016 | 0.000011 |   0.000000 |            0 |             0 |
| Sending data                   | 0.000992 | 0.000998 |   0.000000 |            0 |             0 |
| end                            | 0.000021 | 0.000015 |   0.000000 |            0 |             0 |
| query end                      | 0.000033 | 0.000033 |   0.000000 |            0 |             0 |
| closing tables                 | 0.000019 | 0.000018 |   0.000000 |            0 |             0 |
| freeing items                  | 0.000023 | 0.000022 |   0.000000 |            0 |             0 |
| Waiting for query cache lock   | 0.000009 | 0.000009 |   0.000000 |            0 |             0 |
| freeing items                  | 0.000027 | 0.000028 |   0.000000 |            0 |             0 |
| Waiting for query cache lock   | 0.000009 | 0.000008 |   0.000000 |            0 |             0 |
| freeing items                  | 0.000009 | 0.000009 |   0.000000 |            0 |             0 |
| storing result in query cache  | 0.000009 | 0.000009 |   0.000000 |            0 |             0 |
| cleaning up                    | 0.000025 | 0.000026 |   0.000000 |            0 |             0 |
+--------------------------------+----------+----------+------------+--------------+---------------+
53 rows in set, 1 warning (0.00 sec)



	
	