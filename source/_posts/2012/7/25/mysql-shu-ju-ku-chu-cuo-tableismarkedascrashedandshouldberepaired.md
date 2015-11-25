title: 'MySQL数据库出错:Table is marked as crashed and should be repaired'
id: 86
categories: 闲言碎语
date: 2012-07-25 10:45:23
tags:
---

使用mysql时，发生的错误 Table is marked as crashed and should be repaired。

解决办法：用“REPAIR TABLE `tablename`;”命令修复。简单好用！还有其他办法，就不多说了。

原因：有网友说是频繁查询和更新dede_archives表造成的索引错误，因为我的页面没有静态生成，而是动态页面，因此比较同意这种说 法。还有说法为是MYSQL数据库因为某种原因而受到了损坏，如：数据库服务器突发性的断电、在提在数据库表提供服务时对表的原文件进行某种操作都有可能 导致MYSQL数据库表被损坏而无法读取数据。总之就是因为某些不可测的问题造成表的损坏。

来一曲古风版的最炫民族风，民族乐器演奏出来果然不一般啊！

[![](http://m2.img.libdd.com/farm3/174/CA8AA0A8C4DD2BF56EC8AE21C1E10FAE_200_80.PNG)</img>](http://www.tudou.com/v/qTosu-Oxq8s/&amp;resourceId=65693200_05_02_99/v.swf)
