

open_files_limit：
	操作系统允许MySQL服务打开的文件数量。

Open_files:
	打开文件的数量。
	
造成的问题:	
	MySQL too many open files。 (模拟一下这个) 

问题原因：
	用户需要打开的文件数超过了上限，通过命令"ulimit -a"可查看如下信息。
	

	
'show variables like '%open_files_limit%';'  : 5000
'show variables like '%innodb_open_files%';' : 995


'show global status like 'Open_files%';'	 : 38	
																	    65535
[coding123@db-a ~]$ sudo cat mysql-error.log |grep max_open_files
[sudo] password for coding123: 
2018-04-28T03:16:23.068857Z 0 [Warning] Changed limits: max_open_files: 5000 (requested 15000)
2018-07-06T02:05:01.721696Z 0 [Warning] Changed limits: max_open_files: 5000 (requested 15000)
2018-07-27T23:40:47.732580Z 0 [Warning] Changed limits: max_open_files: 5000 (requested 15000)
2018-10-21T22:18:26.232763Z 0 [Warning] Changed limits: max_open_files: 5000 (requested 15000)
2019-01-20T23:04:27.365601Z 0 [Warning] Changed limits: max_open_files: 5000 (requested 15000)

[Warning] Buffered warning: Changed limits: max_open_files: 1024 (requested 15000)


参考:
	https://blog.csdn.net/liyuming0000/article/details/51201662

2019-01-20T23:04:27.706840Z 0 [Warning] InnoDB: innodb_open_files should not be greater than the open_files_limit.


[coding123@db-a ~]# ulimit -a
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 30806
max locked memory       (kbytes, -l) 64
max memory size         (kbytes, -m) unlimited
open files                      (-n) 1024
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) 30806
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited

