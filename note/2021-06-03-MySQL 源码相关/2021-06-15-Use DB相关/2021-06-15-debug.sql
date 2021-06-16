

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



b completion_hash.cc::add_word
b build_completion_hash





(gdb) b my_net_read
Breakpoint 2 at 0x143d198: file /usr/local/mysql/sql/net_serv.cc, line 896.



(gdb) b build_completion_hash
Function "build_completion_hash" not defined.



b /usr/local/mysql/client/mysql.cc:4748