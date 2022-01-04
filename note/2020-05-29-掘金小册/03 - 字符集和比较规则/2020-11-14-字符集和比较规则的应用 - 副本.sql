

服务器级别的字符集和比较规则
	mysql> show global variables like '%_server%';
	+---------------------------------+-----------------+
	| Variable_name                   | Value           |
	+---------------------------------+-----------------+
	| character_set_server            | utf8            |
	| collation_server                | utf8_general_ci |
	| innodb_ft_server_stopword_table |                 |
	+---------------------------------+-----------------+
	3 rows in set (0.00 sec)


	character_set_server ：服务器级别的字符集
	collation_server ：    服务器级别的比较规则



数据库级别的字符集和比较规则

	mysql>show global variables like '%_database%';
	+------------------------+-----------------+
	| Variable_name          | Value           |
	+------------------------+-----------------+
	| character_set_database | utf8            |
	| collation_database     | utf8_general_ci |
	| skip_show_database     | OFF             |
	+------------------------+-----------------+
	3 rows in set (0.01 sec)

	character_set_database : 当前数据库的字符集
	collation_database : 	 当前数据库的比较规则

  

下面的几个变量跟乱码没有什么关系
	character_set_client·    ： 服务器认为请求是按照该系统变量指定的字符集进行编码的
	character_set_connection ： 服务器在处理请求时，会把请求字节序列从 character_set_client· 转换为 character_set_connection
	character_set_results	 ： 服务器采用该系统变量指定的字符集对返回客户端的字符串进行编码



服务器级别的字符集	
character-set-server = utf8mb4
服务器级别的排序规则
collation-server=utf8mb4_general_ci


https://blog.csdn.net/sun8112133/article/details/79921734


参数character-set-server = utf8/utf8mb4的系统变量
	
	1. character-set-server = utf8
		
		mysql>show global variables like '%character%';
		+--------------------------+----------------------------------------------------------------+
		| Variable_name            | Value                                                          |
		+--------------------------+----------------------------------------------------------------+
		| character_set_client     | utf8                                                           |
		| character_set_connection | utf8                                                           |
		| character_set_database   | utf8                                                           |
		| character_set_filesystem | binary                                                         |
		| character_set_results    | utf8                                                           |
		| character_set_server     | utf8                                                           |
		| character_set_system     | utf8                                                           |
		| character_sets_dir       | /opt/mysql/mysql-5.7.19-linux-glibc2.12-x86_64/share/charsets/ |
		+--------------------------+----------------------------------------------------------------+
		8 rows in set (0.00 sec)


		mysql>show global variables like '%collation_server%';
		+------------------+-----------------+
		| Variable_name    | Value           |
		+------------------+-----------------+
		| collation_server | utf8_general_ci |
		+------------------+-----------------+
		1 row in set (0.01 sec)

		mysql>show global variables like '%collation_database%';
		+--------------------+-----------------+
		| Variable_name      | Value           |
		+--------------------+-----------------+
		| collation_database | utf8_general_ci |
		+--------------------+-----------------+
		1 row in set (0.01 sec)
		
	2. character-set-server = utf8mb4
	
		mysql>show global variables like '%character%';
		+--------------------------+----------------------------------------------------------------+
		| Variable_name            | Value                                                          |
		+--------------------------+----------------------------------------------------------------+
		| character_set_client     | utf8mb4                                                        |
		| character_set_connection | utf8mb4                                                        |
		| character_set_database   | utf8mb4                                                        |
		| character_set_filesystem | binary                                                         |
		| character_set_results    | utf8mb4                                                        |
		| character_set_server     | utf8mb4                                                        |
		| character_set_system     | utf8                                                           |    -- 数据库系统使用的编码格式，这个值一直是utf8，不需要设置，它是为存储系统元数据的编码格式。 The character set used by the server for storing identifiers. The value is always utf8.

		| character_sets_dir       | /opt/mysql/mysql-5.7.19-linux-glibc2.12-x86_64/share/charsets/ |
		+--------------------------+----------------------------------------------------------------+
		8 rows in set (0.00 sec)
	
		mysql> show global variables like '%collation_server%';
		+------------------+--------------------+
		| Variable_name    | Value              |
		+------------------+--------------------+
		| collation_server | utf8mb4_general_ci |
		+------------------+--------------------+
		1 row in set (0.01 sec)

		mysql>show global variables like '%collation_database%';
		+--------------------+--------------------+
		| Variable_name      | Value              |
		+--------------------+--------------------+
		| collation_database | utf8mb4_general_ci |
		+--------------------+--------------------+
		1 row in set (0.00 sec)
		
	



