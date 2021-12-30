

/*

在事务协调器中提交事务

*/

/**
  Commit the transaction in the transaction coordinator.

  This function will commit the sessions transaction in the binary log
  and in the storage engines (by calling @c ha_commit_low). If the
  transaction was successfully logged (or not successfully unlogged)
  but the commit in the engines did not succed, there is a risk of
  inconsistency between the engines and the binary log.

  For binary log group commit, the commit is separated into three
  parts:

  1. First part consists of filling the necessary caches and
     finalizing them (if they need to be finalized). After this,
     nothing is added to any of the caches.

  2. Second part execute an ordered flush and commit. This will be
     done using the group commit functionality in ordered_commit.

  3. Third part checks any errors resulting from the ordered commit
     and handles them appropriately.

  @retval RESULT_SUCCESS   success
  @retval RESULT_ABORTED   error, transaction was neither logged nor committed
  @retval RESULT_INCONSISTENT  error, transaction was logged but not committed
*/
TC_LOG::enum_result MYSQL_BIN_LOG::commit(THD *thd, bool all)
{
  DBUG_ENTER("MYSQL_BIN_LOG::commit");
  DBUG_PRINT("info", ("query='%s'",
                      thd == current_thd ? thd->query().str : NULL));
  binlog_cache_mngr *cache_mngr= thd_get_cache_mngr(thd);
  Transaction_ctx *trn_ctx= thd->get_transaction();
  my_xid xid= trn_ctx->xid_state()->get_xid()->get_my_xid();
  bool stmt_stuff_logged= false;
  bool trx_stuff_logged= false;
  bool skip_commit= is_loggable_xa_prepare(thd);

  DBUG_PRINT("enter", ("thd: 0x%llx, all: %s, xid: %llu, cache_mngr: 0x%llx",
                       (ulonglong) thd, YESNO(all), (ulonglong) xid,
                       (ulonglong) cache_mngr));

  /*
    No cache manager means nothing to log, but we still have to commit
    the transaction.
   */
  if (cache_mngr == NULL)
  {
    if (!skip_commit && ha_commit_low(thd, all))
      DBUG_RETURN(RESULT_ABORTED);
    DBUG_RETURN(RESULT_SUCCESS);
  }

  Transaction_ctx::enum_trx_scope trx_scope=  all ? Transaction_ctx::SESSION :
                                                    Transaction_ctx::STMT;

  DBUG_PRINT("debug", ("in_transaction: %s, no_2pc: %s, rw_ha_count: %d",
                       YESNO(thd->in_multi_stmt_transaction_mode()),
                       YESNO(trn_ctx->no_2pc(trx_scope)),
                       trn_ctx->rw_ha_count(trx_scope)));
  DBUG_PRINT("debug",
             ("all.cannot_safely_rollback(): %s, trx_cache_empty: %s",
              YESNO(trn_ctx->cannot_safely_rollback(Transaction_ctx::SESSION)),
              YESNO(cache_mngr->trx_cache.is_binlog_empty())));
  DBUG_PRINT("debug",
             ("stmt.cannot_safely_rollback(): %s, stmt_cache_empty: %s",
              YESNO(trn_ctx->cannot_safely_rollback(Transaction_ctx::STMT)),
              YESNO(cache_mngr->stmt_cache.is_binlog_empty())));


  /*
    If there are no handlertons registered, there is nothing to
    commit. Note that DDLs are written earlier in this case (inside
    binlog_query).

    TODO: This can be a problem in those cases that there are no
    handlertons registered. DDLs are one example, but the other case
    is MyISAM. In this case, we could register a dummy handlerton to
    trigger the commit.

    Any statement that requires logging will call binlog_query before
    trans_commit_stmt, so an alternative is to use the condition
    "binlog_query called or stmt.ha_list != 0".
   */
  if (!all && !trn_ctx->is_active(trx_scope) &&
      cache_mngr->stmt_cache.is_binlog_empty())
    DBUG_RETURN(RESULT_SUCCESS);

  if (thd->lex->sql_command == SQLCOM_XA_COMMIT)
  {
    /* The Commit phase of the XA two phase logging. */

    bool one_phase= get_xa_opt(thd) == XA_ONE_PHASE;
    DBUG_ASSERT(all);
    DBUG_ASSERT(!skip_commit || one_phase);

    int err= 0;
    XID_STATE *xs= thd->get_transaction()->xid_state();
    /*
      XA COMMIT ONE PHASE statement which has not gone through the binary log
      prepare phase, has to end the active XA transaction with appropriate XA
      END followed by XA COMMIT ONE PHASE.

      The state of XA transaction is changed to PREPARED after the prepare
      phase, intermediately in ha_commit_trans code for the interest of
      binlogger. Hence check that the XA COMMIT ONE PHASE is set to 'PREPARE'
      and it has not already been written to binary log. For such transaction
      write the appropriate XA END statement.
    */
    if (!(is_loggable_xa_prepare(thd))
        && one_phase
        && !(xs->is_binlogged())
        && !cache_mngr->trx_cache.is_binlog_empty())
    {
      XA_prepare_log_event end_evt(thd, xs->get_xid(), one_phase);
      err= cache_mngr->trx_cache.finalize(thd, &end_evt, xs);
      if (err)
      {
        DBUG_RETURN(RESULT_ABORTED);
      }
      trx_stuff_logged= true;
      thd->get_transaction()->xid_state()->set_binlogged();
    }
    if (DBUG_EVALUATE_IF("simulate_xa_commit_log_failure", true,
                         do_binlog_xa_commit_rollback(thd, xs->get_xid(),
                                                      true)))
      DBUG_RETURN(RESULT_ABORTED);
  }

  /*
    If there is anything in the stmt cache, and GTIDs are enabled,
    then this is a single statement outside a transaction and it is
    impossible that there is anything in the trx cache.  Hence, we
    write any empty group(s) to the stmt cache.

    Otherwise, we write any empty group(s) to the trx cache at the end
    of the transaction.
  */
  if (!cache_mngr->stmt_cache.is_binlog_empty())
  {
    /*
      Commit parent identification of non-transactional query has
      been deferred until now, except for the mixed transaction case.
    */
    trn_ctx->store_commit_parent(m_dependency_tracker.get_max_committed_timestamp());
    if (cache_mngr->stmt_cache.finalize(thd))
      DBUG_RETURN(RESULT_ABORTED);
    stmt_stuff_logged= true;
  }

  /*
    We commit the transaction if:
     - We are not in a transaction and committing a statement, or
     - We are in a transaction and a full transaction is committed.
    Otherwise, we accumulate the changes.
  */
  if (!cache_mngr->trx_cache.is_binlog_empty() &&
      ending_trans(thd, all) && !trx_stuff_logged)
  {
    const bool real_trans=
      (all || !trn_ctx->is_active(Transaction_ctx::SESSION));

    /*
      We are committing an XA transaction if it is a "real" transaction
      and has an XID assigned (because some handlerton registered). A
      transaction is "real" if either 'all' is true or the 'all.ha_list'
      is empty.

      Note: This is kind of strange since registering the binlog
      handlerton will then make the transaction XA, which is not really
      true. This occurs for example if a MyISAM statement is executed
      with row-based replication on.
    */
    if (is_loggable_xa_prepare(thd))
    {
      /* The prepare phase of XA transaction two phase logging. */
      int err= 0;
      bool one_phase= get_xa_opt(thd) == XA_ONE_PHASE;

      DBUG_ASSERT(thd->lex->sql_command != SQLCOM_XA_COMMIT || one_phase);

      XID_STATE *xs= thd->get_transaction()->xid_state();
      XA_prepare_log_event end_evt(thd, xs->get_xid(), one_phase);

      DBUG_ASSERT(skip_commit);

      err= cache_mngr->trx_cache.finalize(thd, &end_evt, xs);
      if (err ||
          (DBUG_EVALUATE_IF("simulate_xa_prepare_failure_in_cache_finalize",
                            true, false)))
      {
        DBUG_RETURN(RESULT_ABORTED);
      }
    }
    else if (real_trans && xid && trn_ctx->rw_ha_count(trx_scope) > 1 &&
             !trn_ctx->no_2pc(trx_scope))
    {
      Xid_log_event end_evt(thd, xid);
      if (cache_mngr->trx_cache.finalize(thd, &end_evt))
        DBUG_RETURN(RESULT_ABORTED);
    }
    else
    {
      Query_log_event end_evt(thd, STRING_WITH_LEN("COMMIT"),
                              true, FALSE, TRUE, 0, TRUE);
      if (cache_mngr->trx_cache.finalize(thd, &end_evt))
        DBUG_RETURN(RESULT_ABORTED);
    }
    trx_stuff_logged= true;
  }

  /*
    This is part of the stmt rollback.
  */
  if (!all)
    cache_mngr->trx_cache.set_prev_position(MY_OFF_T_UNDEF);

  /*
    Now all the events are written to the caches, so we will commit
    the transaction in the engines. This is done using the group
    commit logic in ordered_commit, which will return when the
    transaction is committed.

    If the commit in the engines fail, we still have something logged
    to the binary log so we have to report this as a "bad" failure
    (failed to commit, but logged something).
  */
  if (stmt_stuff_logged || trx_stuff_logged)
  {
    if (RUN_HOOK(transaction,
                 before_commit,
                 (thd, all,
                  thd_get_cache_mngr(thd)->get_binlog_cache_log(true),
                  thd_get_cache_mngr(thd)->get_binlog_cache_log(false),
                  max<my_off_t>(max_binlog_cache_size,
                                max_binlog_stmt_cache_size))) ||
        DBUG_EVALUATE_IF("simulate_failure_in_before_commit_hook", true, false))
    {
      ha_rollback_low(thd, all);
      gtid_state->update_on_rollback(thd);
      thd_get_cache_mngr(thd)->reset();
      //Reset the thread OK status before changing the outcome.
      if (thd->get_stmt_da()->is_ok())
        thd->get_stmt_da()->reset_diagnostics_area();
      my_error(ER_RUN_HOOK_ERROR, MYF(0), "before_commit");
      DBUG_RETURN(RESULT_ABORTED);
    }
    /*
      Check whether the transaction should commit or abort given the
      plugin feedback.
    */
    if (thd->get_transaction()->get_rpl_transaction_ctx()->is_transaction_rollback() ||
        (DBUG_EVALUATE_IF("simulate_transaction_rollback_request", true, false)))
    {
      ha_rollback_low(thd, all);
      gtid_state->update_on_rollback(thd);
      thd_get_cache_mngr(thd)->reset();
      if (thd->get_stmt_da()->is_ok())
        thd->get_stmt_da()->reset_diagnostics_area();
      my_error(ER_TRANSACTION_ROLLBACK_DURING_COMMIT, MYF(0));
      DBUG_RETURN(RESULT_ABORTED);
    }

    if (ordered_commit(thd, all, skip_commit))
      DBUG_RETURN(RESULT_INCONSISTENT);

    /*
      Mark the flag m_is_binlogged to true only after we are done
      with checking all the error cases.
    */
    if (is_loggable_xa_prepare(thd))
      thd->get_transaction()->xid_state()->set_binlogged();
  }
  else if (!skip_commit)
  {
    if (ha_commit_low(thd, all))
      DBUG_RETURN(RESULT_INCONSISTENT);
  }

  DBUG_RETURN(RESULT_SUCCESS);
}





