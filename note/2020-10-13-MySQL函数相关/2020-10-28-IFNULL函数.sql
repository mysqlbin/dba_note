
DROP PROCEDURE IF EXISTS `Pr_WriteTaxRecord2_shard`;

受影响的行: 0
时间: 0.270s


CREATE DEFINER=`root`@`%` PROCEDURE `Pr_WriteTaxRecord2_shard`(

受影响的行: 0
时间: 0.164s


1. 本次实验的目的
	验证什么情况下可以使用IFNULL()

CREATE TABLE `t_20201028` (
`id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',  
`age` INT(10) not NULL default 0,
`idCard`INT(10)  NULL,
PRIMARY KEY (`id`)
) ENGINE=InnoDB;

INSERT INTO `test_db`.`t_20201028` (`id`, `age`, `idCard`) VALUES ('1', '0', NULL);

mysql> select * from t_20201028;
+----+-----+--------+
| id | age | idCard |
+----+-----+--------+
|  1 |   0 |   NULL |
+----+-----+--------+
1 row in set (0.00 sec)


记录存在 
	select `age` from t_20201028 where id=1;
	select `idCard` from t_20201028 where id=1;

		mysql> select `age` from t_20201028 where id=1;
		+-----+
		| age |
		+-----+
		|   0 |
		+-----+
		1 row in set (0.00 sec)

		mysql> select `idCard` from t_20201028 where id=1;
		+--------+
		| idCard |
		+--------+
		|   NULL |
		+--------+
		1 row in set (0.00 sec)




	select IFNULL(`age`, 0) from t_20201028 where id=1;
	select IFNULL(`idCard`, 0) from t_20201028 where id=1;

		mysql> select IFNULL(`age`, 0) from t_20201028 where id=1;
		+------------------+
		| IFNULL(`age`, 0) |
		+------------------+
		|                0 |
		+------------------+
		1 row in set (0.00 sec)

		mysql> select IFNULL(`idCard`, 0) from t_20201028 where id=1;
		+---------------------+
		| IFNULL(`idCard`, 0) |
		+---------------------+
		|                   0 |
		+---------------------+
		1 row in set (0.00 sec)



记录不存在
	
	
	set @age=0;
	select age into @age from t_20201028 where id = 0;
	select @age;


		root@mysqldb 14:39:  [test_Db]> set @age=0;
		Query OK, 0 rows affected (0.00 sec)

		root@mysqldb 14:39:  [test_Db]> select age into @age from t_20201028 where id = 0;
		Query OK, 0 rows affected, 1 warning (0.00 sec)

		root@mysqldb 14:39:  [test_Db]> select @age;
		+------+
		| @age |
		+------+
		|    0 |
		+------+
		1 row in set (0.00 sec)


	
	select age into @age from t_20201028 where id = 0;
	select IFNULL(@age, 0);
	
		mysql> select age into @age from t_20201028 where id = 0;
		Query OK, 0 rows affected, 1 warning (0.00 sec)

		mysql> select IFNULL(@age, 0);
		+-----------------+
		| IFNULL(@age, 0) |
		+-----------------+
		| 0               |
		+-----------------+
		1 row in set (0.00 sec)

	

	set @idCard=0;
	select idCard into @idCard from t_20201028 where id = 0;
	select @idCard;


		mysql> set @idCard=0;
		Query OK, 0 rows affected (0.00 sec)

		mysql> select idCard into @idCard from t_20201028 where id = 0;
		Query OK, 0 rows affected, 1 warning (0.00 sec)

		mysql> select @idCard;
		+---------+
		| @idCard |
		+---------+
		|       0 |
		+---------+
		1 row in set (0.00 sec)


	select idCard into @idCard from t_20201028 where id = 0;
	select @idCard;

		mysql> select idCard into @idCard from t_20201028 where id = 0;
		Query OK, 0 rows affected, 1 warning (0.00 sec)

		mysql> select @idCard;
		+---------+
		| @idCard |
		+---------+
		| NULL    |
		+---------+
		1 row in set (0.00 sec)

	
	select idCard into @idCard from t_20201028 where id = 0;
	select IFNULL(@idCard, 0);

		mysql> select idCard into @idCard from t_20201028 where id = 0;
		Query OK, 0 rows affected, 1 warning (0.00 sec)

		mysql> select IFNULL(@idCard, 0);
		+--------------------+
		| IFNULL(@idCard, 0) |
		+--------------------+
		| 0                  |
		+--------------------+
		1 row in set (0.00 sec)




----------------------------------------------------------------------------


CREATE TABLE `table_clubmember` (
  ............................................................
  `nScore` bigint(20) NOT NULL DEFAULT '0' COMMENT '积分',
  ............................................................
) ENGINE=InnoDB AUTO_INCREMENT=66924 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部成员表';




CREATE TABLE `table_clubinfo` (
  ............................................................
  `nScore` bigint(20) DEFAULT '0' COMMENT '积分总账户',
  ............................................................
) ENGINE=InnoDB AUTO_INCREMENT=12155 DEFAULT CHARSET=utf8mb4 COMMENT='俱乐部表';


CREATE TABLE `table_user` (
  ............................................................
  `bRobot` tinyint(4) NOT NULL DEFAULT '0' COMMENT '机器人标志 0-不是 1-是 (默认0)',
  ............................................................
) ENGINE=InnoDB AUTO_INCREMENT=130915 DEFAULT CHARSET=utf8mb4;



记录不存在
	
	
	
	mysql> select * from table_clubinfo where nClubID = 0;
	Empty set (0.00 sec)

	mysql> select IFNULL(nScore, 0) into @clubscore from table_clubinfo where nClubID = 0;
	Query OK, 0 rows affected, 1 warning (0.00 sec)

	mysql> select @clubscore;
	+------------+
	| @clubscore |
	+------------+
	| NULL       |
	+------------+
	1 row in set (0.00 sec)

	-----------------------------------------------------------------------------------
	

	mysql> select * from table_user where nPlayerId = 0;
	Empty set (0.00 sec)

	
	mysql> select bRobot into @bRobot from table_user where nPlayerId = 0;
	Query OK, 0 rows affected, 1 warning (0.00 sec)

	mysql> select @bRobot;
	+---------+
	| @bRobot |
	+---------+
	| NULL    |
	+---------+
	1 row in set (0.00 sec)


	-----------------------------------------------------------------------------------
	
	
	-- 没有初始化变量
	
	CREATE DEFINER=`root`@`%` PROCEDURE `test_20201028`()
	RT:begin


		select IFNULL(nScore,0) into @myscore from table_clubmember where nPlayerID = 0 and nClubID=0 LIMIT 1;
		
		select IFNULL(nScore,0) into @clubscore from table_clubinfo where nClubID = 0;
				
		select IFNULL(bRobot,0) into @bRobot from table_user where nPlayerId = 0;
		
		select @myscore;
		select @clubscore;
		select @bRobot;

	end
	
		
		mysql> CALL test_20201028();
		+----------+
		| @myscore |
		+----------+
		|     1000 |
		+----------+
		1 row in set (0.01 sec)

		+------------+
		| @clubscore |
		+------------+
		| NULL       |
		+------------+
		1 row in set (0.01 sec)

		+---------+
		| @bRobot |
		+---------+
		| NULL    |
		+---------+
		1 row in set (0.01 sec)

		Query OK, 0 rows affected (0.01 sec)
	
	-- 没有初始化变量
	
	CREATE DEFINER=`root`@`%` PROCEDURE `test_20201028`()
	RT:begin


		select nScore into @myscore from table_clubmember where nPlayerID = 0 and nClubID=0 LIMIT 1;
		
		select nScore into @clubscore from table_clubinfo where nClubID = 0;
				
		select bRobot into @bRobot from table_user where nPlayerId = 0;
		
		select @myscore;
		select @clubscore;
		select @bRobot;

	end
	
		mysql> CALL test_20201028();
		+----------+
		| @myscore |
		+----------+
		|     1000 |
		+----------+
		1 row in set (0.00 sec)

		+------------+
		| @clubscore |
		+------------+
		| NULL       |
		+------------+
		1 row in set (0.00 sec)

		+---------+
		| @bRobot |
		+---------+
		| NULL    |
		+---------+
		1 row in set (0.00 sec)

		Query OK, 0 rows affected (0.00 sec)

	
	
	-- 有初始化变量
	CREATE DEFINER=`root`@`%` PROCEDURE `test_20201028`()
	RT:begin

		set @myscore=0;
		set @clubscore=0;
		set @bRobot=0;

		select nScore into @myscore from table_clubmember where nPlayerID = 0 and nClubID=0 LIMIT 1;
		
		select nScore into @clubscore from table_clubinfo where nClubID = 0;
				
		select bRobot into @bRobot from table_user where nPlayerId = 0;
		
		select @myscore;
		select @clubscore;
		select @bRobot;

	end

	
		mysql> call test_20201028();
		+----------+
		| @myscore |
		+----------+
		|     1000 |
		+----------+
		1 row in set (0.01 sec)

		+------------+
		| @clubscore |
		+------------+
		|          0 |
		+------------+
		1 row in set (0.01 sec)

		+---------+
		| @bRobot |
		+---------+
		|       0 |
		+---------+
		1 row in set (0.01 sec)

		Query OK, 0 rows affected (0.01 sec)





