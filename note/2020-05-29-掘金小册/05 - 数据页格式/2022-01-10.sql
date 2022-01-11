1. 数据页结构
2. 记录头信息
3. 页目录(Page Directory)			
4. Page Header(页面头部)
5. File Header(文件头部)
6. File Trailer


1. 数据页结构

	名称					中文名				占用空间大小	简单描述
	File Header				文件头部			38字节			页的一些通用信息
	Page Header				页面头部			56字节			数据页专有的一些信息
	Infimum + Supremum		最小记录和最大记录	26字节			两个虚拟的行记录
	User Records			用户记录			不确定			实际存储的行记录内容
	Free Space				空闲空间			不确定			页中尚未使用的空间
	Page Directory			页面目录			不确定			页中的某些记录的相对位置
	File Trailer			文件尾部			8字节			校验页是否完整


2. 记录头信息

	用于描述记录的记录头信息，它是由固定的5个字节组成。5个字节也就是40个二进制位，不同的位代表不同的意思
	固定占 5 bytes, 包含下一条记录的位置，该行记录总长度，记录类型，是否被删除，对应的 slot 信息等	
	
		二进制位代表的详细信息如下表：

			名称			大小（单位：bit）	描述
			预留位1			1					没有使用
			预留位2			1					没有使用
			delete_mask		1					标记该记录是否被删除
			min_rec_mask	1					B+树的每层非叶子节点中的最小记录都会添加该标记
			n_owned			4					表示当前槽(slot)拥有的记录数
			heap_no			13					表示当前记录在本页中的位置(当前记录在本数据页中的编号)
			record_type		3					表示当前记录的类型，共有4种类型的记录：0表示普通记录，1表示B+树非叶子节点记录，2表示最小记录，3表示最大记录
			next_record		16					表示下一条记录的相对位置


	mysql> CREATE TABLE page_demo(
		->     c1 INT,
		->     c2 INT,
		->     c3 VARCHAR(10000),
		->     PRIMARY KEY (c1)
		-> ) CHARSET=ascii ROW_FORMAT=Compact;
	Query OK, 0 rows affected (0.03 sec)

	mysql> INSERT INTO page_demo VALUES(1, 100, 'aaaa'), (2, 200, 'bbbb'), (3, 300, 'cccc'), (4, 400, 'dddd');
	Query OK, 4 rows affected (0.00 sec)
	Records: 4  Duplicates: 0  Warnings: 0


	delete_mask：
	
		这个属性标记着当前记录是否被删除，占用1个二进制位
		0: 值为0的时候代表记录并没有被删除
		1: 值为1的时候代表记录被删除掉了。
		
		删除记录，不能直接从磁盘上删除的原因：
		
			因为移除它们之后把其他的记录在磁盘上重新排列需要性能消耗，所以只是打一个删除标记而已。
			-- 理解了，从性能上做考量。

		垃圾链表：
			所有被删除掉的记录都会组成一个所谓的垃圾链表
		
		可重用空间：
			在这个垃圾链表中的记录占用的空间称之为所谓的可重用空间，之后如果有新记录插入到表中的话，可能把这些被删除的记录占用的存储空间覆盖掉。

		
		将这个delete_mask位设置为1和将被删除的记录加入到垃圾链表中其实是两个阶段，后边会详细介绍。
		-- 这个要留意下。
		
	min_rec_mask	
		
		自己插入的四条记录的 min_rec_mask 值都是0，意味着它们都不是B+树的非叶子节点中的最小记录。
		
	
	heap_no
	
		当前记录在本页中的位置
		我们插入的4条记录在本页中的位置分别是：2、3、4、5
		
		伪记录分别为最小记录(Infimum)与最大记录(Supremum)
			
			这两条记录的构造：由5字节大小的记录头信息和8字节大小的一个固定的部分组成的
		
			所以共占用26字节：最小值记录：5+8 + 最大值记录：5+8 = 26
		
		最小记录和最大记录的heap_no值分别是0和1，也就是说它们的位置最靠前。
		
		
	record_type
		
		表示当前记录的类型，共有4种类型的记录：0表示普通记录，1表示B+树非叶子节点记录，2表示最小记录，3表示最大记录
			
		我们自己插入的记录就是普通记录，它们的record_type值都是0，而最小记录和最大记录的record_type值分别为2和3。


	next_record
		
		表示从当前记录的真实数据到下一条记录的真实数据的地址偏移量。
		
		目前可以理解为指向下一条记录的指针，通过当前记录，可以快速找到下一条记录。
		
		下一条记录指得并不是按照我们插入顺序的下一条记录，而是按照主键值由小到大的顺序的下一条记录
		
		规定 Infimum 记录（也就是最小记录） 的下一条记录就是本页中主键值最小的用户记录，而本页中主键值最大的用户记录的下一条记录就是 Supremum记录（也就是最大记录）
		
		我们的记录按照主键从小到大的顺序形成了一个单链表。最大记录的next_record的值为0，这也就是说最大记录是没有下一条记录了，它是这个单链表中的最后一个节点。
		
		
		假设删除了 c1 = 2 这一行记录：
			mysql> DELETE FROM page_demo WHERE c1 = 2;
			Query OK, 1 row affected (0.02 sec)
		
			从《删掉第2条记录后的示意图.png》图中可以看出来，删除第2条记录前后主要发生了这些变化：
				
				1. 第2条记录并没有从存储空间中移除，而是把该条记录的delete_mask值设置为1。
				2. 第2条记录的next_record值变为了0，意味着该记录没有下一条记录了。
				3. 第1条记录的next_record指向了第3条记录。
				4. 最大记录的n_owned值从5变成了4
						
		
		
		再次把这条记录插入到表中：
			mysql> INSERT INTO page_demo VALUES(2, 200, 'bbbb');
			Query OK, 1 row affected (0.00 sec)
			
			
			从图《重新插入被删除记录的示意图.png》中可以看到，InnoDB并没有因为新记录的插入而为它申请新的存储空间，而是直接复用了原来被删除记录的存储空间。
			
			
		小结：
		
			不论我们怎么对页中的记录做增删改操作，InnoDB始终会维护一条记录的单链表，链表中的各个节点是按照主键值由小到大的顺序连接起来的。
			
			当数据页中存在多条被删除掉的记录时，这些记录的next_record属性将会把这些被删除掉的记录组成一个垃圾链表，以备之后重用这部分存储空间。



