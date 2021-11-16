

机器配置：4 CPU、16GB 内存，100GB的SSD盘。

注意：不需要重启MySQL .

[root@voice sbtest]# ls -lht sbtest1.ibd 
-rw-r-----. 1 mysql mysql 29G Nov 16 23:21 sbtest1.ibd

drop table sbtest.sbtest1;

sysbench /usr/local/share/sysbench/tests/include/oltp_legacy/oltp.lua \
--mysql-host=192.168.1.12 \
--mysql-port=3306 \
--mysql-user=sysbench \
--mysql-password='1234Abc&' \
--mysql-db=sbtest_02 \
--num-threads=8 \
--oltp-table-size=100000 \
--oltp-tables-count=10 \
--oltp-read-only=off --report-interval=10 --rand-type=uniform --max-time=600 prepare


sysbench /usr/local/share/sysbench/tests/include/oltp_legacy/oltp.lua \
--mysql-host=192.168.1.12 \
--mysql-port=3306 \
--mysql-user=sysbench \
--mysql-password='1234Abc&' \
--mysql-db=sbtest_02 \
--num-threads=8 \
--oltp-table-size=100000 \
--oltp-tables-count=10 \
--oltp-read-only=off --report-interval=1 --rand-type=uniform --max-time=600 \
--max-requests=0 --percentile=99 run >> /home/coding001/2021_11_06_02.log &

use sbtest_02;

drop table sbtest2;
drop table sbtest3;
drop table sbtest4;
drop table sbtest5;
drop table sbtest6;
drop table sbtest7;
drop table sbtest8;
drop table sbtest9;
drop table sbtest10; 
drop table sbtest11; 
drop table sbtest12; 
drop table sbtest13; 
drop table sbtest14; 
drop table sbtest15; 
drop table sbtest16; 
drop table sbtest17; 
drop table sbtest18; 
drop table sbtest19; 
drop table sbtest20; 
drop table sbtest1;


mysql> drop table sbtest.sbtest1;
Query OK, 0 rows affected (16.01 sec)


-bash-4.2$ tail -f /home/coding001/2021_11_06.log
Number of threads: 8
Report intermediate results every 10 second(s)
Initializing random number generator from current time


Initializing worker threads...

Threads started!

[ 10s ] thds: 8 tps: 355.70 qps: 7119.13 (r/w/o: 4984.32/1422.81/712.00) lat (ms,99%): 31.94 err/s: 0.00 reconn/s: 0.00
[ 20s ] thds: 8 tps: 374.01 qps: 7482.18 (r/w/o: 5237.80/1496.16/748.23) lat (ms,99%): 24.83 err/s: 0.00 reconn/s: 0.00
[ 30s ] thds: 8 tps: 378.00 qps: 7560.55 (r/w/o: 5292.46/1512.19/755.89) lat (ms,99%): 23.95 err/s: 0.00 reconn/s: 0.00
[ 40s ] thds: 8 tps: 375.80 qps: 7517.46 (r/w/o: 5262.54/1503.21/751.71) lat (ms,99%): 23.95 err/s: 0.00 reconn/s: 0.00
[ 50s ] thds: 8 tps: 381.00 qps: 7617.12 (r/w/o: 5331.55/1523.68/761.89) lat (ms,99%): 24.83 err/s: 0.00 reconn/s: 0.00
[ 60s ] thds: 8 tps: 372.11 qps: 7443.40 (r/w/o: 5210.57/1488.62/744.21) lat (ms,99%): 27.66 err/s: 0.00 reconn/s: 0.00
[ 70s ] thds: 8 tps: 381.30 qps: 7624.56 (r/w/o: 5336.87/1524.99/762.70) lat (ms,99%): 23.52 err/s: 0.00 reconn/s: 0.00
[ 80s ] thds: 8 tps: 381.50 qps: 7633.61 (r/w/o: 5344.21/1526.40/763.00) lat (ms,99%): 23.10 err/s: 0.00 reconn/s: 0.00
[ 90s ] thds: 8 tps: 381.80 qps: 7632.59 (r/w/o: 5342.19/1526.80/763.60) lat (ms,99%): 23.52 err/s: 0.00 reconn/s: 0.00
[ 100s ] thds: 8 tps: 381.70 qps: 7633.02 (r/w/o: 5342.82/1527.00/763.20) lat (ms,99%): 23.52 err/s: 0.00 reconn/s: 0.00
-- 应该改为每隔1秒输出1次。后面有时间了再测下。
-- 确实会有阻塞DML请求的情况。
[ 110s ] thds: 8 tps: 61.10 qps: 1228.11 (r/w/o: 861.41/244.30/122.40) lat (ms,99%): 23.10 err/s: 0.00 reconn/s: 0.00
[ 120s ] thds: 8 tps: 90.10 qps: 1795.57 (r/w/o: 1255.08/360.29/180.20) lat (ms,99%): 48.34 err/s: 0.00 reconn/s: 0.00

