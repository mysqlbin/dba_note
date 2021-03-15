

https://www.jianshu.com/p/a6b5ab36292a  Keepalived

https://blog.csdn.net/tim_phper/article/details/53334029   Linux正则过滤命令ifconfig/ip提取IP地址

	[root@kp04 scripts]# ip addr show
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
		   
	[root@kp04 scripts]# ip addr show enp0s3 | grep  'inet'
		inet 192.168.0.91/24 brd 192.168.0.255 scope global enp0s3
		inet 192.168.0.93/32 scope global enp0s3
		inet6 fe80::cb5b:b7fc:94c0:6a41/64 scope link 
		
		
	[root@kp04 scripts]# ip addr show enp0s3 | grep  'inet ' | sed 's/^.*inet //g'
	192.168.0.91/24 brd 192.168.0.255 scope global enp0s3
	192.168.0.93/32 scope global enp0s3


	ip addr show enp0s3 | grep  '| grep -v 127.0.0.1' | sed 's/^.*inet //g'



