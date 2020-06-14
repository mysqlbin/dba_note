


select 1


set global innodb_thread_concurrency=3;

CREATE TABLE `t` (
  `id` int(11) NOT NULL,
  `c` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

 insert into t values(1,1)

 

 
 session A                  session B                  session C                 session D         session E
 select sleep(100) from t;  select sleep(100) from t;  select sleep(100) from t; 
																			
																			     select 1; 
																				 (Query OK)
																				 select * from t;
																				 (blocked)
																								   show processlist;
																				 
																				 
mysql>show processlist;
+----+------+--------------------+------+---------+------+--------------+--------------------------+
| Id | User | Host               | db   | Command | Time | State        | Info                     |
+----+------+--------------------+------+---------+------+--------------+--------------------------+
|  7 | lujb | 192.168.1.100:3634 | NULL | Sleep   |  110 |              | NULL                     |
|  8 | lujb | 192.168.1.100:3639 | NULL | Sleep   |  108 |              | NULL                     |
|  9 | lujb | 192.168.1.100:3643 | NULL | Sleep   |  105 |              | NULL                     |
| 10 | lujb | 192.168.1.100:3666 | zst  | Sleep   |   87 |              | NULL                     |
| 11 | lujb | 192.168.1.100:3678 | zst  | Sleep   |   84 |              | NULL                     |
| 12 | lujb | 192.168.1.100:3684 | zst  | Sleep   |   81 |              | NULL                     |
| 13 | root | localhost          | NULL | Query   |    0 | starting     | show processlist         |
| 14 | root | localhost          | zst  | Query   |    6 | Sending data | select * from t          |
| 15 | root | localhost          | zst  | Query   |   23 | User sleep   | select sleep(100) from t |
| 16 | root | localhost          | zst  | Query   |   26 | User sleep   | select sleep(100) from t |
| 17 | root | localhost          | zst  | Query   |   30 | User sleep   | select sleep(100) from t |
+----+------+--------------------+------+---------+------+--------------+--------------------------+
	
select 1: 
   select 1成功返回, 只能说明这个库的进程还在, 并不能说明主库没有问题.
   用 select 1 来检测实例是否正常的话，是检测不出问题的。	
 
innodb_thread_concurrency:
	参数的作用: 
		控制 InnoDB 的并发线程上限
		一旦并发线程数达到这个值，InnoDB 在接收到新请求的时候，就会进入等待状态，直到有线程退出。
	innodb_thread_concurrency=3:　
		表示 InnoDB 只允许 3 个线程并行执行。 
		在本例中，前三个 session 中的 sleep(100)，使得这三个语句都处于 “执行” 状态，以此来模拟大查询。
		session D 里面，select 1 是能执行成功的，但是查询表 t 的语句会被堵住。
			innodb_thread_concurrency参数用于设置限制能够进入innodb层的线程数, select 1; 语句并不需要进入InnoDB层取数据
			如果这时候我们用 select 1 来检测实例是否正常的话，是检测不出问题的。
			
	参数默认值是 0，表示不限制并发线程数量。
		但是，不限制并发线程数肯定是不行的。因为，一个机器的 CPU 核数有限，线程全冲进来，上下文切换的成本就会太高。
		所以，通常情况下，我们建议把 innodb_thread_concurrency 设置为 64~128 之间的值。
			这时，你一定会有疑问，并发线程上限数设置为 128 够干啥，线上的并发连接数动不动就上千了。
	
	在线程进入锁等待以后，并发线程的计数会减一:
	
		1. innodb_thread_concurrency=128, 等行锁（也包括间隙锁）的线程是不算在 128 里面的。
		
			这样设计的作用:
			MySQL 这样设计是非常有意义的。
			1. 进入锁等待的线程已经不吃 CPU 了；
			2. 更重要的是，必须这么设计，才能避免整个系统锁死。
			
		2. 锁等待的线程也占并发线程的计数的影响:
		
			样例:
			线程 1 执行 begin; update t set c=c+1 where id=1, 启动了事务 trx1， 然后保持这个状态。这时候，线程处于空闲状态，不算在并发线程里面。
			线程 2 到线程 129 都执行 update t set c=c+1 where id=1; 由于等行锁，进入等待状态。这样就有 128 个线程处于等待状态；
			如果处于锁等待状态的线程计数不减一，InnoDB 就会认为线程数用满了，会阻止其他语句进入引擎执行，这样线程 1 不能提交事务。
				而另外的 128 个线程又处于锁等待状态，整个系统就堵住了。
			
			这时候 InnoDB 不能响应任何请求，整个系统被锁死。
				而且，由于所有线程都处于等待状态，此时占用的 CPU 却是 0，而这明显不合理。
				所以，我们说 InnoDB 在设计时，遇到进程进入锁等待的情况时，将并发线程的计数减 1 的设计，是合理而且是必要的。		

并发连接和并发查询:
	并发连接: 
		在 show processlist 的结果里，看到的几千个连接，指的就是并发连接。
		并发连接数达到几千个影响并不大，就是多占一些内存而已。
	并发查询:
		“当前正在执行”的语句，才是我们所说的并发查询。
		我们应该关注的是并发查询，因为并发查询太高才是 CPU 杀手。
		这也是为什么我们需要设置 innodb_thread_concurrency 参数的原因。
		
		
查表判断:

	检测出由于并发线程过多导致的数据库不可用情况的方法:
	
		在系统库（mysql 库）里创建一个表，比如命名为 health_check，里面只放一行数据，然后定期执行：
		mysql> select * from mysql.health_check; 
	
	查表判断存在的问题:
		空间满了以后，系统这时候还是可以正常读数据的。
		更新事务要写 binlog，而一旦 binlog 所在磁盘的空间占用率达到 100%，那么所有的更新语句和事务提交的 commit 语句就都会被堵住。
		
		
统计内部每一次IO请求的时间：

	更新判断存在的问题：
		如果磁盘IO 利用率100%，导致系统响应非常慢，但是定时轮询更新判断存在判断慢的问题；
	
	MySQL 5.6 版本以后提供的 performance_schema.file_summary_by_event_name 表里统计了每次 IO 请求的时间。
	
	
	wait/io/file/innodb/innodb_log_file：
	mysql>select * from performance_schema.file_summary_by_event_name where event_name='wait/io/file/innodb/innodb_log_file'\G;
	*************************** 1. row ***************************
				   EVENT_NAME: wait/io/file/innodb/innodb_log_file
				   COUNT_STAR: 70
			   SUM_TIMER_WAIT: 322866189330
			   MIN_TIMER_WAIT: 335434
			   AVG_TIMER_WAIT: 4612373830
			   MAX_TIMER_WAIT: 158221112430
				   COUNT_READ: 7
			   SUM_TIMER_READ: 23676270368
			   MIN_TIMER_READ: 335434
			   AVG_TIMER_READ: 3382324228
			   MAX_TIMER_READ: 13578701052
	 SUM_NUMBER_OF_BYTES_READ: 70144
				  COUNT_WRITE: 32
			  SUM_TIMER_WRITE: 602683802
			  MIN_TIMER_WRITE: 3768904
			  AVG_TIMER_WRITE: 18833712
			  MAX_TIMER_WRITE: 30880000
	SUM_NUMBER_OF_BYTES_WRITE: 34816
				   COUNT_MISC: 31
			   SUM_TIMER_MISC: 298587235160
			   MIN_TIMER_MISC: 613740
			   AVG_TIMER_MISC: 9631846034
			   MAX_TIMER_MISC: 158221112430
	1 row in set (0.01 sec)	
	
	event_name='wait/io/file/innodb/innodb_log_file'：
	  这一行表示统计的是 redo log 的写入时间，
	  EVENT_NAME 表示统计的类型。
	
	redo log 操作的时间统计：
		第一组五列，是所有 IO 类型的统计。
			COUNT_STAR: 70
		    SUM_TIMER_WAIT: 322866189330
		    MIN_TIMER_WAIT: 335434
		    AVG_TIMER_WAIT: 4612373830
		    MAX_TIMER_WAIT: 158221112430
			COUNT_STAR 是所有 IO 的总次数
			接下来四列是具体的统计项， 单位是皮秒；
			前缀 SUM、MIN、AVG、MAX，顾名思义指的就是总和、最小值、平均值和最大值。
			
		第二组六列，是读操作的统计。
			
			COUNT_READ: 7
			SUM_TIMER_READ: 23676270368
			MIN_TIMER_READ: 335434
			AVG_TIMER_READ: 3382324228
			MAX_TIMER_READ: 13578701052
			SUM_NUMBER_OF_BYTES_READ: 70144
			SUM_NUMBER_OF_BYTES_READ 统计的是，总共从 redo log 里读了多少个字节。
				
		第三组六列，统计的是写操作。
			COUNT_WRITE: 32
			SUM_TIMER_WRITE: 602683802
			MIN_TIMER_WRITE: 3768904
			AVG_TIMER_WRITE: 18833712
			MAX_TIMER_WRITE: 30880000
			SUM_NUMBER_OF_BYTES_WRITE: 34816
			
			
		最后的第四组数据，是对其他类型数据的统计。
			COUNT_MISC: 31
			SUM_TIMER_MISC: 298587235160
			MIN_TIMER_MISC: 613740
			AVG_TIMER_MISC: 9631846034
			MAX_TIMER_MISC: 158221112430
			在 redo log 里，它们就是对 fsync 的统计。
	
	wait/io/file/sql/binlog：
		
		performance_schema.file_summary_by_event_name where event_name = "wait/io/file/sql/binlog" 这一行。
		各个字段的统计逻辑，与 redo log 的各个字段完全相同。
	
	打开这个统计功能的影响：
	
		每一次操作数据库，performance_schema 都需要额外地统计这些信息，所以我们打开这个统计功能是有性能损耗的。
		如果打开所有的 performance_schema 项，性能大概会下降 10% 左右。
			因此，只打开自己需要的项进行统计。
		
		可以通过下面的方法打开或者关闭某个具体项的统计。	
		如果要打开 redo log 的时间监控，可以执行这个语句：
		
			mysql> update performance_schema.setup_instruments set ENABLED='YES', Timed='YES' where name like '%wait/io/file/innodb/innodb_log_file%';

	通过 MAX_TIMER 的值来判断数据库是否出问题了：
	
		比如，你可以设定阈值，单次 IO 请求时间超过 200 毫秒属于异常，然后使用类似下面这条语句作为检测逻辑
		mysql> select event_name,MAX_TIMER_WAIT  FROM performance_schema.file_summary_by_event_name where event_name in ('wait/io/file/innodb/innodb_log_file','wait/io/file/sql/binlog') and MAX_TIMER_WAIT>200*1000000000;

		发现异常后，取到你需要的信息，再通过下面这条语句， 把之前的统计信息清空。
		这样如果后面的监控中，再次出现这个异常，就可以加入监控累积值了：
			mysql> truncate table performance_schema.file_summary_by_event_name;

		
