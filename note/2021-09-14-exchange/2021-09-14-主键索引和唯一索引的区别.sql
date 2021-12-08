

主键索引和唯一索引的区别
	1. 在InnoDB存储引擎里，两者都是一颗B+树
	2. 主键索引一定是聚集索引，唯一索引不一定是聚集索引
	3. 加锁：对唯一索引的记录加写锁，也会回到对应的主键索引加写锁
	
	4. 从存储的角度：
		主键索引的叶子节点存储的是整行记录
		普通索引叶子节点的内容是主键索引键的值
		
	5. 从索引个数的角度：
		一个表只能有一个主键索引,但是可以有多个唯一索引
		
	6. 从是否允许为NULL的角度：
		唯一性索引列允许为NULL，而主键列不允许为NULL。
		
	-- 主要从存储、索引个数、是否允许为NULL进行比较。


通过实践验证

	1. 主键索引不可以为NULL
	2. 唯一索引允许为NULL	
	3. 1个表可以有多个唯一索引


1. 主键索引不可以为NULL

	DROP TABLE IF EXISTS `t`;
	CREATE TABLE `t` (
	  `ID` int(10) DEFAULT NULL  COMMENT '',
	  `ntableId` int(11) DEFAULT NULL COMMENT '',
	  PRIMARY KEY (`ID`),
	  UNIQUE KEY `idx_ntableId` (`ntableId`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;


	DROP TABLE IF EXISTS `t`;
	CREATE TABLE `t` (
	  `ID` varchar(10) DEFAULT NULL  COMMENT '',
	  `ntableId` int(11) DEFAULT NULL COMMENT '',
	  PRIMARY KEY (`ID`),
	  UNIQUE KEY `idx_ntableId` (`ntableId`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;



	mysql> CREATE TABLE `t` (
		->   `ID` int(10) DEFAULT NULL  COMMENT '',
		->   `ntableId` int(11) DEFAULT NULL COMMENT '',
		->   PRIMARY KEY (`ID`),
		->   UNIQUE KEY `idx_ntableId` (`ntableId`)
		-> ) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;
	ERROR 1171 (42000): All parts of a PRIMARY KEY must be NOT NULL; if you need NULL in a key, use UNIQUE instead
	主键索引列必须定义为 NOT NULL, 如果需要设置键为 NULL, 可以使用唯一索引代替.

	new_app_user@mysqldb 15:32:  [sbtest1104]> DROP TABLE IF EXISTS `t`;
	Query OK, 0 rows affected, 1 warning (0.11 sec)

	mysql> CREATE TABLE `t` (
		->   `ID` varchar(10) DEFAULT NULL  COMMENT '',
		->   `ntableId` int(11) DEFAULT NULL COMMENT '',
		->   PRIMARY KEY (`ID`),
		->   UNIQUE KEY `idx_ntableId` (`ntableId`)
		-> ) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;
	ERROR 1171 (42000): All parts of a PRIMARY KEY must be NOT NULL; if you need NULL in a key, use UNIQUE instead


2. 唯一索引允许为NULL	
	
	DROP TABLE IF EXISTS `t`;
	CREATE TABLE `t` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '',
	  `ntableId` int(11) DEFAULT NULL COMMENT '',
	  PRIMARY KEY (`ID`),
	  UNIQUE KEY `idx_ntableId` (`ntableId`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

	mysql> show create table t;
	+-------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| Table | Create Table                                                                                                                                                                                                  |
	+-------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	| t     | CREATE TABLE `t` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
	  `ntableId` int(11) DEFAULT NULL,
	  PRIMARY KEY (`ID`),
	  UNIQUE KEY `idx_ntableId` (`ntableId`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 |
	+-------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
	1 row in set (0.00 sec)


	insert into t(ntableId) value(null);
	insert into t(ntableId) value(null);

	mysql> select * from t;
	+----+----------+
	| ID | ntableId |
	+----+----------+
	|  1 |     NULL |
	|  2 |     NULL |
	+----+----------+
	2 rows in set (0.00 sec)

	insert into t(ntableId) value(5);
	insert into t(ntableId) value(5);
	ERROR 1062 (23000): Duplicate entry '5' for key 'idx_ntableId'



3. 1个表可以有多个唯一索引

	DROP TABLE IF EXISTS `t`;
	CREATE TABLE `t` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '',
	  `ntableId` int(11) DEFAULT NULL COMMENT '',
	  `nplayerId` int(11) DEFAULT NULL COMMENT '',
	  PRIMARY KEY (`ID`),
	  UNIQUE KEY `idx_ntableId` (`ntableId`),
	  UNIQUE KEY `nplayerId` (`nplayerId`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;




