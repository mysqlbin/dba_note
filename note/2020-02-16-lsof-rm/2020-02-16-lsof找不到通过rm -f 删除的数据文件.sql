

查看MySQL的进程号
	[root@mgr9 ~]# echo `pidof mysqld`
	23023

通过 rm -rf 删除文件
	[root@mgr9 db1]# rm -rf t_1602.ibd 
lsof 命令找到已经删除的文件
	[root@mgr9 fd]# lsof | grep t_1602.ibd

发现 t_1602.ibd 文件找不到。

