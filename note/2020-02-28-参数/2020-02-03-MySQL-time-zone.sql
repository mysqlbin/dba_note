



https://www.jianshu.com/p/e8b904e5e890   MySQL：timestamp时区转换导致CPU %sy高的问题  # 再一次用到了 pstack 


	对于使用 timestamp 的场景，MySQL 在访问 timestamp 字段时会做时区转换，当 time_zone 设置为 system 时，
		MySQL 访问每一行的 timestamp 字段时，都会通过 libc 的时区函数，获取 Linux 设置的时区，
		在这个 libc 时区函数中会持有mutex，当大量并发SQL需要访问 timestamp 字段时，会出现 mutex 竞争。

	MySQL 访问每一行都会做这个时区转换，转换完后释放 mutex，所有等待这个 mutex 的线程全部唤醒，结果又会只有一个线程会成功持有 mutex，
		其余又会再次sleep，这样就会导致 context switch 非常高但 qps 很低，系统吞吐量急剧下降。

	解决办法：设置 time_zone=’+8:00’，这样就不会访问 Linux 系统时区，直接转换，避免了mutex问题。

	
	

timestap转换
	在进行新纪元时间（1970-01-01 00:00:00）以来的秒到实际时间之间转换的时候MySQL根据参数time_zone的设置有两种选择：

	time_zone：设置为SYSTEM的话，使用sys_time_zone获取的OS会话时区，同时使用OS API进行转换。对应转换函数 Time_zone_system::gmt_sec_to_TIME
	time_zone：设置为实际的时区的话，比如‘+08:00’，那么使用使用MySQL自己的方法进行转换。对应转换函数 Time_zone_offset::gmt_sec_to_TIME
