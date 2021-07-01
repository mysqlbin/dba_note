

1. InnoDB锁结构实现
2. InnoDB锁定读实现
3. ha_innobase::index_read 函数实现如下
4. row_search_mvcc加锁访问流程如下
5. 行锁加锁流程(lock_rec_lock)
6. 相关参考



1. InnoDB锁结构实现

	锁类型
		Innodb锁有两种类型，分别是表锁与行锁

		#define LOCK_TABLE    16    /*!< table lock */
		#define LOCK_REC    32    /*!< record lock */

	锁标记
		锁有一个waiting flag，由以下宏定义，表示锁目前不占用资源，而是正在等待资源的释放。
	
		#define LOCK_WAIT    256   


	锁模式
		行锁有三种模式，定义如下所示，并且三种锁模式互斥。

		#define LOCK_ORDINARY     0    
		#define LOCK_GAP    	  512    
		#define LOCK_REC_NOT_GAP  1024


	锁定义
		/* 锁系统结构 */
		/* 这里仅展示行锁哈希表字段的定义，忽略了其它锁与字段 */
		struct lock_sys_t{
			hash_table_t*	rec_hash;		/* 行锁哈希表 */
		};

		/* 哈希结构 */
		struct hash_table_t {
			ulint			n_cells;/* cell个数 */
			hash_cell_t*		array;	/* cell数组 */
		};

		/* 锁定义 */
		struct lock_t {
			trx_t*		trx;		/* 锁所在的事务 */
			dict_index_t*	index;		/* 锁对应的索引 */
			lock_t*		hash;		/* 由于所有的锁都是存储在一个HASH结构中 */
												/* 因此此字段表示单链表下一个结构，解决冲突 */
			union {
				lock_table_t	tab_lock;/* 表锁 */
				lock_rec_t	rec_lock;/* 行锁 */
			} un_member;			/* 锁由于一个UNION存储 */
			ib_uint32_t	type_mode;	/* 用于存储锁类型，锁模式，锁标记等 */
		};

		/* 行锁定义 */
		struct lock_rec_t {
			ib_uint32_t	space;		/* 表空间号tablespace */
			ib_uint32_t	page_no;	/* 页号 */
			ib_uint32_t	n_bits;		/* 锁位图大小，并且位图是放在lock_t结构之后的 */
		};


2. InnoDB锁定读实现
	
	以下函数调用实现了锁定读（范围/等值查询的锁定读）的核心流程。
		

		handle_query
			...
				index_read
					row_search_mvcc
						lock_table         #对表加意向锁LOCK_IX或LOCK_IS
						btr_pcur_get_rec   #根据条件获取行数据
						sel_set_rec_lock   #对行加锁LOCK_X或LOCK_S



3. ha_innobase::index_read 函数实现如下

	-- E:\github\mysql-5.7.26\storage\innobase\handler\ha_innodb.cc
	
	int
	ha_innobase::index_read(
		uchar*		buf,		/* 用于存储Innodb读到的数据以便返回给Server层处理 */
		const uchar*	key_ptr,	/* 查询键值 */
		uint		key_len,        /* 键值长度 */
		enum ha_rkey_function find_flag)/* 查询标记 */
	{
			/* 根据find_flag推断出检索模式mode */ 
		page_cur_mode_t	mode = convert_search_mode_to_innobase(find_flag);
		ulint	match_mode = 0;
			/* 根据find_flag推断行的匹配模式match_mode*/
		if (find_flag == HA_READ_KEY_EXACT) {
			match_mode = ROW_SEL_EXACT;
		} else if (find_flag == HA_READ_PREFIX_LAST) {
			match_mode = ROW_SEL_EXACT_PREFIX;
		}
		dberr_t		ret;
		if (mode != PAGE_CUR_UNSUPP) {
					/* mode以及match_mode控制着row_search_mvcc的流程 */
			ret = row_search_mvcc(buf, mode, m_prebuilt, match_mode, 0);
		} else {
			ret = DB_UNSUPPORTED;
		}
		DBUG_RETURN(error);
	} 






