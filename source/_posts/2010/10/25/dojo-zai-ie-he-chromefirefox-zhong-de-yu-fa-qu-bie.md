title: dojo在ie和chrome、firefox中的语法区别
id: 223
categories:

date: 2010-10-25 13:35:24
tags:
---

在ie中的语法 
</br>tab = new dijit.layout.BorderContainer({ 
</br>&nbsp;&nbsp;&nbsp; id: targetId, 
</br>&nbsp;&nbsp;&nbsp; title: title, 
</br>&nbsp;&nbsp;&nbsp; closable: true, 
</br>&nbsp;&nbsp;&nbsp; refreshOnShow: false 
</br>});

其他浏览器的语法 
</br>tab = new dijit.layout.BorderContainer({ 
</br>&nbsp;&nbsp;&nbsp; id: targetId, 
</br>&nbsp;&nbsp;&nbsp; title: title, 
</br>&nbsp;&nbsp;&nbsp; closable: true, 
</br>&nbsp;&nbsp;&nbsp; refreshOnShow: false, 
</br>});
 区别就是在句末的“,”的添加，按照语句规则，最后添加是没有问题，但是在ie中却认为这是个错误，建议在使用按照ie中的写法来写。