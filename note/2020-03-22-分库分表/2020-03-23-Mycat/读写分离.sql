
1. 环境介绍
2. 配置主从	
3. dataHost 节点中比较重要的三个属性以及各自值的含义
4. 配置 schema.xml, 重启 Mycat 
5. 进入Mycat的管理端
6. 执行查询
7. 查看读写分离效果
8. 注意事项
9. 在读写分离中测试Mycat对事务的支持



1. 环境介绍
  
	3台物理机linux操作系统
	其中两台安装Mysql 5.7
	另一台安装Mycat

	主机        IP 地址         role           用途                分库分表模式          分库分表规则
	mgr9        192.168.0.55                   部署 Mycat           
  
	mycat01     192.168.0.201    master        分库分表             	

	mycat02     192.168.0.202	 master        分库分表	         
	
	mycat03     192.168.0.203	 master        分库分表	 
	
	mycat05     192.168.0.205	 mycat01的slave 	   
	
	
2. 配置主从	
	master	
		create user 'repl_user'@'192.168.0.%' identified by '123456abc';
		grant replication slave on *.* to 'repl_user'@'192.168.0.%' with grant option;	
			
		root@mysqldb 04:28:  [(none)]> show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000004
				 Position: 643
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: 4de223ef-6dab-11ea-a74c-0800276af083:1-2
		1 row in set (0.00 sec)

		ERROR: 
		No query specified

		
	slave:
		reset master;
		change master to master_host='192.168.0.201', master_user='repl_user', master_password='123456abc',master_auto_position=1;
		start slave;
		show slave status\G;
		
		
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
		
		注意：balance=3只在1.4及其以后版本有，1.3没有；

		
	2. writeType 属性：

		1.writeType=”0”
			所有写操作发送到配置的第一个writeHost, 第一个挂了切到还生存的第二个writeHost,重新启动后以切换后的为准，切换记录在配置文件中: dnindex.properties；
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

4. 配置 schema.xml, 重启 Mycat 

	<!-- 主数据库201 -->
	<dataHost name="datahost_201" maxCon="1000" minCon="10" balance="3"  
			  writeType="0" dbType="mysql" dbDriver="native" switchType="1"  slaveThreshold="100">   <!-- 底层MySQL登录方式-->
		<heartbeat>select user()</heartbeat>
		<!-- can have multi write hosts -->
		<writeHost host="mycat01" url="192.168.0.201:3306" user="root" password="123456abc">
			<!-- 读库205 --->
			<readHost host="mycat05" url="192.168.0.205:3306" user="root" password="123456abc" />
		</writeHost>
		<!-- <writeHost host="hostM2" url="localhost:3316" user="root" password="123456"/> -->
	</dataHost>
	
	
