
测试环境 
参数解读
第一次测试
第二次测试
第三次测试
第四次测试
第五次测试
计算多次测试的平均IOPS
	
测试环境:
	阿里云ECS
	CPU: 4
	内存: 16G
	磁盘种类：
		SSD云盘、100GiB(4800 IOPS)
	
	
参数解读:
filename=$filename　     # 注意： -filename=/dev/sda2或-filename=/dev/sdb 这样直接测试系统盘/数据盘，会格式化系统盘/数据盘
direct=1                 测试过程绕过机器自带的buffer，使测试结果更真实
rw=randwread             测试随机读的I/O
rw=randwrite             测试随机写的I/O
rw=randrw                测试随机混合写和读的I/O
rw=read                  测试顺序读的I/O
rw=write                 测试顺序写的I/O
rw=rw                    测试顺序混合写和读的I/O
bs=4k                    单次io的块文件大小为4k
bsrange=512-2048         同上，提定数据块的大小范围
size=5g                  本次的测试文件大小为5g，以每次4k的io进行测试
numjobs=30               本次的测试线程为30
runtime=1000             测试时间为1000秒，如果不写则一直将5g文件分4k每次写完为止
ioengine=psync           io引擎使用pync方式，如果要使用libaio引擎，需要yum install libaio-devel包
rwmixwrite=30            在混合读写的模式下，写占30%
group_reporting          关于显示结果的，汇总每个进程的信息
此外
lockmem=1g               只使用1g内存进行测试
zero_buffers             用0初始化系统buffer
nrfiles=8                每个进程生成文件的数量



第一次测试：
shell> fio -filename=/mydata/fio.txt -direct=1 -iodepth 1 -thread -rw=randrw -ioengine=psync -bs=16k -size=500M -numjobs=10 -runtime=10 -group_reporting -name=mytest 
mytest: (g=0): rw=randrw, bs=16K-16K/16K-16K/16K-16K, ioengine=psync, iodepth=1
...
fio-2.1.10
Starting 10 threads
mytest: Laying out IO file(s) (1 file(s) / 500MB)
Jobs: 10 (f=10): [mmmmmmmmmm] [100.0% done] [10848KB/10400KB/0KB /s] [678/650/0 iops] [eta 00m:00s]
mytest: (groupid=0, jobs=10): err= 0: pid=18523: Sat Oct 12 16:55:29 2019
  read : io=123968KB, bw=12392KB/s, iops=774, runt= 10004msec
    clat (usec): min=564, max=239065, avg=6330.69, stdev=11810.96
     lat (usec): min=565, max=239065, avg=6330.95, stdev=11810.97
    clat percentiles (usec):
     |  1.00th=[  612],  5.00th=[  692], 10.00th=[  740], 20.00th=[  828],
     | 30.00th=[  908], 40.00th=[ 1064], 50.00th=[ 2736], 60.00th=[ 4768],
     | 70.00th=[ 6560], 80.00th=[ 8640], 90.00th=[13376], 95.00th=[22400],
     | 99.00th=[58624], 99.50th=[73216], 99.90th=[123392], 99.95th=[234496],
     | 99.99th=[238592]
    bw (KB  /s): min=  171, max= 2756, per=10.09%, avg=1249.93, stdev=566.22
  write: io=112368KB, bw=11232KB/s, iops=702, runt= 10004msec
    clat (usec): min=549, max=235350, avg=7251.91, stdev=13676.53
     lat (usec): min=549, max=235350, avg=7252.61, stdev=13676.54
    clat percentiles (usec):
     |  1.00th=[  596],  5.00th=[  628], 10.00th=[  652], 20.00th=[  700],
     | 30.00th=[  756], 40.00th=[ 1272], 50.00th=[ 3728], 60.00th=[ 5536],
     | 70.00th=[ 7264], 80.00th=[ 9408], 90.00th=[14400], 95.00th=[27776],
     | 99.00th=[69120], 99.50th=[82432], 99.90th=[173056], 99.95th=[234496],
     | 99.99th=[234496]
    bw (KB  /s): min=  125, max= 2043, per=10.04%, avg=1127.84, stdev=445.44
    lat (usec) : 750=19.34%, 1000=18.38%
    lat (msec) : 2=7.58%, 4=8.37%, 10=29.42%, 20=10.83%, 50=4.38%
    lat (msec) : 100=1.50%, 250=0.20%
  cpu          : usr=0.12%, sys=0.56%, ctx=28456, majf=0, minf=7
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued    : total=r=7748/w=7023/d=0, short=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
   READ: io=123968KB, aggrb=12391KB/s, minb=12391KB/s, maxb=12391KB/s, mint=10004msec, maxt=10004msec
  WRITE: io=112368KB, aggrb=11232KB/s, minb=11232KB/s, maxb=11232KB/s, mint=10004msec, maxt=10004msec

