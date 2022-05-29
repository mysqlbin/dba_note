


相关参考
	
	https://db.xiaoe-tools.com/detail/18311/
		数据库wait_timeout=3600s
		
		
	https://github.com/hanchuanchuan/goInception/issues/306   执行过程中远程数据库连接中断，重新连接时没有设置数据库信息（No database selected ） #306
	
	https://github.com/hanchuanchuan/goInception/releases/tag/v1.2.5

	https://github.com/hanchuanchuan/goInception/commit/a1b4a642d7dcf1ec0633c0c6172b0c8df730e91e	


现象：
	

原因和解决办法：
	
	原因：执行过程中远程数据库连接中断，重新连接时没有设置数据库信息(use)。属于goIncpetion审核工具的1个bug，官方修复已经修复这个问题了。
	解决办法：现在我们用的是1.2.3版本的goIncpetion，升级到1.2.5版本就可以解决这个问题。

	最近使用1.2.5的版本goInception来详细测试下，没问题后再升级。

	
思考：
	
	1. 怎么复现？
	
		复现了。通过设置数据库wait_timeout=10这个方式复现的。
		整理了一下：
		   1. goinception在最开始use就建立1个连接。 -- 定义为 ”连接1“
		   2. 但是osc没有用这个链接，新建了连接。这里执行耗时30秒。第10秒的时候 ”连接1“ 已经断开了。
		   3. 直到后面非osc语句去用的时候发现连接中断了。然后就出现了 Execute: No database selected. 这个错误。
		
		复现语句
			-- 走pt-osc
			alter table t_20201030 add content_url6677775 varchar(512) default '' null comment '富文本链接';
			-- 走原始DDL(不走pt-osc)
			ALTER TABLE t_20220525 add INDEX idx_age(age);

	2. goInception 部署在项目代码外面，会有什么问题吗
	
		是如何识别的？
	
		是如何集成在archery中的？
	
	
		不会有问题，只在goInception进程存在就可以了。
		

1.2.5 版本移除的参数
	
	(venv4archery) [root@localhost goInception]# tail -f nohup.out
	time="2022/05/25 19:18:13.670" level=info msg="[ddl] closing DDL:91fee622-99f5-440f-8ee1-40d38a9ec670 takes time 1.434819ms" file=ddl.go func=close line=401
	time="2022/05/25 19:18:13.670" level=info msg="[ddl] stop DDL:91fee622-99f5-440f-8ee1-40d38a9ec670" file=ddl.go func=Stop line=348
	################################################
	Warning: The following parameters will be deprecated and replaced with disable_types:
			enable_blob_type
			enable_json_type
			enable_enum_set_bit
			enable_timestamp_type
	https://github.com/hanchuanchuan/goInception/pull/418
	################################################



	(以下参数将弃用: enable_blob_type,enable_json_type,enable_enum_set_bit,enable_timestamp_type)

	# 列的类型不能是BLOB/TEXT	  已弃用
	enable_blob_type = true
		检查是不是支持BLOB字段，包括建表、修改列、新增列操作 (使用参数disable_types代替)


	enable_json_type  			  已弃用

		设置是否允许json类型字段，包括建表、修改列、新增列操作 (使用参数disable_types代替)

	enable_enum_set_bit 		  已弃用	
		是不是支持enum,set,bit数据类型 (使用参数disable_types代替)
	
	enable_timestamp_type 		v1.0.1 已弃用

		设置是否允许 timestamp 类型字段，包括建表、修改列、新增列操作，默认为 true (使用参数disable_types代替)



enable_blob_type
 
	检查是不是支持BLOB字段，包括建表、修改列、新增列操作 (使用参数disable_types代替)
	包含text字段吗？
	
	https://github.com/hanchuanchuan/goInception/issues/400   新参数 disable_types 禁用数据库类型,多个时以逗号分隔.
	
	
	之前是可以创建blog、text文本类型的大字段吗


	CREATE TABLE `db_jianbin_test0525` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键ID',
	  `app_id` blob COMMENT 'ddd',
	  PRIMARY KEY (`id`)
	) COMMENT='dba_test_table';


	CREATE TABLE `db_jianbin_test0524` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键ID',
	  `app_id` text COMMENT 'ddd',
	  PRIMARY KEY (`id`)
	) COMMENT='dba_test_table';

	
	goInception的代码写了 wait_timeout 超过600s才会重连.

	
	CREATE INDEX idx_app_id ON db_jianbin_test0525 (`app_id`);
	
	CREATE TABLE `db_jianbin_test0526002` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键ID',
	  `app_id` varchar(100) null COMMENT 'app_id',
	  PRIMARY KEY (`id`)
	) COMMENT='dba_test_table';


	CREATE TABLE `db_jianbin_test052603` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键ID',
	  `app_id` varchar(100) null COMMENT 'app_id',
	  PRIMARY KEY (`id`),
	  KEY `app_id` (`app_id`)
	) COMMENT='dba_test_table';



	CREATE TABLE `db_jianbin_test062222` (
	  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键ID',
	  `app_id` text COMMENT 'ddd',
	  PRIMARY KEY (`id`)
	)engine=InnoDB COMMENT='dba_test_table';




	






