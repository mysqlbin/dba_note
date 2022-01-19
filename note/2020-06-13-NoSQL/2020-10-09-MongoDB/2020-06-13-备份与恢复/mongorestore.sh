#!/bin/bash

# mongorestore命令
LOAD=/usr/local/mongodb/bin/mongorestore

# 备份的路径
BAK_PATH=/data/backup/niuniu_h520220118/niuniu_h5

# IP地址
HOST_NAME="192.168.1.11:27017"

# 用户名
DB_USER="admin"

# 密码
DB_PASS="admin"

# 恢复数据到哪个数据库中
BAK_DBNAME="niuniu_h5"

$LOAD --host $HOST_NAME  -u $DB_USER -p $DB_PASS --authenticationDatabase "admin" -d $BAK_DBNAME --gzip --dir=$BAK_PATH 

