

void log_slow_statement(THD *thd)
{
  if (log_slow_applicable(thd))
    log_slow_do(thd);
}



bool log_slow_applicable(THD *thd)
{
  DBUG_ENTER("log_slow_applicable");

  /*
    The following should never be true with our current code base,
    but better to keep this here so we don't accidently try to log a
    statement in a trigger or stored function
  */
  if (unlikely(thd->in_sub_stmt))
    DBUG_RETURN(false);                         // Don t set time for sub stmt

  /*
    Do not log administrative statements unless the appropriate option is
    set.
  */
  if (thd->enable_slow_log && opt_slow_log)
  {
    bool warn_no_index= ((thd->server_status &
                          (SERVER_QUERY_NO_INDEX_USED |
                           SERVER_QUERY_NO_GOOD_INDEX_USED)) &&
                         opt_log_queries_not_using_indexes &&
                         !(sql_command_flags[thd->lex->sql_command] &
                           CF_STATUS_COMMAND));
    bool log_this_query=  ((thd->server_status & SERVER_QUERY_WAS_SLOW) ||
                           warn_no_index) &&
                          (thd->get_examined_row_count() >=
                           thd->variables.min_examined_row_limit);
    bool suppress_logging= log_throttle_qni.log(thd, warn_no_index);

    if (!suppress_logging && log_this_query)
      DBUG_RETURN(true);
  }
  DBUG_RETURN(false);
}


void log_slow_do(THD *thd)
{
  THD_STAGE_INFO(thd, stage_logging_slow_query);
  thd->status_var.long_query_count++;

  if (thd->rewritten_query.length())
    query_logger.slow_log_write(thd,
                                thd->rewritten_query.c_ptr_safe(),
                                thd->rewritten_query.length());
  else
    query_logger.slow_log_write(thd, thd->query().str, thd->query().length);
}
