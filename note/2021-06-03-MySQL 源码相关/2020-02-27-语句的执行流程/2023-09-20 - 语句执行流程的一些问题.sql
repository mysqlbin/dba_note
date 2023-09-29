
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

