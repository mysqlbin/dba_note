#!/bin/bash

LOAD=/usr/local/mongodb/bin/mongorestore

BAK_PATH=/home/coding001/backup/mongodb/niuniu_h520210510/abc_h5

DATE=`date +%Y%m%d`

HOST_NAME="192.168.1.11:27017"

DB_USER="admin"

DB_PASS="admin"

BAK_DBNAME="abc_h5"

$LOAD --host $HOST_NAME  -u $DB_USER -p $DB_PASS --authenticationDatabase "admin" -d $BAK_DBNAME --gzip --dir=$BAK_PATH 

