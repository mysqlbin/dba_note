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
before_day = -40
before_datetime = datetime.datetime.strptime(before_datetime, '%Y-%m-%d') + datetime.timedelta(days=before_day)
print(before_datetime)
utcDatetime = before_datetime + datetime.timedelta(hours=-0)
print(utcDatetime)

import datetime
import time
import pymongo
from pymongo import MongoClient
mongoserver_uri = "mongodb://admin:admin123456@127.0.0.1:27017,127.0.0.1:27017/admin?replicaSet=repl_set"
client = MongoClient(mongoserver_uri)
db = client['niuniu_h5']
collection = db['t11']
utcDatetime=datetime.datetime.now()
myquery = {'CreateTime': {'$lt': datetime.datetime(utcDatetime.year,utcDatetime.month,utcDatetime.day,utcDatetime.hour,utcDatetime.minute,utcDatetime.second)}}
res = collection.delete_many(myquery)
print(res.deleted_count, "个文档已删除")


import datetime
utcDatetime=datetime.datetime.now()
print(utcDatetime.year)

utcDatetime='2020-05-10 00:00:01'

print(datetime.datetime(utcDatetime.year,utcDatetime.month,utcDatetime.day,utcDatetime.hour,utcDatetime.minute,utcDatetime.second))

db.table_clubgamelog.find({'CreateTime': {'$lt': ISODate('2020-07-01 15:12:33')}})




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
    mongoserver_uri = "mongodb://admin:admin123456@192.168.0.1:27017,192.168.0.2:27017/admin?replicaSet=repl_set"
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


