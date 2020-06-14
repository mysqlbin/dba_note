

a='abc'
b='efg'
c=''
if [ $a = $b ]
then 
	echo "$a = $b : a 等于 b"
else
	echo "$a = $b : a 不于 b"
fi

if [ $a != $b ]
then 
	echo "$a != $b : a 不等于 b"
else
	echo "$a != $b : a 等于 b"
fi


if [ -z $a ]
then 
	echo "-z $a : 字符串长度为0"
else
	echo "-z $a : 字符串长度不为0"
fi


if [ -n $a ]
then 
	echo "-n $a : 字符串长度不为0"
else
	echo "-n $a : 字符串长度为0"
fi

if [ $a ]
then
	echo "$a : 字符串不为空"
else
	echo "$a : 字符串为空"
fi

if [ $c ]
then
	echo "$a : 字符串不为空"
else
	echo "$a : 字符串为空"
fi


输出
	abc = efg : a 不于 b
	abc != efg : a 不等于 b
	-z abc : 字符串长度不为0
	-n abc : 字符串长度不为0
	abc : 字符串不为空
	 : 字符串为空

	 