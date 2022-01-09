drop table if exists table_20201117_01;
CREATE TABLE `table_20201117_01` (
field_1 text,
field_2 text,
field_3 text,
field_4 text,
field_5 text,
field_6 text,
field_7 text,
field_8 text,
field_9 text,
field_10 text,
field_11 text,
field_12 text,
field_13 text,
field_14 text,
field_15 text,
field_16 text,
field_17 text,
field_18 text,
field_19 text,
field_20 text,
field_21 text,
field_22 text,
field_23 text,
field_24 text,
field_25 text,
field_26 text,
field_27 text,
field_28 text,
field_29 text,
field_30 text,
field_31 text,
field_32 text,
field_33 text,
field_34 text,
field_35 text,
field_36 text,
field_37 text,
field_38 text,
field_39 text,
field_40 text,
field_41 text,
field_42 text,
field_43 text,
field_44 text,
field_45 text,
field_46 text,
field_47 text,
field_48 text,
field_49 text,
field_50 text,
field_51 text,
field_52 text,
field_53 text,
field_54 text,
field_55 text,
field_56 text,
field_57 text,
field_58 text,
field_59 text,
field_60 text,
field_61 text,
field_62 text,
field_63 text,
field_64 text,
field_65 text,
field_66 text,
field_67 text,
field_68 text,
field_69 text,
field_70 text,
field_71 text,
field_72 text,
field_73 text,
field_74 text,
field_75 text,
field_76 text,
field_77 text,
field_78 text,
field_79 text,
field_80 text,
field_81 text,
field_82 text,
field_83 text,
field_84 text,
field_85 text,
field_86 text,
field_87 text,
field_88 text,
field_89 text,
field_90 text,
field_91 text,
field_92 text,
field_93 text,
field_94 text,
field_95 text,
field_96 text,
field_97 text,
field_98 text,
field_99 text,
field_100 text,
field_101 text,
field_102 text,
field_103 text,
field_104 text,
field_105 text,
field_106 text,
field_107 text,
field_108 text,
field_109 text,
field_110 text,
field_111 text,
field_112 text,
field_113 text,
field_114 text,
field_115 text,
field_116 text,
field_117 text,
field_118 text,
field_119 text,
field_120 text,
field_121 text,
field_122 text,
field_123 text,
field_124 text,
field_125 text,
field_126 text,
field_127 text,
field_128 text,
field_129 text,
field_130 text,
field_131 text,
field_132 text,
field_133 text,
field_134 text,
field_135 text,
field_136 text,
field_137 text,
field_138 text,
field_139 text,
field_140 text,
field_141 text,
field_142 text,
field_143 text,
field_144 text,
field_145 text,
field_146 text,
field_147 text,
field_148 text,
field_149 text,
field_150 text,
field_151 text,
field_152 text,
field_153 text,
field_154 text,
field_155 text,
field_156 text,
field_157 text,
field_158 text,
field_159 text,
field_160 text,
field_161 text,
field_162 text,
field_163 text,
field_164 text,
field_165 text,
field_166 text,
field_167 text,
field_168 text,
field_169 text,
field_170 text,
field_171 text,
field_172 text,
field_173 text,
field_174 text,
field_175 text,
field_176 text,
field_177 text,
field_178 text,
field_179 text,
field_180 text,
field_181 text,
field_182 text,
field_183 text,
field_184 text,
field_185 text,
field_186 text,
field_187 text,
field_188 text,
field_189 text,
field_190 text,
field_191 text,
field_192 text,
field_193 text,
field_194 text,
field_195 text,
field_196 text,
field_197 text
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=Compact;
[Err] 1118 - Row size too large (> 8126). Changing some columns to TEXT or BLOB or using ROW_FORMAT=DYNAMIC or ROW_FORMAT=COMPRESSED may help. In current row format, BLOB prefix of 768 bytes is stored inline.


    -> field_196 text
    -> ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=Compact;
Query OK, 0 rows affected, 1 warning (0.51 sec)



132个字节：
 
	每个页除了存放我们的记录以外，也需要存储一些额外的信息，乱七八糟的额外信息加起来需要132个字节的空间（现在只要知道这个数字就好了），其他的空间都可以被用来存储记录。
	1个数据页是16KB = 16384 byte，16384 - 132 = 16252 byte，由于每个数据页最少要存储2条记录，因此行内保留的数据长度不能大于8126，否则会导致数据写入失败。
	
	select 16252/2 = 8126
	
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
		
		
		
		
		