Disk stats (read/write):
  vdb: ios=7622/6989, merge=0/92, ticks=8178/9844, in_queue=18030, util=97.86%



第二次测试：
shell> fio -filename=/mydata/fio.txt -direct=1 -iodepth 1 -thread -rw=randrw -ioengine=psync -bs=16k -size=500M -numjobs=10 -runtime=10 -group_reporting -name=mytest 
mytest: (g=0): rw=randrw, bs=16K-16K/16K-16K/16K-16K, ioengine=psync, iodepth=1
...
fio-2.1.10
Starting 10 threads
mytest: Laying out IO file(s) (1 file(s) / 500MB)
Jobs: 10 (f=10): [mmmmmmmmmm] [100.0% done] [14288KB/16320KB/0KB /s] [893/1020/0 iops] [eta 00m:00s]
mytest: (groupid=0, jobs=10): err= 0: pid=19368: Sat Oct 12 16:58:49 2019
  read : io=149872KB, bw=14978KB/s, iops=936, runt= 10006msec
    clat (usec): min=567, max=141398, avg=5199.14, stdev=7530.89
     lat (usec): min=567, max=141398, avg=5199.41, stdev=7530.89
    clat percentiles (usec):
     |  1.00th=[  628],  5.00th=[  668], 10.00th=[  716], 20.00th=[  788],
     | 30.00th=[  868], 40.00th=[ 1012], 50.00th=[ 2896], 60.00th=[ 4576],
     | 70.00th=[ 6176], 80.00th=[ 8096], 90.00th=[11456], 95.00th=[16320],
     | 99.00th=[36608], 99.50th=[46336], 99.90th=[67072], 99.95th=[102912],
     | 99.99th=[142336]
    bw (KB  /s): min=  180, max= 2923, per=10.07%, avg=1509.00, stdev=523.75
  write: io=142240KB, bw=14215KB/s, iops=888, runt= 10006msec
    clat (usec): min=530, max=173598, avg=5767.95, stdev=8750.02
     lat (usec): min=530, max=173599, avg=5768.63, stdev=8750.06
    clat percentiles (usec):
     |  1.00th=[  580],  5.00th=[  620], 10.00th=[  636], 20.00th=[  676],
     | 30.00th=[  732], 40.00th=[ 1368], 50.00th=[ 3760], 60.00th=[ 5344],
     | 70.00th=[ 6816], 80.00th=[ 8768], 90.00th=[12352], 95.00th=[17536],
     | 99.00th=[39168], 99.50th=[49920], 99.90th=[119296], 99.95th=[129536],
     | 99.99th=[173056]
    bw (KB  /s): min=  181, max= 2322, per=9.99%, avg=1419.48, stdev=434.91
    lat (usec) : 750=23.04%, 1000=15.57%
    lat (msec) : 2=6.15%, 4=8.85%, 10=32.13%, 20=10.47%, 50=3.38%
    lat (msec) : 100=0.33%, 250=0.09%
  cpu          : usr=0.14%, sys=0.69%, ctx=35221, majf=0, minf=7
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued    : total=r=9367/w=8890/d=0, short=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
   READ: io=149872KB, aggrb=14978KB/s, minb=14978KB/s, maxb=14978KB/s, mint=10006msec, maxt=10006msec
  WRITE: io=142240KB, aggrb=14215KB/s, minb=14215KB/s, maxb=14215KB/s, mint=10006msec, maxt=10006msec

