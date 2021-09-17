#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import sys

ip = sys.argv[1]
c=0
for i in range(1,4,1):
    return1=os.popen('ping %s -w 1' %ip).read()
    if  '100% packet loss' in return1  :
        c += 1
if c>2:
os.popen('service keepalived stop')




"""
定时任务如下：
Shell>crontab –e
* * * * * /root/ping.py 192.168.137.1
"""