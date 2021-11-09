
使用 use db; 命令切换数据库，客户端执行慢的原因：
	1. 默认不加 -A 参数，会打开当前数据库下的所有表，在客户端构建哈希索引，用于实现本地库名+表名的补全操作。
	2. 如果当前数据库下的表的个数很多，这个步骤会花比较长的时间。

	
	COMMAND = mysql
		
		shell> top
		top - 08:45:20 up 9 days, 22:59,  4 users,  load average: 0.47, 0.15, 0.08
		Tasks: 100 total,   3 running,  97 sleeping,   0 stopped,   0 zombie
		%Cpu0  : 97.4 us,  0.0 sy,  0.0 ni,  2.6 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
		KiB Mem :  1016476 total,   574296 free,    76976 used,   365204 buff/cache
		KiB Swap:  2097148 total,  2063200 free,    33948 used.   764252 avail Mem 

		  PID USER      PR  NI    VIRT    RES    SHR S %CPU %MEM     TIME+ COMMAND                                                                                                                                                                                                   
		10007 root      20   0  160632  29116   1708 R 97.4  2.9   0:45.16 mysql    


		COMMAND = mysql 说明是客户端


	COMMAND = mysqld
		shell> top
		top - 16:05:34 up 7 days, 22:01,  2 users,  load average: 0.33, 0.09, 0.03
		Tasks: 158 total,   1 running, 157 sleeping,   0 stopped,   0 zombie
		Cpu0  :  0.0%us,  0.0%sy,  0.0%ni,100.0%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
		Cpu1  :  0.0%us,  0.0%sy,  0.0%ni,100.0%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
		Cpu2  :  0.0%us,  0.3%sy,  0.0%ni, 99.7%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
		Cpu3  :  0.0%us,  0.0%sy,  0.0%ni,100.0%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
		Mem:   6015828k total,  4518400k used,  1497428k free,   188040k buffers
		Swap:  2047996k total,        0k used,  2047996k free,   859648k cached

		  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND                                                                                                                                                                                                                                                                                                                                                                                                             
		 3194 mysql     20   0 5680m 3.1g  13m S  0.3 54.0 222:58.92 mysqld 
		 
		 
		COMMAND = mysqld 才是服务端
		
		
		