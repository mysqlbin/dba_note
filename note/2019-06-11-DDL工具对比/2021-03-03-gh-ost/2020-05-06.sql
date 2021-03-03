

*/1 * * * * /usr/bin/python /root/python_coding/ddl_time_insert_data_py2.py
*/2 * * * * /usr/bin/python /root/python_coding/ddl_time_insert_data_py2.py
*/3 * * * * /usr/bin/python /root/python_coding/ddl_time_insert_data_py2.py


show global variables like '%sync_binlog%';
show global variables like '%innodb_flush_log_at_trx_commit%';

set global sync_binlog=1;
set global innodb_flush_log_at_trx_commit=1;
[root@kp04 python_coding]# time python ddl_time_insert_data_py2.py 

real	2m29.259s
user	0m1.667s
sys	0m1.213s

mysqldump -uroot -p123456abc --set-gtid-purged=off --single-transaction --master-data=2 -B sbtest --tables sbtest1 >  sbtest1.sql


从库:
	set global sync_binlog=10000;
	set global innodb_flush_log_at_trx_commit=2;


