

1. 100GB的SSD 盘
	1.1 顺序写的I/O
	1.2 顺序读的I/O
	1.3 随机读写的I/O

2.0 900GB的SSD盘
	2.1 顺序写的I/O   
	2.2 顺序读的I/O  
	2.3 随机混合写和读的I/O
	
3. 1000GB的SSD盘
	3.1 顺序写的I/O   
	3.2 顺序读的I/O  
	3.3 随机混合写和读的I/O

4. 对比





1. 100GB的SSD 盘

1.1 顺序写的I/O

	sudo fio -filename=/data_volume/fio_write.txt -direct=1 -iodepth 1 -thread -rw=write -ioengine=psync -bs=16k -size=500M -numjobs=10 -runtime=10 -group_reporting -name=mytest 
	[coding001@db-a data_volume]$ sudo fio -filename=/data_volume/fio_write.txt -direct=1 -iodepth 1 -thread -rw=write -ioengine=psync -bs=16k -size=500M -numjobs=10 -runtime=10 -group_reporting -name=mytest 
	mytest: (g=0): rw=write, bs=(R) 16.0KiB-16.0KiB, (W) 16.0KiB-16.0KiB, (T) 16.0KiB-16.0KiB, ioengine=psync, iodepth=1
	...
	fio-3.7
	Starting 10 threads
	mytest: Laying out IO file (1 file / 500MiB)
	Jobs: 10 (f=10): [W(10)][100.0%][r=0KiB/s,w=48.0MiB/s][r=0,w=3074 IOPS][eta 00m:00s]
	mytest: (groupid=0, jobs=10): err= 0: pid=6812: Wed Jul 14 14:27:32 2021
	  write: IOPS=9623, BW=150MiB/s (158MB/s)(1504MiB/10004msec)
		clat (usec): min=407, max=6204, avg=1036.25, stdev=768.49
		 lat (usec): min=407, max=6204, avg=1037.31, stdev=768.44
		clat percentiles (usec):
		 |  1.00th=[  498],  5.00th=[  553], 10.00th=[  594], 20.00th=[  644],
		 | 30.00th=[  693], 40.00th=[  734], 50.00th=[  775], 60.00th=[  832],
		 | 70.00th=[  906], 80.00th=[ 1020], 90.00th=[ 2704], 95.00th=[ 3261],
		 | 99.00th=[ 3523], 99.50th=[ 3621], 99.90th=[ 3884], 99.95th=[ 4047],
		 | 99.99th=[ 4424]
	   bw (  KiB/s): min= 4832, max=20832, per=10.00%, avg=15398.81, stdev=6954.10, samples=200
	   iops        : min=  302, max= 1302, avg=962.39, stdev=434.61, samples=200
	  lat (usec)   : 500=1.12%, 750=43.38%, 1000=34.37%
	  lat (msec)   : 2=10.93%, 4=10.13%, 10=0.07%
	  cpu          : usr=0.74%, sys=3.80%, ctx=113528, majf=0, minf=8
	  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
		 submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
		 complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
		 issued rwts: total=0,96269,0,0 short=0,0,0,0 dropped=0,0,0,0
		 latency   : target=0, window=0, percentile=100.00%, depth=1

	Run status group 0 (all jobs):
	  WRITE: bw=150MiB/s (158MB/s), 150MiB/s-150MiB/s (158MB/s-158MB/s), io=1504MiB (1577MB), run=10004-10004msec

	Disk stats (read/write):
	  sdb: ios=0/95939, merge=0/0, ticks=0/94108, in_queue=94559, util=99.17%



