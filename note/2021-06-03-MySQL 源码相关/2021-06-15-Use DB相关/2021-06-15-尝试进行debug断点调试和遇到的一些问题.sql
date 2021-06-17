

[root@localhost mysql]# ps aux|grep mysql
mysql    31859  104 19.0 1159296 193140 pts/3  Rl   20:47   0:02 /home/mysql/bin/mysqld --defaults-file=/etc/my.cnf
root     31881  0.0  0.0 112828   976 pts/3    R+   20:47   0:00 grep --color=auto mysql



[root@localhost mysql]# mysql -uroot -p123456abc
mysql: [Warning] Using a password on the command line interface can be insecure.
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 3
Server version: 5.7.26-debug-log Source distribution

Copyright (c) 2000, 2019, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

(gdb) b my_net_read
Breakpoint 2 at 0x143d198: file /usr/local/mysql/sql/net_serv.cc, line 896.


1. Function "" not defined
2. Breakpoint
3. 为什么打断点会失败


1. Function "" not defined

	b completion_hash.cc::add_word
	b build_completion_hash
	b /usr/local/mysql/client/mysql.cc:4748


	(gdb) b completion_hash.cc::add_word
	Function "completion_hash.cc::add_word" not defined.
	Make breakpoint pending on future shared library load? (y or [n]) y
	Breakpoint 3 (completion_hash.cc::add_word) pending.


	(gdb) b build_completion_hash
	Function "build_completion_hash" not defined.
	-- build_completion_hash 不是1个函数
	(gdb) b /usr/local/mysql/client/mysql.cc:4748
	No source file named /usr/local/mysql/client/mysql.cc.
	Make breakpoint pending on future shared library load? (y or [n]) y
	Breakpoint 2 (/usr/local/mysql/client/mysql.cc:4748) pending.


