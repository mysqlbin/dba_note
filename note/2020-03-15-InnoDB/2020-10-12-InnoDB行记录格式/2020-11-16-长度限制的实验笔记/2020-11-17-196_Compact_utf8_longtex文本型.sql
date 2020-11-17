drop table if exists table_20201117_01;
CREATE TABLE `table_20201117_01` (
field_1 longtext,
field_2 longtext,
field_3 longtext,
field_4 longtext,
field_5 longtext,
field_6 longtext,
field_7 longtext,
field_8 longtext,
field_9 longtext,
field_10 longtext,
field_11 longtext,
field_12 longtext,
field_13 longtext,
field_14 longtext,
field_15 longtext,
field_16 longtext,
field_17 longtext,
field_18 longtext,
field_19 longtext,
field_20 longtext,
field_21 longtext,
field_22 longtext,
field_23 longtext,
field_24 longtext,
field_25 longtext,
field_26 longtext,
field_27 longtext,
field_28 longtext,
field_29 longtext,
field_30 longtext,
field_31 longtext,
field_32 longtext,
field_33 longtext,
field_34 longtext,
field_35 longtext,
field_36 longtext,
field_37 longtext,
field_38 longtext,
field_39 longtext,
field_40 longtext,
field_41 longtext,
field_42 longtext,
field_43 longtext,
field_44 longtext,
field_45 longtext,
field_46 longtext,
field_47 longtext,
field_48 longtext,
field_49 longtext,
field_50 longtext,
field_51 longtext,
field_52 longtext,
field_53 longtext,
field_54 longtext,
field_55 longtext,
field_56 longtext,
field_57 longtext,
field_58 longtext,
field_59 longtext,
field_60 longtext,
field_61 longtext,
field_62 longtext,
field_63 longtext,
field_64 longtext,
field_65 longtext,
field_66 longtext,
field_67 longtext,
field_68 longtext,
field_69 longtext,
field_70 longtext,
field_71 longtext,
field_72 longtext,
field_73 longtext,
field_74 longtext,
field_75 longtext,
field_76 longtext,
field_77 longtext,
field_78 longtext,
field_79 longtext,
field_80 longtext,
field_81 longtext,
field_82 longtext,
field_83 longtext,
field_84 longtext,
field_85 longtext,
field_86 longtext,
field_87 longtext,
field_88 longtext,
field_89 longtext,
field_90 longtext,
field_91 longtext,
field_92 longtext,
field_93 longtext,
field_94 longtext,
field_95 longtext,
field_96 longtext,
field_97 longtext,
field_98 longtext,
field_99 longtext,
field_100 longtext,
field_101 longtext,
field_102 longtext,
field_103 longtext,
field_104 longtext,
field_105 longtext,
field_106 longtext,
field_107 longtext,
field_108 longtext,
field_109 longtext,
field_110 longtext,
field_111 longtext,
field_112 longtext,
field_113 longtext,
field_114 longtext,
field_115 longtext,
field_116 longtext,
field_117 longtext,
field_118 longtext,
field_119 longtext,
field_120 longtext,
field_121 longtext,
field_122 longtext,
field_123 longtext,
field_124 longtext,
field_125 longtext,
field_126 longtext,
field_127 longtext,
field_128 longtext,
field_129 longtext,
field_130 longtext,
field_131 longtext,
field_132 longtext,
field_133 longtext,
field_134 longtext,
field_135 longtext,
field_136 longtext,
field_137 longtext,
field_138 longtext,
field_139 longtext,
field_140 longtext,
field_141 longtext,
field_142 longtext,
field_143 longtext,
field_144 longtext,
field_145 longtext,
field_146 longtext,
field_147 longtext,
field_148 longtext,
field_149 longtext,
field_150 longtext,
field_151 longtext,
field_152 longtext,
field_153 longtext,
field_154 longtext,
field_155 longtext,
field_156 longtext,
field_157 longtext,
field_158 longtext,
field_159 longtext,
field_160 longtext,
field_161 longtext,
field_162 longtext,
field_163 longtext,
field_164 longtext,
field_165 longtext,
field_166 longtext,
field_167 longtext,
field_168 longtext,
field_169 longtext,
field_170 longtext,
field_171 longtext,
field_172 longtext,
field_173 longtext,
field_174 longtext,
field_175 longtext,
field_176 longtext,
field_177 longtext,
field_178 longtext,
field_179 longtext,
field_180 longtext,
field_181 longtext,
field_182 longtext,
field_183 longtext,
field_184 longtext,
field_185 longtext,
field_186 longtext,
field_187 longtext,
field_188 longtext,
field_189 longtext,
field_190 longtext,
field_191 longtext,
field_192 longtext,
field_193 longtext,
field_194 longtext,
field_195 longtext,
field_196 longtext,
field_197 longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=Compact;
[Err] 1118 - Row size too large (> 8126). Changing some columns to longtext or longtext or using ROW_FORMAT=DYNAMIC or ROW_FORMAT=COMPRESSED may help. In current row format, longtext prefix of 768 bytes is stored inline.


utf8字符集下的longtext文本型长度，超过40个字节，那么就按40个字节;
	197字段的计算
		mysql> select 197*40;
		+--------+
		| 197*40 |
		+--------+
		|   7880 |
		+--------+
		1 row in set (0.00 sec)

		
		mysql> select 197*40+197+5+6+6+7;
		+--------------------+
		| 197*40+197+5+6+6+7 |
		+--------------------+
		|               8101 |
		+--------------------+
		1 row in set (0.00 sec)

			+197 表示 占用 变长列表长度为 197个byte
			+5 	 表示 占用 额外的头信息 5个byte
			+6 	 表示 rowid 占用 6个byte
			+6 	 表示 事务ID 占用 6个byte
			+7 	 表示 回滚指针 占用 7个byte
		8101 > 8126 ：创建成功
		
	198字段的计算		
		mysql> select 198*40;
		+--------+
		| 198*40 |
		+--------+
		|   7920 |
		+--------+
		1 row in set (0.00 sec)
		
		mysql> select 198*40+197+5+6+6+7;
		+--------------------+
		| 198*40+197+5+6+6+7 |
		+--------------------+
		|               8141 |
		+--------------------+
		1 row in set (0.00 sec)
		
		8141 > 8126 ：创建失败
	-- 这里可以对应上.