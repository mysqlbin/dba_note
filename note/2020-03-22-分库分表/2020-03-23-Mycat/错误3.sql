

日志:

	Caused by: io.mycat.config.util.ConfigException: Illegal table conf : table [ TEST1 ] rule function [ partbyday ] partition size : 7 > table datanode size : 4, please make sure table datanode size = function partition size


schema.xml
	<table name="test1" primaryKey="ID" autoIncrement="true" dataNode="dn1,dn2,dn5,dn9"  rule="sharding-by-partbyday" splitTableNames ="true"/>   <!--表test1 拆分的节点以及拆分规则-->


	<dataNode name="dn1" dataHost="datahost_201" database="db1" />
	<dataNode name="dn2" dataHost="datahost_201" database="db2" />
	<dataNode name="dn3" dataHost="datahost_201" database="db3" />
	<dataNode name="dn4" dataHost="datahost_201" database="db4" />

	<dataNode name="dn5" dataHost="datahost_202" database="db1" />
	<dataNode name="dn6" dataHost="datahost_202" database="db2" />
	<dataNode name="dn7" dataHost="datahost_202" database="db3" />
	<dataNode name="dn8" dataHost="datahost_202" database="db4" />

	<dataNode name="dn9"  dataHost="datahost_203" database="db1" />
	<dataNode name="dn10" dataHost="datahost_203" database="db2" />
	<dataNode name="dn11" dataHost="datahost_203" database="db3" />
	<dataNode name="dn12" dataHost="datahost_203" database="db4" />

rule.xml 

	<tableRule name="sharding-by-partbyday">   <!-- 表test1 的拆分规则配置-->

		<rule>
			<columns>CreateTime</columns>
			<algorithm>partbyday</algorithm>
		</rule>
	</tableRule>
	


	<!-- 按天分片 -->
	<function name="partbyday"
			  class="io.mycat.route.function.PartitionByDate">
		<property name="dateFormat">yyyy-MM-dd</property>
		<property name="sNaturalDay">0</property>
		<property name="sBeginDate">2020-03-01</property>
		<property name="sEndDate">2020-05-01</property>
		<property name="sPartionDay">10</property>
	</function>
	
	
调用 rule.xml
	<!-- 按天分片 -->
	<function name="partbyday"
			  class="io.mycat.route.function.PartitionByDate">
		<property name="dateFormat">yyyy-MM-dd</property>
		<property name="sNaturalDay">0</property>
		<property name="sBeginDate">2020-03-01</property>
		<property name="sEndDate">2020-04-09</property>
		<property name="sPartionDay">10</property>
	</function>
	
	
	