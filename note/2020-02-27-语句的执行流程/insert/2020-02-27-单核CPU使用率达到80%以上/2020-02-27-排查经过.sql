
1. show processlist
2. SELECT * FROM INFORMATION_SCHEMA.INNODB_TRX
3. show engine innodb status
4. 小结

1. show processlist
	mysql> show processlist;
	+---------+-----------------+----------------------+------+-------------+----------+-----------------------------------------------------------------------+------------------------------------------------------------------------------------------------------+
	| Id      | User            | Host                 | db   | Command     | Time     | State                                                                 | Info                                                                                                 |
	+---------+-----------------+----------------------+------+-------------+----------+-----------------------------------------------------------------------+------------------------------------------------------------------------------------------------------+
	|       1 | event_scheduler | localhost            | NULL | Daemon      |       79 | Waiting for next activation                                           | NULL                                                                                                 |
	| 1595818 | repl            | 10.45.186.60:52012   | NULL | Binlog Dump | 33918736 | Master has sent all binlog to slave; waiting for binlog to be updated | NULL                                                                                                 |
	| 2520601 | app_user        | 10.30.210.129:31258  | yldb | Sleep       |        8 |                                                                       | NULL                                                                                                 |
	| 2520602 | app_user        | 10.30.210.129:31260  | yldb | Sleep       |        1 |                                                                       | NULL                                                                                                 |
	| 2520603 | app_user        | 10.30.210.129:31262  | yldb | Sleep       |        1 |                                                                       | NULL                                                                                                 |
	| 2520604 | app_user        | 10.30.210.129:31264  | yldb | Sleep       |        1 |                                                                       | NULL                                                                                                 |
	| 2520605 | app_user        | 10.30.210.129:31266  | yldb | Sleep       |        1 |                                                                       | NULL                                                                                                 |
	| 2520606 | app_user        | 10.30.210.129:31270  | yldb | Sleep       |     2053 |                                                                       | NULL                                                                                                 |
	| 2520607 | app_user        | 10.30.210.129:31272  | yldb | Sleep       |     1961 |                                                                       | NULL                                                                                                 |
	| 2520608 | app_user        | 10.30.210.129:31274  | yldb | Sleep       |     1952 |                                                                       | NULL                                                                                                 |
	| 2520609 | app_user        | 10.30.210.129:31276  | yldb | Sleep       |     2170 |                                                                       | NULL                                                                                                 |
	| 2520610 | app_user        | 10.30.210.129:31278  | yldb | Sleep       |     2157 |                                                                       | NULL                                                                                                 |
	| 2520611 | app_user        | 10.30.210.129:31282  | yldb | Sleep       |        1 |                                                                       | NULL                                                                                                 |
	| 2520612 | app_user        | 10.30.210.129:31284  | yldb | Sleep       |        1 |                                                                       | NULL                                                                                                 |
	| 2520613 | app_user        | 10.30.210.129:31286  | yldb | Sleep       |        8 |                                                                       | NULL                                                                                                 |
	| 2520614 | app_user        | 10.30.210.129:31288  | yldb | Sleep       |        7 |                                                                       | NULL                                                                                                 |
	| 2520615 | app_user        | 10.30.210.129:31290  | yldb | Sleep       |        1 |                                                                       | NULL                                                                                                 |
	| 3015175 | app_user        | 10.29.64.46:47802    | yldb | Sleep       |        1 |                                                                       | NULL                                                                                                 |
	| 3015176 | app_user        | 10.29.64.46:47804    | yldb | Sleep       |        1 |                                                                       | NULL                                                                                                 |
	| 3015177 | app_user        | 10.29.64.46:47806    | yldb | Sleep       |        1 |                                                                       | NULL                                                                                                 |
	| 3015178 | app_user        | 10.29.64.46:47808    | yldb | Sleep       |        0 |                                                                       | NULL                                                                                                 |
	| 3015179 | app_user        | 10.29.64.46:47810    | yldb | Sleep       |        2 |                                                                       | NULL                                                                                                 |
	| 3015180 | app_user        | 10.29.64.46:47812    | yldb | Sleep       |        2 |                                                                       | NULL                                                                                                 |
	| 3015181 | app_user        | 10.29.64.46:47814    | yldb | Sleep       |        2 |                                                                       | NULL                                                                                                 |
	| 3015182 | app_user        | 10.29.64.46:47816    | yldb | Sleep       |        2 |                                                                       | NULL                                                                                                 |
	| 3015183 | app_user        | 10.29.64.46:47818    | yldb | Sleep       |        2 |                                                                       | NULL                                                                                                 |
	| 3015184 | app_user        | 10.29.64.46:47820    | yldb | Sleep       |        2 |                                                                       | NULL                                                                                                 |
	| 3015185 | app_user        | 10.29.64.46:47832    | yldb | Sleep       |    48551 |                                                                       | NULL                                                                                                 |
	| 3015186 | app_user        | 10.29.64.46:47834    | yldb | Sleep       |    48551 |                                                                       | NULL                                                                                                 |
	| 3015187 | app_user        | 10.30.210.161:42054  | yldb | Sleep       |       10 |                                                                       | NULL                                                                                                 |
	| 3015188 | app_user        | 10.30.210.161:42056  | yldb | Sleep       |       51 |                                                                       | NULL                                                                                                 |
	| 3015189 | app_user        | 10.29.250.218:23547  | yldb | Sleep       |        9 |                                                                       | NULL                                                                                                 |
	| 3015190 | app_user        | 10.29.250.218:23549  | yldb | Sleep       |        3 |                                                                       | NULL                                                                                                 |
	| 3015191 | app_user        | 10.29.250.218:23551  | yldb | Sleep       |        0 |                                                                       | NULL                                                                                                 |
	| 3015192 | app_user        | 10.29.250.218:23553  | yldb | Sleep       |       15 |                                                                       | NULL                                                                                                 |
	| 3015193 | app_user        | 10.29.253.186:10663  | yldb | Sleep       |        1 |                                                                       | NULL                                                                                                 |
	| 3015194 | app_user        | 10.29.253.186:10664  | yldb | Sleep       |        0 |                                                                       | NULL                                                                                                 |
	| 3015195 | app_user        | 10.29.253.186:10665  | yldb | Sleep       |       16 |                                                                       | NULL                                                                                                 |
	| 3015196 | app_user        | 10.29.253.186:10666  | yldb | Sleep       |        4 |                                                                       | NULL                                                                                                 |
	| 3015197 | app_user        | 10.29.253.186:10671  | yldb | Sleep       |        4 |                                                                       | NULL                                                                                                 |
	| 3015198 | app_user        | 10.29.253.186:10672  | yldb | Sleep       |        3 |                                                                       | NULL                                                                                                 |
	| 3015200 | app_user        | 10.169.231.171:56705 | yldb | Sleep       |        0 |                                                                       | NULL                                                                                                 |
	| 3015201 | app_user        | 10.169.231.171:56706 | yldb | Sleep       |        2 |                                                                       | NULL                                                                                                 |
	| 3015202 | app_user        | 10.169.231.171:56707 | yldb | Sleep       |       17 |                                                                       | NULL                                                                                                 |
	| 3015203 | app_user        | 10.169.231.171:56709 | yldb | Sleep       |        3 |                                                                       | NULL                                                                                                 |
	| 3015204 | app_user        | 10.169.231.171:56711 | yldb | Sleep       |       41 |                                                                       | NULL                                                                                                 |
	| 3015205 | app_user        | 10.169.231.171:56713 | yldb | Sleep       |       17 |                                                                       | NULL                                                                                                 |
	| 3015206 | app_user        | 10.169.231.171:56716 | yldb | Sleep       |       40 |                                                                       | NULL                                                                                                 |
	| 3015207 | app_user        | 10.169.231.171:56717 | yldb | Sleep       |       41 |                                                                       | NULL                                                                                                 |
	| 3015208 | app_user        | 10.169.231.171:56718 | yldb | Sleep       |        2 |                                                                       | NULL                                                                                                 |
	| 3015209 | app_user        | 10.169.231.171:56720 | yldb | Sleep       |       40 |                                                                       | NULL                                                                                                 |
	| 3015210 | app_user        | 10.169.231.171:56719 | yldb | Sleep       |        3 |                                                                       | NULL                                                                                                 |
	| 3015211 | app_user        | 10.169.231.171:56721 | yldb | Sleep       |        1 |                                                                       | NULL                                                                                                 |
	| 3015212 | app_user        | 10.169.231.171:56723 | yldb | Sleep       |       12 |                                                                       | NULL                                                                                                 |
	| 3015213 | app_user        | 10.169.231.171:56724 | yldb | Sleep       |       41 |                                                                       | NULL                                                                                                 |
	| 3015214 | app_user        | 10.169.231.171:56725 | yldb | Sleep       |       11 |                                                                       | NULL                                                                                                 |
	| 3015215 | app_user        | 10.169.231.171:56726 | yldb | Sleep       |       41 |                                                                       | NULL                                                                                                 |
	| 3015216 | app_user        | 10.169.231.171:56727 | yldb | Sleep       |       40 |                                                                       | NULL                                                                                                 |
	| 3015217 | root            | %:56728              | yldb | Query       |        0 | query end                                                             | insert into Table_Web_UserZhangJi(
					nGameId,TableId,nPlayerID,szNickName, szStartTime,s |
	| 3015218 | app_user        | 10.169.200.130:27408 | yldb | Sleep       |       37 |                                                                       | NULL                                                                                                 |
	| 3015219 | app_user        | 10.169.200.130:27410 | yldb | Sleep       |       37 |                                                                       | NULL                                                                                                 |
	| 3015220 | app_user        | 10.169.200.130:27409 | yldb | Sleep       |       14 |                                                                       | NULL                                                                                                 |
	| 3015221 | app_user        | 10.169.200.130:27411 | yldb | Sleep       |       18 |                                                                       | NULL                                                                                                 |
	| 3015222 | app_user        | 10.169.200.130:27412 | yldb | Sleep       |       36 |                                                                       | NULL                                                                                                 |
	| 3015223 | app_user        | 10.169.200.130:27413 | yldb | Sleep       |       37 |                                                                       | NULL                                                                                                 |
	| 3015224 | app_user        | 10.169.200.130:27416 | yldb | Sleep       |       37 |                                                                       | NULL                                                                                                 |
	| 3015225 | app_user        | 10.169.200.130:27417 | yldb | Sleep       |        3 |                                                                       | NULL                                                                                                 |
	| 3015226 | app_user        | 10.169.200.130:27419 | yldb | Sleep       |       37 |                                                                       | NULL                                                                                                 |
	| 3015227 | app_user        | 10.169.200.130:27420 | yldb | Sleep       |        3 |                                                                       | NULL                                                                                                 |
	| 3015228 | app_user        | 10.169.200.130:27421 | yldb | Sleep       |        1 |                                                                       | NULL                                                                                                 |
	| 3015229 | app_user        | 10.169.200.130:27422 | yldb | Sleep       |        0 |                                                                       | NULL                                                                                                 |
	| 3015230 | app_user        | 10.169.200.130:27423 | yldb | Sleep       |        2 |                                                                       | NULL                                                                                                 |
	| 3015231 | app_user        | 10.169.200.130:27426 | yldb | Sleep       |        3 |                                                                       | NULL                                                                                                 |
	| 3015232 | app_user        | 10.169.200.130:27427 | yldb | Sleep       |       12 |                                                                       | NULL                                                                                                 |
	| 3015233 | app_user        | 10.169.200.130:27432 | yldb | Sleep       |       17 |                                                                       | NULL                                                                                                 |
	| 3015234 | app_user        | 10.29.57.36:59780    | yldb | Sleep       |       23 |                                                                       | NULL                                                                                                 |
	| 3015235 | app_user        | 10.29.57.36:59782    | yldb | Sleep       |        2 |                                                                       | NULL                                                                                                 |
	| 3015236 | app_user        | 10.29.57.36:59784    | yldb | Sleep       |        9 |                                                                       | NULL                                                                                                 |
	| 3015237 | app_user        | 10.29.57.36:59785    | yldb | Sleep       |        5 |                                                                       | NULL                                                                                                 |
	| 3015238 | root            | %:59786              | yldb | Query       |        0 | query end                                                             | update Table_User set  nCardCount = _tmpCardCount2 where nPlayerId=$intPlayerId                      |
	| 3015239 | app_user        | 10.29.57.36:59790    | yldb | Sleep       |        3 |                                                                       | NULL                                                                                                 |
	| 3015240 | app_user        | 10.29.57.36:59791    | yldb | Sleep       |       25 |                                                                       | NULL                                                                                                 |
	| 3015241 | app_user        | 10.29.57.36:59794    | yldb | Sleep       |        4 |                                                                       | NULL                                                                                                 |
	| 3015242 | app_user        | 10.29.57.36:59795    | yldb | Sleep       |       11 |                                                                       | NULL                                                                                                 |
	| 3018223 | web_user        | 10.27.179.56:44986   | yldb | Sleep       |      128 |                                                                       | NULL                                                                                                 |
	| 3018247 | root            | %:45084              | yldb | Query       |        0 | closing tables                                                        | select AccountName into _Name from AccountInfo where  EnterPriseID=_EnterPriseID                     |
	| 3018334 | root            | 10.80.235.41:48634   | NULL | Sleep       |      137 |                                                                       | NULL                                                                                                 |
	| 3018335 | root            | 10.80.235.41:48636   | NULL | Sleep       |      135 |                                                                       | NULL                                                                                                 |
	| 3018337 | root            | 10.80.235.41:48642   | NULL | Sleep       |      117 |                                                                       | NULL                                                                                                 |
	| 3018350 | root            | localhost            | NULL | Query       |        0 | init                                                                  | show processlist                                                                                     |
	+---------+-----------------+----------------------+------+-------------+----------+-----------------------------------------------------------------------+------------------------------------------------------------------------------------------------------+
	90 rows in set (0.00 sec)

	
	进入提交逻辑  
		mysql_execute_command
		>切换session状态为 query end
		
	closing tables

2. SELECT * FROM INFORMATION_SCHEMA.INNODB_TRX

	mysql> SELECT * FROM INFORMATION_SCHEMA.INNODB_TRX\G;
	*************************** 1. row ***************************
						trx_id: 1951556378
					 trx_state: RUNNING
				   trx_started: 2020-02-27 20:47:59
		 trx_requested_lock_id: NULL
			  trx_wait_started: NULL
					trx_weight: 3924058      # 需要回滚的记录数
		   trx_mysql_thread_id: 3018247      # 线程ID
					 trx_query: call Pro_DividedMoney($intPlayerId,_totalFree,@result)
		   trx_operation_state: NULL
			 trx_tables_in_use: 0
			 trx_tables_locked: 0
			  trx_lock_structs: 1
		 trx_lock_memory_bytes: 360
			   trx_rows_locked: 0
			 trx_rows_modified: 3924057
	   trx_concurrency_tickets: 0
		   trx_isolation_level: REPEATABLE READ
			 trx_unique_checks: 1
		trx_foreign_key_checks: 1
	trx_last_foreign_key_error: NULL
	 trx_adaptive_hash_latched: 0
	 trx_adaptive_hash_timeout: 10000
			  trx_is_read_only: 0
	trx_autocommit_non_locking: 0
	1 row in set (0.00 sec)

	ERROR: 
	No query specified


3. show engine innodb status
	mysql> show engine innodb status\G;
	*************************** 1. row ***************************
	  Type: InnoDB
	  Name: 
	Status: 
	=====================================
	2020-02-27 21:06:02 7fb9276da700 INNODB MONITOR OUTPUT
	=====================================
	Per second averages calculated from the last 23 seconds
	-----------------
	BACKGROUND THREAD
	-----------------
	srv_master_thread loops: 40789647 srv_active, 0 srv_shutdown, 25811133 srv_idle
	srv_master_thread log flush and writes: 66600770
	----------
	SEMAPHORES
	----------
	OS WAIT ARRAY INFO: reservation count 48311791
	OS WAIT ARRAY INFO: signal count 144738968
	Mutex spin waits 19074312433, rounds 28055572593, OS waits 15294322
	RW-shared spins 101983342, rounds 1305468335, OS waits 20857792
	RW-excl spins 69669865, rounds 783791756, OS waits 9199130
	Spin rounds per wait: 14.81 mutex, 12.80 RW-shared, 11.25 RW-excl
	------------------------
	LATEST DETECTED DEADLOCK
	------------------------
	2020-01-28 12:38:30 7fb9269a5700
	*** (1) TRANSACTION:
	TRANSACTION 1714854424, ACTIVE 0 sec inserting, thread declared inside InnoDB 4998
	mysql tables in use 2, locked 2
	LOCK WAIT 6 lock struct(s), heap size 1184, 4 row lock(s), undo log entries 1
	MySQL thread id 2773162, OS thread handle 0x7fb927d5c700, query id 4632044006 10.29.64.46 app_user Sending data
	insert into Table_score_signin (nPlayerID,nSignin) 
			SELECT $playid, d  
	from 
	(
	SELECT DATE_ADD(curdate(),interval -day(curdate())+1 day) as d  UNION
	SELECT DATE_ADD(curdate(),interval -day(curdate())+2 day) as d  UNION
	SELECT DATE_ADD(curdate(),interval -day(curdate())+3 day) as d  UNION
	SELECT DATE_ADD(curdate(),interval -day(curdate())+4 day) as d  UNION
	SELECT DATE_ADD(curdate(),interval -day(curdate())+5 day) as d  UNION
	SELECT DATE_ADD(curdate(),interval -day(curdate())+6 day) as d  UNION
	SELECT DATE_ADD(curdate(),interval -day(curdate())+7 day) as d  UNION
	SELECT DATE_ADD(curdate(),interval -day(curdate())+8 day) as d  UNION
	SELECT DATE_ADD(curdate(),interval -day(curdate())+9 day) as d  UNION
	SELECT DATE_ADD(curdate(),interval -day(curdate())+10 day) as d  UNION
	SELECT DATE_ADD(curdate(),interval -day(curdate())+11 day) as d  UNION
	SELECT DATE_ADD(curdate(),interval -day(cu
	*** (1) WAITING FOR THIS LOCK TO BE GRANTED:
	RECORD LOCKS space id 1726 page no 1674 n bits 728 index `idx_nPlayerID` of table `yldb`.`table_score_signin` trx id 1714854424 lock_mode X insert intention waiting
	Record lock, heap no 1 PHYSICAL RECORD: n_fields 1; compact format; info bits 0
	 0: len 8; hex 73757072656d756d; asc supremum;;

	*** (2) TRANSACTION:
	TRANSACTION 1714854425, ACTIVE 0 sec setting auto-inc lock, thread declared inside InnoDB 4999
	mysql tables in use 2, locked 2
	4 lock struct(s), heap size 1184, 3 row lock(s)
	MySQL thread id 2773161, OS thread handle 0x7fb9269a5700, query id 4632044003 10.29.64.46 app_user Sending data
	insert into Table_score_signin (nPlayerID,nSignin) 
			SELECT $playid, d  
	from 
	(
	SELECT DATE_ADD(curdate(),interval -day(curdate())+1 day) as d  UNION
	SELECT DATE_ADD(curdate(),interval -day(curdate())+2 day) as d  UNION
	SELECT DATE_ADD(curdate(),interval -day(curdate())+3 day) as d  UNION
	SELECT DATE_ADD(curdate(),interval -day(curdate())+4 day) as d  UNION
	SELECT DATE_ADD(curdate(),interval -day(curdate())+5 day) as d  UNION
	SELECT DATE_ADD(curdate(),interval -day(curdate())+6 day) as d  UNION
	SELECT DATE_ADD(curdate(),interval -day(curdate())+7 day) as d  UNION
	SELECT DATE_ADD(curdate(),interval -day(curdate())+8 day) as d  UNION
	SELECT DATE_ADD(curdate(),interval -day(curdate())+9 day) as d  UNION
	SELECT DATE_ADD(curdate(),interval -day(curdate())+10 day) as d  UNION
	SELECT DATE_ADD(curdate(),interval -day(curdate())+11 day) as d  UNION
	SELECT DATE_ADD(curdate(),interval -day(cu
	*** (2) HOLDS THE LOCK(S):
	RECORD LOCKS space id 1726 page no 1674 n bits 728 index `idx_nPlayerID` of table `yldb`.`table_score_signin` trx id 1714854425 lock mode S
	Record lock, heap no 1 PHYSICAL RECORD: n_fields 1; compact format; info bits 0
	 0: len 8; hex 73757072656d756d; asc supremum;;

	Record lock, heap no 656 PHYSICAL RECORD: n_fields 2; compact format; info bits 0
	 0: len 4; hex 8001b144; asc    D;;
	 1: len 4; hex 8008beb2; asc     ;;

	*** (2) WAITING FOR THIS LOCK TO BE GRANTED:
	TABLE LOCK table `yldb`.`table_score_signin` trx id 1714854425 lock mode AUTO-INC waiting
	*** WE ROLL BACK TRANSACTION (2)
	------------
	TRANSACTIONS
	------------
	Trx id counter 1951730280
	Purge done for trx's n:o < 1951730279 undo n:o < 0 state: running but idle
	History list length 3197
	LIST OF TRANSACTIONS FOR EACH SESSION:
	---TRANSACTION 0, not started
	MySQL thread id 3018350, OS thread handle 0x7fb9276da700, query id 6881189512 localhost root init
	show engine innodb status
	---TRANSACTION 1951721712, not started
	MySQL thread id 3015187, OS thread handle 0x7fb926013700, query id 6878638257 10.30.210.161 app_user
	---TRANSACTION 1951721713, not started
	MySQL thread id 3015188, OS thread handle 0x7fb926daa700, query id 6878638259 10.30.210.161 app_user
	---TRANSACTION 1951730063, not started
	MySQL thread id 3015242, OS thread handle 0x7fb925b19700, query id 6881124981 10.29.57.36 app_user
	---TRANSACTION 1951729932, not started
	MySQL thread id 3015241, OS thread handle 0x7fb9258fe700, query id 6881098860 10.29.57.36 app_user
	---TRANSACTION 1951729822, not started
	MySQL thread id 3015240, OS thread handle 0x7fb91ed9d700, query id 6881073606 10.29.57.36 app_user
	---TRANSACTION 1951729792, not started
	MySQL thread id 3015239, OS thread handle 0x7fb926695700, query id 6881063996 10.29.57.36 app_user
	---TRANSACTION 1951730279, not started
	MySQL thread id 3015237, OS thread handle 0x7fb91efe9700, query id 6881189139 10.29.57.36 app_user
	---TRANSACTION 1951729954, not started
	MySQL thread id 3015236, OS thread handle 0x7fb927306700, query id 6881107258 10.29.57.36 app_user
	---TRANSACTION 1951730137, not started
	MySQL thread id 3015238, OS thread handle 0x7fb925809700, query id 6881139340 10.29.57.36 app_user
	---TRANSACTION 1951729935, not started
	MySQL thread id 3015235, OS thread handle 0x7fb9256e3700, query id 6881099610 10.29.57.36 app_user
	---TRANSACTION 1951729574, not started
	MySQL thread id 3015234, OS thread handle 0x7fb91eec3700, query id 6880990792 10.29.57.36 app_user
	---TRANSACTION 1951724388, not started
	MySQL thread id 3015233, OS thread handle 0x7fb925776700, query id 6879349458 10.169.200.130 app_user
	---TRANSACTION 1951729780, not started
	MySQL thread id 3015232, OS thread handle 0x7fb91ef87700, query id 6881049056 10.169.200.130 app_user
	---TRANSACTION 1951729923, not started
	MySQL thread id 3015231, OS thread handle 0x7fb92625f700, query id 6881096320 10.169.200.130 app_user
	---TRANSACTION 1951729563, not started
	MySQL thread id 3015228, OS thread handle 0x7fb927d5c700, query id 6880982139 10.169.200.130 app_user
	---TRANSACTION 1951730025, not started
	MySQL thread id 3015229, OS thread handle 0x7fb934044700, query id 6881118664 10.169.200.130 app_user
	---TRANSACTION 1951729466, not started
	MySQL thread id 3015227, OS thread handle 0x7fb926ce6700, query id 6880961359 10.169.200.130 app_user
	---TRANSACTION 1951728307, not started
	MySQL thread id 3015225, OS thread handle 0x7fb927a4c700, query id 6880584917 10.169.200.130 app_user
	---TRANSACTION 1951727005, not started
	MySQL thread id 3015230, OS thread handle 0x7fb92583a700, query id 6880218700 10.169.200.130 app_user
	---TRANSACTION 1951723424, not started
	MySQL thread id 3015224, OS thread handle 0x7fb927b72700, query id 6879094757 10.169.200.130 app_user
	---TRANSACTION 1951723427, not started
	MySQL thread id 3015226, OS thread handle 0x7fb91ec15700, query id 6879095638 10.169.200.130 app_user
	---TRANSACTION 1951723407, not started
	MySQL thread id 3015223, OS thread handle 0x7fb926acb700, query id 6879092375 10.169.200.130 app_user
	---TRANSACTION 1951723442, not started
	MySQL thread id 3015222, OS thread handle 0x7fb91ef25700, query id 6879106931 10.169.200.130 app_user
	---TRANSACTION 1951723382, not started
	MySQL thread id 3015219, OS thread handle 0x7fb927c67700, query id 6879090736 10.169.200.130 app_user
	---TRANSACTION 1951729858, not started
	MySQL thread id 3015221, OS thread handle 0x7fb925f1e700, query id 6881082521 10.169.200.130 app_user
	---TRANSACTION 1951723436, not started
	MySQL thread id 3015218, OS thread handle 0x7fb926974700, query id 6879102740 10.169.200.130 app_user
	---TRANSACTION 1951728411, not started
	MySQL thread id 3015220, OS thread handle 0x7fb9271af700, query id 6880611862 10.169.200.130 app_user
	---TRANSACTION 1951730213, not started
	MySQL thread id 3015177, OS thread handle 0x7fb925d03700, query id 6881159329 10.29.64.46 app_user
	---TRANSACTION 1951730221, not started
	MySQL thread id 3015182, OS thread handle 0x7fb9262c1700, query id 6881166401 10.29.64.46 app_user
	---TRANSACTION 1951730060, not started
	MySQL thread id 3015217, OS thread handle 0x7fb925681700, query id 6881123848 10.169.231.171 app_user
	---TRANSACTION 1951723671, not started
	MySQL thread id 3015216, OS thread handle 0x7fb925e29700, query id 6879176553 10.169.231.171 app_user
	---TRANSACTION 1951722658, not started
	MySQL thread id 3015207, OS thread handle 0x7fb9270ba700, query id 6878894697 10.169.231.171 app_user
	---TRANSACTION 1951722660, not started
	MySQL thread id 3015215, OS thread handle 0x7fb91ed6c700, query id 6878894833 10.169.231.171 app_user
	---TRANSACTION 1951730164, not started
	MySQL thread id 3015211, OS thread handle 0x7fb927957700, query id 6881140555 10.169.231.171 app_user
	---TRANSACTION 1951722632, not started
	MySQL thread id 3015213, OS thread handle 0x7fb934108700, query id 6878890122 10.169.231.171 app_user
	---TRANSACTION 1951722541, not started
	MySQL thread id 3015214, OS thread handle 0x7fb9278c4700, query id 6878872198 10.169.231.171 app_user
	---TRANSACTION 1951729359, not started
	MySQL thread id 3015210, OS thread handle 0x7fb926c53700, query id 6880932608 10.169.231.171 app_user
	---TRANSACTION 1951730083, not started
	MySQL thread id 3015212, OS thread handle 0x7fb925ca1700, query id 6881128793 10.169.231.171 app_user
	---TRANSACTION 1951729980, not started
	MySQL thread id 3015208, OS thread handle 0x7fb92742c700, query id 6881111884 10.169.231.171 app_user
	---TRANSACTION 1951722809, not started
	MySQL thread id 3015209, OS thread handle 0x7fb927211700, query id 6878929793 10.169.231.171 app_user
	---TRANSACTION 1951722770, not started
	MySQL thread id 3015206, OS thread handle 0x7fb9257d8700, query id 6878916900 10.169.231.171 app_user
	---TRANSACTION 1951730140, not started
	MySQL thread id 3015203, OS thread handle 0x7fb91eabe700, query id 6881139863 10.169.231.171 app_user
	---TRANSACTION 1951722615, not started
	MySQL thread id 3015204, OS thread handle 0x7fb9258cd700, query id 6878887435 10.169.231.171 app_user
	---TRANSACTION 1951729309, not started
	MySQL thread id 3015205, OS thread handle 0x7fb93c2df700, query id 6880923727 10.169.231.171 app_user
	---TRANSACTION 1951727281, not started
	MySQL thread id 3015202, OS thread handle 0x7fb92773c700, query id 6880330775 10.169.231.171 app_user
	---TRANSACTION 1951727663, not started
	MySQL thread id 3015200, OS thread handle 0x7fb926afc700, query id 6880411308 10.169.231.171 app_user
	---TRANSACTION 1951729571, not started
	MySQL thread id 3015201, OS thread handle 0x7fb91f0de700, query id 6880988521 10.169.231.171 app_user
	---TRANSACTION 1951730265, not started
	MySQL thread id 3015175, OS thread handle 0x7fb925466700, query id 6881185697 10.29.64.46 app_user
	---TRANSACTION 1951730223, not started
	MySQL thread id 3015184, OS thread handle 0x7fb91ea8d700, query id 6881166457 10.29.64.46 app_user
	---TRANSACTION 1951730222, not started
	MySQL thread id 3015183, OS thread handle 0x7fb927cfa700, query id 6881166484 10.29.64.46 app_user
	---TRANSACTION 1951730111, not started
	MySQL thread id 3015181, OS thread handle 0x7fb926e9f700, query id 6881166454 10.29.64.46 app_user
	---TRANSACTION 1951728692, not started
	MySQL thread id 3015198, OS thread handle 0x7fb926f94700, query id 6880731162 10.29.253.186 app_user
	---TRANSACTION 1951726335, not started
	MySQL thread id 3015197, OS thread handle 0x7fb925dc7700, query id 6879999208 10.29.253.186 app_user
	---TRANSACTION 1951730230, not started
	MySQL thread id 3015196, OS thread handle 0x7fb9340d7700, query id 6881167020 10.29.253.186 app_user
	---TRANSACTION 1951727832, not started
	MySQL thread id 3015195, OS thread handle 0x7fb92616a700, query id 6880440875 10.29.253.186 app_user
	---TRANSACTION 1951730257, not started
	MySQL thread id 3015194, OS thread handle 0x7fb926c84700, query id 6881182148 10.29.253.186 app_user
	---TRANSACTION 1951728698, not started
	MySQL thread id 3015193, OS thread handle 0x7fb927242700, query id 6880732848 10.29.253.186 app_user
	---TRANSACTION 1951729396, not started
	MySQL thread id 3015192, OS thread handle 0x7fb91eb82700, query id 6880945987 10.29.250.218 app_user
	---TRANSACTION 1951730182, not started
	MySQL thread id 3015191, OS thread handle 0x7fb925a24700, query id 6881149258 10.29.250.218 app_user
	---TRANSACTION 1951728933, not started
	MySQL thread id 3015190, OS thread handle 0x7fb926d17700, query id 6880806869 10.29.250.218 app_user
	---TRANSACTION 1951724837, not started
	MySQL thread id 3015189, OS thread handle 0x7fb9340a6700, query id 6879471840 10.29.250.218 app_user
	---TRANSACTION 1951730216, not started
	MySQL thread id 3015180, OS thread handle 0x7fb927831700, query id 6881159489 10.29.64.46 app_user
	---TRANSACTION 1951730215, not started
	MySQL thread id 3015179, OS thread handle 0x7fb91ebb3700, query id 6881159451 10.29.64.46 app_user
	---TRANSACTION 1951730214, not started
	MySQL thread id 3015178, OS thread handle 0x7fb92647a700, query id 6881159331 10.29.64.46 app_user
	---TRANSACTION 1951730212, not started
	MySQL thread id 3015176, OS thread handle 0x7fb925bdd700, query id 6881159272 10.29.64.46 app_user
	---TRANSACTION 1951729700, not started
	MySQL thread id 2520611, OS thread handle 0x7fb926759700, query id 6881021702 10.30.210.129 app_user
	---TRANSACTION 1951728991, not started
	MySQL thread id 2520605, OS thread handle 0x7fb92711c700, query id 6880815986 10.30.210.129 app_user
	---TRANSACTION 1951728985, not started
	MySQL thread id 2520601, OS thread handle 0x7fb934075700, query id 6880815610 10.30.210.129 app_user
	---TRANSACTION 1951727698, not started
	MySQL thread id 2520604, OS thread handle 0x7fb92555b700, query id 6880413338 10.30.210.129 app_user
	---TRANSACTION 1951728992, not started
	MySQL thread id 2520603, OS thread handle 0x7fb927893700, query id 6880816128 10.30.210.129 app_user
	---TRANSACTION 1951382501, not started
	MySQL thread id 2520606, OS thread handle 0x7fb925eed700, query id 6829558115 10.30.210.129 app_user
	---TRANSACTION 1951365956, not started
	MySQL thread id 2520610, OS thread handle 0x7fb91ef56700, query id 6829506599 10.30.210.129 app_user
	---TRANSACTION 1951363694, not started
	MySQL thread id 2520609, OS thread handle 0x7fb926075700, query id 6829499786 10.30.210.129 app_user
	---TRANSACTION 1951397634, not started
	MySQL thread id 2520608, OS thread handle 0x7fb925cd2700, query id 6829605340 10.30.210.129 app_user
	---TRANSACTION 1951729698, not started
	MySQL thread id 2520614, OS thread handle 0x7fb925ae8700, query id 6881021555 10.30.210.129 app_user
	---TRANSACTION 1951729691, not started
	MySQL thread id 2520615, OS thread handle 0x7fb925b7b700, query id 6881021293 10.30.210.129 app_user
	---TRANSACTION 1951729694, not started
	MySQL thread id 2520613, OS thread handle 0x7fb925df8700, query id 6881021429 10.30.210.129 app_user
	---TRANSACTION 1951729710, not started
	MySQL thread id 2520612, OS thread handle 0x7fb926bc0700, query id 6881022726 10.30.210.129 app_user
	---TRANSACTION 1951395931, not started
	MySQL thread id 2520607, OS thread handle 0x7fb92558c700, query id 6829600085 10.30.210.129 app_user
	---TRANSACTION 1951728988, not started
	MySQL thread id 2520602, OS thread handle 0x7fb926b8f700, query id 6880815863 10.30.210.129 app_user
	---TRANSACTION 1951556378, ACTIVE 1083 sec inserting, thread declared inside InnoDB 5000
	mysql tables in use 1, locked 1
	1 lock struct(s), heap size 360, 0 row lock(s), undo log entries 4211218
	MySQL thread id 3018247, OS thread handle 0x7fb927800700, query id 6881189514 10.27.179.56 web_user update
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
	--------
	FILE I/O
	--------
	I/O thread 0 state: waiting for completed aio requests (insert buffer thread)
	I/O thread 1 state: waiting for completed aio requests (log thread)
	I/O thread 2 state: waiting for completed aio requests (read thread)
	I/O thread 3 state: waiting for completed aio requests (read thread)
	I/O thread 4 state: waiting for completed aio requests (read thread)
	I/O thread 5 state: waiting for completed aio requests (read thread)
	I/O thread 6 state: waiting for completed aio requests (read thread)
	I/O thread 7 state: waiting for completed aio requests (read thread)
	I/O thread 8 state: waiting for completed aio requests (read thread)
	I/O thread 9 state: waiting for completed aio requests (read thread)
	I/O thread 10 state: waiting for completed aio requests (read thread)
	I/O thread 11 state: waiting for completed aio requests (read thread)
	I/O thread 12 state: waiting for completed aio requests (read thread)
	I/O thread 13 state: waiting for completed aio requests (read thread)
	I/O thread 14 state: waiting for completed aio requests (read thread)
	I/O thread 15 state: waiting for completed aio requests (read thread)
	I/O thread 16 state: waiting for completed aio requests (read thread)
	I/O thread 17 state: waiting for completed aio requests (read thread)
	I/O thread 18 state: waiting for completed aio requests (write thread)
	I/O thread 19 state: waiting for completed aio requests (write thread)
	I/O thread 20 state: waiting for completed aio requests (write thread)
	I/O thread 21 state: waiting for completed aio requests (write thread)
	I/O thread 22 state: waiting for completed aio requests (write thread)
	I/O thread 23 state: waiting for completed aio requests (write thread)
	I/O thread 24 state: waiting for completed aio requests (write thread)
	I/O thread 25 state: waiting for completed aio requests (write thread)
	I/O thread 26 state: waiting for completed aio requests (write thread)
	I/O thread 27 state: waiting for completed aio requests (write thread)
	I/O thread 28 state: waiting for completed aio requests (write thread)
	I/O thread 29 state: waiting for completed aio requests (write thread)
	I/O thread 30 state: waiting for completed aio requests (write thread)
	I/O thread 31 state: waiting for completed aio requests (write thread)
	I/O thread 32 state: waiting for completed aio requests (write thread)
	I/O thread 33 state: waiting for completed aio requests (write thread)
	I/O thread 34 state: waiting for completed aio requests (write thread)
	I/O thread 35 state: waiting for completed aio requests (write thread)
	I/O thread 36 state: waiting for completed aio requests (write thread)
	I/O thread 37 state: waiting for completed aio requests (write thread)
	I/O thread 38 state: complete io for buf page (write thread)
	I/O thread 39 state: waiting for completed aio requests (write thread)
	I/O thread 40 state: waiting for completed aio requests (write thread)
	I/O thread 41 state: waiting for completed aio requests (write thread)
	I/O thread 42 state: waiting for completed aio requests (write thread)
	I/O thread 43 state: waiting for completed aio requests (write thread)
	I/O thread 44 state: waiting for completed aio requests (write thread)
	I/O thread 45 state: waiting for completed aio requests (write thread)
	I/O thread 46 state: waiting for completed aio requests (write thread)
	I/O thread 47 state: waiting for completed aio requests (write thread)
	I/O thread 48 state: waiting for completed aio requests (write thread)
	I/O thread 49 state: waiting for completed aio requests (write thread)
	Pending normal aio reads: 0 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] , aio writes: 0 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] ,
	 ibuf aio reads: 0, log i/o's: 0, sync i/o's: 0
	Pending flushes (fsync) log: 1; buffer pool: 1
	214318 OS file reads, 2057922426 OS file writes, 1334053448 OS fsyncs
	0.00 reads/s, 0 avg bytes/read, 94.21 writes/s, 61.65 fsyncs/s
	-------------------------------------
	INSERT BUFFER AND ADAPTIVE HASH INDEX
	-------------------------------------
	Ibuf: size 1, free list len 458, seg size 460, 4416 merges
	merged operations:
	 insert 29841, delete mark 1802, delete 195
	discarded operations:
	 insert 0, delete mark 0, delete 0
	Hash table size 50999279, node heap has 7731 buffer(s)
	11767.66 hash searches/s, 307.73 non-hash searches/s
	---
	LOG
	---
	Log sequence number 639802539982
	Log flushed up to   639802532043
	Pages flushed up to 639723435303
	Last checkpoint at  639722455059
	1 pending log writes, 0 pending chkp writes
	446234363 log i/o's done, 43.83 log i/o's/second
	----------------------
	BUFFER POOL AND MEMORY
	----------------------
	Total memory allocated 26373783552; in additional pool allocated 0
	Dictionary memory allocated 2313184
	Buffer pool size   1572856
	Free buffers       8193
	Database pages     1556932
	Old database pages 574562
	Modified db pages  5293
	Pending reads 0
	Pending writes: LRU 0, flush list 2, single page 0
	Pages made young 1537320, not young 19462629
	19.35 youngs/s, 0.00 non-youngs/s
	Pages read 190155, created 3692638, written 1197042170
	0.00 reads/s, 1.04 creates/s, 44.52 writes/s
	Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
	Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
	LRU len: 1556932, unzip_LRU len: 0
	I/O sum[16984]:cur[88], unzip sum[0]:cur[0]
	----------------------
	INDIVIDUAL BUFFER POOL INFO
	----------------------
	---BUFFER POOL 0
	Buffer pool size   196607
	Free buffers       1025
	Database pages     194629
	Old database pages 71825
	Modified db pages  708
	Pending reads 0
	Pending writes: LRU 0, flush list 0, single page 0
	Pages made young 217252, not young 2516435
	2.78 youngs/s, 0.00 non-youngs/s
	Pages read 24026, created 461019, written 231469670
	0.00 reads/s, 0.00 creates/s, 8.22 writes/s
	Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
	Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
	LRU len: 194629, unzip_LRU len: 0
	I/O sum[2123]:cur[11], unzip sum[0]:cur[0]
	---BUFFER POOL 1
	Buffer pool size   196607
	Free buffers       1024
	Database pages     194615
	Old database pages 71820
	Modified db pages  637
	Pending reads 0
	Pending writes: LRU 0, flush list 0, single page 0
	Pages made young 213917, not young 2461805
	3.00 youngs/s, 0.00 non-youngs/s
	Pages read 24231, created 460673, written 74381554
	0.00 reads/s, 0.17 creates/s, 4.39 writes/s
	Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
	Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
	LRU len: 194615, unzip_LRU len: 0
	I/O sum[2123]:cur[11], unzip sum[0]:cur[0]
	---BUFFER POOL 2
	Buffer pool size   196607
	Free buffers       1024
	Database pages     194619
	Old database pages 71821
	Modified db pages  609
	Pending reads 0
	Pending writes: LRU 0, flush list 0, single page 0
	Pages made young 223030, not young 2372862
	5.30 youngs/s, 0.00 non-youngs/s
	Pages read 23620, created 461525, written 115552818
	0.00 reads/s, 0.17 creates/s, 5.74 writes/s
	Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
	Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
	LRU len: 194619, unzip_LRU len: 0
	I/O sum[2123]:cur[11], unzip sum[0]:cur[0]
	---BUFFER POOL 3
	Buffer pool size   196607
	Free buffers       1024
	Database pages     194614
	Old database pages 71819
	Modified db pages  619
	Pending reads 0
	Pending writes: LRU 0, flush list 0, single page 0
	Pages made young 220049, not young 2538696
	2.78 youngs/s, 0.00 non-youngs/s
	Pages read 23711, created 462047, written 135060920
	0.00 reads/s, 0.17 creates/s, 4.70 writes/s
	Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
	Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
	LRU len: 194614, unzip_LRU len: 0
	I/O sum[2123]:cur[11], unzip sum[0]:cur[0]
	---BUFFER POOL 4
	Buffer pool size   196607
	Free buffers       1024
	Database pages     194626
	Old database pages 71824
	Modified db pages  592
	Pending reads 0
	Pending writes: LRU 0, flush list 0, single page 0
	Pages made young 222222, not young 2047950
	0.22 youngs/s, 0.00 non-youngs/s
	Pages read 22839, created 461575, written 132989063
	0.00 reads/s, 0.17 creates/s, 7.04 writes/s
	Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
	Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
	LRU len: 194626, unzip_LRU len: 0
	I/O sum[2123]:cur[11], unzip sum[0]:cur[0]
	---BUFFER POOL 5
	Buffer pool size   196607
	Free buffers       1024
	Database pages     194633
	Old database pages 71826
	Modified db pages  639
	Pending reads 0
	Pending writes: LRU 0, flush list 2, single page 0
	Pages made young 114011, not young 2706170
	0.00 youngs/s, 0.00 non-youngs/s
	Pages read 24100, created 460704, written 141451029
	0.00 reads/s, 0.17 creates/s, 3.74 writes/s
	Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
	Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
	LRU len: 194633, unzip_LRU len: 0
	I/O sum[2123]:cur[11], unzip sum[0]:cur[0]
	---BUFFER POOL 6
	Buffer pool size   196607
	Free buffers       1024
	Database pages     194614
	Old database pages 71819
	Modified db pages  613
	Pending reads 0
	Pending writes: LRU 0, flush list 0, single page 0
	Pages made young 111163, not young 2969512
	0.00 youngs/s, 0.00 non-youngs/s
	Pages read 24153, created 463507, written 120638283
	0.00 reads/s, 0.17 creates/s, 2.96 writes/s
	Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
	Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
	LRU len: 194614, unzip_LRU len: 0
	I/O sum[2123]:cur[11], unzip sum[0]:cur[0]
	---BUFFER POOL 7
	Buffer pool size   196607
	Free buffers       1024
	Database pages     194582
	Old database pages 71808
	Modified db pages  876
	Pending reads 0
	Pending writes: LRU 0, flush list 0, single page 0
	Pages made young 215676, not young 1849199
	5.26 youngs/s, 0.00 non-youngs/s
	Pages read 23475, created 461588, written 245498833
	0.00 reads/s, 0.00 creates/s, 7.74 writes/s
	Buffer pool hit rate 1000 / 1000, young-making rate 0 / 1000 not 0 / 1000
	Pages read ahead 0.00/s, evicted without access 0.00/s, Random read ahead 0.00/s
	LRU len: 194582, unzip_LRU len: 0
	I/O sum[2123]:cur[11], unzip sum[0]:cur[0]
	--------------
	ROW OPERATIONS
	--------------
	0 queries inside InnoDB, 0 queries in queue
	0 read views open inside InnoDB
	Main thread process no. 3912, id 140433580902144, state: sleeping
	Number of rows inserted 589954125, updated 192281392, deleted 410192648, read 3376840924188
	3840.70 inserts/s, 16.52 updates/s, 0.00 deletes/s, 58788.97 reads/s
	----------------------------
	END OF INNODB MONITOR OUTPUT
	============================

	1 row in set (0.04 sec)

	ERROR: 
	No query specified



4. 小结
	
	1. show processlist
	2. SELECT * FROM INFORMATION_SCHEMA.INNODB_TRX
	3. show engine innodb status
	这3项都可以加入 巡检脚本 中。
	
	
	
	