1.2 顺序读的I/O



	sudo fio -filename=/data_volume/fio_read.txt -direct=1 -iodepth 1 -thread -rw=read -ioengine=psync -bs=16k -size=500M -numjobs=10 -runtime=10 -group_reporting -name=mytest 
	[coding001@db-a data_volume]$ sudo fio -filename=/data_volume/fio_read.txt -direct=1 -iodepth 1 -thread -rw=read -ioengine=psync -bs=16k -size=500M -numjobs=10 -runtime=10 -group_reporting -name=mytest 
	mytest: (g=0): rw=read, bs=(R) 16.0KiB-16.0KiB, (W) 16.0KiB-16.0KiB, (T) 16.0KiB-16.0KiB, ioengine=psync, iodepth=1
	...
	fio-3.7
	Starting 10 threads
	mytest: Laying out IO file (1 file / 500MiB)
	Jobs: 10 (f=10): [R(10)][100.0%][r=48.0MiB/s,w=0KiB/s][r=3072,w=0 IOPS][eta 00m:00s]
	mytest: (groupid=0, jobs=10): err= 0: pid=6761: Wed Jul 14 14:25:52 2021
	   read: IOPS=9622, BW=150MiB/s (158MB/s)(1504MiB/10005msec)
		clat (usec): min=53, max=4533, avg=1037.41, stdev=965.20
		 lat (usec): min=53, max=4534, avg=1037.59, stdev=965.22
		clat percentiles (usec):
		 |  1.00th=[  143],  5.00th=[  502], 10.00th=[  562], 20.00th=[  611],
		 | 30.00th=[  627], 40.00th=[  644], 50.00th=[  660], 60.00th=[  676],
		 | 70.00th=[  701], 80.00th=[  758], 90.00th=[ 2999], 95.00th=[ 3261],
		 | 99.00th=[ 4228], 99.50th=[ 4293], 99.90th=[ 4424], 99.95th=[ 4424],
		 | 99.99th=[ 4490]
	   bw (  KiB/s): min= 4768, max=28832, per=10.04%, avg=15453.30, stdev=9836.57, samples=199
	   iops        : min=  298, max= 1802, avg=965.80, stdev=614.80, samples=199
	  lat (usec)   : 100=0.23%, 250=2.24%, 500=2.39%, 750=74.49%, 1000=4.58%
	  lat (msec)   : 2=0.82%, 4=13.58%, 10=1.66%
	  cpu          : usr=0.47%, sys=2.97%, ctx=96314, majf=0, minf=57
	  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
		 submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
		 complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
		 issued rwts: total=96275,0,0,0 short=0,0,0,0 dropped=0,0,0,0
		 latency   : target=0, window=0, percentile=100.00%, depth=1

	Run status group 0 (all jobs):
	   READ: bw=150MiB/s (158MB/s), 150MiB/s-150MiB/s (158MB/s-158MB/s), io=1504MiB (1577MB), run=10005-10005msec

	Disk stats (read/write):
	  sdb: ios=95719/2, merge=0/0, ticks=95180/2, in_queue=95474, util=99.19%




