
change_stage
  /*
    Stage #1: flushing transactions to binary log

    While flushing, we allow new threads to enter and will process
    them in due time. Once the queue was empty, we cannot reap
    anything more since it is possible that a thread entered and
    appointed itself leader for the flush phase.
  */
  
  -- flush 队列
  THD *first_seen= stage_manager.fetch_queue_for(Stage_manager::FLUSH_STAGE);



if (!flush_error && (sync_counter + 1 >= get_sync_period()))
stage_manager.wait_count_or_timeout(opt_binlog_group_commit_sync_no_delay_count,
									opt_binlog_group_commit_sync_delay,
									Stage_manager::SYNC_STAGE);


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
  -- sync binlog 队列 
  final_queue= stage_manager.fetch_queue_for(Stage_manager::SYNC_STAGE);

  if (flush_error == 0 && total_bytes > 0)
  {
    DEBUG_SYNC(thd, "before_sync_binlog_file");
    std::pair<bool, bool> result= sync_binlog_file(false);
    sync_error= result.first;
  }


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
	-- 提交队列
    THD *commit_queue= stage_manager.fetch_queue_for(Stage_manager::COMMIT_STAGE);
	
	
	
	

-- 获取队列中的事务组(获取整个队列之后并清空它)
  /**
    Fetch the entire queue and empty it.

    @return Pointer to the first session of the queue.
   */
  THD *fetch_queue_for(StageID stage) {
    DBUG_PRINT("debug", ("Fetching queue for stage %d", stage));
    return m_queue[stage].fetch_and_empty();
  }

	