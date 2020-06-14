
1. 简介
2. Binary log综述
3. Event 的总体格式
	Event header
		timestamp
		type code
		server_id
		event_len
		end_log_p
		flags
		
	Event data
	
	Event footer
		Event footer 中的 cc
		
4. 常用的 event
5. 小结		
		
1. 简介
	在主从间Event起到了数据的载体功能，他们在主从之间传递，它们可以说是一组协议

2. Binary log综述
	每个 binary log都是由开头的4byte的魔术数和一个一个event组成

3. Event 的总体格式
	Event header
		timestamp
		type code
		server_id
		event_len
		end_log_p
		flags
	Event data
	Event footer
		Event footer 中的 cc
		
		
3. Event 的总体格式
	Event header
		timestamp: 
			固定4 bytes
			这个时间是命令发起的时间。
			如何定义命令发起？
				执行计划生成后开始实际执行语句的时候；
				言外之意对于 语法意义、权限检查、优化器生成执行计划的时间都包括在里面；
			这个时间在从库计算 seconds_behind_master 的时候是一个重要的依据，在第27节详细讨论
		type code
			固定 1 bytes
			event事件的编码，每个evnt有自己的编码
		server_id
			固定 4 bytes
			生成这个 event 服务端的 server id 
			即便从库端开启了 log_slave_updates参数，从库将主库的 event 写到 binary log， 这个 server id 也是主库的 server id，如果这个 event 再次传到主库，那么需要跳过。
			
		event_len
			固定 4 bytes, 整个 event 的长度
		end_log_p
			固定 2 bytes, 下一个 event 的开始位置
		flags
			固定 2 bytes, 某些 event 包含这个标示
			
	Event data
	

	Event footer
		Event footer 中的 cc
			固定 4 bytes, 这部分就是整个 event 的一个 crc 检验码， 用于标示 event 的完整性。
		


4. 常用的 event
	QUERY_EVENT = 2
		在语句模式下记录实际的语句
		在行模式下不记录任何语句相关的信息，但是DLL始终是记录的语句
		
	FORMAT_DESCRIPTION_EVENT = 15
		说明 binary log 的版本信息
		总包含在每一个 binary log 的开头
		
	XID_EVENT = 16 
		当事务提交的时候记录这个 event 其中携带了 XID 信息
	
	TABLE_MAP_EVENT = 19
		包含了 table_id 和 具体表名的映射
		
	WRITE_ROWS_EVENT = 30
		insert 语句生成的 event，包含插入的实际数据
		是行模式才有的
	
	UPDATE_ROWS_EVENT = 31
		update 语句生成的 event，包含数据的前后印象数据
		是行模式才有的
	
	DELETE_ROWS_EVENT = 32
		delete 语句生成的 event，包含实际需要删除的数据
		是行模式才有的
	
	GTID_LOG_EVENT = 33
		
		是什么
			是 binary log 其中的一个 event
			如果开启 GTID 模式的时候生成关于 GTID 的信息， 并且携带 last commit 和 seq number 作为 并行回放的依据
		有什么作用
			GTID_LOG_EVENT这个event主要记录的部分有3个即作用
				1. 记录GTID的详细信息
				2. 记录逻辑时钟详细信息，即 last commit 和 seq number
				3. 是否为行模式，比如 DDL 语句就不是行模式的。
		
	ANONYMOUS_GTID_LOG_EVENT = 34
		是什么：
			这个是匿名GTID event，5.7 如果不开启GTID则使用这种格式
			在关闭 GTID 模式的时候生成，并且携带 last commit 和 seq number 作为 MTS 并行回放的依据
		
	PREVIOUS_GTIDS_LOG_EVENT = 35
		说明前面所有的  binary log 包含的 gtid set, relay log 则 代表 IO 线程收到的 gtid set。
		用于表示当前binlog文件之前已经执行过的GTID集合，记录在Binlog文件头，例如：
			# at 120 
			#130502 23:23:27 server id 119821  end_log_pos 231 CRC32 0x4f33bb48     Previous-GTIDs 
			# 10a27632-a909-11e2-8bc7-0010184e9e08:1, 
			# 7a07cd08-ac1b-11e2-9fcf-0010184e9e08:1-1129
			这个字符串，用“：”分开，前面表示这个服务器的server_uuid，这是一个128位的随机字符串，在第一次启动时生成（函数generate_server_uuid），对应的variables是只读变量server_uuid。 它能以极高的概率保证全局唯一性，并存到文件DATA/auto.cnf中。因此要注意保护这个文件不要被删除或修改，不然就麻烦了。
			第二部分是一个自增的事务ID号，事务id号+server_uuid来唯一标示一个事务。
			除了单独的GTID外，还有一个GTID SET的概念。一个GTID SET的表示类似于：
				7a07cd08-ac1b-11e2-9fcf-0010184e9e08:1-31
			GTID_EXECUTED和GTID_PURGED是典型的GTID SET类型变量；在一个复制拓扑中，GTID_EXECUTED 可能包含好几组数据，例如：
				mysql> show global variables like ‘%gtid_executed%’\G

				*************************** 1. row ***************************
				Variable_name: gtid_executed
						Value: 10a27632-a909-11e2-8bc7-0010184e9e08:1-4,
				153c0406-a909-11e2-8bc7-0010184e9e08:1-3,
				7a07cd08-ac1b-11e2-9fcf-0010184e9e08:1-31,
				f914fb74-a908-11e2-8bc6-0010184e9e08:1
				
			参考：
				https://blog.csdn.net/shaochenshuo/article/details/54138317   [MySQL 5.6] GTID内部实现、运维变化及存在的bug
			
	由各个 event 组成 binlog 的完整格式。

4. show binlog events 
	binlog是由一个一个event组成的，之前讲过我们可以使用 show binlog events in binlog.xxxx 的语法来查看这些事件

	
5. 小结
	在主从间Event起到了数据的载体功能，他们在主从之间传递，它们可以说是一组协议
	每个 binary log都是由开头的4byte的魔术数和一个一个event组成	
	由各个 event 组成 binlog 的完整格式。
	
	修改数据不止一行的情况 
		DML语句都可以一条语句变更多条数据，这种情况下实际它们只需要将行数据增加到这个 event 就可以了。
		一个 event 不可以无限大, 本次加入的数据加上已有的数据的大小大于 8192 bytes 就会新建一个 event 来继续存
		一个 DML event 中可以包含多行数据，其大小 应该在 8192 bytes 左右，因此大事务(操作多行)可能包含多个 DML event 即一个大事务可能跨 event
		# 一个事务可以有多个 event , 一个 Event 最大为8K左右
		# 差不多理解了.
	
	写入 binlog cache 时机
		
		如果DML语句涉及到多行数据的变更，根据修改量的大小可能会生成多个DML event
		实际上每次新开启一个 DML event 之后都会将现有的 event 写入到 binlog cache
		因此并不是等到所有的 DML event 生成后才一次性写入 binlog cache，那样会带来更多的内存消耗是不可取的
		UPDATE_ROWS_EVENT 和 DELETE_ROWS_EVENT 其生成时机和写入 binlog cache 时机跟 W_EVENT 一致。
			
		
		
	