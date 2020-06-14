
CREATE TABLE `t` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `c` (`c`)
) ENGINE=InnoDB;

insert into t values(null, 1,1);
insert into t values(null, 2,2);
insert into t values(null, 3,3);
insert into t values(null, 4,4);

create table t2 like t


1. insert ... select 语句的加锁 
事务隔离级别: 可重复读
binlog_format: statement 格式;
为什么 insert into t2(c,d) select c,d from t; 会对表 t 的所有行和间隙加锁;

session A                 			session B
									begin;
									insert into t2(c,d) select c,d from t;
begin;
insert into t values(-1, -1, -1);    

mysql> select locked_index,locked_type,blocking_lock_mode,waiting_lock_mode,waiting_query from sys.innodb_lock_waits;
+--------------+-------------+--------------------+-------------------+----------------------------------+
| locked_index | locked_type | blocking_lock_mode | waiting_lock_mode | waiting_query                    |
+--------------+-------------+--------------------+-------------------+----------------------------------+
| PRIMARY      | RECORD      | S                  | X,GAP             | insert into t values(-1, -1, -1) |
+--------------+-------------+--------------------+-------------------+----------------------------------+
1 row in set, 3 warnings (0.01 sec)



从binlog日志和数据的一致性作为考虑方向;

如果没有锁的话，就可能出现 session B 的 insert 语句先执行，但是后写入 binlog 的情况
于是，在 binlog_format=statement 的情况下，binlog 里面就记录了这样的语句序列：
	insert into t values(-1, -1, -1);
	insert into t2(c,d) select c,d from t;
这个语句到了备库执行，就会把 id=-1 这一行也写到表 t2 中，出现主备不一致。

执行 insert … select 的时候，对目标表也不是锁全表，而是只锁住需要访问的资源。


2. insert 循环写入:

都能够学会用 explain 的结果来“脑补”整条语句的执行过程。

set global long_query_time=0;

show GLOBAL variables like '%long_query_time%';


show status like '%Innodb_rows_read%';
insert into t(c,d)  (select c+1, d from t force index(c) order by c desc limit 1);
show status like '%Innodb_rows_read%';


需求：
	要往表 t 中插入一行数据，这一行的 c 值是表 t 中 c 值的最大值加 1。
SQL语句:
	insert into t(c,d)  (select c+1, d from t force index(c) order by c desc limit 1);

分析语句的执行流程和扫描行数的方向:
    
	查看执行计划
		用 explain 的结果来“脑补”整条语句的执行过程。
	分析扫描的行数的方法:
		show status like '%Innodb_rows_read%';
		从慢查询查看SQL语句的Rows_examined
		explain.rows
		
查看慢查询:
	语句的 Rows_examined 的值是 5
	
查看执行计划:
Extra = Using temporary:
	表示这个语句用到了临时表;
	说明执行过程中，需要把表 t 的内容读出来，写入临时表。
rows = 1:
	预计扫描的行数
	

rows = 1, 先对这个语句的执行流程做一个猜测：
	如果说是把子查询的结果读出来（扫描 1 行），写入临时表，然后再从临时表读出来（扫描 1 行），写回表 t 中。
	那么，这个语句的扫描行数就应该是 2，而不是 5。
	
	所以，这个猜测不对; 推翻了猜测的思路

先说结论:
	实际上，Explain 结果里的 rows=1 是因为受到了 limit 1 的影响。	

查看Innodb_rows_read变化:
	从另一个角度考虑的话，我们可以看看 InnoDB 扫描了多少行:


	可以看到，这个语句执行前后，Innodb_rows_read 的值增加了 4。
	因为默认临时表是使用 Memory 引擎的，所以这 4 行查的都是表 t，也就是说对表 t 做了全表扫描。
	
	
整个执行过程:
	1. 创建临时表，表里有两个字段 c 和 d。
	2. 按照索引 c 扫描表 t，依次取 c=4、3、2、1，然后回表，读到 c 和 d 的值写入临时表。
		这时，Rows_examined=4。
	3. 由于语义里面有 limit 1，所以只取了临时表的第一行，再插入到表 t 中。
		这时，Rows_examined 的值加 1，变成了 5。
	
	4. 这个语句会导致在表 t 上做全表扫描，并且会给索引 c 上的所有间隙都加上共享的 next-key lock; 
		这个语句执行期间，其他事务不能在这个表上插入数据。
	
为什么这个语句的执行需要临时表:
	原因是这类一边遍历数据，一边更新数据的情况
	如果读出来的数据直接写回原表，就可能在遍历过程中，读到刚刚插入的记录，新插入的记录如果参与计算逻辑，就跟语义不符。	
	
这个语句为什么需要遍历整张表:
	由于实现上这个语句没有在子查询中就直接使用 limit 1，从而导致了这个语句的执行需要遍历整个表 t。

