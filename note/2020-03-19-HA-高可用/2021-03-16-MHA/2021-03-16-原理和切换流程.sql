
1. MHA的介绍	
2. 优点
3. 高可用架构MHA有什么样的不足和风险点
4. 基本工作原理
5. MHA切换原理的5个阶段
6. 具体切换流程
7. 自己的一些总结/精髓
8. 关于MHA+GTID		
	

1. MHA的介绍
	
	该软件由两部分组成：MHA Manager（管理节点）和MHA Node（数据节点）。
		MHA Manager 可以单独部署在一台独立的机器上管理多个master-slave集群，也可以部署在一台slave节点上。
		MHA Node 运行在每台MySQL服务器上，MHA Manager会定时探测集群中的master节点，当master出现故障时，它可以自动将最新数据的slave提升为新的master，然后将所有其他的slave重新指向新的master。
		
		整个故障转移过程对应用程序完全透明。
		MHA由Node和Manager组成，Node运行在每一台MySQL服务器上，也就是说，不管是MySQL主服务器，还是MySQL从服务器，都要安装Node，而Manager通常运行在独立的服务器上，
		但如果硬件资源吃紧，也可以用一台MySQL从服务器来兼职Manager的角色。

	在MHA自动故障切换过程中，MHA试图从宕机的主服务器上保存二进制日志，最大程度的保证数据的不丢失，但这并不总是可行的。
		例如，如果主服务器硬件故障或无法通过ssh访问，MHA没法保存二进制日志，只进行故障转移而丢失了最新的数据。
		使用MySQL 5.5的半同步复制，可以大大降低数据丢失的风险。MHA可以与半同步复制结合起来。
		如果只有一个slave已经收到了最新的二进制日志，MHA可以将最新的二进制日志应用于其他所有的slave服务器上，因此可以保证所有节点的数据一致性。
		
	MHA软件由两部分组成，Manager工具包和Node工具包，具体的说明如下。

		Manager工具包主要包括以下几个工具：

			masterha_check_ssh              检查MHA的SSH配置状况
			masterha_check_repl             检查MySQL复制状况
			masterha_manger                 启动MHA
			masterha_check_status           检测当前MHA运行状态
			masterha_master_monitor         检测master是否宕机
			masterha_master_switch          控制故障转移（自动或者手动）
			masterha_conf_host              添加或删除配置的server信息

		Node工具包（这些工具通常由MHA Manager的脚本触发，无需人为操作）主要包括以下几个工具：

			save_binary_logs                保存和复制master的二进制日志
			apply_diff_relay_logs           识别差异的中继日志事件并将其差异的事件应用于其他的slave
			filter_mysqlbinlog              去除不必要的ROLLBACK事件（MHA已不再使用这个工具）
			purge_relay_logs                清除中继日志（不会阻塞SQL线程）
		
		MHA分为manager和node两部分：
			manager启动后主要负责检测master状态，以及触发切换动作
			node无需启动任何后台进程只包含日志维护脚本。
	

2. 优点

	MHA是开源高可用方案中最好的一种，它最重要的特点就是支持binlog补偿和relay log补偿。
	在基于复制实现高可用架构，最大的问题就是复制是异步的，怎么在主从有延迟的环境下实现切换时不丢失数据，MHA第一个做到了，但它做的还不够好。
	了解MHA原理的朋友应该知道MHA分为manager和node两部分，manager启动后主要负责检测master状态，以及触发切换动作，node无需启动任何后台进程只包含日志维护脚本。
	当mysql master服务退出时，manager通过ssh方式调用数据库主机上的一些脚本完成日志补偿(如有延迟差异)，将主从切换流程完全自动，并且加上binlog补偿能力，这在当时已经是非常好的方案了，所以应用的也特别广。
	

