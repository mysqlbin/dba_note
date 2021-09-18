


优点
	
	1. MHA是开源高可用方案中最好的一种，它最重要的特点就是支持binlog补偿和relay log补偿。
	2. 在主从有延迟的环境下实现切换时不丢失数据。
	3. 主库宕机，自动完成新的主从复制构架，不需要人为干预。
	
	

缺点：
	
	1. 基于异步的复制，还是有数据丢失的风险;
	2. 从节点出现宕机等异常并没有能力处理，即没有从库故障转移能力;
		-- MongoDB 有从库故障转移能力。
		
		
基本工作原理
	
	MHA分为manager和node两部分：
		manager启动后主要负责检测master状态，以及触发切换动作
		node无需启动任何后台进程只包含日志维护脚本。
	
	
	MHA Manager会定时探测集群中的master节点，当master出现故障时，MHA的工作流程如下：
	
		1. 从宕机崩溃的master保存二进制日志事件（binlog events）;

		2. 识别含有最新更新的slave，接着做以下操作

			1. 应用差异的中继日志（relay log）到其他的slave，保证所有从库的数据一致
		
			2. 应用从master保存的二进制日志事件（binlog events）；

			3. 提升有最新更新的slave为新的master；

		3. 使其他的slave连接新的master进行复制；
		4. 至此，主从切换完成。
		
	

mha manager 的作用相当于 keepliaved，都会去探测master是否宕机。



