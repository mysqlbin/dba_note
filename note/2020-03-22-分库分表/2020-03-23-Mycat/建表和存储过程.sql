
1. 在逻辑库下建表
2. 每个分片都需要创建存储过程
3. 相关参考


1. 在逻辑库下建表
	mycat_user@mysqldb 23:42:  [mycat_db]> /*!mycat: sql=select 1 from 表 */create table ttt(id int);
	ERROR 1064 (HY000): can t find table define in schema 表 schema:mycat_db



	mycat_user@mysqldb 00:24:  [mycat_db]> /*!mycat: sql=select 1 from ttt */create table ttt(id int);
	ERROR 1064 (HY000): can t find table define in schema TTT schema:mycat_db

	mycat_user@mysqldb 00:24:  [mycat_db]> /*!mycat: sql=select 1 from test1 */create table ttt(id int);
	ERROR 1064 (HY000): can t find table define in schema TTT schema:mycat_db



	mycat_user@mysqldb 00:25:  [mycat_db]> create table ttt(id int);
	ERROR 1064 (HY000): op table not in schema----TTT

	小结:
	
		每个分片都需要创建表
		
		
2. 每个分片都需要创建存储过程
	
	DROP PROCEDURE IF EXISTS `test_proc`;
	DELIMITER;; 
	create PROCEDURE  test_proc(
	)
	begin
	 
		select name FROM `user` where id=2;

	end;;
	DELIMITER ;

	call test_proc();

	
	在逻辑库下建存储过程:
		/*!mycat: sql=select 1 from user */ call test_proc()

		mycat_user@mysqldb 01:01:  [mycat_db]> /*!mycat: sql=select 1 from user */ call test_proc();
		ERROR 1105 (HY000): PROCEDURE db1.test_proc does not exist


	在逻辑库下调用存储过程
		mycat_user@mysqldb 01:01:  [mycat_db]> call test_proc();
		+------+
		| name |
		+------+
		| lisi |
		+------+
		1 row in set (0.00 sec)

		^C^C -- query aborted
		^[[A^C^C -- query aborted
		^C^C -- query aborted
		^C^C -- query aborted
		^C^C -- query aborted
		^C^C -- query aborted
		^C^C -- query aborted
		^C^C -- query aborted
		^C^C -- query aborted
		^C^C -- query aborted
		^C^C -- query aborted
		^C^C -- query aborted
		^C^C -- query aborted

		
		tail -f mycat.log
			2020-03-31 15:02:53.614 DEBUG [Timer1] (io.mycat.sqlengine.SQLJob.connectionAcquired(SQLJob.java:89)) - con query sql:select user() to con:MySQLConnection@1735678510 [id=3, lastTime=1585638173614, user=root, schema=db1, old shema=db1, borrowed=true, fromSlaveDB=false, threadId=1131, charset=utf8, txIsolation=3, autocommit=true, attachment=null, respHandler=null, host=192.168.0.202, port=3306, statusSync=null, writeQueue=0, modifiedSQLExecuted=false]
			2020-03-31 15:02:53.615 DEBUG [Timer1] (io.mycat.sqlengine.SQLJob.connectionAcquired(SQLJob.java:89)) - con query sql:show slave status to con:MySQLConnection@1361331392 [id=14, lastTime=1585638173615, user=root, schema=db1, old shema=db1, borrowed=true, fromSlaveDB=false, threadId=493, charset=utf8, txIsolation=3, autocommit=true, attachment=null, respHandler=null, host=192.168.0.201, port=3306, statusSync=null, writeQueue=0, modifiedSQLExecuted=false]
			2020-03-31 15:02:53.616 DEBUG [Timer1] (io.mycat.sqlengine.SQLJob.connectionAcquired(SQLJob.java:89)) - con query sql:show slave status to con:MySQLConnection@1187229633 [id=34, lastTime=1585638173616, user=root, schema=db1, old shema=db1, borrowed=true, fromSlaveDB=false, threadId=555, charset=utf8, txIsolation=3, autocommit=true, attachment=null, respHandler=null, host=192.168.0.205, port=3306, statusSync=null, writeQueue=0, modifiedSQLExecuted=false]
			2020-03-31 15:02:53.617 DEBUG [Timer1] (io.mycat.sqlengine.SQLJob.connectionAcquired(SQLJob.java:89)) - con query sql:show slave status to con:MySQLConnection@2000541455 [id=33, lastTime=1585638173616, user=root, schema=db1, old shema=db1, borrowed=true, fromSlaveDB=true, threadId=552, charset=utf8, txIsolation=3, autocommit=true, attachment=null, respHandler=null, host=192.168.0.205, port=3306, statusSync=null, writeQueue=0, modifiedSQLExecuted=false]
			2020-03-31 15:02:53.617 DEBUG [Timer1] (io.mycat.sqlengine.SQLJob.connectionAcquired(SQLJob.java:89)) - con query sql:select user() to con:MySQLConnection@1710167297 [id=28, lastTime=1585638173617, user=root, schema=db4, old shema=db4, borrowed=true, fromSlaveDB=false, threadId=523, charset=utf8, txIsolation=3, autocommit=true, attachment=null, respHandler=null, host=192.168.0.203, port=3306, statusSync=null, writeQueue=0, modifiedSQLExecuted=false]
			2020-03-31 15:02:53.621 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.datasource.PhysicalDatasource.releaseChannel(PhysicalDatasource.java:633)) - release channel MySQLConnection@1187229633 [id=34, lastTime=1585638173612, user=root, schema=db1, old shema=db1, borrowed=true, fromSlaveDB=false, threadId=555, charset=utf8, txIsolation=3, autocommit=true, attachment=null, respHandler=null, host=192.168.0.205, port=3306, statusSync=null, writeQueue=0, modifiedSQLExecuted=false]
			2020-03-31 15:02:53.622 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.datasource.PhysicalDatasource.releaseChannel(PhysicalDatasource.java:633)) - release channel MySQLConnection@1710167297 [id=28, lastTime=1585638173612, user=root, schema=db4, old shema=db4, borrowed=true, fromSlaveDB=false, threadId=523, charset=utf8, txIsolation=3, autocommit=true, attachment=null, respHandler=null, host=192.168.0.203, port=3306, statusSync=null, writeQueue=0, modifiedSQLExecuted=false]
			2020-03-31 15:02:53.623 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.datasource.PhysicalDatasource.releaseChannel(PhysicalDatasource.java:633)) - release channel MySQLConnection@1361331392 [id=14, lastTime=1585638173612, user=root, schema=db1, old shema=db1, borrowed=true, fromSlaveDB=false, threadId=493, charset=utf8, txIsolation=3, autocommit=true, attachment=null, respHandler=null, host=192.168.0.201, port=3306, statusSync=null, writeQueue=0, modifiedSQLExecuted=false]
			2020-03-31 15:02:53.624 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.datasource.PhysicalDatasource.releaseChannel(PhysicalDatasource.java:633)) - release channel MySQLConnection@2000541455 [id=33, lastTime=1585638173612, user=root, schema=db1, old shema=db1, borrowed=true, fromSlaveDB=true, threadId=552, charset=utf8, txIsolation=3, autocommit=true, attachment=null, respHandler=null, host=192.168.0.205, port=3306, statusSync=null, writeQueue=0, modifiedSQLExecuted=false]
			2020-03-31 15:02:53.625 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.datasource.PhysicalDatasource.releaseChannel(PhysicalDatasource.java:633)) - release channel MySQLConnection@1735678510 [id=3, lastTime=1585638173612, user=root, schema=db1, old shema=db1, borrowed=true, fromSlaveDB=false, threadId=1131, charset=utf8, txIsolation=3, autocommit=true, attachment=null, respHandler=null, host=192.168.0.202, port=3306, statusSync=null, writeQueue=0, modifiedSQLExecuted=false]
			2020-03-31 15:02:56.596 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.net.FrontendConnection.query(FrontendConnection.java:337)) - ServerConnection [id=1, schema=mycat_db, host=127.0.0.1, user=mycat_user,txIsolation=3, autocommit=true, schema=mycat_db, executeSql=SELECT DATABASE()] call test_proc()
			2020-03-31 15:02:56.596 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.server.ServerQueryHandler.query(ServerQueryHandler.java:70)) - ServerConnection [id=1, schema=mycat_db, host=127.0.0.1, user=mycat_user,txIsolation=3, autocommit=true, schema=mycat_db, executeSql=call test_proc()]call test_proc()
			2020-03-31 15:02:56.661 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.server.NonBlockingSession.execute(NonBlockingSession.java:126)) - ServerConnection [id=1, schema=mycat_db, host=127.0.0.1, user=mycat_user,txIsolation=3, autocommit=true, schema=mycat_db, executeSql=call test_proc()]call test_proc(), route={
			   1 -> dn1{call test_proc()}
			} rrs 
			2020-03-31 15:02:56.663 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.mysql.nio.handler.SingleNodeHandler.execute(SingleNodeHandler.java:186)) - rrs.getRunOnSlave() default
			2020-03-31 15:02:56.663 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.mysql.nio.handler.SingleNodeHandler.execute(SingleNodeHandler.java:188)) - node.getRunOnSlave()  default 
			2020-03-31 15:02:56.663 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.mysql.nio.handler.SingleNodeHandler.execute(SingleNodeHandler.java:198)) - node.getRunOnSlave() null
			2020-03-31 15:02:56.663 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.mysql.nio.handler.SingleNodeHandler.execute(SingleNodeHandler.java:200)) - node.getRunOnSlave() null
			2020-03-31 15:02:56.663 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.datasource.PhysicalDBNode.getConnection(PhysicalDBNode.java:102)) - rrs.getRunOnSlave()  default 
			2020-03-31 15:02:56.663 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.datasource.PhysicalDBNode.getConnection(PhysicalDBNode.java:133)) - rrs.getRunOnSlave()  default 
			2020-03-31 15:02:56.664 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.mysql.nio.MySQLConnection.synAndDoExecute(MySQLConnection.java:503)) - con need syn ,total syn cmd 1 commands SET names utf8;schema change:false con:MySQLConnection@2122015299 [id=15, lastTime=1585638176663, user=root, schema=db1, old shema=db1, borrowed=true, fromSlaveDB=false, threadId=494, charset=utf8, txIsolation=3, autocommit=true, attachment=dn1{call test_proc()}, respHandler=SingleNodeHandler [node=dn1{call test_proc()}, packetId=0], host=192.168.0.201, port=3306, statusSync=io.mycat.backend.mysql.nio.MySQLConnection$StatusSync@7bb2223f, writeQueue=0, modifiedSQLExecuted=true]
			2020-03-31 15:02:56.666 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.server.NonBlockingSession.releaseConnection(NonBlockingSession.java:386)) - release connection MySQLConnection@2122015299 [id=15, lastTime=1585638176656, user=root, schema=db1, old shema=db1, borrowed=true, fromSlaveDB=false, threadId=494, charset=utf8, txIsolation=3, autocommit=true, attachment=dn1{call test_proc()}, respHandler=SingleNodeHandler [node=dn1{call test_proc()}, packetId=4], host=192.168.0.201, port=3306, statusSync=io.mycat.backend.mysql.nio.MySQLConnection$StatusSync@7bb2223f, writeQueue=0, modifiedSQLExecuted=true]
			2020-03-31 15:02:56.666 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.backend.datasource.PhysicalDatasource.releaseChannel(PhysicalDatasource.java:633)) - release channel MySQLConnection@2122015299 [id=15, lastTime=1585638176656, user=root, schema=db1, old shema=db1, borrowed=true, fromSlaveDB=false, threadId=494, charset=utf8, txIsolation=3, autocommit=true, attachment=null, respHandler=null, host=192.168.0.201, port=3306, statusSync=null, writeQueue=0, modifiedSQLExecuted=false]
			2020-03-31 15:02:56.669 ERROR [$_NIOREACTOR-0-RW] (io.mycat.backend.mysql.nio.MySQLConnectionHandler.handleOkPacket(MySQLConnectionHandler.java:158)) - receive OkPacket but not handle

			
	在逻辑库下通过注释调用存储过程

		mycat_user@mysqldb 15:13:  [mycat_db]> /* mycat:dataNode = dn1 */call test_proc();
		+------+
		| name |
		+------+
		| lisi |
		+------+
		1 row in set (0.01 sec)

		^C^C -- query aborted
		^C^C -- query aborted

		虽然能返回数据, 但是会卡死.
		
		
3. 相关参考
	https://blog.csdn.net/baiyangok/article/details/81382056   Mycat下执行存储过程，参数IN、OUT

	https://www.cnblogs.com/double-kill/p/8324217.html
		4、1.6版本的mycat支持存储过程的创建 、调用。｛通过前面加上注解，通过注解里面查询的表来确定要创建或者执行存储过程的库｝。一定要记得去掉存储过程创建语句上的 权限定义部分。
