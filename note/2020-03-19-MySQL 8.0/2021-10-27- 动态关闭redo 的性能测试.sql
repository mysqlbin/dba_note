

1. 初始化数据

	ALTER INSTANCE DISABLE INNODB REDO_LOG;

	set global sync_binlog=0;

	sysbench --test=/usr/local/share/sysbench/oltp_write_only.lua --mysql-host=192.168.1.12 --mysql-port=3307 --mysql-user=sysbench --mysql-password='1234Abc&' --mysql-db=sbtest --tables=5 --table-size=2000000 --threads=5 --time=1800 --report-interval=10 --db-driver=mysql prepare &


	[root@voice sbtest]# ls -lht 
	total 2.4G
	-rw-r-----. 1 mysql mysql 472M Oct 27 12:18 sbtest1.ibd
	-rw-r-----. 1 mysql mysql 472M Oct 27 12:18 sbtest3.ibd
	-rw-r-----. 1 mysql mysql 472M Oct 27 12:18 sbtest5.ibd
	-rw-r-----. 1 mysql mysql 472M Oct 27 12:18 sbtest4.ibd
	-rw-r-----. 1 mysql mysql 472M Oct 27 12:18 sbtest2.ibd

	rm sbstst.sql

	/usr/local/mysql8/bin/mysqldump -h 192.168.1.12 -usysbench -p'1234Abc&' -P 3307  --single-transaction --set-gtid-purged=OFF  -B sbtest> sbstst.sql


------------------------------------------------------------------------------------------------------------------------------------------

2. 禁用redo同时sync_binlog=1

	ALTER INSTANCE DISABLE INNODB REDO_LOG;
	set global sync_binlog=1;

	show global variables like '%sync_binlog%';
	show global variables like '%REDO%';

	mysql> show global variables like '%sync_binlog%';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| sync_binlog   | 1     |
	+---------------+-------+
	1 row in set (0.00 sec)


	mysql> show global variables like '%REDO%';
	+------------------------------+-------+
	| Variable_name                | Value |
	+------------------------------+-------+
	| innodb_redo_log_archive_dirs |       |
	| innodb_redo_log_encrypt      | OFF   |
	+------------------------------+-------+
	2 rows in set (0.01 sec)


	[root@voice coding001]# time /usr/local/mysql8/bin/mysql  -h 192.168.1.12 -usysbench -p'1234Abc&' -P 3307 sbtest <  sbstst.sql
	mysql: [Warning] Using a password on the command line interface can be insecure.

	real	3m58.658s
	user	0m21.642s
	sys	0m2.885s

	 
------------------------------------------------------------------------------------------------------------------------------------------

2. 禁用redo同时sync_binlog=1000

	ALTER INSTANCE DISABLE INNODB REDO_LOG;
	set global sync_binlog=1000;

	show global variables like '%sync_binlog%';
	show global variables like '%REDO%';

	mysql> ALTER INSTANCE DISABLE INNODB REDO_LOG;
	Query OK, 0 rows affected (0.00 sec)

	mysql> set global sync_binlog=1000;
	Query OK, 0 rows affected (0.00 sec)

	mysql> 
	mysql> show global variables like '%sync_binlog%';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| sync_binlog   | 1000  |
	+---------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%REDO%';
	+------------------------------+-------+
	| Variable_name                | Value |
	+------------------------------+-------+
	| innodb_redo_log_archive_dirs |       |
	| innodb_redo_log_encrypt      | OFF   |
	+------------------------------+-------+
	2 rows in set (0.00 sec)


	time /usr/local/mysql8/bin/mysql  -h 192.168.1.12 -usysbench -p'1234Abc&' -P 3307 sbtest <  sbstst.sql


	[root@voice coding001]# time /usr/local/mysql8/bin/mysql  -h 192.168.1.12 -usysbench -p'1234Abc&' -P 3307 sbtest <  sbstst.sql
	mysql: [Warning] Using a password on the command line interface can be insecure.

	real	3m49.622s
	user	0m21.652s
	sys	0m2.949s



------------------------------------------------------------------------------------------------------------------------------------------
 

3. 禁用redo同时sync_binlog=0

	drop table sbtest1;
	drop table sbtest2;
	drop table sbtest3;
	drop table sbtest4;
	drop table sbtest5;
	 
	ALTER INSTANCE DISABLE INNODB REDO_LOG;
	set global sync_binlog=0;

	show global variables like '%sync_binlog%';
	show global variables like '%REDO%';

	mysql> show global variables like '%sync_binlog%';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| sync_binlog   | 0     |
	+---------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%REDO%';
	+------------------------------+-------+
	| Variable_name                | Value |
	+------------------------------+-------+
	| innodb_redo_log_archive_dirs |       |
	| innodb_redo_log_encrypt      | OFF   |
	+------------------------------+-------+
	2 rows in set (0.01 sec)

	time /usr/local/mysql8/bin/mysql  -h 192.168.1.12 -usysbench -p'1234Abc&' -P 3307 sbtest <  sbstst.sql
	[root@voice coding001]# time /usr/local/mysql8/bin/mysql  -h 192.168.1.12 -usysbench -p'1234Abc&' -P 3307 sbtest <  sbstst.sql
	mysql: [Warning] Using a password on the command line interface can be insecure.

	real	3m40.430s
	user	0m21.651s
	sys	0m3.076s


------------------------------------------------------------------------------------------------------------------------------------------

