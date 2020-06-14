

部分改进和特性:
	1. 增强系统可运维性，增加管理员连接地址，在MySQL系统连接满的情况下，管理员可以通过admin_address登录数据库进行维护操作。其实这个有

	2. 支持账号设置双密码，修改底层密码时系统可以更平滑，提供系统安全性和稳定性。例如：

		ALTER USER 'appuser1'@'host1.example.com' IDENTIFIED BY 'password_b' RETAIN CURRENT PASSWORD;

	3. 之前的8.0版本是系统默认创建2个undo表空间，新版本支持创建额外的undo表空间并且可以在运行时删除额外的undo表空间。
		
		create undo tablespace tablespace_name add datefile 'file_name.ibu';

		drop undo tablespace tablespace_name;

	   还可以通过alter命令动态的设置undo 表空间的ACTIVE|INACTIVE状态。


	4. 当 innodb_dedicated_server 为开启时，log file的数量和大小可以根据系统的buffer pool size 自动调整。
		之前的版本是根据os系统的内存大小设置的，而且log file的数量不是自动调整的。注意: 如果不是独享物理机，官方文档并不推荐打开该参数。具体可以参考官方文档。
		
	5. alter table命令支持in-place的方式修改字符集了，不过需要满足如下三个条件:

		a. 字符集类型是char，varchar，text或者enum

		b. 字符集类型从utf8mb3 修改为utf8mb4,或者由任意字符集修改为binary

		c. 被修改的字段非索引字段。
		
	6. MRG新增控制集群数据一致性读写的参数  group_replication_consistency ，防止集群容灾切换时，新的主库没有应用完backlog，业务请求访问新的主库可能会读取老的数据。
		该参数有四个值:EVENTUAL,BEFORE_ON_PRIMARY_FAILOVER,BEFORE,AFTER,BEFORE_AND_AFTER。
	
		默认为  EVENTUAL ,可以不等日志应用完成即可读写。如果设置为 BEFORE_ON_PRIMARY_FAILOVER 则新的读写请求会被阻塞住，直到日志被应用完成。
		相关参考:
			https://mp.weixin.qq.com/s?__biz=MzU2NzgwMTg0MA==&mid=2247484255&idx=1&sn=23d319be0029f65d67cc25fce514b27b&chksm=fc96e1c0cbe168d629deb259a634b5cf93c2ec40fac0d1933904ebf45efefc3b2b00cc8465af&scene=21#wechat_redirect
		
	7. 并行查询
		支持并发聚族索引读取，提高 check table 的速度。其并发数量由innodb_parallel_read_threads 控制，默认是4，需要注意的是该功能不支持辅助索引。
		InnoDB 目前支持在 clustered index 上进行并行查询，提供 innodb_parallel_read_threads ，https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_parallel_read_threads，参数控制session内的并行度。
		
			
相关参考:
	https://mp.weixin.qq.com/s/rqI7ZFoJWyKz1sAaOUs4BQ   MySQL 最新的release notes
	https://mp.weixin.qq.com/s/nQKxQUirbhwoesA9lzQF6A   MySQL 8.0.14版本新功能详解 
	
	
