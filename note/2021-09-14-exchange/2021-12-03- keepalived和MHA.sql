
1. 都是基于VIP的方式。

2. MHA更强大，具有补偿binlog+relay log的能力。

3. 节点数：
	MHA 需要3个节点，keepalived需要2个节点
	MGR 也是最少需要3个节点，暂时还不支持仲裁节点，MongoDB 副本集支持仲裁节点，而且MGR需要中间件来实现故障切换后，找到新的主库进行连接服务。
	
4. 方案
	keepalived + 1主1从 + 1个延迟从库，基于GTID的复制。
	