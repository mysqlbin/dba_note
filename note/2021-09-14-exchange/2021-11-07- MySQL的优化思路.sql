
1. 硬件层：CPU、磁盘、内存

2. 系统层：文件系统、内核参数
		open files
		max user processes
	
3. MySQL层：
	1. 参数
	2. SQL优化和慢查询优化
	3. 行锁和死锁优化
		
	1. 参数
		2021-09-15-列举至少三个InnoDB的优化参数并简要解释.sql
		加上 time_zone 时区参数
		
	
	2. SQL优化和慢查询优化

		先看语句的执行计划

			1. key列
				表示语句使用到的索引，可以知道使用了联合索引的前几列

			2. rows 
				预计扫描的行数
				
			3. extra
				using index: 是否使用到覆盖索引
				using temporary： group by分组字段没有索引，使用到了临时表
				using filesort ：排序字段没有索引，如果排序需要的空间大于sort_buffer_size，就需要产生磁盘临时表。
				Using intersect：使用到了索引合并扫描
				using join buffer: 被驱动表的关联字段没有索引
				
		
		实际的优化案例
			1. in里面的个数太多，改为 join 
			2. 分页优化，先通过覆盖索引查询出主键，再根据主键跟原表做关联查询
				
	3. 行锁和死锁优化	
		1. 事务要及时提交
		2. 事务内的SQL语句，要按照相同的加锁次序执行
		3. 不需要保证可重复读的场景，可以使用RC事务隔离级别，避免因为使用RR可重复读事务隔离级别，由于gap lock的存在，加大死锁产生的概率。 
		
		
4. 流程制度

5. 架构
		
		
Schema设计规范:
1、所有的innodb表都设计无用途的自增列做主键

