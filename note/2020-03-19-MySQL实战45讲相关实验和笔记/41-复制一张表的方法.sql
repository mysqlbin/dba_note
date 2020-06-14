
初始化20521632行记录
./sysbench --mysql-host= --mysql-port=3306 --mysql-user=root --mysql-password=123456abc --test=tests/db/oltp.lua --oltp_tables_count=1 --oltp-table-size=20521632 --rand-init=on prepare
shell> ls -lht
total 4.4G
-rw-r----- 1 mysql mysql 4.4G 2019-08-23 09:30 sbtest1.ibd
-rw-r----- 1 mysql mysql 8.5K 2019-08-23 09:22 sbtest1.frm
-rw-r----- 1 mysql mysql   67 2019-08-23 09:19 db.opt


机器配置:
	内存: 16G
	高效云盘: 100G
	CPU: 4 cores
	

IO参数:
	innodb_flush_log_at_trx_commit=0; 
	sync_binlog=100000;
内存参数:
	innodb_buffer_pool_size=10G;
	
mysqldump 方法:
mysqldump -h$host -P$port -u$user --add-locks=0 --no-create-info --single-transaction  --set-gtid-purged=OFF db1 t --where="a>900" --result-file=/client_tmp/t.sql

shell> time mysqldump -h11.111.11.11 -P3306 -uroot -p123456abc --add-locks=0 --no-create-info --single-transaction  --set-gtid-purged=OFF sbtest sbtest1 --where="id>0" --result-file=/home/dba2/sbtest1.sql
mysqldump: [Warning] Using a password on the command line interface can be insecure.

real	1m5.028s
user	0m48.039s
sys	0m4.083s

–single-transaction 的作用是，在导出数据的时候不需要对表 db1.t 加表锁，而是使用 START TRANSACTION WITH CONSISTENT SNAPSHOT 的方法；
–add-locks 设置为 0，表示在输出的文件结果里，不增加" LOCK TABLES <code>t</code> WRITE;" ；
–no-create-info 的意思是，不需要导出表结构；
–set-gtid-purged=off 表示的是，不输出跟 GTID 相关的信息；
–result-file 指定了输出文件的路径，其中 client 表示生成的文件是在客户端机器上的。

备份文件t.sql会的INSERT 语句里面会包含多个 value 对，这是为了后续用这个文件来写入数据的时候，执行速度可以更快。


mysqldump+skip-extended-insert:
	mysqldump加上参数–skip-extended-insert, 生成的文件中一条 INSERT 语句只插入一行数据的话; 
	

通过source命令恢复备份文件:
	mysql -h11.111.11.11 -P3306  -uroot -p123456abc db2 -e "source /home/dba2/product.sql"
	mysql 客户端执行这个命令的流程是这样的：
		1. source 是一个客户端命令, 不是一条 SQL 语句
		2. 打开文件，默认以分号为结尾读取一条条的 SQL 语句；
		3. 将 SQL 语句发送到服务端执行。
		4. 服务端执行的并不是这个source t.sql语句，而是 INSERT 语句。
			所以，不论是在慢查询日志（slow log），还是在 binlog，记录的都是这些要被真正执行的 INSERT 语句。
	
	shell> time mysql -h11.111.11.11 -P3306  -uroot -p123456abc db2 -e "source /home/dba2/sbtest1.sql"
		mysql: [Warning] Using a password on the command line interface can be insecure.

		real	7m17.745s
		user	0m45.838s
		sys	0m3.901s
	select 20521632/437 = 46960: 每秒可以导入约5W行记录;
	
	
这条命令是否要加 FTWRL全局读锁?
mysqldump -h$host -P$port -u$user --add-locks=0 --no-create-info --single-transaction  --set-gtid-purged=OFF db1 t --where="a>900" --result-file=/client_tmp/t.sql
shell> time mysqldump -h -P3306 -uroot -p123456abc --add-locks=0 --no-create-info --single-transaction  --set-gtid-purged=OFF sbtest product --where="id>0" --result-file=/home/dba2/product.sql

