#!/usr/bin/python#coding=utf-8

import sys
reload(sys)
sys.setdefaultencoding( "utf-8" )

import smtplib
from email.mime.text import MIMEText

import re
import logging
import traceback
import os
import subprocess
import datetime
import time

logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s',
                    filename='mongodb_alive_monitor.log',
                    filemode='a')

logger = logging.getLogger(__name__)

# logger = logging.getLogger('default')


def send_mail(body, format = 'plain'):

    host = 'smtp.163.com'
    port = 465
    sender = '13202095158@163.com'
    pwd = '.........'
    receiver = ['13202095158@163.com', '1224056230@qq.com']
    body = body
    msg = MIMEText(body, format, 'utf-8')
    msg['subject'] = 'Info: ntf MongoDB is done...'
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




def execute_cmd(cmd_args, shell):
    """
    执行命令并且返回process
    :return:
    """
    try:
        p = subprocess.Popen(cmd_args,
                             shell=shell,
                             stdout=subprocess.PIPE,
                             stderr=subprocess.PIPE,
                             universal_newlines=True)
        return p
    except Exception as e:
        logger.error("命令执行失败\n{}".format(traceback.format_exc()))
        raise RuntimeError('命令执行失败，失败原因:%s' % str(e))




if __name__ == '__main__':

    result = {'status': 1, 'msg': 'ok', 'data': ''}
    
    cmd_args = 'ps aux | grep mongod |grep -v grep |wc -l'

    # 执行命令
    try:
        p = execute_cmd(cmd_args, shell=True)

        for line in iter(p.stdout.readline, ''):
            print(line)
            if int(line) == 1:
                send_mail('MongoDB is done...')
                break
        # 终止子进程
        p.kill()

    except Exception as e:
        logger.error(traceback.format_exc())
        result['status'] = 0
        result['msg'] = str(e)
        # print(result)
        send_mail(str(result))
