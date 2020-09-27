

GTID_LOG_EVENT 和 ANONYMOUS_GTID_LOG_EVENT 格式一致，只是携带的数据不一样而已

1. GTID_LOG_EVENT
	1.1 主要记录的部分有3个
	
1.1 GTID_LOG_EVENT 这个event主要记录的部分有3个即作用
	1. 记录GTID的详细信息
	2. 记录逻辑时钟详细信息，即 last commit 和 seq number
	3. 是否为行模式，比如 DDL 语句就不是行模式的。
	
	显示开启事务的情况下 GTID_LOG_EVENT 和 XID_EVENT event header 的 timestamp 都是 commit 命令发起的时间，当然如果没有显示开启事务那么 timestamp 还是命令发起的时间
	
1.2 主体格式
	GTID_LOG_EVENT 的 event data 部分只有固定部分，没有可变部分
	固定部分
		flags
			1 bytes
			主要用于表达是否是行模式的，如果是则为 0X00，不是则为 0X01
			
		server_uuid
			16 bytes
		
		gno
			8 bytes
			小端显示
			表示GTID的序号
		
		ts type 
			1 bytes
			
		last commit
			8 bytes
			小端显示
		
		seq number
			8 bytes
			小端显示
		
	其中 last commit 和 seq number 的生成方式会在后面第15节和第16节进行详细描述。

1.3 生成时机
	GTID_LOG_EVENT 的生成和写入 binary log 文件都是 order commit 的 flush 阶段
	
1.4 ANONYMOUS_GTID_LOG_EVENT
	
	这个是匿名GTID event，5.7 如果不开启GTID则使用这种格式
	它除了不生成GTID相关信息外和GTID_LOG_EVENT 保持一致，即如下部分全部为0：
		server_uuid
		gno
		
1.5 GTID 三种模式
	自动生成GTID: 主库一般是这种情况 （AUTOMATIC_GROUP）
	指定GTID：    从库或者使用 GTID_NEXT 一般就是这种情况（GTID_GROUP）
	匿名GTID:     也就是不开启 GTID 的情况 （ANONYMOUS_GROUP）
	
1.6 GTID_LOG_EVENT 在 binlog 中的样式

	#200307 15:01:33 server id 330640  end_log_pos 829 CRC32 0x0a8ab72f 	GTID	last_committed=2	sequence_number=3	rbr_only=yes  
	/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
	SET @@SESSION.GTID_NEXT= '7af746a1-5c2d-11ea-bc75-00163e08b460:5603'/*!*/;															  # gtid event
	
	
	# gtid_next=automatic，代表使用默认值。MySQL 就会把 server_uuid:gno 分配给这个事务：
        a. 记录 binlog 的时候，先记录一行 SET @@SESSION.GTID_NEXT=‘server_uuid:gno’;
        b. 把这个GTID加入本实例的GTID集合
		
		