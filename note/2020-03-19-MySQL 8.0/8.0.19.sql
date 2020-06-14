

InnoDB ReplicaSet
	继 InnoDB Cluster 作为我们基于组复制的第一个完全集成的 MySQL HA 解决方案之后，InnoDB ReplicaSet 提供了另一个完整的解决方案（基于MySQL 复制）。
	InnoDB ReplicaSet 的基本思想是对经典 MySQL 复制执行与 InnoDB Cluster 对组复制所做的相同操作。我们采用了一种非常强大但可能很复杂的技术，在 MySQL Shell 中为其提供了易于使用的 AdminAPI。

	仅需几个易于使用的 Shell 命令，即可从头开始配置 MySQL 复制数据库体系结构，包括使用 CLONE 进行数据供应，设置复制并执行手动切换或故障切换。
	MySQL Router 了解拓扑结构，并会自动进行负载平衡或流量重定向。
	

	InnoDB ReplicaSet由一个主节点和多个从节点组成，与传统主从复制的主从节点非常类似，所有的节点必须基于GTID，并且数据复制采用异步的方式。
	通过使用MySQL Shell的AdminAPI和ReplicaSet对象，用户可以像配置InnoDB Cluster那样非常简单地去搭建一主多从的复制架构。
	此外，使用复制集还可以接管既有的主从复制，但是需要注意，一旦被接管，只能通过AdminAPI对其进行管理。
	
	
DNS SRV

	
https://mp.weixin.qq.com/s/X2UgEgNmkTMU5GPK7bgA3Q  MySQL8.0.19的InnoDB ReplicaSet

https://mp.weixin.qq.com/s/G3dW_GPDd1l1MJ86c7iFTA  新特性解读 | MySQL 8.0.19 支持 DNS SRV


	MySQL Router 是 InnoDB Cluster 架构的访问入口，在架构部署上，官方给出的建议是 router 与应用端绑定部署，避免 router 单点问题。
	之前还有客户咨询，能否 router 不与应用端绑定部署，不便于部署，在此之前都需要在 router 前面加 VIP 或者一层负载均衡。
	我还在想这事儿就应该由 MySQL Connector 来实现访问链路的 Failover 和 Loadbalance， 现在有了 DNS SRV 的支持，router 不必和应用端绑定部署，也可以省了 VIP 和负载均衡，
	MySQL InnoDB Cluster 方案更加完善，配合 consul 等服务发现组件，更容易适配 service mesh 架构。
	DNS SRV 是 DNS 记录的一种，用来指定服务地址。SRV 记录不仅有服务目标地址，还有服务的端口，并且可以设置每个服务地址的优先级和权重。


https://mp.weixin.qq.com/s/k0qqlydYdfkpeZksf-gobQ  技术译文 | MySQL 8.0.19 GA!


结合InnoDB Cluster的三个组件 MGR、MySQL Router和MySQL Shell
Mysql InnoDB Cluster 主要由三个模块构成：

	支持Group Replication 功能的Mysql Server(version >= 5.7.17)，模块主要功能在于实现了组内通信，故障转移（英语：failover, 即当活动的服务或应用意外终止时，快速启用冗余或备用的服务器、系统、硬件或者网络接替它们工作）、故障恢复（英语：failback，将系统，组件，服务恢复到故障之前的组态）
	Mysql-shell：实现快速部署，主要提供了一套AdminAPI，可以自动化配置Group Replication，让我们无须再手动配置cluster中group replication相关参数。
	Mysql-router：内置读写分离，负载均衡。自动根据Mysql InnoDB Cluster中的metadata自动调整。
	
	
如果mysql router需要实现高可用，可以使用keepalived或者headbetart实现，这里主要介绍mysql router就不实现了。