[ 130s ] thds: 8 tps: 371.70 qps: 7439.95 (r/w/o: 5208.84/1487.71/743.41) lat (ms,99%): 27.66 err/s: 0.00 reconn/s: 0.00
[ 140s ] thds: 8 tps: 373.00 qps: 7455.69 (r/w/o: 5218.39/1491.40/745.90) lat (ms,99%): 26.20 err/s: 0.00 reconn/s: 0.00
[ 150s ] thds: 8 tps: 375.20 qps: 7505.72 (r/w/o: 5254.41/1500.90/750.40) lat (ms,99%): 24.38 err/s: 0.00 reconn/s: 0.00
[ 160s ] thds: 8 tps: 374.80 qps: 7493.07 (r/w/o: 5244.58/1498.79/749.70) lat (ms,99%): 24.38 err/s: 0.00 reconn/s: 0.00
[ 170s ] thds: 8 tps: 374.40 qps: 7493.62 (r/w/o: 5246.42/1498.40/748.80) lat (ms,99%): 23.95 err/s: 0.00 reconn/s: 0.00
[ 180s ] thds: 8 tps: 376.10 qps: 7521.21 (r/w/o: 5265.31/1503.70/752.20) lat (ms,99%): 24.38 err/s: 0.00 reconn/s: 0.00
[ 190s ] thds: 8 tps: 376.90 qps: 7532.78 (r/w/o: 5271.59/1507.50/753.70) lat (ms,99%): 23.95 err/s: 0.00 reconn/s: 0.00
[ 200s ] thds: 8 tps: 375.20 qps: 7508.29 (r/w/o: 5256.79/1501.00/750.50) lat (ms,99%): 23.95 err/s: 0.00 reconn/s: 0.00
[ 210s ] thds: 8 tps: 373.90 qps: 7477.63 (r/w/o: 5234.42/1495.41/747.80) lat (ms,99%): 23.95 err/s: 0.00 reconn/s: 0.00
[ 220s ] thds: 8 tps: 375.20 qps: 7504.68 (r/w/o: 5252.79/1501.60/750.30) lat (ms,99%): 23.95 err/s: 0.00 reconn/s: 0.00
[ 230s ] thds: 8 tps: 374.28 qps: 7486.81 (r/w/o: 5241.42/1496.72/748.66) lat (ms,99%): 24.38 err/s: 0.00 reconn/s: 0.00
[ 240s ] thds: 8 tps: 376.22 qps: 7518.99 (r/w/o: 5261.97/1504.58/752.44) lat (ms,99%): 23.52 err/s: 0.00 reconn/s: 0.00
[ 250s ] thds: 8 tps: 375.80 qps: 7518.94 (r/w/o: 5264.23/1503.11/751.60) lat (ms,99%): 23.95 err/s: 0.00 reconn/s: 0.00




