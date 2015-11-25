title: mysql忘记root密码后的修改
id: 128
categories: 闲言碎语
date: 2012-02-02 13:39:34
tags:
---

年过完了，新一年又开始喽！吼吼！

同事的mysql忘记了root密码，我也整理测试了下，此方法可以行的通的。

环境是windows，linux下面应该也可以的，就是执行mysql命令而已。

1.结束mysql的服务
> net stop mysql5_pn

2.打开dos窗口，切换到mysql的bin目录下
> cd D:serverPHPnow-1.5.6MySQL-5.0.90bin
>
> mysqld-nt --skip-grant-tables
>
> 注释：
> </br>该命令通过跳过权限安全检查，开启mysql服务，这样连接mysql时，可以不用输入用户密码。
>
> 此时这个dos窗口会静止了，不管，就是开启了mysql的服务。

3.继续重新打开一个新的dos窗口，切换到mysql的bin目录下
> cd D:serverPHPnow-1.5.6MySQL-5.0.90bin
>
> mysql
>
> 这样就进入mysql了，继续。
>
> use mysql
>
> 选择切换到mysql的数据库，继续。
>
> update user set password=password('123456as') where user='root';
>
> 修改root的密码为123456as，继续。
>
> flush privileges;
>
> 刷新权限，继续。
>
> quit
>
> 退出，就结束了，可以把所有的dos关闭了。

4.启动mysql服务，登录
> net start mysql5_pn
>
> 启动mysql服务
>
> mysql –u root –p
>
> 进入mysql数据库，输入密码123456as就完毕了，如果还没有成功，就要看下你的人品了！

关键的命令都用红色标记出来了，跟着操作就可以了。
