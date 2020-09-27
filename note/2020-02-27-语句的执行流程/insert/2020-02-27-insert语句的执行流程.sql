
0. insert 语句的大概插入流程
1. 为什么看不到正在执行插入的数据
2. kill 掉一个线程，为什么看不到回滚的的数据？
3. kill 在做什么处理											   
4. 相关参考
5. 思考


0. insert 语句的大概插入流程
	https://www.jianshu.com/p/5248ca67eac2  MySQL：一个简单insert语句的大概流程

1. 为什么看不到正在执行插入的数据

	show engine innodb status 的重点信息如下：
	---TRANSACTION 1951556378, ACTIVE 1083 sec inserting, thread declared inside InnoDB 5000
		mysql tables in use 1, locked 1
		1 lock struct(s), heap size 360, 0 row lock(s), undo log entries 4211218
		MySQL thread id 3018247, OS thread handle 0x7fb927800700, query id 6881189514 11 web_user update
		INSERT INTO Table_AgentWithdrawalRecord
													   (Application
													   ,Superior
													   ,Money
													   ,State
													   ,Type
													   ,Grade
													   ,CreateTime)
													VALUES
													   (_Name
													   ,_NameXJ
													   ,(($totalFree*(_DMSPriceOne-_DMSPrice))/100)
													   ,0
													   ,1
													   ,1
												   ,NOW())
	
	首先 insert 语句的大概插入流程如下：
		事务正在执行过程：
			写 Undo， 对于insert和delete，undo中会记录键值，delete操作只是标记删除(delete mark)记录。
			写 buffer pool 缓冲池
			写 redo log buffer
		
		事务提交：
			事务提交成功后才可以看到已经插入的数据。
			
		
	因为事务并没有提交（提交了的事务才能被看到），其一直处在 正在执行过程 阶段，所以看不到正在插入的数据。
		
		
		
	
2. kill 掉一个线程，为什么看不到回滚的的数据？												   
	
	show engine innodb status 的重点信息如下：
	---TRANSACTION 1951556378, ACTIVE 1083 sec inserting, thread declared inside InnoDB 5000
		mysql tables in use 1, locked 1
		1 lock struct(s), heap size 360, 0 row lock(s), undo log entries 4211218
		MySQL thread id 3018247, OS thread handle 0x7fb927800700, query id 6881189514 11 web_user update
		INSERT INTO Table_AgentWithdrawalRecord
													   (Application
													   ,Superior
													   ,Money
													   ,State
													   ,Type
													   ,Grade
													   ,CreateTime)
													VALUES
													   (_Name
													   ,_NameXJ
													   ,(($totalFree*(_DMSPriceOne-_DMSPrice))/100)
													   ,0
													   ,1
													   ,1
												   ,NOW())
												   
	首先 insert 语句的大概插入流程如下：
		事务正在执行过程：
			写 Undo， 对于insert和delete，undo中会记录键值，delete操作只是标记删除(delete mark)记录。
			写 buffer pool 缓冲池
			写 redo log buffer
		
		事务提交：
			事务提交成功后才可以看到已经插入的数据。
														   
	
	需要回滚的数据在 Undo 中，而且只会记录键值，所以看到不到回滚的数据，只是可以看到回滚的状态
	
	mysql> show processlist;
			*************************** 10. row ***************************
							trx_id: 1897305171
						 trx_state: RUNNING
					   trx_started: 2020-02-20 20:36:53
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 15282207
			   trx_mysql_thread_id: 2974808
						 trx_query: select EnterPriseID,ZMSPrice,SMSPrice,MMSPrice,XMSPrice,DMSPrice 
													into _EnterPriseIDDJ,_ZMSPriceOne,_SMSPriceOne,_MMSPriceOne,_XMSPriceOne,_DMSPriceOne 
													from EnterPrise where EnterPriseID=_EnterPriseID
			   trx_operation_state: starting index read
				 trx_tables_in_use: 1
				 trx_tables_locked: 0
				  trx_lock_structs: 1
			 trx_lock_memory_bytes: 360
				   trx_rows_locked: 0
				 trx_rows_modified: 15282206
		   trx_concurrency_tickets: 5000
			   trx_isolation_level: REPEATABLE READ
				 trx_unique_checks: 1
			trx_foreign_key_checks: 1
		trx_last_foreign_key_error: NULL
		 trx_adaptive_hash_latched: 0
		 trx_adaptive_hash_timeout: 10000
				  trx_is_read_only: 0
		trx_autocommit_non_locking: 0
		
	mysql> kill 2974808;
	
	mysql> show processlist;
			*************************** 8. row ***************************
							trx_id: 1897305171
						 trx_state: ROLLING BACK
					   trx_started: 2020-02-20 20:36:53
			 trx_requested_lock_id: NULL
				  trx_wait_started: NULL
						trx_weight: 7895613
			   trx_mysql_thread_id: 2974808
						 trx_query: NULL
			   trx_operation_state: rollback
				 trx_tables_in_use: 0
				 trx_tables_locked: 0
				  trx_lock_structs: 1
			 trx_lock_memory_bytes: 360
				   trx_rows_locked: 0
				 trx_rows_modified: 7895612
		   trx_concurrency_tickets: 0
			   trx_isolation_level: REPEATABLE READ
				 trx_unique_checks: 1
			trx_foreign_key_checks: 1
		trx_last_foreign_key_error: NULL
		 trx_adaptive_hash_latched: 0
		 trx_adaptive_hash_timeout: 10000
				  trx_is_read_only: 0
		trx_autocommit_non_locking: 0
	
