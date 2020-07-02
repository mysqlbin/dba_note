#!/usr/bin/ptyhon
#coding=utf-8

"""
https://www.pythonheidong.com/blog/article/142585/  如何在pymongo中使用isodate进行查询

https://www.v2ex.com/amp/t/407072   pymongo 查询日期的困惑

"""

import pymongo
from pymongo import MongoClient
import datetime
import logging
import traceback
import time

logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s',
                    filename='monitor_mongodb_crash.log',
                    filemode='a')

logger = logging.getLogger(__name__)

before_datetime = time.strftime("%Y-%m-%d")
before_day = -30
before_datetime = datetime.datetime.strptime(before_datetime, '%Y-%m-%d') + datetime.timedelta(days=before_day)
before_datetime_hours = before_datetime + datetime.timedelta(hours=-8)


"""
import datetime
import time
before_datetime = time.strftime("%Y-%m-%d")
before_day = -30
before_datetime = datetime.datetime.strptime(before_datetime, '%Y-%m-%d') + datetime.timedelta(days=before_day)
utcDatetime = before_datetime + datetime.timedelta(hours=-8)

import datetime
import time
import pymongo
from pymongo import MongoClient
mongoserver_uri = "mongodb://admin:admin@192.168.0.242:27017,192.168.0.252:27017/admin?replicaSet=repl_set"
client = MongoClient(mongoserver_uri)
db = client['yldb']
collection = db['table_clubgamelog']
before_datetime='2020-07-01 15:12:33'
myquery = {'$and': [ {'CreateTime': {'$lt': datetime.datetime(2020,07,02,04,00,00)}},  {'tEndTime': {'$lt': before_datetime }} ] }
res = collection.delete_many(myquery)
print(res)


print(list(collection.find(myquery)))


import datetime
#取当前时间
print(datetime.datetime.now())
#取年
print(datetime.datetime.now().year)
#取月
print(datetime.datetime.now().month)
#取日
print(datetime.datetime.now().day)
#取时
print(datetime.datetime.now().hour)
#取分
print(datetime.datetime.now().minute)
#取秒
print(datetime.datetime.now().second)


import datetime
import time
before_datetime = time.strftime("%Y-%m-%d")
before_day = -30
before_datetime = datetime.datetime.strptime(before_datetime, '%Y-%m-%d') + datetime.timedelta(days=before_day)
before_datetime_hours = before_datetime + datetime.timedelta(hours=-8)
print(before_datetime_hours.year)
print(before_datetime_hours.month)
print(before_datetime_hours.day)
print(before_datetime_hours.hour)
print(before_datetime_hours.minute)
print(before_datetime_hours.second)


"""

try:

    # 连接副本集
    #client = MongoClient(['192.168.0.1:27017', '192.168.0.2:27017'], replicaSet='repl_set')
    mongoserver_uri = "mongodb://admin:admin123456@10.31.76.149:27017,10.31.76.227:27017/admin?replicaSet=repl_set"
    client = MongoClient(mongoserver_uri)
    db = client['niuniu_h5']
    collection = db['t1']
    # myquery = {'$and': [ {'CreateTime': {'$lt': ISODate(before_datetime_hours)}},  {'tEndTime': {'$lt': '2020-05-07 00:00:00' }} ] }
    # myquery = {'$and': [{'tEndTime': {'$lt': '2020-05-07 00:00:00'}}]}
    myquery = {'CreateTime': {'$lt': datetime.datetime(utcDatetime.year,utcDatetime.month,utcDatetime.day,utcDatetime.hour,utcDatetime.minute,utcDatetime.second)}}

    try:

        res = collection.delete_many(myquery)
            
        logger.info("Record delete - counts: %s" % str(res))

    except pymongo.errors.ConnectionFailure as e:

        logger.error("ConnectionFailure seen: %s" % str(e))
        logger.info("Retrying...")


except Exception as e:
    logger.error("连接失败\n{}".format(traceback.format_exc()))
    raise RuntimeError('连接失败，失败原因:%s' % str(e))

finally:
    client.close()


