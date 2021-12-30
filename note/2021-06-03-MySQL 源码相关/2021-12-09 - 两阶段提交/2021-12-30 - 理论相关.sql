
binlog 是Server层的， Redo log是InnoDB存储引擎层的， 是两个互不想干的逻辑，为了让它们保持逻辑上的一致，因此需要两阶段提交，把Redo log的写入操作拆分成 redo log prepare 和 commit 这2个阶段。
先写redo log 后写 binlog，或者先写 binlog 后写 redo log，都会存在问题。



两阶段提交  prepare commit     

----------------------------------------------------------------------------------------------------------------------------------------------



innobase_xa_prepare	是InnoDB存储引擎实现的XA规范的prepare接口：


	当处于Prepare阶段时，调用 innobase_xa_prepare 函数会将 TRX_UNDO_STATE 字段的值设置为 TRX_UNDO_PREPARED（整数5），表明当前事务处在Prepare阶段

	当处于Prepare阶段时，调用 innobase_xa_prepare 函数会将 TRX_UNDO_XID_EXISTS 设置为TRUE，并将本次内部XA事务的xid（这个xid是MySQL自己生成的）写入XID信息处。
	
	https://mp.weixin.qq.com/s/fZhHBMV_jIY2vYOQZiDIhw



MySQL 采用了如下的过程实现内部 XA 的两阶段提交：

	Prepare 阶段：
		InnoDB 将回滚段设置为 prepare 状态；
		将 redolog 写文件并刷盘；
	
	Commit 阶段：
		Binlog 写入文件；
		binlog 刷盘；
		InnoDB commit；
	
	
	http://mysql.taobao.org/monthly/2020/05/07/	
	
	Commit阶段：先将事务执行过程中产生的binlog刷新到硬盘，再执行存储引擎的提交工作。




组提交在prepare的基础上进行  flush  sync commit




binlog提交的三个阶段

	flush阶段（将redo刷入redo log并刷盘<由参数innodb_flush_logs_at_trx_commit决定>），写入binlog文件<只是写入到os的缓存中>
	sync阶段（调用fsync，将binlog刷入文件落盘）
	commit阶段（引擎层完成数据提交，并将binlog信息写入redo log）
	
	-- 出处是哪里？
		半同步复制after_sync模式下的一则客户端断开问题分析


Flush 阶段
	
	http://mysql.taobao.org/monthly/2020/05/07/
	
	change_stage 后 leader 线程进入到 flush 阶段，leader 线程获得 LOCK_log 锁，然后执行 MYSQL_BIN_LOG::process_flush_stage_queue 函数：

	int MYSQL_BIN_LOG::process_flush_stage_queue(my_off_t *total_bytes_var,
												 bool *rotate_var,
												 THD **out_queue_var) {
	  my_off_t total_bytes = 0;

	  leader 线程在这里取出了当前的 flush queue，将 flush queue 重置为空
	  这个时刻之后进入 ordered_commit 的第一个线程会在 change_stage 里面成为 leader
	  但是会在 change_stage 里等待当前线程释放 flush 阶段的 lock
	  因此，当前执行 flush 的时候，新的 flush queue 中会不断积累多个 follower thd
	  THD *first_seen = stage_manager.fetch_queue_for(Stage_manager::FLUSH_STAGE);

		-- redo log 批量刷盘 
	  log_buffer_flush_to_disk 将 innodb 中 prepared 状态的事务刷入 redolog
	  即，这些事务已经填充了 mtr，并已经申请 logbuffer 的位置了
	  通知 log_writer 线程和 log_flusher 线程将 redolog 刷到指定 LSN
	  ha_flush_logs(true);
	  
	  -- binlog 批量刷盘 
	  /* Flush thread caches to binary log. */
	  for (THD *head = first_seen; head; head = head->next_to_commit) {
		 队列中每一个 thd 都进行 cache 刷盘
		 每个线程有两个 binlog cache，分别对应事务型 event 和非事务型 event
		std::pair<int, my_off_t> result = flush_thread_caches(head);
		 更新总共的写入bytes
		total_bytes += result.second;
	  }

	  *out_queue_var = first_seen;
	  *total_bytes_var = total_bytes;

	  如果 binlog 文件超过了 max_size，则准备 rotate binlog，设置 rotate_var=true
	  if (total_bytes > 0 &&
		  (m_binlog_file->get_real_file_size() >= (my_off_t)max_size ||
		   DBUG_EVALUATE_IF("simulate_max_binlog_size", true, false)))
		*rotate_var = true;
	}



