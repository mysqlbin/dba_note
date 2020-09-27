
1. 前言
	InnoDB 的行锁是在语句运行期间就已经获取，因此如果多个事务同时进入了提交流程(prepare阶段)，在InnoDB层提交释放InnoDB行锁资源之前各个事务之间肯定是没有行冲突的，因此可以在从库端并行执行。
	
	在基于 COMMIT_ORDER 的并行复制中，last commit 和 seq_number 正是基于这种思想生成的， 如果 last_commit 相同（即处于同一组）则视为可以在从库并行回放。
	
	基于 writeset 的并行复制中， last commit 将会在 writeset 的影响下继续降低， 来使从库获取更好的并行回放效果，实际上它也是以 commit_order 为基础的。
	
	
2. COMMIT_ORDER 的特点
	
	每次事务提交 seq_number 将会加1，并且 seq_number 是递增的
	last commit 在前面的 binlog 准备阶段就赋值给了每个事务
	last commit 是前一个commit队列的最大 seq number
	
3. MySQL 5.7-5.7.21版本的并行复制策略
	1. 同时处于 prepare 状态的事务，在备库执行时是可以并行的；
	2. 处于 prepare 状态的事务，与处于 commit 状态的事务之间，在备库执行时也是可以并行的。

	3. 具体实现机制：
       1. 在一组里面一起提交的事务，有一个相同的 commit_id 即 last commit，下一组就是 commit_id+1；
       2. commit_id 直接写到 binlog 里面；     
       3. 传到备库应用的时候，相同 commit_id 的事务分发到多个 worker 执行；
       4. 这一组全部执行完成后，coordinator 再去取下一批。
	   5. coordinator：作为分发器，负责 读取中转日志(relay log)和分发事务给不同的worker; 
		
4. Waiting for semi-sync ACK from slave
	如果 rpl_semi_sync_master_wait_point 参数设置为  after_commit, 这里将会进行 ACK 确认，可以看到实际的 InnoDB 层提交操作已经完成了， 等待期间
状态为 Waiting for semi-sync ACK from slave


5. 基于 commit_order 的并行复制如果数据库压力不大的情况下可能出现每个队列都只有一个事务的情况，这种情况就不能在从库
并行回放了，但是基于 writeset 的并行复制却可以改变这种情况。


6. 大事务
	大事务的 event 会在提交时刻一次性的写入到 binlog, 如果 commit 队列中包含了大事务，那么必然会堵塞本队列中的其它事务提交，后续的提交操作也不能完成。


7. last_committed 和 sequence_number 的初始值
	shell> mysqlbinlog --no-defaults mysql-bin.000355 |grep last_commit
	#191015 18:49:11 server id 17  end_log_pos 259 CRC32 0xac687d83 	Anonymous_GTID	last_committed=0	sequence_number=1	rbr_only=yes
	
	解析主库binlog，查看组提交的分组情况， 发现 last_commit 的默认值是0，sequence_number 的初始值是1.
	
	
8. 参数 binlog_order_commits
	主要用于保证 InnoDB 层提交顺序和 MySQL 层提交一致，该参数默认开启
	

9. MySQL 层事务提交流程
	prepare 阶段
	flush 阶段
	sync 阶段
	commit 阶段
	
	
	
	


 