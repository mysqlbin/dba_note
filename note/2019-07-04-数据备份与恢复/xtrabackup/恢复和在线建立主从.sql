
1. 数据恢复
2. 在线建立主从
3. copy-back 的信息
4. 观察数据恢复之后启动MySQL的错误日志



1. 数据恢复

	如果需要用备份文件来恢复数据库， 只需要指定 --copy-back 和备份数据所在目录即可

	1. 需要恢复的地方MySQL需要关闭
		执行 ps aux|grep mysqld 命令检查
		
	2. datadir 即 数据目录需要为空

	3. 手工把 apply 之后的备份文件 copy 过去
		scp backup.zip 192.168.1.29:/data/ 
		[root@env backup]# ls -lht
		total 1.2G
		-rw-r--r-- 1 root root 8.1M Mar 17  2020 percona-xtrabackup-24-2.4.9-1.el6.x86_64.rpm
		-rw-r--r-- 1 root root 1.2G Mar 16 06:00 backup.zip

	4. copy back
		time innobackupex --copy-back  /data/2020-03-15_19-46-09 

	5. 更改 copy 过去的权限
		chown -R mysql:mysql /data/mysql/mysql3306/data 
		
		
	6. 启动 MySQL 

		/usr/local/mysql/bin/mysqld --defaults-file=/etc/my.cnf  &
		
	7. 确认MySQL启动成功
		ps aux|grep mysqld 
		看错误日志

