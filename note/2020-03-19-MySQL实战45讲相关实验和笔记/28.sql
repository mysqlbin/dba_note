
怎么处理过期读问题的方案包括：
	
	强制走主库方案
	sleep 方案
	判断主备无延迟方案
	semi-sync 配合判断主备无延迟方案
	等主库位点方案
	等 GTID 方案




强制走主库方案


sleep 方案

	mysql> select sleep(1);
	+----------+
	| sleep(1) |
	+----------+
	|        0 |
	+----------+
	1 row in set (1.00 sec)


	比如说延迟一秒再做读取/查询操作。
	
	也存在不精确的问题，这个不精确包含了两层意思：如果这个查询请求本来 0.5 秒就可以在从库上拿到正确结果，也会等 1 秒；如果延迟超过 1 秒，还是会出现过期读。	
	
	
判断主备无延迟方案
	
	存在的问题：
		异步复制，可能有一部分binlog没有发送给从库，导致过期读问题。
		但是 IO 线程的 位点 = SQL 线程的位点。
		
		
semi-sync 配合判断主备无延迟方案
	
	
	semi-sync 配合判断主备无延迟的方案，存在两个问题：
	
		1. 一主多从的时候，在某些从库执行查询请求会存在过期读的现象；
			
			如果查询是落在这个响应了 ack 的从库上，是能够确保读到最新数据；
			但如果是查询落到其他从库上，它们可能还没有收到最新的日志，就会产生过期读的问题。
			
		2. 在持续延迟的情况下，可能出现过度等待的问题。
		
		3. 等主库位点方案 或者 等GTID方案，就可以解决上面的2个问题。-- 是如何解决的？
		
		
等主库位点方案
	
	mysql> show master status\G;

	*************************** 1. row ***************************
				 File: mysql-bin.000267
			 Position: 226
		 Binlog_Do_DB: 
	 Binlog_Ignore_DB: 
	Executed_Gtid_Set: 56e3abc1-a3e7-11ea-8d96-484d7ea518b9:1-7536598
	1 row in set (0.01 sec)

		
	命令： select master_pos_wait(file, pos[, timeout]);

		select master_pos_wait('mysql-bin.000267', 226, 1);
	
	命令的逻辑：
		1. 它是在从库执行的；
		2. 参数 file 和 pos 指的是主库上的文件名和位置；
		3. timeout 可选，设置为正整数 N 表示这个函数最多等待 N 秒。


	这个命令正常返回的结果是一个正整数 M，表示从命令开始执行，到应用完 file 和 pos 表示的 binlog 位置，执行了多少事务。
	当然，除了正常返回一个正整数 M 外，这条命令还会返回一些其他结果，包括：
		如果执行期间，备库同步线程发生异常，则返回 NULL；
		如果等待超过 N 秒，就返回 -1；
		如果刚开始执行的时候，就发现已经执行过这个位置了，则返回 0。
	
	对于图 5 中先执行 trx1，再执行一个查询请求的逻辑，要保证能够查到正确的数据，我们可以使用这个逻辑：
	
		trx1 事务更新完成后，马上执行 show master status 得到当前主库执行到的 File 和 Position；  -- 等GTID方案，不用到主库执行 show master status 获取 GTID，也就是减少了一次查询请求。
		选定一个从库执行查询语句，在从库上执行 select master_pos_wait(File, Position, 1)；
		如果返回值是 >=0 的正整数，则在这个从库执行查询语句；
		否则，到主库执行查询语句。
	