3. 高可用架构MHA有什么样的不足和风险点

	MHA作为传统复制下的高可用霸主，在今天的GTID环境下，开始慢慢走向没落，更多的人开始开始选择replication-manager或者orchestrator等高可用解决方案
	不足及风险点：
		1、failover依赖于外部脚本，比如VIP切换需要自己编写脚本实现
		2、MHA启动后只检测主库是否正常，并不检查从库状态及主从延迟
		3、需要基于SSH免认证配置，存在一定的安全隐患
		4、没有提供从服务器的读负载均衡功能
		5、从节点出现宕机等异常并没有能力处理，即没有从库故障转移能力
		6、在高可用切换期间，某些场景下可能出现数据丢失的情况，并不保证数据0丢失
		7、无法控制RTO恢复时间
		具体的数据丢失场景移步吴老师公开课《把MHA拉下神坛》
		https://mp.weixin.qq.com/s/PVd4qGMu1HVrH2BkIR7i8g   《叶问》第18期 高可用架构MHA有什么样的不足和风险点吗？

		缺点:
		这个服务器宕掉了、SSH登不上去了或者是主机所在服务器网卡挂掉了、网络登不上去了，这样都会导致丢数据情况的发生
		

		在基于复制实现高可用架构，最大的问题就是复制是异步的，怎么在主从有延迟的环境下实现切换时不丢失数据，MHA第一个做到了，但它做的还不够好。
		了解MHA原理的朋友应该知道MHA分为manager和node两部分，manager启动后主要负责检测master状态，以及触发切换动作，node无需启动任何后台进程只包含日志维护脚本。
		当mysql master服务退出时，manager通过ssh方式调用数据库主机上的一些脚本完成日志补偿(如有延迟差异)，将主从切换流程完全自动，并且加上binlog补偿能力，这在当时已经是非常好的方案了，所以应用的也特别广。
		
		但它还有些不足：
			切换一次，即退出。（能帮你切换就不错了，要啥自行车）
			服务器挂了ssh访问不到了，怎么拉日志。（DBA爬起来吧）
			old master 能再自动加回集群就好了。（你咋不上天呢）
			slave挂了你还管么。（你想太多了吧）
		https://mp.weixin.qq.com/s/VHW7LbzZfBNL4c-SGYuoug   爱可生拥抱MySQL Group Replication
		


   它的好处就是在限定场景下能够确保数据的一致性，比如MHA实现的基本原理是主库挂掉后，它通过SSH到主库的服务器上拿取主库的Binlog，然后把这部分Binlog补全到从库上面去，但实现前提是它能够通过SSH登陆到原先的主机所在的服务器上
   假如说这个服务器宕掉了、SSH登不上去了或者是主机所在服务器网卡挂掉了、网络登不上去了，这样都会导致丢数据情况的发生。
   http://tech.it168.com/a2018/0903/5018/000005018235.shtml  郭忆：网易数据库高可用架构最新进展！ 
   
   MHA最大的亮点莫过于在没有GITD年代选主的机制，而且还需要有 VIP，至于别的，就是一堆运维脚本，仅此而已。
		MHA解决的痛点MGR本身已经解决即自动选主同时可以在线选主    -- 但是MGR的驱动需要适配，如果需要官方的router工具来做，在router通过keepalived做高可用的时候，也是需要持有VIP的。
		https://mp.weixin.qq.com/s/ybiGEuTdZuS3UW-_KXLR7Q  MHA，传奇不再 #M1012#


	

4. 基本工作原理
	（1）从宕机崩溃的master保存二进制日志事件（binlog events）;

	（2）识别含有最新更新的slave；

	（3）应用差异的中继日志（relay log）到其他的slave；

	（4）应用从master保存的二进制日志事件（binlog events）；

	（5）提升一个slave为新的master；

	（6）使其他的slave连接新的master进行复制；


5. MHA切换原理的5个阶段

    phase 1: Configuration Check Phase..

    mha will check the mha default file,then it can get the status of all mysql nodes and the relationship between them, who is master ,who is slave and who is dead ,who is alive.

    Phase 2: Dead Master Shutdown Phase
    使用master_ip_failover_scirpt和shutdown script  to  shutdown or inactive the dead master ,（sush as  IP  or DNS switching，which was  defined in a self-defined script in advance ,just in case of split-brain） and I tend to use python.
    （执行master_ip_failover_script —command=stopssh 使原主库IP 失效；执行SHUTDOWN script —command=stopssh，关闭原主库）

    Phase 3: Master Recovery Phase

        3.1 比较所有从库的bin log的pos点，找出latest binlog file&pos和oldest file&pos

        3.2 尝试去原主库上获取binlog

        3.3 根据no_master、candidate_master和各从库延迟情况，选出新主库；获取新主库的日志缺失情况

        3.4 给新选出来的主库补日志，并激活新主库。 （生成change master to语句）

    Phase 4: Slaves Recovery Phase

        4.1 给从库补日志：从主库上补日志，或者，从lastest从库上给其他从库补日志

        4.2  execute “change master to” command in all avaiable slaves , which is generated in former steps

    Phase 5: New master cleanup

	
	

