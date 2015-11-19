title: ssh连接linux中文出现乱码
id: 241
categories:
  - 闲言碎语
date: 2010-08-06 18:03:40
tags:
---

ssh连接linux中文出现乱码
</br>解决办法：
</br>1.使用管理员账户
</br>vi /etc/sysconfig/i18n
</br>2.修改
</br>将LANG=&quot;zh_CN.UTF-8&quot;修改为LANG=&quot;zh_CN.GB18030&quot;
</br>或者修改为LANG=&quot;zh_CN.GB18030&quot;也都是可以