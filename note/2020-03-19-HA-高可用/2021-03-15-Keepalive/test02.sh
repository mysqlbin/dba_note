#!/bin/bash

. /root/.bash_profile

Master_Log_File=$(/usr/local/mysql/bin/mysql -uroot -p123456abc -S /tmp/mysql.sock -e "show slave status\G" | grep -w Master_Log_File | awk -F": " '{print $2}')
Relay_Master_Log_File=$(/usr/local/mysql/bin/mysql -uroot -p123456abc -S /tmp/mysql.sock -e "show slave status\G" | grep -w Relay_Master_Log_File | awk -F": " '{print $2}')
Read_Master_Log_Pos=$(/usr/local/mysql/bin/mysql -uroot -p123456abc -S /tmp/mysql.sock -e "show slave status\G" | grep -w Read_Master_Log_Pos | awk -F": " '{print $2}')
Exec_Master_Log_Pos=$(/usr/local/mysql/bin/mysql -uroot -p123456abc -S /tmp/mysql.sock -e "show slave status\G" | grep -w Exec_Master_Log_Pos | awk -F": " '{print $2}')

echo $Master_Log_File
echo $Relay_Master_Log_File
echo $Read_Master_Log_Pos
echo $Exec_Master_Log_Pos

