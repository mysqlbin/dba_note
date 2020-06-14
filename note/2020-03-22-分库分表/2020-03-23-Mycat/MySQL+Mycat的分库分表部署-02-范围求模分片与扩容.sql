

1. 范围求模分片
	
	环境如下
		主机        IP 地址           用途                分库分表模式                    分库分表规则
		mgr9        192.168.0.55      部署 Mycat           mycat: test3                   test3: 范围求模分片   
	 
		mycat01     192.168.0.201     分库分表             db1: test3			

		mycat02     192.168.0.202	  分库分表	           db3: test3
		
		use mycat01.db1;
		CREATE TABLE test3 (  
			id INT NOT NULL AUTO_INCREMENT,  
			name varchar(50) NOT NULL default '',  
			PRIMARY KEY (id)  
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;  
		
		use mycat02.db3;
		CREATE TABLE test3 (  
			id INT NOT NULL AUTO_INCREMENT,  
			name varchar(50) NOT NULL default '',  
			PRIMARY KEY (id)  
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
		
		INSERT INTO test3 (id, name)VALUES ('9999', 'weikaixxxxxx');
		INSERT INTO test3 (id, name)VALUES ('10000', 'weikaixxxxxx');
		INSERT INTO test3 (id, name)VALUES ('10001', 'weikaixxxxxx');
		INSERT INTO test3 (id, name)VALUES ('20000', 'weikaixxxxxx');

		mycat_user@mysqldb 07:37:  [mycat_db]> select * from test3;
		+-------+--------------+
		| id    | name         |
		+-------+--------------+
		|  9999 | weikaixxxxxx |
		| 10000 | weikaixxxxxx |
		| 10001 | weikaixxxxxx |
		| 20000 | weikaixxxxxx |
		+-------+--------------+
		4 rows in set (0.05 sec)
		
		root@mysqldb 15:40:  [(none)]> select * from db1.test3;
		+-------+--------------+
		| id    | name         |
		+-------+--------------+
		|  9999 | weikaixxxxxx |
		| 10000 | weikaixxxxxx |
		+-------+--------------+
		2 rows in set (0.00 sec)

		root@mysqldb 15:43:  [(none)]> select * from db3.test3;
		+-------+--------------+
		| id    | name         |
		+-------+--------------+
		| 10001 | weikaixxxxxx |
		| 20000 | weikaixxxxxx |
		+-------+--------------+
		2 rows in set (0.00 sec)

2. 扩容


		新建第三个库和一张test3表，表内有id和name字段
		环境如下
		主机        IP 地址           用途                分库分表模式                    分库分表规则
		mgr9        192.168.0.55      部署 Mycat           mycat: test3                   test3: 范围求模分片   
	 
		mycat01     192.168.0.201     分库分表             db1: test3			

		mycat02     192.168.0.202	  分库分表	           db3: test3
		
		mycat03     192.168.0.203	  分库分表	           db5: test3
		
		create  database db5 DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;
		use db5;
		CREATE TABLE test3 (  
			id INT NOT NULL AUTO_INCREMENT,  
			name varchar(50) NOT NULL default '',  
			PRIMARY KEY (id)  
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
		
		配置
			schema.xml
				<table name="test3" primaryKey="ID" dataNode="dn1,dn3,dn5" rule="sharding-by-rang-mod" splitTableNames ="true"/>
				
				<dataNode name="dn5" dataHost="datahost_203" database="db5" />
				
				
				<dataHost name="datahost_203" maxCon="1000" minCon="10" balance="0" 
				  writeType="0" dbType="mysql" dbDriver="native" switchType="1"  slaveThreshold="100">   <!-- 底层MySQL登录方式-->
					<heartbeat>select user()</heartbeat>
					<!-- can have multi write hosts -->
					<writeHost host="mycat03" url="192.168.0.203:3306" user="root" password="123456abc">
					</writeHost>
					<!-- <writeHost host="hostM2" url="localhost:3316" user="root" password="123456"/> -->
				</dataHost>
				
			partition-range-mod.txt	
			# range start-end ,data node group size
			0-1M=1
			1M1-2M=2

		
		重启 mycat
			
		测试功能
		
			INSERT INTO test3 (id, name)VALUES ('10019', 'weikaixxxxxx');
			INSERT INTO test3 (id, name)VALUES ('10020', 'weikaixxxxxx');
			
			root@mysqldb 05:50:  [(none)]> select * from db3.test3;
			+-------+--------------+
			| id    | name         |
			+-------+--------------+
			| 10001 | weikaixxxxxx |
			| 10020 | weikaixxxxxx |
			| 20000 | weikaixxxxxx |
			+-------+--------------+
			3 rows in set (0.00 sec)
			
					
			root@mysqldb 08:25:  [(none)]> select * from db5.test3;
			+-------+--------------+
			| id    | name         |
			+-------+--------------+
			| 10019 | weikaixxxxxx |
			+-------+--------------+
			1 row in set (0.00 sec)
			
			
			INSERT INTO test3 (id, name)VALUES ('10002', 'weikaixxxxxx');
			INSERT INTO test3 (id, name)VALUES ('10003', 'weikaixxxxxx');
			
			root@mysqldb 05:50:  [(none)]> select * from db3.test3;
			+-------+--------------+
			| id    | name         |
			+-------+--------------+
			| 10001 | weikaixxxxxx |
			| 10002 | weikaixxxxxx |
			| 10020 | weikaixxxxxx |
			| 20000 | weikaixxxxxx |
			+-------+--------------+
			4 rows in set (0.00 sec)

			
			root@mysqldb 08:25:  [(none)]> select * from db5.test3;
			+-------+--------------+
			| id    | name         |
			+-------+--------------+
			| 10003 | weikaixxxxxx |
			| 10019 | weikaixxxxxx |
			+-------+--------------+
			2 rows in set (0.00 sec)
		
			
			可以看到, id = 10003 和 id = 10019 的行记录已经扩容到 192.168.0.203 上了.
			
			
	