2. copy-back 的信息
	[root@env data]# time innobackupex --copy-back  /data/2020-03-15_19-46-09
	200317 16:16:48 innobackupex: Starting the copy-back operation

	IMPORTANT: Please check that the copy-back run completes successfully.
			   At the end of a successful copy-back run innobackupex
			   prints "completed OK!".

	innobackupex version 2.4.9 based on MySQL server 5.7.13 Linux (x86_64) (revision id: a467167cdd4)
	200317 16:16:48 [01] Copying ib_logfile0 to /data/mysql/mysql3306/data/ib_logfile0
	200317 16:16:50 [01]        ...done
	200317 16:16:52 [01] Copying ib_logfile1 to /data/mysql/mysql3306/data/ib_logfile1
	200317 16:16:53 [01]        ...done
	200317 16:16:55 [01] Copying ib_logfile2 to /data/mysql/mysql3306/data/ib_logfile2
	200317 16:16:57 [01]        ...done
	200317 16:16:58 [01] Copying ibdata1 to /data/mysql/mysql3306/data/ibdata1
	200317 16:17:51 [01]        ...done
	200317 16:18:01 [01] Copying ./mysql/plugin.ibd to /data/mysql/mysql3306/data/mysql/plugin.ibd
	200317 16:18:01 [01]        ...done
	200317 16:18:01 [01] Copying ./mysql/servers.ibd to /data/mysql/mysql3306/data/mysql/servers.ibd
	200317 16:18:01 [01]        ...done
	200317 16:18:01 [01] Copying ./mysql/help_topic.ibd to /data/mysql/mysql3306/data/mysql/help_topic.ibd
	200317 16:18:01 [01]        ...done
	200317 16:18:01 [01] Copying ./mysql/help_category.ibd to /data/mysql/mysql3306/data/mysql/help_category.ibd
	200317 16:18:01 [01]        ...done
	200317 16:18:01 [01] Copying ./mysql/help_relation.ibd to /data/mysql/mysql3306/data/mysql/help_relation.ibd
	200317 16:18:01 [01]        ...done
	200317 16:18:01 [01] Copying ./mysql/help_keyword.ibd to /data/mysql/mysql3306/data/mysql/help_keyword.ibd
	200317 16:18:01 [01]        ...done
	200317 16:18:01 [01] Copying ./mysql/time_zone_name.ibd to /data/mysql/mysql3306/data/mysql/time_zone_name.ibd
	200317 16:18:01 [01]        ...done
	200317 16:18:01 [01] Copying ./mysql/time_zone.ibd to /data/mysql/mysql3306/data/mysql/time_zone.ibd
	200317 16:18:01 [01]        ...done
	200317 16:18:01 [01] Copying ./mysql/time_zone_transition.ibd to /data/mysql/mysql3306/data/mysql/time_zone_transition.ibd
	200317 16:18:01 [01]        ...done
	200317 16:18:01 [01] Copying ./mysql/time_zone_transition_type.ibd to /data/mysql/mysql3306/data/mysql/time_zone_transition_type.ibd
	200317 16:18:01 [01]        ...done
	200317 16:18:01 [01] Copying ./mysql/time_zone_leap_second.ibd to /data/mysql/mysql3306/data/mysql/time_zone_leap_second.ibd
	200317 16:18:01 [01]        ...done
	200317 16:18:01 [01] Copying ./mysql/innodb_table_stats.ibd to /data/mysql/mysql3306/data/mysql/innodb_table_stats.ibd
	200317 16:18:01 [01]        ...done
	200317 16:18:01 [01] Copying ./mysql/innodb_index_stats.ibd to /data/mysql/mysql3306/data/mysql/innodb_index_stats.ibd
	200317 16:18:01 [01]        ...done
	200317 16:18:01 [01] Copying ./mysql/slave_relay_log_info.ibd to /data/mysql/mysql3306/data/mysql/slave_relay_log_info.ibd
	200317 16:18:01 [01]        ...done
	200317 16:18:01 [01] Copying ./mysql/slave_master_info.ibd to /data/mysql/mysql3306/data/mysql/slave_master_info.ibd
	200317 16:18:01 [01]        ...done
	200317 16:18:01 [01] Copying ./mysql/slave_worker_info.ibd to /data/mysql/mysql3306/data/mysql/slave_worker_info.ibd
	200317 16:18:01 [01]        ...done
	200317 16:18:01 [01] Copying ./mysql/gtid_executed.ibd to /data/mysql/mysql3306/data/mysql/gtid_executed.ibd
	200317 16:18:01 [01]        ...done
	200317 16:18:01 [01] Copying ./mysql/server_cost.ibd to /data/mysql/mysql3306/data/mysql/server_cost.ibd
	200317 16:18:01 [01]        ...done
	200317 16:18:01 [01] Copying ./mysql/engine_cost.ibd to /data/mysql/mysql3306/data/mysql/engine_cost.ibd
	200317 16:18:01 [01]        ...done
	200317 16:18:01 [01] Copying ./mysql/db.opt to /data/mysql/mysql3306/data/mysql/db.opt
	200317 16:18:01 [01]        ...done
	200317 16:18:01 [01] Copying ./mysql/db.frm to /data/mysql/mysql3306/data/mysql/db.frm
	200317 16:18:01 [01]        ...done
	200317 16:18:01 [01] Copying ./mysql/db.MYI to /data/mysql/mysql3306/data/mysql/db.MYI
	200317 16:18:01 [01]        ...done
	200317 16:18:01 [01] Copying ./mysql/db.MYD to /data/mysql/mysql3306/data/mysql/db.MYD
	200317 16:18:01 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/user.frm to /data/mysql/mysql3306/data/mysql/user.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/user.MYI to /data/mysql/mysql3306/data/mysql/user.MYI
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/user.MYD to /data/mysql/mysql3306/data/mysql/user.MYD
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/func.frm to /data/mysql/mysql3306/data/mysql/func.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/func.MYI to /data/mysql/mysql3306/data/mysql/func.MYI
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/func.MYD to /data/mysql/mysql3306/data/mysql/func.MYD
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/plugin.frm to /data/mysql/mysql3306/data/mysql/plugin.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/servers.frm to /data/mysql/mysql3306/data/mysql/servers.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/tables_priv.frm to /data/mysql/mysql3306/data/mysql/tables_priv.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/tables_priv.MYI to /data/mysql/mysql3306/data/mysql/tables_priv.MYI
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/tables_priv.MYD to /data/mysql/mysql3306/data/mysql/tables_priv.MYD
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/columns_priv.frm to /data/mysql/mysql3306/data/mysql/columns_priv.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/columns_priv.MYI to /data/mysql/mysql3306/data/mysql/columns_priv.MYI
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/columns_priv.MYD to /data/mysql/mysql3306/data/mysql/columns_priv.MYD
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/help_topic.frm to /data/mysql/mysql3306/data/mysql/help_topic.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/help_category.frm to /data/mysql/mysql3306/data/mysql/help_category.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/help_relation.frm to /data/mysql/mysql3306/data/mysql/help_relation.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/help_keyword.frm to /data/mysql/mysql3306/data/mysql/help_keyword.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/time_zone_name.frm to /data/mysql/mysql3306/data/mysql/time_zone_name.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/time_zone.frm to /data/mysql/mysql3306/data/mysql/time_zone.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/time_zone_transition.frm to /data/mysql/mysql3306/data/mysql/time_zone_transition.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/time_zone_transition_type.frm to /data/mysql/mysql3306/data/mysql/time_zone_transition_type.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/time_zone_leap_second.frm to /data/mysql/mysql3306/data/mysql/time_zone_leap_second.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/proc.frm to /data/mysql/mysql3306/data/mysql/proc.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/proc.MYI to /data/mysql/mysql3306/data/mysql/proc.MYI
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/proc.MYD to /data/mysql/mysql3306/data/mysql/proc.MYD
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/procs_priv.frm to /data/mysql/mysql3306/data/mysql/procs_priv.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/procs_priv.MYI to /data/mysql/mysql3306/data/mysql/procs_priv.MYI
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/procs_priv.MYD to /data/mysql/mysql3306/data/mysql/procs_priv.MYD
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/general_log.frm to /data/mysql/mysql3306/data/mysql/general_log.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/general_log.CSM to /data/mysql/mysql3306/data/mysql/general_log.CSM
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/general_log.CSV to /data/mysql/mysql3306/data/mysql/general_log.CSV
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/slow_log.frm to /data/mysql/mysql3306/data/mysql/slow_log.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/slow_log.CSM to /data/mysql/mysql3306/data/mysql/slow_log.CSM
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/slow_log.CSV to /data/mysql/mysql3306/data/mysql/slow_log.CSV
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/event.frm to /data/mysql/mysql3306/data/mysql/event.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/event.MYI to /data/mysql/mysql3306/data/mysql/event.MYI
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/event.MYD to /data/mysql/mysql3306/data/mysql/event.MYD
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/ndb_binlog_index.frm to /data/mysql/mysql3306/data/mysql/ndb_binlog_index.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/ndb_binlog_index.MYI to /data/mysql/mysql3306/data/mysql/ndb_binlog_index.MYI
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/ndb_binlog_index.MYD to /data/mysql/mysql3306/data/mysql/ndb_binlog_index.MYD
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/innodb_table_stats.frm to /data/mysql/mysql3306/data/mysql/innodb_table_stats.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/innodb_index_stats.frm to /data/mysql/mysql3306/data/mysql/innodb_index_stats.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/slave_relay_log_info.frm to /data/mysql/mysql3306/data/mysql/slave_relay_log_info.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/slave_master_info.frm to /data/mysql/mysql3306/data/mysql/slave_master_info.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/slave_worker_info.frm to /data/mysql/mysql3306/data/mysql/slave_worker_info.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/gtid_executed.frm to /data/mysql/mysql3306/data/mysql/gtid_executed.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/server_cost.frm to /data/mysql/mysql3306/data/mysql/server_cost.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/engine_cost.frm to /data/mysql/mysql3306/data/mysql/engine_cost.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/proxies_priv.frm to /data/mysql/mysql3306/data/mysql/proxies_priv.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/proxies_priv.MYI to /data/mysql/mysql3306/data/mysql/proxies_priv.MYI
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./mysql/proxies_priv.MYD to /data/mysql/mysql3306/data/mysql/proxies_priv.MYD
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/sys_config.ibd to /data/mysql/mysql3306/data/sys/sys_config.ibd
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/db.opt to /data/mysql/mysql3306/data/sys/db.opt
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/version.frm to /data/mysql/mysql3306/data/sys/version.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/sys_config.frm to /data/mysql/mysql3306/data/sys/sys_config.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/statements_with_full_table_scans.frm to /data/mysql/mysql3306/data/sys/statements_with_full_table_scans.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/sys_config_insert_set_user.TRN to /data/mysql/mysql3306/data/sys/sys_config_insert_set_user.TRN
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/processlist.frm to /data/mysql/mysql3306/data/sys/processlist.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/sys_config.TRG to /data/mysql/mysql3306/data/sys/sys_config.TRG
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/statements_with_sorting.frm to /data/mysql/mysql3306/data/sys/statements_with_sorting.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/sys_config_update_set_user.TRN to /data/mysql/mysql3306/data/sys/sys_config_update_set_user.TRN
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/x@0024statements_with_sorting.frm to /data/mysql/mysql3306/data/sys/x@0024statements_with_sorting.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/innodb_buffer_stats_by_schema.frm to /data/mysql/mysql3306/data/sys/innodb_buffer_stats_by_schema.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/schema_index_statistics.frm to /data/mysql/mysql3306/data/sys/schema_index_statistics.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/x@0024innodb_buffer_stats_by_schema.frm to /data/mysql/mysql3306/data/sys/x@0024innodb_buffer_stats_by_schema.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/statements_with_temp_tables.frm to /data/mysql/mysql3306/data/sys/statements_with_temp_tables.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/innodb_buffer_stats_by_table.frm to /data/mysql/mysql3306/data/sys/innodb_buffer_stats_by_table.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/x@0024ps_schema_table_statistics_io.frm to /data/mysql/mysql3306/data/sys/x@0024ps_schema_table_statistics_io.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/x@0024innodb_buffer_stats_by_table.frm to /data/mysql/mysql3306/data/sys/x@0024innodb_buffer_stats_by_table.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/host_summary.frm to /data/mysql/mysql3306/data/sys/host_summary.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/innodb_lock_waits.frm to /data/mysql/mysql3306/data/sys/innodb_lock_waits.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/x@0024host_summary.frm to /data/mysql/mysql3306/data/sys/x@0024host_summary.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/x@0024innodb_lock_waits.frm to /data/mysql/mysql3306/data/sys/x@0024innodb_lock_waits.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/waits_by_user_by_latency.frm to /data/mysql/mysql3306/data/sys/waits_by_user_by_latency.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/schema_object_overview.frm to /data/mysql/mysql3306/data/sys/schema_object_overview.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/user_summary_by_file_io_type.frm to /data/mysql/mysql3306/data/sys/user_summary_by_file_io_type.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/schema_auto_increment_columns.frm to /data/mysql/mysql3306/data/sys/schema_auto_increment_columns.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/user_summary_by_file_io.frm to /data/mysql/mysql3306/data/sys/user_summary_by_file_io.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/x@0024schema_flattened_keys.frm to /data/mysql/mysql3306/data/sys/x@0024schema_flattened_keys.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/x@0024user_summary_by_file_io.frm to /data/mysql/mysql3306/data/sys/x@0024user_summary_by_file_io.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/schema_redundant_indexes.frm to /data/mysql/mysql3306/data/sys/schema_redundant_indexes.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/user_summary_by_statement_type.frm to /data/mysql/mysql3306/data/sys/user_summary_by_statement_type.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/ps_check_lost_instrumentation.frm to /data/mysql/mysql3306/data/sys/ps_check_lost_instrumentation.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/latest_file_io.frm to /data/mysql/mysql3306/data/sys/latest_file_io.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/waits_by_host_by_latency.frm to /data/mysql/mysql3306/data/sys/waits_by_host_by_latency.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/x@0024latest_file_io.frm to /data/mysql/mysql3306/data/sys/x@0024latest_file_io.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/waits_global_by_latency.frm to /data/mysql/mysql3306/data/sys/waits_global_by_latency.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/io_by_thread_by_latency.frm to /data/mysql/mysql3306/data/sys/io_by_thread_by_latency.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/user_summary_by_stages.frm to /data/mysql/mysql3306/data/sys/user_summary_by_stages.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/x@0024io_by_thread_by_latency.frm to /data/mysql/mysql3306/data/sys/x@0024io_by_thread_by_latency.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/x@0024user_summary_by_stages.frm to /data/mysql/mysql3306/data/sys/x@0024user_summary_by_stages.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/io_global_by_file_by_bytes.frm to /data/mysql/mysql3306/data/sys/io_global_by_file_by_bytes.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/x@0024schema_index_statistics.frm to /data/mysql/mysql3306/data/sys/x@0024schema_index_statistics.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/x@0024io_global_by_file_by_bytes.frm to /data/mysql/mysql3306/data/sys/x@0024io_global_by_file_by_bytes.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/user_summary.frm to /data/mysql/mysql3306/data/sys/user_summary.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/io_global_by_file_by_latency.frm to /data/mysql/mysql3306/data/sys/io_global_by_file_by_latency.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/schema_table_statistics.frm to /data/mysql/mysql3306/data/sys/schema_table_statistics.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/x@0024io_global_by_file_by_latency.frm to /data/mysql/mysql3306/data/sys/x@0024io_global_by_file_by_latency.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/x@0024user_summary.frm to /data/mysql/mysql3306/data/sys/x@0024user_summary.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/io_global_by_wait_by_bytes.frm to /data/mysql/mysql3306/data/sys/io_global_by_wait_by_bytes.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/x@0024schema_table_statistics.frm to /data/mysql/mysql3306/data/sys/x@0024schema_table_statistics.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/x@0024io_global_by_wait_by_bytes.frm to /data/mysql/mysql3306/data/sys/x@0024io_global_by_wait_by_bytes.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/host_summary_by_file_io_type.frm to /data/mysql/mysql3306/data/sys/host_summary_by_file_io_type.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/io_global_by_wait_by_latency.frm to /data/mysql/mysql3306/data/sys/io_global_by_wait_by_latency.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/schema_table_statistics_with_buffer.frm to /data/mysql/mysql3306/data/sys/schema_table_statistics_with_buffer.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/x@0024io_global_by_wait_by_latency.frm to /data/mysql/mysql3306/data/sys/x@0024io_global_by_wait_by_latency.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/host_summary_by_file_io.frm to /data/mysql/mysql3306/data/sys/host_summary_by_file_io.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/memory_by_user_by_current_bytes.frm to /data/mysql/mysql3306/data/sys/memory_by_user_by_current_bytes.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/schema_table_lock_waits.frm to /data/mysql/mysql3306/data/sys/schema_table_lock_waits.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/x@0024memory_by_user_by_current_bytes.frm to /data/mysql/mysql3306/data/sys/x@0024memory_by_user_by_current_bytes.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:02 [01] Copying ./sys/x@0024host_summary_by_file_io.frm to /data/mysql/mysql3306/data/sys/x@0024host_summary_by_file_io.frm
	200317 16:18:02 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/memory_by_host_by_current_bytes.frm to /data/mysql/mysql3306/data/sys/memory_by_host_by_current_bytes.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024schema_table_lock_waits.frm to /data/mysql/mysql3306/data/sys/x@0024schema_table_lock_waits.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024memory_by_host_by_current_bytes.frm to /data/mysql/mysql3306/data/sys/x@0024memory_by_host_by_current_bytes.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/statement_analysis.frm to /data/mysql/mysql3306/data/sys/statement_analysis.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/memory_by_thread_by_current_bytes.frm to /data/mysql/mysql3306/data/sys/memory_by_thread_by_current_bytes.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024statement_analysis.frm to /data/mysql/mysql3306/data/sys/x@0024statement_analysis.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024memory_by_thread_by_current_bytes.frm to /data/mysql/mysql3306/data/sys/x@0024memory_by_thread_by_current_bytes.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/host_summary_by_statement_type.frm to /data/mysql/mysql3306/data/sys/host_summary_by_statement_type.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/memory_global_by_current_bytes.frm to /data/mysql/mysql3306/data/sys/memory_global_by_current_bytes.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/statements_with_errors_or_warnings.frm to /data/mysql/mysql3306/data/sys/statements_with_errors_or_warnings.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024memory_global_by_current_bytes.frm to /data/mysql/mysql3306/data/sys/x@0024memory_global_by_current_bytes.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/metrics.frm to /data/mysql/mysql3306/data/sys/metrics.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/memory_global_total.frm to /data/mysql/mysql3306/data/sys/memory_global_total.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/host_summary_by_stages.frm to /data/mysql/mysql3306/data/sys/host_summary_by_stages.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024memory_global_total.frm to /data/mysql/mysql3306/data/sys/x@0024memory_global_total.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/session.frm to /data/mysql/mysql3306/data/sys/session.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024schema_table_statistics_with_buffer.frm to /data/mysql/mysql3306/data/sys/x@0024schema_table_statistics_with_buffer.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024statements_with_errors_or_warnings.frm to /data/mysql/mysql3306/data/sys/x@0024statements_with_errors_or_warnings.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/schema_tables_with_full_table_scans.frm to /data/mysql/mysql3306/data/sys/schema_tables_with_full_table_scans.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/schema_unused_indexes.frm to /data/mysql/mysql3306/data/sys/schema_unused_indexes.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024schema_tables_with_full_table_scans.frm to /data/mysql/mysql3306/data/sys/x@0024schema_tables_with_full_table_scans.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024host_summary_by_stages.frm to /data/mysql/mysql3306/data/sys/x@0024host_summary_by_stages.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024statements_with_full_table_scans.frm to /data/mysql/mysql3306/data/sys/x@0024statements_with_full_table_scans.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024ps_digest_avg_latency_distribution.frm to /data/mysql/mysql3306/data/sys/x@0024ps_digest_avg_latency_distribution.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024ps_digest_95th_percentile_by_avg_us.frm to /data/mysql/mysql3306/data/sys/x@0024ps_digest_95th_percentile_by_avg_us.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/statements_with_runtimes_in_95th_percentile.frm to /data/mysql/mysql3306/data/sys/statements_with_runtimes_in_95th_percentile.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024statements_with_runtimes_in_95th_percentile.frm to /data/mysql/mysql3306/data/sys/x@0024statements_with_runtimes_in_95th_percentile.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024statements_with_temp_tables.frm to /data/mysql/mysql3306/data/sys/x@0024statements_with_temp_tables.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024user_summary_by_file_io_type.frm to /data/mysql/mysql3306/data/sys/x@0024user_summary_by_file_io_type.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024user_summary_by_statement_type.frm to /data/mysql/mysql3306/data/sys/x@0024user_summary_by_statement_type.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/user_summary_by_statement_latency.frm to /data/mysql/mysql3306/data/sys/user_summary_by_statement_latency.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024user_summary_by_statement_latency.frm to /data/mysql/mysql3306/data/sys/x@0024user_summary_by_statement_latency.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024host_summary_by_file_io_type.frm to /data/mysql/mysql3306/data/sys/x@0024host_summary_by_file_io_type.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024host_summary_by_statement_type.frm to /data/mysql/mysql3306/data/sys/x@0024host_summary_by_statement_type.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/host_summary_by_statement_latency.frm to /data/mysql/mysql3306/data/sys/host_summary_by_statement_latency.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024host_summary_by_statement_latency.frm to /data/mysql/mysql3306/data/sys/x@0024host_summary_by_statement_latency.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/wait_classes_global_by_avg_latency.frm to /data/mysql/mysql3306/data/sys/wait_classes_global_by_avg_latency.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024wait_classes_global_by_avg_latency.frm to /data/mysql/mysql3306/data/sys/x@0024wait_classes_global_by_avg_latency.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/wait_classes_global_by_latency.frm to /data/mysql/mysql3306/data/sys/wait_classes_global_by_latency.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024wait_classes_global_by_latency.frm to /data/mysql/mysql3306/data/sys/x@0024wait_classes_global_by_latency.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024waits_by_user_by_latency.frm to /data/mysql/mysql3306/data/sys/x@0024waits_by_user_by_latency.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024waits_by_host_by_latency.frm to /data/mysql/mysql3306/data/sys/x@0024waits_by_host_by_latency.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024waits_global_by_latency.frm to /data/mysql/mysql3306/data/sys/x@0024waits_global_by_latency.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024processlist.frm to /data/mysql/mysql3306/data/sys/x@0024processlist.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/x@0024session.frm to /data/mysql/mysql3306/data/sys/x@0024session.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./sys/session_ssl_status.frm to /data/mysql/mysql3306/data/sys/session_ssl_status.frm
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./zst/t1.ibd to /data/mysql/mysql3306/data/zst/t1.ibd
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./zst/product.ibd to /data/mysql/mysql3306/data/zst/product.ibd
	200317 16:18:03 [01]        ...done
	200317 16:18:03 [01] Copying ./zst/t1_10yi.ibd to /data/mysql/mysql3306/data/zst/t1_10yi.ibd
	200317 16:18:33 [01]        ...done
	200317 16:18:40 [01] Copying ./zst/t2.ibd to /data/mysql/mysql3306/data/zst/t2.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./zst/t20190930.ibd to /data/mysql/mysql3306/data/zst/t20190930.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./zst/t20191007.ibd to /data/mysql/mysql3306/data/zst/t20191007.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./zst/t2019100702.ibd to /data/mysql/mysql3306/data/zst/t2019100702.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./zst/mytest.ibd to /data/mysql/mysql3306/data/zst/mytest.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./zst/mytest01.ibd to /data/mysql/mysql3306/data/zst/mytest01.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./zst/t.ibd to /data/mysql/mysql3306/data/zst/t.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./zst/db.opt to /data/mysql/mysql3306/data/zst/db.opt
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./zst/t1.frm to /data/mysql/mysql3306/data/zst/t1.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./zst/product.frm to /data/mysql/mysql3306/data/zst/product.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./zst/t1_10yi.frm to /data/mysql/mysql3306/data/zst/t1_10yi.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./zst/t2.frm to /data/mysql/mysql3306/data/zst/t2.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./zst/t20190930.frm to /data/mysql/mysql3306/data/zst/t20190930.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./zst/t20191007.frm to /data/mysql/mysql3306/data/zst/t20191007.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./zst/t2019100702.frm to /data/mysql/mysql3306/data/zst/t2019100702.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./zst/mytest.frm to /data/mysql/mysql3306/data/zst/mytest.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./zst/mytest01.frm to /data/mysql/mysql3306/data/zst/mytest01.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./zst/t.frm to /data/mysql/mysql3306/data/zst/t.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./zst/a.frm to /data/mysql/mysql3306/data/zst/a.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./zst/a.MYI to /data/mysql/mysql3306/data/zst/a.MYI
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./zst/a.MYD to /data/mysql/mysql3306/data/zst/a.MYD
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./zst/t2020.frm to /data/mysql/mysql3306/data/zst/t2020.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./zst/t2020.MYI to /data/mysql/mysql3306/data/zst/t2020.MYI
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./zst/t2020.MYD to /data/mysql/mysql3306/data/zst/t2020.MYD
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./repl_monitor/slave_statment.ibd to /data/mysql/mysql3306/data/repl_monitor/slave_statment.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./repl_monitor/master_statment.ibd to /data/mysql/mysql3306/data/repl_monitor/master_statment.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./repl_monitor/db.opt to /data/mysql/mysql3306/data/repl_monitor/db.opt
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./repl_monitor/slave_statment.frm to /data/mysql/mysql3306/data/repl_monitor/slave_statment.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./repl_monitor/master_statment.frm to /data/mysql/mysql3306/data/repl_monitor/master_statment.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/auth_group.ibd to /data/mysql/mysql3306/data/terrace_db/auth_group.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/auth_group_permissions.ibd to /data/mysql/mysql3306/data/terrace_db/auth_group_permissions.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/auth_permission.ibd to /data/mysql/mysql3306/data/terrace_db/auth_permission.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/auth_user.ibd to /data/mysql/mysql3306/data/terrace_db/auth_user.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/auth_user_groups.ibd to /data/mysql/mysql3306/data/terrace_db/auth_user_groups.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/auth_user_user_permissions.ibd to /data/mysql/mysql3306/data/terrace_db/auth_user_user_permissions.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/django_admin_log.ibd to /data/mysql/mysql3306/data/terrace_db/django_admin_log.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/django_content_type.ibd to /data/mysql/mysql3306/data/terrace_db/django_content_type.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/django_migrations.ibd to /data/mysql/mysql3306/data/terrace_db/django_migrations.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/django_session.ibd to /data/mysql/mysql3306/data/terrace_db/django_session.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/myapp_query_log.ibd to /data/mysql/mysql3306/data/terrace_db/myapp_query_log.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/myapp_oper_log.ibd to /data/mysql/mysql3306/data/terrace_db/myapp_oper_log.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/mysql_slow_query_review.ibd to /data/mysql/mysql3306/data/terrace_db/mysql_slow_query_review.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/mysql_slow_query_review_history.ibd to /data/mysql/mysql3306/data/terrace_db/mysql_slow_query_review_history.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/salt_record.ibd to /data/mysql/mysql3306/data/terrace_db/salt_record.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/tb_blacklist.ibd to /data/mysql/mysql3306/data/terrace_db/tb_blacklist.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/tb_blacklist_user_permit.ibd to /data/mysql/mysql3306/data/terrace_db/tb_blacklist_user_permit.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/myapp_permission.ibd to /data/mysql/mysql3306/data/terrace_db/myapp_permission.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/myapp_db_instance.ibd to /data/mysql/mysql3306/data/terrace_db/myapp_db_instance.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/myapp_db_name.ibd to /data/mysql/mysql3306/data/terrace_db/myapp_db_name.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/django_q_task.ibd to /data/mysql/mysql3306/data/terrace_db/django_q_task.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/django_q_schedule.ibd to /data/mysql/mysql3306/data/terrace_db/django_q_schedule.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/django_celery_results_taskresult.ibd to /data/mysql/mysql3306/data/terrace_db/django_celery_results_taskresult.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/django_q_ormq.ibd to /data/mysql/mysql3306/data/terrace_db/django_q_ormq.ibd
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/db.opt to /data/mysql/mysql3306/data/terrace_db/db.opt
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/auth_group.frm to /data/mysql/mysql3306/data/terrace_db/auth_group.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/auth_group_permissions.frm to /data/mysql/mysql3306/data/terrace_db/auth_group_permissions.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/auth_permission.frm to /data/mysql/mysql3306/data/terrace_db/auth_permission.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/auth_user.frm to /data/mysql/mysql3306/data/terrace_db/auth_user.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/auth_user_groups.frm to /data/mysql/mysql3306/data/terrace_db/auth_user_groups.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/auth_user_user_permissions.frm to /data/mysql/mysql3306/data/terrace_db/auth_user_user_permissions.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/django_admin_log.frm to /data/mysql/mysql3306/data/terrace_db/django_admin_log.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/django_content_type.frm to /data/mysql/mysql3306/data/terrace_db/django_content_type.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/django_migrations.frm to /data/mysql/mysql3306/data/terrace_db/django_migrations.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/django_session.frm to /data/mysql/mysql3306/data/terrace_db/django_session.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/myapp_db_instance.frm to /data/mysql/mysql3306/data/terrace_db/myapp_db_instance.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/myapp_oper_log.frm to /data/mysql/mysql3306/data/terrace_db/myapp_oper_log.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/mysql_slow_query_review.frm to /data/mysql/mysql3306/data/terrace_db/mysql_slow_query_review.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/mysql_slow_query_review_history.frm to /data/mysql/mysql3306/data/terrace_db/mysql_slow_query_review_history.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/salt_record.frm to /data/mysql/mysql3306/data/terrace_db/salt_record.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/tb_blacklist.frm to /data/mysql/mysql3306/data/terrace_db/tb_blacklist.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/tb_blacklist_user_permit.frm to /data/mysql/mysql3306/data/terrace_db/tb_blacklist_user_permit.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/myapp_permission.frm to /data/mysql/mysql3306/data/terrace_db/myapp_permission.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/myapp_query_log.frm to /data/mysql/mysql3306/data/terrace_db/myapp_query_log.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/myapp_db_name.frm to /data/mysql/mysql3306/data/terrace_db/myapp_db_name.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/django_q_task.frm to /data/mysql/mysql3306/data/terrace_db/django_q_task.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/django_q_schedule.frm to /data/mysql/mysql3306/data/terrace_db/django_q_schedule.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/django_celery_results_taskresult.frm to /data/mysql/mysql3306/data/terrace_db/django_celery_results_taskresult.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./terrace_db/django_q_ormq.frm to /data/mysql/mysql3306/data/terrace_db/django_q_ormq.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./performance_schema/db.opt to /data/mysql/mysql3306/data/performance_schema/db.opt
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./performance_schema/cond_instances.frm to /data/mysql/mysql3306/data/performance_schema/cond_instances.frm
	200317 16:18:40 [01]        ...done
	200317 16:18:40 [01] Copying ./performance_schema/events_waits_current.frm to /data/mysql/mysql3306/data/performance_schema/events_waits_current.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_waits_history.frm to /data/mysql/mysql3306/data/performance_schema/events_waits_history.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_waits_history_long.frm to /data/mysql/mysql3306/data/performance_schema/events_waits_history_long.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_waits_summary_by_instance.frm to /data/mysql/mysql3306/data/performance_schema/events_waits_summary_by_instance.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_waits_summary_by_host_by_event_name.frm to /data/mysql/mysql3306/data/performance_schema/events_waits_summary_by_host_by_event_name.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_waits_summary_by_user_by_event_name.frm to /data/mysql/mysql3306/data/performance_schema/events_waits_summary_by_user_by_event_name.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_waits_summary_by_account_by_event_name.frm to /data/mysql/mysql3306/data/performance_schema/events_waits_summary_by_account_by_event_name.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_waits_summary_by_thread_by_event_name.frm to /data/mysql/mysql3306/data/performance_schema/events_waits_summary_by_thread_by_event_name.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_waits_summary_global_by_event_name.frm to /data/mysql/mysql3306/data/performance_schema/events_waits_summary_global_by_event_name.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/file_instances.frm to /data/mysql/mysql3306/data/performance_schema/file_instances.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/file_summary_by_event_name.frm to /data/mysql/mysql3306/data/performance_schema/file_summary_by_event_name.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/file_summary_by_instance.frm to /data/mysql/mysql3306/data/performance_schema/file_summary_by_instance.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/socket_instances.frm to /data/mysql/mysql3306/data/performance_schema/socket_instances.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/socket_summary_by_instance.frm to /data/mysql/mysql3306/data/performance_schema/socket_summary_by_instance.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/socket_summary_by_event_name.frm to /data/mysql/mysql3306/data/performance_schema/socket_summary_by_event_name.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/host_cache.frm to /data/mysql/mysql3306/data/performance_schema/host_cache.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/mutex_instances.frm to /data/mysql/mysql3306/data/performance_schema/mutex_instances.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/objects_summary_global_by_type.frm to /data/mysql/mysql3306/data/performance_schema/objects_summary_global_by_type.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/performance_timers.frm to /data/mysql/mysql3306/data/performance_schema/performance_timers.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/rwlock_instances.frm to /data/mysql/mysql3306/data/performance_schema/rwlock_instances.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/setup_actors.frm to /data/mysql/mysql3306/data/performance_schema/setup_actors.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/setup_consumers.frm to /data/mysql/mysql3306/data/performance_schema/setup_consumers.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/setup_instruments.frm to /data/mysql/mysql3306/data/performance_schema/setup_instruments.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/setup_objects.frm to /data/mysql/mysql3306/data/performance_schema/setup_objects.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/setup_timers.frm to /data/mysql/mysql3306/data/performance_schema/setup_timers.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/table_io_waits_summary_by_index_usage.frm to /data/mysql/mysql3306/data/performance_schema/table_io_waits_summary_by_index_usage.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/table_io_waits_summary_by_table.frm to /data/mysql/mysql3306/data/performance_schema/table_io_waits_summary_by_table.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/table_lock_waits_summary_by_table.frm to /data/mysql/mysql3306/data/performance_schema/table_lock_waits_summary_by_table.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/threads.frm to /data/mysql/mysql3306/data/performance_schema/threads.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_stages_current.frm to /data/mysql/mysql3306/data/performance_schema/events_stages_current.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_stages_history.frm to /data/mysql/mysql3306/data/performance_schema/events_stages_history.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_stages_history_long.frm to /data/mysql/mysql3306/data/performance_schema/events_stages_history_long.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_stages_summary_by_thread_by_event_name.frm to /data/mysql/mysql3306/data/performance_schema/events_stages_summary_by_thread_by_event_name.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_stages_summary_by_host_by_event_name.frm to /data/mysql/mysql3306/data/performance_schema/events_stages_summary_by_host_by_event_name.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_stages_summary_by_user_by_event_name.frm to /data/mysql/mysql3306/data/performance_schema/events_stages_summary_by_user_by_event_name.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_stages_summary_by_account_by_event_name.frm to /data/mysql/mysql3306/data/performance_schema/events_stages_summary_by_account_by_event_name.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_stages_summary_global_by_event_name.frm to /data/mysql/mysql3306/data/performance_schema/events_stages_summary_global_by_event_name.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_statements_current.frm to /data/mysql/mysql3306/data/performance_schema/events_statements_current.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_statements_history.frm to /data/mysql/mysql3306/data/performance_schema/events_statements_history.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_statements_history_long.frm to /data/mysql/mysql3306/data/performance_schema/events_statements_history_long.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_statements_summary_by_thread_by_event_name.frm to /data/mysql/mysql3306/data/performance_schema/events_statements_summary_by_thread_by_event_name.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_statements_summary_by_host_by_event_name.frm to /data/mysql/mysql3306/data/performance_schema/events_statements_summary_by_host_by_event_name.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_statements_summary_by_user_by_event_name.frm to /data/mysql/mysql3306/data/performance_schema/events_statements_summary_by_user_by_event_name.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_statements_summary_by_account_by_event_name.frm to /data/mysql/mysql3306/data/performance_schema/events_statements_summary_by_account_by_event_name.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_statements_summary_global_by_event_name.frm to /data/mysql/mysql3306/data/performance_schema/events_statements_summary_global_by_event_name.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_transactions_current.frm to /data/mysql/mysql3306/data/performance_schema/events_transactions_current.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_transactions_history.frm to /data/mysql/mysql3306/data/performance_schema/events_transactions_history.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_transactions_history_long.frm to /data/mysql/mysql3306/data/performance_schema/events_transactions_history_long.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_transactions_summary_by_thread_by_event_name.frm to /data/mysql/mysql3306/data/performance_schema/events_transactions_summary_by_thread_by_event_name.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_transactions_summary_by_host_by_event_name.frm to /data/mysql/mysql3306/data/performance_schema/events_transactions_summary_by_host_by_event_name.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_transactions_summary_by_user_by_event_name.frm to /data/mysql/mysql3306/data/performance_schema/events_transactions_summary_by_user_by_event_name.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_transactions_summary_by_account_by_event_name.frm to /data/mysql/mysql3306/data/performance_schema/events_transactions_summary_by_account_by_event_name.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_transactions_summary_global_by_event_name.frm to /data/mysql/mysql3306/data/performance_schema/events_transactions_summary_global_by_event_name.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/hosts.frm to /data/mysql/mysql3306/data/performance_schema/hosts.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/users.frm to /data/mysql/mysql3306/data/performance_schema/users.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/accounts.frm to /data/mysql/mysql3306/data/performance_schema/accounts.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/memory_summary_global_by_event_name.frm to /data/mysql/mysql3306/data/performance_schema/memory_summary_global_by_event_name.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/memory_summary_by_thread_by_event_name.frm to /data/mysql/mysql3306/data/performance_schema/memory_summary_by_thread_by_event_name.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/memory_summary_by_account_by_event_name.frm to /data/mysql/mysql3306/data/performance_schema/memory_summary_by_account_by_event_name.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/memory_summary_by_host_by_event_name.frm to /data/mysql/mysql3306/data/performance_schema/memory_summary_by_host_by_event_name.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/memory_summary_by_user_by_event_name.frm to /data/mysql/mysql3306/data/performance_schema/memory_summary_by_user_by_event_name.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_statements_summary_by_digest.frm to /data/mysql/mysql3306/data/performance_schema/events_statements_summary_by_digest.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/events_statements_summary_by_program.frm to /data/mysql/mysql3306/data/performance_schema/events_statements_summary_by_program.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/prepared_statements_instances.frm to /data/mysql/mysql3306/data/performance_schema/prepared_statements_instances.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/replication_connection_configuration.frm to /data/mysql/mysql3306/data/performance_schema/replication_connection_configuration.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/replication_group_member_stats.frm to /data/mysql/mysql3306/data/performance_schema/replication_group_member_stats.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/replication_group_members.frm to /data/mysql/mysql3306/data/performance_schema/replication_group_members.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/replication_connection_status.frm to /data/mysql/mysql3306/data/performance_schema/replication_connection_status.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/replication_applier_configuration.frm to /data/mysql/mysql3306/data/performance_schema/replication_applier_configuration.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/replication_applier_status.frm to /data/mysql/mysql3306/data/performance_schema/replication_applier_status.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/replication_applier_status_by_coordinator.frm to /data/mysql/mysql3306/data/performance_schema/replication_applier_status_by_coordinator.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/replication_applier_status_by_worker.frm to /data/mysql/mysql3306/data/performance_schema/replication_applier_status_by_worker.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/session_connect_attrs.frm to /data/mysql/mysql3306/data/performance_schema/session_connect_attrs.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/session_account_connect_attrs.frm to /data/mysql/mysql3306/data/performance_schema/session_account_connect_attrs.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/table_handles.frm to /data/mysql/mysql3306/data/performance_schema/table_handles.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/metadata_locks.frm to /data/mysql/mysql3306/data/performance_schema/metadata_locks.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/user_variables_by_thread.frm to /data/mysql/mysql3306/data/performance_schema/user_variables_by_thread.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/variables_by_thread.frm to /data/mysql/mysql3306/data/performance_schema/variables_by_thread.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/global_variables.frm to /data/mysql/mysql3306/data/performance_schema/global_variables.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/session_variables.frm to /data/mysql/mysql3306/data/performance_schema/session_variables.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/status_by_thread.frm to /data/mysql/mysql3306/data/performance_schema/status_by_thread.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/status_by_user.frm to /data/mysql/mysql3306/data/performance_schema/status_by_user.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/status_by_host.frm to /data/mysql/mysql3306/data/performance_schema/status_by_host.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/status_by_account.frm to /data/mysql/mysql3306/data/performance_schema/status_by_account.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/global_status.frm to /data/mysql/mysql3306/data/performance_schema/global_status.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./performance_schema/session_status.frm to /data/mysql/mysql3306/data/performance_schema/session_status.frm
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./ib_buffer_pool to /data/mysql/mysql3306/data/ib_buffer_pool
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./xtrabackup_info to /data/mysql/mysql3306/data/xtrabackup_info
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./xtrabackup_binlog_pos_innodb to /data/mysql/mysql3306/data/xtrabackup_binlog_pos_innodb
	200317 16:18:41 [01]        ...done
	200317 16:18:41 [01] Copying ./ibtmp1 to /data/mysql/mysql3306/data/ibtmp1
	200317 16:18:41 [01]        ...done
	200317 16:18:41 completed OK!

	real	1m53.256s
	user	0m0.080s
	sys	0m10.222s
	

