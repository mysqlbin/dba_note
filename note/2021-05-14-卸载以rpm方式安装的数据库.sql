


shell> sudo rpm -qa | grep -i mysql
perl-DBD-MySQL-4.023-6.el7.x86_64
mysql-community-common-5.7.26-1.el7.x86_64
mysql-community-libs-compat-5.7.26-1.el7.x86_64

mysql-community-libs-5.7.26-1.el7.x86_64
mysql-community-server-5.7.26-1.el7.x86_64
mysql-community-devel-5.7.26-1.el7.x86_64
mysql57-community-release-el7-11.noarch
mysql-community-client-5.7.26-1.el7.x86_64


shell> sudo rpm -qa | grep -i mysql
perl-DBD-MySQL-4.023-6.el7.x86_64
mysql-community-common-5.7.26-1.el7.x86_64
mysql-community-libs-compat-5.7.26-1.el7.x86_64
mysql-community-libs-5.7.26-1.el7.x86_64
mysql-community-server-5.7.26-1.el7.x86_64
mysql-community-devel-5.7.26-1.el7.x86_64
mysql-community-client-5.7.26-1.el7.x86_64

sudo rpm -e mysql-community-server-5.7.26-1.el7.x86_64
sudo rpm -e mysql-community-client-5.7.26-1.el7.x86_64



shell> sudo rpm -qa | grep -i mysql
perl-DBD-MySQL-4.023-6.el7.x86_64
mysql-community-common-5.7.26-1.el7.x86_64
mysql-community-libs-compat-5.7.26-1.el7.x86_64
mysql-community-libs-5.7.26-1.el7.x86_64
mysql-community-devel-5.7.26-1.el7.x86_64



shell> rpm -qa|grep -i mysql
perl-DBD-MySQL-4.023-6.el7.x86_64
mysql-community-common-5.7.26-1.el7.x86_64
mysql-community-libs-compat-5.7.26-1.el7.x86_64

mysql-community-libs-5.7.26-1.el7.x86_64
mysql-community-devel-5.7.26-1.el7.x86_64


shell>

sudo rpm -ev mysql-community-libs-compat-5.7.26-1.el7.x86_64  --nodeps
sudo rpm -ev mysql-community-common-5.7.26-1.el7.x86_64  --nodeps
sudo rpm -ev mysql-community-libs-5.7.26-1.el7.x86_64  --nodeps
sudo rpm -ev mysql-community-devel-5.7.26-1.el7.x86_64  --nodeps
sudo rpm -ev perl-DBD-MySQL-4.023-6.el7.x86_64  --nodeps




[coding001@db-c mysql]$ sudo rpm -qa | grep -i mysql
[sudo] password for coding001: 
[coding001@db-c mysql]$ 

