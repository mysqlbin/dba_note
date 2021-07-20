1. 是什么
2. 内部工作流程
3. 相关参数
4. 小结
5. 相关参考
6. 思考
	0. checksums表各个字段的含义
	1. pt-table-checksum 对SQL语句加的什么锁
	2. 耗费的CPU资源和IO资源
	3. 耗时多久

7. 结果集各列的含义


1. 是什么 
	0. 是主从数据一致性校验的工作
	1. 需要扫描指定库下的所有表的数据，这里是分块(分批)操作
	2. 通过相同sql分别在主从库进行计算而校验出来的
		2.0 把binlog格式改为statement格式 
		2.1 通过sql在主库执行数据块的校验，同时对取到块数据进行加锁，保证数据不被别的事务修改
		2.2 然后把相同的语句传送到从库，并在从库上计算数据块的校验，最后将主从库相同块的校验值进行对比，辨别主从不一致。
		
2. 内部工作流程
	1. 设置行锁等待时间为 1秒钟
		当遇到锁冲突，就退出，为了不阻塞业务的正常运行
		
	2. 把binlog格式改为statement格式
	3. 设置事务隔离级别为可重复读
	4. 创建校验信息存放的库和表
	5. 确定分块的第一行和使用的索引列
		2021-07-16T03:48:53.520072Z	332454 Query	SELECT /*!40001 SQL_NO_CACHE */ `id` FROM `niuniuh5_db`.`table_bet_inout` FORCE INDEX(`PRIMARY`) ORDER BY `id` LIMIT 1 /*first lower boundary*/
		2021-07-16T03:48:53.526675Z	332454 Query	SELECT /*!40001 SQL_NO_CACHE */ `id` FROM `niuniuh5_db`.`table_bet_inout` FORCE INDEX (`PRIMARY`) WHERE `id` IS NOT NULL ORDER BY `id` LIMIT 1 /*key_len*/
	
	6. 查出该分块的所有记录，对记录加锁并且做校验，最后插入检验表
		REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) 
		SELECT 'niuniuh5_db', 'table_bet_inout', '1', 'PRIMARY', '1', '51646', COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `tableid`, `ninouttype`, `namount`, `nfreeamount`, `nplayerscore`, `nplayerfreescore`, `ntablescore`, `ntablefreescore`, UNIX_TIMESTAMP(`createtime`))) AS UNSIGNED)), 10, 16)), 0) AS crc 
		FROM `niuniuh5_db`.`table_bet_inout` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '1')) AND ((`id` <= '51646')) /*checksum chunk*/
		
	7. 查出主库校验值和校验行数更新到校验信息表的master_crc, master_cnt列
		2021-07-16T03:48:53.638248Z	332454 Query	
		UPDATE `consistency_db`.`checksums` SET chunk_time = '0.092035', master_crc = '30058458', master_cnt = '51646' WHERE db = 'niuniuh5_db' AND tbl = 'table_bet_inout' AND chunk = '1'
	
	8. 6-7的语句同步到从库，在从库上计算数据块的校验
	
	9. 通过sql命令查出校验表中主从校验不一致的信息。
	
		2021-07-16T03:48:54.495065Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, 
		COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc 
		FROM `consistency_db`.`checksums` 
		WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_bet_inout')

	10. 重复 6-9 这4个步骤
	
	
	
3. 相关参数

	参考笔记：《2021-07-16-相关参数.sql》

		

4. 小结
	1. pt-table-checksum、pt-archiver 的策略都是分块处理工具，避免大事务
	2. 需要对数据进行加共享读锁;
	3. 消耗CPU资源、IO资源
	4. 游戏业务场景，在凌晨5-7点是业务低峰期，可以做主从一致性校验。


