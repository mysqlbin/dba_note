#!/bin/bash

#date=`date "+%Y-%m-%d %H:%M:%S"`

start_date=`date -d "-1 day" +%Y-%m-%d`
start_datetime="${start_date} 00:00:00"

stop_date=`date "+%Y-%m-%d"`
stop_datetime="${stop_date} 06:00:00"

current_date=`date "+%Y-%m-%d"`
back_path="/data/backup/${current_date}.sql"

binlog_name=`ls mysql-bin*`
mark="'"
			
/usr/local/mysql/bin/mysqlbinlog -v --base64-output=decode-rows --start-datetime=${mark}${start_datetime}${mark} --stop-datetime=${mark}${stop_datetime}${mark} mysql-bin.000024 > ${back_path};


 





