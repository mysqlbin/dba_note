


mysql5.5版本的mysqlbinlog识别不了5.7的binlog
	[root@soft ~]# mysqlbinlog -vv --base64-output='decode-rows' --stop-position=376430828 /mydata/mysql/mysql3306/logs/mysql-bin.000245 > 245.sql
	ERROR: Error in Log_event::read_log_event(): 'Sanity check failed', data_len: 31, event_type: 35


	[root@soft ~]# mysqlbinlog --version
	mysqlbinlog Ver 3.3 for Linux at x86_64
	[root@soft ~]# pwd
	/root
	[root@soft ~]# which mysqlbinlog
	/usr/local/mysql-5.5.57/bin/mysqlbinlog




[root@soft ~]# /usr/local/mysql/bin/mysqlbinlog --version
/usr/local/mysql/bin/mysqlbinlog Ver 3.4 for linux-glibc2.12 at x86_64

