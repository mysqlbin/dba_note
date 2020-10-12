


https://dev.mysql.com/doc/refman/5.7/en/create-index.html

https://dev.mysql.com/doc/refman/5.7/en/innodb-online-ddl.html

https://dev.mysql.com/doc/refman/5.7/en/innodb-online-ddl-operations.html

https://www.cnblogs.com/YangJiaXin/p/10828244.html


虽然pt-osc和gh-ost比 online DDL 慢一倍左右，但是对于主从延迟很小。

慢的原因：pt-osc和gh-ost需要产生binlog和redo。



ALTER TABLE tbl_name ADD PRIMARY KEY (column), ALGORITHM=INPLACE, LOCK=NONE;


思考：
	在线操作索引，不需要重建表，工作原理是怎么样的？
	
	
	
The LOCK clause is useful for fine-tuning the degree of concurrent access to the table. The ALGORITHM clause is primarily intended for performance comparisons and as a fallback to the older table-copying behavior in case you encounter any issues. For example:
	LOCK子句可用于微调对表的并发访问程度。 ALGORITHM子句主要用于性能比较，并在遇到任何问题时作为对较早的表复制行为的后备。 例如：
		
	1. To avoid accidentally making the table unavailable for reads, writes, or both, specify a clause on the ALTER TABLE statement such as LOCK=NONE (permit reads and writes) or LOCK=SHARED (permit reads). The operation halts immediately if the requested level of concurrency is not available.
		为避免意外使表不可用于读取和/或写入，请在ALTER TABLE语句上指定一个子句，例如LOCK = NONE（允许读写）或LOCK = SHARED（允许读取）。 如果请求的并发级别不可用，该操作将立即停止。
		
		
	2. To compare performance between algorithms, run a statement with ALGORITHM=INPLACE and ALGORITHM=COPY. Alternatively, run a statement with the old_alter_table configuration option disabled and enabled.
		要比较算法之间的性能，请使用ALGORITHM = INPLACE和ALGORITHM = COPY运行一条语句。 或者，在禁用和启用old_alter_table配置选项的情况下运行语句。


	3. To avoid tying up the server with an ALTER TABLE operation that copies the table, include ALGORITHM=INPLACE. The statement halts immediately if it cannot use the in-place mechanism.
		为避免使用复制表的ALTER TABLE操作捆绑服务器，请包含ALGORITHM = INPLACE。 如果无法使用就地机制，该语句将立即暂停。
		
		
