

a=10
b=20

if [[ $a -lt 100 && $b -gt 100 ]]
then
	echo '返回 true'
else
	echo '返回 false'
fi


if [[ $a -lt 100 || $b -gt 100 ]]
then
	echo '返回 true'
else
	echo '返回 false'
fi


输出
	返回 false
	返回 true
		
