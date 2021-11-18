#!/bin/bash

. /root/.bash_profile


old_slave_ip=${4}
old_slave_port=${5}
new_master_ip=${6}
new_master_port=${7}


#当slave提升为主以后，发送邮件
echo "#####################################" > /tmp/status
echo "Redis salve已经提升为主库，请进行检查！" >> /tmp/status
echo "原主节点的ip地址: ${old_slave_ip}" >> /tmp/status
echo "原主节点的端口: ${old_slave_port}" >> /tmp/status6
echo "新主节点的ip地址: ${new_master_ip}" >> /tmp/status
echo "新主节点的端口: ${new_master_port}" >> /tmp/status
echo "#####################################" >> /tmp/status
master=`cat /tmp/status`
echo "$master" | mail -s "Redis slave to primary-origin master" 13202095158@163.com


