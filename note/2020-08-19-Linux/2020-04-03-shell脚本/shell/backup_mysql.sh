#!/bin/bash
#######################
# Name: backup_mysql.sh
# Description: backup mysql db
# Author: Bin
# Version:0.0.1
# Datatime: 2018-04-18 15:56:38
# Usage: backup_mysql.sh
#######################
HOST="127.0.0.1"
SQL_PATH="/data/backup/"
DATE=$(date +%F-%H%M)
USER="backup"
PASSWD="123456abc"
LOG_FILE="/tmp/$0.log"
DB_NAME=(
channels_a
channels_b
load_db
load_db
monitor_db
procedure
)

echo start-`date` >> $LOG_FILE

for ((i=0; i<${#DB_NAME[*]}; i++))
#do
	#/usr/local/mysql/bin/mysqldump -h ${HOST} -u ${USER} -p${PASSWD} --master-data=2 --single-transaction -B ${DB_NAME[$i]} -R --triggers --events > ${SQL_PATH}${DB_NAME[$i]}_${DATE}.sql
#done
do
TAR_FILE="${DB_NAME[$i]}-${DATE}.tgz"
SQL_FILE="${DB_NAME[$i]}-${DATE}.sql"
/usr/local/mysql/bin/mysqldump -u${USER} -p${PASSWD} --single-transaction --master-data=2 -B ${DB_NAME[$i]} -R --triggers --events > ${SQL_PATH}${SQL_FILE} && cd ${SQL_PATH} && tar zcf ${SQL_PATH}${TAR_FILE} ${SQL_FILE} && rm -f ${SQL_FILE} 
done

echo end-`date` >> $LOG_FILE
