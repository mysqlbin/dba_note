

https://juejin.im/post/5ede6436518825430c3acaf4  MySQL 事务   --把MySQL实战45讲相关的知识点口述出来了


https://mp.weixin.qq.com/s/vkTb1E2in67JdG_Hk6SlOg  MySQL 四万字精华总结 + 面试100 问，和面试官扯皮绰绰有余  --2020-07-16

	跟着题目先自己讲给自己听，看看自己会满意吗，不满意就继续学习这个点，如此反复

https://www.jianshu.com/p/a59fe4fcddfb  史上最详细的一线大厂Mysql面试题详解



若是没有索引的条件下，就获取所有行，都加上行锁，然后Mysql会再次过滤符合条件的的行并释放锁，只有符合条件的行才会继续持有锁。
	只有符合条件的行才会继续持有锁，这个是在RC隔离级别的优化。
		
		