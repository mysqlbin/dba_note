 match_mode=0：范围查询
 match_mode=1：等值查询

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


		

5. 行锁加锁流程(lock_rec_lock)
	ha_innobase::index_read
		->row_search_mvcc
			->sel_set_rec_lock
				->lock_clust_rec_read_check_and_lock
					->lock_rec_lock
	(gdb) bt
	#0  lock_rec_lock (impl=false, mode=1026, block=0x7f2993520838, heap_no=2, index=0x5a744d0, thr=0x7f296c011568) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:2040
	#1  0x000000000194dcd5 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7f2993520838, rec=0x7f29946c8080 "\200", index=0x5a744d0, offsets=0x7f29841b8d80, mode=LOCK_S, gap_mode=1024, thr=0x7f296c011568) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6414
	#2  0x0000000001a4651c in sel_set_rec_lock (pcur=0x7f296c010fe8, rec=0x7f29946c8080 "\200", index=0x5a744d0, offsets=0x7f29841b8d80, mode=2, type=1024, thr=0x7f296c011568, mtr=0x7f29841b90a0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:1254
	#3  0x0000000001a4f23c in row_search_mvcc (buf=0x7f296c010250 "\377", mode=PAGE_CUR_G, prebuilt=0x7f296c010dd0, match_mode=0, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5524
	#4  0x00000000018c1784 in ha_innobase::index_read (this=0x7f296c00fe40, buf=0x7f296c010250 "\377", key_ptr=0x0, key_len=0, find_flag=HA_READ_AFTER_KEY) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#5  0x00000000018c27ba in ha_innobase::index_first (this=0x7f296c00fe40, buf=0x7f296c010250 "\377") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:9157
	#6  0x0000000000f2c4b3 in handler::ha_index_first (this=0x7f296c00fe40, buf=0x7f296c010250 "\377") at /usr/local/mysql/sql/handler.cc:3193


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
	
	
	sel_set_rec_lock 
		在加锁前会检测死锁，锁等待等情况。
		在加锁时会复用事务之前创建的bitmap或创建新的bitmap，然后调用lock_rec_set_nth_bit根据行的heap_no设置bitmap中相应的位。

	lock_clust_rec_read_check_and_lock
		检查是否有锁堵塞，并对主键索引进行加锁
		
	lock_rec_lock
	
		行锁加锁流程

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
			3. 返回错误码，对于DB_LOCK_WAIT, DB_DEADLOCK 等错误码，会在上层进行处理。

		http://mysql.taobao.org/monthly/2016/01/01/



6. 相关参考
		
	http://mysql.taobao.org/monthly/2016/01/01/
	
	https://segmentfault.com/a/1190000017076101
	
	https://blog.csdn.net/fly43108622/article/details/89473828

	https://blog.csdn.net/weixin_28733651/article/details/113287018	mysql锁兼容矩阵_InnoDB行锁兼容性矩阵

	https://zhuanlan.zhihu.com/p/139489272	MySQL Innodb行锁剖析

	https://blog.csdn.net/zxz1580977728/article/details/109400915	【数据库篇】MySQL源码分析之row_search_mvcc详细分析（Page加载及索引分析）

	https://developer.aliyun.com/article/594724	 MySQL · 引擎分析 · InnoDB行锁分析









----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------



7.4 锁阻塞的断点

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
