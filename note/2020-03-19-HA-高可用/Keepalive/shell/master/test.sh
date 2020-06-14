#!/bin/bash
mysql -uroot -p123456abc -S /tmp/mysql.sock -e "set global read_only=0;"
mysql -uroot -p123456abc -S /tmp/mysql.sock -e "set global super_read_only=0;"
mysql -uroot -p123456abc -S /tmp/mysql.sock -e "stop slave;"
mysql -uroot -p123456abc -S /tmp/mysql.sock -e "show master status;" > /tmp/master_status_$(date "+%y%m%d-%H%M").txt
