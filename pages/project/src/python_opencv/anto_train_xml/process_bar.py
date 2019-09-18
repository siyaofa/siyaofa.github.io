import sys
def process_bar(num, total):
	rate = num / total                        #得到现在的比率，0<rate<1
	rate_num = int(rate * 100)                #将比率百分化，0<rate_num<100
	r = '\r[%s%s]' % (">"*rate_num, " "*(100-rate_num)) #进度条封装
	sys.stdout.write(r)                       #显示进度条
	sys.stdout.write(str(rate_num)+'%')            #显示进度百分比
	sys.stdout.flush()                        #使输出变得平滑