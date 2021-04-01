
MySQL binlog的几个作用：
	1. 主从复制
	
	2. 增量备份和数据恢复
		数据恢复：
			有全备+binlog，就可以构建延迟从库恢复误操作的数据。
		实现DML的闪回，衍生工具：binlog2sql，简单好用
		
	3. 异构系统同步
		
		MySQL二进制日志完整保存了一条记录的前项和后项记录，可以方便的写个DTS服务，将MySQL数据以准实时的方式同步到其他数据库系统，比如ES、HBase、Redis、Hive、Spark等，这个特性至关重要。
	
		
		https://mp.weixin.qq.com/s/4SEqhrJssxupu_a6AzAzRw 移除MySQL Binlog？亲，你根本不懂MySQL呐~~~

		
		官方若要移除二进制日志，意味着复制模块，MGR模块，全部重构。之前互联网上已跑着的高可用架构，需要大幅调整。
		
		
		