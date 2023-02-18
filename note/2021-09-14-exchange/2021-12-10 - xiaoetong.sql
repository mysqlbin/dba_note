


2021-12-10 进行一面：



1. 自我介绍
	需要 MySQL 主要是1主1从或者1主2从的配置，1主2从中其中有1个从是延迟从库，MongoDB 是副本集模式。
	
2. 先介绍数据库实例数和架构
	18台MySQL数据库实例，架构为1主1从或者1主2从，1主2从里面其中有1个从库是延迟复制的从库
	
3. 容灾
	我回答的是备份和恢复
	
	其实要问的是两地三中心、
	
4. 从哪方面做 MySQL 的优化
	我回答的是 操作系统层、MySQL server层 和 InnoDB层
		其实可以更具体一点说
	
	问了内存参数的优化：
		我回答的是InnoDB最重要的内存参数，InnoDB buffer pool size缓冲池的大小，设置太大和太小分别带来的问题
		在5.7版本是可以修改的，自己也有在线修改过，没有造成业务的阻塞，因为我是在业务低峰期执行的，
		如果在业务高峰期缩小该参数的大小，会对内存buffer pool加 mutex 互斥锁，会阻塞业务的DML和查询请求。
		遍历instance，以instance为单位进行加锁，然后回收该instance的数据页，回收完成后释放buffer pool instance锁
		然后对整个BP缓冲池加锁，以chunk为单位进行回收内存。

		没有回答BP缓冲池参数的作用
		
	-- 《2021-11-07- MySQL的优化思路.sql》
	
	
5. binlog刷盘参数的优化

6. 主从复制的原理、扩展来讲延迟的原因和解决办法
	
7. 什么情况下会用不到索引？

	-- 补充：扫描行数超过表行数的30%左右，SQL语句会用不到索引。
	
	
	
8. MongoDB大表在线加索引，会有什么问题？

	4.0 版本支持在后台添加索引，通过添加 background=true 这个参数，4.2 版本移除了这个参数，默认在后台添加索引。  --都是在不断优化的过程。
	
	经过测试，添加索引持有的锁(需要在构建索引的开始和结束阶段，加集合排他锁)+占用磁盘IO，一般会阻塞业务0.2秒左右。
	
	
	主要考虑副本模式下，会导致副本有延迟不？
		会的，但是副本(从库)没有业务的读取操作，那就还好。
		-- 需要验证下。
		
		
	内存不足，会导致添加索引报错吗？
		不会。
		
	4.0 之前的版本，是怎么处理的？
		会对集合加锁，阻塞对该集合的读和写请求。
		
	
一些职责：
	1. 保证数据库的平稳运行，不要时不时有大事务、死锁相关的问题，影响用户体验
	2. 不要在生产环境上随意做相关维护操作
	3. 要有上级领导的指示才能做，并且要有相关的记录
	4. 紧急操作，要有第二审核人，并且做好相关的回滚方案
	
MongoDB 4.0 以上的版本，副本集模式，对大表在线添加索引，你是怎么处理的

我记得你之前在你的公众号有写一篇相关的文章，应该对这个挺有经验的

在4.2版本，我之前有在业务停服后直接在主上加，没有什么问题啊
当时的数据和配置：30GB的单个集合数据大小，内部内存设置为8GB(wiredTigerCacheSizeGB=8GB)，物理内存16GB.

有人建议先在副本上加，然后副本集的切换，不过这个切换过程会导致业务有10秒左右的不可写





有基本的了解了
	
	公司业务相关：
		做sass平台的，面向的是to B市场，主要业务：店铺销售、知识付费、直播等，现在直播业务是核心。
	
	用户量相关：
		160W+客户数，同时在线有1000W+，终端用户数7.8亿
	
	数据库相关：
		主要有MySQL、MongoDB、Redis、ES，其中MySQL在腾讯云数据库上
	
	
	
	
