

	在事务协调器中准备事务。
	写记录到日志缓冲区。
	
	从5.7.26开始，设置了持久化属性为 HA_IGNORE_DURABILITY ，即在prepare阶段不再对Redo日志刷盘；而对于InnoDB层的prepare：
		5.7.26开始关闭临时表空间的Redo日志，因为它不需要崩溃恢复
		从5.7.26开始，RC隔离级别及以下，会释放GAP锁
		从5.7.26开始，因使用HA_IGNORE_DURABILITY属性，在prepare阶段不再处理由 innodb_flush_log_at_trx_commit 参数控制的Redo日志的刷盘

	
/*
  Prepare the transaction in the transaction coordinator.

  This function will prepare the transaction in the storage engines
  (by calling @c ha_prepare_low) what will write a prepare record
  to the log buffers.

  @retval 0    success
  @retval 1    error
*/
int MYSQL_BIN_LOG::prepare(THD *thd, bool all)
{
  DBUG_ENTER("MYSQL_BIN_LOG::prepare");

  DBUG_ASSERT(opt_bin_log);
  /*
    The applier thread explicitly overrides the value of sql_log_bin
    with the value of log_slave_updates.
  */
  DBUG_ASSERT(thd->slave_thread ?
              opt_log_slave_updates : thd->variables.sql_log_bin);

  /*
    Set HA_IGNORE_DURABILITY to not flush the prepared record of the
    transaction to the log of storage engine (for example, InnoDB
    redo log) during the prepare phase. So that we can flush prepared
    records of transactions to the log of storage engine in a group
    right before flushing them to binary log during binlog group
    commit flush stage. Reset to HA_REGULAR_DURABILITY at the
    beginning of parsing next command.
  */
  thd->durability_property= HA_IGNORE_DURABILITY;

  int error= ha_prepare_low(thd, all);

  DBUG_RETURN(error);
}




int ha_prepare_low(THD *thd, bool all)
{
  int error= 0;
  Transaction_ctx::enum_trx_scope trx_scope=
    all ? Transaction_ctx::SESSION : Transaction_ctx::STMT;
  Ha_trx_info *ha_info= thd->get_transaction()->ha_trx_info(trx_scope);

  DBUG_ENTER("ha_prepare_low");

  if (ha_info)
  {
    for (; ha_info && !error; ha_info= ha_info->next())
    {
      int err= 0;
      handlerton *ht= ha_info->ht();
      /*
        Do not call two-phase commit if this particular
        transaction is read-only. This allows for simpler
        implementation in engines that are always read-only.
      */
      if (!ha_info->is_trx_read_write())
        continue;
      if ((err= ht->prepare(ht, thd, all)))
      {
        my_error(ER_ERROR_DURING_COMMIT, MYF(0), err);
        error= 1;
      }
      DBUG_ASSERT(!thd->status_var_aggregated);
      thd->status_var.ha_prepare_count++;
    }
    DBUG_EXECUTE_IF("crash_commit_after_prepare", DBUG_SUICIDE(););
  }

  DBUG_RETURN(error);
}


-- 生成last_commit
static int binlog_prepare(handlerton *hton, THD *thd, bool all)
{
  DBUG_ENTER("binlog_prepare");
  if (!all)
  {
    thd->get_transaction()->store_commit_parent(mysql_bin_log.
      m_dependency_tracker.get_max_committed_timestamp());

  }

  DBUG_RETURN(all && is_loggable_xa_prepare(thd) ?
              mysql_bin_log.commit(thd, true) : 0);
}


int64 Transaction_dependency_tracker::get_max_committed_timestamp()
{
  return m_commit_order.get_max_committed_transaction().get_timestamp();
}


