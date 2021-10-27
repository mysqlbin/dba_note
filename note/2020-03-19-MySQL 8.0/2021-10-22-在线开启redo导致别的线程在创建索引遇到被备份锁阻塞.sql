
mysql> ALTER INSTANCE ENABLE INNODB REDO_LOG;

mysql> show processlist;
+-----+-----------------+--------------------+--------+---------+--------+-------------------------+---------------------------------------+
| Id  | User            | Host               | db     | Command | Time   | State                   | Info                                  |
+-----+-----------------+--------------------+--------+---------+--------+-------------------------+---------------------------------------+
|   5 | event_scheduler | localhost          | NULL   | Daemon  | 148359 | Waiting on empty queue  | NULL                                  |
| 192 | sysbench        | 192.168.1.12:35382 | sbtest | Query   |     46 | Waiting for backup lock | ALTER INSTANCE ENABLE INNODB REDO_LOG |
| 193 | sysbench        | 192.168.1.10:59426 | sbtest | Query   |     56 | altering table          | CREATE INDEX k_3 ON sbtest3(k)        |
| 194 | sysbench        | 192.168.1.10:59428 | sbtest | Query   |     64 | altering table          | CREATE INDEX k_6 ON sbtest6(k)        |
| 195 | sysbench        | 192.168.1.10:59420 | sbtest | Query   |     42 | Waiting for backup lock | CREATE INDEX k_5 ON sbtest5(k)        |
| 196 | sysbench        | 192.168.1.10:59419 | sbtest | Query   |     45 | Waiting for backup lock | CREATE INDEX k_1 ON sbtest1(k)        |
| 197 | sysbench        | 192.168.1.10:59430 | sbtest | Query   |     43 | Waiting for backup lock | CREATE INDEX k_2 ON sbtest2(k)        |
| 198 | sysbench        | 192.168.1.10:59432 | sbtest | Query   |     41 | Waiting for backup lock | CREATE INDEX k_4 ON sbtest4(k)        |
| 199 | sysbench        | 192.168.1.10:59418 | sbtest | Query   |     73 | altering table          | CREATE INDEX k_7 ON sbtest7(k)        |
| 200 | sysbench        | 192.168.1.10:59436 | sbtest | Query   |     62 | altering table          | CREATE INDEX k_9 ON sbtest9(k)        |
| 201 | sysbench        | 192.168.1.10:59434 | sbtest | Query   |     52 | altering table          | CREATE INDEX k_8 ON sbtest8(k)        |
| 202 | sysbench        | 192.168.1.10:59440 | sbtest | Query   |     39 | Waiting for backup lock | CREATE INDEX k_15 ON sbtest15(k)      |
| 203 | sysbench        | 192.168.1.10:59438 | sbtest | Query   |     51 | altering table          | CREATE INDEX k_11 ON sbtest11(k)      |
| 204 | sysbench        | 192.168.1.10:59442 | sbtest | Query   |     67 | altering table          | CREATE INDEX k_16 ON sbtest16(k)      |
| 205 | sysbench        | 192.168.1.10:59444 | sbtest | Query   |     57 | altering table          | CREATE INDEX k_12 ON sbtest12(k)      |
| 206 | sysbench        | 192.168.1.10:59448 | sbtest | Query   |     54 | altering table          | CREATE INDEX k_13 ON sbtest13(k)      |
| 207 | sysbench        | 192.168.1.10:59446 | sbtest | Query   |     68 | altering table          | CREATE INDEX k_14 ON sbtest14(k)      |
| 208 | sysbench        | 192.168.1.10:59450 | sbtest | Query   |     44 | Waiting for backup lock | CREATE INDEX k_10 ON sbtest10(k)      |
| 209 | sysbench        | 192.168.1.12:35446 | NULL   | Query   |      0 | init                    | show processlist                      |
+-----+-----------------+--------------------+--------+---------+--------+-------------------------+---------------------------------------+
19 rows in set (0.01 sec)




