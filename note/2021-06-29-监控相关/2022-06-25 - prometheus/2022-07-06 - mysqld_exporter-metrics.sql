# HELP mysql_exporter_collector_duration_seconds Collector time duration.
# TYPE mysql_exporter_collector_duration_seconds gauge
mysql_exporter_collector_duration_seconds{collector="collect.global_status"} 0.011844412
mysql_exporter_collector_duration_seconds{collector="collect.global_variables"} 0.04098587
mysql_exporter_collector_duration_seconds{collector="collect.info_schema.innodb_cmp"} 0.030028133
mysql_exporter_collector_duration_seconds{collector="collect.info_schema.innodb_cmpmem"} 0.045479659
mysql_exporter_collector_duration_seconds{collector="collect.info_schema.processlist"} 0.02111171
mysql_exporter_collector_duration_seconds{collector="collect.info_schema.query_response_time"} 0.004419442
mysql_exporter_collector_duration_seconds{collector="collect.slave_status"} 0.058732692
mysql_exporter_collector_duration_seconds{collector="connection"} 0.022112893
# HELP mysql_exporter_last_scrape_error Whether the last scrape of metrics from MySQL resulted in an error (1 for error, 0 for success).
# TYPE mysql_exporter_last_scrape_error gauge
mysql_exporter_last_scrape_error 0
# HELP mysql_exporter_scrapes_total Total number of times MySQL was scraped for metrics.
# TYPE mysql_exporter_scrapes_total counter
mysql_exporter_scrapes_total 42102




# HELP mysql_global_status_aborted_clients Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_aborted_clients untyped
mysql_global_status_aborted_clients 1073
-- 客户端在未正确关闭连接的情况下被中止的连接数。

# HELP mysql_global_status_aborted_connects Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_aborted_connects untyped
mysql_global_status_aborted_connects 1142
-- 连接 MySQL 服务器失败的尝试次数

# HELP mysql_global_status_binlog_cache_disk_use Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_binlog_cache_disk_use untyped
mysql_global_status_binlog_cache_disk_use 0
-- 在磁盘上创建临时文件用于保存binlog的次数
# HELP mysql_global_status_binlog_cache_use Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_binlog_cache_use untyped
mysql_global_status_binlog_cache_use 72055
-- 缓冲binlog的总次数：包括 binlog 缓冲区和在磁盘上创建临时文件保存 binlog 的总次数

# HELP mysql_global_status_binlog_stmt_cache_disk_use Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_binlog_stmt_cache_disk_use untyped
mysql_global_status_binlog_stmt_cache_disk_use 0
-- 非事务语句缓存使用次数

# HELP mysql_global_status_binlog_stmt_cache_use Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_binlog_stmt_cache_use untyped
mysql_global_status_binlog_stmt_cache_use 464
-- 非事务语句磁盘缓存使用次数


Binlog_cache_use：使用二进制日志缓存的事务数。
Binlog_cache_disk_use：使用临时二进制日志缓存但超过binlog_cache_size值并使用临时文件存储事务语句的事务数。
Binlog_stmt_cache_use：使用二进制日志语句缓存的非事务性语句的数量。
Binlog_stmt_cache_disk_use：使用二进制日志语句缓存但超过binlog_stmt_cache_size值并使用临时文件存储这些语句的非事务语句的数量。


# HELP mysql_global_status_buffer_pool_dirty_pages Innodb buffer pool dirty pages.
# TYPE mysql_global_status_buffer_pool_dirty_pages gauge
mysql_global_status_buffer_pool_dirty_pages 3
-- innodb buffer pool 内存缓冲池的脏页数量

# HELP mysql_global_status_buffer_pool_page_changes_total Innodb buffer pool page state changes.
# TYPE mysql_global_status_buffer_pool_page_changes_total counter
mysql_global_status_buffer_pool_page_changes_total{operation="flushed"} 188071
# HELP mysql_global_status_buffer_pool_pages Innodb buffer pool pages by state.
# TYPE mysql_global_status_buffer_pool_pages gauge
mysql_global_status_buffer_pool_pages{state="data"} 12369
mysql_global_status_buffer_pool_pages{state="free"} 4000
mysql_global_status_buffer_pool_pages{state="misc"} 15
-- innodb buffer pool内存缓冲池数据页的状态：

# HELP mysql_global_status_bytes_received Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_bytes_received untyped
mysql_global_status_bytes_received 1.19189992e+08
# HELP mysql_global_status_bytes_sent Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_bytes_sent untyped
mysql_global_status_bytes_sent 2.268347977e+09
# HELP mysql_global_status_commands_total Total number of executed MySQL commands.
# TYPE mysql_global_status_commands_total counter
mysql_global_status_commands_total{command="admin_commands"} 108333
mysql_global_status_commands_total{command="alter_db"} 0
mysql_global_status_commands_total{command="alter_db_upgrade"} 0
mysql_global_status_commands_total{command="alter_event"} 1
mysql_global_status_commands_total{command="alter_function"} 0
mysql_global_status_commands_total{command="alter_instance"} 0
mysql_global_status_commands_total{command="alter_procedure"} 0
mysql_global_status_commands_total{command="alter_server"} 0
mysql_global_status_commands_total{command="alter_table"} 190
mysql_global_status_commands_total{command="alter_tablespace"} 0
mysql_global_status_commands_total{command="alter_user"} 0
mysql_global_status_commands_total{command="analyze"} 3
mysql_global_status_commands_total{command="assign_to_keycache"} 0
mysql_global_status_commands_total{command="begin"} 8
mysql_global_status_commands_total{command="binlog"} 0
mysql_global_status_commands_total{command="call_procedure"} 27
mysql_global_status_commands_total{command="change_db"} 1488
mysql_global_status_commands_total{command="change_master"} 0
mysql_global_status_commands_total{command="change_repl_filter"} 0
mysql_global_status_commands_total{command="check"} 0
mysql_global_status_commands_total{command="checksum"} 0
mysql_global_status_commands_total{command="commit"} 8837
mysql_global_status_commands_total{command="create_db"} 13
mysql_global_status_commands_total{command="create_event"} 2
mysql_global_status_commands_total{command="create_function"} 0
mysql_global_status_commands_total{command="create_index"} 0
mysql_global_status_commands_total{command="create_procedure"} 4
mysql_global_status_commands_total{command="create_server"} 0
mysql_global_status_commands_total{command="create_table"} 134
mysql_global_status_commands_total{command="create_trigger"} 7
mysql_global_status_commands_total{command="create_udf"} 0
mysql_global_status_commands_total{command="create_user"} 5
mysql_global_status_commands_total{command="create_view"} 0
mysql_global_status_commands_total{command="dealloc_sql"} 0
mysql_global_status_commands_total{command="delete"} 126
mysql_global_status_commands_total{command="delete_multi"} 0
mysql_global_status_commands_total{command="do"} 0
mysql_global_status_commands_total{command="drop_db"} 10
mysql_global_status_commands_total{command="drop_event"} 2
mysql_global_status_commands_total{command="drop_function"} 0
mysql_global_status_commands_total{command="drop_index"} 0
mysql_global_status_commands_total{command="drop_procedure"} 4
mysql_global_status_commands_total{command="drop_server"} 0
mysql_global_status_commands_total{command="drop_table"} 97
mysql_global_status_commands_total{command="drop_trigger"} 6
mysql_global_status_commands_total{command="drop_user"} 0
mysql_global_status_commands_total{command="drop_view"} 0
mysql_global_status_commands_total{command="empty_query"} 0
mysql_global_status_commands_total{command="execute_sql"} 0
mysql_global_status_commands_total{command="explain_other"} 0
mysql_global_status_commands_total{command="flush"} 10
mysql_global_status_commands_total{command="get_diagnostics"} 0
mysql_global_status_commands_total{command="grant"} 5
mysql_global_status_commands_total{command="group_replication_start"} 0
mysql_global_status_commands_total{command="group_replication_stop"} 0
mysql_global_status_commands_total{command="ha_close"} 0
mysql_global_status_commands_total{command="ha_open"} 0
mysql_global_status_commands_total{command="ha_read"} 0
mysql_global_status_commands_total{command="help"} 0
mysql_global_status_commands_total{command="insert"} 69893
mysql_global_status_commands_total{command="insert_select"} 31
mysql_global_status_commands_total{command="install_plugin"} 0
mysql_global_status_commands_total{command="kill"} 35
mysql_global_status_commands_total{command="load"} 0
mysql_global_status_commands_total{command="lock_tables"} 80
mysql_global_status_commands_total{command="optimize"} 0
mysql_global_status_commands_total{command="preload_keys"} 0
mysql_global_status_commands_total{command="prepare_sql"} 0
mysql_global_status_commands_total{command="purge"} 0
mysql_global_status_commands_total{command="purge_before_date"} 0
mysql_global_status_commands_total{command="release_savepoint"} 17
mysql_global_status_commands_total{command="rename_table"} 2
mysql_global_status_commands_total{command="rename_user"} 0
mysql_global_status_commands_total{command="repair"} 0
mysql_global_status_commands_total{command="replace"} 0
mysql_global_status_commands_total{command="replace_select"} 0
mysql_global_status_commands_total{command="reset"} 1
mysql_global_status_commands_total{command="resignal"} 0
mysql_global_status_commands_total{command="revoke"} 0
mysql_global_status_commands_total{command="revoke_all"} 0
mysql_global_status_commands_total{command="rollback"} 3
mysql_global_status_commands_total{command="rollback_to_savepoint"} 243
mysql_global_status_commands_total{command="savepoint"} 17
mysql_global_status_commands_total{command="select"} 232948
mysql_global_status_commands_total{command="set_option"} 109932
mysql_global_status_commands_total{command="show_binlog_events"} 9
mysql_global_status_commands_total{command="show_binlogs"} 47
mysql_global_status_commands_total{command="show_charsets"} 2
mysql_global_status_commands_total{command="show_collations"} 2
mysql_global_status_commands_total{command="show_create_db"} 3
mysql_global_status_commands_total{command="show_create_event"} 4
mysql_global_status_commands_total{command="show_create_func"} 0
mysql_global_status_commands_total{command="show_create_proc"} 0
mysql_global_status_commands_total{command="show_create_table"} 641
mysql_global_status_commands_total{command="show_create_trigger"} 0
mysql_global_status_commands_total{command="show_create_user"} 0
mysql_global_status_commands_total{command="show_databases"} 127
mysql_global_status_commands_total{command="show_engine_logs"} 0
mysql_global_status_commands_total{command="show_engine_mutex"} 0
mysql_global_status_commands_total{command="show_engine_status"} 0
mysql_global_status_commands_total{command="show_errors"} 0
mysql_global_status_commands_total{command="show_events"} 3
mysql_global_status_commands_total{command="show_fields"} 1241
mysql_global_status_commands_total{command="show_function_code"} 0
mysql_global_status_commands_total{command="show_function_status"} 44
mysql_global_status_commands_total{command="show_grants"} 8
mysql_global_status_commands_total{command="show_keys"} 9
mysql_global_status_commands_total{command="show_master_status"} 43
mysql_global_status_commands_total{command="show_open_tables"} 0
mysql_global_status_commands_total{command="show_plugins"} 0
mysql_global_status_commands_total{command="show_privileges"} 0
mysql_global_status_commands_total{command="show_procedure_code"} 0
mysql_global_status_commands_total{command="show_procedure_status"} 44
mysql_global_status_commands_total{command="show_processlist"} 32
mysql_global_status_commands_total{command="show_profile"} 1
mysql_global_status_commands_total{command="show_profiles"} 1
mysql_global_status_commands_total{command="show_relaylog_events"} 0
mysql_global_status_commands_total{command="show_slave_hosts"} 9
mysql_global_status_commands_total{command="show_slave_status"} 52302
mysql_global_status_commands_total{command="show_status"} 52931
mysql_global_status_commands_total{command="show_storage_engines"} 42
mysql_global_status_commands_total{command="show_table_status"} 671
mysql_global_status_commands_total{command="show_tables"} 916
mysql_global_status_commands_total{command="show_triggers"} 248
mysql_global_status_commands_total{command="show_variables"} 52663
mysql_global_status_commands_total{command="show_warnings"} 7
mysql_global_status_commands_total{command="shutdown"} 0
mysql_global_status_commands_total{command="signal"} 0
mysql_global_status_commands_total{command="slave_start"} 0
mysql_global_status_commands_total{command="slave_stop"} 0
mysql_global_status_commands_total{command="stmt_close"} 20
mysql_global_status_commands_total{command="stmt_execute"} 20
mysql_global_status_commands_total{command="stmt_fetch"} 0
mysql_global_status_commands_total{command="stmt_prepare"} 20
mysql_global_status_commands_total{command="stmt_reprepare"} 0
mysql_global_status_commands_total{command="stmt_reset"} 0
mysql_global_status_commands_total{command="stmt_send_long_data"} 0
mysql_global_status_commands_total{command="truncate"} 2
mysql_global_status_commands_total{command="uninstall_plugin"} 0
mysql_global_status_commands_total{command="unlock_tables"} 83
mysql_global_status_commands_total{command="update"} 2245
mysql_global_status_commands_total{command="update_multi"} 0
mysql_global_status_commands_total{command="xa_commit"} 0
mysql_global_status_commands_total{command="xa_end"} 0
mysql_global_status_commands_total{command="xa_prepare"} 0
mysql_global_status_commands_total{command="xa_recover"} 0
mysql_global_status_commands_total{command="xa_rollback"} 0
mysql_global_status_commands_total{command="xa_start"} 0
-- MySQL各种命令执行的总数：insert、delete、select、update、drop、alter_table 等 

