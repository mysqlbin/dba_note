

0. 环境
1. 初始化表结构和数据
2. 事务执行流程
3. 查看锁的信息
4. session A的加锁范围
5. 本案例下RR隔离级别的锁详情


0. 环境
	MySQL 8.0.19 版本
	RC隔离级别

1. 初始化表结构和数据

	drop table if exists t1 ;
	CREATE TABLE `t1` (
	  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
	  `t1` int(10) NOT NULL COMMENT '',
	  `t2` int(10) NOT NULL COMMENT '',
	  `order_no` varchar(64) NOT NULL DEFAULT '' COMMENT 'order no',
	  `status` int(10) NOT NULL COMMENT '',
	  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
	  PRIMARY KEY (`ID`),
	  KEY `idx_order_no` (`order_no`),
	  KEY `idx_status` (`status`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COMMENT='';

		
	INSERT INTO `t1` (`ID`, `t1`, `t2`, `order_no`, `status`, `createtime`) VALUES ('1', '1', '1', '123456', '0', '2020-04-23 17:28:45');
	

2. 事务执行流程
	session A                  					session B

	begin; 
	select * from t1 where order_no='123456' for update; 

												begin;
												UPDATE t1 SET status = 5 WHERE status=0;
												
												
												
												
select * from information_schema.innodb_trx\G;
SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits\G;

pager less
select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;



		