字符集的查看

	mysql> SHOW CHARSET;
	+----------+---------------------------------+---------------------+--------+
	| Charset  | Description                     | Default collation   | Maxlen |
	+----------+---------------------------------+---------------------+--------+
	| big5     | Big5 Traditional Chinese        | big5_chinese_ci     |      2 |
	| dec8     | DEC West European               | dec8_swedish_ci     |      1 |
	| cp850    | DOS West European               | cp850_general_ci    |      1 |
	| hp8      | HP West European                | hp8_english_ci      |      1 |
	| koi8r    | KOI8-R Relcom Russian           | koi8r_general_ci    |      1 |
	| latin1   | cp1252 West European            | latin1_swedish_ci   |      1 |
	| latin2   | ISO 8859-2 Central European     | latin2_general_ci   |      1 |
	| swe7     | 7bit Swedish                    | swe7_swedish_ci     |      1 |
	| ascii    | US ASCII                        | ascii_general_ci    |      1 |
	| ujis     | EUC-JP Japanese                 | ujis_japanese_ci    |      3 |
	| sjis     | Shift-JIS Japanese              | sjis_japanese_ci    |      2 |
	| hebrew   | ISO 8859-8 Hebrew               | hebrew_general_ci   |      1 |
	| tis620   | TIS620 Thai                     | tis620_thai_ci      |      1 |
	| euckr    | EUC-KR Korean                   | euckr_korean_ci     |      2 |
	| koi8u    | KOI8-U Ukrainian                | koi8u_general_ci    |      1 |
	| gb2312   | GB2312 Simplified Chinese       | gb2312_chinese_ci   |      2 |
	| greek    | ISO 8859-7 Greek                | greek_general_ci    |      1 |
	| cp1250   | Windows Central European        | cp1250_general_ci   |      1 |
	| gbk      | GBK Simplified Chinese          | gbk_chinese_ci      |      2 |
	| latin5   | ISO 8859-9 Turkish              | latin5_turkish_ci   |      1 |
	| armscii8 | ARMSCII-8 Armenian              | armscii8_general_ci |      1 |
	| utf8     | UTF-8 Unicode                   | utf8_general_ci     |      3 |
	| ucs2     | UCS-2 Unicode                   | ucs2_general_ci     |      2 |
	| cp866    | DOS Russian                     | cp866_general_ci    |      1 |
	| keybcs2  | DOS Kamenicky Czech-Slovak      | keybcs2_general_ci  |      1 |
	| macce    | Mac Central European            | macce_general_ci    |      1 |
	| macroman | Mac West European               | macroman_general_ci |      1 |
	| cp852    | DOS Central European            | cp852_general_ci    |      1 |
	| latin7   | ISO 8859-13 Baltic              | latin7_general_ci   |      1 |
	| utf8mb4  | UTF-8 Unicode                   | utf8mb4_general_ci  |      4 |
	| cp1251   | Windows Cyrillic                | cp1251_general_ci   |      1 |
	| utf16    | UTF-16 Unicode                  | utf16_general_ci    |      4 |
	| utf16le  | UTF-16LE Unicode                | utf16le_general_ci  |      4 |
	| cp1256   | Windows Arabic                  | cp1256_general_ci   |      1 |
	| cp1257   | Windows Baltic                  | cp1257_general_ci   |      1 |
	| utf32    | UTF-32 Unicode                  | utf32_general_ci    |      4 |
	| binary   | Binary pseudo charset           | binary              |      1 |
	| geostd8  | GEOSTD8 Georgian                | geostd8_general_ci  |      1 |
	| cp932    | SJIS for Windows Japanese       | cp932_japanese_ci   |      2 |
	| eucjpms  | UJIS for Windows Japanese       | eucjpms_japanese_ci |      3 |
	| gb18030  | China National Standard GB18030 | gb18030_chinese_ci  |      4 |
	+----------+---------------------------------+---------------------+--------+
	41 rows in set (0.00 sec)
	
	
	Maxlen，它代表该种字符集表示一个字符最多需要几个字节.
	
	几个常用到的字符集的Maxlen列：

		字符集名称	Maxlen
		ascii		1
		latin1		1
		gb2312		2
		gbk			2
		utf8		3
		utf8mb4		4
		
		

