#!/bin/bash

funWithReturn(){
	echo "这个函数会对输入的两个数字进行相加运算..."
	echo "输入第一个数字: "
	read aNum
	echo "输入第二个数字: "
	read bNUM
	echo "两个数字分别为 $aNum 和 $bNUM !"
	return $(($aNum+$bNUM))
}

funWithReturn
echo "输入的两个数字之和为 $? !"


[root@mgr9 data]# ./14-02.sh 
这个函数会对输入的两个数字进行相加运算...
输入第一个数字: 
5
输入第二个数字: 
2
两个数字分别为 5 和 2 !
输入的两个数字之和为 7 !

