



root@localhost [(none)]>select @@server_uuid;
+--------------------------------------+
| @@server_uuid                        |
+--------------------------------------+
| f7323d17-6442-11ea-8a77-080027758761 |
+--------------------------------------+
1 row in set (0.00 sec)

root@localhost [(none)]>select * from mysql.gtid_executed;
+--------------------------------------+----------------+--------------+
| source_uuid                          | interval_start | interval_end |
+--------------------------------------+----------------+--------------+
| c27f419e-cecd-27e7-9649-0800279d4f09 |              1 |         1613 |
| c39f419e-cecd-26e7-9649-0800279d4f09 |              1 |       922364 |
| f7323d17-6442-11ea-8a77-080027758761 |              1 |            1 |
+--------------------------------------+----------------+--------------+
3 rows in set (0.00 sec)

root@localhost [(none)]> show global variables  like '%gtid%';
+----------------------------------+--------------------------------------------------------------------------------------------------------------------------------------+
| Variable_name                    | Value                                                                                                                                |
+----------------------------------+--------------------------------------------------------------------------------------------------------------------------------------+
| binlog_gtid_simple_recovery      | ON                                                                                                                                   |
| enforce_gtid_consistency         | ON                                                                                                                                   |
| gtid_executed                    | c27f419e-cecd-27e7-9649-0800279d4f09:1-1613,
c39f419e-cecd-26e7-9649-0800279d4f09:1-922364,
f7323d17-6442-11ea-8a77-080027758761:1-2 |
| gtid_executed_compression_period | 1000                                                                                                                                 |
| gtid_mode                        | ON                                                                                                                                   |
| gtid_owned                       |                                                                                                                                      |
| gtid_purged                      | c27f419e-cecd-27e7-9649-0800279d4f09:1-620,
c39f419e-cecd-26e7-9649-0800279d4f09:1-922364                                            |
| session_track_gtids              | OFF                                                                                                                                  |
+----------------------------------+--------------------------------------------------------------------------------------------------------------------------------------+
8 rows in set (0.00 sec)

root@localhost [(none)]>reset master;^C
root@localhost [(none)]>show master status\G;
*************************** 1. row ***************************
             File: mysql-bin.000044
         Position: 548
     Binlog_Do_DB: 
 Binlog_Ignore_DB: 
Executed_Gtid_Set: c27f419e-cecd-27e7-9649-0800279d4f09:1-1613,
c39f419e-cecd-26e7-9649-0800279d4f09:1-922364,
f7323d17-6442-11ea-8a77-080027758761:1-2
1 row in set (0.00 sec)

ERROR: 
No query specified

root@localhost [(none)]>reset master;
Query OK, 0 rows affected (0.01 sec)

root@localhost [(none)]>select * from mysql.gtid_executed;
Empty set (0.00 sec)

root@localhost [(none)]> show global variables  like '%gtid%';
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

root@localhost [(none)]>show master status\G;
*************************** 1. row ***************************
             File: mysql-bin.000001
         Position: 154
     Binlog_Do_DB: 
 Binlog_Ignore_DB: 
Executed_Gtid_Set: 
1 row in set (0.00 sec)

ERROR: 
No query specified

root@localhost [(none)]>




[root@env logs]# ll
total 8
-rw-r----- 1 mysql mysql 154 Mar 14 12:40 mysql-bin.000001
-rw-r----- 1 mysql mysql  44 Mar 14 12:40 mysql-bin.index

root@localhost [(none)]>show binary logs;
+------------------+-----------+
| Log_name         | File_size |
+------------------+-----------+
| mysql-bin.000001 |       154 |
+------------------+-----------+
1 row in set (0.00 sec)


清除 GTID 信息：
	mysql.gtid_executed 表信息
	gtid_executed
	gtid_purged
	
清空 binary log


