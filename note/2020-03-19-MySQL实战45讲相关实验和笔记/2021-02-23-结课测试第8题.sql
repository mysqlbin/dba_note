

CREATE TABLE `t20210223` (
  `age` int(10) NOT NULL,
  `tEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `test_db`.`t20210223` (`age`, `tEndTime`) VALUES ('1', now());

root@mysqldb 17:06:  [test_db]> desc select count(*) from t20210223;
+----+-------------+-----------+------------+------+---------------+------+---------+------+------+----------+-------+
| id | select_type | table     | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra |
+----+-------------+-----------+------------+------+---------------+------+---------+------+------+----------+-------+
|  1 | SIMPLE      | t20210223 | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    1 |   100.00 | NULL  |
+----+-------------+-----------+------------+------+---------------+------+---------+------+------+----------+-------+
1 row in set, 1 warning (0.00 sec)


--------------------------------------------------------------------------------------------------------------------

CREATE TABLE `t20210224` (
  `age` int(10) NOT NULL,
  `tEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `idx_age` (`age`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;
INSERT INTO `test_db`.`t20210224` (`age`, `tEndTime`) VALUES ('1', now());



root@mysqldb 17:06:  [test_db]> desc select count(*) from t20210224;
+----+-------------+-----------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
| id | select_type | table     | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra       |
+----+-------------+-----------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | t20210224 | NULL       | index | NULL          | idx_age | 4       | NULL |    1 |   100.00 | Using index |
+----+-------------+-----------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)



--------------------------------------------------------------------------------------------------------------------



CREATE TABLE `t20210225` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `age` int(10) NOT NULL,
  `tEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_age` (`age`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
INSERT INTO `test_db`.`t20210225` (`age`, `tEndTime`) VALUES ('1', now());


root@mysqldb 17:08:  [test_db]> desc select count(*) from t20210225;
+----+-------------+-----------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
| id | select_type | table     | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra       |
+----+-------------+-----------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | t20210225 | NULL       | index | NULL          | idx_age | 4       | NULL |    1 |   100.00 | Using index |
+----+-------------+-----------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)

扫描二级索引产生的代价比扫描主键索引的代价小。



--------------------------------------------------------------------------------------------------------------------