1.3 随机读写的I/O

	fio -filename=/data_volume/fio.txt -direct=1 -iodepth 1 -thread -rw=randrw -ioengine=psync -bs=16k -size=500M -numjobs=10 -runtime=10 -group_reporting -name=mytest

	[coding001@db-a data_volume]$ sudo fio -filename=/data_volume/fio.txt -direct=1 -iodepth 1 -thread -rw=randrw -ioengine=psync -bs=16k -size=500M -numjobs=10 -runtime=10 -group_reporting -name=mytest
	mytest: (g=0): rw=randrw, bs=(R) 16.0KiB-16.0KiB, (W) 16.0KiB-16.0KiB, (T) 16.0KiB-16.0KiB, ioengine=psync, iodepth=1
	...
	fio-3.7
	Starting 10 threads
	mytest: Laying out IO file (1 file / 500MiB)
	Jobs: 10 (f=10): [m(2),f(1),m(7)][100.0%][r=23.5MiB/s,w=23.4MiB/s][r=1502,w=1500 IOPS][eta 00m:00s]
	mytest: (groupid=0, jobs=10): err= 0: pid=6721: Wed Jul 14 14:24:45 2021
	   read: IOPS=5065, BW=79.2MiB/s (82.0MB/s)(792MiB/10004msec)
		clat (usec): min=187, max=6371, avg=844.61, stdev=944.38
		 lat (usec): min=187, max=6371, avg=844.79, stdev=944.38
		clat percentiles (usec):
		 |  1.00th=[  260],  5.00th=[  297], 10.00th=[  322], 20.00th=[  363],
		 | 30.00th=[  408], 40.00th=[  453], 50.00th=[  498], 60.00th=[  545],
		 | 70.00th=[  594], 80.00th=[  676], 90.00th=[ 3032], 95.00th=[ 3294],
		 | 99.00th=[ 3654], 99.50th=[ 3916], 99.90th=[ 4359], 99.95th=[ 4424],
		 | 99.99th=[ 5276]
	   bw (  KiB/s): min= 1792, max=15872, per=10.00%, avg=8106.65, stdev=5134.57, samples=200
	   iops        : min=  112, max=  992, avg=506.64, stdev=320.92, samples=200
	  write: IOPS=5113, BW=79.9MiB/s (83.8MB/s)(799MiB/10004msec)
		clat (usec): min=422, max=5036, avg=1113.96, stdev=928.91
		 lat (usec): min=423, max=5037, avg=1115.00, stdev=928.81
		clat percentiles (usec):
		 |  1.00th=[  506],  5.00th=[  562], 10.00th=[  594], 20.00th=[  652],
		 | 30.00th=[  693], 40.00th=[  734], 50.00th=[  775], 60.00th=[  824],
		 | 70.00th=[  873], 80.00th=[  971], 90.00th=[ 3261], 95.00th=[ 3523],
		 | 99.00th=[ 3949], 99.50th=[ 4228], 99.90th=[ 4686], 99.95th=[ 4817],
		 | 99.99th=[ 4948]
	   bw (  KiB/s): min= 1920, max=15744, per=10.00%, avg=8182.64, stdev=5234.67, samples=200
	   iops        : min=  120, max=  984, avg=511.39, stdev=327.18, samples=200
	  lat (usec)   : 250=0.26%, 500=25.39%, 750=38.22%, 1000=20.06%
	  lat (msec)   : 2=2.88%, 4=12.55%, 10=0.63%
	  cpu          : usr=0.55%, sys=3.08%, ctx=104792, majf=0, minf=9
	  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
		 submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
		 complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
		 issued rwts: total=50678,51153,0,0 short=0,0,0,0 dropped=0,0,0,0
		 latency   : target=0, window=0, percentile=100.00%, depth=1

	Run status group 0 (all jobs):
	   READ: bw=79.2MiB/s (82.0MB/s), 79.2MiB/s-79.2MiB/s (82.0MB/s-82.0MB/s), io=792MiB (830MB), run=10004-10004msec
	  WRITE: bw=79.9MiB/s (83.8MB/s), 79.9MiB/s-79.9MiB/s (83.8MB/s-83.8MB/s), io=799MiB (838MB), run=10004-10004msec

	Disk stats (read/write):
	  sdb: ios=50422/50953, merge=0/7, ticks=40554/54729, in_queue=95392, util=99.13%



2.0 900GB的SSD盘

	[root@localhost mysql3306]# df -h
	文件系统             容量  已用  可用 已用% 挂载点
	/dev/mapper/cl-root   50G  9.3G   41G   19% /
	devtmpfs             7.8G     0  7.8G    0% /dev
	tmpfs                7.8G     0  7.8G    0% /dev/shm
	tmpfs                7.8G   73M  7.7G    1% /run
	tmpfs                7.8G     0  7.8G    0% /sys/fs/cgroup
	/dev/sda1           1014M  140M  875M   14% /boot
	/dev/mapper/cl-home  873G   44G  829G    6% /home
	tmpfs                1.6G     0  1.6G    0% /run/user/0
	[root@localhost mysql3306]# pwd
	/home/mysql/mysql3306