shell> tail -f general.log 
2019-08-23T10:35:20.486820+08:00	   62 Connect	root@11.111.11.11 on  using TCP/IP
2019-08-23T10:35:20.486994+08:00	   62 Query	/*!40100 SET @@SQL_MODE='' */
2019-08-23T10:35:20.487105+08:00	   62 Query	/*!40103 SET TIME_ZONE='+00:00' */
2019-08-23T10:35:20.487258+08:00	   62 Query	SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ
2019-08-23T10:35:20.487342+08:00	   62 Query	START TRANSACTION /*!40100 WITH CONSISTENT SNAPSHOT */
2019-08-23T10:35:20.487432+08:00	   62 Query	UNLOCK TABLES
2019-08-23T10:35:20.487622+08:00	   62 Query	SELECT LOGFILE_GROUP_NAME, FILE_NAME, TOTAL_EXTENTS, INITIAL_SIZE, ENGINE, EXTRA FROM INFORMATION_SCHEMA.FILES WHERE FILE_TYPE = 'UNDO LOG' AND FILE_NAME IS NOT NULL AND LOGFILE_GROUP_NAME IS NOT NULL AND LOGFILE_GROUP_NAME IN (SELECT DISTINCT LOGFILE_GROUP_NAME FROM INFORMATION_SCHEMA.FILES WHERE FILE_TYPE = 'DATAFILE' AND TABLESPACE_NAME IN (SELECT DISTINCT TABLESPACE_NAME FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_SCHEMA='sbtest' AND TABLE_NAME IN ('product'))) GROUP BY LOGFILE_GROUP_NAME, FILE_NAME, ENGINE, TOTAL_EXTENTS, INITIAL_SIZE ORDER BY LOGFILE_GROUP_NAME
2019-08-23T10:35:20.489906+08:00	   62 Query	SELECT DISTINCT TABLESPACE_NAME, FILE_NAME, LOGFILE_GROUP_NAME, EXTENT_SIZE, INITIAL_SIZE, ENGINE FROM INFORMATION_SCHEMA.FILES WHERE FILE_TYPE = 'DATAFILE' AND TABLESPACE_NAME IN (SELECT DISTINCT TABLESPACE_NAME FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_SCHEMA='sbtest' AND TABLE_NAME IN ('product')) ORDER BY TABLESPACE_NAME, LOGFILE_GROUP_NAME
2019-08-23T10:35:20.490965+08:00	   62 Query	SHOW VARIABLES LIKE 'ndbinfo\_version'
2019-08-23T10:35:20.492253+08:00	   62 Init DB	sbtest
2019-08-23T10:35:20.492354+08:00	   62 Query	SHOW TABLES LIKE 'product'
2019-08-23T10:35:20.492538+08:00	   62 Query	SAVEPOINT sp
2019-08-23T10:35:20.492650+08:00	   62 Query	show table status like 'product'
2019-08-23T10:35:20.492941+08:00	   62 Query	SET SQL_QUOTE_SHOW_CREATE=1
2019-08-23T10:35:20.493032+08:00	   62 Query	show fields from `product`
2019-08-23T10:35:20.493424+08:00	   62 Query	show fields from `product`
2019-08-23T10:35:20.493785+08:00	   62 Query	SELECT /*!40001 SQL_NO_CACHE */ * FROM `product` WHERE id>0
2019-08-23T10:35:20.494054+08:00	   62 Query	SET SESSION character_set_results = 'binary'
2019-08-23T10:35:20.494134+08:00	   62 Query	use `sbtest`
2019-08-23T10:35:20.494220+08:00	   62 Query	select @@collation_database
2019-08-23T10:35:20.494312+08:00	   62 Query	SHOW TRIGGERS LIKE 'product'
2019-08-23T10:35:20.494636+08:00	   62 Query	SET SESSION character_set_results = 'utf8mb4'
2019-08-23T10:35:20.494710+08:00	   62 Query	ROLLBACK TO SAVEPOINT sp
2019-08-23T10:35:20.494772+08:00	   62 Query	RELEASE SAVEPOINT sp
2019-08-23T10:35:20.497004+08:00	   62 Quit	

答: 不需要.




不可以直接把 db1.t 表的.frm 文件和.ibd 文件拷贝到 db2 目录下:
	因为，一个 InnoDB 表，除了包含这两个物理文件外，还需要在数据字典中注册。
	直接拷贝这两个文件的话，因为数据字典中没有 db2.t 这个表，系统是不会识别和接受它们的。

可传输表空间(transportable tablespace):
	MySQL 5.6 版本引入了可传输表空间(transportable tablespace) 的方法，可以通过导出 + 导入表空间的方式，实现物理拷贝表的功能。 

假设我们现在的目标是在 db1 库下，复制一个跟表 t 相同的表 r，具体的执行步骤如下：

1. 执行 create table r like t，创建一个相同表结构的空表
2. 执行 alter table r discard tablespace，这时候 r.ibd 文件会被删除；
3. 执行 flush table t for export，这时候 db1 目录下会生成一个 t.cfg 文件；
	执行完 flsuh table 命令之后，db1.t 整个表处于只读状态，直到执行 unlock tables 命令后才释放读锁；
	
