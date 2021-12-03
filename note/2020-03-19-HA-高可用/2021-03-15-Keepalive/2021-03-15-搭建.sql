
大纲: 
	1. keepalived 环境
	2. 先建立主从关系
	3. keepalived软件安装（主从操作一样）
	4. 安装和配置keeplived(主从都要)
	5. keepalived --help
	6. 主库和从库都要 启动 keepalived, 并查看系统日志 messages
	7. 查看 VIP挂载在哪一台：
	  7.1 从操作系统上看:
	  7.2 从MySQL 数据库上看:
	8. 测试
		8.1 测试 VIP所在节点 mysql shutdown
	9. 什么情况下能启动keepalived
	10. Keepalived的启动流程：
	11. 相关参考
	12. 创建可以用登录VIP所在节点的账号
	13. Note
	
	Nov 14 14:45:32 kp04 Keepalived_vrrp[5749]: VRRP_Script(check_run) succeeded
			Nov 14 14:45:32 kp04 Keepalived_vrrp[5749]: (VI_1) Entering BACKUP STATE
			Nov 14 14:45:32 kp04 Keepalived_vrrp[5749]: VRRP_Group(VG1) Syncing instances to BACKUP state
			Nov 14 14:45:47 kp04 Keepalived_vrrp[5749]: (VI_1) Receive advertisement timeout
			Nov 14 14:45:47 kp04 Keepalived_vrrp[5749]: (VI_1) Entering MASTER STATE
			Nov 14 14:45:47 kp04 Keepalived_vrrp[5749]: (VI_1) setting VIPs.
	

	14. 相关错误和解决
		14.1 错误1 	
		14.2 错误2	

	15. 小结
	

1. keepalived 环境
	主从模式
	hostname    主机IP        端口号 通信端口号(server-id)    server_uuid                                   MySQL版本       Role
	kp04        192.168.0.91  3306   330691					  bebc6d54-fc75-11e9-8ea8-080027e2e489		    MySQL 8.0.18    Master  
	kp05        192.168.0.92  3306   330692									                                MySQL 8.0.18    Slave
	VIP         192.168.0.93
	
2. 先建立主从关系
	
	master 授权
		reset master;     # 两台都是新的实例, 数据一致, 但是GTID不一致, 可以先在主库执行 reset master, 清空 GTID信息和binlog信息.
		create user keepalived@'192.168.0.%' identified by '123456abc';
		grant replication slave on *.* to keepalived@'192.168.0.%';
		
	slave 建立连接:	
		change master to master_host='192.168.0.91', master_port=3306, master_user='keepalived', master_password='123456abc', master_auto_position=1;
		Start slave;
			
	# Last_IO_Error: error connecting to master 'keepalived@192.168.0.92:3306' - retry-time: 60 retries: 1 message: Authentication plugin 'caching_sha2_password' reported error: Authentication requires secure connection.
	
	解决办法1:
		ALTER USER 'keepalived'@'192.168.0.%' IDENTIFIED WITH caching_sha2_password BY '123456abc';
		
		# failed
		
	解决办法2:
		ALTER USER 'keepalived'@'192.168.0.%' IDENTIFIED BY '123456abc' PASSWORD EXPIRE NEVER; #修改加密规则 
		ALTER USER 'keepalived'@'192.168.0.%' IDENTIFIED WITH mysql_native_password BY '123456abc'; #更新一下用户密码 
		
		# OK

		
3.keepalived软件安装（主从操作一样）

	[root@kp04 keepalived-2.0.19]# pwd
	/data/keepalived-2.0.19

	./configure && make && make install

	参考:
		[root@mysql-server-01 keepalived]# cp /usr/local/etc/rc.d/init.d/keepalived /etc/rc.d/init.d/
		[root@mysql-server-01 keepalived]# cp /usr/local/etc/sysconfig/keepalived /etc/sysconfig/
		[root@mysql-server-01 keepalived]# mkdir /etc/keepalived
		[root@mysql-server-01 keepalived]# cp /usr/local/etc/keepalived/keepalived.conf /etc/keepalived/
		[root@mysql-server-01 keepalived]# cp /usr/local/sbin/keepalived /usr/sbin/
		[root@mysql-server-01 keepalived]# chkconfig --add keepalived
		[root@mysql-server-01 keepalived]# chkconfig --level 345 keepalived on


	实际使用:
		shell> find / -name keepalived
		/etc/selinux/targeted/active/modules/100/keepalived
		/usr/local/etc/keepalived
		/usr/local/etc/sysconfig/keepalived
		/usr/local/sbin/keepalived
		/usr/local/share/doc/keepalived
		/data/keepalived-2.0.19/keepalived
		/data/keepalived-2.0.19/keepalived/etc/sysconfig/keepalived
		/data/keepalived-2.0.19/keepalived/etc/openrc/keepalived
		/data/keepalived-2.0.19/keepalived/etc/keepalived
		/data/keepalived-2.0.19/keepalived/etc/init.d/keepalived
		/data/keepalived-2.0.19/keepalived/keepalived
		/data/keepalived-2.0.19/bin/keepalived


		shell> cp /data/keepalived-2.0.19/keepalived/etc/init.d/keepalived /etc/rc.d/init.d/
		shell> cp /usr/local/etc/sysconfig/keepalived /etc/sysconfig/


		shell> find / -name keepalived.conf
		/usr/local/etc/keepalived/keepalived.conf
		/data/keepalived-2.0.19/keepalived/etc/keepalived/keepalived.conf
		
		shell> mkdir /etc/keepalived
		shell> cp /usr/local/etc/keepalived/keepalived.conf /etc/keepalived/
		shell> cp /usr/local/sbin/keepalived /usr/sbin/
		shell> chkconfig --add keepalived
		shell> chkconfig --level 345 keepalived on
		Note: Forwarding request to 'systemctl enable keepalived.service'.
		Created symlink from /etc/systemd/system/multi-user.target.wants/keepalived.service to /usr/lib/systemd/system/keepalived.service.


