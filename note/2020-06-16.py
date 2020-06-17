#!/usr/bin/ptyhon
#coding=utf-8

"""
类的初始化
"""

import pymongo
from pymongo import MongoClient
import datetime

# 连接副本集
client = MongoClient(['10.31.76.149:27017', '10.31.76.227:27017'])
db = client['test']
collection = db['test']

i = 0
while True:
    doc = {"idx": i, "date": datetime.utcnow()}
    i += 1
    collection.insert_one(doc)
    
'''
mongoserver_uri = "mongodb://{0}:{1}@{2}:{3}/admin".format(
                    username, password, host, port)

pymongo.MongoClient(host=mongoserver_uri, ssl=True,
                                  ssl_cert_reqs=ssl.CERT_NONE,
                                  replicaset='repl_set')
'''
