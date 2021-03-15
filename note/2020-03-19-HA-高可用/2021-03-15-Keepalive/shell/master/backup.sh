#!/bin/bash

. /root/.bash_profile

/usr/local/mysql/bin/mysql -uroot -p123456abc -S /tmp/mysql.sock -e "set global event_scheduler=0;"
/usr/local/mysql/bin/mysql -uroot -p123456abc -S /tmp/mysql.sock -e "set global read_only=1;"
/usr/local/mysql/bin/mysql -uroot -p123456abc -S /tmp/mysql.sock -e "set global super_read_only=1;"



