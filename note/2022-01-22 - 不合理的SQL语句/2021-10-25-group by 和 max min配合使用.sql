


CREATE TABLE `table_total` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
  `szToken` varchar(64) NOT NULL DEFAULT '' COMMENT '',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='';

INSERT INTO `table_total` (`ID`, `szToken`) VALUES ('1', '666002-110995-1631192439');
INSERT INTO `table_total` (`ID`, `szToken`) VALUES ('2', '666002-110995-1631192439');
INSERT INTO `table_total` (`ID`, `szToken`) VALUES ('3', '666002-110995-1631192440');
INSERT INTO `table_total` (`ID`, `szToken`) VALUES ('4', '666002-110995-1631192440');
INSERT INTO `table_total` (`ID`, `szToken`) VALUES ('5', '666002-110995-1631192443');
INSERT INTO `table_total` (`ID`, `szToken`) VALUES ('6', '666002-110995-1631192443');
INSERT INTO `table_total` (`ID`, `szToken`) VALUES ('7', '666002-110995-1631192443');

-- 错误姿势
	mysql> select max(id), min(id) from (
		select id from table_total group by szToken order by id desc limit 2
	)temp;
	+---------+---------+
	| max(id) | min(id) |
	+---------+---------+
	|       5 |       3 |
	+---------+---------+
	1 row in set (0.00 sec)
		-- 不符合语义
		
---------------------------------------------------------------------------------------

-- 错误姿势

	mysql> select max(id) id from table_total group by szToken order by id desc limit 2;
	+------+
	| id   |
	+------+
	|    7 |
	|    4 |
	+------+
	2 rows in set (0.00 sec)

-- 正确姿势

	mysql> select max(id) from (
		select max(id) id from table_total group by szToken order by id desc limit 2
	)temp;

	+---------+
	| max(id) |
	+---------+
	|       7 |
	+---------+
	1 row in set (0.00 sec)


---------------------------------------------------------------------------------------

-- 错误姿势

	mysql> select min(id) id from table_total group by szToken order by id desc limit 2;
	+------+
	| id   |
	+------+
	|    5 |
	|    3 |
	+------+
	2 rows in set (0.00 sec)

-- 正确姿势

	mysql> select min(id) from (
		select min(id) id from table_total group by szToken order by id desc limit 2
	)temp;
	+---------+
	| min(id) |
	+---------+
	|       3 |
	+---------+
	1 row in set (0.00 sec)


