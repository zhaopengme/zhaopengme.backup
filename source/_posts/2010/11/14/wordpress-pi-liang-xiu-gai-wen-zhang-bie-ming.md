title: wordpress批量修改文章别名
id: 213
categories:
  - java
date: 2010-11-14 00:19:14
tags:
---

之前文章浏览的方式一直采用的数字方式，没有用过别名，采用固定链接方式后，中文默认全是乱码了，一篇一篇的去修改，显然不可能，最后用java做了文章别名批量来修改，思路简单，就是去文章的中文标题，在把标题转换为拼音而已，直接对数据库做操作而已。
</br>现把源码和工具公布，在[http://code.google.com/p/dapeng/downloads/list](http://code.google.com/p/dapeng/downloads/list)可以下载到。
</br><span> 注：用java开发，所以必须要安装jar。</span>