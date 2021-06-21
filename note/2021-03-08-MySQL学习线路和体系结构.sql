
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
	1. MySQL 的体系结构可以划分为2层
	
	2. Server层
		
		1. binlog日志
		
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
			表空间 
			段
			区
			数据页
			行
			1.表空间组成
			  表空间是由索引组成，每个索引2个segment(非叶子节点段，叶子节点段);
			  segment有多个组组成，每个组256个extent，每个extent 1M;
			  extent由页面组成，每个extent有64个页面，每个页面16k;
			  页面由一行一行数据组成;
			总结:表空间====>段====>组====>簇(区)====>页面====>行====>列。
					
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
	


