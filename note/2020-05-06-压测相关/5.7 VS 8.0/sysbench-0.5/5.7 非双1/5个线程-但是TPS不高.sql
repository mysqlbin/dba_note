








[coding001@voice sysbench]$ top
top - 15:47:30 up 95 days, 45 min,  4 users,  load average: 3.88, 4.44, 4.10
Tasks: 124 total,   2 running, 122 sleeping,   0 stopped,   0 zombie
%Cpu0  : 59.7 us, 20.8 sy,  0.0 ni, 13.0 id,  1.3 wa,  0.0 hi,  5.2 si,  0.0 st
%Cpu1  : 62.3 us, 15.6 sy,  0.0 ni, 10.4 id,  6.5 wa,  0.0 hi,  5.2 si,  0.0 st
%Cpu2  : 58.8 us, 20.0 sy,  0.0 ni, 12.5 id,  3.8 wa,  0.0 hi,  5.0 si,  0.0 st
%Cpu3  : 62.0 us, 19.0 sy,  0.0 ni, 12.7 id,  2.5 wa,  0.0 hi,  3.8 si,  0.0 st
KiB Mem : 16266300 total,   159336 free, 10031532 used,  6075432 buff/cache
KiB Swap:        0 total,        0 free,        0 used.  5140604 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                                                                                                                   
 6404 mysql     20   0   11.4g   9.0g   3492 S 278.2 58.1 482:05.90 mysqld                                                                                                                                                                    
23871 coding0+  20   0  363692   4052   1236 S  60.3  0.0  15:27.54 sysbench   






[coding001@voice sysbench]$ iostat -dmx 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/19/2021 	_x86_64_	(4 CPU)

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00    61.45     0.00    1.21    1.21    0.00   0.88   0.00
sda               0.00     0.12    2.10    4.43     0.14     0.21   108.85     0.07   10.70   23.99    4.40   0.65   0.42

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  344.00     0.00    31.51   187.58     0.71    2.07    0.00    2.07   0.74  25.40

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  334.00     0.00    29.45   180.57     0.56    1.67    0.00    1.67   0.64  21.50

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  350.00     0.00    31.47   184.16     0.55    1.56    0.00    1.56   0.58  20.40

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  319.00     0.00    29.51   189.47     0.51    1.60    0.00    1.60   0.62  19.90

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  335.00     0.00    31.54   192.81     0.56    1.68    0.00    1.68   0.59  19.80

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sdb               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
sda               0.00     0.00    0.00  325.00     0.00    29.23   184.22     0.43    1.34    0.00    1.34   0.55  17.90

^C
[coding001@voice sysbench]$ iostat 1
Linux 3.10.0-1160.31.1.el7.x86_64 (voice) 	10/19/2021 	_x86_64_	(4 CPU)

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
           0.50    0.00    0.66    0.18    0.00   98.66

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00       4148          0
sda               6.52       144.22       210.87 1184163138 1731346344

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          63.89    0.00   22.22    2.53    0.00   11.36

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda             313.00         0.00     31044.00          0      31044

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          62.69    0.00   22.84    2.79    0.00   11.68

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda             308.00         0.00     29736.00          0      29736

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          60.71    0.00   22.42    3.53    0.00   13.35

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda             376.00         0.00     34420.00          0      34420

avg-cpu:  %user   %nice %system %iowait  %steal   %idle
          62.16    0.00   23.06    2.76    0.00   12.03

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdb               0.00         0.00         0.00          0          0
sda             336.00         0.00     29608.00          0      29608


[coding001@voice ~]$ tail -f  /home/coding001/log/sysbench_oltpX_5_not11.log
Number of threads: 5
Report intermediate results every 10 second(s)
Random number generator seed is 0 and will be ignored


Initializing worker threads...

Threads started!

