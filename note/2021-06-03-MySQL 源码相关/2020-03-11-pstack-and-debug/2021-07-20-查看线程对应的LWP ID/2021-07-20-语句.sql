select a.thd_id,b.THREAD_OS_ID,a.user,b.TYPE from  sys.processlist a,performance_schema.threads  b where b.thread_id=a.thd_id;
	01
show PROCESSLIST;
	02
select * from sys.processlist;
	03
pstack $(pgrep -xn mysqld) > 1.sql