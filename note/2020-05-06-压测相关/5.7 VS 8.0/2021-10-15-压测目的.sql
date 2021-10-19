

当前机器的最大TPS、QPS

双1 VS 非双1

5.7 VS 8.0

Hash join



mysql> show global variables like '%innodb_io_capacity%';
+------------------------+-------+
| Variable_name          | Value |
+------------------------+-------+
| innodb_io_capacity     | 200   |
| innodb_io_capacity_max | 2000  |
+------------------------+-------+
2 rows in set (0.41 sec)




CPU		物理内存	数据库内存缓冲池大小	数据盘大小	剩余空间大小
4核		16GB内存	8GB						100GB		55GB
是否是SSD盘		文件系统	MySQL 版本		部署MySQL所在的设备
是				ext4		5.7.26			/dev/vdb1

顺序读IOPS	顺序写IOPS	随机读/写的IOPS
4800		1000		750/775




mysql> show global variables like '%innodb_io_capacity%';
+------------------------+-------+
| Variable_name          | Value |
+------------------------+-------+
| innodb_io_capacity     | 200   |
| innodb_io_capacity_max | 2000  |
+------------------------+-------+
2 rows in set (0.41 sec)

innodb_io_capacity=5000
innodb_io_capacity_max=20000



sudo fio -filename=/data_volume/fio.txt -direct=1 -iodepth 1 -thread -rw=randrw -ioengine=psync -bs=16k -size=500M -numjobs=10 -runtime=10 -group_reporting -name=mytest 
[coding001@voice data_volume]$ sudo fio -filename=/data_volume/fio.txt -direct=1 -iodepth 1 -thread -rw=randrw -ioengine=psync -bs=16k -size=500M -numjobs=10 -runtime=10 -group_reporting -name=mytest 

mytest: (g=0): rw=randrw, bs=(R) 16.0KiB-16.0KiB, (W) 16.0KiB-16.0KiB, (T) 16.0KiB-16.0KiB, ioengine=psync, iodepth=1
...
fio-3.7
Starting 10 threads
mytest: Laying out IO file (1 file / 500MiB)
Jobs: 10 (f=10): [m(10)][100.0%][r=22.1MiB/s,w=22.2MiB/s][r=1414,w=1419 IOPS][eta 00m:00s]
mytest: (groupid=0, jobs=10): err= 0: pid=28966: Mon Oct 18 16:07:49 2021
   read: IOPS=4984, BW=77.9MiB/s (81.7MB/s)(779MiB/10004msec)
    clat (usec): min=222, max=14297, avg=885.30, stdev=1070.38
     lat (usec): min=223, max=14298, avg=885.65, stdev=1070.39
    clat percentiles (usec):
     |  1.00th=[  306],  5.00th=[  351], 10.00th=[  375], 20.00th=[  412],
     | 30.00th=[  445], 40.00th=[  478], 50.00th=[  510], 60.00th=[  545],
     | 70.00th=[  603], 80.00th=[  709], 90.00th=[ 3064], 95.00th=[ 3326],
     | 99.00th=[ 4080], 99.50th=[ 5342], 99.90th=[13304], 99.95th=[13566],
     | 99.99th=[13829]
   bw (  KiB/s): min= 1728, max=13984, per=10.00%, avg=7977.70, stdev=4972.89, samples=200
   iops        : min=  108, max=  874, avg=498.60, stdev=310.80, samples=200
  write: IOPS=5032, BW=78.6MiB/s (82.5MB/s)(787MiB/10004msec)
    clat (usec): min=409, max=14037, avg=1102.06, stdev=1027.43
     lat (usec): min=409, max=14037, avg=1103.10, stdev=1027.47
    clat percentiles (usec):
     |  1.00th=[  494],  5.00th=[  545], 10.00th=[  578], 20.00th=[  627],
     | 30.00th=[  660], 40.00th=[  701], 50.00th=[  742], 60.00th=[  799],
     | 70.00th=[  857], 80.00th=[  979], 90.00th=[ 3228], 95.00th=[ 3490],
     | 99.00th=[ 4113], 99.50th=[ 5407], 99.90th=[ 7898], 99.95th=[13566],
     | 99.99th=[13829]
   bw (  KiB/s): min= 1568, max=13984, per=10.00%, avg=8054.98, stdev=5064.96, samples=200
   iops        : min=   98, max=  874, avg=503.43, stdev=316.55, samples=200
  lat (usec)   : 250=0.02%, 500=24.32%, 750=42.41%, 1000=16.96%
  lat (msec)   : 2=3.97%, 4=11.23%, 10=1.00%, 20=0.10%
  cpu          : usr=1.12%, sys=4.52%, ctx=101781, majf=0, minf=8
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=49869,50350,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
   READ: bw=77.9MiB/s (81.7MB/s), 77.9MiB/s-77.9MiB/s (81.7MB/s-81.7MB/s), io=779MiB (817MB), run=10004-10004msec
  WRITE: bw=78.6MiB/s (82.5MB/s), 78.6MiB/s-78.6MiB/s (82.5MB/s-82.5MB/s), io=787MiB (825MB), run=10004-10004msec

Disk stats (read/write):
  sda: ios=49851/51416, merge=0/0, ticks=41741/55908, in_queue=98445, util=99.18%



磁盘IO能力不行，压测的TPS、QPS上不去多少。





SQL statistics:
    queries performed:
        read:                            1379084                       #300s执行了137万读请求
        write:                           394024                        #300s执行了39万写请求
        other:                           197012                        #300s执行了19万其他请求
        total:                           1970120                       #300s执行了共197万请求
    transactions:                        98506  (328.27 per sec.)      #300s执行了共9.8万次事务（每秒382.27次事务）
    queries:                             1970120 (6565.43 per sec.)    #300s执行了查询共197万次请求（每秒0.65万次请求）
    ignored errors:                      0      (0.00 per sec.)        #300s忽略错误总数（每秒忽略错误次数）
    reconnects:                          0      (0.00 per sec.)        #300s重连总数（每秒重连次数）

General statistics:
    total time:                          300.0742s                     #总耗时
    total number of events:              98506                         #总发生的事务数

Latency (ms):
         min:                                   20.68                  #最小延迟 20.68ms
         avg:                                   30.46                  #平均延迟 30.46ms
         max:                                  162.34                  #最大延迟 162.34ms
         95th percentile:                       46.63                  #95%的请求延迟 46.63ms
         sum:                              3000010.96

Threads fairness:
    events (avg/stddev):           9850.6000/536.53
    execution time (avg/stddev):   300.0011/0.03