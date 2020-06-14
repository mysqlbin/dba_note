


5.6/5.7的视图
	information_schema.innodb_trx;
	information_schema.innodb_locks;
	information_schema.innodb_lock_waits;
5.7以上才有的视图：
	sys.innodb_lock_waits;
	sys.schema_table_lock_waits;
8.0下可用的视图
	information_schema.innodb_trx;
	Performance_Schema.data_locks
	Performance_Schema.data_lock_waits 

	select * from performance_schema.data_lock_waits;
	select * from information_schema.innodb_trx\G;
	show processlist;
	
	
sys.innodb_lock_waits 的解读

系统库下视图的相关参考：

https://blog.csdn.net/yuyinghua0302/article/details/82318408    数据库事务和锁（三）——INNODB_LOCKS, INNODB_LOCK_WAITS, INNODB_TRX表的简单介绍


MySQL 5.7 
	select * from information_schema.innodb_trx\G;
	select * from information_schema.innodb_locks\G;
	select * from information_schema.innodb_lock_waits\G;
	SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
MySQL 8.0.19
	select version();
	select @@global.transaction_isolation;
	select @@session.transaction_isolation;
	
	select * from information_schema.innodb_trx\G;
	SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;
	
	pager less
	select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	

select version();
select @@global.transaction_isolation;
select @@session.transaction_isolation;	
	




select version();
select @@global.tx_isolation;
select @@session.tx_isolation;	










































*************************** 1. row ***************************
                          ENGINE: INNODB
       REQUESTING_ENGINE_LOCK_ID: 139859108162416:252:1840:312:139858345334816
REQUESTING_ENGINE_TRANSACTION_ID: 870401
            REQUESTING_THREAD_ID: 2145
             REQUESTING_EVENT_ID: 29
REQUESTING_OBJECT_INSTANCE_BEGIN: 139858345334816
         BLOCKING_ENGINE_LOCK_ID: 139859108163288:252:1840:312:139859033420744
  BLOCKING_ENGINE_TRANSACTION_ID: 870406
              BLOCKING_THREAD_ID: 2145
               BLOCKING_EVENT_ID: 29
  BLOCKING_OBJECT_INSTANCE_BEGIN: 139859033420744