4. row_search_mvcc加锁访问流程如下

	dberr_t
	row_search_mvcc(
		byte*		buf,
		page_cur_mode_t	mode,
		row_prebuilt_t*	prebuilt,
		ulint		match_mode,
		ulint		direction)
	{


	
	-- 第1步：判断是否是唯一索引的等值查询
	if (match_mode == ROW_SEL_EXACT
	    && dict_index_is_unique(index)
	    && dtuple_get_n_fields(search_tuple)
	    == dict_index_get_n_unique(index)
	    && (dict_index_is_clust(index)
		|| !dtuple_contains_null(search_tuple))) {

		/* Note above that a UNIQUE secondary index can contain many
		rows with the same key value if one of the columns is the SQL
		null. A clustered index under MySQL can never contain null
		columns because we demand that all the columns in primary key
		are non-null. */
		-- 等值查询，并且查询的索引为聚族索引 */
        -- 或者查询的索引为辅助索引且辅助索引是唯一的且查询条件中不含有NULL值*/
		unique_search = TRUE;

	}

	
	-- 第2步：对表加意向锁
	wait_table_again:
			--  根据行锁类型获取相应的意向锁
			err = lock_table(0, index->table,
					 prebuilt->select_lock_type == LOCK_S
					 ? LOCK_IS : LOCK_IX, thr);
			-- 加意向锁失败，处于锁等待状态
			if (err != DB_SUCCESS) {

				table_lock_waited = TRUE;
				goto lock_table_wait;
			}
			prebuilt->sql_stat_start = FALSE;
		}

		-- 根据查询条件search_tuple建立B+树的cursor
		btr_pcur_open_with_no_init(index, search_tuple, mode, BTR_SEARCH_LEAF, pcur, 0, &mtr);

		
	-- 第3步：获取行数据
	rec_loop:
		DEBUG_SYNC_C("row_search_rec_loop");
		
		/*-------------------------------------------------------------*/
		/* PHASE 4: Look for matching records in a loop */
		
		-- 从cursor中读取行记录，也就是根据条件获取行数据
		rec = btr_pcur_get_rec(pcur);


	-- 第4点：添加行锁
	wrong_offs:
		
		prev_rec = rec;
		
		-- 加间隙锁
		-- 非唯一索引的等值查询
		if (match_mode == ROW_SEL_EXACT) {    --等值查询
				
			if (0 != cmp_dtuple_rec(search_tuple, rec, offsets)) {
				
				-- 间隙锁
				if (set_also_gap_locks
					&& !(srv_locks_unsafe_for_binlog
					 || trx->isolation_level
					 <= TRX_ISO_READ_COMMITTED)
					&& prebuilt->select_lock_type != LOCK_NONE
					&& !dict_index_is_spatial(index)) {

					/* Try to place a gap lock on the index record only if innodb_locks_unsafe_for_binlog option is not set or this session is not using a READ COMMITTED isolation level. */
					仅当 innodb_locks_unsafe_for_binlog 选项未设置或此会话未使用 READ COMMITTED 隔离级别时，才尝试在索引记录上放置间隙锁
					如何解决幻读的:
						1、MySQL在RR隔离级别引入gap lock，把2条记录中间的gap锁住，避免其他事务写入(例如在二级索引上锁定记录1-3之间的gap，那么其他会话无法在这个gap间插入数据)
						2、MySQL出现幻读的条件是隔离级别<=RC，或者 innodb_locks_unsafe_for_binlog=1(8.0已取消该选项)
					
					- LOCK_GAP 512

					只锁住索引记录之间或者第一条索引记录前或者最后一条索引记录之后的范围，并不锁住记录本身。  --《4.1.1 唯一索引等值查询间隙锁》

					例如在RR隔离级别下，非唯一索引条件上的等值当前读，会在等值记录上加NEXT-KEY LOCK同时锁住行和前面范围的记录，同时会在后面一个值上加LOCK\_GAP锁住下一个值前面的范围。
					
					err = sel_set_rec_lock(
						pcur,
						rec, index, offsets,
						prebuilt->select_lock_type, LOCK_GAP,
						thr, &mtr);

					switch (err) {
					case DB_SUCCESS_LOCKED_REC:
					case DB_SUCCESS:
						break;
					default:
						goto lock_wait_or_error;
					}
				}

				btr_pcur_store_position(pcur, &mtr);
				
				ut_ad(pcur->rel_pos == BTR_PCUR_ON);
				pcur->rel_pos = BTR_PCUR_BEFORE;

				err = DB_RECORD_NOT_FOUND;
				goto normal_return;
			}
		
		} else if (match_mode == ROW_SEL_EXACT_PREFIX) {

			if (!cmp_dtuple_is_prefix_of_rec(search_tuple, rec, offsets)) {

				if (set_also_gap_locks
					&& !(srv_locks_unsafe_for_binlog
					 || trx->isolation_level
					 <= TRX_ISO_READ_COMMITTED)
					&& prebuilt->select_lock_type != LOCK_NONE
					&& !dict_index_is_spatial(index)) {

		
					err = sel_set_rec_lock(
						pcur,
						rec, index, offsets,
						prebuilt->select_lock_type, LOCK_GAP,
						thr, &mtr);

					switch (err) {
					case DB_SUCCESS_LOCKED_REC:
					case DB_SUCCESS:
						break;
					default:
						goto lock_wait_or_error;
					}
				}

				btr_pcur_store_position(pcur, &mtr);

				/* The found record was not a match, but may be used
				as NEXT record (index_next). Set the relative position
				to BTR_PCUR_BEFORE, to reflect that the position of
				the persistent cursor is before the found/stored row
				(pcur->old_rec). */
				ut_ad(pcur->rel_pos == BTR_PCUR_ON);
				pcur->rel_pos = BTR_PCUR_BEFORE;

				err = DB_RECORD_NOT_FOUND;
				goto normal_return;
			}

		}


		ulint		select_lock_type;/*!< LOCK_NONE, LOCK_S, or LOCK_X */


		-- 添加行锁
		if (prebuilt->select_lock_type != LOCK_NONE) {
			
				 -- 锁定义，需要根据 lock_type 加相应的锁 
				 
				ulint	lock_type;;
				
				if (!set_also_gap_locks
					|| srv_locks_unsafe_for_binlog
					|| trx->isolation_level <= TRX_ISO_READ_COMMITTED
					|| (unique_search && !rec_get_deleted_flag(rec, comp))
					|| dict_index_is_spatial(index)) {
					
					-- 唯一查询，加 LOCK_REC_NOT_GAP 锁
					goto no_gap_lock;
					
				} else {
				
					-- 非唯一索引查询，加 next-key lock
					lock_type = LOCK_ORDINARY;
				}

				
				
				/* If we are doing a 'greater or equal than a primary key
				value' search from a clustered index, and we find a record
				that has that exact primary key value, then there is no need
				to lock the gap before the record, because no insert in the
				gap can be in our search range. That is, no phantom row can
				appear that way.

				An example: if col1 is the primary key, the search is WHERE
				col1 >= 100, and we find a record where col1 = 100, then no
				need to lock the gap before that record. */
				
				-- col1 为主键索引，WHERE col1 >= 100
				-- 那么不需要锁定该 col1=100 记录之前的间隙
				
		
				-- 聚集索引的加锁	
				if (index == clust_index
					&& mode == PAGE_CUR_GE
					&& direction == 0
					&& dtuple_get_n_fields_cmp(search_tuple)
					== dict_index_get_n_unique(index)
					&& 0 == cmp_dtuple_rec(search_tuple, rec, offsets)) {
		no_gap_lock:
					-- 锁的类型为行锁
					lock_type = LOCK_REC_NOT_GAP;
				}
				
				-- 进行加锁
				err = sel_set_rec_lock(pcur,
					   rec, index, offsets,
					   prebuilt->select_lock_type,
					   lock_type, thr, &mtr);
					   
				-- 根据返回值 err 判断加锁是否成功	   
				switch (err) {
					const rec_t*	old_vers;
					
				-- 创建锁成功，加锁成功 
				case DB_SUCCESS_LOCKED_REC:
					if (srv_locks_unsafe_for_binlog
						|| trx->isolation_level
						<= TRX_ISO_READ_COMMITTED) {
						/* Note that a record of
						prebuilt->index was locked. */
						prebuilt->new_rec_locks = 1;
					}
					
					err = DB_SUCCESS;
					// Fall through
					
				-- 找到了当前事务之前创建并且兼容的锁，复用之，加锁成功	
				case DB_SUCCESS:
					break;
					
				-- 加锁不成功，因为有锁等待
				case DB_LOCK_WAIT:
					/* Lock wait for R-tree should already
					be handled in sel_set_rtr_rec_lock() */
					ut_ad(!dict_index_is_spatial(index));
					/* Never unlock rows that were part of a conflict. */
					prebuilt->new_rec_locks = 0;

					if (UNIV_LIKELY(prebuilt->row_read_type
							!= ROW_READ_TRY_SEMI_CONSISTENT)
						|| unique_search
						|| index != clust_index) {
						-- 处理lock wait错误
						goto lock_wait_or_error;
					}


					/* Check whether it was a deadlock or not, if not
					a deadlock and the transaction had to wait then
					release the lock it is waiting on. */
					
					-- 检查是否为死锁，如果不是死锁，则事务必须等待，然后释放它正在等待的锁。
					
					err = lock_trx_handle_wait(trx);

					switch (err) {
					-- 加锁成功
					case DB_SUCCESS:
						/* The lock was granted while we were
						searching for the last committed version.
						Do a normal locking read. */

						offsets = rec_get_offsets(
							rec, index, offsets, ULINT_UNDEFINED,
							&heap);
						goto locks_ok;
					-- 死锁
					case DB_DEADLOCK:
						goto lock_wait_or_error;
					-- 锁等待
					case DB_LOCK_WAIT:
						ut_ad(!dict_index_is_spatial(index));
						err = DB_SUCCESS;
						break;
					default:
						ut_error;
					}
				-- 没有找到记录	
				case DB_RECORD_NOT_FOUND:
					if (dict_index_is_spatial(index)) {
						goto next_rec;
					} else {
						goto lock_wait_or_error;
					}

				default:

					goto lock_wait_or_error;
				}
		}



