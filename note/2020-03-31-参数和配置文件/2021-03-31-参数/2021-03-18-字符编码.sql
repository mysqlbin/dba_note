
create user 'test_user'@'%' identified by '123456abc';
grant SELECT, INSERT, UPDATE, DELETE, CREATE, REFERENCES, INDEX, ALTER, SHOW DATABASES, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE on *.* to 'test_user'@'%' with grant option;


https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_init_connect

https://mp.weixin.qq.com/s/0XSDpDns4YE9xGONGsvm2g   图解MySQL | [原理解析] 设置字符集的参数控制了哪些行为



root@mysqldb 15:05:  [(none)]> select version();
+------------+
| version()  |
+------------+
| 5.7.22-log |
+------------+
1 row in set (0.00 sec)

1. 配置1

	[client]
	port	= 3306
	socket	= /home/mysql/mysql3306/data/mysql3306.sock
	default-character-set = utf8mb4

	[mysql]
	prompt="\u@mysqldb \R:\m:\s [\d]> "
	no-auto-rehash
	default-character-set = utf8mb4

	[mysqld]
	#字符集设置
	character-set-server = utf8mb4
	collation-server=utf8mb4_general_ci
	init-connect='SET NAMES utf8'


	mysql> show variables like '%char%';
	+--------------------------+----------------------------------+
	| Variable_name            | Value                            |
	+--------------------------+----------------------------------+
	| character_set_client     | utf8                             |
	| character_set_connection | utf8                             |
	| character_set_database   | utf8mb4                          |
	| character_set_filesystem | binary                           |
	| character_set_results    | utf8                             |
	| character_set_server     | utf8mb4                          |
	| character_set_system     | utf8                             |
	| character_sets_dir       | /usr/local/mysql/share/charsets/ |
	+--------------------------+----------------------------------+
	8 rows in set (0.01 sec)
	
	
	mysql> show create table table_user\G;
	*************************** 1. row ***************************
		   Table: table_user
	Create Table: CREATE TABLE `table_user` (
	  `nPlayerId` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '玩家用户Id',
	  `szNickName` varchar(64) DEFAULT NULL,
	  PRIMARY KEY (`nPlayerId`)
	) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4
	1 row in set (0.00 sec)

	
	select szNickName from table_user where nPlayerId=1000;

	mysql> update table_user set szNickName='ad' where nPlayerId=1000;
	Query OK, 0 rows affected (0.00 sec)
	Rows matched: 1  Changed: 0  Warnings: 0



2. 配置2

	[client]
	port	= 3306
	socket	= /home/mysql/mysql3306/data/mysql3306.sock
	#default-character-set = utf8mb4

	[mysql]
	prompt="\u@mysqldb \R:\m:\s [\d]> "
	no-auto-rehash
	default-character-set = utf8mb4


	[mysqld]
	#字符集设置
	character-set-server = utf8mb4
	collation-server=utf8mb4_general_ci
	init-connect='SET NAMES utf8'

	test_user@mysqldb 15:38:  [(none)]> show variables like '%char%';
	+--------------------------+----------------------------------+
	| Variable_name            | Value                            |
	+--------------------------+----------------------------------+
	| character_set_client     | utf8                             |
	| character_set_connection | utf8                             |
	| character_set_database   | utf8mb4                          |
	| character_set_filesystem | binary                           |
	| character_set_results    | utf8                             |
	| character_set_server     | utf8mb4                          |
	| character_set_system     | utf8                             |
	| character_sets_dir       | /usr/local/mysql/share/charsets/ |
	+--------------------------+----------------------------------+
	8 rows in set (0.01 sec)


2. 配置3

	[client]
	port	= 3306
	socket	= /home/mysql/mysql3306/data/mysql3306.sock
	default-character-set = utf8mb4

	[mysql]
	prompt="\u@mysqldb \R:\m:\s [\d]> "
	no-auto-rehash
	default-character-set = utf8mb4


	[mysqld]
	#字符集设置
	character-set-server = utf8mb4
	collation-server=utf8mb4_general_ci
	
	mysql> show variables like '%char%';
	+--------------------------+----------------------------------+
	| Variable_name            | Value                            |
	+--------------------------+----------------------------------+
	| character_set_client     | utf8mb4                          |
	| character_set_connection | utf8mb4                          |
	| character_set_database   | utf8mb4                          |
	| character_set_filesystem | binary                           |
	| character_set_results    | utf8mb4                          |
	| character_set_server     | utf8mb4                          |
	| character_set_system     | utf8                             |
	| character_sets_dir       | /usr/local/mysql/share/charsets/ |
	+--------------------------+----------------------------------+
	8 rows in set (0.01 sec)

	
