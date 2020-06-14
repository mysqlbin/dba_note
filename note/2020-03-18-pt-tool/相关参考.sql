
相关参考：
    https://www.lianst.com/3712.html      MySQL数据库归档利器之pt-archiver
    http://www.fordba.com/percona-toolkitpt-archiver.html   Percona-Toolkit系列之pt-archiver数据归档利器
    https://www.cnblogs.com/David-domain/p/11176669.html    [原创]pt-archiver 归档历史数据及参数详解
	
	http://www.ttlsa.com/mysql/pt-archiver-bug-cannot-migration-max-id-record/ pt-archiver Bug不会迁移max(id)那条数据
		# 已经实践过了.
	
	https://www.jianshu.com/p/20a1de73aa53  【MySQL】pt工具安装教程



perl(DBI) >= 1.13 is needed by percona-toolkit-3.2.0-1.el7.x86_64
perl(DBD::mysql) >= 1.0 is needed by percona-toolkit-3.2.0-1.el7.x86_64
perl(IO::Socket::SSL) is needed by percona-toolkit-3.2.0-1.el7.x86_64
perl(Digest::MD5) is needed by percona-toolkit-3.2.0-1.el7.x86_64
perl(Term::ReadKey) is needed by percona-toolkit-3.2.0-1.el7.x86_64

	yum install -y perl-DBI
	yum install -y perl-DBD-MySQL
	yum install -y perl-Time-HiRes
	yum install -y perl-IO-Socket-SSL

		
perl(Digest::MD5) is needed by percona-toolkit-3.2.0-1.el7.x86_64
perl(Term::ReadKey) is needed by percona-toolkit-3.2.0-1.el7.x86_64
	
	yum install -y  perl-TermReadKey.x86_64 perl-Digest-MD5
	
	
	
	