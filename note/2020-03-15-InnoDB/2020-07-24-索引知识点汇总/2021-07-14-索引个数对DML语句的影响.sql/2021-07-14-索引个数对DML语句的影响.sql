
大纲
1. SSD盘
	1.1 初始化表结构
	1.2 双1配置
	1.3 操作10W行记录
		1.3.1 insert 
		1.3.2 update 
		1.3.3 delete 
	1.4 操作50W行记录
		1.4.1 insert 
		1.4.2 update
		1.4.3 delete 

2. 机械盘
	2.1 初始化表结构
	2.2 双1配置
	2.3 操作10W行记录
		2.3.1 insert 
		2.3.2 update 
		2.3.3 delete 


	2.4 操作50W行记录
		2.4.1 insert 
		2.4.2 update 
		2.4.3 delete 

3. 小结
4. 相关参考
5. 通过delete删除数据不会释放表空间



1. SSD盘

1.1 初始化表结构

	CREATE TABLE `t0` (
	  `id` int unsigned NOT NULL AUTO_INCREMENT,
	  `r0` int DEFAULT NULL,
	  `r1` int DEFAULT NULL,
	  `r2` int DEFAULT NULL,
	  `r3` int DEFAULT NULL,
	  `r4` int DEFAULT NULL,
	  `r5` int DEFAULT NULL,
	  `r6` int DEFAULT NULL,
	  `r7` int DEFAULT NULL,
	  `r8` int DEFAULT NULL,
	  `r9` int DEFAULT NULL,
	  `r10` int DEFAULT NULL,
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



	for i in `seq 1 10`;do mysql -h192.168.1.10 -uroot -p -e "use consistency_db;create table t$i like t0";done;
	for i in `seq 1 10`; do for j in `seq 1 "$i"`; do mysql -h192.168.1.10 -uroot -p -e"use consistency_db;alter table t$i add key idx_r$j (r$j)"; done; done;



	DELIMITER $$


	DROP PROCEDURE IF EXISTS `sp_batch_write`$$

	CREATE DEFINER=`root`@`%` PROCEDURE `sp_batch_write`(
		IN f_write ENUM('insert','update','delete'),
		IN f_table_name VARCHAR(64),
		IN f_num INT UNSIGNED
		)
	BEGIN
	  DECLARE i INT UNSIGNED DEFAULT 0;
	  
	  IF f_write = 'insert' THEN
		SET @stmt = CONCAT('insert into ',f_table_name,'(r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10)  
							values (ceil(rand()*10000),ceil(rand()*10000),ceil(rand()*10000),
							ceil(rand()*10000),ceil(rand()*10000),ceil(rand()*10000),ceil(rand()*10000),
							ceil(rand()*10000),ceil(rand()*10000),ceil(rand()*10000),ceil(rand()*10000))');
	   
		SET @@autocommit=0;
		WHILE i < f_num
		DO
		  PREPARE s1 FROM @stmt;
		  EXECUTE s1;
		  IF MOD(i,50) = 0 THEN
			COMMIT;
		  END IF;
		  SET i = i + 1;
		END WHILE;  
		DROP PREPARE s1;
		COMMIT;
		SET @@autocommit=1;

	  ELSEIF f_write = 'update' THEN
		SET @stmt = CONCAT('update ',f_table_name,' set r0=ceil(rand()*10000),r1 = ceil(rand()*10000),
		r2 = ceil(rand()*10000),r3 = ceil(rand()*10000),r4 = ceil(rand()*10000),
		r5 = ceil(rand()*10000),r6 = ceil(rand()*10000),r7 = ceil(rand()*10000),
		r8 = ceil(rand()*10000),r9 = ceil(rand()*10000),r10 = ceil(rand()*10000)');
		PREPARE s1 FROM @stmt;
		EXECUTE s1;
		DROP PREPARE s1;
	  ELSEIF f_write = 'delete' THEN
		SET @stmt = CONCAT('delete from ',f_table_name);
		PREPARE s1 FROM @stmt;
		EXECUTE s1;
		DROP PREPARE s1;
	  END IF;

	END$$

	DELIMITER ;

1.2 双1配置

	Database changed
	mysql> show global variables like '%sync_binlog%';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| sync_binlog   | 1     |
	+---------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%flush_log%';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| innodb_flush_log_at_timeout    | 1     |
	| innodb_flush_log_at_trx_commit | 1     |
	+--------------------------------+-------+
	2 rows in set (0.00 sec)

	mysql> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.26-log |
	+------------+
	1 row in set (0.00 sec)


1.3 操作10W行记录

	1.3.1 insert 

		call sp_batch_write('insert','t1',100000);
		call sp_batch_write('insert','t2',100000);
		call sp_batch_write('insert','t3',100000);
		call sp_batch_write('insert','t4',100000);
		call sp_batch_write('insert','t5',100000);
		call sp_batch_write('insert','t6',100000);
		call sp_batch_write('insert','t7',100000);
		call sp_batch_write('insert','t8',100000);
		call sp_batch_write('insert','t9',100000);
		call sp_batch_write('insert','t10',100000);



		--第一次测试
		
		mysql> call sp_batch_write('insert','t1',100000);
		Query OK, 0 rows affected (13.53 sec)

		mysql> call sp_batch_write('insert','t2',100000);
		Query OK, 0 rows affected (14.03 sec)

		mysql> call sp_batch_write('insert','t3',100000);
		Query OK, 0 rows affected (15.02 sec)

		mysql> call sp_batch_write('insert','t4',100000);
		Query OK, 0 rows affected (14.67 sec)

		mysql> call sp_batch_write('insert','t5',100000);
		Query OK, 0 rows affected (14.94 sec)

		mysql> call sp_batch_write('insert','t6',100000);
		Query OK, 0 rows affected (15.61 sec)

		mysql> call sp_batch_write('insert','t7',100000);
		Query OK, 0 rows affected (15.98 sec)

		mysql> call sp_batch_write('insert','t8',100000);
		Query OK, 0 rows affected (16.03 sec)

		mysql> call sp_batch_write('insert','t9',100000);
		Query OK, 0 rows affected (16.62 sec)

		mysql> call sp_batch_write('insert','t10',100000);
		Query OK, 0 rows affected (16.93 sec)

		-------------------------------------------------------
		
		--第二次测试
		mysql> call sp_batch_write('insert','t1',100000);
		Query OK, 0 rows affected (13.69 sec)

		mysql> call sp_batch_write('insert','t2',100000);
		Query OK, 0 rows affected (14.07 sec)

		mysql> call sp_batch_write('insert','t3',100000);
		Query OK, 0 rows affected (14.61 sec)

		mysql> call sp_batch_write('insert','t4',100000);
		Query OK, 0 rows affected (15.00 sec)

		mysql> call sp_batch_write('insert','t5',100000);
		Query OK, 0 rows affected (15.28 sec)

		mysql> call sp_batch_write('insert','t6',100000);
		Query OK, 0 rows affected (15.56 sec)

		mysql> call sp_batch_write('insert','t7',100000);
		Query OK, 0 rows affected (16.06 sec)

		mysql> call sp_batch_write('insert','t8',100000);
		Query OK, 0 rows affected (16.41 sec)

		mysql> call sp_batch_write('insert','t9',100000);
		Query OK, 0 rows affected (16.88 sec)

		mysql> call sp_batch_write('insert','t10',100000);
		Query OK, 0 rows affected (17.31 sec)

		-------------------------------------------------------
		
		--第三次测试
		mysql> call sp_batch_write('insert','t1',100000);
		Query OK, 0 rows affected (13.48 sec)

		mysql> call sp_batch_write('insert','t2',100000);
		Query OK, 0 rows affected (13.77 sec)

		mysql> call sp_batch_write('insert','t3',100000);
		Query OK, 0 rows affected (14.18 sec)

		mysql> call sp_batch_write('insert','t4',100000);
		Query OK, 0 rows affected (14.71 sec)

		mysql> call sp_batch_write('insert','t5',100000);
		Query OK, 0 rows affected (15.08 sec)

		mysql> call sp_batch_write('insert','t6',100000);
		Query OK, 0 rows affected (15.53 sec)

		mysql> call sp_batch_write('insert','t7',100000);
		Query OK, 0 rows affected (16.26 sec)

		mysql> call sp_batch_write('insert','t8',100000);
		Query OK, 0 rows affected (16.35 sec)

		mysql> call sp_batch_write('insert','t9',100000);
		Query OK, 0 rows affected (16.73 sec)

		mysql> call sp_batch_write('insert','t10',100000);
		Query OK, 0 rows affected (17.29 sec)



	1.3.2 update 

		call sp_batch_write('update','t1',100000);
		call sp_batch_write('update','t2',100000);
		call sp_batch_write('update','t3',100000);
		call sp_batch_write('update','t4',100000);
		call sp_batch_write('update','t5',100000);
		call sp_batch_write('update','t6',100000);
		call sp_batch_write('update','t7',100000);
		call sp_batch_write('update','t8',100000);
		call sp_batch_write('update','t9',100000);
		call sp_batch_write('update','t10',100000);


		mysql> call sp_batch_write('update','t1',100000);
		Query OK, 0 rows affected (1.46 sec)

		mysql> call sp_batch_write('update','t2',100000);
		Query OK, 0 rows affected (2.02 sec)

		mysql> call sp_batch_write('update','t3',100000);
		Query OK, 0 rows affected (2.76 sec)

		mysql> call sp_batch_write('update','t4',100000);
		Query OK, 0 rows affected (3.36 sec)

		mysql> call sp_batch_write('update','t5',100000);
		Query OK, 0 rows affected (5.08 sec)

		mysql> call sp_batch_write('update','t6',100000);
		Query OK, 0 rows affected (5.18 sec)

		mysql> call sp_batch_write('update','t7',100000);
		Query OK, 0 rows affected (5.65 sec)

		mysql> call sp_batch_write('update','t8',100000);
		Query OK, 0 rows affected (7.78 sec)

		mysql> call sp_batch_write('update','t9',100000);
		Query OK, 0 rows affected (9.01 sec)

		mysql> call sp_batch_write('update','t10',100000);
		Query OK, 0 rows affected (8.75 sec)

		-------------------------------------------------------
		
		--第二次测试
		--间隔3-5秒再执行下一个表的update操作
		mysql> call sp_batch_write('update','t1',100000);
		Query OK, 0 rows affected (1.41 sec)

		mysql> call sp_batch_write('update','t2',100000);
		Query OK, 0 rows affected (2.05 sec)

		mysql> call sp_batch_write('update','t3',100000);
		Query OK, 0 rows affected (2.85 sec)

		mysql> call sp_batch_write('update','t4',100000);
		Query OK, 0 rows affected (3.41 sec)

		mysql> call sp_batch_write('update','t5',100000);
		Query OK, 0 rows affected (4.26 sec)

		mysql> call sp_batch_write('update','t6',100000);
		Query OK, 0 rows affected (4.86 sec)

		mysql> call sp_batch_write('update','t7',100000);
		Query OK, 0 rows affected (5.83 sec)

		mysql> call sp_batch_write('update','t8',100000);
		Query OK, 0 rows affected (6.76 sec)

		mysql> call sp_batch_write('update','t9',100000);
		Query OK, 0 rows affected (7.32 sec)

		mysql> call sp_batch_write('update','t10',100000);
		Query OK, 0 rows affected (8.20 sec)



	1.3.3 delete 

		call sp_batch_write('delete','t1',100000);
		call sp_batch_write('delete','t2',100000);
		call sp_batch_write('delete','t3',100000);
		call sp_batch_write('delete','t4',100000);
		call sp_batch_write('delete','t5',100000);
		call sp_batch_write('delete','t6',100000);
		call sp_batch_write('delete','t7',100000);
		call sp_batch_write('delete','t8',100000);
		call sp_batch_write('delete','t9',100000);
		call sp_batch_write('delete','t10',100000);


		mysql> call sp_batch_write('delete','t1',100000);
		Query OK, 0 rows affected (0.51 sec)

		mysql> call sp_batch_write('delete','t2',100000);
		Query OK, 0 rows affected (1.15 sec)

		mysql> call sp_batch_write('delete','t3',100000);
		Query OK, 0 rows affected (1.39 sec)

		mysql> call sp_batch_write('delete','t4',100000);
		Query OK, 0 rows affected (1.61 sec)

		mysql> call sp_batch_write('delete','t5',100000);
		Query OK, 0 rows affected (1.93 sec)

		mysql> call sp_batch_write('delete','t6',100000);
		Query OK, 0 rows affected (2.21 sec)

		mysql> call sp_batch_write('delete','t7',100000);
		Query OK, 0 rows affected (2.51 sec)

		mysql> call sp_batch_write('delete','t8',100000);
		Query OK, 0 rows affected (2.87 sec)

		mysql> call sp_batch_write('delete','t9',100000);
		Query OK, 0 rows affected (3.16 sec)

		mysql> call sp_batch_write('delete','t10',100000);
		Query OK, 0 rows affected (2.19 sec)

		
		-------------------------------------------------------
		
		--间隔3-5秒再执行下一个表的删除操作
		mysql> call sp_batch_write('delete','t1',100000);
		Query OK, 0 rows affected (0.55 sec)

		mysql> call sp_batch_write('delete','t2',100000);
		Query OK, 0 rows affected (0.75 sec)

		mysql> call sp_batch_write('delete','t3',100000);
		Query OK, 0 rows affected (0.91 sec)

		mysql> call sp_batch_write('delete','t4',100000);
		Query OK, 0 rows affected (1.15 sec)

		mysql> call sp_batch_write('delete','t5',100000);
		Query OK, 0 rows affected (1.30 sec)

		mysql> call sp_batch_write('delete','t6',100000);
		Query OK, 0 rows affected (1.48 sec)

		mysql> call sp_batch_write('delete','t7',100000);
		Query OK, 0 rows affected (1.61 sec)

		mysql> call sp_batch_write('delete','t8',100000);
		Query OK, 0 rows affected (1.76 sec)

		mysql> call sp_batch_write('delete','t9',100000);
		Query OK, 0 rows affected (1.96 sec)

		mysql> call sp_batch_write('delete','t10',100000);
		Query OK, 0 rows affected (2.27 sec)


	
------------------------------------------------------

1.4 操作50W行记录

	truncate table t1;
	truncate table t2;
	truncate table t3;
	truncate table t4;
	truncate table t5;
	truncate table t6;
	truncate table t7;
	truncate table t8;
	truncate table t9;
	truncate table t10;
	
	mysql> truncate table t1;
	Query OK, 0 rows affected (0.03 sec)

	mysql> truncate table t2;
	Query OK, 0 rows affected (0.02 sec)

	mysql> truncate table t3;
	Query OK, 0 rows affected (0.02 sec)

	mysql> truncate table t4;
	Query OK, 0 rows affected (0.03 sec)

	mysql> truncate table t5;
	Query OK, 0 rows affected (0.03 sec)

	mysql> truncate table t6;
	Query OK, 0 rows affected (0.02 sec)

	mysql> truncate table t7;
	Query OK, 0 rows affected (0.03 sec)

	mysql> truncate table t8;
	Query OK, 0 rows affected (0.03 sec)

	mysql> truncate table t9;
	Query OK, 0 rows affected (0.02 sec)

	mysql> truncate table t10;
	Query OK, 0 rows affected (0.03 sec)
		
	1.4.1 insert 

		call sp_batch_write('insert','t1',500000);
		call sp_batch_write('insert','t2',500000);
		call sp_batch_write('insert','t3',500000);
		call sp_batch_write('insert','t4',500000);
		call sp_batch_write('insert','t5',500000);
		call sp_batch_write('insert','t6',500000);
		call sp_batch_write('insert','t7',500000);
		call sp_batch_write('insert','t8',500000);
		call sp_batch_write('insert','t9',500000);
		call sp_batch_write('insert','t10',500000);

		mysql> call sp_batch_write('insert','t1',500000);
		Query OK, 0 rows affected (1 min 7.83 sec)

		mysql> call sp_batch_write('insert','t2',500000);
		Query OK, 0 rows affected (1 min 8.85 sec)

		mysql> call sp_batch_write('insert','t3',500000);
		Query OK, 0 rows affected (1 min 10.61 sec)

		mysql> call sp_batch_write('insert','t4',500000);
		Query OK, 0 rows affected (1 min 11.30 sec)

		mysql> call sp_batch_write('insert','t5',500000);
		Query OK, 0 rows affected (1 min 13.70 sec)

		mysql> call sp_batch_write('insert','t6',500000);
		Query OK, 0 rows affected (1 min 14.88 sec)

		mysql> call sp_batch_write('insert','t7',500000);
		Query OK, 0 rows affected (1 min 17.60 sec)

		mysql> call sp_batch_write('insert','t8',500000);
		Query OK, 0 rows affected (1 min 18.74 sec)

		mysql> call sp_batch_write('insert','t9',500000);
		Query OK, 0 rows affected (1 min 21.05 sec)

		mysql> call sp_batch_write('insert','t10',500000);
		Query OK, 0 rows affected (1 min 22.64 sec)



	1.4.2 update 

		call sp_batch_write('update','t1',100000);
		call sp_batch_write('update','t2',100000);
		call sp_batch_write('update','t3',100000);
		call sp_batch_write('update','t4',100000);
		call sp_batch_write('update','t5',100000);
		call sp_batch_write('update','t6',100000);
		call sp_batch_write('update','t7',100000);
		call sp_batch_write('update','t8',100000);
		call sp_batch_write('update','t9',100000);
		call sp_batch_write('update','t10',100000);



		mysql> call sp_batch_write('update','t1',100000);
		Query OK, 0 rows affected (7.79 sec)

		mysql> call sp_batch_write('update','t2',100000);
		Query OK, 0 rows affected (12.99 sec)

		mysql> call sp_batch_write('update','t3',100000);
		Query OK, 0 rows affected (18.50 sec)

		mysql> call sp_batch_write('update','t4',100000);
		Query OK, 0 rows affected (24.37 sec)

		mysql> call sp_batch_write('update','t5',100000);
		Query OK, 0 rows affected (30.79 sec)

		mysql> call sp_batch_write('update','t6',100000);
		Query OK, 0 rows affected (37.95 sec)

		mysql> call sp_batch_write('update','t7',100000);
		Query OK, 0 rows affected (44.79 sec)

		mysql> call sp_batch_write('update','t8',100000);
		Query OK, 0 rows affected (49.83 sec)

		mysql> call sp_batch_write('update','t9',100000);
		Query OK, 0 rows affected (57.44 sec)

		mysql> call sp_batch_write('update','t10',100000);
		Query OK, 0 rows affected (1 min 5.20 sec)


---------------------------------------------------

	1.4.3 delete 

		call sp_batch_write('delete','t1',100000);
		call sp_batch_write('delete','t2',100000);
		call sp_batch_write('delete','t3',100000);
		call sp_batch_write('delete','t4',100000);
		call sp_batch_write('delete','t5',100000);
		call sp_batch_write('delete','t6',100000);
		call sp_batch_write('delete','t7',100000);
		call sp_batch_write('delete','t8',100000);
		call sp_batch_write('delete','t9',100000);
		call sp_batch_write('delete','t10',100000);
		
		mysql> call sp_batch_write('delete','t1',100000);
		Query OK, 0 rows affected (3.21 sec)
		
		mysql> call sp_batch_write('delete','t2',100000);
		Query OK, 0 rows affected (5.78 sec)

		mysql> call sp_batch_write('delete','t3',100000);
		Query OK, 0 rows affected (6.13 sec)

		mysql> call sp_batch_write('delete','t4',100000);
		Query OK, 0 rows affected (7.87 sec)

		mysql> call sp_batch_write('delete','t5',100000);
		Query OK, 0 rows affected (9.14 sec)

		mysql> call sp_batch_write('delete','t6',100000);
		Query OK, 0 rows affected (10.74 sec)

		mysql> call sp_batch_write('delete','t7',100000);
		Query OK, 0 rows affected (12.29 sec)

		mysql> call sp_batch_write('delete','t8',100000);
		Query OK, 0 rows affected (15.80 sec)

		mysql> call sp_batch_write('delete','t9',100000);
		Query OK, 0 rows affected (17.76 sec)

		mysql> call sp_batch_write('delete','t10',100000);
		Query OK, 0 rows affected (18.82 sec)

		delete 语句执行的速度确实快，因为找到记录之后只是打了个删除标记就可以直接返回了。


---------------------------------------------------

2. 机械盘

2.1 初始化表结构



	CREATE TABLE `t0` (
	  `id` int unsigned NOT NULL AUTO_INCREMENT,
	  `r0` int DEFAULT NULL,
	  `r1` int DEFAULT NULL,
	  `r2` int DEFAULT NULL,
	  `r3` int DEFAULT NULL,
	  `r4` int DEFAULT NULL,
	  `r5` int DEFAULT NULL,
	  `r6` int DEFAULT NULL,
	  `r7` int DEFAULT NULL,
	  `r8` int DEFAULT NULL,
	  `r9` int DEFAULT NULL,
	  `r10` int DEFAULT NULL,
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



	for i in `seq 1 10`;do mysql -h192.168.0.242 -uroot -p'@ly242yhn%.' -e "use abc_db;create table t$i like t0";done;
	for i in `seq 1 10`; do for j in `seq 1 "$i"`; do mysql -h192.168.0.242 -uroot -p'@ly242yhn%.' -e"use abc_db;alter table t$i add key idx_r$j (r$j)"; done; done;



	DELIMITER $$


	DROP PROCEDURE IF EXISTS `sp_batch_write`$$

	CREATE DEFINER=`root`@`%` PROCEDURE `sp_batch_write`(
		IN f_write ENUM('insert','update','delete'),
		IN f_table_name VARCHAR(64),
		IN f_num INT UNSIGNED
		)
	BEGIN
	  DECLARE i INT UNSIGNED DEFAULT 0;
	  
	  IF f_write = 'insert' THEN
		SET @stmt = CONCAT('insert into ',f_table_name,'(r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10)  
							values (ceil(rand()*10000),ceil(rand()*10000),ceil(rand()*10000),
							ceil(rand()*10000),ceil(rand()*10000),ceil(rand()*10000),ceil(rand()*10000),
							ceil(rand()*10000),ceil(rand()*10000),ceil(rand()*10000),ceil(rand()*10000))');
	   
		SET @@autocommit=0;
		WHILE i < f_num
		DO
		  PREPARE s1 FROM @stmt;
		  EXECUTE s1;
		  IF MOD(i,50) = 0 THEN
			COMMIT;
		  END IF;
		  SET i = i + 1;
		END WHILE;  
		DROP PREPARE s1;
		COMMIT;
		SET @@autocommit=1;

	  ELSEIF f_write = 'update' THEN
		SET @stmt = CONCAT('update ',f_table_name,' set r0=ceil(rand()*10000),r1 = ceil(rand()*10000),
		r2 = ceil(rand()*10000),r3 = ceil(rand()*10000),r4 = ceil(rand()*10000),
		r5 = ceil(rand()*10000),r6 = ceil(rand()*10000),r7 = ceil(rand()*10000),
		r8 = ceil(rand()*10000),r9 = ceil(rand()*10000),r10 = ceil(rand()*10000)');
		PREPARE s1 FROM @stmt;
		EXECUTE s1;
		DROP PREPARE s1;
	  ELSEIF f_write = 'delete' THEN
		SET @stmt = CONCAT('delete from ',f_table_name);
		PREPARE s1 FROM @stmt;
		EXECUTE s1;
		DROP PREPARE s1;
	  END IF;

	END$$

	DELIMITER ;
	
	
2.2 双1配置

	root@mysqldb 15:06:  [(none)]> show global variables like '%sync_binlog%';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| sync_binlog   | 1     |
	+---------------+-------+
	1 row in set (0.00 sec)

	root@mysqldb 15:06:  [(none)]> show global variables like '%flush_log%';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| innodb_flush_log_at_timeout    | 1     |
	| innodb_flush_log_at_trx_commit | 1     |
	+--------------------------------+-------+
	2 rows in set (0.00 sec)

	root@mysqldb 15:06:  [(none)]> select version();
	+------------+
	| version()  |
	+------------+
	| 5.7.22-log |
	+------------+
	1 row in set (0.00 sec)


2.3 操作10W行记录

	2.3.1 insert 
		call sp_batch_write('insert','t1',100000);
		call sp_batch_write('insert','t2',100000);
		call sp_batch_write('insert','t3',100000);
		call sp_batch_write('insert','t4',100000);
		call sp_batch_write('insert','t5',100000);
		call sp_batch_write('insert','t6',100000);
		call sp_batch_write('insert','t7',100000);
		call sp_batch_write('insert','t8',100000);
		call sp_batch_write('insert','t9',100000);
		call sp_batch_write('insert','t10',100000);


		root@mysqldb 15:13:  [abc_db]> call sp_batch_write('insert','t1',100000);
		Query OK, 0 rows affected (2 min 27.16 sec)

		root@mysqldb 15:13:  [abc_db]> call sp_batch_write('insert','t2',100000);
		Query OK, 0 rows affected (2 min 36.39 sec)

		root@mysqldb 15:16:  [abc_db]> call sp_batch_write('insert','t3',100000);
		Query OK, 0 rows affected (2 min 43.20 sec)

		root@mysqldb 15:18:  [abc_db]> call sp_batch_write('insert','t4',100000);
		Query OK, 0 rows affected (2 min 45.90 sec)

		root@mysqldb 15:21:  [abc_db]> call sp_batch_write('insert','t5',100000);
		Query OK, 0 rows affected (2 min 38.10 sec)

		root@mysqldb 15:24:  [abc_db]> call sp_batch_write('insert','t6',100000);
		Query OK, 0 rows affected (2 min 41.40 sec)

		root@mysqldb 15:27:  [abc_db]> call sp_batch_write('insert','t7',100000);
		Query OK, 0 rows affected (2 min 43.50 sec)

		root@mysqldb 15:29:  [abc_db]> call sp_batch_write('insert','t8',100000);
		Query OK, 0 rows affected (2 min 39.93 sec)

		root@mysqldb 15:32:  [abc_db]> call sp_batch_write('insert','t9',100000);
		Query OK, 0 rows affected (2 min 44.54 sec)
		
		root@mysqldb 11:29:  [abc_db]> call sp_batch_write('insert','t10',100000);
		Query OK, 0 rows affected (2 min 41.00 sec)


		--第二次测试
		root@mysqldb 11:34:  [abc_db]> call sp_batch_write('insert','t1',100000);
		Query OK, 0 rows affected (2 min 54.13 sec)

		root@mysqldb 11:37:  [abc_db]> call sp_batch_write('insert','t2',100000);
		Query OK, 0 rows affected (2 min 49.57 sec)

		root@mysqldb 11:40:  [abc_db]> call sp_batch_write('insert','t3',100000);
		Query OK, 0 rows affected (2 min 42.13 sec)

		root@mysqldb 11:43:  [abc_db]> call sp_batch_write('insert','t4',100000);
		Query OK, 0 rows affected (2 min 46.65 sec)

		root@mysqldb 11:46:  [abc_db]> call sp_batch_write('insert','t5',100000);
		Query OK, 0 rows affected (2 min 31.67 sec)

		root@mysqldb 11:48:  [abc_db]> call sp_batch_write('insert','t6',100000);
		Query OK, 0 rows affected (2 min 41.07 sec)

		root@mysqldb 11:51:  [abc_db]> call sp_batch_write('insert','t7',100000);
		Query OK, 0 rows affected (2 min 45.12 sec)

		root@mysqldb 11:54:  [abc_db]> call sp_batch_write('insert','t8',100000);
		Query OK, 0 rows affected (2 min 38.96 sec)

		root@mysqldb 11:56:  [abc_db]> call sp_batch_write('insert','t9',100000);
		Query OK, 0 rows affected (2 min 34.10 sec)

		root@mysqldb 11:59:  [abc_db]> call sp_batch_write('insert','t10',100000);
		Query OK, 0 rows affected (2 min 31.65 sec)


	2.3.2 update 

		call sp_batch_write('update','t1',100000);
		call sp_batch_write('update','t2',100000);
		call sp_batch_write('update','t3',100000);
		call sp_batch_write('update','t4',100000);
		call sp_batch_write('update','t5',100000);
		call sp_batch_write('update','t6',100000);
		call sp_batch_write('update','t7',100000);
		call sp_batch_write('update','t8',100000);
		call sp_batch_write('update','t9',100000);
		call sp_batch_write('update','t10',100000);
		
		root@mysqldb 15:37:  [abc_db]> call sp_batch_write('update','t1',100000);
		Query OK, 0 rows affected (2.01 sec)

		root@mysqldb 15:43:  [abc_db]> call sp_batch_write('update','t2',100000);
		Query OK, 0 rows affected (2.51 sec)

		root@mysqldb 15:43:  [abc_db]> call sp_batch_write('update','t3',100000);
		Query OK, 0 rows affected (3.66 sec)

		root@mysqldb 15:43:  [abc_db]> call sp_batch_write('update','t4',100000);
		Query OK, 0 rows affected (4.22 sec)

		root@mysqldb 15:43:  [abc_db]> call sp_batch_write('update','t5',100000);
		Query OK, 0 rows affected (4.52 sec)

		root@mysqldb 15:43:  [abc_db]> call sp_batch_write('update','t6',100000);
		Query OK, 0 rows affected (4.91 sec)

		root@mysqldb 15:43:  [abc_db]> call sp_batch_write('update','t7',100000);
		Query OK, 0 rows affected (5.95 sec)

		root@mysqldb 15:43:  [abc_db]> call sp_batch_write('update','t8',100000);
		Query OK, 0 rows affected (7.69 sec)

		root@mysqldb 15:43:  [abc_db]> call sp_batch_write('update','t9',100000);
		Query OK, 0 rows affected (8.74 sec)

		root@mysqldb 15:43:  [abc_db]> call sp_batch_write('update','t10',100000);
		Query OK, 0 rows affected (10.15 sec)

	2.3.3 delete 

		call sp_batch_write('delete','t1',100000);
		call sp_batch_write('delete','t2',100000);
		call sp_batch_write('delete','t3',100000);
		call sp_batch_write('delete','t4',100000);
		call sp_batch_write('delete','t5',100000);
		call sp_batch_write('delete','t6',100000);
		call sp_batch_write('delete','t7',100000);
		call sp_batch_write('delete','t8',100000);
		call sp_batch_write('delete','t9',100000);
		call sp_batch_write('delete','t10',100000);

		root@mysqldb 15:46:  [abc_db]> call sp_batch_write('delete','t1',100000);
		;Query OK, 0 rows affected (0.79 sec)

		root@mysqldb 15:46:  [abc_db]> call sp_batch_write('delete','t2',100000);
		Query OK, 0 rows affected (0.85 sec)

		root@mysqldb 15:46:  [abc_db]> call sp_batch_write('delete','t3',100000);
		Query OK, 0 rows affected (1.18 sec)

		root@mysqldb 15:46:  [abc_db]> call sp_batch_write('delete','t4',100000);
		Query OK, 0 rows affected (1.15 sec)

		root@mysqldb 15:46:  [abc_db]> call sp_batch_write('delete','t5',100000);
		Query OK, 0 rows affected (1.28 sec)

		root@mysqldb 15:46:  [abc_db]> call sp_batch_write('delete','t6',100000);
		Query OK, 0 rows affected (1.69 sec)

		root@mysqldb 15:46:  [abc_db]> call sp_batch_write('delete','t7',100000);
		Query OK, 0 rows affected (1.56 sec)

		root@mysqldb 15:46:  [abc_db]> call sp_batch_write('delete','t8',100000);
		Query OK, 0 rows affected (1.69 sec)

		root@mysqldb 15:46:  [abc_db]> call sp_batch_write('delete','t9',100000);
		Query OK, 0 rows affected (1.93 sec)

		root@mysqldb 15:46:  [abc_db]> call sp_batch_write('delete','t10',100000);
		Query OK, 0 rows affected (3.54 sec)




2.4 操作50W行记录

	truncate table t1;
	truncate table t2;
	truncate table t3;
	truncate table t4;
	truncate table t5;
	truncate table t6;
	truncate table t7;
	truncate table t8;
	truncate table t9;
	truncate table t10;
		
	root@mysqldb 15:48:  [abc_db]> truncate table t1;
	Query OK, 0 rows affected (1.47 sec)

	root@mysqldb 15:48:  [abc_db]> truncate table t2;
	Query OK, 0 rows affected (1.27 sec)

	root@mysqldb 15:48:  [abc_db]> truncate table t3;
	Query OK, 0 rows affected (0.46 sec)

	root@mysqldb 15:48:  [abc_db]> truncate table t4;
	Query OK, 0 rows affected (0.72 sec)

	root@mysqldb 15:48:  [abc_db]> truncate table t5;
	Query OK, 0 rows affected (0.25 sec)

	root@mysqldb 15:48:  [abc_db]> truncate table t6;
	Query OK, 0 rows affected (0.78 sec)

	root@mysqldb 15:48:  [abc_db]> truncate table t7;
	Query OK, 0 rows affected (0.44 sec)

	root@mysqldb 15:48:  [abc_db]> truncate table t8;
	Query OK, 0 rows affected (0.53 sec)

	root@mysqldb 15:48:  [abc_db]> truncate table t9;
	Query OK, 0 rows affected (0.31 sec)

	root@mysqldb 15:48:  [abc_db]> truncate table t10;
	Query OK, 0 rows affected (0.83 sec)
	
	2.4.1 insert 

		call sp_batch_write('insert','t1',500000);
		call sp_batch_write('insert','t2',500000);
		call sp_batch_write('insert','t3',500000);
		call sp_batch_write('insert','t4',500000);
		call sp_batch_write('insert','t5',500000);
		call sp_batch_write('insert','t6',500000);
		call sp_batch_write('insert','t7',500000);
		call sp_batch_write('insert','t8',500000);
		call sp_batch_write('insert','t9',500000);
		call sp_batch_write('insert','t10',500000);

		
		root@mysqldb 15:48:  [abc_db]> call sp_batch_write('insert','t1',500000);
		Query OK, 0 rows affected (13 min 46.30 sec)

		root@mysqldb 16:03:  [abc_db]> call sp_batch_write('insert','t2',500000);
		Query OK, 0 rows affected (12 min 53.74 sec)

		root@mysqldb 16:16:  [abc_db]> call sp_batch_write('insert','t3',500000);
		Query OK, 0 rows affected (12 min 52.23 sec)

		root@mysqldb 16:29:  [abc_db]> call sp_batch_write('insert','t4',500000);
		Query OK, 0 rows affected (14 min 26.25 sec)

		root@mysqldb 16:43:  [abc_db]> call sp_batch_write('insert','t5',500000);
		Query OK, 0 rows affected (14 min 47.79 sec)

		root@mysqldb 16:58:  [abc_db]> call sp_batch_write('insert','t6',500000);
		Query OK, 0 rows affected (15 min 6.68 sec)

		root@mysqldb 17:13:  [abc_db]> call sp_batch_write('insert','t7',500000);
		Query OK, 0 rows affected (15 min 16.79 sec)

		root@mysqldb 17:28:  [abc_db]> call sp_batch_write('insert','t8',500000);
		Query OK, 0 rows affected (15 min 27.42 sec)

		root@mysqldb 17:44:  [abc_db]> call sp_batch_write('insert','t9',500000);
		Query OK, 0 rows affected (15 min 35.27 sec)
		
		root@mysqldb 17:59:  [abc_db]> call sp_batch_write('insert','t10',500000);
		Query OK, 0 rows affected (15 min 37.51 sec)



	2.4.2 update 


		call sp_batch_write('update','t1',500000);
		call sp_batch_write('update','t2',500000);
		call sp_batch_write('update','t3',500000);
		call sp_batch_write('update','t4',500000);
		call sp_batch_write('update','t5',500000);
		call sp_batch_write('update','t6',500000);
		call sp_batch_write('update','t7',500000);
		call sp_batch_write('update','t8',500000);
		call sp_batch_write('update','t9',500000);
		call sp_batch_write('update','t10',500000);

		root@mysqldb 18:15:  [abc_db]> call sp_batch_write('update','t1',500000);
		Query OK, 0 rows affected (10.11 sec)

		root@mysqldb 18:16:  [abc_db]> call sp_batch_write('update','t2',500000);
		Query OK, 0 rows affected (13.22 sec)

		root@mysqldb 18:17:  [abc_db]> call sp_batch_write('update','t3',500000);
		Query OK, 0 rows affected (22.60 sec)

		root@mysqldb 18:17:  [abc_db]> call sp_batch_write('update','t4',500000);
		Query OK, 0 rows affected (37.19 sec)

		root@mysqldb 18:18:  [abc_db]> call sp_batch_write('update','t5',500000);
		Query OK, 0 rows affected (46.15 sec)

		root@mysqldb 18:18:  [abc_db]> call sp_batch_write('update','t6',500000);
		Query OK, 0 rows affected (52.25 sec)

		root@mysqldb 18:19:  [abc_db]> call sp_batch_write('update','t7',500000);
		Query OK, 0 rows affected (1 min 5.90 sec)

		root@mysqldb 18:20:  [abc_db]> call sp_batch_write('update','t8',500000);
		Query OK, 0 rows affected (1 min 10.32 sec)

		root@mysqldb 18:21:  [abc_db]> call sp_batch_write('update','t9',500000);
		Query OK, 0 rows affected (1 min 11.38 sec)

		root@mysqldb 18:23:  [abc_db]> call sp_batch_write('update','t10',500000);
		Query OK, 0 rows affected (1 min 25.95 sec)


	2.4.3 delete 


		call sp_batch_write('delete','t1',500000);
		call sp_batch_write('delete','t2',500000);
		call sp_batch_write('delete','t3',500000);
		call sp_batch_write('delete','t4',500000);
		call sp_batch_write('delete','t5',500000);
		call sp_batch_write('delete','t6',500000);
		call sp_batch_write('delete','t7',500000);
		call sp_batch_write('delete','t8',500000);
		call sp_batch_write('delete','t9',500000);
		call sp_batch_write('delete','t10',500000);
		
		
		root@mysqldb 18:24:  [abc_db]> call sp_batch_write('delete','t1',500000);
		Query OK, 0 rows affected (5.33 sec)

		root@mysqldb 18:25:  [abc_db]> call sp_batch_write('delete','t2',500000);
		Query OK, 0 rows affected (6.26 sec)

		root@mysqldb 18:25:  [abc_db]> call sp_batch_write('delete','t3',500000);
		Query OK, 0 rows affected (6.72 sec)

		root@mysqldb 18:25:  [abc_db]> call sp_batch_write('delete','t4',500000);
		Query OK, 0 rows affected (8.76 sec)

		root@mysqldb 18:25:  [abc_db]> call sp_batch_write('delete','t5',500000);
		Query OK, 0 rows affected (10.13 sec)

		root@mysqldb 18:25:  [abc_db]> call sp_batch_write('delete','t6',500000);
		Query OK, 0 rows affected (13.14 sec)

		root@mysqldb 18:25:  [abc_db]> call sp_batch_write('delete','t7',500000);
		Query OK, 0 rows affected (11.18 sec)

		root@mysqldb 18:26:  [abc_db]> call sp_batch_write('delete','t8',500000);
		Query OK, 0 rows affected (15.00 sec)

		root@mysqldb 18:26:  [abc_db]> call sp_batch_write('delete','t9',500000);
		Query OK, 0 rows affected (10.77 sec)

		root@mysqldb 18:26:  [abc_db]> call sp_batch_write('delete','t10',500000);
		Query OK, 0 rows affected (1 min 32.51 sec)

		
		--第二次测试
		--间隔10秒+后再执行下一个表的delete操作, 也就是等IO资源释放再执行
		
		
		root@mysqldb 12:22:  [abc_db]> call sp_batch_write('delete','t1',500000);
		Query OK, 0 rows affected (3.82 sec)

		root@mysqldb 12:22:  [abc_db]> call sp_batch_write('delete','t2',500000);
		Query OK, 0 rows affected (7.69 sec)

		root@mysqldb 12:22:  [abc_db]> call sp_batch_write('delete','t3',500000);
		Query OK, 0 rows affected (14.01 sec)

		root@mysqldb 12:23:  [abc_db]> call sp_batch_write('delete','t4',500000);
		Query OK, 0 rows affected (2 min 26.80 sec)

		
		root@mysqldb 12:26:  [abc_db]> call sp_batch_write('delete','t10',500000);
		Query OK, 0 rows affected (2 min 22.13 sec)

		
		--第三次测试
		root@mysqldb 14:08:  [abc_db]> call sp_batch_write('delete','t10',500000);
		Query OK, 0 rows affected (3 min 2.71 sec)

		
		--第四次测试
				
		root@mysqldb 14:38:  [abc_db]> call sp_batch_write('delete','t1',500000);
		Query OK, 0 rows affected (3.61 sec)

		root@mysqldb 14:39:  [abc_db]> call sp_batch_write('delete','t2',500000);
		Query OK, 0 rows affected (6.39 sec)

		root@mysqldb 14:39:  [abc_db]> call sp_batch_write('delete','t3',500000);
		Query OK, 0 rows affected (18.97 sec)
			
		root@mysqldb 14:47:  [abc_db]> call sp_batch_write('delete','t4',500000);
		Query OK, 0 rows affected (14.14 sec)

		root@mysqldb 14:50:  [abc_db]> call sp_batch_write('delete','t5',500000);
		Query OK, 0 rows affected (1 min 22.05 sec)
		
		root@mysqldb 15:19:  [abc_db]> call sp_batch_write('delete','t6',500000);
		Query OK, 0 rows affected (1 min 12.01 sec)
			
		root@mysqldb 15:22:  [abc_db]> call sp_batch_write('delete','t7',500000);
		Query OK, 0 rows affected (1 min 25.14 sec)
			
		root@mysqldb 15:27:  [abc_db]> call sp_batch_write('delete','t8',500000);
		Query OK, 0 rows affected (1 min 44.48 sec)
		
		root@mysqldb 15:32:  [abc_db]> call sp_batch_write('delete','t9',500000);
		Query OK, 0 rows affected (1 min 52.98 sec)
			
		root@mysqldb 15:47:  [abc_db]> call sp_batch_write('delete','t10',500000);
		Query OK, 0 rows affected (15.77 sec)


3. 小结
	
	1. 索引个数的增加，DML操作的耗时都有一定的增加。
		
	2. delete语句的执行速度很快，因为找到记录之后只是打了个删除标记就可以直接返回了。后期purge线程定期清理打删除标记的记录，并不会回收/释放磁盘空间。
	
	3. 在机械盘下做实验测试，费时费力。
	
	4. 磁盘能力对比

		磁盘类型   			顺序写的IOPS   顺序读的IOPS   混合随机读写的IOPS
		100GB的SSD      	3074           3072			  r=1502,w=1500 IOPS
		900GB的机械盘		12000		   20000		  r=129,w=104 IOPS
	
		随机读和写的IO能力体现出来了：
			SSD盘的随机读和写的IO能力比机械盘的高10倍，在insert和delete操作耗时比较中，SSD盘也有10倍左右的性能提升。
	
		
4. 相关参考
	
	https://mp.weixin.qq.com/s/_6zG2GNKmFubyv8EJbmQWQ  第31期：索引设计（索引数量探讨）
	
	
5. 通过delete删除数据不会释放表空间

	-rw-r----- 1 mysql mysql  40M Jul 15 11:54 t10.ibd
	-rw-r----- 1 mysql mysql  40M Jul 15 11:54 t9.ibd
	-rw-r----- 1 mysql mysql  36M Jul 15 11:54 t8.ibd
	-rw-r----- 1 mysql mysql  36M Jul 15 11:53 t7.ibd
	-rw-r----- 1 mysql mysql  30M Jul 15 11:53 t6.ibd
	-rw-r----- 1 mysql mysql  28M Jul 15 11:53 t5.ibd
	-rw-r----- 1 mysql mysql  25M Jul 15 11:53 t4.ibd
	-rw-r----- 1 mysql mysql  23M Jul 15 11:52 t3.ibd
	-rw-r----- 1 mysql mysql  20M Jul 15 11:52 t2.ibd
	-rw-r----- 1 mysql mysql  18M Jul 15 11:52 t1.ibd


	call sp_batch_write('delete','t1',100000);
	call sp_batch_write('delete','t2',100000);
	call sp_batch_write('delete','t3',100000);
	call sp_batch_write('delete','t4',100000);
	call sp_batch_write('delete','t5',100000);
	call sp_batch_write('delete','t6',100000);
	call sp_batch_write('delete','t7',100000);
	call sp_batch_write('delete','t8',100000);
	call sp_batch_write('delete','t9',100000);
	call sp_batch_write('delete','t10',100000);

	
	-rw-r----- 1 mysql mysql  36M Jul 15 11:55 t7.ibd
	-rw-r----- 1 mysql mysql  30M Jul 15 11:55 t6.ibd
	-rw-r----- 1 mysql mysql  28M Jul 15 11:55 t5.ibd
	-rw-r----- 1 mysql mysql  25M Jul 15 11:55 t4.ibd
	-rw-r----- 1 mysql mysql  23M Jul 15 11:55 t3.ibd
	-rw-r----- 1 mysql mysql  20M Jul 15 11:55 t2.ibd
	-rw-r----- 1 mysql mysql  18M Jul 15 11:55 t1.ibd
	-rw-r----- 1 mysql mysql  40M Jul 15 11:54 t10.ibd
	-rw-r----- 1 mysql mysql  40M Jul 15 11:54 t9.ibd
	-rw-r----- 1 mysql mysql  36M Jul 15 11:54 t8.ibd

