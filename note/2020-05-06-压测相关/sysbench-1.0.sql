


https://blog.csdn.net/saga_gallon/article/details/82770222  sysbench 1.0 下载安装
https://blog.51cto.com/bilibili/2173243?source=dra 

下载地址
wget https://github.com/akopytov/sysbench/archive/1.0.zip

安装
* 基本步骤
yum -y install  make automake libtool pkgconfig libaio-devel vim-common

./autogen.sh

sudo ./configure --with-mysql-includes=/usr/local/mysql/include --with-mysql-libs=/usr/local/mysql/lib && make && make install


[root@kp04 sysbench-1.0]# sysbench --version
sysbench 1.0.20



测试

1、 建测试表及数据：
线程，数据表大小及数量及其他参数按需求修改即可

set global sync_binlog=10000;
set global innodb_flush_log_at_trx_commit=2;

create  database sbtest DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;



create user 'sysbench'@'%' identified by '';
grant all privileges on *.* to 'sysbench'@'%' with grant option;
			

sysbench /usr/local/share/sysbench/tests/include/oltp_legacy/oltp.lua --mysql-host=192.168.1.12 --mysql-port=3306 --mysql-user=sysbench --mysql-password='' --mysql-db=sbtest --threads=4 --oltp-table-size=5000000 --oltp-tables-count=10 --threads=4 prepare




set global sync_binlog=1;
set global innodb_flush_log_at_trx_commit=1;

压测3次：
	1. 备份数据
	2. 压测完成后要做的步骤
drop table sbtest1;
drop table sbtest2;
drop table sbtest3;
drop table sbtest4;
drop table sbtest5;
drop table sbtest6;
drop table sbtest7;
drop table sbtest8;
drop table sbtest9;
drop table sbtest10; 
		
		重启MySQL 
		
		导入数据
		

sysbench /usr/local/share/sysbench/tests/include/oltp_legacy/oltp.lua 
--mysql-host=192.168.1.12 
--mysql-port=3306 
--mysql-user=sysbench 
--mysql-password='' 
--mysql-db=sbtest 
--threads=10 
--oltp-table-size=5000000 
--oltp-tables-count=10 
prepare


[root@voice sbtest]# ls -lht *
-rw-r-----. 1 mysql mysql 1.2G Oct 15 15:23 sbtest9.ibd
-rw-r-----. 1 mysql mysql 1.2G Oct 15 15:22 sbtest10.ibd
-rw-r-----. 1 mysql mysql 8.5K Oct 15 15:21 sbtest10.frm
-rw-r-----. 1 mysql mysql 1.2G Oct 15 15:21 sbtest8.ibd
-rw-r-----. 1 mysql mysql 8.5K Oct 15 15:20 sbtest9.frm
-rw-r-----. 1 mysql mysql 1.2G Oct 15 15:19 sbtest7.ibd
-rw-r-----. 1 mysql mysql 8.5K Oct 15 15:18 sbtest8.frm
-rw-r-----. 1 mysql mysql 1.2G Oct 15 15:18 sbtest6.ibd
-rw-r-----. 1 mysql mysql 8.5K Oct 15 15:17 sbtest7.frm
-rw-r-----. 1 mysql mysql 1.2G Oct 15 15:16 sbtest5.ibd
-rw-r-----. 1 mysql mysql 8.5K Oct 15 15:15 sbtest6.frm
-rw-r-----. 1 mysql mysql 1.2G Oct 15 15:15 sbtest4.ibd
-rw-r-----. 1 mysql mysql 8.5K Oct 15 15:14 sbtest5.frm
-rw-r-----. 1 mysql mysql 1.2G Oct 15 15:13 sbtest3.ibd
-rw-r-----. 1 mysql mysql 8.5K Oct 15 15:12 sbtest4.frm
-rw-r-----. 1 mysql mysql 1.2G Oct 15 15:11 sbtest2.ibd
-rw-r-----. 1 mysql mysql 8.5K Oct 15 15:11 sbtest3.frm
-rw-r-----. 1 mysql mysql 1.2G Oct 15 15:10 sbtest1.ibd
-rw-r-----. 1 mysql mysql 8.5K Oct 15 15:09 sbtest2.frm
-rw-r-----. 1 mysql mysql 8.5K Oct 15 15:08 sbtest1.frm
-rw-r-----. 1 mysql mysql   67 Oct 15 12:10 db.opt


[root@voice sbtest]# df -h
Filesystem      Size  Used Avail Use% Mounted on
devtmpfs        7.8G     0  7.8G   0% /dev
tmpfs           7.8G     0  7.8G   0% /dev/shm
tmpfs           7.8G  705M  7.1G   9% /run
tmpfs           7.8G     0  7.8G   0% /sys/fs/cgroup
/dev/sda1       100G   40G   61G  40% /
tmpfs           1.6G     0  1.6G   0% /run/user/1001


[coding001@voice ~]$ /usr/local/mysql/bin/mysqldump -uroot -pzP1ExFNsugs%  –set-gtid-purged=off --single-transaction --master-data=2 -B sbtest > sbtest.sql  
mysqldump: [Warning] Using a password on the command line interface can be insecure.
Warning: A partial dump from a server that has GTIDs will by default include the GTIDs of all transactions, even those that changed suppressed parts of the database. If you don t want to restore GTIDs, pass --set-gtid-purged=OFF. To make a complete dump, pass --all-databases --triggers --routines --events. 
mysqldump: Error: Binlogging on server not active


