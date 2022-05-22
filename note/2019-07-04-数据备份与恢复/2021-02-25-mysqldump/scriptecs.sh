#!/bin/bash
DATE=`date +%Y%m%d_%H%M%S`
BAK_PATH=/home/backup/
Password=123456abc


/usr/local/mysql/bin/mysqldump -h101.37.253.14 -uroot -p${Password} --single-transaction --master-data=2 -R -E -B  archery |gzip  >  ${BAK_PATH}archery${DATE}.dump.gz

