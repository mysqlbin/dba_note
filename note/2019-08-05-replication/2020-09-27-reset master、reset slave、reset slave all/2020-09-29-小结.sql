

1. 主库执行了 reset master之后，从库不需要重建。

2. 主库 reset master 触发的行为
	2.1 reset master重置的信息
		清除 GTID 信息：
			mysql.gtid_executed 表信息
			gtid_executed
			gtid_purged
			
		清空 binary log

		也就是说重置GTID信息、清空binary log。
		

	2.2 主库执行 reset maser，slave会发生什么
		slave会报错，需要重建从库。 
		-- 操作要谨慎。
		-- 目前通过实验，明白了GTID模式下，主库执行 reset master，从库并不需要重建。
		
		
3.  reset slave会重置的信息

	1. master_info_repository=TABLE和relay_log_info_repository=TABLE
	
		会清空 mysql.slave_master_info和mysql.slave_relay_log_info表的信息。
		
		
	3. 删除所有的 relay log（中继日志）文件 并且 创建一个新的 relay log 文件
		It clears the master info and relay log info repositories, deletes all the relay log files, and starts a new relay log file
		重置中继日志。
		
	4. GTID 模式下：
		不影响GTID的执行信息， 比如不会重置gtid_executed变量、gtid_purged变量、mysql.gtid_executed表
		issuing RESET SLAVE has no effect on the GTID execution history. The statement does not change the values of gtid_executed or gtid_purged, or the mysql.gtid_executed table.
		
		
	5. reset slave 存在的问题：
		RESET SLAVE有个问题，它虽然删除了上述文件，但内存中的 change master 信息并没有删除，
		此时，可直接执行start slave，但因为删除了master.info和relay-log.info，它会从头开始接受主的binlog并应用。
		传统复制下会报错，GTID模式下执行start slave则不会有问题。
		
		
		
		
		