3. kill 在做什么处理
	
	lu 2-20 22:59:11
	在处理， Kill 掉的线程需要回滚好多条记录。

	liao 2-20 23:02:49
	回滚那些记录？

	liao 2-20 23:03:04
	KILL 不就完了？

	liao 2-20 23:03:43
	你把那几条数据恢复，才会好。

	lu 2-20 23:03:51
	kill 掉不会马上释放的，需要把已经写入(实际没有刷盘)的 7895613 行记录回滚掉，才会释放。
	
	原因： show processlist.trx_weight: 15282207   表示事务影响的行数，如果需要回滚，那么会回滚 1500多W行记录。
	
	-- 回滚操作需要对事务执行期间生成的所有新数据版本做回收操作，耗时很长。
	
4. 相关参考

	https://www.jianshu.com/p/5248ca67eac2  MySQL：一个简单insert语句的大概流程


5. 思考
	1. 下面的语句经历的所有的阶段是通过debug来看到的吗？
		下面是这个语句经历的所有的阶段：

		   126  T@2: | THD::enter_stage: 'starting' /root/mysql5.7.14/percona-server-5.7.14-7/sql/conn_handler/socket_connection.cc:100
		   349  T@2: | | | | | | THD::enter_stage: 'checking permissions' /root/mysql5.7.14/percona-server-5.7.14-7/sql/auth/sql_authorization.cc:843
		   359  T@2: | | | | | | | THD::enter_stage: 'Opening tables' /root/mysql5.7.14/percona-server-5.7.14-7/sql/sql_base.cc:5719
		  1078  T@2: | | | | | THD::enter_stage: 'init' /root/mysql5.7.14/percona-server-5.7.14-7/sql/sql_insert.cc:470
		  1155  T@2: | | | | | | | THD::enter_stage: 'System lock' /root/mysql5.7.14/percona-server-5.7.14-7/sql/lock.cc:321
		  1253  T@2: | | | | | THD::enter_stage: 'update' /root/mysql5.7.14/percona-server-5.7.14-7/sql/sql_insert.cc:663
		  1535  T@2: | | | | | THD::enter_stage: 'end' /root/mysql5.7.14/percona-server-5.7.14-7/sql/sql_insert.cc:881
		  1544  T@2: | | | | THD::enter_stage: 'query end' /root/mysql5.7.14/percona-server-5.7.14-7/sql/sql_parse.cc:5174
		  1603  T@2: | | | | THD::enter_stage: 'closing tables' /root/mysql5.7.14/percona-server-5.7.14-7/sql/sql_parse.cc:5252
		  1730  T@2: | | | THD::enter_stage: 'freeing items' /root/mysql5.7.14/percona-server-5.7.14-7/sql/sql_parse.cc:5855
		  1793  T@2: | | THD::enter_stage: 'cleaning up' /root/mysql5.7.14/percona-server-5.7.14-7/sql/sql_parse.cc:1884
		  1824  T@2: | THD::enter_stage: 'starting' /root/mysql5.7.14/percona-server-5.7.14-7/sql/conn_handler/socket_connection.cc:100
		主要集中在：

		update
		query end


