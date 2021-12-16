
Thread 38 (Thread 0x7fe57a86f700 (LWP 67268)):
#0  0x0000003dee4f82ce in __lll_lock_wait_private () from /lib64/libc.so.6
#1  0x0000003dee49df8d in _L_lock_2163 () from /lib64/libc.so.6
#2  0x0000003dee49dd47 in __tz_convert () from /lib64/libc.so.6
#3  0x00000000007c02e7 in Time_zone_system::gmt_sec_to_TIME(st_mysql_time*, long) const ()
#4  0x0000000000811df6 in Field_timestampf::get_date_internal(st_mysql_time*) ()
#5  0x0000000000809ea9 in Field_temporal_with_date::val_date_temporal() ()
#6  0x00000000005f43cc in get_datetime_value(THD*, Item***, Item**, Item*, bool*) ()
#7  0x00000000005e7ba7 in Arg_comparator::compare_datetime() ()
#8  0x00000000005eef4e in Item_func_gt::val_int() ()
#9  0x00000000006fc6ab in evaluate_join_record(JOIN*, st_join_table*) ()
#10 0x0000000000700e7e in sub_select(JOIN*, st_join_table*, bool) ()
#11 0x00000000006fecc1 in JOIN::exec() ()


现象：
	update 一个字段，赋值为now()返回需要几秒，赋值为具体的时间很快

原因分析：
    对于使用 timestamp 的场景，MySQL 在访问 timestamp 字段时会做时区转换，当 time_zone 设置为 system 时，
        MySQL 访问每一行的 timestamp 字段时，都会通过 libc 的时区函数，获取 Linux 设置的时区，    
		-- 经过GDB断点调试，确实是如此，只要访问每一行的 timestamp 字段，都会进行时区转换。
        在这个 libc 时区函数中会持有mutex，当大量并发SQL需要访问 timestamp 字段时，会出现 mutex 竞争。
    MySQL 访问每一行都会做这个时区转换，转换完后释放mutex，所有等待这个 mutex 的线程全部唤醒，结果又会只有一个线程会成功持有 mutex，
        其余又会再次sleep，这样就会导致 context switch 非常高但 qps 很低，系统吞吐量急剧下降。
		
	总的来说, 就是通过获取 OS会话时区, 会出现  mutex 竞争导致 context switch 非常高
	
	
	
互斥锁
    mutex一般指互斥锁
    在编程中，引入了对象互斥锁的概念，来保证共享数据操作的完整性。每个对象都对应于一个可称为" 互斥锁" 的标记，这个标记用来保证在任一时刻，只能有一个线程访问该对象。
	-- 相当于是串行执行。
    相关参考 https://baike.baidu.com/item/%E4%BA%92%E6%96%A5%E9%94%81/841823?fromtitle=mutex&fromid=6330198&fr=aladdin      

timestamp 转换：

    在进行新纪元时间（1970-01-01 00:00:00）以来的秒到实际时间之间转换的时候MySQL根据参数time_zone的设置有两种选择：
		1. time_zone：设置为SYSTEM的话，使用sys_time_zone获取的OS会话时区，同时使用OS API进行转换。对应转换函数 Time_zone_system::gmt_sec_to_TIME
		2. time_zone：设置为实际的时区的话，比如‘+08:00’，那么使用使用MySQL自己的方法进行转换。对应转换函数 Time_zone_offset::gmt_sec_to_TIME
	
	实际上Time_zone_system和Time_zone_offset均继承于Time_zone类，并且实现了Time_zone类的虚函数进行了重写，因此上层调用都是Time_zone::gmt_sec_to_TIME。




高并发环境下并不适合使用TIMESTAMP

	这一点MySql的文档中有明确的说明：
		Note
		If set to SYSTEM, every MySQL function call that requires a time zone calculation makes a system library call to determine the current system time zone. 
		This call may be protected by a global mutex, resulting in contention.
		
		虽然通过TIMESTAMP可以自动转换时区，代价是当MySQL参数time_zone=system时每次都会尝试获取一个全局锁，这在高并发的环境下无疑是致命的，可能会导致线程上下文频繁切换，CPU使用率暴涨，系统响应变慢甚至假死。
		
	https://dev.mysql.com/doc/refman/5.7/en/time-zone-support.html	
