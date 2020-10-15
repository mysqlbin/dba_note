
1. slave 

	mysql> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.22-log |
	+------------+
	1 row in set (0.03 sec)

	mysql> select * from mysql.gtid_executed;
	+--------------------------------------+----------------+--------------+
	| source_uuid                          | interval_start | interval_end |
	+--------------------------------------+----------------+--------------+
	| 9e520b78-013c-11eb-a84c-0800271bf591 |              4 |            4 |
	+--------------------------------------+----------------+--------------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%gtid%';
	+----------------------------------+----------------------------------------+
	| Variable_name                    | Value                                  |
	+----------------------------------+----------------------------------------+
	| binlog_gtid_simple_recovery      | ON                                     |
	| enforce_gtid_consistency         | ON                                     |
	| gtid_executed                    | 9e520b78-013c-11eb-a84c-0800271bf591:4 |
	| gtid_executed_compression_period | 1000                                   |
	| gtid_mode                        | ON                                     |
	| gtid_owned                       |                                        |
	| gtid_purged                      | 9e520b78-013c-11eb-a84c-0800271bf591:4 |
	| session_track_gtids              | OFF                                    |
	+----------------------------------+----------------------------------------+
	8 rows in set (0.01 sec)


2. master
	
	shell> mysqldump -uroot -p123456abc --single-transaction --master-data=2 -R -E -A > 2020-10-15.sql
	
	
3. slave

	shell> mysql -uroot -p123456abc < 2020-10-15.sql
	mysql: [Warning] Using a password on the command line interface can be insecure.
	ERROR 1840 (HY000) at line 24: @@GLOBAL.GTID_PURGED can only be set when @@GLOBAL.GTID_EXECUTED is empty.
	-- 仅当@@ GLOBAL.GTID_EXECUTED为空时才能设置@@ GLOBAL.GTID_PURGED。）
	
	mysql> reset master;
	
	mysql> select * from mysql.gtid_executed;
	Empty set (0.00 sec)

	mysql> show global variables like '%gtid%';
	+----------------------------------+-------+
	| Variable_name                    | Value |
	+----------------------------------+-------+
	| binlog_gtid_simple_recovery      | ON    |
	| enforce_gtid_consistency         | ON    |
	| gtid_executed                    |       |
	| gtid_executed_compression_period | 1000  |
	| gtid_mode                        | ON    |
	| gtid_owned                       |       |
	| gtid_purged                      |       |
	| session_track_gtids              | OFF   |
	+----------------------------------+-------+
	8 rows in set (0.00 sec)
			
	-- 再次导入数据
	shell> mysql -uroot -p123456abc < 2020-10-15.sql
	mysql: [Warning] Using a password on the command line interface can be insecure.
	
	
	验证数据：
		master:
			mysql> SELECT * FROM test_db.t;
			+----+------+------+
			| id | c    | d    |
			+----+------+------+
			|  4 |    4 |    4 |
			|  5 |    5 |    5 |
			|  6 |    6 |    6 |
			|  7 |    7 |    7 |
			|  8 |    8 |    8 |
			|  9 |    9 |    9 |
			| 10 |   10 |   10 |
			+----+------+------+
			7 rows in set (0.00 sec)
		
		
		slave:
			mysql> SELECT * FROM test_db.t;
			+----+------+------+
			| id | c    | d    |
			+----+------+------+
			|  4 |    4 |    4 |
			|  5 |    5 |    5 |
			|  6 |    6 |    6 |
			|  7 |    7 |    7 |
			|  8 |    8 |    8 |
			|  9 |    9 |    9 |
			| 10 |   10 |   10 |
			+----+------+------+
			7 rows in set (0.00 sec)
					
		
