
-1. trx_sys_t
0. InnoDB隐藏字段源码分析
1. read view 中主要包含4个比较重要的内容
2. 判断可见性的源码
3. row_search_mvcc和row_search_no_mvcc的入口函数
4. lock_clust_rec_cons_read_sees和row_vers_build_for_consistent_read
	4.1 row_search_mvcc->lock_clust_rec_cons_read_sees 判断可见性
	4.2 row_vers_build_for_consistent_read 构建undo历史版本
5. 相关参考


-1. trx_sys_t
	trx_sys_t是整个事务的管理系统，包括MVCC的控制模块和数据库所有的活跃事务，以及回滚段 rollback segments 管理。
	
	/* mysql-5.7.26\storage\innobase\include\trx0sys.h */
	struct trx_sys_t {

	
		MVCC*		mvcc;		/*!< Multi version concurrency control manager */
		volatile trx_id_t max_trx_id;	    /* 下一个事务被分配的ID */
						
		trx_ut_list_t	serialisation_list; /* 所有活跃的读写事务 */
						
		trx_id_t	rw_max_trx_id;	 		/* 活跃事务的最大ID */ 
		
		trx_ut_list_t	rw_trx_list;		/* 当前系统所有的读写事务，包括活跃的和已经提交的事务。崩溃恢复后产生的事务和系统的事务也放在上面。 */   

		trx_ut_list_t	mysql_trx_list;	    /* 所有用户创建的事务，系统的事务和奔溃恢复后的事务不会在这个链表上，但是这个链表上可能会有还没开始的用户事务。 */

		trx_ids_t	rw_trx_ids; 			/* 活跃的事务ID列表 */

	
		trx_rseg_t*	rseg_array[TRX_SYS_N_RSEGS];
						/*!< Pointer array to rollback
						segments; NULL if slot not in use;
						created and destroyed in
						single-threaded mode; not protected
						by any mutex, because it is read-only
						during multi-threaded operation */
		ulint		rseg_history_len;
						/*!< Length of the TRX_RSEG_HISTORY
						list (update undo logs for committed
						transactions), protected by
						rseg->mutex */

		trx_rseg_t*	const pending_purge_rseg_array[TRX_SYS_N_RSEGS];
						/*!< Pointer array to rollback segments
						between slot-1..slot-srv_tmp_undo_logs
						that are now replaced by non-redo
						rollback segments. We need them for
						scheduling purge if any of the rollback
						segment has pending records to purge. */

		TrxIdSet	rw_trx_set;	/*!< Mapping from transaction id
						to transaction instance */

		ulint		n_prepared_trx;	/*!< Number of transactions currently
						in the XA PREPARED state */

		ulint		n_prepared_recovered_trx; /*!< Number of transactions
						currently in XA PREPARED state that are
						also recovered. Such transactions cannot
						be added during runtime. They can only
						occur after recovery if mysqld crashed
						while there were XA PREPARED
						transactions. We disable query cache
						if such transactions exist. */
	};



0. InnoDB隐藏字段源码分析
	
	/* mysql-5.7.26\storage\innobase\dict\dict0dict.cc */

	/**********************************************************************//**
	Adds system columns to a table object. */
	void
	dict_table_add_system_columns(
	/*==========================*/
		dict_table_t*	table,	/*!< in/out: table */
		mem_heap_t*	heap)	/*!< in: temporary heap */
	{
		ut_ad(table);
		ut_ad(table->n_def ==
			  (table->n_cols - dict_table_get_n_sys_cols(table)));
		ut_ad(table->magic_n == DICT_TABLE_MAGIC_N);
		ut_ad(!table->cached);

		/* NOTE: the system columns MUST be added in the following order
		(so that they can be indexed by the numerical value of DATA_ROW_ID,
		etc.) and as the last columns of the table memory object.
		The clustered index will not always physically contain all system
		columns.
		Intrinsic table don't need DB_ROLL_PTR as UNDO logging is turned off
		for these tables. */

		dict_mem_table_add_col(table, heap, "DB_ROW_ID", DATA_SYS,
					   DATA_ROW_ID | DATA_NOT_NULL,
					   DATA_ROW_ID_LEN);

	#if (DATA_ITT_N_SYS_COLS != 2)
	#error "DATA_ITT_N_SYS_COLS != 2"
	#endif

	#if DATA_ROW_ID != 0
	#error "DATA_ROW_ID != 0"
	#endif
		dict_mem_table_add_col(table, heap, "DB_TRX_ID", DATA_SYS,
					   DATA_TRX_ID | DATA_NOT_NULL,
					   DATA_TRX_ID_LEN);
	#if DATA_TRX_ID != 1
	#error "DATA_TRX_ID != 1"
	#endif

		if (!dict_table_is_intrinsic(table)) {
			dict_mem_table_add_col(table, heap, "DB_ROLL_PTR", DATA_SYS,
						   DATA_ROLL_PTR | DATA_NOT_NULL,
						   DATA_ROLL_PTR_LEN);
	#if DATA_ROLL_PTR != 2
	#error "DATA_ROLL_PTR != 2"
	#endif

			/* This check reminds that if a new system column is added to
			the program, it should be dealt with here */
	#if DATA_N_SYS_COLS != 3
	#error "DATA_N_SYS_COLS != 3"
	#endif
		}
	}

