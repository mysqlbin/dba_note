

1. 延迟加锁机制
2. 在 lock_rec_convert_impl_to_expl 函数位置打断点

1. 延迟加锁机制

	如果一个表有很多的索引，那么操作一个记录时，岂不是要加很多锁到不同的B-Tree上吗？
	先来看一个事务的状态信息:
	
		drop table if exists t11 ;
		CREATE TABLE `t11` (
		  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
		  `t1` int(10) NOT NULL COMMENT '',
		  `t2` int(10) NOT NULL COMMENT '',
		  `order_no` varchar(64) NOT NULL DEFAULT '' COMMENT 'order no',
		  `status` int(10) NOT NULL COMMENT '',
		  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
		  PRIMARY KEY (`ID`),
		  KEY `idx_order_no` (`order_no`),
		  KEY `idx_status` (`status`)
		) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='';

		begin;
		INSERT INTO `t11` (`ID`, `t1`, `t2`, `order_no`, `status`, `createtime`) VALUES ('1', '1', '1', '123456', '0', '2020-04-23 17:28:45');
			
		show engine innodb status\G;的状态信息:
		---TRANSACTION 68877, ACTIVE 3 sec
		1 lock struct(s), heap size 1160, 0 row lock(s), undo log entries 1
		MySQL thread id 3, OS thread handle 139658956588800, query id 19 localhost root
	
	
		-- 同时验证了Insert语句不加锁。


	隐式锁
		Lock 是一种悲观的顺序化机制。它假设很可能发生冲突，因此在操作数据时，就加锁。
		如果冲突的可能性很小，多数的锁都是不必要的。 --减少加锁操作，减少资源消耗，加快SQL语句的执行速度。

		Innodb 实现了一个延迟加锁的机制，来减少加锁的数量，在代码中称为隐式锁(Implicit Lock)。
		
		隐式锁中有个重要的元素,事务ID（trx_id).隐式锁的逻辑过程如下：
			A. InnoDB的每条记录中都一个隐含的trx_id字段，这个字段存在于簇索引的B+Tree中。
			B. 在操作一条记录前，首先根据记录中的trx_id检查该事务是否是活动的事务(未提交或回滚).
			 如果是活动的事务，首先将隐式锁转换为显式锁(就是为该事务添加一个锁)。
			C. 检查是否有锁冲突，如果有冲突，创建锁，并设置为waiting状态。如果没有冲突不加锁,跳到E。
			D. 等待加锁成功，被唤醒，或者超时。
			E. 写数据，并将自己的trx_id写入trx_id字段。Page Lock可以保证操作的正确性。

	相关代码：
		A. lock_rec_convert_impl_to_expl()将隐式锁转换成显示锁。
		B. 加锁和测试行锁冲突都用lock_rec_lock(),它的第一个参数表示是否是隐式锁。所以要特别注意这个参数。如果为TRUE，在没有冲突时并不会加锁。
		C. 测试行锁的冲突的具体内容在lock_rec_has_wait()
		D. 创建waiting锁是lock_rec_enqueue_waiting()
		E. 创建行锁是lock_rec_add_to_queue()

	隐式锁的特点
	  A. 只有在很可能发生冲突时才加锁，减少了锁的数量。
	  B. 隐式锁是针对被修改的B+Tree记录，因此都是Record类型的锁。不可能是Gap或Next-Key类型。

	隐式锁的使用
	  A. INSERT操作只加隐式锁，不需要显示加锁。
	  B. UPDATE,DELETE在查询时，直接对查询用的Index和主键使用显示锁，其他索引上使用隐式锁。   
		 理论上说，可以对主键使用隐式锁的。提前使用显示锁应该是为了减少死锁的可能性。
		 INSERT，UPDATE，DELETE对B+Tree们的操作都是从主键的B+Tree开始，因此对主键加锁可以有效的阻止死锁。
			-- 先修改主键索引的数据，再修改二级索引的数据。
			
		--只对必要的索引加锁，原来这个叫隐式锁(implicit lock) ，参考笔记：
			《2020-04-24-5.7多个单列索引同一行记录的加锁规则问题.sql》
			《2020-04-24-8.0版本多个单列索引同一行记录的加锁规则问题.sql》
			
	----------------------------------------------------------------------------------------------------
	
	什么是隐式锁

		隐式锁的意思就是没有锁！
		InnoDB 在插入记录时，是不加锁的。
		如果事务 A 插入记录且未提交，这时事务 B 尝试对这条记录加锁，事务 B 会先去判断记录上保存的事务 id 是否活跃，如果活跃的话，那么就帮助事务 A 去建立一个锁对象，然后自身进入等待事务 A 状态，这就是所谓的隐式锁转换为显式锁。

	insert 加的是隐式锁。	
		
		执行 insert 语句，判断是否有和插入意向锁冲突的锁，如果有，加插入意向锁，进入锁等待；如果没有，直接写数据，不加任何锁；
		
		insert 加锁，执行 insert 之后，如果没有任何冲突，在 show engine innodb status 命令中是看不到任何锁的，这是因为 insert 加的是隐式锁。
		所以，根本就不存在之前说的先加插入意向锁，再加排他记录锁的说法，在执行 insert 语句时，什么锁都不会加。这就有点意思了，如果 insert 什么锁都不加，那么如果其他事务执行 select ... lock in share mode，它是如何阻止其他事务加锁的呢？
		
		执行 select ... lock in share mode 语句，判断记录上是否存在活跃的事务，如果存在，则为 insert 事务创建一个排他记录锁，并将自己加入到锁等待队列；



