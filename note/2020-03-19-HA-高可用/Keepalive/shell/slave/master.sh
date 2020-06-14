#!/bin/bash

. /root/.bash_profile

Master_Log_File=$(/usr/local/mysql/bin/mysql -uroot -p123456abc -S /tmp/mysql.sock -e "show slave status\G" | grep -w Master_Log_File | awk -F": " '{print $2}')
Relay_Master_Log_File=$(/usr/local/mysql/bin/mysql -uroot -p123456abc -S /tmp/mysql.sock -e "show slave status\G" | grep -w Relay_Master_Log_File | awk -F": " '{print $2}')
Read_Master_Log_Pos=$(/usr/local/mysql/bin/mysql -uroot -p123456abc -S /tmp/mysql.sock -e "show slave status\G" | grep -w Read_Master_Log_Pos | awk -F": " '{print $2}')
Exec_Master_Log_Pos=$(/usr/local/mysql/bin/mysql -uroot -p123456abc -S /tmp/mysql.sock -e "show slave status\G" | grep -w Exec_Master_Log_Pos | awk -F": " '{print $2}')

i=1

while true
do

if [ $Master_Log_File = $Relay_Master_Log_File ] && [ $Read_Master_Log_Pos -eq $Exec_Master_Log_Pos ]
then
   echo "ok"
   break
else
   sleep 1

   if [ $i -gt 60 ]
   then
      break
   fi
   continue
   let i++
fi
done

/usr/local/mysql/bin/mysql -uroot -p123456abc -S /tmp/mysql.sock -e "stop slave;"
/usr/local/mysql/bin/mysql -uroot -p123456abc -S /tmp/mysql.sock -e "reset slave all;"
/usr/local/mysql/bin/mysql -uroot -p123456abc -S /tmp/mysql.sock -e "set global read_only=0;"
/usr/local/mysql/bin/mysql -uroot -p123456abc -S /tmp/mysql.sock -e "set global super_read_only=0;"
/usr/local/mysql/bin/mysql -uroot -p123456abc -S /tmp/mysql.sock -e "set global event_scheduler=1;"
/usr/local/mysql/bin/mysql -uroot -p123456abc -S /tmp/mysql.sock -e "show master status;" > /tmp/master_status_$(date "+%y%m%d-%H%M").txt



#当slave提升为主以后，发送邮件
echo "#####################################" > /tmp/status
echo "salve已经提升为主库，请进行检查！" >> /tmp/status
ip addr show enp0s3 | grep  'inet ' | sed 's/^.*inet //g' >> /tmp/status
mysql -uroot -p123456abc -S /tmp/mysql.sock -Nse "show variables like 'port'" >> /tmp/status
echo "#####################################" >> /tmp/status
master=`cat /tmp/status`
echo "$master" | mail -s "Note: slave to primary" 13202095158@163.com





