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

sysbench --test=/usr/local/share/sysbench/oltp_write_only.lua --mysql-host=192.168.1.12 --mysql-port=3306 --mysql-user=sysbench --mysql-password='1234Abc&' --mysql-db=sbtest --tables=20 --table-size=2000000 --threads=32 --time=600 --report-interval=10 --db-driver=mysql prepare &


show global variables like '%sync_binlog%';
show global variables like '%innodb_flush_log_at_trx_commit%';
show global variables like '%innodb_io_capacity%';


mysql> show global variables like '%sync_binlog%';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| sync_binlog   | 0     |
+---------------+-------+
1 row in set (0.02 sec)

mysql> show global variables like '%innodb_flush_log_at_trx_commit%';
+--------------------------------+-------+
| Variable_name                  | Value |
+--------------------------------+-------+
| innodb_flush_log_at_trx_commit | 0     |
+--------------------------------+-------+
1 row in set (0.00 sec)

mysql> show global variables like '%innodb_io_capacity%';
+------------------------+-------+
| Variable_name          | Value |
+------------------------+-------+
| innodb_io_capacity     | 5000  |
| innodb_io_capacity_max | 20000 |
+------------------------+-------+
2 rows in set (0.00 sec)





sysbench --test=/usr/local/share/sysbench/oltp_write_only.lua \
--mysql-host=192.168.1.12 --mysql-port=3306 --mysql-user=sysbench \
--mysql-password='1234Abc&' --mysql-db=sbtest --tables=20 \
--table-size=2000000 --threads=24 --time=600 --report-interval=10 \
--db-driver=mysql run  &
				


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
delete from sbtest1;

update sbtest1 set pad=10000000000000000000000000000000000;

update t1 set a=1000000000;
update t1 set a=1000000001;
update t1 set a=1000000002;
update t1 set a=1000000003;
update t1 set a=1000000004;
update t1 set a=1000000005;
update t1 set a=200000005;
update t1 set a=300000005;
update t1 set a=400000005;
update t1 set a=50000005;
update t1 set a=60000005;
update t1 set a=70000005;
update t1 set a=70000006;
update t1 set a=70000007;
update t1 set a=70000008;
update t1 set a=70000009;
update t1 set a=70000010;
update t1 set a=70000011;
update t1 set a=10000011;
update t1 set a=20000011;
update t1 set a=30000011;
update t1 set a=40000011;
update t1 set a=50000011;
update t1 set a=60000011;
update t1 set a=1000000000;
update t1 set a=1000000001;
update t1 set a=1000000002;
update t1 set a=1000000003;
update t1 set a=1000000004;
update t1 set a=1000000005;
update t1 set a=200000005;
update t1 set a=300000005;
update t1 set a=400000005;
update t1 set a=50000005;
update t1 set a=60000005;
update t1 set a=70000005;
update t1 set a=70000006;
update t1 set a=70000007;
update t1 set a=70000008;
update t1 set a=70000009;
update t1 set a=70000010;
update t1 set a=70000011;
update t1 set a=10000011;
update t1 set a=20000011;
update t1 set a=30000011;
update t1 set a=40000011;
update t1 set a=50000011;
update t1 set a=60000011;

update t1 set a=1000000000;
update t1 set a=1000000001;
update t1 set a=1000000002;
update t1 set a=1000000003;
update t1 set a=1000000004;
update t1 set a=1000000005;
update t1 set a=200000005;
update t1 set a=300000005;
update t1 set a=400000005;
update t1 set a=50000005;
update t1 set a=60000005;
update t1 set a=70000005;
update t1 set a=70000006;
update t1 set a=70000007;
update t1 set a=70000008;
update t1 set a=70000009;
update t1 set a=70000010;
update t1 set a=70000011;
update t1 set a=10000011;
update t1 set a=20000011;
update t1 set a=30000011;
update t1 set a=40000011;
update t1 set a=50000011;
update t1 set a=60000011;

update t1 set a=1000000000;
update t1 set a=1000000001;
update t1 set a=1000000002;
update t1 set a=1000000003;
update t1 set a=1000000004;
update t1 set a=1000000005;
update t1 set a=200000005;
update t1 set a=300000005;
update t1 set a=400000005;
update t1 set a=50000005;
update t1 set a=60000005;
update t1 set a=70000005;
update t1 set a=70000006;
update t1 set a=70000007;
update t1 set a=70000008;
update t1 set a=70000009;
update t1 set a=70000010;
update t1 set a=70000011;
update t1 set a=10000011;
update t1 set a=20000011;
update t1 set a=30000011;
update t1 set a=40000011;
update t1 set a=50000011;
update t1 set a=60000011;

