
1. iostat 是什么
2. 命令格式
3. 命令功能
4. 命令参数
5. cpu属性值说明
6. disk属性值说明
7. 样例分析1
8. 样例分析2
9. 小结和相关参考


1. iostat 是什么

	iostat是I/O statistics（输入/输出统计）的缩写，用来动态监视系统的磁盘操作活动。

2. 命令格式

	iostat[参数][时间][次数]

3. 命令功能

	通过iostat方便查看CPU、网卡、tty设备、磁盘、CD-ROM 等等设备的活动情况, 负载信息。
	
	监控CPU和磁盘IO的使用情况。
	
4. 命令参数

	-C 显示CPU使用情况
	-d 显示磁盘使用情况
	-k 以 KB 为单位显示
	-m 以 M 为单位显示
	-N 显示磁盘阵列(LVM) 信息
	-n 显示NFS 使用情况
	-p[磁盘] 显示磁盘和分区的情况
	-t 显示终端和CPU的信息
	-x 显示详细信息
	-V 显示版本信息

5. cpu属性值说明

	shell> iostat
	Linux 3.10.0-693.21.1.el7.x86_64 (db-a) 	09/25/2019 	_x86_64_	(4 CPU)

	avg-cpu:  %user   %nice %system %iowait  %steal   %idle
			   0.14    0.00    0.07    0.08    0.00   99.70

	Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
	sda               0.27         1.77         6.59   79045332  293522080
	sdb              15.76         1.12       269.82   49744140 12021937088

	cpu属性值说明：
		%user：   CPU处在用户模式下的时间百分比。
		%nice：   CPU处在带NICE值的用户模式下的时间百分比。
		%system： CPU处在系统模式下的时间百分比。
		%iowait： CPU等待输入输出完成时间的百分比。
		%steal：  管理程序维护另一个虚拟处理器时，虚拟CPU的无意识等待时间百分比。
		%idle：   CPU空闲时间百分比。

	如果%iowait的值过高，表示硬盘存在I/O瓶颈
	%idle值高，表示CPU较空闲
	如果%idle值高但系统响应慢时，有可能是CPU等待分配内存，此时应加大内存容量。
	%idle值如果持续低于10，那么系统的CPU处理能力相对较低，表明系统中最需要解决的资源是CPU。
	
	结合 zabbix 监控中CPU utiliztion项的 CPU idle time 和 CPU iowait time 指标来做分析。

6. disk属性值说明

	shell> iostat -dmx 1
	Linux 3.10.0-693.21.1.el7.x86_64 (db-a) 	09/25/2019 	_x86_64_	(4 CPU)

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     0.03    0.02    0.25     0.00     0.01    61.45     0.00   15.02   43.68   12.88   0.73   0.02
	sdb               0.00     0.02    0.01   15.75     0.00     0.26    34.37     0.02    1.01    6.90    1.00   0.47   0.74

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     0.00    8.00    0.00     0.05     0.00    12.00     0.04    6.75    6.75    0.00   2.62   2.10
	sdb               0.00     0.00    0.00  381.00     0.00    48.01   258.06    10.73   28.15    0.00   28.15   2.52  95.90

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	sdb               0.00     0.00    0.00  361.00     0.00    48.12   273.00    19.18   52.74    0.00   52.74   2.69  97.00

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	sdb               0.00     0.00    0.00  397.00     0.00    47.84   246.77     6.15   15.66    0.00   15.66   2.35  93.30

	disk属性值说明：
	
		rrqm/s: 每秒进行 merge 的读操作数目。即 rmerge/s
		wrqm/s: 每秒进行 merge 的写操作数目。即 wmerge/s
		r/s: 每秒完成的读 I/O 设备次数。即 rio/s
		w/s: 每秒完成的写 I/O 设备次数。即 wio/s
		rMB/s：每秒读取多少MB的数据
		wMB/s：每秒写入多少MB的数据
	
			rsec/s: 每秒读扇区数。即 rsect/s
			wsec/s: 每秒写扇区数。即 wsect/s
			rkB/s: 每秒读K字节数。是 rsect/s 的一半，因为每扇区大小为512字节。
			wkB/s: 每秒写K字节数。是 wsect/s 的一半。
		
		avgrq-sz: 平均每次设备I/O操作的数据大小 (扇区)。
		avgqu-sz: 平均I/O队列长度。
		
		await: 平均每次设备I/O操作的等待时间 (毫秒)。
		
		r_await: 平均每次读设备I/O操作的等待时间 (毫秒)。
		w_await：平均每次写设备I/O操作的等待时间 (毫秒)。
		
		svctm: 平均每次设备I/O操作的服务时间 (毫秒)。
		%util: 一秒中有百分之多少的时间用于 I/O 操作，即被io消耗的cpu百分比


	如果 %util 接近 100%，说明产生的I/O请求太多，I/O系统已经满负荷，该磁盘可能存在瓶颈。
	如果 svctm 比较接近 await，说明 I/O 几乎没有等待时间；
	如果 await 远大于 svctm，说明I/O 队列太长，io响应太慢，则需要进行必要优化。
	如果 avgqu-sz 比较大，也表示有大量io在等待。


