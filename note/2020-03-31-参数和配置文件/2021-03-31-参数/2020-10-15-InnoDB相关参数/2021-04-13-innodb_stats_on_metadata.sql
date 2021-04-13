
有两种方式可以设置为非持久化统计信息：
	1). 全局变量: INNODB_STATS_PERSISTENT=OFF
	2). CREATE/ALTER表的参数： STATS_PERSISTENT=0

仅当优化器统计信息配置为非持久性时，此选项才适用。


启用innodb_stats_on_metadata时，当元数据语句（例如SHOW TABLE STATUS）或访问INFORMATION_SCHEMA.TABLES或INFORMATION_SCHEMA.STATISTICS表时，InnoDB将更新非持久统计信息。 （这些更新类似于ANALYZE TABLE的情况。）
禁用时，InnoDB不会在这些操作期间更新统计信息。 禁用该设置可以提高具有大量表或索引的架构的访问速度。 它还可以提高涉及InnoDB表的查询的执行计划的稳定性。


非持久化统计信息在以下情况会被自动更新：
	1. 执行ANALYZE TABLE
	2. innodb_stats_on_metadata=ON情况下，执SHOW TABLE STATUS, SHOW INDEX, 查询 INFORMATION_SCHEMA下的TABLES, STATISTICS
	3. 启用--auto-rehash功能情况下，使用mysql client登录
	4. 表第一次被打开
	5. 距上一次更新统计信息，表1/16的数据被修改