-- 刷新并提交事务


/**
	
  Flush and commit the transaction.

  This will execute an ordered flush and commit of all outstanding
  transactions and is the main function for the binary log group
  commit logic. The function performs the ordered commit in two
  phases.

  The first phase flushes the caches to the binary log and under
  LOCK_log and marks all threads that were flushed as not pending.

  The second phase executes under LOCK_commit and commits all
  transactions in order.

  The procedure is:

  1. Queue ourselves for flushing.
  2. Grab the log lock, which might result is blocking if the mutex is
     already held by another thread.
  3. If we were not committed while waiting for the lock
     1. Fetch the queue
     2. For each thread in the queue:
        a. Attach to it
        b. Flush the caches, saving any error code
     3. Flush and sync (depending on the value of sync_binlog).
     4. Signal that the binary log was updated
  4. Release the log lock
  5. Grab the commit lock
     1. For each thread in the queue:
        a. If there were no error when flushing and the transaction shall be committed:
           - Commit the transaction, saving the result of executing the commit.
  6. Release the commit lock
  7. Call purge, if any of the committed thread requested a purge.
  8. Return with the saved error code

  @todo The use of @c skip_commit is a hack that we use since the @c
  TC_LOG Interface does not contain functions to handle
  savepoints. Once the binary log is eliminated as a handlerton and
  the @c TC_LOG interface is extended with savepoint handling, this
  parameter can be removed.

  @param thd Session to commit transaction for
  @param all   This is @c true if this is a real transaction commit, and
               @c false otherwise.
  @param skip_commit
               This is @c true if the call to @c ha_commit_low should
               be skipped (it is handled by the caller somehow) and @c
               false otherwise (the normal case).
 */
