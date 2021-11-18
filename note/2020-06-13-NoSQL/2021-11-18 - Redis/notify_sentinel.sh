#!/bin/bash

. /root/.bash_profile


event_type=${1}
event_desc=${2}



#当Sentinel监控的实例发生改变后，发送邮件
echo "#####################################" > /tmp/status_sentinel
echo "event_type: ${event_type}" >> /tmp/status_sentinel
echo "event_desc: ${event_desc}" >> /tmp/status_sentinel
echo "#####################################" >> /tmp/status_sentinel
master=`cat /tmp/status_sentinel`
echo "$master" | mail -s "Redis Sentinel Event Notification Mail" 13202095158@163.com

exit 0


