import cv2
import os


raw_train_path="train_raw"
train_path="train"

raw_pos_path=raw_train_path+"/pos"
pos_path=train_path+"/pos"

raw_neg_path=raw_train_path+"/neg"
neg_path=train_path+"/neg"

def resize_copy(src_path,dst_path,width,heigt):
	print("%s ---> %s  resize to %dx%d"%(src_path,dst_path,width,heigt))
	for filename in os.listdir(src_path):
		print(filename)
		pic = cv2.imread(src_path+"/"+filename)
		pic = cv2.resize(pic, (width, heigt), interpolation=cv2.INTER_CUBIC)
		cv2.imwrite(dst_path+"/"+filename,pic)


info_dat=""
for filename in os.listdir(path):
	print(filename)
	pic = cv2.imread(path+"/"+filename)
	pic = cv2.resize(pic, (20, 20), interpolation=cv2.INTER_CUBIC)
	cv2.imwrite("train/pos/"+filename,pic,[int(cv2.IMWRITE_JPEG_QUALITY),5])
	info_dat=info_dat+"pos/"+filename+" 1 0 0 19 19\n"

print(info_dat)
f = open('train/info.dat','w')
f.write(info_dat)
f.close()

neg_pic_path="train_raw/neg"
bg_txt=""
for filename in os.listdir(neg_pic_path):
	print(filename)
	pic = cv2.imread(neg_pic_path+"/"+filename)
	pic = cv2.resize(pic, (128, 72), interpolation=cv2.INTER_CUBIC)
	cv2.imwrite("train/neg/"+filename,pic)
	bg_txt=bg_txt+"neg/"+filename+"\n"

f = open('train/bg.txt','w')
f.write(bg_txt)
f.close()

os.chdir("train")
r_v = os.system("opencv_createsamples.exe -vec pos.vec -info info.dat -num 300 -w 20 -h 20") 

print(r_v)

r_v = os.system("opencv_traincascade.exe -data xml -vec pos.vec -bg bg.txt -numPos 300 -numNeg 900 -numStages 10 -w 20 -h 20 -minHitRate 0.999 -maxFalseAlarmRate 0.2 -weightTrimRate 0.95 -featureType LBP") 

print(r_v)