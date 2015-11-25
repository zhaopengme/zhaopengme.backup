title: 使用vsftpd搭建
id: 240
categories: 闲言碎语
date: 2010-08-06 18:04:01
tags:
---

使用vsftpd搭建
</br>1.在ftp://vsftpd.beasts.org/users/cevans/
</br>下载使用vsftpd-2.2.2.tar.gz版本
</br>2.上传解压到
</br>[root@EMAG-167-115 soft]# tar -zxvf vsftpd-2.2.2.tar.gz
</br>3.进入解压后的目录
</br>[root@EMAG-167-115 soft]# cd vsftpd-2.2.2
</br>4.进行编译
</br>[root@EMAG-167-115 vsftpd-2.2.2]# make
</br>5.改错
</br>我在编译的过程中，出现了下面的错误
</br>/lib/libpam.so.0: could not read symbols: 文件格式错误
</br>&nbsp;修改这个文件，将所有lib替换成lib64
</br>修改的方法如此：
</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;修改这个文件，将所有lib替换成lib64
</br>使用vi编辑
</br>[root@EMAG-167-115 vsftpd-2.2.2]#vi vsf_findlibs.sh
</br>:0,$ s//lib//lib64//g
</br>保存退出后再次编译
</br>[root@EMAG-167-115 vsftpd-2.2.2]# make
</br>[root@EMAG-167-115 vsftpd-2.2.2]# make install
</br>6.保存配置文件到系统目录
</br>[root@EMAG-167-115 vsftpd-2.2.2]# cp vsftpd.conf /etc/
</br>7.copy pad 模块 这个模块是进行用户识别的模块，没有它不能进行用户识别。
</br>[root@EMAG-167-115 vsftpd-2.2.2]# cp RedHat/vsftpd.pam /etc/pam.d/ftp
</br>在/etc/pam.d/下面没有ftp文件夹，就新建一个ftp文件夹吧！
</br>8.建立匿名用户默认的目录
</br>[root@EMAG-167-115 vsftpd-2.2.2]# mkdir /var/ftp
</br>9.启动vsfptd
</br>[root@EMAG-167-115 vsftpd-2.2.2]# /usr/local/sbin/vsftpd &amp;
</br>10.防火墙通过21端口
</br>[root@EMAG-167-115 vsftpd-2.2.2]# /sbin/iptables -I INPUT -p tcp --dport 21 -j ACCEPT
</br>11.保存重启配置
</br>[root@EMAG-167-115 vsftpd-2.2.2]# /etc/rc.d/init.d/iptables save
</br>[root@EMAG-167-115 vsftpd-2.2.2]# /etc/init.d/iptables restart
</br>12.设置自动启动vsftpd
</br>[root@EMAG-167-115 vsftpd-2.2.2]# echo &quot;/usr/local/sbin/vsftpd &amp;&quot; &gt;&gt; /etc/rc.local
</br>-------------现在就可以匿名的登陆ftp了
</br>我在windows下cmd进行测试
</br>&nbsp;
</br>C:WindowsSystem32&gt;ftp 192.168.167.115
</br>连接到 192.168.167.115。
</br>220 (vsFTPd 2.2.2)
</br>用户(192.168.167.115:(none)): anonymous
</br>注：要求用户就写：anonymous，否则会进入失败
</br>331 Please specify the password.
</br>密码:
</br>注：密码直接回车
</br>230 Login successful.
</br>ftp&gt; dir
</br>200 PORT command successful. Consider using PASV.
</br>150 Here comes the directory listing.
</br>226 Directory send OK.
</br>ftp&gt;
