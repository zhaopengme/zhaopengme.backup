title: css居中无效的解决办法
id: 602
categories:
  - 闲言碎语
date: 2008-11-15 08:41:00
tags:
---

前几天自己用css做居中的效果 margin: 0 auto,平时我都事这样来写的，不过这次就是不能实现居中的效果，检查代码，原来是自己没有添加DTD语句，即：
</br>＜!DOCTYPE html PUBLIC &quot;-//W3C//DTD XHTML 1.0 Transitional//EN&quot; &quot;http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd&quot;＞
</br>加上之后就可以解决问题了！