int MYSQL_BIN_LOG::ordered_commit(THD *thd, bool all, bool skip_commit)
{
  DBUG_ENTER("MYSQL_BIN_LOG::ordered_commit");
  int flush_error= 0, sync_error= 0;
  my_off_t total_bytes= 0;
  bool do_rotate= false;

  /*
    These values are used while flushing a transaction, so clear
    everything.

    Notes:

    - It would be good if we could keep transaction coordinator
      log-specific data out of the THD structure, but that is not the
      case right now.

    - Everything in the transaction structure is reset when calling
      ha_commit_low since that calls Transaction_ctx::cleanup.
  */
  thd->get_transaction()->m_flags.pending= true;
  thd->commit_error= THD::CE_NONE;
  thd->next_to_commit= NULL;
  thd->durability_property= HA_IGNORE_DURABILITY;
  thd->get_transaction()->m_flags.real_commit= all;
  thd->get_transaction()->m_flags.xid_written= false;
  thd->get_transaction()->m_flags.commit_low= !skip_commit;
  thd->get_transaction()->m_flags.run_hooks= !skip_commit;
#ifndef DBUG_OFF
  /*
     The group commit Leader may have to wait for follower whose transaction
     is not ready to be preempted. Initially the status is pessimistic.
     Preemption guarding logics is necessary only when !DBUG_OFF is set.
     It won't be required for the dbug-off case as long as the follower won't
     execute any thread-specific write access code in this method, which is
     the case as of current.
  */
  thd->get_transaction()->m_flags.ready_preempt= 0;
#endif

  DBUG_PRINT("enter", ("flags.pending: %s, commit_error: %d, thread_id: %u",
                       YESNO(thd->get_transaction()->m_flags.pending),
                       thd->commit_error, thd->thread_id()));

  DEBUG_SYNC(thd, "bgc_before_flush_stage");

  -- 将事务刷新到二进制日志
  -- 
  /*
    Stage #1: flushing transactions to binary log

    While flushing, we allow new threads to enter and will process
    them in due time. Once the queue was empty, we cannot reap
    anything more since it is possible that a thread entered and
    appointed itself leader for the flush phase.
  */

#ifdef HAVE_REPLICATION
  if (has_commit_order_manager(thd))
  {
    Slave_worker *worker= dynamic_cast<Slave_worker *>(thd->rli_slave);
    Commit_order_manager *mngr= worker->get_commit_order_manager();

    if (mngr->wait_for_its_turn(worker, all))
    {
      thd->commit_error= THD::CE_COMMIT_ERROR;
      DBUG_RETURN(thd->commit_error);
    }

    if (change_stage(thd, Stage_manager::FLUSH_STAGE, thd, NULL, &LOCK_log))
      DBUG_RETURN(finish_commit(thd));
  }
  else
#endif



  if (change_stage(thd, Stage_manager::FLUSH_STAGE, thd, NULL, &LOCK_log))
  {
    DBUG_PRINT("return", ("Thread ID: %u, commit_error: %d",
                          thd->thread_id(), thd->commit_error));
    DBUG_RETURN(finish_commit(thd));
  }

  THD *wait_queue= NULL, *final_queue= NULL;
  mysql_mutex_t *leave_mutex_before_commit_stage= NULL;
  my_off_t flush_end_pos= 0;
  bool update_binlog_end_pos_after_sync;
  if (unlikely(!is_open()))
  {
    final_queue= stage_manager.fetch_queue_for(Stage_manager::FLUSH_STAGE);
    leave_mutex_before_commit_stage= &LOCK_log;
    /*
      binary log is closed, flush stage and sync stage should be
      ignored. Binlog cache should be cleared, but instead of doing
      it here, do that work in 'finish_commit' function so that
      leader and followers thread caches will be cleared.
    */
    goto commit_stage;
  }
  DEBUG_SYNC(thd, "waiting_in_the_middle_of_flush_stage");
  
  flush_error= process_flush_stage_queue(&total_bytes, &do_rotate,
                                                 &wait_queue);

  if (flush_error == 0 && total_bytes > 0)
    flush_error= flush_cache_to_file(&flush_end_pos);
  DBUG_EXECUTE_IF("crash_after_flush_binlog", DBUG_SUICIDE(););

  update_binlog_end_pos_after_sync= (get_sync_period() == 1);

  /*
    If the flush finished successfully, we can call the after_flush
    hook. Being invoked here, we have the guarantee that the hook is
    executed before the before/after_send_hooks on the dump thread
    preventing race conditions among these plug-ins.
  */
  if (flush_error == 0)
  {
    const char *file_name_ptr= log_file_name + dirname_length(log_file_name);
    DBUG_ASSERT(flush_end_pos != 0);
    if (RUN_HOOK(binlog_storage, after_flush,
                 (thd, file_name_ptr, flush_end_pos)))
    {
      sql_print_error("Failed to run 'after_flush' hooks");
      flush_error= ER_ERROR_ON_WRITE;
    }

    if (!update_binlog_end_pos_after_sync)
      update_binlog_end_pos();
    DBUG_EXECUTE_IF("crash_commit_after_log", DBUG_SUICIDE(););
  }

  if (flush_error)
  {
    /*
      Handle flush error (if any) after leader finishes it's flush stage.
    */
    handle_binlog_flush_or_sync_error(thd, false /* need_lock_log */);
  }

  DEBUG_SYNC(thd, "bgc_after_flush_stage_before_sync_stage");

  /*
    Stage #2: Syncing binary log file to disk
  */

  if (change_stage(thd, Stage_manager::SYNC_STAGE, wait_queue, &LOCK_log, &LOCK_sync))
  {
    DBUG_PRINT("return", ("Thread ID: %u, commit_error: %d",
                          thd->thread_id(), thd->commit_error));
    DBUG_RETURN(finish_commit(thd));
  }

  /*
    Shall introduce a delay only if it is going to do sync
    in this ongoing SYNC stage. The "+1" used below in the
    if condition is to count the ongoing sync stage.
    When sync_binlog=0 (where we never do sync in BGC group),
    it is considered as a special case and delay will be executed
    for every group just like how it is done when sync_binlog= 1.
  */
  if (!flush_error && (sync_counter + 1 >= get_sync_period()))
    stage_manager.wait_count_or_timeout(opt_binlog_group_commit_sync_no_delay_count,
                                        opt_binlog_group_commit_sync_delay,
                                        Stage_manager::SYNC_STAGE);

  final_queue= stage_manager.fetch_queue_for(Stage_manager::SYNC_STAGE);

  if (flush_error == 0 && total_bytes > 0)
  {
    DEBUG_SYNC(thd, "before_sync_binlog_file");
    std::pair<bool, bool> result= sync_binlog_file(false);
    sync_error= result.first;
  }

  if (update_binlog_end_pos_after_sync)
  {
    THD *tmp_thd= final_queue;
    const char *binlog_file= NULL;
    my_off_t pos= 0;
    while (tmp_thd->next_to_commit != NULL)
      tmp_thd= tmp_thd->next_to_commit;
    if (flush_error == 0 && sync_error == 0)
    {
      tmp_thd->get_trans_fixed_pos(&binlog_file, &pos);
      update_binlog_end_pos(binlog_file, pos);
    }
  }

  DEBUG_SYNC(thd, "bgc_after_sync_stage_before_commit_stage");

  leave_mutex_before_commit_stage= &LOCK_sync;
  /*
    Stage #3: Commit all transactions in order.

    This stage is skipped if we do not need to order the commits and
    each thread have to execute the handlerton commit instead.

    Howver, since we are keeping the lock from the previous stage, we
    need to unlock it if we skip the stage.

    We must also step commit_clock before the ha_commit_low() is called
    either in ordered fashion(by the leader of this stage) or by the tread
    themselves.

    We are delaying the handling of sync error until
    all locks are released but we should not enter into
    commit stage if binlog_error_action is ABORT_SERVER.
  */
  
commit_stage:
  if (opt_binlog_order_commits &&
      (sync_error == 0 || binlog_error_action != ABORT_SERVER))
  {
    if (change_stage(thd, Stage_manager::COMMIT_STAGE,
                     final_queue, leave_mutex_before_commit_stage,
                     &LOCK_commit))
    {
      DBUG_PRINT("return", ("Thread ID: %u, commit_error: %d",
                            thd->thread_id(), thd->commit_error));
      DBUG_RETURN(finish_commit(thd));
    }
    THD *commit_queue= stage_manager.fetch_queue_for(Stage_manager::COMMIT_STAGE);
    DBUG_EXECUTE_IF("semi_sync_3-way_deadlock",
                    DEBUG_SYNC(thd, "before_process_commit_stage_queue"););

    if (flush_error == 0 && sync_error == 0)
      sync_error= call_after_sync_hook(commit_queue);

    /*
      process_commit_stage_queue will call update_on_commit or
      update_on_rollback for the GTID owned by each thd in the queue.

      This will be done this way to guarantee that GTIDs are added to
      gtid_executed in order, to avoid creating unnecessary temporary
      gaps and keep gtid_executed as a single interval at all times.

      If we allow each thread to call update_on_commit only when they
      are at finish_commit, the GTID order cannot be guaranteed and
      temporary gaps may appear in gtid_executed. When this happen,
      the server would have to add and remove intervals from the
      Gtid_set, and adding and removing intervals requires a mutex,
      which would reduce performance.
    */
    process_commit_stage_queue(thd, commit_queue);
    mysql_mutex_unlock(&LOCK_commit);
    /*
      Process after_commit after LOCK_commit is released for avoiding
      3-way deadlock among user thread, rotate thread and dump thread.
    */
    process_after_commit_stage_queue(thd, commit_queue);
    final_queue= commit_queue;
  }
  else
  {
    if (leave_mutex_before_commit_stage)
      mysql_mutex_unlock(leave_mutex_before_commit_stage);
    if (flush_error == 0 && sync_error == 0)
      sync_error= call_after_sync_hook(final_queue);
  }

  /*
    Handle sync error after we release all locks in order to avoid deadlocks
  */
  if (sync_error)
    handle_binlog_flush_or_sync_error(thd, true /* need_lock_log */);

  /* Commit done so signal all waiting threads */
  stage_manager.signal_done(final_queue);

  /*
    Finish the commit before executing a rotate, or run the risk of a
    deadlock. We don't need the return value here since it is in
    thd->commit_error, which is returned below.
  */
  (void) finish_commit(thd);

  /*
    If we need to rotate, we do it without commit error.
    Otherwise the thd->commit_error will be possibly reset.
   */
  if (DBUG_EVALUATE_IF("force_rotate", 1, 0) ||
      (do_rotate && thd->commit_error == THD::CE_NONE &&
       !is_rotating_caused_by_incident))
  {
    /*
      Do not force the rotate as several consecutive groups may
      request unnecessary rotations.

      NOTE: Run purge_logs wo/ holding LOCK_log because it does not
      need the mutex. Otherwise causes various deadlocks.
    */

    DEBUG_SYNC(thd, "ready_to_do_rotation");
    bool check_purge= false;
    mysql_mutex_lock(&LOCK_log);
    /*
      If rotate fails then depends on binlog_error_action variable
      appropriate action will be taken inside rotate call.
    */
    int error= rotate(false, &check_purge);
    mysql_mutex_unlock(&LOCK_log);

    if (error)
      thd->commit_error= THD::CE_COMMIT_ERROR;
    else if (check_purge)
      purge();
  }
  /*
    flush or sync errors are handled above (using binlog_error_action).
    Hence treat only COMMIT_ERRORs as errors.
  */
  DBUG_RETURN(thd->commit_error == THD::CE_COMMIT_ERROR);
}


