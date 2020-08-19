
MySQL
	table_open_cache 
	open_files_limit
	innodb_open_files   

Linux

	ulimit -a
		[root@kp04 ~]#  ulimit -a
		core file size          (blocks, -c) 0
		data seg size           (kbytes, -d) unlimited
		scheduling priority             (-e) 0
		file size               (blocks, -f) unlimited
		pending signals                 (-i) 3884
		max locked memory       (kbytes, -l) 64
		max memory size         (kbytes, -m) unlimited
		open files                      (-n) 65536
		pipe size            (512 bytes, -p) 8
		POSIX message queues     (bytes, -q) 819200
		real-time priority              (-r) 0
		stack size              (kbytes, -s) 8192
		cpu time               (seconds, -t) unlimited
		max user processes              (-u) 3884
		virtual memory          (kbytes, -v) unlimited
		file locks                      (-x) unlimited


	cat /proc/`pidof mysqld`/limits
		[root@kp04 ~]#  cat /proc/`pidof mysqld`/limits
		Limit                     Soft Limit           Hard Limit           Units     
		Max cpu time              unlimited            unlimited            seconds   
		Max file size             unlimited            unlimited            bytes     
		Max data size             unlimited            unlimited            bytes     
		Max stack size            8388608              unlimited            bytes     
		Max core file size        0                    unlimited            bytes     
		Max resident set          unlimited            unlimited            bytes     
		Max processes             3884                 3884                 processes 
		Max open files            65535                65535                files     
		Max locked memory         65536                65536                bytes     
		Max address space         unlimited            unlimited            bytes     
		Max file locks            unlimited            unlimited            locks     
		Max pending signals       3884                 3884                 signals   
		Max msgqueue size         819200               819200               bytes     
		Max nice priority         0                    0                    
		Max realtime priority     0                    0                    
		Max realtime timeout      unlimited            unlimited            us 





查看MySQL打开的文件：
[root@soft ~]# lsof -p `pidof mysqld` | wc -l
1978


[root@soft ~]# ulimit -a|grep 'open files'
open files                      (-n) 1048576






相关参考： 
	https://www.cnblogs.com/zhoujinyi/archive/2013/01/31/2883433.html  MySQL open_files_limit相关设置

