
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
	
		XDES 类型(extent descriptor)：
			全称是extent descriptor(区描述符)，用来登记本组256个区的属性
			对于在extent 256区中的该类型页面存储的就是extent 256 ~ extent 511这些区的属性
			对于在extent 512区中的该类型页面存储的就是extent 512 ~ extent 767这些区的属性
			FSP_HDR类型的页面其实和XDES类型的页面的作用类似，只不过FSP_HDR类型的页面还会额外存储一些表空间的属性(File Space Header部分)。

		IBUF_BITMAP 类型：
			这个类型的页面是存储本组所有的区的所有页面关于INSERT BUFFER的信息。



	以完整的区为单位来分配存储空间，而不是当数据页用完之后，再分配一个新的数据页，总的来说，不是以数据页为单位进行分配空间的。


表空间 > B+树 > 段(叶子索引段、非叶子索引段) > 区 > 页 > 行

段(segment)的概念：

	Segment分为三种：
		Leaf node segment：        B+Tree的叶子节点段
		Non-Leaf node segment：	   B+Tree的非叶子节点段
		Rollback segment：         回滚段，存放undo log，默认是位于 System Tablespace
		InnoDB中的B+Tree索引，由Leaf node segment和Non-Leaf node segment组成
		
	每个 segment 由碎片区的32个零散page + N个 extent 组成，segment 最小以 extent 为单位扩展
    
	
	一个索引会生成2个段：一个叶子节点段，一个非叶子节点段。

碎片(fragment)区

	概念

		在为了考虑以完整的区为单位分配给某个段对于数据量较小的表太浪费存储空间的这种情况，设计InnoDB的大叔们提出了一个碎片（fragment）区的概念
		
		在一个碎片区中，并不是所有的页都是为了存储同一个段的数据而存在的，而是碎片区中的页可以用于不同的目的：
			比如有些页用于段A，有些页用于段B，有些页甚至哪个段都不属于
		碎片区直属于表空间，并不属于任何一个段。    -- 重点
		
		所以此后为某个段分配存储空间的策略是这样的：

			1. 在刚开始向表中插入数据的时候，段是从某个碎片区以单个页面为单位来分配存储空间的。

			2. 当某个段已经占用了32个碎片区页面(碎片区的32个零散页面)之后，就会以完整的区为单位来分配存储空间。
				
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
		FSEG		附属于某个段的区		
		 
	处于 FREE、FREE_FRAG 以及 FULL_FRAG 这三种状态的区都是独立的，算是直属于表空间   -- 重点
	
	而处于 FSEG 状态的区是附属于某个段的，就是只能属于某个段的		
	
	------------------------------------------------------------------------------------------------
	如果把表空间比作是一个集团军，段就相当于师，区就相当于团。
	
		一般的团都是隶属于某个师的，就像是处于`FSEG`的区全都隶属于某个段，
		
		而处于`FREE`、`FREE_FRAG`以及`FULL_FRAG`这三种状态的区却直接隶属于表空间，就像独立团直接听命于军部一样。
	