6. 具体切换流程
	1. 手动Failover(传统复制)切换流程:     # 新Master不需要补全跟最新slave的差异(新Master本身就是最新Slave) 	
	 
		1、配置检查：
			连接到各个实例
			检查整个集群文件配置
			再次确认主库状态（double check），同时检查各个从库的状态。
			
		2、故障Master关闭：
			停止各个从库的 IO thread
			故障Master虚拟IP摘除(stopssh)
			
		3、新Master恢复  			# 这一步相对来说过程比较多

			3.1 获取最新的Slave
				用于补全新Master/其他Slave缺少的数据；
				用于保存故障Master的binlog的起始点
				
			3.2 保存故障Master的binlog，只取最新Slave之后的部分
				故障Master上执行 save_binary_logs (只取最新Slave之后的部分)\n将得到的binlog scp到手动Failover运行的工作目录
				
			3.3 选举新Master
				查找最新的Slave是否包含最旧的Slave缺失的relay-log (apply_diff_relay_logs)
				确定新Master，得到切换前后结构
			
			3.4 新Master产生差异log   #New Master Diff Log Generation Phase
				新Master本身就是最新Slave, 所以不需要补全跟最新Slave的差异
				
			3.5 新Master应用从故障master保存的binlog  # Master Log Apply Phase
				等待新Master应用完自己的relay-log
				新Master应用故障Master保存的binlog 
				新Master应用完所有的relay-log、binlog，得到当前位置
				新主库绑定虚拟IP，并设置read_only=0, 这时候 新Master可以对外提供服务
			
		4、其他Slave恢复
			4.1 生成差异log
				生成最新Slave和Slave之间的差异relay-log，并拷贝到Slave的工作目录；
				从Failover运行的工作目录scp故障Master的binlog到Slave工作目录
			4.2 Slave应用差异log
				等待Slave应用完自己的relay-log；按顺序应用与最新的Slave缺失的relay-log，以及故障Master保存的binlog；重置Slave上的复制到新Master~
			4.3 如果存在多个Slaves，重复上述操作
			
			
		5、新Master清理
			清理旧的复制信息STOP SLAVE;RESET SLAVE ALL;

		6 小结：
			理解了 MHA补全日志的逻辑就算差不多理解了MHA的切换逻辑
			补全日志的逻辑:
				最新更新的Slave:
					1. 保存故障Master的binlog，只取最新Slave之后的部分
					2. 先等自身的realy log应用完成 
					3. 再应用从故障Master保存的binlog
				其它Slave:
					1. 跟最新更新的Slave 生成差异 relay log
					2. 把保存的故障master的binlog scp 到Slave 的工作目录下
					3. 先等自身的realy log应用完成
					4. 再应用与最新更新的Slave产生的差异 relay log
					5. 最后从应用故障master保存的binlog
					
				
	2. 手动Failover(传统复制)切换流程:     # 新Master需要补全跟最新slave的差异 	
	 
		1、配置检查：
			连接到各个实例
			检查整个集群配置文件配置
			再次确认主库状态（double check），同时检查各个从库的状态。
			
		2、故障Master关闭：
			停止各个从库的 IO thread
			故障Master虚拟IP摘除(stopssh)
			
		3、新Master恢复  			# 这一步相对来说过程比较多

			3.1 获取最新的Slave
				用于补全新Master/其他Slave缺少的数据；
				用于save故障Master的binlog的起始点
				
			3.2 保存故障Master的binlog，只取最新Slave之后的部分
				故障Master上执行 save_binary_logs (只取最新Slave之后的部分)\n将得到的binlog scp到手动Failover运行的工作目录
				
			3.3 选举新Master
				查找最新的Slave是否包含最旧的Slave缺失的relay-log (apply_diff_relay_logs)
				确定新Master，得到切换前后结构
			
			3.4 新Master生产差异log   #New Master Diff Log Generation Phase
				新主库需要判断自己的relay log是否与 latest(最新) slave 有差异，产生差异relay log；
				之后通过scp将主库差异binlog拷贝到新主库上。
				
			3.5、新Master应用log  # Master Log Apply Phase
				等待新Master应用完自己的relay-log
				新Master按顺序应用与最新的Slave缺失的relay-log，以及故障Master保存的binlog    #在新主库 上应用relay log差异和主库binlog差异
				新Master应用完所有的relay-log、binlog，得到当前位置
				新主库绑定虚拟IP，并设置read_only=0, 这时候 新Master可以对外提供服务
				
			3.6 小结：
				故障Master的binlog, 新Master自己本身的 relay log，最新Slave的 relay log
				先应用 Master自己本身的 relay log， 再应用差异 relay log， 再应用从故障Master保存的binlog
						
		4、其他Slave恢复
			4.1、生成差异log
				生成最新Slave和Slave之间的差异relay-log，并拷贝到Slave的工作目录；从手动Failover运行的工作目录scp故障Master的binlog到Slave工作目录
			4.2、Slave应用差异log
				等待Slave应用完自己的relay-log；按顺序应用与最新的Slave缺失的relay-log，以及故障Master保存的binlog；重置Slave上的复制到新Master~
			4.3、如果存在多个Slaves，重复上述操作
		5、新Master清理
			清理旧的复制信息STOP SLAVE;RESET SLAVE ALL;

			
			
	3. 手动Failover(GTID)切换流程: 由于当前提升为主库的Slave就是最新更新的SLave, 所以不需要补全跟最新Slave的差异
		1、配置检查：
			连接到各个实例
			检查整个集群配置文件配置
			再次确认主库状态（double check），同时检查各个从库的状态。
			
		2、故障Master关闭：
			停止各个从库的 IO thread
			故障Master虚拟IP摘除(stopssh)
			
		3、新Master恢复
		
			3.1、获取最新的Slave
				用于补全新Master缺少的数据；
				用于save故障Master的binlog的起始点
				
			3.2、选举新Master
				确定新Master，得到切换前后结构
				
			3.3、新Master恢复   
				
				等待新Master应用完自己的relay-log
				补全 新Master与故障Master差异
					在故障Master/BinlogServer执行，取最新Slave之后的部分
					将得到的binlog scp到 手动failover 运行的工作目录
					新Master应用完binlog，得到当前位置；
				绑定虚拟IP，新Master可以对外提供服务
					
		4、其他Slave恢复
			4.1、重置复制，RESET SLAVE;CHANGE MASTER TO New Master;
				意味着从库要开启 log_slave_updates参数？
			4.2、如果存在多个Slaves，重复上述操作
			
		5、新Master清理：
			清理旧的复制信息 STOP SLAVE;RESET SLAVE ALL;
		

	4. 手动Failover(GTID)切换流程:   # 新Master需要补全跟最新slave的差异 	
		1、配置检查：
			连接到各个实例
			检查整个集群配置文件配置
			再次确认主库状态（double check），同时检查各个从库的状态。
			
		2、故障Master关闭：
			停止各个从库的 IO thread
			故障Master虚拟IP摘除(stopssh)
			
		3、新Master恢复
		
			3.1、获取最新的Slave
				用于补全新Master缺少的数据；
				用于save故障Master的binlog的起始点
			3.2、选举新Master
				确定新Master，得到切换前后结构
				
			3.3、新Master恢复
				3.3.1 先补全 新Master与最新Slave差异
					等待新Master应用完自己的relay-log；
					等待最新Slave应用完自己的relay-log；
					将新Master change 到最新Slave，以补全差异数据   
					
					# GTID模式下的新主不需要保存最新Slave的relay log， 直接通过 change master to 到最新Slave, 从而实现自动补全新主跟最新从库的差异的binlog
					# 前提：GTID模式下，从库要开启log_slave_udpates 参数？
					#
					# 如果新Master没有开启 log_slave_updates 记录binlog的参数，是否可以实现这个自动补全差异的relay log？ 不可以。
					# 不是还有宕机的主库的binlog吗
					
					
				3.3.2 再补全 新Master与故障Master差异
				
					故障Master/BinlogServer上执行save_binary_logs；
					将得到的binlog scp到手动Failover运行的工作目录；
					新Master应用完binlog，得到当前位置；
					绑定虚拟IP，新Master可以对外提供服务
					
		4、其他Slave恢复
			4.1、重置复制，RESET SLAVE;CHANGE MASTER TO New Master;
			4.2、如果存在多个Slaves，重复上述操作
			
		5、新Master清理：
			清理旧的复制信息 STOP SLAVE;RESET SLAVE ALL;
			