mysql> show processlist;
+----+-----------------+--------------------+-----------+---------+------+------------------------------+------------------------------------------------------------------------------------------------------+
| Id | User            | Host               | db        | Command | Time | State                        | Info                                                                                                 |
+----+-----------------+--------------------+-----------+---------+------+------------------------------+------------------------------------------------------------------------------------------------------+
|  1 | event_scheduler | localhost          | NULL      | Daemon  | 3099 | Waiting on empty queue       | NULL                                                                                                 |
|  4 | root            | localhost          | sbtest_02 | Query   |   14 | checking permissions         | drop table sbtest.sbtest1                                                                            |
|  5 | root            | localhost          | sbtest    | Query   |    0 | starting                     | show processlist                                                                                     |
|  6 | root            | localhost          | sbtest    | Sleep   | 1790 |                              | NULL                                                                                                 |
|  8 | root            | localhost          | sbtest_02 | Sleep   | 1283 |                              | NULL                                                                                                 |
| 19 | sysbench        | 192.168.1.11:49521 | sbtest_02 | Query   |   14 | Waiting for query cache lock | SELECT SUM(K) FROM sbtest7 WHERE id BETWEEN 49509 AND 49608                                          |
| 20 | sysbench        | 192.168.1.11:49523 | sbtest_02 | Query   |   13 | Waiting for query cache lock | UPDATE sbtest10 SET k=k+1 WHERE id=80349                                                             |
| 21 | sysbench        | 192.168.1.11:49532 | sbtest_02 | Query   |   14 | Waiting for query cache lock | UPDATE sbtest1 SET k=k+1 WHERE id=94460                                                              |
| 22 | sysbench        | 192.168.1.11:49538 | sbtest_02 | Query   |   13 | Waiting for query cache lock | UPDATE sbtest1 SET k=k+1 WHERE id=38914                                                              |
| 23 | sysbench        | 192.168.1.11:49522 | sbtest_02 | Query   |   13 | Waiting for query cache lock | UPDATE sbtest5 SET k=k+1 WHERE id=80538                                                              |
| 24 | sysbench        | 192.168.1.11:49534 | sbtest_02 | Query   |   14 | System lock                  | SELECT c FROM sbtest9 WHERE id BETWEEN 9467 AND 9566                                                 |
| 25 | sysbench        | 192.168.1.11:49520 | sbtest_02 | Query   |   14 | Waiting for query cache lock | UPDATE sbtest2 SET k=k+1 WHERE id=46570                                                              |
| 26 | sysbench        | 192.168.1.11:49536 | sbtest_02 | Query   |   14 | Waiting for query cache lock | UPDATE sbtest10 SET c='54569173224-94358658962-69891856417-80756509532-39675633309-02948787340-1364' |
+----+-----------------+--------------------+-----------+---------+------+------------------------------+------------------------------------------------------------------------------------------------------+
13 rows in set (0.00 sec)

