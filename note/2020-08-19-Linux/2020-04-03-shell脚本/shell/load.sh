#!/bin/bash

date=`date "+%Y-%m-%d %H:%M:%S"`
/usr/bin/top -bc -n 2 > /opt/shell/system.txt
cpu=`LANG=C cat /opt/shell/system.txt | grep Cpu | sed -n '2p' | cut -d: -f2 | cut -du -f1`
free=`free -m |grep Mem |awk -F ' ' '{print $4}'`
disk=`df -h |grep /dev/mapper/centos-data |awk -F ' ' '{print $5}' |cut -d "%" -f 1`
aa=`LANG=C cat /opt/shell/system.txt | grep 'load average' | sed -n '2p' | cut -d: -f5`
tasks=`LANG=C cat /opt/shell/system.txt | grep  -oP  "(?<=Tasks:\s)\d{1,}(?=\stotal)"  | sed -n '2p'`
if [ "$aa"x == ""x ]
then
    load1=`LANG=C cat /opt/shell/system.txt | grep 'load average' | sed -n '2p' | cut -d: -f4 | cut -d, -f1`
    load5=`LANG=C cat /opt/shell/system.txt | grep 'load average' | sed -n '2p' | cut -d: -f4 | cut -d, -f2`
    load15=`LANG=C cat /opt/shell/system.txt | grep 'load average' | sed -n '2p' | cut -d: -f4 | cut -d, -f3`
else
    load1=`LANG=C cat /opt/shell/system.txt | grep 'load average' | sed -n '2p' | cut -d: -f5 | cut -d, -f1`
    load5=`LANG=C cat /opt/shell/system.txt | grep 'load average' | sed -n '2p' | cut -d: -f5 | cut -d, -f2`
    load15=`LANG=C cat /opt/shell/system.txt| grep 'load average' | sed -n '2p' | cut -d: -f5 | cut -d, -f3`
fi
host=192.168.0.12
H=192.168.0.12
MySQL=/usr/local/mysql/bin/mysql
$MySQL -uprocedure -p123456abc -h$H  -e "insert into load_db.serversys(data_time,hostip,cpu,free,disk,load1,load5,load15,tasks) VALUES (\"$date\",\"$host\",trim(\"$cpu\"),trim(\"$free\"),trim(\"$disk\"),\"$load1\",\"$load5\",\"$load15\",\"$tasks\");"
