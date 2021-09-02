
#define SERVER_QUERY_WAS_SLOW          2048


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
  -- 开启记录慢日志功能
  if (thd->enable_slow_log && opt_slow_log)
  {
	-- 判断SQL语句没有走索引
    bool warn_no_index= ((thd->server_status &
                          (SERVER_QUERY_NO_INDEX_USED |
                           SERVER_QUERY_NO_GOOD_INDEX_USED)) &&
                         opt_log_queries_not_using_indexes &&
                         !(sql_command_flags[thd->lex->sql_command] &
                           CF_STATUS_COMMAND));
						   
	-- SQL语句走了索引，语句实际执行时间大于 long_query_time，同时 SQL语句扫描行数大于 min_examined_row_limit 则会被记录到慢日志中
	-- SQL语句没有走索引，同时 SQL语句扫描行数大于 min_examined_row_limit 则会被记录到慢日志中
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




 void update_server_status()
  {
    ulonglong end_utime_of_query= current_utime();
	-- 当前时间 大于 (语句在等待锁的时间 + long_query_time参数的值)
	-- (语句在等待锁的时间 + long_query_time参数的值) = 语句的总执行时间
    if (end_utime_of_query > utime_after_lock + variables.long_query_time)
      server_status|= SERVER_QUERY_WAS_SLOW;
  }
  
  
  
 |=	按位或且赋值运算符	C |= 2 等同于 C = C | 2
 
 server_status|= SERVER_QUERY_WAS_SLOW;  -- server_status = server_status | SERVER_QUERY_WAS_SLOW;
  
  
  