[  10s] threads: 5, tps: 473.89, reads: 6639.59, writes: 1895.77, response time: 39.18ms (99%), errors: 0.00, reconnects:  0.00
[  20s] threads: 5, tps: 406.87, reads: 5694.75, writes: 1627.27, response time: 46.92ms (99%), errors: 0.00, reconnects:  0.00
[  30s] threads: 5, tps: 400.30, reads: 5605.95, writes: 1601.61, response time: 46.39ms (99%), errors: 0.00, reconnects:  0.00
[  40s] threads: 5, tps: 405.70, reads: 5679.50, writes: 1622.50, response time: 42.02ms (99%), errors: 0.00, reconnects:  0.00
[  50s] threads: 5, tps: 411.93, reads: 5766.44, writes: 1647.73, response time: 41.66ms (99%), errors: 0.00, reconnects:  0.00
[  60s] threads: 5, tps: 413.70, reads: 5791.90, writes: 1654.90, response time: 41.44ms (99%), errors: 0.00, reconnects:  0.00
[  70s] threads: 5, tps: 350.30, reads: 4903.39, writes: 1401.00, response time: 49.52ms (99%), errors: 0.00, reconnects:  0.00
[  80s] threads: 5, tps: 289.99, reads: 4061.63, writes: 1160.35, response time: 78.73ms (99%), errors: 0.00, reconnects:  0.00
[  90s] threads: 5, tps: 290.51, reads: 4064.38, writes: 1161.65, response time: 81.78ms (99%), errors: 0.00, reconnects:  0.00
[ 100s] threads: 5, tps: 295.30, reads: 4135.07, writes: 1181.19, response time: 79.37ms (99%), errors: 0.00, reconnects:  0.00
[ 110s] threads: 5, tps: 363.60, reads: 5090.72, writes: 1454.41, response time: 53.87ms (99%), errors: 0.00, reconnects:  0.00
[ 120s] threads: 5, tps: 439.30, reads: 6151.20, writes: 1757.20, response time: 40.86ms (99%), errors: 0.00, reconnects:  0.00
[ 130s] threads: 5, tps: 476.79, reads: 6675.60, writes: 1907.44, response time: 30.76ms (99%), errors: 0.00, reconnects:  0.00
[ 140s] threads: 5, tps: 484.31, reads: 6780.38, writes: 1937.15, response time: 29.86ms (99%), errors: 0.00, reconnects:  0.00
[ 150s] threads: 5, tps: 486.30, reads: 6807.22, writes: 1945.30, response time: 29.97ms (99%), errors: 0.00, reconnects:  0.00
[ 160s] threads: 5, tps: 496.10, reads: 6945.99, writes: 1984.60, response time: 29.27ms (99%), errors: 0.00, reconnects:  0.00
[ 170s] threads: 5, tps: 504.00, reads: 7054.40, writes: 2015.50, response time: 28.60ms (99%), errors: 0.00, reconnects:  0.00
[ 180s] threads: 5, tps: 502.70, reads: 7039.24, writes: 2011.01, response time: 28.59ms (99%), errors: 0.00, reconnects:  0.00
[ 190s] threads: 5, tps: 512.40, reads: 7172.77, writes: 2049.39, response time: 28.23ms (99%), errors: 0.00, reconnects:  0.00
[ 200s] threads: 5, tps: 513.37, reads: 7187.87, writes: 2053.68, response time: 28.28ms (99%), errors: 0.00, reconnects:  0.00
[ 210s] threads: 5, tps: 518.73, reads: 7260.04, writes: 2074.73, response time: 27.22ms (99%), errors: 0.00, reconnects:  0.00
[ 220s] threads: 5, tps: 522.20, reads: 7313.38, writes: 2089.19, response time: 27.38ms (99%), errors: 0.00, reconnects:  0.00
[ 230s] threads: 5, tps: 527.10, reads: 7377.43, writes: 2107.98, response time: 26.20ms (99%), errors: 0.00, reconnects:  0.00
[ 240s] threads: 5, tps: 525.41, reads: 7358.09, writes: 2102.43, response time: 26.31ms (99%), errors: 0.00, reconnects:  0.00
[ 250s] threads: 5, tps: 529.60, reads: 7413.60, writes: 2117.90, response time: 27.25ms (99%), errors: 0.00, reconnects:  0.00
[ 260s] threads: 5, tps: 529.87, reads: 7416.64, writes: 2119.17, response time: 27.04ms (99%), errors: 0.00, reconnects:  0.00
[ 270s] threads: 5, tps: 535.63, reads: 7499.80, writes: 2142.51, response time: 26.26ms (99%), errors: 0.00, reconnects:  0.00
[ 280s] threads: 5, tps: 540.95, reads: 7573.88, writes: 2163.80, response time: 25.80ms (99%), errors: 0.00, reconnects:  0.00
[ 290s] threads: 5, tps: 547.95, reads: 7669.45, writes: 2191.79, response time: 25.25ms (99%), errors: 0.00, reconnects:  0.00
[ 300s] threads: 5, tps: 545.71, reads: 7642.07, writes: 2183.12, response time: 25.36ms (99%), errors: 0.00, reconnects:  0.00
[ 310s] threads: 5, tps: 554.71, reads: 7764.38, writes: 2218.52, response time: 24.48ms (99%), errors: 0.00, reconnects:  0.00
[ 320s] threads: 5, tps: 549.99, reads: 7701.82, writes: 2200.28, response time: 24.61ms (99%), errors: 0.00, reconnects:  0.00
[ 330s] threads: 5, tps: 532.61, reads: 7455.57, writes: 2130.32, response time: 26.34ms (99%), errors: 0.00, reconnects:  0.00
[ 340s] threads: 5, tps: 528.10, reads: 7392.70, writes: 2112.20, response time: 28.97ms (99%), errors: 0.00, reconnects:  0.00
[ 350s] threads: 5, tps: 543.19, reads: 7603.56, writes: 2172.76, response time: 27.28ms (99%), errors: 0.00, reconnects:  0.00
[ 360s] threads: 5, tps: 543.61, reads: 7612.63, writes: 2174.74, response time: 25.65ms (99%), errors: 0.00, reconnects:  0.00
[ 370s] threads: 5, tps: 545.99, reads: 7642.61, writes: 2183.67, response time: 24.04ms (99%), errors: 0.00, reconnects:  0.00
[ 380s] threads: 5, tps: 537.60, reads: 7528.55, writes: 2150.42, response time: 27.04ms (99%), errors: 0.00, reconnects:  0.00
[ 390s] threads: 5, tps: 522.78, reads: 7316.78, writes: 2091.11, response time: 27.22ms (99%), errors: 0.00, reconnects:  0.00
[ 400s] threads: 5, tps: 535.60, reads: 7499.80, writes: 2142.80, response time: 25.71ms (99%), errors: 0.00, reconnects:  0.00
[ 410s] threads: 5, tps: 539.99, reads: 7559.21, writes: 2159.57, response time: 25.89ms (99%), errors: 0.00, reconnects:  0.00
[ 420s] threads: 5, tps: 513.72, reads: 7193.52, writes: 2054.89, response time: 26.61ms (99%), errors: 0.00, reconnects:  0.00
[ 430s] threads: 5, tps: 449.10, reads: 6286.86, writes: 1796.72, response time: 32.25ms (99%), errors: 0.00, reconnects:  0.00
[ 440s] threads: 5, tps: 414.49, reads: 5802.53, writes: 1657.68, response time: 37.36ms (99%), errors: 0.00, reconnects:  0.00
[ 450s] threads: 5, tps: 393.70, reads: 5510.52, writes: 1574.81, response time: 36.82ms (99%), errors: 0.00, reconnects:  0.00
[ 460s] threads: 5, tps: 382.50, reads: 5356.20, writes: 1530.30, response time: 42.76ms (99%), errors: 0.00, reconnects:  0.00
[ 470s] threads: 5, tps: 371.50, reads: 5199.00, writes: 1486.00, response time: 41.48ms (99%), errors: 0.00, reconnects:  0.00
[ 480s] threads: 5, tps: 350.40, reads: 4907.56, writes: 1401.72, response time: 46.60ms (99%), errors: 0.00, reconnects:  0.00
[ 490s] threads: 5, tps: 356.30, reads: 4989.22, writes: 1424.80, response time: 43.38ms (99%), errors: 0.00, reconnects:  0.00
[ 500s] threads: 5, tps: 376.80, reads: 5272.04, writes: 1507.18, response time: 42.66ms (99%), errors: 0.00, reconnects:  0.00
[ 510s] threads: 5, tps: 359.30, reads: 5028.35, writes: 1437.22, response time: 42.42ms (99%), errors: 0.00, reconnects:  0.00
[ 520s] threads: 5, tps: 380.80, reads: 5333.58, writes: 1523.59, response time: 38.49ms (99%), errors: 0.00, reconnects:  0.00
[ 530s] threads: 5, tps: 378.28, reads: 5296.58, writes: 1513.04, response time: 37.11ms (99%), errors: 0.00, reconnects:  0.00
[ 540s] threads: 5, tps: 397.60, reads: 5568.86, writes: 1590.19, response time: 38.19ms (99%), errors: 0.00, reconnects:  0.00
[ 550s] threads: 5, tps: 406.72, reads: 5693.05, writes: 1627.17, response time: 34.10ms (99%), errors: 0.00, reconnects:  0.00
[ 560s] threads: 5, tps: 458.40, reads: 6416.03, writes: 1833.61, response time: 28.40ms (99%), errors: 0.00, reconnects:  0.00
[ 570s] threads: 5, tps: 482.48, reads: 6755.79, writes: 1929.51, response time: 26.05ms (99%), errors: 0.00, reconnects:  0.00
[ 580s] threads: 5, tps: 493.41, reads: 6907.90, writes: 1973.76, response time: 27.86ms (99%), errors: 0.00, reconnects:  0.00
[ 590s] threads: 5, tps: 492.61, reads: 6896.10, writes: 1971.13, response time: 29.75ms (99%), errors: 0.00, reconnects:  0.00
[ 600s] threads: 5, tps: 519.45, reads: 7272.40, writes: 2077.40, response time: 28.72ms (99%), errors: 0.00, reconnects:  0.00
[ 610s] threads: 5, tps: 348.01, reads: 4874.05, writes: 1391.84, response time: 49.94ms (99%), errors: 0.00, reconnects:  0.00
[ 620s] threads: 5, tps: 340.49, reads: 4765.70, writes: 1361.94, response time: 50.54ms (99%), errors: 0.00, reconnects:  0.00
[ 630s] threads: 5, tps: 378.28, reads: 5294.56, writes: 1512.93, response time: 43.56ms (99%), errors: 0.00, reconnects:  0.00
[ 640s] threads: 5, tps: 329.65, reads: 4615.17, writes: 1318.59, response time: 53.95ms (99%), errors: 0.00, reconnects:  0.00
[ 650s] threads: 5, tps: 378.50, reads: 5299.34, writes: 1514.01, response time: 40.67ms (99%), errors: 0.00, reconnects:  0.00
[ 660s] threads: 5, tps: 335.70, reads: 4699.91, writes: 1343.20, response time: 52.01ms (99%), errors: 0.00, reconnects:  0.00
[ 670s] threads: 5, tps: 433.50, reads: 6069.52, writes: 1733.91, response time: 36.32ms (99%), errors: 0.00, reconnects:  0.00
[ 680s] threads: 5, tps: 402.78, reads: 5637.44, writes: 1611.03, response time: 38.27ms (99%), errors: 0.00, reconnects:  0.00
[ 690s] threads: 5, tps: 414.22, reads: 5800.03, writes: 1656.67, response time: 40.79ms (99%), errors: 0.00, reconnects:  0.00
[ 700s] threads: 5, tps: 414.86, reads: 5806.98, writes: 1659.42, response time: 42.32ms (99%), errors: 0.00, reconnects:  0.00
[ 710s] threads: 5, tps: 457.74, reads: 6408.94, writes: 1830.95, response time: 33.03ms (99%), errors: 0.00, reconnects:  0.00
[ 720s] threads: 5, tps: 451.41, reads: 6320.59, writes: 1805.63, response time: 33.61ms (99%), errors: 0.00, reconnects:  0.00
[ 730s] threads: 5, tps: 413.80, reads: 5790.08, writes: 1655.19, response time: 37.46ms (99%), errors: 0.00, reconnects:  0.00
[ 740s] threads: 5, tps: 441.60, reads: 6185.05, writes: 1766.52, response time: 33.19ms (99%), errors: 0.00, reconnects:  0.00
[ 750s] threads: 5, tps: 435.70, reads: 6100.65, writes: 1743.22, response time: 34.83ms (99%), errors: 0.00, reconnects:  0.00
[ 760s] threads: 5, tps: 378.39, reads: 5295.34, writes: 1513.05, response time: 39.03ms (99%), errors: 0.00, reconnects:  0.00
[ 770s] threads: 5, tps: 424.51, reads: 5943.58, writes: 1698.15, response time: 34.00ms (99%), errors: 0.00, reconnects:  0.00
[ 780s] threads: 5, tps: 411.70, reads: 5765.22, writes: 1647.31, response time: 40.04ms (99%), errors: 0.00, reconnects:  0.00
[ 790s] threads: 5, tps: 380.30, reads: 5324.19, writes: 1520.70, response time: 43.51ms (99%), errors: 0.00, reconnects:  0.00
[ 800s] threads: 5, tps: 418.40, reads: 5855.95, writes: 1673.88, response time: 36.75ms (99%), errors: 0.00, reconnects:  0.00
[ 810s] threads: 5, tps: 456.29, reads: 6389.12, writes: 1825.05, response time: 33.10ms (99%), errors: 0.00, reconnects:  0.00
[ 820s] threads: 5, tps: 450.50, reads: 6307.65, writes: 1801.71, response time: 33.79ms (99%), errors: 0.00, reconnects:  0.00
[ 830s] threads: 5, tps: 452.51, reads: 6333.64, writes: 1810.04, response time: 33.90ms (99%), errors: 0.00, reconnects:  0.00
[ 840s] threads: 5, tps: 421.30, reads: 5898.65, writes: 1685.32, response time: 37.88ms (99%), errors: 0.00, reconnects:  0.00
[ 850s] threads: 5, tps: 413.80, reads: 5794.38, writes: 1655.20, response time: 37.90ms (99%), errors: 0.00, reconnects:  0.00
[ 860s] threads: 5, tps: 430.10, reads: 6020.41, writes: 1720.40, response time: 35.75ms (99%), errors: 0.00, reconnects:  0.00
[ 870s] threads: 5, tps: 430.70, reads: 6030.78, writes: 1722.99, response time: 36.95ms (99%), errors: 0.00, reconnects:  0.00
[ 880s] threads: 5, tps: 414.58, reads: 5803.74, writes: 1658.02, response time: 38.37ms (99%), errors: 0.00, reconnects:  0.00
[ 890s] threads: 5, tps: 427.62, reads: 5986.73, writes: 1710.77, response time: 36.68ms (99%), errors: 0.00, reconnects:  0.00
[ 900s] threads: 5, tps: 434.97, reads: 6090.49, writes: 1739.78, response time: 37.43ms (99%), errors: 0.00, reconnects:  0.00
[ 910s] threads: 5, tps: 464.94, reads: 6508.10, writes: 1860.04, response time: 33.40ms (99%), errors: 0.00, reconnects:  0.00
[ 920s] threads: 5, tps: 480.00, reads: 6716.52, writes: 1919.51, response time: 30.35ms (99%), errors: 0.00, reconnects:  0.00
[ 930s] threads: 5, tps: 463.10, reads: 6487.17, writes: 1852.39, response time: 32.76ms (99%), errors: 0.00, reconnects:  0.00
[ 940s] threads: 5, tps: 457.10, reads: 6398.16, writes: 1828.39, response time: 34.38ms (99%), errors: 0.00, reconnects:  0.00
[ 950s] threads: 5, tps: 477.81, reads: 6690.68, writes: 1911.22, response time: 32.32ms (99%), errors: 0.00, reconnects:  0.00
[ 960s] threads: 5, tps: 462.00, reads: 6466.77, writes: 1848.19, response time: 32.77ms (99%), errors: 0.00, reconnects:  0.00
[ 970s] threads: 5, tps: 451.90, reads: 6327.58, writes: 1807.79, response time: 38.33ms (99%), errors: 0.00, reconnects:  0.00
[ 980s] threads: 5, tps: 473.60, reads: 6629.47, writes: 1894.19, response time: 33.95ms (99%), errors: 0.00, reconnects:  0.00
[ 990s] threads: 5, tps: 450.80, reads: 6311.83, writes: 1803.41, response time: 36.95ms (99%), errors: 0.00, reconnects:  0.00
[1000s] threads: 5, tps: 461.60, reads: 6461.96, writes: 1845.99, response time: 33.06ms (99%), errors: 0.00, reconnects:  0.00
[1010s] threads: 5, tps: 486.20, reads: 6805.84, writes: 1945.01, response time: 32.15ms (99%), errors: 0.00, reconnects:  0.00
[1020s] threads: 5, tps: 485.90, reads: 6803.87, writes: 1943.99, response time: 31.12ms (99%), errors: 0.00, reconnects:  0.00
[1030s] threads: 5, tps: 512.00, reads: 7164.75, writes: 2047.71, response time: 29.15ms (99%), errors: 0.00, reconnects:  0.00
[1040s] threads: 5, tps: 504.99, reads: 7073.75, writes: 2019.76, response time: 29.39ms (99%), errors: 0.00, reconnects:  0.00
[1050s] threads: 5, tps: 510.99, reads: 7153.84, writes: 2044.05, response time: 29.61ms (99%), errors: 0.00, reconnects:  0.00
[1060s] threads: 5, tps: 505.42, reads: 7076.09, writes: 2021.48, response time: 30.63ms (99%), errors: 0.00, reconnects:  0.00
[1070s] threads: 5, tps: 496.89, reads: 6955.01, writes: 1987.57, response time: 31.13ms (99%), errors: 0.00, reconnects:  0.00
[1080s] threads: 5, tps: 489.40, reads: 6851.24, writes: 1957.71, response time: 30.09ms (99%), errors: 0.00, reconnects:  0.00
[1090s] threads: 5, tps: 488.60, reads: 6841.85, writes: 1954.29, response time: 30.62ms (99%), errors: 0.00, reconnects:  0.00
[1100s] threads: 5, tps: 472.85, reads: 6617.95, writes: 1891.39, response time: 32.81ms (99%), errors: 0.00, reconnects:  0.00
[1110s] threads: 5, tps: 458.56, reads: 6421.22, writes: 1834.24, response time: 32.65ms (99%), errors: 0.00, reconnects:  0.00
[1120s] threads: 5, tps: 482.10, reads: 6749.12, writes: 1929.11, response time: 31.09ms (99%), errors: 0.00, reconnects:  0.00
[1130s] threads: 5, tps: 493.50, reads: 6908.45, writes: 1973.29, response time: 32.31ms (99%), errors: 0.00, reconnects:  0.00
[1140s] threads: 5, tps: 475.40, reads: 6657.68, writes: 1901.69, response time: 32.86ms (99%), errors: 0.00, reconnects:  0.00
[1150s] threads: 5, tps: 496.10, reads: 6945.15, writes: 1985.01, response time: 30.78ms (99%), errors: 0.00, reconnects:  0.00
[1160s] threads: 5, tps: 503.00, reads: 7041.29, writes: 2011.40, response time: 29.19ms (99%), errors: 0.00, reconnects:  0.00
[1170s] threads: 5, tps: 498.50, reads: 6978.53, writes: 1993.91, response time: 30.33ms (99%), errors: 0.00, reconnects:  0.00
[1180s] threads: 5, tps: 481.89, reads: 6748.66, writes: 1927.56, response time: 32.86ms (99%), errors: 0.00, reconnects:  0.00
[1190s] threads: 5, tps: 489.17, reads: 6846.75, writes: 1956.67, response time: 32.18ms (99%), errors: 0.00, reconnects:  0.00
[1200s] threads: 5, tps: 489.34, reads: 6850.50, writes: 1957.37, response time: 31.84ms (99%), errors: 0.00, reconnects:  0.00
[1210s] threads: 5, tps: 491.99, reads: 6885.92, writes: 1967.98, response time: 30.64ms (99%), errors: 0.00, reconnects:  0.00
[1220s] threads: 5, tps: 485.39, reads: 6799.24, writes: 1942.05, response time: 31.85ms (99%), errors: 0.00, reconnects:  0.00
[1230s] threads: 5, tps: 493.12, reads: 6901.73, writes: 1972.06, response time: 30.64ms (99%), errors: 0.00, reconnects:  0.00
[1240s] threads: 5, tps: 486.00, reads: 6803.61, writes: 1943.90, response time: 31.48ms (99%), errors: 0.00, reconnects:  0.00
[1250s] threads: 5, tps: 499.56, reads: 6994.90, writes: 1998.56, response time: 29.98ms (99%), errors: 0.00, reconnects:  0.00
[1260s] threads: 5, tps: 496.03, reads: 6945.17, writes: 1984.13, response time: 29.65ms (99%), errors: 0.00, reconnects:  0.00
[1270s] threads: 5, tps: 491.36, reads: 6879.50, writes: 1965.26, response time: 32.27ms (99%), errors: 0.00, reconnects:  0.00
[1280s] threads: 5, tps: 486.63, reads: 6811.52, writes: 1946.52, response time: 33.35ms (99%), errors: 0.00, reconnects:  0.00
[1290s] threads: 5, tps: 448.81, reads: 6282.38, writes: 1795.12, response time: 37.73ms (99%), errors: 0.00, reconnects:  0.00
[1300s] threads: 5, tps: 479.50, reads: 6715.58, writes: 1918.19, response time: 33.94ms (99%), errors: 0.00, reconnects:  0.00
[1310s] threads: 5, tps: 496.30, reads: 6946.35, writes: 1984.99, response time: 29.48ms (99%), errors: 0.00, reconnects:  0.00
[1320s] threads: 5, tps: 465.31, reads: 6511.50, writes: 1861.23, response time: 33.97ms (99%), errors: 0.00, reconnects:  0.00
[1330s] threads: 5, tps: 490.99, reads: 6876.01, writes: 1964.07, response time: 29.67ms (99%), errors: 0.00, reconnects:  0.00
[1340s] threads: 5, tps: 477.20, reads: 6680.87, writes: 1909.12, response time: 32.26ms (99%), errors: 0.00, reconnects:  0.00
[1350s] threads: 5, tps: 500.79, reads: 7012.18, writes: 2002.77, response time: 29.41ms (99%), errors: 0.00, reconnects:  0.00
[1360s] threads: 5, tps: 507.21, reads: 7099.13, writes: 2028.84, response time: 28.47ms (99%), errors: 0.00, reconnects:  0.00
[1370s] threads: 5, tps: 496.70, reads: 6956.03, writes: 1987.38, response time: 29.07ms (99%), errors: 0.00, reconnects:  0.00
[1380s] threads: 5, tps: 490.90, reads: 6871.66, writes: 1963.39, response time: 29.78ms (99%), errors: 0.00, reconnects:  0.00
[1390s] threads: 5, tps: 494.80, reads: 6926.91, writes: 1978.80, response time: 30.36ms (99%), errors: 0.00, reconnects:  0.00
[1400s] threads: 5, tps: 483.01, reads: 6764.40, writes: 1933.43, response time: 31.21ms (99%), errors: 0.00, reconnects:  0.00
[1410s] threads: 5, tps: 476.10, reads: 6662.07, writes: 1903.29, response time: 31.58ms (99%), errors: 0.00, reconnects:  0.00
[1420s] threads: 5, tps: 460.40, reads: 6446.29, writes: 1841.40, response time: 34.28ms (99%), errors: 0.00, reconnects:  0.00
[1430s] threads: 5, tps: 474.40, reads: 6641.14, writes: 1897.81, response time: 32.49ms (99%), errors: 0.00, reconnects:  0.00
[1440s] threads: 5, tps: 469.90, reads: 6576.88, writes: 1879.29, response time: 32.71ms (99%), errors: 0.00, reconnects:  0.00
[1450s] threads: 5, tps: 479.80, reads: 6719.03, writes: 1919.18, response time: 31.25ms (99%), errors: 0.00, reconnects:  0.00
[1460s] threads: 5, tps: 490.40, reads: 6867.87, writes: 1961.62, response time: 30.33ms (99%), errors: 0.00, reconnects:  0.00
[1470s] threads: 5, tps: 482.50, reads: 6752.23, writes: 1930.21, response time: 30.42ms (99%), errors: 0.00, reconnects:  0.00
[1480s] threads: 5, tps: 486.20, reads: 6807.47, writes: 1944.59, response time: 30.43ms (99%), errors: 0.00, reconnects:  0.00
[1490s] threads: 5, tps: 483.20, reads: 6765.97, writes: 1932.89, response time: 31.10ms (99%), errors: 0.00, reconnects:  0.00
[1500s] threads: 5, tps: 468.49, reads: 6558.68, writes: 1873.97, response time: 31.67ms (99%), errors: 0.00, reconnects:  0.00
[1510s] threads: 5, tps: 497.11, reads: 6959.45, writes: 1989.14, response time: 29.21ms (99%), errors: 0.00, reconnects:  0.00
[1520s] threads: 5, tps: 478.66, reads: 6700.64, writes: 1914.24, response time: 30.25ms (99%), errors: 0.00, reconnects:  0.00
[1530s] threads: 5, tps: 468.24, reads: 6554.86, writes: 1872.96, response time: 32.32ms (99%), errors: 0.00, reconnects:  0.00
[1540s] threads: 5, tps: 446.80, reads: 6254.74, writes: 1787.08, response time: 34.15ms (99%), errors: 0.00, reconnects:  0.00
[1550s] threads: 5, tps: 447.70, reads: 6266.65, writes: 1790.49, response time: 36.25ms (99%), errors: 0.00, reconnects:  0.00
[1560s] threads: 5, tps: 461.60, reads: 6465.25, writes: 1846.61, response time: 34.94ms (99%), errors: 0.00, reconnects:  0.00
[1570s] threads: 5, tps: 482.31, reads: 6750.68, writes: 1929.02, response time: 31.31ms (99%), errors: 0.00, reconnects:  0.00
[1580s] threads: 5, tps: 484.88, reads: 6790.82, writes: 1939.82, response time: 30.67ms (99%), errors: 0.00, reconnects:  0.00
[1590s] threads: 5, tps: 476.32, reads: 6667.04, writes: 1904.97, response time: 32.04ms (99%), errors: 0.00, reconnects:  0.00
[1600s] threads: 5, tps: 462.20, reads: 6470.84, writes: 1849.11, response time: 35.84ms (99%), errors: 0.00, reconnects:  0.00
[1610s] threads: 5, tps: 477.86, reads: 6691.10, writes: 1911.13, response time: 34.38ms (99%), errors: 0.00, reconnects:  0.00
[1620s] threads: 5, tps: 486.63, reads: 6811.88, writes: 1946.71, response time: 31.39ms (99%), errors: 0.00, reconnects:  0.00
[1630s] threads: 5, tps: 481.22, reads: 6737.55, writes: 1924.67, response time: 32.20ms (99%), errors: 0.00, reconnects:  0.00
[1640s] threads: 5, tps: 482.99, reads: 6761.68, writes: 1932.37, response time: 32.13ms (99%), errors: 0.00, reconnects:  0.00
[1650s] threads: 5, tps: 454.60, reads: 6365.34, writes: 1818.31, response time: 35.36ms (99%), errors: 0.00, reconnects:  0.00
[1660s] threads: 5, tps: 486.99, reads: 6816.59, writes: 1947.67, response time: 32.66ms (99%), errors: 0.00, reconnects:  0.00
[1670s] threads: 5, tps: 488.71, reads: 6840.41, writes: 1954.83, response time: 31.31ms (99%), errors: 0.00, reconnects:  0.00
[1680s] threads: 5, tps: 476.40, reads: 6671.84, writes: 1905.78, response time: 32.73ms (99%), errors: 0.00, reconnects:  0.00
[1690s] threads: 5, tps: 492.01, reads: 6886.32, writes: 1967.83, response time: 32.05ms (99%), errors: 0.00, reconnects:  0.00
[1700s] threads: 5, tps: 466.89, reads: 6539.33, writes: 1867.98, response time: 35.15ms (99%), errors: 0.00, reconnects:  0.00
[1710s] threads: 5, tps: 467.20, reads: 6539.60, writes: 1869.20, response time: 34.60ms (99%), errors: 0.00, reconnects:  0.00
[1720s] threads: 5, tps: 406.20, reads: 5685.46, writes: 1624.02, response time: 36.46ms (99%), errors: 0.00, reconnects:  0.00
[1730s] threads: 5, tps: 329.06, reads: 4609.59, writes: 1317.05, response time: 43.07ms (99%), errors: 0.00, reconnects:  0.00
[1740s] threads: 5, tps: 446.25, reads: 6244.56, writes: 1784.19, response time: 33.20ms (99%), errors: 0.00, reconnects:  0.00
[1750s] threads: 5, tps: 449.70, reads: 6295.90, writes: 1799.20, response time: 32.74ms (99%), errors: 0.00, reconnects:  0.00
[1760s] threads: 5, tps: 448.59, reads: 6282.32, writes: 1794.28, response time: 32.46ms (99%), errors: 0.00, reconnects:  0.00
[1770s] threads: 5, tps: 433.19, reads: 6063.42, writes: 1732.45, response time: 34.30ms (99%), errors: 0.00, reconnects:  0.00
[1780s] threads: 5, tps: 415.72, reads: 5818.18, writes: 1662.88, response time: 36.87ms (99%), errors: 0.00, reconnects:  0.00
[1790s] threads: 5, tps: 417.58, reads: 5848.71, writes: 1670.52, response time: 39.16ms (99%), errors: 0.00, reconnects:  0.00
[1800s] threads: 5, tps: 405.02, reads: 5668.07, writes: 1619.88, response time: 37.95ms (99%), errors: 0.00, reconnects:  0.00
OLTP test statistics:
    queries performed:
        read:                            11590586
        write:                           3311596
        other:                           1655798
        total:                           16557980
    transactions:                        827899 (459.94 per sec.)
    read/write requests:                 14902182 (8278.94 per sec.)
    other operations:                    1655798 (919.88 per sec.)
    ignored errors:                      0      (0.00 per sec.)
    reconnects:                          0      (0.00 per sec.)

