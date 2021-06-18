

0. 初始化表结构和数据
1. 函数接口 buf_LRU_flush_or_remove_pages 
2. truncate
3. drop


0. 初始化表结构和数据
	
1. 函数接口 buf_LRU_flush_or_remove_pages 

	函数接口 buf_LRU_flush_or_remove_pages 用于确认是否维护 LRU list，其中有三种类型：


	/** Algorithm to remove the pages for a tablespace from the buffer pool.
		See buf_LRU_flush_or_remove_pages(). */
		enum buf_remove_t {
			BUF_REMOVE_ALL_NO_WRITE,    /*!< Remove all pages from the buffer
							pool, don't write or sync to disk */  
			BUF_REMOVE_FLUSH_NO_WRITE,  /*!< Remove only, from the flush list,
							don't write or sync to disk */
			BUF_REMOVE_FLUSH_WRITE      /*!< Flush dirty pages to disk only
							don't remove from the buffer pool */
		};


	drop为：     BUF_REMOVE_FLUSH_NO_WRITE ，需要维护flush list，不回写数据
	trunacte为： BUF_REMOVE_ALL_NO_WRITE ，  需要维护flush list和lru list，不回写数据

	作者：重庆八怪
	链接：https://www.jianshu.com/p/a956a3e30eb6
	来源：简书
	著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

	CREATE TABLE `t` (
		  `id` int(11) NOT NULL,
		  `a` int(11) DEFAULT NULL,
		  `t_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
		  PRIMARY KEY (`id`),
		  KEY `t_modified`(`t_modified`)
		) ENGINE=InnoDB; 
	insert into t values(5,1,'2018-11-13');

2. truncate 

	(gdb) b buf_LRU_flush_or_remove_pages
	Breakpoint 1 at 0x1b75804: file /usr/local/mysql-5.7.26/storage/innobase/buf/buf0lru.cc, line 930.
	
	(gdb) bt
	#0  0x00007f17791f1bed in poll () at ../sysdeps/unix/syscall-template.S:81
	#1  0x00000000016626a1 in Mysqld_socket_listener::listen_for_connection_event (this=0x1e174160) at /usr/local/mysql-5.7.26/sql/conn_handler/socket_connection.cc:852
	#2  0x0000000000eab53c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x4d6f850) at /usr/local/mysql-5.7.26/sql/conn_handler/connection_acceptor.h:66
	#3  0x0000000000ea2fba in mysqld_main (argc=127, argv=0x4c49d38) at /usr/local/mysql-5.7.26/sql/mysqld.cc:5149
	#4  0x0000000000e9a12d in main (argc=10, argv=0x7fff81a82798) at /usr/local/mysql-5.7.26/sql/main.cc:25
	(gdb) 
	#0  0x00007f17791f1bed in poll () at ../sysdeps/unix/syscall-template.S:81
	#1  0x00000000016626a1 in Mysqld_socket_listener::listen_for_connection_event (this=0x1e174160) at /usr/local/mysql-5.7.26/sql/conn_handler/socket_connection.cc:852
	#2  0x0000000000eab53c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x4d6f850) at /usr/local/mysql-5.7.26/sql/conn_handler/connection_acceptor.h:66
	#3  0x0000000000ea2fba in mysqld_main (argc=127, argv=0x4c49d38) at /usr/local/mysql-5.7.26/sql/mysqld.cc:5149
	#4  0x0000000000e9a12d in main (argc=10, argv=0x7fff81a82798) at /usr/local/mysql-5.7.26/sql/main.cc:25

	(gdb) c
	Continuing.
	[Switching to Thread 0x7f153c53a700 (LWP 7541)]
		
	Breakpoint 1, buf_LRU_flush_or_remove_pages (id=118, buf_remove=BUF_REMOVE_ALL_NO_WRITE, trx=0x0) at /usr/local/mysql-5.7.26/storage/innobase/buf/buf0lru.cc:930
	930		for (i = 0; i < srv_buf_pool_instances; i++) {


	(gdb) bt
	#0  buf_LRU_flush_or_remove_pages (id=118, buf_remove=BUF_REMOVE_ALL_NO_WRITE, trx=0x0) at /usr/local/mysql-5.7.26/storage/innobase/buf/buf0lru.cc:930
	#1  0x0000000001bd74f9 in fil_reinit_space_header_for_table (table=0x1e147920, size=7, trx=0x7f176a1d4d08) at /usr/local/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:3008
	#2  0x0000000001a5a8d5 in row_truncate_table_for_mysql (table=0x1e147920, trx=0x7f176a1d4d08) at /usr/local/mysql-5.7.26/storage/innobase/row/row0trunc.cc:2077
	#3  0x00000000018c8a11 in ha_innobase::truncate (this=0x7f150c9384d0) at /usr/local/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:12463
	#4  0x0000000000f2f9ad in handler::ha_truncate (this=0x7f150c9384d0) at /usr/local/mysql-5.7.26/sql/handler.cc:4699
	#5  0x0000000001773985 in Sql_cmd_truncate_table::handler_truncate (this=0x7f150c00ff88, thd=0x7f150c00a8a0, table_ref=0x7f150c00f9f8, is_tmp_table=false) at /usr/local/mysql-5.7.26/sql/sql_truncate.cc:244
	#6  0x0000000001774194 in Sql_cmd_truncate_table::truncate_table (this=0x7f150c00ff88, thd=0x7f150c00a8a0, table_ref=0x7f150c00f9f8) at /usr/local/mysql-5.7.26/sql/sql_truncate.cc:502
	#7  0x00000000017742fb in Sql_cmd_truncate_table::execute (this=0x7f150c00ff88, thd=0x7f150c00a8a0) at /usr/local/mysql-5.7.26/sql/sql_truncate.cc:558
	#8  0x00000000015390fc in mysql_execute_command (thd=0x7f150c00a8a0, first_level=true) at /usr/local/mysql-5.7.26/sql/sql_parse.cc:4835
	#9  0x000000000153af3e in mysql_parse (thd=0x7f150c00a8a0, parser_state=0x7f153c539690) at /usr/local/mysql-5.7.26/sql/sql_parse.cc:5570
	#10 0x000000000153084f in dispatch_command (thd=0x7f150c00a8a0, com_data=0x7f153c539df0, command=COM_QUERY) at /usr/local/mysql-5.7.26/sql/sql_parse.cc:1484
	#11 0x000000000152f6b8 in do_command (thd=0x7f150c00a8a0) at /usr/local/mysql-5.7.26/sql/sql_parse.cc:1025
	#12 0x000000000165fff6 in handle_connection (arg=0x1e2cfb50) at /usr/local/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
	#13 0x0000000001ce8640 in pfs_spawn_thread (arg=0x1e234a50) at /usr/local/mysql-5.7.26/storage/perfschema/pfs.cc:2190
	#14 0x00007f177a336e65 in start_thread (arg=0x7f153c53a700) at pthread_create.c:307
	#15 0x00007f17791fc88d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:111



	root@mysqldb 02:56:  [lujb_db]> truncate table t;
	阻塞住

3. drop


	(gdb)  b buf_LRU_flush_or_remove_pages
	Breakpoint 1 at 0x1b75804: file /usr/local/mysql-5.7.26/storage/innobase/buf/buf0lru.cc, line 930.

	(gdb) bt
	#0  0x00007f17791f1bed in poll () at ../sysdeps/unix/syscall-template.S:81
	#1  0x00000000016626a1 in Mysqld_socket_listener::listen_for_connection_event (this=0x1e174160) at /usr/local/mysql-5.7.26/sql/conn_handler/socket_connection.cc:852
	#2  0x0000000000eab53c in Connection_acceptor<Mysqld_socket_listener>::connection_event_loop (this=0x4d6f850) at /usr/local/mysql-5.7.26/sql/conn_handler/connection_acceptor.h:66
	#3  0x0000000000ea2fba in mysqld_main (argc=127, argv=0x4c49d38) at /usr/local/mysql-5.7.26/sql/mysqld.cc:5149
	#4  0x0000000000e9a12d in main (argc=10, argv=0x7fff81a82798) at /usr/local/mysql-5.7.26/sql/main.cc:25


	(gdb) c
	Continuing.
	[Switching to Thread 0x7f153c53a700 (LWP 7541)]

	Breakpoint 1, buf_LRU_flush_or_remove_pages (id=121, buf_remove=BUF_REMOVE_FLUSH_NO_WRITE, trx=0x0) at /usr/local/mysql-5.7.26/storage/innobase/buf/buf0lru.cc:930
	930		for (i = 0; i < srv_buf_pool_instances; i++) {

	(gdb) bt
	#0  buf_LRU_flush_or_remove_pages (id=121, buf_remove=BUF_REMOVE_FLUSH_NO_WRITE, trx=0x0) at /usr/local/mysql-5.7.26/storage/innobase/buf/buf0lru.cc:930
	#1  0x0000000001bd6c39 in fil_delete_tablespace (id=121, buf_remove=BUF_REMOVE_FLUSH_NO_WRITE) at /usr/local/mysql-5.7.26/storage/innobase/fil/fil0fil.cc:2802
	#2  0x0000000001a179c9 in row_drop_single_table_tablespace (space_id=121, tablename=0x7f150c01fac0 "lujb_db/t", filepath=0x7f150c01cbf8 "./lujb_db/t.ibd", is_temp=false, is_encrypted=false, trx=0x7f176a1d59e0)
		at /usr/local/mysql-5.7.26/storage/innobase/row/row0mysql.cc:4268
	#3  0x0000000001a18cd2 in row_drop_table_for_mysql (name=0x7f153c536a10 "lujb_db/t", trx=0x7f176a1d59e0, drop_db=false, nonatomic=true, handler=0x0)
		at /usr/local/mysql-5.7.26/storage/innobase/row/row0mysql.cc:4821
	#4  0x00000000018c8e76 in ha_innobase::delete_table (this=0x7f150c010168, name=0x7f153c538130 "./lujb_db/t") at /usr/local/mysql-5.7.26/storage/innobase/handler/ha_innodb.cc:12583
	#5  0x0000000000f300d4 in handler::ha_delete_table (this=0x7f150c010168, name=0x7f153c538130 "./lujb_db/t") at /usr/local/mysql-5.7.26/sql/handler.cc:4941
	#6  0x0000000000f29c0b in ha_delete_table (thd=0x7f150c00a8a0, table_type=0x4c4b450, path=0x7f153c538130 "./lujb_db/t", db=0x7f150c00ff70 "lujb_db", alias=0x7f150c00f9b0 "t", generate_warning=true)
		at /usr/local/mysql-5.7.26/sql/handler.cc:2594
	#7  0x00000000015b9b3d in mysql_rm_table_no_locks (thd=0x7f150c00a8a0, tables=0x7f150c00f9e8, if_exists=false, drop_temporary=false, drop_view=false, dont_log_query=false)
		at /usr/local/mysql-5.7.26/sql/sql_table.cc:2546
	#8  0x00000000015b8dea in mysql_rm_table (thd=0x7f150c00a8a0, tables=0x7f150c00f9e8, if_exists=0 '\000', drop_temporary=0 '\000') at /usr/local/mysql-5.7.26/sql/sql_table.cc:2196
	#9  0x0000000001535901 in mysql_execute_command (thd=0x7f150c00a8a0, first_level=true) at /usr/local/mysql-5.7.26/sql/sql_parse.cc:3619
	#10 0x000000000153af3e in mysql_parse (thd=0x7f150c00a8a0, parser_state=0x7f153c539690) at /usr/local/mysql-5.7.26/sql/sql_parse.cc:5570
	#11 0x000000000153084f in dispatch_command (thd=0x7f150c00a8a0, com_data=0x7f153c539df0, command=COM_QUERY) at /usr/local/mysql-5.7.26/sql/sql_parse.cc:1484
	#12 0x000000000152f6b8 in do_command (thd=0x7f150c00a8a0) at /usr/local/mysql-5.7.26/sql/sql_parse.cc:1025
	#13 0x000000000165fff6 in handle_connection (arg=0x1e2cfb50) at /usr/local/mysql-5.7.26/sql/conn_handler/connection_handler_per_thread.cc:306
	#14 0x0000000001ce8640 in pfs_spawn_thread (arg=0x1e234a50) at /usr/local/mysql-5.7.26/storage/perfschema/pfs.cc:2190
	#15 0x00007f177a336e65 in start_thread (arg=0x7f153c53a700) at pthread_create.c:307
	#16 0x00007f17791fc88d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:111


	root@mysqldb 03:13:  [lujb_db]> drop table t;
	阻塞住

	
	buf_LRU_flush_or_remove_pages

		buf_LRU_flush_or_remove_pages (id=121, buf_remove=BUF_REMOVE_FLUSH_NO_WRITE
		
		/* 删除所有脏页或删除属于指定表空间的所有页（）。 */ 
		/******************************************************************//**
		Flushes all dirty pages or removes all pages belonging
		to a given tablespace. A PROBLEM: if readahead is being started, what
		guarantees that it will not try to read in pages after this operation
		has completed? */
		void
		buf_LRU_flush_or_remove_pages(
		/*==========================*/
			ulint		id,		/*!< in: space id */
			buf_remove_t	buf_remove,	/*!< in: remove or flush strategy */
			const trx_t*	trx)		/*!< to check if the operation must
							be interrupted */
		{
			ulint		i;

			/* Before we attempt to drop pages one by one we first
			attempt to drop page hash index entries in batches to make
			it more efficient. The batching attempt is a best effort
			attempt and does not guarantee that all pages hash entries
			will be dropped. We get rid of remaining page hash entries
			one by one below. */
			for (i = 0; i < srv_buf_pool_instances; i++) {
				buf_pool_t*	buf_pool;

				buf_pool = buf_pool_from_array(i);

				switch (buf_remove) {
				
				case BUF_REMOVE_FLUSH_NO_WRITE:
					/* It is a DROP TABLE for a single table
					tablespace. No AHI entries exist because
					we already dealt with them when freeing up
					extents. */
		
				buf_LRU_remove_pages(buf_pool, id, buf_remove, trx);
			}
		}


		buf_LRU_flush_or_remove_pages->buf_LRU_remove_pages
			/******************************************************************//**
			Remove pages belonging to a given tablespace inside a specific
			buffer pool instance when we are deleting the data file(s) of that
			tablespace. The pages still remain a part of LRU and are evicted from
			the list as they age towards the tail of the LRU only if buf_remove
			is BUF_REMOVE_FLUSH_NO_WRITE. */
			static
			void
			buf_LRU_remove_pages(
			/*=================*/
				buf_pool_t*	buf_pool,	/*!< buffer pool instance */
				ulint		id,		/*!< in: space id */
				buf_remove_t	buf_remove,	/*!< in: remove or flush strategy */
				const trx_t*	trx)		/*!< to check if the operation must
								be interrupted */
			{
				FlushObserver*	observer = (trx == NULL) ? NULL : trx->flush_observer;

				switch (buf_remove) {

				case BUF_REMOVE_FLUSH_NO_WRITE:
					/* Pass trx as NULL to avoid interruption check. */
					buf_flush_dirty_pages(buf_pool, id, observer, false, NULL);
					break;

				
			}
		
		buf_LRU_remove_pages->buf_flush_dirty_pages
			/******************************************************************//**
			Remove or flush all the dirty pages that belong to a given tablespace
			inside a specific buffer pool instance. The pages will remain in the LRU
			list and will be evicted from the LRU list as they age and move towards
			the tail of the LRU list. */
			static
			void
			buf_flush_dirty_pages(
			/*==================*/
				buf_pool_t*	buf_pool,	/*!< buffer pool instance */
				ulint		id,		/*!< in: space id */
				FlushObserver*	observer,	/*!< in: flush observer */
				bool		flush,		/*!< in: flush to disk if true otherwise
								remove the pages without flushing */
				const trx_t*	trx)		/*!< to check if the operation must
								be interrupted */
			{
				dberr_t		err;

				do {
					buf_pool_mutex_enter(buf_pool);

					err = buf_flush_or_remove_pages(
						buf_pool, id, observer, flush, trx);
					
					/* 释放BP缓冲池的mutex互斥锁 */
					buf_pool_mutex_exit(buf_pool);

					ut_ad(buf_flush_validate(buf_pool));

					if (err == DB_FAIL) {
						os_thread_sleep(2000);
					}

					if (err == DB_INTERRUPTED && observer != NULL) {
						ut_a(flush);

						flush = false;
						err = DB_FAIL;
					}

					/* DB_FAIL is a soft error, it means that the task wasn't
					completed, needs to be retried. */

					ut_ad(buf_flush_validate(buf_pool));

				} while (err == DB_FAIL);

				ut_ad(err == DB_INTERRUPTED
					  || buf_pool_get_dirty_pages_count(buf_pool, id, observer) == 0);
			}

		
		buf_flush_dirty_pages->	buf_pool_mutex_enter
			/* 持有buffer pool mutex； */
			/** Acquire a buffer pool mutex. */
			#define buf_pool_mutex_enter(b) do {		\
				ut_ad(!(b)->zip_mutex.is_owned());	\
				mutex_enter(&(b)->mutex);		\
			} while (0)

		
		buf_flush_dirty_pages->buf_flush_or_remove_pages
	
	
			/*
			当我们删除该表空间的数据文件时，删除属于特定缓冲池实例中给定表空间的所有脏页。 这些页面仍然是 LRU 的一部分，并且随着它们老化到 LRU 的尾部而从列表中被逐出。
			*/
			
			/******************************************************************//**
			Remove all dirty pages belonging to a given tablespace inside a specific
			buffer pool instance when we are deleting the data file(s) of that
			tablespace. The pages still remain a part of LRU and are evicted from
			the list as they age towards the tail of the LRU.
			@retval DB_SUCCESS if all freed
			@retval DB_FAIL if not all freed
			@retval DB_INTERRUPTED if the transaction was interrupted */
			static	MY_ATTRIBUTE((warn_unused_result))
			dberr_t
			buf_flush_or_remove_pages(
			/*======================*/
				buf_pool_t*	buf_pool,	/*!< buffer pool instance */
				ulint		id,		/*!< in: target space id for which
								to remove or flush pages */
				FlushObserver*	observer,	/*!< in: flush observer */
				bool		flush,		/*!< in: flush to disk if true but
								don't remove else remove without
								flushing to disk */
				const trx_t*	trx)		/*!< to check if the operation must
								be interrupted, can be 0 */--
							
						
		-------------------------------------------------------------------------------				

		/** Deletes an IBD tablespace, either general or single-table.
		The tablespace must be cached in the memory cache. This will delete the
		datafile, fil_space_t & fil_node_t entries from the file_system_t cache.
		@param[in]	space_id	Tablespace id
		@param[in]	buf_remove	Specify the action to take on the pages
		for this table in the buffer pool.
		@return DB_SUCCESS or error */
		dberr_t
		fil_delete_tablespace(
			ulint		id,
			buf_remove_t	buf_remove)
		{
			char*		path = 0;
			fil_space_t*	space = 0;

			ut_a(!is_system_tablespace(id));

			dberr_t err = fil_check_pending_operations(
				id, FIL_OPERATION_DELETE, &space, &path);

			if (err != DB_SUCCESS) {

				ib::error() << "Cannot delete tablespace " << id
					<< " because it is not found in the tablespace"
					" memory cache.";

				return(err);
			}

			ut_a(space);
			ut_a(path != 0);
			

	/** Drop a single-table tablespace as part of dropping or renaming a table.
	This deletes the fil_space_t if found and the file on disk.
	@param[in]	space_id	Tablespace ID
	@param[in]	tablename	Table name, same as the tablespace name
	@param[in]	filepath	File path of tablespace to delete
	@param[in]	is_temp		Is this a temporary table/tablespace
	@param[in]	is_encrypted	Is this an encrypted table/tablespace
	@param[in]	trx		Transaction handle
	@return error code or DB_SUCCESS */
	UNIV_INLINE
	dberr_t
	row_drop_single_table_tablespace(
		ulint		space_id,
		const char*	tablename,
		const char*	filepath,
		bool		is_temp,
		bool		is_encrypted,
		trx_t*		trx)
	{
		dberr_t	err = DB_SUCCESS;

		/* This might be a temporary single-table tablespace if the table
		is compressed and temporary. If so, don't spam the log when we
		delete one of these or if we can't find the tablespace. */
		bool	print_msg = !is_temp && !is_encrypted;

		/* If the tablespace is not in the cache, just delete the file. */
		if (!fil_space_for_table_exists_in_mem(
				space_id, tablename, print_msg, false, NULL, 0)) {

			/* Force a delete of any discarded or temporary files. */
			fil_delete_file(filepath);

			if (print_msg) {
				ib::info() << "Removed datafile " << filepath
					<< " for table " << tablename;
			}

		} else if (fil_delete_tablespace(space_id, BUF_REMOVE_FLUSH_NO_WRITE)
			   != DB_SUCCESS) {

			ib::error() << "We removed the InnoDB internal data"
				" dictionary entry of table " << tablename
				<< " but we are not able to delete the tablespace "
				<< space_id << " file " << filepath << "!";

			err = DB_ERROR;
		}

		return(err);
	}

	
	/*
	从MySQL中删除表
	如果数据字典尚未被事务锁定，则将提交事务。 否则，数据字典将保持锁定状态。
	*/
	
	/** Drop a table for MySQL.
	If the data dictionary was not already locked by the transaction,
	the transaction will be committed.  Otherwise, the data dictionary
	will remain locked.
	@param[in]	name		Table name
	@param[in]	trx		Transaction handle
	@param[in]	drop_db		true=dropping whole database
	@param[in]	nonatomic	Whether it is permitted to release
	and reacquire dict_operation_lock
	@param[in,out]	handler		Table handler
	@return error code or DB_SUCCESS */
	dberr_t
	row_drop_table_for_mysql(
		const char*	name,
		trx_t*		trx,
		bool		drop_db,
		bool		nonatomic,
		dict_table_t*	handler)
	{
		dberr_t		err;
		dict_foreign_t*	foreign;
		dict_table_t*	table			= NULL;
		char*		filepath		= NULL;
		char*		tablename		= NULL;
		bool		locked_dictionary	= false;
		pars_info_t*	info			= NULL;
		mem_heap_t*	heap			= NULL;
		bool		is_intrinsic_temp_table	= false;

		DBUG_ENTER("row_drop_table_for_mysql");
		DBUG_PRINT("row_drop_table_for_mysql", ("table: '%s'", name));

		ut_a(name != NULL);

		/* Serialize data dictionary operations with dictionary mutex:
		no deadlocks can occur then in these operations */

		trx->op_info = "dropping table";

		if (handler != NULL && dict_table_is_intrinsic(handler)) {
			table = handler;
			is_intrinsic_temp_table = true;
		}

		if (table == NULL) {

			if (trx->dict_operation_lock_mode != RW_X_LATCH) {
				/* Prevent foreign key checks etc. while we are
				dropping the table */

				row_mysql_lock_data_dictionary(trx);

				locked_dictionary = true;
				nonatomic = true;
			}

			ut_ad(mutex_own(&dict_sys->mutex));
			ut_ad(rw_lock_own(dict_operation_lock, RW_LOCK_X));

			table = dict_table_open_on_name(
				name, TRUE, FALSE,
				static_cast<dict_err_ignore_t>(
					DICT_ERR_IGNORE_INDEX_ROOT
					| DICT_ERR_IGNORE_CORRUPT));
		} else {
			table->acquire();
			ut_ad(dict_table_is_intrinsic(table));
		}

		if (!table) {
			err = DB_TABLE_NOT_FOUND;
			goto funct_exit;
		}

		/* This function is called recursively via fts_drop_tables(). */
		if (!trx_is_started(trx)) {

			if (!dict_table_is_temporary(table)) {
				trx_start_for_ddl(trx, TRX_DICT_OP_TABLE);
			} else {
				trx_set_dict_operation(trx, TRX_DICT_OP_TABLE);
			}
		}

		/* Turn on this drop bit before we could release the dictionary
		latch */
		table->to_be_dropped = true;

		if (nonatomic) {
			/* This trx did not acquire any locks on dictionary
			table records yet. Thus it is safe to release and
			reacquire the data dictionary latches. */
			if (table->fts) {
				ut_ad(!table->fts->add_wq);
				ut_ad(lock_trx_has_sys_table_locks(trx) == 0);

				for (;;) {
					bool retry = false;
					if (dict_fts_index_syncing(table)) {
						retry = true;
					}
					if (!retry) {
						break;
					}
					DICT_BG_YIELD(trx);
				}

				row_mysql_unlock_data_dictionary(trx);
				fts_optimize_remove_table(table);
				row_mysql_lock_data_dictionary(trx);
			}

			/* Do not bother to deal with persistent stats for temp
			tables since we know temp tables do not use persistent
			stats. */
			if (!dict_table_is_temporary(table)) {
				dict_stats_wait_bg_to_stop_using_table(
					table, trx);
			}
		}

		/* make sure background stats thread is not running on the table */
		ut_ad(!(table->stats_bg_flag & BG_STAT_IN_PROGRESS));

		/* Delete the link file if used. */
		if (DICT_TF_HAS_DATA_DIR(table->flags)) {
			RemoteDatafile::delete_link_file(name);
		}

		if (!dict_table_is_temporary(table)) {

			dict_stats_recalc_pool_del(table);

			/* Remove stats for this table and all of its indexes from the
			persistent storage if it exists and if there are stats for this
			table in there. This function creates its own trx and commits
			it. */
			if (dict_stats_is_persistent_enabled(table)) {
				char	errstr[1024];
				err = dict_stats_drop_table(name, errstr, sizeof(errstr));
				if (err != DB_SUCCESS) {
					ib::warn() << errstr;
				}
			}
		}

		if (!dict_table_is_intrinsic(table)) {
			dict_table_prevent_eviction(table);
		}

		dict_table_close(table, TRUE, FALSE);

		/* Check if the table is referenced by foreign key constraints from
		some other table (not the table itself) */

		if (!srv_read_only_mode && trx->check_foreigns) {

			for (dict_foreign_set::iterator it
				= table->referenced_set.begin();
				 it != table->referenced_set.end();
				 ++it) {

				foreign = *it;

				const bool	ref_ok = drop_db
					&& dict_tables_have_same_db(
						name,
						foreign->foreign_table_name_lookup);

				if (foreign->foreign_table != table && !ref_ok) {

					FILE*	ef	= dict_foreign_err_file;

					/* We only allow dropping a referenced table
					if FOREIGN_KEY_CHECKS is set to 0 */

					err = DB_CANNOT_DROP_CONSTRAINT;

					mutex_enter(&dict_foreign_err_mutex);
					rewind(ef);
					ut_print_timestamp(ef);

					fputs("  Cannot drop table ", ef);
					ut_print_name(ef, trx, name);
					fputs("\n"
						  "because it is referenced by ", ef);
					ut_print_name(ef, trx,
							  foreign->foreign_table_name);
					putc('\n', ef);
					mutex_exit(&dict_foreign_err_mutex);

					goto funct_exit;
				}
			}
		}


		DBUG_EXECUTE_IF("row_drop_table_add_to_background",
			row_add_table_to_background_drop_list(table->name.m_name);
			err = DB_SUCCESS;
			goto funct_exit;
		);
		
		/* TODO: could we replace the counter n_foreign_key_checks_running
		with lock checks on the table? Acquire here an exclusive lock on the
		table, and rewrite lock0lock.cc and the lock wait in srv0srv.cc so that
		they can cope with the table having been dropped here? Foreign key
		checks take an IS or IX lock on the table. */

		if (table->n_foreign_key_checks_running > 0) {

			const char*	save_tablename = table->name.m_name;
			ibool		added;

			added = row_add_table_to_background_drop_list(save_tablename);

			if (added) {
				ib::info() << "You are trying to drop table "
					<< table->name
					<< " though there is a foreign key check"
					" running on it. Adding the table to the"
					" background drop queue.";

				/* We return DB_SUCCESS to MySQL though the drop will
				happen lazily later */

				err = DB_SUCCESS;
			} else {
				/* The table is already in the background drop list */
				err = DB_ERROR;
			}

			goto funct_exit;
		}

		/* Remove all locks that are on the table or its records, if there
		are no references to the table but it has record locks, we release
		the record locks unconditionally. One use case is:

			CREATE TABLE t2 (PRIMARY KEY (a)) SELECT * FROM t1;

		If after the user transaction has done the SELECT and there is a
		problem in completing the CREATE TABLE operation, MySQL will drop
		the table. InnoDB will create a new background transaction to do the
		actual drop, the trx instance that is passed to this function. To
		preserve existing behaviour we remove the locks but ideally we
		shouldn't have to. There should never be record locks on a table
		that is going to be dropped. */

		if (table->get_ref_count() == 0) {
			/* We don't take lock on intrinsic table so nothing to remove.*/
			if (!dict_table_is_intrinsic(table)) {
				lock_remove_all_on_table(table, TRUE);
			}
			ut_a(table->n_rec_locks == 0);
		} else if (table->get_ref_count() > 0 || table->n_rec_locks > 0) {
			ibool	added;

			ut_ad(!dict_table_is_intrinsic(table));

			added = row_add_table_to_background_drop_list(
				table->name.m_name);

			if (added) {
				ib::info() << "MySQL is trying to drop table "
					<< table->name
					<< " though there are still open handles to"
					" it. Adding the table to the background drop"
					" queue.";

				/* We return DB_SUCCESS to MySQL though the drop will
				happen lazily later */
				err = DB_SUCCESS;
			} else {
				/* The table is already in the background drop list */
				err = DB_ERROR;
			}

			goto funct_exit;
		}

		/* The "to_be_dropped" marks table that is to be dropped, but
		has not been dropped, instead, was put in the background drop
		list due to being used by concurrent DML operations. Clear it
		here since there are no longer any concurrent activities on it,
		and it is free to be dropped */
		table->to_be_dropped = false;

		/* If we get this far then the table to be dropped must not have
		any table or record locks on it. */

		ut_a(dict_table_is_intrinsic(table) || !lock_table_has_locks(table));

		switch (trx_get_dict_operation(trx)) {
		case TRX_DICT_OP_NONE:
			trx_set_dict_operation(trx, TRX_DICT_OP_TABLE);
			trx->table_id = table->id;
		case TRX_DICT_OP_TABLE:
			break;
		case TRX_DICT_OP_INDEX:
			/* If the transaction was previously flagged as
			TRX_DICT_OP_INDEX, we should be dropping auxiliary
			tables for full-text indexes or temp tables. */
			ut_ad(strstr(table->name.m_name, "/FTS_") != NULL
				  || strstr(table->name.m_name, TEMP_FILE_PREFIX_INNODB)
				  != NULL);
		}

		/* Mark all indexes unavailable in the data dictionary cache
		before starting to drop the table. */

		unsigned*	page_no;
		unsigned*	page_nos;
		heap = mem_heap_create(
			200 + UT_LIST_GET_LEN(table->indexes) * sizeof *page_nos);
		tablename = mem_heap_strdup(heap, name);

		page_no = page_nos = static_cast<unsigned*>(
			mem_heap_alloc(
				heap,
				UT_LIST_GET_LEN(table->indexes) * sizeof *page_no));

		for (dict_index_t* index = dict_table_get_first_index(table);
			 index != NULL;
			 index = dict_table_get_next_index(index)) {
			rw_lock_x_lock(dict_index_get_lock(index));
			/* Save the page numbers so that we can restore them
			if the operation fails. */
			*page_no++ = index->page;
			/* Mark the index unusable. */
			index->page = FIL_NULL;
			rw_lock_x_unlock(dict_index_get_lock(index));
		}

		/* As we don't insert entries to SYSTEM TABLES for temp-tables
		we need to avoid running removal of these entries. */
		if (!dict_table_is_temporary(table)) {
			/* We use the private SQL parser of Innobase to generate the
			query graphs needed in deleting the dictionary data from system
			tables in Innobase. Deleting a row from SYS_INDEXES table also
			frees the file segments of the B-tree associated with the
			index. */

			info = pars_info_create();

			pars_info_add_str_literal(info, "table_name", name);

			std::basic_string<char, std::char_traits<char>,
					  ut_allocator<char> > sql;
			sql.reserve(2000);

			sql =	"PROCEDURE DROP_TABLE_PROC () IS\n"
				"sys_foreign_id CHAR;\n"
				"table_id CHAR;\n"
				"index_id CHAR;\n"
				"foreign_id CHAR;\n"
				"space_id INT;\n"
				"found INT;\n";

			sql +=	"DECLARE CURSOR cur_fk IS\n"
				"SELECT ID FROM SYS_FOREIGN\n"
				"WHERE FOR_NAME = :table_name\n"
				"AND TO_BINARY(FOR_NAME)\n"
				"  = TO_BINARY(:table_name)\n"
				"LOCK IN SHARE MODE;\n";

			sql +=	"DECLARE CURSOR cur_idx IS\n"
				"SELECT ID FROM SYS_INDEXES\n"
				"WHERE TABLE_ID = table_id\n"
				"LOCK IN SHARE MODE;\n";

			sql +=	"BEGIN\n";

			sql +=	"SELECT ID INTO table_id\n"
				"FROM SYS_TABLES\n"
				"WHERE NAME = :table_name\n"
				"LOCK IN SHARE MODE;\n"
				"IF (SQL % NOTFOUND) THEN\n"
				"       RETURN;\n"
				"END IF;\n";

			sql +=	"SELECT SPACE INTO space_id\n"
				"FROM SYS_TABLES\n"
				"WHERE NAME = :table_name;\n"
				"IF (SQL % NOTFOUND) THEN\n"
				"       RETURN;\n"
				"END IF;\n";

			sql +=	"found := 1;\n"
				"SELECT ID INTO sys_foreign_id\n"
				"FROM SYS_TABLES\n"
				"WHERE NAME = 'SYS_FOREIGN'\n"
				"LOCK IN SHARE MODE;\n"
				"IF (SQL % NOTFOUND) THEN\n"
				"       found := 0;\n"
				"END IF;\n"
				"IF (:table_name = 'SYS_FOREIGN') THEN\n"
				"       found := 0;\n"
				"END IF;\n"
				"IF (:table_name = 'SYS_FOREIGN_COLS') \n"
				"THEN\n"
				"       found := 0;\n"
				"END IF;\n";

			sql +=	"OPEN cur_fk;\n"
				"WHILE found = 1 LOOP\n"
				"       FETCH cur_fk INTO foreign_id;\n"
				"       IF (SQL % NOTFOUND) THEN\n"
				"               found := 0;\n"
				"       ELSE\n"
				"               DELETE FROM \n"
				"		   SYS_FOREIGN_COLS\n"
				"               WHERE ID = foreign_id;\n"
				"               DELETE FROM SYS_FOREIGN\n"
				"               WHERE ID = foreign_id;\n"
				"       END IF;\n"
				"END LOOP;\n"
				"CLOSE cur_fk;\n";

			sql +=	"found := 1;\n"
				"OPEN cur_idx;\n"
				"WHILE found = 1 LOOP\n"
				"       FETCH cur_idx INTO index_id;\n"
				"       IF (SQL % NOTFOUND) THEN\n"
				"               found := 0;\n"
				"       ELSE\n"
				"               DELETE FROM SYS_FIELDS\n"
				"               WHERE INDEX_ID = index_id;\n"
				"               DELETE FROM SYS_INDEXES\n"
				"               WHERE ID = index_id\n"
				"               AND TABLE_ID = table_id;\n"
				"       END IF;\n"
				"END LOOP;\n"
				"CLOSE cur_idx;\n";

			sql +=	"DELETE FROM SYS_COLUMNS\n"
				"WHERE TABLE_ID = table_id;\n"
				"DELETE FROM SYS_TABLES\n"
				"WHERE NAME = :table_name;\n";

			if (dict_table_is_file_per_table(table)) {
				sql += "DELETE FROM SYS_TABLESPACES\n"
					"WHERE SPACE = space_id;\n"
					"DELETE FROM SYS_DATAFILES\n"
					"WHERE SPACE = space_id;\n";
			}

			sql +=	"DELETE FROM SYS_VIRTUAL\n"
				"WHERE TABLE_ID = table_id;\n";

			sql += "END;\n";

			err = que_eval_sql(info, sql.c_str(), FALSE, trx);
		} else {
			page_no = page_nos;
			for (dict_index_t* index = dict_table_get_first_index(table);
				 index != NULL;
				 index = dict_table_get_next_index(index)) {
				/* remove the index object associated. */
				dict_drop_index_tree_in_mem(index, *page_no++);
			}
			err = DB_SUCCESS;
		}

		switch (err) {
			ulint	space_id;
			bool	is_temp;
			bool	is_encrypted;
			bool	ibd_file_missing;
			bool	is_discarded;
			bool	shared_tablespace;

		case DB_SUCCESS:
			space_id = table->space;
			ibd_file_missing = table->ibd_file_missing;
			is_discarded = dict_table_is_discarded(table);
			is_temp = dict_table_is_temporary(table);
			is_encrypted = dict_table_is_encrypted(table);
			shared_tablespace = DICT_TF_HAS_SHARED_SPACE(table->flags);

			/* If there is a temp path then the temp flag is set.
			However, during recovery, we might have a temp flag but
			not know the temp path */
			ut_a(table->dir_path_of_temp_table == NULL || is_temp);

			/* We do not allow temporary tables with a remote path. */
			ut_a(!(is_temp && DICT_TF_HAS_DATA_DIR(table->flags)));

			/* Make sure the data_dir_path is set if needed. */
			dict_get_and_save_data_dir_path(table, true);

			err = row_drop_ancillary_fts_tables(table, trx);
			if (err != DB_SUCCESS) {
				break;
			}

			/* Determine the tablespace filename before we drop
			dict_table_t.  Free this memory before returning. */
			if (DICT_TF_HAS_DATA_DIR(table->flags)) {
				ut_a(table->data_dir_path);

				filepath = fil_make_filepath(
					table->data_dir_path,
					table->name.m_name, IBD, true);
			} else if (table->dir_path_of_temp_table) {
				filepath = fil_make_filepath(
					table->dir_path_of_temp_table,
					NULL, IBD, false);
			} else if (!shared_tablespace) {
				filepath = fil_make_filepath(
					NULL, table->name.m_name, IBD, false);
			}

			/* Free the dict_table_t object. */
			err = row_drop_table_from_cache(tablename, table, trx);
			if (err != DB_SUCCESS) {
				break;
			}

			/* Do not attempt to drop known-to-be-missing tablespaces,
			nor system or shared general tablespaces. */
			if (is_discarded || ibd_file_missing || shared_tablespace
				|| is_system_tablespace(space_id)) {
				/* For encrypted table, if ibd file can not be decrypt,
				we also set ibd_file_missing. We still need to try to
				remove the ibd file for this. */
				if (is_discarded || !is_encrypted
					|| !ibd_file_missing) {
					break;
				}
			}

			if (is_encrypted) {
				/* Require the mutex to block key rotation. */
				mutex_enter(&master_key_id_mutex);
			}
			/* We can now drop the single-table tablespace. */
			err = row_drop_single_table_tablespace(
				space_id, tablename, filepath,
				is_temp, is_encrypted, trx);

			if (is_encrypted) {
				mutex_exit(&master_key_id_mutex);
			}
			break;

		case DB_OUT_OF_FILE_SPACE:
			err = DB_MUST_GET_MORE_FILE_SPACE;

			row_mysql_handle_errors(&err, trx, NULL, NULL);

			/* raise error */
			ut_error;
			break;

		case DB_TOO_MANY_CONCURRENT_TRXS:
			/* Cannot even find a free slot for the
			the undo log. We can directly exit here
			and return the DB_TOO_MANY_CONCURRENT_TRXS
			error. */

		default:
			/* This is some error we do not expect. Print
			the error number and rollback the transaction */
			ib::error() << "Unknown error code " << err << " while"
				" dropping table: "
				<< ut_get_name(trx, tablename) << ".";

			trx->error_state = DB_SUCCESS;
			trx_rollback_to_savepoint(trx, NULL);
			trx->error_state = DB_SUCCESS;

			/* Mark all indexes available in the data dictionary
			cache again. */

			page_no = page_nos;

			for (dict_index_t* index = dict_table_get_first_index(table);
				 index != NULL;
				 index = dict_table_get_next_index(index)) {
				rw_lock_x_lock(dict_index_get_lock(index));
				ut_a(index->page == FIL_NULL);
				index->page = *page_no++;
				rw_lock_x_unlock(dict_index_get_lock(index));
			}
		}

		if (err != DB_SUCCESS && table != NULL) {
			/* Drop table has failed with error but as drop table is not
			transaction safe we should mark the table as corrupted to avoid
			unwarranted follow-up action on this table that can result
			in more serious issues. */

			table->corrupted = true;
			for (dict_index_t* index = UT_LIST_GET_FIRST(table->indexes);
				 index != NULL;
				 index = UT_LIST_GET_NEXT(indexes, index)) {
				dict_set_corrupted(index, trx, "DROP TABLE");
			}
		}

	funct_exit:
		if (heap) {
			mem_heap_free(heap);
		}

		ut_free(filepath);

		if (locked_dictionary) {

			if (trx_is_started(trx)) {

				trx_commit_for_mysql(trx);
			}

			row_mysql_unlock_data_dictionary(trx);
		}

		trx->op_info = "";

		/* No need to immediately invoke master thread as there is no work
		generated by intrinsic table operation that needs master thread
		attention. */
		if (!is_intrinsic_temp_table) {
			srv_wake_master_thread();
		}

		DBUG_RETURN(err);
	}
