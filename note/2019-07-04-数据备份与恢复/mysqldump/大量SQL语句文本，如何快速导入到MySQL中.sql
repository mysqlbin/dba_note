

答：

1、可在SQL文本前，添加set session sql_log_bin=0（需要在从库也导入一次）。

2、导入期间临时修改参数sync_binlog=10000、innodb_flush_log_at_trx_commit=2、innodb_autoinc_lock_mode=2。

3、导入前，根据业务情况看能否删除除了自增列主键外的其他索引。

4、将SQL文件切割成多份，再并发多线程导入。

5、若该SQL文件是每个INSERT一行，需要先行将多行合并成一行，即启用extended-insert模式。

6、以上建议，在线上环境请谨慎评估该骚操作的风险性。

7、以上建议，仅考虑尽快导入，涉及到和具体业务需求相冲突时（例如太快导入反倒会影响在线数据库性能），以实际情况为主。



实践：

    数据库系统参数：

        sync_binlog=10000、innodb_flush_log_at_trx_commit=2

     3000W条数据， 数据大小为 4G， 索引大小为7.5G

    逻辑导出数据包含索引：
		
        /usr/bin/mysqldump -uroot -p --single-transaction --master-data=2 -t db_name --tables table_name |gzip > 2019.dump.gz

    逻辑导入时间： 3个小时都没导入完成。
					原因： IO利用率持续100。
        

    逻辑导出数据不包含索引：
		 
		/usr/bin/mysqldump -uroot -p --single-transaction --master-data=2 -t db_name --tables table_name --where='bRobot = 1' |gzip > 2019.dump.gz
		
		/usr/bin/mysqldump -uroot -p --single-transaction --master-data=2 -t db_name --tables table_name --where='bRobot = 0' |gzip > 20190.dump.gz
				
		
    逻辑导入之后创建对应的索引：

            导入时间约 25分钟

            创建索引时间约 20分钟

             

   小结： 导入数据不导索引，导入速度会快很多

    
	本次导入很慢的原因：
		这台机器的IOPS都不到100.
		[root@soft mydata]# fio -filename=/mydata/fio.txt -direct=1 -iodepth 1 -thread -rw=randrw -ioengine=psync -bs=16k -size=500M -numjobs=10 -runtime=10 -group_reporting -name=mytest
		mytest: (g=0): rw=randrw, bs=16K-16K/16K-16K/16K-16K, ioengine=psync, iodepth=1
		...
		mytest: (g=0): rw=randrw, bs=16K-16K/16K-16K/16K-16K, ioengine=psync, iodepth=1
		fio-2.0.13
		Starting 10 threads
		mytest: Laying out IO file(s) (1 file(s) / 500MB)
		Jobs: 10 (f=10): [mmmmmmmmmm] [100.0% done] [1904K/1472K/0K /s] [119 /92 /0  iops] [eta 00m:00s]
		mytest: (groupid=0, jobs=10): err= 0: pid=5878: Mon Mar 16 17:31:06 2020
		  read : io=14768KB, bw=1440.4KB/s, iops=90 , runt= 10253msec
			clat (usec): min=150 , max=1972.1K, avg=84848.01, stdev=124097.78
			 lat (usec): min=150 , max=1972.1K, avg=84848.22, stdev=124097.79
			clat percentiles (usec):
			 |  1.00th=[  892],  5.00th=[ 5856], 10.00th=[ 9792], 20.00th=[16768],
			 | 30.00th=[23168], 40.00th=[31872], 50.00th=[44288], 60.00th=[62208],
			 | 70.00th=[87552], 80.00th=[122368], 90.00th=[199680], 95.00th=[284672],
			 | 99.00th=[651264], 99.50th=[708608], 99.90th=[1974272], 99.95th=[1974272],
			 | 99.99th=[1974272]
			bw (KB/s)  : min=    8, max=  434, per=11.10%, avg=159.90, stdev=99.49
		  write: io=14592KB, bw=1423.2KB/s, iops=88 , runt= 10253msec
			clat (usec): min=164 , max=742797 , avg=25537.40, stdev=95163.49
			 lat (usec): min=165 , max=742798 , avg=25538.48, stdev=95163.47
			clat percentiles (usec):
			 |  1.00th=[  181],  5.00th=[  201], 10.00th=[  209], 20.00th=[  233],
			 | 30.00th=[  306], 40.00th=[  390], 50.00th=[  516], 60.00th=[  908],
			 | 70.00th=[ 1004], 80.00th=[ 2224], 90.00th=[43264], 95.00th=[177152],
			 | 99.00th=[514048], 99.50th=[684032], 99.90th=[741376], 99.95th=[741376],
			 | 99.99th=[741376]
			bw (KB/s)  : min=   16, max=  638, per=11.19%, avg=159.26, stdev=128.88
			lat (usec) : 250=10.68%, 500=13.84%, 750=1.63%, 1000=9.10%
			lat (msec) : 2=3.76%, 4=6.21%, 10=3.71%, 20=7.68%, 50=14.82%
			lat (msec) : 100=12.04%, 250=11.28%, 500=3.87%, 750=1.31%, 2000=0.05%
		  cpu          : usr=0.00%, sys=0.00%, ctx=18446744073709341660, majf=18446744073709551459, minf=18446744073709422876
		  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
			 submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
			 complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
			 issued    : total=r=923/w=912/d=0, short=r=0/w=0/d=0

		Run status group 0 (all jobs):
		   READ: io=14768KB, aggrb=1440KB/s, minb=1440KB/s, maxb=1440KB/s, mint=10253msec, maxt=10253msec
		  WRITE: io=14592KB, aggrb=1423KB/s, minb=1423KB/s, maxb=1423KB/s, mint=10253msec, maxt=10253msec

		Disk stats (read/write):
		  sda: ios=961/1061, merge=75/80, ticks=72059/28288, in_queue=100321, util=100.00%

		  
  
    



	
	