5. 进入Mycat的管理端
	[root@mgr9 conf]# mysql -h127.0.0.1 -umycat_user -p123456abc -P9066

	mycat_user@mysqldb 21:15:  [(none)]> show @@datasource;
	+----------+---------+-------+---------------+------+------+--------+------+------+---------+-----------+------------+
	| DATANODE | NAME    | TYPE  | HOST          | PORT | W/R  | ACTIVE | IDLE | SIZE | EXECUTE | READ_LOAD | WRITE_LOAD |
	+----------+---------+-------+---------------+------+------+--------+------+------+---------+-----------+------------+
	| dn12     | mycat03 | mysql | 192.168.0.203 | 3306 | W    |      0 |   10 | 1000 |      12 |         0 |          0 |
	| dn11     | mycat03 | mysql | 192.168.0.203 | 3306 | W    |      0 |   10 | 1000 |      12 |         0 |          0 |
	| dn1      | mycat01 | mysql | 192.168.0.201 | 3306 | W    |      0 |   10 | 1000 |      12 |         0 |          0 |
	| dn1      | mycat05 | mysql | 192.168.0.205 | 3306 | R    |      0 |    3 | 1000 |       5 |         0 |          0 |
	| dn10     | mycat03 | mysql | 192.168.0.203 | 3306 | W    |      0 |   10 | 1000 |      12 |         0 |          0 |
	| dn3      | mycat01 | mysql | 192.168.0.201 | 3306 | W    |      0 |   10 | 1000 |      12 |         0 |          0 |
	| dn3      | mycat05 | mysql | 192.168.0.205 | 3306 | R    |      0 |    3 | 1000 |       5 |         0 |          0 |
	| dn2      | mycat01 | mysql | 192.168.0.201 | 3306 | W    |      0 |   10 | 1000 |      12 |         0 |          0 |
	| dn2      | mycat05 | mysql | 192.168.0.205 | 3306 | R    |      0 |    3 | 1000 |       5 |         0 |          0 |
	| dn5      | mycat02 | mysql | 192.168.0.202 | 3306 | W    |      0 |   10 | 1000 |      12 |         0 |          0 |
	| dn4      | mycat01 | mysql | 192.168.0.201 | 3306 | W    |      0 |   10 | 1000 |      12 |         0 |          0 |
	| dn4      | mycat05 | mysql | 192.168.0.205 | 3306 | R    |      0 |    3 | 1000 |       5 |         0 |          0 |
	| dn7      | mycat02 | mysql | 192.168.0.202 | 3306 | W    |      0 |   10 | 1000 |      12 |         0 |          0 |
	| dn6      | mycat02 | mysql | 192.168.0.202 | 3306 | W    |      0 |   10 | 1000 |      12 |         0 |          0 |
	| dn9      | mycat03 | mysql | 192.168.0.203 | 3306 | W    |      0 |   10 | 1000 |      12 |         0 |          0 |
	| dn8      | mycat02 | mysql | 192.168.0.202 | 3306 | W    |      0 |   10 | 1000 |      12 |         0 |          0 |
	+----------+---------+-------+---------------+------+------+--------+------+------+---------+-----------+------------+
	16 rows in set (0.02 sec)

	

6. 执行查询	

	mycat客户端
		mycat_user@mysqldb 21:16:  [mycat_db]> select count(*) from test1;
		+--------+
		| COUNT0 |
		+--------+
		|      4 |
		+--------+
		1 row in set (0.04 sec)

		mycat_user@mysqldb 20:55:  [mycat_db]> select * from test1;
		+-----+------+---------------------+
		| ID  | name | CreateTime          |
		+-----+------+---------------------+
		| 101 | lujb | 2020-03-01 00:00:00 |
		| 112 | lujb | 2020-03-02 00:00:00 |
		| 102 | lujb | 2020-03-11 00:00:00 |
		| 103 | lujb | 2020-03-22 00:00:00 |
		+-----+------+---------------------+
		4 rows in set (0.00 sec)


	192.168.0.205
		root@mysqldb 11:32:  [(none)]> select * from db1.test1;
		+-----+------+---------------------+
		| ID  | name | CreateTime          |
		+-----+------+---------------------+
		| 101 | lujb | 2020-03-01 00:00:00 |
		| 112 | lujb | 2020-03-02 00:00:00 |
		+-----+------+---------------------+
		2 rows in set (0.00 sec)