1. read view 中主要包含4个比较重要的内容

	/*mysql-5.7.26\storage\innobase\read\read0read.cc*/
	
	/**
	ReadView constructor */
	ReadView::ReadView()
		:
		m_low_limit_id(),
		m_up_limit_id(),
		m_creator_trx_id(),
		m_ids(),
		m_low_limit_no()
	{
		ut_d(::memset(&m_view_list, 0x0, sizeof(m_view_list)));
	}


	/* mysql-5.7.26\storage\innobase\include\read0types.h */
	
	private:
		/** The read should not see any transaction with trx id >= this
		value. In other words, this is the "high water mark". */
		trx_id_t	m_low_limit_id;

		/** The read should see all trx ids which are strictly
		smaller (<) than this value.  In other words, this is the
		low water mark". */
		trx_id_t	m_up_limit_id;

		/** trx id of creating transaction, set to TRX_ID_MAX for free
		views. */
		trx_id_t	m_creator_trx_id;

		/** Set of RW transactions that was active when this snapshot
		was taken */
		ids_t		m_ids;

		/** The view does not need to see the undo logs for transactions
		whose transaction number is strictly smaller (<) than this value:
		they can be removed in purge if not needed by other views */
		trx_id_t	m_low_limit_no;

		/** AC-NL-RO transaction view that has been "closed". */
		bool		m_closed;

		typedef UT_LIST_NODE_T(ReadView) node_t;

		/** List of read views in trx_sys */
		byte		pad1[64 - sizeof(node_t)];
		node_t		m_view_list;
		
		
		
2. 判断可见性的源码

	/* storage/innobase/include/read0types.h */

	/* changes_visible()的返回结果true代表可见，false代表不可见. */
	
	bool changes_visible(
		trx_id_t		id,
		const table_name_t&	name) const
		MY_ATTRIBUTE((warn_unused_result))
	{
		ut_ad(id > 0);
	   
		// id < m_up_limit_id:     行记录的版本号小于read view活跃事务列表的最小事务ID，可见。
		// id == m_creator_trx_id: 行记录的版本号等于事务ID，说明是自己的更新，可见。
		
		if (id < m_up_limit_id || id == m_creator_trx_id) {

			return(true);
		}

		check_trx_id_sanity(id, name);
		// 当记录的版本号大于read view活跃事务列表中的最大事务ID，不可见。
		if (id >= m_low_limit_id) {

			return(false);

		} else if (m_ids.empty()) {

			return(true);
		}

		const ids_t::value_type*	p = m_ids.data();
		//判断是否在Read View中
			在活跃事务列表中，说明未提交，不可见。 
			不在活跃事务列表中， 在 m_ids 范围内， 表示这个版本是已经提交了的事务生成的，可见。   --参考案例：《2020-06-04-通过第2个例子讲解MVCC.md》
		return(!std::binary_search(p, p + m_ids.size(), id));  
	}



