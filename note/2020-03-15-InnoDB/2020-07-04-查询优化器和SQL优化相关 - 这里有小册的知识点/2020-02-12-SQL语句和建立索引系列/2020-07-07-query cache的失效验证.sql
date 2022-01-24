
1. 查看直接从 query cache 中返回数据
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

2. 删除表的一行记录, query cache 缓存就会失效

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



	
	