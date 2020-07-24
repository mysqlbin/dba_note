


大表的大小：

	索引长度： 0.50 GB
	数据长度： 1.93 GB (2,073,034,752)
	
对大表进行Online DDL，提示：
	
	添加6个索引
	
	alter table table_clubaaaabbbbbdetail_history
	add index `idx_szToken` (`szToken`(28)),
	add index `idx_tEndTime` (`tEndTime`),
	add index `.....` (`..`,`..`),
	add index `.....` (`..`,`..`,`..`),
	add index `.....` (`..`,`..`,`..`),
	add index `.....` (`..`,`..`);
	
	
	ERROR 2013 (HY000): Lost connection to MySQL server during query


配置
	innodb_buffer_pool_size = 8G


/var/log/messages
	Jul 24 16:03:53 database-03 kernel: Out of memory: Kill process 3096 (mysqld) score 924 or sacrifice child
	Jul 24 16:03:53 database-03 kernel: Killed process 3096 (mysqld) total-vm:10733904kB, anon-rss:3582864kB, file-rss:0kB, shmem-rss:0kB


物理内存大小
	shell> free -h
				  total        used        free      shared  buff/cache   available
	Mem:           3.7G        497M        2.8G        5.9M        442M        3.0G
	Swap:            0B          0B          0B






