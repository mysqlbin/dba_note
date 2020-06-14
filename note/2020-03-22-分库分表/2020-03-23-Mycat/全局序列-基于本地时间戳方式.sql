		
全局序列
	基于本地时间戳方式
		ID= 64 位二进制 (42(毫秒)+5(机器 ID)+5(业务编码)+12(重复累加)
		
		truncate table test1;
		
		mycat_user@mysqldb 22:45:  [mycat_db]> INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-05-21');
		ERROR 1264 (HY000): Out of range value for column 'id' at row 1
		
		alter table `test1` modify column id bigint(20) NOT NULL AUTO_INCREMENT;
		
		mycat_user@mysqldb 22:57:  [mycat_db]> show create table test1;
		+-------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| Table | Create Table                                                                                                                                                                                                                                                 |
		+-------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		| test1 | CREATE TABLE `test1` (
		  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
		  `name` varchar(50) NOT NULL DEFAULT '',
		  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  PRIMARY KEY (`ID`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4     |
		+-------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
		1 row in set (0.00 sec)


		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-03-24');
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-04-10');
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-04-22');
		
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-03-25');
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-04-08');
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-04-21');
		
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-04-21');
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-04-21');
		
		
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-04-23');
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-04-24');
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-05-01');
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-05-10');
		INSERT INTO `test1` (`name`, `CreateTime`) VALUES ('lujb', '2020-05-21');
		
		查看表test1 的数据
			select * from db1.test1;
			select * from db2.test1;
			select * from db3.test1;
			
			root@mysqldb 06:58:  [(none)]> select * from db1.test1;
			+---------------------+------+---------------------+
			| ID                  | name | CreateTime          |
			+---------------------+------+---------------------+
			| 1242828055358083073 | lujb | 2020-03-24 00:00:00 |
			| 1242828055647490048 | lujb | 2020-03-25 00:00:00 |
			| 1242828056205332481 | lujb | 2020-04-23 00:00:00 |
			| 1242828056259858432 | lujb | 2020-04-24 00:00:00 |
			| 1242828056305995777 | lujb | 2020-05-01 00:00:00 |
			+---------------------+------+---------------------+
			5 rows in set (0.00 sec)

			root@mysqldb 06:59:  [(none)]> select * from db2.test1;
			+---------------------+------+---------------------+
			| ID                  | name | CreateTime          |
			+---------------------+------+---------------------+
			| 1242828055416803329 | lujb | 2020-04-10 00:00:00 |
			| 1242828055731376128 | lujb | 2020-04-08 00:00:00 |
			| 1242828056356327425 | lujb | 2020-05-10 00:00:00 |
			+---------------------+------+---------------------+
			3 rows in set (0.00 sec)
			
			
			root@mysqldb 07:02:  [(none)]> select * from db3.test1;
			+---------------------+------+---------------------+
			| ID                  | name | CreateTime          |
			+---------------------+------+---------------------+
			| 1242828055471329280 | lujb | 2020-04-22 00:00:00 |
			| 1242828055844622337 | lujb | 2020-04-21 00:00:00 |
			| 1242828056045948929 | lujb | 2020-04-21 00:00:00 |
			| 1242828056138223617 | lujb | 2020-04-21 00:00:00 |
			| 1242828059871154177 | lujb | 2020-05-21 00:00:00 |
			+---------------------+------+---------------------+
			5 rows in set (0.00 sec)
			