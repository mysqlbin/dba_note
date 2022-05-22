#!/bin/bash
DATE=`date +%Y%m%d_%H%M%S`
BAK_PATH=/home/coding001/backup/
Password=123456abc


/usr/bin/mysqldump -uroot -p${Password} --single-transaction --master-data=2 -R -E -B  archery |gzip  >  ${BAK_PATH}archery${DATE}.dump.gz

/usr/bin/find ${BAK_PATH} -type f -mtime +30|xargs rm -f > /dev/null
