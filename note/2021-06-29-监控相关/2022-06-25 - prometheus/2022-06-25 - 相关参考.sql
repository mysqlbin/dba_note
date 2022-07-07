https://www.jianshu.com/p/528aeb2328a2

https://prometheus.io/download/

https://www.freesion.com/article/1487331453/


https://blog.csdn.net/m0_55005311/article/details/119464583?spm=1001.2101.3001.6661.1&utm_medium=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7ECTRLIST%7Edefault-1-119464583-blog-122701665.pc_relevant_multi_platform_whitelistv1&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7ECTRLIST%7Edefault-1-119464583-blog-122701665.pc_relevant_multi_platform_whitelistv1&utm_relevant_index=1


https://www.freesion.com/article/8194444612/



  
https://www.cnblogs.com/sanduzxcvbnm/p/13294327.html  prometheus监控多个MySQL实例

https://wenku.baidu.com/view/a53715946adc5022aaea998fcc22bcd126ff42a3.html	

https://www.cnblogs.com/sanduzxcvbnm/p/13094580.html

https://cloud.tencent.com/document/product/1416/56041	 MySQL Exporter 接入


https://blog.csdn.net/xiaoxiangzi520/article/details/114655712  prometheus+mysqld_exporter对mysql服务器多实例的监控


https://cloud.tencent.com/developer/article/1756851	  grafana+prometheus+Consul自动服务发现监控平台



https://grafana.com/solutions/mysql/monitor/?src=ggl-s&mdm=cpc&camp=nb-mysql-bmm&cnt=128610717094&trm=mysql%20monitoring&device=c&gclid=EAIaIQobChMIkPfY7a_N-AIVoZFmAh3tRwVREAAYASAAEgI23vD_BwE

http://erdong.site/prometheus-notes/chapter03-Exporter/3.14-mysql-server-exporter.html


https://blog.csdn.net/ywq935/article/details/80847161


https://www.icode9.com/content-2-1274546.html  



https://www.linuxe.cn/post-513.html

https://blog.csdn.net/n88Lpo/article/details/105648254



CREATE USER 'exporter'@'%' IDENTIFIED BY '' WITH MAX_USER_CONNECTIONS 3;
GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'exporter'@'%';


CREATE USER 'exporter'@'%' IDENTIFIED BY '';
GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'exporter'@'%';

 



