


	

#创建测试表
drop table if exists test_flush_log;
create table test_flush_log(id int,name char(50))engine=innodb;

#创建插入指定行数的记录到测试表中的存储过程
drop procedure if exists proc;
delimiter $$
create procedure proc(i int)
begin
    declare s int default 1;
    declare c char(50) default repeat('a',50);
    while s<=i do
        start transaction;
        insert into test_flush_log values(null,c);
        commit;
        set s=s+1;
    end while;
end$$
delimiter ;


innodb_flush_log_at_trx_commit = 1:

	mysql> show global variables like 'innodb_flush_log_at_trx_commit';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| innodb_flush_log_at_trx_commit | 1     |
	+--------------------------------+-------+
	1 row in set (0.01 sec)


	mysql> call proc(100000);
	Query OK, 0 rows affected (4 min 55.36 sec)


innodb_flush_log_at_trx_commit = 0:

	mysql> truncate table test_flush_log;
	Query OK, 0 rows affected (0.04 sec)

	mysql> set global innodb_flush_log_at_trx_commit = 0;
	Query OK, 0 rows affected (0.00 sec)

	mysql> show global variables like 'innodb_flush_log_at_trx_commit';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| innodb_flush_log_at_trx_commit | 0     |
	+--------------------------------+-------+
	1 row in set (0.00 sec)

	mysql> call proc(100000);
	Query OK, 0 rows affected (2 min 30.93 sec)


innodb_flush_log_at_trx_commit = 2:
	
	mysql> truncate table test_flush_log;
	Query OK, 0 rows affected (0.03 sec)

	mysql> set global innodb_flush_log_at_trx_commit = 2;
	Query OK, 0 rows affected (0.00 sec)

	mysql> show global variables like 'innodb_flush_log_at_trx_commit';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| innodb_flush_log_at_trx_commit | 2     |
	+--------------------------------+-------+
	1 row in set (0.00 sec)

	
	mysql> call proc(100000);
	Query OK, 0 rows affected (2 min 34.36 sec)

	
更好的插入数据的做法是将值设置为1，然后修改存储过程，将每次循环都提交修改为只提交一次，这样既能保证数据的一致性，也能提升性能，修改如下：

#创建插入指定行数的记录到测试表中的存储过程
	drop procedure if exists proc;
	delimiter $$
	create procedure proc(i int)
	begin
		declare s int default 1;
		declare c char(50) default repeat('a',50);
		start transaction;
		while s<=i DO
			insert into test_flush_log values(null,c);
			set s=s+1;
		end while;
		commit;
	end$$
	delimiter ;


innodb_flush_log_at_trx_commit = 1:

	mysql> set global innodb_flush_log_at_trx_commit = 1;
	mysql> show global variables like 'innodb_flush_log_at_trx_commit';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| innodb_flush_log_at_trx_commit | 1     |
	+--------------------------------+-------+
	1 row in set (0.01 sec)

	mysql> call proc(100000);
	Query OK, 0 rows affected (2.24 sec)


innodb_flush_log_at_trx_commit = 0:

	mysql> truncate table test_flush_log;
	Query OK, 0 rows affected (0.04 sec)

	mysql> set global innodb_flush_log_at_trx_commit = 0;
	Query OK, 0 rows affected (0.00 sec)

	mysql> show global variables like 'innodb_flush_log_at_trx_commit';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| innodb_flush_log_at_trx_commit | 0     |
	+--------------------------------+-------+
	1 row in set (0.00 sec)

	mysql> call proc(100000);
	Query OK, 0 rows affected (2.31 sec)


innodb_flush_log_at_trx_commit = 2:
	
	mysql> truncate table test_flush_log;
	Query OK, 0 rows affected (0.03 sec)

	mysql> set global innodb_flush_log_at_trx_commit = 2;
	Query OK, 0 rows affected (0.00 sec)

	mysql> show global variables like 'innodb_flush_log_at_trx_commit';
	+--------------------------------+-------+
	| Variable_name                  | Value |
	+--------------------------------+-------+
	| innodb_flush_log_at_trx_commit | 2     |
	+--------------------------------+-------+
	1 row in set (0.00 sec)
	
	mysql> call proc(100000);
	Query OK, 0 rows affected (2.30 sec)

	