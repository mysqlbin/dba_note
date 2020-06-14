#!/usr/bin/python
#coding=utf-8

"""
python pt_archiver_by_date_py2.py  -soD=audit_db -soT=table_name -deD=audit_db -deT='1' -field=CreateTime -beforeDay=-1
python pt_archiver_by_date_py2.py  -soD=audit_db -soT=table_name -deD=audit_db -deT='1' -field=tEndTime -beforeDay=-1
"""

"""
Python3
import sys
import importlib
importlib.reload(sys)
"""

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
import argparse
import MySQLdb


logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s',
                    filename='mysql_archiver_monitor.log',
                    filemode='a')

logger = logging.getLogger(__name__)

def parse_args():

   parser = argparse.ArgumentParser()
   parser.add_argument('-soD', '--source-database', dest='source_database', help='source database', type=str)
   parser.add_argument('-soT', '--source-table', dest='source_table', help='source table', type=str)
   parser.add_argument('-field', '--source-field', dest='source_field', help='source field', type=str)
   parser.add_argument('-deD', '--dest-database', dest='dest_database', help='dest database', type=str)
   parser.add_argument('-deT', '--dest-table', dest='dest_table', help='dest table', type=str)
   parser.add_argument('-beforeDay', '--before-data', dest='before_day', help='before day', type=int)
   return parser


def command_line_args(args):
    parser = parse_args()
    args = parser.parse_args(args)
    return args


def mysql_process_log_search(str, line):
    """
   错误日志的匹配项并返回 匹配项和对应的错误日志行数
   :return:
   """
    m_search = re.search(str, line)  # 类似于 like '%aa%'
    if m_search is not None:
        row = "{}".format(line)
        return row


def send_mail(body, format = 'plain'):

    host = 'smtp.163.com'
    port = 465
    sender = '13202095158@163.com'
    pwd = ''
    receiver = ['13202095158@163.com', '1224056230@qq.com']
    body = body
    msg = MIMEText(body, format, 'utf-8')
    msg['subject'] = 'Info: data archiver monitor'
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


def pt_cmd(soh, sou, sop, soPort, sod, sot, soa, deh, deu, dep, dePort, ded, det, charset, process_count, condition, limit, txn_size, sleep_time, operation):

    """
   sudo pt-archiver \
   --source h=192.168.1.10,u = root,p = ,P = 3306,D = test_db,t = t1,A=utf8mb4 \
   --dest h = 192.168.1.10,P = 3306,u=root,p = ,D = test_db,t = t12 \
   --charset=utf8mb4 --progress 10000 \
   --WHERE 'tEndTime<"2019-07-29 00:00:00.000"' \
   --statistics --LIMIT=20000 --txn-size 1000 --sleep 1 --NO-DELETE

   operation:
    --NO-DELETE
    --bulk-delete
   """

    archiver_cmd = " pt-archiver \
    --source h={},u={},p={},P={},D={},t={},A={} \
    --dest h={},u={},p={},P={},D={},t={} \
    --charset={} --progress {} \
    --where '{}' \
    --statistics --limit={} --txn-size {} --sleep {} {}".format(soh, sou, sop, soPort, sod, sot, soa, deh, deu, dep, dePort, ded, det, charset, process_count, condition, limit, txn_size, sleep_time, operation)
    return archiver_cmd


def mysql_query(sql, user, passwd, host, port, get_data = 1):
    try:
        conn = MySQLdb.connect(host=host, user=user, passwd=passwd, port=int(port), charset='utf8mb4')
        cursor = conn.cursor()
        cursor.execute(sql)
        if get_data == 1:
            result = cursor.fetchone()
        else:
            result = cursor.fetchall()
        cursor.close()
        conn.close()
        return result
    except Exception as err:
        logger.error("MySQL语句执行报错，语句：{}，错误信息{}" .format(sql,traceback.format_exc()))
        return err

