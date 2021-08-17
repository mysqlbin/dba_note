

我的分析和形成死锁的事务次序
	session A        					session B 
	begin;(TRANSACTION 4656447873)		begin;(TRANSACTION 4656447881)


	UPDATE T_EXER_RANGE SET DELAY_FINISH_NUM = DELAY_FINISH_NUM + 1,totaltime = ifnull(totaltime,0) + 5,AVERAGETIME=FLOOR(totaltime/(FINISH_NUM+DELAY_FINISH_NUM)) WHERE ID = 581131110763728896
					
										UPDATE T_EXER SET DELAY_REVISE_NUM = DELAY_REVISE_NUM + 1 WHERE ID = 581131110700814337;

	UPDATE T_EXER SET DELAY_REVISE_NUM = DELAY_REVISE_NUM + 1 WHERE ID = 581131110700814337;
	(Blocked)
										UPDATE T_EXER_RANGE SET DELAY_FINISH_NUM = DELAY_FINISH_NUM + 1,totaltime = ifnull(totaltime,0) + 5,AVERAGETIME=FLOOR(totaltime/(FINISH_NUM+DELAY_FINISH_NUM)) WHERE ID = 581131110763728896
										
										(Blocked)
										(触发死锁检测，回滚代价最小的事务)
										
									




杭州-dba拓荒牛(120114793) 2021/3/23 16:58:26
破案了：代码里面这两个update在不同的应用里面都有，不过顺序不一样，改成一样就行了
-- 跟我分析的一样。
