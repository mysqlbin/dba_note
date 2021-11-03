
1. 简化版代码
	NOTE: Run purge_logs wo/ holding LOCK_log because it does not need
			  the mutex. Otherwise causes various deadlocks.
			  
			注意：运行 purge_logs wo/持有 LOCK_log 因为它不需要互斥锁。 否则会导致各种死锁。


			
	int MYSQL_BIN_LOG::rotate_and_purge(THD* thd, bool force_rotate)

		mysql_mutex_lock(&LOCK_log);     -- 会阻塞DML和select吗
		
		error= rotate(force_rotate, &check_purge);
	  
		mysql_mutex_unlock(&LOCK_log);

		if (!error && check_purge)
			purge();


	int MYSQL_BIN_LOG::rotate(bool force_rotate, bool* check_purge)


	void MYSQL_BIN_LOG::purge()

		  purge_logs_before_date(purge_time, true);

	int MYSQL_BIN_LOG::purge_logs_before_date(time_t purge_time, bool auto_purge)

		 mysql_mutex_lock(&LOCK_index);
		 -- 遍历删除binlog
			while (!(log_is_active= is_active(log_info.log_file_name)))
				if (!mysql_file_delete(key_file_binlog, log_info.log_file_name, MYF(0)))       
				/*删除binlogfile，如果积累很多binlog很容会占用大量的磁盘io，虽然此时可以写入但是也会影响业务*/
		 mysql_mutex_unlock(&LOCK_index);


2. 流程整理
	
			
	int MYSQL_BIN_LOG::rotate_and_purge(THD* thd, bool force_rotate)

		mysql_mutex_lock(&LOCK_log);     -- 会阻塞DML和select吗
		
		error= rotate(force_rotate, &check_purge);
	  
		mysql_mutex_unlock(&LOCK_log);
		
		/*如果需要则执行purge*/
		if (!error && check_purge)
			purge();

			void MYSQL_BIN_LOG::purge()

				  purge_logs_before_date(purge_time, true);
				
					int MYSQL_BIN_LOG::purge_logs_before_date(time_t purge_time, bool auto_purge)

						 mysql_mutex_lock(&LOCK_index);
						 -- 遍历删除binlog
							while (!(log_is_active= is_active(log_info.log_file_name)))
								if (!mysql_file_delete(key_file_binlog, log_info.log_file_name, MYF(0)))       
								/*删除binlogfile，如果积累很多binlog很容会占用大量的磁盘io，虽然此时可以写入但是也会影响业务*/
						 mysql_mutex_unlock(&LOCK_index);
					 



4. 	mysql_mutex_lock	

	◆ mysql_mutex_lock
	#define mysql_mutex_lock	(	 	M	)	   mysql_mutex_lock_with_src(M, __FILE__, __LINE__)

	Instrumented mutex_lock.

	mysql_mutex_lock is a drop-in replacement for pthread_mutex_lock.

	Parameters
	M	The mutex to lock

	https://dev.mysql.com/doc/dev/mysql-server/latest/group__psi__api__mutex.html#ga340bf8f49d0cbaa994eaf5fb1fc7a22f