if __name__ == '__main__':

    args = command_line_args(sys.argv[1:])
    source_database = args.source_database
    source_table    = args.source_table
    source_field    = args.source_field
    dest_database = args.dest_database
    dest_table = args.dest_table
    before_day    = args.before_day

    if source_database == '' or source_table == '' or source_field == '' or dest_database == '' or  dest_table == '' or before_day == '':
        logger.error('source_database or source_table or source_field or dest_database or dest_tabe is Null or before_day is Null. exit')
        exit()

    '''
    if before_day > -30:
        logger.error('The date format does not match . exit')
        exit()
    '''
	
    result = {'status': 1, 'msg': 'ok', 'data': ''}

    soh = '192.168.0.91'
    sou = 'root'
    sop = '123456abc'
    soPort = 3306
    sod = source_database
    sot = source_table
    soa = 'utf8mb4'

    deh = '192.168.0.91'
    deu = 'root'
    dep = '123456abc'

    dePort = 3306
    ded = dest_database
    
    charset = 'utf8mb4'
    process_count = 10000
	
    # 时间处理
    #before_day = -1
    before_datetime = time.strftime("%Y-%m-%d")
    before_begin_datetime = datetime.datetime.strptime(before_datetime, '%Y-%m-%d') + datetime.timedelta(days=before_day)
    print(before_begin_datetime)
	
    end_day = before_day+1
    before_datetime = time.strftime("%Y-%m-%d")
    before_end_datetime = datetime.datetime.strptime(before_datetime, '%Y-%m-%d') + datetime.timedelta(days=end_day)
    print(before_end_datetime)

    #table_date = datetime.datetime.strptime(before_begin_datetime, '%Y-%m-%d %H:%M:%S').strftime('%y%m%d')
    # select  min(ID) as min_id , max(ID) as max_id from table_clubgamelog where tEndTime < '2019-08-25 00:00:00.000'
	#     sql = 'select  min(ID) as min_id , max(ID) as max_id from {}.{} where {} < "{}.000"'. format(source_database, source_table, source_field, before_datetime)

    sql = 'select  min(ID) as min_id , max(ID) as max_id from {}.{} where {} >= "{}.000" and {} < "{}.000"'. format(source_database, source_table, source_field, before_begin_datetime, source_field, before_end_datetime)
    print(sql)

    min_max_value = mysql_query(sql, sou, sop, soh, soPort)
    if len(min_max_value) == 0:
        logger.error('The data format does not match . exit')
        exit()
    min_id =  min_max_value[0]
    max_id =  min_max_value[1]
    if min_id is None or max_id is None:
        logger.error('The max id value or min id value is Null . exit')
        exit()
    #sql = 'select  min(ID) as min_id , max(ID) as max_id from {}.{} where {} >= "{}.000" and {} < "{}.000"'. format(source_database, source_table, source_field, before_begin_datetime, source_field, before_end_datetime)

    condition = 'id <= {} and id >= {} and {} >= "{}.000" and {} < "{}.000"' .format(max_id, min_id, source_field, before_begin_datetime, source_field, before_end_datetime)

    limit = 20000
    txn_size = 1000
    sleep_time = 1
    operation = '--no-delete'

    print(before_begin_datetime)
    # 拼接表名
    table_ymd = str(before_begin_datetime).replace('-', '')[0:8]
    print(table_ymd)
    dest_table = '{}{}'.format(source_table, table_ymd)
    det = dest_table
    cmd_args = pt_cmd(soh, sou, sop, soPort, sod, sot, soa, deh, deu, dep, dePort, ded, det, charset, process_count, condition, limit, txn_size, sleep_time, operation)
    print(cmd_args)
    # 执行命令

    try:
        p = execute_cmd(cmd_args, shell=True)
        info_list = []

        for line in iter(p.stdout.readline, ''):
            process_info_dict = {}
            #获取执行的开始时间和结束时间
            started_time = mysql_process_log_search('Started', line)

            if started_time is not None:
                started_ended_at_list = re.split(',', started_time)
                if isinstance(started_ended_at_list, list):
                    if len(started_ended_at_list) > 0:
                        process_info_dict['started_time'] = started_ended_at_list[0]
                        process_info_dict['ended_time'] = started_ended_at_list[1]

            insert_row = mysql_process_log_search('INSERT', line)
            if insert_row is not None:
                process_info_dict['insert_row'] = insert_row

            delete_row = mysql_process_log_search('DELETE', line)
            if delete_row is not None:
                process_info_dict['delete_row'] = delete_row

            if not bool(process_info_dict):
                continue

            info_list.append(process_info_dict)

        if info_list.__len__() == 0:
            # 判断是否有异常
            stderr = p.stderr.read()
            if stderr:
                result['status'] = 0
                result['msg'] = stderr
        # 终止子进程
        p.kill()
        result['data'] = info_list
    except Exception as e:
        logger.error(traceback.format_exc())
        result['status'] = 0
        result['msg'] = str(e)

    print(result)

    # send_mail(str(result))
