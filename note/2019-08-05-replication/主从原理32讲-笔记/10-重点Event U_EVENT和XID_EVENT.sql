

1. UPDATE_ROWS_EVENT
1.1 UPDATE_ROWS_EVENT 的作用
	UPDATE_ROWS_EVENT 是 Update 语句生成的 event
	主要用于记录 Update 语句的 before_image 实际数据 和 after_image 实际数据，还包含 table_id、映像位图、字段数量、行数据位图等信息
	
1.2 主体格式
	UPDATE_ROWS_EVENT 格式更加复杂一些，因为要 记录 before_image实际数据 和 after_image 实际数据
	固定部分
		table_id
			6 bytes
		reserved
			2 bytes
			
	可变部分
		var_header_len
			当前 2 bytes 通过为 '0x02 00'
		columns_width
			字段个数
		columns_after_image
			after_image 位图，最少 1 bytes
			如果 binlog_row_image 参数设置为 FULL ， 那么 columns_after_image 会记录为 '0xff'
		row Bit-field
			位图，最少 1 bytes
			这个数据是行数据自身携带的，也就是构造 event 的时候传入的，每位代表一个字段
			如果字段有实际数据则本位为 0 ，如果为 NULL 则 为 1
		row real data
			实际行数据
		row Bit-field 和  row real data 分为 before_image 和 after_image
	
	
2. XID_EVENT
2.1 XID的作用
	解析 binary log 的时候经常会看到在事务结束提交的位置会包含一个 XID，如下所示

			190511 11:06:54 server id 123306  end_log_pos 439 CRC32 0x1c809de0     Xid = 614
   		    COMMIT/*!*/;
	
	XID 实际是 binary log 和 InnoDB层之间保证事务一致性的桥梁
	COMMIT表示事务提交成功之后写入的状态， XID 表示事务被正确提交了。
	
	
2.2 XID_EVENT 的作用	
	XID_EVENT 就是用于携带XID的event
	从库应用的时候将会进行 commit 操作
	和 GTID_LOG_EVENT 一样，它们 event header 的 timestamp 都是 commit 命令发起的时间，如果没有显示开启事务那么  timestamp 还是 DML命令发起的时间
	
2.3 主体格式
	可变部分
		xid：
			8 bytes
			记录的就是XID的值
			
2.4 生成时机
	XID在事务的第一条语句就已经定了，但是 构造 event 和 写入到 binlog cache 是在整个提交过程的 prepare 之后， order commit 之前。
	

	