mysql> show processlist;
+----+-----------------+--------------------+-----------+---------+------+------------------------------+------------------------------------------------------------------------------------------------------+
| Id | User            | Host               | db        | Command | Time | State                        | Info                                                                                                 |
+----+-----------------+--------------------+-----------+---------+------+------------------------------+------------------------------------------------------------------------------------------------------+
|  1 | event_scheduler | localhost          | NULL      | Daemon  | 3099 | Waiting on empty queue       | NULL                                                                                                 |
|  4 | root            | localhost          | sbtest_02 | Query   |   14 | checking permissions         | drop table sbtest.sbtest1                                                                            |
|  5 | root            | localhost          | sbtest    | Query   |    0 | starting                     | show processlist                                                                                     |
|  6 | root            | localhost          | sbtest    | Sleep   | 1790 |                              | NULL                                                                                                 |
|  8 | root            | localhost          | sbtest_02 | Sleep   | 1283 |                              | NULL                                                                                                 |
| 19 | sysbench        | 192.168.1.11:49521 | sbtest_02 | Query   |   14 | Waiting for query cache lock | SELECT SUM(K) FROM sbtest7 WHERE id BETWEEN 49509 AND 49608                                          |
| 20 | sysbench        | 192.168.1.11:49523 | sbtest_02 | Query   |   13 | Waiting for query cache lock | UPDATE sbtest10 SET k=k+1 WHERE id=80349                                                             |
| 21 | sysbench        | 192.168.1.11:49532 | sbtest_02 | Query   |   14 | Waiting for query cache lock | UPDATE sbtest1 SET k=k+1 WHERE id=94460                                                              |
| 22 | sysbench        | 192.168.1.11:49538 | sbtest_02 | Query   |   13 | Waiting for query cache lock | UPDATE sbtest1 SET k=k+1 WHERE id=38914                                                              |
| 23 | sysbench        | 192.168.1.11:49522 | sbtest_02 | Query   |   13 | Waiting for query cache lock | UPDATE sbtest5 SET k=k+1 WHERE id=80538                                                              |
| 24 | sysbench        | 192.168.1.11:49534 | sbtest_02 | Query   |   14 | System lock                  | SELECT c FROM sbtest9 WHERE id BETWEEN 9467 AND 9566                                                 |
| 25 | sysbench        | 192.168.1.11:49520 | sbtest_02 | Query   |   14 | Waiting for query cache lock | UPDATE sbtest2 SET k=k+1 WHERE id=46570                                                              |
| 26 | sysbench        | 192.168.1.11:49536 | sbtest_02 | Query   |   14 | Waiting for query cache lock | UPDATE sbtest10 SET c='54569173224-94358658962-69891856417-80756509532-39675633309-02948787340-1364' |
+----+-----------------+--------------------+-----------+---------+------+------------------------------+------------------------------------------------------------------------------------------------------+
13 rows in set (0.00 sec)

mysql> show processlist;
+----+-----------------+--------------------+-----------+---------+------+------------------------------+------------------------------------------------------------------------------------------------------+
| Id | User            | Host               | db        | Command | Time | State                        | Info                                                                                                 |
+----+-----------------+--------------------+-----------+---------+------+------------------------------+------------------------------------------------------------------------------------------------------+
|  1 | event_scheduler | localhost          | NULL      | Daemon  | 3100 | Waiting on empty queue       | NULL                                                                                                 |
|  4 | root            | localhost          | sbtest_02 | Query   |   15 | checking permissions         | drop table sbtest.sbtest1                                                                            |
|  5 | root            | localhost          | sbtest    | Query   |    0 | starting                     | show processlist                                                                                     |
|  6 | root            | localhost          | sbtest    | Sleep   | 1791 |                              | NULL                                                                                                 |
|  8 | root            | localhost          | sbtest_02 | Sleep   | 1284 |                              | NULL                                                                                                 |
| 19 | sysbench        | 192.168.1.11:49521 | sbtest_02 | Query   |   15 | Waiting for query cache lock | SELECT SUM(K) FROM sbtest7 WHERE id BETWEEN 49509 AND 49608                                          |
| 20 | sysbench        | 192.168.1.11:49523 | sbtest_02 | Query   |   14 | Waiting for query cache lock | UPDATE sbtest10 SET k=k+1 WHERE id=80349                                                             |
| 21 | sysbench        | 192.168.1.11:49532 | sbtest_02 | Query   |   15 | Waiting for query cache lock | UPDATE sbtest1 SET k=k+1 WHERE id=94460                                                              |
| 22 | sysbench        | 192.168.1.11:49538 | sbtest_02 | Query   |   14 | Waiting for query cache lock | UPDATE sbtest1 SET k=k+1 WHERE id=38914                                                              |
| 23 | sysbench        | 192.168.1.11:49522 | sbtest_02 | Query   |   14 | Waiting for query cache lock | UPDATE sbtest5 SET k=k+1 WHERE id=80538                                                              |
| 24 | sysbench        | 192.168.1.11:49534 | sbtest_02 | Query   |   15 | System lock                  | SELECT c FROM sbtest9 WHERE id BETWEEN 9467 AND 9566                                                 |
| 25 | sysbench        | 192.168.1.11:49520 | sbtest_02 | Query   |   15 | Waiting for query cache lock | UPDATE sbtest2 SET k=k+1 WHERE id=46570                                                              |
| 26 | sysbench        | 192.168.1.11:49536 | sbtest_02 | Query   |   15 | Waiting for query cache lock | UPDATE sbtest10 SET c='54569173224-94358658962-69891856417-80756509532-39675633309-02948787340-1364' |
+----+-----------------+--------------------+-----------+---------+------+------------------------------+------------------------------------------------------------------------------------------------------+
13 rows in set (0.00 sec)