7. 查看读写分离效果
	192.168.0.201 的 general.log 
		2020-03-27T05:18:52.340463+08:00	   14 Query	select user()
		2020-03-27T05:19:02.310481+08:00	   15 Query	select user()
		2020-03-27T05:19:12.310238+08:00	   19 Query	select user()
		2020-03-27T05:19:22.316440+08:00	   14 Query	select user()
		2020-03-27T05:19:32.310396+08:00	   24 Query	select user()

	192.168.0.205 的 general.log

		2020-03-27T12:03:28.984553+08:00	   10 Query	SELECT *
		FROM test1
		LIMIT 100
		2020-03-27T12:03:32.844820+08:00	    7 Query	select user()
		2020-03-27T12:03:42.851000+08:00	   10 Query	select user()

	mycat.log 
		2020-03-26 21:20:22.955 DEBUG [$_MyCatServer] (io.mycat.net.FrontendConnection.setId(FrontendConnection.java:106)) - ServerConnection [id=3, schema=null, host=127.0.0.1, user=null,txIsolation=3, autocommit=true, schema=null, executeSql=null] localPort:44188 port8066
		2020-03-26 21:20:22.957  INFO [$_NIOREACTOR-0-RW] (io.mycat.net.handler.FrontendAuthenticator.success(FrontendAuthenticator.java:226)) - ServerConnection [id=3, schema=mycat_db, host=127.0.0.1, user=mycat_user,txIsolation=3, autocommit=true, schema=mycat_db, executeSql=null]'mycat_user' login success
		2020-03-26 21:20:22.962 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.net.FrontendConnection.query(FrontendConnection.java:337)) - ServerConnection [id=3, schema=mycat_db, host=127.0.0.1, user=mycat_user,txIsolation=3, autocommit=true, schema=mycat_db, executeSql=null] select * from test1
		2020-03-26 21:20:22.962 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.server.ServerQueryHandler.query(ServerQueryHandler.java:70)) - ServerConnection [id=3, schema=mycat_db, host=127.0.0.1, user=mycat_user,txIsolation=3, autocommit=true, schema=mycat_db, executeSql=select * from test1]select * from test1
		2020-03-26 21:20:22.963 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.cache.impl.EnchachePool.get(EnchachePool.java:71)) - SQLRouteCache hit cache ,key:mycat_dbselect * from test1
		2020-03-26 21:20:22.963 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.server.NonBlockingSession.execute(NonBlockingSession.java:126)) - ServerConnection [id=3, schema=mycat_db, host=127.0.0.1, user=mycat_user,txIsolation=3, autocommit=true, schema=mycat_db, executeSql=select * from test1]select * from test1, route={
		   1 -> dn1{SELECT *
		FROM test1
		LIMIT 100}
		   2 -> dn2{SELECT *
		FROM test1
		LIMIT 100}
		   3 -> dn5{SELECT *
		FROM test1
		LIMIT 100}
		   4 -> dn9{SELECT *
		FROM test1
		LIMIT 100}
		} rrs 
		2020-03-26 21:20:22.964 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.mysql.nio.handler.MultiNodeQueryHandler.<init>(MultiNodeQueryHandler.java:128)) - execute mutinode query select * from test1
		2020-03-26 21:20:22.964 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.mysql.nio.handler.MultiNodeQueryHandler.<init>(MultiNodeQueryHandler.java:164)) - has data merge logic 
		2020-03-26 21:20:22.964 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.mysql.nio.handler.MultiNodeQueryHandler.execute(MultiNodeQueryHandler.java:201)) - rrs.getRunOnSlave()-default
		2020-03-26 21:20:22.964 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.datasource.PhysicalDBNode.getConnection(PhysicalDBNode.java:102)) - rrs.getRunOnSlave()  default 
		2020-03-26 21:20:22.964 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.datasource.PhysicalDBNode.getConnection(PhysicalDBNode.java:133)) - rrs.getRunOnSlave()  default 
		
		
		
		#  从这里就可以看到, 已经让读操作在 mycat05 上执行了.
		2020-03-26 21:20:22.964 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.datasource.PhysicalDBPool.getRWBanlanceCon(PhysicalDBPool.java:556)) - select read source mycat05 for dataHost:datahost_201
		2020-03-26 21:20:22.965 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.mysql.nio.MySQLConnection.synAndDoExecute(MySQLConnection.java:503)) - con need syn ,total syn cmd 1 commands SET names utf8;schema change:false con:MySQLConnection@1147109347 [id=37, lastTime=1585228822965, user=root, schema=db1, old shema=db1, borrowed=true, fromSlaveDB=true, threadId=10, charset=utf8, txIsolation=3, autocommit=true, attachment=dn1{SELECT *
		FROM test1
		LIMIT 100}, respHandler=io.mycat.backend.mysql.nio.handler.MultiNodeQueryHandler@4d49bbe8, host=192.168.0.205, port=3306, statusSync=io.mycat.backend.mysql.nio.MySQLConnection$StatusSync@68cc5e2e, writeQueue=0, modifiedSQLExecuted=false]
		2020-03-26 21:20:22.966 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.datasource.PhysicalDBNode.getConnection(PhysicalDBNode.java:102)) - rrs.getRunOnSlave()  default 
		2020-03-26 21:20:22.966 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.datasource.PhysicalDBNode.getConnection(PhysicalDBNode.java:133)) - rrs.getRunOnSlave()  default 
		2020-03-26 21:20:22.966 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.datasource.PhysicalDBPool.getRWBanlanceCon(PhysicalDBPool.java:556)) - select read source mycat05 for dataHost:datahost_201
		2020-03-26 21:20:22.967 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.datasource.PhysicalDBNode.getConnection(PhysicalDBNode.java:102)) - rrs.getRunOnSlave()  default 
		2020-03-26 21:20:22.967 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.datasource.PhysicalDBNode.getConnection(PhysicalDBNode.java:133)) - rrs.getRunOnSlave()  default 
		
		
		2020-03-26 21:20:22.967 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.datasource.PhysicalDBPool.getRWBanlanceCon(PhysicalDBPool.java:556)) - select read source mycat02 for dataHost:datahost_202
		2020-03-26 21:20:22.968 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.datasource.PhysicalDBNode.getConnection(PhysicalDBNode.java:102)) - rrs.getRunOnSlave()  default 
		2020-03-26 21:20:22.968 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.datasource.PhysicalDBNode.getConnection(PhysicalDBNode.java:133)) - rrs.getRunOnSlave()  default 
		2020-03-26 21:20:22.968 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.datasource.PhysicalDBPool.getRWBanlanceCon(PhysicalDBPool.java:556)) - select read source mycat03 for dataHost:datahost_203
		
		
		2020-03-26 21:20:22.977 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.sqlengine.mpp.DataMergeService.onRowMetaData(DataMergeService.java:79)) - field metadata keys:[CREATETIME, ID, NAME]
		2020-03-26 21:20:22.977 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.sqlengine.mpp.DataMergeService.onRowMetaData(DataMergeService.java:80)) - field metadata values:[ColMeta [colIndex=2, colType=7], ColMeta [colIndex=0, colType=8], ColMeta [colIndex=1, colType=253]]
		2020-03-26 21:20:22.977 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.mysql.nio.handler.MultiNodeQueryHandler.rowEofResponse(MultiNodeQueryHandler.java:392)) - io.mycat.backend.mysql.nio.handler.MultiNodeQueryHandler@4d49bbe8on row end reseponse MySQLConnection@957459753 [id=23, lastTime=1585228822951, user=root, schema=db1, old shema=db1, borrowed=true, fromSlaveDB=false, threadId=211, charset=utf8, txIsolation=3, autocommit=true, attachment=dn9{SELECT *
		FROM test1
		LIMIT 100}, respHandler=io.mycat.backend.mysql.nio.handler.MultiNodeQueryHandler@4d49bbe8, host=192.168.0.203, port=3306, statusSync=null, writeQueue=0, modifiedSQLExecuted=false]  false  4
		2020-03-26 21:20:22.978 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.server.NonBlockingSession.releaseConnection(NonBlockingSession.java:386)) - release connection MySQLConnection@957459753 [id=23, lastTime=1585228822951, user=root, schema=db1, old shema=db1, borrowed=true, fromSlaveDB=false, threadId=211, charset=utf8, txIsolation=3, autocommit=true, attachment=dn9{SELECT *
		FROM test1
		LIMIT 100}, respHandler=io.mycat.backend.mysql.nio.handler.MultiNodeQueryHandler@4d49bbe8, host=192.168.0.203, port=3306, statusSync=null, writeQueue=0, modifiedSQLExecuted=false]
		2020-03-26 21:20:22.978 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.datasource.PhysicalDatasource.releaseChannel(PhysicalDatasource.java:633)) - release channel MySQLConnection@957459753 [id=23, lastTime=1585228822951, user=root, schema=db1, old shema=db1, borrowed=true, fromSlaveDB=false, threadId=211, charset=utf8, txIsolation=3, autocommit=true, attachment=null, respHandler=null, host=192.168.0.203, port=3306, statusSync=null, writeQueue=0, modifiedSQLExecuted=false]
		2020-03-26 21:20:22.978 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.mysql.nio.handler.MultiNodeQueryHandler.rowEofResponse(MultiNodeQueryHandler.java:392)) - io.mycat.backend.mysql.nio.handler.MultiNodeQueryHandler@4d49bbe8on row end reseponse MySQLConnection@565121492 [id=32, lastTime=1585228822951, user=root, schema=db2, old shema=db2, borrowed=true, fromSlaveDB=true, threadId=8, charset=utf8, txIsolation=3, autocommit=true, attachment=dn2{SELECT *
		FROM test1
		LIMIT 100}, respHandler=io.mycat.backend.mysql.nio.handler.MultiNodeQueryHandler@4d49bbe8, host=192.168.0.205, port=3306, statusSync=null, writeQueue=0, modifiedSQLExecuted=false]  false  3
		2020-03-26 21:20:22.978 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.server.NonBlockingSession.releaseConnection(NonBlockingSession.java:386)) - release connection MySQLConnection@565121492 [id=32, lastTime=1585228822951, user=root, schema=db2, old shema=db2, borrowed=true, fromSlaveDB=true, threadId=8, charset=utf8, txIsolation=3, autocommit=true, attachment=dn2{SELECT *
		FROM test1
		LIMIT 100}, respHandler=io.mycat.backend.mysql.nio.handler.MultiNodeQueryHandler@4d49bbe8, host=192.168.0.205, port=3306, statusSync=null, writeQueue=0, modifiedSQLExecuted=false]
		2020-03-26 21:20:22.978 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.datasource.PhysicalDatasource.releaseChannel(PhysicalDatasource.java:633)) - release channel MySQLConnection@565121492 [id=32, lastTime=1585228822951, user=root, schema=db2, old shema=db2, borrowed=true, fromSlaveDB=true, threadId=8, charset=utf8, txIsolation=3, autocommit=true, attachment=null, respHandler=null, host=192.168.0.205, port=3306, statusSync=null, writeQueue=0, modifiedSQLExecuted=false]
		2020-03-26 21:20:22.978 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.mysql.nio.handler.MultiNodeQueryHandler.okResponse(MultiNodeQueryHandler.java:289)) - received ok response ,executeResponse:false from MySQLConnection@1147109347 [id=37, lastTime=1585228822951, user=root, schema=db1, old shema=db1, borrowed=true, fromSlaveDB=true, threadId=10, charset=utf8, txIsolation=3, autocommit=true, attachment=dn1{SELECT *
		FROM test1
		LIMIT 100}, respHandler=io.mycat.backend.mysql.nio.handler.MultiNodeQueryHandler@4d49bbe8, host=192.168.0.205, port=3306, statusSync=io.mycat.backend.mysql.nio.MySQLConnection$StatusSync@68cc5e2e, writeQueue=0, modifiedSQLExecuted=false]
		2020-03-26 21:20:22.978 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.mysql.nio.handler.MultiNodeQueryHandler.rowEofResponse(MultiNodeQueryHandler.java:392)) - io.mycat.backend.mysql.nio.handler.MultiNodeQueryHandler@4d49bbe8on row end reseponse MySQLConnection@1147109347 [id=37, lastTime=1585228822951, user=root, schema=db1, old shema=db1, borrowed=true, fromSlaveDB=true, threadId=10, charset=utf8, txIsolation=3, autocommit=true, attachment=dn1{SELECT *
		FROM test1
		LIMIT 100}, respHandler=io.mycat.backend.mysql.nio.handler.MultiNodeQueryHandler@4d49bbe8, host=192.168.0.205, port=3306, statusSync=io.mycat.backend.mysql.nio.MySQLConnection$StatusSync@68cc5e2e, writeQueue=0, modifiedSQLExecuted=false]  false  2
		2020-03-26 21:20:22.978 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.server.NonBlockingSession.releaseConnection(NonBlockingSession.java:386)) - release connection MySQLConnection@1147109347 [id=37, lastTime=1585228822951, user=root, schema=db1, old shema=db1, borrowed=true, fromSlaveDB=true, threadId=10, charset=utf8, txIsolation=3, autocommit=true, attachment=dn1{SELECT *
		FROM test1
		LIMIT 100}, respHandler=io.mycat.backend.mysql.nio.handler.MultiNodeQueryHandler@4d49bbe8, host=192.168.0.205, port=3306, statusSync=io.mycat.backend.mysql.nio.MySQLConnection$StatusSync@68cc5e2e, writeQueue=0, modifiedSQLExecuted=false]
		2020-03-26 21:20:22.978 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.datasource.PhysicalDatasource.releaseChannel(PhysicalDatasource.java:633)) - release channel MySQLConnection@1147109347 [id=37, lastTime=1585228822951, user=root, schema=db1, old shema=db1, borrowed=true, fromSlaveDB=true, threadId=10, charset=utf8, txIsolation=3, autocommit=true, attachment=null, respHandler=null, host=192.168.0.205, port=3306, statusSync=null, writeQueue=0, modifiedSQLExecuted=false]
		2020-03-26 21:20:22.978 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.mysql.nio.handler.MultiNodeQueryHandler.rowEofResponse(MultiNodeQueryHandler.java:392)) - io.mycat.backend.mysql.nio.handler.MultiNodeQueryHandler@4d49bbe8on row end reseponse MySQLConnection@228921117 [id=4, lastTime=1585228822951, user=root, schema=db1, old shema=db1, borrowed=true, fromSlaveDB=false, threadId=646, charset=utf8, txIsolation=3, autocommit=true, attachment=dn5{SELECT *
		FROM test1
		LIMIT 100}, respHandler=io.mycat.backend.mysql.nio.handler.MultiNodeQueryHandler@4d49bbe8, host=192.168.0.202, port=3306, statusSync=null, writeQueue=0, modifiedSQLExecuted=false]  false  1
		2020-03-26 21:20:22.979 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.server.NonBlockingSession.releaseConnection(NonBlockingSession.java:386)) - release connection MySQLConnection@228921117 [id=4, lastTime=1585228822951, user=root, schema=db1, old shema=db1, borrowed=true, fromSlaveDB=false, threadId=646, charset=utf8, txIsolation=3, autocommit=true, attachment=dn5{SELECT *
		FROM test1
		LIMIT 100}, respHandler=io.mycat.backend.mysql.nio.handler.MultiNodeQueryHandler@4d49bbe8, host=192.168.0.202, port=3306, statusSync=null, writeQueue=0, modifiedSQLExecuted=false]
		2020-03-26 21:20:22.979 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.datasource.PhysicalDatasource.releaseChannel(PhysicalDatasource.java:633)) - release channel MySQLConnection@228921117 [id=4, lastTime=1585228822951, user=root, schema=db1, old shema=db1, borrowed=true, fromSlaveDB=false, threadId=646, charset=utf8, txIsolation=3, autocommit=true, attachment=null, respHandler=null, host=192.168.0.202, port=3306, statusSync=null, writeQueue=0, modifiedSQLExecuted=false]
		2020-03-26 21:20:22.979 DEBUG [BusinessExecutor2] (io.mycat.sqlengine.mpp.DataMergeService.getResults(DataMergeService.java:307)) - prepare mpp merge result for select * from test1
		2020-03-26 21:20:22.980 DEBUG [BusinessExecutor2] (io.mycat.backend.mysql.nio.handler.MultiNodeQueryHandler.outputMergeResult(MultiNodeQueryHandler.java:652)) - last packet id:10

	
8. 注意事项:
	配置读写分离完成后, 要重启 Mycat 
	

9. 在读写分离中测试Mycat对事务的支持
	参考笔记 《对事务的支持.sql》