3. 页目录(Page Directory)			
			
	mysql> CREATE TABLE page_demo(
		->     c1 INT,
		->     c2 INT,
		->     c3 VARCHAR(10000),
		->     PRIMARY KEY (c1)
		-> ) CHARSET=ascii ROW_FORMAT=Compact;
	Query OK, 0 rows affected (0.03 sec)

	mysql> INSERT INTO page_demo VALUES(1, 100, 'aaaa'), (2, 200, 'bbbb'), (3, 300, 'cccc'), (4, 400, 'dddd');
	Query OK, 4 rows affected (0.00 sec)
	Records: 4  Duplicates: 0  Warnings: 0
		
		一共有6行记录：分别为最小值记录、最大值记录，还有4条真实的记录
		分为2组：
			第一组：最小值记录
			第二组：4条真实的记录 + 最大值记录
			

	页目录(Page Directory)
		将每个组的最后一条记录的地址偏移量单独提取出来按顺序存储到靠近页的尾部的地方，这个地方就是所谓的Page Directory，也就是页目录（此时应该返回头看看页面各个部分的图）。
		
	槽(Slot)
		页面目录中的这些地址偏移量被称为槽（英文名：Slot），所以这个页面目录就是由槽组成的。
	
	
	
	对每个分组中的记录条数是有规定的：

		1. 最小记录所在的分组： 只能有 1 条记录
		2. 最大记录所在的分组： 拥有的记录条数只能在 1~8 条之间
		3. 剩下的分组：         记录的条数范围只能在是 4~8 条之间。
		
	所以分组是按照下边的步骤进行的：


		1. 初始情况下一个数据页里只有最小记录和最大记录两条记录，它们分属于两个分组。

		2. 之后每插入一条记录，都会从页目录中找到主键值比本记录的主键值大并且差值最小的槽，
			然后把该槽对应的记录的n_owned值加1，表示本组内又添加了一条记录，直到该组中的记录数等于8个。

		3. 在一个组中的记录数等于8个后再插入一条记录时，会将组中的记录拆分成两个组，一个组中4条记录，另一个5条记录。
			
			这个过程会在页目录中新增一个槽来记录这个新增分组中最大的那条记录的偏移量。
		

	继续往表中添加12条记录

	mysql> INSERT INTO page_demo VALUES(5, 500, 'eeee'), (6, 600, 'ffff'), (7, 700, 'gggg'), (8, 800, 'hhhh'), (9, 900, 'iiii'), (10, 1000, 'jjjj'), (11, 1100, 'kkkk'), (12, 1200, 'llll'), (13, 1300, 'mmmm'), (14, 1400, 'nnnn'), (15, 1500, 'oooo'), (16, 1600, 'pppp');
	Query OK, 12 rows affected (0.00 sec)
	Records: 12  Duplicates: 0  Warnings: 0


	现在页里边就一共有18条记录了（包括最小和最大记录），这些记录被分成了5个组，


	现在看怎么从这个页目录中查找记录：

		因为各个槽代表的记录的主键值都是从小到大排序的，所以我们可以使用所谓的二分法来进行快速查找。
		5个槽的编号分别是：0、1、2、3、4，所以初始情况下最低的槽就是low=0，最高的槽就是high=4
		
		比方说我们想找主键值为6的记录，过程是这样的：
		
			
