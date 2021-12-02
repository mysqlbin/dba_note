
版本：
	keepalived-2.0.10
	https://www.keepalived.org/download.html
	Keepalived for Linux - Version 2.0.10 - November(11月) 12, 2018 - MD5SUM:={ac93d7eb5b69a9fbf7494fcf27b39ccf}
	
	2019年1月8号上线Keepalived。
	

基本原理：

	通过 keepalived 监控主库 mysqld 的存活，当监控到 mysqld 宕机，自动把主库的keepalived进程杀掉，让VIP进行漂移，这时候从库接管服务，这些步骤不需要人为干预。

需要人为干预的地方：
	1. 修复宕机的主库
	2. 把宕机的主库指向新的主库，成为新的从库
	
	
脑裂问题：
	
	VIP 分别挂载在 主库和从库上，出现双写。

解决脑裂的办法：
	
	https://blog.51cto.com/u_10630401/2089847	keepalived的脑裂问题

	
	每个keepalived的节点都执行一个定时任务的脚本，定时去ping网关，累计失败次数超过指定次数，则关闭自身的keepalived服务并发邮件通知。这样就不会出现脑裂的情况。	
	
	shell> ping 192.168.0.1 -w 1
	PING 192.168.0.1 (192.168.0.1) 56(84) bytes of data.
	64 bytes from 192.168.0.1: icmp_seq=1 ttl=128 time=0.955 ms

	--- 192.168.0.1 ping statistics ---
	1 packets transmitted, 1 received, 0% packet loss, time 0ms
	rtt min/avg/max/mdev = 0.955/0.955/0.955/0.000 ms
	
	

小结：
	
	基于 keepalived 的高可用方式，简单不要太简单。
	
	ping本地IP是检查自己网卡的设置是否有问题
	
	ping网关是检查自己是否能与局域网主机通信
	
	