bool
MYSQL_BIN_LOG::change_stage(THD *thd,
                            Stage_manager::StageID stage, THD *queue,
                            mysql_mutex_t *leave_mutex,
                            mysql_mutex_t *enter_mutex)
{
  DBUG_ENTER("MYSQL_BIN_LOG::change_stage");
  DBUG_PRINT("enter", ("thd: 0x%llx, stage: %s, queue: 0x%llx",
                       (ulonglong) thd, g_stage_name[stage], (ulonglong) queue));
					   
  DBUG_ASSERT(0 <= stage && stage < Stage_manager::STAGE_COUNTER);
  DBUG_ASSERT(enter_mutex);
  DBUG_ASSERT(queue);
  /*
    enroll_for will release the leave_mutex once the sessions are
    queued.
  */
  if (!stage_manager.enroll_for(stage, queue, leave_mutex))
  {
    DBUG_ASSERT(!thd_get_cache_mngr(thd)->dbug_any_finalized());
    DBUG_RETURN(true);
  }

  /*
    We do not lock the enter_mutex if it is LOCK_log when rotating binlog
    caused by logging incident log event, since it is already locked.
  */
  bool need_lock_enter_mutex=
    !(is_rotating_caused_by_incident && enter_mutex == &LOCK_log);

  if (need_lock_enter_mutex)
    mysql_mutex_lock(enter_mutex);
  else
    mysql_mutex_assert_owner(enter_mutex);

  DBUG_RETURN(false);
}



