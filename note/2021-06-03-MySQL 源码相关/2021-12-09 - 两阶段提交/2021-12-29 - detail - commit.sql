
-- 提交一系列会话

/**
  Commit a sequence of sessions.

  This function commit an entire queue of sessions starting with the
  session in @c first. If there were an error in the flushing part of
  the ordered commit, the error code is passed in and all the threads
  are marked accordingly (but not committed).

  It will also add the GTIDs of the transactions to gtid_executed.

  @see MYSQL_BIN_LOG::ordered_commit

  @param thd The "master" thread
  @param first First thread in the queue of threads to commit
 */

void
MYSQL_BIN_LOG::process_commit_stage_queue(THD *thd, THD *first)
{
  mysql_mutex_assert_owner(&LOCK_commit);
#ifndef DBUG_OFF
  thd->get_transaction()->m_flags.ready_preempt= 1; // formality by the leader
#endif
  for (THD *head= first ; head ; head = head->next_to_commit)
  {
    DBUG_PRINT("debug", ("Thread ID: %u, commit_error: %d, flags.pending: %s",
                         head->thread_id(), head->commit_error,
                         YESNO(head->get_transaction()->m_flags.pending)));
    /*
      If flushing failed, set commit_error for the session, skip the
      transaction and proceed with the next transaction instead. This
      will mark all threads as failed, since the flush failed.

      If flush succeeded, attach to the session and commit it in the
      engines.
    */
#ifndef DBUG_OFF
    stage_manager.clear_preempt_status(head);
#endif
    if (head->get_transaction()->sequence_number != SEQ_UNINIT)
    {
      mysql_mutex_lock(&LOCK_slave_trans_dep_tracker);
      m_dependency_tracker.update_max_committed(head);
      mysql_mutex_unlock(&LOCK_slave_trans_dep_tracker);
    }
    /*
      Flush/Sync error should be ignored and continue
      to commit phase. And thd->commit_error cannot be
      COMMIT_ERROR at this moment.
    */
    DBUG_ASSERT(head->commit_error != THD::CE_COMMIT_ERROR);
#ifndef EMBEDDED_LIBRARY
    Thd_backup_and_restore switch_thd(thd, head);
#endif /* !EMBEDDED_LIBRARY */
    bool all= head->get_transaction()->m_flags.real_commit;
    if (head->get_transaction()->m_flags.commit_low)
    {
      /* head is parked to have exited append() */
      DBUG_ASSERT(head->get_transaction()->m_flags.ready_preempt);
      /*
        storage engine commit
       */
      if (ha_commit_low(head, all, false))
        head->commit_error= THD::CE_COMMIT_ERROR;
    }
    DBUG_PRINT("debug", ("commit_error: %d, flags.pending: %s",
                         head->commit_error,
                         YESNO(head->get_transaction()->m_flags.pending)));
  }

  /*
    Handle the GTID of the threads.
    gtid_executed table is kept updated even though transactions fail to be
    logged. That's required by slave auto positioning.
  */
  gtid_state->update_commit_group(first);

  for (THD *head= first ; head ; head = head->next_to_commit)
  {
    /*
      Decrement the prepared XID counter after storage engine commit.
      We also need decrement the prepared XID when encountering a
      flush error or session attach error for avoiding 3-way deadlock
      among user thread, rotate thread and dump thread.
    */
    if (head->get_transaction()->m_flags.xid_written)
      dec_prep_xids(head);
  }
}



/*****************************************************************//**
Commits a transaction in an InnoDB database or marks an SQL statement
ended.
@return 0 or deadlock error if the transaction was aborted by another
	higher priority transaction. */