2. Breakpoint
	b mysql_execute_command
	b my_net_read

	(gdb) b mysql_execute_command
	Breakpoint 4 at 0x15326a5: file /usr/local/mysql/sql/sql_parse.cc, line 2445.
	(gdb) 
	Note: breakpoint 4 also set at pc 0x15326a5.
	Breakpoint 5 at 0x15326a5: file /usr/local/mysql/sql/sql_parse.cc, line 2445.

	(gdb) b my_net_read
	Breakpoint 7 at 0x143d198: file /usr/local/mysql/sql/net_serv.cc, line 896.
	(gdb) info b
	Num     Type           Disp Enb Address            What
	1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
		breakpoint already hit 1 time
	2       breakpoint     keep y   <PENDING>          /usr/local/mysql/client/mysql.cc:4748
	3       breakpoint     keep y   <PENDING>          completion_hash.cc::add_word
	4       breakpoint     keep y   0x00000000015326a5 in mysql_execute_command(THD*, bool) at /usr/local/mysql/sql/sql_parse.cc:2445
	5       breakpoint     keep y   0x00000000015326a5 in mysql_execute_command(THD*, bool) at /usr/local/mysql/sql/sql_parse.cc:2445
	6       breakpoint     keep y   <PENDING>          mysql_select
	7       breakpoint     keep y   0x000000000143d198 in my_net_read(NET*) at /usr/local/mysql/sql/net_serv.cc:896
	(gdb) 



	(gdb) b trace_tmp_table
	Breakpoint 8 at 0x15dc625: file /usr/local/mysql/sql/sql_tmp_table.cc, line 2300.


	(gdb) info b
	Num     Type           Disp Enb Address            What
	1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
		breakpoint already hit 1 time
	2       breakpoint     keep y   <PENDING>          /usr/local/mysql/client/mysql.cc:4748
	3       breakpoint     keep y   <PENDING>          completion_hash.cc::add_word
	4       breakpoint     keep y   0x00000000015326a5 in mysql_execute_command(THD*, bool) at /usr/local/mysql/sql/sql_parse.cc:2445
	5       breakpoint     keep y   0x00000000015326a5 in mysql_execute_command(THD*, bool) at /usr/local/mysql/sql/sql_parse.cc:2445
	6       breakpoint     keep y   <PENDING>          mysql_select
	7       breakpoint     keep y   0x000000000143d198 in my_net_read(NET*) at /usr/local/mysql/sql/net_serv.cc:896
	8       breakpoint     keep y   0x00000000015dc625 in trace_tmp_table(Opt_trace_context*, TABLE const*) at /usr/local/mysql/sql/sql_tmp_table.cc:2300
	(gdb) 


	
	(gdb) b /usr/local/mysql/sql/sql_tmp_table.cc:2300
	Note: breakpoint 8 also set at pc 0x15dc625.
	Breakpoint 9 at 0x15dc625: file /usr/local/mysql/sql/sql_tmp_table.cc, line 2300.
	(gdb) clear 8
	No breakpoint at 8.
	(gdb) delete 8
	(gdb) info b
	Num     Type           Disp Enb Address            What
	1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
		breakpoint already hit 1 time
	2       breakpoint     keep y   <PENDING>          /usr/local/mysql/client/mysql.cc:4748
	3       breakpoint     keep y   <PENDING>          completion_hash.cc::add_word
	4       breakpoint     keep y   0x00000000015326a5 in mysql_execute_command(THD*, bool) at /usr/local/mysql/sql/sql_parse.cc:2445
	5       breakpoint     keep y   0x00000000015326a5 in mysql_execute_command(THD*, bool) at /usr/local/mysql/sql/sql_parse.cc:2445
	6       breakpoint     keep y   <PENDING>          mysql_select
	7       breakpoint     keep y   0x000000000143d198 in my_net_read(NET*) at /usr/local/mysql/sql/net_serv.cc:896
	9       breakpoint     keep y   0x00000000015dc625 in trace_tmp_table(Opt_trace_context*, TABLE const*) at /usr/local/mysql/sql/sql_tmp_table.cc:2300
	(gdb) delete 9
	(gdb) info b
	Num     Type           Disp Enb Address            What
	1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
		breakpoint already hit 1 time
	2       breakpoint     keep y   <PENDING>          /usr/local/mysql/client/mysql.cc:4748
	3       breakpoint     keep y   <PENDING>          completion_hash.cc::add_word
	4       breakpoint     keep y   0x00000000015326a5 in mysql_execute_command(THD*, bool) at /usr/local/mysql/sql/sql_parse.cc:2445
	5       breakpoint     keep y   0x00000000015326a5 in mysql_execute_command(THD*, bool) at /usr/local/mysql/sql/sql_parse.cc:2445
	6       breakpoint     keep y   <PENDING>          mysql_select
	7       breakpoint     keep y   0x000000000143d198 in my_net_read(NET*) at /usr/local/mysql/sql/net_serv.cc:896



	(gdb) b /usr/local/mysql/sql/sql_tmp_table.cc:2300
	Breakpoint 10 at 0x15dc625: file /usr/local/mysql/sql/sql_tmp_table.cc, line 2300.
	(gdb) info b
	Num     Type           Disp Enb Address            What
	1       breakpoint     keep y   0x0000000000e9a04c in main(int, char**) at /usr/local/mysql/sql/main.cc:25
		breakpoint already hit 1 time
	2       breakpoint     keep y   <PENDING>          /usr/local/mysql/client/mysql.cc:4748
	3       breakpoint     keep y   <PENDING>          completion_hash.cc::add_word
	4       breakpoint     keep y   0x00000000015326a5 in mysql_execute_command(THD*, bool) at /usr/local/mysql/sql/sql_parse.cc:2445
	5       breakpoint     keep y   0x00000000015326a5 in mysql_execute_command(THD*, bool) at /usr/local/mysql/sql/sql_parse.cc:2445
	6       breakpoint     keep y   <PENDING>          mysql_select
	7       breakpoint     keep y   0x000000000143d198 in my_net_read(NET*) at /usr/local/mysql/sql/net_serv.cc:896
	10      breakpoint     keep y   0x00000000015dc625 in trace_tmp_table(Opt_trace_context*, TABLE const*) at /usr/local/mysql/sql/sql_tmp_table.cc:2300


	
	(gdb) b trx_undo_page_report_insert
	Breakpoint 13 at 0x1ac7441: file /usr/local/mysql/storage/innobase/trx/trx0rec.cc, line 478.






	int
	binlog_cache_data::flush(THD *thd, my_off_t *bytes_written, bool *wrote_xid)

------------------------------------------------------------------------------------

3. 为什么打断点会失败

	带着问题去学习c++的函数


	-- 静态函数
	static void trace_tmp_table(Opt_trace_context *trace, const TABLE *table)
	{

	static void 是定义静态无返回值函数。




	-- 静态整型
		/* ARGSUSED */
	static int
	com_use(String *buffer MY_ATTRIBUTE((unused)), char *line)
	{


	static int 是定义静态函数返回值的数据类型是 int 整型。

	------------------------------------------------------------------------------------

	static
	ulint
	trx_undo_page_report_insert()

	static ulint 是定义静态函数返回值的数据类型是 ulint 整型。

	------------------------------------------------------------------------------------

	C++中 ULONGLONG是什么类型
		无符号大整数类型 表示0~2^64-1 (18446744073709551615) 的数


	1、static int ：加上static关键字，这样声明的成员就叫做静态成员，用于定义静态的int型变量。

	2、int：是用于定义整数类型变量的标识符。



	/*****************************************************************//**
	Create an internal cursor instance.
	@return DB_SUCCESS or err code */
	static
	ib_err_t
	ib_create_cursor(
	/*=============*/
		ib_crsr_t*	ib_crsr,	/*!< out: InnoDB cursor */
		dict_table_t*	table,		/*!< in: table instance */
		dict_index_t*	index,		/*!< in: index to use */
		trx_t*		trx)		/*!< in: transaction */
	{



	找到对应的函数然后打断点，才起作用。




