#!/usr/bin/env python
#-*- coding:utf-8 -*-

import sys
import MySQLdb
import time
import hashlib
import random

# db_connect = MySQLdb.connect(
#     host='192.168.0.54',
#     user='root',
#     passwd='123456abc',
#     db='test_db',
#     port=3306,
#     charset='utf8mb4'
# )
#

db_connect = MySQLdb.connect(
    host='192.168.0.91',
    user='app_user',
    passwd='123456abc',
    db='sbtest',
    port=3306,
    charset='utf8mb4'
)

cur_write = db_connect.cursor()

for val in range(1,8001):

    current_datetime = time.strftime("%Y-%m-%d %H:%M:%S")

    hash = hashlib.md5(current_datetime.encode('utf-8'))

    random_k = random.randint(10001, 50000)
    random_pad = random.randint(50000, 99999)

    hash_random_k  = hashlib.md5(str(random_k).encode('utf-8'))
    val_c = hash_random_k.hexdigest()
    val_c = str(random_k) + '-' + val_c + '-' + str(random_pad)

    hash_random_pad = hashlib.md5(str(random_pad).encode('utf-8'))
    val_pad = hash_random_pad.hexdigest()
    val_pad = str(random_pad) + '-' + val_pad + '-' + str(random_k)

    insert_sql = 'INSERT INTO sbtest1(k, c, pad) VALUES( %s, "%s", "%s")' % (
        random_k, val_c, val_pad)

    # print(insert_sql)
    cur_write.execute(insert_sql)
    db_connect.commit()