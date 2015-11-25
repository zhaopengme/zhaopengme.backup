title: 再次推荐ant+hudson
id: 76
categories: java
date: 2012-09-26 14:30:03
tags:
---

上次推荐在[《强势推荐ANT小蚂蚁》](http://beardnote.com/strong-recommendation-ant-small-ant.html "《强势推荐ANT小蚂蚁》")中提到使用ant可以完成同步svn代码、编译代码、打包代码、上传、部署的功能。这次再次将ant的功能提升一下，加入hudson持续集成引擎，将我们的程序化的工作更加的自动化完成。
</br> Hudson 是一个可扩展的持续集成引擎，更多的信息可以下面网址。
</br>[http://www.oschina.net/p/hudson](http://www.oschina.net/p/hudson "http://www.oschina.net/p/hudson")
</br>[http://hudson-ci.org/ ](http://hudson-ci.org/ "http://hudson-ci.org/ ")
</br>

#### 配置使用步骤

1.  基本界面
</br> 我使用的Hudson的版本是2.2.1，已经有3.0.0RC的版本出来了，我求稳定，还是使用2.2.1，下载下来是个war，直接扔到tomcat下面就可以了。界面有中文，不过还没有实现全部的I18N，还有部分的英文，基本都认识的，不用担心。 ![](http://m2.img.libdd.com/farm5/2012/0926/13/0258B853F671524179BF177F832CF28B23E5F08D7D8E_500_243.jpg)</img>
</br> 基本界面如上，可以看到我有成功，也有失败的记录，我们的劳动总算是有记录了。

2.  建立构建工程
</br> 选择新建任务 ![](http://m2.img.libdd.com/farm5/2012/0926/13/7C90C7C5C955DCE6B2E4A15332F36EAB7F903C8D7D8E_500_278.jpg)</img>
</br> 我这里选择_自由风格_，根据项目实际情况选择。
</br>

3.  配置ant和任务调度
</br>![](http://m1.img.libdd.com/farm5/2012/0926/13/4967C7BC825022035AE093DF57121EA0C1CECF75FC09_500_253.jpg)</img> 在任务配置界面中，因为我在ant脚本中已经写好了svn的信息，所以在这里就不配置版本管理了，只配置ant和任务调度两个。
</br>![](http://m1.img.libdd.com/farm4/2012/0926/13/777DDCE2E6F37F4B9FE3AE25E0C53E780CDA7975FC09_500_253.jpg)</img> 在ant的配置中，只要你把ant脚本文件build.xml放在_C:.hudsonjobsTEST_下面，hudson就可以执行ant脚本了，当前在target中要配置了，在target中每行可以写一个执行的目标。
</br> 在_Build Triggers_中，我选择_Build periodically_，表示定时执行，需要写调度表达式。
</br>
> ##### 调度表达式资料:
>
> Schedule的配置规则是有5个空格隔开的字符组成，从左到右分别代表：分 时 天 月 年，*代表所有。 例如：0 9 * * * 表示在任何年任何月的任何天的9点的0分
> </br>
4.  构建工程
</br> 可以可以选择_立刻构建_或者等定时任务就可以开始构建工程了，在Hudson可以查看执行的日志和最后的结果。
</br>

## ![](http://m3.img.libdd.com/farm4/2012/0926/14/2904FB277723DA4715DF3AA6EF43087368BDFA8D7D8E_500_71.jpg)</img>
</br>

看到_BUILD SUCCESSFUL_就说明，你成功了，恭喜！
</br>

#### [Hudson下载地址](http://java.net/projects/hudson/downloads/download/war/hudson-2.2.1.war "Hudson下载地址")
