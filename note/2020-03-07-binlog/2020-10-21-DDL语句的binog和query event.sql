



mysql> alter table table_bbbbbbbbbbbbbbbbbbbbbbbb add column b int(11) default null;

	--语句执行期间没有记录binlog。

	mysql> show binlog events in 'mysql-bin.000036';
	+------------------+-----+----------------+-----------+-------------+---------------------------------------+
	| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                  |
	+------------------+-----+----------------+-----------+-------------+---------------------------------------+
	| mysql-bin.000036 |   4 | Format_desc    |    330607 |         123 | Server ver: 5.7.22-log, Binlog ver: 4 |
	| mysql-bin.000036 | 123 | Previous_gtids |    330607 |         154 |                                       |
	+------------------+-----+----------------+-----------+-------------+---------------------------------------+
	2 rows in set (0.00 sec)



mysql> alter table table_bbbbbbbbbbbbbbbbbbbbbbbb add column b int(11) default null;
Query OK, 0 rows affected (41.19 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> show binlog events in 'mysql-bin.000036';
+------------------+-----+----------------+-----------+-------------+-------------------------------------------------------------------------------------------------+
| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                                                                            |
+------------------+-----+----------------+-----------+-------------+-------------------------------------------------------------------------------------------------+
| mysql-bin.000036 |   4 | Format_desc    |    330607 |         123 | Server ver: 5.7.22-log, Binlog ver: 4                                                           |
| mysql-bin.000036 | 123 | Previous_gtids |    330607 |         154 |                                                                                                 |
| mysql-bin.000036 | 154 | Anonymous_Gtid |    330607 |         219 | SET @@SESSION.GTID_NEXT= 'ANONYMOUS'                                                            |
| mysql-bin.000036 | 219 | Query          |    330607 |         387 | use `aiuaiuh9_db`; alter table table_bbbbbbbbbbbbbbbbbbbbbbbb add column b int(11) default null |
+------------------+-----+----------------+-----------+-------------+-------------------------------------------------------------------------------------------------+
4 rows in set (0.00 sec)


shell> mysqlbinlog -vv --base64-output='decode-rows' mysql-bin.000036 > 36_binlog.sql

shell> cat 36_binlog.sql 
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
DELIMITER /*!*/;
# at 4
#201021 18:29:49 server id 330607  end_log_pos 123 CRC32 0xbabbec30 	Start: binlog v 4, server v 5.7.22-log created 201021 18:29:49
# Warning: this binlog is either in use or was not closed properly.
# at 123
#201021 18:29:49 server id 330607  end_log_pos 154 CRC32 0x564ab565 	Previous-GTIDs
# [empty]
# at 154
#201021 18:30:45 server id 330607  end_log_pos 219 CRC32 0x7ca5ec94 	Anonymous_GTID	last_committed=0	sequence_number=1	rbr_only=no
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 219
#201021 18:30:45 server id 330607  end_log_pos 387 CRC32 0x9b873d7a 	Query	thread_id=132	exec_time=41	error_code=0   -- query event
use `aiuaiuh9_db`/*!*/;
SET TIMESTAMP=1603276245.526404/*!*/;
SET @@session.pseudo_thread_id=132/*!*/;
SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=0, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
SET @@session.sql_mode=1075838976/*!*/;
SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
/*!\C utf8 *//*!*/;
SET @@session.character_set_client=33,@@session.collation_connection=33,@@session.collation_server=45/*!*/;
SET @@session.lc_time_names=0/*!*/;
SET @@session.collation_database=DEFAULT/*!*/;
alter table table_bbbbbbbbbbbbbbbbbbbbbbbb add column b int(11) default null
/*!*/;
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
DELIMITER ;
# End of log file
/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;



-- 验证了 query event 实际记录了 DDL语句的执行时间。