-- 执行flush阶段

/**
  Execute the flush stage.

  @param total_bytes_var Pointer to variable that will be set to total
  number of bytes flushed, or NULL.

  @param rotate_var Pointer to variable that will be set to true if
  binlog rotation should be performed after releasing locks. If rotate
  is not necessary, the variable will not be touched.

  @return Error code on error, zero on success
 */

int
MYSQL_BIN_LOG::process_flush_stage_queue(my_off_t *total_bytes_var,
                                         bool *rotate_var,
                                         THD **out_queue_var)
{
  DBUG_ENTER("MYSQL_BIN_LOG::process_flush_stage_queue");
  #ifndef DBUG_OFF
  // number of flushes per group.
  int no_flushes= 0;
  #endif
  DBUG_ASSERT(total_bytes_var && rotate_var && out_queue_var);
  my_off_t total_bytes= 0;
  int flush_error= 1;
  mysql_mutex_assert_owner(&LOCK_log);

  /*
    Fetch the entire flush queue and empty it, so that the next batch
    has a leader. We must do this before invoking ha_flush_logs(...)
    for guaranteeing to flush prepared records of transactions before
    flushing them to binary log, which is required by crash recovery.
  */
  THD *first_seen= stage_manager.fetch_queue_for(Stage_manager::FLUSH_STAGE);
  DBUG_ASSERT(first_seen != NULL);
  /*
    We flush prepared records of transactions to the log of storage
    engine (for example, InnoDB redo log) in a group right before
    flushing them to binary log.
  */
  
  -- flush redo log 
  ha_flush_logs(NULL, true);
  
  DBUG_EXECUTE_IF("crash_after_flush_engine_log", DBUG_SUICIDE(););
  assign_automatic_gtids_to_flush_group(first_seen);
  
  -- 把 binlog cache 中的 binlog flush到binlog文件
  /* Flush thread caches to binary log. */
  for (THD *head= first_seen ; head ; head = head->next_to_commit)
  {
    std::pair<int,my_off_t> result= flush_thread_caches(head);
    total_bytes+= result.second;
    if (flush_error == 1)
      flush_error= result.first;
#ifndef DBUG_OFF
    no_flushes++;
#endif
  }

  *out_queue_var= first_seen;
  *total_bytes_var= total_bytes;
  if (total_bytes > 0 && my_b_tell(&log_file) >= (my_off_t) max_size)
    *rotate_var= true;
#ifndef DBUG_OFF
  DBUG_PRINT("info",("no_flushes:= %d", no_flushes));
  no_flushes= 0;
#endif
  DBUG_RETURN(flush_error);
}

