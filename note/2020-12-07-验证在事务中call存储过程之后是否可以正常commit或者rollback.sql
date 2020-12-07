
初始化表结构和数据
	drop table  if exists `t_20201207`;
	CREATE TABLE `t_20201207` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
	  `nPlayerID` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
	  `ExtendCode` varchar(36) DEFAULT NULL COMMENT '推广码',
	  `socre` int(11) DEFAULT 0 COMMENT '积分',
	  PRIMARY KEY (`ID`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;


	INSERT INTO `test_db`.`t_20201207` (`ID`, `nPlayerID`, `ExtendCode`, `socre`) VALUES ('1', '1', '0', 0);
	INSERT INTO `test_db`.`t_20201207` (`ID`, `nPlayerID`, `ExtendCode`, `socre`) VALUES ('2', '2', '0', 0);
	INSERT INTO `test_db`.`t_20201207` (`ID`, `nPlayerID`, `ExtendCode`, `socre`) VALUES ('3', '3', '3', 0);
	INSERT INTO `test_db`.`t_20201207` (`ID`, `nPlayerID`, `ExtendCode`, `socre`) VALUES ('4', '4', '4', 0);
	INSERT INTO `test_db`.`t_20201207` (`ID`, `nPlayerID`, `ExtendCode`, `socre`) VALUES ('5', '5', '5', 0);


	DROP PROCEDURE IF EXISTS `pr_20201207`;
	DELIMITER ;;
	CREATE DEFINER=`root`@`%` PROCEDURE `pr_20201207`()
	RT:BEGIN

		delete from t_20201207 where id=2;
	 
	END;;
	DELIMITER ;


rollback
	session A 
	begin;

	delete from t_20201207 where id=1;
	call pr_20201207();

	rollback;


	mysql> select * from t_20201207;
	+----+-----------+------------+-------+
	| ID | nPlayerID | ExtendCode | socre |
	+----+-----------+------------+-------+
	|  1 |         1 | 0          |     0 |
	|  2 |         2 | 0          |     0 |
	|  3 |         3 | 3          |     0 |
	|  4 |         4 | 4          |     0 |
	|  5 |         5 | 5          |     0 |
	+----+-----------+------------+-------+
	5 rows in set (0.00 sec)


commit
	session B
	begin;
	delete from t_20201207 where id=1;
	call pr_20201207();
	commit;
	mysql> select * from t_20201207;
	+----+-----------+------------+-------+
	| ID | nPlayerID | ExtendCode | socre |
	+----+-----------+------------+-------+
	|  3 |         3 | 3          |     0 |
	|  4 |         4 | 4          |     0 |
	|  5 |         5 | 5          |     0 |
	+----+-----------+------------+-------+
	3 rows in set (0.00 sec)




