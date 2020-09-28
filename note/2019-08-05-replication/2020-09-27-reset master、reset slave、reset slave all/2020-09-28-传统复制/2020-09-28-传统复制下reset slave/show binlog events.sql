

mysql> show binlog events in 'mysql-bin.000001';
+------------------+-----+----------------+-----------+-------------+---------------------------------------+
| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                  |
+------------------+-----+----------------+-----------+-------------+---------------------------------------+
| mysql-bin.000001 |   4 | Format_desc    |    330607 |         123 | Server ver: 5.7.22-log, Binlog ver: 4 |
| mysql-bin.000001 | 123 | Previous_gtids |    330607 |         154 |                                       |
| mysql-bin.000001 | 154 | Stop           |    330607 |         177 |                                       |
+------------------+-----+----------------+-----------+-------------+---------------------------------------+
3 rows in set (0.00 sec)


mysql> show binlog events in 'mysql-bin.000002';
+------------------+-----+----------------+-----------+-------------+----------------------------------------------------------------------------------------------------------------------+
| Log_name         | Pos | Event_type     | Server_id | End_log_pos | Info                                                                                                                 |
+------------------+-----+----------------+-----------+-------------+----------------------------------------------------------------------------------------------------------------------+
| mysql-bin.000002 |   4 | Format_desc    |    330607 |         123 | Server ver: 5.7.22-log, Binlog ver: 4                                                                                |
| mysql-bin.000002 | 123 | Previous_gtids |    330607 |         154 |                                                                                                                      |
| mysql-bin.000002 | 154 | Anonymous_Gtid |    330607 |         219 | SET @@SESSION.GTID_NEXT= 'ANONYMOUS'                                                                                 |
| mysql-bin.000002 | 219 | Query          |    330607 |         414 | ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' AS '*FF051C055989F0D4D3E061F738DD68E277934095' |
| mysql-bin.000002 | 414 | Stop           |    330607 |         437 |                                                                                                                      |
+------------------+-----+----------------+-----------+-------------+----------------------------------------------------------------------------------------------------------------------+
5 rows in set (0.00 sec)