比较规则的查看
	只查看一下utf8字符集下的比较规则：
		root@mysqldb 11:22:  [(none)]> SHOW COLLATION LIKE 'utf8\_%';
		+--------------------------+---------+-----+---------+----------+---------+
		| Collation                | Charset | Id  | Default | Compiled | Sortlen |
		+--------------------------+---------+-----+---------+----------+---------+
		| utf8_general_ci          | utf8    |  33 | Yes     | Yes      |       1 |
		| utf8_bin                 | utf8    |  83 |         | Yes      |       1 |
		| utf8_unicode_ci          | utf8    | 192 |         | Yes      |       8 |
		| utf8_icelandic_ci        | utf8    | 193 |         | Yes      |       8 |
		| utf8_latvian_ci          | utf8    | 194 |         | Yes      |       8 |
		| utf8_romanian_ci         | utf8    | 195 |         | Yes      |       8 |
		| utf8_slovenian_ci        | utf8    | 196 |         | Yes      |       8 |
		| utf8_polish_ci           | utf8    | 197 |         | Yes      |       8 |
		| utf8_estonian_ci         | utf8    | 198 |         | Yes      |       8 |
		| utf8_spanish_ci          | utf8    | 199 |         | Yes      |       8 |
		| utf8_swedish_ci          | utf8    | 200 |         | Yes      |       8 |
		| utf8_turkish_ci          | utf8    | 201 |         | Yes      |       8 |
		| utf8_czech_ci            | utf8    | 202 |         | Yes      |       8 |
		| utf8_danish_ci           | utf8    | 203 |         | Yes      |       8 |
		| utf8_lithuanian_ci       | utf8    | 204 |         | Yes      |       8 |
		| utf8_slovak_ci           | utf8    | 205 |         | Yes      |       8 |
		| utf8_spanish2_ci         | utf8    | 206 |         | Yes      |       8 |
		| utf8_roman_ci            | utf8    | 207 |         | Yes      |       8 |
		| utf8_persian_ci          | utf8    | 208 |         | Yes      |       8 |
		| utf8_esperanto_ci        | utf8    | 209 |         | Yes      |       8 |
		| utf8_hungarian_ci        | utf8    | 210 |         | Yes      |       8 |
		| utf8_sinhala_ci          | utf8    | 211 |         | Yes      |       8 |
		| utf8_german2_ci          | utf8    | 212 |         | Yes      |       8 |
		| utf8_croatian_ci         | utf8    | 213 |         | Yes      |       8 |
		| utf8_unicode_520_ci      | utf8    | 214 |         | Yes      |       8 |
		| utf8_vietnamese_ci       | utf8    | 215 |         | Yes      |       8 |
		| utf8_general_mysql500_ci | utf8    | 223 |         | Yes      |       1 |
		+--------------------------+---------+-----+---------+----------+---------+
		27 rows in set (0.00 sec)

		utf8_general_ci 和  utf8_unicode_ci 的差异
		
		utf8_general_ci 是一种通用的比较规则。
		
	
比较规则

	比较规则有时也称为排序规则，用于在字符串比较大小时规定其顺序的
	同一种字符集可以有多种比较规则

命名规则

	每一种字符集都可能对应多种比较规则，这些比较规则命名规律为

		比较规则名称以对应的字符集名称开头
		中间部分表示主要用于哪种语言
		后缀有以下几种：
			后缀	全称					含义
			`_ai`	accent insensitive		不区分重音
			`_as`	accent sensitive		区分重音
			`_ci`	case insensitive		不区分大小写
			`_cs`	case sensitive			区分大小写
			`_bin`	binary					以二进制方式比较
			
		
		示例： `utf8_spanish_ci` 表示以西班牙语比较，且不区分大小写




字符集和比较规则的应用




