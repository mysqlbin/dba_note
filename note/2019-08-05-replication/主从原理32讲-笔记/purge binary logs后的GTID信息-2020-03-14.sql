
1. old gtid info
2. purge binary logs to
3. new gtid info


1. old gtid info
	root@localhost [(none)]>select * from mysql.gtid_executed;
	+--------------------------------------+----------------+--------------+
	| source_uuid                          | interval_start | interval_end |
	+--------------------------------------+----------------+--------------+
	| f7323d17-6442-11ea-8a77-080027758761 |              1 |         1004 |
	+--------------------------------------+----------------+--------------+
	1 row in set (0.00 sec)

	root@localhost [(none)]> show global variables  like 'gtid_%';
	+----------------------------------+---------------------------------------------+
	| Variable_name                    | Value                                       |
	+----------------------------------+---------------------------------------------+
	| gtid_executed                    | f7323d17-6442-11ea-8a77-080027758761:1-1005 |
	| gtid_executed_compression_period | 1000                                        |
	| gtid_mode                        | ON                                          |
	| gtid_owned                       |                                             |
	| gtid_purged                      |                                             |
	+----------------------------------+---------------------------------------------+
	5 rows in set (0.00 sec)

	root@localhost [(none)]> show binary logs;
	+------------------+-----------+
	| Log_name         | File_size |
	+------------------+-----------+
	| mysql-bin.000001 |       475 |
	| mysql-bin.000002 |    454241 |
	| mysql-bin.000003 |      1603 |
	| mysql-bin.000004 |       648 |
	+------------------+-----------+
	4 rows in set (0.00 sec)


	root@localhost [(none)]>show binlog events in 'mysql-bin.000004';
	+------------------+-----+----------------+-----------+-------------+----------------------------------------------------------------------+
	| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                                                 |
	+------------------+-----+----------------+-----------+-------------+----------------------------------------------------------------------+
	| mysql-bin.000004 |   4 | Format_desc    |    273306 |         123 | Server ver: 5.7.19-log, Binlog ver: 4                                |
	| mysql-bin.000004 | 123 | Previous_gtids |    273306 |         194 | f7323d17-6442-11ea-8a77-080027758761:1-1004                          |
	| mysql-bin.000004 | 194 | Gtid           |    273306 |         259 | SET @@SESSION.GTID_NEXT= 'f7323d17-6442-11ea-8a77-080027758761:1005' |
	| mysql-bin.000004 | 259 | Query          |    273306 |         333 | BEGIN                                                                |
	| mysql-bin.000004 | 333 | Table_map      |    273306 |         392 | table_id: 131 (sbtest.sbtest1)                                       |
	| mysql-bin.000004 | 392 | Delete_rows    |    273306 |         617 | table_id: 131 flags: STMT_END_F                                      |
	| mysql-bin.000004 | 617 | Xid            |    273306 |         648 | COMMIT /* xid=1090 */                                                |
	+------------------+-----+----------------+-----------+-------------+----------------------------------------------------------------------+
	7 rows in set (0.00 sec)


2. purge binary logs to

	root@localhost [(none)]>purge binary logs to 'mysql-bin.000004';
	Query OK, 0 rows affected (0.04 sec)


3. new gtid info

	root@localhost [(none)]>select * from mysql.gtid_executed;
	+--------------------------------------+----------------+--------------+
	| source_uuid                          | interval_start | interval_end |
	+--------------------------------------+----------------+--------------+
	| f7323d17-6442-11ea-8a77-080027758761 |              1 |         1004 |
	+--------------------------------------+----------------+--------------+
	1 row in set (0.00 sec)

	root@localhost [(none)]>show global variables  like 'gtid_%';
	+----------------------------------+---------------------------------------------+
	| Variable_name                    | Value                                       |
	+----------------------------------+---------------------------------------------+
	| gtid_executed                    | f7323d17-6442-11ea-8a77-080027758761:1-1005 |
	| gtid_executed_compression_period | 1000                                        |
	| gtid_mode                        | ON                                          |
	| gtid_owned                       |                                             |
	| gtid_purged                      | f7323d17-6442-11ea-8a77-080027758761:1-1004 |
	+----------------------------------+---------------------------------------------+
	5 rows in set (0.00 sec)


	root@localhost [(none)]> show binary logs;
	+------------------+-----------+
	| Log_name         | File_size |
	+------------------+-----------+
	| mysql-bin.000004 |       648 |
	+------------------+-----------+
	1 row in set (0.00 sec)


