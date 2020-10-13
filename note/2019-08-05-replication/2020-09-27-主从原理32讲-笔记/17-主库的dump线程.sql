
0. 带问题学习
1. dump 线程的主要功能	
2. position mode 模式和 gtid auto_position mode 模式的不同
3. 主库 dump 线程的工作流程步骤解析   
	3.1 主要通过网络底层读取需要的信息
	3.2 杀死已经存在的 dump 线程	
	3.3 主库进行两项检查
	3.4 进行判断是否使用 gtid auto_position mode 模式
	3.5 检查主库的 gtid 参数是否开启
	3.6 检查从库的 gtid set 是否大于主库的 gtid set 	
	3.7 根据主库的 gtid_purged 变量检查从库需要的 gtid event 是否已经被清理
	3.8 实际扫描主库的 binary log，检查从库需要的 gtid event 是否已经被清理
	3.9 循环每一个 binary log 文件，读取 event 
	3.10 进行三项检查
		检查 gtid event，如果 auto_position = on 不能是匿名的，否则报错
		检查 gtid event，如果 gtid_mode = on 不能是匿名的，否则报错
		检查 gtid event，如果 gtid_mode = off 不能是显示的，否则报错
	3.11 进行 gtid 的过滤，决定发送哪些 event 给从库
	3.12 最后就可以将 event 发送给从库的 IO 线程了。

4. 小结

0. 带问题学习
	主库的 dump 线程的启动和工作流程
	结合从库的 IO 线程，看看 IO 线程是如何发送信息给 dump 线程的
	
1. dump 线程的主要功能	

	对于每一个从库在主库都对应了一个 dump 线程，主要功能就是发送 event 给从库，如下：

	mysql> select id,user,command,time,state from information_schema.`PROCESSLIST`;
	+-------+-----------------+------------------+---------+---------------------------------------------------------------+
	| id    | user            | command          | time    | state                                                         |
	+-------+-----------------+------------------+---------+---------------------------------------------------------------+
	|    31 | event_scheduler | Daemon           |      38 | Waiting for next activation                                   |
	| 49631 | repl_user       | Binlog Dump GTID | 2373324 | Master has sent all binlog to slave; waiting for more updates |
	|    27 | repl_user       | Binlog Dump GTID | 5236064 | Master has sent all binlog to slave; waiting for more updates |

	
2. position mode 模式和 gtid auto_position mode 模式的不同

	2.1 对于 position mode 模式和 gtid auto_position mode 模式获取从库的信息是不一样的，调用的接口也不一样
	2.2 position 模式
		使用的是 IO 线程传输过来的 master log name 和 master log position 进行主库 binary log 的定位
	3.3 gtid auto_position 模式
		使用的是 从库的 gtid set 信息进行主库 binary log 文件的查找，然后使用 gtid set 在 binary log 文件内部进行过滤查找具体的位置
		在这种模式下 master log name 和 master log position 是没有用处的
		gtid set 和 参数 relay_log_recovery 参数设置有关，如果设置了 relay_log_recovery = on， retrieved_gtid_set 将不会使用，具体可参考第26章节
		retrieved_gtid_set 表示 从库接收到的所有日志的 gtid set。
		从库的gtid set     表示 retrieved_gtid_set 和 executed_gtid_set 的并集
	