XDES Entry结构
	
	为了方便管理这些区，设计InnoDB的大叔设计了一个称为XDES Entry的结构(全称就是Extent Descriptor Entry)
	
	每一个区都对应着一个 XDES Entry 结构，这个结构记录了对应的区的一些属性。  -- 重点概念。
	
	XDES Entry是一个40个字节的结构，大致分为4个部分，各个部分的释义如下：

		1. Segment ID(8字节)

			每一个段都有一个唯一的编号，用ID表示，此处的Segment ID字段表示就是该区所在的段。
		
		2. List Node(12字节)
			
			作用：
				这个部分可以将若干个XDES Entry结构串联成一个链表：FREE链表、NOT_FULL链表、FULL链表
			
			参考图片：《XDES Entry 结构示意图.png》
			
			如果我们想定位表空间内的某一个位置的话，只需指定页号以及该位置在指定页号中的页内偏移量即可(page no、page no offset)：
			
				Pre Node Page Number 和 Pre Node Offset   的组合就是指向前一个 XDES Entry 的指针

				Next Node Page Number 和 Next Node Offset 的组合就是指向后一个 XDES Entry 的指针。
				
				-- 用来构建链表结构
				
		3. State(4字节)
			这个字段表明区的类型: FREE、FREE_FRAG、FULL_FRAG、FSEG
			
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
		
		/*
		
		所以此后为某个段分配存储空间的策略是这样的：

			1. 在刚开始向表中插入数据的时候，段是从某个碎片区以单个页面为单位来分配存储空间的。

			2. 当某个段已经占用了碎片区的32个零散页面之后，就会以完整的区为单位来分配存储空间。
			
		引用上文的
			
		*/	
					
		1. 从段中的碎片区依次取32个页面
			当段中数据较少的时候，首先会查看表空间中是否有状态为 FREE_FRAG 的区 ，也就是找还有空闲空间的碎片区，如果找到了，那么从该区中取一些零散的页把数据插进去；
			否则到表空间下申请一个状态为FREE的区，也就是空闲的区，把该区的状态变为 FREE_FRAG ，然后从该新申请的区中取一些零散的页把数据插进去。

			/* 如何知道碎片区的状态？*/
			可以通过List Node中的指针，做这么三件事：
			
				-- 各碎片区如果处于相同的状态，会构建1个链表
				
				把状态为 FREE 的区对应的XDES Entry结构通过List Node来连接成一个链表，这个链表我们就称之为 FREE链表。

				把状态为 FREE_FRAG 的区对应的XDES Entry结构通过List Node来连接成一个链表，这个链表我们就称之为 FREE_FRAG链表。

				把状态为 FULL_FRAG 的区对应的XDES Entry结构通过List Node来连接成一个链表，这个链表我们就称之为 FULL_FRAG链表。
				
				-- 方便知道哪些区有可用的页面、哪些区没有可用的页面、哪些区是空闲的
				
			这样每当我们想找一个 FREE_FRAG 状态的区时，就直接把 FREE_FRAG 链表的头节点拿出来，从这个节点中取一些零散的页来插入数据，
				-- 上面的还不理解。多看2遍，并结合上下文，又理解了。
				
			当这个节点对应的区用完时，就修改一下这个节点的State字段的值(state = FULL_FRAG)，然后从 FREE_FRAG 链表中移到 FULL_FRAG 链表中。
			
			同理，如果 FREE_FRAG 链表中一个节点都没有，那么就直接从 FREE 链表 中取一个节点移动到 FREE_FRAG 链表的状态，
			并修改该节点的STATE字段值为 FREE_FRAG(state = FREE_FRAG) ，然后从这个节点对应的区中获取零散的页就好了。
			-- 理解了。
			
		2. 当段中数据已经占满了碎片区的32个零散页面后，就直接申请完整的区来插入数据了。
		
	
	-- 上面区的状态区分的是零散区，不是属于某一个固定的段；下面区的状态区分的是已经分配给某一个段的区，在段内进行状态区分；
	
	/* 如何知道段属区的状态 */
	
	因为一个段中可以有好多个区，有的区是完全空闲的，有的区还有一些页面可以用，有的区已经没有空闲页 面可以用了，所以我们有必要继续细分
	InnoDB 为每个段中的区()对应的 XDES Entry结构 建立了三个链表：

		1. FREE链表：
				同一个段中，所有页面都是空闲的区对应的 XDES Entry结构 会被加入到这个链表。
				-- 注意和直属于表空间的FREE链表区别开了，此处的FREE链表是附属于某个段的。
				-- 还没有数据写入的extent
				
		2. NOT_FULL链表：
				同一个段中，仍有空闲空间的区对应的 XDES Entry结构 会被加入到这个链表。
				-- 数据没有填满的extent
				
		3. FULL链表：
				同一个段中，已经没有空闲空间的区对应的 XDES Entry结构 会被加入到这个链表。
				-- 数据已经把extent填满了。
	
	
	每一个索引都对应两个段，每个段都会维护上述的3个链表.

	所以段在数据量比较大时插入数据的话，会先获取 NOT_FULL链表 的头节点，直接把数据插入这个头节点对应的区中即可，如果该区的空间已经被用完，就把该节点移到 FULL链表 中。
	
	
	-- 区(extent)的4种状态 和 XDES Entry结构的3个链表的关系？
	
	
	
