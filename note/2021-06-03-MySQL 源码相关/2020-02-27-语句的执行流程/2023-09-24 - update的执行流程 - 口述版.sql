

一、Server层
	
二、InnoDB存储引擎层

	1. 执行阶段
		数据页加载到缓冲池
		加排他锁
			两阶段加锁协议
		写日志：
			undo
			redo
			binlog
		修改值
			
	2. commit阶段
		
		两阶段提交协议
			redo、binlog刷盘
			
		释放锁
			
		