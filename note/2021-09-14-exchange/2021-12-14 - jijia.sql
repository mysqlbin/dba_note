
1. Online DDL 有几种类型
		
	copy算法
	inplace算法
	instant算法
	
	-----------------------------------------------------------------------------
	
	ALGORITHM=COPY：采用拷表方式进行表变更，与pt-osc/gh-ost类似；
	ALGORITHM=INPLACE：仅需要进行引擎层数据改动，不涉及Server层；
	ALGORITHM=INSTANT：与第一种方式类似，仅修改元数据。目前仅支持在表最后增加新列；

2. 5.7 Online DDL 添加和删除字段，需要锁表吗
	
	需要加MDL写锁。会阻塞DML和SELECT请求。
	
	对大表直接做Online DDL, 我说会导致主从延迟，他说不会。这个没必要争执，大家都有自己的见解。
	pt-osc 来做，从库设置为非双1，不会导致主从延迟。 他说会。
	
	
	看下 rebuild 和 no rebuild 的流程。



3. 处理主从延迟的时候
	
	我用的是 drop table + create  table ， 没有用 truncate table， 因为 drop table 比 truncate table  性能高， drop table 不需要扫描 lru list 的数据。
	
	
	 
4. 用的是RDS 与 开发相关

	需要做自动化运维、自动化发布
	
	开源的运维平台有哪些，这个我忘记了
		Yearning
		Archery 
		db_platform
		回答了下面的2个
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
	漏了备份非事务引擎文件的过程，后面补充的。
	
	
7. 分表自己做的工作


8. 刚介绍到 “日常的更新发布工作等等，持续保障数据库的平衡运行。” 这里， 就被打断了，面试官想抓重点来问。



主要是想有更大的提升，跟目前的公司没什么纠纷。
想往云上发展，毕竟云是大势所趋了。













写了MongoDB，但是问到新版本相关特性的时候，只回答了：
	4.0 开始支持在后台添加索引，需要指定 background=true参数， 4.2 不需要指定这个参数。  

	补充：
		4.0 支持副本集事务
		4.2 支持分片事务
		5.0 支持在线数据重新分片
		
		









































一样样来解决，先有行动。






