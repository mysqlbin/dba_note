

top - 08:45:20 up 9 days, 22:59,  4 users,  load average: 0.47, 0.15, 0.08
Tasks: 100 total,   3 running,  97 sleeping,   0 stopped,   0 zombie
%Cpu0  : 97.4 us,  0.0 sy,  0.0 ni,  2.6 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
KiB Mem :  1016476 total,   574296 free,    76976 used,   365204 buff/cache
KiB Swap:  2097148 total,  2063200 free,    33948 used.   764252 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S %CPU %MEM     TIME+ COMMAND                                                                                                                                                                                                   
10007 root      20   0  160632  29116   1708 R 97.4  2.9   0:45.16 mysql                                                                                                                                                                                                     
    1 root      20   0   45812   3608   2208 S  0.0  0.4   0:09.79 systemd                                                                                                                                                                                                   
    2 root      20   0       0      0      0 S  0.0  0.0   0:00.08 kthreadd                                                                                                                                                                                                  
    3 root      20   0       0      0      0 S  0.0  0.0   0:53.81 ksoftirqd/0                                                                                                                                                                                               
    6 root      20   0       0      0      0 S  0.0  0.0   0:01.65 kworker/u2:0                                                                                                                                                                                              
    7 root      rt   0       0      0      0 S  0.0  0.0   0:00.00 migration/0                                                                                                                                                                                               
    8 root      20   0       0      0      0 S  0.0  0.0   0:00.00 rcu_bh              
	
	
	
	
root@mysqldb 09:52:  [sbtest]> show processlist;
+----+------+---------------------+--------+---------+------+----------+------------------+
| Id | User | Host                | db     | Command | Time | State    | Info             |
+----+------+---------------------+--------+---------+------+----------+------------------+
| 53 | root | 192.168.0.201:36158 | sbtest | Sleep   |    0 |          | NULL             |
| 54 | root | localhost           | sbtest | Query   |    0 | starting | show processlist |
+----+------+---------------------+--------+---------+------+----------+------------------+
2 rows in set (0.00 sec)



root@mysqldb 09:53:  [sbtest]> select THREAD_OS_ID from performance_schema.threads where processlist_id=53\G;
*************************** 1. row ***************************
THREAD_OS_ID: 28811
1 row in set (0.00 sec)
