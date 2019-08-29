---
layout: page
title: Android 开发调试记录
date:   2019-08-29
---

现象：包含WebView的activity跳转至应用商店后，在应用商店内打开此应用后WebView内的模型消失了

排查：发现调用了onCreate()方法，可能与Activity的启动模式有关，更换为singleTask、singleTop后问题依旧存在。

log显示应用商店打开了入口Activity A, A中的onCreate()方法调用了Activity B.

Activity默认启动模式是standard
Activity 有四种加载模式
[1] standard 模式
这是默认模式，每次激活Activity时都会创建Activity实例，并放入任务栈中。
[2] singleTop 模式
如果在任务的栈顶正好存在该Activity的实例，就重用该实例( 会调用实例的 onNewIntent() )，否则就会创建新的实例并放入栈顶，即使栈中已经存在该Activity的实例，只要不在栈顶，都会创建新的实例。
[3] singleTask 模式
如果在栈中已经有该Activity的实例，就重用该实例(会调用实例的 onNewIntent() )。重用时，会让该实例回到栈顶，因此在它上面的实例将会被移出栈。如果栈中不存在该实例，将会创建新的实例放入栈中。
[4] singleInstance 模式
在一个新栈中创建该Activity的实例，并让多个应用共享该栈中的该Activity实例。一旦该模式的Activity实例已经存在于某个栈中，任何应用再激活该Activity时都会重用该栈中的实例( 会调用实例的 onNewIntent() )。其效果相当于多个应用共享一个应用，不管谁激活该 Activity 都会进入同一个应用中。
设置启动模式的位置在 AndroidManifest.xml 文件中 Activity 元素的 android:launchMode 属性。
