
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

	for i in `seq 1 10`;do mysql -h172.25.159.83 -uroot -p123456abc -e "use sbtest;create table t$i like t0";done;
	for i in `seq 1 10`; do for j in `seq 1 "$i"`; do mysql -h172.25.159.83 -uroot -p123456abc -e"use sbtest;alter table t$i add key idx_r$j (r$j)"; done; done;


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



mysql> call sp_batch_write('insert','t1',100000);
Query OK, 0 rows affected (11.01 sec)

mysql> call sp_batch_write('insert','t2',100000);
Query OK, 0 rows affected (11.39 sec)

mysql> call sp_batch_write('insert','t3',100000);
Query OK, 0 rows affected (11.78 sec)

mysql> call sp_batch_write('insert','t4',100000);
Query OK, 0 rows affected (12.16 sec)

mysql> call sp_batch_write('insert','t5',100000);
Query OK, 0 rows affected (12.51 sec)

mysql> call sp_batch_write('insert','t6',100000);
Query OK, 0 rows affected (12.91 sec)

mysql> call sp_batch_write('insert','t7',100000);
Query OK, 0 rows affected (13.26 sec)

mysql> call sp_batch_write('insert','t8',100000);
Query OK, 0 rows affected (13.83 sec)

mysql> call sp_batch_write('insert','t9',100000);
Query OK, 0 rows affected (14.19 sec)

mysql> call sp_batch_write('insert','t10',100000);
Query OK, 0 rows affected (14.52 sec)


