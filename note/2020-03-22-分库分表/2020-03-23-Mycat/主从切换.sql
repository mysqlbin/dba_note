
1. 实验目的
2. 环境介绍
3. dataHost 节点中比较重要的三个属性以及各自值的含义
4. 配置
5. 记录重点数据信息
6. 测试
7. mycat05	的 general.log



1. 实验目的
	紧接个上一篇 读写分离 的来做主从切换
	假设 mycat01 宕机, 把业务切换到 mycat05 
	
2. 环境介绍
  
	3台物理机linux操作系统
	其中两台安装Mysql 5.7
	另一台安装Mycat

	主机        IP 地址         role              用途                分库分表模式          分库分表规则
	mgr9        192.168.0.55                      部署 Mycat           
  
	mycat01     192.168.0.201    master           分库分表             	

	mycat02     192.168.0.202	 master           分库分表	         
	
	mycat03     192.168.0.203	 master           分库分表	 
	
	mycat05     192.168.0.205	 mycat01的slave 
	
3. dataHost 节点中比较重要的三个属性以及各自值的含义

	1. balance 指的负载均衡类型，目前的取值有4种：

		1. balance=”0”
			不开启读写分离机制，所有读操作都发送到当前可用的writeHost上；
		2. balance=”1”
			全部的readHost与stand bywriteHost参与select语句的负载均衡，简单的说，当双主双从模式(M1->S1，M2->S2，并且M1与 M2互为主备)，正常情况下，M2,S1,S2都参与select语句的负载均衡；
		3. balance=”2”
			所有读操作都随机的在writeHost、readhost上分发；
		4. balance=”3”
			所有读请求随机的分发到wiriterHost对应的readhost执行，writerHost不负担读压力；
		
			如果是这种呢?
			begin; 
				select * from t1; 
				insert into t1; 
			commit ;
			
		注意：balance=3只在1.4及其以后版本有，1.3没有；

		
	2. writeType 属性：

		1.writeType=”0”
			所有写操作发送到配置的第一个writeHost, 第一个挂了切到还生存的第二个writeHost,重新启动后以切换后的为准，切换记录在配置文件中: dnindex.properties；
			即使恢复为原始的主从模式，Mycat重新启动后还是以切换后的为准。
			即使恢复为原始的主从模式, Mycat重新启动后还是以切换后的为准。当把第一次切换后的主库关闭，就会回到原来的模式。
			
			# 验证了。
			
		2.writeType=”1”
			所有写操作都随机地发送到配置的writeHost,1.5以后废弃不推荐；
		
	3. switchType 指的是切换的模式，目前的取值也有4种：

		1. switchType=’-1’ 
			表示不自动切换；
		2. switchType=’1’
			默认值，表示自动切换；
		3. switchType=’2’ 
			基于MySQL主从同步的状态决定是否切换,心跳语句为 show slave status；
		4. switchType=’3’
			基于MySQLgalary cluster的切换机制（适合集群）（1.4.1），心跳语句为 show status like ‘wsrep%’；
	

4. 配置

	<!-- 主数据库201 -->
	<dataHost name="datahost_201" maxCon="1000" minCon="10" balance="3"  
			  writeType="0" dbType="mysql" dbDriver="native" switchType="2"  slaveThreshold="100">   <!-- 底层MySQL登录方式-->
		<heartbeat>show slave status</heartbeat>
		<!-- can have multi write hosts -->
		<writeHost host="mycat01" url="192.168.0.201:3306" user="root" password="123456abc">
			<readHost host="mycat05" url="192.168.0.205:3306" user="root" password="123456abc" />
		</writeHost>
		<!-- <writeHost host="hostM2" url="localhost:3316" user="root" password="123456"/> -->
		
		 <!-- 备用写节点  -->
        <writeHost host="mycat05" url="192.168.0.205:3306" user="root" password="123456abc">
        </writeHost>

	</dataHost>
	
	