Disk stats (read/write):
  vdb: ios=9299/8925, merge=0/108, ticks=9204/9559, in_queue=18763, util=97.16%

 

第三次测试
shell> fio -filename=/mydata/fio.txt -direct=1 -iodepth 1 -thread -rw=randrw -ioengine=psync -bs=16k -size=500M -numjobs=10 -runtime=10 -group_reporting -name=mytest 
mytest: (g=0): rw=randrw, bs=16K-16K/16K-16K/16K-16K, ioengine=psync, iodepth=1
...
fio-2.1.10
Starting 10 threads
mytest: Laying out IO file(s) (1 file(s) / 500MB)
Jobs: 10 (f=10): [mmmmmmmmmm] [100.0% done] [8640KB/9728KB/0KB /s] [540/608/0 iops] [eta 00m:00s]   
mytest: (groupid=0, jobs=10): err= 0: pid=19938: Sat Oct 12 17:00:52 2019
  read : io=132496KB, bw=13240KB/s, iops=827, runt= 10007msec
    clat (usec): min=554, max=179229, avg=5958.10, stdev=9806.11
     lat (usec): min=554, max=179229, avg=5958.36, stdev=9806.11
    clat percentiles (usec):
     |  1.00th=[  628],  5.00th=[  684], 10.00th=[  740], 20.00th=[  836],
     | 30.00th=[  924], 40.00th=[ 1080], 50.00th=[ 2896], 60.00th=[ 5024],
     | 70.00th=[ 6944], 80.00th=[ 9280], 90.00th=[13120], 95.00th=[18560],
     | 99.00th=[40192], 99.50th=[64256], 99.90th=[118272], 99.95th=[144384],
     | 99.99th=[179200]
    bw (KB  /s): min=  153, max= 2304, per=10.26%, avg=1358.13, stdev=554.24
  write: io=122048KB, bw=12196KB/s, iops=762, runt= 10007msec
    clat (usec): min=542, max=204946, avg=6641.64, stdev=10722.14
     lat (usec): min=543, max=204947, avg=6642.27, stdev=10722.16
    clat percentiles (usec):
     |  1.00th=[  604],  5.00th=[  644], 10.00th=[  668], 20.00th=[  716],
     | 30.00th=[  780], 40.00th=[ 1336], 50.00th=[ 3760], 60.00th=[ 5664],
     | 70.00th=[ 7584], 80.00th=[ 9792], 90.00th=[14656], 95.00th=[22144],
     | 99.00th=[49920], 99.50th=[66048], 99.90th=[121344], 99.95th=[158720],
     | 99.99th=[205824]
    bw (KB  /s): min=  152, max= 1912, per=10.19%, avg=1242.69, stdev=458.64
    lat (usec) : 750=17.65%, 1000=19.27%
    lat (msec) : 2=7.93%, 4=8.45%, 10=28.27%, 20=13.27%, 50=4.34%
    lat (msec) : 100=0.63%, 250=0.19%
  cpu          : usr=0.11%, sys=0.58%, ctx=30840, majf=0, minf=9
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued    : total=r=8281/w=7628/d=0, short=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
   READ: io=132496KB, aggrb=13240KB/s, minb=13240KB/s, maxb=13240KB/s, mint=10007msec, maxt=10007msec
  WRITE: io=122048KB, aggrb=12196KB/s, minb=12196KB/s, maxb=12196KB/s, mint=10007msec, maxt=10007msec

Disk stats (read/write):
  vdb: ios=8224/7872, merge=0/172, ticks=9026/10308, in_queue=19378, util=97.87%

  
