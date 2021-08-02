
1. insert into select 语句的加锁

2. update join 关联更新语句的加锁

	RR/RC事务隔离级别下，驱动表的数据都是加写锁； 
	
	RC事务隔离级别下，关联到的被驱动表的数据不加锁；
	RR事务隔离级别下，关联到的被驱动表的数据加读锁；
	
		跟 insert into select 语句一样，RC事务隔离级别下， select 的语句不加锁; RR事务隔离级别下，select 的语句加读锁。
		
3. 读提交隔离级别下还有一个优化，即：语句执行过程中加上的行锁，在语句执行完成后，就要把 不满足条件的行 上的行锁直接释放了，不需要等到事务提交。  


4. RC和RR隔离级别最主要的区别是 RC和RR创建一致性视图的(read view)时机不一样：

	在可重复读隔离级别下，只需要在事务开始的时候创建一致性视图，之后事务里的其他查询都共用这个一致性视图；
	在读提交隔离级别下，每一个语句执行前都会重新算出一个新的视图。
	
5. 加锁的基本单位：
	RC为行锁
	RR为next-key锁
