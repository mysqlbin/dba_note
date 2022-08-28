https://www.cnblogs.com/ccw869476711/p/15162146.html   守护进程 supervisor
https://www.ucloud.cn/yun/10067.html
    supervisord 服务端
    supervisorctl 客户端
	
	
https://www.cnblogs.com/dadonggg/p/8297604.html         supervisor 配置篇

https://www.cnblogs.com/52fhy/p/10161253.html  Supervisor使用教程



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

supervisorctl shutdown

/usr/bin/supervisord -c /etc/supervisord.conf


supervisorctl stop cdb-2czqa3op                  
supervisorctl stop cdb-2ihqctad                     
supervisorctl stop cdb-2iibmv35                   
supervisorctl stop cdb-60r9gd1n                    
supervisorctl stop cdb-8nnay80x                    
supervisorctl stop cdb-am0621s3                   
supervisorctl stop cdb-bt4v3iiz                   
supervisorctl stop cdb-c1sl84sr                    
supervisorctl stop cdb-d3t1qa93                   
supervisorctl stop cdb-ojfdtbqf                     
supervisorctl stop cdb-qxorwe8b                     
supervisorctl stop cdb-r6mj1nfr                     
supervisorctl stop cdb-r8v1vd8t                

