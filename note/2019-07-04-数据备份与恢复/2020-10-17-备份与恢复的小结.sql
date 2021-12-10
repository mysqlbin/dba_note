

小结
	1. 如果要做 binlog server， 那么在哪一台从库做备份，就做对应备份从库的 binlog server。
		-- GTID模式下不需要这样做，在从库做备份，可以根据主库来做 binlog server。
		
	2. 基于全备加增量binlog的恢复，速度慢

	3. 利用现有的延迟从库做数据恢复，速度更快
		-- 延迟复制的从库，机器配置不需要太好的，一般2核4GB内存就好，待用到的时候再在线升级机器配置。节约成本 。
		start slave until SQL_BEFORE_GTIDS='f7323d17-6442-11ea-8a77-080027758761:110635'; 
		start slave until master_log_file='mysql-bin.000002',master_log_pos=1584; 
		
	4. 以利用IO_Thread、SQL_thread + binlog/relay log来做各种数据的恢复操作。
	 
	5. GTID模式下，在从库做备份，可以用主库的binlog做数据恢复，从库可以不用开启binlog。 
	
	6. 把实验记录下来，方便复习和实际恢复数据的时候快速找到相应的方案。


思考：
	1. GTID的全局唯一性，看看恢复数据会不会简单很多？
		答：会的。 GTID模式下，在从库做备份，可以用主库的binlog做数据恢复，从库可以不用开启binlog。 
		
