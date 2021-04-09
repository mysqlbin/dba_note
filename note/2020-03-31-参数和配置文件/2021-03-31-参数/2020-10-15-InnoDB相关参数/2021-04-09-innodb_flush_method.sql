

innodb_flush_method参数
	InnoDB 和操作系统打交道的一个IO模型.

InnoDB 从 buffer pool 刷数据和日志到磁盘的方式(设置buffer pool刷新机制 )

定义用于将数据刷新到InnoDB数据文件和日志文件的方法，这可能会影响I / O吞吐量。

默认为NULL
在 UNIX 系统上, 默认为 fsync
在 Windows 系统上默认为 async_unbuffered

在使用SSD或者PCIE类型的存储时, 可以设置为 O_DIRECT, 底层调用 directio(), 直接修改写入磁盘, 以提升性能.

O_DSYNC:  只有数据写到磁盘时， 写入操作才算完成（write才算成功）
O_SYNC:   刷数据的同时要刷 metadata, 代价太大
O_DIRECT: 读/写操作都会跳过 OS CACHE, 直接在 device(disk)上读/写，发挥裸设备最大性能。（绕过操作系统缓存，直接写阵列卡）







root@mysqldb 15:41:  [(none)]> show global variables like '%innodb_flush_method%';
+---------------------+----------+
| Variable_name       | Value    |
+---------------------+----------+
| innodb_flush_method | O_DIRECT |
+---------------------+----------+
1 row in set (0.00 sec)




相关参考
	
	https://dev.mysql.com/doc/refman/5.7/en/innodb-parameters.html#sysvar_innodb_flush_method
	http://blog.itpub.net/7728585/viewspace-1980262/
	https://blog.csdn.net/smooth00/article/details/72725941