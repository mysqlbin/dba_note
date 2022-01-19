
INNODB_SYS_TABLES

	root@mysqldb 15:29:  [(none)]> SELECT * FROM INFORMATION_SCHEMA.INNODB_SYS_TABLES where SPACE_TYPE="System" limit 1;
	+----------+---------------+------+--------+-------+-------------+------------+---------------+------------+
	| TABLE_ID | NAME          | FLAG | N_COLS | SPACE | FILE_FORMAT | ROW_FORMAT | ZIP_PAGE_SIZE | SPACE_TYPE |
	+----------+---------------+------+--------+-------+-------------+------------+---------------+------------+
	|       14 | SYS_DATAFILES |    0 |      5 |     0 | Antelope    | Redundant  |             0 | System     |
	+----------+---------------+------+--------+-------+-------------+------------+---------------+------------+
	1 row in set (0.00 sec)

	
	root@mysqldb 15:31:  [(none)]> SELECT * FROM INFORMATION_SCHEMA.INNODB_SYS_TABLES where SPACE_TYPE="Single" limit 1;
	+----------+--------------------------------------------------------+------+--------+-------+-------------+------------+---------------+------------+
	| TABLE_ID | NAME                                                   | FLAG | N_COLS | SPACE | FILE_FORMAT | ROW_FORMAT | ZIP_PAGE_SIZE | SPACE_TYPE |
	+----------+--------------------------------------------------------+------+--------+-------+-------------+------------+---------------+------------+
	|   341783 | audit_db/FTS_0000000000053711_000000000006da11_INDEX_1 |   33 |      8 |  2024 | Barracuda   | Dynamic    |             0 | Single     |
	+----------+--------------------------------------------------------+------+--------+-------+-------------+------------+---------------+------------+
	1 row in set (0.00 sec)


INNODB_SYS_COLUMNS

	root@mysqldb 15:36:  [(none)]> SELECT * FROM INFORMATION_SCHEMA.INNODB_SYS_COLUMNS limit 5;
	+----------+----------+-----+-------+---------+-----+
	| TABLE_ID | NAME     | POS | MTYPE | PRTYPE  | LEN |
	+----------+----------+-----+-------+---------+-----+
	|       11 | ID       |   0 |     1 | 2949124 |   0 |
	|       11 | FOR_NAME |   1 |     1 | 2949124 |   0 |
	|       11 | REF_NAME |   2 |     1 | 2949124 |   0 |
	|       11 | N_COLS   |   3 |     6 |       0 |   4 |
	|       12 | ID       |   0 |     1 | 2949124 |   0 |
	+----------+----------+-----+-------+---------+-----+
	5 rows in set (0.02 sec)

INNODB_SYS_INDEXES

	root@mysqldb 15:36:  [(none)]> SELECT * FROM INFORMATION_SCHEMA.INNODB_SYS_INDEXES limit 10;
	+----------+-----------------------+----------+------+----------+---------+-------+-----------------+
	| INDEX_ID | NAME                  | TABLE_ID | TYPE | N_FIELDS | PAGE_NO | SPACE | MERGE_THRESHOLD |
	+----------+-----------------------+----------+------+----------+---------+-------+-----------------+
	|       11 | ID_IND                |       11 |    3 |        1 |     270 |     0 |              50 |
	|       12 | FOR_IND               |       11 |    0 |        1 |     271 |     0 |              50 |
	|       13 | REF_IND               |       11 |    0 |        1 |     272 |     0 |              50 |
	|       14 | ID_IND                |       12 |    3 |        2 |     273 |     0 |              50 |
	|       15 | SYS_TABLESPACES_SPACE |       13 |    3 |        1 |     275 |     0 |              50 |
	|       16 | SYS_DATAFILES_SPACE   |       14 |    3 |        1 |     276 |     0 |              50 |
	|       17 | BASE_IDX              |       15 |    3 |        3 |     278 |     0 |              50 |
	|       18 | PRIMARY               |       16 |    3 |        1 |       3 |     2 |              50 |
	|       19 | PRIMARY               |       17 |    3 |        1 |       3 |     3 |              50 |
	|       27 | PRIMARY               |       22 |    3 |        1 |       3 |     8 |              50 |
	+----------+-----------------------+----------+------+----------+---------+-------+-----------------+
	10 rows in set (0.00 sec)


INNODB_SYS_FIELDS

	root@mysqldb 15:37:  [(none)]> SELECT * FROM INFORMATION_SCHEMA.INNODB_SYS_FIELDS limit 10;
	+----------+----------+-----+
	| INDEX_ID | NAME     | POS |
	+----------+----------+-----+
	|       11 | ID       |   0 |
	|       12 | FOR_NAME |   0 |
	|       13 | REF_NAME |   0 |
	|       14 | ID       |   0 |
	|       14 | POS      |   1 |
	|       15 | SPACE    |   0 |
	|       16 | SPACE    |   0 |
	|       17 | TABLE_ID |   0 |
	|       17 | POS      |   1 |
	|       17 | BASE_POS |   2 |
	+----------+----------+-----+
	10 rows in set (0.00 sec)


	SYS_FIELDS表的列 
		列名			描述
		INDEX_ID		该索引列所属的索引的ID
		POS				该索引列在某个索引中是第几列
		COL_NAME		该索引列的名称
	
	这个SYS_FIELDS表只有一个聚集索引：

		以(INDEX_ID, POS)列为主键的聚簇索引

	
	
