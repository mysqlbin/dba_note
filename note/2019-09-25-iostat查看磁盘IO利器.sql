

iostat -dmx 1
iostat 1



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


如果 %iowait 的值过高，表示硬盘存在I/O瓶颈。
如果 %util 接近 100%，说明产生的I/O请求太多，I/O系统已经满负荷，该磁盘可能存在瓶颈。
如果 svctm 比较接近 await，说明 I/O 几乎没有等待时间；
如果 await 远大于 svctm ，说明I/O 队列太长，io响应太慢，则需要进行必要优化。
如果 avgqu-sz 比较大，也表示有大量io在等待。

https://linuxtools-rst.readthedocs.io/zh_CN/latest/tool/iostat.html


[root@localhost logs]# iostat 1
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


如果 %iowait 的值过高，表示硬盘存在I/O瓶颈。
如果 %util 接近 100%，说明产生的I/O请求太多，I/O系统已经满负荷，该磁盘可能存在瓶颈。
如果 svctm 比较接近 await，说明 I/O 几乎没有等待时间；
如果 await 远大于 svctm ，说明I/O 队列太长，io响应太慢，则需要进行必要优化。
如果 avgqu-sz 比较大，也表示有大量io在等待。


[root@localhost logs]# iostat -dmx 1

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

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sda               0.00     0.00    0.00   75.00     0.00     0.45    12.16     1.00   13.32    0.00   13.32  13.29  99.70
dm-0              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
dm-2              0.00     0.00    0.00   55.00     0.00     0.45    16.58     1.00   18.16    0.00   18.16  18.13  99.70

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sda               0.00     1.00    3.00   75.00     0.01     0.45    12.10     1.09   13.45   19.00   13.23  12.73  99.30
dm-0              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
dm-1              0.00     0.00    3.00    0.00     0.01     0.00     8.00     0.06   19.00   19.00    0.00   6.33   1.90
dm-2              0.00     0.00    0.00   57.00     0.00     0.45    16.28     1.04   17.42    0.00   17.42  17.44  99.40

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sda               0.00     1.00    0.00   73.00     0.00     0.38    10.74     1.21   16.32    0.00   16.32  13.66  99.70
dm-0              0.00     0.00    0.00    3.00     0.00     0.01     8.00     0.14   47.00    0.00   47.00  41.67  12.50
dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
dm-2              0.00     0.00    0.00   50.00     0.00     0.37    15.20     1.08   21.32    0.00   21.32  19.94  99.70

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sda               0.00     0.00    0.00   80.00     0.00     0.47    12.00     1.04   13.57    0.00   13.57  12.45  99.60
dm-0              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
dm-2              0.00     0.00    0.00   57.00     0.00     0.46    16.70     1.04   19.05    0.00   19.05  17.47  99.60

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sda               0.00     0.00    0.00   81.00     0.00     0.49    12.44     1.00   12.22    0.00   12.22  12.27  99.40
dm-0              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
dm-2              0.00     0.00    0.00   59.00     0.00     0.49    16.95     1.00   16.78    0.00   16.78  16.85  99.40