update t1 set a=1000000000;
update t1 set a=1000000001;
update t1 set a=1000000002;
update t1 set a=1000000003;
update t1 set a=1000000004;
update t1 set a=1000000005;
update t1 set a=200000005;
update t1 set a=300000005;
update t1 set a=400000005;
update t1 set a=50000005;
update t1 set a=60000005;
update t1 set a=70000005;
update t1 set a=70000006;
update t1 set a=70000007;
update t1 set a=70000008;
update t1 set a=70000009;
update t1 set a=70000010;
update t1 set a=70000011;
update t1 set a=10000011;
update t1 set a=20000011;
update t1 set a=30000011;
update t1 set a=40000011;
update t1 set a=50000011;
update t1 set a=60000011;
update t1 set a=1000000000;
update t1 set a=1000000001;
update t1 set a=1000000002;
update t1 set a=1000000003;
update t1 set a=1000000004;
update t1 set a=1000000005;
update t1 set a=200000005;
update t1 set a=300000005;
update t1 set a=400000005;
update t1 set a=50000005;
update t1 set a=60000005;
update t1 set a=70000005;
update t1 set a=70000006;
update t1 set a=70000007;
update t1 set a=70000008;
update t1 set a=70000009;
update t1 set a=70000010;
update t1 set a=70000011;
update t1 set a=10000011;
update t1 set a=20000011;
update t1 set a=30000011;
update t1 set a=40000011;
update t1 set a=50000011;
update t1 set a=60000011;

update t1 set a=1000000000;
update t1 set a=1000000001;
update t1 set a=1000000002;
update t1 set a=1000000003;
update t1 set a=1000000004;
update t1 set a=1000000005;
update t1 set a=200000005;
update t1 set a=300000005;
update t1 set a=400000005;
update t1 set a=50000005;
update t1 set a=60000005;
update t1 set a=70000005;
update t1 set a=70000006;
update t1 set a=70000007;
update t1 set a=70000008;
update t1 set a=70000009;
update t1 set a=70000010;
update t1 set a=70000011;
update t1 set a=10000011;
update t1 set a=20000011;
update t1 set a=30000011;
update t1 set a=40000011;
update t1 set a=50000011;
update t1 set a=60000011;

update t1 set a=1000000000;
update t1 set a=1000000001;
update t1 set a=1000000002;
update t1 set a=1000000003;
update t1 set a=1000000004;
update t1 set a=1000000005;
update t1 set a=200000005;
update t1 set a=300000005;
update t1 set a=400000005;
update t1 set a=50000005;
update t1 set a=60000005;
update t1 set a=70000005;
update t1 set a=70000006;
update t1 set a=70000007;
update t1 set a=70000008;
update t1 set a=70000009;
update t1 set a=70000010;
update t1 set a=70000011;
update t1 set a=10000011;
update t1 set a=20000011;
update t1 set a=30000011;
update t1 set a=40000011;
update t1 set a=50000011;
update t1 set a=60000011;


update t2 set a=1000000000;
update t2 set a=1000000001;
update t2 set a=1000000002;
update t2 set a=1000000003;
update t2 set a=1000000004;
update t2 set a=1000000005;
update t2 set a=200000005;
update t2 set a=300000005;
update t2 set a=400000005;
update t2 set a=50000005;
update t2 set a=60000005;
update t2 set a=70000005;
update t2 set a=70000006;
update t2 set a=70000007;
update t2 set a=70000008;
update t2 set a=70000009;
update t2 set a=70000010;
update t2 set a=70000011;
update t2 set a=1000000000;
update t2 set a=1000000001;
update t2 set a=1000000002;
update t2 set a=1000000003;
update t2 set a=1000000004;
update t2 set a=1000000005;
update t2 set a=200000005;
update t2 set a=300000005;
update t2 set a=400000005;
update t2 set a=50000005;
update t2 set a=60000005;
update t2 set a=70000005;
update t2 set a=70000006;
update t2 set a=70000007;
update t2 set a=70000008;
update t2 set a=70000009;
update t2 set a=70000010;
update t2 set a=70000011;
update t2 set a=1000000000;
update t2 set a=1000000001;
update t2 set a=1000000002;
update t2 set a=1000000003;
update t2 set a=1000000004;
update t2 set a=1000000005;
update t2 set a=200000005;
update t2 set a=300000005;
update t2 set a=400000005;
update t2 set a=50000005;
update t2 set a=60000005;
update t2 set a=70000005;
update t2 set a=70000006;
update t2 set a=70000007;
update t2 set a=70000008;
update t2 set a=70000009;
update t2 set a=70000010;
update t2 set a=70000011;
update t2 set a=1000000000;
update t2 set a=1000000001;
update t2 set a=1000000002;
update t2 set a=1000000003;
update t2 set a=1000000004;
update t2 set a=1000000005;
update t2 set a=200000005;
update t2 set a=300000005;
update t2 set a=400000005;
update t2 set a=50000005;
update t2 set a=60000005;
update t2 set a=70000005;
update t2 set a=70000006;
update t2 set a=70000007;
update t2 set a=70000008;
update t2 set a=70000009;
update t2 set a=70000010;
update t2 set a=70000011;