4. 禁用redo同时关闭binlog


	ALTER INSTANCE DISABLE INNODB REDO_LOG;
	mysql> show global variables like 'log_bin%';
	+---------------------------------+-------+
	| Variable_name                   | Value |
	+---------------------------------+-------+
	| log_bin                         | OFF   |
	| log_bin_basename                |       |
	| log_bin_index                   |       |
	| log_bin_trust_function_creators | OFF   |
	| log_bin_use_v1_row_events       | OFF   |
	+---------------------------------+-------+
	5 rows in set (0.00 sec)

	show global variables like '%REDO%';

	mysql> show global variables like '%REDO%';
	+------------------------------+-------+
	| Variable_name                | Value |
	+------------------------------+-------+
	| innodb_redo_log_archive_dirs |       |
	| innodb_redo_log_encrypt      | OFF   |
	+------------------------------+-------+
	2 rows in set (0.00 sec)


	[root@voice coding001]# time /usr/local/mysql8/bin/mysql  -h 192.168.1.12 -usysbench -p'1234Abc&' -P 3307 sbtest <  sbstst.sql
	mysql: [Warning] Using a password on the command line interface can be insecure.

	real	2m48.042s
	user	0m21.460s
	sys	0m2.911s

	-----------------------------------------------------------------------------------------------------------------------------

5. 启用redo innodb_flush_log_at_trx_commit=0同时关闭binlog
	drop table sbtest1;
	drop table sbtest2;
	drop table sbtest3;
	drop table sbtest4;
	drop table sbtest5;

	关闭binlog

	ALTER INSTANCE ENABLE INNODB REDO_LOG;
	set global innodb_flush_log_at_trx_commit=0;

	mysql>  show global variables like 'log_bin%';
	+---------------------------------+-------+
	| Variable_name                   | Value |
	+---------------------------------+-------+
	| log_bin                         | OFF   |
	| log_bin_basename                |       |
	| log_bin_index                   |       |
	| log_bin_trust_function_creators | OFF   |
	| log_bin_use_v1_row_events       | OFF   |
	+---------------------------------+-------+
	5 rows in set (0.00 sec)


	show global variables like '%innodb_flush_log_at_trx_commit%';
	mysql> show global variables like '%innodb_flush_log_at_trx_commit%';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| innodb_flush_log_at_trx_commit | 0     |
	+--------------------------------+-------+
	1 row in set (0.00 sec)


	[root@voice coding001]# time /usr/local/mysql8/bin/mysql  -h 192.168.1.12 -usysbench -p'1234Abc&' -P 3307 sbtest <  sbstst.sql
	mysql: [Warning] Using a password on the command line interface can be insecure.

	real	3m6.187s
	user	0m21.888s
	sys	0m3.133s


-----------------------------------------------------------------------------------------------------------------------------

6. 启用redo innodb_flush_log_at_trx_commit=1同时关闭binlog


	drop table sbtest1;
	drop table sbtest2;
	drop table sbtest3;
	drop table sbtest4;
	drop table sbtest5;

	关闭binlog

	ALTER INSTANCE ENABLE INNODB REDO_LOG;
	set global innodb_flush_log_at_trx_commit=1;

	mysql>  show global variables like 'log_bin%';
	+---------------------------------+-------+
	| Variable_name                   | Value |
	+---------------------------------+-------+
	| log_bin                         | OFF   |
	| log_bin_basename                |       |
	| log_bin_index                   |       |
	| log_bin_trust_function_creators | OFF   |
	| log_bin_use_v1_row_events       | OFF   |
	+---------------------------------+-------+
	5 rows in set (0.00 sec)

	mysql> show global variables like '%innodb_flush_log_at_trx_commit%';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| innodb_flush_log_at_trx_commit | 1     |
	+--------------------------------+-------+
	1 row in set (0.01 sec)


	[root@voice coding001]# time /usr/local/mysql8/bin/mysql  -h 192.168.1.12 -usysbench -p'1234Abc&' -P 3307 sbtest <  sbstst.sql
	mysql: [Warning] Using a password on the command line interface can be insecure.

	real	3m19.195s
	user	0m21.921s
	sys	0m3.162s




7. 双1配置

	drop table sbtest1;
	drop table sbtest2;
	drop table sbtest3;
	drop table sbtest4;
	drop table sbtest5;

	ALTER INSTANCE ENABLE INNODB REDO_LOG;
	show global variables like 'log_bin%';
	show global variables like '%sync_binlog%';
	show global variables like '%innodb_flush_log_at_trx_commit%';

	mysql> ALTER INSTANCE ENABLE INNODB REDO_LOG;
	Query OK, 0 rows affected (0.00 sec)

	mysql> show global variables like 'log_bin%';
	+---------------------------------+---------------------------------------------+
	| Variable_name                   | Value                                       |
	+---------------------------------+---------------------------------------------+
	| log_bin                         | ON                                          |
	| log_bin_basename                | /data_volume/mysql3307/logs/mysql-bin       |
	| log_bin_index                   | /data_volume/mysql3307/logs/mysql-bin.index |
	| log_bin_trust_function_creators | OFF                                         |
	| log_bin_use_v1_row_events       | OFF                                         |
	+---------------------------------+---------------------------------------------+
	5 rows in set (0.01 sec)

	mysql> show global variables like '%sync_binlog%';
	+---------------+-------+
	| Variable_name | Value |
	+---------------+-------+
	| sync_binlog   | 1     |
	+---------------+-------+
	1 row in set (0.00 sec)

	mysql> show global variables like '%innodb_flush_log_at_trx_commit%';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| innodb_flush_log_at_trx_commit | 1     |
	+--------------------------------+-------+
	1 row in set (0.00 sec)


	[root@voice coding001]# time /usr/local/mysql8/bin/mysql  -h 192.168.1.12 -usysbench -p'1234Abc&' -P 3307 sbtest <  sbstst.sql
	mysql: [Warning] Using a password on the command line interface can be insecure.

	real	4m11.612s
	user	0m22.052s
	sys	0m3.659s


