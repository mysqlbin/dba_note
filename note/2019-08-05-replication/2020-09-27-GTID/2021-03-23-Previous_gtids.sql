
在所有binlog里定位某个GTID是不是效率也很低？

	在binlog文件开头，有一个 Previous_gtids, 用于记录 "生成这个binlog的时候，实例的Executed_gtid_set", 所以启动的时候只需要解析最后一个文件；
	同样的, 由于有这个 Previous_gtids, 可以快速地定位GTID在哪个文件里。
	
	Previous：以前的
	Previous_gtids：生成这个binlog的时候，实例的 Executed_gtid_set

	by MySQL实战45讲 第27讲

Previous_gtids_log_event 和 GTID_LOG_EVENT 简介

	Previous_gtids_log_event
		
		包含在每一个 binary log 的开头，用于描述直到上一个 binary log 所包含的全部 GTID（包括已经删除的 binary log）
		在 5.7 中即便不开启 GTID 也会包含这个 Previous_gtids_log_event
		为快速扫描 binary log 获得正确 gtid_executed 变量提供了基础， 否则可能扫描大量的 binary log 才能得到（比如关闭 GTID 的情况）
		
		mysql> show binlog events in 'mysql-bin.000008';
		+------------------+------+----------------+-----------+-------------+----------------------------------------------------------------------+
		| Log_name         | Pos  | Event_type     | Server_id | End_log_pos | Info                                                                 |
		+------------------+------+----------------+-----------+-------------+----------------------------------------------------------------------+
		| mysql-bin.000008 |    4 | Format_desc    |    330640 |         123 | Server ver: 5.7.22-log, Binlog ver: 4                                |
		| mysql-bin.000008 |  123 | Previous_gtids |    330640 |         194 | 7af746a1-5c2d-11ea-bc75-00163e08b460:1-5600                          |
		| mysql-bin.000008 |  194 | Gtid           |    330640 |         259 | SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:5601' |
		| mysql-bin.000008 |  259 | Query          |    330640 |         346 | BEGIN                                                                |
		| mysql-bin.000008 |  346 | Table_map      |    330640 |         400 | table_id: 562 (niuniuh5_db.t)                                        |
		| mysql-bin.000008 |  400 | Write_rows     |    330640 |         448 | table_id: 562 flags: STMT_END_F                                      |
		| mysql-bin.000008 |  448 | Xid            |    330640 |         479 | COMMIT /* xid=36095 */                                               |
		
		上一个 binary log(mysql-bin.000007) 所包含的全部 GTID : 7af746a1-5c2d-11ea-bc75-00163e08b460:1-5600
		
	by 主从原理 第1讲
	
root@mysqldb 10:36:  [(none)]> show binlog events in 'mysql-bin.000056';
+------------------+-----+----------------+-----------+-------------+---------------------------------------+
| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                  |
+------------------+-----+----------------+-----------+-------------+---------------------------------------+
| mysql-bin.000056 |   4 | Format_desc    |    330607 |         123 | Server ver: 5.7.22-log, Binlog ver: 4 |
| mysql-bin.000056 | 123 | Previous_gtids |    330607 |         154 |                                       |
+------------------+-----+----------------+-----------+-------------+---------------------------------------+
2 rows in set (0.00 sec)

root@mysqldb 10:36:  [(none)]> use yldbs;
Database changed
root@mysqldb 10:36:  [yldbs]> delete from t1 where id=1;
Query OK, 1 row affected (0.00 sec)

root@mysqldb 10:36:  [yldbs]> show binlog events in 'mysql-bin.000056';
+------------------+-----+----------------+-----------+-------------+----------------------------------------------------------------------+
| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                                                 |
+------------------+-----+----------------+-----------+-------------+----------------------------------------------------------------------+
| mysql-bin.000056 |   4 | Format_desc    |    330607 |         123 | Server ver: 5.7.22-log, Binlog ver: 4                                |
| mysql-bin.000056 | 123 | Previous_gtids |    330607 |         154 |                                                                      |
| mysql-bin.000056 | 154 | Gtid           |    330607 |         219 | SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:1635' |
| mysql-bin.000056 | 219 | Query          |    330607 |         292 | BEGIN                                                                |
| mysql-bin.000056 | 292 | Table_map      |    330607 |         341 | table_id: 112 (yldbs.t1)                                             |
| mysql-bin.000056 | 341 | Delete_rows    |    330607 |         389 | table_id: 112 flags: STMT_END_F                                      |
| mysql-bin.000056 | 389 | Xid            |    330607 |         420 | COMMIT /* xid=47 */                                                  |
+------------------+-----+----------------+-----------+-------------+----------------------------------------------------------------------+
7 rows in set (0.00 sec)

--------------------------------------------------------------------------------------------------------------------------------------------

root@mysqldb 10:36:  [yldbs]> flush logs;
Query OK, 0 rows affected (0.23 sec)

root@mysqldb 10:37:  [yldbs]> show binary logs;
+------------------+-----------+
| Log_name         | File_size |
+------------------+-----------+
| mysql-bin.000056 |       467 |
| mysql-bin.000057 |       194 |
+------------------+-----------+
2 rows in set (0.00 sec)

root@mysqldb 10:37:  [yldbs]> show binlog events in 'mysql-bin.000057';
+------------------+-----+----------------+-----------+-------------+-------------------------------------------+
| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                      |
+------------------+-----+----------------+-----------+-------------+-------------------------------------------+
| mysql-bin.000057 |   4 | Format_desc    |    330607 |         123 | Server ver: 5.7.22-log, Binlog ver: 4     |
| mysql-bin.000057 | 123 | Previous_gtids |    330607 |         194 | 56e3abc1-a3e7-11ea-8d96-484d7ea518b9:1635 |
+------------------+-----+----------------+-----------+-------------+-------------------------------------------+
2 rows in set (0.00 sec)

root@mysqldb 10:37:  [yldbs]> delete from table_user where nplayerid=1000;
Query OK, 1 row affected (0.00 sec)

root@mysqldb 10:38:  [yldbs]> show binlog events in 'mysql-bin.000057';
+------------------+-----+----------------+-----------+-------------+----------------------------------------------------------------------+
| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                                                 |
+------------------+-----+----------------+-----------+-------------+----------------------------------------------------------------------+
| mysql-bin.000057 |   4 | Format_desc    |    330607 |         123 | Server ver: 5.7.22-log, Binlog ver: 4                                |
| mysql-bin.000057 | 123 | Previous_gtids |    330607 |         194 | 56e3abc1-a3e7-11ea-8d96-484d7ea518b9:1635                            |
| mysql-bin.000057 | 194 | Gtid           |    330607 |         259 | SET @@SESSION.GTID_NEXT= '56e3abc1-a3e7-11ea-8d96-484d7ea518b9:1636' |
| mysql-bin.000057 | 259 | Query          |    330607 |         332 | BEGIN                                                                |
| mysql-bin.000057 | 332 | Table_map      |    330607 |         443 | table_id: 113 (yldbs.table_user)                                     |
| mysql-bin.000057 | 443 | Delete_rows    |    330607 |         635 | table_id: 113 flags: STMT_END_F                                      |
| mysql-bin.000057 | 635 | Xid            |    330607 |         666 | COMMIT /* xid=71 */                                                  |
+------------------+-----+----------------+-----------+-------------+----------------------------------------------------------------------+
7 rows in set (0.00 sec)


