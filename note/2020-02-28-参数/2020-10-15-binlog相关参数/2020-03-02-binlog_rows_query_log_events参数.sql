

binlog_rows_query_log_events =1 
    在row模式下..开启该参数,将把sql语句打印到binlog日志里面.默认是0(off);
    虽然将语句放入了binlog,但不会执行这个sql,就相当于注释一样.但对于dba来说,在查看binlog的时候,很有用处.
	
http://blog.itpub.net/20892230/viewspace-2129567/    binlog很有用的2个参数binlog_rows_query_log_events和binlog_row_image

https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_rows_query_log_events





This system variable affects row-based logging only. 
When enabled, it causes the server to write informational log events such as row query log events into its binary log. 
This information can be used for debugging and related purposes, such as obtaining the original query issued on the source when it cannot be reconstructed from the row updates.

此系统变量仅影响基于行的日志记录。 
启用后，它将导致服务器将诸如行查询日志事件之类的信息日志事件写入其二进制日志。 
此信息可用于调试和相关目的，例如，当无法从行更新中重建原始查询时，获取原始查询。

These informational events are normally ignored by MySQL programs reading the binary log and so cause no issues when replicating or restoring from backup. 
To view them, increase the verbosity level by using mysqlbinlog s --verbose option twice, either as -vv or --verbose --verbose.

这些信息事件通常被读取二进制日志的MySQL程序忽略，因此从备份复制或还原时不会引起任何问题。 
要查看它们，请通过两次使用mysqlbinlog的--verbose选项（-vv或--verbose --verbose）来提高详细程度。

