

1. Instant Add Column

2. Group Replication继续优化

	新增了参数 group_replication_exit_state_action 来控制，如果一个实例发现自己属于被抛弃（网络分区发生后的少数派）的实例的情况下
	这个值默认为ABORT_SERVER，也就是说，少数派会自己关闭，这个值也可以设置为 READ_ONLY，这个设置下，会以只读（设置super read only）的形式加入集群，并设置状态为 ERROR。

相关参考
	https://mp.weixin.qq.com/s/vJuZha6QXZ-bsaQ5W2YAig
	参考笔记 <MySQL8.0.12 - 新特性 - Instant Add Column>