lock_wait_or_error:
	/* Reset the old and new "did semi-consistent read" flags. */
	if (UNIV_UNLIKELY(prebuilt->row_read_type
			  == ROW_READ_DID_SEMI_CONSISTENT)) {
		prebuilt->row_read_type = ROW_READ_TRY_SEMI_CONSISTENT;
	}
	did_semi_consistent_read = FALSE;

	/*-------------------------------------------------------------*/
	if (!dict_index_is_spatial(index)) {
		btr_pcur_store_position(pcur, &mtr);
	}


------------------------------------------------------------------------

E:\github\mysql-5.7.26\storage\innobase\lock\lock0lock.cc
/*********************************************************************//**
Check whether the transaction has already been rolled back because it
was selected as a deadlock victim, or if it has to wait then cancel
the wait lock.
@return DB_DEADLOCK, DB_LOCK_WAIT or DB_SUCCESS */
dberr_t
lock_trx_handle_wait(
/*=================*/
	trx_t*	trx)	/*!< in/out: trx lock state */
{
	dberr_t	err;
	-- 行锁开销大
	lock_mutex_enter();

	trx_mutex_enter(trx);

	if (trx->lock.was_chosen_as_deadlock_victim) {
		err = DB_DEADLOCK;
	} else if (trx->lock.wait_lock != NULL) {
		lock_cancel_waiting_and_release(trx->lock.wait_lock);
		err = DB_LOCK_WAIT;
	} else {
		/* The lock was probably granted before we got here. */
		err = DB_SUCCESS;
	}

	lock_mutex_exit();

	trx_mutex_exit(trx);

	return(err);
}



		