General statistics:
    total time:                          1800.0110s
    total number of events:              827899
    total time taken by event execution: 8996.8804s
    response time:
         min:                                  3.89ms
         avg:                                 10.87ms
         max:                                212.65ms
         approx.  99 percentile:              35.75ms

Threads fairness:
    events (avg/stddev):           165579.8000/260.01
    execution time (avg/stddev):   1799.3761/0.00


mysql> show engine innodb status\G;
*************************** 1. row ***************************
  Type: InnoDB
  Name: 
Status: 
=====================================
2021-10-19 15:43:12 0x7fc4c816b700 INNODB MONITOR OUTPUT
=====================================
Per second averages calculated from the last 31 seconds
-----------------
BACKGROUND THREAD
-----------------
srv_master_thread loops: 15025 srv_active, 0 srv_shutdown, 61703 srv_idle
srv_master_thread log flush and writes: 76728
----------
SEMAPHORES
----------
OS WAIT ARRAY INFO: reservation count 778624
--Thread 140483034007296 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x2aa98b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 140483034277632 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x2aa98b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 140483344389888 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x2aa98b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 140483033736960 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x2aa98b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

--Thread 140483032925952 has waited at buf0buf.cc line 3510 for 0.00 seconds the semaphore:
Mutex at 0x2aa98b8, Mutex BUF_POOL created buf0buf.cc:1731, lock var 1