binlog 组提交逻辑的主要函数是 MYSQL_BIN_LOG::ordered_commit ，此时引擎层事务已经 prepare，但是还没有写 redolog，并发情况下多个线程将不断涌入这个函数中。

ordered_commit 函数明确地分为了三个阶段，组提交过程中，每个阶段的进入都要调用 MYSQL_BIN_LOG::change_stage 函数。

	http://mysql.taobao.org/monthly/2020/05/07/



MYSQL_BIN_LOG::ordered_commit 的3个阶段

  -- 将事务刷新到二进制日志 
  /*
    Stage #1: flushing transactions to binary log

    While flushing, we allow new threads to enter and will process
    them in due time. Once the queue was empty, we cannot reap
    anything more since it is possible that a thread entered and
    appointed itself leader for the flush phase.
  */
  
  
  -- 将二进制日志文件同步到磁盘
  /*
    Stage #2: Syncing binary log file to disk
  */

	
  -- 按顺序提交所有事务	
  /*
    Stage #3: Commit all transactions in order.

    This stage is skipped if we do not need to order the commits and
    each thread have to execute the handlerton commit instead.

    Howver, since we are keeping the lock from the previous stage, we
    need to unlock it if we skip the stage.

    We must also step commit_clock before the ha_commit_low() is called
    either in ordered fashion(by the leader of this stage) or by the tread
    themselves.

    We are delaying the handling of sync error until
    all locks are released but we should not enter into
    commit stage if binlog_error_action is ABORT_SERVER.
  */
  
  








