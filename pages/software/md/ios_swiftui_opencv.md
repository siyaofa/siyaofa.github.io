---
layout: page
title: iOS SwiftUI OpenCV
date:   2021-03-24
---

## OpenCV

OpenCV 从 4.4开始有了iOS的Swift封装

之前的方法实在是太过恶心，要桥接，并且要使用到ObjectC

两点需要注意：

- 【General】加依赖库 libc++.tbd

- 【Build Settings】-【Other Linker Flags】= 【-all_load】

Xcode导入下载好的框架即可。

成功后opencv会和libc++.tbd在一起，opencv的框架选择不嵌入

```swift

import opencv2

struct ContentView: View {
    
    @State var grayImage : UIImage?
    @State var orgImage = UIImage(named: "lemon.jpeg")
    
    var body: some View {
        VStack{
            Image(uiImage: orgImage!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                //.frame(width: 200, height: 200, alignment: .center)
            
            Button("测试OpenCV"){
                let src = Mat(uiImage:orgImage!)
                let gray = Mat()
                
                Imgproc.cvtColor(src: src, dst: gray, code: .COLOR_BGR2HSV)
                grayImage = gray.toUIImage()
                
            }
            if let grayImage = grayImage {
            Image(uiImage: grayImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                //.frame(width: 200, height: 200, alignment: .center)
            }
        }
    }
}
```
到此简单的颜色空间转换就完成了。

