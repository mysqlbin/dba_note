
1. Online DDL 有几种类型	
	copy算法
	inplace算法
	instant算法
	
	-----------------------------------------------------------------------------
	
	ALGORITHM=COPY：采用拷表方式进行表变更，与pt-osc/gh-ost类似；
	ALGORITHM=INPLACE：仅需要进行引擎层数据改动，不涉及Server层；
	ALGORITHM=INSTANT：与第一种方式类似，仅修改元数据。目前仅支持在表最后增加新列；

2. 5.7 Online DDL 添加和删除字段，需要锁表吗
	
	不会
	
	对大表直接做Online DDL, 我说会导致主从延迟，他说不会。这个没必要争执，大家都有自己的见解。
	pt-osc 来做，从库设置为非双1，不会导致主从延迟。 他说会。
	

3. 处理主从延迟的时候
	
	我用的是 drop table + create  table ， 没有用 truncate table， 因为 drop table 比 truncate table  性能高， drop table 不需要扫描 lru list 的数据。
	
	
	 
4. 用的是RDS 与 开发相关

	需要做自动化运维、自动化发布
	
	开源的运维平台有哪些，这个我忘记了
		Yearning
		Archery 
		db_platform
		inception
		goinception

	
	之前用Django 写过2个功能：
		主要技术栈罗列一下
		show processlist 结果的展示 和 kill 线程
		展示慢查询功能
	ansible 有用过

	
5. 监控
	普罗米修斯
	

6. 口述了物理备份的逻辑



7. 分表自己做的工作



主要是想有更大的提升，跟目前的公司没什么纠纷。
还没有数据库上云的机会，还是想往这方面发展。







