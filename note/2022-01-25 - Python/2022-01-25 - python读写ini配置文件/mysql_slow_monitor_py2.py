#!/usr/bin/env python
#-*- coding:utf-8 -*-

import sys
import MySQLdb
reload(sys)

import smtplib
from email.mime.text import MIMEText

sys.setdefaultencoding('utf-8')

import ConfigParser
import os
curpath=os.path.dirname(os.path.realpath(__file__))
configpath = os.path.join(curpath, "config.ini")
config = ConfigParser.ConfigParser()
config.read(configpath)

def send_mail(body, format = 'plain'):

    host = config.get("Email", "host")
    port = config.get("Email", "port")
    sender = config.get("Email", "sender")
    pwd = config.get("Email", "pwd")
    receiver = config.get("Email", "receiver")
    receiver = receiver.strip(',').split(',')

    body = body
    msg = MIMEText(body, format, 'utf-8')
    msg['subject'] = 'Info: test slow log'
    msg['from'] = sender
    msg['to'] = ",".join(receiver)
	
    try:
        s = smtplib.SMTP_SSL(host, port)
        s.login(sender, pwd)
        s.sendmail(sender, receiver, msg.as_string())
        print('Done.sent email success')
    except smtplib.SMTPException as e:
        print(e)
        print('Error.sent email fail')


db_connect = MySQLdb.connect(
    host='192.168.0.252',
    user='root',
    passwd='',
    db='audit_db',
    port=3306,
    charset='utf8mb4'
)

cur_write = db_connect.cursor()
cur_write.execute("select concat(concat('checksum： ', checksum), '， ', concat('fingerprint：', left(fingerprint, 50))) as checksum_fingerprint  from consistency_db.mysql_slow_query_review  where UNIX_TIMESTAMP(now())-UNIX_TIMESTAMP(last_seen) < 4260 limit 1;")
res = cur_write.fetchone()
cur_write.close()
db_connect.close()

if res:

    checksum_fingerprint    = res[0]
    body = '<h1>慢查询日志的checksum和fingerprint如下</h1>  \
           <p>%s </p> ' % \
             (checksum_fingerprint)
	
    send_mail(body, 'html')
