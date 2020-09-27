
1. 从库SQL线程的主要功能
2. 从库SQL线程的流程解析
	2.1 如果是 MTS 需要启动工作线程
	2.2 检查 relay_log_info 参数
	2.3 状态 reading event from the relay log
	2.4 如果是MTS，判定是否需要进行 MTS 检查点	
	2.5 判断是否需要切换和清理  relay log
	2.6 获取  last_master_timestamp
	2.7 进行 partial transaction 的恢复
	2.8 sql_slave_skip_counter 参数 		
	2.9 MTS 进行分发,单SQL线程进行应用
	2.10 1032、1062 错误

3. 各大 event 大概做什么
4. 小结	
5. 未完成
			
1. 从库SQL线程的主要功能
	1. 读取 relay log 中的 event 
	2. 应用这些读取到的 event, 将修改作用于从库
	3. 如果是 MTS (并行复制) 通过情况下不会应用 event, SQL线程会蜕变为协调线程, 分发 event 给工作线程.
	
	即 读取中转日志，解析出日志里的命令，并执行。
	
	
2. 从库SQL线程的流程解析

	2.1 如果是 MTS 需要启动工作线程
		每次重新启动 SQL 线程（MTS协调线程）的时候 slave_parallel_workers 参数才会生效，并不是修改了马上生效
		
	2.2 检查 relay_log_info_repository 参数
		这一步会检查 relay_log_info_repository 参数是否设置为 table
		在 position mode 模式下这个参数设置极为重要，因为是否能够启动成功的关键就是 slave_relay_log_info 信息的正确性
		虽然在 gtid auto_position mode 模式下会好很多， 但是依旧建议设置为 table
		如果没有设置为 table, MySQL 就会给出一个警告：
			Warning：If a crash happens thisconfiguration does not guarantee that the relay log info will be consistent
			相关参考： https://www.cnblogs.com/vijayfly/p/5227877.html
			
	2.3 状态 reading event from the relay log
		开始读取 relay log event 的时候会进入状态 reading event from the relay log
	
	2.4 如果是MTS，判定是否需要进行 MTS 检查点
		每次读取一个 event 都会去判断是否需要进行 MTS 的检查点，其条件有两个：
			1. 超过参数 slave_checkpoint_period 的设置
			2. GAQ 队列已满
			
	2.5 判断是否需要切换和清理  relay log
		如果发现 relay log 已满， 则需要进行切换。
		如果这个 evnet 并不是事务的结束，那么是不能切换的，因此常规情况下  relay log 和 binary log 一样是不能跨事务的
		参数 recovery_relay_log = 0 并且从库异常重启的场景下 relay log 可能出现跨事务的情况：
			1. gtid auto_position mode 模式下可能会出现 partial transaction, 会造成额外的回滚操作
			2. position mode           模式下会继续发送事务余下的部分的 event 
			
		in a group 就代表在一个事务中
		recovery_relay_log = on:
			如果读取完了一个非当前 relay log 的 event 会进行清理流程
			如果读取完了当前 relay log， 则不能清理，会等待 IO 线程的唤醒，如果是 MTS 等待唤醒期间还需要进行 MTS 的检查点 
			
	2.6 获取  last_master_timestamp
		
	2.7 进行 partial transaction 的恢复
		下面两种情况可能出现这种情况：
			1. gtid auto_position mode 模式下如果 IO 线程出现重连，dump 线程会根据 gtid set 进行重新定位，重发部分已经发送过的 event 
			2. gtid auto_position mode 模式下如果 从库异常重启，并且 recovery_relay_log = 0 的情况下，dump 线程会根据 gtid 进行重新定位，重发部分已经发送过的 event.
			
		这两种情况下由于一个事务可能包含部分重叠的 event ，就涉及到回滚操作
		对于  MTS 环境来讲是由协调线程进行回滚
		非 MTS 环境则在 gtid event 应用的时候进行回滚。
		
	2.8 sql_slave_skip_counter 参数 
		sql_slave_skip_counter 参数的基本计数单位是 event ，但是如果最后一个 event 正处于事务中的时候，整个事务也会被跳过.
		
		相关参考：
			https://blog.51cto.com/20131104/2390475           sql_slave_skip_counter，你真的用对了吗？
			https://www.cnblogs.com/Uest/p/7941329.html       跳过复制错误——sql_slave_skip_counter
			
		小结： 出现复制错误后，如果使用 sql_slave_skip_counter 跳过一个 event 后，要在业务低峰期通过 pt-table-checksum 进行主从一致性的检验。
		
		虽然主从复制出现的故障成功跳过了，但只是暂时恢复了正常的主从复制状态，需要尽快的对Slave缺失的数据进行补齐，不然Master对Slave不存在的数据做的变更，仍然会重复导致主从复制故障，笔者觉得如果你的数据量差异不是太大的话，可以考虑使用pt-table-checksum和pt-table-sync工具进行恢复，如果你的数据量很大且数据差异很多，还是建议重做Slave较好，因为使用工具会锁表，会对线上业务造成一定的影响

		自己也要做 sql_slave_skip_counter 的实验。
		
	2.9 MTS 进行分发,单SQL线程进行应用
		最后就是拿到这个 event 后怎么进行处理:
			MTS 进行 event 分发, 分发给工作线程进行 event 的应用
			单 SQL 线程进行 event 的应用
			
	2.10 1032、1062 错误
	
3. 各大 event 大概做什么

4. 小结	
	1. 学习了 从库SQL线程的主要功能
	2. 学习了 从库SQL线程的流程解析
	3. 1032、1062 错误 是由 SQL 线程触发的
	4. sql_slave_skip_counter 参数的了解
	
5. 未完成
	
	对比 主库的 event 和 从库 的event 
	https://www.cnblogs.com/yuyue2014/p/6120828.html  MySQL relay_log_purge=0 时的风险
	pt-table-checksum和pt-table-sync 加什么锁？

