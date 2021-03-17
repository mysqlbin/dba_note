

1. 针对大事务做的改进:

	事务大小限制:
		若事务内容过大，导致组内成员无法在5秒窗口内完成信息拷贝，将怀疑成员失败，并将其驱逐。
		限制事务大小。例如，LOAD DATA文件拆分多个小块。
		使用 group_replication_transaction_size_limit 去配置事务最大大小。
			MySQL5.7默认为0，而MySQL8.0默认为大约143MB。事务超出配置大小，将回滚且GCS(group communication system)不会发送事务给组。
		使用 group_replication_compression_threshold 压缩事务内容。默认值为1MB。
		
	1.1 大事务回滚
		不能传大事务，大事务出现超时后即传输不到slave, 那么该slave 会被自动移除。
		在 5.7.17、5.7.18 都有此问题，fix 5.7.19 加了一个限制大事务的参数 group_replication_transaction_size_limit 默认是0，是没有限制，需要根据 MGR 工作负载设置比较合理的值

	
	1.2 消息压缩:

		网络带宽成为瓶颈时，消息压缩可以在组通信层提高吞吐量。
		如图1所示，压缩发生在组通信系统API级别，因此事务负载可以在被发送到组之前被压缩，并且在成员接收事务时进行解压缩。
		压缩使用LZ4算法，阈值缺省为1000000字节，由 group_replication_compression_threshold 参数控制，即只压缩大于该参数指定字节数的事务，设置为0将禁用压缩。
		收到消息后，组成员检查消息是否被压缩。如果需要，该成员在将事务交付给上层之前解压缩该事务。
		组复制不要求组中的所有服务器都同时启用压缩。
		group_replication_compression_threshold ： 
			含义是事务超过相应大小则在传输前进行压缩处理； 默认该功能是超过1M的数据量就启用压缩，关闭只需设置该参数为0
			MySQL 5.7.17 就有的参数
			
		mysql> show global variables like '%group_replication_compression_threshold%';
		+-----------------------------------------+---------+
		| Variable_name                           | Value   |
		+-----------------------------------------+---------+
		| group_replication_compression_threshold | 1000000 |
		+-----------------------------------------+---------+
		1 row in set (0.05 sec)
		
		相关参考:
			https://blog.csdn.net/wzy0623/article/details/97782304
			

	1.3 消息分段:
		组复制组成员之间发送异常大的消息时，可能会导致某些组成员报告为失败并从组中移除。
		这是因为组通信引擎使用的单个线程被处理消息占用时间太长，使得某些组成员将接收状态报告为失败。
		从MySQL 8.0.16开始，默认情况下，大消息会自动拆分为单独发送的消息片段，并由接收方重新组装为原消息。

	    系统变量 group_replication_communication_max_message_size :
			指定组复制通信的最大消息大小，超过该大小的消息将被分段。
			缺省值为10485760字节（10MB）允许的最大值与 slave_max_allowed_pa​​cket 系统变量的最大值相同，即1073741824字节（1GB）。
			group_replication_communication_max_message_size 的值不能大于 slave_max_allowed_pa​​cket 的值
				因为复制应用程序线程无法处理大于 slave_max_allowed_pa​​cket 的消息片段。
			要关闭消息分段，可将 group_replication_communication_max_message_size 设置为0。

		当所有组成员收到并重新组装消息的所有片段时，认为消息传递已完成。
		分段消息包括其标头中的信息，这些信息在消息传输期间加入，以使成员恢复之前发送的早期消息片段。
		如果组成员无法恢复消息，则将其从组中移除。
		为了使复制组使用消息分段，所有组成员必须为MySQL 8.0.16或更高版本，并且组使用的复制通信协议版本也必须设置为8.0.16或更高版本。

		如果复制组因某些成员不支持而无法使用消息分段时，系统变量 group_replication_transaction_size_limit 可用于限制组接收的最大事务。
		   在MySQL 8.0中，缺省值为150000000（约143MB），大于该值的事务将被回滚。
		   
		   
		使用系统变量 group_replication_transaction_size_limit 指定组接收的最大事务大小。
		超过此大小的事务将回滚，不会发送到组。在MySQL 8.0中，此系统变量缺省值为150000000字节（大约143 MB）。
		
		
		MySQL 8.0.16开始，大型消息会自动分段，这意味着大型消息不会触发引发怀疑的5秒检测周期，除非此时存在其它网络问题。
		为了使复制组使用分段，所有组成员必须处于MySQL 8.0.16或更高版本，并且组使用的组复制通信协议版本必须允许分段。
		如果MySQL版本不支持消息分段，可以使用系统变量 group_replication_communication_max_message_size 来调整最大消息大小，缺省值为10485760字节（10 MB），
		或通过指定零值来关闭分段。
	
	1.4 group_replication_member_expel_timeout
	
		从MySQL 8.0.13开始，可以使用系统变量 group_replication_member_expel_timeout 来允许在怀疑失败的成员在被移出之前有更多的时间。
			可以在最初的5秒检测期后最多延长一个小时。
	
		之前，如果某个节点被怀疑有问题，在5秒检测期结束之后，那么就直接被驱逐出这个集群。即使该节点恢复正常时，也不会再被加入集群。
			那么，瞬时的故障，会把某些节点驱逐出集群。
			group_replication_member_expel_timeout 让管理员能更好的依据自身的场景，做出最合适的配置（建议配置时间小于一个小时）。
			
		root@mysqldb 23:24:  [(none)]> show global variables like '%group_replication_member_expel_timeout%';
		+----------------------------------------+-------+
		| Variable_name                          | Value |
		+----------------------------------------+-------+
		| group_replication_member_expel_timeout | 0     |
		+----------------------------------------+-------+
		1 row in set (0.00 sec)
		
		https://dev.mysql.com/doc/refman/8.0/en/group-replication-options.html#sysvar_group_replication_member_expel_timeout
		
		
	1.5 MGR处理大事务的小结:
		在 5.7.17、5.7.18 版本的MGR组复制中, 如果大事务出现超时后即传输不到slave, 那么该slave 会被自动移除
		改进方案: 
			5.7.19 加了一个限制大事务的参数 group_replication_transaction_size_limit 默认是0，是没有限制，需要根据 MGR 工作负载设置比较合理的值
			8.0.16 的消息分段:
				由系统变量 group_replication_communication_max_message_size 控制	
		
	
