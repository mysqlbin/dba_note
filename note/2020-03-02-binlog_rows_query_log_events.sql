

binlog_rows_query_log_events =1 
    在row模式下..开启该参数,将把sql语句打印到binlog日志里面.默认是0(off);
    虽然将语句放入了binlog,但不会执行这个sql,就相当于注释一样.但对于dba来说,在查看binlog的时候,很有用处.
	
http://blog.itpub.net/20892230/viewspace-2129567/    binlog很有用的2个参数binlog_rows_query_log_events和binlog_row_image

