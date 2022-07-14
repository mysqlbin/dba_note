https://www.cnblogs.com/ccw869476711/p/15162146.html   守护进程 supervisor
https://www.ucloud.cn/yun/10067.html
    supervisord 服务端
    supervisorctl 客户端
	
	

[root@iZbp1co0b2dkojjkbk7r8cZ supervisor]# supervisorctl reread
redis: available
[root@iZbp1co0b2dkojjkbk7r8cZ supervisor]# 


[root@iZbp1co0b2dkojjkbk7r8cZ supervisor]# ps aux|grep redis
root     17607  0.0  0.0 112704   972 pts/3    S+   11:35   0:00 grep --color=auto redis

[root@iZbp1co0b2dkojjkbk7r8cZ supervisor]# ps aux|grep redis
root     17673  0.0  0.0 112704   972 pts/3    S+   11:36   0:00 grep --color=auto redis
[root@iZbp1co0b2dkojjkbk7r8cZ supervisor]# 
[root@iZbp1co0b2dkojjkbk7r8cZ supervisor]# supervisorctl update
redis: added process group
[root@iZbp1co0b2dkojjkbk7r8cZ supervisor]# ps aux|grep redis
root     17683  0.0  0.4 153892  8200 ?        Sl   11:36   0:00 /usr/local/bin/redis-server *:6379
root     17691  0.0  0.0 112704   968 pts/3    S+   11:36   0:00 grep --color=auto redis


/etc/supervisor/supervisorctl  reread