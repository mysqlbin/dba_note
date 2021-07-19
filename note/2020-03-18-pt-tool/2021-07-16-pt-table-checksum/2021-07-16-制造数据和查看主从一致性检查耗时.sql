
1. 初始化表结构和数据
2. 查看数据量
3. 执行pt-table-checksum期间耗时的CPU和IO资源情况
4. 耗时
5. 小结



1. 初始化表结构和数据

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



	for i in `seq 1 10`;do mysql -h192.168.1.10 -upt_user -p'123456' -e "use sbtest;create table t$i like t0";done;
	for i in `seq 1 10`; do for j in `seq 1 "$i"`; do mysql -h192.168.1.10 -upt_user -p'123456' -e"use sbtest;alter table t$i add key idx_r$j (r$j)"; done; done;


	CREATE TABLE `t11` (
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


	for i in `seq 12 20`;do mysql -h192.168.1.10 -upt_user -p'123456' -e "use sbtest;create table t$i like t0";done;
	for i in `seq 21 30`;do mysql -h192.168.1.10 -upt_user -p'123456' -e "use sbtest;create table t$i like t0";done;


	DELIMITER $$

	DROP PROCEDURE IF EXISTS `sp_batch_write`$$

	CREATE DEFINER=`pt_user`@`%` PROCEDURE `sp_batch_write`(
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




	call sp_batch_write('insert','t1',1000000);
	call sp_batch_write('insert','t2',1000000);
	call sp_batch_write('insert','t3',1000000);
	call sp_batch_write('insert','t4',1000000);
	call sp_batch_write('insert','t5',1000000);
	call sp_batch_write('insert','t6',1000000);
	call sp_batch_write('insert','t7',1000000);
	call sp_batch_write('insert','t8',1000000);
	call sp_batch_write('insert','t9',1000000);
	call sp_batch_write('insert','t10',1000000);


	call sp_batch_write('insert','t11',1000000);
	call sp_batch_write('insert','t12',1000000);
	call sp_batch_write('insert','t13',1000000);

	call sp_batch_write('insert','t14',1000000);
	call sp_batch_write('insert','t15',1000000);
	call sp_batch_write('insert','t16',1000000);
	call sp_batch_write('insert','t17',1000000);

	call sp_batch_write('insert','t18',1000000);
	call sp_batch_write('insert','t19',1000000);
	call sp_batch_write('insert','t20',1000000);


	call sp_batch_write('insert','t21',2000000);
	call sp_batch_write('insert','t22',2000000);
	call sp_batch_write('insert','t23',2000000);


	call sp_batch_write('insert','t24',2000000);
	call sp_batch_write('insert','t25',2000000);
	call sp_batch_write('insert','t26',2000000);
	call sp_batch_write('insert','t27',2000000);


	call sp_batch_write('insert','t28',2000000);
	call sp_batch_write('insert','t29',2000000);
	call sp_batch_write('insert','t30',2000000);


2. 查看数据量

	mysql> SELECT table_schema,table_name,(data_length/1024/1024) AS data_mb,(index_length/1024/1024) AS index_mb,((data_length + index_length)/1024/1024) AS all_mb,table_rows FROM   information_schema.tables  where table_schema='sbtest';
	+--------------+------------+--------------+--------------+--------------+------------+
	| table_schema | table_name | data_mb      | index_mb     | all_mb       | table_rows |
	+--------------+------------+--------------+--------------+--------------+------------+
	| sbtest       | t0         |   0.01562500 |   0.00000000 |   0.01562500 |          0 |
	| sbtest       | t1         |  70.59375000 |  21.54687500 |  92.14062500 |     995826 |
	| sbtest       | t10        |  65.59375000 | 195.46875000 | 261.06250000 |     996130 |
	| sbtest       | t11        |  70.59375000 |   0.00000000 |  70.59375000 |     995826 |
	| sbtest       | t12        |  66.59375000 |   0.00000000 |  66.59375000 |     995885 |
	| sbtest       | t13        |  70.59375000 |   0.00000000 |  70.59375000 |     995826 |
	| sbtest       | t14        | 155.65625000 |   0.00000000 | 155.65625000 |    1991426 |
	| sbtest       | t15        |  66.59375000 |   0.00000000 |  66.59375000 |     995873 |
	| sbtest       | t16        |  70.59375000 |   0.00000000 |  70.59375000 |     995826 |
	| sbtest       | t17        |  70.59375000 |   0.00000000 |  70.59375000 |     995826 |
	| sbtest       | t18        |  68.59375000 |   0.00000000 |  68.59375000 |     959361 |
	| sbtest       | t19        |  70.59375000 |   0.00000000 |  70.59375000 |     995826 |
	| sbtest       | t2         |  70.59375000 |  41.09375000 | 111.68750000 |     995632 |
	| sbtest       | t20        |  67.59375000 |   0.00000000 |  67.59375000 |     945881 |
	| sbtest       | t21        | 130.65625000 |   0.00000000 | 130.65625000 |    1991982 |
	| sbtest       | t22        | 128.65625000 |   0.00000000 | 128.65625000 |    1991926 |
	| sbtest       | t23        | 135.65625000 |   0.00000000 | 135.65625000 |    1991557 |
	| sbtest       | t24        | 141.67187500 |   0.00000000 | 141.67187500 |    1989442 |
	| sbtest       | t25        | 134.65625000 |   0.00000000 | 134.65625000 |    1893307 |
	| sbtest       | t26        | 129.65625000 |   0.00000000 | 129.65625000 |    1825902 |
	| sbtest       | t27        | 140.67187500 |   0.00000000 | 140.67187500 |    1981486 |
	| sbtest       | t28        | 141.67187500 |   0.00000000 | 141.67187500 |    1991210 |
	| sbtest       | t29        | 136.65625000 |   0.00000000 | 136.65625000 |    1918280 |
	| sbtest       | t3         |  67.59375000 |  58.64062500 | 126.23437500 |     995881 |
	| sbtest       | t30        | 127.65625000 |   0.00000000 | 127.65625000 |    1800487 |
	| sbtest       | t4         |  64.59375000 |  78.18750000 | 142.78125000 |     996041 |
	| sbtest       | t5         |  70.59375000 | 103.73437500 | 174.32812500 |     995826 |
	| sbtest       | t6         |  70.59375000 | 126.28125000 | 196.87500000 |     995826 |
	| sbtest       | t7         |  69.59375000 | 142.82812500 | 212.42187500 |     995707 |
	| sbtest       | t8         |  66.59375000 | 156.37500000 | 222.96875000 |     996027 |
	| sbtest       | t9         |  66.59375000 | 176.92187500 | 243.51562500 |     995905 |
	+--------------+------------+--------------+--------------+--------------+------------+
	31 rows in set (0.00 sec)


	shell> sudo ls -lht /data_volume/mysql/sbtest/
	total 4.3G


	SELECT sum(table_rows) FROM   information_schema.tables  where table_schema='sbtest';
	mysql> SELECT sum(table_rows) FROM   information_schema.tables  where table_schema='sbtest';
	+-----------------+
	| sum(table_rows) |
	+-----------------+
	|        40201936 |
	+-----------------+
	1 row in set (0.00 sec)




3. 执行pt-table-checksum期间耗时的CPU和IO资源情况

	shell> top
	top - 15:39:30 up 179 days,  8:02,  4 users,  load average: 0.58, 0.51, 1.08
	Tasks: 127 total,   1 running, 126 sleeping,   0 stopped,   0 zombie
	%Cpu0  : 60.7 us,  0.0 sy,  0.0 ni, 39.3 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
	%Cpu1  :  0.3 us,  0.3 sy,  0.0 ni, 99.3 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
	%Cpu2  :  2.7 us,  0.0 sy,  0.0 ni, 97.3 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
	%Cpu3  : 19.6 us,  0.0 sy,  0.0 ni, 80.1 id,  0.3 wa,  0.0 hi,  0.0 si,  0.0 st
	KiB Mem : 16266528 total,   184564 free,  7607364 used,  8474600 buff/cache
	KiB Swap:        0 total,        0 free,        0 used.  8104800 avail Mem 

	  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                                                  
	 3679 mysql     20   0 8715212   6.4g   6944 S  83.1 41.3 414:09.42 mysqld                                                                                                                                                                                                   
	 7135 mongodb   20   0 2468152 541248   6528 S   0.7  3.3   1512:07 mongod                                                                                                                                                                                                   
	11555 root      20   0  228480  23792   5016 S   0.7  0.1   0:00.27 perl                                                                                                                                                                                                     
		1 root      20   0  190832   3236   1992 S   0.0  0.0   5:39.39 systemd               
		
		
		
	shell> iostat -dmx 1
		
	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sdb               0.00     0.00    0.00    2.00     0.00     0.01    12.00     0.00    1.00    0.00    1.00   1.00   0.20
	sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sdb               0.00     0.00    0.00    2.00     0.00     0.02    16.00     0.00    1.00    0.00    1.00   1.00   0.20
	sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sdb               0.00     0.00    0.00    2.00     0.00     0.02    20.00     0.00    1.00    0.00    1.00   1.00   0.20
	sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sdb               0.00     0.00    0.00    2.00     0.00     0.01     8.00     0.00    1.00    0.00    1.00   1.00   0.20
	sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sdb               0.00     0.00    0.00    2.00     0.00     0.01    12.00     0.00    1.00    0.00    1.00   1.00   0.20
	sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sdb               0.00     0.00    0.00    4.00     0.00     0.03    14.00     0.00    0.75    0.00    0.75   0.75   0.30
	sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sdb               0.00     0.00    0.00    2.00     0.00     0.01     8.00     0.00    0.50    0.00    0.50   0.50   0.10
	sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sdb               0.00     0.00    0.00    2.00     0.00     0.01    12.00     0.00    0.00    0.00    0.00   0.00   0.00
	sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sdb               0.00     0.00    0.00    2.00     0.00     0.02    16.00     0.00    1.00    0.00    1.00   1.00   0.20
	sda               0.00     1.00    3.00   12.00     0.05     0.14    26.13     0.06    3.67   12.33    1.50   2.60   3.90

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sdb               0.00     1.00    0.00   19.00     0.00     0.25    26.95     0.02    1.00    0.00    1.00   0.32   0.60
	sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

		
4. 耗时

	shell> time sudo  pt-table-checksum --nocheck-replication-filters --no-check-binlog-format  --replicate=consistency_db.checksums h=192.168.1.10,u=pt_user,p='',P=3306 --databases=sbtest
	[sudo] password for coding001: 
	Checking if all tables can be checksummed ...
	Starting checksum ...
				TS ERRORS  DIFFS     ROWS  DIFF_ROWS  CHUNKS SKIPPED    TIME TABLE
	07-16T15:37:03      0      0        0          0       1       0   0.025 sbtest.t0
	07-16T15:37:06      0      0  1000000          0       8       0   2.910 sbtest.t1
	07-16T15:37:09      0      0  1000000          0       7       0   2.827 sbtest.t10
	07-16T15:37:12      0      0  1000000          0       7       0   2.834 sbtest.t11
	07-16T15:37:15      0      0  1000000          0       7       0   2.796 sbtest.t12
	07-16T15:37:18      0      0  1000000          0       7       0   2.836 sbtest.t13
	07-16T15:37:23      0      0  2000000          0      11       0   5.111 sbtest.t14
	07-16T15:37:26      0      0  1000000          0       7       0   2.803 sbtest.t15
	07-16T15:37:28      0      0  1000000          0       7       0   2.796 sbtest.t16
	07-16T15:37:31      0      0  1000000          0       6       0   2.783 sbtest.t17
	07-16T15:37:34      0      0  1000000          0       6       0   2.782 sbtest.t18
	07-16T15:37:37      0      0  1000000          0       7       0   2.785 sbtest.t19
	07-16T15:37:40      0      0  1000000          0       7       0   2.902 sbtest.t2
	07-16T15:37:42      0      0  1000000          0       6       0   2.758 sbtest.t20
	07-16T15:37:47      0      0  2000000          0      11       0   5.075 sbtest.t21
	07-16T15:37:52      0      0  2000000          0      10       0   4.983 sbtest.t22
	07-16T15:37:57      0      0  2000000          0      10       0   5.037 sbtest.t23
	07-16T15:38:02      0      0  2000000          0      11       0   5.044 sbtest.t24
	07-16T15:38:08      0      0  2000000          0      11       0   5.085 sbtest.t25
	07-16T15:38:13      0      0  2000000          0      11       0   5.086 sbtest.t26
	07-16T15:38:18      0      0  2000000          0      10       0   5.034 sbtest.t27
	07-16T15:38:23      0      0  2000000          0      11       0   5.080 sbtest.t28
	07-16T15:38:28      0      0  2000000          0      11       0   5.088 sbtest.t29
	07-16T15:38:31      0      0  1000000          0       7       0   2.832 sbtest.t3
	07-16T15:38:36      0      0  2000000          0      11       0   5.109 sbtest.t30
	07-16T15:38:39      0      0  1000000          0       6       0   2.778 sbtest.t4
	07-16T15:38:41      0      0  1000000          0       6       0   2.776 sbtest.t5
	07-16T15:38:44      0      0  1000000          0       7       0   2.873 sbtest.t6
	07-16T15:38:47      0      0  1000000          0       7       0   2.846 sbtest.t7
	07-16T15:38:50      0      0  1000000          0       7       0   2.781 sbtest.t8
	07-16T15:38:53      0      0  1000000          0       6       0   2.774 sbtest.t9

	real	1m58.735s
	user	0m0.771s
	sys	0m0.170s

	shell> time sudo  pt-table-checksum --nocheck-replication-filters --no-check-binlog-format  --replicate=consistency_db.checksums h=192.168.1.10,u=pt_user,p='',P=3306 --databases=sbtest
	Checking if all tables can be checksummed ...
	Starting checksum ...
				TS ERRORS  DIFFS     ROWS  DIFF_ROWS  CHUNKS SKIPPED    TIME TABLE
	07-16T15:39:14      0      0        0          0       1       0   0.025 sbtest.t0
	07-16T15:39:16      0      0  1000000          0       8       0   2.785 sbtest.t1
	07-16T15:39:19      0      0  1000000          0       7       0   2.797 sbtest.t10
	07-16T15:39:22      0      0  1000000          0       6       0   2.733 sbtest.t11
	07-16T15:39:25      0      0  1000000          0       6       0   2.713 sbtest.t12
	07-16T15:39:27      0      0  1000000          0       6       0   2.756 sbtest.t13
	07-16T15:39:32      0      0  2000000          0      10       0   4.997 sbtest.t14
	07-16T15:39:35      0      0  1000000          0       6       0   2.780 sbtest.t15
	07-16T15:39:38      0      0  1000000          0       7       0   2.799 sbtest.t16
	07-16T15:39:41      0      0  1000000          0       6       0   2.778 sbtest.t17
	07-16T15:39:44      0      0  1000000          0       6       0   2.777 sbtest.t18
	07-16T15:39:46      0      0  1000000          0       7       0   2.794 sbtest.t19
	07-16T15:39:49      0      0  1000000          0       6       0   2.808 sbtest.t2
	07-16T15:39:52      0      0  1000000          0       6       0   2.731 sbtest.t20
	07-16T15:39:57      0      0  2000000          0      10       0   4.958 sbtest.t21
	07-16T15:40:02      0      0  2000000          0      10       0   5.032 sbtest.t22
	07-16T15:40:07      0      0  2000000          0      10       0   4.966 sbtest.t23
	07-16T15:40:12      0      0  2000000          0      10       0   4.942 sbtest.t24
	07-16T15:40:17      0      0  2000000          0      10       0   4.989 sbtest.t25
	07-16T15:40:22      0      0  2000000          0      11       0   5.049 sbtest.t26
	07-16T15:40:27      0      0  2000000          0      10       0   4.951 sbtest.t27
	07-16T15:40:32      0      0  2000000          0      10       0   4.971 sbtest.t28
	07-16T15:40:37      0      0  2000000          0      10       0   5.010 sbtest.t29
	07-16T15:40:40      0      0  1000000          0       6       0   2.791 sbtest.t3
	07-16T15:40:45      0      0  2000000          0      10       0   5.034 sbtest.t30
	07-16T15:40:47      0      0  1000000          0       6       0   2.771 sbtest.t4
	07-16T15:40:50      0      0  1000000          0       6       0   2.795 sbtest.t5
	07-16T15:40:53      0      0  1000000          0       6       0   2.754 sbtest.t6
	07-16T15:40:56      0      0  1000000          0       6       0   2.743 sbtest.t7
	07-16T15:40:58      0      0  1000000          0       6       0   2.735 sbtest.t8
	07-16T15:41:01      0      0  1000000          0       6       0   2.784 sbtest.t9

	real	1m47.847s
	user	0m0.671s
	sys	0m0.148s


5. 小结


	4000W行记录，数据量大小为4.3GB，耗时约100秒。
	8000W行记录，数据量大小为9GB, 耗时约200秒
	20GB，耗时约400秒  = 6.5分钟;
	40GB，耗时约800秒  = 13分钟;
	80GB，耗时约1600秒 约 25 分钟;







	
