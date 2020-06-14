
mysql> CREATE TABLE `t` (
  `id` int(11) NOT NULL,
  `c` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

delimiter ;;
create procedure idata()
begin
  declare i int;
  set i=1;
  while(i<=100000) do
    insert into t values(i,i);
    set i=i+1;
  end while;
end;;
delimiter ;

call idata();


1. 第一类：查询长时间不返回


执行下面的SQL语句，查询结果长时间不返回。
mysql> select * from t where id=1;


查询一小部分数据，长时间不返回，大概率是表被锁住了。

分析原因：
	1. 先执行 show processlist命令，看看当前语句处于什么状态；
	2. 针对每种状态，分析它们产生的原因、如何复现、如何处理。

	
1.1 等MDL锁

session A                session B
lock table t write;
						 select * from t where id=1;
		
mysql> show processlist;
+------+-----------+--------------------+----------+-------------+--------+-------------------------------------+----------------------------+
| Id   | User      | Host               | db       | Command     | Time   | State                               | Info                       |
+------+-----------+--------------------+----------+-------------+--------+-------------------------------------+----------------------------+
| 2277 | root      | 192.168.0.54:44034 | admin_db | Sleep       |     14 |                                     | NULL                       |
| 2278 | root      | 192.168.0.54:44036 | admin_db | Query       |      7 | Waiting for table metadata lock      select * from t where id=1  |
| 2279 | root      | 192.168.0.54:44038 | NULL     | Query       |      0 | starting                            | show processlist           |
+------+-----------+--------------------+----------+-------------+--------+-------------------------------------+----------------------------+
4 rows in set (0.00 sec)

1. 表现：使用show processlist命令查看 State的状态处于 Waiting for table metadata lock; 

2. 这里状态处于Waiting for table metadata lock的含义：
	表示 现在有一个线程正在 表t 上请求或者持有 MDL写锁，把 select 语句堵住了。
	
	
3. 分析原因和过程：
	session A 通过 lock table 命令持有表 t 的 MDL写锁，而 session B 的查询需要获取 MDL 读锁； 
	所以，session B 进入等待状态。
	

4. 处理方式：
	
	就是找到谁持有 MDL 写锁，然后把它 kill 掉。
	
	在 show processlist 的结果里面，session A 的 Command 列是“Sleep”，导致查找起来很不方便； 

	1.MySQL 5.6版本，通过performance_schema系统库来找：
		MySQL 启动时需要设置 performance_schema=on，相比于设置为 off 会有 10% 左右的性能损失。
		
	2.MySQL 5.7版本  通过sys库来找：
	   查询 sys.schema_table_lock_waits 这张表，可以直接找出造成阻塞的 process id，用 kill 命令把这个连接断开即可。

	mysql> select * from sys.schema_table_lock_waits\G;
	*************************** 1. row ***************************
				   object_schema: admin_db
					 object_name: t
			   waiting_thread_id: 2311
					 waiting_pid: 2278
				 waiting_account: root@192.168.0.54
			   waiting_lock_type: SHARED_READ
		   waiting_lock_duration: TRANSACTION
				   waiting_query: select * from t where id=1
			  waiting_query_secs: 79
	 waiting_query_rows_affected: 0
	 waiting_query_rows_examined: 0
			  blocking_thread_id: 2310
					blocking_pid: 2277
				blocking_account: root@192.168.0.54
			  blocking_lock_type: SHARED_NO_READ_WRITE
		  blocking_lock_duration: TRANSACTION
		 sql_kill_blocking_query: KILL QUERY 2277
	sql_kill_blocking_connection: KILL 2277
	1 row in set (0.00 sec)

	mysql> kill 2277;

	

1.2 等flush

session A          session B               session C

select sleep(1) from t;
			       flush tables t write;

										   select * from t where id=1;
mysql> show processlist;
+------+-----------+--------------------+----------+-------------+--------+---------------------------+----------------------------+
| Id   | User      | Host               | db       | Command     | Time   | State                     | Info                       |
+------+-----------+--------------------+----------+-------------+--------+---------------------------+----------------------------+
| 2289 | root      | 192.168.0.54:44040 | admin_db | Query       |     64 | User sleep                | select sleep(1) from t     |
| 2293 | root      | 192.168.0.54:44042 | admin_db | Query       |      2 | Waiting for table flush   | select * from t where id=1 |
| 2294 | root      | 192.168.0.54:44044 | NULL     | Query       |      0 | starting                  | show processlist           |
| 2295 | app_user  | 192.168.0.71:33533 | NULL     | Sleep       |     58 |                           | NULL                       |
| 2296 | app_user  | 192.168.0.71:33537 | NULL     | Sleep       |     43 |                           | NULL                       |
| 2297 | root      | 192.168.0.54:44046 | admin_db | Query       |     31 | Waiting for table flush   | flush tables t             |
+------+-----------+--------------------+----------+-------------+--------+---------------------------+----------------------------+


1.分析：
	1. 在 session A 中，每行都调用一次 sleep(1)，这样这个语句默认要执行 10 万秒，
	   在这期间表 t 一直是被 session A“打开”着。

	2. session B 的 flush tables t 命令再要去关闭表 t，就需要等 session A 的查询结束。

	3. session C 要再次查询的话，就会被 flush 命令堵住了。	
	
2. 表现：使用show processlist命令查看State的状态处于 Waiting for table flush; 

3. 这里状态处于Waiting for table flush的含义：
	
	表示 现在有一个线程正要对 表t 做 flush操作; 
	
4. 出现Waiting for table flush状态的可能情况：
	有一个 flush tables 命令被别的语句堵住了，然后它又堵住了我们的 select 语句。

5. MySQL 里面对表做 flush 操作的两个用法：

	flush tables t with read lock;
	flush tables with read lock;

	flush 语句，如果指定表 t 的话，代表的是只关闭表 t；
	如果没有指定具体的表名，则表示关闭 MySQL 里所有打开的表。
	
5. 查询语句需要打开表, flush tables语句需要关闭表; 
   因此, 同一个表不能在同一个时间段做打开表和关闭表操作。	

1.3 等行锁
	
session A                session B

begin;

update t set c=c+1 where id=1;
							
						select * from t where id=1 lock in share mode;

mysql> select * from sys.innodb_lock_waits\G;
*************************** 1. row ***************************
                wait_started: 2019-07-22 10:17:47
                    wait_age: 00:00:24
               wait_age_secs: 24
                locked_table: `admin_db`.`t`
                locked_index: PRIMARY
                 locked_type: RECORD
              waiting_trx_id: 421298126309664
         waiting_trx_started: 2019-07-22 10:17:47
             waiting_trx_age: 00:00:24
     waiting_trx_rows_locked: 1
   waiting_trx_rows_modified: 0
                 waiting_pid: 2328
               waiting_query: select * from t where id=1 lock in share mode
             waiting_lock_id: 421298126309664:4347:4:2
           waiting_lock_mode: S
             blocking_trx_id: 8114275
                blocking_pid: 2327
              blocking_query: NULL
            blocking_lock_id: 8114275:4347:4:2
          blocking_lock_mode: X
        blocking_trx_started: 2019-07-22 10:16:16
            blocking_trx_age: 00:01:55
    blocking_trx_rows_locked: 1
  blocking_trx_rows_modified: 1
     sql_kill_blocking_query: KILL QUERY 2327
sql_kill_blocking_connection: KILL 2327
1 row in set, 3 warnings (0.01 sec)

mysql> kill 2327; 

 分析：
	1. 通过 sys.innodb_lock_waits表查找到 blocking pid,  用 kill blocking pid断开这个连接；
	2. 连接被断开的时候，会自动回滚这个连接里面正在执行的线程，也就释放了 行锁。

2.第二类: 查询慢
	

delimiter ;;
create procedure update_100w()
begin
  declare i int;
  set i=1;
	start transaction;
  while(i<=1000000) do
    update t set c=c+1 where id=1;
    set i=i+1;
  end while;
	commit;
end;;
delimiter ;

session A            	session B
start transaction with consistent snapshot; 
						
						update t set c=c+1 id=1;
						#待执行100W次结束之后, 开始执行 session A的查询语句;				 
						#用存储过程实现: call update_100w();
					 
select * from t where id=1;
select * from t where id=1 lock in share mode;					 

	
	
mysql> select * from t where id=1;
+----+------+
| id | c    |
+----+------+
|  1 |    1 |
+----+------+
1 row in set (0.97 sec)

mysql> select * from t where id=1 lock in share mode;
+----+---------+
| id | c       |
+----+---------+
|  1 | 1000001 |
+----+---------+
1 row in set (0.00 sec)


1. session B 更新完 100 万次，生成了 100 万个回滚日志 (undo log);
2. lock in share mode: 当前读，因此会直接读到 1000001 这个结果，所以速度很快;
3. select * from t where id=1: 一致性读，因此需要从 1000001 开始，依次执行 undo log，执行了 100 万次以后，才将 1 这个结果返回;
4. undo log 里记录的其实是“把 2 改成 1”，“把 3 改成 2”这样的操作逻辑，画成减 1 的目的是方便看图。


