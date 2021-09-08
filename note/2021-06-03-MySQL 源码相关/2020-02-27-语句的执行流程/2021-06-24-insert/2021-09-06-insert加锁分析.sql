

大纲
	1. 环境 
	2. 初始化表结构和数据
	3. 一个 insert 出现幻读的假设
	4. 三种加锁情况
		4.1 先select后insert
		4.2 先insert后select
		4.3 先insert后select - 特殊场景
	5. 隐式锁
	6. LATCH 锁
	7. mini transaction
		7.1 mini transation 主要作用：
		7.2 mini transaction、LATCH、数据插入的函数堆栈
		7.3 每个 mini-transaction 会遵守下面的几个规则
		
	8. 总结
		8.1 latch 锁
		8.1 insert 和 select ... lock in share mode 不会发生幻读
		8.3 insert 语句

	9. 疑问




1. 环境 
	
	mysql> show global variables like '%iso%';
	+-----------------------+-----------------+
	| Variable_name         | Value           |
	+-----------------------+-----------------+
	| transaction_isolation | REPEATABLE-READ |
	+-----------------------+-----------------+
	1 row in set (0.00 sec)

	mysql> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.18    |
	+-----------+
	1 row in set (0.00 sec)


2. 初始化表结构和数据

	use mysqlslap;
	create table t_20210906(id int NOT NULL AUTO_INCREMENT , PRIMARY KEY (id));
	insert into t_20210906(id) values(1),(10),(20),(50);

---------------------------------------------------------------------------------------------------

3. 一个 insert 出现幻读的假设

	加了插入意向锁后，插入数据之前，此时执行了 select…lock in share mode 语句（没有取到待插入的值），然后插入了数据，下一次再执行 select…lock in share mode（不会跟插入意向锁冲突），发现多了一条数据，于是又产生了幻读。会出现这种情况吗？

	也就是 4.3 先 insert 后 select - 特殊
	
4. 三种加锁情况

	4.1 先select后insert

		session A 							session B
		begin;								begin;	

											select * from t_20210906 where id = 30 lock in share mode;
		
		insert into t_20210906(id) value(30);	
		(Blocked)
		-- 被间隙锁阻塞								
		commit;	
											select * from t_20210906 where id = 30 lock in share mode;


		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
		| 140138352831952:1073:140138273376744   |                 55075 |        67 | t_20210906  | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
		| 140138352831952:16:4:5:140138273373816 |                 55075 |        67 | t_20210906  | PRIMARY    | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 50        |
		-- 被(20, 30) 的间隙锁阻塞
		| 140138352831080:1073:140138273370792   |       421613329541736 |        65 | t_20210906  | NULL       | TABLE     | IS                     | GRANTED     | NULL      |
		| 140138352831080:16:4:5:140138273367752 |       421613329541736 |        65 | t_20210906  | PRIMARY    | RECORD    | S,GAP                  | GRANTED     | 50        |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
		4 rows in set (0.00 sec)

									
	---------------------------------------------------------------------------------------------------

	4.2 先insert后select 

		session A 							session B
		begin;								begin;	
		insert into t_20210906(id) value(30);
											select * from t_20210906 where id = 30 lock in share mode;
											(Blocked)
											-- 被id=30的X锁阻塞
		commit;	
											select * from t_20210906 where id = 30 lock in share mode;
											

		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 140138352831080:1073:140138273370792   |                 55073 |        65 | t_20210906  | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 140138352831080:16:4:6:140138273367752 |                 55073 |        67 | t_20210906  | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 30        |
		| 140138352831952:1073:140138273376744   |       421613329542608 |        67 | t_20210906  | NULL       | TABLE     | IS            | GRANTED     | NULL      |
		| 140138352831952:16:4:6:140138273373816 |       421613329542608 |        67 | t_20210906  | PRIMARY    | RECORD    | S,REC_NOT_GAP | WAITING     | 30        |
		-- 被id=30的X锁阻塞
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		4 rows in set (0.00 sec)

			
						
	4.3 先insert后select - 特殊场景
							
		执行 insert 语句时，从判断是否有锁冲突，到写数据，这两个操作之间还是有时间差的：	
		
			如果 select...lock in share mode 的请求发生在 insert 申请完插入意向锁之后，写数据之前，这时候 GAP 锁和插入意向锁是不冲突的
			因为 记录锁 和 GAP 锁也是不冲突的，所以 insert 成功插入了一条数据
			所以当 insert 成功插入后，把事务A 提交了，再次执行 select...lock in share mode ，如果查到 id=3 的数据，是不是意味着出现了幻读。
			
			-- 就是这里没有搞懂
			-- 现在有点眉目了
			
		假设的场景如下：
			session A 							session B															LOCK
			begin;								begin;	

			insert into t_20210906(id) value(30);																	lock_mode X locks gap before rec insert intention
			-- 数据未插入
			-- 先申请到插入意向锁
												select * from t_20210906 where id = 30 lock in share mode;			lock_mode S locks gap before rec
												-- 请求发生在 insert 申请完插入意向锁之后，写数据之前
												-- 申请到 gap lock：(20, 30), gap lock 和 插入意向锁不冲突
												-- return 0 records
				
			insert into t_20210906(id) value(30);																	lock_mode X locks rec but not gap 
			-- 因为已经申请了插入意向锁，所以可以插入，此时插入操作执行完成
			
			commit;	
												select * from t_20210906 where id = 30 lock in share mode;			lock_modes S locks gap before rec	
												-- return 1 records：id=30
												(幻读？)



