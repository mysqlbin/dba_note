

mysql -h192.168.0.242 -usysbench -p'123456aA$'   sbtest1102 < sbtest1102.sql  



create  database sbtest1103 DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;

create user 'sysbench'@'%' identified by '123456aA$';
grant all privileges on *.* to 'sysbench'@'%' with grant option;
			

set global sync_binlog=0;
set global innodb_flush_log_at_trx_commit=0;




sysbench --test=/usr/local/share/sysbench/oltp_write_only.lua --mysql-host=192.168.0.242 --mysql-port=3306 --mysql-user=sysbench --mysql-password='123456aA$' --mysql-db=sbtest1103 --tables=20 --table-size=2000000 --threads=20 --time=600 --report-interval=10 --db-driver=mysql prepare &

mysqldump -h192.168.0.242 -usysbench -p'123456aA$' --single-transaction --master-data=2  --set-gtid-purged=off  -B sbtest1103 > sbtest1103.sql  


create  database sbtest1103 DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;


sysbench --test=/usr/local/share/sysbench/oltp_write_only.lua \
--mysql-host=192.168.0.242 --mysql-port=3306 --mysql-user=sysbench \
--mysql-password='123456aA$' --mysql-db=sbtest1103 --tables=20 \
--table-size=2000000 --threads=20 --time=1800 --report-interval=10 \
--db-driver=mysql run  &

sysbench --test=/usr/local/share/sysbench/oltp_write_only.lua --mysql-host=192.168.0.242 --mysql-port=3306 --mysql-user=sysbench --mysql-password='123456aA$' --mysql-db=sbtest1103 --tables=20 --table-size=2000000 --threads=20 --time=600 --report-interval=10 --db-driver=mysql prepare &




IO 利用率、iowait  top
iostat -dmx 1
iostat 1
top

set global sync_binlog=1;
set global innodb_flush_log_at_trx_commit=1;



CREATE TABLE `t1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key1` varchar(100) DEFAULT NULL,
  `key2` int(11) DEFAULT NULL,
  `key3` varchar(100) DEFAULT NULL,
  `common_field` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10001 DEFAULT CHARSET=utf8mb4;

INSERT INTO `t1` (`id`, `key1`, `key2`, `key3`, `common_field`) VALUES ('1', '35', '5', '73', '62');



											begin;
purge binary logs to 'mysql-bin.000173';  
Query OK, 0 rows affected (0.70 sec)

											delete from t1 where id=1;
											-- 耗时：0.11 sec
		

------------------------------------------------------------------------------------

											begin;
purge binary logs to 'mysql-bin.000174';  
Query OK, 0 rows affected (0.70 sec)

											select * from t1 where id=1;
											-- 耗时：
											

root@mysqldb 11:45:  [sbtest1103]> select * from t1 where id=1;
+----+------+------+------+--------------+
| id | key1 | key2 | key3 | common_field |
+----+------+------+------+--------------+
|  1 | 35   |    5 | 73   | 62           |
+----+------+------+------+--------------+
1 row in set (0.12 sec)

root@mysqldb 11:45:  [sbtest1103]> select * from t1 where id=1;
+----+------+------+------+--------------+
| id | key1 | key2 | key3 | common_field |
+----+------+------+------+--------------+
|  1 | 35   |    5 | 73   | 62           |
+----+------+------+------+--------------+
1 row in set (0.00 sec)


										
root@mysqldb 11:29:  [sbtest1103]> begin;
Query OK, 0 rows affected (0.01 sec)

root@mysqldb 11:30:  [sbtest1103]> delete from t1 where id=1;
Query OK, 1 row affected (0.13 sec)

root@mysqldb 11:31:  [sbtest1103]> rollback;
Query OK, 0 rows affected (0.11 sec)

root@mysqldb 11:31:  [sbtest1103]> begin;
Query OK, 0 rows affected (0.00 sec)

root@mysqldb 11:31:  [sbtest1103]> delete from t1 where id=1;
Query OK, 1 row affected (0.00 sec)



shell> iostat -dmx 1
Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sda               0.00     1.00    0.00    8.00     0.00     0.06    15.00     0.08    9.75    0.00    9.75   9.75   7.80
dm-0              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
dm-2              0.00     0.00    0.00    8.00     0.00     0.06    15.00     0.08    9.75    0.00    9.75   9.75   7.80

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sda               0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
dm-0              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
dm-2              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00

