

相关参考：
	https://mp.weixin.qq.com/s/scAX0c0Jps_VSgkJzhGAfQ     MySQL 8 新特性之持久化全局变量的修改 
	https://mp.weixin.qq.com/s/apep8Pp6YcVKah3x-IElCA     新特性解读 | MySQL 8.0 轻松改配置，云上友好
	
	
MySQL8.0可以使用SET PERSIST动态修改参数并保存在配置文件中（mysqld-auto.cnf，保存的格式为JSON串），这个是DBA同学的福音，不必担心设置之后忘记保存在配置文件中，重启之后会被还原的问题了。


在MySQL 8.0之前的版本中，对于全局变量的修改，其只会影响其内存值，而不会持久化到配置文件中。
数据库重启，又会恢复成修改前的值。从8.0开始，可通过SET PERSIST命令将全局变量的修改持久化到配置文件中。


1. 实验：
	root@mysqldb 01:02:  [(none)]> show variables like '%max_connections%';
	+------------------------+-------+
	| Variable_name          | Value |
	+------------------------+-------+
	| max_connections        | 512   |
	| mysqlx_max_connections | 100   |
	+------------------------+-------+
	2 rows in set (0.01 sec)


	root@mysqldb 01:02:  [(none)]> set persist max_connections=1024;
	Query OK, 0 rows affected (0.00 sec)


	root@mysqldb 01:02:  [(none)]> show variables like '%max_connections%';
	+------------------------+-------+
	| Variable_name          | Value |
	+------------------------+-------+
	| max_connections        | 1024  |
	| mysqlx_max_connections | 100   |
	+------------------------+-------+
	2 rows in set (0.00 sec)

2. 全局变量的修改会保存在两处：

	1. 数据目录下mysqld-auto.cnf文件。

		注意，不是启动时--defaults-file指定的配置文件。

		[root@kp05 data]# pwd
		/data/mysql/mysql3306/data

		[root@kp05 data]# ls  mysqld-auto.cnf
		mysqld-auto.cnf

		[root@kp05 data]# cat mysqld-auto.cnf 
		{ "Version" : 1 , "mysql_server" : { "max_connections" : { "Value" : "1024" , "Metadata" : { "Timestamp" : 1574442161578876 , "User" : "root" , "Host" : "localhost" } } } }

		持久化信息以json格式保存，其中，Metadata记录了这次修改的用户及时间信息。

		在数据库启动时，会首先读取其它配置文件，最后才读取mysqld-auto.cnf文件。

		不建议手动修改该文件，其有可能导致数据库在启动过程中因解析错误而失败。如果出现这种情况，可手动删除 mysqld-auto.cnf 文件或将 persisted_globals_load 变量设置为off来避免该文件的加载。



	2. performance_schema.persisted_variables表
	root@mysqldb 01:02:  [(none)]> select * from performance_schema.persisted_variables;
	+-----------------+----------------+
	| VARIABLE_NAME   | VARIABLE_VALUE |
	+-----------------+----------------+
	| max_connections | 1024           |
	+-----------------+----------------+
	1 row in set (0.00 sec)

	
3. 持久化操作的两种形式

	全局变量的持久化除了 SET PERSIST 外，还可以使用SET PERSIST_ONLY，与前者相比，其只持久化全局变量，而不修改其内存值。

	同时，在权限方面，前者只需要 SYSTEM_VARIABLES_ADMIN，后者还需要 PERSIST_RO_VARIABLES_ADMIN权限（注：在MySQL 8.0中，引入了更多细粒度的权限来替代super权限）

4. 清除持久化变量

	对于已经持久化了变量，可通过RESET PERSIST命令清除掉
	注意，其只是清空mysqld-auto.cnf和performance_schema. persisted_variables中的内容，对于已经修改了的变量的值，不会产生任何影响。
	
	root@mysqldb 01:06:  [(none)]> RESET PERSIST;
	Query OK, 0 rows affected (0.00 sec)

	[root@kp05 data]# cat mysqld-auto.cnf 
	{ "Version" : 1 , "mysql_server" : {  } }

	root@mysqldb 01:08:  [(none)]> select * from performance_schema.persisted_variables;
	Empty set (0.00 sec)
