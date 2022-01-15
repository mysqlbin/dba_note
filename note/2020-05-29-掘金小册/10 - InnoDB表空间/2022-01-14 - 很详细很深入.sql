
把1个表空间完整的结构都写出来了，这就是宇宙最全的文章/教程，服了。

		
		
File Header.FIL_PAGE_TYPE 表示数据页的类型

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
	
	

区(extent)的概念

	
	表空间被划分为许多连续的区，每个区默认由64个页组成(也就是说一个区默认占用1MB空间大小)，每256个区划分为一组，每个组的最开始的几个页面类型是固定的就好了
	
	第一个组最开始的3个页面的类型是固定的：
		1. FSP_HDR 类型：
			这个类型的页面是用来登记整个表空间的一些整体属性以及本组所有的区
			整个表空间只有一个 FSP_HDR 类型的页面。

		2. IBUF_BITMAP 类型：
			这个类型的页面是存储本组所有的区的所有页面关于INSERT BUFFER的信息。

		3. INODE 类型：
			这个类型的页面存储了许多称为INODE的数据结构


		示例
			.ibd数据文件的数据页类型

			shell> innodb_space -f /data/mysql/mysql3306/data/test_db/page_info.ibd space-page-type-regions
			start       end         count       type                
			0           0           1           FSP_HDR             
			1           1           1           IBUF_BITMAP         
			2           2           1           INODE   



			FSP_HDR PAGE

				数据文件的第一个Page类型为FIL_PAGE_TYPE_FSP_HDR
				
				这个类型的页面是用来登记整个表空间的一些整体属性以及本组所有的区，也就是extent 0 ~ extent 255这256个区的属性
				
				
			IBUF_BITMAP PAGE

				第2个page类型为FIL_PAGE_IBUF_BITMAP
				主要用于跟踪随后的每个page的change buffer信息，使用4个bit来描述每个page的change buffer信息。
				
				
			INODE PAGE
				
				数据文件的第3个page的类型为FIL_PAGE_INODE，用于管理数据文件中的segement，每个索引占用2个segment，分别用于管理叶子节点和非叶子节点。
				每个inode页可以存储FSP_SEG_INODES_PER_PAGE（默认为85）个记录。


			相关参考

				https://blog.csdn.net/mysql_lover/article/details/54612876   MySQL · 引擎特性 · InnoDB 文件系统之文件物理结构
				
				

	其余各组最开始的2个页面的类型是固定的：
	
		XDES类型：
			全称是extent descriptor(区描述符)，用来登记本组256个区的属性
			对于在extent 256区中的该类型页面存储的就是extent 256 ~ extent 511这些区的属性
			对于在extent 512区中的该类型页面存储的就是extent 512 ~ extent 767这些区的属性
			FSP_HDR类型的页面其实和XDES类型的页面的作用类似，只不过FSP_HDR类型的页面还会额外存储一些表空间的属性。

		IBUF_BITMAP类型：
			这个类型的页面是存储本组所有的区的所有页面关于INSERT BUFFER的信息。



	以完整的区为单位来分配存储空间，而不是当数据页用完之后，再分配一个新的数据页，总的来说，不是以数据页为单位进行分配空间的。


表空间 > B+树 > 段(叶子索引段、非叶子索引段) > 区 > 页 > 行

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
		
		碎片区直属于表空间，并不属于任何一个段。    -- 重点
		所以此后为某个段分配存储空间的策略是这样的：

			1. 在刚开始向表中插入数据的时候，段是从某个碎片区以单个页面为单位来分配存储空间的。

			2. 当某个段已经占用了32个碎片区页面之后，就会以完整的区为单位来分配存储空间。

		因此，段不能仅定义为是某些区的集合，更精确的应该是某些零散的页面以及一些完整的区的集合。
		
		小结：段是一些零散的页面以及一些完整的区的集合。
		
		
	