优化方法:
	先 insert into 到临时表 temp_t，这样就只需要扫描一行;
	然后再从表 temp_t 里面取出这行数据插入表 t1;	

	由于这个语句涉及的数据量很小，可以考虑使用内存临时表来做这个优化。
	使用内存临时表优化时，语句序列的写法如下：
		create temporary table temp_t(c int,d int) engine=memory;
		insert into temp_t  (select c+1, d from t force index(c) order by c desc limit 1);
		insert into t select * from temp_t;
		drop table temp_t;

		



insert 唯一键冲突


session A                      		session B                  					session C
begin;
insert into t values(null, 5, 5);		 
									insert into t values(null, 5, 5);		    insert into t values(null, 5, 5);

rollback;

																				ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction

																		

mysql>  select locked_index,locked_type,blocking_lock_mode,waiting_lock_mode,waiting_query from sys.innodb_lock_waits;
+--------------+-------------+--------------------+-------------------+----------------------------------+
| locked_index | locked_type | blocking_lock_mode | waiting_lock_mode | waiting_query                    |
+--------------+-------------+--------------------+-------------------+----------------------------------+
| c            | RECORD      | X                  | S                 | insert into t values(null, 5, 5) |
+--------------+-------------+--------------------+-------------------+----------------------------------+
1 row in set, 3 warnings (0.02 sec)

mysql>  select locked_index,locked_type,blocking_lock_mode,waiting_lock_mode,waiting_query from sys.innodb_lock_waits;
+--------------+-------------+--------------------+-------------------+----------------------------------+
| locked_index | locked_type | blocking_lock_mode | waiting_lock_mode | waiting_query                    |
+--------------+-------------+--------------------+-------------------+----------------------------------+
| c            | RECORD      | X                  | S                 | insert into t values(null, 5, 5) |
| c            | RECORD      | X                  | S                 | insert into t values(null, 5, 5) |
+--------------+-------------+--------------------+-------------------+----------------------------------+

死锁日志:
2019-08-04T05:16:43.317616+08:00 19 [Note] InnoDB: Transactions deadlock detected, dumping detailed information.
2019-08-04T05:16:43.317670+08:00 19 [Note] InnoDB: 
*** (1) TRANSACTION:

TRANSACTION 8218471, ACTIVE 34 sec inserting
mysql tables in use 1, locked 1
LOCK WAIT 4 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 1
MySQL thread id 18, OS thread handle 140220116989696, query id 142 192.168.0.54 root update
insert into t values(null, 5, 5)
2019-08-04T05:16:43.317745+08:00 19 [Note] InnoDB: *** (1) WAITING FOR THIS LOCK TO BE GRANTED:

RECORD LOCKS space id 4367 page no 4 n bits 80 index c of table `admin_db`.`t` trx id 8218471 lock_mode X insert intention waiting
Record lock, heap no 1 PHYSICAL RECORD: n_fields 1; compact format; info bits 0
 0: len 8; hex 73757072656d756d; asc supremum;;

2019-08-04T05:16:43.318013+08:00 19 [Note] InnoDB: *** (2) TRANSACTION:

TRANSACTION 8218473, ACTIVE 9 sec inserting
mysql tables in use 1, locked 1
4 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 1
MySQL thread id 19, OS thread handle 140220116457216, query id 155 192.168.0.54 root update
insert into t values(null, 5, 5)
2019-08-04T05:16:43.318082+08:00 19 [Note] InnoDB: *** (2) HOLDS THE LOCK(S):

RECORD LOCKS space id 4367 page no 4 n bits 80 index c of table `admin_db`.`t` trx id 8218473 lock mode S
Record lock, heap no 1 PHYSICAL RECORD: n_fields 1; compact format; info bits 0
 0: len 8; hex 73757072656d756d; asc supremum;;

2019-08-04T05:16:43.318210+08:00 19 [Note] InnoDB: *** (2) WAITING FOR THIS LOCK TO BE GRANTED:

RECORD LOCKS space id 4367 page no 4 n bits 80 index c of table `admin_db`.`t` trx id 8218473 lock_mode X insert intention waiting
Record lock, heap no 1 PHYSICAL RECORD: n_fields 1; compact format; info bits 0
 0: len 8; hex 73757072656d756d; asc supremum;;

2019-08-04T05:16:43.318339+08:00 19 [Note] InnoDB: *** WE ROLL BACK TRANSACTION (2)
			


insert into … on duplicate key update:

insert into … on duplicate key update 这个语义的逻辑:
	插入一行数据，如果碰到唯一键约束，就执行后面的更新语句。
	如果有多个列违反了唯一性约束，就会按照索引的顺序，修改跟第一个索引冲突的行。	


样例：
	表 t 里面已经有了 (1,1,1) 和 (2,2,2) 这两行；
	执行语句： insert into t values(2, 1, 100) on duplicate key update d=100;
	主键 id 是先判断的，MySQL 认为这个语句跟 id=2 这一行冲突，所以修改的是 id=2 的行。
	执行这条语句的 affected rows 返回的是 2，很容易造成误解：
		实际上，真正更新的只有一行，只是在代码实现上，insert 和 update 都认为自己成功了，update 计数加了 1， insert 计数也加了 1。	

		
	
	