
https://mp.weixin.qq.com/s/RagHfZVZvq6zycZDqIvZYw  线上一个client连接失败报错

https://mp.weixin.qq.com/s/vjNxRtTm5z59fv4wDwVacw  关于Aborted connection告警日志的分析

0. Got an error reading communication packets

	读取通信数据包时出错

尝试修改max_allowed_packet参数的大小

	mysql> show global variables like '%max_allowed_packet%';
	+--------------------------+------------+
	| Variable_name            | Value      |
	+--------------------------+------------+
	| max_allowed_packet       | 4194304    |
	| slave_max_allowed_packet | 1073741824 |
	+--------------------------+------------+
	2 rows in set (0.00 sec)
	select 4194304/1024/1024 = 4MB;
		2020-09-04T02:53:54.524817Z 33743 [Note] Aborted connection 33743 to db: 'consistency_db' user: 'root' host: '111.111.1.10' (Got an error reading communication packets)


	set global max_allowed_packet=16777216;
		2020-09-04T02:53:54.524817Z 33743 [Note] Aborted connection 33743 to db: 'consistency_db' user: 'root' host: '111.111.1.10' (Got an error reading communication packets)



尝试修改net_buffer_length参数的大小
	mysql> show global variables like '%net_buffer_length%';
	+-------------------+-------+
	| Variable_name     | Value |
	+-------------------+-------+
	| net_buffer_length | 16384 |
	+-------------------+-------+
	1 row in set (0.00 sec)

	select 16384/1024 = 16KB

	set global net_buffer_length=32768;

		2020-09-04T02:57:08.095060Z 33749 [Note] Aborted connection 33749 to db: 'consistency_db' user: 'root' host: '111.111.1.10' (Got an error reading communication packets)


	set global net_buffer_length=65536;

		2020-09-04T03:00:21.322663Z 33756 [Note] Aborted connection 33756 to db: 'consistency_db' user: 'root' host: '111.111.1.10' (Got an error reading communication packets)


mysql> show global status like 'abort%';
+------------------+-------+
| Variable_name    | Value |
+------------------+-------+
| Aborted_clients  | 1725  |     出现一次 Got an error reading communication packets ， 状态值会加1.
| Aborted_connects | 3     |
+------------------+-------+
2 rows in set (0.00 sec)



