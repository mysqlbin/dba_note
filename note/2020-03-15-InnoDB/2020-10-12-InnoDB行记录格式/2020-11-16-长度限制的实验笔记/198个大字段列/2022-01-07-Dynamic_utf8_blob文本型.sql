drop table if exists table_20201117_01;
CREATE TABLE `table_20201117_01` (
field_1 blob,
field_2 blob,
field_3 blob,
field_4 blob,
field_5 blob,
field_6 blob,
field_7 blob,
field_8 blob,
field_9 blob,
field_10 blob,
field_11 blob,
field_12 blob,
field_13 blob,
field_14 blob,
field_15 blob,
field_16 blob,
field_17 blob,
field_18 blob,
field_19 blob,
field_20 blob,
field_21 blob,
field_22 blob,
field_23 blob,
field_24 blob,
field_25 blob,
field_26 blob,
field_27 blob,
field_28 blob,
field_29 blob,
field_30 blob,
field_31 blob,
field_32 blob,
field_33 blob,
field_34 blob,
field_35 blob,
field_36 blob,
field_37 blob,
field_38 blob,
field_39 blob,
field_40 blob,
field_41 blob,
field_42 blob,
field_43 blob,
field_44 blob,
field_45 blob,
field_46 blob,
field_47 blob,
field_48 blob,
field_49 blob,
field_50 blob,
field_51 blob,
field_52 blob,
field_53 blob,
field_54 blob,
field_55 blob,
field_56 blob,
field_57 blob,
field_58 blob,
field_59 blob,
field_60 blob,
field_61 blob,
field_62 blob,
field_63 blob,
field_64 blob,
field_65 blob,
field_66 blob,
field_67 blob,
field_68 blob,
field_69 blob,
field_70 blob,
field_71 blob,
field_72 blob,
field_73 blob,
field_74 blob,
field_75 blob,
field_76 blob,
field_77 blob,
field_78 blob,
field_79 blob,
field_80 blob,
field_81 blob,
field_82 blob,
field_83 blob,
field_84 blob,
field_85 blob,
field_86 blob,
field_87 blob,
field_88 blob,
field_89 blob,
field_90 blob,
field_91 blob,
field_92 blob,
field_93 blob,
field_94 blob,
field_95 blob,
field_96 blob,
field_97 blob,
field_98 blob,
field_99 blob,
field_100 blob,
field_101 blob,
field_102 blob,
field_103 blob,
field_104 blob,
field_105 blob,
field_106 blob,
field_107 blob,
field_108 blob,
field_109 blob,
field_110 blob,
field_111 blob,
field_112 blob,
field_113 blob,
field_114 blob,
field_115 blob,
field_116 blob,
field_117 blob,
field_118 blob,
field_119 blob,
field_120 blob,
field_121 blob,
field_122 blob,
field_123 blob,
field_124 blob,
field_125 blob,
field_126 blob,
field_127 blob,
field_128 blob,
field_129 blob,
field_130 blob,
field_131 blob,
field_132 blob,
field_133 blob,
field_134 blob,
field_135 blob,
field_136 blob,
field_137 blob,
field_138 blob,
field_139 blob,
field_140 blob,
field_141 blob,
field_142 blob,
field_143 blob,
field_144 blob,
field_145 blob,
field_146 blob,
field_147 blob,
field_148 blob,
field_149 blob,
field_150 blob,
field_151 blob,
field_152 blob,
field_153 blob,
field_154 blob,
field_155 blob,
field_156 blob,
field_157 blob,
field_158 blob,
field_159 blob,
field_160 blob,
field_161 blob,
field_162 blob,
field_163 blob,
field_164 blob,
field_165 blob,
field_166 blob,
field_167 blob,
field_168 blob,
field_169 blob,
field_170 blob,
field_171 blob,
field_172 blob,
field_173 blob,
field_174 blob,
field_175 blob,
field_176 blob,
field_177 blob,
field_178 blob,
field_179 blob,
field_180 blob,
field_181 blob,
field_182 blob,
field_183 blob,
field_184 blob,
field_185 blob,
field_186 blob,
field_187 blob,
field_188 blob,
field_189 blob,
field_190 blob,
field_191 blob,
field_192 blob,
field_193 blob,
field_194 blob,
field_195 blob,
field_196 blob,
field_197 blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=Dynamic;
ERROR 1118 (42000): Row size too large (> 8126). Changing some columns to TEXT or BLOB may help. In current row format, BLOB prefix of 0 bytes is stored inline.

    -> field_196 blob
    -> ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=Dynamic;
Query OK, 0 rows affected, 1 warning (0.20 sec)






132个字节：
 
	每个页除了存放我们的记录以外，也需要存储一些额外的信息，乱七八糟的额外信息加起来需要132个字节的空间（现在只要知道这个数字就好了），其他的空间都可以被用来存储记录。
			
	mysql> select 8126*2;
	+--------+
	| 8126*2 |
	+--------+
	|  16252 |
	+--------+
	1 row in set (0.00 sec)
	
	
	mysql> select 16384 - 16252;
	+---------------+
	| 16384 - 16252 |
	+---------------+
	|           132 |
	+---------------+
	1 row in set (0.00 sec)
			
	
	行内保留的数据长度不能大于8126，否则会导致数据写入失败。
	


utf8字符集下的blob文本型长度，超过40个字节，那么就按40个字节;

	196字段的计算
		
		mysql> select 196*40;
		+--------+
		| 196*40 |
		+--------+
		|   7840 |
		+--------+
		1 row in set (0.00 sec)
		
		mysql> select (196*40)+196+25+5+6+6+7;
		+-------------------------+
		| (196*40)+196+25+5+6+6+7 |
		+-------------------------+
		|                    8085 |
		+-------------------------+
		1 row in set (0.00 sec)

		+196   表示 占用 变长列表长度为 196个byte
		+25    表示 196个NULL值占用 196个bit = 5 byte
		+5 	   表示 占用 额外的头信息 5个byte
		+6 	   表示 rowid 占用 6个byte
		+6 	   表示 事务ID 占用 6个byte
		+7 	   表示 回滚指针 占用 7个byte
		
		8084 < 8126 ：创建成功	
			
		
		
	197字段的计算	
	
		mysql> select 197*40;
		+--------+
		| 197*40 |
		+--------+
		|   7880 |
		+--------+
		1 row in set (0.00 sec)

				
		mysql> select (197*40)+197+25+5+6+6+7;
		+-------------------------+
		| (197*40)+197+25+5+6+6+7 |
		+-------------------------+
		|                    8126 |
		+-------------------------+
		1 row in set (0.00 sec)


		+197   表示 占用 变长列表长度为 197个byte
		+25    表示  197个bit = 25 byte
		+5 	   表示 占用 额外的头信息 5个byte
		+6 	   表示 rowid 占用 6个byte
		+6 	   表示 事务ID 占用 6个byte
		+7 	   表示 回滚指针 占用 7个byte
		
		
		8126 = 8126 ：创建失败
		
		-- 这里可以对应上.
		
		-- 很棒的1个分析，同时做到不断更新自己的认知。
		
		
		
		
		