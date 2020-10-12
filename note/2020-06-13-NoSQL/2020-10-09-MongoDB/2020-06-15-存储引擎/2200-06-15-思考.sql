

checkpoint 检查点是位于内部缓存还是 Journal ？
	
	
Journal 是覆盖写吗？
	不是，一个100MB的journal文件写满之后会新建另一个100MB的journal文件。
	100MB的文件写满之后，触发journal日志刷盘。
	
	

