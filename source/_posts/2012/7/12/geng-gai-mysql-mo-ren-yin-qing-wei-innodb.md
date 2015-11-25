title: 更改mysql默认引擎为Innodb
id: 90
categories: 闲言碎语
date: 2012-07-12 12:53:50
tags:
---

mysql默认是关闭InnoDB存储引擎的使用的，将InnoDB设置为默认的引擎如下。
</br> 1\. 查看mysql存储引擎情况： mysql&gt;show engines。 InnoDB | YES，说明此mysql数据库服务器支持InnoDB引擎。
</br> 2\. 设置InnoDB为默认引擎：在配置文件my.ini中的 [mysqld] 下面加入default-storage-engine=INNODB
</br> 3\. 重启mysql服务器
</br> 4\. 登录mysql数据库，mysql&gt;show engines。如果出现 InnoDB |DEFAULT，则表示设置InnoDB为默认引擎成功。

听一曲歌来听听，挺喜欢的歌手万晓利的。走过来，走过去!

[![](http://m2.img.libdd.com/farm3/174/CA8AA0A8C4DD2BF56EC8AE21C1E10FAE_200_80.PNG)</img>](http://www.xiami.com/widget/0_373807/singlePlayer.swf)
