
[root@mgr9 conf]# cat sequence_db_conf.properties 
#sequence stored in datanode
#GLOBAL=dn1
COMPANY=dn1
CUSTOMER=dn1
ORDERS=dn1

GLOBALS=dn1




mycat_user@mysqldb 19:23:  [mycat_db]> INSERT INTO `test1` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBAL', 'lujb', '2020-03-27');
ERROR 1003 (HY000): mycat sequnce err.io.mycat.config.util.ConfigException: can't find definition for sequence :GLOBALjava

2020-03-26 19:28:15.980 DEBUG [$_NIOREACTOR-0-RW] (io.mycat.server.ServerQueryHandler.query(ServerQueryHandler.java:70)) - ServerConnection [id=1, schema=mycat_db, host=127.0.0.1, user=mycat_user,txIsolation=3, autocommit=true, schema=mycat_db, executeSql=INSERT INTO `test1` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBAL', 'lujb', '2020-03-27')]INSERT INTO `test1` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBAL', 'lujb', '2020-03-27')
2020-03-26 19:28:15.981 ERROR [SequenceExecutor2] (io.mycat.route.MyCATSequnceProcessor.executeSeq(MyCATSequnceProcessor.java:55)) - MyCATSequenceProcessor.executeSeq(SesionSQLPair)
io.mycat.config.util.ConfigException: can't find definition for sequence :GLOBAL
	at io.mycat.route.sequence.handler.IncrSequenceMySQLHandler.nextId(IncrSequenceMySQLHandler.java:91) ~[Mycat-server-1.6.7.4-release.jar:?]
	at io.mycat.route.parser.druid.DruidSequenceHandler.getExecuteSql(DruidSequenceHandler.java:92) ~[Mycat-server-1.6.7.4-release.jar:?]
	at io.mycat.route.MyCATSequnceProcessor.executeSeq(MyCATSequnceProcessor.java:51) ~[Mycat-server-1.6.7.4-release.jar:?]
	at io.mycat.route.util.RouterUtil$1.run(RouterUtil.java:582) ~[Mycat-server-1.6.7.4-release.jar:?]
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149) [?:1.8.0_231]
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624) [?:1.8.0_231]
	at java.lang.Thread.run(Thread.java:748) [?:1.8.0_231]
2020-03-26 19:28:15.981 ERROR [SequenceExecutor2] (io.mycat.net.FrontendConnection.writeErrMessage(FrontendConnection.java:210)) - ServerConnection [id=1, schema=mycat_db, host=127.0.0.1, user=mycat_user,txIsolation=3, autocommit=true, schema=mycat_db, executeSql=INSERT INTO `test1` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBAL', 'lujb', '2020-03-27')]mycat sequnce err.io.mycat.config.util.ConfigException: can't find definition for sequence :GLOBALjava.lang.Thread .getStackTrace1559
io.mycat.net.FrontendConnection .getStack224
io.mycat.net.FrontendConnection .writeErrMessage210
io.mycat.route.MyCATSequnceProcessor .executeSeq56
io.mycat.route.util.RouterUtil$1 .run582
java.util.concurrent.ThreadPoolExecutor .runWorker1149
java.util.concurrent.ThreadPoolExecutor$Worker .run624
java.lang.Thread .run748
 write errorMsg:{} error


 
正确方式:
 INSERT INTO `test1` (`id`, `name`, `CreateTime`) VALUES ('next value for MYCATSEQ_GLOBALS', 'lujb', '2020-03-27');