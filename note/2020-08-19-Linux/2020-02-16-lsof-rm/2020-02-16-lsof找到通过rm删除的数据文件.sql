

# 查看MySQL的进程号
[root@mgr9 ~]# echo `pidof mysqld`
23023

[root@mgr9 db1]# rm t1.ibd 
rm: remove regular file ‘t1.ibd’? y
[root@mgr9 db1]# ls -lht t1.ibd
ls: cannot access t1.ibd: No such file or directory


[root@mgr9 fd]# lsof | grep t1.ibd
mysqld    23023         mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23024   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23027   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23028   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23029   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23030   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23031   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23032   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23033   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23034   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23035   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23036   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23037   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23038   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23039   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23040   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23041   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23042   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23043   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23044   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23045   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23046   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23047   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23048   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23053   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23054   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23055   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23056   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23057   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23058   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23059   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23060   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23061   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23062   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23063   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23064   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23065   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23066   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 23071   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 28232   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)
mysqld    23023 28244   mysql  143uW     REG              253,2     147456       1771 /data/mysql/mysql3306/data/db1/t1.ibd (deleted)


[root@mgr9 fd]# pwd
/proc/23023/fd
[root@mgr9 fd]# cp 143 /data/mysql/mysql3306/data/db1/t1.ibd
cp: overwrite ‘/data/mysql/mysql3306/data/db1/t1.ibd’? y

[root@mgr9 db1]# ls -lht t1.ibd
-rw-r--r-- 1 root root 144K Feb 15 00:43 t1.ibd

[root@mgr9 db1]# chown mysql:mysql t1.ibd

[root@mgr9 db1]# ls -lht t1.ibd
-rw-r--r-- 1 mysql mysql 144K Feb 15 00:43 t1.ibd



测试删除 .ibd 文件后是否还可以正确写入？
	[root@mgr9 db1]# rm t1.ibd 
	rm: remove regular file ‘t1.ibd’? y
	[root@mgr9 db1]# ls -lht t1.ibd
	ls: cannot access t1.ibd: No such file or directory
	
	root@mysqldb 03:23:  [db1]> INSERT INTO `db1`.`t1` (`id`, `a`, `b`) VALUES ('1002', '1000', '1');
	Query OK, 1 row affected (0.00 sec)

	root@mysqldb 03:27:  [db1]> select * from t1 order by id desc limit 1;
	+------+------+------+
	| id   | a    | b    |
	+------+------+------+
	| 1002 | 1000 |    1 |
	+------+------+------+
	1 row in set (0.00 sec)