2.1 顺序写的I/O  
	[root@localhost mysql3306]# fio -filename=//home/mysql/mysql3306/fio_write.txt -direct=1 -iodepth 1 -thread -rw=write -ioengine=psync -bs=16k -size=500M -numjobs=10 -runtime=10 -group_reporting -name=mytest 
	mytest: (g=0): rw=write, bs=(R) 16.0KiB-16.0KiB, (W) 16.0KiB-16.0KiB, (T) 16.0KiB-16.0KiB, ioengine=psync, iodepth=1
	...
	fio-3.7
	Starting 10 threads
	mytest: Laying out IO file (1 file / 500MiB)
	Jobs: 10 (f=10): [W(10)][100.0%][r=0KiB/s,w=190MiB/s][r=0,w=12.2k IOPS][eta 00m:00s]
	mytest: (groupid=0, jobs=10): err= 0: pid=7976: Wed Jul 14 11:51:54 2021
	  write: IOPS=12.2k, BW=190MiB/s (199MB/s)(1903MiB/10001msec)
		clat (usec): min=266, max=49234, avg=820.27, stdev=1137.28
		 lat (usec): min=266, max=49234, avg=820.63, stdev=1137.28
		clat percentiles (usec):
		 |  1.00th=[  627],  5.00th=[  644], 10.00th=[  660], 20.00th=[  685],
		 | 30.00th=[  701], 40.00th=[  725], 50.00th=[  742], 60.00th=[  766],
		 | 70.00th=[  791], 80.00th=[  865], 90.00th=[ 1045], 95.00th=[ 1106],
		 | 99.00th=[ 1254], 99.50th=[ 1385], 99.90th=[ 1565], 99.95th=[40109],
		 | 99.99th=[49021]
	   bw (  KiB/s): min=10912, max=20288, per=10.01%, avg=19497.75, stdev=2147.89, samples=196
	   iops        : min=  682, max= 1268, avg=1218.61, stdev=134.24, samples=196
	  lat (usec)   : 500=0.01%, 750=52.83%, 1000=33.89%
	  lat (msec)   : 2=13.20%, 50=0.07%
	  cpu          : usr=0.19%, sys=1.14%, ctx=121801, majf=0, minf=14
	  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
		 submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
		 complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
		 issued rwts: total=0,121767,0,0 short=0,0,0,0 dropped=0,0,0,0
		 latency   : target=0, window=0, percentile=100.00%, depth=1

	Run status group 0 (all jobs):
	  WRITE: bw=190MiB/s (199MB/s), 190MiB/s-190MiB/s (199MB/s-199MB/s), io=1903MiB (1995MB), run=10001-10001msec

	Disk stats (read/write):
		dm-2: ios=0/120467, merge=0/0, ticks=0/97585, in_queue=97594, util=99.03%, aggrios=0/121767, aggrmerge=0/0, aggrticks=0/98552, aggrin_queue=98523, aggrutil=98.93%
	  sda: ios=0/121767, merge=0/0, ticks=0/98552, in_queue=98523, util=98.93%


	  
