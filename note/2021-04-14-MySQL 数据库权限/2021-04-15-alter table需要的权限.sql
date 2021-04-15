
1. 当前账号的权限
2. 添加字段
3. 添加索引
4. alter table重命名表
5. rename table需要的权限
6. 小结



1. 当前账号的权限
	create user 'alter_user'@'%' identified by '123456';
	grant select, alter ON test_db.* to 'alter_user'@'%' with grant option;


	alter_user@mysqldb 09:58:  [test_db]> show grants for 'alter_user'@'%';
	+--------------------------------------------------------------------------+
	| Grants for alter_user@%                                                  |
	+--------------------------------------------------------------------------+
	| GRANT USAGE ON *.* TO 'alter_user'@'%'                                   |
	| GRANT SELECT, ALTER ON `test_db`.* TO 'alter_user'@'%' WITH GRANT OPTION |
	+--------------------------------------------------------------------------+
	2 rows in set (0.00 sec)



	root@mysqldb 09:56:  [test_db]> show create table t1\G;
	*************************** 1. row ***************************
		   Table: t1
	Create Table: CREATE TABLE `t1` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
	  `age` int(10) NOT NULL,
	  `tEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  `filed_02` int(10) DEFAULT '3' COMMENT 'filed_02',
	  PRIMARY KEY (`ID`),
	  KEY `idx_age` (`age`)
	) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4
	1 row in set (0.05 sec)


2. 添加字段

	alter table t1 add column `filed_05` int(10) DEFAULT '5' COMMENT 'filed_05';

	alter_user@mysqldb 09:57:  [test_db]> alter table t1 add column `filed_05` int(10) DEFAULT '5' COMMENT 'filed_05';
	Query OK, 0 rows affected (0.61 sec)
	Records: 0  Duplicates: 0  Warnings: 0

	alter_user@mysqldb 09:58:  [test_db]> show create table t1\G;
	*************************** 1. row ***************************
		   Table: t1
	Create Table: CREATE TABLE `t1` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
	  `age` int(10) NOT NULL,
	  `tEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  `filed_02` int(10) DEFAULT '3' COMMENT 'filed_02',
	  `filed_05` int(10) DEFAULT '5' COMMENT 'filed_05',
	  PRIMARY KEY (`ID`),
	  KEY `idx_age` (`age`)
	) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4
	1 row in set (0.00 sec)


