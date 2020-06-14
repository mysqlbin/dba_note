
mycat_user@mysqldb 01:38:  [mycat_db]> INSERT INTO `test4` (`name`, `CreateTime`) VALUES ('lujb', '2019-03-10');
ERROR 1064 (HY000): Can t find a valid data node for specified node index :TEST4 -> CREATETIME -> 2019-03-10 -> Index : 2

	<!-- 按月份分片 -->
	<function name="partbymonth"
			  class="io.mycat.route.function.PartitionByMonth">
		<property name="dateFormat">yyyy-MM-dd</property>
		<property name="sBeginDate">2019-01-01</property>
	</function>
	
	<table name="test4" primaryKey="ID" autoIncrement="true" dataNode="dn2,dn4" rule="sharding-by-partbymonth" splitTableNames ="true"/>
	
	只做了2个分片, 导致，超出部分就直接抛数组越界异常了。