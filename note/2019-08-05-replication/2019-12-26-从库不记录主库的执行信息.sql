

master:
	mysql> select * from test_db.t;
	+----+------+------+
	| id | c    | d    |
	+----+------+------+
	|  4 |    4 |    4 |
	|  5 |    5 |    5 |
	|  6 |    6 |    6 |
	|  7 |    7 |    7 |
	|  8 |    8 |    8 |
	|  9 |    9 |    9 |
	| 10 |   10 |   10 |
	+----+------+------+
	7 rows in set (0.00 sec)

	delete from t where id=4;
	delete from t where id=5;
	
slave的general_log
	
	2020-09-28T20:23:10.968248Z	   11 Query	BEGIN
	2020-09-28T20:23:10.968345Z	   11 Query	COMMIT /* implicit, from Xid_log_event */
	2020-09-28T20:23:14.099114Z	   11 Query	BEGIN
	2020-09-28T20:23:14.099364Z	   11 Query	COMMIT /* implicit, from Xid_log_event */


从机的general_log是不记录主机上执行的事务信息的，只是以 begin;commit; 的方式显示

