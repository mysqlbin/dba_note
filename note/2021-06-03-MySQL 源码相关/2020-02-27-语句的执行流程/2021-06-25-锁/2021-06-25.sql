

row_search_mvcc
PHASE 1: Try to pop the row from the prefetch cache 
PHASE 2:  Try fast adaptive hash index search if possible 
PHASE 3: Open or restore index cursor position
PHASE 4: Test search end conditions and deleted flag
PHASE 5: Move the cursor to the next index record 


if (match_mode == ROW_SEL_EXACT) {    --等值查询
	
	/* Try to place a gap lock on the index record only if innodb_locks_unsafe_for_binlog option is not set or this session is not using a READ COMMITTED isolation level */
	
	仅当 innodb_locks_unsafe_for_binlog 选项未设置或此会话未使用 READ COMMITTED 隔离级别时，才尝试在索引记录上放置间隙锁
	如何解决幻读的:
		1、MySQL在RR隔离级别引入gap lock，把2条记录中间的gap锁住，避免其他事务写入(例如在二级索引上锁定记录1-3之间的gap，那么其他会话无法在这个gap间插入数据)
		2、MySQL出现幻读的条件是隔离级别<=RC，或者 innodb_locks_unsafe_for_binlog=1(8.0已取消该选项)

} else if (match_mode == ROW_SEL_EXACT_PREFIX) {

}

if (prebuilt->select_lock_type != LOCK_NONE) {
	
	
	     /* 锁定义，需要根据 lock_type 加相应的锁 */
		ulint	lock_type;;
		
		if (!set_also_gap_locks
		    || srv_locks_unsafe_for_binlog
		    || trx->isolation_level <= TRX_ISO_READ_COMMITTED
		    || (unique_search && !rec_get_deleted_flag(rec, comp))
		    || dict_index_is_spatial(index)) {
			
			/* 唯一查询，加LOCK_REC_NOT_GAP锁 */
			goto no_gap_lock;
		} else {
			-- 锁的类型为next-key lock
			lock_type = LOCK_ORDINARY;
		}

		
			
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

}









An example: if col1 is the primary key, the search is WHERE
		col1 >= 100, and we find a record where col1 = 100, then no
		need to lock the gap before that record
		
		-- 那么不需要锁定该记录之前的间隙
		
		
http://mysql.taobao.org/monthly/2016/01/01/
https://segmentfault.com/a/1190000017076101
https://zhuanlan.zhihu.com/p/56519305	 MySQL · 引擎分析 · InnoDB行锁分析
https://blog.csdn.net/fly43108622/article/details/89473828

https://blog.csdn.net/weixin_28733651/article/details/113287018	mysql锁兼容矩阵_InnoDB行锁兼容性矩阵

https://zhuanlan.zhihu.com/p/139489272	MySQL Innodb行锁剖析

https://blog.csdn.net/zxz1580977728/article/details/109400915	【数据库篇】MySQL源码分析之row_search_mvcc详细分析（Page加载及索引分析）




drop table if exists hero;
CREATE TABLE hero (
	number INT,
	name VARCHAR(100),
	country varchar(100),
	PRIMARY KEY (number),
	KEY idx_name (name)
) Engine=InnoDB CHARSET=utf8mb4;

死锁检测函数列表A row_search_for_mysql(搜索行)

死锁检测函数列表B sel_set_rec_lock(判断是二级索引还是主键,然后对行加锁)

死锁检测函数列表C lock_clust_rec_read_check_and_lock(检查有锁堵塞)

死锁检测函数列表D lock_rec_lock 处理逻辑（检测锁的兼容性)

死锁检测函数列表E lock_rec_lock_slow处理逻辑(确认申请不到锁)

死锁检测函数列表F lock_rec_enqueue_waiting

死锁检测函数列表G lock_deadlock_check_and_resolve处理逻辑

死锁检测函数列表H lock_deadlock_search函数代码处理逻辑

死锁检测函数列表I lock_get_first_lock 处理逻辑(第一个锁比较)

死锁检测函数列表J lock_get_next_lock 函数代码处理逻辑(获取锁继续比较)


https://mp.weixin.qq.com/s/13d4bST9jqlQjMSogS37Bw	

我们一个个来看这些函数的主要作用 

你可以通过GDB，断点函数 lock_rec_lock 来查看某条SQL如何执行加锁操作。
b lock_rec_lock

行级锁加锁的入口函数为 lock_rec_lock，其中第一个参数 impl 如果为 TRUE ，则当当前记录上已有的锁和LOCK_X | LOCK_REC_NOT_GAP不冲突时，就无需创建锁对象。



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
