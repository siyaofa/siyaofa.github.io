#!/usr/bin/env python
# -*- coding: utf8 -*-
#Author : lous
from tkinter import *
import sys
import os
from ctypes import *
from struct import *
#Author : lous

class RESULT_STRUCT(Structure):
    _fields_ = [("int_result",  c_int),
                ("double_result",  c_double)]

class Application(Frame):

    def load_dll(self):
        """载入动态库"""
        self.libtst = CDLL('libpython_clib.dll')

    def app_relase(self):
        """退出界面时释放资源"""
        self.relase_resource()
        self.quit()
        
    def relase_resource(self):
        """释放申请的资源"""
        pass
    
    def footprint(self, message):
        self.result_text.insert(1.0,"\n"+message+"\n")
        
    def result_clear(self):
        self.result_text.delete(1.0,END)

    def download(self):
        """调用download"""
        rtn=self.libtst.download()
        self.footprint("libtst.download()")
        
    def add(self):
        """调用add"""
        c=c_double(0)
        rtn=self.libtst.add(1,2,byref(c))
        self.footprint("libtst.add() c = %f" %(c.value))

    def initialize(self):
        """调用initialize"""
        rtn=self.libtst.initialize()
        self.footprint("libtst.initialize()")
    def terminate(self):
        """调用terminate"""
        rtn=self.libtst.terminate()
        self.footprint("libtst.terminate()")
    def get_result(self):
        """调用get_result"""
        result=RESULT_STRUCT()
        rtn=self.libtst.get_result(byref(result))
        self.footprint("get_result %d %lf" %(result.int_result,result.double_result))

    def createWidgets(self):
        #root frame
        self.root_frame=Frame(self).grid(sticky=N+S+E+W)
        #输入frame
        self.input_frame=Frame(self.root_frame)
        self.input_frame.grid(row=0,column=0,sticky=N+S+E+W)
        self.create_input_frame()
        #子 frame
        self.sub_frame=Frame(self.root_frame)
        self.sub_frame.grid(row=0,column=1,sticky=N+S+E+W)
        self.create_sub_frame()
        #输出框
        self.output_frame=Frame(self.root_frame)
        self.output_frame.grid(row=2,column=0,columnspan=2,sticky=N+S+E+W)
        self.create_output_frame()

    def create_input_frame(self):
        self.position_sb=Spinbox(self.input_frame)
        self.position_sb.grid(row=0,column=1)
        self.position_label=Label(self.input_frame,text="Positon     m")
        self.position_label.grid(row=0,column=0)
        self.velocity_sb=Spinbox(self.input_frame)
        self.velocity_sb.grid(row=1,column=1)
        self.velocity_label=Label(self.input_frame,text="Velocity     m/s")
        self.velocity_label.grid(row=1,column=0)
        self.acceleration_sb=Spinbox(self.input_frame)
        self.acceleration_sb.grid(row=2,column=1)
        self.acceleration_label=Label(self.input_frame,text="acceleration     m/s^2")
        self.acceleration_label.grid(row=2,column=0)
        self.jerk_sb=Spinbox(self.input_frame)
        self.jerk_sb.grid(row=3,column=1)
        self.jerk_label=Label(self.input_frame,text="Jerk     m/s^3")
        self.jerk_label.grid(row=3,column=0)
        self.djerk_sb=Spinbox(self.input_frame)
        self.djerk_sb.grid(row=4,column=1)
        self.djerk_label=Label(self.input_frame,text="DJerk     m/s^4")
        self.djerk_label.grid(row=4,column=0)
        
    def create_sub_frame(self):
        #initialize
        self.initialize_btn = Button(self.sub_frame)
        self.initialize_btn["text"] = "initialize"
        self.initialize_btn["command"] =  self.initialize
        self.initialize_btn.grid(row=0)
        #terminate
        self.terminate_btn = Button(self.sub_frame)
        self.terminate_btn["text"] = "terminate"
        self.terminate_btn["command"] = self.terminate
        self.terminate_btn.grid(row=1)
        #get_result
        self.get_status_btn = Button(self.sub_frame)
        self.get_status_btn["text"] = "get_result"
        self.get_status_btn["command"] =  self.get_result
        self.get_status_btn.grid(row=2)
        #add
        self.add_btn = Button(self.sub_frame)
        self.add_btn["text"] = "add"
        self.add_btn["command"] =  self.add
        self.add_btn.grid(row=3)

    def create_output_frame(self):
        self.result_text=Text(self.output_frame,height=8)
        self.result_text.grid(columnspan=2)
        ##滚动条
        #self.result_scrollbar=Scrollbar(self.output_frame)
        #self.result_scrollbar.grid(row=8,column=1,sticky=N+S)
        #self.result_scrollbar.config(command=self.result_text.yview)
        #self.result_text.config(yscrollcommand=self.result_scrollbar.set)
        self.result_clear_btn = Button(self.output_frame)
        self.result_clear_btn["text"] = "Clear"
        self.result_clear_btn["command"] =  self.result_clear
        self.result_clear_btn.grid(row=1,column=1)
        #创建退出
        self.QUIT = Button(self.output_frame)
        self.QUIT["text"] = "QUIT"
        self.QUIT["command"] =  self.app_relase
        self.QUIT.grid(row=1)

    def __init__(self, master=None):
        Frame.__init__(self, master)
        #master.geometry("1280x720")
        self.load_dll()
        #initialize_resource()
        self.createWidgets()

root = Tk()
HRIS = Application(master=root)
HRIS.master.title("Test Demo")
HRIS.mainloop()
root.destroy()