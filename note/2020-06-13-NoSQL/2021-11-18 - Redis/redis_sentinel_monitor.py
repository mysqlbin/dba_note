#!/usr/bin/python
#coding=utf-8


import redis
from redis.sentinel import Sentinel
import smtplib
from email.mime.text import MIMEText

def send_mail(body, format = 'plain'):

    host = 'smtp.163.com'
    port = 465
    sender = ''
    pwd = ''
    receiver = ['', '']
    body = body
    msg = MIMEText(body, format, 'utf-8')
    msg['subject'] = 'Info:Redis slave to primary!!!!!'
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

    # 连接哨兵服务器(主机名也可以用域名)
    sentinel = Sentinel([('192.168.0.111', 26379),
                         ('192.168.0.112', 26379),
                         ('192.168.0.113', 26379)
                         ],
                        socket_timeout=0.5)

    # 获取主服务器地址
    master = sentinel.discover_master('mymaster')
    print(master)

    # 获取从服务器地址
    slave = sentinel.discover_slaves('mymaster')
    print(slave)

    master = "新的主库：{}".format(master)
    print(master)

    slave = "   从库列表为：{}".format(slave)
    print(slave)

    content = master + slave
    send_mail(content)