mysql> show binlog events in 'mysql-bin.000003';
+------------------+------+----------------+-----------+-------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Log_name         | Pos  | Event_type     | Server_id | End_log_pos | Info                                                                                                                                                                                                                |
+------------------+------+----------------+-----------+-------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| mysql-bin.000003 |    4 | Format_desc    |    330607 |         123 | Server ver: 5.7.22-log, Binlog ver: 4                                                                                                                                                                               |
| mysql-bin.000003 |  123 | Previous_gtids |    330607 |         154 |                                                                                                                                                                                                                     |
| mysql-bin.000003 |  154 | Anonymous_Gtid |    330607 |         219 | SET @@SESSION.GTID_NEXT= 'ANONYMOUS'                                                                                                                                                                                |
| mysql-bin.000003 |  219 | Query          |    330607 |         448 | GRANT REPLICATION SLAVE ON *.* TO 'rpl'@'192.168.0.202' IDENTIFIED WITH 'mysql_native_password' AS '*3C76A04FE84B30367B4DBEAD39C53842FB508A39'                                                                      |
| mysql-bin.000003 |  448 | Anonymous_Gtid |    330607 |         513 | SET @@SESSION.GTID_NEXT= 'ANONYMOUS'                                                                                                                                                                                |
| mysql-bin.000003 |  513 | Query          |    330607 |         641 | create  database test_db DEFAULT CHARSET utf8mb4                                                                                                                                                                    |
| mysql-bin.000003 |  641 | Anonymous_Gtid |    330607 |         706 | SET @@SESSION.GTID_NEXT= 'ANONYMOUS'                                                                                                                                                                                |
| mysql-bin.000003 |  706 | Query          |    330607 |         982 | use `test_db`; CREATE TABLE `t` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `c` (`c`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 |
| mysql-bin.000003 |  982 | Anonymous_Gtid |    330607 |        1047 | SET @@SESSION.GTID_NEXT= 'ANONYMOUS'                                                                                                                                                                                |
| mysql-bin.000003 | 1047 | Query          |    330607 |        1122 | BEGIN                                                                                                                                                                                                               |
| mysql-bin.000003 | 1122 | Table_map      |    330607 |        1171 | table_id: 108 (test_db.t)                                                                                                                                                                                           |
| mysql-bin.000003 | 1171 | Write_rows     |    330607 |        1223 | table_id: 108 flags: STMT_END_F                                                                                                                                                                                     |
| mysql-bin.000003 | 1223 | Xid            |    330607 |        1254 | COMMIT /* xid=39 */                                                                                                                                                                                                 |
| mysql-bin.000003 | 1254 | Anonymous_Gtid |    330607 |        1319 | SET @@SESSION.GTID_NEXT= 'ANONYMOUS'                                                                                                                                                                                |
| mysql-bin.000003 | 1319 | Query          |    330607 |        1394 | BEGIN                                                                                                                                                                                                               |
| mysql-bin.000003 | 1394 | Table_map      |    330607 |        1443 | table_id: 108 (test_db.t)                                                                                                                                                                                           |
| mysql-bin.000003 | 1443 | Write_rows     |    330607 |        1495 | table_id: 108 flags: STMT_END_F                                                                                                                                                                                     |
| mysql-bin.000003 | 1495 | Xid            |    330607 |        1526 | COMMIT /* xid=40 */                                                                                                                                                                                                 |
| mysql-bin.000003 | 1526 | Anonymous_Gtid |    330607 |        1591 | SET @@SESSION.GTID_NEXT= 'ANONYMOUS'                                                                                                                                                                                |
| mysql-bin.000003 | 1591 | Query          |    330607 |        1666 | BEGIN                                                                                                                                                                                                               |
| mysql-bin.000003 | 1666 | Table_map      |    330607 |        1715 | table_id: 108 (test_db.t)                                                                                                                                                                                           |
| mysql-bin.000003 | 1715 | Write_rows     |    330607 |        1767 | table_id: 108 flags: STMT_END_F                                                                                                                                                                                     |
| mysql-bin.000003 | 1767 | Xid            |    330607 |        1798 | COMMIT /* xid=41 */                                                                                                                                                                                                 |
| mysql-bin.000003 | 1798 | Anonymous_Gtid |    330607 |        1863 | SET @@SESSION.GTID_NEXT= 'ANONYMOUS'                                                                                                                                                                                |
| mysql-bin.000003 | 1863 | Query          |    330607 |        1938 | BEGIN                                                                                                                                                                                                               |
| mysql-bin.000003 | 1938 | Table_map      |    330607 |        1987 | table_id: 108 (test_db.t)                                                                                                                                                                                           |
| mysql-bin.000003 | 1987 | Write_rows     |    330607 |        2039 | table_id: 108 flags: STMT_END_F                                                                                                                                                                                     |
| mysql-bin.000003 | 2039 | Xid            |    330607 |        2070 | COMMIT /* xid=42 */                                                                                                                                                                                                 |
| mysql-bin.000003 | 2070 | Anonymous_Gtid |    330607 |        2135 | SET @@SESSION.GTID_NEXT= 'ANONYMOUS'                                                                                                                                                                                |
| mysql-bin.000003 | 2135 | Query          |    330607 |        2210 | BEGIN                                                                                                                                                                                                               |
| mysql-bin.000003 | 2210 | Table_map      |    330607 |        2259 | table_id: 108 (test_db.t)                                                                                                                                                                                           |
| mysql-bin.000003 | 2259 | Write_rows     |    330607 |        2311 | table_id: 108 flags: STMT_END_F                                                                                                                                                                                     |
| mysql-bin.000003 | 2311 | Xid            |    330607 |        2342 | COMMIT /* xid=43 */                                                                                                                                                                                                 |
| mysql-bin.000003 | 2342 | Anonymous_Gtid |    330607 |        2407 | SET @@SESSION.GTID_NEXT= 'ANONYMOUS'                                                                                                                                                                                |
| mysql-bin.000003 | 2407 | Query          |    330607 |        2482 | BEGIN                                                                                                                                                                                                               |
| mysql-bin.000003 | 2482 | Table_map      |    330607 |        2531 | table_id: 108 (test_db.t)                                                                                                                                                                                           |
| mysql-bin.000003 | 2531 | Write_rows     |    330607 |        2583 | table_id: 108 flags: STMT_END_F                                                                                                                                                                                     |
| mysql-bin.000003 | 2583 | Xid            |    330607 |        2614 | COMMIT /* xid=47 */                                                                                                                                                                                                 |
+------------------+------+----------------+-----------+-------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
38 rows in set (0.00 sec)