5. 记录重点数据信息

	mycat_user@mysqldb 23:43:  [(none)]> show @@datasource;
	+----------+---------+-------+---------------+------+------+--------+------+------+---------+-----------+------------+
	| DATANODE | NAME    | TYPE  | HOST          | PORT | W/R  | ACTIVE | IDLE | SIZE | EXECUTE | READ_LOAD | WRITE_LOAD |
	+----------+---------+-------+---------------+------+------+--------+------+------+---------+-----------+------------+
	| dn12     | mycat03 | mysql | 192.168.0.203 | 3306 | W    |      0 |   10 | 1000 |      12 |         0 |          0 |
	| dn11     | mycat03 | mysql | 192.168.0.203 | 3306 | W    |      0 |   10 | 1000 |      12 |         0 |          0 |
	| dn1      | mycat01 | mysql | 192.168.0.201 | 3306 | W    |      0 |   10 | 1000 |      12 |         0 |          0 |
	| dn1      | mycat05 | mysql | 192.168.0.205 | 3306 | W    |      0 |    1 | 1000 |       2 |         0 |          0 |
	| dn1      | mycat05 | mysql | 192.168.0.205 | 3306 | R    |      0 |    3 | 1000 |       5 |         0 |          0 |
	| dn10     | mycat03 | mysql | 192.168.0.203 | 3306 | W    |      0 |   10 | 1000 |      12 |         0 |          0 |
	| dn3      | mycat01 | mysql | 192.168.0.201 | 3306 | W    |      0 |   10 | 1000 |      12 |         0 |          0 |
	| dn3      | mycat05 | mysql | 192.168.0.205 | 3306 | W    |      0 |    1 | 1000 |       2 |         0 |          0 |
	| dn3      | mycat05 | mysql | 192.168.0.205 | 3306 | R    |      0 |    3 | 1000 |       5 |         0 |          0 |
	| dn2      | mycat01 | mysql | 192.168.0.201 | 3306 | W    |      0 |   10 | 1000 |      12 |         0 |          0 |
	| dn2      | mycat05 | mysql | 192.168.0.205 | 3306 | W    |      0 |    1 | 1000 |       2 |         0 |          0 |
	| dn2      | mycat05 | mysql | 192.168.0.205 | 3306 | R    |      0 |    3 | 1000 |       5 |         0 |          0 |
	| dn5      | mycat02 | mysql | 192.168.0.202 | 3306 | W    |      0 |   10 | 1000 |      12 |         0 |          0 |
	| dn4      | mycat01 | mysql | 192.168.0.201 | 3306 | W    |      0 |   10 | 1000 |      12 |         0 |          0 |
	| dn4      | mycat05 | mysql | 192.168.0.205 | 3306 | W    |      0 |    1 | 1000 |       2 |         0 |          0 |
	| dn4      | mycat05 | mysql | 192.168.0.205 | 3306 | R    |      0 |    3 | 1000 |       5 |         0 |          0 |
	| dn7      | mycat02 | mysql | 192.168.0.202 | 3306 | W    |      0 |   10 | 1000 |      12 |         0 |          0 |
	| dn6      | mycat02 | mysql | 192.168.0.202 | 3306 | W    |      0 |   10 | 1000 |      12 |         0 |          0 |
	| dn9      | mycat03 | mysql | 192.168.0.203 | 3306 | W    |      0 |   10 | 1000 |      12 |         0 |          0 |
	| dn8      | mycat02 | mysql | 192.168.0.202 | 3306 | W    |      0 |   10 | 1000 |      12 |         0 |          0 |
	+----------+---------+-------+---------------+------+------+--------+------+------+---------+-----------+------------+
	20 rows in set (0.01 sec)

		
	root@mysqldb 07:42:  [(none)]> select * from db1.mycat_sequence;
	+---------+---------------+-----------+
	| name    | current_value | increment |
	+---------+---------------+-----------+
	| GLOBALS |           101 |       100 |
	+---------+---------------+-----------+
	1 row in set (0.00 sec)


	mycat_user@mysqldb 23:44:  [mycat_db]> select * from test1;
	+-----+------+---------------------+
	| ID  | name | CreateTime          |
	+-----+------+---------------------+
	| 101 | lujb | 2020-03-01 00:00:00 |
	| 112 | lujb | 2020-03-02 00:00:00 |
	| 102 | lujb | 2020-03-11 00:00:00 |
	| 103 | lujb | 2020-03-22 00:00:00 |
	+-----+------+---------------------+
	4 rows in set (0.09 sec)