/*******************************************************************//**
This function is used to prepare an X/Open XA distributed transaction.
@return 0 or error number */
static
int
innobase_xa_prepare(
/*================*/
	handlerton*	hton,		/*!< in: InnoDB handlerton */
	THD*		thd,		/*!< in: handle to the MySQL thread of
					the user whose XA transaction should
					be prepared */
	bool		prepare_trx)	/*!< in: true - prepare transaction
					false - the current SQL statement
					ended */
{
	trx_t*		trx = check_trx_exists(thd);

	DBUG_ASSERT(hton == innodb_hton_ptr);

	-- 获取 XID 
	thd_get_xid(thd, (MYSQL_XID*) trx->xid);

	/* Release a possible FIFO ticket and search latch. Since we will
	reserve the trx_sys->mutex, we have to release the search system
	latch first to obey the latching order. */

	trx_search_latch_release_if_reserved(trx);

	innobase_srv_conc_force_exit_innodb(trx);

	TrxInInnoDB	trx_in_innodb(trx);

	if (trx_in_innodb.is_aborted() ||
	    DBUG_EVALUATE_IF("simulate_xa_failure_prepare_in_engine", 1, 0)) {

		innobase_rollback(hton, thd, prepare_trx);

		return(convert_error_code_to_mysql(
			DB_FORCED_ABORT, 0, thd));
	}

	if (!trx_is_registered_for_2pc(trx) && trx_is_started(trx)) {

		sql_print_error("Transaction not registered for MySQL 2PC,"
				" but transaction is active");
	}

	if (prepare_trx
	    || (!thd_test_options(thd, OPTION_NOT_AUTOCOMMIT | OPTION_BEGIN))) {

		/* We were instructed to prepare the whole transaction, or
		this is an SQL statement end and autocommit is on */

		ut_ad(trx_is_registered_for_2pc(trx));
		
		-- 
		dberr_t	err = trx_prepare_for_mysql(trx);

		ut_ad(err == DB_SUCCESS || err == DB_FORCED_ABORT);

		if (err == DB_FORCED_ABORT) {

			innobase_rollback(hton, thd, prepare_trx);

			return(convert_error_code_to_mysql(
				DB_FORCED_ABORT, 0, thd));
		}

	} else {
		/* We just mark the SQL statement ended and do not do a
		transaction prepare */

		/* If we had reserved the auto-inc lock for some
		table in this SQL statement we release it now */

		lock_unlock_table_autoinc(trx);

		/* Store the current undo_no of the transaction so that we
		know where to roll back if we have to roll back the next
		SQL statement */

		trx_mark_sql_stat_end(trx);
	}

	if (thd_sql_command(thd) != SQLCOM_XA_PREPARE
	    && (prepare_trx
		|| !thd_test_options(
			thd, OPTION_NOT_AUTOCOMMIT | OPTION_BEGIN))) {

		/* For mysqlbackup to work the order of transactions in binlog
		and InnoDB must be the same. Consider the situation

		  thread1> prepare; write to binlog; ...
			  <context switch>
		  thread2> prepare; write to binlog; commit
		  thread1>			     ... commit

                The server guarantees that writes to the binary log
                and commits are in the same order, so we do not have
                to handle this case. */
	}

	return(0);
}


extern "C"
void thd_get_xid(const MYSQL_THD thd, MYSQL_XID *xid)
{
  *xid = *(MYSQL_XID *) thd->get_transaction()->xid_state()->get_xid();
}



/**
Does the transaction prepare for MySQL.
@param[in, out] trx		Transaction instance to prepare */
dberr_t
trx_prepare_for_mysql(trx_t* trx)
{
	trx_start_if_not_started_xa(trx, false);

	TrxInInnoDB	trx_in_innodb(trx, true);

	if (trx_in_innodb.is_aborted()
	    && trx->killed_by != os_thread_get_curr_id()) {

		return(DB_FORCED_ABORT);
	}

	trx->op_info = "preparing";

	trx_prepare(trx);

	trx->op_info = "";

	return(DB_SUCCESS);
}