4. 安装和配置keeplived(主从都要)
    shell> yum install MySQL-python.x86_64
	shell> pwd
		//etc/keepalived
	shell> ll
		total 12
		-rwxr-xr-x. 1 root root 1789 Nov  1 15:56 checkMySQL.py
		-rw-r--r--. 1 root root  684 Nov  1 15:57 keepalived.conf
		-rw-r--r--. 1 root root 3550 Nov  1 12:20 keepalived.conf_bak

	shell> /etc/keepalived/checkMySQL.py -h 127.0.0.1 -P 3306
	shell> echo $? 
	0 
	# 返回0， 说明正常， 因为keepalived的脚本检测，成功检测的返回值状态是0

	shell> /etc/keepalived/checkMySQL.py -h 127.0.0.1 -P 3307
	error
	# 返回 error, 说明是有问题。
 

5. keepalived --help
	[root@kp04 keepalived]# keepalived --help
	Usage: keepalived [OPTION...]
	  -f, --use-file=FILE          Use the specified configuration file
	  -P, --vrrp                   Only run with VRRP subsystem
	  -C, --check                  Only run with Health-checker subsystem
		  --all                    Force all child processes to run, even if have no configuration
	  -l, --log-console            Log messages to local console
	  -D, --log-detail             Detailed log messages
	  -S, --log-facility=[0-7]     Set syslog facility to LOG_LOCAL[0-7]
	  -G, --no-syslog              Don't log via syslog
	  -u, --umask=MASK             umask for file creation (in numeric form)
	  -X, --release-vips           Drop VIP on transition from signal.
	  -V, --dont-release-vrrp      Don't remove VRRP VIPs and VROUTEs on daemon stop
	  -I, --dont-release-ipvs      Don't remove IPVS topology on daemon stop
	  -R, --dont-respawn           Don't respawn child processes
	  -n, --dont-fork              Don't fork the daemon process
	  -d, --dump-conf              Dump the configuration data
	  -p, --pid=FILE               Use specified pidfile for parent process
	  -r, --vrrp_pid=FILE          Use specified pidfile for VRRP child process
	  -c, --checkers_pid=FILE      Use specified pidfile for checkers child process
	  -a, --address-monitoring     Report all address additions/deletions notified via netlink
	  -s, --namespace=NAME         Run in network namespace NAME (overrides config)
	  -m, --core-dump              Produce core dump if terminate abnormally
	  -M, --core-dump-pattern=PATN Also set /proc/sys/kernel/core_pattern to PATN (default 'core')
	  -i, --config-id id           Skip any configuration lines beginning '@' that don't match id
									or any lines beginning @^ that do match.
									The config-id defaults to the node name if option not used
		  --signum=SIGFUNC         Return signal number for STOP, RELOAD, DATA, STATS
	  -t, --config-test[=LOG_FILE] Check the configuration for obvious errors, output to
									stderr by default
	  -v, --version                Display the version number
	  -h, --help                   Display this help message

	  
