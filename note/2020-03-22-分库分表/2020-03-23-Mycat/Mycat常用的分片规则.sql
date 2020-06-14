
1. 分片规则概述
2. Mycat 全局表
3. ER 分片表
4. 多对多关联
5. 主键分片 vs 非主键分片
6. Mycat 常用的分片规则
	1. 分片枚举
	2. 固定分片 hash 算法
	3. 范围约定 auto-sharding-long  
	4. 取模		mod-long		           # 已经测试
	5. 按日期（天）分片 sharding-by-date   # 已经测试
	6. 取模范围约束
	7. 截取数字做 hash 求模范围约束
	8. 应用指定
	9. 截取数字 hash 解析
	10. 一致性 hash
	11. 按单月小时拆分
	12. 范围求模分片    auto-sharding-rang-mod  # 已经测试     
	13. 日期范围 hash 分片
	14. 冷热数据分片
	15. 自然月分片    sharding-by-month     #  在测试
	
		
1. 分片规则概述
	在数据切分处理中，特别是水平切分中，中间件最终要的两个处理过程就是数据的切分、数据的聚合。
	选择合适的切分规则，至关重要，因为它决定了后续数据聚合的难易程度，甚至可以避免跨库的数据聚合处理。
	
	# 尽量避免跨库做数据聚合处理
	
2. Mycat 全局表
	数据量不大的表, 经常需要跟分片表做 join, 这种表适合于Mycat 全局表
	全局表就是需要在每个分片上都保存一份数据, Mycat 在 join 操作中, 业务表跟全局表进行聚合, 会优先选择相同分片内的全局表join, 避免跨库 join
	在进行数据插入时, mycat 将把数据分发到全局表对应的所有分片执行, 在进行数据读取时将会随机获取一个节点读取数据.
	
	全局表的配置:
		<table name="t_area" primaryKey="id" type="global" dataNode="dn1,dn2" />
		
	
	
3. ER 分片表
	适用于父子关系表
	把父表 对应 子表的数据放到同一个分片中
	<table name="order" dataNode="dn$1-32" rule="mod-long">
		<childTable name="order_detail" primaryKey="id" joinKey="order_id" parentKey="order_id" />
	</table>
	
4. 多对多关联
	
	目前总的原则是需要从业务角度来看，关系表更偏向哪个表，即“A 的关系” 还是“B 的关系” ，来决定关系表跟从那个方向存储，未来 Mycat 版本中将考虑将中间表进行双向复制
	
	
5. 主键分片 vs 非主键分片
	当你没有任何字段可以作为分片字段的时候，主键分片就是唯一选择，其优点是按照主键的查询最快，当采用自动增长的序列号作为主键时，还能比较均匀的将数据分片在不同的节点上
	若有某个合适的业务字段比较合适作为分片字段，则建议采用此业务字段分片，选择分片字段的条件如下：
		1. 尽可能的比较均匀分布数据到各个节点上；
 		2. 该业务字段是最频繁的或者最重要的查询条件。
	
	常见的除了主键之外的其他可能分片字段有“订单创建时间” 、 “店铺类别” 或“所在省” 等。
	当你找到某个合适的业务字段作为分片字段以后，不必纠结于“牺牲了按主键查询记录的性能” ，因为在这种情况下，MyCAT 提供了“主键到分片” 的内存缓存机制，热点数据按照主键查询，丝毫不损失性能
	
	<table name="t_user" primaryKey="user_id" dataNode="dn$1-32" rule="mod-long">
	<childTable name="t_user_detail" primaryKey="id" joinKey="user_id" parentKey="user_id" />
	</table>
	
	对于非主键分片的 table， 填写属性 primaryKey，此时 MyCAT 会将你根据主键查询的 SQL 语句的第一次执行结果进行分析，确定该 Table 的某个主键在什么分片上，并进行主键到分片 ID 的缓存。
	第二次或后续查询 mycat 会优先从缓存中查询是否有 id–>node 即主键到分片的映射，如果有直接查询，通过此种方法提高了非主键分片的查询性能


