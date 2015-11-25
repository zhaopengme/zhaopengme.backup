title: ubuntu 下的firestarter无法启动的问题解决办法
categories: 闲言碎语
date: 2008-04-21 14:46:00
tags:
---

装了好几天的ubuntu，今天算是装上了，还装了一个firestart防火墙，刚开始就是不能启动，<span>启动**firestarter**时，显示
</br>the device eth0 is not ready。</span>找了找方法，找到了一个，但是还不行，原来那个方法里面可能是原作者没注意，少改了点东西吧！
</br>
</br>第一步，使用在终端中输入ifconfig，windows下是ipconfig，大家别搞混了，我们可以得到掩码和广播的地址，我也不懂广播是什么，也是刚接触ubuntu的。
</br>
</br>第二步，在终端中舒服sudo gedit<span>/etc/**firestarter**/**firestarter**.sh，</span>
</br>
</br>找到
</br>
</br># External network interface data
</br>IP=`/sbin/ifconfig $IF | grep inet | cut -d : -f 2 | cut -d &nbsp; -f 1`
</br>MASK=`/sbin/ifconfig $IF | grep 掩码 | cut -d : -f 4`
</br>BCAST=`/sbin/ifconfig $IF |grep 广播 | cut -d : -f 3 | cut -d &nbsp; -f 1`
</br>NET=$IP/$MASK
</br>
</br>把掩码和广播改成你本机的就可以了，我的就这样成功的。
</br>
</br>原作者的文章中掩码和广播后都代了“：”，那个没有的。