6. 主库和从库都要 启动 keepalived, 并查看系统日志 messages
	# 192.168.0.91
	[root@kp04 keepalived]# /etc/init.d/keepalived start
	Starting keepalived (via systemctl):                       [  OK  ]
		
		[root@kp04 keepalived]# tail -f /var/log/messages  
			Nov 14 14:45:32 kp04 systemd: Starting LVS and VRRP High Availability Monitor...
			Nov 14 14:45:32 kp04 Keepalived[5747]: Starting Keepalived v2.0.19 (10/19,2019)
			Nov 14 14:45:32 kp04 Keepalived[5747]: Running on Linux 3.10.0-693.el7.x86_64 #1 SMP Tue Aug 22 21:09:27 UTC 2017 (built for Linux 3.10.0)
			Nov 14 14:45:32 kp04 Keepalived[5747]: Command line: '/usr/local/sbin/keepalived' '-D'
			Nov 14 14:45:32 kp04 Keepalived[5747]: Opening file '/etc/keepalived/keepalived.conf'.
			Nov 14 14:45:32 kp04 systemd: PID file /run/keepalived.pid not readable (yet?) after start.
			Nov 14 14:45:32 kp04 Keepalived[5748]: Starting VRRP child process, pid=5749
			Nov 14 14:45:32 kp04 systemd: Started LVS and VRRP High Availability Monitor.
			Nov 14 14:45:32 kp04 Keepalived_vrrp[5749]: Registering Kernel netlink reflector
			Nov 14 14:45:32 kp04 Keepalived_vrrp[5749]: Registering Kernel netlink command channel
			Nov 14 14:45:32 kp04 Keepalived_vrrp[5749]: Opening file '/etc/keepalived/keepalived.conf'.
			Nov 14 14:45:32 kp04 Keepalived_vrrp[5749]: Sync group VG1 has only 1 virtual router(s) - this probably isn t what you want
			Nov 14 14:45:32 kp04 Keepalived_vrrp[5749]: Assigned address 192.168.0.91 for interface enp0s3
			Nov 14 14:45:32 kp04 Keepalived_vrrp[5749]: Assigned address fe80::a00:27ff:fe52:19f4 for interface enp0s3
			Nov 14 14:45:32 kp04 Keepalived_vrrp[5749]: Registering gratuitous ARP shared channel
			Nov 14 14:45:32 kp04 Keepalived_vrrp[5749]: (VI_1) removing VIPs.
			Nov 14 14:45:32 kp04 Keepalived_vrrp[5749]: VRRP sockpool: [ifindex(2), family(IPv4), proto(112), unicast(0), fd(11,12)]
			Nov 14 14:45:32 kp04 Keepalived_vrrp[5749]: VRRP_Script(check_run) succeeded
			Nov 14 14:45:32 kp04 Keepalived_vrrp[5749]: (VI_1) Entering BACKUP STATE
			Nov 14 14:45:32 kp04 Keepalived_vrrp[5749]: VRRP_Group(VG1) Syncing instances to BACKUP state
			Nov 14 14:45:47 kp04 Keepalived_vrrp[5749]: (VI_1) Receive advertisement timeout
			Nov 14 14:45:47 kp04 Keepalived_vrrp[5749]: (VI_1) Entering MASTER STATE
			Nov 14 14:45:47 kp04 Keepalived_vrrp[5749]: (VI_1) setting VIPs.
			Nov 14 14:45:47 kp04 Keepalived_vrrp[5749]: Sending gratuitous ARP on enp0s3 for 192.168.0.93
			Nov 14 14:45:47 kp04 Keepalived_vrrp[5749]: (VI_1) Sending/queueing gratuitous ARPs on enp0s3 for 192.168.0.93
			Nov 14 14:45:47 kp04 Keepalived_vrrp[5749]: Sending gratuitous ARP on enp0s3 for 192.168.0.93
			Nov 14 14:45:47 kp04 Keepalived_vrrp[5749]: Sending gratuitous ARP on enp0s3 for 192.168.0.93
			Nov 14 14:45:47 kp04 Keepalived_vrrp[5749]: Sending gratuitous ARP on enp0s3 for 192.168.0.93
			Nov 14 14:45:47 kp04 Keepalived_vrrp[5749]: Sending gratuitous ARP on enp0s3 for 192.168.0.93
			Nov 14 14:45:47 kp04 Keepalived_vrrp[5749]: VRRP_Group(VG1) Syncing instances to MASTER state
			Nov 14 14:45:52 kp04 Keepalived_vrrp[5749]: Sending gratuitous ARP on enp0s3 for 192.168.0.93


			
		[root@kp04 keepalived]# ps aux|grep keepalived
		root     22120  0.0  0.0  63312   804 ?        Ss   15:50   0:00 /usr/local/sbin/keepalived -D
		root     22121  0.0  0.0  63312  1700 ?        S    15:50   0:00 /usr/local/sbin/keepalived -D
		root     22184  0.0  0.0 112704   976 pts/1    S+   15:52   0:00 grep --color=auto keepalive

		
	# 192.168.0.92
	[root@kp05 ~]# /etc/init.d/keepalived start
	Starting keepalived (via systemctl):                       [  OK  ]

		[root@kp05 keepalived]# tail -f /var/log/messages

		Nov  1 15:58:53 kp05 systemd: Started Session 7 of user root.
		Nov  1 15:58:53 kp05 systemd-logind: New session 7 of user root.
		Nov  1 15:58:53 kp05 systemd: Starting Session 7 of user root.
		Nov  1 15:59:00 kp05 systemd: Starting LVS and VRRP High Availability Monitor...
		Nov  1 15:59:00 kp05 Keepalived[22200]: Starting Keepalived v2.0.19 (10/19,2019)
		Nov  1 15:59:00 kp05 Keepalived[22200]: Running on Linux 3.10.0-693.el7.x86_64 #1 SMP Tue Aug 22 21:09:27 UTC 2017 (built for Linux 3.10.0)
		Nov  1 15:59:00 kp05 Keepalived[22200]: Command line: '/usr/local/sbin/keepalived' '-D'
		Nov  1 15:59:00 kp05 Keepalived[22200]: Opening file '/etc/keepalived/keepalived.conf'.
		Nov  1 15:59:01 kp05 Keepalived[22201]: Starting VRRP child process, pid=22202
		Nov  1 15:59:01 kp05 systemd: Started LVS and VRRP High Availability Monitor.
		Nov  1 15:59:01 kp05 Keepalived_vrrp[22202]: Registering Kernel netlink reflector
		Nov  1 15:59:01 kp05 Keepalived_vrrp[22202]: Registering Kernel netlink command channel
		Nov  1 15:59:01 kp05 Keepalived_vrrp[22202]: Opening file '/etc/keepalived/keepalived.conf'.
		Nov  1 15:59:01 kp05 Keepalived_vrrp[22202]: WARNING - default user 'keepalived_script' for script execution does not exist - please create.
		Nov  1 15:59:01 kp05 Keepalived_vrrp[22202]: WARNING - script `python` resolved by path search to `/usr/bin/python`. Please specify full path.
		Nov  1 15:59:01 kp05 Keepalived_vrrp[22202]: SECURITY VIOLATION - scripts are being executed but script_security not enabled.
		Nov  1 15:59:01 kp05 Keepalived_vrrp[22202]: Assigned address 192.168.0.92 for interface enp0s3
		Nov  1 15:59:01 kp05 Keepalived_vrrp[22202]: Assigned address fe80::a00:27ff:fea6:62f6 for interface enp0s3
		Nov  1 15:59:01 kp05 Keepalived_vrrp[22202]: Registering gratuitous ARP shared channel
		Nov  1 15:59:01 kp05 Keepalived_vrrp[22202]: (VI_82) removing VIPs.
		Nov  1 15:59:01 kp05 Keepalived_vrrp[22202]: VRRP sockpool: [ifindex(2), family(IPv4), proto(112), unicast(0), fd(11,12)]
		Nov  1 15:59:01 kp05 Keepalived_vrrp[22202]: VRRP_Script(vs_mysql_41) succeeded
		Nov  1 15:59:01 kp05 Keepalived_vrrp[22202]: (VI_82) Entering BACKUP STATE


