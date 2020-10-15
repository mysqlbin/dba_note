
1. mysql.gtid_executed表/gtid_executed变量/gtid_purged变量
	1.1 mysql.gtid_executed表
	1.2 gtid_executed变量
	1.3 gtid_purged变量
	
2. 讨论主库修改时机、从库修改时机、通用修改时机
	2.1 主库修改时机
	2.2 从库修改时机
	2.3 通用修改时机
	
	
1. mysql.gtid_executed表/gtid_executed变量/gtid_purged变量

	1.1 mysql.gtid_executed表：
	
		GTID持久化的介质，GTID模块初始化的时候会读取这个表来作为获取gtid_executed变量的基础。
		也就是说  mysql.gtid_executed表 作为 GTID模块初始化获取 gtid_executed变量的起点。
		
	1.2 gtid_executed变量：
	
		表示数据库中执行了哪些GTID，它是一个GTID SET处于内存中。‘show slave status’中的Executed_Gtid_Set和‘show master status’中的Executed_Gtid_Set都来自于它。

	1.3 gtid_purged变量：
	
		表示由于binary log文件的删除(如purge binary logfiles或者超过expire_logs_days设置)已经丢失的GTID Event它是一个GTID SET处于内存中。
		
		我们在搭建备库的时候，通常需要使用‘set global gtid_purged’命令来设置本变量，用于表示这个备份已经执行了哪些GTID操作。
		注意手动删除binary log将不会更新这个变量。
		
2. 讨论主库修改时机、从库修改时机、通用修改时机

	我们先来达成一个共识，gtid_executed变量一定是实时更新的，不管主库还是从库。我们的讨论将分为三部分：
	
	2.1 主库修改时机
		2.1.1 binlog关闭
			不生成Gtid,mysql.gtid_executed表/gtid_executed变量/gtid_purged变量均不更新。
			
		2.1.2 binlog打开
			mysql.gtid_executed表修改时机
				在binlog发生切换(rotate)的时候保存直到上一个binlog文件执行过的全部Gtid，它不是实时更新的。	
				# 已经验证过。
				
			gtid_executed变量修改时机
				在述 ordered_commit flush 阶段生成Gtid，在commit阶段才计入gtid_executed变量，它是实时更新的。
				
			gtid_purged变量修改时机	
				在Mysql触发的清理binlog的情况下，比如purge binary logs to或者超过参数expire_logs_days设置的天数后自动删除，需要将丢失的Gtid计入这个变量中。
				
	2.2 从库修改时机
		
		2.2.1 binlog关闭或者binlog开启参数log_slave_updates关闭的情况
			mysql.gtid_executed表修改时机
				
				实时更新
				这种情况下从库没有办法通过binlog来持久化sql_thread执行过的Gtid事务，只能通过实时更新mysql.gtid_executed表来保存，所以必须要要实时将Gtid持久化到mysql.gtid_executed表中。实际上实时保存mysql.gtid_executed发生在commit的preper阶段之前，也就是最开始。但是对于主库来讲由于还没有生成Gtid，那么则不能写入
			
			gtid_executed变量修改时机
				这个和主库一样实时更新，不做讨论。
				
			gtid_purged变量修改时机
				由于压根没有binlog来记录已经执行过的Gtid事务，所以gtid_purged变量实时更新
			
				# 需要验证
			
		2.2.2 binlog开启同时参数log_slave_updates开启的情况
		
			这种情况sql_thread执行过的Gtid事务可以通过binlog进行维护，所以mysql.gtid_executed表和gtid_purged变量不需要实时更新。
			
			mysql.gtid_executed表修改时机
				和主库一致。及在进行日志切换的时候进行更新，不做讨论
		
			gtid_executed变量修改时机
				和主库一样实时更新，不做讨论

			gtid_purged变量修改时机
				和主库一致，binlog删除时更新，不做讨论
		
			# 验证后印象会更加深刻。
			
	2.3 通用更改时机

		2.3.1 mysql.gtid_executed表修改时机
			在 reset master 的时候清空本表	
			在 set global gitd_purged 的时候，设置本表
			
		2.3.2 gtid_executed变量修改时机
			在 reset master 的时候清空本变量
			在 set global gitd_purged 的时候，设置本变量
			在mysql启动的时候初始化设置gtid_executed变量，这个将在后面章节详细描述描述步骤。
			
		2.3.3 gtid_purged变量修改时机
			在 reset master 的时候清空本变量
			在 set global gitd_purged 的时候，设置本变量
			在mysql启动的时候初始化设置gtid_executed变量，这个将在后面章节详细描述描述步骤。
		