/****************************************************************//**
Prepares a transaction. */
static
void
trx_prepare(
/*========*/
	trx_t*	trx)	/*!< in/out: transaction */
{
	/* This transaction has crossed the point of no return and cannot
	be rolled back asynchronously now. It must commit or rollback
	synhronously. */

	lsn_t	lsn = 0;

	/* Only fresh user transactions can be prepared.
	Recovered transactions cannot. */
	ut_a(!trx->is_recovered);

	if (trx->rsegs.m_redo.rseg != NULL && trx_is_redo_rseg_updated(trx)) {

		lsn = trx_prepare_low(trx, &trx->rsegs.m_redo, false);
	}

	DBUG_EXECUTE_IF("ib_trx_crash_during_xa_prepare_step", DBUG_SUICIDE(););

	if (trx->rsegs.m_noredo.rseg != NULL
	    && trx_is_noredo_rseg_updated(trx)) {

		trx_prepare_low(trx, &trx->rsegs.m_noredo, true);
	}

	/*--------------------------------------*/
	ut_a(trx->state == TRX_STATE_ACTIVE);
	trx_sys_mutex_enter();
	trx->state = TRX_STATE_PREPARED;
	trx_sys->n_prepared_trx++;
	trx_sys_mutex_exit();
	/*--------------------------------------*/

	/* Force isolation level to RC and release GAP locks
	for test purpose. */
	DBUG_EXECUTE_IF("ib_force_release_gap_lock_prepare",
			trx->isolation_level = TRX_ISO_READ_COMMITTED;);

	/* Release read locks after PREPARE for READ COMMITTED
	and lower isolation. */
	if (trx->isolation_level <= TRX_ISO_READ_COMMITTED) {

		/* Stop inheriting GAP locks. */
		trx->skip_lock_inheritance = true;

		/* Release only GAP locks for now. */
		lock_trx_release_read_locks(trx, true);
	}

	switch (thd_requested_durability(trx->mysql_thd)) {
	case HA_IGNORE_DURABILITY:
		/* We set the HA_IGNORE_DURABILITY during prepare phase of
		binlog group commit to not flush redo log for every transaction
		here. So that we can flush prepared records of transactions to
		redo log in a group right before writing them to binary log
		during flush stage of binlog group commit. */
		break;
	case HA_REGULAR_DURABILITY:
		if (lsn == 0) {
			break;
		}
		/* Depending on the my.cnf options, we may now write the log
		buffer to the log files, making the prepared state of the
		transaction durable if the OS does not crash. We may also
		flush the log files to disk, making the prepared state of the
		transaction durable also at an OS crash or a power outage.

		The idea in InnoDB's group prepare is that a group of
		transactions gather behind a trx doing a physical disk write
		to log files, and when that physical write has been completed,
		one of those transactions does a write which prepares the whole
		group. Note that this group prepare will only bring benefit if
		there are > 2 users in the database. Then at least 2 users can
		gather behind one doing the physical log write to disk.

		We must not be holding any mutexes or latches here. */

		trx_flush_log_if_needed(lsn, trx);
	}
}