5. 隐式锁
	
	相关笔记：
		《2021-07-07-隐式锁.sql》

	举个例子：
		
		1. 事务A 插入一条记录且未提交
		2. 事务B 要对这条记录加锁，会先判断记录上是否存在活跃的事务
		3. 如果是活跃的，就会去帮事务A建立一个排他锁对象，然后自身进入等待事务A的阶段，这个步骤就是隐式锁转化为显示锁的步骤。	
	
		create table t_20210906(id int NOT NULL AUTO_INCREMENT , PRIMARY KEY (id));
		insert into t_20210906(id) values(1),(10),(20),(50);

		session A 							session B
		begin;								begin;	
		insert into t_20210906(id) value(30);
											select * from t_20210906 where id = 30 lock in share mode;
											(Blocked)
											-- 被id=30的X锁阻塞
		commit;	
											
											

		mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		| 140138352831080:1073:140138273370792   |                 55073 |        65 | t_20210906  | NULL       | TABLE     | IX            | GRANTED     | NULL      |
		| 140138352831080:16:4:6:140138273367752 |                 55073 |        67 | t_20210906  | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 30        |
		| 140138352831952:1073:140138273376744   |       421613329542608 |        67 | t_20210906  | NULL       | TABLE     | IS            | GRANTED     | NULL      |
		| 140138352831952:16:4:6:140138273373816 |       421613329542608 |        67 | t_20210906  | PRIMARY    | RECORD    | S,REC_NOT_GAP | WAITING     | 30        |
		-- 被id=30的X锁阻塞
		+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
		4 rows in set (0.00 sec)
		
		结合源码验证
		
			我们跟一下执行 select 时的流程，如果 select 需要加锁，则会走： sel_set_rec_lock -> lock_clust_rec_read_check_and_lock -> lock_rec_convert_impl_to_expl
		
			-- 如果事务在记录上具有隐式 x 锁，但没有在记录上设置显式 x 锁，则为其设置一个X锁
			-- 将隐式锁转换成显示锁，给其它事务已插入的记录加上必要的锁
			/*********************************************************************//**
			If a transaction has an implicit x-lock on a record, but no explicit x-lock
			set on the record, sets one for it. */
			static
			void
			lock_rec_convert_impl_to_expl(
			/*==========================*/
				const buf_block_t*	block,	/*!< in: buffer block of rec */
				const rec_t*		rec,	/*!< in: user record on page */
				dict_index_t*		index,	/*!< in: index of record */
				const ulint*		offsets)/*!< in: rec_get_offsets(rec, index) */
			{
				trx_t*		trx;

				ut_ad(!lock_mutex_own());
				ut_ad(page_rec_is_user_rec(rec));
				ut_ad(rec_offs_validate(rec, index, offsets));
				ut_ad(!page_rec_is_comp(rec) == !rec_offs_comp(offsets));

				if (dict_index_is_clust(index)) {
					trx_id_t	trx_id;

					trx_id = lock_clust_rec_some_has_impl(rec, index, offsets);

					trx = trx_rw_is_active(trx_id, NULL, true);
				} else {
					ut_ad(!dict_index_is_online_ddl(index));

					trx = lock_sec_rec_some_has_impl(rec, index, offsets);

					ut_ad(!trx || !lock_rec_other_trx_holds_expl(
							LOCK_S | LOCK_REC_NOT_GAP, trx, rec, block));
				}

				if (trx != 0) {
					ulint	heap_no = page_rec_get_heap_no(rec);

					ut_ad(trx_is_referenced(trx));
					-- 如果事务仍然处于活动状态并且在记录上没有设置明确的 x 锁，则为其设置 1(也就是在记录上加X锁)。在引用计数为零之前无法提交 trx
					/* If the transaction is still active and has no
					explicit x-lock set on the record, set one for it.
					trx cannot be committed until the ref count is zero. */

					lock_rec_convert_impl_to_expl_for_trx(
						block, rec, index, offsets, trx, heap_no);
				}
			}

		
			sel_set_rec_lock -> lock_clust_rec_read_check_and_lock -> lock_rec_convert_impl_to_expl->lock_rec_convert_impl_to_expl_for_trx
			
			
			/*********************************************************************//**
			Creates an explicit record lock for a running transaction that currently only
			has an implicit lock on the record. The transaction instance must have a
			reference count > 0 so that it can't be committed and freed before this
			function has completed. */
			static
			void
			lock_rec_convert_impl_to_expl_for_trx(
			/*==================================*/
				const buf_block_t*	block,	/*!< in: buffer block of rec */
				const rec_t*		rec,	/*!< in: user record on page */
				dict_index_t*		index,	/*!< in: index of record */
				const ulint*		offsets,/*!< in: rec_get_offsets(rec, index) */
				trx_t*			trx,	/*!< in/out: active transaction */
				ulint			heap_no)/*!< in: rec heap number to lock */
			{
				ut_ad(trx_is_referenced(trx));

				DEBUG_SYNC_C("before_lock_rec_convert_impl_to_expl_for_trx");

				lock_mutex_enter();

				ut_ad(!trx_state_eq(trx, TRX_STATE_NOT_STARTED));
				
				-- 先判断 trx_state_eq 事务是否活跃，再根据 lock_rec_has_expl 判断是否存在排他记录锁
				-- 如果事务活跃且没有锁 if (!trx_state_eq && !lock_rec_has_expl) ，就为该事务加上排他记录锁。
				if (!trx_state_eq(trx, TRX_STATE_COMMITTED_IN_MEMORY)
					&& !lock_rec_has_expl(LOCK_X | LOCK_REC_NOT_GAP,
							  block, heap_no, trx)) {

					ulint	type_mode;

					type_mode = (LOCK_REC | LOCK_X | LOCK_REC_NOT_GAP);
					-- 加入锁等待队列中
					lock_rec_add_to_queue(
						type_mode, block, heap_no, index, trx, FALSE);
				}

				lock_mutex_exit();

				trx_release_reference(trx);

				DEBUG_SYNC_C("after_lock_rec_convert_impl_to_expl_for_trx");
			}
			
				
		先判断 trx_state_eq 事务是否活跃，再根据 lock_rec_has_expl 判断是否存在排他记录锁，如果事务活跃且没有锁 if (!trx_state_eq && !lock_rec_has_expl) ，就为该事务加上排他记录锁。

		上文例子的流程如下：

			执行 insert 语句，判断是否有和插入意向锁冲突的锁，如果有，加插入意向锁，进入锁等待；如果没有，直接写数据，不加任何锁；

			执行 select * from t_20210906 where id = 30 lock in share mode; 语句执行后，判断记录上是否存在活跃的事务
				如果存在，为 insert 事务创建一个排他记录锁，并将自己加入到锁等待队列 （函数语句 lock_rec_add_to_queue）；
			
			
		-- 判断事务是否处于活跃状态
		/**********************************************************************//**
		Determines if a transaction is in the given state.
		The caller must hold trx_sys->mutex, or it must be the thread
		that is serving a running transaction.
		A running RW transaction must be in trx_sys->rw_trx_list.
		@return TRUE if trx->state == state */
		UNIV_INLINE
		bool
		trx_state_eq(
		/*=========*/
			const trx_t*	trx,	/*!< in: transaction */
			trx_state_t	state)	/*!< in: state */
		{			
			
		
		-- 判断是否有锁
		/*********************************************************************//**
		Checks if a transaction has a GRANTED explicit lock on rec stronger or equal
		to precise_mode.
		@return lock or NULL */
		UNIV_INLINE
		lock_t*
		lock_rec_has_expl(




6. LATCH 锁
	
	本文的案例分析就用到 latch 锁。
	
	insert 会在检查锁冲突和写数据之前，会对记录所在的页加一个 RW-X-LATCH 锁，执行完写数据之后再释放该锁(实际上写数据的操作就是写 redo log(重做日志)，将脏页加入 flush list)。
	这个锁的释放非常快，但是这个锁足以保证在插入数据的过程中其他事务无法访问记录所在的页。
	这个加锁过程实际上是在 mini transaction 里完成的。
	

	假设的幻读场景如下：
	
		时间点	session A 							session B															LOCK
				begin;								begin;	

			T1	insert into t_20210906(id) value(30);																	lock_mode X locks gap before rec insert intention
				-- 数据未插入
				-- 会先对记录所在的数据页加1个 RW-X-LATCH
				-- 然后先申请到插入意向锁
			
			T2										select * from t_20210906 where id = 30 lock in share mode;			lock_mode S locks gap before rec
													
													-- 1. 请求发生在 insert 申请完插入意向锁之后，写数据之前
													-- 2. 申请到 gap lock：(20, 30), gap lock 和 插入意向锁不冲突
													-- 3. return 0 records
													-- 上面1-3的步骤，假设不成立
													-- 因为这里会在1-3步骤之前，申请对记录所在的数据页加 RW-S-LATCH， 因为会被 RW-X-LATCH 阻塞。
													-- (Blocked)
												
				
			T3	insert into t_20210906(id) value(30);																	lock_mode X locks rec but not gap 
				-- 因已经申请了插入意向锁，所以可以插入，此时插入操作执行完成
				-- 释放 RW-X-LATCH
													
													-- 获取到 RW-S-LATCH，但是被id=30的X 记录锁阻塞
				commit;	
													-- session A的事务提交，此时T2可以获取到id=30的 S 记录锁
													-- return 1 records：id=30
													
													----------------------------------------------------------------------------------------------------
												
			T4										select * from t_20210906 where id = 30 lock in share mode;			lock_modes S locks gap before rec	
													-- session A的事务提交，此时T4可以获取到id=30的 S 记录锁
													-- return 1 records：id=30
													
											
	-- 所以幻读不成立。
	
	
7. mini transaction

	7.1 mini transation 主要作用
	
		主要用于innodb redo log 和 undo log写入，保证两种日志的ACID特性。
	
	7.2 mini transaction、LATCH、数据插入的函数堆栈
	
		函数堆栈为：row_ins_clust_index_entry_low -> btr_cur_search_to_nth_level -> btr_cur_latch_leaves。
		-- 后面可以根据这些函数堆栈进行扩展

		UNIV_INTERN
		dberr_t
		row_ins_clust_index_entry_low(
		/*==========================*/
			ulint        flags,    /*!< in: undo logging and locking flags */
			ulint        mode,    /*!< in: BTR_MODIFY_LEAF or BTR_MODIFY_TREE,
						depending on whether we wish optimistic or
						pessimistic descent down the index tree */
			dict_index_t*    index,    /*!< in: clustered index */
			ulint        n_uniq,    /*!< in: 0 or index->n_uniq */
			dtuple_t*    entry,    /*!< in/out: index entry to insert */
			ulint        n_ext,    /*!< in: number of externally stored columns */
			que_thr_t*    thr)    /*!< in: query thread */
		{
			/* 开启一个 mini-transaction */
			mtr_start(&mtr);
			 
			-- 调用 btr_cur_latch_leaves -> btr_block_get 加 RW_X_LATCH 
			btr_cur_search_to_nth_level(index, 0, entry, PAGE_CUR_LE, mode,
							&cursor, 0, __FILE__, __LINE__, &mtr);
			 
			if (mode != BTR_MODIFY_TREE) {
				/* 不需要修改 BTR_TREE，乐观插入 */
				err = btr_cur_optimistic_insert(
					flags, &cursor, &offsets, &offsets_heap,
					entry, &insert_rec, &big_rec,
					n_ext, thr, &mtr);
			} else {
				/* 需要修改 BTR_TREE，先乐观插入，乐观插入失败则进行悲观插入 */
				err = btr_cur_optimistic_insert(
					flags, &cursor,
					&offsets, &offsets_heap,
					entry, &insert_rec, &big_rec,
					n_ext, thr, &mtr);
				if (err == DB_FAIL) {
					err = btr_cur_pessimistic_insert(
						flags, &cursor,
						&offsets, &offsets_heap,
						entry, &insert_rec, &big_rec,
						n_ext, thr, &mtr);
				}
			}
			 
			/* 提交 mini-transaction */
			mtr_commit(&mtr);
		}



	7.3 每个 mini-transaction 会遵守下面的几个规则

		修改一个页需要获得该页的 X-LATCH；
		访问一个页需要获得该页的 S-LATCH 或 X-LATCH；
		持有该页的 LATCH 直到修改或者访问该页的操作完成。
	


8. 总结
	
	8.1 latch 锁
		
		insert 会在检查锁冲突和写数据之前，会对记录所在的页加一个 RW-X-LATCH 锁，执行完写数据之后再释放该锁(实际上写数据的操作就是写 redo log(重做日志)，将脏页加入 flush list)。
		这个锁的释放非常快，但是这个锁足以保证在插入数据的过程中其他事务无法访问记录所在的页。
		这个加锁过程实际上是在 mini transaction 里完成的。
		
	
	8.1 insert 和 select ... lock in share mode 不会发生幻读
	

		整个流程如下：
			-- 没有 LATCH 锁的描述
				执行 insert 语句，判断是否有和插入意向锁冲突的锁，如果有，加插入意向锁，进入锁等待；如果没有，直接写数据，不加任何锁；
				执行 select ... lock in share mode 语句，判断记录上是否存在活跃的事务，如果存在，则为 insert 事务创建一个排他记录锁，并将自己加入到锁等待队列；
			
			-- 有 LATCH 锁的描述
				执行 insert 语句，对要操作的页加 RW-X-LATCH，然后判断是否有和插入意向锁冲突的锁，如果有，加插入意向锁，进入锁等待；如果没有，直接写数据，不加任何锁，结束后释放 RW-X-LATCH；
				执行 select ... lock in share mode 语句，对要操作的页加 RW-S-LATCH，如果页面上存在 RW-X-LATCH 会被阻塞
					没有的话则判断记录上是否存在活跃的事务，如果存在，则为 insert 事务创建一个排他记录锁，并将自己加入到锁等待队列，最后也会释放 RW-S-LATCH；
				
				-- 对数据页加latch锁
	
	
	8.3 insert 语句
	
		insert操作不需要对数据加锁，但是插入数据前需要先申请意向插入锁。
	

9. 疑问
	
	1. latch 锁什么时候释放，语句执行结束还等事务提交再释放？
		答：目前来看是语句执行结束就释放 latch 锁，不然会影响并发度。
		

				