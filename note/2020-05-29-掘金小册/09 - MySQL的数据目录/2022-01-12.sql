

MySQL系统数据库简介

	1. mysql

		这个数据库贼核心，它存储了MySQL的用户账户和权限信息，一些存储过程、事件的定义信息，一些运行过程中产生的日志信息，一些帮助信息以及时区信息等。

	2. information_schema

		这个数据库保存着MySQL服务器维护的所有其他数据库的信息，比如有哪些表、哪些视图、哪些触发器、哪些列、哪些索引吧啦吧啦。
		这些信息并不是真实的用户数据，而是一些描述性信息，有时候也称之为元数据。

	3. performance_schema

		这个数据库里主要保存MySQL服务器运行过程中的一些状态信息，算是对MySQL服务器的一个性能监控。
		包括统计最近执行了哪些语句，在执行过程的每个阶段都花费了多长时间，内存的使用情况等等信息。

	4. sys

		这个数据库主要是通过视图的形式把information_schema和performance_schema结合起来，让程序员可以更方便的了解MySQL服务器的一些性能信息。