5. 行锁加锁流程(lock_rec_lock)

	行锁加锁流程(lock_rec_lock)
	
		如下图所示：

		lock_rec_other_has_conflicting->lock_rec_has_to_wait 表示行锁加锁前的兼容性检查，兼容则加锁，不兼容则进入锁等待；

		lock_rec_lock 首先走 lock_rec_lock_fast 逻辑，判断能否快速完成加锁; 若lock_rec_lock_fast失败，则通过lock_rec_lock_slow进行加锁；

		lock_rec_lock_fast 表示满足一定条件可以共用之前已经创建的行锁(设置一下bitmap即可)，条件：

			以下条件满足一个则快速加锁失败：
			if (lock_rec_get_next_on_page(lock)              //page上有多个行锁
				|| lock->trx != trx                          //已经拥有该锁的事务不是当前事务
				|| lock->type_mode != (mode | LOCK_REC)      //已有的锁和要加的锁锁模式是否一致
				|| lock_rec_get_n_bits(lock) <= heap_no) {   //n_bits是否足够描述大小为 heap_no 的行
			  status = LOCK_REC_FAIL;
			}
			
		lock_rec_lock_slow 首先调用 lock_rec_has_expl 判断该行是否有相同或者更强的锁，然后通过兼容性矩阵判断该行是否有不兼容的锁，若不兼容需要将锁设置为等待状态并进行死锁检测(RecLock::deadlock_check)，死锁检测流程下文将详细介绍。	
		
		https://blog.51cto.com/u_15080020/2655735
		
	加行级锁

		行级锁加锁的入口函数为 lock_rec_lock ，其中第一个参数impl如果为TRUE，则当当前记录上已有的锁和LOCK_X | LOCK_REC_NOT_GAP不冲突时，就无需创建锁对象。（见上文关于记录锁LOCK_X相关描述部分），为了描述清晰，下文的流程描述，默认impl为FALSE。

		lock_rec_lock：

			1. 首先尝试fast lock的方式，对于冲突少的场景，这是比较普通的加锁方式(lock_rec_lock_fast), 符合如下情况时，可以走fast lock:
				记录所在的page上没有任何记录锁时，直接创建锁对象，加入rec_hash，并返回成功;
				记录所在的page上只存在一个记录锁，并且属于当前事务，且这个记录锁预分配的bitmap能够描述当前的heap no（预分配的bit数为创建锁对象时的page上记录数 + 64，参阅函数 RecLock::lock_size ），则直接设置对应的bit位并返回;
			2. 无法走fast lock时，再调用slow lock的逻辑(lock_rec_lock_slow)
				判断当前事务是否已经持有了一个优先级更高的锁，如果是的话，直接返回成功（lock_rec_has_expl）;
				检查是否存在和当前申请锁模式冲突的锁（lock_rec_other_has_conflicting），如果存在的话，就创建一个锁对象（RecLock::RecLock），并加入到等待队列中（RecLock::add_to_waitq），这里会进行死锁检测;
				如果没有冲突的锁，则入队列（lock_rec_add_to_queue）：已经有在同一个Page上的锁对象且没有别的会话等待相同的heap no时，可以直接设置对应的bitmap（lock_rec_find_similar_on_page）；否则需要创建一个新的锁对象;
			3. 返回错误码，对于DB_LOCK_WAIT, DB_DEADLOCK等错误码，会在上层进行处理。

		http://mysql.taobao.org/monthly/2016/01/01/


6. 相关参考
		
	http://mysql.taobao.org/monthly/2016/01/01/
	
	https://segmentfault.com/a/1190000017076101
	
	https://zhuanlan.zhihu.com/p/56519305	 MySQL · 引擎分析 · InnoDB行锁分析
	
	https://blog.csdn.net/fly43108622/article/details/89473828

	https://blog.csdn.net/weixin_28733651/article/details/113287018	mysql锁兼容矩阵_InnoDB行锁兼容性矩阵

	https://zhuanlan.zhihu.com/p/139489272	MySQL Innodb行锁剖析

	https://blog.csdn.net/zxz1580977728/article/details/109400915	【数据库篇】MySQL源码分析之row_search_mvcc详细分析（Page加载及索引分析）

	https://developer.aliyun.com/article/594724	 MySQL · 引擎分析 · InnoDB行锁分析



死锁检测函数列表A row_search_for_mysql (搜索行)

死锁检测函数列表B sel_set_rec_lock (判断是二级索引还是主键,然后对行加锁)

死锁检测函数列表C lock_clust_rec_read_check_and_lock (检查有锁堵塞)

死锁检测函数列表D lock_rec_lock 处理逻辑（检测锁的兼容性)

死锁检测函数列表E lock_rec_lock_slow 处理逻辑(确认申请不到锁)

死锁检测函数列表F lock_rec_enqueue_waiting

死锁检测函数列表G lock_deadlock_check_and_resolve 处理逻辑

死锁检测函数列表H lock_deadlock_search 函数代码处理逻辑

死锁检测函数列表I lock_get_first_lock 处理逻辑(第一个锁比较)

死锁检测函数列表J lock_get_next_lock 函数代码处理逻辑(获取锁继续比较)


https://mp.weixin.qq.com/s/13d4bST9jqlQjMSogS37Bw	

我们一个个来看这些函数的主要作用 

你可以通过GDB，断点函数 lock_rec_lock 来查看某条SQL如何执行加锁操作。
b lock_rec_lock

行级锁加锁的入口函数为 lock_rec_lock，其中第一个参数 impl 如果为 TRUE ，则当当前记录上已有的锁和LOCK_X | LOCK_REC_NOT_GAP不冲突时，就无需创建锁对象。



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

session A       																session B                                                           
                                                      
(gdb) b lock_rec_lock
Breakpoint 2 at 0x1943577: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 2040.
																				BEGIN;		
(gdb) c
Continuing.
[Switching to Thread 0x7f29841bc700 (LWP 6580)]
																				
																				SELECT * FROM hero WHERE number <= 8 LOCK IN SHARE MODE;

