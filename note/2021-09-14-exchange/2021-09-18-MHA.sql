

优点
	
	1. MHA是开源高可用方案中最好的一种，它最重要的特点就是支持binlog补偿和relay log补偿。
		-- MHA 是 MySQL 高可用的1个大杀器
	2. 在主从有延迟的环境下实现切换时不丢失数据。
	
	3. 主库宕机后，自动完成新的主从复制构架(其余从库和新主库确认新的主从关系)，对业务而已也是透明的，不需要人为干预。
	
	4. 主库宕机后，新的主从架构数据一致性得到一定保障。
	

缺点
	
	1. 基于异步的复制，还是有数据丢失的风险;
		-- 如果主服务器硬件故障或无法通过ssh访问，MHA没法保存二进制日志，只进行故障转移而丢失了最新的数据。
		
	2. 从节点出现宕机等异常并没有能力处理，即没有从库故障转移能力;
		-- MongoDB 有从库故障转移能力。
		
		
基本工作原理
	
	MHA分为manager和node两部分：
		manager启动后主要负责检测master状态，以及触发切换动作
		node无需启动任何后台进程只包含日志维护脚本。
	
	
	MHA Manager会定时探测集群中的master节点，当master出现故障时，MHA的工作流程如下：
		
		--上面的原理还没能口述出来。
		
		
		比如有 A、B、C这3个节点
		
			A 是主库，虚拟IP为 192.168.1.100，挂载在主库上
			B 和 C 是从库
			此时 主库A宕机，会触发 B 和 C 这2个从库的选举
			
			假设B从库是拥有最新更新的从库，会做以下操作：
			
				1. 保存故障Master的binlog，只取最新Slave之后的部分
				2. 先等自身的realy log应用完成
				3. 再应用从故障Master保存的binlog
				4. 绑定虚拟IP，提供对外服务
				
			C库会做以下操作：
				
				1. 跟最新更新的Slave 生成差异 relay log
				2. 把保存的故障master的binlog 并 scp 到Slave 的工作目录下
				3. 先等自身的realy log应用完成
				4. 再应用与最新更新的Slave产生的差异 relay log
				5. 最后从应用故障master保存的binlog		
				6. 作为从库连接到新的主库进行复制
			
			
				
小结

	mha manager 的作用相当于 keepliaved，都会去探测master是否宕机。
	
	理解了 MHA 补全日志的逻辑就算差不多理解了MHA的切换逻辑
		
		
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
			
			主要补relay log、补binlog：先应用 自身的relay log、差异的relay log、缺失的binlog。
			从库跟宕机的主库补binlog日志
			其它从库跟最新的从库补差异的relay log
		
	故障切换后，会自动建立新的主从关系，对应用、业务而言是透明的。	
		
		
	MHA 的最新版本是0.58, 最新的1次维护是在 2018年3月23号
		https://github.com/yoshinorim/mha4mysql-manager
		https://github.com/yoshinorim/mha4mysql-node
	
		
	-- 在日常工作、生活中积累，加强口述表达能力。

	