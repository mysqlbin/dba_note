
卸载：
	1. 删除
	
		[root@iZbp1co0b2dkojjkbk7r8cZ data]# cd /usr/local/bin/
		[root@iZbp1co0b2dkojjkbk7r8cZ bin]# ll
		total 32852
		-rwxr-xr-x 1 root root 4365944 Feb 15 14:49 redis-benchmark
		-rwxr-xr-x 1 root root 8151920 Feb 15 14:49 redis-check-aof
		-rwxr-xr-x 1 root root 8151920 Feb 15 14:49 redis-check-rdb
		-rwxr-xr-x 1 root root 4807160 Feb 15 14:49 redis-cli
		lrwxrwxrwx 1 root root      12 Feb 15 14:49 redis-sentinel -> redis-server
		-rwxr-xr-x 1 root root 8151920 Feb 15 14:49 redis-server

		rm -f /usr/local/bin/redis*


	2. 删除
	
		[root@iZbp1co0b2dkojjkbk7r8cZ local]# pwd
		/usr/local
		[root@iZbp1co0b2dkojjkbk7r8cZ local]# ll
		total 652952
		drwxr-xr-x  7 root  root       4096 Feb 15 03:01 aegis
		drwxr-xr-x. 2 root  root       4096 Feb 15 14:49 bin
		drwxr-xr-x. 2 root  root       4096 Apr 11  2018 etc
		drwxr-xr-x. 2 root  root       4096 Apr 11  2018 games
		drwxr-xr-x. 2 root  root       4096 Apr 11  2018 include
		drwxr-xr-x. 2 root  root       4096 Apr 11  2018 lib
		drwxr-xr-x. 2 root  root       4096 Apr 11  2018 lib64
		drwxr-xr-x. 2 root  root       4096 Apr 11  2018 libexec
		drwxr-xr-x  9 mysql mysql      4096 Feb 14 19:17 mysql
		-rw-r--r--  1 root  root  666559924 Feb 14 18:41 mysql-5.7.36-linux-glibc2.12-x86_64.tar.gz
		drwxrwxr-x  6 root  root       4096 Oct  4 18:58 redis
		-rw-r--r--  1 root  root    2000179 Feb 14 22:23 redis-5.0.14.tar.gz
		drwxr-xr-x. 2 root  root       4096 Apr 11  2018 sbin
		drwxr-xr-x. 7 root  root       4096 Nov 30 15:18 share
		drwxr-xr-x. 2 root  root       4096 Apr 11  2018 src
			
		rm -rf redis/

	
	

名称 				版本
Port 				6379
Config file 		/data/redis/6379/conf/redis.conf     -- 已指定
logfile			    /data/redis/6379/data/redis_6379.log -- 已指定 
dir 				/data/redis/6379/data				 -- 已指定	
Executable 			/usr/local/bin/redis-server
Cli Executable 	    /usr/local/bin/redis-cli
pidfile             /data/redis/6379/6379.pid            -- 已指定


1. 下载安装包并上传到  /usr/local 目录下并解压
	
	redis-4.0.9.tar.gz
	
	tar zxvf redis-4.0.9.tar.gz
	

	
2. 创建数据和配置文件目录

	mkdir /data/redis/6379/data -pv
	cd /data/redis/6379
	mkdir conf 
	cp  /usr/local/redis-4.0.9/redis.conf /data/redis/6379/conf
	

3. 安装 Redis
	cd /usr/local/redis-4.0.9/src/
	make MALLLOC=jemalloc  # 内存算法
	make install

4. 启动和关闭 Redis
	
	启动:
		redis-server /data/redis/6379/conf/redis.conf
		
	关闭:
		redis-cli -h 192.168.0.112 shutdown
			6158:M 11 Nov 11:51:18.155 # User requested shutdown...
			6158:M 11 Nov 11:51:18.155 * Calling fsync() on the AOF file.
			6158:M 11 Nov 11:51:18.157 * Saving the final RDB snapshot before exiting.
			6158:M 11 Nov 11:51:18.160 * DB saved on disk
			6158:M 11 Nov 11:51:18.160 * Removing the pid file.
			6158:M 11 Nov 11:51:18.160 # Redis is now ready to exit, bye bye...


