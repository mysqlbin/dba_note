

https://blog.csdn.net/qq_53893431/article/details/124906064  【Python】Matplotlib绘制折线图

https://www.runoob.com/matplotlib/matplotlib-tutorial.html	Matplotlib 教程


https://blog.csdn.net/weixin_39941620/article/details/111731824	  python plt.show_python之matplotlib中plt.show()不显示图的解决办法


https://www.cnblogs.com/kori/p/11846162.html   【鸽子的迷信（二）】ModuleNotFoundError: No module named 'Tkinter'


https://blog.csdn.net/weixin_39619478/article/details/116937451	linux plt.show不显示图片,解决matplotlib库show()方法不显示图片的问题

https://www.shuzhiduo.com/A/o75NobLMdW/	  plt.show() 不显示图表


https://blog.csdn.net/weixin_38087692/article/details/107562535   一图多线


https://blog.csdn.net/t20134297/article/details/105018198

http://www.coolpython.net/data_analysis/matplotlib/matplotlib-basic-line-color.html



import matplotlib.pyplot as plt
import numpy as np
xpoints = np.array([0, 6])
ypoints = np.array([0, 100])
plt.plot(xpoints, ypoints)
plt.show()



pip3 install tcl-dev tk-dev python3-tk

python3 -m pip install -U matplotlib


yum install tcl-dev tk-dev python3-tk
yum install python3-tk



import matplotlib
import matplotlib.pyplot as plt
plt.use('TkAgg')



import matplotlib.pyplot as plt
import numpy as np
xpoints = np.array([0, 6])
ypoints = np.array([0, 100])
plt.plot(xpoints, ypoints)
plt.show()



import matplotlib
matplotlib.use('TkAgg')


import matplotlib.pyplot as plt
plt.use('TkAgg')




import matplotlib
matplotlib.use('TkAgg')
import matplotlib.pyplot as plt
import numpy as np
xpoints = np.array([0, 6])
ypoints = np.array([0, 100])
plt.plot(xpoints, ypoints)
plt.show()




import pandas as pd
import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np
from numpy import *


import matplotlib as mpl
mpl.use('Agg')
import matplotlib.pyplot as plt
plt.plot([10, 20, 30])
plt.xlabel('tiems')
plt.ylabel('numbers')
plt.show()
plt.savefig('table.png')



核心：
	1. x轴、y轴
	2. 报表类型
	3. 



# 设置图形
"""
figsize：以英寸为单位的宽高，缺省值为 rc figure.figsize (1 英寸等于 2.54 厘米)
dpi：图形分辨率，缺省值为 rc figure.dpi
facecolor：背景色
"""
plt.figure(figsize=(20,8),dpi=80)
