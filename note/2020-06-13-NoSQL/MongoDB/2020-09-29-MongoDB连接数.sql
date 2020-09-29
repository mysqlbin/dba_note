
1. 生产环境
2. 测试环境
3. 查看生产环境中的连接到MongoDB 27017端口的连接数
4. 相关参考

1. 生产环境
	
	shell> cat /etc/mongodb.conf 

	maxConns=20000      #设置最大连接数
	
	repl_set:PRIMARY> db.serverStatus().connections
	{ "current" : 140, "available" : 679, "totalCreated" : 1054, "active" : 2 }


	repl_set:SECONDARY> db.serverStatus().connections
	{ "current" : 6, "available" : 813, "totalCreated" : 206, "active" : 1 }

	shell> mongostat  -u admin -p 123456abc --authenticationDatabase=admin
	insert query update delete getmore command dirty  used flushes vsize   res qrw arw net_in net_out conn      set repl                time
	 8    *0     *0     *0       9    13|0  0.4% 67.0%       0 9.71G 6.49G 0|0 1|0  23.1k   60.0k  141 repl_set  PRI Sep 29 10:20:30.969
     3    *0     *0     *0       3     4|0  0.4% 67.0%       0 9.71G 6.49G 0|0 1|0  8.55k   45.2k  141 repl_set  PRI Sep 29 10:20:31.971
     5    *0     *0     *0       8    11|0  0.4% 67.0%       0 9.71G 6.49G 0|0 1|0  16.0k   52.6k  141 repl_set  PRI Sep 29 10:20:32.968
    13    *0     *0     *0      12    13|0  0.4% 67.0%       0 9.71G 6.49G 0|0 1|0  27.6k   63.0k  141 repl_set  PRI Sep 29 10:20:33.968
    *0    *0     *0     *0       0     2|0  0.4% 67.0%       0 9.71G 6.49G 0|0 1|0   696b   38.9k  141 repl_set  PRI Sep 29 10:20:34.969
     5    *0     *0     *0       8     9|0  0.4% 67.0%       0 9.71G 6.49G 0|0 1|0  17.2k   52.9k  141 repl_set  PRI Sep 29 10:20:35.968
    *0    *0     *0     *0       0     5|0  0.4% 67.0%       0 9.71G 6.49G 0|0 1|0   814b   41.2k  141 repl_set  PRI Sep 29 10:20:36.968
	
	
	shell> ulimit -a
	core file size          (blocks, -c) unlimited
	data seg size           (kbytes, -d) unlimited
	scheduling priority             (-e) 0
	file size               (blocks, -f) unlimited
	pending signals                 (-i) 63476
	max locked memory       (kbytes, -l) 64
	max memory size         (kbytes, -m) unlimited
	open files                      (-n) 40000       old: 1024
	pipe size            (512 bytes, -p) 8
	POSIX message queues     (bytes, -q) 819200
	real-time priority              (-r) 0
	stack size              (kbytes, -s) 8192
	cpu time               (seconds, -t) unlimited
	max user processes              (-u) 4096
	virtual memory          (kbytes, -v) unlimited
	file locks                      (-x) unlimited



	shell> cat /etc/security/limits.conf
	# /etc/security/limits.conf
	#
	#This file sets the resource limits for the users logged in via PAM.
	#It does not affect resource limits of the system services.
	#
	#Also note that configuration files in /etc/security/limits.d directory,
	#which are read in alphabetical order, override the settings in this
	#file in case the domain is the same or more specific.
	#That means for example that setting a limit for wildcard domain here
	#can be overriden with a wildcard setting in a config file in the
	#subdirectory, but a user specific setting here can be overriden only
	#with a user specific setting in the subdirectory.
	#
	#Each line describes a limit for a user in the form:
	#
	#<domain>        <type>  <item>  <value>
	#
	#Where:
	#<domain> can be:
	#        - a user name
	#        - a group name, with @group syntax
	#        - the wildcard *, for default entry
	#        - the wildcard %, can be also used with %group syntax,
	#                 for maxlogin limit
	#
	#<type> can have the two values:
	#        - "soft" for enforcing the soft limits
	#        - "hard" for enforcing hard limits
	#
	#<item> can be one of the following:
	#        - core - limits the core file size (KB)
	#        - data - max data size (KB)
	#        - fsize - maximum filesize (KB)
	#        - memlock - max locked-in-memory address space (KB)
	#        - nofile - max number of open file descriptors
	#        - rss - max resident set size (KB)
	#        - stack - max stack size (KB)
	#        - cpu - max CPU time (MIN)
	#        - nproc - max number of processes
	#        - as - address space limit (KB)
	#        - maxlogins - max number of logins for this user
	#        - maxsyslogins - max number of logins on the system
	#        - priority - the priority to run user process with
	#        - locks - max number of file locks the user can hold
	#        - sigpending - max number of pending signals
	#        - msgqueue - max memory used by POSIX message queues (bytes)
	#        - nice - max nice priority allowed to raise to values: [-20, 19]
	#        - rtprio - max realtime priority
	#
	#<domain>      <type>  <item>         <value>
	#

	#*               soft    core            0
	#*               hard    rss             10000
	*                soft    nofile          40000
	*                hard    nofile          40000
	#@student        hard    nproc           20
	#@faculty        soft    nproc           20
	#@faculty        hard    nproc           50
	#ftp             hard    nproc           0
	#@student        -       maxlogins       4

	# End of file



	1. mongodb最大的连接数是819，在启动里面加参数 --maxConns=3000重启mongodb服务后最大连接数还是819。
	2. 其实是linux系统的限制，Linux系统默认一个进程最大文件打开数目为1024。需要修改此限制

