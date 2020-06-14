#!/usr/bin/ptyhon
#coding=utf-8

import os
import errno
import sys
import time
import getopt
import logging
import shlex
import shutil
from subprocess import Popen, PIPE, STDOUT
from datetime import timedelta, datetime 
import MySQLdb

db_host="192.168.1.112"
db_port="3306"
db_user="backup"
db_passwd="123456abc"
db_name="commands"

pt_xtrabackup ="/usr/bin/innobackupex"

# Start logging
logging.basicConfig(
	filename='/u2/backup/backup.log',
	format='%(asctime)s:%(levelname)s:%(message)s',
	datefmt='%Y-%m-%d %T',
	level=logging.INFO
)
logging.info("Starting backup")

class backup:
	global pt_xtrabackup
	def __init__(self,db_user=None, db_passwd=None, db_port=None, conf=None, target_dir=None):
		self.user	=db_user
		self.passwd	=db_passwd
		self.port	=db_port
		if (conf == 'None'):
			self.default_file='/etc/my.cnf'
		else:
			self.default_file=conf

		self.target_dir = target_dir

	def backup(self):
		command = "{0} --defaults-file={4}  --user={1} --password={2} --host=127.0.0.1 --port={3}  --no-timestamp {5}".format(pt_xtrabackup, self.user, self.passwd, self.port, self.default_file, self.target_dir)
		print command
		status = runCommand(command)
		print status,'test'
		if status == 1:
			return 1
	def applylog(self):
		command ="%s --defaults-file=%s/backup-my.cnf --apply-log  --user=%s --password=%s --host=127.0.0.1 --port=%s %s" %( pt_xtrabackup, self.user, self.passwd, self.port, target_dir, target_dir)
		print command
		status = runCommand(command)
		if status == 1:
			return 1
		return 0

def runCommand(command):
	cmd = shlex.split(command)
	logging.debug('Running command: "' + command + '"')
	# print cmd
	proc = Popen(cmd, stdout=PIPE, stderr=PIPE)
	# print proc
	for line in proc.stderr:
		logging.warning(str(line.strip()))

	for line in proc.stdout:
		logging.debug(str(line.strip()))

	proc.wait()
	#print proc.returncode
	if proc.returncode != 0:
		logging.critical('Command failed with return code "' + str(proc.returncode) + '"')
		return 1
	else:
		logging.debug('Command successfully finished with returncode "' + str(proc.returncode) + '"')
		return 0


class dbinstance:
	conn = None
	def __init__(self, host=None,port=None, user=None, passwd=None, dbname=None):
		self.dbhost= host
		self.dbport = int(port)
		self.dbuser = user
		self.dbpassword = passwd
		if (dbname == 'None'):
			self.dbname = 'mysql'
		else:
			self.dbname = dbname


	def connect(self):
		#       print "in db conn"
	#               print "host : %s, port: %d, user: %s, password: %s" % (self.dbhost, self.dbport, self.dbuser, self.dbpassword)
		try:
			self.conn=MySQLdb.connect(host="%s"%self.dbhost, port=self.dbport,user="%s"%self.dbuser, passwd="%s"%self.dbpassword, db="%s"%self.dbname)
		except Exception, e:
		#                       print " Error"
			print e
			return 1
		return  0
	
	def disconnect(self):
		if (self.conn):
			self.conn.close()	
		self.conn = None
	
	def query(self, sql):
		cursor = self.conn.cursor()
		cursor.execute(sql)
		alldata = cursor.fetchall()
		cursor.close()
		return alldata

	def save(self, sql):
		cursor = self.conn.cursor()
		cursor.execute(sql)
		self.conn.commit()


if __name__ == '__main__':
	db = dbinstance (db_host, db_port, db_user, db_passwd, db_name)		
	if (db.connect()):
		logging.info('Connect commands db error , Please Check')
		os.exit(1)

	host_id= os.popen('cat /etc/MachineId').read().strip()	
	logging.info("get host_id : %s" % host_id)

	sql = "select dbname, username, password, port, defaults_file, backup_path, datadir from backup_task_list where host_id=%s and flag='Y' order by level desc" % host_id
	print sql
	tasks = db.query(sql)
	print tasks
	for task in tasks:
		dir= task[0]+"_"+time.strftime('%Y-%m-%d', time.gmtime()) 
		target_dir = task[5]+dir
		
		#(self,db_user=None, db_passwd=None, db_port=None, conf=None, target_dir=None):
		t= backup(task[1], task[2], task[3], task[4], target_dir)  	
		sql = "INSERT INTO backup_done_list(host_id, dbname, target_dir,src_dir,start_time,is_ok) VALUES(%s, '%s', '%s','%s', NOW(),'N')" % (host_id, task[0], target_dir, task[6])
		print sql
		logging.info(sql)
		db.save(sql)
		t.backup()
		status = t.applylog()
		if (status == 0):
			dbsize =os.popen('du -sm %s' % target_dir).read().split("\t")
			logging.info("%s backup to %s dbsize: %s" % (task[0],  target_dir, dbsize[0]))
			sql="update backup_done_list set backup_size=%s, is_ok='Y',create_time=NOW() where host_id=%s and dbname='%s'and  target_dir='%s';" % (dbsize[0], host_id, task[0], target_dir)
			logging.info(sql)
			db.save(sql)
	
	logging.info("End backup")
	
	#删除过期备份
	before_date = datetime.today() + timedelta(-1)  
	before_date_format = before_date.strftime('%Y-%m-%d')  
	shutil.rmtree(r'/data/backup/db_repl_'+before_date_format+'/');
	#shutil.rmtree(r'/data/backup/db_repl_2017-12-03/');
