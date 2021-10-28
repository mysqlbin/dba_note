mysql> show binary logs;
+------------------+------------+-----------+
| Log_name         | File_size  | Encrypted |
+------------------+------------+-----------+
| mysql-bin.000069 | 1073749339 | No        |
| mysql-bin.000070 | 1075518620 | No        |
| mysql-bin.000071 | 1076632867 | No        |
| mysql-bin.000072 | 1080204648 | No        |
| mysql-bin.000073 | 1074081616 | No        |
| mysql-bin.000074 | 1074081614 | No        |
| mysql-bin.000075 | 1074081610 | No        |
| mysql-bin.000076 | 1074081607 | No        |
| mysql-bin.000077 | 1074081599 | No        |
| mysql-bin.000078 | 1073900570 | No        |
| mysql-bin.000079 | 1074082800 | No        |
| mysql-bin.000080 | 1073745731 | No        |
| mysql-bin.000081 |  530702456 | No        |
| mysql-bin.000082 | 1074099052 | No        |
| mysql-bin.000083 | 1074533910 | No        |
| mysql-bin.000084 | 1074581707 | No        |
| mysql-bin.000085 | 1074333872 | No        |
| mysql-bin.000086 | 1074332997 | No        |
| mysql-bin.000087 | 1074212395 | No        |
| mysql-bin.000088 | 1074682190 | No        |
| mysql-bin.000089 |  110556603 | No        |
| mysql-bin.000090 | 1074464993 | No        |
| mysql-bin.000091 | 1074682900 | No        |
| mysql-bin.000092 | 1074586473 | No        |
| mysql-bin.000093 |  591696384 | No        |
+------------------+------------+-----------+
25 rows in set (0.02 sec)

mysql> purge binary logs to 'mysql-bin.000093';
Query OK, 0 rows affected (1.48 sec)

24个GB的binlog，耗时 1.48s


mysql>  show binary logs;
+------------------+------------+
| Log_name         | File_size  |
+------------------+------------+
| mysql-bin.000368 | 1073964358 |
| mysql-bin.000369 | 1075003942 |
| mysql-bin.000370 | 1075006854 |
| mysql-bin.000371 | 1073767907 |
| mysql-bin.000372 |  777924301 |
| mysql-bin.000373 | 1073971284 |
| mysql-bin.000374 | 1076043524 |
| mysql-bin.000375 | 1073972489 |
| mysql-bin.000376 | 1075005288 |
| mysql-bin.000377 | 1073969317 |
| mysql-bin.000378 | 1073975376 |
| mysql-bin.000379 | 1075005404 |
| mysql-bin.000380 | 1073972509 |
| mysql-bin.000381 | 1073973973 |
| mysql-bin.000382 | 1073974115 |
| mysql-bin.000383 | 1073972611 |
| mysql-bin.000384 | 1073958614 |
| mysql-bin.000385 | 1073967088 |
| mysql-bin.000386 | 1073964691 |
| mysql-bin.000387 | 1073741897 |
| mysql-bin.000388 | 1073742212 |
| mysql-bin.000389 | 1355298972 |
| mysql-bin.000390 | 1144884817 |
| mysql-bin.000391 | 1144884817 |
| mysql-bin.000392 | 1144884821 |
| mysql-bin.000393 | 1144884823 |
| mysql-bin.000394 | 1144884823 |
| mysql-bin.000395 | 1144884823 |
| mysql-bin.000396 | 1427285191 |
| mysql-bin.000397 | 1094242533 |
| mysql-bin.000398 | 1109923907 |
| mysql-bin.000399 |  880100599 |
+------------------+------------+
32 rows in set (0.01 sec)

mysql> purge binary logs to 'mysql-bin.000399'; 
Query OK, 0 rows affected (0.57 sec)

mysql>  show binary logs;
+------------------+-----------+
| Log_name         | File_size |
+------------------+-----------+
| mysql-bin.000399 | 880100599 |
+------------------+-----------+
1 row in set (0.00 sec)


											begin;
purge binary logs to 'mysql-bin.000399';  
											delete from t1 where id=1;