-- 为给定的回滚段准备一个事务。
/****************************************************************//**
Prepares a transaction for given rollback segment.
@return lsn_t: lsn assigned for commit of scheduled rollback segment */
static
lsn_t
trx_prepare_low(
/*============*/
	trx_t*		trx,		/*!< in/out: transaction */
	trx_undo_ptr_t*	undo_ptr,	/*!< in/out: pointer to rollback
					segment scheduled for prepare. */
	bool		noredo_logging)	/*!< in: turn-off redo logging. */
{
	lsn_t		lsn;

	if (undo_ptr->insert_undo != NULL || undo_ptr->update_undo != NULL) {
		mtr_t		mtr;
		trx_rseg_t*	rseg = undo_ptr->rseg;

		mtr_start_sync(&mtr);

		if (noredo_logging) {
			mtr_set_log_mode(&mtr, MTR_LOG_NO_REDO);
		}

		/* Change the undo log segment states from TRX_UNDO_ACTIVE to
		TRX_UNDO_PREPARED: these modifications to the file data
		structure define the transaction as prepared in the file-based
		world, at the serialization point of lsn. */

		mutex_enter(&rseg->mutex);

		if (undo_ptr->insert_undo != NULL) {

			/* It is not necessary to obtain trx->undo_mutex here
			because only a single OS thread is allowed to do the
			transaction prepare for this transaction. */
			trx_undo_set_state_at_prepare(
				trx, undo_ptr->insert_undo, false, &mtr);
		}

		if (undo_ptr->update_undo != NULL) {
			trx_undo_set_state_at_prepare(
				trx, undo_ptr->update_undo, false, &mtr);
		}

		mutex_exit(&rseg->mutex);

		/*--------------*/
		/* This mtr commit makes the transaction prepared in
		file-based world. */
		mtr_commit(&mtr);
		/*--------------*/

		lsn = mtr.commit_lsn();
		ut_ad(noredo_logging || lsn > 0);
	} else {
		lsn = 0;
	}

	return(lsn);
}



将 undo 页面段头的TRX_UNDO_STATE设置为TRX_UNDO_PREPARED， 表明当前事务处在Prepare阶段


/** Set the state of the undo log segment at a XA PREPARE or XA ROLLBACK.
@param[in,out]	trx		transaction
@param[in,out]	undo		insert_undo or update_undo log
@param[in]	rollback	false=XA PREPARE, true=XA ROLLBACK
@param[in,out]	mtr		mini-transaction
@return undo log segment header page, x-latched */
page_t*
trx_undo_set_state_at_prepare(
	trx_t*		trx,
	trx_undo_t*	undo,
	bool		rollback,
	mtr_t*		mtr)
{
	trx_usegf_t*	seg_hdr;
	trx_ulogf_t*	undo_header;
	page_t*		undo_page;
	ulint		offset;

	ut_ad(trx && undo && mtr);

	ut_a(undo->id < TRX_RSEG_N_SLOTS);

	undo_page = trx_undo_page_get(
		page_id_t(undo->space, undo->hdr_page_no),
		undo->page_size, mtr);

	seg_hdr = undo_page + TRX_UNDO_SEG_HDR;

	if (rollback) {
		ut_ad(undo->state == TRX_UNDO_PREPARED);
		mlog_write_ulint(seg_hdr + TRX_UNDO_STATE, TRX_UNDO_ACTIVE,
				 MLOG_2BYTES, mtr);
		return(undo_page);
	}

	/*------------------------------*/
	ut_ad(undo->state == TRX_UNDO_ACTIVE);
	undo->state = TRX_UNDO_PREPARED;
	undo->xid   = *trx->xid;
	/*------------------------------*/

	mlog_write_ulint(seg_hdr + TRX_UNDO_STATE, undo->state,
			 MLOG_2BYTES, mtr);

	offset = mach_read_from_2(seg_hdr + TRX_UNDO_LAST_LOG);
	undo_header = undo_page + offset;

	mlog_write_ulint(undo_header + TRX_UNDO_XID_EXISTS,
			 TRUE, MLOG_1BYTE, mtr);

	trx_undo_write_xid(undo_header, &undo->xid, mtr);

	return(undo_page);
}

/**********************************************************************//**
If required, flushes the log to disk based on the value of
innodb_flush_log_at_trx_commit. */
static
void
trx_flush_log_if_needed(
/*====================*/
	lsn_t	lsn,	/*!< in: lsn up to which logs are to be
			flushed. */
	trx_t*	trx)	/*!< in/out: transaction */
{
	trx->op_info = "flushing log";
	trx_flush_log_if_needed_low(lsn);
	trx->op_info = "";
}