INFORMATION_SCHEMA.INNODB_SYS_TABLESPACES
	
	mysql> SELECT * FROM INFORMATION_SCHEMA.INNODB_SYS_TABLESPACES limit 2;
	+-------+---------------+------+-------------+------------+-----------+---------------+------------+---------------+-----------+----------------+
	| SPACE | NAME          | FLAG | FILE_FORMAT | ROW_FORMAT | PAGE_SIZE | ZIP_PAGE_SIZE | SPACE_TYPE | FS_BLOCK_SIZE | FILE_SIZE | ALLOCATED_SIZE |
	+-------+---------------+------+-------------+------------+-----------+---------------+------------+---------------+-----------+----------------+
	|     2 | mysql/plugin  |   33 | Barracuda   | Dynamic    |     16384 |             0 | Single     |          4096 |     98304 |         102400 |
	|     3 | mysql/servers |   33 | Barracuda   | Dynamic    |     16384 |             0 | Single     |          4096 |     98304 |         102400 |
	+-------+---------------+------+-------------+------------+-----------+---------------+------------+---------------+-----------+----------------+
	2 rows in set (0.00 sec)


	只要有了上述4个基本系统表，也就意味着可以获取其他系统表以及用户定义的表的所有元数据。
	比方说我们想看看 INNODB_SYS_TABLESPACES 这个系统表里存储了哪些表空间以及表空间对应的属性，那就可以：
		到SYS_TABLES表中根据表名(有表的名称之后)定位到具体的记录，就可以获取到SYS_TABLESPACES表的TABLE_ID

		使用这个TABLE_ID到SYS_COLUMNS表中就可以获取到属于该表的所有列的信息。

		使用这个TABLE_ID还可以到SYS_INDEXES表中获取所有的索引的信息，索引的信息中包括对应的INDEX_ID，还记录着该索引对应的B+数根页面是哪个表空间的哪个页面。

		使用INDEX_ID就可以到SYS_FIELDS表中获取所有索引列的信息。
		
		
	
Data Dictionary Header页面

	拿出一个固定的页面来记录这4个系统表的聚簇索引和二级索引对应的B+树位置，这个页面就是页号为7的页面，类型为 SYS (FIL_PAGE_TYPE_SYS 即 系统页)，记录了 Data Dictionary Header ，也就是数据字典的头部信息。
	
	这个页面由下边几个部分组成：

		名称						中文名				占用空间大小		简单描述
		File Header					文件头部			38字节				页的一些通用信息
		Data Dictionary Header		数据字典头部信息	56字节				记录一些基本系统表的根页面位置以及InnoDB存储引擎的一些全局信息
		Segment Header				段头部信息			10字节				记录本页面所在段对应的INODE Entry位置信息
		Empty Space					尚未使用空间		16272字节			用于页结构的填充，没啥实际意义
		File Trailer				文件尾部			8字节				校验页是否完整
		
		
	把这些有关数据字典的信息当成一个段来分配存储空间，我们就姑且称之为数据字典段吧。
	由于目前我们需要记录的数据字典信息非常少（可以看到Data Dictionary Header部分仅占用了56字节），所以该段只有一个碎片页，也就是页号为7的这个页。
	
	Data Dictionary Header部分的各个字段：

		Max Row ID：我们说过如果我们不显式的为表定义主键，而且表中也没有UNIQUE索引，那么InnoDB存储引擎会默认为我们生成一个名为row_id的列作为主键。因为它是主键，所以每条记录的row_id列的值不能重复。原则上只要一个表中的row_id列不重复就可以了，也就是说表a和表b拥有一样的row_id列也没啥关系，不过设计InnoDB的大叔只提供了这个Max Row ID字段，不论哪个拥有row_id列的表插入一条记录时，该记录的row_id列的值就是Max Row ID对应的值，然后再把Max Row ID对应的值加1，也就是说这个Max Row ID是全局共享的。

		Max Table ID：InnoDB存储引擎中的所有的表都对应一个唯一的ID，每次新建一个表时，就会把本字段的值作为该表的ID，然后自增本字段的值。

		Max Index ID：InnoDB存储引擎中的所有的索引都对应一个唯一的ID，每次新建一个索引时，就会把本字段的值作为该索引的ID，然后自增本字段的值。

		Max Space ID：InnoDB存储引擎中的所有的表空间都对应一个唯一的ID，每次新建一个表空间时，就会把本字段的值作为该表空间的ID，然后自增本字段的值。

		Mix ID Low(Unused)：这个字段没啥用，跳过。

		Root of SYS_TABLES clust index：本字段代表SYS_TABLES表聚簇索引的根页面的页号。

		Root of SYS_TABLE_IDS sec index：本字段代表SYS_TABLES表为ID列建立的二级索引的根页面的页号。

		Root of SYS_COLUMNS clust index：本字段代表SYS_COLUMNS表聚簇索引的根页面的页号。

		Root of SYS_INDEXES clust index本字段代表SYS_INDEXES表聚簇索引的根页面的页号。

		Root of SYS_FIELDS clust index：本字段代表SYS_FIELDS表聚簇索引的根页面的页号。

		Unused：这4个字节没用，跳过。