4. Page Header(页面头部)

	为了能得到一个数据页中存储的记录的状态信息
	
		比如本页中已经存储了多少条记录，第一条记录的地址是什么，页目录中存储了多少个槽等等，特意在页中定义了一个叫Page Header的部分
		
	它是页结构的第二部分，这个部分占用固定的56个字节
	
		名称					占用空间大小		描述
		PAGE_N_DIR_SLOTS		2字节				在页目录中的槽数量
		PAGE_HEAP_TOP			2字节				还未使用的空间最小地址，也就是说从该地址之后就是Free Space
		PAGE_N_HEAP				2字节				本页中的记录的数量（包括最小和最大记录以及标记为删除的记录）
		PAGE_FREE				2字节				第一个已经标记为删除的记录地址（各个已删除的记录通过next_record也会组成一个单链表，这个单链表中的记录可以被重新利用）
		PAGE_GARBAGE			2字节				已删除记录占用的字节数
		PAGE_LAST_INSERT		2字节				最后插入记录的位置
		PAGE_DIRECTION			2字节				记录插入的方向(左边或者右边)
		PAGE_N_DIRECTION		2字节				一个方向连续插入的记录数量
		PAGE_N_RECS				2字节				该页中记录的数量（不包括最小和最大记录以及被标记为删除的记录）
		PAGE_MAX_TRX_ID			8字节				修改当前页的最大事务ID，该值仅在二级索引中定义
		PAGE_LEVEL				2字节				前页在B+树中所处的层级
		PAGE_INDEX_ID			8字节				索引ID，表示当前页属于哪个索引
		PAGE_BTR_SEG_LEAF		10字节	B+树叶子段的头部信息，仅在B+树的Root页定义
		PAGE_BTR_SEG_TOP		10字节	B+树非叶子段的头部信息，仅在B+树的Root页定义




	PAGE_DIRECTION

		假如新插入的一条记录的主键值比上一条记录的主键值大，我们说这条记录的插入方向是右边，反之则是左边。
		用来表示最新一条记录插入方向的状态就是 PAGE_DIRECTION。

	PAGE_N_DIRECTION

		假设连续几次插入新记录的方向都是一致的，InnoDB会把沿着同一个方向插入记录的条数记下来，这个条数就用 PAGE_N_DIRECTION 这个状态表示。
		当然，如果最后一条记录的插入方向改变了的话，这个状态的值会被清零重新统计。

	至于我们没提到的那些属性，我没说是因为现在不需要大家知道。不要着急，当我们学完了后边的内容，你再回头看，一切都是那么清晰。
	
	