7. 查看 VIP挂载在哪一台：
  7.1 从操作系统上看:
	[root@kp04 keepalived]# ip addr show
	1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1
		link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
		inet 127.0.0.1/8 scope host lo
		   valid_lft forever preferred_lft forever
		inet6 ::1/128 scope host 
		   valid_lft forever preferred_lft forever
	2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
		link/ether 08:00:27:e2:e4:89 brd ff:ff:ff:ff:ff:ff
		inet 192.168.0.91/24 brd 192.168.0.255 scope global enp0s3
		   valid_lft forever preferred_lft forever
		inet 192.168.0.93/32 scope global enp0s3
		   valid_lft forever preferred_lft forever
		inet6 fe80::cb5b:b7fc:94c0:6a41/64 scope link 
		   valid_lft forever preferred_lft forever


  7.2 从MySQL 数据库上看:
	
	授权 账号:
		create user test_user@'192.168.0.%' identified by '123456abc';
		grant all privileges on *.* to test_user@'192.168.0.%';
		ALTER USER 'test_user'@'192.168.0.%' IDENTIFIED BY '123456abc' PASSWORD EXPIRE NEVER; #修改加密规则 
		ALTER USER 'test_user'@'192.168.0.%' IDENTIFIED WITH mysql_native_password BY '123456abc'; #更新一下用户密码 
		   
	登录:
		[root@kp04 keepalived]# mysql -h192.168.0.93 -utest_user -p123456abc
		mysql> select @@hostname;
		  
		+------------+
		| @@hostname |
		+------------+
		| kp04       |
		+------------+
		1 row in set (0.00 sec)

	# 说明了 VIP在 kp04 这个节点上


把脚本转换 Unix格式：	
	shell> dos2unix backup.sh master.sh stop.sh 
	dos2unix: converting file backup.sh to Unix format ...
	dos2unix: converting file master.sh to Unix format ...
	dos2unix: converting file stop.sh to Unix format ...



