

iostat 1
	avg-cpu:  %user   %nice %system %iowait  %steal   %idle
			  24.61    0.00   17.54   17.02    0.00   40.84

	Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
	vda               0.00         0.00         0.00          0          0
	vdb             477.00     56036.00    169436.00      56036     169436

	avg-cpu:  %user   %nice %system %iowait  %steal   %idle
			  21.26    0.00   15.49   24.41    0.00   38.85

	Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
	vda             164.00      6688.00         0.00       6688          0
	vdb             519.00     42976.00    179272.00      42976     179272

	avg-cpu:  %user   %nice %system %iowait  %steal   %idle
			  15.94    0.00   11.05   37.28    0.00   35.73

	Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
	vda               0.00         0.00         0.00          0          0
	vdb             457.00     44260.00    132080.00      44260     132080

	avg-cpu:  %user   %nice %system %iowait  %steal   %idle
			  12.47    0.00    9.87   35.06    0.00   42.60

	Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
	vda               0.00         0.00         0.00          0          0
	vdb             591.00     33208.00    208584.00      33208     208584

	avg-cpu:  %user   %nice %system %iowait  %steal   %idle
			  28.31    0.00   20.26   13.25    0.00   38.18

	Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
	vda              33.00       936.00         0.00        936          0
	vdb             333.00     63976.00     89568.00      63976      89568

	avg-cpu:  %user   %nice %system %iowait  %steal   %idle
			  18.90    0.00   14.96   25.46    0.00   40.68

	Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
	vda             408.00     25004.00         0.00      25004          0
	vdb             503.00     51616.00    167140.00      51616     167140

		  
iostat -dmx 1
	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	vda               0.00     0.00  562.00    0.00   131.78     0.00   480.21    56.32  141.00  141.00    0.00   1.78 100.00
	vdb               1.00     0.00  188.00  344.00    44.16   160.01   785.98    89.55  198.70   15.68  298.73   1.71  91.00

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	vda               0.00     0.00  407.00    0.00   116.80     0.00   587.71    25.85   64.59   64.59    0.00   2.46 100.00
	vdb               1.00    16.00   98.00  278.00    40.17   129.95   926.62    90.63  273.89   46.84  353.93   2.66 100.00

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	vda               1.00     1.00  421.00   64.00    35.53     0.27   151.18     8.00   18.64   20.90    3.75   2.05  99.20
	vdb               1.00     0.00   99.00  250.00    34.12   116.52   883.99    92.37  210.34   22.93  284.55   2.58  89.90

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	vda               0.00     6.00  607.00    2.00     7.31     0.03    24.68    15.95   26.02   26.10    1.00   1.60  97.70
	vdb               1.00     6.00  108.00  397.00    47.16   185.63   944.06   113.56  237.29   99.19  274.85   1.93  97.60

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	vda               0.00     0.00  291.00    0.00    18.25     0.00   128.44     4.29   15.09   15.09    0.00   2.75  80.10
	vdb               0.00     0.00  115.00  296.00    50.69   138.80   944.25    91.37  223.75   57.67  288.28   2.00  82.40

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	vda               0.00     0.00  102.00    0.00     1.95     0.00    39.06     0.29    2.88    2.88    0.00   1.04  10.60
	vdb              32.00     0.00  146.00  310.00    60.73   145.04   924.18    86.13  193.52   61.28  255.80   1.98  90.40

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	vda               0.00     0.00   77.00    0.00     4.15     0.00   110.34     0.67    8.66    8.66    0.00   0.53   4.10
	vdb               0.00    22.00  118.00  357.00    52.00   166.19   940.75   119.67  231.48   84.62  280.02   2.11 100.00

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	vda               0.00     0.00  315.00    0.00    26.61     0.00   173.00    13.52   42.90   42.90    0.00   1.41  44.50
	vdb               0.00     0.00  115.00  390.00    51.37   181.01   942.42   110.16  232.09   69.39  280.07   1.98 100.20

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	vda               0.00    15.00    0.00    3.00     0.00     0.07    48.00     0.00    1.00    0.00    1.00   0.67   0.20
	vdb               0.00     5.00  124.00  317.00    52.35   146.93   925.48   101.23  200.78   63.61  254.44   2.19  96.40

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	vda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
	vdb               1.00     0.00  102.00  392.00    44.18   184.12   946.49   120.94  267.08   98.52  310.94   2.02 100.00

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	vda               0.00     0.00   53.00    0.00     1.03     0.00    39.85     0.23    4.28    4.28    0.00   1.49   7.90
	vdb               0.00     0.00  154.00  325.00    52.32   153.01   877.90   100.74  197.42   28.18  277.61   2.09 100.00

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	vda               0.00     0.00   28.00    0.00     2.43     0.00   178.00     0.60   21.29   21.29    0.00   1.46   4.10
	vdb               0.00    18.00  244.00  300.00    39.16   139.67   673.25    91.34  162.52   30.20  270.14   1.75  95.20

	Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
	vda               0.00     0.00   17.00    0.00     1.98     0.00   238.12     0.49   15.76   15.76    0.00   7.88  13.40
	vdb               0.00     0.00  195.00  340.00    47.83   160.00   795.59   106.20  203.50   43.75  295.12   1.80  96.30