[root@iZ2zebrso907kehx5xp0z3Z local]# iostat -dmx 1
Linux 4.18.0-305.3.1.el8.x86_64 (iZ2zebrso907kehx5xp0z3Z) 	07/22/2021 	_x86_64_	(2 CPU)

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s  %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
vda              3.15    4.36      0.09      0.80     0.00     0.34   0.14   7.14    1.06   60.82   0.27    29.41   188.76   1.41   1.06
vdb             37.98   49.08      0.60      2.07     0.00     1.02   0.00   2.03    0.87   11.54   0.60    16.09    43.09   0.18   1.56

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s  %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
vda              3.00    0.00      0.03      0.00     0.00     0.00   0.00   0.00    0.33    0.00   0.00     9.33     0.00   0.67   0.20
vdb              0.00  940.00      0.00      5.86     0.00     0.00   0.00   0.00    0.00    0.44   0.41     0.00     6.39   0.57  54.00


Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s  %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
vda              0.00    0.00      0.00      0.00     0.00     0.00   0.00   0.00    0.00    0.00   0.00     0.00     0.00   0.00   0.00
vdb              0.00  953.00      0.00      5.93     0.00     0.00   0.00   0.00    0.00    0.44   0.42     0.00     6.37   0.58  55.40

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s  %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
vda              0.00    0.00      0.00      0.00     0.00     0.00   0.00   0.00    0.00    0.00   0.00     0.00     0.00   0.00   0.00
vdb              0.00  937.00      0.00      5.13     0.00     0.00   0.00   0.00    0.00    0.42   0.39     0.00     5.61   0.60  56.30

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s  %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
vda              0.00    0.00      0.00      0.00     0.00     0.00   0.00   0.00    0.00    0.00   0.00     0.00     0.00   0.00   0.00
vdb              0.00 1009.00      0.00     14.07     0.00     0.00   0.00   0.00    0.00    0.69   0.69     0.00    14.28   0.59  59.50

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s  %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
vda              0.00    0.00      0.00      0.00     0.00     0.00   0.00   0.00    0.00    0.00   0.00     0.00     0.00   0.00   0.00
vdb              0.00  887.00      0.00      4.84     0.00     0.00   0.00   0.00    0.00    0.41   0.37     0.00     5.59   0.59  52.50

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s  %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
vda              0.00    0.00      0.00      0.00     0.00     0.00   0.00   0.00    0.00    0.00   0.00     0.00     0.00   0.00   0.00
vdb              0.00  897.00      0.00      5.87     0.00     0.00   0.00   0.00    0.00    0.44   0.40     0.00     6.70   0.59  52.60

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s  %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
vda              0.00    5.00      0.00      0.04     0.00     1.00   0.00  16.67    0.00    0.60   0.00     0.00     9.20   0.20   0.10


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
		Query OK, 0 rows affected (1.31 sec)

		mysql> call sp_batch_write('update','t2',100000);
		Query OK, 0 rows affected (2.27 sec)

		mysql> call sp_batch_write('update','t3',100000);
		Query OK, 0 rows affected (3.08 sec)

		mysql> call sp_batch_write('update','t4',100000);
		Query OK, 0 rows affected (3.74 sec)

		mysql> call sp_batch_write('update','t5',100000);
		Query OK, 0 rows affected (4.85 sec)

		mysql> call sp_batch_write('update','t6',100000);
		Query OK, 0 rows affected (5.68 sec)

		mysql> call sp_batch_write('update','t7',100000);
		Query OK, 0 rows affected (6.60 sec)

		mysql> call sp_batch_write('update','t8',100000);
		Query OK, 0 rows affected (7.62 sec)

		mysql> call sp_batch_write('update','t9',100000);
		Query OK, 0 rows affected (8.48 sec)

		mysql> call sp_batch_write('update','t10',100000);
		Query OK, 0 rows affected (9.44 sec)


		[root@iZ2zebrso907kehx5xp0z3Z local]# iostat -dmx 1
		Linux 4.18.0-305.3.1.el8.x86_64 (iZ2zebrso907kehx5xp0z3Z) 	07/22/2021 	_x86_64_	(2 CPU)
		Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s  %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
		vda              0.00    0.00      0.00      0.00     0.00     0.00   0.00   0.00    0.00    0.00   0.00     0.00     0.00   0.00   0.00
		vdb              0.00  198.00      0.00     26.21     0.00     0.00   0.00   0.00    0.00   20.08   3.98     0.00   135.57   0.64  12.60

		Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s  %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
		vda              0.00    0.00      0.00      0.00     0.00     0.00   0.00   0.00    0.00    0.00   0.00     0.00     0.00   0.00   0.00
		vdb              0.00   68.00      0.00     17.59     0.00     0.00   0.00   0.00    0.00   12.71   0.86     0.00   264.85   1.18   8.00

		Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s  %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
		vda              0.00    0.00      0.00      0.00     0.00     0.00   0.00   0.00    0.00    0.00   0.00     0.00     0.00   0.00   0.00
		vdb              0.00  171.00      0.00     11.04     0.00     0.00   0.00   0.00    0.00    7.23   1.24     0.00    66.10   0.39   6.60

		Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s  %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
		vda              0.00   42.00      0.00      0.21     0.00     2.00   0.00   4.55    0.00    0.48   0.02     0.00     5.05   0.12   0.50
		vdb              0.00  172.00      0.00     33.87     0.00     0.00   0.00   0.00    0.00   17.62   3.03     0.00   201.66   0.98  16.80

		......................................................................................................................................
		
		Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s  %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
		vda              0.00    0.00      0.00      0.00     0.00     0.00   0.00   0.00    0.00    0.00   0.00     0.00     0.00   0.00   0.00
		vdb              0.00  109.00      0.00     15.49     0.00     0.00   0.00   0.00    0.00    5.81   0.63     0.00   145.54   0.74   8.10



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
		Query OK, 0 rows affected (0.47 sec)

		mysql> call sp_batch_write('delete','t2',100000);
		Query OK, 0 rows affected (1.03 sec)

		mysql> call sp_batch_write('delete','t3',100000);
		Query OK, 0 rows affected (1.10 sec)

		mysql> call sp_batch_write('delete','t4',100000);
		Query OK, 0 rows affected (1.21 sec)

		mysql> call sp_batch_write('delete','t5',100000);
		Query OK, 0 rows affected (1.46 sec)

		mysql> call sp_batch_write('delete','t6',100000);
		Query OK, 0 rows affected (1.58 sec)

		mysql> call sp_batch_write('delete','t7',100000);
		Query OK, 0 rows affected (1.83 sec)

		mysql> call sp_batch_write('delete','t8',100000);
		Query OK, 0 rows affected (2.12 sec)

		mysql> call sp_batch_write('delete','t9',100000);
		Query OK, 0 rows affected (2.17 sec)

		mysql> call sp_batch_write('delete','t10',100000);
		Query OK, 0 rows affected (2.41 sec)


	
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
Query OK, 0 rows affected (55.04 sec)

mysql> call sp_batch_write('insert','t2',500000);
Query OK, 0 rows affected (56.21 sec)

mysql> call sp_batch_write('insert','t3',500000);
Query OK, 0 rows affected (57.70 sec)

mysql> call sp_batch_write('insert','t4',500000);
Query OK, 0 rows affected (59.44 sec)