5. 相关参考

	https://mp.weixin.qq.com/s/N4FeV7_Vuug3F3VfmVEFCQ	 第13问：pt-table-checksum 到底会不会影响业务性能？
	https://www.modb.pro/db/56033   					 pt-table-checksum使用方法及主从一致性校验
	https://blog.51cto.com/u_10574662/1733788?xiangguantuijian&04	pt-table-checksum 原理解析
	
	
	https://www.percona.com/downloads/percona-toolkit/3.2.0/binary/tarball/percona-toolkit-3.2.0_x86_64.tar.gz
	https://www.percona.com/downloads/percona-toolkit/LATEST/
	wget https://www.percona.com/downloads/percona-toolkit/3.0.11/binary/redhat/7/x86_64/percona-toolkit-3.0.11-1.el7.x86_64.rpm
	https://www.percona.com/downloads/percona-toolkit/3.2.0/binary/redhat/7/x86_64/percona-toolkit-3.2.0-1.el7.x86_64.rpm

	
6. 思考
	
	0. checksums表各个字段的含义
		
		CREATE TABLE `checksums` (
		  `db` char(64) NOT NULL comment '数据库名',
		  `tbl` char(64) NOT NULL comment '表名',
		  `chunk` int(11) NOT NULL comment '第几个块',
		  `chunk_time` float DEFAULT NULL '对这个块校验需要的时间',
		  `chunk_index` varchar(200) DEFAULT NULL comment '使用的索引',
		  `lower_boundary` text comment '当前chunk的ID起始值',
		  `upper_boundary` text comment '当前chunk的ID结束值',
		  `this_crc` char(40) NOT NULL comment '在从库校验得到的值', 
		  `this_cnt` int(11) NOT NULL comment '在从库校验的行数',
		  `master_crc` char(40) DEFAULT NULL comment '在主库校验得到的值',
		  `master_cnt` int(11) DEFAULT NULL comment '在主库校验的行数',
		  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
		  PRIMARY KEY (`db`,`tbl`,`chunk`),
		  KEY `ts_db_tbl` (`ts`,`db`,`tbl`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8;
		
		通过 this_crc 跟 master_crc 对比，就知道数据有没有不一致。
		
		master:
			
			mysql> select id,token from dezhou_db.table_zhanji_details where id=2;
			+----+------------------+
			| id | token            |
			+----+------------------+
			|  2 | 4872801528109888 |
			+----+------------------+
			1 row in set (0.00 sec)

			mysql> select * from checksums where tbl='table_zhanji_details';
			+-----------+----------------------+-------+------------+-------------+----------------+----------------+----------+----------+------------+------------+---------------------+
			| db        | tbl                  | chunk | chunk_time | chunk_index | lower_boundary | upper_boundary | this_crc | this_cnt | master_crc | master_cnt | ts                  |
			+-----------+----------------------+-------+------------+-------------+----------------+----------------+----------+----------+------------+------------+---------------------+
			| dezhou_db | table_zhanji_details |     1 |   0.001164 | NULL        | NULL           | NULL           | 2316954e |      156 | 2316954e   |        156 | 2021-07-16 17:36:13 |
			+-----------+----------------------+-------+------------+-------------+----------------+----------------+----------+----------+------------+------------+---------------------+
			1 row in set (0.00 sec)

			mysql> select count(*) from dezhou_db.table_zhanji_details;
			+----------+
			| count(*) |
			+----------+
			|      156 |
			+----------+
			1 row in set (0.00 sec)

		slave:
			
			mysql> select id,token from dezhou_db.table_zhanji_details where id=2;
			+----+------------------+
			| id | token            |
			+----+------------------+
			|  2 | 4872801528109881 |
			+----+------------------+
			1 row in set (0.01 sec)	
			
			mysql> select * from checksums where tbl='table_zhanji_details';
			+-----------+----------------------+-------+------------+-------------+----------------+----------------+----------+----------+------------+------------+---------------------+
			| db        | tbl                  | chunk | chunk_time | chunk_index | lower_boundary | upper_boundary | this_crc | this_cnt | master_crc | master_cnt | ts                  |
			+-----------+----------------------+-------+------------+-------------+----------------+----------------+----------+----------+------------+------------+---------------------+
			| dezhou_db | table_zhanji_details |     1 |   0.001164 | NULL        | NULL           | NULL           | 55648221 |      156 | 2316954e   |        156 | 2021-07-16 17:36:13 |
			+-----------+----------------------+-------+------------+-------------+----------------+----------------+----------+----------+------------+------------+---------------------+
			1 row in set (0.00 sec)




	1. pt-table-checksum 对SQL语句加的什么锁
		对数据加共享读锁。
		
		master
			
			/*!50108 SET @@binlog_format := 'STATEMENT'*/
			
			SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
			
			更新主库 this_cnt、this_crc 的值
			2021-07-16T03:48:53.545364Z	332454 Query
			REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) 
			SELECT 'niuniuh5_db', 'table_bet_inout', '1', 'PRIMARY', '1', '51646', COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `tableid`, `ninouttype`, `namount`, `nfreeamount`, `nplayerscore`, `nplayerfreescore`, `ntablescore`, `ntablefreescore`, UNIX_TIMESTAMP(`createtime`))) AS UNSIGNED)), 10, 16)), 0) AS crc 
			FROM `niuniuh5_db`.`table_bet_inout` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '1')) AND ((`id` <= '51646')) /*checksum chunk*/
			
			2021-07-16T03:48:53.638248Z	332454 Query	
			更新主库 master_crc、master_cnt 的值
			UPDATE `consistency_db`.`checksums` SET chunk_time = '0.092035', master_crc = '30058458', master_cnt = '51646' WHERE db = 'niuniuh5_db' AND tbl = 'table_bet_inout' AND chunk = '1'
			
			
			mysql> select * from checksums where tbl='table_bet_inout' and db='niuniuh5_db';
			+-------------+-----------------+-------+------------+-------------+----------------+----------------+----------+----------+------------+------------+---------------------+
			| db          | tbl             | chunk | chunk_time | chunk_index | lower_boundary | upper_boundary | this_crc | this_cnt | master_crc | master_cnt | ts                  |
			+-------------+-----------------+-------+------------+-------------+----------------+----------------+----------+----------+------------+------------+---------------------+
			| niuniuh5_db | table_bet_inout |     1 |   0.212655 | PRIMARY     | 1              | 124796         | 92bd0c50 |   124796 | 92bd0c50   |     124796 | 2021-07-16 17:34:47 |
			| niuniuh5_db | table_bet_inout |     2 |   0.255034 | PRIMARY     | 124797         | 278785         | 6e09bb2c |   153989 | 6e09bb2c   |     153989 | 2021-07-16 17:34:47 |
			| niuniuh5_db | table_bet_inout |     3 |   0.000502 | PRIMARY     | NULL           | 1              | 0        |        0 | 0          |          0 | 2021-07-16 17:34:47 |
			| niuniuh5_db | table_bet_inout |     4 |   0.000359 | PRIMARY     | 278785         | NULL           | 0        |        0 | 0          |          0 | 2021-07-16 17:34:47 |
			+-------------+-----------------+-------+------------+-------------+----------------+----------------+----------+----------+------------+------------+---------------------+
			4 rows in set (0.00 sec)


			
		slave
			更新从库 this_cnt、this_crc 的值
					
			2021-07-16T03:48:53.728736Z	11767 Query
			REPLACE INTO `consistency_db`.`checksums` (db, tbl, chunk, chunk_index, lower_boundary, upper_boundary, this_cnt, this_crc) 
			SELECT 'niuniuh5_db', 'table_bet_inout', '1', 'PRIMARY', '1', '51646', COUNT(*) AS cnt, COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `nplayerid`, `tableid`, `ninouttype`, `namount`, `nfreeamount`, `nplayerscore`, `nplayerfreescore`, `ntablescore`, `ntablefreescore`, UNIX_TIMESTAMP(`createtime`))) AS UNSIGNED)), 10, 16)), 0) AS crc 
			FROM `niuniuh5_db`.`table_bet_inout` FORCE INDEX(`PRIMARY`) WHERE ((`id` >= '1')) AND ((`id` <= '51646')) /*checksum chunk*/
			
			更新 master_crc、master_cnt 的检验值
			因为传的是固定值，所以这2个值一样会跟主库的一样
			2021-07-16T03:48:53.729289Z	11767 Query	
			UPDATE `consistency_db`.`checksums` SET chunk_time = '0.092035', master_crc = '30058458', master_cnt = '51646' WHERE db = 'niuniuh5_db' AND tbl = 'table_bet_inout' AND chunk = '1'


			-- 在从库执行 将主从库相同块的校验值进行对比
			2021-07-16T03:48:54.495065Z	61678 Query	SELECT CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, 
			COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc 
			FROM `consistency_db`.`checksums` 
			WHERE (master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc))  AND (db='niuniuh5_db' AND tbl='table_bet_inout')


			mysql> select * from checksums where tbl='table_bet_inout' and db='niuniuh5_db';
			+-------------+-----------------+-------+------------+-------------+----------------+----------------+----------+----------+------------+------------+---------------------+
			| db          | tbl             | chunk | chunk_time | chunk_index | lower_boundary | upper_boundary | this_crc | this_cnt | master_crc | master_cnt | ts                  |
			+-------------+-----------------+-------+------------+-------------+----------------+----------------+----------+----------+------------+------------+---------------------+
			| niuniuh5_db | table_bet_inout |     1 |   0.212655 | PRIMARY     | 1              | 124796         | 92bd0c50 |   124796 | 92bd0c50   |     124796 | 2021-07-16 17:34:47 |
			| niuniuh5_db | table_bet_inout |     2 |   0.255034 | PRIMARY     | 124797         | 278785         | 6e09bb2c |   153989 | 6e09bb2c   |     153989 | 2021-07-16 17:34:47 |
			| niuniuh5_db | table_bet_inout |     3 |   0.000502 | PRIMARY     | NULL           | 1              | 0        |        0 | 0          |          0 | 2021-07-16 17:34:47 |
			| niuniuh5_db | table_bet_inout |     4 |   0.000359 | PRIMARY     | 278785         | NULL           | 0        |        0 | 0          |          0 | 2021-07-16 17:34:47 |
			+-------------+-----------------+-------+------------+-------------+----------------+----------------+----------+----------+------------+------------+---------------------+
			4 rows in set (0.00 sec)



	2. 耗费的CPU资源和IO资源
	
		占用CPU资源
			
			shell> top
			top - 12:20:17 up 179 days,  4:42,  4 users,  load average: 0.28, 0.08, 0.06
			Tasks: 128 total,   1 running, 127 sleeping,   0 stopped,   0 zombie
			%Cpu0  :  3.4 us,  1.0 sy,  0.0 ni, 94.9 id,  0.3 wa,  0.0 hi,  0.3 si,  0.0 st
			%Cpu1  : 22.1 us,  1.7 sy,  0.0 ni, 71.9 id,  4.0 wa,  0.0 hi,  0.3 si,  0.0 st
			%Cpu2  :  6.6 us,  1.0 sy,  0.0 ni, 92.0 id,  0.0 wa,  0.0 hi,  0.3 si,  0.0 st
			%Cpu3  :  1.7 us,  0.3 sy,  0.0 ni, 98.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
			KiB Mem : 16266528 total,   350220 free,  5438588 used, 10477720 buff/cache
			KiB Swap:        0 total,        0 free,        0 used. 10273304 avail Mem 

			  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                                                  
			 3679 mysql     20   0 8696116   4.3g   7168 S  27.6 27.8 342:49.05 mysqld                                                                                                                                                                                                   
			 8931 root      20   0  228604  23952   5028 S  13.0  0.1   0:03.86 perl                                                                                                                                                                                                     
			 7135 mongodb   20   0 2468152 540656   6552 S   0.7  3.3   1510:51 mongod                                                                                                                                                                                                   
				9 root      20   0       0      0      0 S   0.3  0.0  81:18.07 rcu_sched                                                                                                                                                                                                
			 1358 root      20   0       0      0      0 S   0.3  0.0  17:03.79 xfsaild/sda1                   
			 
		 
		占用IO资源

			shell> iostat -dmx 1
			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
			sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sdb               0.00     0.00    0.00  102.00     0.00     0.44     8.78     0.06    0.61    0.00    0.61   0.60   6.10
			sda               0.00     0.00   38.00    0.00     4.34     0.00   233.68     0.88   23.18   23.18    0.00   1.68   6.40

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sdb               0.00     0.00    0.00  291.00     0.00     1.28     9.02     0.18    0.62    0.00    0.62   0.62  17.90
			sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sdb               0.00     0.00    0.00  122.00     0.00     0.53     8.92     0.07    0.59    0.00    0.59   0.59   7.20
			sda               0.00     1.00    0.00    8.00     0.00     0.07    19.00     0.06    7.88    0.00    7.88   1.50   1.20

			..........................................................................................................................

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sdb               0.00     0.00    0.00  340.00     0.00     1.48     8.94     0.23    0.68    0.00    0.68   0.68  23.10
			sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sdb               0.00     0.00    0.00  327.00     0.00     1.43     8.95     0.22    0.67    0.00    0.67   0.67  21.80
			sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

			Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
			sdb               0.00     0.00    0.00  162.00     0.00     0.71     8.99     0.11    0.69    0.00    0.69   0.69  11.10
			sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

	 
	3. 耗时多久
		参考笔记：《2021-07-16-制造数据和查看主从一致性检查耗时.sql》
		
	

