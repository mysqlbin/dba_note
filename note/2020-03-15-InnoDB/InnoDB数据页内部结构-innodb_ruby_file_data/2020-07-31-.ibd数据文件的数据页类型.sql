


[root@mgr9 data]# innodb_space -f /data/mysql/mysql3306/data/test_db/page_info.ibd space-page-type-regions
start       end         count       type                
0           0           1           FSP_HDR             
1           1           1           IBUF_BITMAP         
2           2           1           INODE   



FSP_HDR PAGE

	数据文件的第一个Page类型为FIL_PAGE_TYPE_FSP_HDR，

IBUF BITMAP PAGE

	第2个page类型为FIL_PAGE_IBUF_BITMAP
	主要用于跟踪随后的每个page的change buffer信息，使用4个bit来描述每个page的change buffer信息。
	
	
INODE PAGE
	
	数据文件的第3个page的类型为FIL_PAGE_INODE，用于管理数据文件中的segement，每个索引占用2个segment，分别用于管理叶子节点和非叶子节点。
	每个inode页可以存储FSP_SEG_INODES_PER_PAGE（默认为85）个记录。


相关参考

	https://blog.csdn.net/mysql_lover/article/details/54612876   MySQL · 引擎特性 · InnoDB 文件系统之文件物理结构