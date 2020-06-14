
1. InnoDB的7种锁类型
	1.1 Shared and Exclusive Locks (共享锁和排他锁)
	1.2 Intention Locks (意向锁) 
	1.3 Record Locks (行锁、LOCK_REC_NOT_GAP)
	1.4 Gap Locks (间隙锁、LOCK_GAP)
	1.5 Next-Key Locks (gap lock+record lock、LOCK_ORDINARY)
	1.6 Insert Intention Locks (插入意向锁、LOCK_INSERT_INTENTION)
	1.7 AUTO-INC Locks (自增锁)
2. 小结
3. MySQL锁的分类
4. 相关参考

1.1 Shared and Exclusive Locks (共享锁和排他锁)
	
	行锁根据互斥的纬度可以分为：
		共享锁： 表示事务A对读取到的记录加共享锁，别的事务不可以对事务A已经读取到的记录加排他锁。
				permits the transaction that holds the lock to read a row. 允许持有锁的事务读取一行。

		排他锁： 表示事务A对读取到的记录加排他锁，别的事务不可以对事务A已经读取到的记录加排他锁和共享锁。
				permits the transaction that holds the lock to update or delete a row.   允许持有锁的事务更新或删除行。

	使用的语义为：
		共享锁之间不互斥，简记为：读读可以并行
		排他锁与任何锁互斥，简记为：写读，写写不可以并行, 串行执行
		
	参考笔记 《2019-07-03-for_update和共享锁的实验.sql》
	
