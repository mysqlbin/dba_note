




https://www.cnblogs.com/wdrain/p/11527455.html  mysql5.7 忘记root密码处理


[root@mgr9 tmp]# vim /etc/my.cnf
[mysqld]
skip-grant-tables

[root@mgr9 tmp]# /etc/init.d/mysql restart
Shutting down MySQL.. SUCCESS! 
Starting MySQL... SUCCESS! 
[root@mgr9 tmp]# mysql

root@mysqldb 02:28:  [(none)]> alter user 'root'@'localhost' identified by '123456abc';
ERROR 1290 (HY000): The MySQL server is running with the --skip-grant-tables option so it cannot execute this statement


root@mysqldb 02:31:  [(none)]> use mysql;
Database changed
root@mysqldb 02:31:  [mysql]> update user set authentication_string=password('123456abc') where user='root' and host='localhost';
Query OK, 0 rows affected, 1 warning (0.01 sec)
Rows matched: 0  Changed: 0  Warnings: 1

再次修改my.cnf配置文件，将第一步添加的语句注释或删除,然后重启mysql。

[root@mgr9 tmp]# /etc/init.d/mysql restart
Shutting down MySQL.. SUCCESS! 
Starting MySQL... SUCCESS! 
[root@mgr9 tmp]# 

用新密码登录mysql, 并且再次修改密码
	mysql -uroot -p123456abc
	root@mysqldb 02:37:  [(none)]> alter user 'root'@'localhost' identified by '123456abc';
	Query OK, 0 rows affected (0.01 sec)
