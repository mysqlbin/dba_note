

create  database db1 DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;
create table db1.t1(id int, a int);

create user 'ua'@'%' identified by '123456abc';

grant all privileges on db1.t1 to 'ua'@'%' with grant option;


GRANT SELECT(id), INSERT (id,a) ON db1.t1 TO 'ua'@'%' with grant option;

ua@mysqldb 11:14:  [db1]> insert into t1 values(1,1);
Query OK, 1 row affected (0.02 sec)
	
ua@mysqldb 11:15:  [db1]> delete from t1 where id=1;
ERROR 1142 (42000): DELETE command denied to user 'ua'@'192.168.0.54' for table 't1'





	
	
	
