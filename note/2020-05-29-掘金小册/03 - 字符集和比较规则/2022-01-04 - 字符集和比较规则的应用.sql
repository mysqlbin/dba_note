

字符集和比较规则简介

字符集简介
	字符集指的是某个字符范围的编码规则
	由于计算机中只能存储二进制数据，当需要存储字符串的时候，需要建立字符与二进制数据的映射关系
	将一个字符映射成一个二进制数据的过程也叫做编码，将一个二进制数据映射到一个字符的过程叫做解码。
	
	
	举例说明：字符集的概念来描述某个字符范围的编码规则
	
		自定义一个名称为 xiaohaizi 的字符集，它包含的字符范围和编码规则如下：
		
			包含的字符范围：
				'a'、'b'、'A'、'B'。
		
			编码规则如下：
			
				采用1个字节编码一个字符的形式，字符和字节的映射关系如下：
					'a' -> 00000001 (十六进制：0x01)
					'b' -> 00000010 (十六进制：0x02)
					'A' -> 00000011 (十六进制：0x03)
					'B' -> 00000100 (十六进制：0x04)
				
		有了 xiaohaizi 字符集，我们就可以用二进制形式表示一些字符串了，下边是一些字符串用xiaohaizi字符集编码后的二进制表示：

			'bA' -> 0000001000000011  (十六进制：0x0203)
			'baB' -> 000000100000000100000100  (十六进制：0x020104)
			'cd' -> 无法表示，字符集xiaohaizi不包含字符'c'和'd'
		
		
		
比较规则简介

	比较规则是针对某个字符集中的字符比较大小的一种规则。
	比如是否区分大小写等
	


一些重要的字符集



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

	各级别的字符集和比较规则
		MySQL有4个级别的字符集和比较规则，分别是：

			服务器级别
			数据库级别
			表级别
			列级别


服务器级别的字符集和比较规则

	mysql> show global variables like '%_server%';
	+---------------------------------+--------------------+
	| Variable_name                   | Value              |
	+---------------------------------+--------------------+
	| character_set_server            | utf8mb4            |   -- 服务器级别的字符集
	| collation_server                | utf8mb4_general_ci |   -- 服务器级别的排序规则
	| innodb_ft_server_stopword_table |                    |
	+---------------------------------+--------------------+
	3 rows in set (0.00 sec)


	配置文件：
		character-set-server = utf8mb4     	-- 服务器级别的字符集
		collation-server=utf8mb4_general_ci -- 服务器级别的排序规则


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
			
			

数据库级别的字符集和比较规则

	mysql>show global variables like '%_database%';
	+------------------------+-----------------+
	| Variable_name          | Value           |
	+------------------------+-----------------+
	| character_set_database | utf8            |    -- 当前数据库的字符集
	| collation_database     | utf8_general_ci |	-- 当前数据库的比较规则
	| skip_show_database     | OFF             |	
	+------------------------+-----------------+
	3 rows in set (0.01 sec)
	
	character_set_database 和 collation_database 这两个系统变量是只读的，我们不能通过修改这两个变量的值而改变当前数据库的字符集和比较规则。

	语法：

		CREATE DATABASE 数据库名
			[[DEFAULT] CHARACTER SET 字符集名称]
			[[DEFAULT] COLLATE 比较规则名称];

		ALTER DATABASE 数据库名
			[[DEFAULT] CHARACTER SET 字符集名称]
			[[DEFAULT] COLLATE 比较规则名称];
			

	创建字符集为utf8mb4 和排序规则为utf8mb4_general_ci的数据库
		
		mysql> create  database sbtest CHARACTER set utf8mb4 COLLATE utf8mb4_general_ci;

		Query OK, 1 row affected (0.11 sec)


		mysql> SHOW VARIABLES LIKE 'character_set_database';
		+------------------------+---------+
		| Variable_name          | Value   |
		+------------------------+---------+
		| character_set_database | utf8mb4 |
		+------------------------+---------+
		1 row in set (0.00 sec)

		mysql> SHOW VARIABLES LIKE 'collation_database';
		+--------------------+--------------------+
		| Variable_name      | Value              |
		+--------------------+--------------------+
		| collation_database | utf8mb4_general_ci |
		+--------------------+--------------------+
		1 row in set (0.00 sec)




表级别的字符集和比较规则
	
	语法：
		CREATE TABLE 表名 (列的信息)
			[[DEFAULT] CHARACTER SET 字符集名称]
			[COLLATE 比较规则名称]]

		ALTER TABLE 表名
			[[DEFAULT] CHARACTER SET 字符集名称]
			[COLLATE 比较规则名称]


列级别的字符集和比较规则
	语法：
		CREATE TABLE 表名(
			列名 字符串类型 [CHARACTER SET 字符集名称] [COLLATE 比较规则名称],
			其他列...
		);

		ALTER TABLE 表名 MODIFY 列名 字符串类型 [CHARACTER SET 字符集名称] [COLLATE 比较规则名称];



各级别字符集和比较规则小结

	我们介绍的这4个级别字符集和比较规则的联系如下：

		如果创建或修改列时没有显式的指定字符集和比较规则，则该列默认用表的字符集和比较规则
		
		如果创建表时没有显式的指定字符集和比较规则，则该表默认用数据库的字符集和比较规则
		
		如果创建数据库时没有显式的指定字符集和比较规则，则该数据库默认用服务器的字符集和比较规则
	
	
编码和解码使用的字符集不一致的后果

	对于同一个字符串编码和解码使用的字符集不一样，会产生意想不到的结果，作为人类的我们看上去就像是产生了乱码一样。
	