7. 自己的一些总结/精髓
	
	异步复制存在的问题和MHA的解决方案：
	
		1. 主库宕机，有可能会存在部分binlog没有发送给从库，MHA具有这个补全 binlog的能力，也就是 主库宕机，如果有binlog没有发送给从库，那么MHA的做法是：
			ssh到主库的服务器上去拿取binlog，然后把这部分binlog补全到从库中。
			所以MHA高可用场景中，需要配置各个机器之间的ssh互信。
			
		2. 2个从库做选举，但是这2个从库的位点不一样：
			MHA高可用场景中，从库之间具有这个补全relay log的能力，对比位点，获取缺失的relay log，应用到自己的从库上，保证2个从库的数据一致。
			
		3. 总的来说，就是具有binlog补偿、relay log补偿的能力，最大程度保证数据的不丢失。
		
	
	自己理解的MHA补日志的逻辑：
		1. 其它从库从最新的slave补差异的 relay log
		2. 最新的从库根据保存下来的 master 日志补 binlog 
		3. 最新的从库成为 master, 其它从库成为最新master的从库。
	


	6 小结：
		理解了 MHA补全日志的逻辑就算差不多理解了MHA的切换逻辑
		补全日志的逻辑:
			最新更新的Slave也就是relay log最多的Slave:
				1. 保存故障Master的binlog，只取最新Slave之后的部分
				2. 先等自身的realy log应用完成 
				3. 再应用从故障Master保存的binlog
			其它Slave:
				1. 跟最新更新的Slave 生成差异 relay log
				2. 把保存的故障master的binlog 并 scp 到Slave 的工作目录下
				3. 先等自身的realy log应用完成
				4. 再应用与最新更新的Slave产生的差异 relay log
				5. 最后从应用故障master保存的binlog
				
				主要补relay log、补binlog，应用 自身的relay log、差异的relay log、缺失的binlog。
				
		故障切换后，会自动建立新的主从关系。	
		
			-- 这个总结可以。
				
	具体的细节需要看故障切换的日志。
	笔记做得详情一些，方便自己浏览。
	
	