1.2 Intention Locks 
	
	https://www.jianshu.com/p/0b713ea4df16   MySQL的意向锁
	https://www.cnblogs.com/perfei/p/11367804.html  my40_MySQL锁概述之意向锁   # 还不错, 很详细
	
	--官方文档
		InnoDB支持多种粒度锁定，允许行锁和表锁并存。 例如，诸如LOCK TABLES ... WRITE之类的语句对指定表采用排他锁（X锁）。 
		为了使在多个粒度级别上的锁定变得切实可行，InnoDB使用了意图锁定。
		意向锁是表级锁，指示事务稍后对表中的行需要哪种类型的锁（共享锁或排他锁）。
		有两种类型的意向锁：
			意向共享锁(IS Lock): 当前事务想要获取一张表中某几行的共享锁
								 SELECT ... lock in share mode 持有: IS lock	
			意向排他锁(IX Lock): 当前事务想要获得一张表中某几行的排他锁
								 SELECT ... FOR UPDATE		  持有: IX lock	
								 
		意向锁除了全表请求（例如LOCK TABLES ... WRITE）外，不阻止任何其他内容。 
		意图锁定的主要目的是表明有人正在锁定表中的行，或者打算锁定表中的行。
			由于 InnoDB 存储引擎支持的是行级别的锁， 因此意向锁其实不会阻塞除全表扫描以外的任何请求。
			
	1. 概念：
		意向锁是表级别的锁(InnoDB存储引擎支持意向锁设计比较简练，其意向即为表级别的锁。)
		InnoDB存储引擎支持两种意向锁：
			意向共享锁(IS Lock): 事务想要获取表A中某些行的共享锁(S 锁)，必须要获取表A的意向共享锁(IS 锁)
			意向排他锁(IX Lock): 事务想要获取表A中某些行的排他锁(X 锁)，必须要获取表A的意向排他锁(IX 锁)
		意向锁是InnoDB自动加的，不需要人为干预
		由于 InnoDB 存储引擎支持的是行级别的锁， 因此意向锁其实不会阻塞除全表扫描以外的任何请求。
		
	2. 设计目的：为了在一个事务中揭示下一步将要被请求的锁的类型。
	
	3. 作用：提高InnoDB的性能，会话A持有的是表级锁，那么会话B一看全表已经被锁定，则不再去看每行是否锁定，从而提高InnoDB的性能
	
	4. 意向锁的意义在哪里？
		1. IX，IS是表级锁，不会和行级的X，S锁发生冲突。只会和表级的X，S发生冲突
		2. 意向锁是在添加行锁之前添加。
		3. 如果没有意向锁，当向一个表添加表级X锁时，就需要遍历整张表来判断是否存行锁，以免发生冲突
		4. 如果有了意向锁，只需要判断该意向锁与表级锁是否兼容即可。
	
	表级X锁如何添加 
		TABLE LOCK table `test`.`t` trx id 598438 lock mode IX  --一个表级意向排他锁
		
		
	案例如下：
	
		表结构和初始化数据	
			CREATE TABLE `t2` (
			  `id` int(11) NOT NULL,
			  `c` int(11) DEFAULT NULL,
			  `d` int(11) DEFAULT NULL,
			  PRIMARY KEY (`id`),
			  KEY `c` (`c`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

			INSERT INTO `t2` (`id`, `c`, `d`) VALUES ('10', '10', '10');

			mysql> select * from t2;
			+----+------+------+
			| id | c    | d    |
			+----+------+------+
			| 10 |   10 |   10 |
			+----+------+------+
			1 row in set (0.00 sec)

		事务的执行次序
			session A             session B
			mysql> begin;
			mysql> select * from t2 lock in share mode;
			+----+------+------+
			| id | c    | d    |
			+----+------+------+
			| 10 |   10 |   10 |
			+----+------+------+
			1 row in set (0.00 sec)

								  INSERT INTO `t2` (`id`, `c`, `d`) VALUES ('11', '11', '11');



			mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
			+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+--------------------+-------------+------------------------+
			| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE          | LOCK_STATUS | LOCK_DATA              |
			+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+--------------------+-------------+------------------------+
			| 139859108159800:1305:139859033399624    |                869722 |      2067 | t2          | NULL       | TABLE     | IX                 | GRANTED     | NULL                   |
			| 139859108159800:248:4:1:139859033396744 |                869722 |      2067 | t2          | PRIMARY    | RECORD    | X,INSERT_INTENTION | WAITING     | supremum pseudo-record |
			
			| 139859108158928:1305:139859033393640    |       421334084869584 |      2066 | t2          | NULL       | TABLE     | IS                 | GRANTED     | NULL                   |
			| 139859108158928:248:4:1:139859033390712 |       421334084869584 |      2066 | t2          | PRIMARY    | RECORD    | S                  | GRANTED     | supremum pseudo-record |
			| 139859108158928:248:4:2:139859033390712 |       421334084869584 |      2066 | t2          | PRIMARY    | RECORD    | S                  | GRANTED     | 10                     |
			+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+--------------------+-------------+------------------------+
			5 rows in set (0.00 sec)

			supremum pseudo-record：它是索引中的伪记录(pseudo-record)，代表此索引中可能存在的最大值

			root@mysqldb 16:24:  [(none)]> SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
			+--------------+-------------+-------------------------------------------------------------+--------------------+--------------------+
			| locked_index | locked_type | waiting_query                                               | waiting_lock_mode  | blocking_lock_mode |
			+--------------+-------------+-------------------------------------------------------------+--------------------+--------------------+
			| PRIMARY      | RECORD      | INSERT INTO `t2` (`id`, `c`, `d`) VALUES ('11', '11', '11') | X,INSERT_INTENTION | S                  |
			+--------------+-------------+-------------------------------------------------------------+--------------------+--------------------+
			1 row in set (0.00 sec)
			
			本案例的IS跟IX不互斥, 所以会去判断有没有行级锁
			
			
		会话B先判断表上有没有表级锁，如果没有表级锁，则开始判断有没有行级锁

		这个案例基于MySQL 5.7.22
		innodb_status_output_locks参数处于开启状态。
		begin;
		select * from t2 lock in share mode;
								begin;
								select * from t2 where c=10 for update;
		show engine innodb status\G;
			---TRANSACTION 5893164, ACTIVE 4 sec starting index read
			mysql tables in use 1, locked 1
			LOCK WAIT 3 lock struct(s), heap size 1136, 2 row lock(s)
			MySQL thread id 28, OS thread handle 140403754362624, query id 355 localhost root Sending data
			select * from t2 where c=10 for update
			------- TRX HAS BEEN WAITING 4 SEC FOR THIS LOCK TO BE GRANTED:
			RECORD LOCKS space id 231 page no 3 n bits 72 index PRIMARY of table `sbtest`.`t2` trx id 5893164 lock_mode X locks rec but not gap waiting
			Record lock, heap no 2 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
			 0: len 4; hex 8000000a; asc     ;;
			 1: len 6; hex 00000059ec2b; asc    Y +;;
			 2: len 7; hex a20001401a0110; asc    @   ;;
			 3: len 4; hex 8000000a; asc     ;;
			 4: len 4; hex 8000000a; asc     ;;

			------------------
			TABLE LOCK table `sbtest`.`t2` trx id 5893164 lock mode IX
			RECORD LOCKS space id 231 page no 4 n bits 72 index c of table `sbtest`.`t2` trx id 5893164 lock_mode X
			Record lock, heap no 2 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
			 0: len 4; hex 8000000a; asc     ;;
			 1: len 4; hex 8000000a; asc     ;;

			RECORD LOCKS space id 231 page no 3 n bits 72 index PRIMARY of table `sbtest`.`t2` trx id 5893164 lock_mode X locks rec but not gap waiting
			Record lock, heap no 2 PHYSICAL RECORD: n_fields 5; compact format; info bits 0
			 0: len 4; hex 8000000a; asc     ;;
			 1: len 6; hex 00000059ec2b; asc    Y +;;
			 2: len 7; hex a20001401a0110; asc    @   ;;
			 3: len 4; hex 8000000a; asc     ;;
			 4: len 4; hex 8000000a; asc     ;;

		root@localhost [(none)]>select * from information_schema.innodb_locks\G;
		*************************** 1. row ***************************
		    lock_id: 5893164:231:3:2
		lock_trx_id: 5893164
		  lock_mode: X
		  lock_type: RECORD
		 lock_table: `sbtest`.`t2`
		 lock_index: PRIMARY
		 lock_space: 231
		  lock_page: 3
		   lock_rec: 2
		  lock_data: 10
		*************************** 2. row ***************************
		    lock_id: 421878861553264:231:3:2
		lock_trx_id: 421878861553264
		  lock_mode: S
		  lock_type: RECORD
		 lock_table: `sbtest`.`t2`
		 lock_index: PRIMARY
		 lock_space: 231
		  lock_page: 3
		   lock_rec: 2
		  lock_data: 10
		2 rows in set, 1 warning (0.00 sec)

		ERROR: 
		No query specified

		root@localhost [(none)]>select * from information_schema.innodb_lock_waits\G;
		*************************** 1. row ***************************
		requesting_trx_id: 5893164
		requested_lock_id: 5893164:231:3:2
		  blocking_trx_id: 421878861553264
		 blocking_lock_id: 421878861553264:231:3:2
		1 row in set, 1 warning (0.00 sec)

		root@localhost [(none)]>SELECT locked_index,locked_type,waiting_query,waiting_lock_mode,blocking_lock_mode FROM sys.innodb_lock_waits;
		+--------------+-------------+----------------------------------------+-------------------+--------------------+
		| locked_index | locked_type | waiting_query                          | waiting_lock_mode | blocking_lock_mode |
		+--------------+-------------+----------------------------------------+-------------------+--------------------+
		| PRIMARY      | RECORD      | select * from t2 where c=10 for update | X                 | S                  |
		+--------------+-------------+----------------------------------------+-------------------+--------------------+
		1 row in set, 3 warnings (0.07 sec)

1.3 Record Locks (行锁)
	锁是加在索引上的，所以才有行锁；行锁就是针对数据库表中行记录的锁。
	举例：比如事务A更新了一行，而这时候事务B也要更新同一行，则事务B必须要等待事务A的更新操作完成后才能进行更新。    
	两阶段加锁：在InnoDB事务中，行锁是在需要的时候才加上的，但并不是不需要了就立即释放，而是要等到事务结束时才释放。 
	
	参考笔记《7-行锁.sql》
	
	
1.4 Gap Locks (间隙锁)
	参考笔记
	《20-幻读.sql》
	《21-8.0.18版本下做实验.sql》 4.2.5 非唯一索引上等值查询-Gap lock死锁
	
1.5 Next-Key Locks (gap lock+record lock)

	参考笔记 
	《20-幻读.sql》  1.4 持有 next-key lock 会阻塞往 gap lock 中写入数据
	《21-8.0.18版本下做实验.sql》 4.2.5 非唯一索引上等值查询-Gap lock死锁 
	

1.6 Insert Intention Locks
	-- by 官方文档
		An insert intention lock is a type of gap lock set by INSERT operations prior to row insertion. 
			插入意向锁是在行插入之前通过INSERT操作设置的间隙锁的一种类型
			
		This lock signals the intent to insert in such a way that multiple transactions inserting into the same index gap need not wait for each other if they are not inserting at the same position within the gap. 
		Suppose that there are index records with values of 4 and 7. Separate transactions that attempt to insert values of 5 and 6, respectively, each lock the gap between 4 and 7 with insert intention locks prior to obtaining the exclusive lock on the inserted row, but do not block each other because the rows are nonconflicting.	
			此锁发出插入意图的信号是，如果多个事务未插入间隙中的相同位置，则无需等待插入到同一索引间隙中的多个事务。 
			假设有索引记录，其值分别为4和7。单独的事务分别尝试插入值5和6，在获得插入行的排他锁之前，每个事务都使用插入意图锁来锁定4和7之间的间隙， 但不会互相阻塞，因为行是无冲突的。
		
		The following example demonstrates a transaction taking an insert intention lock prior to obtaining an exclusive lock on the inserted record. The example involves two clients, A and B.
			下面的示例演示了在获得对插入记录的排他锁之前，使用插入意图锁的事务。 该示例涉及两个客户端A和B。
		
		Client A creates a table containing two index records (90 and 102) and then starts a transaction that places an exclusive lock on index records with an ID greater than 100. The exclusive lock includes a gap lock before record 102
			客户端A创建一个包含两个索引记录（90和102）的表，然后启动一个事务，该事务在ID大于100的索引记录上放置一个排他锁。排他锁在记录102之前包含一个间隙锁
		
		参考笔记《2020-05-20-意向插入锁.sql》
		
		
	-- By 叶问
		插入意向锁定是在行插入之前由INSERT操作设置的一种间隙锁。
		这个锁表示插入的意图，即插入相同索引间隙的多个事务如果不插入间隙内的相同位置则不需要等待彼此，插入意向锁是一种特殊的GAP LOCK
	
	-- By 丁奇
		insert intention ：表示当前线程准备插入一个记录，这是一个插入意向锁, 可以认为它就是这个插入动作本身    # by 丁奇
	 
	 
	-- By 叶老师
		相关概念：
			1. 它是个 gap lock
			2. 如果两个不同事务想往同一个gap中写入数据， 但写入位置不一样时，是无需等待，可以直接写入的，因为没有冲突
		作用：
			gap lock 仅用于防止往 gap 上写入新记录（避免幻读）， 因此无论是 S-gap 还是 X-gap 锁，其实作用是一样的。
	
	-- 网友的理解 
		对已有数据行的修改与删除，必须加强互斥锁(X锁)，那么对于数据的插入，是否还需要加这么强的锁，来实施互斥呢？插入意向锁，孕育而生。

		插入意向锁，是间隙锁(Gap Locks)的一种（所以，也是实施在索引上的），它是专门针对insert操作的。多个事务，在同一个索引，同一个范围区间插入记录时，如果插入的位置不冲突，不会阻塞彼此。
		https://www.cnblogs.com/volcano-liu/p/9890832.html  mysql锁机制详解

	-- 自己的理解 
		概念
			
			插入意向锁是 gap lock的一种（所以，也是加在索引上的），它是专门针对 insert 操作（意向插入锁其实是插入动作本身）
			只要两个事务的insert不插入同一范围的同一位置,就不会有冲突即互相阻塞彼此.
			
		为什么要有意向插入锁
			对已有数据行的修改与删除，必须加强互斥锁(X锁)，那么对于数据的插入，是否还需要加这么强的锁，来实施互斥呢？插入意向锁，孕育而生。
		
		作用
			提高插入并发能力: 多个事务，在同一个索引，同一个范围区间插入记录时，如果插入的位置不冲突，不会阻塞彼此。
			


1.7 AUTO-INC Locks (自增锁)
	自增ID锁并不是一个事务锁， 而是每次申请完就马上释放， 以便允许别的事务再申请，提高并发性能。
	自增长锁采用的是一种特殊的表锁机制，为了提高插入性能，锁不是在一个事务完成后才释放，而是在完成对自增长值插入的SQL语句后立即释放	
	
	设计自增长锁申请完成就释放的意义：
		首先自增长锁的粒度非常小 
		提高并发插入能力，如果事务完成后才释放自增长锁，那么会很影响并发性能，假设有两个并发事务，事务1执行耗时约 0.5 秒才提交完成，事务2需要等待 0.5 秒之后才开始执行，影响了事务的执行效率。
		
	场景: 针对insert语句通过AUTO_INCREMENT自增列获取自增ID的加锁

	举例: 参考笔记《2020-05-15-innodb_autoinc_lock_mode-验证自增长锁的释放时机.sql》、《2020-05-16-innodb_autoinc_lock_mode-验证MySQL 8.0.18版本是否存在自增锁扩大.sql》
			


2. 小结
	锁的作用：
		1. 提高并发度，比如意向锁、意向插入锁、自增长锁、行锁
			不支持行锁意味着并发控制只能使用表锁，对于这种引擎的表，同一张表上任何时刻只能有一个更新在执行， 这就会影响到业务并发度。
		2. 保证数据的一致性，比如共享锁和排他锁、行锁
		3. 消耗幻读：间隙锁

		4. 小结：降低（减小）加锁的粒度（范围），可以提高并发能力。
			
	锁的负作用：产生锁等待、死锁	

	了解锁的原理、工作机制、用途、作用之后，发现锁的设计是非常巧妙的.

	插入意向锁跟意向锁的区别：一个是表级别的锁，另一个是插入动作本身 

	阻塞insert语句的锁: 
		全局读锁:  flush table with read lock;
		表锁：lock table t wrte/read;
		表级锁: MDL、意向锁、自增锁 
		行锁: next-key lock、gap kock、插入意向锁
		唯一键冲突
		
3. MySQL锁的分类
	
	锁的模式
		The value is storage engine dependent. For InnoDB, permitted values are S[,GAP], X[,GAP], IS[,GAP], IX[,GAP], AUTO_INC, and UNKNOWN. 
		该值取决于存储引擎, 在InnoDB中, 允许的值有 S[,GAP], X[,GAP], IS[,GAP], IX[,GAP], AUTO_INC, and UNKNOWN.
		S
		X
		IS
		IX
		AUTO_INC
		gap lock 
		REC_NOT_GAP
		INSERT_INTENTION
	
	全局锁
		flush table with read lock;
		
	表锁和表级锁
		表锁: lock table t write/read; 
		表级锁: MDL锁、自增锁、意向锁
		
	行锁
		行锁根据锁定的范围可以分为： 行锁的模式即 LOCK_TYPE=RECORD， LOCK_MODE： X,GAP,INSERT_INTENTION
			1、间隙锁：间隙锁锁定范围是索引记录之间的间隙或者第一个或最后一个索引记录之前的间隙(指虚拟最大记录)
			2、记录锁：MySQL中记录锁都是添加在索引上，即使表上没有索引也会在隐藏的聚集索引上添加记录锁
			3、next-key lock：Next-Key Locks是Record Locks与Gap Locks间隙锁的组合，也就是索引记录本身加上 之前的间隙。间隙锁防止了保证RR级别下不出现幻读现象会，防止同一个事务内得 到的结果不一致
			4、插入意向锁：插入意向锁定是在行插入之前由INSERT操作设置的一种间隙锁。这个锁表示插入的意图，即插入相同索引间隙的多个事务如果不插入间隙内的相同位置则不需要等待彼此，插入意向锁是一种特殊的GAP LOCK
			
			mysql> select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,THREAD_ID,OBJECT_NAME,INDEX_NAME,LOCK_TYPE,LOCK_MODE,LOCK_STATUS,LOCK_DATA from performance_schema.data_locks;
			+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
			| ENGINE_LOCK_ID                          | ENGINE_TRANSACTION_ID | THREAD_ID | OBJECT_NAME | INDEX_NAME | LOCK_TYPE | LOCK_MODE              | LOCK_STATUS | LOCK_DATA |
			+-----------------------------------------+-----------------------+-----------+-------------+------------+-----------+------------------------+-------------+-----------+
			| 139811159242760:1344:139811050573816    |               1004315 |        59 | t518        | NULL       | TABLE     | IX                     | GRANTED     | NULL      |
			| 139811159242760:287:5:4:139811050570776 |               1004315 |        59 | t518        | c          | RECORD    | X,GAP,INSERT_INTENTION | WAITING     | 5, 3      |
			
	行锁根据互斥的纬度(互斥程度)可以分为：
		共享锁： 表示事务A对读取到的记录加共享锁，别的事务不可以对事务A已经读取到的记录加排他锁。
				permits the transaction that holds the lock to read a row. 允许持有锁的事务读取一行。

		排他锁： 表示事务A对读取到的记录加排他锁，别的事务不可以对事务A已经读取到的记录加排他锁和共享锁。
				permits the transaction that holds the lock to update or delete a row.   允许持有锁的事务更新或删除行。
	


4. 相关参考
	https://dev.mysql.com/doc/refman/8.0/en/innodb-locking.html
	https://mp.weixin.qq.com/s/2VHDVbZdJxldjVFQqzCC7A  MySQL InnoDB 引擎中的 7 种锁类型，你都知道吗？
	https://mp.weixin.qq.com/s/iXZATb1qjrt-Pv1wx-rykQ  技本功丨浅谈MySQL的七种锁 # 原创 袋鼠云技术团队


	