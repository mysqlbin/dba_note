


select * from performance_schema.events_statements_history where THREAD_ID in ( select THREAD_ID from performance_schema.threads where PROCESSLIST_ID  in (select trx_mysql_thread_id from information_schema.innodb_trx ) )

https://mp.weixin.qq.com/s/z8sPEyalc26gktWbDyFj_Q    一个监控SQL分享_长事务所运行的所有SQL