链表基节点(list base node)

	List Base Node的结构，翻译成中文就是链表的基节点
	
	参考图片：《list base node 结构示意图.png》
	
	这个结构中包含了链表的头节点和尾节点的指针以及这个链表中包含了多少节点的信息
	
	作用：	
		快速找到链表。
	
	每个链表(FREE链表、NOT_FULL链表、FULL链表，/* 包含碎片区的链表不？*/)都对应这么一个List Base Node结构，其中：

		List Length：表明该链表一共有多少节点  -- 节点 这是不理解

		First Node Page Number和First Node Offset：表明该链表的头节点在表空间中的位置(指向XDES Entry链表头节点的指针)。

		Last Node Page Number和Last Node Offset：表明该链表的尾节点在表空间中的位置(指向XDES Entry链表尾节点的指针)。

	一般我们把某个链表对应的 List Base Node 结构放置在表空间中固定的位置，这样想找定位某个链表就变得so easy啦。
	-- 理解了。


链表小结
	
	1. XDES Entry结构
		每一个区都对应着一个 XDES Entry 结构，这个结构记录了对应的区的一些属性。
	
	2. 表空间是由若干个区组成的，每个区都对应一个XDES Entry的结构，直属于表空间的区(碎片区)对应的XDES Entry结构可以分成 FREE、FREE_FRAG 和 FULL_FRAG 这3个链表；
		-- 碎片区
		这3个链表对应的状态：
			链表名称          状态
			FREE链表		  空闲的区	
			FREE_FRAG链表	  有剩余空间的碎片区
			FULL_FRAG链表     没有剩余空间的碎片区
	
		-- 总结：相同状态的区会组成1个链表。
		
	3. 每个段可以附属若干个区，每个段中的区对应的XDES Entry结构可以分成 FREE、NOT_FULL 和FULL这3个链表：
		-- 段内的区
	
	4. 链表的基节点：每个链表都对应一个List Base Node的结构，这个结构里记录了链表的头、尾节点的位置以及该链表中包含的节点数。
		
		-- 这里还不理解。
	
	5. 上面区的状态区分的是零散区，不是属于某一个固定的段；下面区的状态区分的是已经分配给某一个段的区，在段内进行状态区分；


	

段的结构

	每个区都有对应的 XDES Entry 来记录这个区中的属性
	每个段都定义了一个 INODE Entry 结构来记录一下段中的属性
	《INODE Entry 结构示意图.png》
	INODE Entry结构各个部分的含义如下：
	
		Segment ID：
			就是指这个INODE Entry结构对应的段的编号（ID）。
			
		NOT_FULL_N_USED：
			这个字段指的是在 NOT_FULL链表 中已经使用了多少个页面。
		
		3个List Base Node：
			分别为段的 FREE链表、NOT_FULL链表、FULL链表 定义了List Base Node
			找某个段的某个链表的头节点和尾节点的时候，就可以直接到这个部分找到对应链表的List Base Node
			-- 理解了。
			
		Magic Number：
			这个值是用来标记这个INODE Entry是否已经被初始化了（初始化的意思就是把各个字段的值都填进去了）。
			如果这个数字是值的97937874，表明该INODE Entry已经初始化，否则没有被初始化。
		
		Fragment Array Entry：
			在前边强调过无数次段是一些零散页面和一些完整的区的集合，
			每个Fragment Array Entry结构都对应着一个零散的页面，这个结构一共4个字节，表示一个零散页面的页号。

		

