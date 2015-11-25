title: win7下面android使用eclipse开发环境部署
id: 230
categories: java
date: 2010-10-08 15:20:59
tags:
---

前提：使用eclipse肯定必须要安装jdk，配置jdk的环境的。
</br>我单独下载了eclipse的版本，没有在之前的eclipse装，我搭建了一个php的开发环境也是这样，单独的eclipse用于php的开发，java的开发用的是myeclipse。
</br>前提有了之后，接着需要有android-sdk-windows， 在http://developer.android.com/sdk/ 下载
</br>还要有 Android Development Tools （ADT） 通过eclipse插件安装的方式安装，地址：https://dl-ssl.google.com/android/eclipse/
</br>关键配置几个环境变量
</br>变量名：ANDROID_SDK_HOME 必须这么写
</br>值：D: oolsandroidandroid-avd avd模拟器的地址
</br>变量名：path
</br>值：D: oolsandroidandroid-sdk-windows ools 照这样的的写
</br>其他的配置可以参加http://news.congci.com/news/windows7-android-eclipse-adt看看。
