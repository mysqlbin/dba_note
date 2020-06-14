
tmp_table_size: 
	表示内存临时表的大小


在 Group By 或者 Distinct 的时候，如果SQL语句用不到索引，就会使用系统内部临时表记录中间状态。
如果 tmp_table_size 不够大，则 MySQL 会自动使用物理磁盘，这会对查询性能造成很大的影响，

即
如果SQL产生的内存临时表超过 tmp_table_size 或者 max_head_table_size ，那么会产生基于磁盘的临时表。



问题:
	1. 有个库设置了1G 看还是有 disk tmp 产生
		可能是SQL效率太差了。
	需要自己尝试去调整。先从32M比较小的设置开始。

查看创建临时表的数量：
mysql> show global status like '%tmp%';
+-------------------------+--------+
| Variable_name           | Value  |
+-------------------------+--------+
| Created_tmp_disk_tables | 31063  |
| Created_tmp_files       | 10     |
| Created_tmp_tables      | 113515 |
+-------------------------+--------+
3 rows in set (0.00 sec)


查看临时表的相关信息：
mysql> show variables like '%tmp%';
+----------------------------+----------+
| Variable_name              | Value    |
+----------------------------+----------+
| default_tmp_storage_engine | InnoDB   |
| innodb_tmpdir              |          |
| max_tmp_tables             | 32       |
| slave_load_tmpdir          | /tmp     |
| tmp_table_size             | 33554432 |
| tmpdir                     | /tmp     |
+----------------------------+----------+
6 rows in set (0.00 sec)


查看有哪些SQL使用了内存临时表, 磁盘临时表: 
mysql> select db, query, tmp_tables, tmp_disk_tables, tmp_tables+tmp_disk_tables as tmp_all from sys.statement_analysis where tmp_tables>0 or tmp_disk_tables >0 order by tmp_all desc limit 20;


如何看到这条SQL导致的 tmp table_size 不够用的？

[yejr]@[imysql.com] [performance_schema]>set profiling=1;
[yejr]@[imysql.com] [performance_schema]>set profiling_history_size=2;
[yejr]@[imysql.com] [information_schema]>select benchmark(1000000, pow(2,10));
[yejr]@[imysql.com] [information_schema]>select Query_ID,sum(DURATION) from PROFILING group by query_id order by query_id desc limit 1;

