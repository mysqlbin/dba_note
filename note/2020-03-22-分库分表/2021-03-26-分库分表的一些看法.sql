


关于分库分表的一些看法：

	大部分的业务场景，几乎都是日志表的体积量相对较大，如果真的要分库分表，对日志表做分表就好了，也可以用拆分的思路，把一些独立的日志大表，用MongoDB来存储(异步写MongoDB)。
	
	日志表，数据保留半年-1年，历史数据可以迁移到历史库中。
	
	维护分布式架构比维护集中式架构，复杂得多。
	
	
	字段拆分为2个表的缺点：多了一次事务提交。
	
	
	分库分表的难题：分布式事务、非分片键的查询 
	
	同时，分布式数据库的特点还会引发其他很多问题，比如非分区键的二级索引访问、分布式事务、JOIN关联查询、子查询等。
		https://mp.weixin.qq.com/s/CiirYDEaRh0ul4r_QUi91w
		
https://mp.weixin.qq.com/s?__biz=MjM5MjIxNDA4NA==&mid=401323641&idx=1&sn=a49d44b8b67f529557e99094cb6453e9&scene=21#wechat_redirect   你的系统真的需要分布式数据库架构吗？

https://mp.weixin.qq.com/s/4I-byGqVD1YQZwsm3UqxrA   MYSQL 中间件分表是一个好主意？

		
	
	最后，有机会还是要用的。
	
	