配置4

	[client]
	port	= 3306
	socket	= /home/mysql/mysql3306/data/mysql3306.sock
	#default-character-set = utf8mb4

	[mysql]
	prompt="\u@mysqldb \R:\m:\s [\d]> "
	no-auto-rehash
	#default-character-set = utf8mb4_general_ci

	
	[mysqld]

	#字符集设置
	character-set-server = utf8mb4
	collation-server=utf8mb4_general_ci
	#init-connect='SET NAMES utf8'


	test_user@mysqldb 15:45:  [(none)]> show variables like '%char%';
	+--------------------------+----------------------------------+
	| Variable_name            | Value                            |
	+--------------------------+----------------------------------+
	| character_set_client     | utf8mb4                          |
	| character_set_connection | utf8mb4                          |
	| character_set_database   | utf8mb4                          |
	| character_set_filesystem | binary                           |
	| character_set_results    | utf8mb4                          |
	| character_set_server     | utf8mb4                          |
	| character_set_system     | utf8                             |
	| character_sets_dir       | /usr/local/mysql/share/charsets/ |
	+--------------------------+----------------------------------+
	8 rows in set (0.00 sec)
	
	test_user@mysqldb 16:05:  [yldbs]> show global variables like '%init%';
	+------------------------+-------+
	| Variable_name          | Value |
	+------------------------+-------+
	| init_connect           |       |
	| init_file              |       |
	| init_slave             |       |
	| table_definition_cache | 1024  |
	+------------------------+-------+
	4 rows in set (0.00 sec)
	
	
	mysql> show create table table_user\G;
	*************************** 1. row ***************************
		   Table: table_user
	Create Table: CREATE TABLE `table_user` (
	  `nPlayerId` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '玩家用户Id',
	  `szNickName` varchar(64) DEFAULT NULL,
	  PRIMARY KEY (`nPlayerId`)
	) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4
	1 row in set (0.00 sec)

	
	select szNickName from table_user where nPlayerId=1000;
	
	update table_user set szNickName='a👿d' where nPlayerId=1000;
	
	mysql> update table_user set szNickName='ad' where nPlayerId=1000;

	Query OK, 0 rows affected (0.00 sec)
	Rows matched: 1  Changed: 0  Warnings: 0

	test_user@mysqldb 16:04:  [yldbs]> select szNickName from table_user where nPlayerId=1000;
	+------------+
	| szNickName |
	+------------+
	| ad         |
	+------------+
	1 row in set (0.00 sec)
			
			
			

	
配置5

	[client]
	port	= 3306
	socket	= /home/mysql/mysql3306/data/mysql3306.sock
	#default-character-set = utf8mb4

	[mysql]
	prompt="\u@mysqldb \R:\m:\s [\d]> "
	no-auto-rehash
	#default-character-set = utf8mb4_general_ci

	
	[mysqld]

	#字符集设置
	character-set-server = utf8mb4
	collation-server=utf8mb4_general_ci
	init-connect='SET NAMES utf8mb4'


	test_user@mysqldb 16:12:  [yldbs]> show variables like '%char%';
	+--------------------------+----------------------------------+
	| Variable_name            | Value                            |
	+--------------------------+----------------------------------+
	| character_set_client     | utf8mb4                          |
	| character_set_connection | utf8mb4                          |
	| character_set_database   | utf8mb4                          |
	| character_set_filesystem | binary                           |
	| character_set_results    | utf8mb4                          |
	| character_set_server     | utf8mb4                          |
	| character_set_system     | utf8                             |
	| character_sets_dir       | /usr/local/mysql/share/charsets/ |
	+--------------------------+----------------------------------+
	8 rows in set (0.00 sec)

	
	test_user@mysqldb 16:12:  [yldbs]> show global variables like '%init%';
	+------------------------+-------------------+
	| Variable_name          | Value             |
	+------------------------+-------------------+
	| init_connect           | SET NAMES utf8mb4 |
	| init_file              |                   |
	| init_slave             |                   |
	| table_definition_cache | 1024              |
	+------------------------+-------------------+
	4 rows in set (0.01 sec)

	
	
	mysql> show create table table_user\G;
	*************************** 1. row ***************************
		   Table: table_user
	Create Table: CREATE TABLE `table_user` (
	  `nPlayerId` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '玩家用户Id',
	  `szNickName` varchar(64) DEFAULT NULL,
	  PRIMARY KEY (`nPlayerId`)
	) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4
	1 row in set (0.00 sec)

	
	select szNickName from table_user where nPlayerId=1000;
	
	update table_user set szNickName='a👿d' where nPlayerId=1000;
	select szNickName from table_user where nPlayerId=1000;
	mysql> update table_user set szNickName='ad' where nPlayerId=1000;

	Query OK, 0 rows affected (0.00 sec)
	Rows matched: 1  Changed: 0  Warnings: 0

	test_user@mysqldb 16:04:  [yldbs]> select szNickName from table_user where nPlayerId=1000;
	+------------+
	| szNickName |
	+------------+
	| ad         |
	+------------+
	1 row in set (0.00 sec)
						




SET NAMES utf8mb4;
update table_user set szNickName='a👿d' where nPlayerId=1000;


test_user@mysqldb 16:36:  [yldbs]> select szNickName from table_user where nPlayerId=1000;
+------------+
| szNickName |
+------------+
| a👿d         |
+------------+
1 row in set (0.01 sec)


[client]
port	= 3306
socket	= /home/mysql/mysql3306/data/mysql3306.sock
default-character-set = utf8mb4

[mysql]
prompt="\u@mysqldb \R:\m:\s [\d]> "
no-auto-rehash
default-character-set = utf8mb4


	
具有super权限的数据库账号，对数据库的所有操作，都不会走 init-connect 参数值的逻辑。


