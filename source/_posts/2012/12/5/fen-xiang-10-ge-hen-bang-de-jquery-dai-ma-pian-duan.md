title: 分享10个很棒的jQuery代码片段
id: 28
categories:
  - java
date: 2012-12-05 15:00:01
tags:
---

 jQuery使用户能更方便地处理HTML documents、events，以及动画效果，并且方便地为网站提供AJAX交互。jQuery的另一个比较大的优势是，它拥有一套很好的文档说明，其中的各种应用也说得很详细，同时还有优秀的插件可供开发组来选择。jQuery能够使用户的html页保持代码和html内容分离，也就是说，不用再在html里面插入一堆js来调用命令了，只需定义id即可。

### _[代码]_ 图片预加载
</br>
<pre config="brush:jscript;">(function($) {
  var cache = [];
  // Arguments are image paths relative to the current page.
  $.preLoadImages = function() {
    var args_len = arguments.length;
    for (var i = args_len; i--;) {
      var cacheImage = document.createElement('img');
      cacheImage.src = arguments[i];
      cache.push(cacheImage);
    }
  }
jQuery.preLoadImages(&quot;image1.gif&quot;, &quot;/path/to/image2.png&quot;);</pre>

### _[代码]_ 在新窗口打开链接 (target=”blank”)
</br>
<pre config="brush:jscript;">$('a[@rel$='external']').click(function(){
     this.target = &quot;_blank&quot;;
});
/*
   Usage:
   &lt;a href=&quot;http://www.idbshare.com&quot; rel=&quot;external&quot;&gt;idbshare.com&lt;/a&gt;
*/</pre>

### _[代码]_ 当支持 JavaScript 时为 body 增加 class
</br>
<pre config="brush:jscript;">/* 该代码只有1行，但是最简单的用来检测浏览器是否支持 JavaScript 的方法
    如果支持 JavaScript 就在 body 元素增加一个 hasJS 的 class */
$('body').addClass('hasJS');</pre>

### _[代码]_ 平滑滚动页面到某个锚点
</br>
<pre config="brush:jscript;">$(document).ready(function() {
    $(&quot;a.topLink&quot;).click(function() {
        $(&quot;html, body&quot;).animate({
            scrollTop: $($(this).attr(&quot;href&quot;)).offset().top + &quot;px&quot;
        }, {
            duration: 500,
            easing: &quot;swing&quot;
        });
        return false;
    });
});</pre>

### _[代码]_ 鼠标滑动时的渐入和渐出
</br>
<pre config="brush:jscript;">$(document).ready(function(){
    $(&quot;.thumbs img&quot;).fadeTo(&quot;slow&quot;, 0.6); // This sets the opacity of the thumbs to fade down to 60% when the page loads
    $(&quot;.thumbs img&quot;).hover(function(){
        $(this).fadeTo(&quot;slow&quot;, 1.0); // This should set the opacity to 100% on hover
    },function(){
        $(this).fadeTo(&quot;slow&quot;, 0.6); // This should set the opacity back to 60% on mouseout
    });
});</pre>

### _[代码]_ 制作等高的列
</br>
<pre config="brush:jscript;">var max_height = 0;
$(&quot;div.col&quot;).each(function(){
    if ($(this).height() &gt; max_height) { max_height = $(this).height(); }
});
$(&quot;div.col&quot;).height(max_height);</pre>

### _[代码]_ 在一些老的浏览器上启用 HTML5 的支持
</br>
<pre config="brush:jscript;">(function(){
    if(!/*@cc_on!@*/0)
        return;
    var e = &quot;abbr,article,aside,audio,bb,canvas,datagrid,datalist,details,dialog,eventsource,figure,footer,header,hgroup,mark,menu,meter,nav,output,progress,section,time,video&quot;.split(','),i=e.length;while(i--){document.createElement(e[i])}
})()
//然后在head中引入该js
&lt;!--[if lt IE 9]&gt;
&lt;script src=&quot;http://html5shim.googlecode.com/svn/trunk/html5.js&quot;&gt;&lt;/script&gt;
&lt;![endif]--&gt;</pre>

### _[代码]_ 测试浏览器是否支持某些 CSS3 属性
</br>
<pre config="brush:jscript;">var supports = (function() {
   var div = document.createElement('div'),
      vendors = 'Khtml Ms O Moz Webkit'.split(' '),
      len = vendors.length;
   return function(prop) {
      if ( prop in div.style ) return true;
      prop = prop.replace(/^[a-z]/, function(val) {
         return val.toUpperCase();
      });
      while(len--) {
         if ( vendors[len] + prop in div.style ) {
            // browser supports box-shadow. Do what you need.
            // Or use a bang (!) to test if the browser doesn't.
            return true;
         }
      }
      return false;
   };
})();
if ( supports('textShadow') ) {
   document.documentElement.className += ' textShadow';</pre>

### _[代码]_ 获取 URL 中传递的参数
</br>
<pre config="brush:jscript;">$.urlParam = function(name){
    var results = new RegExp('[\?&amp;]' + name + '=([^&amp;#]*)').exec(window.location.href);
    if (!results) { return 0; }
    return results[1] || 0;
}</pre>

### _[代码]_ 禁用表单的回车键提交
</br>
<pre config="brush:jscript;">$(&quot;#form&quot;).keypress(function(e) {
  if (e.which == 13) {
    return false;
  }
});</pre>