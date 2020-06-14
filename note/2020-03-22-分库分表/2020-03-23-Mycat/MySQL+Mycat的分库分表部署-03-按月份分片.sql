

			
按月份分片	

	3个主机节点的环境 
		主机        IP 地址           用途                分库分表模式                   分库分表规则
		mgr9        192.168.0.55      部署 Mycat           mycat: test4                   按月份分片
	 
		mycat01     192.168.0.201     分库分表             db1 db2 db3 db4			

		mycat02     192.168.0.202	  分库分表	           db1 db2 db3 db4
		
		mycat03     192.168.0.203	  分库分表	           db1 db2 db3 db4
	
	各个主机节点都需要执行:
		create  database db1 DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;
		create  database db2 DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;
		create  database db3 DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;
		create  database db4 DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;
		
		use db1;
		CREATE TABLE test4 (  
			id bigint(20) NOT NULL AUTO_INCREMENT,  
			name varchar(50) NOT NULL default '', 
			`CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
			PRIMARY KEY (id)  
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;  
			
		use db2;
		CREATE TABLE test4 (  
			id bigint(20) NOT NULL AUTO_INCREMENT,  
			name varchar(50) NOT NULL default '', 
			`CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
			PRIMARY KEY (id)  
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;  
			
		use db3;
		CREATE TABLE test4 (  
			id bigint(20) NOT NULL AUTO_INCREMENT,  
			name varchar(50) NOT NULL default '', 
			`CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
			PRIMARY KEY (id)  
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;  
			
		use db4;
		CREATE TABLE test4 (  
			id bigint(20) NOT NULL AUTO_INCREMENT,  
			name varchar(50) NOT NULL default '', 
			`CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
			PRIMARY KEY (id)  
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;  
			


		alter table `test1` modify column id bigint(20) NOT NULL AUTO_INCREMENT;


	
	插入数据		
		INSERT INTO `test4` (`name`, `CreateTime`) VALUES ('lujb', '2019-01-02');
		INSERT INTO `test4` (`name`, `CreateTime`) VALUES ('lujb', '2019-02-02');
		INSERT INTO `test4` (`name`, `CreateTime`) VALUES ('lujb', '2019-03-02');
		INSERT INTO `test4` (`name`, `CreateTime`) VALUES ('lujb', '2019-04-02');
		INSERT INTO `test4` (`name`, `CreateTime`) VALUES ('lujb', '2019-05-02');
		INSERT INTO `test4` (`name`, `CreateTime`) VALUES ('lujb', '2019-06-02');
		INSERT INTO `test4` (`name`, `CreateTime`) VALUES ('lujb', '2019-07-02');
		INSERT INTO `test4` (`name`, `CreateTime`) VALUES ('lujb', '2019-08-02');
		INSERT INTO `test4` (`name`, `CreateTime`) VALUES ('lujb', '2019-09-02');
		INSERT INTO `test4` (`name`, `CreateTime`) VALUES ('lujb', '2019-10-02');
		INSERT INTO `test4` (`name`, `CreateTime`) VALUES ('lujb', '2019-11-02');
		INSERT INTO `test4` (`name`, `CreateTime`) VALUES ('lujb', '2019-12-02');

		INSERT INTO `test4` (`name`, `CreateTime`) VALUES ('lujb', '2019-01-10');
		INSERT INTO `test4` (`name`, `CreateTime`) VALUES ('lujb', '2019-02-10');
		INSERT INTO `test4` (`name`, `CreateTime`) VALUES ('lujb', '2019-03-10');
		INSERT INTO `test4` (`name`, `CreateTime`) VALUES ('lujb', '2019-04-10');
		INSERT INTO `test4` (`name`, `CreateTime`) VALUES ('lujb', '2019-05-10');
		INSERT INTO `test4` (`name`, `CreateTime`) VALUES ('lujb', '2019-06-10');
		INSERT INTO `test4` (`name`, `CreateTime`) VALUES ('lujb', '2019-07-10');
		INSERT INTO `test4` (`name`, `CreateTime`) VALUES ('lujb', '2019-08-10');
		INSERT INTO `test4` (`name`, `CreateTime`) VALUES ('lujb', '2019-09-10');
		INSERT INTO `test4` (`name`, `CreateTime`) VALUES ('lujb', '2019-10-10');
		INSERT INTO `test4` (`name`, `CreateTime`) VALUES ('lujb', '2019-11-10');
		INSERT INTO `test4` (`name`, `CreateTime`) VALUES ('lujb', '2019-12-10');
	
	
		
	查看数据	
		select * from db1.test4;
		select * from db2.test4;
		select * from db3.test4;
		select * from db4.test4;
		
		192.168.0.201
		
			root@mysqldb 11:18:  [(none)]> select * from db1.test4;
			+---------------------+------+---------------------+
			| id                  | name | CreateTime          |
			+---------------------+------+---------------------+
			| 1242892685405196289 | lujb | 2019-01-02 00:00:00 |
			| 1242892806897405953 | lujb | 2019-01-10 00:00:00 |
			+---------------------+------+---------------------+
			2 rows in set (0.00 sec)

			root@mysqldb 11:18:  [(none)]> select * from db2.test4;
			+---------------------+------+---------------------+
			| ID                  | name | CreateTime          |
			+---------------------+------+---------------------+
			| 1242892685480693761 | lujb | 2019-02-02 00:00:00 |
			| 1242892807027429376 | lujb | 2019-02-10 00:00:00 |
			+---------------------+------+---------------------+
			2 rows in set (0.00 sec)

			root@mysqldb 11:18:  [(none)]> select * from db3.test4;
			+---------------------+------+---------------------+
			| id                  | name | CreateTime          |
			+---------------------+------+---------------------+
			| 1242892685547802625 | lujb | 2019-03-02 00:00:00 |
			| 1242892807111315456 | lujb | 2019-03-10 00:00:00 |
			+---------------------+------+---------------------+
			2 rows in set (0.00 sec)

			root@mysqldb 11:18:  [(none)]> select * from db4.test4;
			+---------------------+------+---------------------+
			| id                  | name | CreateTime          |
			+---------------------+------+---------------------+
			| 1242892685606522881 | lujb | 2019-04-02 00:00:00 |
			| 1242892807178424320 | lujb | 2019-04-10 00:00:00 |
			+---------------------+------+---------------------+
			2 rows in set (0.00 sec)
			
		192.168.0..202 
			root@mysqldb 11:22:  [(none)]> select * from db1.test4;
			+---------------------+------+---------------------+
			| id                  | name | CreateTime          |
			+---------------------+------+---------------------+
			| 1242892685648465921 | lujb | 2019-05-02 00:00:00 |
			| 1242892807266504705 | lujb | 2019-05-10 00:00:00 |
			+---------------------+------+---------------------+
			2 rows in set (0.00 sec)

			root@mysqldb 11:22:  [(none)]> select * from db2.test4;
			+---------------------+------+---------------------+
			| id                  | name | CreateTime          |
			+---------------------+------+---------------------+
			| 1242892685702991872 | lujb | 2019-06-02 00:00:00 |
			| 1242892807417499649 | lujb | 2019-06-10 00:00:00 |
			+---------------------+------+---------------------+
			2 rows in set (0.00 sec)

			root@mysqldb 11:22:  [(none)]> select * from db3.test4;
			+---------------------+------+---------------------+
			| id                  | name | CreateTime          |
			+---------------------+------+---------------------+
			| 1242892685740740609 | lujb | 2019-07-02 00:00:00 |
			| 1242892807480414208 | lujb | 2019-07-10 00:00:00 |
			+---------------------+------+---------------------+
			2 rows in set (0.00 sec)

			root@mysqldb 11:22:  [(none)]> select * from db4.test4;
			+---------------------+------+---------------------+
			| ID                  | name | CreateTime          |
			+---------------------+------+---------------------+
			| 1242892685791072257 | lujb | 2019-08-02 00:00:00 |
			| 1242892807539134464 | lujb | 2019-08-10 00:00:00 |
			+---------------------+------+---------------------+
			2 rows in set (0.00 sec)
		
		192.168.0..203
			root@mysqldb 13:57:  [(none)]> select * from db1.test4;
			+---------------------+------+---------------------+
			| id                  | name | CreateTime          |
			+---------------------+------+---------------------+
			| 1242892685841403905 | lujb | 2019-09-02 00:00:00 |
			| 1242892807606243328 | lujb | 2019-09-10 00:00:00 |
			+---------------------+------+---------------------+
			2 rows in set (0.00 sec)

			root@mysqldb 13:57:  [(none)]> select * from db2.test4;
			+---------------------+------+---------------------+
			| id                  | name | CreateTime          |
			+---------------------+------+---------------------+
			| 1242892685929484288 | lujb | 2019-10-02 00:00:00 |
			| 1242892807803375617 | lujb | 2019-10-10 00:00:00 |
			+---------------------+------+---------------------+
			2 rows in set (0.00 sec)

			root@mysqldb 13:57:  [(none)]> select * from db3.test4;
			+---------------------+------+---------------------+
			| id                  | name | CreateTime          |
			+---------------------+------+---------------------+
			| 1242892685984010241 | lujb | 2019-11-02 00:00:00 |
			| 1242892807916621824 | lujb | 2019-11-10 00:00:00 |
			+---------------------+------+---------------------+
			2 rows in set (0.00 sec)

			root@mysqldb 13:57:  [(none)]> select * from db4.test4;
			+---------------------+------+---------------------+
			| id                  | name | CreateTime          |
			+---------------------+------+---------------------+
			| 1242892686034341889 | lujb | 2019-12-02 00:00:00 |
			| 1242892808059228160 | lujb | 2019-12-10 00:00:00 |
			+---------------------+------+---------------------+
			2 rows in set (0.00 sec)
			
		
