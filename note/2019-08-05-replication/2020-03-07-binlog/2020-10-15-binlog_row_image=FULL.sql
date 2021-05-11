
0. 相关参数
1. 已经产生的binary log和表结构和数据初始化
2. binlog events
	2.1 创建表
	2.2 插入记录
	2.3 更新记录
	2.4 删除记录
	2.5 完整版
	2.6 DDL
3. mysqlbinlog

0. 相关参数

	mysql> show global variables like 'gtid_mode';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| gtid_mode     | ON    |
	+---------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like 'enforce_gtid_consistency';
	+--------------------------+-------+
	| Variable_name            | Value |
	+--------------------------+-------+
	| enforce_gtid_consistency | ON    |
	+--------------------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like 'binlog_row_image';
	+------------------+-------+
	| Variable_name    | Value |
	+------------------+-------+
	| binlog_row_image | FULL  |
	+------------------+-------+
	1 row in set (0.00 sec)


1. 已经产生的binary log和表结构和数据初始化

	root@mysqldb 14:54:  [(none)]> show binlog events in 'mysql-bin.000007';
	+------------------+-----+----------------+-----------+-------------+---------------------------------------------+
	| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                        |
	+------------------+-----+----------------+-----------+-------------+---------------------------------------------+
	| mysql-bin.000007 |   4 | Format_desc    |    330640 |         123 | Server ver: 5.7.22-log, Binlog ver: 4       |
	| mysql-bin.000007 | 123 | Previous_gtids |    330640 |         194 | 7af746a1-5c2d-11ea-bc75-00163e08b460:1-5594 |
	+------------------+-----+----------------+-----------+-------------+---------------------------------------------+
	2 rows in set (0.00 sec)

	CREATE TABLE `t` (
	  `id` int(11) NOT NULL,
	  `a` int(11) DEFAULT NULL,
	  `t_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`id`),
	  KEY `t_modified`(`t_modified`)
	) ENGINE=InnoDB;

	insert into t values(1,1,'2018-11-13');
	insert into t values(2,2,'2018-11-12');

	update t set a=3 where id=1;

	delete from t where id=1;


2. binlog events

2.1 创建表
	mysql> show binlog events in 'mysql-bin.000007';
	+------------------+-----+----------------+-----------+-------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                                                                                                                                                                                                                 |
	+------------------+-----+----------------+-----------+-------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| mysql-bin.000007 |   4 | Format_desc    |    330640 |         123 | Server ver: 5.7.22-log, Binlog ver: 4                                                                                                                                                                                                |
	| mysql-bin.000007 | 123 | Previous_gtids |    330640 |         194 | 7af746a1-5c2d-11ea-bc75-00163e08b460:1-5594                                                                                                                                                                                          |
	| mysql-bin.000007 | 194 | Gtid           |    330640 |         259 | SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:5595'                                                                                                                                                                 |
	| mysql-bin.000007 | 259 | Query          |    330640 |         558 | use `niuniuh5_db`; CREATE TABLE `t` (
	  `id` int(11) NOT NULL,
	  `a` int(11) DEFAULT NULL,
	  `t_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`id`),
	  KEY `t_modified`(`t_modified`)
	) ENGINE=InnoDB |
	+------------------+-----+----------------+-----------+-------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	4 rows in set (0.00 sec)

2.2 插入记录

	mysql> show binlog events in 'mysql-bin.000008' from  123 limit 11;
	+------------------+-----+----------------+-----------+-------------+----------------------------------------------------------------------+
	| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                                                 |
	+------------------+-----+----------------+-----------+-------------+----------------------------------------------------------------------+
	| mysql-bin.000008 | 123 | Previous_gtids |    330640 |         194 | 7af746a1-5c2d-11ea-bc75-00163e08b460:1-5600                          |
	| mysql-bin.000008 | 194 | Gtid           |    330640 |         259 | SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:5601' |
	| mysql-bin.000008 | 259 | Query          |    330640 |         346 | BEGIN                                                                |
	| mysql-bin.000008 | 346 | Table_map      |    330640 |         400 | table_id: 562 (niuniuh5_db.t)                                        |
	| mysql-bin.000008 | 400 | Write_rows     |    330640 |         448 | table_id: 562 flags: STMT_END_F                                      |
	| mysql-bin.000008 | 448 | Xid            |    330640 |         479 | COMMIT /* xid=36095 */                                               |
	| mysql-bin.000008 | 479 | Gtid           |    330640 |         544 | SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:5602' |
	| mysql-bin.000008 | 544 | Query          |    330640 |         631 | BEGIN                                                                |
	| mysql-bin.000008 | 631 | Table_map      |    330640 |         685 | table_id: 562 (niuniuh5_db.t)                                        |
	| mysql-bin.000008 | 685 | Write_rows     |    330640 |         733 | table_id: 562 flags: STMT_END_F                                      |
	| mysql-bin.000008 | 733 | Xid            |    330640 |         764 | COMMIT /* xid=36096 */                                               |
	+------------------+-----+----------------+-----------+-------------+----------------------------------------------------------------------+
	11 rows in set (0.00 sec)

