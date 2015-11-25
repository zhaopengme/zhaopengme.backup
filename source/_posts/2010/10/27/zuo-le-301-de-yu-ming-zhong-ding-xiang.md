title: 做了301的域名重定向
id: 221
categories: 闲言碎语
date: 2010-10-27 12:29:46
tags:
---

之前一直用joypen.cn，今天刚用301做了，域名的重定向，修改.htaccess，加入
</br>RewriteEngine on
</br>RewriteRule ^(.*)$ http://dapeng.me/$1 [R=301,L]
</br>所以的都就到了dapeng.me了。
