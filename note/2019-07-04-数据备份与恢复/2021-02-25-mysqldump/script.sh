#!/bin/bash
DATE=`date +%Y%m%d_%H%M%S`
BAK_PATH=/home/coding001/backup/
Password=123456abc


/usr/bin/mysqldump -uroot -p${Password} --single-transaction --master-data=2 -R -E -B  db_name |gzip  >  ${BAK_PATH}db_name${DATE}.dump.gz
/usr/bin/mysqldump -uroot -p${Password} --single-transaction --master-data=2 --set-gtid-purged=OFF -B db_name --tables table_name1 table_name2 |gzip  >  ${BAK_PATH}db_name_db_2tables_${DATE}.dump.gz

/usr/bin/find ${BAK_PATH} -type f -mtime +30|xargs rm -f > /dev/null
