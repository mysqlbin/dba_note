

1. 数据库压测，发现TPS和QPS一直上不去
	组合1：
		sync_binlog=1;
		innodb_flush_log_at_trx_commit=1;
	组合2：
		sync_binlog=1000;
		innodb_flush_log_at_trx_commit=2;
		
	组合1和组合2，分别在5、10、12线程下压测，TPS和QPS相差不大。
	
	[coding001@voice data_volume]$ sysbench --version
	sysbench 1.0.20
	
	

	sysbench 换成0.5版本的试试，
		-- 目前来看，效果好很多了。
		新的问题：TPS和QPS 没有随着线程数增长而升高。
		
		
			
	
	
	
	
	