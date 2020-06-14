

mysql> select version();
+------------+
| version()  |
+------------+
| 5.7.22-log |
+------------+
1 row in set (0.00 sec)


CREATE TABLE `tinyint_out_of_range` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键/索引',
  `game_type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='测试表';

mysql> insert into tinyint_out_of_range(`game_type`) values(127);
Query OK, 1 row affected (0.01 sec)

mysql> insert into tinyint_out_of_range(`game_type`) values(128);
ERROR 1264 (22003): Out of range value for column 'game_type' at row 1

mysql> select * from tinyint_out_of_range;
+----+-----------+
| ID | game_type |
+----+-----------+
|  1 |       127 |
+----+-----------+
1 row in set (0.00 sec)