2. 流控:

    流控的概念： 在MGR中如果节点落后集群中其它成员太多， 就会发起让其它节点等它完成再做的控制， 这个叫流控。
       当启用： group_replication_flow_control_mode=QUOTA 时表示启用流控。 流控默认通过两个参数控制：
            group_replication_flow_control_applier_threshold (默认: 25000)     表示如果复制应用队列中的事务数超过该变量值触发应用流控，缺省值为25000，值域为0-2147483647。
            group_replication_flow_control_certifier_threshold (默认: 25000)    表示如果认证队列中的事务数超过该变量值触发认证流控，缺省值为25000，值域为0-2147483647。
            也就说默认延迟在25000个GTID时，会对整个集群Block住写操作。
            当然，也可以允许，节点延迟，就如同我们主从结构，从节点延迟，不往上面发请求就可以。
            关闭Flow control： set global group_replication_flow_control_mode='DISABLED';
            提示： 关闭流控制，注意查看是不是存在延迟，如果延迟，自已控制阀值不向上面发请求即可。 多IDC结构的MGR，建议关闭流控。    
　　 		         流控的三个参数，MGR的缺陷是基于Binlog进行数据同步，就会存在复制延迟问题，但MGR有流控系统，它可以在发现从库复制延迟比较高的情况下，限制主库的写入速度，来减少主从复制的延迟，其实这是一种自保护的机制。


	  流控测试:
		group_replication_flow_control_applier_threshold = 1;
		

		
3. 支持在线切换group replication状态:
	参考笔记 《支持在线切换Group Replication的状态.txt》
	这个特性可以。
	
4. group_replication_autorejoin_tries

	MGR增加参数 group_replication_autorejoin_tries 控制节点加入集群的次数，超过指定次数则加入失败。
		默认值为0，也就是说MRG成员不主动尝试加入集群。 对于网络不太稳定的基础环境，启用该参数可以减少人肉运维操作，提高'幸福感'。

	之前的版本中，MGR成员相互传递大量信息可能会导致部分节点接收失败并且从集群中移除。
		因为接受大量消息会导致接收消息的线程被group communication engine (XCom, a Paxos variant)占用很长时间，其他节点会认为该节点无法响应。
		8.0.16版本通过参数 group_replication_communication_max_message_size 支持将超过指定大小消息拆分为多组消息。


	
5. 小结:
	不建议使用MySQL 5.7的组复制, 因为不够成熟, 因此在MySQL 8.0版本中, 对MGR组复制也做了一些改进: 
		比如对大事务的处理, 消息分段, 支持在线切换group replication状态（自主选主）等
	
	见过很多人为了涨经验, 都没有经过完整测试, 直接上了MGR组复制, 还是要多多调研才行, 待成熟后才加以应用
	
	不适用于跨城跨机房,但是适用于同城跨机房
	
	在MGR 3节点的同城跨机房下加一个主从复制，用于备份。
	
	
	
	
	

	