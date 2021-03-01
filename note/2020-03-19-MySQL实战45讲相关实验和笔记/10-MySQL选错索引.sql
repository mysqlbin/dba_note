

假如要查 A in () AND B in (), 怎么建索引?

where A in (a,b,c) AND B in (x,y,z)
会转成
 
(A=a and B=x) or (A=a and B=y) or (A=a and B=z) or
(A=b and B=x) or (A=b and B=y) or (A=b and B=z) or
(A=c and B=x) or (A=c and B=y) or (A=c and B=z)


借助 show warnings; 命令就可以看到 A in (a, b, c) 会转成  A=a or A=b or A=c