Device:         rrqm/s   wrqm/s     r/s     w/s    rMB/s    wMB/s avgrq-sz avgqu-sz   await r_await w_await  svctm  %util
sda               0.00     0.00    0.00    6.00     0.00     0.02     8.00     0.07   11.17    0.00   11.17  11.17   6.70
dm-0              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
dm-1              0.00     0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00    0.00    0.00   0.00   0.00
dm-2              0.00     0.00    0.00    4.00     0.00     0.02    12.00     0.07   16.75    0.00   16.75  16.75   6.70



root@mysqldb 10:52:  [sbtest1103]> show binary logs;
+------------------+------------+
| Log_name         | File_size  |
+------------------+------------+
| mysql-bin.000095 |   47927584 |
| mysql-bin.000096 |        217 |
| mysql-bin.000097 | 1074230511 |
| mysql-bin.000098 |  453172155 |
| mysql-bin.000099 | 1074104232 |
| mysql-bin.000100 | 1074102444 |
| mysql-bin.000101 | 1074099852 |
| mysql-bin.000102 | 1074650347 |
| mysql-bin.000103 | 1074564173 |
| mysql-bin.000104 | 1074649529 |
| mysql-bin.000105 | 1073742982 |
| mysql-bin.000106 | 1073747842 |
| mysql-bin.000107 | 1073742279 |
| mysql-bin.000108 | 1073753528 |
| mysql-bin.000109 | 1073748586 |
| mysql-bin.000110 | 1073749699 |
| mysql-bin.000111 | 1073742984 |
| mysql-bin.000112 | 1107913093 |
| mysql-bin.000113 | 1144885425 |
| mysql-bin.000114 | 1144885426 |
| mysql-bin.000115 | 1144885429 |
| mysql-bin.000116 | 1074125064 |
| mysql-bin.000117 | 1074625779 |
| mysql-bin.000118 | 1074125013 |
| mysql-bin.000119 | 1074630256 |
| mysql-bin.000120 | 1077697080 |
| mysql-bin.000121 | 1074125653 |
| mysql-bin.000122 | 1074113857 |
| mysql-bin.000123 |  686929042 |
| mysql-bin.000124 | 1074117360 |
| mysql-bin.000125 | 1073836520 |
| mysql-bin.000126 | 1074114318 |
| mysql-bin.000127 | 1075528015 |
| mysql-bin.000128 | 1073966693 |
| mysql-bin.000129 | 1075783045 |
| mysql-bin.000130 | 1074096058 |
| mysql-bin.000131 | 1074605215 |
| mysql-bin.000132 | 1074650459 |
| mysql-bin.000133 | 1074567608 |
| mysql-bin.000134 | 1074649348 |
| mysql-bin.000135 | 1234293813 |
| mysql-bin.000136 | 1144885443 |
| mysql-bin.000137 | 1144885441 |
| mysql-bin.000138 | 1074565692 |
| mysql-bin.000139 | 1215624541 |
| mysql-bin.000140 | 1074459656 |
| mysql-bin.000141 | 1400338384 |
| mysql-bin.000142 | 1074440437 |
| mysql-bin.000143 | 1378477966 |
| mysql-bin.000144 | 1328795539 |
| mysql-bin.000145 | 1074440311 |
| mysql-bin.000146 | 1391395300 |
| mysql-bin.000147 | 1074895781 |
| mysql-bin.000148 | 1074623328 |
| mysql-bin.000149 | 1073868626 |
| mysql-bin.000150 | 1073868436 |
| mysql-bin.000151 | 1074671620 |
| mysql-bin.000152 | 1074222264 |
| mysql-bin.000153 | 1074221872 |
| mysql-bin.000154 | 1314835374 |
| mysql-bin.000155 | 1144884729 |
| mysql-bin.000156 | 1335698926 |
| mysql-bin.000157 | 1335698926 |
| mysql-bin.000158 | 1335699163 |
| mysql-bin.000159 | 1335698926 |
| mysql-bin.000160 | 1335699164 |
| mysql-bin.000161 | 1144885207 |
| mysql-bin.000162 | 1144885207 |
| mysql-bin.000163 | 1074304561 |
| mysql-bin.000164 | 1074296270 |
| mysql-bin.000165 | 1074206160 |
| mysql-bin.000166 | 1073943230 |
| mysql-bin.000167 | 1234127300 |
| mysql-bin.000168 | 1074601612 |
| mysql-bin.000169 | 1172714811 |
| mysql-bin.000170 | 1268169546 |
| mysql-bin.000171 | 1144885207 |
| mysql-bin.000172 | 1165787035 |
| mysql-bin.000173 |  190814408 |
+------------------+------------+
79 rows in set (0.00 sec)