-----------------------------------------------------------

2. 测试环境

	repl_set:SECONDARY> db.serverStatus().connections
	{ "current" : 5, "available" : 19995, "totalCreated" : 62, "active" : 1 }

	[root@soft ~]# ulimit -a
	core file size          (blocks, -c) 0
	data seg size           (kbytes, -d) unlimited
	scheduling priority             (-e) 0
	file size               (blocks, -f) unlimited
	pending signals                 (-i) 22885
	max locked memory       (kbytes, -l) 64
	max memory size         (kbytes, -m) unlimited
	open files                      (-n) 40000
	pipe size            (512 bytes, -p) 8
	POSIX message queues     (bytes, -q) 819200
	real-time priority              (-r) 0
	stack size              (kbytes, -s) 10240
	cpu time               (seconds, -t) unlimited
	max user processes              (-u) 22885
	virtual memory          (kbytes, -v) unlimited
	file locks                      (-x) unlimited


	[root@soft ~]# cat /etc/security/limits.conf
	# /etc/security/limits.conf
	#
	#Each line describes a limit for a user in the form:
	#
	#<domain>        <type>  <item>  <value>
	#
	#Where:
	#<domain> can be:
	#        - a user name
	#        - a group name, with @group syntax
	#        - the wildcard *, for default entry
	#        - the wildcard %, can be also used with %group syntax,
	#                 for maxlogin limit
	#
	#<type> can have the two values:
	#        - "soft" for enforcing the soft limits
	#        - "hard" for enforcing hard limits
	#
	#<item> can be one of the following:
	#        - core - limits the core file size (KB)
	#        - data - max data size (KB)
	#        - fsize - maximum filesize (KB)
	#        - memlock - max locked-in-memory address space (KB)
	#        - nofile - max number of open file descriptors
	#        - rss - max resident set size (KB)
	#        - stack - max stack size (KB)
	#        - cpu - max CPU time (MIN)
	#        - nproc - max number of processes
	#        - as - address space limit (KB)
	#        - maxlogins - max number of logins for this user
	#        - maxsyslogins - max number of logins on the system
	#        - priority - the priority to run user process with
	#        - locks - max number of file locks the user can hold
	#        - sigpending - max number of pending signals
	#        - msgqueue - max memory used by POSIX message queues (bytes)
	#        - nice - max nice priority allowed to raise to values: [-20, 19]
	#        - rtprio - max realtime priority
	#
	#<domain>      <type>  <item>         <value>
	#

	#*               soft    core            0
	#*               hard    rss             10000
	#@student        hard    nproc           20
	#@faculty        soft    nproc           20
	#@faculty        hard    nproc           50
	#ftp             hard    nproc           0
	#@student        -       maxlogins       4
	*	soft	nofile	40000
	*	hard 	nofile	40000

	# End of file





-------------------------------------------------------------------