区(extent)的4种分类和对应状态：

	区(extent)的4种分类：
		
		1. 空闲的区：现在还没有用到这个区中的任何页面。

		2. 有剩余空间的碎片区：	表示碎片区中还有可用的页面。

		3. 没有剩余空间的碎片区： 表示碎片区中的所有页面都被使用，没有空闲页面。

		4. 附属于某个段的区：		
			每一个索引都可以分为叶子节点段和非叶子节点段，
			除此之外InnoDB还会另外定义一些特殊作用的段，在这些段中的数据量很大时将使用区来作为基本的分配单位。
				
		
	区(extent)的4种状态：
		
		状态名		含义
		FREE		空闲的区
		FREE_FRAG	有剩余空间的碎片区
		FULL_FRAG	没有剩余空间的碎片区
		FSEG		附属于某个段的区		区(extent)的4种状态：
		
		状态名		含义
		FREE		空闲的区
		FREE_FRAG	有剩余空间的碎片区
		FULL_FRAG	没有剩余空间的碎片区
		FSEG		附属于某个段的区	
		 
	处于 FREE、FREE_FRAG 以及 FULL_FRAG 这三种状态的区都是独立的，算是直属于表空间   -- 重点
	
	而处于 FSEG 状态的区是附属于某个段的			
	
	------------------------------------------------------------------------------------------------
	如果把表空间比作是一个集团军，段就相当于师，区就相当于团。
		一般的团都是隶属于某个师的，就像是处于`FSEG`的区全都隶属于某个段，
		而处于`FREE`、`FREE_FRAG`以及`FULL_FRAG`这三种状态的区却直接隶属于表空间，就像独立团直接听命于军部一样。
	


XDES Entry结构
	
	为了方便管理这些区，设计InnoDB的大叔设计了一个称为XDES Entry的结构(全称就是Extent Descriptor Entry)
	
	每一个区都对应着一个 XDES Entry 结构，这个结构记录了对应的区的一些属性。  -- 重点概念。
	l
	XDES Entry是一个40个字节的结构，大致分为4个部分，各个部分的释义如下：

		1. Segment ID(8字节)

			每一个段都有一个唯一的编号，用ID表示，此处的Segment ID字段表示就是该区所在的段。
		
		2. List Node(12字节)
			
			这个部分可以将若干个XDES Entry结构串联成一个链表：FREE链表、NOT_FULL链表、FULL链表
			参考图片：《XDES Entry 结构示意图.png》
			
			如果我们想定位表空间内的某一个位置的话，只需指定页号以及该位置在指定页号中的页内偏移量即可(page no、page no offset)：
			
				Pre Node Page Number 和 Pre Node Offset   的组合就是指向前一个 XDES Entry 的指针

				Next Node Page Number 和 Next Node Offset 的组合就是指向后一个 XDES Entry 的指针。
				
		3. State(4字节)
			这个字段表明区的状态: FREE、FREE_FRAG、FULL_FRAG、FSEG
			
			区(extent)的4种状态：
				
				状态名		含义
				FREE		空闲的区
				FREE_FRAG	有剩余空间的碎片区
				FULL_FRAG	没有剩余空间的碎片区
				FSEG		附属于某个段的区	
		
		4. Page State Bitmap(16字节)
			-- 未做记录。
			
			
		
XDES Entry链表

	区(extent)的4种状态：--重点，这里做了一下引用。
		
		状态名		含义
		FREE		空闲的区
		FREE_FRAG	有剩余空间的碎片区
		FULL_FRAG	没有剩余空间的碎片区
		FSEG		附属于某个段的区	

	向某个段中插入数据的过程：
	
		1. 当段中数据较少的时候，首先会查看表空间中是否有状态为 FREE_FRAG 的区 ，也就是找还有空闲空间的碎片区，如果找到了，那么从该区中取一些零散的页把数据插进去；
			否则到表空间下申请一个状态为FREE的区，也就是空闲的区，把该区的状态变为 FREE_FRAG ，然后从该新申请的区中取一些零散的页把数据插进去。


			可以通过List Node中的指针，做这么三件事：

				把状态为 FREE 的区对应的XDES Entry结构通过List Node来连接成一个链表，这个链表我们就称之为 FREE链表。

				把状态为 FREE_FRAG 的区对应的XDES Entry结构通过List Node来连接成一个链表，这个链表我们就称之为 FREE_FRAG链表。

				把状态为 FULL_FRAG 的区对应的XDES Entry结构通过List Node来连接成一个链表，这个链表我们就称之为 FULL_FRAG链表。

			这样每当我们想找一个 FREE_FRAG 状态的区时，就直接把 FREE_FRAG 链表的头节点拿出来，从这个节点中取一些零散的页来插入数据，
			当这个节点对应的区用完时，就修改一下这个节点的State字段的值(state = FULL_FRAG)，然后从 FREE_FRAG 链表中移到 FULL_FRAG 链表中。
			
			同理，如果 FREE_FRAG 链表中一个节点都没有，那么就直接从 FREE 链表 中取一个节点移动到 FREE_FRAG 链表的状态，
			并修改该节点的STATE字段值为 FREE_FRAG(state = FREE_FRAG) ，然后从这个节点对应的区中获取零散的页就好了。
			
			
		2. 当段中数据已经占满了32个零散的页后，就直接申请完整的区来插入数据了。
		
	
	InnoDB 为每个段中的区对应的XDES Entry结构建立了三个链表：

		1. FREE链表：
				同一个段中，所有页面都是空闲的区对应的XDES Entry结构会被加入到这个链表。
				-- 注意和直属于表空间的FREE链表区别开了，此处的FREE链表是附属于某个段的。
				-- 还没有数据写入的extent
				
		2. NOT_FULL链表：
				同一个段中，仍有空闲空间的区对应的XDES Entry结构会被加入到这个链表。
				-- 数据没有填满的extent
				
		3. FULL链表：
				同一个段中，已经没有空闲空间的区对应的XDES Entry结构会被加入到这个链表。
				-- 数据已经把extent填满了。
				
	每一个索引都对应两个段，每个段都会维护上述的3个链表.

	所以段在数据量比较大时插入数据的话，会先获取 NOT_FULL链表 的头节点，直接把数据插入这个头节点对应的区中即可，如果该区的空间已经被用完，就把该节点移到 FULL链表 中。
	
	
	-- 区(extent)的4种状态 和 XDES Entry结构的3个链表的关系？
	
	
	