第四次测试  
shell> fio -filename=/mydata/fio.txt -direct=1 -iodepth 1 -thread -rw=randrw -ioengine=psync -bs=16k -size=500M -numjobs=10 -runtime=10 -group_reporting -name=mytest 
mytest: (g=0): rw=randrw, bs=16K-16K/16K-16K/16K-16K, ioengine=psync, iodepth=1
...
fio-2.1.10
Starting 10 threads
mytest: Laying out IO file(s) (1 file(s) / 500MB)
Jobs: 10 (f=10): [mmmmmmmmmm] [100.0% done] [10000KB/12064KB/0KB /s] [625/754/0 iops] [eta 00m:00s] 
mytest: (groupid=0, jobs=10): err= 0: pid=21603: Sat Oct 12 17:06:36 2019
  read : io=126352KB, bw=12630KB/s, iops=789, runt= 10004msec
    clat (usec): min=610, max=167686, avg=6268.02, stdev=10402.54
     lat (usec): min=610, max=167687, avg=6268.27, stdev=10402.55
    clat percentiles (usec):
     |  1.00th=[  652],  5.00th=[  692], 10.00th=[  740], 20.00th=[  804],
     | 30.00th=[  876], 40.00th=[ 1032], 50.00th=[ 2800], 60.00th=[ 4832],
     | 70.00th=[ 6752], 80.00th=[ 9280], 90.00th=[14400], 95.00th=[21632],
     | 99.00th=[50944], 99.50th=[62720], 99.90th=[116224], 99.95th=[122368],
     | 99.99th=[166912]
    bw (KB  /s): min=  187, max= 2517, per=10.10%, avg=1275.14, stdev=576.46
  write: io=114960KB, bw=11491KB/s, iops=718, runt= 10004msec
    clat (usec): min=546, max=176011, avg=7016.87, stdev=11440.31
     lat (usec): min=546, max=176011, avg=7017.47, stdev=11440.32
    clat percentiles (usec):
     |  1.00th=[  588],  5.00th=[  620], 10.00th=[  644], 20.00th=[  684],
     | 30.00th=[  740], 40.00th=[ 1240], 50.00th=[ 3632], 60.00th=[ 5600],
     | 70.00th=[ 7648], 80.00th=[10304], 90.00th=[15552], 95.00th=[23936],
     | 99.00th=[59136], 99.50th=[77312], 99.90th=[110080], 99.95th=[121344],
     | 99.99th=[175104]
    bw (KB  /s): min=  223, max= 1888, per=10.02%, avg=1150.94, stdev=453.71
    lat (usec) : 750=21.09%, 1000=17.27%
    lat (msec) : 2=7.09%, 4=8.33%, 10=26.65%, 20=13.51%, 50=4.78%
    lat (msec) : 100=1.10%, 250=0.19%
  cpu          : usr=0.10%, sys=0.54%, ctx=29172, majf=0, minf=7
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued    : total=r=7897/w=7185/d=0, short=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
   READ: io=126352KB, aggrb=12630KB/s, minb=12630KB/s, maxb=12630KB/s, mint=10004msec, maxt=10004msec
  WRITE: io=114960KB, aggrb=11491KB/s, minb=11491KB/s, maxb=11491KB/s, mint=10004msec, maxt=10004msec

Disk stats (read/write):
  vdb: ios=7737/7102, merge=0/96, ticks=8645/9691, in_queue=18335, util=98.07%
  
  
