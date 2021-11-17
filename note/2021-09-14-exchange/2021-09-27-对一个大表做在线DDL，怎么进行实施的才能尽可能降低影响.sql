


DDL 大体上分为 操作字段 和 操作索引：
	
	1. 操作字段：
		添加和删除字段，需要重建表
		小表直接Online DDL了
		大表可以使用第3方工具 pt-osc(主键自增长锁的参数值要设置为2，减少发生死锁的概率) 或者 gh-ost 来做(从库要设置为非双1，避免主从延迟。大表做了按天分表之后，一些不是很重要的游戏日志数据使用MongoDB来存储，就很少使用第3方工具来做DDL操作了)， 8.0 版本支持快速加列
		
		-- 从库binlog和redo刷盘的参数，要设置为非双1，避免主从延迟过大。
		-- 1个项目可以用2种数据库来存储，比如一些不是很重要的游戏日志数据，异步写到MongoDB中进行存储
		
		只修改字段名称，不修改默认值并不会重建表，只是修改了 .frm 表结构文件。
		
		修改字段名称，并且修改默认值，需要重建表。
		
		修改字段默认值，老的值不会发生改变，需要重建表。
			-- 修改字段默认值，需要重建表。
	
	
	2. 操作索引：
		索引的添加和删除，不需要重建表，但是添加索引需要扫描全表的数据。
		添加索引：关闭会话级别的binlog，分别在主从执行，避免导致主从延迟。
		删除索引：直接在主库执行，因为删除索引的执行速度很快，毫秒级别。原理：打删除标记，由 后台 purge 线程真正删除索引。
		
		
		
	
	

