

0. 问题
1. 环境
2. 初始表结构和数据
3. 语句的执行次序
4. 结果

0. 问题
	
	如果在 insert … select 执行期间有其他线程操作原表，会导致逻辑错误？
    答：其实，这是不会的，如果不加锁，就是快照读。一条语句执行期间，它的一致性视图是不会修改的，所以即使有其他事务修改了原表的数据，也不会影响这条语句看到的数据。
   


1. 环境
	
	mysql> show global variables like '%binlog_format%';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| binlog_format | ROW   |
	+---------------+-------+
	1 row in set (0.00 sec)


	mysql> select version();
	+-----------+
	| version() |
	+-----------+
	| 8.0.18    |
	+-----------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%iso%';
	+-----------------------+----------------+
	| Variable_name         | Value          |
	+-----------------------+----------------+
	| transaction_isolation | READ-COMMITTED |
	+-----------------------+----------------+
	1 row in set (0.03 sec)

2. 初始表结构和数据

	CREATE TABLE `t_20210909` (
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

	CREATE TABLE `t_20210909_02` (
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



	call sp_batch_write('insert','t_20210909',300000);


	mysql> select * from t_20210909 order by id desc limit 1;
	+--------+------+------+------+------+------+------+------+------+------+------+------+
	| id     | r0   | r1   | r2   | r3   | r4   | r5   | r6   | r7   | r8   | r9   | r10  |
	+--------+------+------+------+------+------+------+------+------+------+------+------+
	| 300000 | 7223 | 6062 | 8640 | 5016 | 9157 |  740 | 6226 | 8908 | 5865 | 2598 | 5397 |
	+--------+------+------+------+------+------+------+------+------+------+------+------+
	1 row in set (0.00 sec)


3. 语句的执行次序

	session A              session B 
						   
	insert into t_20210909_02 select * from t_20210909;

							delete from t_20210909 where id=300000;
							Query OK, 1 row affected (0.04 sec)

	Query OK, 300000 rows affected (5.62 sec)
	Records: 300000  Duplicates: 0  Warnings: 0


4. 结果

	mysql> select count(*) from t_20210909;
	+----------+
	| count(*) |
	+----------+
	|   299999 |
	+----------+
	1 row in set (0.11 sec)

	mysql> select count(*) from t_20210909_02;
	+----------+
	| count(*) |
	+----------+
	|   300000 |
	+----------+
	1 row in set (0.08 sec)

	问题：如果在 insert … select 执行期间有其他线程操作原表，会导致逻辑错误？
    答：其实，这是不会的，如果不加锁，就是快照读。一条语句执行期间，它的一致性视图是不会修改的，所以即使有其他事务修改了原表的数据，也不会影响这条语句看到的数据。
   