2.3 更新记录
	mysql> show binlog events in 'mysql-bin.000008' from 764 limit 5;
	+------------------+------+-------------+-----------+-------------+----------------------------------------------------------------------+
	| Log_name         | Pos  | Event_type  | Server_id | End_log_pos | Info                                                                 |
	+------------------+------+-------------+-----------+-------------+----------------------------------------------------------------------+
	| mysql-bin.000008 |  764 | Gtid        |    330640 |         829 | SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:5603' |
	| mysql-bin.000008 |  829 | Query       |    330640 |         908 | BEGIN                                                                |
	| mysql-bin.000008 |  908 | Table_map   |    330640 |         962 | table_id: 562 (niuniuh5_db.t)                                        |
	| mysql-bin.000008 |  962 | Update_rows |    330640 |        1024 | table_id: 562 flags: STMT_END_F                                      |
	| mysql-bin.000008 | 1024 | Xid         |    330640 |        1055 | COMMIT /* xid=36102 */                                               |
	+------------------+------+-------------+-----------+-------------+----------------------------------------------------------------------+
	5 rows in set (0.00 sec)

2.4 删除记录
	mysql> show binlog events in 'mysql-bin.000008' from 1055 limit 5;
	+------------------+------+-------------+-----------+-------------+----------------------------------------------------------------------+
	| Log_name         | Pos  | Event_type  | Server_id | End_log_pos | Info                                                                 |
	+------------------+------+-------------+-----------+-------------+----------------------------------------------------------------------+
	| mysql-bin.000008 | 1055 | Gtid        |    330640 |        1120 | SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:5604' |
	| mysql-bin.000008 | 1120 | Query       |    330640 |        1199 | BEGIN                                                                |
	| mysql-bin.000008 | 1199 | Table_map   |    330640 |        1253 | table_id: 562 (niuniuh5_db.t)                                        |
	| mysql-bin.000008 | 1253 | Delete_rows |    330640 |        1301 | table_id: 562 flags: STMT_END_F                                      |
	| mysql-bin.000008 | 1301 | Xid         |    330640 |        1332 | COMMIT /* xid=36108 */                                               |
	+------------------+------+-------------+-----------+-------------+----------------------------------------------------------------------+


2.5 完整版
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
	| mysql-bin.000008 |  479 | Gtid           |    330640 |         544 | SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:5602' |
	| mysql-bin.000008 |  544 | Query          |    330640 |         631 | BEGIN                                                                |
	| mysql-bin.000008 |  631 | Table_map      |    330640 |         685 | table_id: 562 (niuniuh5_db.t)                                        |
	| mysql-bin.000008 |  685 | Write_rows     |    330640 |         733 | table_id: 562 flags: STMT_END_F                                      |
	| mysql-bin.000008 |  733 | Xid            |    330640 |         764 | COMMIT /* xid=36096 */                                               |
	| mysql-bin.000008 |  764 | Gtid           |    330640 |         829 | SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:5603' |
	| mysql-bin.000008 |  829 | Query          |    330640 |         908 | BEGIN                                                                |
	| mysql-bin.000008 |  908 | Table_map      |    330640 |         962 | table_id: 562 (niuniuh5_db.t)                                        |
	| mysql-bin.000008 |  962 | Update_rows    |    330640 |        1024 | table_id: 562 flags: STMT_END_F                                      |
	| mysql-bin.000008 | 1024 | Xid            |    330640 |        1055 | COMMIT /* xid=36102 */                                               |
	| mysql-bin.000008 | 1055 | Gtid           |    330640 |        1120 | SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:5604' |
	| mysql-bin.000008 | 1120 | Query          |    330640 |        1199 | BEGIN                                                                |
	| mysql-bin.000008 | 1199 | Table_map      |    330640 |        1253 | table_id: 562 (niuniuh5_db.t)                                        |
	| mysql-bin.000008 | 1253 | Delete_rows    |    330640 |        1301 | table_id: 562 flags: STMT_END_F                                      |
	| mysql-bin.000008 | 1301 | Xid            |    330640 |        1332 | COMMIT /* xid=36108 */                                               |
	+------------------+------+----------------+-----------+-------------+----------------------------------------------------------------------+
	22 rows in set (0.00 sec)

2.6 DDL
	
	alter table t add column b int(11) default null after a;
		--这里没有记录这个DDL的执行时间，所以和binlog中 exec_time 没有对应上，不方便理解。
		
	root@mysqldb 20:29:  [(none)]> show binlog events in 'mysql-bin.000010';
	+------------------+-----+----------------+-----------+-------------+----------------------------------------------------------------------------+
	| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                                                       |
	+------------------+-----+----------------+-----------+-------------+----------------------------------------------------------------------------+
	| mysql-bin.000010 |   4 | Format_desc    |    330640 |         123 | Server ver: 5.7.22-log, Binlog ver: 4                                      |
	| mysql-bin.000010 | 123 | Previous_gtids |    330640 |         194 | 7af746a1-5c2d-11ea-bc75-00163e08b460:1-5768                                |

	| mysql-bin.000010 | 194 | Gtid           |    330640 |         259 | SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:5769'       |
	| mysql-bin.000010 | 259 | Query          |    330640 |         402 | use `niuniuh5_db`; alter table t add column b int(11) default null after a |
	| mysql-bin.000010 | 402 | Rotate         |    330640 |         449 | mysql-bin.000011;pos=4                                                     |
	+------------------+-----+----------------+-----------+-------------+----------------------------------------------------------------------------+
	5 rows in set (0.00 sec)
	
	mysqlbinlog -vv --base64-output='decode-rows' mysql-bin.000010 > 10-DDL binlog.sql

	
3. mysqlbinlog
	
	mysqlbinlog -vv --base64-output='decode-rows' --start-position=194 mysql-bin.000008 > vv_base64.sql

	mysqlbinlog -vv  --start-position=194 mysql-bin.000008 > vv.sql

	mysqlbinlog -v  --start-position=194 mysql-bin.000008 > v.sql
	