Breakpoint 2, lock_rec_lock (impl=false, mode=1026, block=0x7f2993520838, heap_no=2, index=0x5a744d0, thr=0x7f296c011568) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1026, block=0x7f2993520838, heap_no=2, index=0x5a744d0, thr=0x7f296c011568) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7f2993520838, rec=0x7f29946c8080 "\200", index=0x5a744d0, offsets=0x7f29841b8d80, mode=LOCK_S, gap_mode=1024, thr=0x7f296c011568) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
#2  0x0000000001a4651c in sel_set_rec_lock (pcur=0x7f296c010fe8, rec=0x7f29946c8080 "\200", index=0x5a744d0, offsets=0x7f29841b8d80, mode=2, type=1024, thr=0x7f296c011568, mtr=0x7f29841b90a0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1254
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7f296c010250 "\377", mode=PAGE_CUR_G, prebuilt=0x7f296c010dd0, match_mode=0, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
#4  0x00000000018c1784 in ha_innobase::index_read (this=0x7f296c00fe40, buf=0x7f296c010250 "\377", key_ptr=0x0, key_len=0, find_flag=HA_READ_AFTER_KEY) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
#5  0x00000000018c27ba in ha_innobase::index_first (this=0x7f296c00fe40, buf=0x7f296c010250 "\377") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9157
#6  0x0000000000f2c4b3 in handler::ha_index_first (this=0x7f296c00fe40, buf=0x7f296c010250 "\377") at /usr/local/mysql/sql/handler.cc:3193
#7  0x0000000000f34e59 in handler::read_range_first (this=0x7f296c00fe40, start_key=0x0, end_key=0x7f296c00ff48, eq_range_arg=false, sorted=false) at /usr/local/mysql/sql/handler.cc:7378
#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x7f296c00fe40, range_info=0x7f29841ba110) at /usr/local/mysql/sql/handler.cc:6450
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7f296c0100a0, range_info=0x7f29841ba110) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7f296c00fe40, range_info=0x7f29841ba110) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7f296c00ee80) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001457dba in rr_quick (info=0x7f296c01ce58) at /usr/local/mysql/sql/records.cc:398
#13 0x00000000014f0090 in join_init_read_record (tab=0x7f296c01ce08) at /usr/local/mysql/sql/sql_executor.cc:2497
#14 0x00000000014ed267 in sub_select (join=0x7f296c01c8f0, qep_tab=0x7f296c01ce08, end_of_records=false) at /usr/local/mysql/sql/sql_executor.cc:1277
#15 0x00000000014ecbfa in do_select (join=0x7f296c01c8f0) at /usr/local/mysql/sql/sql_executor.cc:950
#16 0x00000000014eab61 in JOIN::exec (this=0x7f296c01c8f0) at /usr/local/mysql/sql/sql_executor.cc:199
#17 0x0000000001583b64 in handle_query (thd=0x7f296c0011c0, lex=0x7f296c0034e0, result=0x7f296c007748, added_options=0, removed_options=0) at /usr/local/mysql/sql/sql_select.cc:184
#18 0x000000000153996f in execute_sqlcom_select (thd=0x7f296c0011c0, all_tables=0x7f296c006e40) at /usr/local/mysql/sql/sql_parse.cc:5144
#19 0x000000000153339d in mysql_execute_command (thd=0x7f296c0011c0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:2816
#20 0x000000000153a849 in mysql_parse (thd=0x7f296c0011c0, parser_state=0x7f29841bb690) at /usr/local/mysql/sql/sql_parse.cc:5570
#21 0x00000000015302d8 in dispatch_command (thd=0x7f296c0011c0, com_data=0x7f29841bbdf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#22 0x000000000152f20c in do_command (thd=0x7f296c0011c0) at /usr/local/mysql/sql/sql_parse.cc:1025
#23 0x000000000165f7c8 in handle_connection (arg=0x3d33690) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#24 0x0000000001ce7612 in pfs_spawn_thread (arg=0x3d7fae0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#25 0x00007f29abac5ea5 in start_thread () from /lib64/libpthread.so.0
#26 0x00007f29aa98b9fd in clone () from /lib64/libc.so.6

--------------------------------------------------------------------------------------------------------------------------

(gdb) b lock_rec_lock
Breakpoint 2 at 0x1943577: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 2040.
																							begin;

(gdb) c
Continuing.
[Switching to Thread 0x7f29841bc700 (LWP 6580)]
																							SELECT * FROM hero WHERE number = 15 FOR UPDATE;
Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7f2993520838, heap_no=5, index=0x5a744d0, thr=0x7f296c011568) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7f2993520838, heap_no=5, index=0x5a744d0, thr=0x7f296c011568) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7f2993520838, rec=0x7f29946c80ec "\200", index=0x5a744d0, offsets=0x7f29841b8ad0, mode=LOCK_X, gap_mode=1024, thr=0x7f296c011568) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
#2  0x0000000001a4651c in sel_set_rec_lock (pcur=0x7f296c010fe8, rec=0x7f29946c80ec "\200", index=0x5a744d0, offsets=0x7f29841b8ad0, mode=3, type=1024, thr=0x7f296c011568, mtr=0x7f29841b8df0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1254
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7f296c010250 "\374\017", mode=PAGE_CUR_GE, prebuilt=0x7f296c010dd0, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
#4  0x00000000018c1784 in ha_innobase::index_read (this=0x7f296c00fe40, buf=0x7f296c010250 "\374\017", key_ptr=0x7f296c007e88 "\017", key_len=4, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
#5  0x0000000000f39602 in handler::index_read_map (this=0x7f296c00fe40, buf=0x7f296c010250 "\374\017", key=0x7f296c007e88 "\017", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
#6  0x0000000000f35421 in handler::index_read_idx_map (this=0x7f296c00fe40, buf=0x7f296c010250 "\374\017", index=0, key=0x7f296c007e88 "\017", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:7590
#7  0x0000000000f2ba86 in handler::ha_index_read_idx_map (this=0x7f296c00fe40, buf=0x7f296c010250 "\374\017", index=0, key=0x7f296c007e88 "\017", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3091
#8  0x00000000014eedd1 in read_const (table=0x7f296c00f480, ref=0x7f296c01cd98) at /usr/local/mysql/sql/sql_executor.cc:2013
#9  0x00000000014ee8b4 in join_read_const_table (tab=0x7f296c01ccc8, pos=0x7f296c01ce40) at /usr/local/mysql/sql/sql_executor.cc:1898
#10 0x000000000151a6ef in JOIN::extract_func_dependent_tables (this=0x7f296c01c8f0) at /usr/local/mysql/sql/sql_optimizer.cc:5594
#11 0x0000000001519191 in JOIN::make_join_plan (this=0x7f296c01c8f0) at /usr/local/mysql/sql/sql_optimizer.cc:5058
#12 0x000000000150db30 in JOIN::optimize (this=0x7f296c01c8f0) at /usr/local/mysql/sql/sql_optimizer.cc:368
#13 0x0000000001585390 in st_select_lex::optimize (this=0x7f296c005f40, thd=0x7f296c0011c0) at /usr/local/mysql/sql/sql_select.cc:1009
#14 0x0000000001583aec in handle_query (thd=0x7f296c0011c0, lex=0x7f296c0034e0, result=0x7f296c007738, added_options=0, removed_options=0) at /usr/local/mysql/sql/sql_select.cc:164
#15 0x000000000153996f in execute_sqlcom_select (thd=0x7f296c0011c0, all_tables=0x7f296c006e30) at /usr/local/mysql/sql/sql_parse.cc:5144
#16 0x000000000153339d in mysql_execute_command (thd=0x7f296c0011c0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:2816
#17 0x000000000153a849 in mysql_parse (thd=0x7f296c0011c0, parser_state=0x7f29841bb690) at /usr/local/mysql/sql/sql_parse.cc:5570
#18 0x00000000015302d8 in dispatch_command (thd=0x7f296c0011c0, com_data=0x7f29841bbdf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#19 0x000000000152f20c in do_command (thd=0x7f296c0011c0) at /usr/local/mysql/sql/sql_parse.cc:1025
#20 0x000000000165f7c8 in handle_connection (arg=0x3d33690) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#21 0x0000000001ce7612 in pfs_spawn_thread (arg=0x3d7fae0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#22 0x00007f29abac5ea5 in start_thread () from /lib64/libpthread.so.0
#23 0x00007f29aa98b9fd in clone () from /lib64/libc.so.6

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------



