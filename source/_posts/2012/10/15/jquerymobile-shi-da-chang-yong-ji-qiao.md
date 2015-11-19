title: jQuery Mobile十大常用技巧
id: 56
categories:
  - java
date: 2012-10-15 12:40:08
tags:
---

在本文中，将介绍使用jQuery Mobile开发的一些常用的技巧，阅读对象为已经使用过jQuery Mobile进行开发的移动Web开发者.
</br> 1、禁止截断过长的列表和按钮内容
</br> 在jQuery mobile中，如果列表或者按钮中文字的内容过长，jQuery Mobile会自动截断其超过长度的内容，但如果不希望这样的话，可以在CSS样式中增加如下设置即可，比如下面的是针对按钮的CSS样式设置：
</br>
<pre config="brush:css;toolbar:false;">
.ui-btn-text {
white-space: normal;
}
</pre>

下面的是针对列表的CSS样式设置
</br>
<pre config="brush:css;toolbar:false;">
.ui-li-desc {
white-space: normal;
}
</pre>

如果要恢复对文字的截断,则继续设置CSS为white-space: nowrap;
</br> 2、实现页面加载时的随机页面背景过渡效果
</br> jQuery Mobile中,当需要实现页面加载时,可以有很多的页面加载事件可供使用。比如下面的CSS和JavaScript代码，可以实现页面加载时的随机页面背景过渡效果。
</br> CSS代码:
</br>
<pre config="brush:css;toolbar:false;">
.my-page  { background: transparent url(../images/bg.jpg) 0 0 no-repeat; }

.my-page.bg1 { background: transparent url(../images/bg-1.jpg) 0 0 no-repeat; }

.my-page.bg2 { background: transparent url(../images/bg-2.jpg) 0 0 no-repeat; }

.my-page.bg3 { background: transparent url(../images/bg-3.jpg) 0 0 no-repeat; }
</pre>

Javascript代码：
</br>
<pre config="brush:js;toolbar:false;">
$('.my-page').live(&quot;pagecreate&quot;, function() {
　var randombg = Math.floor(Math.random()*4); //获得0到3之间的随机数
　    $('.my-page').removeClass().addClass('bg' + randombg);
});
</pre>

3、禁用button
</br> 在有的情况下，可能会需要禁止按钮的加载事件，这个时候可以继续通过如下的设置实现：
</br>
<pre config="brush:css;toolbar:false;">
$('#home-button').button(&quot;disable&quot;);
</pre>

如果要恢复可用，则设置为：
</br>
<pre config="brush:css;toolbar:false;">
$('#home-button').button(&quot;enable&quot;);
</pre>

4、去掉页面加载时的提示信息
</br> 如果在加载页面时，不需要显示页面加载信息时，可以通过设置一个属性来取消显示加载提示信息，如下：
</br>
<pre config="brush:js;toolbar:false;">
$.mobile.pageLoading(true);
</pre>

如果要继续保持显示页面加载信息，则为：
</br>
<pre config="brush:js;toolbar:false;">
$.mobile.pageLoading();
</pre>

5、创建自定义主题
</br> jQuery Mobile本身提供了A-E五种不同的主题，但可以自定义主题，步骤如下：
</br> 1.从jQuery Mobile的任意一个定义主题的CSS文件中，复制其内容到自己定义的CSS文件中。
</br> 2.给要自定义的CSS主题一个恰当的名称并且重新命名CSS文件，注意命名必须是(a-z)英文字母，比如你是从jQuery Mobile的主题c的样式文件中复制的，则可以将主题命名为Z,则复制过来的内容中，比如要将.ui-btn-up-c改为.ui-btn-up-z,.ui-body-c改为.ui-body-z，如此类推。
</br> 3\. 改变新建立的自定义主题的颜色和CSS文件。
</br> 4\. 最后，需要在页面中，应用新定义的主题样式，如下：
<pre config="brush:css;toolbar:false;">
&lt;div data-role=&quot;page&quot; data-theme=&quot;z&quot;&gt;&lt;/div&gt;
</pre>

6、使用自定义字体
</br> 在移动Web应用中，有的时候需要更换字体，这样的话，可以通过使用@font-face方法实现，并且性能是十分好的。具体关于@font-face的使用，请参考[http://www.sitepoint.com/the-fontface-jquery-plugin/](http://www.sitepoint.com/the-fontface-jquery-plugin/ "http://www.sitepoint.com/the-fontface-jquery-plugin/")这篇文章。
</br> 7、创建一个没有文本只有图片的按钮
</br> 有时，可能想用一个没有文本内容仍具有按钮特性的一个按钮。如果要在按钮上隐藏文本，设置data-iconpos=&quot;notext&quot;，例如：
</br>
<pre config="brush:html;toolbar:false;">
&lt;a href=&quot;../index.html&quot; data-icon=&quot;grid&quot; claa=&quot;ui-btn-right&quot; data-iconpos=&quot;notext&quot;&gt;Home&lt;/a&gt;
</pre>

8、打开一个无需使用Ajax页面过渡的超链接
</br> 如果不需要使用Ajax打开一个页面的链接，可以设置链接的rel属性，如下：
</br>
<pre config="brush:html;toolbar:false;">
&lt;a href=&quot;../index.html&quot; data-icon=&quot;grid&quot; class=&quot;ui-btn-right&quot; rel=&quot;external&quot;&gt;Home&lt;/a&gt;
</pre>

9、移除项目列表中的箭头
</br> 默认情况下，jQuery Mobile框架会为每一个列表项添加一个箭头，想要禁用箭头显示，需要在想要移除列表项设置data-icon=&quot;false&quot;。
</br>
<pre config="brush:html;toolbar:false;">
&lt;li data-icon=&quot;false&quot;&gt;&lt;a href=&quot;contact.html&quot;&gt;Contact Us&lt;/a&gt;&lt;/li&gt;
</pre>

10、设置页面的背景颜色
</br> 怎样在不修改jQuery Mobile样式下设置一个页面背景颜色的？听起来很简单，其实需要花几分钟时间才能解决。通常情况下，需要在body元素中设置背景颜色，但是用jQuery Mobile框架，需要设置在ui-page类中。
</br>
<pre config="brush:css;toolbar:false;">
.ui-page{
     background:#eee;
}
</pre>