2.2 顺序读的I/O  
	[root@localhost mysql3306]# fio -filename=//home/mysql/mysql3306/fio_read.txt -direct=1 -iodepth 1 -thread -rw=read -ioengine=psync -bs=16k -size=500M -numjobs=10 -runtime=10 -group_reporting -name=mytest 
	mytest: (g=0): rw=read, bs=(R) 16.0KiB-16.0KiB, (W) 16.0KiB-16.0KiB, (T) 16.0KiB-16.0KiB, ioengine=psync, iodepth=1
	...
	fio-3.7
	Starting 10 threads
	mytest: Laying out IO file (1 file / 500MiB)
	Jobs: 10 (f=10): [R(10)][100.0%][r=311MiB/s,w=0KiB/s][r=19.9k,w=0 IOPS][eta 00m:00s]
	mytest: (groupid=0, jobs=10): err= 0: pid=7937: Wed Jul 14 11:50:50 2021
	   read: IOPS=19.8k, BW=310MiB/s (325MB/s)(3101MiB/10001msec)
		clat (usec): min=450, max=14144, avg=503.36, stdev=99.36
		 lat (usec): min=450, max=14145, avg=503.43, stdev=99.36
		clat percentiles (usec):
		 |  1.00th=[  469],  5.00th=[  478], 10.00th=[  494], 20.00th=[  494],
		 | 30.00th=[  494], 40.00th=[  494], 50.00th=[  494], 60.00th=[  494],
		 | 70.00th=[  494], 80.00th=[  502], 90.00th=[  545], 95.00th=[  545],
		 | 99.00th=[  644], 99.50th=[  660], 99.90th=[  685], 99.95th=[  693],
		 | 99.99th=[  750]
	   bw (  KiB/s): min=30176, max=31904, per=10.00%, avg=31746.86, stdev=368.41, samples=190
	   iops        : min= 1886, max= 1994, avg=1984.18, stdev=23.03, samples=190
	  lat (usec)   : 500=80.10%, 750=19.89%, 1000=0.01%
	  lat (msec)   : 20=0.01%
	  cpu          : usr=0.20%, sys=1.27%, ctx=198536, majf=0, minf=57
	  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
		 submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
		 complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
		 issued rwts: total=198460,0,0,0 short=0,0,0,0 dropped=0,0,0,0
		 latency   : target=0, window=0, percentile=100.00%, depth=1

	Run status group 0 (all jobs):
	   READ: bw=310MiB/s (325MB/s), 310MiB/s-310MiB/s (325MB/s-325MB/s), io=3101MiB (3252MB), run=10001-10001msec

	Disk stats (read/write):
		dm-2: ios=198263/0, merge=0/0, ticks=98184/0, in_queue=98184, util=99.04%, aggrios=198460/0, aggrmerge=0/0, aggrticks=98220/0, aggrin_queue=98184, aggrutil=98.93%
	  sda: ios=198460/0, merge=0/0, ticks=98220/0, in_queue=98184, util=98.93%
	  

2.3 随机混合写和读的I/O
	[root@localhost mysql3306]# fio -filename=//home/mysql/mysql3306/fio.txt -direct=1 -iodepth 1 -thread -rw=randrw -ioengine=psync -bs=16k -size=500M -numjobs=10 -runtime=10 -group_reporting -name=mytest 
	mytest: (g=0): rw=randrw, bs=(R) 16.0KiB-16.0KiB, (W) 16.0KiB-16.0KiB, (T) 16.0KiB-16.0KiB, ioengine=psync, iodepth=1
	...
	fio-3.7
	Starting 10 threads
	mytest: Laying out IO file (1 file / 500MiB)
	Jobs: 10 (f=10): [m(10)][100.0%][r=2066KiB/s,w=1665KiB/s][r=129,w=104 IOPS][eta 00m:00s]
	mytest: (groupid=0, jobs=10): err= 0: pid=7893: Wed Jul 14 11:49:36 2021
	   read: IOPS=115, BW=1841KiB/s (1885kB/s)(18.1MiB/10084msec)
		clat (usec): min=172, max=384511, avg=73071.78, stdev=59590.96
		 lat (usec): min=172, max=384511, avg=73072.22, stdev=59590.94
		clat percentiles (usec):
		 |  1.00th=[   494],  5.00th=[  7111], 10.00th=[ 13042], 20.00th=[ 22152],
		 | 30.00th=[ 32375], 40.00th=[ 45876], 50.00th=[ 59507], 60.00th=[ 72877],
		 | 70.00th=[ 90702], 80.00th=[113771], 90.00th=[154141], 95.00th=[193987],
		 | 99.00th=[270533], 99.50th=[325059], 99.90th=[346031], 99.95th=[383779],
		 | 99.99th=[383779]
	   bw (  KiB/s): min=   64, max=  383, per=10.00%, avg=184.01, stdev=63.02, samples=200
	   iops        : min=    4, max=   23, avg=11.36, stdev= 3.91, samples=200
	  write: IOPS=111, BW=1783KiB/s (1826kB/s)(17.6MiB/10084msec)
		clat (usec): min=101, max=250027, avg=13965.38, stdev=29675.33
		 lat (usec): min=102, max=250028, avg=13966.33, stdev=29675.34
		clat percentiles (usec):
		 |  1.00th=[   139],  5.00th=[   159], 10.00th=[   174], 20.00th=[   204],
		 | 30.00th=[   235], 40.00th=[   285], 50.00th=[   510], 60.00th=[  1221],
		 | 70.00th=[  6521], 80.00th=[ 24249], 90.00th=[ 47449], 95.00th=[ 67634],
		 | 99.00th=[152044], 99.50th=[191890], 99.90th=[242222], 99.95th=[250610],
		 | 99.99th=[250610]
	   bw (  KiB/s): min=   31, max=  576, per=10.43%, avg=186.05, stdev=107.59, samples=193
	   iops        : min=    1, max=   36, avg=11.49, stdev= 6.73, samples=193
	  lat (usec)   : 250=17.21%, 500=7.79%, 750=3.02%, 1000=1.23%
	  lat (msec)   : 2=3.11%, 4=1.93%, 10=5.30%, 20=7.14%, 50=19.88%
	  lat (msec)   : 100=19.09%, 250=13.49%, 500=0.83%
	  cpu          : usr=0.01%, sys=0.09%, ctx=2337, majf=0, minf=11
	  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
		 submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
		 complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
		 issued rwts: total=1160,1124,0,0 short=0,0,0,0 dropped=0,0,0,0
		 latency   : target=0, window=0, percentile=100.00%, depth=1

	Run status group 0 (all jobs):
	   READ: bw=1841KiB/s (1885kB/s), 1841KiB/s-1841KiB/s (1885kB/s-1885kB/s), io=18.1MiB (19.0MB), run=10084-10084msec
	  WRITE: bw=1783KiB/s (1826kB/s), 1783KiB/s-1783KiB/s (1826kB/s-1826kB/s), io=17.6MiB (18.4MB), run=10084-10084msec

	Disk stats (read/write):
		dm-2: ios=1159/1149, merge=0/0, ticks=83533/18899, in_queue=111626, util=99.07%, aggrios=1160/1154, aggrmerge=0/6, aggrticks=84726/39074, aggrin_queue=123799, aggrutil=98.96%
	  sda: ios=1160/1154, merge=0/6, ticks=84726/39074, in_queue=123799, util=98.96%



