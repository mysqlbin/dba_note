
1. 环境介绍
2. 测试按天分片和求模法


2. 环境介绍
  
	3台物理机linux操作系统
	其中两台安装Mysql 5.7
	另一台安装Mycat

	主机        IP 地址           用途                分库分表模式          分库分表规则
	mgr9        192.168.0.55      部署 Mycat           mycat: test2          test2: 按 求模法
 
	mycat01     192.168.0.201     分库分表             db2: test2		

	mycat02     192.168.0.202	  分库分表	           db4: test2


2. 测试按天分片和求模法
	192.168.0.201	

		create  database db2 DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;
		use db2;
		CREATE TABLE test2 (  
			id INT NOT NULL AUTO_INCREMENT,  
			`nPlayerID` int(11) DEFAULT '0' COMMENT '',
			`szToken` varchar(64) DEFAULT NULL COMMENT '',
			PRIMARY KEY (id)  
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;  

	192.168.0.202

		create  database db4 DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;
		use db2;
		CREATE TABLE test2 (  
			id INT NOT NULL AUTO_INCREMENT,  
			name varchar(50) NOT NULL default '',  
			PRIMARY KEY (id)  
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;  
		

	
	登录Mycat
	
		INSERT INTO `test2` (`id`, `nPlayerID`, `szToken`) VALUES ('next value for MYCATSEQ_GLOBALS', '1', '123');
		INSERT INTO `test2` (`id`, `nPlayerID`, `szToken`) VALUES ('next value for MYCATSEQ_GLOBALS', '2', '123');
		INSERT INTO `test2` (`id`, `nPlayerID`, `szToken`) VALUES ('next value for MYCATSEQ_GLOBALS', '3', '123');
		INSERT INTO `test2` (`id`, `nPlayerID`, `szToken`) VALUES ('next value for MYCATSEQ_GLOBALS', '4', '123');
		INSERT INTO `test2` (`id`, `nPlayerID`, `szToken`) VALUES ('next value for MYCATSEQ_GLOBALS', '5', '123');
		INSERT INTO `test2` (`id`, `nPlayerID`, `szToken`) VALUES ('next value for MYCATSEQ_GLOBALS', '6', '123');
		INSERT INTO `test2` (`id`, `nPlayerID`, `szToken`) VALUES ('next value for MYCATSEQ_GLOBALS', '7', '123');
		INSERT INTO `test2` (`id`, `nPlayerID`, `szToken`) VALUES ('next value for MYCATSEQ_GLOBALS', '8', '123');
		INSERT INTO `test2` (`id`, `nPlayerID`, `szToken`) VALUES ('next value for MYCATSEQ_GLOBALS', '9', '123');
		INSERT INTO `test2` (`id`, `nPlayerID`, `szToken`) VALUES ('next value for MYCATSEQ_GLOBALS', '10', '123');
		INSERT INTO `test2` (`id`, `nPlayerID`, `szToken`) VALUES ('next value for MYCATSEQ_GLOBALS', '11', '123');
		INSERT INTO `test2` (`id`, `nPlayerID`, `szToken`) VALUES ('next value for MYCATSEQ_GLOBALS', '12', '123');
	
	登录分片节点查看数据

		mycat_user@mysqldb 19:20:  [mycat_db]> select * from test2;
		+-----+-----------+---------+
		| id  | nPlayerID | szToken |
		+-----+-----------+---------+
		| 814 |         2 | 123     |
		| 816 |         4 | 123     |
		| 818 |         6 | 123     |
		| 820 |         8 | 123     |
		| 822 |        10 | 123     |
		| 824 |        12 | 123     |
		| 813 |         1 | 123     |
		| 815 |         3 | 123     |
		| 817 |         5 | 123     |
		| 819 |         7 | 123     |
		| 821 |         9 | 123     |
		| 823 |        11 | 123     |
		+-----+-----------+---------+
		12 rows in set (0.04 sec)	
		
		root@mysqldb 18:51:  [db2]> select * from db2.test2;
		+-----+-----------+---------+
		| id  | nPlayerID | szToken |
		+-----+-----------+---------+
		| 814 |         2 | 123     |
		| 816 |         4 | 123     |
		| 818 |         6 | 123     |
		| 820 |         8 | 123     |
		| 822 |        10 | 123     |
		| 824 |        12 | 123     |
		+-----+-----------+---------+
		6 rows in set (0.00 sec)


			
		root@mysqldb 08:59:  [db2]> select * from db2.test2;
		+-----+-----------+---------+
		| id  | nPlayerID | szToken |
		+-----+-----------+---------+
		| 813 |         1 | 123     |
		| 815 |         3 | 123     |
		| 817 |         5 | 123     |
		| 819 |         7 | 123     |
		| 821 |         9 | 123     |
		| 823 |        11 | 123     |
		+-----+-----------+---------+
		6 rows in set (0.00 sec)

			
			mycat_user@mysqldb 05:07:  [mycat_db]> select count(*) from test2;
			+--------+
			| COUNT0 |
			+--------+
			|     12 |
			+--------+
			1 row in set (0.01 sec)
			
mycat_user@mysqldb 19:26:  [mycat_db]> select * from test2 where nPlayerID between 2 and 6 order by nPlayerID asc;
+-----+-----------+---------+
| id  | nPlayerID | szToken |
+-----+-----------+---------+
| 814 |         2 | 123     |
| 815 |         3 | 123     |
| 816 |         4 | 123     |
| 817 |         5 | 123     |
| 818 |         6 | 123     |
+-----+-----------+---------+
5 rows in set (0.02 sec)
