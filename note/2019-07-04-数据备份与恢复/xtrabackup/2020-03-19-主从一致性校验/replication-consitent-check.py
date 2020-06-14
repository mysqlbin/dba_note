#!/usr/bin/env python
# -*- coding: UTF-8 -*-
#脚本需要和 pt-table-checksum一起使用
#通过监控pt-table-checksum生产的checksums表来确认表是否一致
#脚本要在主库执行

# import smtplib
# from email.mime.text import MIMEText
import time,datetime
import os,sys
import MySQLdb as mdb
# from dingtalkchatbot.chatbot import DingtalkChatbot


# webhook = 'https://oapi.dingtalk.com/robot/send?access_token=1f077306f882465984c4d9932afca61d6b85310093cda55bd14993a84f50446b'
# xiaoding = DingtalkChatbot(webhook)


def check_info(nowtime):
    try:
        #这里要连接从库
        con = mdb.connect(host='192.168.1.29',user='root',passwd='123456abc',db='consistency_db',port=3306)
        cur = con.cursor()
        sql = "select * from checksums where this_crc not in (select master_crc from checksums) and ts > '%s' " %nowtime
        cur.execute(sql)
        res = cur.fetchall()
        con.close()
        return res
    except Exception,e:
        print e


if __name__ == "__main__":

    nowtime = time.strftime('%Y-%m-%d %X', time.localtime())
    #这里是连接主库
    cmd = "pt-table-checksum --nocheck-replication-filters --no-check-binlog-format --replicate=consistency_db.checksums h=192.168.1.27,u=root,p=123456abc,P=3306"
    os.system(cmd)
    result = check_info(nowtime)
    if result:
        for m in result:
            database = m[0]
            table =  m[1]
            print database + ' ' +table

    #
    # if result:
    #     for m in result:
    #         database = m[0]
    #         table =  m[1]
    #     xiaoding.send_markdown(
    #         title='主从数据一致性检验',
    #         text=str('主从数据不一致性报告列表') + '\n'
    #             '> 库名 ' + database + '\n'
    #             '> 表名 ' + table + ' \n',
    #         is_at_all=True
    #     )
    # else:
    #     xiaoding.send_markdown(
    #         title='主从数据一致性检验',
    #         text=str('主从数据一致性检验报告') + '\n'
    #                 '> 目前没有检测到数据不一致 \n',
    #         is_at_all=True
    #     )