[root@voice ~]# cd /usr/local/share/sysbench/tests/include/oltp_legacy
[root@voice oltp_legacy]# ll
total 52
-rw-r--r--. 1 root root 1195 Oct 15 14:38 bulk_insert.lua
-rw-r--r--. 1 root root 4696 Oct 15 14:38 common.lua
-rw-r--r--. 1 root root  366 Oct 15 14:38 delete.lua
-rw-r--r--. 1 root root 1171 Oct 15 14:38 insert.lua
-rw-r--r--. 1 root root 3004 Oct 15 14:38 oltp.lua
-rw-r--r--. 1 root root  368 Oct 15 14:38 oltp_simple.lua
-rw-r--r--. 1 root root  527 Oct 15 14:38 parallel_prepare.lua
-rw-r--r--. 1 root root  369 Oct 15 14:38 select.lua
-rw-r--r--. 1 root root 1448 Oct 15 14:38 select_random_points.lua
-rw-r--r--. 1 root root 1556 Oct 15 14:38 select_random_ranges.lua
-rw-r--r--. 1 root root  369 Oct 15 14:38 update_index.lua
-rw-r--r--. 1 root root  578 Oct 15 14:38 update_non_index.lua






mysql> show global variables like '%sync_binlog%';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| sync_binlog   | 1     |
+---------------+-------+
1 row in set (0.01 sec)

mysql> show global variables like '%innodb_flush%';
+--------------------------------+-------+
| Variable_name                  | Value |
+--------------------------------+-------+
| innodb_flush_log_at_timeout    | 1     |
| innodb_flush_log_at_trx_commit | 1     |
| innodb_flush_method            |       |
| innodb_flush_neighbors         | 1     |
| innodb_flush_sync              | ON    |
| innodb_flushing_avg_loops      | 30    |
+--------------------------------+-------+
6 rows in set (0.00 sec)

mysql> show global variables like '%innodb_flush_log%';
+--------------------------------+-------+
| Variable_name                  | Value |
+--------------------------------+-------+
| innodb_flush_log_at_timeout    | 1     |
| innodb_flush_log_at_trx_commit | 1     |
+--------------------------------+-------+
2 rows in set (0.00 sec)

mysql> show global variables like '%innodb_flush_log_at_trx_commit%';
+--------------------------------+-------+
| Variable_name                  | Value |
+--------------------------------+-------+
| innodb_flush_log_at_trx_commit | 1     |
+--------------------------------+-------+
1 row in set (0.00 sec)




https://blog.csdn.net/weixin_40006963/article/details/111365601


sudo ./configure --with-mysql-includes=/usr/local/mysql/include --with-mysql-libs=/usr/local/mysql/lib && make && make install


	make[3]: Entering directory `/home/coding001/sysbench-1.0/third_party/concurrency_kit/tmp/ck/doc'
	mkdir -p //home/coding001/sysbench-1.0/third_party/concurrency_kit/share/man/man3 || exit
	cp *.3.gz //home/coding001/sysbench-1.0/third_party/concurrency_kit/share/man/man3 || exit
	make[3]: Leaving directory `/home/coding001/sysbench-1.0/third_party/concurrency_kit/tmp/ck/doc'
	mkdir -p //home/coding001/sysbench-1.0/third_party/concurrency_kit/lib || exit
	mkdir -p //home/coding001/sysbench-1.0/third_party/concurrency_kit/lib/pkgconfig || exit
	chmod 755 //home/coding001/sysbench-1.0/third_party/concurrency_kit/lib/pkgconfig
	cp build/ck.pc //home/coding001/sysbench-1.0/third_party/concurrency_kit/lib/pkgconfig/ck.pc || exit


	---[ Concurrency Kit has installed successfully.
	make[2]: Leaving directory `/home/coding001/sysbench-1.0/third_party/concurrency_kit/tmp/ck'
	make[1]: Leaving directory `/home/coding001/sysbench-1.0/third_party/concurrency_kit'
	Making all in src
	make[1]: Entering directory `/home/coding001/sysbench-1.0/src'
	Making all in drivers
	make[2]: Entering directory `/home/coding001/sysbench-1.0/src/drivers'
	Making all in mysql
	make[3]: Entering directory `/home/coding001/sysbench-1.0/src/drivers/mysql'
	gcc -std=gnu99 -DHAVE_CONFIG_H -I. -I../../../config  -I/usr/local/mysql/include -I../../../src -I/home/coding001/sysbench-1.0/third_party/luajit/inc -I/home/coding001/sysbench-1.0/third_party/concurrency_kit/include -D_GNU_SOURCE  -Wall -Wextra -Wpointer-arith -Wbad-function-cast -Wstrict-prototypes -Wnested-externs -Wno-format-zero-length -Wundef -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wredundant-decls -Wcast-align -Wvla   -pthread -O2 -funroll-loops -ggdb3  -march=core-avx2 -MT libsbmysql_a-drv_mysql.o -MD -MP -MF .deps/libsbmysql_a-drv_mysql.Tpo -c -o libsbmysql_a-drv_mysql.o `test -f 'drv_mysql.c' || echo './'`drv_mysql.c
	drv_mysql.c:1060:1: fatal error: opening dependency file .deps/libsbmysql_a-drv_mysql.Tpo: Permission denied
	 }
	 ^
	compilation terminated.
	make[3]: *** [libsbmysql_a-drv_mysql.o] Error 1
	make[3]: Leaving directory `/home/coding001/sysbench-1.0/src/drivers/mysql'
	make[2]: *** [all-recursive] Error 1
	make[2]: Leaving directory `/home/coding001/sysbench-1.0/src/drivers'
	make[1]: *** [all-recursive] Error 1
	make[1]: Leaving directory `/home/coding001/sysbench-1.0/src'
	make: *** [all-recursive] Error 1

	执行 shell> sudo -i 命令，切换到 root 账号
	
	
	