OS WAIT ARRAY INFO: signal count 501178
RW-shared spins 0, rounds 308486, OS waits 57418
RW-excl spins 0, rounds 1943051, OS waits 52301
RW-sx spins 17811, rounds 477325, OS waits 9623
Spin rounds per wait: 308486.00 RW-shared, 1943051.00 RW-excl, 26.80 RW-sx
------------
TRANSACTIONS
------------
Trx id counter 41615548
Purge done for trx's n:o < 41615543 undo n:o < 0 state: running but idle
History list length 96
LIST OF TRANSACTIONS FOR EACH SESSION:
---TRANSACTION 421967708637920, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 421967708638832, not started
0 lock struct(s), heap size 1136, 0 row lock(s)
---TRANSACTION 41615547, ACTIVE 0 sec starting index read
mysql tables in use 1, locked 1
3 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
MySQL thread id 80, OS thread handle 140483033736960, query id 77899583 192.168.1.12 sysbench updating
DELETE FROM sbtest2 WHERE id=1504271
Trx read view will not see trx with id >= 41615543, sees < 41615540
---TRANSACTION 41615546, ACTIVE 0 sec starting index read
mysql tables in use 1, locked 1
3 lock struct(s), heap size 1136, 2 row lock(s), undo log entries 2
MySQL thread id 83, OS thread handle 140483034007296, query id 77899582 192.168.1.12 sysbench updating
DELETE FROM sbtest15 WHERE id=1332121
Trx read view will not see trx with id >= 41615543, sees < 41615540
--------
FILE I/O
--------
I/O thread 0 state: waiting for completed aio requests (insert buffer thread)
I/O thread 1 state: waiting for completed aio requests (log thread)
I/O thread 2 state: waiting for completed aio requests (read thread)
I/O thread 3 state: waiting for completed aio requests (read thread)
I/O thread 4 state: waiting for completed aio requests (read thread)
I/O thread 5 state: waiting for completed aio requests (read thread)
I/O thread 6 state: waiting for completed aio requests (write thread)
I/O thread 7 state: waiting for completed aio requests (write thread)
I/O thread 8 state: waiting for completed aio requests (write thread)
I/O thread 9 state: complete io for buf page (write thread)
Pending normal aio reads: [0, 0, 0, 0] , aio writes: [0, 0, 0, 0] ,
 ibuf aio reads:, log i/o's:, sync i/o's:
