5.7 组提交优化：
延迟写 redo 到 group commit 阶段

MySQL 5.6 的组提交逻辑中，每个事务各自做 prepare 并写 redo log，只有到了 commit 阶段才进入组提交，因此每个事务的 redolog sync 操作成为性能瓶颈。

在 5.7 版本中，修改了组提交的 flush 阶段，在 prepare 阶段不再让线程各自执行 flush redolog 操作，而是推迟到组提交的 flush 阶段，flush stage 修改成如下逻辑：

	收集组提交队列，得到 leader 线程，其余 follower 线程进入阻塞；
	leader 调用 ha_flush_logs 做一次 redo write/sync，即，一次将所有线程的 redolog 刷盘；
	将队列中 thd 的所有 binlog cache 写到 binlog 文件中。

	-- 在 prepare 阶段不再让线程各自执行 flush redolog 操作？
		但是下面的流程就是说 redo log 在 prepare 阶段就要持久化一次	。			
		-> trx_prepare -> trx_flush_log_if_needed
					
			-> trx_flush_log_if_needed -> trx_flush_log_if_needed_low
				
				-> trx_flush_log_if_needed_low -> log_write_up_to  -> log_group_write_buf  -- 将 redolog 写文件并刷盘； 
				
					如果把 innodb_flush_log_at_trx_commit 设置成 1，那么 redo log 在 prepare 阶段就要持久化一次，因为有一个崩溃恢复逻辑是要依赖于 prepare 的 redo log，再加上 binlog 来恢复的
					在 prepare 阶段， redo log 要先刷盘一次，在 flush 阶段, 再做 redo log 组提交刷盘。	


这个优化是将 redolog 的刷盘延迟到了 binlog group commit 的 flush stage 之中，sync binlog 之前。
通过延迟写 redolog 的方式，为 redolog 做了一次组写入，这样 binlog 和 redolog 都进行了优化。