4. 在 db1 目录下执行 cp t.cfg r.cfg; cp t.ibd r.ibd；这两个命令（这里需要注意的是，拷贝得到的两个文件，MySQL 进程要有读写权限）；
5. 执行 unlock tables，这时候 t.cfg 文件会被删除；
6. 执行 alter table r import tablespace，将这个 r.ibd 文件作为表 r 的新的表空间，由于这个文件的数据内容和 t.ibd 是相同的，所以表 r 中就有了和表 t 相同的数据。
	在执行 import tablespace 的时候，为了让文件里的表空间 id 和数据字典中的一致，会修改 r.ibd 的表空间 id。
	而这个表空间 id 存在于每一个数据页中。
	因此，如果是一个很大的文件（比如 TB 级别），每个数据页都需要修改，所以你会看到这个 import 语句的执行是需要一些时间的。
	当然，如果是相比于逻辑导入的方法，import 语句的耗时是非常短的。
	
实践:
	sbtest.sbtest1
	shell> ls -lht
	total 4.4G
	-rw-r----- 1 mysql mysql 4.4G 2019-08-23 09:30 sbtest1.ibd
	-rw-r----- 1 mysql mysql 8.5K 2019-08-23 09:22 sbtest1.frm
	-rw-r----- 1 mysql mysql   67 2019-08-23 09:19 db.opt
		
		
	1. mysql> create table sbtest1_new like sbtest1;
		shell>  ls -lht
		total 4.4G
		-rw-r----- 1 mysql mysql  96K 2019-08-23 09:33 sbtest1_new.ibd
		-rw-r----- 1 mysql mysql 8.5K 2019-08-23 09:33 sbtest1_new.frm
		-rw-r----- 1 mysql mysql 4.4G 2019-08-23 09:30 sbtest1.ibd
		-rw-r----- 1 mysql mysql 8.5K 2019-08-23 09:22 sbtest1.frm
		-rw-r----- 1 mysql mysql   67 2019-08-23 09:19 db.opt

	2. mysql> alter table sbtest1_new discard tablespace;
		shell> ls -lht
		total 4.4G
		-rw-r----- 1 mysql mysql 8.5K 2019-08-23 09:33 sbtest1_new.frm
		-rw-r----- 1 mysql mysql 4.4G 2019-08-23 09:30 sbtest1.ibd
		-rw-r----- 1 mysql mysql 8.5K 2019-08-23 09:22 sbtest1.frm
		-rw-r----- 1 mysql mysql   67 2019-08-23 09:19 db.opt
	3. mysql> flush table sbtest1 for export;
		shell> ls -lht
		total 4.4G
		-rw-r----- 1 mysql mysql  498 2019-08-23 09:34 sbtest1.cfg
		-rw-r----- 1 mysql mysql 8.5K 2019-08-23 09:33 sbtest1_new.frm
		-rw-r----- 1 mysql mysql 4.4G 2019-08-23 09:30 sbtest1.ibd
		-rw-r----- 1 mysql mysql 8.5K 2019-08-23 09:22 sbtest1.frm
		-rw-r----- 1 mysql mysql   67 2019-08-23 09:19 db.opt
		
		mysql-error.log
		2019-08-23T09:45:14.416646+08:00 47 [Note] InnoDB: Sync to disk of `sbtest`.`sbtest1` started.
		2019-08-23T09:45:14.416687+08:00 47 [Note] InnoDB: Stopping purge
		2019-08-23T09:45:14.416750+08:00 47 [Note] InnoDB: Writing table metadata to './sbtest/sbtest1.cfg'
		2019-08-23T09:45:14.416857+08:00 47 [Note] InnoDB: Table `sbtest`.`sbtest1` flushed to disk


	4. shell> time cp sbtest1.cfg sbtest1_new.cfg; cp sbtest1.ibd sbtest1_new.ibd
		 
			real	0m0.002s
			user	0m0.000s
			sys	0m0.001s

	5. mysql> unlock tables;
		
		mysql-error.log:
		2019-08-23T09:46:40.440960+08:00 47 [Note] InnoDB: Deleting the meta-data file './sbtest/sbtest1.cfg'
		2019-08-23T09:46:40.441003+08:00 47 [Note] InnoDB: Resuming purge


	mysql> select count(*) from sbtest1_new;
	ERROR 1814 (HY000): Tablespace has been discarded for table 'sbtest1_new'

	6. chown -R mysql:mysql sbtest1_new.ibd
	   执行第7步的时候, 要先把表空间文件设置为MySQL的用户组和用户
	   否则, 直接执行第7步会报这个错:
		ERROR 1812 (HY000): Tablespace is missing for table `sbtest`.`sbtest1_new`.
		
	7. mysql> alter table sbtest1_new import tablespace;
	Query OK, 0 rows affected, 1 warning (1 min 16.09 sec)




使用注意事项：
	不能并发做表空间传输
	不能有外键
	不能在线上主上做表空间传输，会把从库出错停掉的
		







