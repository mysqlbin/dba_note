#!/bin/bash

DUMP=/usr/local/mongodb/bin/mongodump

BAK_PATH=/home/backup_mongodb/

DATE=`date +%Y%m%d`

DB_USER="admin"

DB_PASS="admin"

BAK_DBNAME="test_db"


# 最终保存的数据库备份文件
TAR_BAK="${BAK_DBNAME}${DATE}.tar.gz"


$DUMP  --host "192.168.0.1:27017"  -u $DB_USER -p $DB_PASS --authenticationDatabase "admin"  -d $BAK_DBNAME  --gzip  --out ${BAK_PATH}${BAK_DBNAME}${DATE}


/usr/bin/find ${BAK_PATH}  -mtime +3|xargs rm -rf > /dev/null




/usr/bin/tar -zcvf ${BAK_PATH}${TAR_BAK} ${BAK_PATH}${BAK_DBNAME}${DATE}
