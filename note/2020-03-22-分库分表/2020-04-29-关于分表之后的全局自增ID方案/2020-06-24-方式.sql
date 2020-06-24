

1. 方式1

	DROP TABLE IF EXISTS `get_table_clublogscore_id`;
	CREATE TABLE `get_table_clublogscore_id` (
	  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB AUTO_INCREMENT=7366392 DEFAULT CHARSET=utf8mb4 COMMENT='';

	INSERT INTO get_table_clublogscore_id () values ();
	return @@identity;
	
	这种方式在高并发情况下会有性能影响，额外增加了一次 get_table_clublogscore_id.id 刷盘。
	
	
2. 	方式2
	基于Redis Incr分配自增ID
	
	就算有Redis 高可用，当Redis 宕机进行切换期间会影响业务。 
	
3. 方式3 
	(REPLACE(unix_timestamp(current_timestamp(3)),'.','') * 1000) + FLOOR(1 + (RAND() * 9999));	
	这种方式会有主键冲突的可能
	
4. 方式4 
	
	每个表分配根据 1970-01-01 至 当前日期 相差的天数 * 1亿 开始的主键， 每个表的ID还是自增的。
	
	-- 目前用的是这种方式， 这种方式适合当前业务 。
	
	
	
	


	
			
				