6. 测试
	关闭主服务器 192.168.0.201 的mysql服务
	
	/etc/init.d/mysql stop
	
	
	mycat_user@mysqldb 23:43:  [(none)]> show @@datasource;
	+----------+---------+-------+---------------+------+------+--------+------+------+---------+-----------+------------+
	| DATANODE | NAME    | TYPE  | HOST          | PORT | W/R  | ACTIVE | IDLE | SIZE | EXECUTE | READ_LOAD | WRITE_LOAD |
	+----------+---------+-------+---------------+------+------+--------+------+------+---------+-----------+------------+
	| dn12     | mycat03 | mysql | 192.168.0.203 | 3306 | W    |      0 |   10 | 1000 |      38 |         2 |          0 |
	| dn11     | mycat03 | mysql | 192.168.0.203 | 3306 | W    |      0 |   10 | 1000 |      38 |         2 |          0 |
	| dn1      | mycat01 | mysql | 192.168.0.201 | 3306 | W    |      0 |    0 | 1000 |       0 |         0 |          0 |
	| dn1      | mycat05 | mysql | 192.168.0.205 | 3306 | W    |      0 |    2 | 1000 |      39 |         2 |          1 |
	| dn1      | mycat05 | mysql | 192.168.0.205 | 3306 | R    |      0 |    3 | 1000 |      31 |         2 |          0 |
	| dn10     | mycat03 | mysql | 192.168.0.203 | 3306 | W    |      0 |   10 | 1000 |      38 |         2 |          0 |
	| dn3      | mycat01 | mysql | 192.168.0.201 | 3306 | W    |      0 |    0 | 1000 |       0 |         0 |          0 |
	| dn3      | mycat05 | mysql | 192.168.0.205 | 3306 | W    |      0 |    2 | 1000 |      39 |         2 |          1 |
	| dn3      | mycat05 | mysql | 192.168.0.205 | 3306 | R    |      0 |    3 | 1000 |      31 |         2 |          0 |
	| dn2      | mycat01 | mysql | 192.168.0.201 | 3306 | W    |      0 |    0 | 1000 |       0 |         0 |          0 |
	| dn2      | mycat05 | mysql | 192.168.0.205 | 3306 | W    |      0 |    2 | 1000 |      39 |         2 |          1 |
	| dn2      | mycat05 | mysql | 192.168.0.205 | 3306 | R    |      0 |    3 | 1000 |      31 |         2 |          0 |
	| dn5      | mycat02 | mysql | 192.168.0.202 | 3306 | W    |      0 |   10 | 1000 |      39 |         2 |          1 |
	| dn4      | mycat01 | mysql | 192.168.0.201 | 3306 | W    |      0 |    0 | 1000 |       0 |         0 |          0 |
	| dn4      | mycat05 | mysql | 192.168.0.205 | 3306 | W    |      0 |    2 | 1000 |      39 |         2 |          1 |
	| dn4      | mycat05 | mysql | 192.168.0.205 | 3306 | R    |      0 |    3 | 1000 |      31 |         2 |          0 |
	| dn7      | mycat02 | mysql | 192.168.0.202 | 3306 | W    |      0 |   10 | 1000 |      39 |         2 |          1 |
	| dn6      | mycat02 | mysql | 192.168.0.202 | 3306 | W    |      0 |   10 | 1000 |      39 |         2 |          1 |
	| dn9      | mycat03 | mysql | 192.168.0.203 | 3306 | W    |      0 |   10 | 1000 |      38 |         2 |          0 |
	| dn8      | mycat02 | mysql | 192.168.0.202 | 3306 | W    |      0 |   10 | 1000 |      39 |         2 |          1 |
	+----------+---------+-------+---------------+------+------+--------+------+------+---------+-----------+------------+
	20 rows in set (0.00 sec)
	
	mycat_user@mysqldb 23:44:  [mycat_db]> INSERT INTO `test1` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2020-03-23');
	Query OK, 1 row affected (0.08 sec)

	mycat_user@mysqldb 23:46:  [mycat_db]> select * from test1;
	+-----+------+---------------------+
	| ID  | name | CreateTime          |
	+-----+------+---------------------+
	| 101 | lujb | 2020-03-01 00:00:00 |
	| 112 | lujb | 2020-03-02 00:00:00 |
	| 102 | lujb | 2020-03-11 00:00:00 |
	| 103 | lujb | 2020-03-22 00:00:00 |
	| 201 | lujb | 2020-03-23 00:00:00 |
	+-----+------+---------------------+
	5 rows in set (0.03 sec)

	
	INSERT INTO `test1` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2020-03-03');
	
	mycat_user@mysqldb 23:52:  [mycat_db]> select * from test1;
	+-----+------+---------------------+
	| ID  | name | CreateTime          |
	+-----+------+---------------------+
	| 101 | lujb | 2020-03-01 00:00:00 |
	| 112 | lujb | 2020-03-02 00:00:00 |
	| 202 | lujb | 2020-03-03 00:00:00 |
	| 102 | lujb | 2020-03-11 00:00:00 |
	| 103 | lujb | 2020-03-22 00:00:00 |
	| 201 | lujb | 2020-03-23 00:00:00 |
	+-----+------+---------------------+
	6 rows in set (0.02 sec)
	

7. mycat05	的 general.log

	2020-03-27T14:35:35.165007+08:00	   28 Query	INSERT INTO `test1` (`id`, `name`, `CreateTime`) VALUES ('202', 'lujb', '2020-03-03')
	
	2020-03-27T14:36:09.003337+08:00	   22 Query	SELECT *
	FROM test1
	LIMIT 100
	2020-03-27T14:36:09.004011+08:00	   23 Query	SELECT *
	FROM test1
	LIMIT 100


	
	

			