游戏停服后的错误日志（不是停止数据库）：
shell> cat mysql-error.log-20200826
2020-08-25T07:05:31.796051+08:00 1156031 [Note] Aborted connection 1156031 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.12' (Got an error reading communication packets)
2020-08-25T07:05:31.796066+08:00 1156030 [Note] Aborted connection 1156030 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.12' (Got an error reading communication packets)
2020-08-25T07:05:33.289655+08:00 1168204 [Note] Aborted connection 1168204 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.12' (Got an error reading communication packets)
2020-08-25T07:05:33.289748+08:00 1168205 [Note] Aborted connection 1168205 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.12' (Got an error reading communication packets)
2020-08-25T07:05:33.289789+08:00 1168211 [Note] Aborted connection 1168211 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.12' (Got an error reading communication packets)
2020-08-25T07:05:33.289822+08:00 1168217 [Note] Aborted connection 1168217 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.12' (Got an error reading communication packets)
2020-08-25T07:05:33.291980+08:00 1168218 [Note] Aborted connection 1168218 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.12' (Got an error reading communication packets)
2020-08-25T07:05:33.291999+08:00 1168215 [Note] Aborted connection 1168215 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.12' (Got an error reading communication packets)
2020-08-25T07:05:33.289773+08:00 1168207 [Note] Aborted connection 1168207 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.12' (Got an error reading communication packets)
2020-08-25T07:05:33.292142+08:00 1168213 [Note] Aborted connection 1168213 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.12' (Got an error reading communication packets)
2020-08-25T07:05:33.289655+08:00 1168203 [Note] Aborted connection 1168203 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.12' (Got an error reading communication packets)
2020-08-25T07:05:33.289689+08:00 1168206 [Note] Aborted connection 1168206 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.12' (Got an error reading communication packets)
2020-08-25T07:05:33.294251+08:00 1168214 [Note] Aborted connection 1168214 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.12' (Got an error reading communication packets)
2020-08-25T07:05:33.294317+08:00 1168212 [Note] Aborted connection 1168212 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.12' (Got an error reading communication packets)
2020-08-25T07:05:33.295871+08:00 1168210 [Note] Aborted connection 1168210 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.12' (Got an error reading communication packets)
2020-08-25T07:05:33.296473+08:00 1168216 [Note] Aborted connection 1168216 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.12' (Got an error reading communication packets)
2020-08-25T07:05:33.296496+08:00 1168220 [Note] Aborted connection 1168220 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.12' (Got an error reading communication packets)
2020-08-25T07:05:33.289692+08:00 1168202 [Note] Aborted connection 1168202 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.12' (Got an error reading communication packets)
2020-08-25T07:05:33.298180+08:00 1168221 [Note] Aborted connection 1168221 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.12' (Got an error reading communication packets)
2020-08-25T07:05:33.298451+08:00 1168209 [Note] Aborted connection 1168209 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.12' (Got an error reading communication packets)
2020-08-25T07:05:33.289714+08:00 1168208 [Note] Aborted connection 1168208 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.12' (Got an error reading communication packets)
2020-08-25T07:05:33.299161+08:00 1168219 [Note] Aborted connection 1168219 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.12' (Got an error reading communication packets)
2020-08-25T07:05:34.724461+08:00 1156052 [Note] Aborted connection 1156052 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.724576+08:00 1156053 [Note] Aborted connection 1156053 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.724598+08:00 1156055 [Note] Aborted connection 1156055 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.724639+08:00 1156056 [Note] Aborted connection 1156056 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.730485+08:00 1156060 [Note] Aborted connection 1156060 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.730833+08:00 1156058 [Note] Aborted connection 1156058 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.730927+08:00 1156057 [Note] Aborted connection 1156057 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.730991+08:00 1156065 [Note] Aborted connection 1156065 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.735097+08:00 1156059 [Note] Aborted connection 1156059 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.735689+08:00 1156061 [Note] Aborted connection 1156061 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.736334+08:00 1156066 [Note] Aborted connection 1156066 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.737540+08:00 1156063 [Note] Aborted connection 1156063 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.739197+08:00 1156062 [Note] Aborted connection 1156062 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.724486+08:00 1156054 [Note] Aborted connection 1156054 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.740976+08:00 1156064 [Note] Aborted connection 1156064 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.746191+08:00 1156067 [Note] Aborted connection 1156067 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.746332+08:00 1156068 [Note] Aborted connection 1156068 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.747323+08:00 1156070 [Note] Aborted connection 1156070 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.749401+08:00 1156071 [Note] Aborted connection 1156071 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.751148+08:00 1156069 [Note] Aborted connection 1156069 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.751589+08:00 1156077 [Note] Aborted connection 1156077 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.751743+08:00 1156081 [Note] Aborted connection 1156081 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.755764+08:00 1156080 [Note] Aborted connection 1156080 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.755831+08:00 1156075 [Note] Aborted connection 1156075 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.756405+08:00 1156082 [Note] Aborted connection 1156082 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.757202+08:00 1156085 [Note] Aborted connection 1156085 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.760909+08:00 1156084 [Note] Aborted connection 1156084 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.760941+08:00 1156072 [Note] Aborted connection 1156072 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.762768+08:00 1156079 [Note] Aborted connection 1156079 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.763247+08:00 1156086 [Note] Aborted connection 1156086 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.765745+08:00 1156083 [Note] Aborted connection 1156083 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.767820+08:00 1156074 [Note] Aborted connection 1156074 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.767960+08:00 1156076 [Note] Aborted connection 1156076 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.768758+08:00 1156078 [Note] Aborted connection 1156078 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:34.767827+08:00 1156073 [Note] Aborted connection 1156073 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.17' (Got an error reading communication packets)
2020-08-25T07:05:37.200302+08:00 1156088 [Note] Aborted connection 1156088 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.200422+08:00 1156087 [Note] Aborted connection 1156087 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.200498+08:00 1156090 [Note] Aborted connection 1156090 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.200535+08:00 1156091 [Note] Aborted connection 1156091 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.200502+08:00 1156089 [Note] Aborted connection 1156089 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.206574+08:00 1156098 [Note] Aborted connection 1156098 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.206662+08:00 1156099 [Note] Aborted connection 1156099 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.206799+08:00 1156095 [Note] Aborted connection 1156095 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.209974+08:00 1156097 [Note] Aborted connection 1156097 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.206671+08:00 1156096 [Note] Aborted connection 1156096 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.217397+08:00 1156100 [Note] Aborted connection 1156100 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.217445+08:00 1156102 [Note] Aborted connection 1156102 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.217486+08:00 1156103 [Note] Aborted connection 1156103 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.217584+08:00 1156104 [Note] Aborted connection 1156104 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.221491+08:00 1156106 [Note] Aborted connection 1156106 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.221864+08:00 1156107 [Note] Aborted connection 1156107 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.222545+08:00 1156101 [Note] Aborted connection 1156101 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.223111+08:00 1156108 [Note] Aborted connection 1156108 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.226388+08:00 1156114 [Note] Aborted connection 1156114 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.226608+08:00 1156110 [Note] Aborted connection 1156110 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.228160+08:00 1156109 [Note] Aborted connection 1156109 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.228426+08:00 1156105 [Note] Aborted connection 1156105 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.230771+08:00 1156113 [Note] Aborted connection 1156113 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.232127+08:00 1156118 [Note] Aborted connection 1156118 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.233512+08:00 1156117 [Note] Aborted connection 1156117 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.235257+08:00 1156115 [Note] Aborted connection 1156115 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.235332+08:00 1156119 [Note] Aborted connection 1156119 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.237046+08:00 1156112 [Note] Aborted connection 1156112 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.237827+08:00 1156111 [Note] Aborted connection 1156111 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:37.238726+08:00 1156116 [Note] Aborted connection 1156116 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.18' (Got an error reading communication packets)
2020-08-25T07:05:39.812661+08:00 1279319 [Note] Aborted connection 1279319 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.812715+08:00 1279322 [Note] Aborted connection 1279322 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.812817+08:00 1156120 [Note] Aborted connection 1156120 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.812909+08:00 1156122 [Note] Aborted connection 1156122 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.817025+08:00 1279321 [Note] Aborted connection 1279321 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.812661+08:00 1279318 [Note] Aborted connection 1279318 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.818563+08:00 1156123 [Note] Aborted connection 1156123 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.812756+08:00 1279320 [Note] Aborted connection 1279320 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.820276+08:00 1156124 [Note] Aborted connection 1156124 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.823763+08:00 1156121 [Note] Aborted connection 1156121 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.831711+08:00 1156131 [Note] Aborted connection 1156131 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.831780+08:00 1156130 [Note] Aborted connection 1156130 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.831907+08:00 1156132 [Note] Aborted connection 1156132 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.831787+08:00 1156134 [Note] Aborted connection 1156134 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.832466+08:00 1156133 [Note] Aborted connection 1156133 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.839189+08:00 1156135 [Note] Aborted connection 1156135 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.839221+08:00 1156137 [Note] Aborted connection 1156137 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.839345+08:00 1156138 [Note] Aborted connection 1156138 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.839422+08:00 1156143 [Note] Aborted connection 1156143 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.839235+08:00 1156141 [Note] Aborted connection 1156141 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.862330+08:00 1156139 [Note] Aborted connection 1156139 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.862352+08:00 1156140 [Note] Aborted connection 1156140 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.862455+08:00 1156136 [Note] Aborted connection 1156136 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.863500+08:00 1156144 [Note] Aborted connection 1156144 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.868009+08:00 1156142 [Note] Aborted connection 1156142 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.872833+08:00 1156145 [Note] Aborted connection 1156145 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.872858+08:00 1156149 [Note] Aborted connection 1156149 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.872923+08:00 1156147 [Note] Aborted connection 1156147 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.874454+08:00 1156146 [Note] Aborted connection 1156146 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.876810+08:00 1156148 [Note] Aborted connection 1156148 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.880546+08:00 1156152 [Note] Aborted connection 1156152 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.880626+08:00 1156150 [Note] Aborted connection 1156150 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.880639+08:00 1156154 [Note] Aborted connection 1156154 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.880717+08:00 1156153 [Note] Aborted connection 1156153 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.886293+08:00 1156151 [Note] Aborted connection 1156151 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.886328+08:00 1156155 [Note] Aborted connection 1156155 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.888104+08:00 1156157 [Note] Aborted connection 1156157 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.889294+08:00 1156156 [Note] Aborted connection 1156156 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.892344+08:00 1156167 [Note] Aborted connection 1156167 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.892517+08:00 1156160 [Note] Aborted connection 1156160 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.893353+08:00 1156159 [Note] Aborted connection 1156159 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.896349+08:00 1156164 [Note] Aborted connection 1156164 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.897543+08:00 1156158 [Note] Aborted connection 1156158 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.899788+08:00 1156165 [Note] Aborted connection 1156165 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.901962+08:00 1156172 [Note] Aborted connection 1156172 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.903591+08:00 1156174 [Note] Aborted connection 1156174 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.903697+08:00 1156162 [Note] Aborted connection 1156162 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.906424+08:00 1156166 [Note] Aborted connection 1156166 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.906699+08:00 1156173 [Note] Aborted connection 1156173 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.908811+08:00 1156182 [Note] Aborted connection 1156182 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.911172+08:00 1156178 [Note] Aborted connection 1156178 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.912903+08:00 1156175 [Note] Aborted connection 1156175 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.913152+08:00 1156161 [Note] Aborted connection 1156161 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.913739+08:00 1156169 [Note] Aborted connection 1156169 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.916338+08:00 1156168 [Note] Aborted connection 1156168 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.916429+08:00 1156179 [Note] Aborted connection 1156179 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.918524+08:00 1156184 [Note] Aborted connection 1156184 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.919131+08:00 1156171 [Note] Aborted connection 1156171 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.922548+08:00 1156176 [Note] Aborted connection 1156176 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.922820+08:00 1156170 [Note] Aborted connection 1156170 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.924435+08:00 1156163 [Note] Aborted connection 1156163 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.925099+08:00 1156180 [Note] Aborted connection 1156180 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.926317+08:00 1156177 [Note] Aborted connection 1156177 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.930018+08:00 1156183 [Note] Aborted connection 1156183 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:39.930480+08:00 1156181 [Note] Aborted connection 1156181 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.19' (Got an error reading communication packets)
2020-08-25T07:05:42.359053+08:00 1156191 [Note] Aborted connection 1156191 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.30' (Got an error reading communication packets)
2020-08-25T07:05:42.359085+08:00 1156190 [Note] Aborted connection 1156190 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.30' (Got an error reading communication packets)
2020-08-25T07:05:42.359379+08:00 1156192 [Note] Aborted connection 1156192 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.30' (Got an error reading communication packets)
2020-08-25T07:05:42.359480+08:00 1156193 [Note] Aborted connection 1156193 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.30' (Got an error reading communication packets)
2020-08-25T07:05:42.363910+08:00 1156194 [Note] Aborted connection 1156194 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.30' (Got an error reading communication packets)
2020-08-25T07:05:42.412575+08:00 1156185 [Note] Aborted connection 1156185 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.30' (Got an error reading communication packets)
2020-08-25T07:05:42.412575+08:00 1156187 [Note] Aborted connection 1156187 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.30' (Got an error reading communication packets)
2020-08-25T07:05:42.412695+08:00 1156186 [Note] Aborted connection 1156186 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.30' (Got an error reading communication packets)
2020-08-25T07:05:42.412575+08:00 1156189 [Note] Aborted connection 1156189 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.30' (Got an error reading communication packets)
2020-08-25T07:05:42.412575+08:00 1156188 [Note] Aborted connection 1156188 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.30' (Got an error reading communication packets)
2020-08-25T07:05:44.930872+08:00 1156204 [Note] Aborted connection 1156204 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.31' (Got an error reading communication packets)
2020-08-25T07:05:44.931012+08:00 1156205 [Note] Aborted connection 1156205 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.31' (Got an error reading communication packets)
2020-08-25T07:05:44.931091+08:00 1156203 [Note] Aborted connection 1156203 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.31' (Got an error reading communication packets)
2020-08-25T07:05:44.931299+08:00 1156202 [Note] Aborted connection 1156202 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.31' (Got an error reading communication packets)
2020-08-25T07:05:44.935040+08:00 1156201 [Note] Aborted connection 1156201 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.31' (Got an error reading communication packets)
2020-08-25T07:05:44.975568+08:00 1156199 [Note] Aborted connection 1156199 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.31' (Got an error reading communication packets)
2020-08-25T07:05:44.975545+08:00 1156196 [Note] Aborted connection 1156196 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.31' (Got an error reading communication packets)
2020-08-25T07:05:44.975582+08:00 1156197 [Note] Aborted connection 1156197 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.31' (Got an error reading communication packets)
2020-08-25T07:05:44.975547+08:00 1156198 [Note] Aborted connection 1156198 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.31' (Got an error reading communication packets)
2020-08-25T07:05:44.975679+08:00 1156200 [Note] Aborted connection 1156200 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.31' (Got an error reading communication packets)
2020-08-25T07:05:47.383990+08:00 1156209 [Note] Aborted connection 1156209 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.32' (Got an error reading communication packets)
2020-08-25T07:05:47.384200+08:00 1156207 [Note] Aborted connection 1156207 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.32' (Got an error reading communication packets)
2020-08-25T07:05:47.384335+08:00 1156206 [Note] Aborted connection 1156206 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.32' (Got an error reading communication packets)
2020-08-25T07:05:47.384022+08:00 1156208 [Note] Aborted connection 1156208 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.32' (Got an error reading communication packets)
2020-08-25T07:05:47.384200+08:00 1156210 [Note] Aborted connection 1156210 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.32' (Got an error reading communication packets)
2020-08-25T07:05:47.410555+08:00 1156211 [Note] Aborted connection 1156211 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.32' (Got an error reading communication packets)
2020-08-25T07:05:47.410600+08:00 1156214 [Note] Aborted connection 1156214 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.32' (Got an error reading communication packets)
2020-08-25T07:05:47.410647+08:00 1156213 [Note] Aborted connection 1156213 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.32' (Got an error reading communication packets)
2020-08-25T07:05:47.410751+08:00 1156215 [Note] Aborted connection 1156215 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.32' (Got an error reading communication packets)
2020-08-25T07:05:47.410609+08:00 1156212 [Note] Aborted connection 1156212 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.32' (Got an error reading communication packets)
2020-08-25T07:05:49.868439+08:00 1156223 [Note] Aborted connection 1156223 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.33' (Got an error reading communication packets)
2020-08-25T07:05:49.868469+08:00 1156221 [Note] Aborted connection 1156221 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.33' (Got an error reading communication packets)
2020-08-25T07:05:49.868560+08:00 1156224 [Note] Aborted connection 1156224 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.33' (Got an error reading communication packets)
2020-08-25T07:05:49.868623+08:00 1156222 [Note] Aborted connection 1156222 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.33' (Got an error reading communication packets)
2020-08-25T07:05:49.868480+08:00 1156225 [Note] Aborted connection 1156225 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.33' (Got an error reading communication packets)
2020-08-25T07:05:49.873860+08:00 1156220 [Note] Aborted connection 1156220 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.33' (Got an error reading communication packets)
2020-08-25T07:05:49.873875+08:00 1156217 [Note] Aborted connection 1156217 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.33' (Got an error reading communication packets)
2020-08-25T07:05:49.874035+08:00 1156218 [Note] Aborted connection 1156218 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.33' (Got an error reading communication packets)
2020-08-25T07:05:49.873874+08:00 1156216 [Note] Aborted connection 1156216 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.33' (Got an error reading communication packets)
2020-08-25T07:05:49.877964+08:00 1156219 [Note] Aborted connection 1156219 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.33' (Got an error reading communication packets)
2020-08-25T07:05:52.248079+08:00 1280626 [Note] Aborted connection 1280626 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.34' (Got an error reading communication packets)
2020-08-25T07:05:52.248017+08:00 1280623 [Note] Aborted connection 1280623 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.34' (Got an error reading communication packets)
2020-08-25T07:05:52.248019+08:00 1280622 [Note] Aborted connection 1280622 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.34' (Got an error reading communication packets)
2020-08-25T07:05:52.248144+08:00 1280625 [Note] Aborted connection 1280625 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.34' (Got an error reading communication packets)
2020-08-25T07:05:52.248040+08:00 1280624 [Note] Aborted connection 1280624 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.34' (Got an error reading communication packets)
2020-08-25T07:05:54.765255+08:00 1156232 [Note] Aborted connection 1156232 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.14' (Got an error reading communication packets)
2020-08-25T07:05:54.765274+08:00 1156231 [Note] Aborted connection 1156231 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.14' (Got an error reading communication packets)
2020-08-25T07:05:54.765434+08:00 1156233 [Note] Aborted connection 1156233 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.14' (Got an error reading communication packets)
2020-08-25T07:05:54.765255+08:00 1156234 [Note] Aborted connection 1156234 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.14' (Got an error reading communication packets)
2020-08-25T07:05:54.765257+08:00 1156235 [Note] Aborted connection 1156235 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.14' (Got an error reading communication packets)
2020-08-25T07:05:59.694178+08:00 1200669 [Note] Aborted connection 1200669 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.15' (Got an error reading communication packets)
2020-08-25T07:05:59.694216+08:00 1200668 [Note] Aborted connection 1200668 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.15' (Got an error reading communication packets)
2020-08-25T07:06:00.613808+08:00 1156024 [Note] Aborted connection 1156024 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.13' (Got an error reading communication packets)
2020-08-25T07:06:00.613890+08:00 1156028 [Note] Aborted connection 1156028 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.13' (Got an error reading communication packets)
2020-08-25T07:06:00.613978+08:00 1156023 [Note] Aborted connection 1156023 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.13' (Got an error reading communication packets)
2020-08-25T07:06:00.614115+08:00 1156026 [Note] Aborted connection 1156026 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.13' (Got an error reading communication packets)
2020-08-25T07:06:00.619148+08:00 1156021 [Note] Aborted connection 1156021 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.13' (Got an error reading communication packets)
2020-08-25T07:06:00.619849+08:00 1156029 [Note] Aborted connection 1156029 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.13' (Got an error reading communication packets)
2020-08-25T07:06:00.621060+08:00 1156022 [Note] Aborted connection 1156022 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.13' (Got an error reading communication packets)
2020-08-25T07:06:00.621076+08:00 1156020 [Note] Aborted connection 1156020 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.13' (Got an error reading communication packets)
2020-08-25T07:06:00.625600+08:00 1156027 [Note] Aborted connection 1156027 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.13' (Got an error reading communication packets)
2020-08-25T07:06:00.625728+08:00 1156025 [Note] Aborted connection 1156025 to db: 'aiuaiuh5_db' user: 'accu5_user' host: '111.111.1.13' (Got an error reading communication packets)
