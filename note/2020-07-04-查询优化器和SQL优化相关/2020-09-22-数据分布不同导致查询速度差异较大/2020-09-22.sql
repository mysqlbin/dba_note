

语句的执行时间：

	select * from msg where operator=0 limit 10;   --0.01秒
	select * from msg where operator=99 limit 10;  --0.64秒

现状：
	1. 看了两条SQL语句的optimize strace，没什么差别。
	2. 根据提供的信息，觉得是跟数据分布有关。
	3. SQL语句用的是主键索引。
	4. 当前数据表的最大ID: 17244138，总记录数：1637927；看着是经常有删除表数据的操作。
	5. 一些统计信息：
		select count(*) from msg where id<15617303;   -- 记录数：13719
		select count(*) from msg where id between 15617303 and 15619769; -- 记录数：14
		select count(*) from msg where id<9763995;     -- 记录数：9153
		select count(*) from msg where id between 9763995 and 16726666;  -- 记录数：1111476

分析：
	select id from msg where operator=0 limit 10; 

		最小ID和最大ID分别为 15617303、15619769;
		select count(*) from msg where id<15617303;   -- 记录数：13719
		select count(*) from msg where id between 15617303 and 15619769; -- 记录数：14	
		也就是说根据主键ID从头开始扫描，只需要扫描 13719+14=13733 记录就可以返回数据。 
		

		
	select id from msg where operator=99 limit 10; 
		最小ID和最大ID分别为 9763995、16726666;
		select count(*) from msg where id<9763995;     -- 记录数：9153
		select count(*) from msg where id between 9763995 and 16726666;  -- 记录数：1111476
		也就是说根据主键ID从头开始扫描，需要扫描 9153+1111476=1120629 记录才可以返回数据。 
	
小结
	operator=0  limit 10 需要扫描 13733行记录；
	operator=99 limit 10 需要扫描 1120629行记录；
	这就是为什么 select * from msg where operator=0 limit 10; 语句执行很快的原因。
	主要还是跟数据的分布有关。
	
	
	
	
	
	
	

		
	