等 GTID 方案

	命令：select wait_for_executed_gtid_set(gtid_set, 1);
	
	命令的逻辑：等待，直到这个库执行的事务中包含传入的 gtid_set，返回 0；超时返回 1。
				-- 就是说 已经执行过的GTID集合中包含传入的GTID，就返回0；超时返回 1.

	等 GTID 的执行流程就变成了：
		trx1 事务更新完成后，从返回包直接获取这个事务的 GTID，记为 gtid1；
		选定一个从库执行查询语句，在从库上执行 select wait_for_executed_gtid_set(gtid1, 1)；
		如果返回值是 0，则在这个从库执行查询语句；
		否则，到主库执行查询语句。
	
	--------------------------------------------------------------------------------------------------------------
	 Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13797-4748980
				Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-4748980,
	90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-1637664

	select wait_for_executed_gtid_set('7664fad8-49fd-11e8-a546-4201c0a8010a:4748980', 1);

	mysql> select wait_for_executed_gtid_set('7664fad8-49fd-11e8-a546-4201c0a8010a:4748980', 1);
	+-------------------------------------------------------------------------------+
	| wait_for_executed_gtid_set('7664fad8-49fd-11e8-a546-4201c0a8010a:4748980', 1) |
	+-------------------------------------------------------------------------------+
	|                                                                             0 |
	+-------------------------------------------------------------------------------+
	1 row in set (0.00 sec)
	
	mysql> select wait_for_executed_gtid_set('7664fad8-49fd-11e8-a546-4201c0a8010a:1-4748980', 1);
	+---------------------------------------------------------------------------------+
	| wait_for_executed_gtid_set('7664fad8-49fd-11e8-a546-4201c0a8010a:1-4748980', 1) |
	+---------------------------------------------------------------------------------+
	|                                                                               0 |
	+---------------------------------------------------------------------------------+
	1 row in set (0.01 sec)


	返回值是0，说明没有延迟。

	--------------------------------------------------------------------------------------------------------------
			   Retrieved_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:13797-4748981
				Executed_Gtid_Set: 7664fad8-49fd-11e8-a546-4201c0a8010a:1-4748981,
	90e79fc1-49fd-11e8-a6dd-4201c0a8010b:1-1637664


	mysql> select wait_for_executed_gtid_set('7664fad8-49fd-11e8-a546-4201c0a8010a:4748982', 1);
	+-------------------------------------------------------------------------------+
	| wait_for_executed_gtid_set('7664fad8-49fd-11e8-a546-4201c0a8010a:4748982', 1) |
	+-------------------------------------------------------------------------------+
	|                                                                             1 |
	+-------------------------------------------------------------------------------+
	1 row in set (1.00 sec)

	返回值非0，说明有延迟。


------------------------------------------------------------------------------------------------------------------


1. 按照我们设定不允许过期读的要求，就只有两种选择：

	一种是超时放弃
	一种是转到主库查询
		但是所有的从库都延迟，那么请求就会全部落到主库上，这时候会不会由于压力突然增大，把主库打挂了呢？
	
2. 在实际应用中，这几个方案是可以混合使用的：
		
	先在客户端对请求做分类，区分哪些请求可以接受过期读，而哪些请求完全不能接受过期读；
		
	然后，对于不能接受过期读的语句，再使用等 GTID 或等位点的方案(超时放弃 或者 转到主库查询)。
	
	具体怎么选择，就需要业务开发同学做好限流策略了。
	


未完成：
	对比各个方案的优缺点
	
	
	
show global variables like '%session_track_gtids%';

mysql> show global variables like '%session_track_gtids%';
+---------------------+-------+
| Variable_name       | Value |
+---------------------+-------+
| session_track_gtids | OFF   |
+---------------------+-------+
1 row in set (0.01 sec)


drop table  if exists t;
CREATE TABLE `t` (
  `nPlayerId` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '昵称',
  PRIMARY KEY (`nPlayerId`),
  KEY `idx_name`(name(2))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `t` VALUES ('1', '卢建斌');
INSERT INTO `t` VALUES ('2', 'ttttttttttttt');

master 和 slave 都执行 set global session_track_gtids="OWN_GTID";


mysql> show global variables like '%session_track_gtids%';
+---------------------+----------+
| Variable_name       | Value    |
+---------------------+----------+
| session_track_gtids | OWN_GTID |
+---------------------+----------+
1 row in set (0.00 sec)

INSERT INTO `t` VALUES ('3', 'ttttttttttttt');
INSERT INTO `t` VALUES ('4', 'ttttttttttttt');


mysql> INSERT INTO `t` VALUES ('3', 'ttttttttttttt');
Query OK, 1 row affected (0.00 sec)


mysql> INSERT INTO `t` VALUES ('4', 'ttttttttttttt');
Query OK, 1 row affected (0.00 sec)


-- 看不到返回的GTID编号












	
	