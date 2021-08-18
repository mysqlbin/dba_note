

《2021-08-18-1个案例》 属于大字段列的溢出


2020-11-18-insert出现8126的错误-latin1 varchar(100) Compact.sql
2020-11-18-insert出现8126的错误-latin1 varchar(100) Dymanic.sql

Antelope格式下的COMPACT大字段按照 DICT_ANTELOPE_MAX_INDEX_COL_LEN（768）字节溢出页。varchar(100)没有存储为溢出页。

Barracuda的DYNAMIC和COMPRESSED格式下只有长字段才会用20字节溢出页的方式，varchar(100)也没有存储为溢出页。