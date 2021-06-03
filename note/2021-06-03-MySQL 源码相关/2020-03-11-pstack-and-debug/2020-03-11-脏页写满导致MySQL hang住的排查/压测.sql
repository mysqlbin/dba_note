
通过 fio 压测磁盘IOPS
	root@voice mydata]# fio -filename=/mydata/fio.txt -direct=1 -iodepth 1 -thread -rw=randrw -ioengine=psync -bs=16k -size=500M -numjobs=10 -runtime=10 -group_reporting -name=mytest
	mytest: (g=0): rw=randrw, bs=16K-16K/16K-16K/16K-16K, ioengine=psync, iodepth=1
	...
	fio-2.2.8
	Starting 10 threads
	mytest: Laying out IO file(s) (1 file(s) / 500MB)
	Jobs: 10 (f=10): [m(10)] [100.0% done] [20096KB/15680KB/0KB /s] [1256/980/0 iops] [eta 00m:00s]
	mytest: (groupid=0, jobs=10): err= 0: pid=11837: Wed Mar 11 17:26:35 2020
	  read : io=200512KB, bw=20041KB/s, iops=1252, runt= 10005msec
		clat (usec): min=528, max=73487, avg=4055.10, stdev=3998.97
		 lat (usec): min=529, max=73488, avg=4055.56, stdev=3998.97
		clat percentiles (usec):
		 |  1.00th=[  644],  5.00th=[  692], 10.00th=[  732], 20.00th=[  796],
		 | 30.00th=[  876], 40.00th=[ 1224], 50.00th=[ 3536], 60.00th=[ 4768],
		 | 70.00th=[ 5792], 80.00th=[ 6880], 90.00th=[ 8512], 95.00th=[10048],
		 | 99.00th=[13760], 99.50th=[16768], 99.90th=[29312], 99.95th=[70144],
		 | 99.99th=[71168]
		bw (KB  /s): min= 1169, max= 3136, per=10.02%, avg=2008.91, stdev=384.65
	  write: io=184064KB, bw=18397KB/s, iops=1149, runt= 10005msec
		clat (usec): min=500, max=73284, avg=4267.71, stdev=4440.45
		 lat (usec): min=500, max=73285, avg=4268.88, stdev=4440.47
		clat percentiles (usec):
		 |  1.00th=[  564],  5.00th=[  604], 10.00th=[  636], 20.00th=[  700],
		 | 30.00th=[  804], 40.00th=[ 1704], 50.00th=[ 3888], 60.00th=[ 5088],
		 | 70.00th=[ 6048], 80.00th=[ 7200], 90.00th=[ 8768], 95.00th=[10304],
		 | 99.00th=[15168], 99.50th=[18304], 99.90th=[70144], 99.95th=[71168],
		 | 99.99th=[73216]
		bw (KB  /s): min= 1328, max= 2454, per=10.04%, avg=1846.56, stdev=220.83
		lat (usec) : 750=18.96%, 1000=17.57%
		lat (msec) : 2=5.48%, 4=10.16%, 10=42.59%, 20=4.89%, 50=0.22%
		lat (msec) : 100=0.12%
	  cpu          : usr=0.23%, sys=1.31%, ctx=45215, majf=0, minf=9
	  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
		 submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
		 complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
		 issued    : total=r=12532/w=11504/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
		 latency   : target=0, window=0, percentile=100.00%, depth=1

	Run status group 0 (all jobs):
	   READ: io=200512KB, aggrb=20041KB/s, minb=20041KB/s, maxb=20041KB/s, mint=10005msec, maxt=10005msec
	  WRITE: io=184064KB, aggrb=18397KB/s, minb=18397KB/s, maxb=18397KB/s, mint=10005msec, maxt=10005msec

	Disk stats (read/write):
	  vda: ios=12511/11339, merge=0/22, ticks=12494/9012, in_queue=21498, util=95.64%


参数设置
	set global innodb_io_capacity=200;
	set global innodb_io_capacity_max=2000;

	root@mysqldb 17:56:  [(none)]> show global variables like '%innodb_io_capacity%';
	+------------------------+-------+
	| Variable_name          | Value |
	+------------------------+-------+
	| innodb_io_capacity     | 200   |
	| innodb_io_capacity_max | 2000  |
	+------------------------+-------+
	2 rows in set (0.00 sec)
	

	root@mysqldb 18:19:  [(none)]> set global innodb_max_dirty_pages_pct = 10;
	Query OK, 0 rows affected (0.00 sec)

	root@mysqldb 18:22:  [(none)]> show global variables like '%innodb_max_dirty_pages_pct%';
	+--------------------------------+-----------+
	| Variable_name                  | Value     |
	+--------------------------------+-----------+
	| innodb_max_dirty_pages_pct     | 10.000000 |
	| innodb_max_dirty_pages_pct_lwm | 0.000000  |
	+--------------------------------+-----------+
	2 rows in set (0.00 sec)

	root@mysqldb 18:13:  [(none)]> show global variables like '%innodb_buffer_pool%';
	+-------------------------------------+----------------+
	| Variable_name                       | Value          |
	+-------------------------------------+----------------+
	| innodb_buffer_pool_chunk_size       | 134217728      |
	| innodb_buffer_pool_dump_at_shutdown | ON             |
	| innodb_buffer_pool_dump_now         | OFF            |
	| innodb_buffer_pool_dump_pct         | 25             |
	| innodb_buffer_pool_filename         | ib_buffer_pool |
	| innodb_buffer_pool_instances        | 2              |
	| innodb_buffer_pool_load_abort       | OFF            |
	| innodb_buffer_pool_load_at_startup  | ON             |
	| innodb_buffer_pool_load_now         | OFF            |
	| innodb_buffer_pool_size             | 3221225472     |       # BP缓冲池为 3GB
	+-------------------------------------+----------------+
	10 rows in set (0.00 sec)


	set global sync_binlog=10000;
	set global innodb_flush_log_at_trx_commit=2;

sysbench 压测

	./configure --with-mysql-includes=/usr/local/mysql/include/mysql/ --with-mysql-libs=/usr/local/mysql/lib && make && make install

	./sysbench --mysql-host=39.108.193.40 --mysql-port=3306 --mysql-user=root --mysql-password=root@481845% --test=tests/db/oltp.lua --oltp_tables_count=10 --oltp-table-size=1000000 --rand-init=on prepare


	./sysbench --mysql-host=39.108.193.40 --mysql-port=3306 --mysql-user=root \
	--mysql-password=root@481845% --test=tests/db/oltp.lua --oltp_tables_count=10 \
	--oltp-table-size=1000000 --num-threads=10 --oltp-read-only=off \
	--report-interval=10 --rand-type=uniform --max-time=3600 \
	--max-requests=0 --percentile=99 run >> /mydata/sysbench_oltpX_10_2020-03-11_5.7.26.log