8. 关于MHA+GTID

	建议在 GTID 配置情况下放弃 MHA，因为不补偿 Dead MASTER 的日志，这不是1个bug，需要在MHA的配置文件手工配置主库的binlog路径。
	
	MHA+传统复制模式：
		新主库的数据并不是最新的，新主库在跟最新的从库可以用差异的relay log做relay log的补偿，保证从库的数据一致。
		
	MHA+GTID复制模式：	
		新主库的数据并不是最新的，新主库在跟最新的从库是怎么做类似于 MHA+传统复制模式中 relay log补偿模式？
		
		
		
	
	
	Fri Nov  8 10:52:27 2019 - [info]  Waiting all logs to be applied on the latest slave.. 
	Fri Nov  8 10:52:27 2019 - [info]  Resetting slave 192.168.0.102(192.168.0.102:3306) and starting replication from the new master 192.168.0.103(192.168.0.103:3306)..								
	Fri Nov  8 10:52:27 2019 - [debug]  Stopping slave IO/SQL thread on 192.168.0.102(192.168.0.102:3306)..	
	
	

	
3.3、新Master恢复
3.3.1 先补全 新Master与最新Slave差异
	等待新Master应用完自己的relay-log；
	等待最新Slave应用完自己的relay-log；
	将新Master change 到最新Slave，以补全差异数据   
	
		

	
	
	
	