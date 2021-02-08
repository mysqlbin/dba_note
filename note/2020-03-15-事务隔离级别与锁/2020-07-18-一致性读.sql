


一致性读（Consistent Reads）
	事务利用MVCC进行的读取操作称之为一致性读，或者一致性无锁读，或者一致性非锁定读，有的地方也称之为快照读。
	所有普通的SELECT语句（plain SELECT）在READ COMMITTED、REPEATABLE READ隔离级别下都算是一致性读，比方说：
	
		SELECT * FROM t;
		SELECT * FROM t1 INNER JOIN t2 ON t1.col1 = t2.col2
		
	一致性读并不会对表中的任何记录做加锁操作，其他事务可以自由的对表中的记录做改动。


By <工作面试老大难 —— 锁>