8. 测试:
8.1 测试 VIP所在节点 mysql shutdown
	在 kp04 上执行:
		shell> /etc/init.d/mysql stop
		
		shell> tail -f /var/log/messages
			Nov  1 16:32:22 kp04 Keepalived_vrrp[22121]: Script `vs_mysql_41` now returning 1
			Nov  1 16:32:22 kp04 Keepalived_vrrp[22121]: VRRP_Script(vs_mysql_41) failed (exited with status 1)
			Nov  1 16:32:22 kp04 Keepalived_vrrp[22121]: (VI_82) Entering FAULT STATE
			Nov  1 16:32:22 kp04 Keepalived_vrrp[22121]: (VI_82) sent 0 priority
			Nov  1 16:32:22 kp04 Keepalived_vrrp[22121]: (VI_82) removing VIPs.

		shell> ip addr show
			1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1
				link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
				inet 127.0.0.1/8 scope host lo
				   valid_lft forever preferred_lft forever
				inet6 ::1/128 scope host 
				   valid_lft forever preferred_lft forever
			2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
				link/ether 08:00:27:e2:e4:89 brd ff:ff:ff:ff:ff:ff
				inet 192.168.0.91/24 brd 192.168.0.255 scope global enp0s3
				   valid_lft forever preferred_lft forever
				inet6 fe80::cb5b:b7fc:94c0:6a41/64 scope link 
				   valid_lft forever preferred_lft forever

	在 kp05 上查看系统日志:
		shell> tail -f /var/log/messages
			Nov  1 16:36:18 kp05 Keepalived_vrrp[22202]: (VI_82) Backup received priority 0 advertisement
			Nov  1 16:36:18 kp05 Keepalived_vrrp[22202]: (VI_82) Backup received priority 0 advertisement
			Nov  1 16:36:19 kp05 Keepalived_vrrp[22202]: (VI_82) Receive advertisement timeout
			Nov  1 16:36:19 kp05 Keepalived_vrrp[22202]: (VI_82) Entering MASTER STATE
			Nov  1 16:36:19 kp05 Keepalived_vrrp[22202]: (VI_82) setting VIPs.
			Nov  1 16:36:19 kp05 Keepalived_vrrp[22202]: Sending gratuitous ARP on enp0s3 for 192.168.0.93
			Nov  1 16:36:19 kp05 Keepalived_vrrp[22202]: (VI_82) Sending/queueing gratuitous ARPs on enp0s3 for 192.168.0.93
			Nov  1 16:36:19 kp05 Keepalived_vrrp[22202]: Sending gratuitous ARP on enp0s3 for 192.168.0.93
			Nov  1 16:36:19 kp05 Keepalived_vrrp[22202]: Sending gratuitous ARP on enp0s3 for 192.168.0.93
			Nov  1 16:36:19 kp05 Keepalived_vrrp[22202]: Sending gratuitous ARP on enp0s3 for 192.168.0.93
			Nov  1 16:36:19 kp05 Keepalived_vrrp[22202]: Sending gratuitous ARP on enp0s3 for 192.168.0.93
			Nov  1 16:36:24 kp05 Keepalived_vrrp[22202]: Sending gratuitous ARP on enp0s3 for 192.168.0.93
			Nov  1 16:36:24 kp05 Keepalived_vrrp[22202]: (VI_82) Sending/queueing gratuitous ARPs on enp0s3 for 192.168.0.93
			Nov  1 16:36:24 kp05 Keepalived_vrrp[22202]: Sending gratuitous ARP on enp0s3 for 192.168.0.93
			Nov  1 16:36:24 kp05 Keepalived_vrrp[22202]: Sending gratuitous ARP on enp0s3 for 192.168.0.93
			Nov  1 16:36:24 kp05 Keepalived_vrrp[22202]: Sending gratuitous ARP on enp0s3 for 192.168.0.93
			Nov  1 16:36:24 kp05 Keepalived_vrrp[22202]: Sending gratuitous ARP on enp0s3 for 192.168.0.93

		shell> ip addr show
			1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1
				link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
				inet 127.0.0.1/8 scope host lo
				   valid_lft forever preferred_lft forever
				inet6 ::1/128 scope host 
				   valid_lft forever preferred_lft forever
			2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
				link/ether 08:00:27:a6:62:f6 brd ff:ff:ff:ff:ff:ff
				inet 192.168.0.92/24 brd 192.168.0.255 scope global enp0s3
				   valid_lft forever preferred_lft forever
				inet 192.168.0.93/32 scope global enp0s3
				   valid_lft forever preferred_lft forever
				inet6 fe80::a00:27ff:fea6:62f6/64 scope link 
				   valid_lft forever preferred_lft forever		
		
		shell> mysql -h192.168.0.93 -utest_user -p123456abc
		mysql> select @@hostname;
		+------------+
		| @@hostname |
		+------------+
		| kp05       |
		+------------+
		1 row in set (0.00 sec)

	# 说明了 VIP已经飘移了.
	
	
	恢复:
		kp04:
			shell> /etc/init.d/keepalived stop
			shell> /etc/init.d/mysql start
			
			
		kp05:
			mysql> create database test_20191101;
			mysql> use test_20191101;
			Database changed
			mysql> create table t1(a int);
			Query OK, 0 rows affected (0.01 sec)

			mysql> insert into t1 values (1);
			Query OK, 1 row affected (0.00 sec)
		
		kp04:
			mysql> select * from t1;
			+------+
			| a    |
			+------+
			|    1 |
			+------+
			1 row in set (0.00 sec)
		
			mysql> show slave status\G;
			*************************** 1. row ***************************
						   Slave_IO_State: Waiting for master to send event
							  Master_Host: 192.168.0.92
							  Master_User: keepalived
							  Master_Port: 3306
							Connect_Retry: 60
						  Master_Log_File: mysql-bin.000001
					  Read_Master_Log_Pos: 4918
						   Relay_Log_File: kp04-relay-bin.000004
							Relay_Log_Pos: 1072
					Relay_Master_Log_File: mysql-bin.000001
						 Slave_IO_Running: Yes
						Slave_SQL_Running: Yes
					  Exec_Master_Log_Pos: 4918
						  Relay_Log_Space: 1271

			  Replicate_Ignore_Server_Ids: 
						 Master_Server_Id: 330692
							  Master_UUID: e136faa2-eeab-11e9-9494-080027cb3816
						 Master_Info_File: mysql.slave_master_info
								SQL_Delay: 0
					  SQL_Remaining_Delay: NULL
				  Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates 
					   Retrieved_Gtid_Set: e136faa2-eeab-11e9-9494-080027cb3816:6-8
						Executed_Gtid_Set: bebc6d54-fc75-11e9-8ea8-080027e2e489:1-9,
			e136faa2-eeab-11e9-9494-080027cb3816:1-8
							Auto_Position: 1
			1 row in set (0.00 sec)

			ERROR: 
			No query specified

			# 当主从没有延迟, 两台机器的数据一致的时候,就可以启动 keepalive:
			shell> /etc/init.d/keepalived stop

	