/**********************************************************************//**
If required, flushes the log to disk based on the value of
innodb_flush_log_at_trx_commit. */
static
void
trx_flush_log_if_needed_low(
/*========================*/
	lsn_t	lsn)	/*!< in: lsn up to which logs are to be
			flushed. */
{
#ifdef _WIN32
	bool	flush = true;
#else
	bool	flush = srv_unix_file_flush_method != SRV_UNIX_NOSYNC;
#endif /* _WIN32 */

	switch (srv_flush_log_at_trx_commit) {
	case 2:
		/* Write the log but do not flush it to disk */
		flush = false;
		/* fall through */
	case 1:
		/* Write the log and optionally flush it to disk */
		log_write_up_to(lsn, flush);
		return;
	case 0:
		/* Do nothing */
		return;
	}

	ut_error;
}


写redo log的入口函数为 log_write_up_to

/** Ensure that the log has been written to the log file up to a given
log entry (such as that of a transaction commit). Start a new write, or
wait and check if an already running write is covering the request.
@param[in]	lsn		log sequence number that should be
included in the redo log file write
@param[in]	flush_to_disk	whether the written log should also
be flushed to the file system */
void
log_write_up_to(
	lsn_t	lsn,
	bool	flush_to_disk)
{
#ifdef UNIV_DEBUG
	ulint		loop_count	= 0;
#endif /* UNIV_DEBUG */
	byte*           write_buf;
	lsn_t           write_lsn;

	ut_ad(!srv_read_only_mode);

	if (recv_no_ibuf_operations) {
		/* Recovery is running and no operations on the log files are
		allowed yet (the variable name .._no_ibuf_.. is misleading) */

		return;
	}

loop:
	ut_ad(++loop_count < 128);

#if UNIV_WORD_SIZE > 7
	/* We can do a dirty read of LSN. */
	/* NOTE: Currently doesn't do dirty read for
	(flush_to_disk == true) case, because the log_mutex
	contention also works as the arbitrator for write-IO
	(fsync) bandwidth between log files and data files. */
	os_rmb;
	if (!flush_to_disk && log_sys->write_lsn >= lsn) {
		return;
	}
#endif

	log_write_mutex_enter();
	ut_ad(!recv_no_log_write);

	lsn_t	limit_lsn = flush_to_disk
		? log_sys->flushed_to_disk_lsn
		: log_sys->write_lsn;

	if (limit_lsn >= lsn) {
		log_write_mutex_exit();
		return;
	}

#ifdef _WIN32
# ifndef UNIV_HOTBACKUP
	/* write requests during fil_flush() might not be good for Windows */
	if (log_sys->n_pending_flushes > 0
	    || !os_event_is_set(log_sys->flush_event)) {
		log_write_mutex_exit();
		os_event_wait(log_sys->flush_event);
		goto loop;
	}
# else
	if (log_sys->n_pending_flushes > 0) {
		goto loop;
	}
# endif  /* !UNIV_HOTBACKUP */
#endif /* _WIN32 */

	/* If it is a write call we should just go ahead and do it
	as we checked that write_lsn is not where we'd like it to
	be. If we have to flush as well then we check if there is a
	pending flush and based on that we wait for it to finish
	before proceeding further. */
	if (flush_to_disk
	    && (log_sys->n_pending_flushes > 0
		|| !os_event_is_set(log_sys->flush_event))) {

		/* Figure out if the current flush will do the job
		for us. */
		bool work_done = log_sys->current_flush_lsn >= lsn;

		log_write_mutex_exit();

		os_event_wait(log_sys->flush_event);

		if (work_done) {
			return;
		} else {
			goto loop;
		}
	}

	log_mutex_enter();
	if (!flush_to_disk
	    && log_sys->buf_free == log_sys->buf_next_to_write) {
		/* Nothing to write and no flush to disk requested */
		log_mutex_exit_all();
		return;
	}

	log_group_t*	group;
	ulint		start_offset;
	ulint		end_offset;
	ulint		area_start;
	ulint		area_end;
	ulong		write_ahead_size = srv_log_write_ahead_size;
	ulint		pad_size;

	DBUG_PRINT("ib_log", ("write " LSN_PF " to " LSN_PF,
			      log_sys->write_lsn,
			      log_sys->lsn));

	if (flush_to_disk) {
		log_sys->n_pending_flushes++;
		log_sys->current_flush_lsn = log_sys->lsn;
		MONITOR_INC(MONITOR_PENDING_LOG_FLUSH);
		os_event_reset(log_sys->flush_event);

		if (log_sys->buf_free == log_sys->buf_next_to_write) {
			/* Nothing to write, flush only */
			log_mutex_exit_all();
			log_write_flush_to_disk_low();
			return;
		}
	}

	start_offset = log_sys->buf_next_to_write;
	end_offset = log_sys->buf_free;

	area_start = ut_calc_align_down(start_offset, OS_FILE_LOG_BLOCK_SIZE);
	area_end = ut_calc_align(end_offset, OS_FILE_LOG_BLOCK_SIZE);

	ut_ad(area_end - area_start > 0);

	log_block_set_flush_bit(log_sys->buf + area_start, TRUE);
	log_block_set_checkpoint_no(
		log_sys->buf + area_end - OS_FILE_LOG_BLOCK_SIZE,
		log_sys->next_checkpoint_no);

	write_lsn = log_sys->lsn;
	write_buf = log_sys->buf;

	log_buffer_switch();

	group = UT_LIST_GET_FIRST(log_sys->log_groups);

	log_group_set_fields(group, log_sys->write_lsn);

	log_mutex_exit();

	/* Calculate pad_size if needed. */
	pad_size = 0;
	if (write_ahead_size > OS_FILE_LOG_BLOCK_SIZE) {
		lsn_t	end_offset;
		ulint	end_offset_in_unit;

		end_offset = log_group_calc_lsn_offset(
			ut_uint64_align_up(write_lsn,
					   OS_FILE_LOG_BLOCK_SIZE),
			group);
		end_offset_in_unit = (ulint) (end_offset % write_ahead_size);

		if (end_offset_in_unit > 0
		    && (area_end - area_start) > end_offset_in_unit) {
			/* The first block in the unit was initialized
			after the last writing.
			Needs to be written padded data once. */
			pad_size = write_ahead_size - end_offset_in_unit;

			if (area_end + pad_size > log_sys->buf_size) {
				pad_size = log_sys->buf_size - area_end;
			}

			::memset(write_buf + area_end, 0, pad_size);
		}
	}
	
	-- 写入日志文件 
	/* Do the write to the log files */
	log_group_write_buf(
		group, write_buf + area_start,
		area_end - area_start + pad_size,
#ifdef UNIV_DEBUG
		pad_size,
#endif /* UNIV_DEBUG */
		ut_uint64_align_down(log_sys->write_lsn,
				     OS_FILE_LOG_BLOCK_SIZE),
		start_offset - area_start);

	srv_stats.log_padded.add(pad_size);

	log_sys->write_lsn = write_lsn;

#ifndef _WIN32
	if (srv_unix_file_flush_method == SRV_UNIX_O_DSYNC) {
		/* O_SYNC means the OS did not buffer the log file at all:
		so we have also flushed to disk what we have written */
		log_sys->flushed_to_disk_lsn = log_sys->write_lsn;
	}
#endif /* !_WIN32 */

	log_write_mutex_exit();

	if (flush_to_disk) {
		log_write_flush_to_disk_low();
	}
}