-- 获取整个队列并清空它。
  /**
    Fetch the entire queue and empty it.

    @return Pointer to the first session of the queue.
   */
  THD *fetch_queue_for(StageID stage) {
    DBUG_PRINT("debug", ("Fetching queue for stage %d", stage));
    return m_queue[stage].fetch_and_empty();
  }




static my_bool flush_handlerton(THD *thd, plugin_ref plugin,
                                void *arg)
{
  handlerton *hton= plugin_data<handlerton*>(plugin);
  if (hton->state == SHOW_OPTION_YES && hton->flush_logs &&
      hton->flush_logs(hton, *(static_cast<bool *>(arg))))
    return TRUE;
  return FALSE;
}


bool ha_flush_logs(handlerton *db_type, bool binlog_group_flush)
{
  if (db_type == NULL)
  {
    if (plugin_foreach(NULL, flush_handlerton,
                       MYSQL_STORAGE_ENGINE_PLUGIN,
                       static_cast<void *>(&binlog_group_flush)))
      return TRUE;
  }
  else
  {
    if (db_type->state != SHOW_OPTION_YES ||
        (db_type->flush_logs &&
         db_type->flush_logs(db_type, binlog_group_flush)))
      return TRUE;
  }
  return FALSE;
}


-- 将 InnoDB 重做日志刷新到文件系统。
/** Flush InnoDB redo logs to the file system.
@param[in]	hton			InnoDB handlerton
@param[in]	binlog_group_flush	true if we got invoked by binlog
group commit during flush stage, false in other cases.
@return false */
static
bool
innobase_flush_logs(
	handlerton*	hton,
	bool		binlog_group_flush)
{
	DBUG_ENTER("innobase_flush_logs");
	DBUG_ASSERT(hton == innodb_hton_ptr);

	if (srv_read_only_mode) {
		DBUG_RETURN(false);
	}

	/* If !binlog_group_flush, we got invoked by FLUSH LOGS or similar.
	Else, we got invoked by binlog group commit during flush stage. */

	if (binlog_group_flush && srv_flush_log_at_trx_commit == 0) {
		/* innodb_flush_log_at_trx_commit=0
		(write and sync once per second).
		Do not flush the redo log during binlog group commit. */
		DBUG_RETURN(false);
	}

	/* Flush the redo log buffer to the redo log file.
	Sync it to disc if we are in FLUSH LOGS, or if
	innodb_flush_log_at_trx_commit=1
	(write and sync at each commit). */
	log_buffer_flush_to_disk(!binlog_group_flush
				 || srv_flush_log_at_trx_commit == 1);

	DBUG_RETURN(false);
}




