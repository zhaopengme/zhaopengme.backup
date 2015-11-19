title: dojo中的懒加载和提前加载
id: 225
categories:
  - web
date: 2010-10-25 13:11:45
tags:
---

提前加载： 
</br>var pane= new dijit.layout.ContentPane({ 
</br>&nbsp; href:&quot;*.html&quot; 
</br>}); 
</br>懒加载： 
</br>var pane= new dijit.layout.ContentPane({ 
</br>}); 
</br>pane.set(&quot;href&quot;,&quot;*.html&quot;) 
</br>
</br>在用法上来说，两种的使用是没有区别的，但我在实际使用中，使用提前加载不能把*.html加载进去，而懒加载可以。

而且推荐使用懒记载的方式，懒加载在效率上面也要比提前加载好一些。