mysql> show processlist;
+----+-----------------+--------------------+-----------+---------+------+------------------------------+------------------------------------------------------------------------------------------------------+
| Id | User            | Host               | db        | Command | Time | State                        | Info                                                                                                 |
+----+-----------------+--------------------+-----------+---------+------+------------------------------+------------------------------------------------------------------------------------------------------+
|  1 | event_scheduler | localhost          | NULL      | Daemon  | 3101 | Waiting on empty queue       | NULL                                                                                                 |
|  4 | root            | localhost          | sbtest_02 | Query   |   16 | checking permissions         | drop table sbtest.sbtest1                                                                            |
|  5 | root            | localhost          | sbtest    | Query   |    0 | starting                     | show processlist                                                                                     |
|  6 | root            | localhost          | sbtest    | Sleep   | 1792 |                              | NULL                                                                                                 |
|  8 | root            | localhost          | sbtest_02 | Sleep   | 1285 |                              | NULL                                                                                                 |
| 19 | sysbench        | 192.168.1.11:49521 | sbtest_02 | Query   |   16 | Waiting for query cache lock | SELECT SUM(K) FROM sbtest7 WHERE id BETWEEN 49509 AND 49608                                          |
| 20 | sysbench        | 192.168.1.11:49523 | sbtest_02 | Query   |   15 | Waiting for query cache lock | UPDATE sbtest10 SET k=k+1 WHERE id=80349                                                             |
| 21 | sysbench        | 192.168.1.11:49532 | sbtest_02 | Query   |   16 | Waiting for query cache lock | UPDATE sbtest1 SET k=k+1 WHERE id=94460                                                              |
| 22 | sysbench        | 192.168.1.11:49538 | sbtest_02 | Query   |   15 | Waiting for query cache lock | UPDATE sbtest1 SET k=k+1 WHERE id=38914                                                              |
| 23 | sysbench        | 192.168.1.11:49522 | sbtest_02 | Query   |   15 | Waiting for query cache lock | UPDATE sbtest5 SET k=k+1 WHERE id=80538                                                              |
| 24 | sysbench        | 192.168.1.11:49534 | sbtest_02 | Query   |   16 | System lock                  | SELECT c FROM sbtest9 WHERE id BETWEEN 9467 AND 9566                                                 |
| 25 | sysbench        | 192.168.1.11:49520 | sbtest_02 | Query   |   16 | Waiting for query cache lock | UPDATE sbtest2 SET k=k+1 WHERE id=46570                                                              |
| 26 | sysbench        | 192.168.1.11:49536 | sbtest_02 | Query   |   16 | Waiting for query cache lock | UPDATE sbtest10 SET c='54569173224-94358658962-69891856417-80756509532-39675633309-02948787340-1364' |
+----+-----------------+--------------------+-----------+---------+------+------------------------------+------------------------------------------------------------------------------------------------------+
13 rows in set (0.00 sec)


