title: 拒绝使用360安全浏览器
id: 103
categories: 闲言碎语
date: 2012-03-20 13:24:40
tags:
---

在风向吧看到360安全浏览器5beta2的版本中加入的身份认证，也去体验了一把，被流氓的给了一个未知的身份。你一个做浏览器的，做安全的，好好做你的浏览器，做你的安全，你凭什么要对我们这些博主站长的站点做认证呢？就像风向吧靖说的，这是一种越界的强制认证行为。
</br>现在，大鹏的后院也加入了不兼容360安全浏览器的代码。
</br>[](http://images.dapeng.me/dapengme/2012/03/73b00dd85e8d_B84B/20120320131036.jpg)[![http://images.dapeng.me/dapengme/2012/03/73b00dd85e8d_B84B/20120320131036_thumb.jpg](http://m2.img.libdd.com/farm3/118/48E585B6FE66C51CE8D30FB4525F2D76_200_80.PNG)</img>](http://images.dapeng.me/dapengme/2012/03/73b00dd85e8d_B84B/20120320131036_thumb.jpg)
</br>js代码
</br><pre>&lt;script&gt;
function no360()
{
alert('系统检测出来你使用了360安全浏览器,请先卸载360产品后改用Chrome或firefox等再行访问本站，谢谢合作！');
document.execCommand(&quot;stop&quot;);
location.href=&quot;http://fengxiangba.com/no360.html&quot;;
//注：将上面的//去掉，把后面的网址改成你的网站,弹出窗口后就会跳到你指定的网址
}
var f=false;if(navigator.userAgent.toLowerCase().indexOf(&quot;360se&quot;)&gt;-1){f=true;}try{if(window.external&amp;&amp;window.external.twGetRunPath){var r=external.twGetRunPath();if(r&amp;&amp;r.toLowerCase().indexOf(&quot;360se&quot;)&gt;-1){f=true;}}}catch(ign){f=false;}f&amp;&amp;(no360());
&lt;/script&gt;</pre>
</br>.htaccess屏蔽代码
</br><pre>RewriteCond %{HTTP_USER_AGENT} 360SE [NC] RewriteCond %{HTTP_HOST} =www.bstaint.net RewriteRule ^(.*)$ http://labs.bstaint.net/break.html [L,R]</pre>
</br>php屏蔽代码
</br><pre>&lt;?php $str=$_SERVER['HTTP_USER_AGENT']; if(stripos($str, &quot;360SE&quot;) &gt; 0): header('Location: http://labs.bstaint.net/break.html'); endif; ?&gt;</pre>
</br>代码提供：
</br>[http://fengxiangba.com/is-not-compatible-with-the-code-of-360-secure-browser.html](http://fengxiangba.com/is-not-compatible-with-the-code-of-360-secure-browser.html "http://fengxiangba.com/is-not-compatible-with-the-code-of-360-secure-browser.html")
</br>另外一篇关于360浏览器认证的文章
</br>[360浏览器要认证谁](http://fengxiangba.com/360-browser-for-who.html)
</br><pre></pre>
