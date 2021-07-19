

1. 到 checksums 表找到主从数据不一致的列表

	SELECT db, tbl, CONCAT(db, '.', tbl) AS `table`, chunk, chunk_index, lower_boundary, upper_boundary, COALESCE(this_cnt-master_cnt, 0) AS cnt_diff, 
	COALESCE(this_crc <> master_crc OR ISNULL(master_crc) <> ISNULL(this_crc), 0) AS crc_diff, this_cnt, master_cnt, this_crc, master_crc 
	FROM consistency_db.checksums WHERE master_cnt <> this_cnt OR master_crc <> this_crc OR ISNULL(master_crc) <> ISNULL(this_crc)


2. 取出 最大ID和最小ID作用范围查询条件

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
	
	

小结：
	1. 只需要对主从数据不一致的记录所在的chunk的记录进行加锁，不需要扫描全表的数据。
	
	