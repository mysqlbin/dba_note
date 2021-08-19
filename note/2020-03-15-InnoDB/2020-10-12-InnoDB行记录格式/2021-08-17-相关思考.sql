

ALTER TABLE `t_role_90`  ROW_FORMAT=DYNAMIC; 命令是否会同步到从库不？
	不会。
	


MySQL的一个表最多可以有多少个字段？
	这个是1个伪命题
	

1. varchar(N) N 大于属于大对象字段


2. 
	Antelope格式下的COMPACT大字段按照 DICT_ANTELOPE_MAX_INDEX_COL_LEN（768）字节溢出页。varchar(100)没有存储为溢出页。

	Barracuda的DYNAMIC和COMPRESSED格式下只有长字段才会用20字节溢出页的方式，varchar(100)也没有存储为溢出页。

	-- 理解了。
	

当 varchar(n) 中的 n 大于特定值时，MySQL 会自动将其转换成 text

大于 255，varchar 自动转换成 tinytext

大于 500，varchar 自动转换成 text

大于 20000，varchar 自动转换成 mediumtext

-- 这个在哪里有提到