7. 样例分析1

	shell> iostat -dmx 1
	Linux 3.10.0-693.21.1.el7.x86_64 (db-a) 	09/25/2019 	_x86_64_	(4 CPU)

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     0.03    0.02    0.25     0.00     0.01    61.45     0.00   15.02   43.68   12.88   0.73   0.02
	sdb               0.00     0.02    0.01   15.75     0.00     0.26    34.37     0.02    1.01    6.90    1.00   0.47   0.74

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     0.00    8.00    0.00     0.05     0.00    12.00     0.04    6.75    6.75    0.00   2.62   2.10
	sdb               0.00     0.00    0.00  381.00     0.00    48.01   258.06    10.73   28.15    0.00   28.15   2.52  95.90

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	sdb               0.00     0.00    0.00  361.00     0.00    48.12   273.00    19.18   52.74    0.00   52.74   2.69  97.00

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	sdb               0.00     0.00    0.00  397.00     0.00    47.84   246.77     6.15   15.66    0.00   15.66   2.35  93.30

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	sdb               0.00     0.00    0.00  340.00     0.00    48.12   289.88    12.88   36.04    0.00   36.04   2.82  95.80

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	sdb               0.00     0.00    0.00  371.00     0.00    47.89   264.35     7.56   22.14    0.00   22.14   2.57  95.50


	shell> iostat
	Linux 3.10.0-693.21.1.el7.x86_64 (db-a) 	09/25/2019 	_x86_64_	(4 CPU)

	avg-cpu:  %user   %nice %system %iowait  %steal   %idle
			   0.14    0.00    0.07    0.08    0.00   99.70

	Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
	sda               0.27         1.77         6.59   79045332  293522080
	sdb              15.76         1.12       269.82   49744140 12021937088

	
	

8. 样例分析2

	shell> iostat 1
	Linux 3.10.0-514.el7.x86_64 (localhost.localdomain) 	2020年06月04日 	_x86_64_	(4 CPU)

	avg-cpu:  %user   %nice %system %iowait  %steal   %idle
			   0.70    0.00    0.28    0.15    0.00   98.87

	Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
	sda               5.08        51.07       435.34   60634533  516904920
	dm-0              0.10         0.57         3.72     674032    4418312
	dm-1              0.11         0.13         0.32     157108     378276
	dm-2              7.14        50.34       431.30   59772804  512105992

	avg-cpu:  %user   %nice %system %iowait  %steal   %idle
			   2.25    0.00    0.25    0.00    0.00   97.50

	Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
	sda              70.00         0.00       468.00          0        468
	dm-0              1.00         0.00        16.00          0         16
	dm-1              0.00         0.00         0.00          0          0
	dm-2             51.00         0.00       452.00          0        452

	avg-cpu:  %user   %nice %system %iowait  %steal   %idle
			   1.25    0.00    0.25    0.25    0.00   98.25

	Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
	sda              82.00         0.00       480.00          0        480
	dm-0              0.00         0.00         0.00          0          0
	dm-1              0.00         0.00         0.00          0          0
	dm-2             59.00         0.00       476.00          0        476

	avg-cpu:  %user   %nice %system %iowait  %steal   %idle
			   1.50    0.00    0.50    0.00    0.00   97.99

	Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
	sda              82.00         0.00       476.00          0        476
	dm-0              0.00         0.00         0.00          0          0
	dm-1              0.00         0.00         0.00          0          0
	dm-2             61.00         0.00       480.00          0        480

	avg-cpu:  %user   %nice %system %iowait  %steal   %idle
			   1.75    0.00    0.25    1.75    0.00   96.24

	Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
	sda              89.00         0.00       528.00          0        528
	dm-0              0.00         0.00         0.00          0          0
	dm-1              0.00         0.00         0.00          0          0
	dm-2             64.00         0.00       528.00          0        528

	avg-cpu:  %user   %nice %system %iowait  %steal   %idle
			   1.00    0.00    0.25    0.00    0.00   98.75

	Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
	sda              82.00         0.00       460.00          0        460
	dm-0              0.00         0.00         0.00          0          0
	dm-1              0.00         0.00         0.00          0          0
	dm-2             62.00         0.00       460.00          0        460


	shell> iostat -dmx 1

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     0.00    0.00   76.00     0.00     0.48    12.95     1.08   14.61    0.00   14.61  13.11  99.60
	dm-0              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	dm-2              0.00     0.00    0.00   54.00     0.00     0.48    18.07     1.09   20.57    0.00   20.57  18.46  99.70

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     0.00    0.00   76.00     0.00     0.54    14.63     1.01   13.26    0.00   13.26  13.13  99.80
	dm-0              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	dm-2              0.00     0.00    0.00   56.00     0.00     0.55    20.00     1.02   18.02    0.00   18.02  17.84  99.90

	.........................................................................................................................

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     0.00    0.00   81.00     0.00     0.49    12.44     1.00   12.22    0.00   12.22  12.27  99.40
	dm-0              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	dm-2              0.00     0.00    0.00   59.00     0.00     0.49    16.95     1.00   16.78    0.00   16.78  16.85  99.40


9. 小结和相关参考
	https://linuxtools-rst.readthedocs.io/zh_CN/latest/tool/iostat.html
	结合 zabbix 监控中CPU utiliztion项的 CPU idle time 和 CPU iowait time 来做分析。



