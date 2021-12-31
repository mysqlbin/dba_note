


change_stage


THD *first_seen= stage_manager.fetch_queue_for(Stage_manager::FLUSH_STAGE);



if (!flush_error && (sync_counter + 1 >= get_sync_period()))
stage_manager.wait_count_or_timeout(opt_binlog_group_commit_sync_no_delay_count,
									opt_binlog_group_commit_sync_delay,
									Stage_manager::SYNC_STAGE);


final_queue= stage_manager.fetch_queue_for(Stage_manager::SYNC_STAGE);



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