
怎么处理过期读问题
	
	这些方案包括：
	
		
		强制走主库方案；
		sleep 方案；
		判断主备无延迟方案；
		配合 semi-sync 方案；
		等主库位点方案；
		等 GTID 方案。




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
		
		
配合 semi-sync 方案
	
	
	semi-sync 配合判断主备无延迟的方案，存在两个问题：
	
		1. 一主多从的时候，在某些从库执行查询请求会存在过期读的现象；
			
			如果查询是落在这个响应了 ack 的从库上，是能够确保读到最新数据；
			但如果是查询落到其他从库上，它们可能还没有收到最新的日志，就会产生过期读的问题。
			
		2. 在持续延迟的情况下，可能出现过度等待的问题。
		
		
等主库位点方案
	
mysql> show master status\G;

*************************** 1. row ***************************
             File: mysql-bin.000267
         Position: 226
     Binlog_Do_DB: 
 Binlog_Ignore_DB: 
Executed_Gtid_Set: 56e3abc1-a3e7-11ea-8d96-484d7ea518b9:1-7536598
1 row in set (0.01 sec)

	
select master_pos_wait(file, pos[, timeout]);

select master_pos_wait('mysql-bin.000267', 226, 1);




按照我们设定不允许过期读的要求，就只有两种选择：
	一种是超时放弃
	一种是转到主库查询。
	具体怎么选择，就需要业务开发同学做好限流策略了。
	


等 GTID 方案

	select wait_for_executed_gtid_set(gtid_set, 1);
	
	
	
	
	
show global variables like '%session_track_gtids%';

mysql> show global variables like '%session_track_gtids%';
+---------------------+-------+
| Variable_name       | Value |
+---------------------+-------+
| session_track_gtids | OFF   |
+---------------------+-------+
1 row in set (0.01 sec)































	
	