(gdb) b lock_rec_lock
Breakpoint 2 at 0x1943577: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 2040.
																					begin;
(gdb) c
Continuing.
[Switching to Thread 0x7f29841bc700 (LWP 6580)]
																					UPDATE hero SET name = '曹操' WHERE number = 8;

Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7f2993520838, heap_no=7, index=0x5a744d0, thr=0x7f296c011568) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
2040		ut_ad(lock_mutex_own());
(gdb) bt
#0  lock_rec_lock (impl=false, mode=1027, block=0x7f2993520838, heap_no=7, index=0x5a744d0, thr=0x7f296c011568) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7f2993520838, rec=0x7f29946c8132 "\200", index=0x5a744d0, offsets=0x7f29841b8880, mode=LOCK_X, gap_mode=1024, thr=0x7f296c011568) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
#2  0x0000000001a4651c in sel_set_rec_lock (pcur=0x7f296c010fe8, rec=0x7f29946c8132 "\200", index=0x5a744d0, offsets=0x7f29841b8880, mode=3, type=1024, thr=0x7f296c011568, mtr=0x7f29841b8ba0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1254
#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7f296c010250 "\377", mode=PAGE_CUR_GE, prebuilt=0x7f296c010dd0, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
#4  0x00000000018c1784 in ha_innobase::index_read (this=0x7f296c00fe40, buf=0x7f296c010250 "\377", key_ptr=0x7f296c427040 "\b", key_len=4, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
#5  0x0000000000f39602 in handler::index_read_map (this=0x7f296c00fe40, buf=0x7f296c010250 "\377", key=0x7f296c427040 "\b", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
#6  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x7f296c00fe40, buf=0x7f296c010250 "\377", key=0x7f296c427040 "\b", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
#7  0x0000000000f34e8f in handler::read_range_first (this=0x7f296c00fe40, start_key=0x7f296c00ff28, end_key=0x7f296c00ff48, eq_range_arg=true, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x7f296c00fe40, range_info=0x7f29841b9c30) at /usr/local/mysql/sql/handler.cc:6450
#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7f296c0100a0, range_info=0x7f29841b9c30) at /usr/local/mysql/sql/handler.cc:6837
#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7f296c00fe40, range_info=0x7f29841b9c30) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7f296c00ee40) at /usr/local/mysql/sql/opt_range.cc:11233
#12 0x0000000001457dba in rr_quick (info=0x7f29841b9dd0) at /usr/local/mysql/sql/records.cc:398
#13 0x00000000015e7b84 in mysql_update (thd=0x7f296c0011c0, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7f29841ba428, updated_return=0x7f29841ba420) at /usr/local/mysql/sql/sql_update.cc:812
#14 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7f296c006e18, thd=0x7f296c0011c0, switch_to_multitable=0x7f29841ba4cf) at /usr/local/mysql/sql/sql_update.cc:2891
#15 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7f296c006e18, thd=0x7f296c0011c0) at /usr/local/mysql/sql/sql_update.cc:3018
#16 0x00000000015351f1 in mysql_execute_command (thd=0x7f296c0011c0, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
#17 0x000000000153a849 in mysql_parse (thd=0x7f296c0011c0, parser_state=0x7f29841bb690) at /usr/local/mysql/sql/sql_parse.cc:5570
#18 0x00000000015302d8 in dispatch_command (thd=0x7f296c0011c0, com_data=0x7f29841bbdf0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#19 0x000000000152f20c in do_command (thd=0x7f296c0011c0) at /usr/local/mysql/sql/sql_parse.cc:1025
#20 0x000000000165f7c8 in handle_connection (arg=0x3d33690) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#21 0x0000000001ce7612 in pfs_spawn_thread (arg=0x3d7fae0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#22 0x00007f29abac5ea5 in start_thread () from /lib64/libpthread.so.0
#23 0x00007f29aa98b9fd in clone () from /lib64/libc.so.6