2021-12-13 进行二面：
	
	0. 自我介绍
	
	1. 数据库上云比较稳定之后，DBA还需要做什么 
		1. 首先，不可能一直稳定的
		2. 从公司的角度
			可以考虑做一下容灾之类的
			看看业务跟数据库的交互有没有一些隐患之类的，提前做下优化，比如慢查询
			做自动化运维、往故障自愈方面思考
			
		3. 从个人的角度
			学习新版本的相关特性
			深入到源码层面做提升，更深入的理解MySQL，然后运用到工作上。
			
	2. 自建的数据库稳定之后，还需要做什么 或者 你在做什么
	
		1. 首先，不可能一直稳定的
		2. 从公司的角度
			可以考虑做一下容灾之类的
			看看业务跟数据库的交互有没有一些隐患之类的，提前做下优化，比如慢查询
			做自动化运维、往故障自愈方面思考
			
			
		3. 从个人的角度
			学习和研究新版本的相关特性
			深入到源码层面做提升，更深入的理解MySQL，然后运用到工作上。
		
		
	3. 个人职业发展规则
		主要往资深DBA方向发展。
		
	4. 一条查询语句的执行流程
	
	5. 自建的有高可用吗
		
		补充：使用 keepalive ，有发生过故障切换？  有的，上线前演练过（-- 补充：在业务停服更新的时候，有手工切换过，正常切换后，业务可以正常读写）。 

	6. 一条语句，第一次查询耗时100ms，第二次查询耗时10ms, 原因
		第一次查询已经把数据页加载到内存中，第二次查询，直接读取了内存数据页，然后返回，所以执行速度快


	7. 自建的MySQL，怎么做的监控？
		用的是fpmmm的模板，这个跟zabbix很搭。
	
	8. 为什么离职？
		主要是想有更大的提升，跟目前的公司没什么纠纷。
		要是能节前面试成功，节后上班的最好。
		
		主要是想有更大的提升，跟目前的公司没什么纠纷。
		想往云上发展，毕竟云是大势所趋了。		
	
		-- 原因：
			对个人的开发能力不满意，自己也没在这方面做总结和复习。
			
	小结：2面的时候，语速有放慢。
	
	
	
	
一面和二面都是用腾讯会议开视频，真的很耗电。



2021-12-16： 3面

	1. 限流，可以从数据库端做吗
		读写分离构架，及时杀掉有性能问题的语句。
		--补充：从业务端做限流
		-- 补充 innodb_thread_concurrency 参数
		
	2. 在自我介绍环节，有提到了看过的源码，同时提到了自己做过的数据库运维平台的一些功能
		-- 看源码，得到了一些肯定。
	
		不看源码，有些点，一知半解 感觉就像隔靴搔痒 
	
	
	3. 添加联合索引的流程
		-- 补充：联合索引是由多个列(字段)组成的
		
	4. 目前的工作，有什么亮眼的吗
		回答得不好。
		
		-- 下面的是补充
		1. 主从复制模式改为双主，也就是互为主从。
			解决了从库的数据比主库的数据多，避免了在做主从切换需要额外地补数据，加快了切换时间。
			
		2. 提供解决业务因素导致数据库产生死锁的方案。
			-- 某1时刻大量派发机器人的逻辑，由于是放在事务里面的，因此会导致死锁的可能。业务方说这里不可以出现死锁，但是可以串行的方式执行事务。
			-- 开发2-3天没搞定，自己花了几分钟就解决了。
			
		3. 数据库动不动卡死    
			然后我就去看      一看存储过程调用了大量冗余表，而这些冗余表全部都是insert select操作   数据库隔离级别又是RR    我就说都得改  然后我们架构师天天夜里在那改存储过程  改了一个多月
		
		4. 资源的整合，节约了成本 
			
			1. 1个月节省了3000块，一年就3.6W了
				32核CPU、128GB、1000GB的SSD盘 
					5466.00 
					
				16核CPU、32GB、500GB的SSD盘 
					2270.40 
				
				
				这个是之前把好几个游戏的数据库都放在里面，后来做了拆分，每个实例1个数据库，但是没有做机器的缩容。
			
			2. 还有1个实例，数据库明明没有在用了，并且是关闭状态，也没有释放，每个月都在续费，每个月差不多2000块钱
				8核32GB 200GB的SSD盘
				
				
		5. 表自增ID不够用
			
			
			
	5. 为什么离职？
	
		个人想往云方面发展，毕竟现在云是大势所趋了。
		
		-- 回答得不错。
	
要问的问题：
    1. 实例数大概有多少，还有数据量有多少
    2. 用自建的数据库还是云数据库
        自建的话有高可用吗
    3. 用户量大概有多少 
	4. 主要使用的数据库产品有哪些
	5. 目前有DBA了吗
	
	


































