3. 1000GB的SSD盘

3.1 顺序写的I/O   

	[root@iZ2zebrso907kehx5xp0z3Z mydata]# fio -filename=/mydata/fio_write.txt -direct=1 -iodepth 1 -thread -rw=write -ioengine=psync -bs=16k -size=500M -numjobs=10 -runtime=10 -group_reporting -name=mytest 
	mytest: (g=0): rw=write, bs=(R) 16.0KiB-16.0KiB, (W) 16.0KiB-16.0KiB, (T) 16.0KiB-16.0KiB, ioengine=psync, iodepth=1
	...
	fio-3.19
	Starting 10 threads
	mytest: Laying out IO file (1 file / 500MiB)
	Jobs: 10 (f=10): [W(10)][100.0%][w=158MiB/s][w=10.1k IOPS][eta 00m:00s]
	mytest: (groupid=0, jobs=10): err= 0: pid=26403: Thu Jul 22 11:04:47 2021
	  write: IOPS=11.1k, BW=173MiB/s (182MB/s)(1733MiB/10001msec); 0 zone resets
		clat (usec): min=398, max=4494, avg=900.20, stdev=383.82
		 lat (usec): min=399, max=4495, avg=900.92, stdev=383.82
		clat percentiles (usec):
		 |  1.00th=[  486],  5.00th=[  562], 10.00th=[  603], 20.00th=[  660],
		 | 30.00th=[  709], 40.00th=[  758], 50.00th=[  807], 60.00th=[  873],
		 | 70.00th=[  947], 80.00th=[ 1045], 90.00th=[ 1237], 95.00th=[ 1500],
		 | 99.00th=[ 2638], 99.50th=[ 3163], 99.90th=[ 3884], 99.95th=[ 4015],
		 | 99.99th=[ 4228]
	   bw (  KiB/s): min=160256, max=196897, per=100.00%, avg=177997.53, stdev=1308.17, samples=190
	   iops        : min=10016, max=12306, avg=11124.58, stdev=81.73, samples=190
	  lat (usec)   : 500=1.35%, 750=37.35%, 1000=37.01%
	  lat (msec)   : 2=21.84%, 4=2.39%, 10=0.05%
	  cpu          : usr=0.35%, sys=0.94%, ctx=114260, majf=0, minf=0
	  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
		 submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
		 complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
		 issued rwts: total=0,110909,0,0 short=0,0,0,0 dropped=0,0,0,0
		 latency   : target=0, window=0, percentile=100.00%, depth=1

	Run status group 0 (all jobs):
	  WRITE: bw=173MiB/s (182MB/s), 173MiB/s-173MiB/s (182MB/s-182MB/s), io=1733MiB (1817MB), run=10001-10001msec

	Disk stats (read/write):
	  vdb: ios=0/109147, merge=0/812, ticks=0/96572, in_queue=96571, util=99.12%
	  