各类型页面的详细情况

	1. FSP_HDR类型
	
		存储的内容：
			存储了表空间的一些整体属性以及第一组内256个区的对应XDES Entry结构。
			File Space Header、XDES Entry。
			1个数据页可以存储完本组内所有的区对应的XDES Entry结构。
			
		----------------------------------------------------------------------------------------------------------------
		
		第一组的第一个页面，也是表空间的第一个页面，页号为0，它存储了表空间的一些整体属性以及第一组内256个区的对应XDES Entry结构。
		
		一个完整的FSP_HDR类型的页面大致由5个部分组成，各个部分的具体释义如下表：
					
			名称				中文名			占用空间大小	简单描述
			File Header			文件头部		38字节			页的一些通用信息
			File Space Header	表空间头部		112字节			表空间的一些整体属性信息
			XDES Entry			区描述信息		10240字节		存储本组256个区对应的属性信息
			Empty Space			尚未使用空间	5986字节		用于页结构的填充，没啥实际意义
			File Trailer		文件尾部		8字节			校验页是否完整
		
			
			XDES Entry占用空间大小=10240字节
				1组有256个区
				1个区对应一个XDES Entry， 一个XDES Entry结构的大小是40字节
				select 256*40 = 10240 bytes 
		
			File Space Header 部分

				下面是各个属性的简单描述：
					名称									占用空间大小	描述
					Space ID								4字节			表空间的ID
					Not Used								4字节			这4个字节未被使用，可以忽略
					Size									4字节			当前表空间占有的页面数
					FREE Limit								4字节			尚未被初始化的最小页号，大于或等于这个页号的区对应的XDES Entry结构都没有被加入FREE链表
					Space Flags								4字节			表空间的一些占用存储空间比较小的属性
					FRAG_N_USED								4字节			FREE_FRAG链表中已使用的页面数量
					List Base Node for FREE List			16字节			FREE链表的基节点
					List Base Node for FREE_FRAG List		16字节			FREE_FRAG链表的基节点
					List Base Node for FULL_FRAG List		16字节			FULL_FRAG链表的基节点
					Next Unused Segment ID					8字节			当前表空间中下一个未使用的 Segment ID
					List Base Node for SEG_INODES_FULL List	16字节			SEG_INODES_FULL链表的基节点
					List Base Node for SEG_INODES_FREE List	16字节			SEG_INODES_FREE链表的基节点
					
				
				List Base Node for FREE List、List Base Node for FREE_FRAG List、List Base Node for FULL_FRAG List
					分别是直属于表空间的FREE链表的基节点、FREE_FRAG链表的基节点、FULL_FRAG链表的基节点，
					这三个链表的基节点在表空间的位置是固定的，就是在表空间的第一个页面（也就是FSP_HDR类型的页面）的File Space Header部分。
					所以之后定位这几个链表就很简单啦。	
				
				FRAG_N_USED
					这个字段表明在 FREE_FRAG链表 中已经使用的页面数量。	
				
				FREE Limit
					为表空间定义了FREE Limit这个字段，在该字段表示页号之前的区都被初始化了，之后的区尚未被初始化
				
				Next Unused Segment ID
					该字段表明当前表空间中最大的段ID的下一个ID，这样在创建新段的时候赋予新段一个唯一的ID值就so easy啦，直接使用这个字段的值就好了。
				
				Space Flags

					表空间对于一些布尔类型的属性，或者只需要寥寥几个比特位搞定的属性都放在了这个Space Flags中存储，虽然它只有4个字节，32个比特位大小，却存储了好多表空间的属性，详细情况如下表：					



					标志名称		占用空间（单位：bit）	描述
					POST_ANTELOPE	1						表示文件格式是否大于ANTELOPE
					
					ZIP_SSIZE		4						表示压缩页面的大小
					
					ATOMIC_BLOBS	1						表示是否自动把值非常长的字段放到BLOB页里
					
					PAGE_SIZE		4						页面大小
						
					DATA_DIR		1						表示表空间是否是从默认的数据目录中获取的
					
					SHARED			1						是否为共享表空间
					
					TEMPORARY		1						是否为临时表空间
					
					ENCRYPTION		1						表空间是否加密
					
					UNUSED			18						没有使用到的比特位
					
		
		
				List Base Node for SEG_INODES_FULL List和List Base Node for SEG_INODES_FREE List
				
					每个段对应的INODE Entry结构会集中存放到一个类型为INODE的页中，如果表空间中的段特别多，则会有多个INODE Entry结构，可能一个页放不下，这些INODE类型的页会组成两种列表：

						SEG_INODES_FULL链表，该链表中的INODE类型的页面都已经被INODE Entry结构填充满了，没空闲空间存放额外的INODE Entry了。

						SEG_INODES_FREE链表，该链表中的INODE类型的页面仍有空闲空间来存放INODE Entry结构				


		
	2. XDES类型
	
		存储的内容：
			第了第1个分组外，接下来的每个分组的第一个页面只需要记录本组内所有的区对应的XDES Entry结构即可，不需要再记录表空间的属性了
			1个数据页可以存储完本组内所有的区对应的XDES Entry结构。
			
		一个XDES类型的页面是由这几部分构成的：
			名称				中文名			占用空间大小	简单描述
			File Header			文件头部		38字节			页的一些通用信息
			XDES Entry			区描述信息		10240字节		存储本组256个区对应的属性信息
			Empty Space			尚未使用空间	5986字节		用于页结构的填充，没啥实际意义
			File Trailer		文件尾部		8字节			校验页是否完整
			
			
			与FSP_HDR类型的页面对比，除了少了 File Space Header 部分之外，也就是除了少了记录表空间整体属性的部分之外，其余的部分是一样一样的。
		
		每一个XDES Entry对应表空间中的一个区，在区数量非常多的时，一个单独的页可能就不够存放足够多的XDES Entry结构，所以把表空间的区分为了若干个组，
		每组开头的第一个页面记录着本组内的所有区对应的XDES Entry,由于第一组的第一个页面有些特殊，因为它也是整个表空间的第一个页面，
		所以除了记录本组中的所有区对应的XDES Entry意以外，还记录着表空间的一些整体属性，这个页面类型就是FSP_HDR类型，整个表空间里只有这一个类型的页面，
		除此之外，之后每个分组的第一个页面只需记录本组内所有的区对应的XDES Entry结构即可，称为XDES类型。


	3. INODE类型
		
		存储的内容：
		
			存储上一个INODE页面和下一个INODE页面的指针、INODE Entry结构。
			
			1个数据页可能存储不了多个段的INODE Entry结构，所以需要申请新的数据页来存储，需要链表把 INODE类型的数据页关联起来。
		
		一个INODE类型的页面是由这几部分构成的：
			
			名称							中文名			占用空间大小	简单描述
			File Header						文件头部		38字节			页的一些通用信息
			List Node for INODE Page List	通用链表节点 	12字节 			存储上一个INODE页面和下一个INODE页面的指针
			INODE Entry						段描述信息 		16320字节		存储段描述信息
			Empty Space						尚未使用空间 	6字节 			用于页结构的填充，没啥实际意义
			File Trailer					文件尾部 		8字节			校验页是否完整
		
			1. INODE Entry部分：
			
				前边已经详细介绍过这个结构的组成了，主要包括对应的段内零散页面的地址以及附属于该段的FREE、NOT_FULL和FULL链表的基节点。
				每个INODE Entry结构占用192字节，一个页面里可以存储85个这样的结构。
					select 192 * 85 = 16320

				/*				
				每个区都有对应的 XDES Entry 来记录这个区中的属性
				每个段都定义了一个 INODE Entry 结构来记录一下段中的属性
				《INODE Entry 结构示意图.png》
				INODE Entry结构各个部分的含义如下：
				
					Segment ID：
						就是指这个INODE Entry结构对应的段的编号（ID）。
						
					NOT_FULL_N_USED：
						这个字段指的是在 NOT_FULL链表 中已经使用了多少个页面。
					
					3个List Base Node：
						分别为段的 FREE链表、NOT_FULL链表、FULL链表 定义了List Base Node
						找某个段的某个链表的头节点和尾节点的时候，就可以直接到这个部分找到对应链表的List Base Node
					
					Magic Number：
						这个值是用来标记这个INODE Entry是否已经被初始化了（初始化的意思就是把各个字段的值都填进去了）。
						如果这个数字是值的97937874，表明该INODE Entry已经初始化，否则没有被初始化。
					
					Fragment Array Entry：
						在前边强调过无数次段是一些零散页面和一些完整的区的集合，
						每个Fragment Array Entry结构都对应着一个零散的页面，这个结构一共4个字节，表示一个零散页面的页号。
				*/
				
			
			2. List Node for INODE Page							
				-- INODE页的链表节点
				因为一个表空间中可能存在超过85个段，所以可能一个INODE类型的页面不足以存储所有的段对应的INODE Entry结构，
				所以就需要额外的INODE类型的页面来存储这些结构。
				还是为了方便管理这些INODE类型的页面，InnoDB将这些INODE类型的页面串联成两个不同的链表：
				
					SEG_INODES_FULL链表：该链表中的INODE类型的页面中已经没有空闲空间来存储额外的INODE Entry结构了。
					SEG_INODES_FREE链表：该链表中的INODE类型的页面中还有空闲空间来存储额外的INODE Entry结构了。
				
	
				以后每当我们新创建一个段（创建索引时就会创建段）时，都会创建一个INODE Entry结构与之对应，
				存储INODE Entry的大致过程就是这样的：
					
					SEG_INODES_FREE链表不空：
						先看看 SEG_INODES_FREE链表 是否为空，如果不为空，直接从该链表中获取一个节点，也就相当于获取到一个仍有空闲空间的INODE类型的页面，
						然后把该INODE Entry结构放到该页面中。
						当该页面中无剩余空间时，就把该页放到 SEG_INODES_FULL链表 中。
						
					SEG_INODES_FREE链表为空：	
						如果 SEG_INODES_FREE链表 为空，则需要从表空间的 FREE_FRAG链表 中申请一个页面，修改该页面的类型为INODE，
						把该页面放到 SEG_INODES_FREE链表 中，与此同时把该 INODE Entry结构 放入该页面。

						-- FREE_FRAG链表	  有剩余空间的碎片区
					
	

	Segment Header 结构的运用
		
		查找某个段对应哪个INODE Entry结构，需要找个地方记下来这个对应关系。
		
		
		Page Header部分（为突出重点，省略了好多属性） 
		名称				占用空间大小	描述
		...	...	...
		PAGE_BTR_SEG_LEAF	10字节			B+树叶子段的头部信息，仅在B+树的根页定义
		PAGE_BTR_SEG_TOP	10字节			B+树非叶子段的头部信息，仅在B+树的根页定义

		PAGE_BTR_SEG_LEAF 和 PAGE_BTR_SEG_TOP 都占用10个字节，它们其实对应一个叫Segment Header的结构
		
		Segment Header结构的各个部分的具体释义如下：

			名称							占用字节数		描述
			Space ID of the INODE Entry		4				INODE Entry结构所在的表空间ID
			Page Number of the INODE Entry	4				INODE Entry结构所在的页面页号
			Byte Offset of the INODE Ent	2				INODE Entry结构在该页面中的偏移量	
					
		PAGE_BTR_SEG_LEAF 记录着叶子节点段对应的INODE Entry结构的地址是哪个表空间的哪个页面的哪个偏移量
		PAGE_BTR_SEG_TOP  记录着非叶子节点段对应的INODE Entry结构的地址是哪个表空间的哪个页面的哪个偏移量
			
		这样子索引和其对应的段的关系就建立起来了。
		
		不过需要注意的一点是，因为一个索引只对应两个段，所以只需要在索引的根页面中记录这两个结构即可。

		
		
		
		
				