4. 观察数据恢复之后启动MySQL的错误日志
	2020-03-17T08:23:10.055500Z 0 [Warning] The syntax '--log_warnings/-W' is deprecated and will be removed in a future release. Please use '--log_error_verbosity' instead.
	2020-03-17T08:23:10.055621Z 0 [Warning] TIMESTAMP with implicit DEFAULT value is deprecated. Please use --explicit_defaults_for_timestamp server option (see documentation for more details).
	2020-03-17T08:23:10.056369Z 0 [Warning] Insecure configuration for --secure-file-priv: Location is accessible to all OS users. Consider choosing a different directory.
	2020-03-17T08:23:10.056405Z 0 [Note] /usr/local/mysql/bin/mysqld (mysqld 5.7.19-log) starting as process 27938 ...
	2020-03-17T08:23:10.097517Z 0 [Note] InnoDB: PUNCH HOLE support available
	2020-03-17T08:23:10.097549Z 0 [Note] InnoDB: Mutexes and rw_locks use GCC atomic builtins
	2020-03-17T08:23:10.097554Z 0 [Note] InnoDB: Uses event mutexes
	2020-03-17T08:23:10.097560Z 0 [Note] InnoDB: GCC builtin __sync_synchronize() is used for memory barrier
	2020-03-17T08:23:10.097564Z 0 [Note] InnoDB: Compressed tables use zlib 1.2.3
	2020-03-17T08:23:10.097568Z 0 [Note] InnoDB: Using Linux native AIO
	2020-03-17T08:23:10.097766Z 0 [Note] InnoDB: Number of pools: 1
	2020-03-17T08:23:10.097869Z 0 [Note] InnoDB: Using CPU crc32 instructions
	2020-03-17T08:23:10.098936Z 0 [Note] InnoDB: Initializing buffer pool, total size = 100M, instances = 1, chunk size = 100M
	2020-03-17T08:23:10.103639Z 0 [Note] InnoDB: Completed initialization of buffer pool
	2020-03-17T08:23:10.104599Z 0 [Note] InnoDB: If the mysqld execution user is authorized, page cleaner thread priority can be changed. See the man page of setpriority().
	2020-03-17T08:23:10.143343Z 0 [Note] InnoDB: Highest supported file format is Barracuda.
	2020-03-17T08:23:10.722890Z 0 [Note] InnoDB: Creating shared tablespace for temporary tables
	2020-03-17T08:23:10.722983Z 0 [Note] InnoDB: Setting file './ibtmp1' size to 12 MB. Physically writing the file full; Please wait ...
	2020-03-17T08:23:10.963625Z 0 [Note] InnoDB: File './ibtmp1' size is now 12 MB.
	2020-03-17T08:23:10.964854Z 0 [Note] InnoDB: 96 redo rollback segment(s) found. 96 redo rollback segment(s) are active.
	2020-03-17T08:23:10.964883Z 0 [Note] InnoDB: 32 non-redo rollback segment(s) are active.
	2020-03-17T08:23:10.965541Z 0 [Note] InnoDB: Waiting for purge to start
	2020-03-17T08:23:11.027063Z 0 [Note] InnoDB: 5.7.19 started; log sequence number 18238657243
	2020-03-17T08:23:11.027359Z 0 [Note] Plugin 'FEDERATED' is disabled.
	2020-03-17T08:23:11.030586Z 0 [Note] InnoDB: Loading buffer pool(s) from /data/mysql/mysql3306/data/ib_buffer_pool
	2020-03-17T08:23:11.048563Z 0 [Note] Salting uuid generator variables, current_pid: 27938, server_start_time: 1584433390, bytes_sent: 0, 
	2020-03-17T08:23:11.048652Z 0 [Note] Generated uuid: '89f12dce-6828-11ea-9c33-080027fc8003', server_start_time: 7863847900926768656, bytes_sent: 37319456
	2020-03-17T08:23:11.048678Z 0 [Warning] No existing UUID has been found, so we assume that this is the first time that this server has been started. Generating a new UUID: 89f12dce-6828-11ea-9c33-080027fc8003.
	2020-03-17T08:23:11.145761Z 0 [Note] InnoDB: Buffer pool(s) load completed at 200317 16:23:11
	2020-03-17T08:23:11.367488Z 0 [Warning] Failed to set up SSL because of the following SSL library error: SSL context is not usable without certificate and private key
	2020-03-17T08:23:11.367511Z 0 [Note] Server hostname (bind-address): '*'; port: 3306
	2020-03-17T08:23:11.367544Z 0 [Note] IPv6 is available.
	2020-03-17T08:23:11.367552Z 0 [Note]   - '::' resolves to '::';
	2020-03-17T08:23:11.367572Z 0 [Note] Server socket created on IP: '::'.
	2020-03-17T08:23:11.487281Z 0 [Note] Event Scheduler: Loaded 0 events
	2020-03-17T08:23:11.487406Z 0 [Note] /usr/local/mysql/bin/mysqld: ready for connections.
	Version: '5.7.19-log'  socket: '/tmp/mysql3306.sock'  port: 3306  MySQL Community Server (GPL)
	2020-03-17T08:23:11.487415Z 0 [Note] Executing 'SELECT * FROM INFORMATION_SCHEMA.TABLES;' to get a list of tables using the deprecated partition engine. You may use the startup option '--disable-partition-engine-check' to skip this check. 
	2020-03-17T08:23:11.487418Z 0 [Note] Beginning of list of non-natively partitioned tables
	2020-03-17T08:23:11.563138Z 0 [Note] End of list of non-natively partitioned tables
	[root@env data]# tail -f error.log 
	2020-03-17T08:23:11.367511Z 0 [Note] Server hostname (bind-address): '*'; port: 3306
	2020-03-17T08:23:11.367544Z 0 [Note] IPv6 is available.
	2020-03-17T08:23:11.367552Z 0 [Note]   - '::' resolves to '::';
	2020-03-17T08:23:11.367572Z 0 [Note] Server socket created on IP: '::'.
	2020-03-17T08:23:11.487281Z 0 [Note] Event Scheduler: Loaded 0 events
	2020-03-17T08:23:11.487406Z 0 [Note] /usr/local/mysql/bin/mysqld: ready for connections.
	Version: '5.7.19-log'  socket: '/tmp/mysql3306.sock'  port: 3306  MySQL Community Server (GPL)
	2020-03-17T08:23:11.487415Z 0 [Note] Executing 'SELECT * FROM INFORMATION_SCHEMA.TABLES;' to get a list of tables using the deprecated partition engine. You may use the startup option '--disable-partition-engine-check' to skip this check. 
	2020-03-17T08:23:11.487418Z 0 [Note] Beginning of list of non-natively partitioned tables
	2020-03-17T08:23:11.563138Z 0 [Note] End of list of non-natively partitioned tables

	

