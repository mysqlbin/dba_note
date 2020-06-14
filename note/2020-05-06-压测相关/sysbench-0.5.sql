./autogen.sh
automake 1.10.x (aclocal) wasn't found, exiting
shell> yum install automake

libtoolize 1.4+ wasn't found, exiting
shell> yum install libtool

./autogen.sh


./configure --with-mysql-includes=/usr/local/mysql/include --with-mysql-libs=/usr/local/mysql/lib && make
./configure --with-mysql-includes=/usr/local/mysql/include --with-mysql-libs=/usr/local/mysql/lib && make && make install

mysqladmin create sbtest -uasynchronous -p
OR
create  database sbtest DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;


cd /sysbench

./sysbench --mysql-host=192.168.1.26 --mysql-port=3306 --mysql-user=asynchronous --mysql-password=123456abc --test=tests/db/oltp.lua --oltp_tables_count=10 --oltp-table-size=100000 --rand-init=on prepare
./sysbench --mysql-host=192.168.23.201 --mysql-port=3306 --mysql-user=app_user --mysql-password=123456abc --test=tests/db/oltp.lua --oltp_tables_count=10 --oltp-table-size=1000000 --rand-init=on prepare
./sysbench --mysql-host=192.168.0.54 --mysql-port=3306 --mysql-user=root --mysql-password=123456abc --test=tests/db/oltp.lua --oltp_tables_count=10 --oltp-table-size=1000000 --rand-init=on prepare
./sysbench --mysql-host=192.168.23.200 --mysql-port=3306 --mysql-user=app_user --mysql-password=123456abc --test=tests/db/oltp.lua --oltp_tables_count=10 --oltp-table-size=1000000 --rand-init=on prepare

./sysbench --mysql-host= --mysql-port=3306 --mysql-user=root --mysql-password=123456abc --test=tests/db/oltp.lua --oltp_tables_count=10 --oltp-table-size=1000000 --rand-init=on prepare


[root@localhost storage]# sysbench --test=threads --num-threads=64 --thread-yields=100 --thread-locks=2 run

./sysbench --mysql-host= --mysql-port=3306 --mysql-user=root \
--mysql-password=123456abc --test=tests/db/oltp.lua --oltp_tables_count=20 \
--oltp-table-size=10000000 --num-threads=10 --oltp-read-only=off \
--report-interval=10 --rand-type=uniform --max-time=3600 \
 --max-requests=0 --percentile=99 run >> /home/dba2/log/sysbench_oltpX_12_2019-01-16_5.7.24_writeset_MTS.log


 
error 1:
	./sysbench: error while loading shared libraries: libmysqlclient.so.20: cannot open shared object file: No such file or directory

	export LD_LIBRARY_PATH=/usr/local/mysql/lib  OK


error2:
	Unknown option: --oltp_tables_count.
	Usage:
	  sysbench [general-options]... --test=<test-name> [test-options]... command
	  
  
  
error3:
	sysbench-0.4.12 /usr/bin/ld: cannot find -lmysqlclient_r
	http://liuhonghe.me/sysbench-mysql-benchmark-test.html
	  

  
error4:
	configure: error: cannot find MySQL client libraries in /usr/local/mysql/lib
	export LD_LIBRARY_PATH=/usr/local/mysql/lib  OK

error5:
	make[3]: *** [libsbmysql_a-drv_mysql.o] Error 1
	make[3]: Leaving directory `/root/sysbench-0.5/sysbench/drivers/mysql'
	make[2]: *** [all-recursive] Error 1
	make[2]: Leaving directory `/root/sysbench-0.5/sysbench/drivers'
	make[1]: *** [all-recursive] Error 1
	make[1]: Leaving directory `/root/sysbench-0.5/sysbench'
	make: *** [all-recursive] Error 1

