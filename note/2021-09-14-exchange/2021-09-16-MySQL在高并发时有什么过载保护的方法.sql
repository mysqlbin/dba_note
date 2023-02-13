

1. 监控长事务，使用 pt-kill 工具，及时kill掉执行时间过长的语句
2. 读写分离(业务访问隔离)，一些相对大的查询，比如报表相关的查询，可以放到专用的从库去查
3. 及时优化慢SQL语句、优化死锁等
4. 设设置查询语句可以执行的最大时间，也就是设置 max_execution_time 参数， 5.7的新特性。

大事务, kill 掉后下次还有进来
	1. 设置大事务的超时时间，比如设置max_execution_time参数
	2. pt-kill 工具，及时杀掉引发性能问题的SQL。
	
	

别人的参考
	1、在前端Nginx层/中间件中限流，控制对MySQL的请求数。
	2、控制MySQL的参数max_connections/max_user_connections，防止过高并发。
	3、利用pt-kill等工具，及时杀掉引发性能问题的SQL。
	4、根据服务器的压力情况，适当调整MySQL的innodb_thread_concurrency参数。
	5、快速构建从库，缓解主库读压力。
	6、适当调整max_execution_time=N。当SQL语句超过N秒，不予执行。 MySQL 5.7的新特性.
	7、尽快优化慢SQL。
