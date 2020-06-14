
root@mysqldb 09:02:  [(none)]> show global status like '%buffer_pool%';
+---------------------------------------+--------------------------------------------------+
| Variable_name                         | Value                                            |
+---------------------------------------+--------------------------------------------------+
| Innodb_buffer_pool_dump_status        | Dumping of buffer pool not started               |
| Innodb_buffer_pool_load_status        | Buffer pool(s) load completed at 200311 20:48:56 |
| Innodb_buffer_pool_resize_status      |                                                  |
| Innodb_buffer_pool_pages_data         | 86831                                            |
| Innodb_buffer_pool_bytes_data         | 1422639104                                       |
| Innodb_buffer_pool_pages_dirty        | 0                                                |
| Innodb_buffer_pool_bytes_dirty        | 0                                                |
| Innodb_buffer_pool_pages_flushed      | 77628                                            |
| Innodb_buffer_pool_pages_free         | 109749                                           |
| Innodb_buffer_pool_pages_misc         | 4                                                |
| Innodb_buffer_pool_pages_total        | 196584                                           |
| Innodb_buffer_pool_read_ahead_rnd     | 0                                                |
| Innodb_buffer_pool_read_ahead         | 0                                                |
| Innodb_buffer_pool_read_ahead_evicted | 0                                                |
| Innodb_buffer_pool_read_requests      | 489509                                           |
| Innodb_buffer_pool_reads              | 1702                                             |
| Innodb_buffer_pool_wait_free          | 1042                                             |      # 内存数据页不中产生的等待次数， Number of times waited for free buffer
| Innodb_buffer_pool_write_requests     | 3107                                             |
+---------------------------------------+--------------------------------------------------+
18 rows in set (0.01 sec)

root@mysqldb 09:02:  [(none)]> show global status like '%wait%';
+-------------------------------+-------+
| Variable_name                 | Value |
+-------------------------------+-------+
| Innodb_buffer_pool_wait_free  | 1042  |
| Innodb_log_waits              | 0     |
| Innodb_row_lock_current_waits | 0     |
| Innodb_row_lock_waits         | 0     |
| Table_locks_waited            | 0     |
| Tc_log_page_waits             | 0     |
+-------------------------------+-------+
6 rows in set (0.00 sec)



/* innodb_buffer_pool_wait_free */
	case MONITOR_OVLD_BUF_POOL_WAIT_FREE:
		value = srv_stats.buf_pool_wait_free;
		break;