3. row_search_mvcc和row_search_no_mvcc的入口函数

	/* mysql-5.7.26\storage\innobase\include\row0sel.ic */
	

	dberr_t
	row_search_for_mysql(
		byte*			buf,
		page_cur_mode_t		mode,
		row_prebuilt_t*		prebuilt,
		ulint			match_mode,
		ulint			direction)
	{
		if (!dict_table_is_intrinsic(prebuilt->table)) {
			return(row_search_mvcc(
				buf, mode, prebuilt, match_mode, direction));
		} else {
			return(row_search_no_mvcc(
				buf, mode, prebuilt, match_mode, direction));
		}
	}
	
	--------------------------------------------------------
	
	row_search_for_mysql->row_search_mvcc
	dberr_t
	row_search_mvcc(
		byte*		buf,
		page_cur_mode_t	mode,
		row_prebuilt_t*	prebuilt,
		ulint		match_mode,
		ulint		direction)
	{
		DBUG_ENTER("row_search_mvcc");





4. lock_clust_rec_cons_read_sees和row_vers_build_for_consistent_read

	当用mvcc读取的时候（row_search_mvcc），对于聚簇索引，当拿到一条记录后，会先通过函数 lock_clust_rec_cons_read_sees 判断可见性，如果不可见会再构建老版本数据 row_vers_build_for_consistent_read 。


	4.1 row_search_mvcc->lock_clust_rec_cons_read_sees 判断可见性

		/* mysql-5.7.26\storage\innobase\row\row0sel.cc */
		
		/*********************************************************************//**
		Checks that a record is seen in a consistent read.
		@return true if sees, or false if an earlier version of the record
		should be retrieved */
		bool
		lock_clust_rec_cons_read_sees(
		/*==========================*/
			const rec_t*	rec,	/*!< in: user record which should be read or
						passed over by a read cursor */
			dict_index_t*	index,	/*!< in: clustered index */
			const ulint*	offsets,/*!< in: rec_get_offsets(rec, index) */
			ReadView*	view)	/*!< in: consistent read view */
		{
			ut_ad(dict_index_is_clust(index));
			ut_ad(page_rec_is_user_rec(rec));
			ut_ad(rec_offs_validate(rec, index, offsets));

			/* Temp-tables are not shared across connections and multiple
			transactions from different connections cannot simultaneously
			operate on same temp-table and so read of temp-table is
			always consistent read. */
			
			/*
				临时表不跨连接共享，来自不同连接的多个事务不能同时对同一个临时表进行操作，因此临时表的读取始终是一致读取   -- 临时表是session也就是线程级别的，因此临时表的读取始终是一致性读取
				srv_read_only_mode： 此处获取事务当前是否是只读属性，可以看到他和我们的read_only参数设置事物是ddl事物是否是内部事物有关
			*/
			if (srv_read_only_mode || dict_table_is_temporary(index->table)) {
				ut_ad(view == 0 || dict_table_is_temporary(index->table));
				return(true);
			}

			/* NOTE that we call this function while holding the search
			system latch. */
			
			/* 获取该条 Record 的trx_id */
			trx_id_t	trx_id = row_get_rec_trx_id(rec, index, offsets);
			
			/* 判断记录可见性 */
			return(view->changes_visible(trx_id, index->table->name));
		} 
		
		
	
	4.2  row_vers_build_for_consistent_read 构建undo历史版本
	
		/* mysql-5.7.26\storage\innobase\row\row0vers.cc */

		/*****************************************************************//**
		Constructs the version of a clustered index record which a consistent
		read should see. We assume that the trx id stored in rec is such that
		the consistent read should not see rec in its present version.
		@return DB_SUCCESS or DB_MISSING_HISTORY */
		dberr_t
		row_vers_build_for_consistent_read()
		{
		
			/* If purge can't see the record then we can't rely on
			the UNDO log record. */
			
			/* 如果purge 看不到记录，那么我们就不能依赖UNDO 日志记录。 */
			
				for (;;) {
					mem_heap_t*	prev_heap = heap;

					heap = mem_heap_create(1024);

					if (vrow) {
						*vrow = NULL;
					}

					/* If purge can't see the record then we can't rely on
					the UNDO log record. */
					/* 通过undo构建行记录的历史版本 */
					bool	purge_sees = trx_undo_prev_version_build(
						rec, mtr, version, index, *offsets, heap,
						&prev_version, NULL, vrow, 0);

					err  = (purge_sees) ? DB_SUCCESS : DB_MISSING_HISTORY;
					
			}

		}
		-----------------------------------------------------------------------------------------
		
		/* 通过undo构建行记录的历史版本 */
		/* mysql-5.7.26\storage\innobase\trx\trx0rec.cc */
		
		/*******************************************************************//**
		Build a previous version of a clustered index record. The caller must
		hold a latch on the index page of the clustered index record.
		@retval true if previous version was built, or if it was an insert
		or the table has been rebuilt
		@retval false if the previous version is earlier than purge_view,
		or being purged, which means that it may have been removed */
		bool
		trx_undo_prev_version_build()
	
		
	
		/*============== BUILDING PREVIOUS VERSION OF A RECORD(获取对应的 Undo Record 内容) ===============*/
		/******************************************************************//**
		Copies an undo record to heap. This function can be called if we know that
		the undo log record exists.
		@return own: copy of the record */
		trx_undo_rec_t*
		trx_undo_get_undo_rec_low(
		/*======================*/
			roll_ptr_t	roll_ptr,	/*!< in: roll pointer to record */
			mem_heap_t*	heap,		/*!< in: memory heap where copied */
			bool		is_redo_rseg)	/*!< in: true if redo rseg. */
		{


			/* 解析 roll_ptr 指针内容. */
			trx_undo_decode_roll_ptr(roll_ptr, &is_insert, &rseg_id, &page_no,
						 &offset);
			/* 根据回滚段 ID 查找回滚段。（Looks for a rollback segment, based on the rollback segment id.）*/
			rseg = trx_rseg_get_on_id(rseg_id, is_redo_rseg);

			mtr_start(&mtr);
			
			/* 在回滚段中获取对应的 Undo Page. */
			undo_page = trx_undo_page_get_s_latched(
				page_id_t(rseg->space, page_no), rseg->page_size,
				&mtr);
				
			/* 通过 offset 获取对应的 Undo Record. */
			undo_rec = trx_undo_rec_copy(undo_page + offset, heap);

			mtr_commit(&mtr);

			return(undo_rec);
		}


		/* 解析 roll_ptr 指针内容. */
		/***********************************************************************//**
		Decodes a roll pointer. */
		UNIV_INLINE
		void
		trx_undo_decode_roll_ptr(
		/*=====================*/
			roll_ptr_t	roll_ptr,	/*!< in: roll pointer */
			ibool*		is_insert,	/*!< out: TRUE if insert undo log */
			ulint*		rseg_id,	/*!< out: rollback segment id */
			ulint*		page_no,	/*!< out: page number */
			ulint*		offset)		/*!< out: offset of the undo
							entry within page */
		{
		#if DATA_ROLL_PTR_LEN != 7
		# error "DATA_ROLL_PTR_LEN != 7"
		#endif
		#if TRUE != 1
		# error "TRUE != 1"
		#endif
			ut_ad(roll_ptr < (1ULL << 56));
			*offset = (ulint) roll_ptr & 0xFFFF;
			roll_ptr >>= 16;
			*page_no = (ulint) roll_ptr & 0xFFFFFFFF;
			roll_ptr >>= 32;
			*rseg_id = (ulint) roll_ptr & 0x7F;
			roll_ptr >>= 7;
			*is_insert = (ibool) roll_ptr; /* TRUE==1 */
		}


5. 构建undo历史版本的流程

	1. 构建老版本记录（trx_undo_prev_version_build）需要持有page latch，因此如果Undo链太长的话，其他请求该page的线程可能等待时间过长导致crash 
	
	2. 在构建老版本的过程中，总是需要创建heap来存储旧版本记录，实际上这个heap是可以重用的，无需总是重复构建
	3. 如果回滚段类型是INSERT，就完全没有必要去看Undo日志了，因为一个未提交事务的新插入记录，对其他事务而言总是不可见的。
	4. 对于聚集索引我们知道其记录中存有修改该记录的事务id，我们可以直接判断是否需要构建老版本(lock_clust_rec_cons_read_sees)
		但对于二级索引记录，并未存储事务id，而是每次更新记录时，同时更新记录所在的page上的事务id（PAGE_MAX_TRX_ID），
		如果该事务id对当前事务是可见的，那么就无需去构建老版本了，否则就需要去回表查询对应的聚集索引记录，然后判断可见性（lock_sec_rec_cons_read_sees）


6. 相关参考

	http://mysql.taobao.org/monthly/2015/04/01/
	http://mysql.taobao.org/monthly/2018/11/04/
	https://my.oschina.net/alchemystar/blog/1927425
    https://dev.mysql.com/doc/dev/mysql-server/8.0.12/classReadView.html
   
    https://blog.csdn.net/maray/article/details/80848544
	
	https://www.leviathan.vip/2019/03/20/InnoDB%E7%9A%84%E4%BA%8B%E5%8A%A1%E5%88%86%E6%9E%90-MVCC/   
	
	http://blog.itpub.net/7728585/viewspace-2284045/  MySQL：Innodb DB_ROLL_PTR指针解析

	