3. 主库 dump 线程的工作流程步骤解析   

	3.1 主要通过网络底层读取需要的信息
		gtid auto_position 模式下读取的信息：
			从库的 server_id
			从库的 gtid set
			
	3.2 杀死已经存在的 dump 线程
		在启动 dump 线程之前依据从库的 server_uuid 杀掉已经存在的 dump 线程
	
	3.3 主库进行两项检查
		检查主库binlog是否开启，如果没有开启则报错          -》 binary log is not open
		检查主库的 server_id 是否为 0， 为0不允许连接，报错 -》 misconfigured master - master server_id is 0
	
	3.4 进行判断是否使用 gtid auto_position mode 模式
	
	3.5 检查主库的 gtid 参数是否开启
		主库 gtid_mode 必须是 on, 否则报错
	
	3.6 检查从库的 gtid set 是否大于主库的 gtid set 
		获取主库 gtid 和 从库 gtid 中关于主库 server_uuid 的部分进行比较，如果从库的 gtid 大则说明从库事务多了， 报错
			会提示是否设置了 sync_binlog != 1，该参数会控制什么时候发送 binlog 给从库，如下：
				sync_binlog != 1：flush 阶段后发送，这种情况可能导致从库比主库多事务
				sync_binlog  = 1：sync 阶段后发送 即 把 binlog cache 中 binlog write 到操作系统的 page cache 之后，dump 线程就可以把该 binlog 发送给从库。 
				
	3.7 根据主库的 gtid_purged 变量检查从库需要的 gtid event 是否已经被清理
		
	3.8 实际扫描主库的 binary log，检查从库需要的 gtid event 是否已经被清理
		这一步需要完成两件事情：
			1. 上一步检查有一种特殊情况，比如主库手动删除了 binary logfile，这种情况 gtid_purged 变量可能没有更新，因此
				需要实际的扫描主库的 binary log 来进行确认
				
			2. 将扫描到的 binary log 文件作为 dump 线程发送的起点 
				
				扫描方式就是先扫描最后一个 binary log 拿到 PREVIOUS_GTIDS_LOG_EVENT，然后检查需要拉取的 GTID 是否在此之后，是就结束 
				否则检查上一个 binary log 文件同样拿到 PREVIOUS_GTIDS_LOG_EVENT，同样检查需要拉取的GTID 是否在此之后，如此循环直到找到为止
				PREVIOUS_GTIDS_LOG_EVE ： 
					表示当前binlog文件之前已经执行过的GTID集合，记录在Binlog文件头
					
			3. 如果没有找到则会报错	
			
		如果延迟较高，并且设置了 relay_log_recovery = on ， 这时 retrieved_gtid_set 将不会初始化，也就是以从库的 executed_gtid_set 去检查，这个过程可能有些长，比如几十秒，因为需要扫描的 binary log 可能比较多。相关案例参考： 参考第26章节
				
	3.9 循环每一个 binary log 文件，读取 event 
		在前面的步骤中已经找到 binary log 文件，这就是 dump 线程读取的起点       *******
		接下来就是读取 binary log 的 event 了， 如果是当前 binary log 读取完了所有的 event 后 dump 线程就需要堵塞等待唤醒了，阻塞期间
		还会醒来发送心跳 event 给从库，如果有事务提交那么就会唤醒 dump 线程进行发送 event
		
	3.10 进行三项检查
		检查 gtid event，如果 auto_position = on 不能是匿名的，否则报错
		检查 gtid event，如果 gtid_mode = on 不能是匿名的，否则报错
		检查 gtid event，如果 gtid_mode = off 不能是显示的，否则报错
	
	3.11 进行 gtid 的过滤，决定发送哪些 event 给从库
		在前面的步骤中已经找到 binary log 文件，具体发送哪些事务 event 给从库还需要根据从库的 gtid set 进行过滤
	
	
	3.12 最后就可以将 event 发送给从库的 IO 线程了。
	
		
4. 小结
	1. dump 线程的主要功能	
		对于每一个从库在主库都对应了一个 dump 线程，主要功能就是读取 event 和 发送 event 给从库的 IO 线程，如下：

		mysql> select id,user,command,time,state from information_schema.`PROCESSLIST`;
		+-------+-----------------+------------------+---------+---------------------------------------------------------------+
		| id    | user            | command          | time    | state                                                         |
		+-------+-----------------+------------------+---------+---------------------------------------------------------------+
		|    31 | event_scheduler | Daemon           |      38 | Waiting for next activation                                   |
		| 49631 | repl_user       | Binlog Dump GTID | 2373324 | Master has sent all binlog to slave; waiting for more updates |
		|    27 | repl_user       | Binlog Dump GTID | 5236064 | Master has sent all binlog to slave; waiting for more updates |

	2. dump 线程的其它作用：比较 gtid set 和 gtid
		检查从库的 gtid set 是否大于主库的 gtid set 
		检查从库需要的 gtid event 是否已经被清理
		进行 gtid 的过滤，决定发送哪些事务给从库
		
	3. 学习 dump 线程的启动和工作流程

	
		
		
	
	
	
	
	
	
	
		
	
	




	
	
