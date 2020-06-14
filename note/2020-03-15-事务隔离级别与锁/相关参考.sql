

http://blog.itpub.net/7728585/viewspace-2146183/    Innodb:RR隔离级别下insert...select 对select表加锁模型和死锁案列


分析死锁一般要从死锁日志中获取如下信息

	1、加锁发生在主键还是辅助索引
	2、加锁的模式是什么
	3、是单行还是多行加锁
	4、触发死锁事务最后的语句
	5、死锁信息中事务顺序是怎么样的
	在重现的时候，必须要做到和线上死锁信息完全匹配那么这个死锁场景才叫测试成功了.
	
	
https://www.cnblogs.com/CQqfjy/p/12703029.html  手把手教你分析Mysql死锁问题