3.2 顺序读的I/O  	  
	[root@iZ2zebrso907kehx5xp0z3Z mydata]# fio -filename=/mydata/fio_read.txt -direct=1 -iodepth 1 -thread -rw=read -ioengine=psync -bs=16k -size=500M -numjobs=10 -runtime=10 -group_reporting -name=mytest 
	mytest: (g=0): rw=read, bs=(R) 16.0KiB-16.0KiB, (W) 16.0KiB-16.0KiB, (T) 16.0KiB-16.0KiB, ioengine=psync, iodepth=1
	...
	fio-3.19
	Starting 10 threads
	mytest: Laying out IO file (1 file / 500MiB)
	Jobs: 10 (f=10): [R(10)][100.0%][r=156MiB/s][r=9990 IOPS][eta 00m:00s]
	mytest: (groupid=0, jobs=10): err= 0: pid=26417: Thu Jul 22 11:05:10 2021
	  read: IOPS=11.0k, BW=172MiB/s (180MB/s)(1720MiB/10003msec)
		clat (usec): min=111, max=10061, avg=907.42, stdev=1883.35
		 lat (usec): min=111, max=10061, avg=907.53, stdev=1883.34
		clat percentiles (usec):
		 |  1.00th=[  137],  5.00th=[  163], 10.00th=[  184], 20.00th=[  217],
		 | 30.00th=[  249], 40.00th=[  302], 50.00th=[  338], 60.00th=[  367],
		 | 70.00th=[  396], 80.00th=[  437], 90.00th=[  766], 95.00th=[ 7046],
		 | 99.00th=[ 7308], 99.50th=[ 7439], 99.90th=[ 7570], 99.95th=[ 7635],
		 | 99.99th=[ 8291]
	   bw (  KiB/s): min=127424, max=328010, per=99.58%, avg=175362.21, stdev=4957.51, samples=190
	   iops        : min= 7964, max=20496, avg=10959.89, stdev=309.77, samples=190
	  lat (usec)   : 250=30.42%, 500=55.57%, 750=3.95%, 1000=0.74%
	  lat (msec)   : 2=0.44%, 4=0.18%, 10=8.71%, 20=0.01%
	  cpu          : usr=0.27%, sys=1.07%, ctx=110112, majf=0, minf=40
	  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
		 submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
		 complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
		 issued rwts: total=110093,0,0,0 short=0,0,0,0 dropped=0,0,0,0
		 latency   : target=0, window=0, percentile=100.00%, depth=1

	Run status group 0 (all jobs):
	   READ: bw=172MiB/s (180MB/s), 172MiB/s-172MiB/s (180MB/s-180MB/s), io=1720MiB (1804MB), run=10003-10003msec

	Disk stats (read/write):
	  vdb: ios=108783/0, merge=0/0, ticks=97559/0, in_queue=97559, util=99.09%
	  