insert 语句函数调用栈
		
	DROP TABLE IF EXISTS `t`;
	CREATE TABLE `t` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('1', '1', '1');
	INSERT INTO `t` (`id`, `c`, `d`) VALUES ('3', '3', '3');

	mysql> select * from t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  1 |    1 |    1 |
	|  3 |    3 |    3 |
	+----+------+------+
	2 rows in set (0.00 sec)




	b page_cur_insert_rec_write_log



	INSERT INTO `t` (`c`, `d`) VALUES ('5', '5');

	update t set d=100 where id=1;



	b page_cur_insert_rec_write_log



	(gdb) c
	Continuing.
	[Switching to Thread 0x7f4c700c6700 (LWP 16720)]

	Breakpoint 2, page_cur_insert_rec_write_log (insert_rec=0x7f4c64d2c0c4 "\200", rec_size=35, cursor_rec=0x7f4c64d2c0a1 "\200", index=0x7f4c6c977650, mtr=0x7f4c700c2b20) at /usr/local/mysql/storage/innobase/page/page0cur.cc:964
	964		if (dict_table_is_temporary(index->table)) {
	(gdb) bt
	#0  page_cur_insert_rec_write_log (insert_rec=0x7f4c64d2c0c4 "\200", rec_size=35, cursor_rec=0x7f4c64d2c0a1 "\200", index=0x7f4c6c977650, mtr=0x7f4c700c2b20) at /usr/local/mysql/storage/innobase/page/page0cur.cc:964
	#1  0x000000000199522b in page_cur_insert_rec_low (current_rec=0x7f4c64d2c0a1 "\200", index=0x7f4c6c977650, rec=0x7f4c6c9780f6 "\200", offsets=0x7f4c700c2800, mtr=0x7f4c700c2b20) at /usr/local/mysql/storage/innobase/page/page0cur.cc:1531
	#2  0x0000000001b181a8 in page_cur_tuple_insert (cursor=0x7f4c700c2708, tuple=0x7f4c6c02e670, index=0x7f4c6c977650, offsets=0x7f4c700c3040, heap=0x7f4c700c3048, n_ext=0, mtr=0x7f4c700c2b20, use_cache=false) at /usr/local/mysql/storage/innobase/include/page0cur.ic:280
	#3  0x0000000001b212a3 in btr_cur_optimistic_insert (flags=0, cursor=0x7f4c700c2700, offsets=0x7f4c700c3040, heap=0x7f4c700c3048, entry=0x7f4c6c02e670, rec=0x7f4c700c3038, big_rec=0x7f4c700c3050, n_ext=0, thr=0x7f4c6c972a60, mtr=0x7f4c700c2b20)
		at /usr/local/mysql/storage/innobase/btr/btr0cur.cc:3218
	#4  0x00000000019f0380 in row_ins_clust_index_entry_low (flags=0, mode=2, index=0x7f4c6c977650, n_uniq=1, entry=0x7f4c6c02e670, n_ext=0, thr=0x7f4c6c972a60, dup_chk_only=false) at /usr/local/mysql/storage/innobase/row/row0ins.cc:2607
	#5  0x00000000019f2281 in row_ins_clust_index_entry (index=0x7f4c6c977650, entry=0x7f4c6c02e670, thr=0x7f4c6c972a60, n_ext=0, dup_chk_only=false) at /usr/local/mysql/storage/innobase/row/row0ins.cc:3293
	#6  0x00000000019f2780 in row_ins_index_entry (index=0x7f4c6c977650, entry=0x7f4c6c02e670, thr=0x7f4c6c972a60) at /usr/local/mysql/storage/innobase/row/row0ins.cc:3429
	#7  0x00000000019f2cc0 in row_ins_index_entry_step (node=0x7f4c6c9727d0, thr=0x7f4c6c972a60) at /usr/local/mysql/storage/innobase/row/row0ins.cc:3579
	#8  0x00000000019f3020 in row_ins (node=0x7f4c6c9727d0, thr=0x7f4c6c972a60) at /usr/local/mysql/storage/innobase/row/row0ins.cc:3717
	#9  0x00000000019f3484 in row_ins_step (thr=0x7f4c6c972a60) at /usr/local/mysql/storage/innobase/row/row0ins.cc:3853
	#10 0x0000000001a11357 in row_insert_for_mysql_using_ins_graph (mysql_rec=0x7f4c6c02db70 "\371\004", prebuilt=0x7f4c6c9721f0) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:1738
	#11 0x0000000001a118c5 in row_insert_for_mysql (mysql_rec=0x7f4c6c02db70 "\371\004", prebuilt=0x7f4c6c9721f0) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:1859
	#12 0x00000000018bf0b0 in ha_innobase::write_row (this=0x7f4c6c02d880, record=0x7f4c6c02db70 "\371\004") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:7598
	#13 0x0000000000f367b1 in handler::ha_write_row (this=0x7f4c6c02d880, buf=0x7f4c6c02db70 "\371\004") at /usr/local/mysql/sql/handler.cc:8062
	#14 0x0000000001758940 in write_record (thd=0x7f4c6c00a440, table=0x7f4c6c976b80, info=0x7f4c700c41c0, update=0x7f4c700c4240) at /usr/local/mysql/sql/sql_insert.cc:1873
	#15 0x0000000001755b08 in Sql_cmd_insert::mysql_insert (this=0x7f4c6c0101a8, thd=0x7f4c6c00a440, table_list=0x7f4c6c00f9c8) at /usr/local/mysql/sql/sql_insert.cc:769
	#16 0x000000000175c3ef in Sql_cmd_insert::execute (this=0x7f4c6c0101a8, thd=0x7f4c6c00a440) at /usr/local/mysql/sql/sql_insert.cc:3118
	#17 0x0000000001535155 in mysql_execute_command (thd=0x7f4c6c00a440, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3596
	#18 0x000000000153a849 in mysql_parse (thd=0x7f4c6c00a440, parser_state=0x7f4c700c5690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#19 0x00000000015302d8 in dispatch_command (thd=0x7f4c6c00a440, com_data=0x7f4c700c5df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#20 0x000000000152f20c in do_command (thd=0x7f4c6c00a440) at /usr/local/mysql/sql/sql_parse.cc:1025
	#21 0x000000000165f7c8 in handle_connection (arg=0x56bff70) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x4c7ce80) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#23 0x00007f4c7d591ea5 in start_thread () from /lib64/libpthread.so.0
	#24 0x00007f4c7c4579fd in clone () from /lib64/libc.so.6


https://www.jianshu.com/writer#/notebooks/37013486/notes/50142567





	-- flush 阶段没有刷盘吗


