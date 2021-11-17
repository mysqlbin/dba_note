

机器配置：4 CPU、16GB 内存，100GB的SSD盘。

注意：不需要重启MySQL .

[root@voice sbtest]# ls -lht sbtest1.ibd 
-rw-r-----. 1 mysql mysql 29G Nov 16 23:21 sbtest1.ibd



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


-- drop table操作，耗时太短，制造完成数据，重启MySQL导致的
drop table sbtest.sbtest1;
Query OK, 0 rows affected (2.28 sec)
