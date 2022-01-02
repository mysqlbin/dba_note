
1. Prepare 阶段
2. Flush 阶段
3. Sync 阶段
4. Commit 阶段

E:\github\mysql-5.7.26\sql\handler.cc
ha_commit_trans
	
    1. Prepare 阶段
	
		-> MYSQL_BIN_LOG::prepare
			
			-> ha_prepare_low
				
				-> ht->prepare(ht, thd, all) -> binlog_prepare    -- 生成last_commit
				
				-> ht->prepare(ht, thd, all) -> innobase_xa_prepare  -- InnoDB存储引擎的prepare接口
				
					-> innobase_xa_prepare -> thd_get_xid       -- 获取 xid
					
					-> innobase_xa_prepare -> trx_prepare_for_mysql
						
						-> trx_prepare_for_mysql -> trx_prepare
							
							-> trx_prepare -> trx_prepare_low
								
								-> trx_prepare_low -> trx_undo_set_state_at_prepare
								
									修改 undo 页
										
										将 undo 页面段头的 TRX_UNDO_STATE 设置为 TRX_UNDO_PREPARED ， 表明当前事务处在Prepare阶段
										TRX_UNDO_XID_EXISTS 设置为TRUE，并将本次内部XA事务的xid（这个xid是MySQL自己生成的）写入XID信息处(trx_undo_xa_xid)
									
									-- 为什么需要记录undo 
							
							-> trx_prepare -> trx_flush_log_if_needed
										
								-> trx_flush_log_if_needed -> trx_flush_log_if_needed_low
									
									-> trx_flush_log_if_needed_low -> log_write_up_to  -> log_group_write_buf  -- 将 redolog 写文件并刷盘； 
									
										如果把 innodb_flush_log_at_trx_commit 设置成 1，那么 redo log 在 prepare 阶段就要持久化一次，因为有一个崩溃恢复逻辑是要依赖于 prepare 的 redo log，再加上 binlog 来恢复的
										在 prepare 阶段， redo log 要先刷盘一次，在 flush 阶段, 再做 redo log 组提交刷盘。
								
	-- commit 阶段
	
	-> MYSQL_BIN_LOG::commit   -- 入口函数
			
		-> MYSQL_BIN_LOG::ordered_commit
	
	2. Flush 阶段
			-- 执行 flush 阶段
			-> MYSQL_BIN_LOG::process_flush_stage_queue   
				
				-- leader 线程在这里取出了当前的 flush queue，将 flush queue 重置为空  (首先获取队列中的事务组)
				-> MYSQL_BIN_LOG::process_flush_stage_queue -> stage_manager.fetch_queue_for
				
				-- flush redo log， redo 组提交(redo log 批量刷盘) 
				-- leader 调用 ha_flush_logs 做一次 redo write/sync，即，一次将所有线程的 redolog 刷盘；

				-> MYSQL_BIN_LOG::process_flush_stage_queue -> ha_flush_logs
				
					-> ha_flush_logs -> flush_handlerton
					
						-> flush_handlerton -> innobase_flush_logs 	-- 将 InnoDB 重做日志刷新到文件系统。
						
							-> innobase_flush_logs -> log_buffer_flush_to_disk 
							
								-> log_buffer_flush_to_disk -> log_write_up_to  -- 把redo log buffer 中的 redo log 进行刷盘。
								
									-> log_write_up_to -> log_group_write_buf   -- innodb 组提交，确保redo落盘
				
				-- flush binlog，binlog 组提交阶段					
				-> MYSQL_BIN_LOG::process_flush_stage_queue -> MYSQL_BIN_LOG::flush_thread_caches
				
					-> MYSQL_BIN_LOG::flush_thread_caches -> binlog_cache_data::flush    
						-- 这里还不理解。
						-- Flush caches to the binary log.
				
				-- 下面的理解没有问题了。	
				-- 事务ordered_commit 中，会将 thd->cache_mngr 中的 binlog cache 写入到 binlog 文件中，但并没有执行fsync()操作，即只将文件内容写入到 OS 缓存中
				flush_cache_to_file  
					-> my_b_flush_io_cache
						-> inline_mysql_file_write
							-> my_write
					
							
					 DEBUG_SYNC(thd, "waiting_in_the_middle_of_flush_stage");
					  
					  flush_error= process_flush_stage_queue(&total_bytes, &do_rotate,
																	 &wait_queue);

					  if (flush_error == 0 && total_bytes > 0)
						
						----------------------------------------------------------
						
						flush_error= flush_cache_to_file(&flush_end_pos);
						
					  DBUG_EXECUTE_IF("crash_after_flush_binlog", DBUG_SUICIDE(););

					  update_binlog_end_pos_after_sync= (get_sync_period() == 1);

				
				
			3. Sync 阶段
	
				-- 执行 sync 阶段
			    -> MYSQL_BIN_LOG::sync_binlog_file           -- 将产生的 binlog flush 到文件中，即执行 fsync操作.

			
			4. Commit 阶段
			-- commit 提交
			-- 按顺序提交所有事务
			MYSQL_BIN_LOG::process_commit_stage_queue
				-> ha_commit_low     -- storage engine commit  (在存储引擎层进行提交)
					-> innobase_commit
						-> innobase_commit_low
							-> trx_commit_for_mysql
			

---------------------------------------------------------------------------------------------------------------------------------

图中的 write，指的就是指把日志写入到文件系统的 page cache，并没有把数据持久化到磁盘，所以速度比较快。
图中的 fsync，才是将数据持久化到磁盘的操作。一般情况下，我们认为 fsync 才占磁盘的 IOPS。




在binlog的Group Commit的第一阶段FLUSH，会将IO_CACHE以及临时文件中的数据转存到binlog file中；之后truncate 临时文件，但保留IO_CACHE，如下调用栈：

	MYSQL_BIN_LOG::commit
		MYSQL_BIN_LOG::ordered_commit
			MYSQL_BIN_LOG::flush_cache_to_file
				binlog_cache_data::flush
					MYSQL_BIN_LOG::write_cache
					MYSQL_BIN_LOG::do_write_cache
						cache->copy_to(writer) // Binlog_cache_storage cache -> Binlog_event_writer writer


