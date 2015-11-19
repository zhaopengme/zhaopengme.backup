title: CygWin使用命令tail打印出来日志中文乱码的解决办法
id: 284
categories:
  - 闲言碎语
date: 2010-03-06 08:30:48
tags:
---

CygWin使用命令tail打印出来日志中文乱码的解决办法
</br>我在win7上安装了CygWin，使用ls等命令，都可以把中文正常的显示出来。
</br>但是当使用tail -f 来打印SytemOut.log的时候，出现了乱码。
</br>![](http://m2.img.libdd.com/farm5/2012/0821/23/793B8BAE06AEA6F7A9DBB41E4549D40E5E50418D7D8E_500_160.jpg)</img>
</br>要解决就只要在Cygwin.bat中添加set LANG=en_US就可以了。
</br>@echo off
</br>d:
</br>chdir d:cygwinin
</br>set LANG=en_US
</br>bash --login -i
</br>![](http://m2.img.libdd.com/farm5/2012/0821/23/E23FA975989ECC690E227CD2FD873268DB21748D7D8E_500_131.jpg)</img>