第五次测试
shell> fio -filename=/mydata/fio.txt -direct=1 -iodepth 1 -thread -rw=randrw -ioengine=psync -bs=16k -size=500M -numjobs=10 -runtime=10 -group_reporting -name=mytest 
mytest: (g=0): rw=randrw, bs=16K-16K/16K-16K/16K-16K, ioengine=psync, iodepth=1
...
fio-2.1.10
Starting 10 threads
mytest: Laying out IO file(s) (1 file(s) / 500MB)
Jobs: 10 (f=10): [mmmmmmmmmm] [100.0% done] [13008KB/10864KB/0KB /s] [813/679/0 iops] [eta 00m:00s]
mytest: (groupid=0, jobs=10): err= 0: pid=22171: Sat Oct 12 17:08:49 2019
  read : io=111552KB, bw=11136KB/s, iops=696, runt= 10017msec
    clat (usec): min=607, max=172158, avg=6731.37, stdev=11383.31
     lat (usec): min=608, max=172158, avg=6731.63, stdev=11383.32
    clat percentiles (usec):
     |  1.00th=[  684],  5.00th=[  748], 10.00th=[  788], 20.00th=[  852],
     | 30.00th=[  932], 40.00th=[ 1048], 50.00th=[ 2640], 60.00th=[ 4768],
     | 70.00th=[ 6880], 80.00th=[10048], 90.00th=[15808], 95.00th=[23168],
     | 99.00th=[55040], 99.50th=[74240], 99.90th=[123392], 99.95th=[152576],
     | 99.99th=[173056]
    bw (KB  /s): min=  123, max= 2272, per=9.99%, avg=1112.15, stdev=480.68
  write: io=100000KB, bw=9983.3KB/s, iops=623, runt= 10017msec
    clat (usec): min=545, max=210656, avg=8497.88, stdev=15190.52
     lat (usec): min=546, max=210656, avg=8498.51, stdev=15190.55
    clat percentiles (usec):
     |  1.00th=[  596],  5.00th=[  644], 10.00th=[  676], 20.00th=[  724],
     | 30.00th=[  796], 40.00th=[ 1704], 50.00th=[ 4192], 60.00th=[ 6304],
     | 70.00th=[ 8640], 80.00th=[12096], 90.00th=[18560], 95.00th=[29568],
     | 99.00th=[77312], 99.50th=[105984], 99.90th=[171008], 99.95th=[193536],
     | 99.99th=[209920]
    bw (KB  /s): min=  123, max= 1880, per=9.95%, avg=992.89, stdev=382.53
    lat (usec) : 750=14.44%, 1000=21.88%
    lat (msec) : 2=8.07%, 4=8.19%, 10=24.92%, 20=14.82%, 50=5.84%
    lat (msec) : 100=1.45%, 250=0.39%
  cpu          : usr=0.08%, sys=0.49%, ctx=25645, majf=0, minf=7
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued    : total=r=6972/w=6250/d=0, short=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
   READ: io=111552KB, aggrb=11136KB/s, minb=11136KB/s, maxb=11136KB/s, mint=10017msec, maxt=10017msec
  WRITE: io=100000KB, aggrb=9983KB/s, minb=9983KB/s, maxb=9983KB/s, mint=10017msec, maxt=10017msec

Disk stats (read/write):
  vdb: ios=6781/6284, merge=0/105, ticks=7368/11194, in_queue=18561, util=98.07%
	
	
	
计算多次测试的平均IOPS 
	方式:
		去除最高/低的IOPS:   第二次测试和第五次测试
		取中间3次测试取平均值:
			读IOPS: select (774+827+789) /3 = 797
			写IOPS: select (702+762+718) /3 = 727
			select 797+727 = 1524
			
	第一次测试：  
		read : io=123968KB, bw=12392KB/s, iops=774, runt= 10004msec
		write: io=112368KB, bw=11232KB/s, iops=702, runt= 10004msec
		IOPS读为 774
		IOPS写为 702
	第二次测试：	
		read : io=149872KB, bw=14978KB/s, iops=936, runt= 10006msec	
		write: io=142240KB, bw=14215KB/s, iops=888, runt= 10006msec 
		IOPS读为 936
		IOPS写为 888
	第三次测试：
		read : io=132496KB, bw=13240KB/s, iops=827, runt= 10007msec
		write: io=122048KB, bw=12196KB/s, iops=762, runt= 10007msec
		IOPS读为 827
		IOPS写为 762

	第四次测试
		read : io=126352KB, bw=12630KB/s, iops=789, runt= 10004msec
		write: io=114960KB, bw=11491KB/s, iops=718, runt= 10004msec
		IOPS读为 789
		IOPS写为 718
		
	第五次测试
		read : io=111552KB, bw=11136KB/s, iops=696, runt= 10017msec
		write: io=100000KB, bw=9983.3KB/s, iops=623, runt= 10017msec
		IOPS读为 696
		IOPS写为 623
	 