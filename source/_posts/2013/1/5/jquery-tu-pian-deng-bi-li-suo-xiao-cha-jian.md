title: jquery图片等比例缩小插件
id: 18
categories:
  - web
date: 2013-01-05 20:55:26
tags:
---

[胡天硕的点点滴滴](http://tianshuohu.diandian.com/) 提醒文章的缩略图，会把原图缩略之后就给变形，比例失调了，使用max-height max-widthde 的属性，在IE下面失效，现在改用jquery插件的方式了，去除了原来的图片延时加载，与等比例缩小插件有冲突.
</br>

使用也是简单的，加载js文件。
</br>

http://x.libdd.com/farm1/6424fa/f55203fd/loadimage.js
</br>

调用：
</br>
<pre config="brush:js;toolbar:false;">
      //图片等比例缩放
      $(&quot;.post-thumbnail img&quot;).LoadImage({
          scaling : true,
          width : 170,
          height : 130,
          loadpic:&quot;http://x.libdd.com/farm1/6424fa/c106a7b5/default.jpg&quot;
      });
</pre>

首页可以看到效果，放一张哥们的“萌像”（他自己说的，我看就是呆）。
</br>

![](http://m3.img.libdd.com/farm5/2013/0105/20/21CBD7A2F6A2D9923A8A0E690F310844E9C5BABB032F6_500_667.jpg)</img>