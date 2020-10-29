


基于mysqldump备份，建立仅有这个表权限的用户，进行导入，使用权限来过滤不需要的信息

创建用户：
	
	create user 'recovery_user'@'%' identified by '123456';
	grant all privileges on test_db.table_clubgamelog to 'recovery_user'@'%' with grant option;


导入：
	mysql -f -urecovery_user -p123456 sbtest < dump_bak.sql





实际应用：
	
	create  database ddzdb DEFAULT CHARSET utf8mb4 -- UTF-8 Unicode COLLATE utf8mb4_general_ci;

	create user 'recovery_user'@'%' identified by '123456';
	grant all privileges on ddzdb.table_user to 'recovery_user'@'%' with grant option;
		
	mysql -f -urecovery_user -p123456abc ddzdb < ddzdb_2020-10-28.dump
	
	rename table ddzdb.table_user to ddzdb.table_user_bak;



小结：
	
	不用要这种方式授权：grant all privileges on sbtest.test11 to 'tt'@'%' identified by 'tt';
	原因：
		如果已经存在 'tt'@'%' 这个用户，通过这种方式创建用户不会报错
		假设已经存在这个用户并且对所有的库有 all privileges 权限, 那么通过这种方式授权，这个用户具有的权限为 all privileges on *.* 
		这种情况下做全库备份中的单表恢复，还是会走全表导入的逻辑。
		
	这种方式恢复单表比导入全备数据的恢复方式快了不止一丁半点。
	
	
	
	
	
	
	