sysbench@mysqldb 15:40:  [(none)]> purge binary logs to 'mysql-bin.000123';
Query OK, 0 rows affected (0.57 sec)

sysbench@mysqldb 15:41:  [(none)]> show binary logs;
+------------------+-----------+
| Log_name         | File_size |
+------------------+-----------+
| mysql-bin.000123 | 686929772 |
+------------------+-----------+
1 row in set (0.00 sec)

											


root@mysqldb 15:18:  [sbtest1103]> show processlist;
+----+----------+---------------------+------------+---------+-------+------------------------------------------+----------------------------------+
| Id | User     | Host                | db         | Command | Time  | State                                    | Info                             |
+----+----------+---------------------+------------+---------+-------+------------------------------------------+----------------------------------+
|  4 | root     | 192.168.0.220:52790 | NULL       | Sleep   | 17912 |                                          | NULL                             |
|  5 | root     | 192.168.0.220:52791 | NULL       | Sleep   | 17910 |                                          | NULL                             |
|  6 | root     | 192.168.0.220:52792 | NULL       | Sleep   | 17909 |                                          | NULL                             |
| 17 | root     | localhost           | sbtest1103 | Query   |     0 | starting                                 | show processlist                 |
| 22 | root     | 192.168.0.220:52934 | test_db    | Sleep   | 17112 |                                          | NULL                             |
| 23 | root     | 192.168.0.220:52935 | test_db    | Sleep   | 17163 |                                          | NULL                             |
| 24 | root     | 192.168.0.220:52941 | test_db    | Sleep   | 17120 |                                          | NULL                             |
| 60 | sysbench | 192.168.0.242:35148 | sbtest1103 | Query   |  1367 | altering table                           | CREATE INDEX k_14 ON sbtest14(k) |
| 61 | sysbench | 192.168.0.242:35149 | sbtest1103 | Query   |  1317 | altering table                           | CREATE INDEX k_9 ON sbtest9(k)   |
| 62 | sysbench | 192.168.0.242:35152 | sbtest1103 | Query   |  1361 | altering table                           | CREATE INDEX k_5 ON sbtest5(k)   |
| 63 | sysbench | 192.168.0.242:35154 | sbtest1103 | Query   |  1523 | altering table                           | CREATE INDEX k_13 ON sbtest13(k) |
| 64 | sysbench | 192.168.0.242:35156 | sbtest1103 | Query   |  1205 | altering table                           | CREATE INDEX k_2 ON sbtest2(k)   |
| 65 | sysbench | 192.168.0.242:35158 | sbtest1103 | Query   |  1390 | altering table                           | CREATE INDEX k_1 ON sbtest1(k)   |
| 66 | sysbench | 192.168.0.242:35160 | sbtest1103 | Query   |  1409 | altering table                           | CREATE INDEX k_8 ON sbtest8(k)   |
| 67 | sysbench | 192.168.0.242:35162 | sbtest1103 | Query   |  1457 | altering table                           | CREATE INDEX k_15 ON sbtest15(k) |
| 68 | sysbench | 192.168.0.242:35164 | sbtest1103 | Query   |  1517 | altering table                           | CREATE INDEX k_4 ON sbtest4(k)   |
| 69 | sysbench | 192.168.0.242:35166 | sbtest1103 | Query   |  1523 | altering table                           | CREATE INDEX k_6 ON sbtest6(k)   |
| 70 | sysbench | 192.168.0.242:35170 | sbtest1103 | Query   |  1464 | altering table                           | CREATE INDEX k_10 ON sbtest10(k) |
| 71 | sysbench | 192.168.0.242:35168 | sbtest1103 | Query   |  1311 | altering table                           | CREATE INDEX k_3 ON sbtest3(k)   |
| 72 | sysbench | 192.168.0.242:35172 | sbtest1103 | Query   |  1505 | altering table                           | CREATE INDEX k_19 ON sbtest19(k) |
| 73 | sysbench | 192.168.0.242:35174 | sbtest1103 | Query   |  1256 | altering table                           | CREATE INDEX k_12 ON sbtest12(k) |
| 74 | sysbench | 192.168.0.242:35176 | sbtest1103 | Query   |  1204 | altering table                           | CREATE INDEX k_7 ON sbtest7(k)   |
| 75 | sysbench | 192.168.0.242:35178 | sbtest1103 | Query   |  1462 | altering table                           | CREATE INDEX k_16 ON sbtest16(k) |
| 76 | sysbench | 192.168.0.242:35180 | sbtest1103 | Query   |  1214 | altering table                           | CREATE INDEX k_11 ON sbtest11(k) |
| 77 | sysbench | 192.168.0.242:35182 | sbtest1103 | Query   |  1516 | altering table                           | CREATE INDEX k_18 ON sbtest18(k) |
| 78 | sysbench | 192.168.0.242:35184 | sbtest1103 | Query   |  1538 | committing alter table to storage engine | CREATE INDEX k_17 ON sbtest17(k) |
| 79 | sysbench | 192.168.0.242:35186 | sbtest1103 | Query   |  1341 | altering table                           | CREATE INDEX k_20 ON sbtest20(k) |
+----+----------+---------------------+------------+---------+-------+------------------------------------------+----------------------------------+
27 rows in set (0.10 sec)


