#!/bin/bash

/usr/local/mysql/bin/mysql -uroot -p123456abc -S /tmp/mysql.sock -e "stop slave;"
/usr/local/mysql/bin/mysql -uroot -p123456abc -S /tmp/mysql.sock -e "show master status;" > /tmp/master_status_$(date "+%y%m%d-%H%M").txt
