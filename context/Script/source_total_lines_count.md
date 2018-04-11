\#coding=gbk

**import** os

**from** os **import** path

**def** WalkAll**(**rootDir**,**total\_linenum**):**

total\_linenum**=**0

**for** root**,**dirs**,**files **in** os**.**walk**(**rootDir**):**

**for** file **in** files**:**

name**,**ext**=**os**.**path**.**splitext**(**file**)**

**if(**ext**==**".cpp" **or** ext**==**".h" **or** ext**==**".c"**):**

myfile**=**open**(**os**.**path**.**join**(**root**,**file**))**

current\_linenum**=**len**(**myfile**.**readlines**())**

total\_linenum**=**total\_linenum**+**current\_linenum

**print(**os**.**path**.**join**(**root**,**file**))**

**print(**"total lines are "**+**str**(**total\_linenum**))**

**for** dir **in** dirs**:**

WalkAll**(**dir**,**total\_linenum**)**

**return** total\_linenum

\#

\#

inDir**=**path**.**dirname**(**\_\_file\_\_**)**

total\_linenum**=**0

total\_linenum**=**WalkAll**(**inDir**,**total\_linenum**)**

**print(**"total lines are "**+**str**(**total\_linenum**))**

input**(**'wait to exist'**)**