-- 将缓冲区写入日志文件组
/******************************************************//**
Writes a buffer to a log file group. */
static
void
log_group_write_buf(
/*================*/
	log_group_t*	group,		/*!< in: log group */
	byte*		buf,		/*!< in: buffer */
	ulint		len,		/*!< in: buffer len; must be divisible
					by OS_FILE_LOG_BLOCK_SIZE */
#ifdef UNIV_DEBUG
	ulint		pad_len,	/*!< in: pad len in the buffer len */
#endif /* UNIV_DEBUG */
	lsn_t		start_lsn,	/*!< in: start lsn of the buffer; must
					be divisible by
					OS_FILE_LOG_BLOCK_SIZE */
	ulint		new_data_offset)/*!< in: start offset of new data in
					buf: this parameter is used to decide
					if we have to write a new log file
					header */
{
	ulint		write_len;
	bool		write_header	= new_data_offset == 0;
	lsn_t		next_offset;
	ulint		i;

	ut_ad(log_write_mutex_own());
	ut_ad(!recv_no_log_write);
	ut_a(len % OS_FILE_LOG_BLOCK_SIZE == 0);
	ut_a(start_lsn % OS_FILE_LOG_BLOCK_SIZE == 0);

loop:
	if (len == 0) {

		return;
	}

	next_offset = log_group_calc_lsn_offset(start_lsn, group);

	if (write_header
	    && next_offset % group->file_size == LOG_FILE_HDR_SIZE) {
		/* We start to write a new log file instance in the group */

		ut_a(next_offset / group->file_size <= ULINT_MAX);

		log_group_file_header_flush(group, (ulint)
					    (next_offset / group->file_size),
					    start_lsn);
		srv_stats.os_log_written.add(OS_FILE_LOG_BLOCK_SIZE);

		srv_stats.log_writes.inc();
	}

	if ((next_offset % group->file_size) + len > group->file_size) {

		/* if the above condition holds, then the below expression
		is < len which is ulint, so the typecast is ok */
		write_len = (ulint)
			(group->file_size - (next_offset % group->file_size));
	} else {
		write_len = len;
	}

	DBUG_PRINT("ib_log",
		   ("write " LSN_PF " to " LSN_PF
		    ": group " ULINTPF " len " ULINTPF
		    " blocks " ULINTPF ".." ULINTPF,
		    start_lsn, next_offset,
		    group->id, write_len,
		    log_block_get_hdr_no(buf),
		    log_block_get_hdr_no(
			    buf + write_len
			    - OS_FILE_LOG_BLOCK_SIZE)));

	ut_ad(pad_len >= len
	      || log_block_get_hdr_no(buf)
		 == log_block_convert_lsn_to_no(start_lsn));

	/* Calculate the checksums for each log block and write them to
	the trailer fields of the log blocks */

	for (i = 0; i < write_len / OS_FILE_LOG_BLOCK_SIZE; i++) {
		ut_ad(pad_len >= len
		      || i * OS_FILE_LOG_BLOCK_SIZE >= len - pad_len
		      || log_block_get_hdr_no(
			      buf + i * OS_FILE_LOG_BLOCK_SIZE)
			 == log_block_get_hdr_no(buf) + i);
		log_block_store_checksum(buf + i * OS_FILE_LOG_BLOCK_SIZE);
	}

	log_sys->n_log_ios++;

	MONITOR_INC(MONITOR_LOG_IO);

	srv_stats.os_log_pending_writes.inc();

	ut_a(next_offset / UNIV_PAGE_SIZE <= ULINT_MAX);

	const ulint	page_no
		= (ulint) (next_offset / univ_page_size.physical());

	fil_io(IORequestLogWrite, true,
	       page_id_t(group->space_id, page_no),
	       univ_page_size,
	       (ulint) (next_offset % UNIV_PAGE_SIZE), write_len, buf,
	       group);

	srv_stats.os_log_pending_writes.dec();

	srv_stats.os_log_written.add(write_len);
	srv_stats.log_writes.inc();

	if (write_len < len) {
		start_lsn += write_len;
		len -= write_len;
		buf += write_len;

		write_header = true;

		goto loop;
	}
}
