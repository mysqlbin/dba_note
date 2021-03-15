#Keepalived 启动及STATE转换分析
吴炳锡
>这里讨论一下keepalived启动及关闭是状态转换及相应的脚本执行
******
***Keepalived启动后状态依赖于 keepalived.conf中配置的state, 下面分别说明***

1. 当state配置是的master状态时，先执行track_script， keepalived试图进入Master状态，参考track_script返回的结果,如果返回成功，则为Master状态，如果失败，进入FAULT状态

		Oct 15 17:15:14 node78 Keepalived[7699]: Starting Keepalived v1.2.7 (12/20,2012)
		Oct 15 17:15:14 node78 Keepalived[7700]: Starting Healthcheck child process, pid=7701
		Oct 15 17:15:14 node78 Keepalived[7699]: Starting Keepalived v1.2.7 (12/20,2012)
		Oct 15 17:15:14 node78 Keepalived[7700]: Starting Healthcheck child process, pid=7701
		Oct 15 17:15:14 node78 Keepalived[7700]: Starting VRRP child process, pid=7702
		....
		Oct 15 17:15:14 node78 Keepalived_healthcheckers[7701]: Configuration is using : 4685 Bytes
		Oct 15 17:15:14 node78 Keepalived_healthcheckers[7701]: Using LinkWatch kernel netlink reflector...
		Oct 15 17:15:14 node78 root: Failed:redis-cli -h 127.0.0.1 -p 6680 PING
		Oct 15 17:15:14 node78 Keepalived_vrrp[7702]: VRRP_Instance(redis1) Transition to MASTER STATE
		Oct 15 17:15:15 node78 Keepalived_vrrp[7702]: VRRP_Instance(redis1) Entering FAULT STATE
		Oct 15 17:15:15 node78 Keepalived_vrrp[7702]: VRRP_Instance(redis1) Now in FAULT state
		Oct 15 17:15:15 node78 root: From notify: INSTANCE redis1 FAULT 90
	
	如果有兄弟在Master状态，track_script返回成功，则接管Master状态，原来的进入BACKUP状态。（线上为两者为 BACKUP 状态）

2. 如果state配置的BACKUP，则直接进入BACKUP状态，如果在不存在Master的情况下，执行track_script,成功进入Master,失败进入FAULT; 在存在MASTER的情况下，保持在BACKUP状态。 

		其中都是BACKUP配置是，会比较priority的大小，同时启动时，较大的prority，会成为首选的Master.


3. FAULT状态是，试图进入Master没成功时才会进入Fault状态。[所以也能解释： 为什么BACKUP在存在Master的时，只会进入BACKUP状态]，在FAULT状时不会接管VIP。

4. Keepalived正常退出，会进入stop state,提前会把VIP释放掉，如果keepalived补Kill掉，那么VIP不会被释放。



##总结
对于Keepalived双方都是配置的state ***BACKUP***状态的情况下，不能适用于对于数据有持久化要求的场景（原因先启动Redis在启动Keepalived都需要先执行一个notify_backup脚本）

场景1： 指定主从启动 RedisA->RedisB
	 
	  启动Redis A上Keepalived的进入BACKUP状态，执行notify_backup, 变为RedisB的从
	  启动Redis B上keepalived的进入BACKUP状态，执行notfiy_backup，变为Redis A的从
	  
	     Note: 这个阶段很有可能出现互为主从的结构，然后Redis不响应写，响应读也很慢，任何命令都会很慢，大的量的访问有可能会挂掉。
	  
	  直致最终两者出现一个升级为master ,执行notify_master
	
避免方法：
	在Redis双方都挂掉，或是都重新启动时，先起动一个节点，保证第一个节起为Master状态，VIP接管成功后，再起另一个状态。


场景2： 双方起动后两边都有VIP，但主从关系正常
	
		原因： 一方的keepalived被kill掉后，另一方起动keepalived，接管了vip,但原来的VIP没释放，故障的keepalived启动后，进入backup状态VIP没清理造成的。
		但通信上，应该是以接管的为主。
		
		处理办法：确定KEEPALIVED相应的INSTANCE的状态后，手工释放那个无效的VIP。
	
场景3：两边都有VIP，主从关系不正常）
	
		原因：
		Master/Slave网络有问题，双方联系不上对方了，各自认为是自已是主了。
		如原来的BACKUP和MASTER网络之间有问题，BACKUP接收到MASTER发来的通知包时，BACKUP就会升级新的主服务器。 这样就出现了两边都有VIP，STATE都MASTER的状态。
		
		企望这种情况下保持不动：
		
		处理办法：
		在MASTER状态下，vrrp_script只检测自已的监管的进程（Redis）是否存在或是INFO输出是否正常。
		在Slave状态下,vrrp_script要做两个检测： 
		 自已的网络是否正常 依赖是不是能PING通网关
		 在检测是监管的进程是不是正常
		 全OK，exit 0具备进入Master状态，如果任一不OK，exit 1在期望接管理时，会进入FAULT状态

场景4： FAULT->MASTER的过程

	在配置为state BACKUP下，当keepalived满足从FAULT进入MASTER时(vrrp_script返回成功），KEEPALIVED会先进入BACKUP状态，执行notfiy_backukp,然后在进入MASTER状态。
			
		
		