static
int
innobase_commit(
/*============*/
	handlerton*	hton,		/*!< in: InnoDB handlerton */
	THD*		thd,		/*!< in: MySQL thread handle of the
					user for whom the transaction should
					be committed */
	bool		commit_trx)	/*!< in: true - commit transaction
					false - the current SQL statement
					ended */
{
	DBUG_ENTER("innobase_commit");
	DBUG_ASSERT(hton == innodb_hton_ptr);
	DBUG_PRINT("trans", ("ending transaction"));

	trx_t*	trx = check_trx_exists(thd);

	TrxInInnoDB	trx_in_innodb(trx);

	if (trx_in_innodb.is_aborted()) {

		innobase_rollback(hton, thd, commit_trx);

		DBUG_RETURN(convert_error_code_to_mysql(
			DB_FORCED_ABORT, 0, thd));
	}

	ut_ad(trx->dict_operation_lock_mode == 0);
	ut_ad(trx->dict_operation == TRX_DICT_OP_NONE);

	/* Transaction is deregistered only in a commit or a rollback. If
	it is deregistered we know there cannot be resources to be freed
	and we could return immediately.  For the time being, we play safe
	and do the cleanup though there should be nothing to clean up. */

	if (!trx_is_registered_for_2pc(trx) && trx_is_started(trx)) {

		sql_print_error("Transaction not registered for MySQL 2PC,"
				" but transaction is active");
	}

	bool	read_only = trx->read_only || trx->id == 0;

	if (commit_trx
	    || (!thd_test_options(thd, OPTION_NOT_AUTOCOMMIT | OPTION_BEGIN))) {

		/* We were instructed to commit the whole transaction, or
		this is an SQL statement end and autocommit is on */

		/* We need current binlog position for mysqlbackup to work. */

		if (!read_only) {

			while (innobase_commit_concurrency > 0) {

				mysql_mutex_lock(&commit_cond_m);

				++commit_threads;

				if (commit_threads
				    <= innobase_commit_concurrency) {

					mysql_mutex_unlock(&commit_cond_m);
					break;
				}

				--commit_threads;

				mysql_cond_wait(&commit_cond, &commit_cond_m);

				mysql_mutex_unlock(&commit_cond_m);
			}

			/* The following call reads the binary log position of
			the transaction being committed.

			Binary logging of other engines is not relevant to
			InnoDB as all InnoDB requires is that committing
			InnoDB transactions appear in the same order in the
			MySQL binary log as they appear in InnoDB logs, which
			is guaranteed by the server.

			If the binary log is not enabled, or the transaction
			is not written to the binary log, the file name will
			be a NULL pointer. */
			ulonglong	pos;

			thd_binlog_pos(thd, &trx->mysql_log_file_name, &pos);

			trx->mysql_log_offset = static_cast<int64_t>(pos);

			/* Don't do write + flush right now. For group commit
			to work we want to do the flush later. */
			trx->flush_log_later = true;
		}

		innobase_commit_low(trx);

		if (!read_only) {
			trx->flush_log_later = false;

			if (innobase_commit_concurrency > 0) {

				mysql_mutex_lock(&commit_cond_m);

				ut_ad(commit_threads > 0);
				--commit_threads;

				mysql_cond_signal(&commit_cond);

				mysql_mutex_unlock(&commit_cond_m);
			}
		}

		trx_deregister_from_2pc(trx);

		/* Now do a write + flush of logs. */
		if (!read_only) {
			trx_commit_complete_for_mysql(trx);
		}

	} else {
		/* We just mark the SQL statement ended and do not do a
		transaction commit */

		/* If we had reserved the auto-inc lock for some
		table in this SQL statement we release it now */

		if (!read_only) {
			lock_unlock_table_autoinc(trx);
		}

		/* Store the current undo_no of the transaction so that we
		know where to roll back if we have to roll back the next
		SQL statement */

		trx_mark_sql_stat_end(trx);
	}

	/* Reset the number AUTO-INC rows required */
	trx->n_autoinc_rows = 0;

	/* This is a statement level variable. */
	trx->fts_next_doc_id = 0;

	innobase_srv_conc_force_exit_innodb(trx);

	DBUG_RETURN(0);
}



/*****************************************************************//**
Commits a transaction in an InnoDB database. */
void
innobase_commit_low(
/*================*/
	trx_t*	trx)	/*!< in: transaction handle */
{
	if (trx_is_started(trx)) {

		trx_commit_for_mysql(trx);
	}
	trx->will_lock = 0;
}




/**********************************************************************//**
Does the transaction commit for MySQL.
@return DB_SUCCESS or error number */
dberr_t
trx_commit_for_mysql(
/*=================*/
	trx_t*	trx)	/*!< in/out: transaction */
{
	TrxInInnoDB	trx_in_innodb(trx, true);

	if (trx_in_innodb.is_aborted()
	    && trx->killed_by != os_thread_get_curr_id()) {

		return(DB_FORCED_ABORT);
	}

	/* Because we do not do the commit by sending an Innobase
	sig to the transaction, we must here make sure that trx has been
	started. */

	switch (trx->state) {
	case TRX_STATE_NOT_STARTED:
	case TRX_STATE_FORCED_ROLLBACK:

		ut_d(trx->start_file = __FILE__);
		ut_d(trx->start_line = __LINE__);

		trx_start_low(trx, true);
		/* fall through */
	case TRX_STATE_ACTIVE:
	case TRX_STATE_PREPARED:

		trx->op_info = "committing";

		if (trx->id != 0) {
			trx_update_mod_tables_timestamp(trx);
		}

		trx_commit(trx);

		MONITOR_DEC(MONITOR_TRX_ACTIVE);
		trx->op_info = "";
		return(DB_SUCCESS);
	case TRX_STATE_COMMITTED_IN_MEMORY:
		break;
	}
	ut_error;
	return(DB_CORRUPTION);
}