3. 查看生产环境中的连接到MongoDB 27017端口的连接数

	mongodb 在安装的时候最大连接数设置为 5000个，但是实际上只能用默认的 819个。原因：操作系统的 open files参数默认设置得太小。前段时间carry已经把DB相关机器的操作系统的 open files参数改为 40000。

	现在2RM mongodb 主库的连接数已经用了 142个，实际活跃连接数只有2个， 还有大约 677个空闲连接。
	从7月14号上线到现在相当于每天用了2个连接。
	其中这几台机器使用的使用连接数较高：
		192.168.1.17(21个连接)、192.168.1.18(27个连接)、192.168.1.19(39个连接)
		
	现在在持续观察这个连接数的使用情况，避免连接数不够用导致出现异常


	后期连接数不够用，可以在停服的时候重启数据库，让最大连接数设置为5000个生效。
	其中这几台机器使用的使用连接数较高：
		192.168.1.17(21个连接)、192.168.1.18(27个连接)、192.168.1.19(39个连接)


	查出每个IP地址连接数

		shell> netstat -na | grep ESTABLISHED | awk '{print$5}' | awk -F : '{print$1}' |sort |uniq -c | sort -r
			  7 192.168.1.36
			  6 192.168.1.33
			  6 192.168.1.32
			  6 192.168.1.31
			  6 192.168.1.30
			  5 192.168.1.13
			  5 192.168.1.12
			  5 192.168.1.11
			 39 192.168.1.19
			  3 192.168.1.34
			  3 192.168.1.15
			  3 192.168.1.14
			 27 192.168.1.18
			  2 172.217.161.42
			  2 169.254.169.254
			  2 127.0.0.1
			 21 192.168.1.17

	统计27017端口的连接数	
	shell> netstat -nat | grep -i "27017" | wc -l
	143


	统计27017端口的连接数列表
		shell> netstat -an|grep 27017
		tcp        0      0 0.0.0.0:27017           0.0.0.0:*               LISTEN     
		tcp        0      0 192.168.1.35:27017      192.168.1.18:49324      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.18:49464      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.30:52584      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.18:49546      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.14:44924      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:39972      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.18:49490      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.11:56518      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.34:49546      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.32:50872      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.18:49436      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:40002      ESTABLISHED
		tcp        0      0 192.168.1.35:43134      192.168.1.11:27017      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.33:37810      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.17:40070      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:40140      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:39934      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.30:52560      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.17:39984      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.14:44920      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.32:50898      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.13:36706      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.17:40014      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.18:49322      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:40082      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.12:41178      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.31:58002      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.31:57970      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.12:41268      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.18:49548      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:40166      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:40142      ESTABLISHED
		tcp        0      0 127.0.0.1:44772         127.0.0.1:27017         ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:39998      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:39932      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.11:43120      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:39862      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.18:49462      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.18:49518      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.36:47292      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.17:40066      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.18:49522      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.30:52556      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.17:40068      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.32:50874      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.33:37836      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.15:52748      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.17:40012      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:40056      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.18:49434      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.11:43122      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:39938      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.13:36708      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:40028      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.17:40040      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.30:52586      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.32:50902      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:40110      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:39940      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.18:49352      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.18:49410      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.33:37806      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:39890      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.18:49378      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.36:47288      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.36:39226      ESTABLISHED
		tcp        0      0 192.168.1.35:57122      192.168.1.36:27017      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.17:39982      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.31:57972      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.12:41272      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:39888      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:40170      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.18:49380      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.11:56519      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.18:49520      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.18:49550      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:40112      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:40168      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.18:49354      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.18:49438      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.17:39952      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:39860      ESTABLISHED
		tcp        0      0 127.0.0.1:27017         127.0.0.1:44772         ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.18:49382      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.17:39986      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:40138      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.18:49408      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.18:49492      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.17:40042      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.30:52558      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.18:49494      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.36:47274      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.13:36702      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:40114      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.17:39954      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.17:40094      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.17:40096      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.17:40010      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:40000      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:39936      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.33:37808      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.36:47293      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.13:36710      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.18:49406      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:39858      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:39834      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.32:50870      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.36:45954      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.34:49542      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.17:40122      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.31:57974      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.30:52588      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:40026      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.17:40126      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.34:49544      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:40058      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.12:41270      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.17:40038      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.18:49466      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:39974      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.32:50900      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:39830      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.18:49326      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.33:37834      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:39886      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:39922      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.12:41180      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:39832      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.13:36704      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:40054      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.17:39956      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:40086      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.17:40124      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.17:40098      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:40084      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.31:57998      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:39970      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.14:44922      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.19:40030      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.33:37838      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.31:58000      ESTABLISHED
		tcp        0      0 192.168.1.35:27017      192.168.1.18:49350      ESTABLISHED
		unix  2      [ ACC ]     STREAM     LISTENING     118691   /data/mongodb/mongodb-27017.sock



4. 相关参考
	https://www.cnblogs.com/bokejiayuan/p/4212662.html   关于MongoDB最大连接数的查看与修改
	https://mongoing.com/archives/3145   为什么 MongoDB 连接数被用满了？
	https://blog.csdn.net/qq_33412610/article/details/75844260  数据库最大连接池Max Pool Size





