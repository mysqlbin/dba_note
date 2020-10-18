

基于mysqldump备份，建立仅有这个表权限的用户，进行导入，使用权限来过滤不需要的信息

创建用户：grant all privileges on sbtest.test11 to 'tt'@'%' identified by 'tt';

导入：mysql -f -utt -ptt -S /tmp/mysql3308.sock sbtest < dump_bak.sql

create user 'recovery_user'@'%' identified by '123456';
grant all privileges on test_db.table_clubgamelog to 'recovery_user'@'%' with grant option;


time mysql -f -h 192.168.0.242 -urecovery_user -p123456 test_db < dump_bak.sql