5. 查看启动日志:
	[root@redis02 data]# tail -f /data/redis/6379/data/redis_6379.log
	6315:C 11 Nov 11:52:50.539 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
	6315:C 11 Nov 11:52:50.540 # Redis version=4.0.9, bits=64, commit=00000000, modified=0, pid=6315, just started
	6315:C 11 Nov 11:52:50.540 # Configuration loaded
	6316:M 11 Nov 11:52:50.543 * Increased maximum number of open files to 10032 (it was originally set to 1024).
					_._                                                  
			   _.-``__ ''-._                                             
		  _.-``    `.  `_.  ''-._           Redis 4.0.9 (00000000/0) 64 bit
	  .-`` .-```.  ```\/    _.,_ ''-._                                   
	 (    '      ,       .-`  | `,    )     Running in standalone mode
	 |`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
	 |    `-._   `._    /     _.-'    |     PID: 6316
	  `-._    `-._  `-./  _.-'    _.-'                                   
	 |`-._`-._    `-.__.-'    _.-'_.-'|                                  
	 |    `-._`-._        _.-'_.-'    |           http://redis.io        
	  `-._    `-._`-.__.-'_.-'    _.-'                                   
	 |`-._`-._    `-.__.-'    _.-'_.-'|                                  
	 |    `-._`-._        _.-'_.-'    |                                  
	  `-._    `-._`-.__.-'_.-'    _.-'                                   
		  `-._    `-.__.-'    _.-'                                       
			  `-._        _.-'                                           
				  `-.__.-'                                               

	6316:M 11 Nov 11:52:50.545 # WARNING: The TCP backlog setting of 511 cannot be enforced because /proc/sys/net/core/somaxconn is set to the lower value of 128.
	6316:M 11 Nov 11:52:50.545 # Server initialized
	6316:M 11 Nov 11:52:50.545 # WARNING overcommit_memory is set to 0! Background save may fail under low memory condition. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
	6316:M 11 Nov 11:52:50.545 # WARNING you have Transparent Huge Pages (THP) support enabled in your kernel. This will create latency and memory usage issues with Redis. To fix this issue run the command 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' as root, and add it to your /etc/rc.local in order to retain the setting after a reboot. Redis must be restarted after THP is disabled.
	6316:M 11 Nov 11:52:50.545 * Ready to accept connections

	
6. 使用密码策略:
	
	1. 在主库动态设置密码:
	设置密码:
		config set requirepass 123456
	查看密码:
		192.168.0.111:6379> config get requirepass
		(error) NOAUTH Authentication required.
	使用密码登录:
		[root@mha01 src]# redis-cli -h 192.168.0.111 -a 123456
		
		192.168.0.111:6379> ping
		PONG
	
	再次查看密码:
		192.168.0.111:6379> config get requirepass
		1) "requirepass"
		2) "123456"

	
	此时从库的状态:

		16058:S 12 Nov 09:19:03.402 * Connecting to MASTER 192.168.0.111:6379
		16058:S 12 Nov 09:19:03.402 * MASTER <-> SLAVE sync started
		16058:S 12 Nov 09:19:03.402 * Non blocking connect for SYNC fired the event.
		16058:S 12 Nov 09:19:03.403 * Master replied to PING, replication can continue...
		16058:S 12 Nov 09:19:03.403 * (Non critical) Master does not understand REPLCONF listening-port: -NOAUTH Authentication required.
		16058:S 12 Nov 09:19:03.404 * (Non critical) Master does not understand REPLCONF capa: -NOAUTH Authentication required.
		16058:S 12 Nov 09:19:03.404 * Partial resynchronization not possible (no cached master)
		16058:S 12 Nov 09:19:03.405 # Unexpected reply to PSYNC from master: -NOAUTH Authentication required.
		16058:S 12 Nov 09:19:03.405 * Retrying with SYNC...
		16058:S 12 Nov 09:19:03.405 # MASTER aborted replication with an error: NOAUTH Authentication required.

	
	解决办法:
		在从库设置: 
			192.168.0.112:6379> config set masterauth 123456
			并且加入到配置文件中:
				masterauth 123456
	
		相关参考:
			https://blog.csdn.net/mameng1988/article/details/86688012  redis设置密码后如何实现主从复制
			 
