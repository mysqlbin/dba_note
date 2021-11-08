

E:\github\mysql-5.7.26\sql\rpl_slave.cc

1. seconds_behind_master=NULL
2. seconds_behind_master的计算方式
3. 延迟现象
4. 相关参考	


1. seconds_behind_master=NULL

	IO线程或者SQL线程没有启动, seconds_behind_master=NULL
	  /*
		 The pseudo code to compute Seconds_Behind_Master:
		 if (SQL thread is running)
		 {
		   if (SQL thread processed all the available relay log)
		   {
			 if (IO thread is running)
				print 0;
			 else
				print NULL;
		   }
			else
			  compute Seconds_Behind_Master;
		  }
		  else
		   print NULL;
	  */


2. seconds_behind_master的计算方式

	long time_diff= ((long)(time(0) 
						   - mi->rli->last_master_timestamp)
						   - mi->clock_diff_with_master);
						   
						 
						 
		(long)(time(0)：  
			
			表示取当前从库服务器的系统时间。
			
		mi->clock_diff_with_master：

			从库服务器的系统时间和主库服务器的系统时间的差值。

		mi->rli->last_master_timestamp：
			
			DML(单线程)：
				rli->last_master_timestamp = ev->common_header->when.tv_sec +
										  (time_t) ev->exec_time;
										  
			DDL(单线程)：
				rli->last_master_timestamp = ev->common_header->when.tv_sec +
										  (time_t) ev->exec_time;								  

			DDL 和 DML 计算延迟的方式是有区别的，区别就在于 exec_time 是否参与运算：
				DDL 中 exec_time 有参与运算。
			
			----------------------------------------------------------------------------------------------
			
			备库sql线程读取了relay log中的event，event未执行之前就会更新 last_master_timestamp ，这里时间的更新是以event为单位。
	
			
			ev->when.tv_sec	表示事件的开始时间。
		
			exec_time 指事件在主库的执行时间，只有 Query_log_event 和 Load_log_event 才会统计exec_time。 
	
		
	根据源码+实验得到seconds_behind_master计算方式的结论：
		
		DML单线程: 
			从服务器时间 - (本DML在主库的执行时间+在从库的执行时间) - 主从服务器时间差
			从服务器时间 - 各个event中header中timestamp的时间 - 主从服务器时间差
			
		
		DDL:       
			从服务器时间 - (本DDL在从库的执行时间) - 主从服务器时间差
			从服务器时间 - ( query_event header 中timestamp的时间 + 本DDL在主库执行的时间(exec_time)) - 主从服务器时间差
		
		
3. 延迟现象
			
	假设主备库执行某个DDL在都需要30s，执行某个大更新事务(例如insert..select * from )需要30s。
	
	DDL:
		
		t2时刻主库执行完，t2时刻备库执行show slave status，Seconds_Behind_Master值为0。同时t2至t3 Seconds_Behind_Master依次增大至30，然后跌0。
		
		从服务器时间 - (本DDL在从库的执行时间) - 主从服务器时间差
			从服务器时间: 2021-11-08 10:00:00
			本DDL在主库的执行时间: 30s
			本DML在从库的执行时间: 30s
			主从服务器时间差： 0s
		
			2021-11-08 10:00:00 - (30) - 0 = 30s
			
	DML:
		
		t2时刻主库执行完，t2时刻备库执行show slave status，Seconds_Behind_Master值为30。同时t2至t3 Seconds_Behind_Master依次增大至60，然后跌0。
		
		从服务器时间 - (本DML在主库的执行时间+在从库的执行时间) - 主从服务器时间差：
		
			从服务器时间: 2021-11-08 10:00:00
			本DML在主库的执行时间: 30s
			本DML在从库的执行时间: 30s
			主从服务器时间差： 0s
			
			2021-11-08 10:00:00 - (30+30) - 0 = 60s
			
		从库slave 执行 show slave status\G;
			-- Seconds_Behind_Master: 47
			-- 验证了DML大事务造成的延迟，其延迟不会从0开始增加，而是直接从主库执行了多久开始。比如主库执行这个事务耗时20秒，那么延迟就从20开始，这是因为query event中没有准确的执行时间，可以参考第8节和第27节。
			-- 从库的延迟时间就从DML事务在主库执行完成的时间开始。
			-- 说明了 Seconds_Behind_Master 不是完全准确.
			-- 同时事务在从库的执行时间为60秒， Seconds_Behind_Master依次增大至80秒，然后跌0。
						
	小结：
	
		Seconds_Behind_Master 的值在DDL导致的延迟中是准确的，是DML大事务导致的延迟中，是不准确的。
		
	
4. 相关参考	
	
	2020-10-21-pt-osc和gh-ost在1主2从的一些实践对比 -> 2020-10-21.sql
	27-从库seconds_behind_master的计算方式
	http://mysql.taobao.org/monthly/2016/03/09/    MySQL · 答疑解惑 · 备库Seconds_Behind_Master计算
	
	《2021-11-08 - delete删除全表数据查看seonds_behind_master的增长情况.sql》
	
	


