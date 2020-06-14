
前言
查看表的DDL
使用 ibd2sdi
相关参考

前言
	8.0前 frm文件在数据目录下面，可以通过mysqlfrm工具提取表结构
	8.0后 没有frm了。表结构存储在mysql.ibd和 table_name.ibd  可以通过 ibd2sdi 工具提取  
	序列化字典(SDI)
	
	
查看表的DDL
	root@mysqldb 22:10:  [test_db]> show create table t\G;
	*************************** 1. row ***************************
		   Table: t
	Create Table: CREATE TABLE `t` (
	  `id` int(11) NOT NULL,
	  `c` int(11) DEFAULT NULL,
	  `d` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`),
	  KEY `c` (`c`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
	1 row in set (0.00 sec)

		
使用 ibd2sdi	
	[root@mgr03 test_db]# ibd2sdi --version
	ibd2sdi  Ver 8.0.18 for linux-glibc2.12 on x86_64 (MySQL Community Server - GPL)


	InnoDB表t的SDI则可以通过工具ibd2sdi可以解析出来(ibd2sdi t.ibd)：
	# 生成 json格式的数据
	[root@mgr03 test_db]# ibd2sdi t.ibd
	["ibd2sdi"
	,
	{
		"type": 1,
		"id": 645,
		"object":
			{
		"mysqld_version_id": 80018,
		"dd_version": 80017,
		"sdi_version": 80016,
		"dd_object_type": "Table",
		"dd_object": {
			"name": "t",
			"mysql_version_id": 80018,
			"created": 20191107000207,
			"last_altered": 20191107000207,
			"hidden": 1,
			"options": "avg_row_length=0;encrypt_type=N;key_block_size=0;keys_disabled=0;pack_record=0;stats_auto_recalc=0;stats_sample_pages=0;",
			"columns": [
				{
					"name": "id",              # `id` 字段
					"type": 4,
					"is_nullable": false,
					"is_zerofill": false,
					"is_unsigned": false,
					"is_auto_increment": false,
					"is_virtual": false,
					"hidden": 1,
					"ordinal_position": 1,
					"char_length": 11,
					"numeric_precision": 10,
					"numeric_scale": 0,
					"numeric_scale_null": false,
					"datetime_precision": 0,
					"datetime_precision_null": 1,
					"has_no_default": true,
					"default_value_null": false,
					"srs_id_null": true,
					"srs_id": 0,
					"default_value": "AAAAAA==",
					"default_value_utf8_null": true,
					"default_value_utf8": "",
					"default_option": "",
					"update_option": "",
					"comment": "",
					"generation_expression": "",
					"generation_expression_utf8": "",
					"options": "interval_count=0;",
					"se_private_data": "table_id=1172;",
					"column_key": 2,
					"column_type_utf8": "int(11)",
					"elements": [],
					"collation_id": 255,
					"is_explicit_collation": false
				},
				{
					"name": "c",					# `c` 字段
					"type": 4,
					"is_nullable": true,
					"is_zerofill": false,
					"is_unsigned": false,
					"is_auto_increment": false,
					"is_virtual": false,
					"hidden": 1,
					"ordinal_position": 2,
					"char_length": 11,
					"numeric_precision": 10,
					"numeric_scale": 0,
					"numeric_scale_null": false,
					"datetime_precision": 0,
					"datetime_precision_null": 1,
					"has_no_default": false,
					"default_value_null": true,
					"srs_id_null": true,
					"srs_id": 0,
					"default_value": "",
					"default_value_utf8_null": true,
					"default_value_utf8": "",
					"default_option": "",
					"update_option": "",
					"comment": "",
					"generation_expression": "",
					"generation_expression_utf8": "",
					"options": "interval_count=0;",
					"se_private_data": "table_id=1172;",
					"column_key": 4,
					"column_type_utf8": "int(11)",
					"elements": [],
					"collation_id": 255,
					"is_explicit_collation": false
				},
				{
					"name": "d",				 # `d` 字段
					"type": 4,
					"is_nullable": true,
					"is_zerofill": false,
					"is_unsigned": false,
					"is_auto_increment": false,
					"is_virtual": false,
					"hidden": 1,
					"ordinal_position": 3,
					"char_length": 11,
					"numeric_precision": 10,
					"numeric_scale": 0,
					"numeric_scale_null": false,
					"datetime_precision": 0,
					"datetime_precision_null": 1,
					"has_no_default": false,
					"default_value_null": true,
					"srs_id_null": true,
					"srs_id": 0,
					"default_value": "",
					"default_value_utf8_null": true,
					"default_value_utf8": "",
					"default_option": "",
					"update_option": "",
					"comment": "",
					"generation_expression": "",
					"generation_expression_utf8": "",
					"options": "interval_count=0;",
					"se_private_data": "table_id=1172;",
					"column_key": 1,
					"column_type_utf8": "int(11)",
					"elements": [],
					"collation_id": 255,
					"is_explicit_collation": false
				},
				{
					"name": "DB_TRX_ID",       # 隐藏字段: 事务ID
					"type": 10,
					"is_nullable": false,
					"is_zerofill": false,
					"is_unsigned": false,
					"is_auto_increment": false,
					"is_virtual": false,
					"hidden": 2,
					"ordinal_position": 4,
					"char_length": 6,
					"numeric_precision": 0,
					"numeric_scale": 0,
					"numeric_scale_null": true,
					"datetime_precision": 0,
					"datetime_precision_null": 1,
					"has_no_default": false,
					"default_value_null": true,
					"srs_id_null": true,
					"srs_id": 0,
					"default_value": "",
					"default_value_utf8_null": true,
					"default_value_utf8": "",
					"default_option": "",
					"update_option": "",
					"comment": "",
					"generation_expression": "",
					"generation_expression_utf8": "",
					"options": "",
					"se_private_data": "table_id=1172;",
					"column_key": 1,
					"column_type_utf8": "",
					"elements": [],
					"collation_id": 63,
					"is_explicit_collation": false
				},
				{
					"name": "DB_ROLL_PTR",       # 隐藏字段: 回滚段指针   
					"type": 9,
					"is_nullable": false,
					"is_zerofill": false,
					"is_unsigned": false,
					"is_auto_increment": false,
					"is_virtual": false,
					"hidden": 2,
					"ordinal_position": 5,
					"char_length": 7,
					"numeric_precision": 0,
					"numeric_scale": 0,
					"numeric_scale_null": true,
					"datetime_precision": 0,
					"datetime_precision_null": 1,
					"has_no_default": false,
					"default_value_null": true,
					"srs_id_null": true,
					"srs_id": 0,
					"default_value": "",
					"default_value_utf8_null": true,
					"default_value_utf8": "",
					"default_option": "",
					"update_option": "",
					"comment": "",
					"generation_expression": "",
					"generation_expression_utf8": "",
					"options": "",
					"se_private_data": "table_id=1172;",
					"column_key": 1,
					"column_type_utf8": "",
					"elements": [],
					"collation_id": 63,
					"is_explicit_collation": false
				}
			],
			"schema_ref": "test_db",
			"se_private_id": 1172,
			"engine": "InnoDB",
			"last_checked_for_upgrade_version_id": 0,
			"comment": "",
			"se_private_data": "",
			"row_format": 2,
			"partition_type": 0,
			"partition_expression": "",
			"partition_expression_utf8": "",
			"default_partitioning": 0,
			"subpartition_type": 0,
			"subpartition_expression": "",
			"subpartition_expression_utf8": "",
			"default_subpartitioning": 0,
			"indexes": [
				{
					"name": "PRIMARY",
					"hidden": false,
					"is_generated": false,
					"ordinal_position": 1,
					"comment": "",
					"options": "flags=0;",
					"se_private_data": "id=321;root=4;space_id=10;table_id=1172;trx_id=2018041;",
					"type": 1,
					"algorithm": 2,
					"is_algorithm_explicit": false,
					"is_visible": true,
					"engine": "InnoDB",
					"elements": [
						{
							"ordinal_position": 1,
							"length": 4,
							"order": 2,
							"hidden": false,
							"column_opx": 0
						},
						{
							"ordinal_position": 2,
							"length": 4294967295,
							"order": 2,
							"hidden": true,
							"column_opx": 3
						},
						{
							"ordinal_position": 3,
							"length": 4294967295,
							"order": 2,
							"hidden": true,
							"column_opx": 4
						},
						{
							"ordinal_position": 4,
							"length": 4294967295,
							"order": 2,
							"hidden": true,
							"column_opx": 1
						},
						{
							"ordinal_position": 5,
							"length": 4294967295,
							"order": 2,
							"hidden": true,
							"column_opx": 2
						}
					],
					"tablespace_ref": "test_db/t"
				},
				{
					"name": "c",
					"hidden": false,
					"is_generated": false,
					"ordinal_position": 2,
					"comment": "",
					"options": "flags=0;",
					"se_private_data": "id=322;root=5;space_id=10;table_id=1172;trx_id=2018041;",
					"type": 3,
					"algorithm": 2,
					"is_algorithm_explicit": false,
					"is_visible": true,
					"engine": "InnoDB",
					"elements": [
						{
							"ordinal_position": 1,
							"length": 4,
							"order": 2,
							"hidden": false,
							"column_opx": 1
						},
						{
							"ordinal_position": 2,
							"length": 4294967295,
							"order": 2,
							"hidden": true,
							"column_opx": 0
						}
					],
					"tablespace_ref": "test_db/t"
				}
			],
			"foreign_keys": [],
			"check_constraints": [],
			"partitions": [],
			"collation_id": 255
		}
	}
	}
	,
	{
		"type": 2,
		"id": 108,
		"object":
			{
		"mysqld_version_id": 80018,
		"dd_version": 80017,
		"sdi_version": 80016,
		"dd_object_type": "Tablespace",
		"dd_object": {
			"name": "test_db/t",
			"comment": "",
			"options": "encryption=N;",
			"se_private_data": "flags=16417;id=10;server_version=80018;space_version=1;state=normal;",
			"engine": "InnoDB",
			"files": [
				{
					"ordinal_position": 1,
					"filename": "./test_db/t.ibd",
					"se_private_data": "id=10;"
				}
			]
		}
	}
	}
	]


	
	[root@mgr03 test_db]# ibd2sdi --skip-data t.ibd
	["ibd2sdi"
	,
	{
		"type": 1,
		"id": 645
	}
	,
	{
		"type": 2,
		"id": 108
	}

	
相关参考
	https://dev.mysql.com/doc/refman/8.0/en/ibd2sdi.html
	https://mp.weixin.qq.com/s/5y2OG5L0frwIPncutoti0w    详解MySQL-8.0数据字典
	https://mp.weixin.qq.com/s/m7oUtKKZyVUegI0VPaffqg    MySQL8.0之数据字典
	https://mp.weixin.qq.com/s/MnMnfriH7qSKXEghtYc_BA    MySQL 8.0新特性之原子DDL
	https://mp.weixin.qq.com/s/aHS0Bcw0YTcotWWg-oITqA    MySQL 8.0中没FRM文件了还怎么恢复表的DDL信息 
	
	
