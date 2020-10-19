

innodb_status_output:

	表示启用或禁用标准InnoDB Monitor(show engine innodb status命令的信息)的定期输出到错误日志中
	默认为关闭状态
	set global innodb_status_output=ON; 
	https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_status_output


innodb_status_output_locks
	
	启用或禁用标准InnoDB lock Monitor的定期输出到错误日志中
	默认为关闭状态
	set global innodb_status_output_locks=ON;
	https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_status_output_locks
	
	
	

其它相关参考
	https://blog.csdn.net/hangxing_2015/article/details/52586335  InnoDB monitor被莫名开启的问题分析
	https://www.jianshu.com/p/21c8510f2217      Innodb: 自动开启打印show engine status到err日志
	https://www.cnblogs.com/wangdong/p/9235249.html  查看锁信息（开启InnoDB监控）
	
小结
	在排查问题的时候，当需要 show engine innodb status的定期信息，可以把 innodb_status_output、innodb_status_output_locks 这两个参数开启。
	
	
InnoDB监控相关的两个参数

    InnoDB有四种监控类型，包括StandardMonitor、LockMonitor、TablespaceMonitor、TableMonitor，其中后面两类监控在5.7版本中被移除，移除后通过information_schema的表获取。
	Standard Monitor监视活动事务持有的表锁、行锁，事务锁等待，线程信号量等待，文件IO请求，buffer pool统计信息，InnoDB主线程purge和change buffer merge活动；
	Lock Monitor提供额外的锁信息。   

	InnoDB的monitor只在需要的时候开启，它会造成性能开销，观察结束后切记关闭监控。

    StandardMonitor开启关闭方法如下：
		innodb_status_output参数就是用来控制InnoDB的monitor开启或关闭的。
		这种开启方法会将监控结果输出到数据目录下的MySQL错误日志中，每隔15秒产生一次输出，这也就是发现错误日志下产生大量输出的原因。

    	set GLOBAL innodb_status_output=ON/OFF;   

    Lock Monitor开启关闭方法如下：
		注意开启前必须先开启innodb_status_output，而关闭时只需要直接关闭innodb_status_output_locks，如果关闭了innodb_status_output，那么Standard Monitor也会被一同关闭。

    	set GLOBAL innodb_status_output=ON;
		
    	set GLOBAL innodb_status_output_locks=ON;


		session A                       session B
		begin; 
		select * from t1 where id=1 lock in share mode;

										begin;
							
										select * from t1 where id=1 for update;
										(Blocked)
		Lock Monitor的信息如下：
		
			------------
			TRANSACTIONS
			------------
			Trx id counter 281474977958482
			Purge done for trxs n:o < 281474977958481 undo n:o < 0 state: running but idle
			History list length 43
			LIST OF TRANSACTIONS FOR EACH SESSION:
			---TRANSACTION 421674540919072, not started
			0 lock struct(s), heap size 1136, 0 row lock(s)
			---TRANSACTION 421674540918160, not started
			0 lock struct(s), heap size 1136, 0 row lock(s)
			---TRANSACTION 421674540917248, not started
			0 lock struct(s), heap size 1136, 0 row lock(s)
			---TRANSACTION 421674540916336, not started
			0 lock struct(s), heap size 1136, 0 row lock(s)
			---TRANSACTION 421674540915424, not started
			0 lock struct(s), heap size 1136, 0 row lock(s)
			---TRANSACTION 281474977958481, ACTIVE 23 sec starting index read
			mysql tables in use 1, locked 1
			LOCK WAIT 2 lock struct(s), heap size 1136, 1 row lock(s)
			MySQL thread id 48, OS thread handle 140192433497856, query id 33396 192.168.0.54 root statistics
			select * from t1 where id=1 for update
			------- TRX HAS BEEN WAITING 23 SEC FOR THIS LOCK TO BE GRANTED:
			RECORD LOCKS space id 4781 page no 5 n bits 552 index PRIMARY of table `db1`.`t1` trx id 281474977958481 lock_mode X locks rec but not gap waiting
			Record lock, heap no 2 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
			 0: len 4; hex 80000001; asc     ;;
			 1: len 6; hex 00000012df40; asc      @;;
			 2: len 7; hex af000000040110; asc        ;;
			 3: len 4; hex 800003e8; asc     ;;
			 4: len 4; hex 80000001; asc     ;;

			------------------
			TABLE LOCK table `db1`.`t1` trx id 281474977958481 lock mode IX
			RECORD LOCKS space id 4781 page no 5 n bits 552 index PRIMARY of table `db1`.`t1` trx id 281474977958481 lock_mode X locks rec but not gap waiting
			Record lock, heap no 2 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
			 0: len 4; hex 80000001; asc     ;;
			 1: len 6; hex 00000012df40; asc      @;;
			 2: len 7; hex af000000040110; asc        ;;
			 3: len 4; hex 800003e8; asc     ;;
			 4: len 4; hex 80000001; asc     ;;

			--------
			FILE I/O
			--------
				

