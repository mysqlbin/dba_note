#!/usr/bin/ptyhon
#coding=utf-8

"""
https://www.pythonheidong.com/blog/article/303143/
https://mp.weixin.qq.com/s/wZJWTOhC_lll8_Ivp9259A
https://mp.weixin.qq.com/s/JD7IOxZ4yZpzrC3cEjHX5Q PyMongo + Mongo 连接 “哎” 到底怎么连

"""

import pymongo
from pymongo import MongoClient
import datetime
import logging
import traceback

logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s',
                    filename='monitor_mongodb_crash.log',
                    filemode='a')

logger = logging.getLogger(__name__)

try:

    # 连接副本集
    #client = MongoClient(['192.168.0.1:27017', '192.168.0.2:27017'], replicaSet='repl_set')
    mongoserver_uri = "mongodb://test_user:abc123456@192.168.0.1:27017,192.168.0.2:27017/admin?replicaSet=repl_set"
    client = MongoClient(mongoserver_uri)
    db = client['test']
    collection = db['test']
    i = 0
    while True:
        try:
            doc = {"idx": i, "date": datetime.datetime.now()}
            i += 1
            id = collection.insert_one(doc).inserted_id
            logger.info("Record inserted - id: %s" % str(id))
        except pymongo.errors.ConnectionFailure as e:

            logger.error("ConnectionFailure seen: %s" % str(e))
            logger.info("Retrying...")

    logger.info("Done...")
    
except Exception as e:
    logger.error("连接失败\n{}".format(traceback.format_exc()))
    raise RuntimeError('连接失败，失败原因:%s' % str(e))

finally:
    client.close()


'''
mongoserver_uri = "mongodb://{0}:{1}@{2}:{3}/admin".format(
                    username, password, host, port)

pymongo.MongoClient(host=mongoserver_uri, replicaset='repl_set')


mongoserver_uri = "mongodb://{0}:{1}@{2}:{3}/admin".format(
                    username, password, host, port)
 
#当数据库有密码的时候

url = 'mongodb://username:password@host:port/'
#默认进入admin


test_usr
test123456 
 
import datetime
from pymongo import MongoClient                 
mongoserver_uri = "mongodb://test_user:test123456@192.168.0.1:27017,192.168.0.2:27017/admin?replicaSet=repl_set"   
client = MongoClient(mongoserver_uri) 
db = client['test']
collection = db['abc']
doc = {"idx": 1, "date": datetime.datetime.now()}
collection.insert_one(doc)  
<pymongo.results.InsertOneResult object at 0x2a600e0>

mongo -host 192.168.0.1 -u admin -p admin123456
    
    use test
    db.abc.find()
    repl_set:PRIMARY> use test
    switched to db test
    repl_set:PRIMARY> db.abc.find()
    { "_id" : ObjectId("5ee9d5a54019100ef591f11e"), "date" : ISODate("2020-06-17T16:34:36.219Z"), "idx" : 1 }
     
mongo -host 192.168.0.2 -u admin -p admin123456
    rs.slaveOk();
    use test
    db.abc.find()
    repl_set:SECONDARY> use test
    switched to db test
    repl_set:SECONDARY> db.abc.find()
    { "_id" : ObjectId("5ee9d5a54019100ef591f11e"), "date" : ISODate("2020-06-17T16:34:36.219Z"), "idx" : 1 }

当密码错误  
    import datetime
    from pymongo import MongoClient                 
    mongoserver_uri = "mongodb://test_user:test123s456@192.168.0.1:27017,192.168.0.2:27017/admin?replicaSet=repl_set"   
    client = MongoClient(mongoserver_uri) 
    db = client['test']
    collection = db['abc']
    doc = {"idx": 1, "date": datetime.datetime.now()}
    collection.insert_one(doc)  
        pymongo.errors.OperationFailure: Authentication failed.
    
          
'''