MySQL中字符集的转换

	从发送请求到接收结果过程中发生的字符集转换：

		1. 客户端使用操作系统的字符集编码请求字符串，向服务器发送的是经过编码的一个字节串。

		2. 服务器将客户端发送来的字节串采用 character_set_client 代表的字符集进行解码，将解码后的字符串再按照 character_set_connection 代表的字符集进行编码。

		3. 如果 character_set_connection 代表的字符集和具体操作的列使用的字符集一致，则直接进行相应操作
			否则的话需要将请求中的字符串 从 character_set_connection 代表的字符集转换为具体操作的列使用的字符集之后再进行操作。

		4. 将从某个列获取到的字节串从该列使用的字符集转换为 character_set_results 代表的字符集后发送到客户端。


			假设你的客户端采用的字符集和 character_set_results 不一样的话，这就可能会出现客户端无法解码结果集的情况，结果就是在你的屏幕上出现乱码。
			比如我的客户端使用的是utf8字符集，如果把系统变量character_set_results的值设置为ascii的话，可能会产生乱码。



		5. 客户端使用操作系统的字符集解析收到的结果集字节串。
		
		6. 参考图片：《2022-01-04 - 请求从发送到结果返回过程中字符集的变化.png》
		
	在这个过程中各个系统变量的含义如下：
	
		character_set_client·    ： 服务器解码请求时使用的字符集

		character_set_connection ： 服务器处理请求时会把请求字符串从character_set_client转为character_set_connection

		character_set_results	 ： 服务器向客户端返回数据时使用的字符集
		
	
	-- 上面的几个变量跟乱码没有什么关系
	
	通常都把 character_set_client 、character_set_connection、character_set_results 这三个系统变量设置成和客户端使用的字符集一致的情况，这样减少了很多无谓的字符集转换。
	
	如何修改这3个变量：
	
		SET NAMES 字符集名;
		-- 等价于
		SET character_set_client = 字符集名;
		SET character_set_connection = 字符集名;
		SET character_set_results = 字符集名;		
				


	如果想在启动客户端的时候就把character_set_client、character_set_connection、character_set_results这三个系统变量的值设置成一样的，那我们可以在启动客户端的时候指定一个叫default-character-set的启动选项，比如在配置文件里可以这么写：

		[client]
		default-character-set=字符集名
		
		

		
	
比较规则的应用

	mysql>  show global variables like '%_server%';
	+---------------------------------+--------------------+
	| Variable_name                   | Value              |
	+---------------------------------+--------------------+
	| character_set_server            | utf8mb4            |
	| collation_server                | utf8mb4_0900_ai_ci |
	| innodb_dedicated_server         | OFF                |
	| innodb_ft_server_stopword_table |                    |
	+---------------------------------+--------------------+
	4 rows in set (0.45 sec)


	create  database sbtest_03 CHARACTER set utf8mb4 COLLATE utf8mb4_general_ci;
	use sbtest_03;
	
	---------------------------------------------------------------------------------------------------------
	
	
	CHARACTER=gbk and COLLATE = gbk_chinese_ci
		
		DROP TABLE IF EXISTS `t`;
		CREATE TABLE `t` (
		  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `col` varchar(256) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL DEFAULT '' COMMENT '备注',
		  PRIMARY KEY (`ID`)
		) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 comment="";

		mysql> show create table t\G;
		*************************** 1. row ***************************
			   Table: t
		Create Table: CREATE TABLE `t` (
		  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `col` varchar(256) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL DEFAULT '' COMMENT '备注',
		  PRIMARY KEY (`ID`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
		1 row in set (0.01 sec)

		INSERT INTO t(col) VALUES('a'), ('b'), ('A'), ('B');

		mysql> select * from t order by col;
		+----+-----+
		| ID | col |
		+----+-----+
		|  1 | a   |
		|  3 | A   |
		|  2 | b   |
		|  4 | B   |
		+----+-----+
		4 rows in set (0.01 sec)
		
		-- 在默认的比较规则gbk_chinese_ci中是不区分大小写的
		
		
	---------------------------------------------------------------------------------------------------------

	CHARACTER=gbk and COLLATE = gbk_bin
		
	
		ALTER TABLE t MODIFY col VARCHAR(256) COLLATE gbk_bin;

		mysql> ALTER TABLE t MODIFY col VARCHAR(256) COLLATE gbk_bin;

		Query OK, 0 rows affected (0.41 sec)
		Records: 0  Duplicates: 0  Warnings: 0

		mysql> show create table t\G;
		*************************** 1. row ***************************
			   Table: t
		Create Table: CREATE TABLE `t` (
		  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '索引',
		  `col` varchar(256) CHARACTER SET gbk COLLATE gbk_bin DEFAULT NULL,
		  PRIMARY KEY (`ID`)
		) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
		1 row in set (0.00 sec)
		
		mysql>  select * from t order by col;
		+----+------+
		| ID | col  |
		+----+------+
		|  3 | A    |
		|  4 | B    |
		|  1 | a    |
		|  2 | b    |
		+----+------+
		4 rows in set (0.00 sec)


		-- gbk_bin是直接比较字符的编码，所以是区分大小写的
		
			
		列`col`中各个字符在使用gbk字符集编码后对应的数字如下：
		'A' -> 65 （十进制）
		'B' -> 66 （十进制）
		'a' -> 97 （十进制）
		'b' -> 98 （十进制）
		'我' -> 25105 （十进制）
			
	
	
	小结：
		对字符串做比较或者对某个字符串列做排序操作时没有得到想象中的结果，需要思考一下是不是比较规则(是否有区分大小写)的问题。
	





小结：
	


https://blog.csdn.net/sun8112133/article/details/79921734


	