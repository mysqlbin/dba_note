



[root@soft ~]# free -h
             total       used       free     shared    buffers     cached
Mem:          5.7G       5.5G       228M       424K       175M       501M
-/+ buffers/cache:       4.9G       904M
Swap:         2.0G       957M       1.0G



[root@soft ~]# ps aux|grep mysqld
root      1784  0.0  0.0   9452   584 ?        S     2020   0:00 /bin/sh /usr/local/mysql/bin/mysqld_safe --datadir=/mydata/mysql/mysql3306/data --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid
mysql     3226  0.4 79.7 7909576 4794656 ?     Sl    2020 921:05 /usr/local/mysql/bin/mysqld --basedir=/usr/local/mysql --datadir=/mydata/mysql/mysql3306/data --plugin-dir=/usr/local/mysql/lib/plugin --user=mysql --log-error=error.log --open-files-limit=65535 --pid-file=/mydata/mysql/mysql3306/data/mysqldb.pid --socket=/mydata/mysql/mysql3306/data/mysql3306.sock --port=3306
root      7180  0.0  0.0   6560   752 pts/1    S+   14:35   0:00 grep --color=auto mysqld


[root@soft ~]# top
top - 14:35:31 up 133 days,  4:53,  1 user,  load average: 0.05, 0.02, 0.00
Tasks: 155 total,   1 running, 154 sleeping,   0 stopped,   0 zombie
Cpu0  :  0.0%us,  0.0%sy,  0.0%ni,100.0%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
Cpu1  :  0.0%us,  0.0%sy,  0.0%ni,100.0%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
Cpu2  :  0.0%us,  0.0%sy,  0.0%ni,100.0%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
Cpu3  :  0.0%us,  0.0%sy,  0.0%ni,100.0%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:   6015828k total,  5782420k used,   233408k free,   179300k buffers
Swap:  2047996k total,   980676k used,  1067320k free,   513624k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND                                                                                                                                                                                                         
 3226 mysql     20   0 7724m 4.6g 7428 S  0.3 79.7 921:05.34 mysqld                                                                                                                                                                                                           
 7181 root      20   0 15136 1412 1040 R  0.3  0.0   0:00.01 top                 
 
 
 
innodb_buffer_pool_size = 1G

mysqld占用的物理内存：5.7 * 0.79 = 4.503 


mysql> show processlist;
+--------+-----------------+---------------------+-------------+---------+---------+-----------------------------+------------------+
| Id     | User            | Host                | db          | Command | Time    | State                       | Info             |
+--------+-----------------+---------------------+-------------+---------+---------+-----------------------------+------------------+
|      1 | event_scheduler | localhost           | NULL        | Daemon  |      50 | Waiting for next activation | NULL             |
| 638505 | huangdecai      | 192.168.0.251:51746 | niuniuh5_db | Sleep   |     122 |                             | NULL             |
.....................................................................................................................................
| 683858 | root            | 192.168.0.220:51848 | audit_db    | Sleep   |      11 |                             | NULL             |
| 683860 | root            | localhost           | NULL        | Query   |       0 | starting                    | show processlist |
+--------+-----------------+---------------------+-------------+---------+---------+-----------------------------+------------------+
642 rows in set (0.00 sec)