# HELP mysql_global_status_connection_errors_total Total number of MySQL connection errors.
# TYPE mysql_global_status_connection_errors_total counter
mysql_global_status_connection_errors_total{error="accept"} 0
mysql_global_status_connection_errors_total{error="internal"} 0
mysql_global_status_connection_errors_total{error="max_connections"} 0
mysql_global_status_connection_errors_total{error="peer_address"} 1
mysql_global_status_connection_errors_total{error="select"} 0
mysql_global_status_connection_errors_total{error="tcpwrap"} 0
-- MySQL各种连接错误类型的总数：
	max_connections: 由于超出最大连接数导致的错误；
	accept：由于系统内部导致的错误；

# HELP mysql_global_status_connections Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_connections untyped
mysql_global_status_connections 63475

# HELP mysql_global_status_created_tmp_disk_tables Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_created_tmp_disk_tables untyped
mysql_global_status_created_tmp_disk_tables 54135
-- 创建磁盘临时表的次数

# HELP mysql_global_status_created_tmp_files Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_created_tmp_files untyped
mysql_global_status_created_tmp_files 43
-- 创建临时文件的次数
# HELP mysql_global_status_created_tmp_tables Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_created_tmp_tables untyped
mysql_global_status_created_tmp_tables 320609
-- 创建临时表的次数

# HELP mysql_global_status_delayed_errors Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_delayed_errors untyped
mysql_global_status_delayed_errors 0

# HELP mysql_global_status_delayed_insert_threads Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_delayed_insert_threads untyped
mysql_global_status_delayed_insert_threads 0

# HELP mysql_global_status_delayed_writes Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_delayed_writes untyped
mysql_global_status_delayed_writes 0
# HELP mysql_global_status_flush_commands Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_flush_commands untyped
mysql_global_status_flush_commands 7
# HELP mysql_global_status_handlers_total Total number of executed MySQL handlers.
# TYPE mysql_global_status_handlers_total counter
mysql_global_status_handlers_total{handler="commit"} 176837
mysql_global_status_handlers_total{handler="delete"} 1393
mysql_global_status_handlers_total{handler="discover"} 0
mysql_global_status_handlers_total{handler="external_lock"} 402183
mysql_global_status_handlers_total{handler="mrr_init"} 0
mysql_global_status_handlers_total{handler="prepare"} 148264
mysql_global_status_handlers_total{handler="read_first"} 66526
mysql_global_status_handlers_total{handler="read_key"} 271204
mysql_global_status_handlers_total{handler="read_last"} 149
mysql_global_status_handlers_total{handler="read_next"} 221309
mysql_global_status_handlers_total{handler="read_prev"} 17376
mysql_global_status_handlers_total{handler="read_rnd"} 99242
mysql_global_status_handlers_total{handler="read_rnd_next"} 9.4006559e+07
mysql_global_status_handlers_total{handler="rollback"} 110
mysql_global_status_handlers_total{handler="savepoint"} 5
mysql_global_status_handlers_total{handler="savepoint_rollback"} 243
mysql_global_status_handlers_total{handler="update"} 105246
mysql_global_status_handlers_total{handler="write"} 4.6309785e+07
-- 执行的 MySQL 处理总数：commit、rollback 

# HELP mysql_global_status_innodb_available_undo_logs Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_available_undo_logs untyped
mysql_global_status_innodb_available_undo_logs 128
-- 可以被使用的undo日志文件有多少个



# HELP mysql_global_status_innodb_buffer_pool_bytes_data Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_buffer_pool_bytes_data untyped
mysql_global_status_innodb_buffer_pool_bytes_data 2.02653696e+08
-- 
# HELP mysql_global_status_innodb_buffer_pool_bytes_dirty Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_buffer_pool_bytes_dirty untyped
mysql_global_status_innodb_buffer_pool_bytes_dirty 49152
innodb buffer pool缓冲池脏页的大小，单位：字节

# HELP mysql_global_status_innodb_buffer_pool_read_ahead Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_buffer_pool_read_ahead untyped
mysql_global_status_innodb_buffer_pool_read_ahead 29676
-- innodb buffer pool缓冲池每秒预读的page个数

# HELP mysql_global_status_innodb_buffer_pool_read_ahead_evicted Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_buffer_pool_read_ahead_evicted untyped
mysql_global_status_innodb_buffer_pool_read_ahead_evicted 786
-- innodb buffer pool缓冲池每秒无效预读Page个数，即通过预读来的数据页没有被查询就被清理的Page个数

# HELP mysql_global_status_innodb_buffer_pool_read_ahead_rnd Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_buffer_pool_read_ahead_rnd untyped
mysql_global_status_innodb_buffer_pool_read_ahead_rnd 0
# HELP mysql_global_status_innodb_buffer_pool_read_requests Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_buffer_pool_read_requests untyped
mysql_global_status_innodb_buffer_pool_read_requests 4.325148e+06
-- 从缓冲池读取页的次数

# HELP mysql_global_status_innodb_buffer_pool_reads Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_buffer_pool_reads untyped
mysql_global_status_innodb_buffer_pool_reads 20687
-- 预读的次数

# HELP mysql_global_status_innodb_buffer_pool_wait_free Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_buffer_pool_wait_free untyped
mysql_global_status_innodb_buffer_pool_wait_free 0
-- 因free list中没有可用空闲页导致的等待获取空闲页的次数

# HELP mysql_global_status_innodb_buffer_pool_write_requests Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_buffer_pool_write_requests untyped
mysql_global_status_innodb_buffer_pool_write_requests 1.868361e+06
-- 

# HELP mysql_global_status_innodb_data_fsyncs Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_data_fsyncs untyped
mysql_global_status_innodb_data_fsyncs 20501
-- 


# HELP mysql_global_status_innodb_data_pending_fsyncs Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_data_pending_fsyncs untyped
mysql_global_status_innodb_data_pending_fsyncs 0
-- 
# HELP mysql_global_status_innodb_data_pending_reads Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_data_pending_reads untyped
mysql_global_status_innodb_data_pending_reads 0
-- 

# HELP mysql_global_status_innodb_data_pending_writes Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_data_pending_writes untyped
mysql_global_status_innodb_data_pending_writes 0
-- 

# HELP mysql_global_status_innodb_data_read Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_data_read untyped
mysql_global_status_innodb_data_read 8.25217536e+08
-- 

# HELP mysql_global_status_innodb_data_reads Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_data_reads untyped
mysql_global_status_innodb_data_reads 50786
# HELP mysql_global_status_innodb_data_writes Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_data_writes untyped
mysql_global_status_innodb_data_writes 204698
# HELP mysql_global_status_innodb_data_written Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_data_written untyped
mysql_global_status_innodb_data_written 3.651987968e+09
# HELP mysql_global_status_innodb_dblwr_pages_written Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_dblwr_pages_written untyped
mysql_global_status_innodb_dblwr_pages_written 28636
# HELP mysql_global_status_innodb_dblwr_writes Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_dblwr_writes untyped
mysql_global_status_innodb_dblwr_writes 2606
# HELP mysql_global_status_innodb_log_waits Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_log_waits untyped
mysql_global_status_innodb_log_waits 0
# HELP mysql_global_status_innodb_log_write_requests Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_log_write_requests untyped
mysql_global_status_innodb_log_write_requests 155521
# HELP mysql_global_status_innodb_log_writes Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_log_writes untyped
mysql_global_status_innodb_log_writes 9242
# HELP mysql_global_status_innodb_num_open_files Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_num_open_files untyped
mysql_global_status_innodb_num_open_files 111
# HELP mysql_global_status_innodb_os_log_fsyncs Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_os_log_fsyncs untyped
mysql_global_status_innodb_os_log_fsyncs 11868
# HELP mysql_global_status_innodb_os_log_pending_fsyncs Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_os_log_pending_fsyncs untyped
mysql_global_status_innodb_os_log_pending_fsyncs 0
# HELP mysql_global_status_innodb_os_log_pending_writes Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_os_log_pending_writes untyped
mysql_global_status_innodb_os_log_pending_writes 0
# HELP mysql_global_status_innodb_os_log_written Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_os_log_written untyped
mysql_global_status_innodb_os_log_written 9.4692864e+07
# HELP mysql_global_status_innodb_page_size Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_page_size untyped
mysql_global_status_innodb_page_size 16384
-- InnoDB 数据页的大小 