2. 在 lock_rec_convert_impl_to_expl 函数位置打断点

	mysql> select * from t3;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  0 |    0 |    0 |
	|  5 |    5 |    5 |
	| 10 |   10 |   10 |
	| 15 |   15 |   15 |
	| 20 |   20 |   20 |
	| 25 |   25 |   25 |
	+----+------+------+
	6 rows in set (0.00 sec)

	mysql> 
	mysql> show create table t3\G;
	*************************** 1. row ***************************
		   Table: t3
	Create Table: CREATE TABLE `t3` (
	  `id` int(11) NOT NULL,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
	1 row in set (0.04 sec)



	mysql> select * from t3 where c>=10 and c<11 for update;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	| 10 |   10 |   10 |
	+----+------+------+
	1 row in set (14.52 sec)


	(gdb) bt
	#0  lock_rec_convert_impl_to_expl (block=0x7f0103a46b60, rec=0x7f0104bf00bc "\200", index=0x7f010c043e80, offsets=0x7f011022ed60) at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6084
	#1  0x000000000194dbb1 in lock_clust_rec_read_check_and_lock (flags=0, block=0x7f0103a46b60, rec=0x7f0104bf00bc "\200", index=0x7f010c043e80, offsets=0x7f011022ed60, mode=LOCK_X, gap_mode=1024, thr=0x7f010c040c40)
		at /usr/local/mysql/storage/innobase/lock/lock0lock.cc:6404
	#2  0x0000000001a4b095 in row_sel_get_clust_rec_for_mysql (prebuilt=0x7f010c0404a0, sec_index=0x7f010c044a20, rec=0x7f0104be809a "\200", thr=0x7f010c040c40, out_rec=0x7f011022f5f0, offsets=0x7f011022f5c8, offset_heap=0x7f011022f5d0, vrow=0x0, mtr=0x7f011022f080)
		at /usr/local/mysql/storage/innobase/row/row0sel.cc:3649
	#3  0x0000000001a4f94a in row_search_mvcc (buf=0x7f010c03a380 "\375\n", mode=PAGE_CUR_GE, prebuilt=0x7f010c0404a0, match_mode=0, direction=0) at /usr/local/mysql/storage/innobase/row/row0sel.cc:5773
	#4  0x00000000018c1784 in ha_innobase::index_read (this=0x7f010c03a090, buf=0x7f010c03a380 "\375\n", key_ptr=0x7f010c03c8f0 "", key_len=5, find_flag=HA_READ_KEY_OR_NEXT) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:8740
	#5  0x0000000000f39602 in handler::index_read_map (this=0x7f010c03a090, buf=0x7f010c03a380 "\375\n", key=0x7f010c03c8f0 "", keypart_map=1, find_flag=HA_READ_KEY_OR_NEXT) at /usr/local/mysql/sql/handler.h:2809
	#6  0x0000000000f2b457 in handler::ha_index_read_map (this=0x7f010c03a090, buf=0x7f010c03a380 "\375\n", key=0x7f010c03c8f0 "", keypart_map=1, find_flag=HA_READ_KEY_OR_NEXT) at /usr/local/mysql/sql/handler.cc:3039
	#7  0x0000000000f34e8f in handler::read_range_first (this=0x7f010c03a090, start_key=0x7f010c03a178, end_key=0x7f010c03a198, eq_range_arg=false, sorted=false) at /usr/local/mysql/sql/handler.cc:7383
	#8  0x0000000000f32dd1 in handler::multi_range_read_next (this=0x7f010c03a090, range_info=0x7f0110230110) at /usr/local/mysql/sql/handler.cc:6450
	#9  0x0000000000f33c8c in DsMrr_impl::dsmrr_next (this=0x7f010c03a2f0, range_info=0x7f0110230110) at /usr/local/mysql/sql/handler.cc:6837
	#10 0x00000000018d379c in ha_innobase::multi_range_read_next (this=0x7f010c03a090, range_info=0x7f0110230110) at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:20582
	#11 0x000000000171887c in QUICK_RANGE_SELECT::get_next (this=0x7f010c037a70) at /usr/local/mysql/sql/opt_range.cc:11233
	#12 0x0000000001457dba in rr_quick (info=0x7f010c03b880) at /usr/local/mysql/sql/records.cc:398
	#13 0x00000000014f0090 in join_init_read_record (tab=0x7f010c03b830) at /usr/local/mysql/sql/sql_executor.cc:2497
	#14 0x00000000014ed267 in sub_select (join=0x7f010c03ac60, qep_tab=0x7f010c03b830, end_of_records=false) at /usr/local/mysql/sql/sql_executor.cc:1277
	#15 0x00000000014ecbfa in do_select (join=0x7f010c03ac60) at /usr/local/mysql/sql/sql_executor.cc:950
	#16 0x00000000014eab61 in JOIN::exec (this=0x7f010c03ac60) at /usr/local/mysql/sql/sql_executor.cc:199
	#17 0x0000000001583b64 in handle_query (thd=0x7f010c00a970, lex=0x7f010c00cc90, result=0x7f010c010fb8, added_options=0, removed_options=0) at /usr/local/mysql/sql/sql_select.cc:184
	#18 0x000000000153996f in execute_sqlcom_select (thd=0x7f010c00a970, all_tables=0x7f010c0103f0) at /usr/local/mysql/sql/sql_parse.cc:5144
	#19 0x000000000153339d in mysql_execute_command (thd=0x7f010c00a970, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:2816
	#20 0x000000000153a849 in mysql_parse (thd=0x7f010c00a970, parser_state=0x7f0110231690) at /usr/local/mysql/sql/sql_parse.cc:5570
	#21 0x00000000015302d8 in dispatch_command (thd=0x7f010c00a970, com_data=0x7f0110231df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
	#22 0x000000000152f20c in do_command (thd=0x7f010c00a970) at /usr/local/mysql/sql/sql_parse.cc:1025
	#23 0x000000000165f7c8 in handle_connection (arg=0x52b76e0) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
	#24 0x0000000001ce7612 in pfs_spawn_thread (arg=0x46c54b0) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
	#25 0x00007f011c54cea5 in start_thread () from /lib64/libpthread.so.0
	#26 0x00007f011b4129fd in clone () from /lib64/libc.so.6

	
	我们跟一下执行 select 时的流程，如果 select 需要加锁，则会走： sel_set_rec_lock -> lock_clust_rec_read_check_and_lock -> lock_rec_convert_impl_to_expl
	
	-- 如果事务在记录上具有隐式 x 锁，但没有在记录上设置显式 x 锁，则为其设置一个
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
			-- 如果事务仍然处于活动状态并且在记录上没有设置明确的 x 锁，则为其设置 1。在引用计数为零之前无法提交 trx
			/* If the transaction is still active and has no
			explicit x-lock set on the record, set one for it.
			trx cannot be committed until the ref count is zero. */

			lock_rec_convert_impl_to_expl_for_trx(
				block, rec, index, offsets, trx, heap_no);
		}
	}



	lock_rec_convert_impl_to_expl 针对的场景是：

		有A，B两个Client。A开启事务，然后插入一行记录，未提交事务。此时B开启事务，插入同样的一条记录，那么这时B查询到这行记录之前已被A插入了，并且A开始的事务还活跃，那么就会调用lock_rec_convert_impl_to_expl给A插入的记录加上一把X-LOCK。
		然后继续调用 lock_rec_lock 给此记录加上S-LOCK，然后就产生了LOCK_WAIT。
		https://zhuanlan.zhihu.com/p/139489272	
		
		
