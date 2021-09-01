

1. 初始化结构和数据
2. Compact改为dynamic 
3. 耗时

1. 初始化结构和数据

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
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=Compact;



	for i in `seq 1 15`;do mysql -hlocalhost -uroot -p'zP1ExFNsugs%' -e "use sbtest;create table t$i like t0";done;
	for i in `seq 1 10`; do for j in `seq 1 "$i"`; do mysql -hlocalhost -uroot -p'zP1ExFNsugs%' -e"use sbtest;alter table t$i add key idx_r$j (r$j)"; done; done;


	DELIMITER $$

	DROP PROCEDURE IF EXISTS `sp_batch_write`$$

	CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_batch_write`(
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



	select 15*8000000;

	set global innodb_flush_log_at_trx_commit=0;

	mysql> show global variables like '%innodb_flush_log_at_trx_commit%';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| innodb_flush_log_at_trx_commit | 0     |
	+--------------------------------+-------+
	1 row in set (0.10 sec)


	call sp_batch_write('insert','t0',8000000);
	call sp_batch_write('insert','t1',8000000);
	call sp_batch_write('insert','t2',8000000);
	call sp_batch_write('insert','t3',8000000);

	call sp_batch_write('insert','t4',8000000);

	call sp_batch_write('insert','t5',8000000);
	call sp_batch_write('insert','t6',8000000);
	call sp_batch_write('insert','t7',8000000);

	call sp_batch_write('insert','t8',8000000);
	call sp_batch_write('insert','t9',8000000);

	call sp_batch_write('insert','t10',8000000);
	call sp_batch_write('insert','t11',8000000);

	call sp_batch_write('insert','t12',8000000);
	call sp_batch_write('insert','t13',8000000);


	call sp_batch_write('insert','t14',8000000);
	call sp_batch_write('insert','t15',8000000);


	SELECT sum(data_length/1024/1024) AS data_mb FROM  information_schema.tables  where table_schema ='sbtest';
	select TABLE_NAME, ROW_FORMAT, TABLE_ROWS from information_schema.`TABLES` where TABLE_SCHEMA='sbtest';



	mysql> SELECT sum(data_length/1024/1024) AS data_mb FROM  information_schema.tables  where table_schema ='sbtest';
	+---------------+
	| data_mb       |
	+---------------+
	| 9499.35937500 |
	+---------------+
	1 row in set (0.01 sec)

	-- 9499MB = 10GBGB


2. Compact改为dynamic 

	mysql> select TABLE_NAME, ROW_FORMAT, TABLE_ROWS from information_schema.`TABLES` where TABLE_SCHEMA='sbtest';
	+------------+------------+------------+
	| TABLE_NAME | ROW_FORMAT | TABLE_ROWS |
	+------------+------------+------------+
	| t0         | Compact    |    7842108 |
	| t1         | Compact    |    7781642 |
	| t10        | Compact    |    7780844 |
	| t11        | Compact    |    7782808 |
	| t12        | Compact    |    7769522 |
	| t13        | Compact    |    7785623 |
	| t14        | Compact    |    7766043 |
	| t15        | Compact    |    7770216 |
	| t2         | Compact    |    7767456 |
	| t3         | Compact    |    4664785 |
	| t4         | Compact    |    3297712 |
	| t5         | Compact    |    7776829 |
	| t6         | Compact    |    7768183 |
	| t7         | Compact    |    5583763 |
	| t8         | Compact    |    7787011 |
	| t9         | Compact    |    7782338 |
	+------------+------------+------------+
	16 rows in set (0.00 sec)


	mysql> select concat("alter table ", TABLE_NAME, " ROW_FORMAT=DYNAMIC;") from information_schema.`TABLES` where TABLE_SCHEMA='sbtest';
	+------------------------------------------------------------+
	| concat("alter table ", TABLE_NAME, " ROW_FORMAT=DYNAMIC;") |
	+------------------------------------------------------------+
	| alter table t0 ROW_FORMAT=DYNAMIC;                         |
	| alter table t1 ROW_FORMAT=DYNAMIC;                         |
	| alter table t10 ROW_FORMAT=DYNAMIC;                        |
	| alter table t11 ROW_FORMAT=DYNAMIC;                        |
	| alter table t12 ROW_FORMAT=DYNAMIC;                        |
	| alter table t13 ROW_FORMAT=DYNAMIC;                        |
	| alter table t14 ROW_FORMAT=DYNAMIC;                        |
	| alter table t15 ROW_FORMAT=DYNAMIC;                        |
	| alter table t2 ROW_FORMAT=DYNAMIC;                         |
	| alter table t3 ROW_FORMAT=DYNAMIC;                         |
	| alter table t4 ROW_FORMAT=DYNAMIC;                         |
	| alter table t5 ROW_FORMAT=DYNAMIC;                         |
	| alter table t6 ROW_FORMAT=DYNAMIC;                         |
	| alter table t7 ROW_FORMAT=DYNAMIC;                         |
	| alter table t8 ROW_FORMAT=DYNAMIC;                         |
	| alter table t9 ROW_FORMAT=DYNAMIC;                         |
	+------------------------------------------------------------+
	16 rows in set (0.01 sec)

	set global innodb_file_format=Barracuda;

	-- 批量单线程修改
	alter table t0 ROW_FORMAT=DYNAMIC;                         
	alter table t1 ROW_FORMAT=DYNAMIC;                         
	alter table t10 ROW_FORMAT=DYNAMIC;                        
	alter table t11 ROW_FORMAT=DYNAMIC;                        
	alter table t12 ROW_FORMAT=DYNAMIC;                        
	alter table t13 ROW_FORMAT=DYNAMIC;                        
	alter table t14 ROW_FORMAT=DYNAMIC;                        
	alter table t15 ROW_FORMAT=DYNAMIC;                        
	alter table t2 ROW_FORMAT=DYNAMIC;                         
	alter table t3 ROW_FORMAT=DYNAMIC;                         
	alter table t4 ROW_FORMAT=DYNAMIC;                         
	alter table t5 ROW_FORMAT=DYNAMIC;                         
	alter table t6 ROW_FORMAT=DYNAMIC;                         
	alter table t7 ROW_FORMAT=DYNAMIC;                         
	alter table t8 ROW_FORMAT=DYNAMIC;                         
	alter table t9 ROW_FORMAT=DYNAMIC;     

	begin time
		shell> date
		Mon Aug 23 11:36:14 CST 2021

		
		mysql> show processlist;
		+-----+-----------------+-----------+--------+---------+------+------------------------+-----------------------------------+
		| Id  | User            | Host      | db     | Command | Time | State                  | Info                              |
		+-----+-----------------+-----------+--------+---------+------+------------------------+-----------------------------------+
		|   1 | event_scheduler | localhost | NULL   | Daemon  | 6534 | Waiting on empty queue | NULL                              |
		|  96 | root            | localhost | sbtest | Query   |   84 | altering table         | alter table t0 ROW_FORMAT=DYNAMIC |
		| 100 | root            | localhost | NULL   | Query   |    0 | starting               | show processlist                  |
		+-----+-----------------+-----------+--------+---------+------+------------------------+-----------------------------------+
		3 rows in set (0.00 sec)


		mysql> show processlist;
		+-----+-----------------+-----------+--------+---------+------+------------------------+-----------------------------------+
		| Id  | User            | Host      | db     | Command | Time | State                  | Info                              |
		+-----+-----------------+-----------+--------+---------+------+------------------------+-----------------------------------+
		|   1 | event_scheduler | localhost | NULL   | Daemon  | 6771 | Waiting on empty queue | NULL                              |
		|  96 | root            | localhost | sbtest | Query   |   55 | altering table         | alter table t1 ROW_FORMAT=DYNAMIC |
		| 100 | root            | localhost | NULL   | Query   |    0 | starting               | show processlist                  |
		+-----+-----------------+-----------+--------+---------+------+------------------------+-----------------------------------+
		3 rows in set (0.00 sec)


		t0
			mysql> alter table t0 ROW_FORMAT=DYNAMIC;    
			Query OK, 0 rows affected (4 min 25.80 sec)
			Records: 0  Duplicates: 0  Warnings: 0

		t1
			mysql> alter table t1 ROW_FORMAT=DYNAMIC;  
			Query OK, 0 rows affected (2 min 48.22 sec)
			Records: 0  Duplicates: 0  Warnings: 0


		t10
			mysql> alter table t10 ROW_FORMAT=DYNAMIC;                        
			Query OK, 0 rows affected (5 min 1.28 sec)
			Records: 0  Duplicates: 0  Warnings: 0
		
		t11 
			mysql> alter table t11 ROW_FORMAT=DYNAMIC;                        
			Query OK, 0 rows affected (59.15 sec)
			Records: 0  Duplicates: 0  Warnings: 0
			
		t12
			mysql> alter table t12 ROW_FORMAT=DYNAMIC;                        
			Query OK, 0 rows affected (57.48 sec)
			Records: 0  Duplicates: 0  Warnings: 0

		t13		
			mysql> alter table t13 ROW_FORMAT=DYNAMIC;                        
			Query OK, 0 rows affected (55.53 sec)
			Records: 0  Duplicates: 0  Warnings: 0
			
		t14 
			mysql> alter table t14 ROW_FORMAT=DYNAMIC;                        
			Query OK, 0 rows affected (56.14 sec)
			Records: 0  Duplicates: 0  Warnings: 0

		t15 
			mysql> alter table t15 ROW_FORMAT=DYNAMIC;                        
			Query OK, 0 rows affected (57.56 sec)
			Records: 0  Duplicates: 0  Warnings: 0

		t2
			mysql> alter table t2 ROW_FORMAT=DYNAMIC;                         
			Query OK, 0 rows affected (1 min 35.00 sec)
			Records: 0  Duplicates: 0  Warnings: 0

		t3
			mysql> alter table t3 ROW_FORMAT=DYNAMIC;                         
			Query OK, 0 rows affected (1 min 7.58 sec)
			Records: 0  Duplicates: 0  Warnings: 0


		t4 
			mysql> alter table t4 ROW_FORMAT=DYNAMIC;                         
			Query OK, 0 rows affected (53.37 sec)
			Records: 0  Duplicates: 0  Warnings: 0
		
		
		t5
			mysql> alter table t5 ROW_FORMAT=DYNAMIC;                         
			Query OK, 0 rows affected (2 min 31.33 sec)
			Records: 0  Duplicates: 0  Warnings: 0

		t6
			mysql> alter table t6 ROW_FORMAT=DYNAMIC;                         
			Query OK, 0 rows affected (2 min 56.05 sec)
			Records: 0  Duplicates: 0  Warnings: 0

		t7
			mysql> alter table t7 ROW_FORMAT=DYNAMIC;                         
			Query OK, 0 rows affected (2 min 16.40 sec)
			Records: 0  Duplicates: 0  Warnings: 0

		t8
			mysql> alter table t8 ROW_FORMAT=DYNAMIC;                         
			Query OK, 0 rows affected (3 min 39.94 sec)
			Records: 0  Duplicates: 0  Warnings: 0
			
		t9	
			mysql> alter table t9 ROW_FORMAT=DYNAMIC; 
			Query OK, 0 rows affected (4 min 3.80 sec)
			Records: 0  Duplicates: 0  Warnings: 0

		

	end time
		[coding001@voice ~]$ date
		Mon Aug 23 12:12:29 CST 2021

	
3. 耗时
	
	11:36:14 - 12:12:29
	逻辑大小：约10GB的数据: 24+12 = 36分钟。
	物理大小：约18GB 
		shell> df -h
		Filesystem      Size  Used Avail Use% Mounted on
		devtmpfs        7.8G     0  7.8G   0% /dev
		tmpfs           7.8G     0  7.8G   0% /dev/shm
		tmpfs           7.8G  297M  7.5G   4% /run
		tmpfs           7.8G     0  7.8G   0% /sys/fs/cgroup
		/dev/sda1       100G   47G   54G  47% /
		tmpfs           1.6G     0  1.6G   0% /run/user/1001
		tmpfs           1.6G     0  1.6G   0% /run/user/0
		-----------------------------------------------
		drop table t0-15;
		
		shell> df -h
		Filesystem      Size  Used Avail Use% Mounted on
		devtmpfs        7.8G     0  7.8G   0% /dev
		tmpfs           7.8G     0  7.8G   0% /dev/shm
		tmpfs           7.8G  297M  7.5G   4% /run
		tmpfs           7.8G     0  7.8G   0% /sys/fs/cgroup
		/dev/sda1       100G   29G   72G  29% /
		tmpfs           1.6G     0  1.6G   0% /run/user/1001

		
	


