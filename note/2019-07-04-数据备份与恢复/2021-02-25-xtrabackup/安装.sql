



wget https://www.percona.com/downloads/XtraBackup/Percona-XtraBackup-2.4.9/binary/redhat/6/x86_64/percona-xtrabackup-24-2.4.9-1.el6.x86_64.rpm

yum localinstall percona-xtrabackup-24-2.4.9-1.el6.x86_64.rpm

rpm -ql percona-xtrabackup-24-2.4.9-1.el6.x86_64
[root@env backup]# rpm -ql percona-xtrabackup-24-2.4.9-1.el6.x86_64
/usr/bin/innobackupex
/usr/bin/xbcloud
/usr/bin/xbcloud_osenv
/usr/bin/xbcrypt
/usr/bin/xbstream
/usr/bin/xtrabackup
/usr/share/doc/percona-xtrabackup-24-2.4.9
/usr/share/doc/percona-xtrabackup-24-2.4.9/COPYING
/usr/share/man/man1/innobackupex.1.gz
/usr/share/man/man1/xbcrypt.1.gz
/usr/share/man/man1/xbstream.1.gz
/usr/share/man/man1/xtrabackup.1.gz