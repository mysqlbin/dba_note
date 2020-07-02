#!/usr/bin/ptyhon
#coding=utf-8

"""
https://www.pythonheidong.com/blog/article/142585/  如何在pymongo中使用isodate进行查询
https://www.v2ex.com/amp/t/407072   pymongo 查询日期的困惑
    datetime.datetime(2017,10,21,11,0,0)不会自动减 8 小时，而是直接存入 mongodb 中变成了 utc 时间。在网上查询了很多资料，在查询时，datetime 会自动转化为 utc 时间进行查询，所以我做了一个测试

python mongodb_old_data_delete_many.py -soD=niuniu_h5 -soT=t1 -beforeDay=-45

"""

import sys
reload(sys)
sys.setdefaultencoding( "utf-8" )

import smtplib
from email.mime.text import MIMEText

import pymongo
from pymongo import MongoClient
import datetime
import logging
import traceback
import time
import argparse


logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s',
                    filename='monitor_mongodb_archive_info.log',
                    filemode='a')

logger = logging.getLogger(__name__)


def parse_args():

   parser = argparse.ArgumentParser()
   parser.add_argument('-soD', '--source-database', dest='source_database', help='source database', type=str)
   parser.add_argument('-soT', '--source-table', dest='source_table', help='source table', type=str)
   parser.add_argument('-beforeDay', '--before-data', dest='before_day', help='before day', type=int)
   return parser


def command_line_args(args):
    parser = parse_args()
    args = parser.parse_args(args)
    return args


def send_mail(body, sourceTable, format = 'plain'):
    host = 'smtp.163.com'
    port = 465
    sender = '13202095158@163.com'
    pwd = ''
    receiver = ['13202095158@163.com', '1224056230@qq.com']
    body = body
    msg = MIMEText(body, format, 'utf-8')
    msg['subject'] = '{} Info: MongoDB data archiver monitor'.format(sourceTable)
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

if __name__ == '__main__':

    args = command_line_args(sys.argv[1:])
    source_database = args.source_database
    source_table = args.source_table
    before_day = args.before_day

    if before_day > -10:
        logger.error('The date format does not match . exit')
        exit()

    before_datetime = time.strftime("%Y-%m-%d")
    before_datetime = datetime.datetime.strptime(before_datetime, '%Y-%m-%d') + datetime.timedelta(days=before_day)
    utcDatetime = before_datetime + datetime.timedelta(hours=-0)

    result = {'status': 1, 'msg': 'ok', 'delete_count': ''}

    try:

        # 连接副本集
        #client = MongoClient(['192.168.0.1:27017', '192.168.0.2:27017'], replicaSet='repl_set')
        mongoserver_uri = "mongodb://admin:admin123456@192.168.0.1:192.168.0.2.227:27017/admin?replicaSet=repl_set"
        client = MongoClient(mongoserver_uri)
        db = client['niuniu_h5']
        collection = db['t1']

        myquery = {'CreateTime': {'$lt': datetime.datetime(utcDatetime.year,utcDatetime.month,utcDatetime.day,utcDatetime.hour,utcDatetime.minute,utcDatetime.second)}}

        # myquery = {'tEndTime': {'$lt': before_datetime}}  因为这里是字符串类型，所以在MongoDB比较不了。

        #myquery = {'$and': [{'CreateTime': {'$lt': datetime.datetime(utcDatetime.year, utcDatetime.month, utcDatetime.day, utcDatetime.hour,utcDatetime.minute, utcDatetime.second)}}, {'tEndTime': {'$lt': before_datetime}} ] })

        try:

            res = collection.delete_many(myquery)

            result['delete_count'] = res.deleted_count

            logger.info("Record delete - counts: %s" % str(res.deleted_count))

        except pymongo.errors.ConnectionFailure as e:

            logger.error("ConnectionFailure seen: %s" % str(e))
            logger.info("Retrying...")


    except Exception as e:

        result['status'] = 0
        result['msg'] = str(e)

        logger.error("连接失败\n{}".format(traceback.format_exc()))
        raise RuntimeError('连接失败，失败原因:%s' % str(e))

    finally:
        client.close()

    send_mail(str(result), source_table)
