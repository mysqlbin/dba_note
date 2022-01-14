

.ibd数据文件的数据页类型

	shell> innodb_space -f /data/mysql/mysql3306/data/test_db/page_info.ibd space-page-type-regions
	start       end         count       type                
	0           0           1           FSP_HDR             
	1           1           1           IBUF_BITMAP         
	2           2           1           INODE   



	FSP_HDR PAGE

		数据文件的第一个Page类型为FIL_PAGE_TYPE_FSP_HDR
		
		这个类型的页面是用来登记整个表空间的一些整体属性以及本组所有的区，也就是extent 0 ~ extent 255这256个区的属性
		
		整个表空间只有一个 FSP_HDR 类型的页面。
		
		
	IBUF_BITMAP PAGE

		第2个page类型为FIL_PAGE_IBUF_BITMAP
		主要用于跟踪随后的每个page的change buffer信息，使用4个bit来描述每个page的change buffer信息。
		
		
	INODE PAGE
		
		数据文件的第3个page的类型为FIL_PAGE_INODE，用于管理数据文件中的segement，每个索引占用2个segment，分别用于管理叶子节点和非叶子节点。
		每个inode页可以存储FSP_SEG_INODES_PER_PAGE（默认为85）个记录。


	相关参考

		https://blog.csdn.net/mysql_lover/article/details/54612876   MySQL · 引擎特性 · InnoDB 文件系统之文件物理结构
		
		
		
File Header.FIL_PAGE_TYPE 表示数据页的类型：

	类型名称					十六进制		描述
	FIL_PAGE_TYPE_ALLOCATED		0x0000			最新分配，还没使用
	FIL_PAGE_UNDO_LOG			0x0002			Undo日志页
	FIL_PAGE_INODE				0x0003			段信息节点
	FIL_PAGE_IBUF_FREE_LIST		0x0004			Insert Buffer空闲列表
	FIL_PAGE_IBUF_BITMAP		0x0005			Insert Buffer位图
	FIL_PAGE_TYPE_SYS			0x0006			系统页
	FIL_PAGE_TYPE_TRX_SYS		0x0007			事务系统数据
	FIL_PAGE_TYPE_FSP_HDR		0x0008			表空间头部信息
	FIL_PAGE_TYPE_XDES			0x0009			扩展描述页
	FIL_PAGE_TYPE_BLOB			0x000A			溢出页
	FIL_PAGE_INDEX				0x45BF			索引页，也就是我们所说的数据页
			
	我们存放记录的数据页的类型其实是 FIL_PAGE_INDEX ，也就是所谓的索引页。
	
	

https://www.leviathan.vip/2019/04/18/InnoDB%E7%9A%84%E6%96%87%E4%BB%B6%E7%BB%84%E7%BB%87%E7%BB%93%E6%9E%84/



区(extent)的概念

	
	表空间被划分为许多连续的区，每个区默认由64个页组成(也就是说一个区默认占用1MB空间大小)，每256个区划分为一组，每个组的最开始的几个页面类型是固定的就好了
	
	第一个组最开始的3个页面的类型是固定的：
		1. FSP_HDR 类型：
			这个类型的页面是用来登记整个表空间的一些整体属性以及本组所有的区
			整个表空间只有一个 FSP_HDR 类型的页面。

		2. IBUF_BITMAP类型：
			这个类型的页面是存储本组所有的区的所有页面关于INSERT BUFFER的信息。

		3. INODE类型：
			这个类型的页面存储了许多称为INODE的数据结构



	其余各组最开始的2个页面的类型是固定的：
	
		XDES类型：
			全称是extent descriptor(区描述符)，用来登记本组256个区的属性
			对于在extent 256区中的该类型页面存储的就是extent 256 ~ extent 511这些区的属性
			对于在extent 512区中的该类型页面存储的就是extent 512 ~ extent 767这些区的属性
			FSP_HDR类型的页面其实和XDES类型的页面的作用类似，只不过FSP_HDR类型的页面还会额外存储一些表空间的属性。

		IBUF_BITMAP类型：
			这个类型的页面是存储本组所有的区的所有页面关于INSERT BUFFER的信息。



	以完整的区为单位来分配存储空间，而不是当数据页用完之后，再分配一个新的数据页，总的来说，不是以数据页为单位进行分配空间的。



段(segment)的概念：

	Segment分为三种：
		Leaf node segment：        B+Tree的叶子节点段
		Non-Leaf node segment：	   B+Tree的非叶子节点段
		Rollback segment：         回滚段，存放undo log，默认是位于 System Tablespace
		InnoDB中的B+Tree索引，由Leaf node segment和Non-Leaf node segment组成
		
	每个 segment 由N个 extent 以及32个零散page组成，segment 最小以 extent 为单位扩展
    
	
	一个索引会生成2个段：一个叶子节点段，一个非叶子节点段。
	
		
	碎片(fragment)区
		
		在一个碎片区中，并不是所有的页都是为了存储同一个段的数据而存在的，而是碎片区中的页可以用于不同的目的，比如有些页用于段A，有些页用于段B，有些页甚至哪个段都不属于
		
		碎片区直属于表空间，并不属于任何一个段。所以此后为某个段分配存储空间的策略是这样的：

			1. 在刚开始向表中插入数据的时候，段是从某个碎片区以单个页面为单位来分配存储空间的。

			2. 当某个段已经占用了32个碎片区页面之后，就会以完整的区为单位来分配存储空间。

		因此，段不能仅定义为是某些区的集合，更精确的应该是某些零散的页面以及一些完整的区的集合。
		
		小结：段是一些零散的页面以及一些完整的区的集合。
		
		
	
区(extent)的4种分类和4种状态：

	区(extent)的4种分类：
		
		1. 空闲的区：现在还没有用到这个区中的任何页面。

		2. 有剩余空间的碎片区：	表示碎片区中还有可用的页面。

		3. 没有剩余空间的碎片区： 表示碎片区中的所有页面都被使用，没有空闲页面。

		4. 附属于某个段的区：		
			每一个索引都可以分为叶子节点段和非叶子节点段，除此之外InnoDB还会另外定义一些特殊作用的段，在这些段中的数据量很大时将使用区来作为基本的分配单位。
				
		
	区(extent)的4种状态：
		
		状态名		含义
		FREE		空闲的区
		FREE_FRAG	有剩余空间的碎片区
		FULL_FRAG	没有剩余空间的碎片区
		FSEG		附属于某个段的区	
		
	处于 FREE、FREE_FRAG 以及 FULL_FRAG 这三种状态的区都是独立的，算是直属于表空间
	而处于 FSEG 状态的区是附属于某个段的	
	


XDES Entry结构

	每一个区都对应着一个XDES Entry结构，这个结构记录了对应的区的一些属性。
	
	


	
	
	

			