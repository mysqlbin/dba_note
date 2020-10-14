
0. 描述
1. delete 删除大表的造成从库的解决案例之一
3. 小结

0. 描述
	现象：
		1. 后台负责人在生产环境上执行 delete from t 命令删除200多W行的数据
		2. 在主库执行耗时约25S
		3. 通过监控发现从库有长事务和从库有延迟现象
		4. 通过主库的慢查询日志和mysqlbinlog解析binlog发现这是一个delete大事务
			也可以通过 information_schema.innodb_trx 命令来看事务已经执行的时间和操作了多少行数据。
		5. 发现表上没有任何索引
		
	解决办法：
		1. stop slave; 停止复制， 修改从库查找的参数为的 INDEX_SCAN 和 TABLE_SCAN， 然后再开启复制
			这种情况下有会一定的性能提升，之前测试过，操作的行记录过多，从库执行耗时也会比较久。
			
		2. stop slave; 停止复制， 在从库跳过这个delete大事务，然后手动执行删除全表数据的命令
		
		由于已经延迟了5分钟，通过 information_schema.innodb_trx 查看长事务的执行状态和需要回滚的行数
		
		然后及时止损， 执行 stop slave; 命令会卡住一会，因为在这种情况下执行该命令会回滚数据， 数据回滚完成后， stop slave; 也能停止下来了。
		
		
		
	1. 没有索引就添加索引
	2. 根据情况修改从库数据查找的参数
		一般用于表中没有任何索引的情况下。
	3. 在从库跳过这个大事务
	

1. delete 删除大表的造成从库的解决案例之一
	
	mysql> show slave status\G;
			Seconds_Behind_Master: 727
			   Retrieved_Gtid_Set: f7323d17-6442-11ea-8a77-080027758761:110689-161006
				Executed_Gtid_Set: 89f12dce-6828-11ea-9c33-080027fc8003:1,
									f7323d17-6442-11ea-8a77-080027758761:1-161005
	
	跳过事务
		set gtid_next='f7323d17-6442-11ea-8a77-080027758761:161006';
		begin;
		commit;
		set gtid_next=automatic;
	
	从库删除记录
		delete from sbtest1;
			root@localhost [sbtest]>delete from sbtest1;
			Query OK, 500000 rows affected (26.04 sec)
			
	开启复制	
		start slave;
	
	如果是更新，也可以跳过，然后拿update的SQL语句到从库执行就好了。
	
3. 小结
	
	监控长事务
	巡检脚本项中加入判断没有主键和没有二级索引的表
	除了技术总监和DBA，还给其它相关研发人员操作生产环境数据的权限
	
	INDEX_SCAN,HASH_SCAN 的生效时机
		stop slave;
		SET GLOBAL slave_rows_search_algorithms = 'INDEX_SCAN,HASH_SCAN';
		start slave;
		
		
	优化点：
		mysql> show global variables like '%log_slave_updates%';
		+-------------------+-------+
		| Variable_name     | Value |
		+-------------------+-------+
		| log_slave_updates | ON    |
		+-------------------+-------+
		1 row in set (0.00 sec)
		
		
		
		
		
		
		
		

	