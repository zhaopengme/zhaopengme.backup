title: 让java web支持cors
id: 93
categories: java
date: 2012-07-01 23:52:42
tags:
---

场景:

&nbsp;&nbsp;&nbsp; 客户端发出http请求,服务端对客户端的http请求进行验证

问题:

&nbsp;&nbsp;&nbsp; 问题的表象是 从Chrome发出HTTP命令后，Chrome console中报 “Origin null is not allowed by Access-Control-Allow-Origin”错误。

产生原因:

&nbsp;&nbsp;&nbsp; 这是由于Browser的same origin policy 限制的缘故。简单来说，从HTML中发出XMLHttpRequest&nbsp; 请求时，Browser会做检查，如果发现Response中没有Access-Control-Allow-Origin Header或Access-Control-Allow-Origin Header Header的值与 HTML的 orgin 不同时，Browser会拒接绝该Response，Javascript就收不到该Response。 本地HTML的Origin是 null, 而Server端没有发出Access-Control-Allow-Origin Header Header给Browser,&nbsp; 所以会有了“Origin null is not allowed by Access-Control-Allow-Origin”错误。

&nbsp;&nbsp;&nbsp;&nbsp;简单的说,就是由于客户端和服务端处于两个不同的域,相互之间是不允许通信的.

&nbsp;&nbsp;&nbsp; 不同的域包含:1.静态文件向服务器请求 2.客户端和服务端域名不同 3.客户端和服务端端口不同 等等,个人理解总结的,不是很准确.

解决办法:

&nbsp;&nbsp;&nbsp; 事实上有一个W3C标准，Cross Origin Resource Sharing (CORS) 专门用来解决这个问题的。目前的主流Browser也有支持。CORS 在HTTP Message 加入几个Header， Browser和 Server可以利用这些Header来判断对方是否是安全，是否可以通信。

&nbsp;&nbsp;&nbsp; [http://enable-cors.org/](http://enable-cors.org/)&nbsp; 介绍了目前常用的服务器和技术的支持CORS的办法.其中对与JAVA Web,里面没提到.整理下让Java Web支持的办法.

Java Web支持的办法:

&nbsp;&nbsp;&nbsp; 使用[CORS Filter](http://software.dzhuvinov.com/cors-filter.html) 解决.

&nbsp;&nbsp;&nbsp; 下载地址:[http://software.dzhuvinov.com/cors-filter.html](http://software.dzhuvinov.com/cors-filter.html)

&nbsp;&nbsp;&nbsp;&nbsp;使用方法:[http://software.dzhuvinov.com/cors-filter-installation.html](http://software.dzhuvinov.com/cors-filter-installation.html)&nbsp;

&nbsp;&nbsp;&nbsp; 参考文章

&nbsp;&nbsp;&nbsp; [http://www.cnblogs.com/LevinJ/archive/2012/04/09/2439670.html](http://www.cnblogs.com/LevinJ/archive/2012/04/09/2439670.html)
 43 Things：[CORS](http://www.43things.com/tag/CORS)
</br>BuzzNet：[CORS](http://www.buzznet.com/CORS)
</br>del.icio.us：[CORS](http://del.icio.us/popular/CORS)
</br>Flickr：[CORS](http://flickr.com/photos/tags/CORS)
</br>IceRocket：[CORS](http://blogs.icerocket.com/search?q=CORS)
</br>LiveJournal：[CORS](http://www.livejournal.com/interests.bml?int=CORS)
</br>Technorati：[CORS](http://technorati.com/tags/CORS)
</br>
