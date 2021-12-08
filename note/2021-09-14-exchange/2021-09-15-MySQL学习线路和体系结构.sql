
实战:
	1. 权限管理
	2. 数据类型
	3. 备份与恢复
	4. 主从复制: 基于位点, 基于GTID
	5. Keeplavied 高可用
	6. MHA高可用
	7. MGR高可用
	8. ProxySQL 

优化:
	1. MySQL 的体系结构可以划分为2层   -- 结合一条语句的执行流程
	
	2. Server层
		
		1. 日志有: binlog日志, 错误日志, 慢查询日志
		
		2. 细分
			连接器
			分析器
			优化器
			执行器
			
		3. 锁
			全局读锁、MDL元数据锁
		
	3. InnoDB存储引擎层
	
		存储引擎层负责数据的存储和提取
		
		3.0 B+树数据结构
			
		3.1 事务和事务隔离级别
		
		3.2 索引
		
		3.3 锁
			
		3.4 逻辑存储结构
			表空间：共享表空间、独立表空间
			段：叶子索引段、非叶子索引段，回滚段
			区：每个区的大小为1MB，由64个连续的数据页组成
			数据页：默认是16KB的大小，由一行行记录组成
			行
			
					
		3.5 4个后台主线程
			master thread
				checkpoint
				
			io thread
				insert buffer thread 
					merge change buffer   
				log thread
				write thread
				read thread
				
			purge thread   
				undo log
				
			page cleaner thread    
				
		3.6 关键特性
			change buffer
			AHI 自适应哈希索引
			double write
			预读、预写、预热
			刷相邻页
			
		3.7 buffer pool缓冲池
		
		3.8 事务日志：redo log 、undo log
				
		
工具:
	pstack
	


