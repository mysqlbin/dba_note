
基本原理：
	通过 keepalived 监控主库 mysqld 的存活，当监控到 mysqld 宕机，则把虚拟IP也就是VIP挂载到从库上，这时候从库接管服务，这些步骤不需要人为干预。

需要人为干预的地方：
	1. 修复宕机的主库
	2. 把宕机的主库指向新的主库，成为从库
	
	
脑裂问题：
	VIP 分别挂载在 主库和从库上，出现双写。

解决办法：
	
	每个keepalived的节点都执行一个定时任务的脚本，定时去ping网关，累计失败次数超过指定次数，则关闭自身的keepalived服务并发邮件通知。这样就不会出现脑裂的情况。	
	
	[root@localhost ~]# ping 192.168.0.242 -w 1
	PING 192.168.0.242 (192.168.0.242) 56(84) bytes of data.
	64 bytes from 192.168.0.242: icmp_seq=1 ttl=64 time=0.026 ms

	--- 192.168.0.242 ping statistics ---
	1 packets transmitted, 1 received, 0% packet loss, time 0ms
	rtt min/avg/max/mdev = 0.026/0.026/0.026/0.000 ms


小结：
	基于 keepalived 的高可用方式，简单不要太简单。
	
	