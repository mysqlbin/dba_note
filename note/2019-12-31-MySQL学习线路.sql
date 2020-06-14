
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
	1. 索引
	2. 各种锁
	3. InnoDB 存储引擎
		3.1. 逻辑存储结构
			表空间 
			段
			区
			数据页
			行
			
		3.2. 4个后台主线程
			
			master thread
				checkpoint
			io thread
				insert buffer thread 
				log thread
				write thread
				read thread
			purge thread    #已整理
				undo log
			merge thread    #已整理
				merge change buffer   
				

		3.3. 关键特性
			change buffer
			AHI 自适应哈希索引
			double write buffer
			预读
			刷相邻页
			
		3.4. buffer pool缓冲池
		
		3.5 日志：redo log 、undo log
				
		
工具:
	pstack
	