7. 结果集各列的含义
	
				TS ERRORS  DIFFS     ROWS  DIFF_ROWS  CHUNKS SKIPPED    TIME TABLE
	07-16T17:36:10      0      0       23          0       1       0   0.025 dezhou_db.accountinfo
	07-16T17:36:10      0      0        1          0       1       0   0.023 dezhou_db.accountinrole
	07-16T17:36:10      0      0       37          0       1       0   0.023 dezhou_db.accountorroleinrule
	07-16T17:36:10      0      0        0          0       1       0   0.023 dezhou_db.clubbackgroundoperationlog
	07-16T17:36:10      0      0        0          0       1       0   0.024 dezhou_db.enterpricemanage
	07-16T17:36:10      0      0       23          0       1       0   0.026 dezhou_db.enterprise
	07-16T17:36:10      0      0        0          0       1       0   0.024 dezhou_db.enterpriseauth
	07-16T17:36:10      0      0      759          0       1       0   0.025 dezhou_db.enterpriselog
	07-16T17:36:10      0      0      404          0       1       0   0.025 dezhou_db.operationslog
	07-16T17:36:10      0      0      397          0       1       0   0.026 dezhou_db.rechargedetail
	07-16T17:36:10      0      0        1          0       1       0   0.023 dezhou_db.roleinfo
	07-16T17:36:10      0      0      125          0       1       0   0.024 dezhou_db.ruleinfo
	07-16T17:36:10      0      0      123          0       1       0   0.024 dezhou_db.sys_code
	07-16T17:36:10      0      0        0          0       1       0   0.024 dezhou_db.systemlog
	07-16T17:36:11      0      0     1694          0       1       0   0.026 dezhou_db.table_bet_inout
	07-16T17:36:11      0      1        0     135201       1       0   0.443 dezhou_db.table_career
	07-16T17:36:11      0      0      100          0       1       0   0.025 dezhou_db.table_club_application
	07-16T17:36:11      0      0       24          0       1       0   0.023 dezhou_db.table_club_diamond_pay_config



	TS            ：完成检查的时间。
	ERRORS        ：检查时候发生错误和警告的数量。
	DIFFS         ：0表示一致，1表示不一致。当指定--no-replicate-check时，会一直为0，当指定--replicate-check-only会显示不同的信息。
	ROWS          ：表的行数。
	CHUNKS        ：表的第几个分块。
	SKIPPED       ：由于错误或警告或过大，则跳过块的数目。
	TIME          ：执行的时间。
	TABLE         ：被检查的表名。
	
	
	
	