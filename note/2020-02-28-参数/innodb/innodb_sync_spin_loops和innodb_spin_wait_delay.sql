

mysql> select version();
+------------+
| version()  |
+------------+
| 5.7.26-log |
+------------+
1 row in set (0.00 sec)


innodb_sync_spin_loops
innodb_spin_wait_delay



innodb_sync_spin_loops
	mysql> show global variables like '%innodb_sync_spin_loops%';
	+------------------------+-------+
	| Variable_name          | Value |
	+------------------------+-------+
	| innodb_sync_spin_loops | 30    |
	+------------------------+-------+
	1 row in set (0.02 sec)

	含义：
		The number of times a thread waits for an InnoDB mutex to be freed before the thread is suspended.
		在挂起线程之前，线程等待释放InnoDB互斥锁(mutex)的次数。
		
		如果在循环过程中，一直未得到锁释放的信息，则其转入 os wait，即线程进入挂起(suspended)状态
		
	相关参考：
		https://www.cnblogs.com/lonelyxmas/p/9825431.html            MySQL SYS CPU高的案例分析（一）     # Perf Stat 或者  pstack 工具用起来
		https://blog.csdn.net/shaochenshuo/article/details/51881501  MySQL数据库SYS CPU高的可能性分析
		https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_sync_spin_loops  
		

innodb_spin_wait_delay
	为了防止自旋锁循环过快，耗费CPU，MySQL中引入了 innodb_spin_wait_delay 参数
	mysql> show global variables like '%innodb_spin_wait_delay%';
	+------------------------+-------+
	| Variable_name          | Value |
	+------------------------+-------+
	| innodb_spin_wait_delay | 6     |
	+------------------------+-------+
	1 row in set (0.01 sec)

	含义：
		The maximum delay between polls for a spin lock. The low-level implementation of this mechanism varies depending on the combination of hardware and operating system, so the delay does not correspond to a fixed time interval.
		自旋锁定的两次轮询之间的最大延迟。 
		此机制的底层实现取决于硬件和操作系统的组合，因此延迟不对应于固定的时间间隔。

	相关参考：
		https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_spin_wait_delay




context switch ：上下文切换



自旋锁 :
	传统的互斥锁，只要一检测到锁被其他线程所占用了，就立刻放弃cpu时间片，把cpu留给其他线程，这就会产生一次上下文切换。当系统压力大的时候，频繁的上下文切换会导致sys值过高。
	自旋锁，在检测到锁不可用的时候，首先cpu忙等一小会儿，如果还是发现不可用，再放弃cpu，进行切换。
	互斥锁消耗 cpu sys 值，自旋锁消耗 cpu us 值。
	
	
	innodb_spin_wait_delay  & innodb_sync_spin_loops  自旋锁配置相关参数
	
	

	
	
	
