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
    q1 = sql_value('Questions')
    t1 = sql_value('Uptime')

    time.sleep(10)

    q2 = sql_value('Questions')
    t2 = sql_value('Uptime')

    end_time = datetime.datetime.now()

    qps = int((int(q2) - int(q1))) / int((int(t2) - int(t1)))

    print 'qps={}, start_time={}, end_time={}'.format(qps, start_time, end_time)



    """
    qps=7078, start_time=2019-10-15 11:18:40.266534, end_time=2019-10-15 11:18:50.281690
    qps=6616, start_time=2019-10-15 11:18:50.281819, end_time=2019-10-15 11:19:00.296845
    qps=6212, start_time=2019-10-15 11:19:00.296937, end_time=2019-10-15 11:19:10.312380
    qps=7201, start_time=2019-10-15 11:19:10.312458, end_time=2019-10-15 11:19:20.327243
    qps=5920, start_time=2019-10-15 11:19:20.327321, end_time=2019-10-15 11:19:30.341683
    qps=4758, start_time=2019-10-15 11:19:30.341757, end_time=2019-10-15 11:19:40.355963
    qps=7334, start_time=2019-10-15 11:19:40.356045, end_time=2019-10-15 11:19:50.370664
    qps=7080, start_time=2019-10-15 11:19:50.370742, end_time=2019-10-15 11:20:00.385519
    qps=7499, start_time=2019-10-15 11:20:00.385596, end_time=2019-10-15 11:20:10.402004
    qps=6337, start_time=2019-10-15 11:20:10.402077, end_time=2019-10-15 11:20:20.417050
    qps=6958, start_time=2019-10-15 11:20:20.417128, end_time=2019-10-15 11:20:30.431852
    qps=7586, start_time=2019-10-15 11:20:30.431942, end_time=2019-10-15 11:20:40.447571
    qps=7355, start_time=2019-10-15 11:20:40.447646, end_time=2019-10-15 11:20:50.459862
    qps=7488, start_time=2019-10-15 11:20:50.459940, end_time=2019-10-15 11:21:00.474600
    qps=7755, start_time=2019-10-15 11:21:00.474694, end_time=2019-10-15 11:21:10.489012
    qps=7714, start_time=2019-10-15 11:21:10.489081, end_time=2019-10-15 11:21:20.506269
    qps=6904, start_time=2019-10-15 11:21:20.506343, end_time=2019-10-15 11:21:30.519921
    qps=8255, start_time=2019-10-15 11:21:30.519984, end_time=2019-10-15 11:21:40.533662
    qps=7815, start_time=2019-10-15 11:21:40.533719, end_time=2019-10-15 11:21:50.547913
    qps=9222, start_time=2019-10-15 11:21:50.548001, end_time=2019-10-15 11:22:00.563952
    qps=7578, start_time=2019-10-15 11:22:00.564040, end_time=2019-10-15 11:22:10.579121
    qps=7922, start_time=2019-10-15 11:22:10.579194, end_time=2019-10-15 11:22:20.583680
    qps=7335, start_time=2019-10-15 11:22:20.583734, end_time=2019-10-15 11:22:30.598277

    """



