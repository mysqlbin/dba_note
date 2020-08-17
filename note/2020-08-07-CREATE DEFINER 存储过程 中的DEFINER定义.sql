

1. CREATE DEFINER=`root`@`localhost` PROCEDURE `check_data`() 中的DEFINER定义
	create user 'select_user'@'%' identified by '123456abc';
	grant select on *.* to 'select_user'@'%' with grant option;



	root@mysqldb 16:18:  [test_db]>  show grants for 'root'@'localhost';
	+---------------------------------------------------------------------+
	| Grants for root@localhost                                           |
	+---------------------------------------------------------------------+
	| GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION |
	| GRANT PROXY ON ''@'' TO 'root'@'localhost' WITH GRANT OPTION        |
	+---------------------------------------------------------------------+
	2 rows in set (0.00 sec)
	 
	root@mysqldb 16:17:  [test_db]> show grants for 'select_user'@'%';
	+---------------------------------------------------------------------+
	| Grants for select_user@%                                            |
	+---------------------------------------------------------------------+
	| GRANT SELECT, EXECUTE ON *.* TO 'select_user'@'%' WITH GRANT OPTION |
	+---------------------------------------------------------------------+
	1 row in set (0.00 sec)


	root@mysqldb 16:07:  [test_db]> select * from t1;
	+----+-----+---------------------+
	| ID | age | tEndTime            |
	+----+-----+---------------------+
	|  1 |   1 | 2020-07-13 14:23:49 |
	|  2 |   2 | 2020-07-13 14:23:57 |
	|  3 |   3 | 2020-07-13 14:24:00 |
	|  4 |   4 | 2020-07-13 14:24:03 |
	|  5 |   5 | 2020-07-13 14:24:05 |
	|  6 |   6 | 2020-07-13 14:24:08 |
	|  7 |   7 | 2020-07-13 14:24:11 |
	|  8 |   1 | 2020-07-13 14:41:43 |
	+----+-----+---------------------+
	8 rows in set (0.00 sec)

	DROP PROCEDURE IF EXISTS `check_data`;
	DELIMITER ;;
	CREATE DEFINER=`root`@`localhost` PROCEDURE `check_data`()
	begin
		delete from t1 where id=1;
	END
	;;
	DELIMITER ;


	select_user@mysqldb 16:20:  [test_db]> call check_data();
	Query OK, 1 row affected (0.03 sec)

	root@mysqldb 16:21:  [test_db]> select * from t1;
	+----+-----+---------------------+
	| ID | age | tEndTime            |
	+----+-----+---------------------+
	|  2 |   2 | 2020-07-13 14:23:57 |
	|  3 |   3 | 2020-07-13 14:24:00 |
	|  4 |   4 | 2020-07-13 14:24:03 |
	|  5 |   5 | 2020-07-13 14:24:05 |
	|  6 |   6 | 2020-07-13 14:24:08 |
	|  7 |   7 | 2020-07-13 14:24:11 |
	|  8 |   1 | 2020-07-13 14:41:43 |
	+----+-----+---------------------+
	7 rows in set (0.00 sec)



2. 小结

	CREATE DEFINER=`root`@`localhost` PROCEDURE `check_data`() ;    -- 通过 `root`@`localhost` 账号的权限来操作 check_data存储过程中的SQL语句。
	
	

