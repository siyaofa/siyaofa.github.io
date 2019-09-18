import cv2
import os
import sys

import shutil

import process_bar

raw_train_path="train_raw"
train_path="train"

raw_pos_path=raw_train_path+"/pos"
pos_path=train_path+"/pos"

raw_neg_path=raw_train_path+"/neg"
neg_path=train_path+"/neg"

info_dat_filename=train_path+"/info.dat"
bg_txt_filename=train_path+"/bg.txt"

def view_bar(num, total):
	rate = num / total                        #得到现在的比率，0<rate<1
	rate_num = int(rate * 100)                #将比率百分化，0<rate_num<100
	r = '\r[%s%s]' % (">"*rate_num, " "*(100-rate_num)) #进度条封装
	sys.stdout.write(r)                       #显示进度条
	sys.stdout.write(str(rate_num)+'%')            #显示进度百分比
	sys.stdout.flush()                        #使输出变得平滑

def remove_if_exist(dir):
	if os.path.exists(dir):
		#os.remove(dir)
		shutil.rmtree(dir)
		print("remove "+dir)

def create_if_not_exist(dir):
	isExist=os.path.exists(dir)
	if not isExist:
		os.makedirs(dir)
		print("creat "+dir)

def resize_copy(src_path,dst_path,width,heigt):
	print("%s ---> %s  resize to %dx%d"%(src_path,dst_path,width,heigt))
	create_if_not_exist(dst_path)
	filenum=0
	total_num=len(os.listdir(src_path))
	for filename in os.listdir(src_path):
		#print(filename)
		pic = cv2.imread(src_path+"/"+filename)
		pic = cv2.resize(pic, (width, heigt), interpolation=cv2.INTER_CUBIC)
		cv2.imwrite(dst_path+"/"+filename,pic)
		filenum+=1
		view_bar(filenum,total_num)
	print("\n total_num is %d"%(filenum))
	return filenum


def create_info_dat(pos_path,info_dat_filename,width,heigt):
	info_dat=""
	filenum=0
	total_num=len(os.listdir(pos_path))
	for filename in os.listdir(pos_path):
		filenum+=1
		info_dat=info_dat+"pos/"+filename+" 1 0 0 "+str(width-1)+" "+str(heigt-1) 
		if (total_num!=filenum):
			info_dat+="\n"
	f = open(info_dat_filename,'w')
	f.write(info_dat)
	f.close()
	return filenum


def create_bg_txt(neg_path,bg_txt_filename):
	bg_txt=""
	filenum=0
	total_num=len(os.listdir(neg_path))
	for filename in os.listdir(neg_path):
		filenum+=1
		bg_txt=bg_txt+"neg/"+filename
		if (total_num!=filenum):
			bg_txt+="\n"
	f = open(bg_txt_filename,'w')
	f.write(bg_txt)
	f.close()
	return filenum

def create_pos_vec(pos_num,pos_width,pos_height):
	cmd_str="opencv_createsamples.exe -vec %s -info %s -num %d -w %d -h %d"%("pos.vec","info.dat",pos_num,pos_width,pos_height)
	print(cmd_str)
	print(os.system(cmd_str))


def train_xml(pos_num,neg_num,stage_num,pos_width,pos_height,hit_rate):
	remove_if_exist("xml")
	create_if_not_exist("xml")
	cmd_str="opencv_traincascade.exe -data xml -vec pos.vec -bg bg.txt -numPos %d -numNeg %d -numStages %d -w %d -h %d -minHitRate %f -maxFalseAlarmRate 0.2 -weightTrimRate 0.95 -featureType LBP"%(int(pos_num),neg_num,stage_num,pos_width,pos_height,hit_rate)
	print(cmd_str)
	os.system(cmd_str) 








############################################
pos_width=20
pos_height=20
neg_width=128
neg_height=72
stage_num=15
hit_rate=0.999
pos_ratio=0.95 #正样本中真正有效的比例

#拷贝负样本
#resize_copy(raw_neg_path,neg_path,neg_width,neg_height)
#拷贝正样本
#resize_copy(raw_pos_path,pos_path,pos_width,pos_height)
#生成info.dat
pos_num=create_info_dat(pos_path,info_dat_filename,pos_width,pos_height)
#生成bg.txt
neg_num=create_bg_txt(neg_path,bg_txt_filename)

os.chdir(train_path)
create_pos_vec(pos_num,pos_width,pos_height)
train_xml(pos_num*pos_ratio,neg_num,stage_num,pos_width,pos_height,hit_rate)