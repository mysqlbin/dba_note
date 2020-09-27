

1. WRITE_ROWS_EVENT

	1.1 WRITE_ROWS_EVENT 的作用
		WRITE_ROWS_EVENT 是 insert 语句生成的 event
		用于记录 insert 语句的 after_image 实际数据，包含 table_id、映像位图、字段数量、行数据位图等信息
		实际上所有的DML语句虽然客户端看来是一条语句，但是 event 记录的时候是以行为单位的，而且是更改一行记录一行
		一个 event 会记录有多行
		# 第 14 章节详细说明这种流程
		
		
	1.2 主体格式 
		固定部分
			table_id
				6 bytes
				不包含访问表的具体信息，只包含一个 table_id，因为 MAP_EVENT  中已经包含了相应的 table_id到实际访问表的映射
				
			reserved
				2 bytes
				保留以后使用
				
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
			row real data
				实际行数据
				
	1.3 生成时机
		W_EVENT 只会在行模式下生成，跟 UPDATE_ROW_EVENT/DELETE_ROW_EVENT 一样，通常它们生成的时机都是第一条数据在InnoDB层变更完成后，但是
		是在 QUERY_EVENT 和 MAP_EVENT 之后。
		
	1.4 修改数据不止一行的情况 
		DML语句都可以一条语句变更多条数据，这种情况下实际它们只需要将行数据增加到这个 event 就可以了。
		一个 event 不可以无限大, 本次加入的数据加上已有的数据的大小大于 8192 bytes 就会新建一个 event 来继续存
		一个 DML event 中可以包含多行数据，其大小 应该在 8192 bytes 左右，因此大事务(操作多行)可能包含多个 DML event.
		# 差不多理解了.
		
	1.5 写入 binlog cache 时机
		
		如果DML语句涉及到多行数据的变更，根据修改量的大小可能会生成多个DML event
		实际上每次新开启一个 DML event 之后都会将现有的 event 写入到 binlog cache
		因此并不是等到所有的 DML event 生成后才一次性写入 binlog cache，那样会带来更多的内存消耗是不可取的
		
		UPDATE_ROWS_EVENT 和 DELETE_ROWS_EVENT 其生成时机和写入 binlog cache 时机跟 W_EVENT 一致。
		
	
2. DELETE_ROWS_EVENT

	2.1 DELETE_ROWS_EVENT 的作用
		DELETE_ROWS_EVENT 是 delete 语句生成的 event
		主要用于记录 delete 语句的 before_image 实际数据，其中还包含 table_id、映像位图、字段数量、行数据位图等信息
		
	2.2 主体格式 
		固定部分
			table_id
				6 bytes
				不包含访问表的具体信息，只包含一个 table_id，因为 MAP_EVENT  中已经包含了相应的 table_id到实际访问表的映射
				
			reserved
				2 bytes
				保留以后使用
				
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
			row real data
				实际行数据

	
3. WRITE_ROWS_EVENT 跟  DELETE_ROWS_EVENT 基本上没有什么区别 
   唯一的区别在于 event header 的 type.
   
   
	
	
	