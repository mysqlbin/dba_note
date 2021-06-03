#!/usr/bin/env python
#-*- coding:utf-8 -*-


import os
import MySQLdb
import time,datetime
import re

"""
./sysbench --mysql-host= --mysql-port=3306 --mysql-user= --mysql-password= --test=tests/db/oltp.lua --oltp_tables_count=20 --oltp-table-size=1000000 --rand-init=on prepare


./sysbench --mysql-host= --mysql-port=3306 --mysql-user= \
--mysql-password= --test=tests/db/oltp.lua --oltp_tables_count=10 \
--oltp-table-size=1000000 --num-threads=10 --oltp-read-only=off \
--report-interval=10 --rand-type=uniform --max-time=1800 \
 --max-requests=0 --percentile=99 run >> /home/dba2/log/sysbench_oltpX_10-201910151037.log

"""
conn = MySQLdb.connect(host='', port=3306, user='root', passwd='', charset='utf8mb4')
cursor = conn.cursor()

def sql_value(status):
    sql_global_status = "show global status like '{}'".format(status)
    cursor.execute(sql_global_status)
    data = cursor.fetchone()
    return data[1]


while 1==1:
    start_time = datetime.datetime.now()
    c_c1 = sql_value('Com_commit')
    c_r1 = sql_value('Com_rollback')
    t1 = sql_value('Uptime')
    begin_trx_count = int(int(c_c1) + int(c_r1))

    time.sleep(10)

    c_c2 = sql_value('Com_commit')
    c_r2 = sql_value('Com_rollback')
    t2 = sql_value('Uptime')

    end_trx_count = int(int(c_c2) + int(c_r2))

    end_time = datetime.datetime.now()

    tps = int((int(end_trx_count) - int(begin_trx_count))) / int((int(t2) - int(t1)))

    print 'TPS={}, start_time={}, end_time={}'.format(tps, start_time, end_time)



    """
    TPS=269, start_time=2019-10-15 10:44:56.743082, end_time=2019-10-15 10:45:06.750633
    TPS=267, start_time=2019-10-15 10:45:06.750731, end_time=2019-10-15 10:45:16.765801
    TPS=378, start_time=2019-10-15 10:45:16.765866, end_time=2019-10-15 10:45:26.781695
    TPS=407, start_time=2019-10-15 10:45:26.781771, end_time=2019-10-15 10:45:36.796628
    TPS=324, start_time=2019-10-15 10:45:36.796700, end_time=2019-10-15 10:45:46.803073
    TPS=415, start_time=2019-10-15 10:45:46.803139, end_time=2019-10-15 10:45:56.819515
    TPS=415, start_time=2019-10-15 10:45:56.819579, end_time=2019-10-15 10:46:06.837239
    TPS=385, start_time=2019-10-15 10:46:06.837301, end_time=2019-10-15 10:46:16.852784
    TPS=391, start_time=2019-10-15 10:46:16.852840, end_time=2019-10-15 10:46:26.869193
    TPS=423, start_time=2019-10-15 10:46:26.869263, end_time=2019-10-15 10:46:36.885910
    TPS=416, start_time=2019-10-15 10:46:36.885980, end_time=2019-10-15 10:46:46.904315
    TPS=430, start_time=2019-10-15 10:46:46.904384, end_time=2019-10-15 10:46:56.913838
    TPS=409, start_time=2019-10-15 10:46:56.913906, end_time=2019-10-15 10:47:06.929658
    TPS=371, start_time=2019-10-15 10:47:06.929723, end_time=2019-10-15 10:47:16.945972
    TPS=424, start_time=2019-10-15 10:47:16.946042, end_time=2019-10-15 10:47:26.960799
    TPS=388, start_time=2019-10-15 10:47:26.960848, end_time=2019-10-15 10:47:36.976696
    TPS=378, start_time=2019-10-15 10:47:36.976765, end_time=2019-10-15 10:47:46.993974
    TPS=403, start_time=2019-10-15 10:47:46.994042, end_time=2019-10-15 10:47:57.010936
    TPS=404, start_time=2019-10-15 10:47:57.011003, end_time=2019-10-15 10:48:07.028656
    TPS=384, start_time=2019-10-15 10:48:07.028718, end_time=2019-10-15 10:48:17.045834

    """