/** write to the log file up to the last log entry.
@param[in]	sync	whether we want the written log
also to be flushed to disk. */
void
log_buffer_flush_to_disk(
	bool sync)
{
	ut_ad(!srv_read_only_mode);
	log_write_up_to(log_get_lsn(), sync);
}






E:\github\mysql-5.7.26\sql\binlog.cc

binlog cache 进行flush到binlog文件

/**
   Flush caches for session.

   @note @c set_trans_pos is called with a pointer to the file name
   that the binary log currently use and a rotation will change the
   contents of the variable.

   The position is used when calling the after_flush, after_commit,
   and after_rollback hooks, but these have been placed so that they
   occur before a rotation is executed.

   It is the responsibility of any plugin that use this position to
   copy it if they need it after the hook has returned.

   The current "global" transaction_counter is stepped and its new value
   is assigned to the transaction.
 */
std::pair<int,my_off_t>
MYSQL_BIN_LOG::flush_thread_caches(THD *thd)
{
  binlog_cache_mngr *cache_mngr= thd_get_cache_mngr(thd);
  my_off_t bytes= 0;
  bool wrote_xid= false;
  int error= cache_mngr->flush(thd, &bytes, &wrote_xid);
  if (!error && bytes > 0)
  {
    /*
      Note that set_trans_pos does not copy the file name. See
      this function documentation for more info.
    */
    thd->set_trans_pos(log_file_name, my_b_tell(&log_file));
    if (wrote_xid)
      inc_prep_xids(thd);
  }
  DBUG_PRINT("debug", ("bytes: %llu", bytes));
  return std::make_pair(error, bytes);
}