6. Mycat 常用的分片规则
	前言
		如何去分片，如何选择合适分片的规则，总之尽量规避跨库 Join 是一条最重要的原则
		将介绍 Mycat 目前已有的分片规则，每种规则都有特定的场景，分析每种规则去选择合适的应用到项目中。
		要知道每种规则的特定的场景 
	
	1. 分片枚举
	
		通过在配置文件中配置可能的枚举 id，自己配置分片，本规则适用于特定的场景，比如有些业务需要按照省份或区县来做保存，而全国省份区县固定的，这类业务使用本条规则，配置如下：
		<tableRule name="sharding-by-intfile">
			<rule>
			<columns>user_id</columns>
			<algorithm>hash-int</algorithm>
			</rule>
		</tableRule>
		<function name="hash-int" class="io.mycat.route.function.PartitionByFileMap">
			<property name="mapFile">partition-hash-int.txt</property>
			<property name="type">0</property>
			<property name="defaultNode">0</property>
		</function>
		
		partition-hash-int.txt 配置：
			10000=0         # 等于 10000 的路由到 第1个节点
			10010=1         # 等于 10010 的路由到 第2个节点
			DEFAULT_NODE=1
			
		columns 标识将要分片的表字段
		algorithm 分片函数，其中分片函数配置中
			mapFile 标识配置文件名称
			type 默认值为 0, 0 表示 Integer, 非零表示 String 所有的节点配置都是从 0 开始，及 0 代表节点 1
		
		/**
		* defaultNode 默认节点: 小于 0 表示不设置默认节点，大于等于 0 表示设置默认节点
		* 默认节点的作用：      枚举分片时，如果碰到不识别的枚举值，就让它路由到默认节点
		* 如果不配置默认节点（ defaultNode 值小于 0 表示不配置默认节点） ，碰到不识别的枚举值就会报错: like this： can’t find datanode for sharding column:column_nameval:ffffffff
		*/
		
		
	2. 固定分片 hash 算法
		按照二进制求模运算, 取 id 的二进制低10位, 即 id 二进制 &1111111111 
		在连续插入 1-10 时候 1-10 会根据二进制则可能会分到连续的分片，减少插入事务事务控制难度。
	
	
		<tableRule name="rule1">
			<rule>
			<columns>user_id</columns>
			<algorithm>func1</algorithm>
			</rule>
		</tableRule>
		<function name="func1" class="io.mycat.route.function.PartitionByLong">
			<property name="partitionCount">2,1</property>
			<property name="partitionLength">256,512</property>
		</function>	

	
		配置说明：
			columns 标识将要分片的表字段
			algorithm 分片函数，
			partitionCount 分片个数列表
			partitionLength 分片范围列表
			分区长度: 默认为最大 2^n=1024 ,即最大支持 1024 分区
			约 束 :
				count,length 两个数组的长度必须是一致的。
				1024 = sum((count[i]*length[i])). count 和 length 两个向量的点积恒等于 1024
				
	3. 范围约定

		此分片适用于，提前规划好分片字段某个范围属于哪个分片，
			start <= range <= end.
			range start-end ,data node index
			K=1000,M=10000.
			
			<tableRule name="auto-sharding-long">
				<rule>
					<columns>user_id</columns>
					<algorithm>rang-long</algorithm>
				</rule>
			</tableRule>
			<function name="rang-long" class="io.mycat.route.function.AutoPartitionByLong">
				<property name="mapFile">autopartition-long.txt</property>
				<property name="defaultNode">0</property>
			</function>		
	
			配置说明：
				columns      标识将要分片的表字段
				algorithm   分片函数，
				rang-long   函数中 mapFile 代表配置文件路径
				defaultNode 超过范围后的默认节点。
				所有的节点配置都是从 0 开始，及 0 代表节点 1，此配置非常简单，即预先制定可能的 id 范围到某个分片
				0-500M=0
				500M-1000M=1
				1000M-1500M=2
				或
				0-10000000=0
				10000001-20000000=1	
	
	4. 取模
		此规则为对分片字段求模运算。
	
		<tableRule name="mod-long">
			<rule>
				<columns>user_id</columns>
				<algorithm>mod-long</algorithm>
			</rule>
		</tableRule>
		<function name="mod-long" class="io.mycat.route.function.PartitionByMod">
			<!-- how many data nodes -->
			<property name="count">3</property>
		</function>	
	
	
	
		columns 标识将要分片的表字段
		algorithm 分片函数
		此种配置非常明确即根据 id 进行十进制求模预算，相比固定分片 hash，此种在批量插入时可能存在批量插入单事务插入多数据分片，增大事务一致性难度。

	5. 按日期（天）分片
		此规则为按天分片
		
		<tableRule name="sharding-by-date">
			<rule>
				<columns>create_time</columns>
				<algorithm>sharding-by-date</algorithm>
			</rule>
		</tableRule>
		<function name="sharding-by-date" class="io.mycat.route.function.PartitionByDate">
			<property name="dateFormat">yyyy-MM-dd</property>
			<property name="sBeginDate">2014-01-01</property>
			<property name="sEndDate">2014-01-02</property>
			<property name="sPartionDay">10</property>
		</function>


		配置说明：
			columns ：    标识将要分片的表字段
			algorithm ：  分片函数
			dateFormat ： 日期格式
			sBeginDate ： 开始日期
			sEndDate：    结束日期
			sPartionDay ：分区天数，即默认从开始日期算起，分隔 10 天一个分区
			如果配置了 sEndDate 则代表数据达到了这个日期的分片后后循环从开始分片插入。
			
	6. 取模范围约束
		此种规则是取模运算与范围约束的结合，主要为了后续数据迁移做准备，即可以自主决定取模后数据的节点分布		

		<tableRule name="sharding-by-pattern">
			<rule>
				<columns>user_id</columns>
				<algorithm>sharding-by-pattern</algorithm>
			</rule>
		</tableRule>
		<function name="sharding-by-pattern" class="io.mycat.route.function.PartitionByPattern"
			<property name="patternValue">256</property>
			<property name="defaultNode">2</property>
			<property name="mapFile">partition-pattern.txt</property>
		</function>		
		
		partition-pattern.txt
			# id partition range start-end ,data node index
			###### first host configuration
			1-32=0
			33-64=1
			65-96=2
			97-128=3
			129-160=4
			161-192=5
			193-224=6
			225-256=7
			0-0=7

			配置说明：
				columns      标识将要分片的表字段
				algorithm    分片函数
				patternValue 即求模基数
				defaoultNode 默认节点，如果配置了默认，则不会按照求模运算
				mapFile      配置文件路径
				配置文件中， 1-32 即代表 id%256 后分布的范围，如果在 1-32 则在分区 1，其他类推，如果 id 非数据，则会分配在 defaoultNode 默认节点
				
	7. 截取数字做 hash 求模范围约束    
		此种规则类似于取模范围约束，此规则支持数据符号字母取模
		
		<tableRule name="sharding-by-prefixpattern">
			<rule>
				<columns>user_id</columns>
				<algorithm>sharding-by-prefixpattern</algorithm>
			</rule>
		</tableRule>
		<function name="sharding-by-pattern" class="io.mycat.route.function.PartitionByPrefixPattern">
			<property name="patternValue">256</property>
			<property name="prefixLength">5</property>
			<property name="mapFile">partition-pattern.txt</property>
		</function>		
			
		
		partition-pattern.txt
			# range start-end ,data node index
			# ASCII
			# 8-57=0-9 阿拉伯数字
			# 64、 65-90=@、 A-Z
			# 97-122=a-z
			###### first host configuration
			1-4=0
			5-8=1
			9-12=2
			13-16=3
			###### second host configuration
			17-20=4
			21-24=5
			25-28=6
			29-32=7
			0-0=7

		配置说明：
			columns 标识将要分片的表字段
			algorithm 分片函数
			patternValue 即求模基数， 
			prefixLength ASCII 截取的位数
			mapFile 配置文件路径
			配置文件中:
				1-32 即代表 id%256 后分布的范围，如果在 1-32 则在分区 1，其他类推
				此种方式类似方式 6 只不过采取的是将列种获取前 prefixLength 位列所有 ASCII 码的和进行求模sum%patternValue ,获取的值，在范围内的分片数
				
		# 这里不理解, 感觉文档是有问题的
	
	8. 应用指定
		此规则是在运行阶段由应用自主决定路由到那个分片。
		
		<tableRule name="sharding-by-substring">
			<rule>
				<columns>user_id</columns>
				<algorithm>sharding-by-substring</algorithm>
			</rule>
		</tableRule>
		<function name="sharding-by-substring"
			class="io.mycat.route.function.PartitionDirectBySubString">
			<property name="startIndex">0</property><!-- zero-based -->
			<property name="size">2</property>
			<property name="partitionCount">8</property>
			<property name="defaultPartition">0</property>
		</function>
		
		
		配置说明：
			columns 标识将要分片的表字段
			algorithm 分片函数
			
			此方法为直接根据字符子串（必须是数字）计算分区号（由应用传递参数，显式指定分区号）。
			例如 id=05-100000002
			在此配置中代表根据 id 中从 startIndex=0，开始，截取 size=2 位数字即 05， 05 就是获取的分区，如果没传默认分配到 defaultPartition

	9. 截取数字 hash 解析
		此规则是截取字符串中的 int 数值 hash 分片。

		<tableRule name="sharding-by-stringhash">
			<rule>
				<columns>user_id</columns>
				<algorithm>sharding-by-stringhash</algorithm>
			</rule>
		</tableRule>
		<function name="sharding-by-stringhash" class="io.mycat.route.function.PartitionByString">
			<property name="partitionLength">512</property><!-- zero-based -->
			<property name="partitionCount">2</property>
			<property name="hashSlice">0:2</property>
		</function>
			
		配置说明：
			columns 标识将要分片的表字段
			algorithm 分片函数
			函数中 partitionLength 代表字符串 hash 求模基数
			partitionCount 分区数
			hashSlice hash 预算位，即根据子字符串中 int 值 hash 运算

	10. 一致性 hash
		一致性 hash 预算有效解决了分布式数据的扩容问题。
	
		<tableRule name="sharding-by-murmur">
			<rule>
				<columns>user_id</columns>
				<algorithm>murmur</algorithm>
			</rule>
		</tableRule>
		<function name="murmur" class="io.mycat.route.function.PartitionByMurmurHash">
			<property name="seed">0</property><!-- 默认是 0-->
			<property name="count">2</property><!-- 要分片的数据库节点数量，必须指定，否则没法分片-->
			<property name="virtualBucketTimes">160</property><!-- 一个实际的数据库节点被映射为这么多虚拟节点，默认是 160 倍，也就是虚拟节点数是物理节点数的 160 倍-->
		
			<property name="weightMapFile">weightMapFile</property> <!-- 节点的权重，没有指定权重的节点默认是 1。以 properties 文件的格式填写，以从 0 开始到 count-1 的整数值也就是节点索引为 key，
			<!-- 以节点权重值为值。所有权重值必须是正整数，否则以 1 代替 -->
		
			<property name="bucketMapPath">/etc/mycat/bucketMapPath</property> <!--用于测试时观察各物理节点与虚拟节点的分布情况，如果指定了这个属性，会把虚拟节点的 murmur hash 值与物理节
			<!--点的映射按行输出到这个文件，没有默认值，如果不指定，就不会输出任何东西 -->
		</function>


	11. 按单月小时拆分
		此规则是单月内按照小时拆分，最小粒度是小时，可以一天最多 24 个分片，最少 1 个分片，一个月完后下月从头开始循环。
		每个月月尾，需要手工清理数据。
		
		<tableRule name="sharding-by-hour">
			<rule>
				<columns>create_time</columns>
				<algorithm>sharding-by-hour</algorithm>
			</rule>
		</tableRule>
		<function name="sharding-by-hour" class="io.mycat.route.function.LatestMonthPartion">
			<property name="splitOneDay">24</property>
		</function>		
	
		配置说明：
			columns：       拆分字段，字符串类型（yyyymmddHH）
			splitOneDay ：  一天切分的分片数
			
			
	12. 范围求模分片
		原理: 先进行范围分片计算出分片组，组内再求模
		优点
			可以避免扩容时的数据迁移，又可以一定程度上避免范围分片的热点问题
			综合了范围分片和求模分片的优点，分片组内使用求模可以保证组内数据比较均匀，分片组之间是范围分片可以兼顾范围查询。
			最好事先规划好分片的数量，数据扩容时按分片组扩容，则原有分片组的数据不需要迁移。
			由于分片组内数据比较均匀，所以分片组内可以避免热点数据问题。
		
		<tableRule name="auto-sharding-rang-mod">
			<rule>
				<columns>id</columns>
				<algorithm>rang-mod</algorithm>
			</rule>
		</tableRule>
		<function name="rang-mod" class="io.mycat.route.function.PartitionByRangeMod">
			<property name="mapFile">partition-range-mod.txt</property>
			<property name="defaultNode">21</property>
		</function>	
			
		配置说明：
			columns 标识将要分片的表字段
			algorithm 分片函数
			rang-mod 函数中 mapFile 代表配置文件路径
			defaultNode 超过范围后的默认节点顺序号，节点从 0 开始。

			partition-range-mod.txt
				range start-end ,data node group size
				以下配置一个范围代表一个分片组， =号后面的数字代表该分片组所拥有的分片的数量。
				0-200M=5       //代表有 5 个分片节点
				200M1-400M=1
				400M1-600M=4
				600M1-800M=4
				800M1-1000M=6
				
		# 这里还不理解 
		参考:  https://blog.csdn.net/weikaixxxxxx/article/details/85391240  范围求模分片与扩容
			通过学习这篇文章, 发现理解了一点了, 需要做实验.
			
		已做实验, 理解了.
		
	
	13. 日期范围 hash 分片
		原理: 
			思想与范围求模一致，当由于日期在取模会有数据集中问题，所以改成 hash 方法。
			先根据日期分组，再根据时间 hash 使得短期内数据分布的更均匀
		优点:
			可以避免扩容时的数据迁移，又可以一定程度上避免范围分片的热点问题
			要求日期格式尽量精确些，不然达不到局部均匀的目的
			
		<tableRule name="rangeDateHash">
			<rule>
				<columns>col_date</columns>
				<algorithm>range-date-hash</algorithm>
			</rule>
		</tableRule>
		<function name="range-date-hash" class="io.mycat.route.function.PartitionByRangeDateHash">
			<property name="sBeginDate">2014-01-01 00:00:00</property>
			<property name="sPartionDay">3</property>
			<property name="dateFormat">yyyy-MM-dd HH:mm:ss</property>
			<property name="groupPartionSize">6</property>
		</function>
		
		sPartionDay      代表多少天分一个分片
		groupPartionSize 代表分片组的大小
		
	14. 冷热数据分片
		根据日期查询日志数据 冷热数据分布 ，最近 n 个月的到实时交易库查询，超过 n 个月的按照 m 天分片
		<tableRule name="sharding-by-hotdate">
			<rule>
				<columns>create_time</columns>
				<algorithm>sharding-by-hotdate</algorithm>
			</rule>
		</tableRule>
		<function name="sharding-by-hotdate" class="io.mycat.route.function.PartitionByHotDate">
			<property name="dateFormat">yyyy-MM-dd</property>
			<property name="sLastDay">10</property>
			<property name="sPartionDay">30</property>
		</function>
		
		配置说明
			columns ：     分片字段，字符串类型
			dateFormat ：  时间格式化
			sLastDay :     热数据的天数
			sPartionDay :  冷数据的分片天数（按照天数分片）
			
		# 需要做实验
		
	15. 自然月分片
		按月份列分区 ，每个自然月一个分片，格式 between 操作解析的范例
		<tableRule name="sharding-by-month">
			<rule>
				<columns>create_time</columns>
				<algorithm>sharding-by-month</algorithm>
			</rule>
		</tableRule>
		<function name="sharding-by-month" class="io.mycat.route.function.PartitionByMonth">
			<property name="dateFormat">yyyy-MM-dd</property>
			<property name="sBeginDate">2014-01-01</property>
		</function>
		
		配置说明：
			columns ：     分片字段，字符串类型
			dateFormat ： 日期字符串格式
			sBeginDate ： 开始日期
			
		PartitionByMonth partition = new PartitionByMonth();
		partition.setDateFormat("yyyy-MM-dd");
		partition.setsBeginDate("2014-01-01");
		partition.init();
		Assert.assertEquals(true, 0 == partition.calculate("2014-01-01"));
		Assert.assertEquals(true, 0 == partition.calculate("2014-01-10"));
		Assert.assertEquals(true, 0 == partition.calculate("2014-01-31"));
		Assert.assertEquals(true, 1 == partition.calculate("2014-02-01"));
		Assert.assertEquals(true, 1 == partition.calculate("2014-02-28"));
		Assert.assertEquals(true, 2 == partition.calculate("2014-03-1"));
		Assert.assertEquals(true, 11 == partition.calculate("2014-12-31"));
		Assert.assertEquals(true, 12 == partition.calculate("2015-01-31"));
		Assert.assertEquals(true, 23 == partition.calculate("2015-12-31"));

		
		一般来说，按自然月份来进行数据分片的规则比较适用于商城系统订单查询，类似最近三个月、最近半年等查询，这样的数据放在一个分片就省去了MyCat进行数据合并的时间,
		当然按月分片之后每个自然月分片的数据量不要过大。

		实现方式： 将数据按一年中的月份进行分片，每个自然月对应一个分片。
		优点：     可以自由地将每个月的数据分开保存。
		缺点：     由于数据是连续的，其他自然月分片中的资源无法被充分利用。
		
		
		

看看分片规则能不能做成表格的形式


