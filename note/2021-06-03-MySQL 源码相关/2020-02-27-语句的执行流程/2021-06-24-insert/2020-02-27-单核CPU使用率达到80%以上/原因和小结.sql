
1. 原因	
2. 解决办法
3. 小结

1. 原因		
	select Grade INTO _Grade from EnterPrise where  EnterPriseID=_PID;
	
	START TRANSACTION;
		IF _Grade<>1 THEN 
			
			WHILE _Grade<>1 DO
				IF _ch=0 THEN								    
						set _EnterPriseIDDJ=_EnterPriseID;
						
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
						   ,'0'
						   ,(($totalFree*_MMSPrice)/100)
						   ,0
						   ,1
						   ,1
		
	当 	_Grade 不存在的时候 ，会一直做循环 INSERT INTO Table_AgentWithdrawalRecord 动作，
	show engine innodb status 的重点信息如下：
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
		可以看到， 个别事务里生成的 undo 非常非常多（undo log entries 4211218，一个事务里400多W多undo）
	
	
	一直做插入动作，说明事务处于正在执行状态阶段，此时数据已经写入到内存中，但是没有刷盘，所以会把内存撑爆，导致OOM。 参考笔记 《2018-11-19-友趣主库OOM和修改密码》 
	
2. 解决办法
		
	select Grade INTO _Grade from EnterPrise where  EnterPriseID=_PID;
	if exists(select Grade from EnterPrise where  EnterPriseID=_PID) then 
			select Grade INTO _Grade from EnterPrise where  EnterPriseID=_PID;
	else 
			set _Grade=1;
	end if;
	
	START TRANSACTION;
		IF _Grade<>1 THEN 
		
		
		
3. 小结
	监控长事务
	死循环或者长事务会导致CPU偏高，一般单核CPU利用率达到80%就报警。
	
	