Pending flushes (fsync) log: 0; buffer pool: 1
2759989 OS file reads, 16767142 OS file writes, 2041926 OS fsyncs
0.00 reads/s, 0 avg bytes/read, 1219.64 writes/s, 81.35 fsyncs/s
-------------------------------------
INSERT BUFFER AND ADAPTIVE HASH INDEX
-------------------------------------
Ibuf: size 1, free list len 866, seg size 868, 162252 merges
merged operations:
 insert 81305, delete mark 140992, delete 44934
discarded operations:
 insert 0, delete mark 0, delete 0
Hash table size 2365241, node heap has 5609 buffer(s)
Hash table size 2365241, node heap has 5802 buffer(s)
Hash table size 2365241, node heap has 2946 buffer(s)
Hash table size 2365241, node heap has 5869 buffer(s)
Hash table size 2365241, node heap has 5831 buffer(s)
Hash table size 2365241, node heap has 5617 buffer(s)
Hash table size 2365241, node heap has 5559 buffer(s)
Hash table size 2365241, node heap has 5646 buffer(s)
9599.66 hash searches/s, 7254.28 non-hash searches/s
---
LOG
---
Log sequence number 320089104107
Log flushed up to   320089061333
Pages flushed up to 319756742181
Last checkpoint at  319754590025
0 pending log flushes, 0 pending chkp writes
3792538 log i/o's done, 493.29 log i/o's/second
----------------------
BUFFER POOL AND MEMORY
----------------------
Total large memory allocated 8795455488
Dictionary memory allocated 215408
Buffer pool size   524224
Free buffers       2048
Database pages     479297
Old database pages 176887
Modified db pages  254372
Pending reads      0
Pending writes: LRU 0, flush list 63, single page 0
Pages made young 20191010, not young 9178436
2388.15 youngs/s, 0.00 non-youngs/s
Pages read 2758719, created 3858535, written 12536941
0.00 reads/s, 0.35 creates/s, 713.14 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 30 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 479297, unzip_LRU len: 0
I/O sum[69588]:cur[477], unzip sum[0]:cur[0]
----------------------
INDIVIDUAL BUFFER POOL INFO
----------------------
---BUFFER POOL 0
Buffer pool size   262112
Free buffers       1024
Database pages     239656
Old database pages 88446
Modified db pages  126427
Pending reads      0
Pending writes: LRU 0, flush list 2, single page 0
Pages made young 10090438, not young 4626178
1188.41 youngs/s, 0.00 non-youngs/s
Pages read 1381806, created 1929401, written 6261890
0.00 reads/s, 0.10 creates/s, 359.25 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 30 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 239656, unzip_LRU len: 0
I/O sum[34794]:cur[179], unzip sum[0]:cur[0]
---BUFFER POOL 1
Buffer pool size   262112
Free buffers       1024
Database pages     239641
Old database pages 88441
Modified db pages  127945
Pending reads      0
Pending writes: LRU 0, flush list 61, single page 0
Pages made young 10100572, not young 4552258
1199.74 youngs/s, 0.00 non-youngs/s
Pages read 1376913, created 1929134, written 6275051
0.00 reads/s, 0.26 creates/s, 353.89 writes/s
Buffer pool hit rate 1000 / 1000, young-making rate 30 / 1000 not 0 / 1000
Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
LRU len: 239641, unzip_LRU len: 0
I/O sum[34794]:cur[298], unzip sum[0]:cur[0]
--------------
ROW OPERATIONS
--------------
0 queries inside InnoDB, 0 queries in queue
4 read views open inside InnoDB
Process ID=6404, Main thread ID=140483397408512, state: sleeping
Number of rows inserted 263892290, updated 7784246, deleted 3892153, read 1656934104
495.79 inserts/s, 991.52 updates/s, 495.76 deletes/s, 206725.62 reads/s
----------------------------
END OF INNODB MONITOR OUTPUT
============================

1 row in set (0.04 sec)

ERROR: 
No query specified




---
LOG
---
Log sequence number 320089104107
Log flushed up to   320089061333
Pages flushed up to 319756742181
Last checkpoint at  319754590025
0 pending log flushes, 0 pending chkp writes
3792538 log i/o's done, 493.29 log i/o's/second


select 320089061333-319756742181 = 316MB