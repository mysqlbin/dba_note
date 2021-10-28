

/**
  Execute a FLUSH LOGS statement.

  The method is a shortcut of @c rotate() and @c purge().
  LOCK_log is acquired prior to rotate and is released after it.

  @param force_rotate  caller can request the log rotation

  @retval
    nonzero - error in rotating routine.
*/
int MYSQL_BIN_LOG::rotate_and_purge(THD* thd, bool force_rotate)
{
  int error= 0;
  DBUG_ENTER("MYSQL_BIN_LOG::rotate_and_purge");
  bool check_purge= false;

  /*
    FLUSH BINARY LOGS command should ignore 'read-only' and 'super_read_only'
    options so that it can update 'mysql.gtid_executed' replication repository
    table.
  */
  thd->set_skip_readonly_check();
  /*
    Wait for handlerton to insert any pending information into the binlog.
    For e.g. ha_ndbcluster which updates the binlog asynchronously this is
    needed so that the user see its own commands in the binlog.
  */
  ha_binlog_wait(thd);

  DBUG_ASSERT(!is_relay_log);
  mysql_mutex_lock(&LOCK_log);
  error= rotate(force_rotate, &check_purge);
  /*
    NOTE: Run purge_logs wo/ holding LOCK_log because it does not need
          the mutex. Otherwise causes various deadlocks.
  */
  mysql_mutex_unlock(&LOCK_log);

  if (!error && check_purge)
    purge();

  DBUG_RETURN(error);
}



/**
  The method executes rotation when LOCK_log is already acquired
  by the caller.

  @param force_rotate  caller can request the log rotation
  @param check_purge   is set to true if rotation took place

  @note
    If rotation fails, for instance the server was unable 
    to create a new log file, we still try to write an 
    incident event to the current log.

  @note The caller must hold LOCK_log when invoking this function.

  @retval
    nonzero - error in rotating routine.
*/
int MYSQL_BIN_LOG::rotate(bool force_rotate, bool* check_purge)
{
  int error= 0;
  DBUG_ENTER("MYSQL_BIN_LOG::rotate");

  DBUG_ASSERT(!is_relay_log);
  mysql_mutex_assert_owner(&LOCK_log);

  *check_purge= false;

  if (DBUG_EVALUATE_IF("force_rotate", 1, 0) || force_rotate ||
      (my_b_tell(&log_file) >= (my_off_t) max_size))
  {
    error= new_file_without_locking(NULL);
    *check_purge= true;
  }
  DBUG_RETURN(error);
}



/**
  The method executes logs purging routine.

  @retval
    nonzero - error in rotating routine.
*/
void MYSQL_BIN_LOG::purge()
{
#ifdef HAVE_REPLICATION
  if (expire_logs_days)
  {
    DEBUG_SYNC(current_thd, "at_purge_logs_before_date");
    time_t purge_time= my_time(0) - expire_logs_days*24*60*60;
    DBUG_EXECUTE_IF("expire_logs_always",
                    { purge_time= my_time(0);});
    if (purge_time >= 0)
    {
      /*
        Flush logs for storage engines, so that the last transaction
        is fsynced inside storage engines.
      */
      ha_flush_logs(NULL);
      purge_logs_before_date(purge_time, true);
    }
  }
#endif
}

/**
  Remove all logs before the given file date from disk and from the
  index file.

  @param thd		Thread pointer
  @param purge_time	Delete all log files before given date.
  @param auto_purge     True if this is an automatic purge.

  @note
    If any of the logs before the deleted one is in use,
    only purge logs up to this one.

  @retval
    0				ok
  @retval
    LOG_INFO_PURGE_NO_ROTATE	Binary file that can't be rotated
    LOG_INFO_FATAL              if any other than ENOENT error from
                                mysql_file_stat() or mysql_file_delete()
*/

