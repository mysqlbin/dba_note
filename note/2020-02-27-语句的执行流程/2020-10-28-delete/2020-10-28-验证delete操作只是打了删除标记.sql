
1. 语句的执行耗时
2. iostat -dmx 1
3. 小结

1. 语句的执行耗时
	mysql> delete from table_aaaaaaaaaaaaaaaaaaaaaa limit 10000;
	Query OK, 10000 rows affected (0.38 sec)
	
2. iostat -dmx 1

	shell> iostat -dmx 1

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     0.00    0.00    8.00     0.00     0.03     8.00     0.06    7.38    0.00    7.38   7.38   5.90

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     0.00   98.00    8.00     1.53     0.03    30.19     0.12    1.16    0.66    7.25   1.16  12.30

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda              15.00   886.00  190.00   19.00     3.20     3.54    66.03    52.65  251.72  272.10   47.89   4.74  99.00

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00   235.00  120.00  135.00     1.88     4.71    52.89     3.50   12.95   19.64    6.99   3.92  99.90

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda              16.00    16.00  135.00   11.00     2.33     1.96    60.22    48.69  239.86  250.54  108.82   6.84  99.90

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda              28.00    37.00  107.00  119.00     1.88     2.01    35.19   108.96  322.16  658.09   20.11   4.42 100.00

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               4.00    34.00  239.00   33.00     4.03     2.03    45.62   134.56  477.15  508.94  246.91   3.68 100.00

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00    16.00   64.00  110.00     1.03     1.83    33.66    48.02  425.76  958.42  115.85   5.75 100.00

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00    62.00   22.00  152.00     0.34     4.55    57.66     3.94  187.40 1328.73   22.21   5.72  99.50

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               1.00    65.00   34.00  147.00     0.55     5.95    73.55     2.86   16.27   34.76   11.99   5.50  99.50

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               2.00    59.00   32.00  235.00     0.53     5.82    48.69     4.19   14.88   48.59   10.29   3.74  99.90

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00   232.00    0.00  149.00     0.00     5.12    70.44     1.71   12.99    0.00   12.99   6.70  99.90

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     7.00    0.00  256.00     0.00     7.55    60.44     2.58    9.61    0.00    9.61   3.89  99.60

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     5.00    0.00  132.00     0.00     3.80    58.91     1.96   12.18    0.00   12.18   7.58 100.10

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00    14.00    0.00  253.00     0.00     7.57    61.25     2.58   10.82    0.00   10.82   3.94  99.70

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00    13.00    0.00  250.00     0.00     7.55    61.89     2.58   10.57    0.00   10.57   3.99  99.80

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00    15.00    0.00  249.00     0.00     7.60    62.49     2.51   10.97    0.00   10.97   4.00  99.70

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     6.00    0.00  120.00     0.00     5.34    91.13     1.68   14.18    0.00   14.18   8.32  99.80

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00    29.00    0.00  231.00     0.00     5.69    50.42     2.35    8.66    0.00    8.66   4.32  99.80

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00    21.00    0.00  247.00     0.00     7.58    62.83     2.60   11.16    0.00   11.16   4.04  99.80

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00    11.00    0.00  257.00     0.00     7.57    60.36     2.80   11.63    0.00   11.63   3.89  99.90

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     9.00    0.00  124.00     0.00     3.79    62.52     6.96   52.05    0.00   52.05   8.06  99.90

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00    18.00    0.00  206.00     0.00     6.20    61.67     2.13   11.59    0.00   11.59   4.85  99.90

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     5.00    0.00   43.00     0.00     0.45    21.21     0.65   19.65    0.00   19.65  14.65  63.00

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     5.00    0.00  130.00     0.00     3.79    59.63     1.11    7.61    0.00    7.61   2.30  29.90

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     8.00    0.00  129.00     0.00     3.80    60.34     1.92   11.98    0.00   11.98   7.74  99.90

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00    13.00    0.00  258.00     0.00     7.59    60.25     2.94   12.61    0.00   12.61   3.87  99.80

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     3.00    0.00  127.00     0.00     3.77    60.85     1.84   11.86    0.00   11.86   7.87  99.90

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     8.00    0.00  226.00     0.00     6.57    59.58     2.41   12.85    0.00   12.85   4.42  99.90

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     0.00    0.00   11.00     0.00     0.04     6.55     0.63   64.00    0.00   64.00  57.55  63.30

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     0.00    0.00    8.00     0.00     0.03     8.00     0.12   15.62    0.00   15.62  15.62  12.50

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00


3. 小结

	语句的执行耗时：0.38秒； 
	后台purge线程真正做删除记录操作，耗时约25秒； 操作期间会占用IO资源； 
	delete语句只是对行记录打了一个删除标记，后台purge线程真正删除这些记录，释放物理页空间

	后期学习源码，再详细看......
	
	