/**
  Flush caches to the binary log.

  If the cache is finalized, the cache will be flushed to the binary
  log file. If the cache is not finalized, nothing will be done.

  If flushing fails for any reason, an error will be reported and the
  cache will be reset. Flushing can fail in two circumstances:

  - It was not possible to write the cache to the file. In this case,
    it does not make sense to keep the cache.

  - The cache was successfully written to disk but post-flush actions
    (such as binary log rotation) failed. In this case, the cache is
    already written to disk and there is no reason to keep it.

  @see binlog_cache_data::finalize
 */
int
binlog_cache_data::flush(THD *thd, my_off_t *bytes_written, bool *wrote_xid)
{
  /*
    Doing a commit or a rollback including non-transactional tables,
    i.e., ending a transaction where we might write the transaction
    cache to the binary log.

    We can always end the statement when ending a transaction since
    transactions are not allowed inside stored functions. If they
    were, we would have to ensure that we're not ending a statement
    inside a stored function.
  */
  DBUG_ENTER("binlog_cache_data::flush");
  DBUG_PRINT("debug", ("flags.finalized: %s", YESNO(flags.finalized)));
  int error= 0;
  if (flags.finalized)
  {
    my_off_t bytes_in_cache= my_b_tell(&cache_log);
    Transaction_ctx *trn_ctx= thd->get_transaction();

    DBUG_PRINT("debug", ("bytes_in_cache: %llu", bytes_in_cache));

    trn_ctx->sequence_number= mysql_bin_log.m_dependency_tracker.step();
    /*
      In case of two caches the transaction is split into two groups.
      The 2nd group is considered to be a successor of the 1st rather
      than to have a common commit parent with it.
      Notice that due to a simple method of detection that the current is
      the 2nd cache being flushed, the very first few transactions may be logged
      sequentially (a next one is tagged as if a preceding one is its
      commit parent).
    */
    if (trn_ctx->last_committed == SEQ_UNINIT)
      trn_ctx->last_committed= trn_ctx->sequence_number - 1;

    /*
      The GTID is written prior to flushing the statement cache, if
      the transaction has written to the statement cache; and prior to
      flushing the transaction cache if the transaction has written to
      the transaction cache.  If GTIDs are enabled, then transactional
      and non-transactional updates cannot be mixed, so at most one of
      the caches can be non-empty, so just one GTID will be
      generated. If GTIDs are disabled, then no GTID is generated at
      all; if both the transactional cache and the statement cache are
      non-empty then we get two Anonymous_gtid_log_events, which is
      correct.
    */
    Binlog_event_writer writer(mysql_bin_log.get_log_file());

    /* The GTID ownership process might set the commit_error */
    error= (thd->commit_error == THD::CE_FLUSH_ERROR);

    DBUG_EXECUTE_IF("simulate_binlog_flush_error",
                    {
                      if (rand() % 3 == 0)
                      {
                        thd->commit_error= THD::CE_FLUSH_ERROR;
                      }
                    };);

    if (!error)
      if ((error= mysql_bin_log.write_gtid(thd, this, &writer)))
        thd->commit_error= THD::CE_FLUSH_ERROR;
    if (!error)
      error= mysql_bin_log.write_cache(thd, this, &writer);

    if (flags.with_xid && error == 0)
      *wrote_xid= true;

    /*
      Reset have to be after the if above, since it clears the
      with_xid flag
    */
    reset();
    if (bytes_written)
      *bytes_written= bytes_in_cache;
  }
  DBUG_ASSERT(!flags.finalized);
  DBUG_RETURN(error);
}



/**
  Call fsync() to sync the file to disk.
*/
std::pair<bool, bool>
MYSQL_BIN_LOG::sync_binlog_file(bool force)
{
  bool synced= false;
  unsigned int sync_period= get_sync_period();
  if (force || (sync_period && ++sync_counter >= sync_period))
  {
    sync_counter= 0;

    /**
      On *pure non-transactional* workloads there is a small window
      in time where a concurrent rotate might be able to close
      the file before the sync is actually done. In that case,
      ignore the bad file descriptor errors.

      Transactional workloads (InnoDB) are not affected since the
      the rotation will not happen until all transactions have
      committed to the storage engine, thence decreased the XID
      counters.

      TODO: fix this properly even for non-transactional storage
            engines.
     */
    if (DBUG_EVALUATE_IF("simulate_error_during_sync_binlog_file", 1,
                         mysql_file_sync(log_file.file,
                                         MYF(MY_WME | MY_IGNORE_BADFD))))
    {
      THD *thd= current_thd;
      thd->commit_error= THD::CE_SYNC_ERROR;
      return std::make_pair(true, synced);
    }
    synced= true;
  }
  return std::make_pair(false, synced);
}


