


0. 初始化表结构和数据

	CREATE TABLE `t` (
		  `id` int(11) NOT NULL,
		  `a` int(11) DEFAULT NULL,
		  `t_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
		  PRIMARY KEY (`id`),
		  KEY `t_modified`(`t_modified`)
		) ENGINE=InnoDB; 
		
		
	insert into t values(5,1,'2018-11-13');
	
1. 打断点找函数调用栈
	
	b lock_rec_insert_check_and_lock
		(gdb) b lock_rec_insert_check_and_lock
		Breakpoint 2 at 0x194c3f5: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 5900.
		(gdb) c
		Continuing.
		[Switching to Thread 0x7f0b601fd700 (LWP 5187)]

		Breakpoint 2, lock_rec_insert_check_and_lock (flags=0, rec=0x7f0b70ba0063 "infimum", block=0x7f0b6fa42c40, index=0x7f0b78024130, thr=0x569d328, mtr=0x7f0b601f9b20, inherit=0x7f0b601f9310) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:5900
		5900		ut_ad(block->frame == page_align(rec));
		(gdb) bt
		#0  lock_rec_insert_check_and_lock (flags=0, rec=0x7f0b70ba0063 "infimum", block=0x7f0b6fa42c40, index=0x7f0b78024130, thr=0x569d328, mtr=0x7f0b601f9b20, inherit=0x7f0b601f9310) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:5900
		#1  0x0000000001b2098c in btr_cur_ins_lock_and_undo (flags=0, cursor=0x7f0b601f9700, entry=0x56ea3b0, thr=0x569d328, mtr=0x7f0b601f9b20, inherit=0x7f0b601f9310) at /usr/local/mysql/storage/innobase/btr/btr0cur.cc:2971
		#2  0x0000000001b2125c in btr_cur_optimistic_insert (flags=0, cursor=0x7f0b601f9700, offsets=0x7f0b601fa040, heap=0x7f0b601fa048, entry=0x56ea3b0, rec=0x7f0b601fa038, big_rec=0x7f0b601fa050, n_ext=0, thr=0x569d328, mtr=0x7f0b601f9b20)
			at /usr/local/mysql/storage/innobase/btr/btr0cur.cc:3210
		#3  0x00000000019f0380 in row_ins_clust_index_entry_low (flags=0, mode=2, index=0x7f0b78024130, n_uniq=1, entry=0x56ea3b0, n_ext=0, thr=0x569d328, dup_chk_only=false) at /usr/local/mysql/storage/innobase/row/row0ins.cc:2607
		#4  0x00000000019f2281 in row_ins_clust_index_entry (index=0x7f0b78024130, entry=0x56ea3b0, thr=0x569d328, n_ext=0, dup_chk_only=false) at /usr/local/mysql/storage/innobase/row/row0ins.cc:3293
		#5  0x00000000019f2780 in row_ins_index_entry (index=0x7f0b78024130, entry=0x56ea3b0, thr=0x569d328) at /usr/local/mysql/storage/innobase/row/row0ins.cc:3429
		#6  0x00000000019f2cc0 in row_ins_index_entry_step (node=0x569d0a0, thr=0x569d328) at /usr/local/mysql/storage/innobase/row/row0ins.cc:3579
		#7  0x00000000019f3020 in row_ins (node=0x569d0a0, thr=0x569d328) at /usr/local/mysql/storage/innobase/row/row0ins.cc:3717
		#8  0x00000000019f3484 in row_ins_step (thr=0x569d328) at /usr/local/mysql/storage/innobase/row/row0ins.cc:3853
		#9  0x0000000001a11357 in row_insert_for_mysql_using_ins_graph (mysql_rec=0x5610890 "\375\005", prebuilt=0x569c840) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:1738
		#10 0x0000000001a118c5 in row_insert_for_mysql (mysql_rec=0x5610890 "\375\005", prebuilt=0x569c840) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:1859
		#11 0x00000000018bf0b0 in ha_innobase::write_row (this=0x56105a0, record=0x5610890 "\375\005") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:7598
		#12 0x0000000000f367b1 in handler::ha_write_row (this=0x56105a0, buf=0x5610890 "\375\005") at /usr/local/mysql/sql/handler.cc:8062
		#13 0x0000000001758940 in write_record (thd=0x5697fa0, table=0x560fbe0, info=0x7f0b601fb1c0, update=0x7f0b601fb240) at /usr/local/mysql/sql/sql_insert.cc:1873
		#14 0x0000000001755b08 in Sql_cmd_insert::mysql_insert (this=0x56a4880, thd=0x5697fa0, table_list=0x56a42e0) at /usr/local/mysql/sql/sql_insert.cc:769
		#15 0x000000000175c3ef in Sql_cmd_insert::execute (this=0x56a4880, thd=0x5697fa0) at /usr/local/mysql/sql/sql_insert.cc:3118
		#16 0x0000000001535155 in mysql_execute_command (thd=0x5697fa0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3596
		#17 0x000000000153a849 in mysql_parse (thd=0x5697fa0, parser_state=0x7f0b601fc690) at /usr/local/mysql/sql/sql_parse.cc:5570
		#18 0x00000000015302d8 in dispatch_command (thd=0x5697fa0, com_data=0x7f0b601fcdf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
		#19 0x000000000152f20c in do_command (thd=0x5697fa0) at /usr/local/mysql/sql/sql_parse.cc:1025
		#20 0x000000000165f7c8 in handle_connection (arg=0x5664890) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
		#21 0x0000000001ce7612 in pfs_spawn_thread (arg=0x559c750) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
		#22 0x00007f0b88305ea5 in start_thread () from /lib64/libpthread.so.0
		#23 0x00007f0b871cb9fd in clone () from /lib64/libc.so.6


		Server层
			mysql_parse -> mysql_execute_command -> Sql_cmd_insert::execute -> Sql_cmd_insert::mysql_insert -> write_record -> handler::ha_write_row 
			
		InnoDB存储引擎层
			ha_innobase::write_row 	
				-> row_insert_for_mysql 
					-> row_insert_for_mysql_using_ins_graph 
						-> row_ins_step -> row_ins 
							-> row_ins_index_entry_step 
								-> row_ins_index_entry -> row_ins_clust_index_entry
									-> row_ins_clust_index_entry_low 
										-> btr_cur_optimistic_insert 
											-> btr_cur_ins_lock_and_undo 
												-> lock_rec_insert_check_and_lock
	

2. 梳理 insert 语句的函数调用堆栈
	btr_cur_ins_lock_and_undo
		-> lock_rec_insert_check_and_lock
			-> lock_rec_other_has_conflicting
				-> lock_rec_has_to_wait
	
	2.1 btr_cur_ins_lock_and_undo
	
		/*************************************************************//**
		For an insert, checks the locks and does the undo logging if desired.
		@return DB_SUCCESS, DB_WAIT_LOCK, DB_FAIL, or error number */


		对于插入，检查锁并写undo日志记录。


	2.2 btr_cur_ins_lock_and_undo -> lock_rec_insert_check_and_lock

		/*
			锁检查入口：
				检查插入的记录是否会被别的事务持有的锁锁住
				如果有被锁住，则处于等待状态
				如果没有，则持有
				
			调用 lock_rec_insert_check_and_lock 函数，用插入意向锁来检查是否需要等待
		*/
		/*********************************************************************//**
		Checks if locks of other transactions prevent an immediate insert of
		a record. If they do, first tests if the query thread should anyway
		be suspended for some reason; if not, then puts the transaction and
		the query thread to the lock wait state and inserts a waiting request
		for a gap x-lock to the lock queue.
		@return DB_SUCCESS, DB_LOCK_WAIT, DB_DEADLOCK, or DB_QUE_THR_SUSPENDED */
		dberr_t
		lock_rec_insert_check_and_lock(
			
			
			-- 将记录插入索引时，必须持有表的 IX 锁。
			/* When inserting a record into an index, the table must be at
			least IX-locked. When we are building an index, we would pass
			BTR_NO_LOCKING_FLAG and skip the locking altogether. */
			ut_ad(lock_table_has(trx, index->table, LOCK_IX));

			-- 在记录上首先获取 explicit lock（显式锁），返回 first lock ，没有则返回null
			lock = lock_rec_get_first(lock_sys->rec_hash, block, heap_no);


			/* If another transaction has an explicit lock request which locks
			the gap, waiting or granted, on the successor, the insert has to wait.

			An exception is the case where the lock by the another transaction
			is a gap type lock which it placed to wait for its turn to insert. We
			do not consider that kind of a lock conflicting with our insert. This
			eliminates an unnecessary deadlock which resulted when 2 transactions
			had to wait for their insert. Both had waiting gap type lock requests
			on the successor, which produced an unnecessary deadlock. */

			const ulint	type_mode = LOCK_X | LOCK_GAP | LOCK_INSERT_INTENTION;

			const lock_t*	wait_for = lock_rec_other_has_conflicting(
						type_mode, block, heap_no, trx);
						



	2.3 btr_cur_ins_lock_and_undo -> lock_rec_insert_check_and_lock -> lock_rec_other_has_conflicting
		
		-- 兼容性矩阵事务在对InnoDB中的数据进行加锁操作时，需要判断是否存在与之冲突的锁，这个过程是通过函数lock_rec_other_has_conflicting来实现的
		
		/*********************************************************************//**
		Checks if some other transaction has a conflicting explicit lock request
		in the queue, so that we have to wait.
		@return lock or NULL */
		static
		const lock_t*
		lock_rec_other_has_conflicting(
		/*===========================*/
			ulint			mode,	/*!< in: LOCK_S or LOCK_X,
							possibly ORed to LOCK_GAP or
							LOC_REC_NOT_GAP,
							LOCK_INSERT_INTENTION */
			const buf_block_t*	block,	/*!< in: buffer block containing
							the record */
			ulint			heap_no,/*!< in: heap number of the record */
			const trx_t*		trx)	/*!< in: our transaction */
		{
			const lock_t*		lock;

			ut_ad(lock_mutex_own());
			
			/*检测要加锁的索引是否为 supremum */

			bool	is_supremum = (heap_no == PAGE_HEAP_NO_SUPREMUM);
		
			/*从锁hash表中去查看对应到此索引记录的锁*/
			for (lock = lock_rec_get_first(lock_sys->rec_hash, block, heap_no);
				 lock != NULL;
				 lock = lock_rec_get_next_const(heap_no, lock)) {
				/*检测检索到的锁结构与此事务要添加的锁是否冲突，如果冲突，会处于锁等待状态 */
				if (lock_rec_has_to_wait(trx, mode, lock, is_supremum)) {
					return(lock);
				}
			}

			return(NULL);
		}


	2.4 btr_cur_ins_lock_and_undo -> lock_rec_insert_check_and_lock -> lock_rec_other_has_conflicting -> lock_rec_has_to_wait

		-- lock_rec_other_has_conflicting 判断冲突->lock_rec_has_to_wait 检测是否需要等待


		-- 通过函数 lock_rec_has_to_wait 去判断同一个索引记录上的锁是否冲突
		
		/*********************************************************************//**
		Checks if a lock request for a new lock has to wait for request lock2.
		@return TRUE if new lock has to wait for lock2 to be removed */  /* 如果新锁必须等待 lock2 被移除，则为 TRUE */
		UNIV_INLINE
		ibool
		lock_rec_has_to_wait(
		/*=================*/
			const trx_t*	trx,	/*!< in: trx of new lock */
			ulint		type_mode,/*!< in: precise mode of the new lock
						to set: LOCK_S or LOCK_X, possibly
						ORed to LOCK_GAP or LOCK_REC_NOT_GAP,
						LOCK_INSERT_INTENTION */
			const lock_t*	lock2,	/*!< in: another record lock; NOTE that
						it is assumed that this has a lock bit
						set on the same record as in the new
						lock we are setting */
			bool		lock_is_on_supremum)
						/*!< in: TRUE if we are setting the
						lock on the 'supremum' record of an
						index page: we know then that the lock
						request is really for a 'gap' type lock */
		{
			ut_ad(trx && lock2);
			ut_ad(lock_get_type_low(lock2) == LOCK_REC);

			-- 首先要判断这两个锁对象是否属于同一个事务，如果属于同一个事务，则不冲突；并且 判断是否存在表锁冲突，如果不存在，需要进行锁兼容性矩阵的初步检测	
			if (trx != lock2->trx
				&& !lock_mode_compatible(static_cast<lock_mode>(
								 LOCK_MODE_MASK & type_mode),
							 lock_get_mode(lock2))) {
				
				-- 当间隙类型记录锁导致等待时，我们有一些复杂的规则
				/* We have somewhat complex rules when gap type record locks
				cause waits */
				
				
				if ((lock_is_on_supremum || (type_mode & LOCK_GAP))
					&& !(type_mode & LOCK_INSERT_INTENTION)) {

					/* Gap type locks without LOCK_INSERT_INTENTION flag
					do not need to wait for anything. This is because
					different users can have conflicting lock types
					on gaps. */
					
					-- 没有 LOCK_INSERT_INTENTION 标志的间隙类型锁不需要等待任何东西。 这是因为不同的用户可能在间隙上拥有冲突的锁类型

					return(FALSE);
				}

				if (!(type_mode & LOCK_INSERT_INTENTION)
					&& lock_rec_get_gap(lock2)) {

					/* Record lock (LOCK_ORDINARY or LOCK_REC_NOT_GAP
					does not need to wait for a gap type lock */
					-- 记录锁（LOCK_ORDINARY 或 LOCK_REC_NOT_GAP 不需要等待间隙型锁
					
					return(FALSE);
				}

				if ((type_mode & LOCK_GAP)
					&& lock_rec_get_rec_not_gap(lock2)) {

					/* Lock on gap does not need to wait for
					a LOCK_REC_NOT_GAP type lock */
					
					-- 间隙锁跟行锁不冲突
					
					return(FALSE);
				}

				if (lock_rec_get_insert_intention(lock2)) {

					/* No lock request needs to wait for an insert
					intention lock to be removed. This is ok since our
					rules allow conflicting locks on gaps. This eliminates
					a spurious deadlock caused by a next-key lock waiting
					for an insert intention lock; when the insert
					intention lock was granted, the insert deadlocked on
					the waiting next-key lock.

					Also, insert intention locks do not disturb each
					other. */
					
					-- 
					
					return(FALSE);
				}

				return(TRUE);
			}

			return(FALSE);
		}
	

-- 获取记录锁的等待插入标志
/*********************************************************************//**
Gets the waiting insert flag of a record lock.
@return LOCK_INSERT_INTENTION or 0 */
UNIV_INLINE
ulint
lock_rec_get_insert_intention(
/*==========================*/
	const lock_t*	lock)	/*!< in: record lock */
{
	ut_ad(lock);
	ut_ad(lock_get_type_low(lock) == LOCK_REC);

	return(lock->type_mode & LOCK_INSERT_INTENTION);
}	





------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


相关参考

	https://www.aneasystone.com/archives/2018/06/insert-locks-via-mysql-source-code.html  读 MySQL 源码再看 INSERT 加锁流程
	http://mysql.taobao.org/monthly/2017/09/10/	 MySQL · 源码分析 · 一条insert语句的执行过程
	https://www.cnblogs.com/jiangxu67/p/4242346.html	 【MySQL】MySQL锁和隔离级别浅析二 之 INSERT
	https://blog.csdn.net/aeolus_pu/article/details/55508289	mysql lock_rec_insert_check_and_lock 设置断点调试
	https://blog.csdn.net/weixin_28733651/article/details/113287018
	https://www.aneasystone.com/archives/2017/11/solving-dead-locks-two.html	解决死锁之路 - 了解常见的锁类型
	https://blog.51cto.com/u_15080020/2655735	 深入浅出MySQL 8.0 lock_sys锁相关优化
	http://blog.itpub.net/7728585/viewspace-2216591/ MySQL：一个死锁分析 (未分析出来的死锁)
	https://www.iamivan.net/a/bBKE5dM.html		[MySQL学习] Innodb锁系统(4) Insert/Delete 锁处理及死锁示例分析
	
	https://tech.souyunku.com/?p=28410   MySQL 死锁套路：一次诡异的批量插入死锁问题分析
	 
	https://blog.csdn.net/qiuyepiaoling/article/details/7587057	 MySQL数据库InnoDB存储引擎中的锁机制（原创：宋利兵）

	
思考

	1. 语句锁等待的场景下如何打断点
	
	

