#!/bin/bash


pid_ori=$(ps -ef | grep "mongodb" | grep -v grep | awk '{print $2}')
echo $pid_ori


hostname="192.168.0.241"

if [ -z $pid_ori ]
then	
	echo "1-1"
	
	# 发送邮件, 提示MongoDB进程已经不存在
	echo "$hostname" | mail -s "【问题】MongoDB is down, now startup..." 13202095158@163.com
	
	# 启动MongoDB进程
	service mongodb start
	
	sleep 5
	
	pid_new=$(ps -ef | grep "mongodb" | grep -v grep | awk '{print $2}')
	
	if [ -z $pid_new ]

	then
		# 发送邮件, 提示MongoDB进程启动失败
		echo "$hostname" | mail -s "【严重问题】 MongoDB startup failed!" 13202095158@163.com
		
		echo "0"
		
	else
		# 发送邮件, 提示MongoDB进程已经成功启动
		echo "$hostname" | mail -s "【已解决】 MongoDB startup successed." 13202095158@163.com

		echo "1-2"
	fi
	
fi

