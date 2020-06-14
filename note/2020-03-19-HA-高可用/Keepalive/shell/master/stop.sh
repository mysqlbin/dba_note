#!/bin/bash

. /root/.bash_profile

M_File1=$(/usr/local/mysql/bin/mysql -uroot -p123456abc -S /tmp/mysql.sock -e "show master status\G" | awk -F': ' '/File/{print $2}')
M_Position1=$(/usr/local/mysql/bin/mysql -uroot -p123456abc -S /tmp/mysql.sock -e "show master status\G" | awk -F': ' '/Position/{print $2}')
sleep 1
M_File2=$(/usr/local/mysql/bin/mysql -uroot -p123456abc -S /tmp/mysql.sock -e "show master status\G" | awk -F': ' '/File/{print $2}')
M_Position2=$(/usr/local/mysql/bin/mysql -uroot -p123456abc -S /tmp/mysql.sock -e "show master status\G" | awk -F': ' '/Position/{print $2}')

i=1

while true
do

if [ $M_File1 = $M_File1 ] && [ $M_Position1 -eq $M_Position2 ]
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