delete from sbtest1;
delete from sbtest2;
delete from sbtest3;
delete from sbtest4;
delete from sbtest5;
delete from sbtest6;
delete from sbtest7;
delete from sbtest8;
delete from sbtest9;
delete from sbtest10; 
delete from sbtest11; 
delete from sbtest12; 
delete from sbtest13; 
delete from sbtest14; 
delete from sbtest15; 
delete from sbtest16; 
delete from sbtest17; 
delete from sbtest18; 
delete from sbtest19; 
delete from sbtest20; 



drop table sbtest1;
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


set global sync_binlog=0;
set global innodb_flush_log_at_trx_commit=0;

mysql -h192.168.0.242 -usysbench -p'123456aA$'   sbtest1103 < sbtest1103.sql  &
mysql -h192.168.0.242 -usysbench -p'123456aA$'   sbtest1102 < sbtest1102.sql  &


create  database sbtest1104 DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;

sysbench --test=/usr/local/share/sysbench/oltp_write_only.lua --mysql-host=192.168.0.242 --mysql-port=3306 --mysql-user=sysbench --mysql-password='123456aA$' --mysql-db=sbtest1104 --tables=20 --table-size=2000000 --threads=10 --time=600 --report-interval=10 --db-driver=mysql prepare &



create  database sbtest1105 DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;

sysbench --test=/usr/local/share/sysbench/oltp_write_only.lua --mysql-host=192.168.0.242 --mysql-port=3306 --mysql-user=sysbench --mysql-password='123456aA$' --mysql-db=sbtest1105 --tables=20 --table-size=2000000 --threads=10 --time=600 --report-interval=10 --db-driver=mysql prepare &


mysqldump -h192.168.0.242 -usysbench -p'123456aA$' --single-transaction --master-data=2  --set-gtid-purged=off  -B sbtest1102 > sbtest1102.sql &
 
mysqldump -h192.168.0.242 -usysbench -p'123456aA$' --single-transaction --master-data=2  --set-gtid-purged=off  -B sbtest1103 > sbtest1103.sql &

mysqldump -h192.168.0.242 -usysbench -p'123456aA$' --single-transaction --master-data=2  --set-gtid-purged=off  -B sbtest1104 > sbtest1104.sql &
 
mysqldump -h192.168.0.242 -usysbench -p'123456aA$' --single-transaction --master-data=2  --set-gtid-purged=off  -B sbtest1105 > sbtest1105.sql &



mysql -h192.168.0.242 -usysbench -p'123456aA$'   sbtest1102 < sbtest1102.sql  &
mysql -h192.168.0.242 -usysbench -p'123456aA$'   sbtest1103 < sbtest1103.sql  &
mysql -h192.168.0.242 -usysbench -p'123456aA$'   sbtest1104 < sbtest1104.sql  &
mysql -h192.168.0.242 -usysbench -p'123456aA$'   sbtest1105 < sbtest1105.sql  &





