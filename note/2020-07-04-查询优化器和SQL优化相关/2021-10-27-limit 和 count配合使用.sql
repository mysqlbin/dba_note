

CREATE TABLE `t_20211027` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '索引',
  `nPlayerID` int(11) NOT NULL COMMENT '玩家ID',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='';


INSERT INTO `audit_db`.`t_20211027` (`ID`, `nPlayerID`) VALUES ('1', '1');
INSERT INTO `audit_db`.`t_20211027` (`ID`, `nPlayerID`) VALUES ('2', '1');
INSERT INTO `audit_db`.`t_20211027` (`ID`, `nPlayerID`) VALUES ('3', '1');
INSERT INTO `audit_db`.`t_20211027` (`ID`, `nPlayerID`) VALUES ('4', '2');


错误使用

	SELECT SUM(totals) FROM (
		SELECT COUNT(id) AS totals FROM `t_20211027` WHERE nPlayerId = 1 ORDER BY id DESC LIMIT 2
	) temp13;
	+-------------+
	| SUM(totals) |
	+-------------+
	|           3 |
	+-------------+
	1 row in set (0.00 sec)

 
正确使用
	
	SELECT COUNT(1)  FROM (
		  SELECT 1 FROM `t_20211027` WHERE  `nPlayerID` = 1 ORDER BY ID DESC LIMIT 2
	) temp23;
	+----------+
	| COUNT(1) |
	+----------+
	|        2 |
	+----------+
	1 row in set (0.00 sec)
			 