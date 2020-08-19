#!/bin/bash

使用变量
	使用一个定义过的变量, 只要在变量名前面加美元符号即可
	变量名外面的花括号是可选的，加不加都行，加花括号是为了帮助解释器识别变量的边界
	如果不给skill变量加花括号，写成echo "I am good at $skillScript"，解释器就会把$skillScript当成一个变量（其值为空）
	推荐给所有变量加上花括号，这是个好的编程习惯。


your_name="lujb"
echo $your_name
echo ${your_name}


for skill in Ada Coffee Action Java; do
	echo "I am good at ${skill}Script"
done

:<<EOF
I am good at Ada Script
I am good at Coffee Script
I am good at Action Script
I am good at Java Script
EOF

for skill in Ada Coffee Action Java; do
	echo "I am good at $skillScript"
done

:<<EOF
I am good at 
I am good at 
I am good at 
I am good at 
EOF

for skill in Ada Coffee Action Java; do
	echo "I am good at $skill Script"
done

:<<EOF
I am good at Ada Script
I am good at Coffee Script
I am good at Action Script
I am good at Java Script
EOF

myUrl="mysqlbin"
readonly myUrl
myUrl="mysqlbin"
# 输出: script.sh: line 5: myUrl: readonly variable


myUrls="mysqlbins"
unset myUrls
echo $myUrls
# 以上实例执行将没有任何输出。



