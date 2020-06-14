


全局序列

join 查询   # 全局表

mycat 高可用


旧数据的迁移
	步骤：
		1. 通过mysqldump + where 备份依次备份单个大表的数据，然后再导入 Mycat
		2. 大表增量数据再依次导入
		3. 导入其它全局表的数据
		

Mycat 做读写分离 跟 做ProxySQL 读写分离的对比 


Mycat 如何使用 sysbench 做压测


对 MDL 锁的支持


对事务隔离级别的支持







