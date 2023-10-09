

0. 前言
	还是无法构建MySQL知识网络，
	https://baijiahao.baidu.com/s?id=1700060219559369227&wfr=spider&for=pc 在碎片化阅读时代，我们更需要系统性学习
	https://www.zhihu.com/question/67033491        为什么学习任何知识都需要系统化！系统的学习为什么那么重要？本质是什么？系统化学习的原理是什么？
	
	
	我们的人脑就像是一个“关系型数据库”。意思是，我们能记住的新知识，都依赖于大脑中已有的旧知识。只有当新知识和旧知识产生了联结，我们才能真正记住新知识。
	
	
	阅读了非常多的MySQL书籍以及文章，但是相关的知识点没有形成体系，过一段时间没有学习，又很容易忘记； 所以需要系统性学习。
	系统性学习的好处在于，它能将知识连成线，织成网。这样，既能让所学的知识更全面、深入，也能掌握得更牢固。
	通过梳理一条update语句的执行流程，建立知识体系

1. Online DDL为什么要MDL元数据写锁？
	对表加MDL写锁，阻塞读写请求
	内部需要创建2个文件：
		创建临时文件，用于存储原表的数据
		创建临时日志文件，用于存储增量数据
		
	
	用临时文件替换表A的数据文件。新旧表的切换，需要加MDL写锁，会造成秒级的写阻塞，不会造成死锁。
        防止有增量数据写入，导致无法做新旧表的切换。
		
	-- 如果不加MDL元数据写锁，会有什么问题？
	
	
2. 在MySQL5.5.3之前，有一个著名的bug#989，大致如下:
 
	 session1:                  session2:               
	 BEGIN;
	 INSERT INTO t ... ;
								DROP TABLE t;
	 COMMIT; 	


	然而上面的操作流程在binlog记录的顺序是 

	 DROP TABLE t; 
	 
	 BEGIN;  
	 INSERT INTO t ... ; 
	 COMMIT;


	很显然备库执行binlog时会先删除表t，然后执行insert 会报1032 error，导致复制中断。

	为了解决该bug,MySQL 在5.5.3引入了MDL锁（metadata lock），来保护表的元数据信息，用于解决或者保证DDL操作与DML操作之间的一致性。

	
	这个场景下，会导致复制中断吗

	insert into  t ...;  表t不存在，是会语法报错，而不会导致复制中断吧   -- 这里需要找个环境，验证下。
	
	

3. change buffer 跟 脏页的关系

	等到下次有其他sql需要读取该二级索引时，再去与二级索引做merge
	
	
4. GTID 是在哪一个步骤生成的
	

5. ibdata1系统表空间的逻辑结构，也是 表空间 -》 段 -》 区 -》 页 -》 行吗


6. InnoDB buffer pool 
	free list 的大小
	
	flush list脏页链表的大小：
		最多可占用缓冲池的75%；由参数 innodb_max_dirty_pages_pct 控制。
	
	
7. 双1参数的理解，可以画个图理解下

8. InnoDB的逻辑存储结构

9. 两阶段加锁协议
	如果没有两阶段加锁协议，会有什么问题？
	无法保证数据的一致性； 事务之间相同的锁资源，无法实现串行执行。
	
		session A           session B
		begin;
		select * from t where id=1 for update;
		(Query OK)
		
		select counts from t2 where id=3;
		
							begin;
							select * from t where id=1 for update;
							(Query OK)
							
		update t set counts = counts where id=1;	
			
							select counts from t2 where id=3;
							
							update t set counts = counts where id=1; 
							(Query OK)
							

10. lru 热区的数据会被淘汰掉吗
	
	一直往热区加载数据，lru 的大小可是有限的。
	
	
11. 并发复制，是在主库开启还是从库开启


雄哥的总结、理解、表达能力 还是 非常好的。

