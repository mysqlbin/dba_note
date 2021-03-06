

Keepalived简介:
	keep alive ： 保持存活
	检测服务器的状态
	
    Keepalived的作用是检测服务器的状态，如果有一台服务器宕机，
	或工作出现故障，Keepalived将检测到，并将有故障的服务器从系统中剔除，
	同时使用其它服务器代替该服务器的工作，当服务器工作正常后Keepalived自动将服务器加入到服务器群中，
	这些工作全部自动完成，不需要人工干涉，需要人工做的只是修复故障的服务器。

Keepalived 多节点之间的高可用原理:
	1. 利用VRRP协议实现(虚拟路由冗余协议), 组内的master会向backup(备用/从库)节点发送广播
	2. 当backup收不到 master 发送的 vrrp（协议包） 包时,会认为 master down掉
	3. 这时会根据 vrrp的优先级选举出来一个backup提升为 master, 持有VIP.
	
VRRP约束:

	1. 一个VRRP需要一个唯一的路由标识VRID: 0-255之间
	
	2. VRRP广播: 使用IP多播数据包进行封装, 组地址为 224.0.0.18, 发布只限于一个局域网内, 只有主才能发送广播
		backup在连续三个广播间隔里还没收到 VRRP包或者是收到优先级为0的包,则启动新的一轮VRRP选举
		
	3. VRRP中的优先级: 0-255之间
		当前 master优先级最高: 为255, 0是master放弃VIP持有, backup会发起自动选举
		所以可配的优先级范围: 1-254, 高优先级的在选举中更容易成为Master
		
	4. VRPP认证: 同一组机器里的VRID必须一致, 另外需要提供相同的明文密码
	

几个关键参数(notify)：
	notify_master ： 状态改变为master以后执行的脚本。

	notify_backup :  状态改变为backup以后执行的脚本。

	notify_fault :  状态改变为fault后执行的脚本。

	notify_stop :   VRRP停止以后执行的脚本。

	state backup ：我们都设置为了backup，就是为了发生故障以后不会自动切换。

	nopreempt ： 不进行抢占操作
	
	
其中用到了这4个脚本：：
	master.sh
	backup.sh
	mysql_check.sh
	stop.sh

	mysql_check.sh:
		是为了检查mysqld进程是否存活的脚本，当发现连接不上mysql，自动把keepalived进程干掉（释放VIP, 防止脑裂，防止双写），让VIP进行漂移。
		
	master.sh:
		作用是状态改为master以后执行的脚本。
		首先判断复制是否有延迟，如果有延迟，等1分钟后，不论是否有延迟。都跳过，并停止复制。记录binlog和pos点。
		-- 临时主从延迟，是必须要有的。
		脚本中检查复制是否延时的思想如下：
			1、首先看 Relay_Master_Log_File 和 Master_Log_File 是否有差异
			2、如果 Relay_Master_Log_File 和 Master_Log_File 有差异的话，那说明延迟很大了
			3、如果 Relay_Master_Log_File 和 Master_Log_File 没有差异，再来看 Exec_Master_Log_Pos 和 Read_Master_Log_Pos 的差异

			而不是通过Seconds_Behind_Master去判断，该值表示slave上SQL线程和IO线程之间的延迟，实际上还要考虑到 Master_Log_File 和 Relay_Master_Log_File 是否有差距，
			更严谨的则是要同时在master上执行show master status进行对比。
			这也是MHA在切换过程中可以做到的。
			MMM的切换也只是在从库上执行了show slave status。所以数据一致性要求还是MHA给力。
			 
	backup.sh:
		脚本的作用是状态改变为backup以后执行的脚本

	stop.sh:
		表示 keepalived 停止以后需要执行的脚本。检查是否还有写入操作，最后无论是否执行完毕，都退出。
		

防止脑裂:

	1. 配置文件:
		nopreempt             # 不抢占
		priority 100          # 设置优先级/权重, 避免来回切换.
			
		参数设置为非抢占模式，同时设置优先级也就是权重，避免来回切换。
		
	2. 检查mysqld进程是否存活的脚本，当发现连接不上mysql，自动把keepalived进程干掉
	
	3. 参考文档: mysql双主+keepalived高可用方案.docx
		每个keepalived的节点都执行一个定时任务的脚本，定时去ping网关，累计失败次数超过阀值次数，则关闭自身的keepalived服务。这样就不会出现脑裂的情况。
		https://www.zhihu.com/question/50997425
		https://www.cnblogs.com/xihuineng/p/10526386.html
		
		
		
  