(gdb) n
2041		ut_ad(!srv_read_only_mode);
(gdb) n
2042		ut_ad((LOCK_MODE_MASK & mode) != LOCK_S
(gdb) n
2044		ut_ad((LOCK_MODE_MASK & mode) != LOCK_X
(gdb) n
2046		ut_ad((LOCK_MODE_MASK & mode) == LOCK_S
(gdb) n
2048		ut_ad(mode - (LOCK_MODE_MASK & mode) == LOCK_GAP
(gdb) n
2051		ut_ad(dict_index_is_clust(index) || !dict_index_is_online_ddl(index));
(gdb) n
2055		switch (lock_rec_lock_fast(impl, mode, block, heap_no, index, thr)) {      -- 快速加锁
(gdb) n
2059			return(DB_SUCCESS_LOCKED_REC);    -- 加锁成功。
(gdb) n
2067	}
(gdb) n
lock_clust_rec_read_check_and_lock (flags=0, block=0x7f2993520838, rec=0x7f29946c8132 "\200", index=0x5a744d0, offsets=0x7f29841b8880, mode=LOCK_X, gap_mode=1024, thr=0x7f296c011568) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6416
6416		MONITOR_INC(MONITOR_NUM_RECLOCK_REQ);
(gdb) n
6418		lock_mutex_exit();
(gdb) n
6420		ut_ad(lock_rec_queue_validate(FALSE, block, rec, index, offsets));
(gdb) n
6422		DEBUG_SYNC_C("after_lock_clust_rec_read_check_and_lock");
(gdb) n
6424		return(err);
(gdb) n
6425	}
(gdb) n
sel_set_rec_lock (pcur=0x7f296c010fe8, rec=0x7f29946c8132 "\200", index=0x5a744d0, offsets=0x7f29841b8880, mode=3, type=1024, thr=0x7f296c011568, mtr=0x7f29841b8ba0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1273
1273		return(err);
(gdb) n
1274	}
(gdb) n
row_search_mvcc (buf=0x7f296c010250 "\377", mode=PAGE_CUR_GE, prebuilt=0x7f296c010dd0, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5526
5526			switch (err) {
(gdb) n
5529				if (srv_locks_unsafe_for_binlog

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

session A   							session B 														session C
mysql> begin;
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT * FROM hero WHERE name = 'c曹操' LOCK IN SHARE MODE;
+--------+---------+---------+
| number | name    | country |
+--------+---------+---------+
|      8 | c曹操   | 魏      |
+--------+---------+---------+
1 row in set (0.00 sec)



										(gdb) b lock_rec_lock
										Breakpoint 2 at 0x1943577: file /usr/local/mysql/storage/innobase/lock/lock0lock.cc, line 2040.
																										begin;	
										(gdb) c
										Continuing.
										[Switching to Thread 0x7f298413a700 (LWP 6582)]
																										UPDATE hero SET name = '曹操' WHERE number = 8;

										Breakpoint 2, lock_rec_lock (impl=false, mode=1027, block=0x7f2993520838, heap_no=8, index=0x5a744d0, thr=0x7f2968011368) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
										2040		ut_ad(lock_mutex_own());
										(gdb) bt
										#0  lock_rec_lock (impl=false, mode=1027, block=0x7f2993520838, heap_no=8, index=0x5a744d0, thr=0x7f2968011368) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
										#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7f2993520838, rec=0x7f29946c8155 "\200", index=0x5a744d0, offsets=0x7f2984136880, mode=LOCK_X, gap_mode=1024, thr=0x7f2968011368) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
										#2  0x0000000001a4651c in sel_set_rec_lock (pcur=0x7f2968010de8, rec=0x7f29946c8155 "\200", index=0x5a744d0, offsets=0x7f2984136880, mode=3, type=1024, thr=0x7f2968011368, mtr=0x7f2984136ba0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1254
										#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7f2968010050 "\377", mode=PAGE_CUR_GE, prebuilt=0x7f2968010bd0, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
										#4  0x00000000018c1784 in ha_innobase::index_read (this=0x7f296800fc40, buf=0x7f2968010050 "\377", key_ptr=0x7f296801d7e0 "\b", key_len=4, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
										#5  0x0000000000f39602 in handler::index_read_map (this=0x7f296800fc40, buf=0x7f2968010050 "\377", key=0x7f296801d7e0 "\b", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.h:2809
										#6  0x0000000000f2b3c0 in handler::ha_index_read_map (this=0x7f296800fc40, buf=0x7f2968010050 "\377", key=0x7f296801d7e0 "\b", keypart_map=1, find_flag=HA_READ_KEY_EXACT) at /usr/local/mysql/sql/handler.cc:3039
										#7  0x0000000000f34e8f in handler::read_range_first (this=0x7f296800fc40, start_key=0x7f296800fd28, end_key=0x7f296800fd48, eq_range_arg=true, sorted=true) at /usr/local/mysql/sql/handler.cc:7383
										#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x7f296800fc40, range_info=0x7f2984137c30) at /usr/local/mysql/sql/handler.cc:6450
										#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7f296800fea0, range_info=0x7f2984137c30) at /usr/local/mysql/sql/handler.cc:6837
										#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7f296800fc40, range_info=0x7f2984137c30) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
										#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7f296800ea10) at /usr/local/mysql/sql/opt_range.cc:11233
										#12 0x0000000001457dba in rr_quick (info=0x7f2984137dd0) at /usr/local/mysql/sql/records.cc:398
										#13 0x00000000015e7b84 in mysql_update (thd=0x7f2968001590, fields=..., values=..., limit=18446744073709551615, handle_duplicates=DUP_ERROR, found_return=0x7f2984138428, updated_return=0x7f2984138420) at /usr/local/mysql/sql/sql_update.cc:812
										#14 0x00000000015edf22 in Sql_cmd_update::try_single_table_update (this=0x7f2968006d58, thd=0x7f2968001590, switch_to_multitable=0x7f29841384cf) at /usr/local/mysql/sql/sql_update.cc:2891
										#15 0x00000000015ee453 in Sql_cmd_update::execute (this=0x7f2968006d58, thd=0x7f2968001590) at /usr/local/mysql/sql/sql_update.cc:3018
										#16 0x00000000015351f1 in mysql_execute_command (thd=0x7f2968001590, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3606
										#17 0x000000000153a849 in mysql_parse (thd=0x7f2968001590, parser_state=0x7f2984139690) at /usr/local/mysql/sql/sql_parse.cc:5570
										#18 0x00000000015302d8 in dispatch_command (thd=0x7f2968001590, com_data=0x7f2984139df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
										#19 0x000000000152f20c in do_command (thd=0x7f2968001590) at /usr/local/mysql/sql/sql_parse.cc:1025
										#20 0x000000000165f7c8 in handle_connection (arg=0x3d33690) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
										#21 0x0000000001ce7612 in pfs_spawn_thread (arg=0x3d7ed10) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
										#22 0x00007f29abac5ea5 in start_thread () from /lib64/libpthread.so.0
										#23 0x00007f29aa98b9fd in clone () from /lib64/libc.so.6
										(gdb) n
										2041		ut_ad(!srv_read_only_mode);
										(gdb) n
										2042		ut_ad((LOCK_MODE_MASK & mode) != LOCK_S
										(gdb) n
										2044		ut_ad((LOCK_MODE_MASK & mode) != LOCK_X
										(gdb) n
										2046		ut_ad((LOCK_MODE_MASK & mode) == LOCK_S
										(gdb) n
										2048		ut_ad(mode - (LOCK_MODE_MASK & mode) == LOCK_GAP
										(gdb) n
										2051		ut_ad(dict_index_is_clust(index) || !dict_index_is_online_ddl(index));
										(gdb) n
										2055		switch (lock_rec_lock_fast(impl, mode, block, heap_no, index, thr)) {
										(gdb) n
										2062						  heap_no, index, thr));
										(gdb) n
										2067	}
										(gdb) n
										lock_clust_rec_read_check_and_lock (flags=0, block=0x7f2993520838, rec=0x7f29946c8155 "\200", index=0x5a744d0, offsets=0x7f2984136880, mode=LOCK_X, gap_mode=1024, thr=0x7f2968011368) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6416
										6416		MONITOR_INC(MONITOR_NUM_RECLOCK_REQ);
										(gdb) n
										6418		lock_mutex_exit();
										(gdb) n
										6420		ut_ad(lock_rec_queue_validate(FALSE, block, rec, index, offsets));
										(gdb) n
										6422		DEBUG_SYNC_C("after_lock_clust_rec_read_check_and_lock");
										(gdb) n
										6424		return(err);
										(gdb) n
										6425	}
										(gdb) n
										sel_set_rec_lock (pcur=0x7f2968010de8, rec=0x7f29946c8155 "\200", index=0x5a744d0, offsets=0x7f2984136880, mode=3, type=1024, thr=0x7f2968011368, mtr=0x7f2984136ba0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1273
										1273		return(err);
										(gdb) n
										1274	}
										(gdb) n
										row_search_mvcc (buf=0x7f2968010050 "\377", mode=PAGE_CUR_GE, prebuilt=0x7f2968010bd0, match_mode=1, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5526
										5526			switch (err) {


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

InnoDB的锁实现
lock0types.h   事务锁系统的类型定义，包含了 lock_mode定义

lock0priv.ic   锁模块内部的一些方法，被用于除了lock0lock.cc的三个文件里，

lock_get_type_low 获取锁是表锁还是行锁

lock_clust_rec_some_has_impl 检查一行数据上是否有隐示的x锁
lock_rec_get_n_bits 获取一个记录锁的锁位图的bit数目
lock_rec_set_nth_bit 设置第n个记录锁bit位为true
lock_rec_get_next_on_page 获取当前page上的下一个记录锁
lock_rec_get_next_on_page_const 
lock_rec_get_first_on_page_addr 获取当前page上第一个记录锁
lock_rec_get_first_on_page
lock_rec_get_next  返回当前记录上的下一个显示锁请求的锁
lock_rec_get_next_const
lock_rec_get_first 获取当前记录上的第一个显示锁请求的锁
lock_rec_get_nth_bit    Gets the nth bit of a record lock.
lock_get_mode  获取一个锁的 lock_mode
lock_mode_compatible  判断两个lock_mode是否兼容
lock_mode_stronger_or_eq 判断lock_mode 1 是否比 lock_mode 2更强
lock_get_wait 判断一个锁是不是等待锁
lock_rec_find_similar_on_page  查找一个合适的锁结构在当前事务当前页面下？？？找到的话就不用新创建锁结构？？？
lock_table_has  检查一个事务是否有指定类型的表锁，只能由当前事务调用

lock0priv.h  锁模块内部的结构和方法

struct lock_table_t   表锁结构
struct lock_rec_t   行锁结构
struct lock_t 锁通用结构
static const byte lock_compatibility_matrix[5][5]  锁的兼容关系
static const byte lock_strength_matrix[5][5] 锁的强弱关系
enum lock_rec_req_status 记录锁请求状态
struct RecID  记录锁ID
class RecLock   记录锁类
add_to_waitq   入队一个锁等待
create   为事务创建一个锁并初始化
is_on_row  Check of the lock is on m_rec_id.
lock_alloc 创建锁实例
prepare 做一些检查个预处理为创建一个记录锁
mark_trx_for_rollback 收集需要异步回滚的事务
jump_queue   跳过所有低优先级事务并添加锁，如果能授予锁，则授予，不能的话把其他都标记异步回滚
lock_add   添加一个记录锁到事务锁列表和锁hash表中
deadlock_check 检查并解决死锁
check_deadlock_result  检查死锁检查的结果
is_predicate_lock  返回时不是predictate锁
init 按照要求设置上下文
lock_get_type_low 返回行锁还是表锁
lock_rec_get_prev 获取一个记录上的前一个锁