# HELP mysql_global_status_innodb_pages_created Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_pages_created untyped
mysql_global_status_innodb_pages_created 6508
# HELP mysql_global_status_innodb_pages_read Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_pages_read untyped
mysql_global_status_innodb_pages_read 50362
# HELP mysql_global_status_innodb_pages_written Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_pages_written untyped
mysql_global_status_innodb_pages_written 188402
# HELP mysql_global_status_innodb_row_lock_current_waits Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_row_lock_current_waits untyped
mysql_global_status_innodb_row_lock_current_waits 0
# HELP mysql_global_status_innodb_row_lock_time Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_row_lock_time untyped
mysql_global_status_innodb_row_lock_time 1672
# HELP mysql_global_status_innodb_row_lock_time_avg Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_row_lock_time_avg untyped
mysql_global_status_innodb_row_lock_time_avg 23
# HELP mysql_global_status_innodb_row_lock_time_max Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_row_lock_time_max untyped
mysql_global_status_innodb_row_lock_time_max 71
# HELP mysql_global_status_innodb_row_lock_waits Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_row_lock_waits untyped
mysql_global_status_innodb_row_lock_waits 72
# HELP mysql_global_status_innodb_row_ops_total Total number of MySQL InnoDB row operations.
# TYPE mysql_global_status_innodb_row_ops_total counter
mysql_global_status_innodb_row_ops_total{operation="deleted"} 1386
mysql_global_status_innodb_row_ops_total{operation="inserted"} 333794
mysql_global_status_innodb_row_ops_total{operation="read"} 2.401911e+06
mysql_global_status_innodb_row_ops_total{operation="updated"} 15648
# HELP mysql_global_status_innodb_truncated_status_writes Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_innodb_truncated_status_writes untyped
mysql_global_status_innodb_truncated_status_writes 0
# HELP mysql_global_status_key_blocks_not_flushed Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_key_blocks_not_flushed untyped
mysql_global_status_key_blocks_not_flushed 0
# HELP mysql_global_status_key_blocks_unused Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_key_blocks_unused untyped
mysql_global_status_key_blocks_unused 26786
# HELP mysql_global_status_key_blocks_used Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_key_blocks_used untyped
mysql_global_status_key_blocks_used 6
# HELP mysql_global_status_key_read_requests Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_key_read_requests untyped
mysql_global_status_key_read_requests 919
# HELP mysql_global_status_key_reads Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_key_reads untyped
mysql_global_status_key_reads 19
# HELP mysql_global_status_key_write_requests Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_key_write_requests untyped
mysql_global_status_key_write_requests 37
# HELP mysql_global_status_key_writes Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_key_writes untyped
mysql_global_status_key_writes 34
# HELP mysql_global_status_locked_connects Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_locked_connects untyped
mysql_global_status_locked_connects 0
# HELP mysql_global_status_max_execution_time_exceeded Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_max_execution_time_exceeded untyped
mysql_global_status_max_execution_time_exceeded 0
# HELP mysql_global_status_max_execution_time_set Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_max_execution_time_set untyped
mysql_global_status_max_execution_time_set 0
# HELP mysql_global_status_max_execution_time_set_failed Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_max_execution_time_set_failed untyped
mysql_global_status_max_execution_time_set_failed 0
# HELP mysql_global_status_max_used_connections Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_max_used_connections untyped
mysql_global_status_max_used_connections 28
# HELP mysql_global_status_max_used_connections_time Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_max_used_connections_time untyped
mysql_global_status_max_used_connections_time 1.65638003e+09
# HELP mysql_global_status_not_flushed_delayed_rows Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_not_flushed_delayed_rows untyped
mysql_global_status_not_flushed_delayed_rows 0
# HELP mysql_global_status_ongoing_anonymous_transaction_count Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_ongoing_anonymous_transaction_count untyped
mysql_global_status_ongoing_anonymous_transaction_count 0
# HELP mysql_global_status_open_files Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_open_files untyped
mysql_global_status_open_files 84
# HELP mysql_global_status_open_streams Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_open_streams untyped
mysql_global_status_open_streams 0
# HELP mysql_global_status_open_table_definitions Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_open_table_definitions untyped
mysql_global_status_open_table_definitions 306
# HELP mysql_global_status_open_tables Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_open_tables untyped
mysql_global_status_open_tables 874
# HELP mysql_global_status_opened_files Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_opened_files untyped
mysql_global_status_opened_files 64912
# HELP mysql_global_status_opened_table_definitions Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_opened_table_definitions untyped
mysql_global_status_opened_table_definitions 1232
# HELP mysql_global_status_opened_tables Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_opened_tables untyped
mysql_global_status_opened_tables 12800
# HELP mysql_global_status_performance_schema_lost_total Total number of MySQL instrumentations that could not be loaded or created due to memory constraints.
# TYPE mysql_global_status_performance_schema_lost_total counter
mysql_global_status_performance_schema_lost_total{instrumentation="accounts_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="cond_classes_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="cond_instances_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="digest_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="file_classes_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="file_handles_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="file_instances_lost"} 27
mysql_global_status_performance_schema_lost_total{instrumentation="hosts_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="index_stat_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="locker_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="memory_classes_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="metadata_lock_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="mutex_classes_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="mutex_instances_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="nested_statement_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="prepared_statements_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="program_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="rwlock_classes_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="rwlock_instances_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="session_connect_attrs_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="socket_classes_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="socket_instances_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="stage_classes_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="statement_classes_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="table_handles_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="table_instances_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="table_lock_stat_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="thread_classes_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="thread_instances_lost"} 0
mysql_global_status_performance_schema_lost_total{instrumentation="users_lost"} 0
# HELP mysql_global_status_prepared_stmt_count Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_prepared_stmt_count untyped
mysql_global_status_prepared_stmt_count 0
# HELP mysql_global_status_qcache_free_blocks Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_qcache_free_blocks untyped
mysql_global_status_qcache_free_blocks 0
# HELP mysql_global_status_qcache_free_memory Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_qcache_free_memory untyped
mysql_global_status_qcache_free_memory 0
# HELP mysql_global_status_qcache_hits Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_qcache_hits untyped
mysql_global_status_qcache_hits 0
# HELP mysql_global_status_qcache_inserts Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_qcache_inserts untyped
mysql_global_status_qcache_inserts 0
# HELP mysql_global_status_qcache_lowmem_prunes Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_qcache_lowmem_prunes untyped
mysql_global_status_qcache_lowmem_prunes 0
# HELP mysql_global_status_qcache_not_cached Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_qcache_not_cached untyped
mysql_global_status_qcache_not_cached 0
# HELP mysql_global_status_qcache_queries_in_cache Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_qcache_queries_in_cache untyped
mysql_global_status_qcache_queries_in_cache 0
# HELP mysql_global_status_qcache_total_blocks Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_qcache_total_blocks untyped
mysql_global_status_qcache_total_blocks 0
# HELP mysql_global_status_queries Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_queries untyped
mysql_global_status_queries 1.019719e+06
# HELP mysql_global_status_questions Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_questions untyped
mysql_global_status_questions 911224
# HELP mysql_global_status_select_full_join Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_select_full_join untyped
mysql_global_status_select_full_join 174
# HELP mysql_global_status_select_full_range_join Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_select_full_range_join untyped
mysql_global_status_select_full_range_join 0
# HELP mysql_global_status_select_range Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_select_range untyped
mysql_global_status_select_range 261
# HELP mysql_global_status_select_range_check Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_select_range_check untyped
mysql_global_status_select_range_check 0
# HELP mysql_global_status_select_scan Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_select_scan untyped
mysql_global_status_select_scan 384481
# HELP mysql_global_status_slave_open_temp_tables Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_slave_open_temp_tables untyped
mysql_global_status_slave_open_temp_tables 0
# HELP mysql_global_status_slow_launch_threads Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_slow_launch_threads untyped
mysql_global_status_slow_launch_threads 0
# HELP mysql_global_status_slow_queries Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_slow_queries untyped
mysql_global_status_slow_queries 14
# HELP mysql_global_status_sort_merge_passes Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_sort_merge_passes untyped
mysql_global_status_sort_merge_passes 14
# HELP mysql_global_status_sort_range Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_sort_range untyped
mysql_global_status_sort_range 41
# HELP mysql_global_status_sort_rows Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_sort_rows untyped
mysql_global_status_sort_rows 100644
# HELP mysql_global_status_sort_scan Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_sort_scan untyped
mysql_global_status_sort_scan 59516
# HELP mysql_global_status_ssl_accept_renegotiates Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_ssl_accept_renegotiates untyped
mysql_global_status_ssl_accept_renegotiates 0
# HELP mysql_global_status_ssl_accepts Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_ssl_accepts untyped
mysql_global_status_ssl_accepts 98
# HELP mysql_global_status_ssl_callback_cache_hits Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_ssl_callback_cache_hits untyped
mysql_global_status_ssl_callback_cache_hits 0
# HELP mysql_global_status_ssl_client_connects Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_ssl_client_connects untyped
mysql_global_status_ssl_client_connects 0
# HELP mysql_global_status_ssl_connect_renegotiates Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_ssl_connect_renegotiates untyped
mysql_global_status_ssl_connect_renegotiates 0
# HELP mysql_global_status_ssl_ctx_verify_depth Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_ssl_ctx_verify_depth untyped
mysql_global_status_ssl_ctx_verify_depth 1.8446744073709552e+19
# HELP mysql_global_status_ssl_ctx_verify_mode Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_ssl_ctx_verify_mode untyped
mysql_global_status_ssl_ctx_verify_mode 5
# HELP mysql_global_status_ssl_default_timeout Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_ssl_default_timeout untyped
mysql_global_status_ssl_default_timeout 0
# HELP mysql_global_status_ssl_finished_accepts Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_ssl_finished_accepts untyped
mysql_global_status_ssl_finished_accepts 85
# HELP mysql_global_status_ssl_finished_connects Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_ssl_finished_connects untyped
mysql_global_status_ssl_finished_connects 0
# HELP mysql_global_status_ssl_server_not_after Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_ssl_server_not_after untyped
mysql_global_status_ssl_server_not_after 1.9601977e+09
# HELP mysql_global_status_ssl_server_not_before Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_ssl_server_not_before untyped
mysql_global_status_ssl_server_not_before 1.6448377e+09
# HELP mysql_global_status_ssl_session_cache_hits Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_ssl_session_cache_hits untyped
mysql_global_status_ssl_session_cache_hits 0
# HELP mysql_global_status_ssl_session_cache_misses Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_ssl_session_cache_misses untyped
mysql_global_status_ssl_session_cache_misses 26
# HELP mysql_global_status_ssl_session_cache_overflows Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_ssl_session_cache_overflows untyped
mysql_global_status_ssl_session_cache_overflows 0
# HELP mysql_global_status_ssl_session_cache_size Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_ssl_session_cache_size untyped
mysql_global_status_ssl_session_cache_size 128
# HELP mysql_global_status_ssl_session_cache_timeouts Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_ssl_session_cache_timeouts untyped
mysql_global_status_ssl_session_cache_timeouts 0
# HELP mysql_global_status_ssl_sessions_reused Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_ssl_sessions_reused untyped
mysql_global_status_ssl_sessions_reused 0
# HELP mysql_global_status_ssl_used_session_cache_entries Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_ssl_used_session_cache_entries untyped
mysql_global_status_ssl_used_session_cache_entries 53
# HELP mysql_global_status_ssl_verify_depth Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_ssl_verify_depth untyped
mysql_global_status_ssl_verify_depth 0
# HELP mysql_global_status_ssl_verify_mode Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_ssl_verify_mode untyped
mysql_global_status_ssl_verify_mode 0
# HELP mysql_global_status_table_locks_immediate Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_table_locks_immediate untyped
mysql_global_status_table_locks_immediate 106063
# HELP mysql_global_status_table_locks_waited Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_table_locks_waited untyped
mysql_global_status_table_locks_waited 0
# HELP mysql_global_status_table_open_cache_hits Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_table_open_cache_hits untyped
mysql_global_status_table_open_cache_hits 198941
# HELP mysql_global_status_table_open_cache_misses Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_table_open_cache_misses untyped
mysql_global_status_table_open_cache_misses 12800
# HELP mysql_global_status_table_open_cache_overflows Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_table_open_cache_overflows untyped
mysql_global_status_table_open_cache_overflows 9208
# HELP mysql_global_status_tc_log_max_pages_used Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_tc_log_max_pages_used untyped
mysql_global_status_tc_log_max_pages_used 0
# HELP mysql_global_status_tc_log_page_size Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_tc_log_page_size untyped
mysql_global_status_tc_log_page_size 0
# HELP mysql_global_status_tc_log_page_waits Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_tc_log_page_waits untyped
mysql_global_status_tc_log_page_waits 0
# HELP mysql_global_status_threads_cached Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_threads_cached untyped
mysql_global_status_threads_cached 27
# HELP mysql_global_status_threads_connected Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_threads_connected untyped
mysql_global_status_threads_connected 1
# HELP mysql_global_status_threads_created Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_threads_created untyped
mysql_global_status_threads_created 28
# HELP mysql_global_status_threads_running Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_threads_running untyped
mysql_global_status_threads_running 2
# HELP mysql_global_status_uptime Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_uptime untyped
mysql_global_status_uptime 3.364118e+06
# HELP mysql_global_status_uptime_since_flush_status Generic metric from SHOW GLOBAL STATUS.
# TYPE mysql_global_status_uptime_since_flush_status untyped
mysql_global_status_uptime_since_flush_status 3.364118e+06
# HELP mysql_global_variables_auto_generate_certs Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_auto_generate_certs gauge
mysql_global_variables_auto_generate_certs 1
# HELP mysql_global_variables_auto_increment_increment Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_auto_increment_increment gauge
mysql_global_variables_auto_increment_increment 1
# HELP mysql_global_variables_auto_increment_offset Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_auto_increment_offset gauge
mysql_global_variables_auto_increment_offset 1
# HELP mysql_global_variables_autocommit Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_autocommit gauge
mysql_global_variables_autocommit 1
# HELP mysql_global_variables_automatic_sp_privileges Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_automatic_sp_privileges gauge
mysql_global_variables_automatic_sp_privileges 1
# HELP mysql_global_variables_avoid_temporal_upgrade Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_avoid_temporal_upgrade gauge
mysql_global_variables_avoid_temporal_upgrade 0
# HELP mysql_global_variables_back_log Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_back_log gauge
mysql_global_variables_back_log 1024
# HELP mysql_global_variables_big_tables Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_big_tables gauge
mysql_global_variables_big_tables 0
# HELP mysql_global_variables_binlog_cache_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_binlog_cache_size gauge
mysql_global_variables_binlog_cache_size 4.194304e+06
# HELP mysql_global_variables_binlog_direct_non_transactional_updates Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_binlog_direct_non_transactional_updates gauge
mysql_global_variables_binlog_direct_non_transactional_updates 0
# HELP mysql_global_variables_binlog_group_commit_sync_delay Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_binlog_group_commit_sync_delay gauge
mysql_global_variables_binlog_group_commit_sync_delay 0
# HELP mysql_global_variables_binlog_group_commit_sync_no_delay_count Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_binlog_group_commit_sync_no_delay_count gauge
mysql_global_variables_binlog_group_commit_sync_no_delay_count 0
# HELP mysql_global_variables_binlog_gtid_simple_recovery Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_binlog_gtid_simple_recovery gauge
mysql_global_variables_binlog_gtid_simple_recovery 1
# HELP mysql_global_variables_binlog_max_flush_queue_time Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_binlog_max_flush_queue_time gauge
mysql_global_variables_binlog_max_flush_queue_time 0
# HELP mysql_global_variables_binlog_order_commits Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_binlog_order_commits gauge
mysql_global_variables_binlog_order_commits 1
# HELP mysql_global_variables_binlog_rows_query_log_events Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_binlog_rows_query_log_events gauge
mysql_global_variables_binlog_rows_query_log_events 0
# HELP mysql_global_variables_binlog_stmt_cache_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_binlog_stmt_cache_size gauge
mysql_global_variables_binlog_stmt_cache_size 32768
# HELP mysql_global_variables_binlog_transaction_dependency_history_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_binlog_transaction_dependency_history_size gauge
mysql_global_variables_binlog_transaction_dependency_history_size 25000
# HELP mysql_global_variables_bulk_insert_buffer_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_bulk_insert_buffer_size gauge
mysql_global_variables_bulk_insert_buffer_size 6.7108864e+07
# HELP mysql_global_variables_check_proxy_users Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_check_proxy_users gauge
mysql_global_variables_check_proxy_users 0
# HELP mysql_global_variables_connect_timeout Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_connect_timeout gauge
mysql_global_variables_connect_timeout 10
# HELP mysql_global_variables_core_file Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_core_file gauge
mysql_global_variables_core_file 0
# HELP mysql_global_variables_default_password_lifetime Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_default_password_lifetime gauge
mysql_global_variables_default_password_lifetime 0
# HELP mysql_global_variables_default_week_format Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_default_week_format gauge
mysql_global_variables_default_week_format 0
# HELP mysql_global_variables_delay_key_write Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_delay_key_write gauge
mysql_global_variables_delay_key_write 1
# HELP mysql_global_variables_delayed_insert_limit Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_delayed_insert_limit gauge
mysql_global_variables_delayed_insert_limit 100
# HELP mysql_global_variables_delayed_insert_timeout Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_delayed_insert_timeout gauge
mysql_global_variables_delayed_insert_timeout 300
# HELP mysql_global_variables_delayed_queue_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_delayed_queue_size gauge
mysql_global_variables_delayed_queue_size 1000
# HELP mysql_global_variables_disconnect_on_expired_password Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_disconnect_on_expired_password gauge
mysql_global_variables_disconnect_on_expired_password 1
# HELP mysql_global_variables_div_precision_increment Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_div_precision_increment gauge
mysql_global_variables_div_precision_increment 4
# HELP mysql_global_variables_end_markers_in_json Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_end_markers_in_json gauge
mysql_global_variables_end_markers_in_json 0
# HELP mysql_global_variables_enforce_gtid_consistency Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_enforce_gtid_consistency gauge
mysql_global_variables_enforce_gtid_consistency 0
# HELP mysql_global_variables_eq_range_index_dive_limit Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_eq_range_index_dive_limit gauge
mysql_global_variables_eq_range_index_dive_limit 200
# HELP mysql_global_variables_event_scheduler Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_event_scheduler gauge
mysql_global_variables_event_scheduler 1
# HELP mysql_global_variables_expire_logs_days Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_expire_logs_days gauge
mysql_global_variables_expire_logs_days 7
# HELP mysql_global_variables_explicit_defaults_for_timestamp Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_explicit_defaults_for_timestamp gauge
mysql_global_variables_explicit_defaults_for_timestamp 1
# HELP mysql_global_variables_flush Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_flush gauge
mysql_global_variables_flush 0
# HELP mysql_global_variables_flush_time Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_flush_time gauge
mysql_global_variables_flush_time 0
# HELP mysql_global_variables_foreign_key_checks Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_foreign_key_checks gauge
mysql_global_variables_foreign_key_checks 1
# HELP mysql_global_variables_ft_max_word_len Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_ft_max_word_len gauge
mysql_global_variables_ft_max_word_len 84
# HELP mysql_global_variables_ft_min_word_len Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_ft_min_word_len gauge
mysql_global_variables_ft_min_word_len 4
# HELP mysql_global_variables_ft_query_expansion_limit Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_ft_query_expansion_limit gauge
mysql_global_variables_ft_query_expansion_limit 20
# HELP mysql_global_variables_general_log Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_general_log gauge
mysql_global_variables_general_log 0
# HELP mysql_global_variables_group_concat_max_len Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_group_concat_max_len gauge
mysql_global_variables_group_concat_max_len 1024
# HELP mysql_global_variables_gtid_executed_compression_period Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_gtid_executed_compression_period gauge
mysql_global_variables_gtid_executed_compression_period 1000
# HELP mysql_global_variables_gtid_mode Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_gtid_mode gauge
mysql_global_variables_gtid_mode 0
# HELP mysql_global_variables_have_compress Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_have_compress gauge
mysql_global_variables_have_compress 1
# HELP mysql_global_variables_have_crypt Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_have_crypt gauge
mysql_global_variables_have_crypt 1
# HELP mysql_global_variables_have_dynamic_loading Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_have_dynamic_loading gauge
mysql_global_variables_have_dynamic_loading 1
# HELP mysql_global_variables_have_geometry Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_have_geometry gauge
mysql_global_variables_have_geometry 1
# HELP mysql_global_variables_have_openssl Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_have_openssl gauge
mysql_global_variables_have_openssl 1
# HELP mysql_global_variables_have_profiling Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_have_profiling gauge
mysql_global_variables_have_profiling 1
# HELP mysql_global_variables_have_query_cache Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_have_query_cache gauge
mysql_global_variables_have_query_cache 1
# HELP mysql_global_variables_have_rtree_keys Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_have_rtree_keys gauge
mysql_global_variables_have_rtree_keys 1
# HELP mysql_global_variables_have_ssl Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_have_ssl gauge
mysql_global_variables_have_ssl 1
# HELP mysql_global_variables_have_statement_timeout Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_have_statement_timeout gauge
mysql_global_variables_have_statement_timeout 1
# HELP mysql_global_variables_have_symlink Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_have_symlink gauge
mysql_global_variables_have_symlink 1
# HELP mysql_global_variables_host_cache_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_host_cache_size gauge
mysql_global_variables_host_cache_size 753
# HELP mysql_global_variables_ignore_builtin_innodb Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_ignore_builtin_innodb gauge
mysql_global_variables_ignore_builtin_innodb 0
# HELP mysql_global_variables_innodb_adaptive_flushing Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_adaptive_flushing gauge
mysql_global_variables_innodb_adaptive_flushing 1
# HELP mysql_global_variables_innodb_adaptive_flushing_lwm Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_adaptive_flushing_lwm gauge
mysql_global_variables_innodb_adaptive_flushing_lwm 10
# HELP mysql_global_variables_innodb_adaptive_hash_index Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_adaptive_hash_index gauge
mysql_global_variables_innodb_adaptive_hash_index 1
# HELP mysql_global_variables_innodb_adaptive_hash_index_parts Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_adaptive_hash_index_parts gauge
mysql_global_variables_innodb_adaptive_hash_index_parts 8
# HELP mysql_global_variables_innodb_adaptive_max_sleep_delay Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_adaptive_max_sleep_delay gauge
mysql_global_variables_innodb_adaptive_max_sleep_delay 150000
# HELP mysql_global_variables_innodb_api_bk_commit_interval Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_api_bk_commit_interval gauge
mysql_global_variables_innodb_api_bk_commit_interval 5
# HELP mysql_global_variables_innodb_api_disable_rowlock Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_api_disable_rowlock gauge
mysql_global_variables_innodb_api_disable_rowlock 0
# HELP mysql_global_variables_innodb_api_enable_binlog Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_api_enable_binlog gauge
mysql_global_variables_innodb_api_enable_binlog 0
# HELP mysql_global_variables_innodb_api_enable_mdl Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_api_enable_mdl gauge
mysql_global_variables_innodb_api_enable_mdl 0
# HELP mysql_global_variables_innodb_api_trx_level Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_api_trx_level gauge
mysql_global_variables_innodb_api_trx_level 0
# HELP mysql_global_variables_innodb_autoextend_increment Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_autoextend_increment gauge
mysql_global_variables_innodb_autoextend_increment 64
# HELP mysql_global_variables_innodb_autoinc_lock_mode Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_autoinc_lock_mode gauge
mysql_global_variables_innodb_autoinc_lock_mode 1
# HELP mysql_global_variables_innodb_buffer_pool_chunk_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_buffer_pool_chunk_size gauge
mysql_global_variables_innodb_buffer_pool_chunk_size 1.34217728e+08
# HELP mysql_global_variables_innodb_buffer_pool_dump_at_shutdown Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_buffer_pool_dump_at_shutdown gauge
mysql_global_variables_innodb_buffer_pool_dump_at_shutdown 1
# HELP mysql_global_variables_innodb_buffer_pool_dump_now Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_buffer_pool_dump_now gauge
mysql_global_variables_innodb_buffer_pool_dump_now 0
# HELP mysql_global_variables_innodb_buffer_pool_dump_pct Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_buffer_pool_dump_pct gauge
mysql_global_variables_innodb_buffer_pool_dump_pct 25
# HELP mysql_global_variables_innodb_buffer_pool_instances Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_buffer_pool_instances gauge
mysql_global_variables_innodb_buffer_pool_instances 1
# HELP mysql_global_variables_innodb_buffer_pool_load_abort Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_buffer_pool_load_abort gauge
mysql_global_variables_innodb_buffer_pool_load_abort 0
# HELP mysql_global_variables_innodb_buffer_pool_load_at_startup Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_buffer_pool_load_at_startup gauge
mysql_global_variables_innodb_buffer_pool_load_at_startup 1
# HELP mysql_global_variables_innodb_buffer_pool_load_now Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_buffer_pool_load_now gauge
mysql_global_variables_innodb_buffer_pool_load_now 0
# HELP mysql_global_variables_innodb_buffer_pool_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_buffer_pool_size gauge
mysql_global_variables_innodb_buffer_pool_size 2.68435456e+08
# HELP mysql_global_variables_innodb_change_buffer_max_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_change_buffer_max_size gauge
mysql_global_variables_innodb_change_buffer_max_size 25
# HELP mysql_global_variables_innodb_checksums Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_checksums gauge
mysql_global_variables_innodb_checksums 1
# HELP mysql_global_variables_innodb_cmp_per_index_enabled Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_cmp_per_index_enabled gauge
mysql_global_variables_innodb_cmp_per_index_enabled 0
# HELP mysql_global_variables_innodb_commit_concurrency Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_commit_concurrency gauge
mysql_global_variables_innodb_commit_concurrency 0
# HELP mysql_global_variables_innodb_compression_failure_threshold_pct Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_compression_failure_threshold_pct gauge
mysql_global_variables_innodb_compression_failure_threshold_pct 5
# HELP mysql_global_variables_innodb_compression_level Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_compression_level gauge
mysql_global_variables_innodb_compression_level 6
# HELP mysql_global_variables_innodb_compression_pad_pct_max Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_compression_pad_pct_max gauge
mysql_global_variables_innodb_compression_pad_pct_max 50
# HELP mysql_global_variables_innodb_concurrency_tickets Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_concurrency_tickets gauge
mysql_global_variables_innodb_concurrency_tickets 5000
# HELP mysql_global_variables_innodb_deadlock_detect Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_deadlock_detect gauge
mysql_global_variables_innodb_deadlock_detect 1
# HELP mysql_global_variables_innodb_disable_sort_file_cache Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_disable_sort_file_cache gauge
mysql_global_variables_innodb_disable_sort_file_cache 0
# HELP mysql_global_variables_innodb_doublewrite Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_doublewrite gauge
mysql_global_variables_innodb_doublewrite 1
# HELP mysql_global_variables_innodb_fast_shutdown Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_fast_shutdown gauge
mysql_global_variables_innodb_fast_shutdown 1
# HELP mysql_global_variables_innodb_file_format_check Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_file_format_check gauge
mysql_global_variables_innodb_file_format_check 1
# HELP mysql_global_variables_innodb_file_per_table Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_file_per_table gauge
mysql_global_variables_innodb_file_per_table 1
# HELP mysql_global_variables_innodb_fill_factor Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_fill_factor gauge
mysql_global_variables_innodb_fill_factor 100
# HELP mysql_global_variables_innodb_flush_log_at_timeout Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_flush_log_at_timeout gauge
mysql_global_variables_innodb_flush_log_at_timeout 1
# HELP mysql_global_variables_innodb_flush_log_at_trx_commit Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_flush_log_at_trx_commit gauge
mysql_global_variables_innodb_flush_log_at_trx_commit 0
# HELP mysql_global_variables_innodb_flush_neighbors Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_flush_neighbors gauge
mysql_global_variables_innodb_flush_neighbors 0
# HELP mysql_global_variables_innodb_flush_sync Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_flush_sync gauge
mysql_global_variables_innodb_flush_sync 1
# HELP mysql_global_variables_innodb_flushing_avg_loops Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_flushing_avg_loops gauge
mysql_global_variables_innodb_flushing_avg_loops 30
# HELP mysql_global_variables_innodb_force_load_corrupted Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_force_load_corrupted gauge
mysql_global_variables_innodb_force_load_corrupted 0
# HELP mysql_global_variables_innodb_force_recovery Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_force_recovery gauge
mysql_global_variables_innodb_force_recovery 0
# HELP mysql_global_variables_innodb_ft_cache_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_ft_cache_size gauge
mysql_global_variables_innodb_ft_cache_size 8e+06
# HELP mysql_global_variables_innodb_ft_enable_diag_print Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_ft_enable_diag_print gauge
mysql_global_variables_innodb_ft_enable_diag_print 0
# HELP mysql_global_variables_innodb_ft_enable_stopword Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_ft_enable_stopword gauge
mysql_global_variables_innodb_ft_enable_stopword 1
# HELP mysql_global_variables_innodb_ft_max_token_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_ft_max_token_size gauge
mysql_global_variables_innodb_ft_max_token_size 84
# HELP mysql_global_variables_innodb_ft_min_token_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_ft_min_token_size gauge
mysql_global_variables_innodb_ft_min_token_size 3
# HELP mysql_global_variables_innodb_ft_num_word_optimize Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_ft_num_word_optimize gauge
mysql_global_variables_innodb_ft_num_word_optimize 2000
# HELP mysql_global_variables_innodb_ft_result_cache_limit Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_ft_result_cache_limit gauge
mysql_global_variables_innodb_ft_result_cache_limit 2e+09
# HELP mysql_global_variables_innodb_ft_sort_pll_degree Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_ft_sort_pll_degree gauge
mysql_global_variables_innodb_ft_sort_pll_degree 2
# HELP mysql_global_variables_innodb_ft_total_cache_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_ft_total_cache_size gauge
mysql_global_variables_innodb_ft_total_cache_size 6.4e+08
# HELP mysql_global_variables_innodb_io_capacity Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_io_capacity gauge
mysql_global_variables_innodb_io_capacity 4000
# HELP mysql_global_variables_innodb_io_capacity_max Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_io_capacity_max gauge
mysql_global_variables_innodb_io_capacity_max 8000
# HELP mysql_global_variables_innodb_large_prefix Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_large_prefix gauge
mysql_global_variables_innodb_large_prefix 1
# HELP mysql_global_variables_innodb_lock_wait_timeout Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_lock_wait_timeout gauge
mysql_global_variables_innodb_lock_wait_timeout 10
# HELP mysql_global_variables_innodb_locks_unsafe_for_binlog Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_locks_unsafe_for_binlog gauge
mysql_global_variables_innodb_locks_unsafe_for_binlog 0
# HELP mysql_global_variables_innodb_log_buffer_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_log_buffer_size gauge
mysql_global_variables_innodb_log_buffer_size 3.3554432e+07
# HELP mysql_global_variables_innodb_log_checksums Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_log_checksums gauge
mysql_global_variables_innodb_log_checksums 1
# HELP mysql_global_variables_innodb_log_compressed_pages Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_log_compressed_pages gauge
mysql_global_variables_innodb_log_compressed_pages 1
# HELP mysql_global_variables_innodb_log_file_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_log_file_size gauge
mysql_global_variables_innodb_log_file_size 1.073741824e+09
# HELP mysql_global_variables_innodb_log_files_in_group Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_log_files_in_group gauge
mysql_global_variables_innodb_log_files_in_group 3
# HELP mysql_global_variables_innodb_log_write_ahead_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_log_write_ahead_size gauge
mysql_global_variables_innodb_log_write_ahead_size 8192
# HELP mysql_global_variables_innodb_lru_scan_depth Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_lru_scan_depth gauge
mysql_global_variables_innodb_lru_scan_depth 4000
# HELP mysql_global_variables_innodb_max_dirty_pages_pct Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_max_dirty_pages_pct gauge
mysql_global_variables_innodb_max_dirty_pages_pct 50
# HELP mysql_global_variables_innodb_max_dirty_pages_pct_lwm Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_max_dirty_pages_pct_lwm gauge
mysql_global_variables_innodb_max_dirty_pages_pct_lwm 0
# HELP mysql_global_variables_innodb_max_purge_lag Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_max_purge_lag gauge
mysql_global_variables_innodb_max_purge_lag 0
# HELP mysql_global_variables_innodb_max_purge_lag_delay Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_max_purge_lag_delay gauge
mysql_global_variables_innodb_max_purge_lag_delay 0
# HELP mysql_global_variables_innodb_max_undo_log_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_max_undo_log_size gauge
mysql_global_variables_innodb_max_undo_log_size 4.294967296e+09
# HELP mysql_global_variables_innodb_numa_interleave Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_numa_interleave gauge
mysql_global_variables_innodb_numa_interleave 0
# HELP mysql_global_variables_innodb_old_blocks_pct Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_old_blocks_pct gauge
mysql_global_variables_innodb_old_blocks_pct 37
# HELP mysql_global_variables_innodb_old_blocks_time Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_old_blocks_time gauge
mysql_global_variables_innodb_old_blocks_time 1000
# HELP mysql_global_variables_innodb_online_alter_log_max_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_online_alter_log_max_size gauge
mysql_global_variables_innodb_online_alter_log_max_size 4.294967296e+09
# HELP mysql_global_variables_innodb_open_files Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_open_files gauge
mysql_global_variables_innodb_open_files 65535
# HELP mysql_global_variables_innodb_optimize_fulltext_only Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_optimize_fulltext_only gauge
mysql_global_variables_innodb_optimize_fulltext_only 0
# HELP mysql_global_variables_innodb_page_cleaners Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_page_cleaners gauge
mysql_global_variables_innodb_page_cleaners 1
# HELP mysql_global_variables_innodb_page_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_page_size gauge
mysql_global_variables_innodb_page_size 16384
# HELP mysql_global_variables_innodb_print_all_deadlocks Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_print_all_deadlocks gauge
mysql_global_variables_innodb_print_all_deadlocks 1
# HELP mysql_global_variables_innodb_purge_batch_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_purge_batch_size gauge
mysql_global_variables_innodb_purge_batch_size 300
# HELP mysql_global_variables_innodb_purge_rseg_truncate_frequency Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_purge_rseg_truncate_frequency gauge
mysql_global_variables_innodb_purge_rseg_truncate_frequency 128
# HELP mysql_global_variables_innodb_purge_threads Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_purge_threads gauge
mysql_global_variables_innodb_purge_threads 4
# HELP mysql_global_variables_innodb_random_read_ahead Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_random_read_ahead gauge
mysql_global_variables_innodb_random_read_ahead 0
# HELP mysql_global_variables_innodb_read_ahead_threshold Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_read_ahead_threshold gauge
mysql_global_variables_innodb_read_ahead_threshold 56
# HELP mysql_global_variables_innodb_read_io_threads Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_read_io_threads gauge
mysql_global_variables_innodb_read_io_threads 8
# HELP mysql_global_variables_innodb_read_only Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_read_only gauge
mysql_global_variables_innodb_read_only 0
# HELP mysql_global_variables_innodb_replication_delay Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_replication_delay gauge
mysql_global_variables_innodb_replication_delay 0
# HELP mysql_global_variables_innodb_rollback_on_timeout Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_rollback_on_timeout gauge
mysql_global_variables_innodb_rollback_on_timeout 1
# HELP mysql_global_variables_innodb_rollback_segments Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_rollback_segments gauge
mysql_global_variables_innodb_rollback_segments 128
# HELP mysql_global_variables_innodb_sort_buffer_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_sort_buffer_size gauge
mysql_global_variables_innodb_sort_buffer_size 1.048576e+06
# HELP mysql_global_variables_innodb_spin_wait_delay Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_spin_wait_delay gauge
mysql_global_variables_innodb_spin_wait_delay 30
# HELP mysql_global_variables_innodb_stats_auto_recalc Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_stats_auto_recalc gauge
mysql_global_variables_innodb_stats_auto_recalc 1
# HELP mysql_global_variables_innodb_stats_include_delete_marked Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_stats_include_delete_marked gauge
mysql_global_variables_innodb_stats_include_delete_marked 0
# HELP mysql_global_variables_innodb_stats_on_metadata Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_stats_on_metadata gauge
mysql_global_variables_innodb_stats_on_metadata 0
# HELP mysql_global_variables_innodb_stats_persistent Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_stats_persistent gauge
mysql_global_variables_innodb_stats_persistent 1
# HELP mysql_global_variables_innodb_stats_persistent_sample_pages Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_stats_persistent_sample_pages gauge
mysql_global_variables_innodb_stats_persistent_sample_pages 20
# HELP mysql_global_variables_innodb_stats_sample_pages Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_stats_sample_pages gauge
mysql_global_variables_innodb_stats_sample_pages 8
# HELP mysql_global_variables_innodb_stats_transient_sample_pages Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_stats_transient_sample_pages gauge
mysql_global_variables_innodb_stats_transient_sample_pages 8
# HELP mysql_global_variables_innodb_status_output Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_status_output gauge
mysql_global_variables_innodb_status_output 0
# HELP mysql_global_variables_innodb_status_output_locks Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_status_output_locks gauge
mysql_global_variables_innodb_status_output_locks 0
# HELP mysql_global_variables_innodb_strict_mode Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_strict_mode gauge
mysql_global_variables_innodb_strict_mode 1
# HELP mysql_global_variables_innodb_support_xa Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_support_xa gauge
mysql_global_variables_innodb_support_xa 1
# HELP mysql_global_variables_innodb_sync_array_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_sync_array_size gauge
mysql_global_variables_innodb_sync_array_size 1
# HELP mysql_global_variables_innodb_sync_spin_loops Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_sync_spin_loops gauge
mysql_global_variables_innodb_sync_spin_loops 100
# HELP mysql_global_variables_innodb_table_locks Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_table_locks gauge
mysql_global_variables_innodb_table_locks 1
# HELP mysql_global_variables_innodb_thread_concurrency Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_thread_concurrency gauge
mysql_global_variables_innodb_thread_concurrency 0
# HELP mysql_global_variables_innodb_thread_sleep_delay Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_thread_sleep_delay gauge
mysql_global_variables_innodb_thread_sleep_delay 10000
# HELP mysql_global_variables_innodb_undo_log_truncate Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_undo_log_truncate gauge
mysql_global_variables_innodb_undo_log_truncate 0
# HELP mysql_global_variables_innodb_undo_logs Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_undo_logs gauge
mysql_global_variables_innodb_undo_logs 128
# HELP mysql_global_variables_innodb_undo_tablespaces Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_undo_tablespaces gauge
mysql_global_variables_innodb_undo_tablespaces 0
# HELP mysql_global_variables_innodb_use_native_aio Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_use_native_aio gauge
mysql_global_variables_innodb_use_native_aio 1
# HELP mysql_global_variables_innodb_write_io_threads Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_innodb_write_io_threads gauge
mysql_global_variables_innodb_write_io_threads 8
# HELP mysql_global_variables_interactive_timeout Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_interactive_timeout gauge
mysql_global_variables_interactive_timeout 3.1536e+07
# HELP mysql_global_variables_join_buffer_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_join_buffer_size gauge
mysql_global_variables_join_buffer_size 4.194304e+06
# HELP mysql_global_variables_keep_files_on_create Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_keep_files_on_create gauge
mysql_global_variables_keep_files_on_create 0
# HELP mysql_global_variables_key_buffer_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_key_buffer_size gauge
mysql_global_variables_key_buffer_size 3.3554432e+07
# HELP mysql_global_variables_key_cache_age_threshold Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_key_cache_age_threshold gauge
mysql_global_variables_key_cache_age_threshold 300
# HELP mysql_global_variables_key_cache_block_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_key_cache_block_size gauge
mysql_global_variables_key_cache_block_size 1024
# HELP mysql_global_variables_key_cache_division_limit Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_key_cache_division_limit gauge
mysql_global_variables_key_cache_division_limit 100
# HELP mysql_global_variables_keyring_operations Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_keyring_operations gauge
mysql_global_variables_keyring_operations 1
# HELP mysql_global_variables_large_files_support Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_large_files_support gauge
mysql_global_variables_large_files_support 1
# HELP mysql_global_variables_large_page_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_large_page_size gauge
mysql_global_variables_large_page_size 0
# HELP mysql_global_variables_large_pages Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_large_pages gauge
mysql_global_variables_large_pages 0
# HELP mysql_global_variables_local_infile Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_local_infile gauge
mysql_global_variables_local_infile 1
# HELP mysql_global_variables_lock_wait_timeout Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_lock_wait_timeout gauge
mysql_global_variables_lock_wait_timeout 3600
# HELP mysql_global_variables_locked_in_memory Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_locked_in_memory gauge
mysql_global_variables_locked_in_memory 0
# HELP mysql_global_variables_log_bin Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_log_bin gauge
mysql_global_variables_log_bin 1
# HELP mysql_global_variables_log_bin_trust_function_creators Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_log_bin_trust_function_creators gauge
mysql_global_variables_log_bin_trust_function_creators 1
# HELP mysql_global_variables_log_bin_use_v1_row_events Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_log_bin_use_v1_row_events gauge
mysql_global_variables_log_bin_use_v1_row_events 0
# HELP mysql_global_variables_log_builtin_as_identified_by_password Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_log_builtin_as_identified_by_password gauge
mysql_global_variables_log_builtin_as_identified_by_password 0
# HELP mysql_global_variables_log_error_verbosity Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_log_error_verbosity gauge
mysql_global_variables_log_error_verbosity 3
# HELP mysql_global_variables_log_queries_not_using_indexes Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_log_queries_not_using_indexes gauge
mysql_global_variables_log_queries_not_using_indexes 0
# HELP mysql_global_variables_log_slave_updates Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_log_slave_updates gauge
mysql_global_variables_log_slave_updates 0
# HELP mysql_global_variables_log_slow_admin_statements Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_log_slow_admin_statements gauge
mysql_global_variables_log_slow_admin_statements 1
# HELP mysql_global_variables_log_slow_slave_statements Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_log_slow_slave_statements gauge
mysql_global_variables_log_slow_slave_statements 1
# HELP mysql_global_variables_log_statements_unsafe_for_binlog Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_log_statements_unsafe_for_binlog gauge
mysql_global_variables_log_statements_unsafe_for_binlog 1
# HELP mysql_global_variables_log_syslog Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_log_syslog gauge
mysql_global_variables_log_syslog 0
# HELP mysql_global_variables_log_syslog_include_pid Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_log_syslog_include_pid gauge
mysql_global_variables_log_syslog_include_pid 1
# HELP mysql_global_variables_log_throttle_queries_not_using_indexes Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_log_throttle_queries_not_using_indexes gauge
mysql_global_variables_log_throttle_queries_not_using_indexes 60
# HELP mysql_global_variables_log_warnings Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_log_warnings gauge
mysql_global_variables_log_warnings 2
# HELP mysql_global_variables_long_query_time Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_long_query_time gauge
mysql_global_variables_long_query_time 1
# HELP mysql_global_variables_low_priority_updates Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_low_priority_updates gauge
mysql_global_variables_low_priority_updates 0
# HELP mysql_global_variables_lower_case_file_system Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_lower_case_file_system gauge
mysql_global_variables_lower_case_file_system 0
# HELP mysql_global_variables_lower_case_table_names Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_lower_case_table_names gauge
mysql_global_variables_lower_case_table_names 1
# HELP mysql_global_variables_master_verify_checksum Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_master_verify_checksum gauge
mysql_global_variables_master_verify_checksum 0
# HELP mysql_global_variables_max_allowed_packet Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_max_allowed_packet gauge
mysql_global_variables_max_allowed_packet 3.3554432e+07
# HELP mysql_global_variables_max_binlog_cache_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_max_binlog_cache_size gauge
mysql_global_variables_max_binlog_cache_size 2.147483648e+09
# HELP mysql_global_variables_max_binlog_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_max_binlog_size gauge
mysql_global_variables_max_binlog_size 1.073741824e+09
# HELP mysql_global_variables_max_binlog_stmt_cache_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_max_binlog_stmt_cache_size gauge
mysql_global_variables_max_binlog_stmt_cache_size 1.8446744073709548e+19
# HELP mysql_global_variables_max_connect_errors Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_max_connect_errors gauge
mysql_global_variables_max_connect_errors 1e+06
# HELP mysql_global_variables_max_connections Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_max_connections gauge
mysql_global_variables_max_connections 3000
# HELP mysql_global_variables_max_delayed_threads Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_max_delayed_threads gauge
mysql_global_variables_max_delayed_threads 20
# HELP mysql_global_variables_max_digest_length Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_max_digest_length gauge
mysql_global_variables_max_digest_length 1024
# HELP mysql_global_variables_max_error_count Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_max_error_count gauge
mysql_global_variables_max_error_count 64
# HELP mysql_global_variables_max_execution_time Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_max_execution_time gauge
mysql_global_variables_max_execution_time 0
# HELP mysql_global_variables_max_heap_table_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_max_heap_table_size gauge
mysql_global_variables_max_heap_table_size 3.3554432e+07
# HELP mysql_global_variables_max_insert_delayed_threads Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_max_insert_delayed_threads gauge
mysql_global_variables_max_insert_delayed_threads 20
# HELP mysql_global_variables_max_join_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_max_join_size gauge
mysql_global_variables_max_join_size 1.8446744073709552e+19
# HELP mysql_global_variables_max_length_for_sort_data Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_max_length_for_sort_data gauge
mysql_global_variables_max_length_for_sort_data 1024
# HELP mysql_global_variables_max_points_in_geometry Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_max_points_in_geometry gauge
mysql_global_variables_max_points_in_geometry 65536
# HELP mysql_global_variables_max_prepared_stmt_count Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_max_prepared_stmt_count gauge
mysql_global_variables_max_prepared_stmt_count 16382
# HELP mysql_global_variables_max_relay_log_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_max_relay_log_size gauge
mysql_global_variables_max_relay_log_size 0
# HELP mysql_global_variables_max_seeks_for_key Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_max_seeks_for_key gauge
mysql_global_variables_max_seeks_for_key 1.8446744073709552e+19
# HELP mysql_global_variables_max_sort_length Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_max_sort_length gauge
mysql_global_variables_max_sort_length 1024
# HELP mysql_global_variables_max_sp_recursion_depth Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_max_sp_recursion_depth gauge
mysql_global_variables_max_sp_recursion_depth 0
# HELP mysql_global_variables_max_tmp_tables Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_max_tmp_tables gauge
mysql_global_variables_max_tmp_tables 32
# HELP mysql_global_variables_max_user_connections Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_max_user_connections gauge
mysql_global_variables_max_user_connections 0
# HELP mysql_global_variables_max_write_lock_count Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_max_write_lock_count gauge
mysql_global_variables_max_write_lock_count 1.8446744073709552e+19
# HELP mysql_global_variables_metadata_locks_cache_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_metadata_locks_cache_size gauge
mysql_global_variables_metadata_locks_cache_size 1024
# HELP mysql_global_variables_metadata_locks_hash_instances Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_metadata_locks_hash_instances gauge
mysql_global_variables_metadata_locks_hash_instances 8
# HELP mysql_global_variables_min_examined_row_limit Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_min_examined_row_limit gauge
mysql_global_variables_min_examined_row_limit 100
# HELP mysql_global_variables_multi_range_count Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_multi_range_count gauge
mysql_global_variables_multi_range_count 256
# HELP mysql_global_variables_myisam_data_pointer_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_myisam_data_pointer_size gauge
mysql_global_variables_myisam_data_pointer_size 6
# HELP mysql_global_variables_myisam_max_sort_file_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_myisam_max_sort_file_size gauge
mysql_global_variables_myisam_max_sort_file_size 1.073741824e+10
# HELP mysql_global_variables_myisam_mmap_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_myisam_mmap_size gauge
mysql_global_variables_myisam_mmap_size 1.8446744073709552e+19
# HELP mysql_global_variables_myisam_recover_options Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_myisam_recover_options gauge
mysql_global_variables_myisam_recover_options 0
# HELP mysql_global_variables_myisam_repair_threads Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_myisam_repair_threads gauge
mysql_global_variables_myisam_repair_threads 1
# HELP mysql_global_variables_myisam_sort_buffer_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_myisam_sort_buffer_size gauge
mysql_global_variables_myisam_sort_buffer_size 1.34217728e+08
# HELP mysql_global_variables_myisam_use_mmap Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_myisam_use_mmap gauge
mysql_global_variables_myisam_use_mmap 0
# HELP mysql_global_variables_mysql_native_password_proxy_users Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_mysql_native_password_proxy_users gauge
mysql_global_variables_mysql_native_password_proxy_users 0
# HELP mysql_global_variables_net_buffer_length Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_net_buffer_length gauge
mysql_global_variables_net_buffer_length 16384
# HELP mysql_global_variables_net_read_timeout Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_net_read_timeout gauge
mysql_global_variables_net_read_timeout 30
# HELP mysql_global_variables_net_retry_count Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_net_retry_count gauge
mysql_global_variables_net_retry_count 10
# HELP mysql_global_variables_net_write_timeout Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_net_write_timeout gauge
mysql_global_variables_net_write_timeout 60
# HELP mysql_global_variables_new Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_new gauge
mysql_global_variables_new 0
# HELP mysql_global_variables_ngram_token_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_ngram_token_size gauge
mysql_global_variables_ngram_token_size 2
# HELP mysql_global_variables_offline_mode Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_offline_mode gauge
mysql_global_variables_offline_mode 0
# HELP mysql_global_variables_old Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_old gauge
mysql_global_variables_old 0
# HELP mysql_global_variables_old_alter_table Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_old_alter_table gauge
mysql_global_variables_old_alter_table 0
# HELP mysql_global_variables_old_passwords Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_old_passwords gauge
mysql_global_variables_old_passwords 0
# HELP mysql_global_variables_open_files_limit Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_open_files_limit gauge
mysql_global_variables_open_files_limit 65535
# HELP mysql_global_variables_optimizer_prune_level Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_optimizer_prune_level gauge
mysql_global_variables_optimizer_prune_level 1
# HELP mysql_global_variables_optimizer_search_depth Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_optimizer_search_depth gauge
mysql_global_variables_optimizer_search_depth 62
# HELP mysql_global_variables_optimizer_trace_limit Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_optimizer_trace_limit gauge
mysql_global_variables_optimizer_trace_limit 1
# HELP mysql_global_variables_optimizer_trace_max_mem_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_optimizer_trace_max_mem_size gauge
mysql_global_variables_optimizer_trace_max_mem_size 16384
# HELP mysql_global_variables_optimizer_trace_offset Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_optimizer_trace_offset gauge
mysql_global_variables_optimizer_trace_offset -1
# HELP mysql_global_variables_parser_max_mem_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_parser_max_mem_size gauge
mysql_global_variables_parser_max_mem_size 1.8446744073709552e+19
# HELP mysql_global_variables_performance_schema Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema gauge
mysql_global_variables_performance_schema 1
# HELP mysql_global_variables_performance_schema_accounts_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_accounts_size gauge
mysql_global_variables_performance_schema_accounts_size -1
# HELP mysql_global_variables_performance_schema_digests_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_digests_size gauge
mysql_global_variables_performance_schema_digests_size 10000
# HELP mysql_global_variables_performance_schema_events_stages_history_long_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_events_stages_history_long_size gauge
mysql_global_variables_performance_schema_events_stages_history_long_size 10000
# HELP mysql_global_variables_performance_schema_events_stages_history_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_events_stages_history_size gauge
mysql_global_variables_performance_schema_events_stages_history_size 10
# HELP mysql_global_variables_performance_schema_events_statements_history_long_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_events_statements_history_long_size gauge
mysql_global_variables_performance_schema_events_statements_history_long_size 10000
# HELP mysql_global_variables_performance_schema_events_statements_history_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_events_statements_history_size gauge
mysql_global_variables_performance_schema_events_statements_history_size 10
# HELP mysql_global_variables_performance_schema_events_transactions_history_long_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_events_transactions_history_long_size gauge
mysql_global_variables_performance_schema_events_transactions_history_long_size 10000
# HELP mysql_global_variables_performance_schema_events_transactions_history_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_events_transactions_history_size gauge
mysql_global_variables_performance_schema_events_transactions_history_size 10
# HELP mysql_global_variables_performance_schema_events_waits_history_long_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_events_waits_history_long_size gauge
mysql_global_variables_performance_schema_events_waits_history_long_size 10000
# HELP mysql_global_variables_performance_schema_events_waits_history_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_events_waits_history_size gauge
mysql_global_variables_performance_schema_events_waits_history_size 10
# HELP mysql_global_variables_performance_schema_hosts_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_hosts_size gauge
mysql_global_variables_performance_schema_hosts_size -1
# HELP mysql_global_variables_performance_schema_max_cond_classes Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_max_cond_classes gauge
mysql_global_variables_performance_schema_max_cond_classes 80
# HELP mysql_global_variables_performance_schema_max_cond_instances Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_max_cond_instances gauge
mysql_global_variables_performance_schema_max_cond_instances -1
# HELP mysql_global_variables_performance_schema_max_digest_length Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_max_digest_length gauge
mysql_global_variables_performance_schema_max_digest_length 1024
# HELP mysql_global_variables_performance_schema_max_file_classes Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_max_file_classes gauge
mysql_global_variables_performance_schema_max_file_classes 80
# HELP mysql_global_variables_performance_schema_max_file_handles Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_max_file_handles gauge
mysql_global_variables_performance_schema_max_file_handles 32768
# HELP mysql_global_variables_performance_schema_max_file_instances Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_max_file_instances gauge
mysql_global_variables_performance_schema_max_file_instances -1
# HELP mysql_global_variables_performance_schema_max_index_stat Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_max_index_stat gauge
mysql_global_variables_performance_schema_max_index_stat -1
# HELP mysql_global_variables_performance_schema_max_memory_classes Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_max_memory_classes gauge
mysql_global_variables_performance_schema_max_memory_classes 320
# HELP mysql_global_variables_performance_schema_max_metadata_locks Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_max_metadata_locks gauge
mysql_global_variables_performance_schema_max_metadata_locks -1
# HELP mysql_global_variables_performance_schema_max_mutex_classes Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_max_mutex_classes gauge
mysql_global_variables_performance_schema_max_mutex_classes 210
# HELP mysql_global_variables_performance_schema_max_mutex_instances Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_max_mutex_instances gauge
mysql_global_variables_performance_schema_max_mutex_instances -1
# HELP mysql_global_variables_performance_schema_max_prepared_statements_instances Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_max_prepared_statements_instances gauge
mysql_global_variables_performance_schema_max_prepared_statements_instances -1
# HELP mysql_global_variables_performance_schema_max_program_instances Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_max_program_instances gauge
mysql_global_variables_performance_schema_max_program_instances -1
# HELP mysql_global_variables_performance_schema_max_rwlock_classes Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_max_rwlock_classes gauge
mysql_global_variables_performance_schema_max_rwlock_classes 50
# HELP mysql_global_variables_performance_schema_max_rwlock_instances Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_max_rwlock_instances gauge
mysql_global_variables_performance_schema_max_rwlock_instances -1
# HELP mysql_global_variables_performance_schema_max_socket_classes Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_max_socket_classes gauge
mysql_global_variables_performance_schema_max_socket_classes 10
# HELP mysql_global_variables_performance_schema_max_socket_instances Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_max_socket_instances gauge
mysql_global_variables_performance_schema_max_socket_instances -1
# HELP mysql_global_variables_performance_schema_max_sql_text_length Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_max_sql_text_length gauge
mysql_global_variables_performance_schema_max_sql_text_length 1024
# HELP mysql_global_variables_performance_schema_max_stage_classes Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_max_stage_classes gauge
mysql_global_variables_performance_schema_max_stage_classes 150
# HELP mysql_global_variables_performance_schema_max_statement_classes Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_max_statement_classes gauge
mysql_global_variables_performance_schema_max_statement_classes 193
# HELP mysql_global_variables_performance_schema_max_statement_stack Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_max_statement_stack gauge
mysql_global_variables_performance_schema_max_statement_stack 10
# HELP mysql_global_variables_performance_schema_max_table_handles Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_max_table_handles gauge
mysql_global_variables_performance_schema_max_table_handles -1
# HELP mysql_global_variables_performance_schema_max_table_instances Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_max_table_instances gauge
mysql_global_variables_performance_schema_max_table_instances -1
# HELP mysql_global_variables_performance_schema_max_table_lock_stat Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_max_table_lock_stat gauge
mysql_global_variables_performance_schema_max_table_lock_stat -1
# HELP mysql_global_variables_performance_schema_max_thread_classes Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_max_thread_classes gauge
mysql_global_variables_performance_schema_max_thread_classes 50
# HELP mysql_global_variables_performance_schema_max_thread_instances Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_max_thread_instances gauge
mysql_global_variables_performance_schema_max_thread_instances -1
# HELP mysql_global_variables_performance_schema_session_connect_attrs_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_session_connect_attrs_size gauge
mysql_global_variables_performance_schema_session_connect_attrs_size 512
# HELP mysql_global_variables_performance_schema_setup_actors_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_setup_actors_size gauge
mysql_global_variables_performance_schema_setup_actors_size -1
# HELP mysql_global_variables_performance_schema_setup_objects_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_setup_objects_size gauge
mysql_global_variables_performance_schema_setup_objects_size -1
# HELP mysql_global_variables_performance_schema_users_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_performance_schema_users_size gauge
mysql_global_variables_performance_schema_users_size -1
# HELP mysql_global_variables_port Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_port gauge
mysql_global_variables_port 3306
# HELP mysql_global_variables_preload_buffer_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_preload_buffer_size gauge
mysql_global_variables_preload_buffer_size 32768
# HELP mysql_global_variables_profiling Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_profiling gauge
mysql_global_variables_profiling 0
# HELP mysql_global_variables_profiling_history_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_profiling_history_size gauge
mysql_global_variables_profiling_history_size 15
# HELP mysql_global_variables_protocol_version Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_protocol_version gauge
mysql_global_variables_protocol_version 10
# HELP mysql_global_variables_query_alloc_block_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_query_alloc_block_size gauge
mysql_global_variables_query_alloc_block_size 8192
# HELP mysql_global_variables_query_cache_limit Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_query_cache_limit gauge
mysql_global_variables_query_cache_limit 1.048576e+06
# HELP mysql_global_variables_query_cache_min_res_unit Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_query_cache_min_res_unit gauge
mysql_global_variables_query_cache_min_res_unit 4096
# HELP mysql_global_variables_query_cache_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_query_cache_size gauge
mysql_global_variables_query_cache_size 0
# HELP mysql_global_variables_query_cache_type Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_query_cache_type gauge
mysql_global_variables_query_cache_type 0
# HELP mysql_global_variables_query_cache_wlock_invalidate Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_query_cache_wlock_invalidate gauge
mysql_global_variables_query_cache_wlock_invalidate 0
# HELP mysql_global_variables_query_prealloc_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_query_prealloc_size gauge
mysql_global_variables_query_prealloc_size 8192
# HELP mysql_global_variables_range_alloc_block_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_range_alloc_block_size gauge
mysql_global_variables_range_alloc_block_size 4096
# HELP mysql_global_variables_range_optimizer_max_mem_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_range_optimizer_max_mem_size gauge
mysql_global_variables_range_optimizer_max_mem_size 8.388608e+06
# HELP mysql_global_variables_read_buffer_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_read_buffer_size gauge
mysql_global_variables_read_buffer_size 8.388608e+06
# HELP mysql_global_variables_read_only Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_read_only gauge
mysql_global_variables_read_only 0
# HELP mysql_global_variables_read_rnd_buffer_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_read_rnd_buffer_size gauge
mysql_global_variables_read_rnd_buffer_size 4.194304e+06
# HELP mysql_global_variables_relay_log_purge Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_relay_log_purge gauge
mysql_global_variables_relay_log_purge 1
# HELP mysql_global_variables_relay_log_recovery Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_relay_log_recovery gauge
mysql_global_variables_relay_log_recovery 0
# HELP mysql_global_variables_relay_log_space_limit Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_relay_log_space_limit gauge
mysql_global_variables_relay_log_space_limit 0
# HELP mysql_global_variables_replication_optimize_for_static_plugin_config Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_replication_optimize_for_static_plugin_config gauge
mysql_global_variables_replication_optimize_for_static_plugin_config 0
# HELP mysql_global_variables_replication_sender_observe_commit_only Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_replication_sender_observe_commit_only gauge
mysql_global_variables_replication_sender_observe_commit_only 0
# HELP mysql_global_variables_report_port Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_report_port gauge
mysql_global_variables_report_port 3306
# HELP mysql_global_variables_require_secure_transport Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_require_secure_transport gauge
mysql_global_variables_require_secure_transport 0
# HELP mysql_global_variables_rpl_stop_slave_timeout Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_rpl_stop_slave_timeout gauge
mysql_global_variables_rpl_stop_slave_timeout 3.1536e+07
# HELP mysql_global_variables_secure_auth Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_secure_auth gauge
mysql_global_variables_secure_auth 1
# HELP mysql_global_variables_server_id Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_server_id gauge
mysql_global_variables_server_id 330607
# HELP mysql_global_variables_server_id_bits Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_server_id_bits gauge
mysql_global_variables_server_id_bits 32
# HELP mysql_global_variables_session_track_gtids Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_session_track_gtids gauge
mysql_global_variables_session_track_gtids 0
# HELP mysql_global_variables_session_track_schema Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_session_track_schema gauge
mysql_global_variables_session_track_schema 1
# HELP mysql_global_variables_session_track_state_change Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_session_track_state_change gauge
mysql_global_variables_session_track_state_change 0
# HELP mysql_global_variables_session_track_transaction_info Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_session_track_transaction_info gauge
mysql_global_variables_session_track_transaction_info 0
# HELP mysql_global_variables_sha256_password_auto_generate_rsa_keys Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_sha256_password_auto_generate_rsa_keys gauge
mysql_global_variables_sha256_password_auto_generate_rsa_keys 1
# HELP mysql_global_variables_sha256_password_proxy_users Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_sha256_password_proxy_users gauge
mysql_global_variables_sha256_password_proxy_users 0
# HELP mysql_global_variables_show_compatibility_56 Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_show_compatibility_56 gauge
mysql_global_variables_show_compatibility_56 0
# HELP mysql_global_variables_show_create_table_verbosity Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_show_create_table_verbosity gauge
mysql_global_variables_show_create_table_verbosity 0
# HELP mysql_global_variables_show_old_temporals Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_show_old_temporals gauge
mysql_global_variables_show_old_temporals 0
# HELP mysql_global_variables_skip_external_locking Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_skip_external_locking gauge
mysql_global_variables_skip_external_locking 1
# HELP mysql_global_variables_skip_name_resolve Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_skip_name_resolve gauge
mysql_global_variables_skip_name_resolve 1
# HELP mysql_global_variables_skip_networking Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_skip_networking gauge
mysql_global_variables_skip_networking 0
# HELP mysql_global_variables_skip_show_database Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_skip_show_database gauge
mysql_global_variables_skip_show_database 0
# HELP mysql_global_variables_slave_allow_batching Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_slave_allow_batching gauge
mysql_global_variables_slave_allow_batching 0
# HELP mysql_global_variables_slave_checkpoint_group Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_slave_checkpoint_group gauge
mysql_global_variables_slave_checkpoint_group 512
# HELP mysql_global_variables_slave_checkpoint_period Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_slave_checkpoint_period gauge
mysql_global_variables_slave_checkpoint_period 300
# HELP mysql_global_variables_slave_compressed_protocol Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_slave_compressed_protocol gauge
mysql_global_variables_slave_compressed_protocol 0
# HELP mysql_global_variables_slave_max_allowed_packet Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_slave_max_allowed_packet gauge
mysql_global_variables_slave_max_allowed_packet 1.073741824e+09
# HELP mysql_global_variables_slave_net_timeout Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_slave_net_timeout gauge
mysql_global_variables_slave_net_timeout 60
# HELP mysql_global_variables_slave_parallel_workers Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_slave_parallel_workers gauge
mysql_global_variables_slave_parallel_workers 0
# HELP mysql_global_variables_slave_pending_jobs_size_max Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_slave_pending_jobs_size_max gauge
mysql_global_variables_slave_pending_jobs_size_max 1.6777216e+07
# HELP mysql_global_variables_slave_preserve_commit_order Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_slave_preserve_commit_order gauge
mysql_global_variables_slave_preserve_commit_order 0
# HELP mysql_global_variables_slave_skip_errors Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_slave_skip_errors gauge
mysql_global_variables_slave_skip_errors 0
# HELP mysql_global_variables_slave_sql_verify_checksum Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_slave_sql_verify_checksum gauge
mysql_global_variables_slave_sql_verify_checksum 1
# HELP mysql_global_variables_slave_transaction_retries Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_slave_transaction_retries gauge
mysql_global_variables_slave_transaction_retries 10
# HELP mysql_global_variables_slow_launch_time Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_slow_launch_time gauge
mysql_global_variables_slow_launch_time 2
# HELP mysql_global_variables_slow_query_log Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_slow_query_log gauge
mysql_global_variables_slow_query_log 1
# HELP mysql_global_variables_sort_buffer_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_sort_buffer_size gauge
mysql_global_variables_sort_buffer_size 4.194304e+06
# HELP mysql_global_variables_sql_auto_is_null Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_sql_auto_is_null gauge
mysql_global_variables_sql_auto_is_null 0
# HELP mysql_global_variables_sql_big_selects Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_sql_big_selects gauge
mysql_global_variables_sql_big_selects 1
# HELP mysql_global_variables_sql_buffer_result Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_sql_buffer_result gauge
mysql_global_variables_sql_buffer_result 0
# HELP mysql_global_variables_sql_log_off Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_sql_log_off gauge
mysql_global_variables_sql_log_off 0
# HELP mysql_global_variables_sql_notes Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_sql_notes gauge
mysql_global_variables_sql_notes 1
# HELP mysql_global_variables_sql_quote_show_create Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_sql_quote_show_create gauge
mysql_global_variables_sql_quote_show_create 1
# HELP mysql_global_variables_sql_safe_updates Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_sql_safe_updates gauge
mysql_global_variables_sql_safe_updates 0
# HELP mysql_global_variables_sql_select_limit Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_sql_select_limit gauge
mysql_global_variables_sql_select_limit 1.8446744073709552e+19
# HELP mysql_global_variables_sql_slave_skip_counter Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_sql_slave_skip_counter gauge
mysql_global_variables_sql_slave_skip_counter 0
# HELP mysql_global_variables_sql_warnings Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_sql_warnings gauge
mysql_global_variables_sql_warnings 0
# HELP mysql_global_variables_stored_program_cache Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_stored_program_cache gauge
mysql_global_variables_stored_program_cache 256
# HELP mysql_global_variables_super_read_only Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_super_read_only gauge
mysql_global_variables_super_read_only 0
# HELP mysql_global_variables_sync_binlog Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_sync_binlog gauge
mysql_global_variables_sync_binlog 0
# HELP mysql_global_variables_sync_frm Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_sync_frm gauge
mysql_global_variables_sync_frm 1
# HELP mysql_global_variables_sync_master_info Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_sync_master_info gauge
mysql_global_variables_sync_master_info 10000
# HELP mysql_global_variables_sync_relay_log Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_sync_relay_log gauge
mysql_global_variables_sync_relay_log 10000
# HELP mysql_global_variables_sync_relay_log_info Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_sync_relay_log_info gauge
mysql_global_variables_sync_relay_log_info 10000
# HELP mysql_global_variables_table_definition_cache Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_table_definition_cache gauge
mysql_global_variables_table_definition_cache 1024
# HELP mysql_global_variables_table_open_cache Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_table_open_cache gauge
mysql_global_variables_table_open_cache 1024
# HELP mysql_global_variables_table_open_cache_instances Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_table_open_cache_instances gauge
mysql_global_variables_table_open_cache_instances 64
# HELP mysql_global_variables_thread_cache_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_thread_cache_size gauge
mysql_global_variables_thread_cache_size 768
# HELP mysql_global_variables_thread_stack Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_thread_stack gauge
mysql_global_variables_thread_stack 524288
# HELP mysql_global_variables_tmp_table_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_tmp_table_size gauge
mysql_global_variables_tmp_table_size 3.3554432e+07
# HELP mysql_global_variables_transaction_alloc_block_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_transaction_alloc_block_size gauge
mysql_global_variables_transaction_alloc_block_size 8192
# HELP mysql_global_variables_transaction_prealloc_size Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_transaction_prealloc_size gauge
mysql_global_variables_transaction_prealloc_size 4096
# HELP mysql_global_variables_transaction_read_only Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_transaction_read_only gauge
mysql_global_variables_transaction_read_only 0
# HELP mysql_global_variables_transaction_write_set_extraction Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_transaction_write_set_extraction gauge
mysql_global_variables_transaction_write_set_extraction 0
# HELP mysql_global_variables_tx_read_only Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_tx_read_only gauge
mysql_global_variables_tx_read_only 0
# HELP mysql_global_variables_unique_checks Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_unique_checks gauge
mysql_global_variables_unique_checks 1
# HELP mysql_global_variables_updatable_views_with_limit Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_updatable_views_with_limit gauge
mysql_global_variables_updatable_views_with_limit 1
# HELP mysql_global_variables_wait_timeout Generic gauge metric from SHOW GLOBAL VARIABLES.
# TYPE mysql_global_variables_wait_timeout gauge
mysql_global_variables_wait_timeout 3.1536e+07
# HELP mysql_info_schema_innodb_cmp_compress_ops_ok_total Number of times a B-tree page of the size PAGE_SIZE has been successfully compressed.
# TYPE mysql_info_schema_innodb_cmp_compress_ops_ok_total counter
mysql_info_schema_innodb_cmp_compress_ops_ok_total{page_size="1024"} 0
mysql_info_schema_innodb_cmp_compress_ops_ok_total{page_size="16384"} 0
mysql_info_schema_innodb_cmp_compress_ops_ok_total{page_size="2048"} 0
mysql_info_schema_innodb_cmp_compress_ops_ok_total{page_size="4096"} 0
mysql_info_schema_innodb_cmp_compress_ops_ok_total{page_size="8192"} 0
# HELP mysql_info_schema_innodb_cmp_compress_ops_total Number of times a B-tree page of the size PAGE_SIZE has been compressed.
# TYPE mysql_info_schema_innodb_cmp_compress_ops_total counter
mysql_info_schema_innodb_cmp_compress_ops_total{page_size="1024"} 0
mysql_info_schema_innodb_cmp_compress_ops_total{page_size="16384"} 0
mysql_info_schema_innodb_cmp_compress_ops_total{page_size="2048"} 0
mysql_info_schema_innodb_cmp_compress_ops_total{page_size="4096"} 0
mysql_info_schema_innodb_cmp_compress_ops_total{page_size="8192"} 0
# HELP mysql_info_schema_innodb_cmp_compress_time_seconds_total Total time in seconds spent in attempts to compress B-tree pages.
# TYPE mysql_info_schema_innodb_cmp_compress_time_seconds_total counter
mysql_info_schema_innodb_cmp_compress_time_seconds_total{page_size="1024"} 0
mysql_info_schema_innodb_cmp_compress_time_seconds_total{page_size="16384"} 0
mysql_info_schema_innodb_cmp_compress_time_seconds_total{page_size="2048"} 0
mysql_info_schema_innodb_cmp_compress_time_seconds_total{page_size="4096"} 0
mysql_info_schema_innodb_cmp_compress_time_seconds_total{page_size="8192"} 0
# HELP mysql_info_schema_innodb_cmp_uncompress_ops_total Number of times a B-tree page of the size PAGE_SIZE has been uncompressed.
# TYPE mysql_info_schema_innodb_cmp_uncompress_ops_total counter
mysql_info_schema_innodb_cmp_uncompress_ops_total{page_size="1024"} 0
mysql_info_schema_innodb_cmp_uncompress_ops_total{page_size="16384"} 0
mysql_info_schema_innodb_cmp_uncompress_ops_total{page_size="2048"} 0
mysql_info_schema_innodb_cmp_uncompress_ops_total{page_size="4096"} 0
mysql_info_schema_innodb_cmp_uncompress_ops_total{page_size="8192"} 0
# HELP mysql_info_schema_innodb_cmp_uncompress_time_seconds_total Total time in seconds spent in uncompressing B-tree pages.
# TYPE mysql_info_schema_innodb_cmp_uncompress_time_seconds_total counter
mysql_info_schema_innodb_cmp_uncompress_time_seconds_total{page_size="1024"} 0
mysql_info_schema_innodb_cmp_uncompress_time_seconds_total{page_size="16384"} 0
mysql_info_schema_innodb_cmp_uncompress_time_seconds_total{page_size="2048"} 0
mysql_info_schema_innodb_cmp_uncompress_time_seconds_total{page_size="4096"} 0
mysql_info_schema_innodb_cmp_uncompress_time_seconds_total{page_size="8192"} 0
# HELP mysql_info_schema_innodb_cmpmem_pages_free_total Number of blocks of the size PAGE_SIZE that are currently available for allocation.
# TYPE mysql_info_schema_innodb_cmpmem_pages_free_total counter
mysql_info_schema_innodb_cmpmem_pages_free_total{buffer_pool="0",page_size="1024"} 0
mysql_info_schema_innodb_cmpmem_pages_free_total{buffer_pool="0",page_size="16384"} 0
mysql_info_schema_innodb_cmpmem_pages_free_total{buffer_pool="0",page_size="2048"} 0
mysql_info_schema_innodb_cmpmem_pages_free_total{buffer_pool="0",page_size="4096"} 0
mysql_info_schema_innodb_cmpmem_pages_free_total{buffer_pool="0",page_size="8192"} 0
# HELP mysql_info_schema_innodb_cmpmem_pages_used_total Number of blocks of the size PAGE_SIZE that are currently in use.
# TYPE mysql_info_schema_innodb_cmpmem_pages_used_total counter
mysql_info_schema_innodb_cmpmem_pages_used_total{buffer_pool="0",page_size="1024"} 0
mysql_info_schema_innodb_cmpmem_pages_used_total{buffer_pool="0",page_size="16384"} 0
mysql_info_schema_innodb_cmpmem_pages_used_total{buffer_pool="0",page_size="2048"} 0
mysql_info_schema_innodb_cmpmem_pages_used_total{buffer_pool="0",page_size="4096"} 0
mysql_info_schema_innodb_cmpmem_pages_used_total{buffer_pool="0",page_size="8192"} 0
# HELP mysql_info_schema_innodb_cmpmem_relocation_ops_total Number of times a block of the size PAGE_SIZE has been relocated.
# TYPE mysql_info_schema_innodb_cmpmem_relocation_ops_total counter
mysql_info_schema_innodb_cmpmem_relocation_ops_total{buffer_pool="0",page_size="1024"} 0
mysql_info_schema_innodb_cmpmem_relocation_ops_total{buffer_pool="0",page_size="16384"} 0
mysql_info_schema_innodb_cmpmem_relocation_ops_total{buffer_pool="0",page_size="2048"} 0
mysql_info_schema_innodb_cmpmem_relocation_ops_total{buffer_pool="0",page_size="4096"} 0
mysql_info_schema_innodb_cmpmem_relocation_ops_total{buffer_pool="0",page_size="8192"} 0
# HELP mysql_info_schema_innodb_cmpmem_relocation_time_seconds_total Total time in seconds spent in relocating blocks.
# TYPE mysql_info_schema_innodb_cmpmem_relocation_time_seconds_total counter
mysql_info_schema_innodb_cmpmem_relocation_time_seconds_total{buffer_pool="0",page_size="1024"} 0
mysql_info_schema_innodb_cmpmem_relocation_time_seconds_total{buffer_pool="0",page_size="16384"} 0
mysql_info_schema_innodb_cmpmem_relocation_time_seconds_total{buffer_pool="0",page_size="2048"} 0
mysql_info_schema_innodb_cmpmem_relocation_time_seconds_total{buffer_pool="0",page_size="4096"} 0
mysql_info_schema_innodb_cmpmem_relocation_time_seconds_total{buffer_pool="0",page_size="8192"} 0
# HELP mysql_info_schema_processlist_processes_by_host The number of processes by host.
# TYPE mysql_info_schema_processlist_processes_by_host gauge
mysql_info_schema_processlist_processes_by_host{client_host="localhost"} 1
# HELP mysql_info_schema_processlist_processes_by_user The number of processes by user.
# TYPE mysql_info_schema_processlist_processes_by_user gauge
mysql_info_schema_processlist_processes_by_user{mysql_user="event_scheduler"} 1
# HELP mysql_info_schema_processlist_seconds The number of seconds threads have used split by current state.
# TYPE mysql_info_schema_processlist_seconds gauge
mysql_info_schema_processlist_seconds{command="daemon",state="waiting_for_next_activation"} 2864
# HELP mysql_info_schema_processlist_threads The number of threads split by current state.
# TYPE mysql_info_schema_processlist_threads gauge
mysql_info_schema_processlist_threads{command="daemon",state="waiting_for_next_activation"} 1
# HELP mysql_transaction_isolation MySQL transaction isolation.
# TYPE mysql_transaction_isolation gauge
mysql_transaction_isolation{level="READ-COMMITTED"} 1
# HELP mysql_up Whether the MySQL server is up.
# TYPE mysql_up gauge
mysql_up 1
# HELP mysql_version_info MySQL version and distribution.
# TYPE mysql_version_info gauge
mysql_version_info{innodb_version="5.7.36",version="5.7.36-log",version_comment="MySQL Community Server (GPL)"} 1