链表基节点(list base node)

	List Base Node的结构，翻译成中文就是链表的基节点
	
	参考图片：《list base node 结构示意图.png》
	
	每个链表(FREE链表、NOT_FULL链表、FULL链表)都对应这么一个List Base Node结构，其中：

		List Length：表明该链表一共有多少节点

		First Node Page Number和First Node Offset：表明该链表的头节点在表空间中的位置。

		Last Node Page Number和Last Node Offset：表明该链表的尾节点在表空间中的位置。

	一般我们把某个链表对应的List Base Node结构放置在表空间中固定的位置，这样想找定位某个链表就变得so easy啦。
			


链表小结

	表空间是由若干个区组成的，每个区都对应一个XDES Entry的结构，直属于表空间的区对应的XDES Entry结构可以分成 FREE、FREE_FRAG 和 FULL_FRAG 这3个链表；
		这3个链表对应的状态：
			链表名称          状态
			FREE链表		  空闲的区	
			FREE_FRAG链表	  有剩余空间的碎片区
			FULL_FRAG链表     没有剩余空间的碎片区
	
	每个段可以附属若干个区，每个段中的区对应的XDES Entry结构可以分成 FREE、NOT_FULL 和FULL这3个链表：
	
		每个链表都对应一个List Base Node的结构，这个结构里记录了链表的头、尾节点的位置以及该链表中包含的节点数。


段的结构
	每个区都有对应的 XDES Entry 来记录这个区中的属性
	每个段都定义了一个 INODE Entry 结构来记录一下段中的属性
	《INODE Entry 结构示意图.png》
	各个部分的含义如下：
	
		Segment ID：
			就是指这个INODE Entry结构对应的段的编号（ID）。
			
		NOT_FULL_N_USED：
			这个字段指的是在NOT_FULL链表中已经使用了多少个页面。
		
		3个List Base Node：
			分别为段的 FREE链表、NOT_FULL链表、FULL链表 定义了List Base Node
			找某个段的某个链表的头节点和尾节点的时候，就可以直接到这个部分找到对应链表的List Base Node
		
		Magic Number：
			这个值是用来标记这个INODE Entry是否已经被初始化了（初始化的意思就是把各个字段的值都填进去了）。
			如果这个数字是值的97937874，表明该INODE Entry已经初始化，否则没有被初始化。
		
		Fragment Array Entry：
			在前边强调过无数次段是一些零散页面和一些完整的区的集合，
			每个Fragment Array Entry结构都对应着一个零散的页面，这个结构一共4个字节，表示一个零散页面的页号。

		
			

看了第2遍就做笔记了，也可以，但是还要继续看。
第3遍：越看了越明了，结合整个章节一起看的话还没有很清晰
第4遍：画图？



《2020-07-15 - InnoDB表空间全局图 - by 邹召顺.png》
《数据页格式也来1个图》
	
	
其它相关参考：
			
	http://mysql.taobao.org/monthly/2019/10/01/

	https://www.leviathan.vip/2019/04/18/InnoDB%E7%9A%84%E6%96%87%E4%BB%B6%E7%BB%84%E7%BB%87%E7%BB%93%E6%9E%84/		












	