5. File Header(文件头部)

	File Header针对各种类型的页都通用，也就是说不同类型的页都会以File Header作为第一个组成部分
	
	
	它描述了一些针对各种页都通用的一些信息：
		比如这个页的编号是多少，它的上一个页、下一个页是谁等等
		
	这个部分占用固定的38个字节，是由下边这些内容组成的：
	
		名称								占用空间大小	描述
		FIL_PAGE_SPACE_OR_CHKSUM			4字节			页的校验和（checksum值）
		FIL_PAGE_OFFSET						4字节			页号
		FIL_PAGE_PREV						4字节			上一个页的页号
		FIL_PAGE_NEXT						4字节			下一个页的页号
		FIL_PAGE_LSN						8字节			页面被最后修改时对应的日志序列位置（英文名是：Log Sequence Number）
		FIL_PAGE_TYPE						2字节			该页的类型
		FIL_PAGE_FILE_FLUSH_LSN				8字节			仅在系统表空间的一个页中定义，代表文件至少被刷新到了对应的LSN值
		FIL_PAGE_ARCH_LOG_NO_OR_SPACE_ID	4字节			页属于哪个表空间
		
		
	FIL_PAGE_SPACE_OR_CHKSUM
		
		代表当前页面的校验和(checksum值)
		含义：
			就是对于一个很长很长的字节串来说，我们会通过某种算法来计算一个 比较短的值 来代表这个很长的字节串，这个 比较短的值 就称为校验和
			在比较两个很长的字节串之前先比较这两个长字节串的校验和，如果校验和都不一样两个长字节串肯定是不同的，所以省去了直接比较两个比较长的字节串的时间损耗。

		
	FIL_PAGE_OFFSET
			
		每一个页都有一个单独的页号(数据页编号)，就跟身份证号码一样，InnoDB通过页号来可以唯一定位一个页。

	
	FIL_PAGE_TYPE
	
		代表当前页的类型
		
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
	
	
	FIL_PAGE_PREV和FIL_PAGE_NEXT
		
		FIL_PAGE_PREV：当前数据页的上一个页
		FIL_PAGE_NEXT：当前数据页的下一个页
		B+ TREE特性决定了叶子节点必须是双向链表，这样通过建立一个双向链表把许许多多的页就都串联起来了，而无需这些页在物理上真正连着
	
	
6. File Trailer
	
	作用： 为了检测页是否已经完整地写入磁盘(如可能发生的写入过程中磁盘损坏 机器关机等)
	
	1个数据页(16KB)从内存同步到磁盘，如果同步了一部分(8KB)的时候中断电，这个时候就需要检测这个数据页是否的
	
	因此，在每个页的尾部都加了一个File Trailer部分，这个部分由8个字节组成，可以分成2个小部分：
	
		1. 前4个字节代表页的校验和：
			这个部分是和File Header中的校验和相对应的。
			
			数据页是完整的：
				File Trailer.校验和 = File Header.FIL_PAGE_SPACE_OR_CHKSUM(校验和)：说明数据页是完成的。
				
				每当一个页面在内存中修改了，在同步之前就要把它的校验和算出来，
				因为File Header在页面的前边，所以校验和会被首先同步到磁盘，
				当完全写完时，校验和也会被写到页的尾部，如果完全同步成功，则页的首部和尾部的校验和应该是一致的
				
			数据页不是完整的：
				如果脏页写了一半儿断电了，那么在File Header中的校验和就代表着已经修改过的页，而在File Trailer中的校验和代表着原先的页，二者不同则意味着同步中间出了错。
				
				这种情况会导致MySQL crash 还是 会说应用 double write 恢复出最新更新的数据页？
				
			
			
			MySQL crash
				参数 innodb_checksums： InnoDB 每次从磁盘读取一个页就会检测该页的完整性， 如果发现不同，则会导致MySQL crash。
				该参数用于开启或者关闭对这个页完整性的检查。
					《MySQL技术内幕 InnoDB存储引擎》
					
				数据页的头尾除了一些元信息外，还有Checksum校验值，这些校验值在写入磁盘前计算得到，当从磁盘中读取时，重新计算校验值并与数据页中存储的对比，如果发现不同，则会导致MySQL crash
					https://www.cnblogs.com/coderyuhui/p/8884717.html
				
				
		2. 后4个字节代表页面被最后修改时对应的日志序列位置（LSN）
			这个部分也是为了校验页的完整性的
			可以先不用管这个属性。

	

	
	这个 File Trailer 与 File Header 类似，都是所有类型的页通用的。
		