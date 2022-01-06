
0. sql_mode
1. 初始化150个字段的表结构
2. 创建表在Server层和InnoDB层的校验
3. 插入数据报错Row size too large (> 8126)
4. 行溢出

0. sql_mode

	mysql> show global variables like '%sql_mode%';
	+---------------+-----------------------------------------------------------------------------------------------------------------------+
	| Variable_name | Value                                                                                                                 |
	+---------------+-----------------------------------------------------------------------------------------------------------------------+
	| sql_mode      | ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION |
	+---------------+-----------------------------------------------------------------------------------------------------------------------+
	1 row in set (0.00 sec)


1. 初始化150个字段的表结构

	drop table if exists table_20201118_01;
	CREATE TABLE `table_20201118_01` (

	field_1 VARCHAR(256) NOT NULL,
	field_2 VARCHAR(256) NOT NULL,
	field_3 VARCHAR(256) NOT NULL,
	field_4 VARCHAR(256) NOT NULL,
	field_5 VARCHAR(256) NOT NULL,
	field_6 VARCHAR(256) NOT NULL,
	field_7 VARCHAR(256) NOT NULL,
	field_8 VARCHAR(256) NOT NULL,
	field_9 VARCHAR(256) NOT NULL,
	field_10 VARCHAR(256) NOT NULL,
	field_11 VARCHAR(256) NOT NULL,
	field_12 VARCHAR(256) NOT NULL,
	field_13 VARCHAR(256) NOT NULL,
	field_14 VARCHAR(256) NOT NULL,
	field_15 VARCHAR(256) NOT NULL,
	field_16 VARCHAR(256) NOT NULL,
	field_17 VARCHAR(256) NOT NULL,
	field_18 VARCHAR(256) NOT NULL,
	field_19 VARCHAR(256) NOT NULL,
	field_20 VARCHAR(256) NOT NULL,
	field_21 VARCHAR(256) NOT NULL,
	field_22 VARCHAR(256) NOT NULL,
	field_23 VARCHAR(256) NOT NULL,
	field_24 VARCHAR(256) NOT NULL,
	field_25 VARCHAR(256) NOT NULL,
	field_26 VARCHAR(256) NOT NULL,
	field_27 VARCHAR(256) NOT NULL,
	field_28 VARCHAR(256) NOT NULL,
	field_29 VARCHAR(256) NOT NULL,
	field_30 VARCHAR(256) NOT NULL,
	field_31 VARCHAR(256) NOT NULL,
	field_32 VARCHAR(256) NOT NULL,
	field_33 VARCHAR(256) NOT NULL,
	field_34 VARCHAR(256) NOT NULL,
	field_35 VARCHAR(256) NOT NULL,
	field_36 VARCHAR(256) NOT NULL,
	field_37 VARCHAR(256) NOT NULL,
	field_38 VARCHAR(256) NOT NULL,
	field_39 VARCHAR(256) NOT NULL,
	field_40 VARCHAR(256) NOT NULL,
	field_41 VARCHAR(256) NOT NULL,
	field_42 VARCHAR(256) NOT NULL,
	field_43 VARCHAR(256) NOT NULL,
	field_44 VARCHAR(256) NOT NULL,
	field_45 VARCHAR(256) NOT NULL,
	field_46 VARCHAR(256) NOT NULL,
	field_47 VARCHAR(256) NOT NULL,
	field_48 VARCHAR(256) NOT NULL,
	field_49 VARCHAR(256) NOT NULL,
	field_50 VARCHAR(256) NOT NULL,
	field_51 VARCHAR(256) NOT NULL,
	field_52 VARCHAR(256) NOT NULL,
	field_53 VARCHAR(256) NOT NULL,
	field_54 VARCHAR(256) NOT NULL,
	field_55 VARCHAR(256) NOT NULL,
	field_56 VARCHAR(256) NOT NULL,
	field_57 VARCHAR(256) NOT NULL,
	field_58 VARCHAR(256) NOT NULL,
	field_59 VARCHAR(256) NOT NULL,
	field_60 VARCHAR(256) NOT NULL,
	field_61 VARCHAR(256) NOT NULL,
	field_62 VARCHAR(256) NOT NULL,
	field_63 VARCHAR(256) NOT NULL,
	field_64 VARCHAR(256) NOT NULL,
	field_65 VARCHAR(256) NOT NULL,
	field_66 VARCHAR(256) NOT NULL,
	field_67 VARCHAR(256) NOT NULL,
	field_68 VARCHAR(256) NOT NULL,
	field_69 VARCHAR(256) NOT NULL,
	field_70 VARCHAR(256) NOT NULL,
	field_71 VARCHAR(256) NOT NULL,
	field_72 VARCHAR(256) NOT NULL,
	field_73 VARCHAR(256) NOT NULL,
	field_74 VARCHAR(256) NOT NULL,
	field_75 VARCHAR(256) NOT NULL,
	field_76 VARCHAR(256) NOT NULL,
	field_77 VARCHAR(256) NOT NULL,
	field_78 VARCHAR(256) NOT NULL,
	field_79 VARCHAR(256) NOT NULL,
	field_80 VARCHAR(256) NOT NULL,
	field_81 VARCHAR(256) NOT NULL,
	field_82 VARCHAR(256) NOT NULL,
	field_83 VARCHAR(256) NOT NULL,
	field_84 VARCHAR(256) NOT NULL,
	field_85 VARCHAR(256) NOT NULL,
	field_86 VARCHAR(256) NOT NULL,
	field_87 VARCHAR(256) NOT NULL,
	field_88 VARCHAR(256) NOT NULL,
	field_89 VARCHAR(256) NOT NULL,
	field_90 VARCHAR(256) NOT NULL,
	field_91 VARCHAR(256) NOT NULL,
	field_92 VARCHAR(256) NOT NULL,
	field_93 VARCHAR(256) NOT NULL,
	field_94 VARCHAR(256) NOT NULL,
	field_95 VARCHAR(256) NOT NULL,
	field_96 VARCHAR(256) NOT NULL,
	field_97 VARCHAR(256) NOT NULL,
	field_98 VARCHAR(256) NOT NULL,
	field_99 VARCHAR(256) NOT NULL,
	field_100 VARCHAR(256) NOT NULL,
	field_101 VARCHAR(256) NOT NULL,
	field_102 VARCHAR(256) NOT NULL,
	field_103 VARCHAR(256) NOT NULL,
	field_104 VARCHAR(256) NOT NULL,
	field_105 VARCHAR(256) NOT NULL,
	field_106 VARCHAR(256) NOT NULL,
	field_107 VARCHAR(256) NOT NULL,
	field_108 VARCHAR(256) NOT NULL,
	field_109 VARCHAR(256) NOT NULL,
	field_110 VARCHAR(256) NOT NULL,
	field_111 VARCHAR(256) NOT NULL,
	field_112 VARCHAR(256) NOT NULL,
	field_113 VARCHAR(256) NOT NULL,
	field_114 VARCHAR(256) NOT NULL,
	field_115 VARCHAR(256) NOT NULL,
	field_116 VARCHAR(256) NOT NULL,
	field_117 VARCHAR(256) NOT NULL,
	field_118 VARCHAR(256) NOT NULL,
	field_119 VARCHAR(256) NOT NULL,
	field_120 VARCHAR(256) NOT NULL,
	field_121 VARCHAR(256) NOT NULL,
	field_122 VARCHAR(256) NOT NULL,
	field_123 VARCHAR(256) NOT NULL,
	field_124 VARCHAR(256) NOT NULL,
	field_125 VARCHAR(256) NOT NULL,
	field_126 VARCHAR(256) NOT NULL,
	field_127 VARCHAR(256) NOT NULL,
	field_128 VARCHAR(256) NOT NULL,
	field_129 VARCHAR(256) NOT NULL,
	field_130 VARCHAR(256) NOT NULL,
	field_131 VARCHAR(256) NOT NULL,
	field_132 VARCHAR(256) NOT NULL,
	field_133 VARCHAR(256) NOT NULL,
	field_134 VARCHAR(256) NOT NULL,
	field_135 VARCHAR(256) NOT NULL,
	field_136 VARCHAR(256) NOT NULL,
	field_137 VARCHAR(256) NOT NULL,
	field_138 VARCHAR(256) NOT NULL,
	field_139 VARCHAR(256) NOT NULL,
	field_140 VARCHAR(256) NOT NULL,
	field_141 VARCHAR(256) NOT NULL,
	field_142 VARCHAR(256) NOT NULL,
	field_143 VARCHAR(256) NOT NULL,
	field_144 VARCHAR(256) NOT NULL,
	field_145 VARCHAR(256) NOT NULL,
	field_146 VARCHAR(256) NOT NULL,
	field_147 VARCHAR(256) NOT NULL,
	field_148 VARCHAR(256) NOT NULL,
	field_149 VARCHAR(256) NOT NULL,
	field_150 VARCHAR(256) NOT NULL
	) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=Compact;