一个扩展区大小 = 1 MB

一页大小 = 16 KB

一个区内的总页数 = 64 个页

一个 XDES 页中的 XDES 条目总数 = 256

可以在一个 XDES 页面中涵盖总范围 = 256 

总页面数可以包含一个 XDES 页面 = 16384 bytes
	select 64*256 = 16384
	
-------------------------------------------------------
从第2组开始，各组最开始的2个页面的类型是固定的


select 16384-10240 = 6144 bytes





	

	
	
如果把表空间比作是国家，段就相当于省，区就相当于市。一般的市都是属于某个省，就像FSEG状态的区全部属于某个段。而FREE、FREE_FRAG、FULL_FRAG这三种状态的区却直接隶属于表空间，就像北京市、天津市、上海市是直接属于国家管理一样。

			

看了第2遍就做笔记了，也可以，但是还要继续看。
第3遍：越看了越明了，结合整个章节一起看的话还没有很清晰
第4遍：画图？



《2020-07-15 - InnoDB表空间全局图 - by 邹召顺.png》
《数据页格式也来1个图》
	
	
其它相关参考：
	
	https://blog.csdn.net/mashaokang1314/article/details/109750095
	
	http://mysql.taobao.org/monthly/2019/10/01/

	https://www.leviathan.vip/2019/04/18/InnoDB%E7%9A%84%E6%96%87%E4%BB%B6%E7%BB%84%E7%BB%87%E7%BB%93%E6%9E%84/		












	