


pt-table-checksum、pt-archiver 的策略都是分块处理工具，避免大事务

pt-table-checksum：
	1. 需要扫描指定库下的所有表的数据
	
原理
	


相关参考：
	https://mp.weixin.qq.com/s/N4FeV7_Vuug3F3VfmVEFCQ	 第13问：pt-table-checksum 到底会不会影响业务性能？
	https://www.modb.pro/db/56033   					 pt-table-checksum使用方法及主从一致性校验
	https://blog.51cto.com/u_10574662/1733788?xiangguantuijian&04	pt-table-checksum 原理解析
	
	
思考：
	1. pt-table-checksum 对SQL语句加的什么锁？
	2. 耗费的CPU资源和IO资源
	
	