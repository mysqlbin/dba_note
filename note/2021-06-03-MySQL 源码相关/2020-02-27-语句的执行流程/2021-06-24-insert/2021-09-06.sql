

mysql> show global variables like '%iso%';
+-----------------------+-----------------+
| Variable_name         | Value           |
+-----------------------+-----------------+
| transaction_isolation | REPEATABLE-READ |
| tx_isolation          | REPEATABLE-READ |
+-----------------------+-----------------+
2 rows in set (0.01 sec)

mysql> select version();
+------------------+
| version()        |
+------------------+
| 5.7.26-debug-log |
+------------------+
1 row in set (0.00 sec)



use mysqlslap;
create table t_20210906(id int NOT NULL AUTO_INCREMENT , PRIMARY KEY (id));
insert into t_20210906(id) values(1),(10),(20),(50);

---------------------------------------------------------------------------------------------------

-- 先select后insert

	session A 							session B
	begin;								begin;	

										select * from t_20210906 where id = 30 lock in share mode;
	
	insert into t_20210906(id) value(30);	
	(Blocked)
	-- 被间隙锁阻塞								
	commit;	
										select * from t_20210906 where id = 30 lock in share mode;


	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	| 140138352831952:1073:140138273376744   |                 55075 |        67 | t_20210906  | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
	| 140138352831952:16:4:5:140138273373816 |                 55075 |        67 | t_20210906  | PRIMARY    | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 50        |
	-- 被(20, 30) 的间隙锁阻塞
	| 140138352831080:1073:140138273370792   |       421613329541736 |        65 | t_20210906  | NULL       | TABLE     | IS                     | GRANTED     | NULL      |
	| 140138352831080:16:4:5:140138273367752 |       421613329541736 |        65 | t_20210906  | PRIMARY    | RECORD    | S,GAP                  | GRANTED     | 50        |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
	4 rows in set (0.00 sec)

									
---------------------------------------------------------------------------------------------------

-- 先insert后select 

	session A 							session B
	begin;								begin;	
	insert into t_20210906(id) value(30);
										select * from t_20210906 where id = 30 lock in share mode;
										(Blocked)
										-- 被id=30的X锁阻塞
	commit;	
										select * from t_20210906 where id = 30 lock in share mode;
										

	mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| ENGINE_LOCK_ID                         | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE     | LOCK_STATUS | LOCK_DATA |
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	| 140138352831080:1073:140138273370792   |                 55073 |        65 | t_20210906  | NULL       | TABLE     | IX            | GRANTED     | NULL      |
	| 140138352831080:16:4:6:140138273367752 |                 55073 |        67 | t_20210906  | PRIMARY    | RECORD    | X,REC_NOT_GAP | GRANTED     | 30        |
	| 140138352831952:1073:140138273376744   |       421613329542608 |        67 | t_20210906  | NULL       | TABLE     | IS            | GRANTED     | NULL      |
	| 140138352831952:16:4:6:140138273373816 |       421613329542608 |        67 | t_20210906  | PRIMARY    | RECORD    | S,REC_NOT_GAP | WAITING     | 30        |
	-- 被id=30的X锁阻塞
	+----------------------------------------+-----------------------+-----------+-------------+------------+-----------+---------------+-------------+-----------+
	4 rows in set (0.00 sec)

		
				
-- 先 insert 后 select - 特殊
					
	执行 insert 语句时，从判断是否有锁冲突，到写数据，这两个操作之间还是有时间差的：	
		如果 select...lock in share mode 的请求发生在 insert 申请完插入意向锁之后，写数据之前，这时候 GAP 锁和插入意向锁是不冲突的
		然后 insert 语句写数据，加 X 记录锁，因为记录锁和 GAP 锁也是不冲突的，所以 insert 成功插入了一条数据
		所以当 insert 成功插入后，把事务1提交了，再次执行 select...lock in share mode ，如果查到 id=3 的数据，是不是意味着出现了幻读。
		
		-- 就是这里没有搞懂
		-- 现在有点眉目了
		
	假设的场景如下：
		session A 							session B															LOCK
		begin;								begin;	

		insert into t_20210906(id) value(30);																	lock_mode X locks gap before rec insert intention
		-- 数据未插入
		-- 先申请到插入意向锁
											select * from t_20210906 where id = 30 lock in share mode;			lock_mode S locks gap before rec
											-- 请求发生在 insert 申请完插入意向锁之后，写数据之前
											-- 申请到 gap lock：(20, 30), gap lock 和 插入意向锁不冲突
											-- return 0 records
			
		insert into t_20210906(id) value(30);																	lock_mode X locks rec but not gap 
		-- 申请到 id=30 的X锁
		-- 插入完成
		
		commit;	
											select * from t_20210906 where id = 30 lock in share mode;			lock_modes S locks gap before rec	
											-- return 1 records：id=30
											(幻读？)








				