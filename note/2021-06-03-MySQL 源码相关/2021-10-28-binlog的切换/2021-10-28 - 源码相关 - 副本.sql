
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
		
	 mysql_mutex_unlock(&LOCK_index);






概括：
1）在日志切换期间需要获取全局mutex，此时数据库无法写入
2）收集所有要清理binlog文件中的gtid，并维护到gtid_purged，期间无法写入
3）删除binlog文件操作涉及到剧烈io波动，如果文件数很多，需要花费较长的时间，此时会影响业务的响应时间
	-- 验证下，删除大量的binlog，占用的磁盘IO如何
	

◆ mysql_mutex_lock
#define mysql_mutex_lock	(	 	M	)	   mysql_mutex_lock_with_src(M, __FILE__, __LINE__)

Instrumented mutex_lock.

mysql_mutex_lock is a drop-in replacement for pthread_mutex_lock.

Parameters
M	The mutex to lock

https://dev.mysql.com/doc/dev/mysql-server/latest/group__psi__api__mutex.html#ga340bf8f49d0cbaa994eaf5fb1fc7a22f





https://mp.weixin.qq.com/s/XSnFkuYzIlGWMaXIl-oPeQ

https://www.jianshu.com/p/8611e248a493

https://blog.csdn.net/weixin_30490029/article/details/113168543  mysql expire_mysql expire_logs_days是怎么生效的



