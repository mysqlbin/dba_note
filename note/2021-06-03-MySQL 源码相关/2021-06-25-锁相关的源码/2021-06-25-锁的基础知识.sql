

1. InnoDB锁结构实现
2. InnoDB锁定读实现
3. ha_innobase::index_read 函数实现如下
4. 行锁加锁流程(lock_rec_lock)
5. prebuilt->select_lock_type

 
1. InnoDB锁结构实现
	
	match_mode
		match_mode=0：范围查询
		match_mode=1：等值查询

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
			lock_t*		hash;		/* 由于所有的锁都是存储在一个内存的HASH结构中 */
												/* 因此此字段表示单链表下一个结构，解决冲突 */
			union {
				lock_table_t	tab_lock;/* 表锁 */
				lock_rec_t	rec_lock;/* 行锁 */
			} un_member;			/* 锁由于一个UNION存储 */
			ib_uint32_t	type_mode;	/* 用于存储锁类型，锁模式，锁标记等 */
		};
		
		/** 表锁定义 */
		struct lock_table_t {
			dict_table_t*	table;		/*!< database table in dictionary
							cache */
			UT_LIST_NODE_T(lock_t)
					locks;		/*!< list of locks on the same
							table */
			/** Print the table lock into the given output stream
			@param[in,out]	out	the output stream
			@return the given output stream. */
			std::ostream& print(std::ostream& out) const;
};

		/* 行锁定义 */
		struct lock_rec_t {
			ib_uint32_t	space;		/* 表空间ID */
			ib_uint32_t	page_no;	/* 页号 */
			ib_uint32_t	n_bits;		/* 锁位图大小，并且位图是放在lock_t结构之后的 */
		};



	/* The following is parameter to ha_rkey() how to use key */

	/*
	  We define a complete-field prefix of a key value as a prefix where
	  the last included field in the prefix contains the full field, not
	  just some bytes from the start of the field. A partial-field prefix
	  is allowed to contain only a few first bytes from the last included
	  field.

	  Below HA_READ_KEY_EXACT, ..., HA_READ_BEFORE_KEY can take a
	  complete-field prefix of a key value as the search
	  key. HA_READ_PREFIX and HA_READ_PREFIX_LAST could also take a
	  partial-field prefix, but currently (4.0.10) they are only used with
	  complete-field prefixes. MySQL uses a padding trick to implement
	  LIKE 'abc%' queries.

	  NOTE that in InnoDB HA_READ_PREFIX_LAST will NOT work with a
	  partial-field prefix because InnoDB currently strips spaces from the
	  end of varchar fields!
	*/

	enum ha_rkey_function {
	  HA_READ_KEY_EXACT,              /* Find first record else error */
	  HA_READ_KEY_OR_NEXT,            /* Record or next record */
	  HA_READ_KEY_OR_PREV,            /* Record or previous */
	  HA_READ_AFTER_KEY,              /* Find next rec. after key-record */
	  HA_READ_BEFORE_KEY,             /* Find next rec. before key-record */
	  HA_READ_PREFIX,                 /* Key which as same prefix */
	  HA_READ_PREFIX_LAST,            /* Last key with the same prefix */
	  HA_READ_PREFIX_LAST_OR_PREV,    /* Last or prev key with the same prefix */
	  HA_READ_MBR_CONTAIN,            /* Minimum Bounding Rectangle contains */
	  HA_READ_MBR_INTERSECT,          /* Minimum Bounding Rectangle intersect */
	  HA_READ_MBR_WITHIN,             /* Minimum Bounding Rectangle within */
	  HA_READ_MBR_DISJOINT,           /* Minimum Bounding Rectangle disjoint */
	  HA_READ_MBR_EQUAL,              /* Minimum Bounding Rectangle equal */
	  HA_READ_INVALID= -1             /* Invalid enumeration value, always last. */
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





4. 行锁加锁流程(lock_rec_lock)

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

		
	加行级锁

		行级锁加锁的入口函数为 lock_rec_lock ，其中第一个参数impl如果为TRUE，则当当前记录上已有的锁和LOCK_X | LOCK_REC_NOT_GAP不冲突时，就无需创建锁对象。
		（见上文关于记录锁LOCK_X相关描述部分），为了描述清晰，下文的流程描述，默认impl为FALSE。

		lock_rec_lock：

			1. 首先尝试fast lock的方式，对于冲突少的场景，这是比较普通的加锁方式(lock_rec_lock_fast), 符合如下情况时，可以走fast lock:
				1.1 记录所在的page上没有任何记录锁时，直接创建锁对象，加入rec_hash，并返回成功;
				1.2 记录所在的page上只存在一个记录锁，并且属于当前事务，且这个记录锁预分配的bitmap能够描述当前的heap no（预分配的bit数为创建锁对象时的page上记录数 + 64，
					参阅函数 RecLock::lock_size ），则直接设置对应的bit位并返回;
			
			2. 无法走fast lock时，再调用slow lock的逻辑(lock_rec_lock_slow)
			
				2.1 判断当前事务是否已经持有了一个优先级更高的锁，如果是的话，直接返回成功（lock_rec_has_expl）;
				2.2 检查是否存在和当前申请锁模式冲突的锁（lock_rec_other_has_conflicting），如果存在的话，就创建一个锁对象（RecLock::RecLock），并加入到等待队列中（RecLock::add_to_waitq），这里会进行死锁检测;
				2.3 如果没有冲突的锁，则入队列（lock_rec_add_to_queue）：
					已经有在同一个Page上的锁对象且没有别的会话等待相同的heap no时，可以直接设置对应的bitmap（lock_rec_find_similar_on_page）；否则需要创建一个新的锁对象;
					
				参考函数：lock_rec_lock_slow
				
			3. 返回错误码，对于DB_LOCK_WAIT, DB_DEADLOCK 等错误码，会在上层进行处理。
			
		http://mysql.taobao.org/monthly/2016/01/01/



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



5. prebuilt->select_lock_type
	
	ulint		select_lock_type;/*!< LOCK_NONE, LOCK_S, or LOCK_X */
	
	prebuilt->select_lock_type表示加锁的类型：
		LOCK_NONE   表示不加锁
		LOCK_S      表示加S锁（比方说执行SELECT ... LOCK IN SHARE MODE时）
		LOCK_X      表示加X锁（比方说执行SELECT ... FOR UPDATE、DELETE、UPDATE时）。