int MYSQL_BIN_LOG::purge_logs_before_date(time_t purge_time, bool auto_purge)
{
  int error;
  int no_of_threads_locking_log= 0, no_of_log_files_purged= 0;
  bool log_is_active= false, log_is_in_use= false;
  char to_log[FN_REFLEN], copy_log_in_use[FN_REFLEN];
  LOG_INFO log_info;
  MY_STAT stat_area;
  THD *thd= current_thd;

  DBUG_ENTER("purge_logs_before_date");

  mysql_mutex_lock(&LOCK_index);
  to_log[0]= 0;

  if ((error=find_log_pos(&log_info, NullS, false/*need_lock_index=false*/)))
    goto err;

  while (!(log_is_active= is_active(log_info.log_file_name)))
  {
    if (!mysql_file_stat(m_key_file_log,
                         log_info.log_file_name, &stat_area, MYF(0)))
    {
      if (my_errno() == ENOENT)
      {
        /*
          It's not fatal if we can't stat a log file that does not exist.
        */
        set_my_errno(0);
      }
      else
      {
        /*
          Other than ENOENT are fatal
        */
        if (thd)
        {
          push_warning_printf(thd, Sql_condition::SL_WARNING,
                              ER_BINLOG_PURGE_FATAL_ERR,
                              "a problem with getting info on being purged %s; "
                              "consider examining correspondence "
                              "of your binlog index file "
                              "to the actual binlog files",
                              log_info.log_file_name);
        }
        else
        {
          sql_print_information("Failed to delete log file '%s'",
                                log_info.log_file_name);
        }
        error= LOG_INFO_FATAL;
        goto err;
      }
    }
    /* check if the binary log file is older than the purge_time
       if yes check if it is in use, if not in use then add
       it in the list of binary log files to be purged.
    */
    else if (stat_area.st_mtime < purge_time)
    {
      if ((no_of_threads_locking_log= log_in_use(log_info.log_file_name)))
      {
        if (!auto_purge)
        {
          log_is_in_use= true;
          strcpy(copy_log_in_use, log_info.log_file_name);
        }
        break;
      }
      strmake(to_log,
              log_info.log_file_name,
              sizeof(log_info.log_file_name) - 1);
      no_of_log_files_purged++;
    }
    else
      break;
    if (find_next_log(&log_info, false/*need_lock_index=false*/))
      break;
  }

  if (log_is_active)
  {
    if(!auto_purge)
      push_warning_printf(thd, Sql_condition::SL_WARNING,
                          ER_WARN_PURGE_LOG_IS_ACTIVE,
                          ER(ER_WARN_PURGE_LOG_IS_ACTIVE),
                          log_info.log_file_name);

  }

  if (log_is_in_use)
  {
    int no_of_log_files_to_purge= no_of_log_files_purged+1;
    while (strcmp(log_file_name, log_info.log_file_name))
    {
      if (mysql_file_stat(m_key_file_log, log_info.log_file_name,
                          &stat_area, MYF(0)))
      {
        if (stat_area.st_mtime < purge_time)
          no_of_log_files_to_purge++;
        else
          break;
      }
      if (find_next_log(&log_info, false/*need_lock_index=false*/))
      {
        no_of_log_files_to_purge++;
        break;
      }
    }

    push_warning_printf(thd, Sql_condition::SL_WARNING,
                        ER_WARN_PURGE_LOG_IN_USE,
                        ER(ER_WARN_PURGE_LOG_IN_USE),
                        copy_log_in_use, no_of_threads_locking_log,
                        no_of_log_files_purged, no_of_log_files_to_purge);
  }

  error= (to_log[0] ? purge_logs(to_log, true,
                                 false/*need_lock_index=false*/,
                                 true/*need_update_threads=true*/,
                                 (ulonglong *) 0, auto_purge) : 0);

err:
  mysql_mutex_unlock(&LOCK_index);
  DBUG_RETURN(error);
}
#endif /* HAVE_REPLICATION */