2. 创建表在Server层和InnoDB层的校验

	Server层：
		mysql> select 150*100;
		+---------+
		| 150*100 |
		+---------+
		|   15000 |
		+---------+
		1 row in set (0.00 sec)
	
		15000 < 65535， 因此在 Server 层可以校验通过。
	
	InnoDB层：
		latin1字符集下VARCHAR(256) 大于 40个字节，因此按照40个字节来计算长度
		
		select 100*40 = 4000;
			
		4000 < 8126, 因此在 InnoDB层可以校验通过。
		
	select concat("repeat('y',", "100),")  from table_20201116 limit 242;

	
3. 插入数据报错Row size too large (> 8126)

	insert into table_20201118_01 values(
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100),
	repeat('y',100)
	);

	[Err] 1118 - Row size too large (> 8126). Changing some columns to TEXT or BLOB or using ROW_FORMAT=DYNAMIC or ROW_FORMAT=COMPRESSED may help. 
	In current row format, BLOB prefix of 768 bytes is stored inline.
	
	单行记录的空间存不下15000个字节的数据，varchar(256)没有存储为溢出页，因此报错：Row size too large (> 8126)


4. 行溢出
	
	mysql> select 150*100;
	+---------+
	| 150*100 |
	+---------+
	|   15000 |
	+---------+
	1 row in set (0.00 sec)

	-- 单行记录的空间存不下15000个字节的数据。