2. 在线建立主从
	master
		root@localhost [(none)]>show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000002
				 Position: 28168396
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-110036
		1 row in set (0.00 sec)

		ERROR: 
		No query specified

		root@localhost [(none)]>delete from zst.t1_10yi where id=1;
		Query OK, 1 row affected (0.00 sec)

		root@localhost [(none)]>show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000002
				 Position: 28168649
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-110037
		1 row in set (0.00 sec)

		ERROR: 
		No query specified


	slave:
		root@localhost [(none)]>show master status\G;
		*************************** 1. row ***************************
					 File: mysql-bin.000003
				 Position: 194
			 Binlog_Do_DB: 
		 Binlog_Ignore_DB: 
		Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-110036
		1 row in set (0.00 sec)

		ERROR: 
		No query specified

		root@localhost [(none)]>show global variables like '%gtid%';
		+----------------------------------+-----------------------------------------------+
		| Variable_name                    | Value                                         |
		+----------------------------------+-----------------------------------------------+
		| binlog_gtid_simple_recovery      | ON                                            |
		| enforce_gtid_consistency         | ON                                            |
		| gtid_executed                    | f7323d17-6442-11ea-8a77-080027758761:1-110036 |
		| gtid_executed_compression_period | 1000                                          |
		| gtid_mode                        | ON                                            |
		| gtid_owned                       |                                               |
		| gtid_purged                      | f7323d17-6442-11ea-8a77-080027758761:1-2      |
		| session_track_gtids              | OFF                                           |
		+----------------------------------+-----------------------------------------------+
		8 rows in set (0.00 sec)
		 
		 
		[root@env 2020-03-15_19-46-09]# cat xtrabackup_binlog_info
		mysql-bin.000002	2696	f7323d17-6442-11ea-8a77-080027758761:1-14
		
		reset master;
		
		set global gtid_purged = 'f7323d17-6442-11ea-8a77-080027758761:1-14';
		
		root@localhost [(none)]>show global variables like '%gtid%';
		+----------------------------------+-------------------------------------------+
		| Variable_name                    | Value                                     |
		+----------------------------------+-------------------------------------------+
		| binlog_gtid_simple_recovery      | ON                                        |
		| enforce_gtid_consistency         | ON                                        |
		| gtid_executed                    | f7323d17-6442-11ea-8a77-080027758761:1-14 |
		| gtid_executed_compression_period | 1000                                      |
		| gtid_mode                        | ON                                        |
		| gtid_owned                       |                                           |
		| gtid_purged                      | f7323d17-6442-11ea-8a77-080027758761:1-14 |
		| session_track_gtids              | OFF                                       |
		+----------------------------------+-------------------------------------------+
		8 rows in set (0.01 sec)
			
		change master to 
		master_host='192.168.1.27',
		master_user='repl',
		master_password='123456abc',
		master_port=3310,
		MASTER_AUTO_POSITION = 1;
		
		
		root@localhost [(none)]>change master to 
		-> master_host='192.168.1.27',
		-> master_user='repl',
		-> master_password='123456abc',
		-> master_port=3310,
		-> MASTER_AUTO_POSITION = 1;
		Query OK, 0 rows affected, 2 warnings (0.30 sec)
		
		change master to 的信息错误之后的重置：	
				root@localhost [(none)]>reset slave all;
				Query OK, 0 rows affected (0.01 sec)

				root@localhost [(none)]>reset master;
				Query OK, 0 rows affected (0.50 sec)

				root@localhost [(none)]>
				root@localhost [(none)]>set global gtid_purged = 'f7323d17-6442-11ea-8a77-080027758761:1-14';
				Query OK, 0 rows affected (0.00 sec)

				root@localhost [(none)]>show global variables like '%gtid%';
				+----------------------------------+-------------------------------------------+
				| Variable_name                    | Value                                     |
				+----------------------------------+-------------------------------------------+
				| binlog_gtid_simple_recovery      | ON                                        |
				| enforce_gtid_consistency         | ON                                        |
				| gtid_executed                    | f7323d17-6442-11ea-8a77-080027758761:1-14 |
				| gtid_executed_compression_period | 1000                                      |
				| gtid_mode                        | ON                                        |
				| gtid_owned                       |                                           |
				| gtid_purged                      | f7323d17-6442-11ea-8a77-080027758761:1-14 |
				| session_track_gtids              | OFF                                       |
				+----------------------------------+-------------------------------------------+
				8 rows in set (0.00 sec)

		change master to 
		master_host='192.168.1.27',
		master_user='repl',
		master_password='123456abc',
		master_port=3306,
		MASTER_AUTO_POSITION = 1;
		
		start slave io_thread;
		
		root@localhost [(none)]>show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: Waiting for master to send event
						  Master_Host: 192.168.1.27
						  Master_User: repl
						  Master_Port: 3306
						Connect_Retry: 60
					  Master_Log_File: mysql-bin.000002
				  Read_Master_Log_Pos: 28168649
					   Relay_Log_File: relay-bin.000001
						Relay_Log_Pos: 4
				Relay_Master_Log_File: 
					 Slave_IO_Running: Yes
					Slave_SQL_Running: No	
			
		start slave sql_thread;	
		

		root@localhost [(none)]>show slave status\G;
		*************************** 1. row ***************************
					   Slave_IO_State: Waiting for master to send event
						  Master_Host: 192.168.1.27
						  Master_User: repl
						  Master_Port: 3306
						Connect_Retry: 60
					  Master_Log_File: mysql-bin.000002
				  Read_Master_Log_Pos: 28168649
					   Relay_Log_File: relay-bin.000002
						Relay_Log_Pos: 12834146
				Relay_Master_Log_File: mysql-bin.000002
					 Slave_IO_Running: Yes
					Slave_SQL_Running: Yes
					  Replicate_Do_DB: 
				  Replicate_Ignore_DB: 
				   Replicate_Do_Table: 
			   Replicate_Ignore_Table: 
			  Replicate_Wild_Do_Table: 
		  Replicate_Wild_Ignore_Table: 
						   Last_Errno: 0
						   Last_Error: 
						 Skip_Counter: 0
				  Exec_Master_Log_Pos: 12836428
					  Relay_Log_Space: 28166568
					  Until_Condition: None
					   Until_Log_File: 
						Until_Log_Pos: 0
				   Master_SSL_Allowed: No
				   Master_SSL_CA_File: 
				   Master_SSL_CA_Path: 
					  Master_SSL_Cert: 
					Master_SSL_Cipher: 
					   Master_SSL_Key: 
				Seconds_Behind_Master: 25026
		Master_SSL_Verify_Server_Cert: No
						Last_IO_Errno: 0
						Last_IO_Error: 
					   Last_SQL_Errno: 0
					   Last_SQL_Error: 
		  Replicate_Ignore_Server_Ids: 
					 Master_Server_Id: 273306
						  Master_UUID: f7323d17-6442-11ea-8a77-080027758761
					 Master_Info_File: /data/mysql/mysql3306/data/master.info
							SQL_Delay: 0
				  SQL_Remaining_Delay: NULL
			  Slave_SQL_Running_State: Reading event from the relay log
				   Master_Retry_Count: 86400
						  Master_Bind: 
			  Last_IO_Error_Timestamp: 
			 Last_SQL_Error_Timestamp: 
					   Master_SSL_Crl: 
				   Master_SSL_Crlpath: 
				   Retrieved_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:15-110037
					Executed_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:1-49896
						Auto_Position: 1
				 Replicate_Rewrite_DB: 
					 Channel_Name: 
			   Master_TLS_Version: 
		1 row in set (0.06 sec)	
			

			