3.3 随机混合写和读的I/O	  
	[root@iZ2zebrso907kehx5xp0z3Z mydata]# fio -filename=/mydata/fio.txt -direct=1 -iodepth 1 -thread -rw=randrw -ioengine=psync -bs=16k -size=500M -numjobs=10 -runtime=10 -group_reporting -name=mytest
	mytest: (g=0): rw=randrw, bs=(R) 16.0KiB-16.0KiB, (W) 16.0KiB-16.0KiB, (T) 16.0KiB-16.0KiB, ioengine=psync, iodepth=1
	...
	fio-3.19
	Starting 10 threads
	mytest: Laying out IO file (1 file / 500MiB)
	Jobs: 10 (f=10): [m(10)][100.0%][r=77.9MiB/s,w=78.2MiB/s][r=4986,w=5003 IOPS][eta 00m:00s]
	mytest: (groupid=0, jobs=10): err= 0: pid=26431: Thu Jul 22 11:05:27 2021
	  read: IOPS=5480, BW=85.6MiB/s (89.8MB/s)(857MiB/10004msec)
		clat (usec): min=129, max=7641, avg=831.68, stdev=1493.15
		 lat (usec): min=129, max=7641, avg=831.78, stdev=1493.15
		clat percentiles (usec):
		 |  1.00th=[  251],  5.00th=[  277], 10.00th=[  289], 20.00th=[  306],
		 | 30.00th=[  318], 40.00th=[  334], 50.00th=[  351], 60.00th=[  371],
		 | 70.00th=[  404], 80.00th=[  469], 90.00th=[  840], 95.00th=[ 5669],
		 | 99.00th=[ 6194], 99.50th=[ 6325], 99.90th=[ 6456], 99.95th=[ 6521],
		 | 99.99th=[ 7046]
	   bw (  KiB/s): min=72640, max=162568, per=99.62%, avg=87348.63, stdev=1899.70, samples=190
	   iops        : min= 4540, max=10156, avg=5459.05, stdev=118.64, samples=190
	  write: IOPS=5525, BW=86.3MiB/s (90.5MB/s)(864MiB/10004msec); 0 zone resets
		clat (usec): min=367, max=7994, avg=981.57, stdev=1475.82
		 lat (usec): min=367, max=7995, avg=982.49, stdev=1475.81
		clat percentiles (usec):
		 |  1.00th=[  404],  5.00th=[  412], 10.00th=[  424], 20.00th=[  445],
		 | 30.00th=[  465], 40.00th=[  486], 50.00th=[  510], 60.00th=[  537],
		 | 70.00th=[  570], 80.00th=[  635], 90.00th=[ 1090], 95.00th=[ 5735],
		 | 99.00th=[ 6325], 99.50th=[ 6390], 99.90th=[ 6718], 99.95th=[ 7111],
		 | 99.99th=[ 7701]
	   bw (  KiB/s): min=75328, max=168945, per=99.66%, avg=88115.42, stdev=1995.58, samples=190
	   iops        : min= 4708, max=10554, avg=5506.95, stdev=124.62, samples=190
	  lat (usec)   : 250=0.47%, 500=64.00%, 750=23.44%, 1000=2.22%
	  lat (msec)   : 2=1.18%, 4=0.23%, 10=8.46%
	  cpu          : usr=0.36%, sys=1.03%, ctx=110401, majf=0, minf=0
	  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
		 submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
		 complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
		 issued rwts: total=54822,55282,0,0 short=0,0,0,0 dropped=0,0,0,0
		 latency   : target=0, window=0, percentile=100.00%, depth=1

	Run status group 0 (all jobs):
	   READ: bw=85.6MiB/s (89.8MB/s), 85.6MiB/s-85.6MiB/s (89.8MB/s-89.8MB/s), io=857MiB (898MB), run=10004-10004msec
	  WRITE: bw=86.3MiB/s (90.5MB/s), 86.3MiB/s-86.3MiB/s (90.5MB/s-90.5MB/s), io=864MiB (906MB), run=10004-10004msec

	Disk stats (read/write):
	  vdb: ios=54107/54587, merge=0/0, ticks=44381/52942, in_queue=97323, util=99.08%



3. 对比

	内存大小  CPU	磁盘类型   			顺序写的IOPS   顺序读的IOPS   混合随机读写的IOPS
	16GB	  4核	100GB的SSD      	3074           3072			  r=1502,w=1500 
	16GB	  4核	900GB的机械盘		12000		   20000		  r=129,w=104
	4GB       2核   1000GB的SSD			10000		   9990			  r=4986,w=5003



