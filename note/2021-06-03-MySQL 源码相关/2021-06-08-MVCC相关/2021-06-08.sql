
0. InnoDB隐藏字段源码分析
1. read view 中主要包含4个比较重要的内容
2. 判断可见性的源码
3. row_search_mvcc和row_search_no_mvcc的入口函数



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


	/*mysql-5.7.26\storage\innobase\include\read0types.h*/
	
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

	/** Check whether the changes by id are visible.
	@param[in]	id	transaction id to check against the view
	@param[in]	name	table name
	@return whether the view sees the modifications of id. */
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

	/** Searches for rows in the database. This is used in the interface to
	MySQL. This function opens a cursor, and also implements fetch next
	and fetch prev. NOTE that if we do a search with a full key value
	from a unique index (ROW_SEL_EXACT), then we will not store the cursor
	position and fetch next or fetch prev must not be tried to the cursor!

	@param[out]	buf		buffer for the fetched row in MySQL format
	@param[in]	mode		search mode PAGE_CUR_L
	@param[in,out]	prebuilt	prebuilt struct for the table handler;
					this contains the info to search_tuple,
					index; if search tuple contains 0 field then
					we position the cursor at start or the end of
					index, depending on 'mode'
	@param[in]	match_mode	0 or ROW_SEL_EXACT or ROW_SEL_EXACT_PREFIX
	@param[in]	direction	0 or ROW_SEL_NEXT or ROW_SEL_PREV;
					Note: if this is != 0, then prebuilt must has a
					pcur with stored position! In opening of a
					cursor 'direction' should be 0.
	@return DB_SUCCESS, DB_RECORD_NOT_FOUND, DB_END_OF_INDEX, DB_DEADLOCK,
	DB_LOCK_TABLE_FULL, DB_CORRUPTION, or DB_TOO_BIG_RECORD */
	UNIV_INLINE
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



