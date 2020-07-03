

https://www.jianshu.com/p/01fd6cd5cd61  Bash Shell 获取进程 PID（转）
https://blog.csdn.net/qq_28423997/article/details/88890963   定时任务执行shell脚本中 grep -v grep 中的坑


ps -ef | grep "mongodb" | grep -v grep | awk '{print $2}'


[root@database-04 dba2]# ps -ef | grep "mongodb"
mongodb  26208     1  2 14:30 ?        00:00:02 /usr/local/mongodb/bin/mongod --config /etc/mongodb.conf
root     26767 21426  0 14:31 pts/3    00:00:00 grep --color=auto mongodb

awk '{print $2}'   ： 提取第二列

[root@database-04 dba2]# ps -ef | grep "mongodb"  | awk '{print $2}'
26208
27164

其中的grep -v grep 是干啥的呢 ？

很简单 ，为了去除包含grep的进程行 ，避免影响最终数据的正确性 。

[root@database-04 dba2]# ps -ef | grep "mongodb" | grep -v grep | awk '{print $2}'
26208




---------------------------------------------------------------------
ps aux|grep "mongodb" | sed -n 2p | awk '{print $2}'    --这种方式不可行。

