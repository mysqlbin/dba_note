
1. pt-table-sync
2. 原理
3. 注意事项和遇到的问题
4. 相关参考
5. 实践

1. pt-table-sync
	
	高效的同步MySQL表之间的数据，他可以做单向和双向同步的表数据。
	他可以同步单个表，也可以同步整个库。它不同步表结构、索引、或任何其他模式对象。所以在修复一致性之前需要保证他们表存在。

2. 原理
	
	1. 到 checksums 表找到主从数据不一致的列表

		SELECT db, tbl, CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, 
		COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc 
		FROM consistency_db.checksums WHERE master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc)


	2. 取出最大ID和最小ID作用范围查询条件

		SELECT MIN(`id`), MAX(`id`) FROM `sbtest`.`t0` FORCE INDEX (`PRIMARY`) WHERE (((`id` >= '1')) AND ((`id` <= '1000')))

	3. 取出数据不一致的校验值

		SELECT /*sbtest.t0:2/2*/ 1 AS chunk_num, COUNT(*) AS cnt, 
		COALESCE(LOWER(CONV(BIT_XOR(CAST(CRC32(CONCAT_WS('#', `id`, `r0`, `r1`, `r2`, `r3`, `r4`, `r5`, `r6`, `r7`, `r8`, `r9`, `r10`, CONCAT(ISNULL(`r0`), ISNULL(`r1`), ISNULL(`r2`), ISNULL(`r3`), ISNULL(`r4`), ISNULL(`r5`), ISNULL(`r6`), ISNULL(`r7`), ISNULL(`r8`), ISNULL(`r9`), ISNULL(`r10`)))) AS UNSIGNED)), 10, 16)), 0) AS crc 
		FROM `sbtest`.`t0` FORCE INDEX (`PRIMARY`) WHERE (`id` >= '1') AND ((((`id` >= '1')) AND ((`id` <= '1000')))) FOR UPDATE;
		+-----------+------+----------+
		| chunk_num | cnt  | crc      |
		+-----------+------+----------+
		|         1 | 1000 | e3896c7a |
		+-----------+------+----------+
		1 row in set (0.00 sec)

	4. 取出数据不一致所在chunk的所有数据
		SELECT /*rows in chunk*/ `id`, `r0`, `r1`, `r2`, `r3`, `r4`, `r5`, `r6`, `r7`, `r8`, `r9`, `r10`, CRC32(CONCAT_WS('#', `id`, `r0`, `r1`, `r2`, `r3`, `r4`, `r5`, `r6`, `r7`, `r8`, `r9`, `r10`, CONCAT(ISNULL(`r0`), ISNULL(`r1`), ISNULL(`r2`), ISNULL(`r3`), ISNULL(`r4`), ISNULL(`r5`), ISNULL(`r6`), ISNULL(`r7`), ISNULL(`r8`), ISNULL(`r9`), ISNULL(`r10`)))) AS __crc 
		FROM `sbtest`.`t0` FORCE INDEX (`PRIMARY`) WHERE (`id` >= '1') AND (((`id` >= '1')) AND ((`id` <= '1000'))) ORDER BY `id` FOR UPDATE


	5. 取出数据不一致的行记录
		SELECT `id`, `r0`, `r1`, `r2`, `r3`, `r4`, `r5`, `r6`, `r7`, `r8`, `r9`, `r10` FROM `sbtest`.`t0` WHERE `id`='1' LIMIT 1
		

	6. 小结
		1. 只需要对主从数据不一致的记录所在的chunk的记录进行加锁，不需要扫描全表的数据。
		
	

3. 注意事项和遇到的问题

	1. 表没有唯一索引
		Can not make changes on the master because no unique index exists at /usr/bin/pt-table-sync line 10857. while doing niuniu_db.t2 on 39.108.17.15
		--导致 pt-table-sync --print 不能打印要修复的数据。
		mysql> show create table t2\G;
		*************************** 1. row ***************************
			   Table: t2
		Create Table: CREATE TABLE `t2` (
		  `id` int(11) NOT NULL,
		  `a` int(11) DEFAULT NULL,
		  `b` int(11) DEFAULT NULL,
		  KEY `a` (`a`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
		1 row in set (0.00 sec)
		
		
	2. 遇到报错，可以看下源码，下面的排错命令就是在源码中看到的

		shell > perl -MDBD:mysql
		
		
4. 相关参考

	https://www.cnblogs.com/gomysql/p/3662264.html 


5. 实践

	参考笔记：《2021-07-20-实践.sql》

alter user 'pt_user'@'%' identified by '%123456Abc';