9. 什么情况下能启动keepalived:
	Backup接管的前提： 主从没有延迟，两台机器必须要一致。
	如果有延迟还要执行故障切换,可能会有更新丢失的问题。
	主从的gtid一致（数据要一致）
	让vip先别切回来，调整完主从一致后，在启动keepalived，这样更保险
	M1切换到M2，但是M2又挂(MHA也有可能),避免无限地来回切
	
10. Keepalived的启动流程：
	一：Keepalived 运行的三个process进程：
		1：Starting Keepalived 版本 主进程
		2：Healthcheck process 进程
		3：VRRP child process 进程
	二：Vrrp
		先进入Backup State状态，运行一次Vrrp_script 成功后，发现没有主->Master->拉起Vip完成启动	
	
11. 相关参考:
	
	https://www.cnblogs.com/gomysql/p/3856484.html  
	https://blog.csdn.net/wzy0623/article/details/80916567
	https://cloud.tencent.com/developer/article/1416596
	
12. 创建可以用登录VIP所在节点的账号
	create user vip_user@'192.168.0.%' identified by '123456abc';
	grant all privileges on *.* to vip_user@'192.168.0.%';
	ALTER USER 'vip_user'@'192.168.0.%' IDENTIFIED BY '123456abc' PASSWORD EXPIRE NEVER; #修改加密规则 
	ALTER USER 'vip_user'@'192.168.0.%' IDENTIFIED WITH mysql_native_password BY '123456abc'; #更新一下用户密码 

	
13. Note: 

	1. 不需要在 backup.sh 脚本中执行这3个状态:
		/usr/local/mysql/bin/mysql -uroot -p123456abc -S /tmp/mysql.sock -e "set global event_scheduler=0;"
		/usr/local/mysql/bin/mysql -uroot -p123456abc -S /tmp/mysql.sock -e "set global read_only=1;"
		/usr/local/mysql/bin/mysql -uroot -p123456abc -S /tmp/mysql.sock -e "set global super_read_only=1;"

		因为 keepalived 启动后, 会先进入  BACKUP STATE 状态, 这时候会执行  backup.sh 脚本, 执行脚本中的3个状态, 期间业务不能写, 然后再选举出 Master;
		
	2. 故障master的修复:
		set global event_scheduler=0;
		set global read_only=1;
		set global super_read_only=1;
		change master to master_host='192.168.0.91', master_port=3306, master_user='keepalived', master_password='123456abc', master_auto_position=1;
		Start slave;
		show slave status\G;
			 
	


