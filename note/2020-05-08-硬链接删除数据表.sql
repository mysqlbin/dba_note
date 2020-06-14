
硬链接删除表

1. 主库和从库上对表建立硬链接

	ln sbtest1.ibd sbtest1.ibd.hdlk

	
	[root@kp04 sbtest]# ll
	total 2330140
	-rw-r-----. 2 mysql mysql 1186988032 May  7 11:16 sbtest1.ibd
	-rw-r-----. 2 mysql mysql 1186988032 May  7 11:16 sbtest1.ibd.hdlk
	
2. 在主库进行 drop table
	set sql_log_bin=0;  # 从库不存在表.
	drop table sbtest1;
	
	root@mysqldb 11:18:  [sbtest]> set sql_log_bin=0;
	Query OK, 0 rows affected (0.00 sec)

	root@mysqldb 11:19:  [sbtest]> drop table sbtest1;
	Query OK, 0 rows affected (0.04 sec)
		
3. 在 os 层删除物理文件

	rm sbtest1.ibd.hdlk
	
	[root@kp04 sbtest]# rm sbtest1.ibd.hdlk
	rm: remove regular file ‘sbtest1.ibd.hdlk’? y
	[root@kp04 sbtest]# ll
	total 11796
	-rw-r-----. 1 mysql mysql 11534336 May  7 18:22 t1_10w.ibd
	-rw-r-----. 1 mysql mysql   360448 May  7 16:22 t1_1w.ibd
	-rw-r-----. 1 mysql mysql   180224 May  6 17:58 t1_2500.ibd

