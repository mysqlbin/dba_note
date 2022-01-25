#!/usr/bin/env python
#-*- coding:utf-8 -*-

import ConfigParser
import os
curpath=os.path.dirname(os.path.realpath(__file__))
configpath = os.path.join(curpath, "config.ini")
config = ConfigParser.ConfigParser()
config.read(configpath)

'''
host = 'smtp.163.com'
port = 465
sender = '13202095158@163.com'
pwd = '20190809Go'
receiver = ['13202095158@163.com', '1224056230@qq.com']
'''
    
host = config.get("Email", "host")
port = config.get("Email", "port")
sender = config.get("Email", "sender")
pwd = config.get("Email", "pwd")
receiver = config.get("Email", "receiver")
receiver = receiver.strip(',').split(',')


'''
.ini 文件的内容，不要写字符串，类似于：host='xxx'，直接这样写：host=xxx
'''