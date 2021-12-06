


--user         用户
--password     密码
--port     	   端口
--host         主机
--socket       本地套接字


--match-command     			匹配状态
--match-info     				匹配信息
--match-state     				匹配声明
--ignore-host/--match-host      匹配主机
--ignore-db/--match-db     		匹配数据库
--ignore-user/--match-user      匹配用户


--kill        杀掉连接并且退出
--kill-query  只杀掉连接执行的语句，但是线程不会被终止
--print       打印满足条件的语句



--busy-time    SQL 运行时间的线程    
--idle-time    sleep 时间的连接线程，必须在 --match-command sleep 时才有效
--victim       针对范围：oldest | all | all-but-oldest 
--daemonize    是否放到后台执行
--interval     执行频率(s=seconds, m=minutes, h=hours, d=days)
--log-dsn      D=yzw, t=pk_log  记录信息到表中