mysql> call sp_batch_write('insert','t5',500000);
Query OK, 0 rows affected (1 min 0.96 sec)

mysql> call sp_batch_write('insert','t6',500000);
Query OK, 0 rows affected (1 min 2.82 sec)

mysql> call sp_batch_write('insert','t7',500000);
Query OK, 0 rows affected (1 min 4.84 sec)

mysql> call sp_batch_write('insert','t8',500000);
Query OK, 0 rows affected (1 min 6.71 sec)

mysql> call sp_batch_write('insert','t9',500000);
Query OK, 0 rows affected (1 min 8.50 sec)

mysql> call sp_batch_write('insert','t10',500000);
Query OK, 0 rows affected (1 min 10.92 sec)




[root@iZ2zebrso907kehx5xp0z3Z local]# iostat -dmx 1
Linux 4.18.0-305.3.1.el8.x86_64 (iZ2zebrso907kehx5xp0z3Z) 	07/22/2021 	_x86_64_	(2 CPU)

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s  %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
vda              2.87    3.99      0.08      0.72     0.00     0.31   0.14   7.14    1.06   59.79   0.24    29.54   185.62   1.39   0.95
vdb             34.17  110.76      0.54      2.95     0.00     0.94   0.00   0.84    0.87    5.36   0.62    16.09    27.30   0.32   4.61

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s  %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
vda              0.00    6.00      0.00      0.06     0.00     4.00   0.00  40.00    0.00    0.67   0.00     0.00    11.00   0.33   0.20
vdb              0.00  906.00      0.00      5.82     0.00     0.00   0.00   0.00    0.00    0.43   0.39     0.00     6.58   0.57  51.40

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s  %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
vda              0.00    0.00      0.00      0.00     0.00     0.00   0.00   0.00    0.00    0.00   0.00     0.00     0.00   0.00   0.00
vdb              0.00  947.00      0.00      9.29     0.00     0.00   0.00   0.00    0.00    0.55   0.52     0.00    10.05   0.56  53.40

........................................................................................................................................

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s  %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
vda              0.00    0.00      0.00      0.00     0.00     0.00   0.00   0.00    0.00    0.00   0.00     0.00     0.00   0.00   0.00
vdb              0.00  903.00      0.00      5.63     0.00     0.00   0.00   0.00    0.00    0.43   0.38     0.00     6.39   0.58  52.40

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s  %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
vda              0.00    0.00      0.00      0.00     0.00     0.00   0.00   0.00    0.00    0.00   0.00     0.00     0.00   0.00   0.00
vdb              0.00  904.00      0.00      5.60     0.00     0.00   0.00   0.00    0.00    0.42   0.38     0.00     6.35   0.58  52.30

Device            r/s     w/s     rMB/s     wMB/s   rrqm/s   wrqm/s  %rrqm  %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
vda              9.00    0.00      0.35      0.00     0.00     0.00   0.00   0.00    0.44    0.00   0.01    40.00     0.00   0.67   0.60
vdb              0.00  905.00      0.00      5.58     0.00     0.00   0.00   0.00    0.00    0.42   0.38     0.00     6.32   0.58  52.20

	

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
;
call sp_batch_write('update','t7',100000);
call sp_batch_write('update','t8',100000);
call sp_batch_write('update','t9',100000);
call sp_batch_write('update','t10',100000);
Query OK, 0 rows affected (7.37 sec)

mysql> call sp_batch_write('update','t2',100000);
Query OK, 0 rows affected (11.95 sec)

mysql> call sp_batch_write('update','t3',100000);
Query OK, 0 rows affected (16.76 sec)

mysql> call sp_batch_write('update','t4',100000);
Query OK, 0 rows affected (21.67 sec)

mysql> call sp_batch_write('update','t5',100000);
Query OK, 0 rows affected (26.99 sec)

mysql> call sp_batch_write('update','t6',100000);
Query OK, 0 rows affected (31.42 sec)

mysql> call sp_batch_write('update','t7',100000);
Query OK, 0 rows affected (37.02 sec)

mysql> call sp_batch_write('update','t8',100000);
Query OK, 0 rows affected (42.40 sec)

mysql> call sp_batch_write('update','t9',100000);
Query OK, 0 rows affected (47.56 sec)

mysql> call sp_batch_write('update','10',100000);
Query OK, 0 rows affected (52.20 sec)


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

