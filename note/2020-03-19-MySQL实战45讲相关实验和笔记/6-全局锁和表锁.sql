

表锁
	
	表锁的语法: lock tables … read/write。
	释放表锁: unlock tables; 也可以在客户端断开的时候自动释放。
	lock tables 语法除了会限制别的线程的读写外，也限定了本线程接下来的操作对象。
	举例说明:
		在某个线程 A 中执行 lock tables t1 read, t2 write; 这个语句，则其他线程写 t1、读写 t2 的语句都会被阻塞。
		同时，线程 A 在执行 unlock tables 之前，也只能执行读 t1、读写 t2 的操作。
		连写 t1 都不允许，自然也不能访问其他表。
	应用场景：
		mysqldump备份生成的逻辑文件中， 在insert ...语句前面会对表加表的写锁
		参考实验笔记：《2020-04-22-导入mysqldump备份的数据期间查询表数据会处于MDL锁状态.sql》
		lock tables ... write;
		insert into ...
		unlock tables;
		
	
MyISAM:
	不支持行锁
	不支持事务
	
	
给一个表加字段、删除字段，需要扫描全表的数据, 即需要重建表。
对大表的操作要谨慎，以免对线上服务造成影响。
对小表操作不慎也会出问题。






















CREATE TABLE `t` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `c` (`c`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

INSERT INTO `sbtest`.`t` (`id`, `c`, `d`) VALUES ('1', '1', '1');
INSERT INTO `sbtest`.`t` (`id`, `c`, `d`) VALUES ('2', '2', '2');
INSERT INTO `sbtest`.`t` (`id`, `c`, `d`) VALUES ('3', '3', '3');
INSERT INTO `sbtest`.`t` (`id`, `c`, `d`) VALUES ('4', '4', '4');
INSERT INTO `sbtest`.`t` (`id`, `c`, `d`) VALUES ('5', '5', '5');


如果没有MDL元数据锁，会存在什么问题


案例1：
session A    	session B
begin; 
select * from t where id=1; 

				alter table t add column d varchar(100) not null default "" comment ""; 

select * from t where id=1;
能读取到新增字段，d列的值;  -- 违反了事务隔离级别，在RR隔离级别下，无法实现可重复读。

				


session A    session B
begin; 
select * from t where id=1; 

			 drop table t; 

select * from t where id=1;
报错。 -- 违反了事务隔离级别，在RR隔离级别下，无法实现可重复读。



违反了事务隔离级别，在RR隔离级别下，无法实现可重复读。
普通查询不加行锁，但是需要加MDL读锁。






在MySQL5.5.3之前，有一个著名的bug#989，大致如下:
 
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