14. 相关错误和解决
	14.1 错误1 	
		[root@kp04 keepalived]# /etc/init.d/keepalived restart
		Restarting keepalived (via systemctl):  Job for keepalived.service failed because the control process exited with error code. See "systemctl status keepalived.service" and "journalctl -xe" for details.
																   [FAILED]
		tail -f /var/log/messages:
			Nov  5 01:44:45 kp04 systemd: Starting LVS and VRRP High Availability Monitor...
			Nov  5 01:44:45 kp04 Keepalived[10285]: Starting Keepalived v2.0.19 (10/19,2019)
			Nov  5 01:44:45 kp04 Keepalived[10285]: Running on Linux 3.10.0-693.el7.x86_64 #1 SMP Tue Aug 22 21:09:27 UTC 2017 (built for Linux 3.10.0)
			Nov  5 01:44:45 kp04 Keepalived[10285]: Command line: '/usr/local/sbin/keepalived' '-D'
			Nov  5 01:44:45 kp04 Keepalived[10285]: Configuration file '/etc/keepalived/keepalived.conf' is not a regular non-executable file
			Nov  5 01:44:45 kp04 Keepalived[10285]: Stopped Keepalived v2.0.19 (10/19,2019)
			Nov  5 01:44:45 kp04 systemd: keepalived.service: control process exited, code=exited status=6
			Nov  5 01:44:45 kp04 systemd: Failed to start LVS and VRRP High Availability Monitor.
			Nov  5 01:44:45 kp04 systemd: Unit keepalived.service entered failed state.
			Nov  5 01:44:45 kp04 systemd: keepalived.service failed.

		[root@kp04 keepalived]# systemctl status keepalived.service
		● keepalived.service - LVS and VRRP High Availability Monitor
		   Loaded: loaded (/usr/lib/systemd/system/keepalived.service; enabled; vendor preset: disabled)
		   Active: failed (Result: exit-code) since Tue 2019-11-05 01:44:45 CST; 46s ago
		  Process: 10285 ExecStart=/usr/local/sbin/keepalived $KEEPALIVED_OPTIONS (code=exited, status=6)
		 Main PID: 9984 (code=exited, status=0/SUCCESS)

		Nov 05 01:44:45 kp04 systemd[1]: Starting LVS and VRRP High Availability Monitor...
		Nov 05 01:44:45 kp04 systemd[1]: keepalived.service: control process exited, code=exited status=6
		Nov 05 01:44:45 kp04 systemd[1]: Failed to start LVS and VRRP High Availability Monitor.
		Nov 05 01:44:45 kp04 systemd[1]: Unit keepalived.service entered failed state.
		Nov 05 01:44:45 kp04 systemd[1]: keepalived.service failed.


		[root@kp04 keepalived]# journalctl -xe
		-- 
		-- The result is failed.
		Nov 05 01:44:03 kp04 systemd[1]: Unit keepalived.service entered failed state.
		Nov 05 01:44:03 kp04 systemd[1]: keepalived.service failed.
		Nov 05 01:44:03 kp04 polkitd[636]: Unregistered Authentication Agent for unix-process:10247:31061609 (system bus name :1.271, object path /org/freedesktop/PolicyKit1/AuthenticationAgent, locale en_US.UTF-8) (disconnected from bus)
		Nov 05 01:44:10 kp04 polkitd[636]: Registered Authentication Agent for unix-process:10262:31062365 (system bus name :1.272 [/usr/bin/pkttyagent --notify-fd 5 --fallback], object path /org/freedesktop/PolicyKit1/AuthenticationAgent, locale en_US.UTF-8)
		Nov 05 01:44:10 kp04 systemd[1]: Starting LVS and VRRP High Availability Monitor...
		-- Subject: Unit keepalived.service has begun start-up
		-- Defined-By: systemd
		-- Support: http://lists.freedesktop.org/mailman/listinfo/systemd-devel
		-- 
		-- Unit keepalived.service has begun starting up.
		Nov 05 01:44:10 kp04 Keepalived[10268]: Starting Keepalived v2.0.19 (10/19,2019)
		Nov 05 01:44:10 kp04 Keepalived[10268]: Running on Linux 3.10.0-693.el7.x86_64 #1 SMP Tue Aug 22 21:09:27 UTC 2017 (built for Linux 3.10.0)
		Nov 05 01:44:10 kp04 Keepalived[10268]: Command line: '/usr/local/sbin/keepalived' '-D'
		Nov 05 01:44:10 kp04 Keepalived[10268]: Configuration file '/etc/keepalived/keepalived.conf' is not a regular non-executable file
		Nov 05 01:44:10 kp04 Keepalived[10268]: Stopped Keepalived v2.0.19 (10/19,2019)
		Nov 05 01:44:10 kp04 systemd[1]: keepalived.service: control process exited, code=exited status=6
		Nov 05 01:44:10 kp04 systemd[1]: Failed to start LVS and VRRP High Availability Monitor.
		-- Subject: Unit keepalived.service has failed
		-- Defined-By: systemd
		-- Support: http://lists.freedesktop.org/mailman/listinfo/systemd-devel
		-- 
		-- Unit keepalived.service has failed.
		-- 
		-- The result is failed.
		Nov 05 01:44:10 kp04 systemd[1]: Unit keepalived.service entered failed state.
		Nov 05 01:44:10 kp04 systemd[1]: keepalived.service failed.
		Nov 05 01:44:10 kp04 polkitd[636]: Unregistered Authentication Agent for unix-process:10262:31062365 (system bus name :1.272, object path /org/freedesktop/PolicyKit1/AuthenticationAgent, locale en_US.UTF-8) (disconnected from bus)
		Nov 05 01:44:45 kp04 polkitd[636]: Registered Authentication Agent for unix-process:10279:31065819 (system bus name :1.273 [/usr/bin/pkttyagent --notify-fd 5 --fallback], object path /org/freedesktop/PolicyKit1/AuthenticationAgent, locale en_US.UTF-8)
		Nov 05 01:44:45 kp04 systemd[1]: Starting LVS and VRRP High Availability Monitor...
		-- Subject: Unit keepalived.service has begun start-up
		-- Defined-By: systemd
		-- Support: http://lists.freedesktop.org/mailman/listinfo/systemd-devel
		-- 
		-- Unit keepalived.service has begun starting up.
		Nov 05 01:44:45 kp04 Keepalived[10285]: Starting Keepalived v2.0.19 (10/19,2019)
		Nov 05 01:44:45 kp04 Keepalived[10285]: Running on Linux 3.10.0-693.el7.x86_64 #1 SMP Tue Aug 22 21:09:27 UTC 2017 (built for Linux 3.10.0)
		Nov 05 01:44:45 kp04 Keepalived[10285]: Command line: '/usr/local/sbin/keepalived' '-D'
		Nov 05 01:44:45 kp04 Keepalived[10285]: Configuration file '/etc/keepalived/keepalived.conf' is not a regular non-executable file
		Nov 05 01:44:45 kp04 Keepalived[10285]: Stopped Keepalived v2.0.19 (10/19,2019)
		Nov 05 01:44:45 kp04 systemd[1]: keepalived.service: control process exited, code=exited status=6
		Nov 05 01:44:45 kp04 systemd[1]: Failed to start LVS and VRRP High Availability Monitor.
		-- Subject: Unit keepalived.service has failed
		-- Defined-By: systemd
		-- Support: http://lists.freedesktop.org/mailman/listinfo/systemd-devel
		-- 
		-- Unit keepalived.service has failed.
		-- 
		-- The result is failed.
		Nov 05 01:44:45 kp04 systemd[1]: Unit keepalived.service entered failed state.
		Nov 05 01:44:45 kp04 systemd[1]: keepalived.service failed.
		Nov 05 01:44:45 kp04 polkitd[636]: Unregistered Authentication Agent for unix-process:10279:31065819 (system bus name :1.273, object path /org/freedesktop/PolicyKit1/AuthenticationAgent, locale en_US.UTF-8) (disconnected from bus)

		原因在这里：
			[root@kp04 keepalived]# ll
			total 8
			-rwxr-xr-x. 1 root root  860 Nov  5  2019 keepalived.conf
			-rwxr-xr-x. 1 root root 3550 Nov  1 12:20 keepalived.conf_bak

		解决办法：
			[root@kp04 keepalived]# chmod 644 *
			[root@kp04 keepalived]# ll
			total 8
			-rw-r--r--. 1 root root  860 Nov  5  2019 keepalived.conf
			-rw-r--r--. 1 root root 3550 Nov  1 12:20 keepalived.conf_bak


	14.2 错误2 	
			
		Nov  5 02:17:41 kp05 Keepalived_vrrp[18080]: WARNING - default user 'keepalived_script' for script execution does not exist - please create.
		Nov  5 02:17:41 kp05 Keepalived_vrrp[18080]: SECURITY VIOLATION - scripts are being executed but script_security not enabled

		 https://blog.csdn.net/qq_35702095/article/details/88575441
		 https://github.com/acassen/keepalived/issues/901
		 
		 script_user keepalived_script                 #指定运行脚本的用户名和组。默认使用用户的默认组。如未指定，默认为 keepalived_script 用户，如无此用户，则使用root
		 enable_script_security                        #如果路径为非root可写，不要配置脚本为root用户执行。
		   
	   

15. 小结

	基于keepalived的高可用，是最简单的一种方式。
	有高可用，总比没有的好。
	现在MySQL的版本越高，故障率就越小。
	
	
	
  