3. 添加索引

	alter table t1 add index idx_filed_05(`filed_05`);
	
	alter_user@mysqldb 10:01:  [test_db]> alter table t1 add index idx_filed_05(`filed_05`);
	Query OK, 0 rows affected (0.36 sec)
	Records: 0  Duplicates: 0  Warnings: 0

	alter_user@mysqldb 10:01:  [test_db]> show create table t1\G;
	*************************** 1. row ***************************
		   Table: t1
	Create Table: CREATE TABLE `t1` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
	  `age` int(10) NOT NULL,
	  `tEndTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  `filed_02` int(10) DEFAULT '3' COMMENT 'filed_02',
	  `filed_05` int(10) DEFAULT '5' COMMENT 'filed_05',
	  PRIMARY KEY (`ID`),
	  KEY `idx_age` (`age`),
	  KEY `idx_filed_05` (`filed_05`)
	) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4
	1 row in set (0.00 sec)


------------------------------------------------------------------------------------------------------------------------------------



4. alter table重命名表

	------------------------------------------------------------------------------------------------------------------------------------

		
	create user 'alter_user'@'%' identified by '123456';
	grant select, alter ON test_db.* to 'alter_user'@'%' with grant option;
		
		
	alter_user@mysqldb 10:11:  [(none)]> show grants for 'alter_user'@'%';
	+--------------------------------------------------------------------------+
	| Grants for alter_user@%                                                  |
	+--------------------------------------------------------------------------+
	| GRANT USAGE ON *.* TO 'alter_user'@'%'                                   |
	| GRANT SELECT, ALTER ON `test_db`.* TO 'alter_user'@'%' WITH GRANT OPTION |
	+--------------------------------------------------------------------------+
	2 rows in set (0.00 sec)


	alter_user@mysqldb 10:00:  [test_db]> ALTER TABLE t1 RENAME TO t1111;
	ERROR 1142 (42000): DROP command denied to user 'alter_user'@'192.168.0.242' for table 't1'


	------------------------------------------------------------------------------------------------------------------------------------


	grant select, alter, drop ON test_db.* to 'alter_user'@'%' with grant option;


	alter_user@mysqldb 10:13:  [test_db]> show grants for 'alter_user'@'%';
	+--------------------------------------------------------------------------------+
	| Grants for alter_user@%                                                        |
	+--------------------------------------------------------------------------------+
	| GRANT USAGE ON *.* TO 'alter_user'@'%'                                         |
	| GRANT SELECT, DROP, ALTER ON `test_db`.* TO 'alter_user'@'%' WITH GRANT OPTION |
	+--------------------------------------------------------------------------------+
	2 rows in set (0.00 sec)

	alter_user@mysqldb 10:13:  [test_db]>  ALTER TABLE t1 RENAME TO t1111;
	ERROR 1142 (42000): INSERT, CREATE command denied to user 'alter_user'@'192.168.0.242' for table 't1111'

	------------------------------------------------------------------------------------------------------------------------------------

	grant INSERT, CREATE ON test_db.* to 'alter_user'@'%' with grant option;

	alter_user@mysqldb 10:14:  [(none)]> show grants for 'alter_user'@'%';
	+------------------------------------------------------------------------------------------------+
	| Grants for alter_user@%                                                                        |
	+------------------------------------------------------------------------------------------------+
	| GRANT USAGE ON *.* TO 'alter_user'@'%'                                                         |
	| GRANT SELECT, INSERT, CREATE, DROP, ALTER ON `test_db`.* TO 'alter_user'@'%' WITH GRANT OPTION |
	+------------------------------------------------------------------------------------------------+
	2 rows in set (0.00 sec)


	alter_user@mysqldb 10:15:  [test_Db]> ALTER TABLE t1 RENAME TO t1111;
	Query OK, 0 rows affected (0.13 sec)
	
	
	

5. rename table需要的权限
	
	create user 'rename_user'@'%' identified by '123456';
	grant SELECT, INSERT, CREATE, DROP ON test_db.* to 'rename_user'@'%' with grant option;
	
	rename_user@mysqldb 10:26:  [(none)]> show grants for 'rename_user'@'%';
	+------------------------------------------------------------------------------------------+
	| Grants for rename_user@%                                                                 |
	+------------------------------------------------------------------------------------------+
	| GRANT USAGE ON *.* TO 'rename_user'@'%'                                                  |
	| GRANT SELECT, INSERT, CREATE, DROP ON `test_db`.* TO 'rename_user'@'%' WITH GRANT OPTION |
	+------------------------------------------------------------------------------------------+
	2 rows in set (0.00 sec)


	RENAME TABLE t1 TO t1111;

	rename_user@mysqldb 10:27:  [test_db]> RENAME TABLE t1 TO t1111;
	ERROR 1142 (42000): ALTER command denied to user 'rename_user'@'192.168.0.242' for table 't1'
	
	
	grant ALTER ON test_db.* to 'rename_user'@'%' with grant option;

	rename_user@mysqldb 10:31:  [(none)]> show grants for 'rename_user'@'%';
	+-------------------------------------------------------------------------------------------------+
	| Grants for rename_user@%                                                                        |
	+-------------------------------------------------------------------------------------------------+
	| GRANT USAGE ON *.* TO 'rename_user'@'%'                                                         |
	| GRANT SELECT, INSERT, CREATE, DROP, ALTER ON `test_db`.* TO 'rename_user'@'%' WITH GRANT OPTION |
	+-------------------------------------------------------------------------------------------------+
	2 rows in set (0.00 sec)
		
	rename_user@mysqldb 10:32:  [test_db]> RENAME TABLE t1 TO t1111;
	Query OK, 0 rows affected (0.11 sec)

	
	
	revoke select on test_db.* from 'rename_user'@'%';

	rename_user@mysqldb 10:33:  [test_Db]> show grants for 'rename_user'@'%';
	+-----------------------------------------------------------------------------------------+
	| Grants for rename_user@%                                                                |
	+-----------------------------------------------------------------------------------------+
	| GRANT USAGE ON *.* TO 'rename_user'@'%'                                                 |
	| GRANT INSERT, CREATE, DROP, ALTER ON `test_db`.* TO 'rename_user'@'%' WITH GRANT OPTION |
	+-----------------------------------------------------------------------------------------+
	2 rows in set (0.00 sec)
	
	
	rename_user@mysqldb 10:33:  [test_Db]> RENAME TABLE t1111 TO t1;
	Query OK, 0 rows affected (0.18 sec)



6. 小结

	允许使用ALTER TABLE来改变表的结构，ALTER TABLE同时也需要CREATE和INSERT权限。重命名一个表需要对旧表具有ALTER和DROP权限，对新表具有CREATE和INSERT权限。
	
	alter table需要的权限：INSERT, CREATE, DROP, ALTER
	


	
