title: 'jnote开源笔记软件 '
id: 856
categories:
  - 个人作品
date: 2013-12-14 00:46:21
tags:
---

整理了下做的一个笔记软件,以开放开源的态度做的.

jnote是一个开源的笔记软件,类似于Evernote,wiz,麦库,界面也是参考他们做的.当初做只是为了做一个自己可以定制的笔记软件.

目前完成的功能:

1.新建日记,参考wiz的日记功能,这个功能很实用,可以按照年月分类.
2.新建笔记,是一个笔记软件最基本的功能.
3.编辑支持高级html编辑器 简单html编辑器 markdown编辑器
4.分类支持无限级分类
5.简单搜索
6.缩小到托盘
7.支持多标签
8.支持笔记阅读模式
9.阅读模式是可以和wiz一样,定义阅读的主题.
以后的计划

1.添加标签功能
2.添加附件功能
3.搜索功能加强,计划采用lucene,使用OSChina 网站的全文搜索框架源码做了测试,完成可以使用.
4.同步,在选择上面,测试过dropbox的api,计划使用dropbox.
5.和evernote 有道 麦库打通api接口,这个还没有测试过,evernote应该是首选.
6.用户登录,头像…
7.跨平台
8…….

目前存在的问题

1.笔记字数,使用sqlite数据库,存储的文字多少还存在考量.
2.编辑器还不完美,编辑器的切换还对笔记的格式存在转换问题.
3.内嵌浏览器的问题,这个是java的硬伤,目前使用IE内核,Webkit 由于不支持linux就放弃了,打算使用JF X的内嵌浏览器来实现,提高性能和解决跨平台的问题.
4……

采用的技术

1.界面使用BeautyEye,界面很漂亮
2.nutzDao,小巧灵活.
3.数据库使用sqlite,
4.编辑器使用ueditor wysihtml5 pagedown

做笔记软件真不容易,特别还是用java来做.

在13年3月份差不多已经这个样子了,之后在忙其他事情,有时间就会继续完善的.

看几张截图来看看.

[![0](http://zhaopeng.me/wp-content/uploads/2013/12/02.png)](http://zhaopeng.me/wp-content/uploads/2013/12/02.png)

[![1](http://zhaopeng.me/wp-content/uploads/2013/12/12.png)](http://zhaopeng.me/wp-content/uploads/2013/12/12.png)

[![2](http://zhaopeng.me/wp-content/uploads/2013/12/23.png)](http://zhaopeng.me/wp-content/uploads/2013/12/23.png)

项目地址:http://git.oschina.net/imzhpe/jnote