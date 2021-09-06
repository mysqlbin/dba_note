



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

		
					
	4.3 先 insert 后 select - 特殊
						
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
			-- 因为已经申请了插入意向锁，所以插入完成
			
			commit;	
												select * from t_20210906 where id = 30 lock in share mode;			lock_modes S locks gap before rec	
												-- return 1 records：id=30
												(幻读？)



4. 隐式锁
	举个例子：
		1. 事务A 的 insert 语句在执行期间默认不对记录加显示锁，加的是隐式锁，还未提交的事务属于活跃事务
		2. 事务B 申请的锁跟 insert语句这个活跃事务的隐式锁冲突
		3. 此时事务B 会把事务 A 的隐式锁改为显示锁，同时 事务B 处于等待状态
		
	相关笔记：
		《2021-07-07-隐式锁.sql》

5. LATCH 锁
	
	insert 会在检查锁冲突和写数据之前，会对记录所在的页加一个 RW-X-LATCH 锁，执行完写数据之后再释放该锁(实际上写数据的操作就是写 redo log(重做日志)，将脏页加入 flush list)。
	这个锁的释放非常快，但是这个锁足以保证在插入数据的过程中其他事务无法访问记录所在的页。
	这个加锁过程实际上是在 mini transaction 里完成的。
	
	
6. mini transaction

	6.1 mini transation 主要作用：
		主要用于innodb redo log 和 undo log写入，保证两种日志的ACID特性。
	
	6.2 mini transaction、LATCH、数据插入的函数堆栈
	
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



	6.3 每个 mini-transaction 会遵守下面的几个规则：

		修改一个页需要获得该页的 X-LATCH；
		访问一个页需要获得该页的 S-LATCH 或 X-LATCH；
		持有该页的 LATCH 直到修改或者访问该页的操作完成。
	


总结：

	insert 和 select ... lock in share mode 不会发生幻读。
	

	整个流程如下：

		执行 insert 语句，对要操作的页加 RW-X-LATCH，然后判断是否有和插入意向锁冲突的锁，如果有，加插入意向锁，进入锁等待；如果没有，直接写数据，不加任何锁，结束后释放 RW-X-LATCH；
		执行 select ... lock in share mode 语句，对要操作的页加 RW-S-LATCH，如果页面上存在 RW-X-LATCH 会被阻塞
			没有的话则判断记录上是否存在活跃的事务，如果存在，则为 insert 事务创建一个排他记录锁，并将自己加入到锁等待队列，最后也会释放 RW-S-LATCH；
		
	
insert 语句：
	
	加的隐式锁，也就是默认不加锁。
	插入数据前需要先申请意向插入锁。




				