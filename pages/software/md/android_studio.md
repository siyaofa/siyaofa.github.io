---
layout: page
title: Android Studio 使用问题汇总
date:   2019-08-27
---

更换电脑后上传商店发现应用签名不一致，虽然使用了同一个`.jks`文件

查看keystore签名

`keytool -v -list -keystore ***.keystore`

默认密码android

查看APK签名，解压 进入 `META-INF` 输入 `>keytool -printcert -file CERT.RSA`

release版本配置也把`debug.keystore`加进去，这样换了电脑后APK的签名才会一致。


