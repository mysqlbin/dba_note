


binlog 是Server层的， Redo log是InnoDB存储引擎层的， 是两个互不想干的逻辑，为了让它们保持逻辑上的一致，因此需要两阶段提交，把Redo log的写入操作拆分成 redo log prepare 和 commit 这2个阶段。
先写redo log 后写 binlog，或者先写 binlog 后写 redo log，都会存在问题。




	
DROP TABLE IF EXISTS `t`;
CREATE TABLE `t` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `c` int(11) DEFAULT NULL,
  `d` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `c` (`c`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;
INSERT INTO `t` (`id`, `c`, `d`) VALUES ('1', '1', '1');
INSERT INTO `t` (`id`, `c`, `d`) VALUES ('3', '3', '3');

mysql> select * from t;
+----+------+------+
| id | c    | d    |
+----+------+------+
|  1 |    1 |    1 |
|  3 |    3 |    3 |
+----+------+------+
2 rows in set (0.00 sec)




b page_cur_insert_rec_write_log



INSERT INTO `t` (`c`, `d`) VALUES ('5', '5');

update t set d=100 where id=1;



b page_cur_insert_rec_write_log



(gdb) c
Continuing.
[Switching to Thread 0x7f4c700c6700 (LWP 16720)]

Breakpoint 2, page_cur_insert_rec_write_log (insert_rec=0x7f4c64d2c0c4 "\200", rec_size=35, cursor_rec=0x7f4c64d2c0a1 "\200", index=0x7f4c6c977650, mtr=0x7f4c700c2b20) at /usr/local/mysql/storage/innobase/page/page0cur.cc:964
964		if (dict_table_is_temporary(index->table)) {
(gdb) bt
#0  page_cur_insert_rec_write_log (insert_rec=0x7f4c64d2c0c4 "\200", rec_size=35, cursor_rec=0x7f4c64d2c0a1 "\200", index=0x7f4c6c977650, mtr=0x7f4c700c2b20) at /usr/local/mysql/storage/innobase/page/page0cur.cc:964
#1  0x000000000199522b in page_cur_insert_rec_low (current_rec=0x7f4c64d2c0a1 "\200", index=0x7f4c6c977650, rec=0x7f4c6c9780f6 "\200", offsets=0x7f4c700c2800, mtr=0x7f4c700c2b20) at /usr/local/mysql/storage/innobase/page/page0cur.cc:1531
#2  0x0000000001b181a8 in page_cur_tuple_insert (cursor=0x7f4c700c2708, tuple=0x7f4c6c02e670, index=0x7f4c6c977650, offsets=0x7f4c700c3040, heap=0x7f4c700c3048, n_ext=0, mtr=0x7f4c700c2b20, use_cache=false) at /usr/local/mysql/storage/innobase/include/page0cur.ic:280
#3  0x0000000001b212a3 in btr_cur_optimistic_insert (flags=0, cursor=0x7f4c700c2700, offsets=0x7f4c700c3040, heap=0x7f4c700c3048, entry=0x7f4c6c02e670, rec=0x7f4c700c3038, big_rec=0x7f4c700c3050, n_ext=0, thr=0x7f4c6c972a60, mtr=0x7f4c700c2b20)
    at /usr/local/mysql/storage/innobase/btr/btr0cur.cc:3218
#4  0x00000000019f0380 in row_ins_clust_index_entry_low (flags=0, mode=2, index=0x7f4c6c977650, n_uniq=1, entry=0x7f4c6c02e670, n_ext=0, thr=0x7f4c6c972a60, dup_chk_only=false) at /usr/local/mysql/storage/innobase/row/row0ins.cc:2607
#5  0x00000000019f2281 in row_ins_clust_index_entry (index=0x7f4c6c977650, entry=0x7f4c6c02e670, thr=0x7f4c6c972a60, n_ext=0, dup_chk_only=false) at /usr/local/mysql/storage/innobase/row/row0ins.cc:3293
#6  0x00000000019f2780 in row_ins_index_entry (index=0x7f4c6c977650, entry=0x7f4c6c02e670, thr=0x7f4c6c972a60) at /usr/local/mysql/storage/innobase/row/row0ins.cc:3429
#7  0x00000000019f2cc0 in row_ins_index_entry_step (node=0x7f4c6c9727d0, thr=0x7f4c6c972a60) at /usr/local/mysql/storage/innobase/row/row0ins.cc:3579
#8  0x00000000019f3020 in row_ins (node=0x7f4c6c9727d0, thr=0x7f4c6c972a60) at /usr/local/mysql/storage/innobase/row/row0ins.cc:3717
#9  0x00000000019f3484 in row_ins_step (thr=0x7f4c6c972a60) at /usr/local/mysql/storage/innobase/row/row0ins.cc:3853
#10 0x0000000001a11357 in row_insert_for_mysql_using_ins_graph (mysql_rec=0x7f4c6c02db70 "\371\004", prebuilt=0x7f4c6c9721f0) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:1738
#11 0x0000000001a118c5 in row_insert_for_mysql (mysql_rec=0x7f4c6c02db70 "\371\004", prebuilt=0x7f4c6c9721f0) at /usr/local/mysql/storage/innobase/row/row0mysql.cc:1859
#12 0x00000000018bf0b0 in ha_innobase::write_row (this=0x7f4c6c02d880, record=0x7f4c6c02db70 "\371\004") at /usr/local/mysql/storage/innobase/handler/ha_innodb.cc:7598
#13 0x0000000000f367b1 in handler::ha_write_row (this=0x7f4c6c02d880, buf=0x7f4c6c02db70 "\371\004") at /usr/local/mysql/sql/handler.cc:8062
#14 0x0000000001758940 in write_record (thd=0x7f4c6c00a440, table=0x7f4c6c976b80, info=0x7f4c700c41c0, update=0x7f4c700c4240) at /usr/local/mysql/sql/sql_insert.cc:1873
#15 0x0000000001755b08 in Sql_cmd_insert::mysql_insert (this=0x7f4c6c0101a8, thd=0x7f4c6c00a440, table_list=0x7f4c6c00f9c8) at /usr/local/mysql/sql/sql_insert.cc:769
#16 0x000000000175c3ef in Sql_cmd_insert::execute (this=0x7f4c6c0101a8, thd=0x7f4c6c00a440) at /usr/local/mysql/sql/sql_insert.cc:3118
#17 0x0000000001535155 in mysql_execute_command (thd=0x7f4c6c00a440, first_level=true) at /usr/local/mysql/sql/sql_parse.cc:3596
#18 0x000000000153a849 in mysql_parse (thd=0x7f4c6c00a440, parser_state=0x7f4c700c5690) at /usr/local/mysql/sql/sql_parse.cc:5570
#19 0x00000000015302d8 in dispatch_command (thd=0x7f4c6c00a440, com_data=0x7f4c700c5df0, command=COM_QUERY) at /usr/local/mysql/sql/sql_parse.cc:1484
#20 0x000000000152f20c in do_command (thd=0x7f4c6c00a440) at /usr/local/mysql/sql/sql_parse.cc:1025
#21 0x000000000165f7c8 in handle_connection (arg=0x56bff70) at /usr/local/mysql/sql/conn_handler/connection_handler_per_thread.cc:306
#22 0x0000000001ce7612 in pfs_spawn_thread (arg=0x4c7ce80) at /usr/local/mysql/storage/perfschema/pfs.cc:2190
#23 0x00007f4c7d591ea5 in start_thread () from /lib64/libpthread.so.0
#24 0x00007f4c7c4579fd in clone () from /lib64/libc.so.6


https://www.jianshu.com/writer#/notebooks/37013486/notes/50142567







E:\github\mysql-5.7.26\sql\handler.cc
ha_commit_trans
	-> MYSQL_BIN_LOG::prepare
		-> ha_prepare_low
		








		
prepare阶段
以函数MYSQL_BIN_LOG::prepare为起点进行分析，分别对比5.6.51、5.7.26以及8.0.18源码。
prepare阶段会分别依次阻塞性调用binlog_prepare与innobase_xa_prepare函数
	https://zhuanlan.zhihu.com/p/348828585
	
	
	


