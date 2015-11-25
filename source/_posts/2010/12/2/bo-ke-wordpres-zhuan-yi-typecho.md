title: 博客wordpres转移typecho
id: 211
categories: 软件工具
date: 2010-12-02 15:39:59
tags:
---

个人的博客本来就需求简单一点的，wordpress的功能提取额是很强大，越来越大，越来越强，当然会越来越重的，不是说wordpress不好，对我来说，就有点重。

</br>

在经过短暂的思考决定后，将wordpress转到typecho了，并且将博客[http://dapeng.me](http://dapeng.me)进入后院时代[http://dapeng.me/](http://dapeng.me/)，仅仅追求个人博客价值，将自己的杂念排除在外了。typecho相当的简单，简单到文章发布的编辑器也就仅仅是个文本框，必须添加插件才有丰富的编辑功能。

</br>

在没玩过程序之前，对转换程序很神秘，感觉好神奇的，懂了数据库，转换，也就是从一张表数据到另外一张表数据的改变而已！

</br>

wordpress的势力大，从其他程序都有转换的工具，而且更新快，能满足多各个版本，typecho就不行了，现在提供的wordpress2typecho，只能满足wordpress2.7转typecho0.6。

</br>

为了不拿服务器做实验，我的转换都是在本地完成。

</br>

1.在本地搭建了wordpress2.7和typecho0.6的环境
</br>&nbsp;http://localhost/wordpress

</br>

http://localhost/typecho

</br>

2.将服务器上的wordpress通过wordpress数据格式导出到本地，将数据导入到本地的wordpress2.7中

</br>

3.在typecho0.6安装[wordpresstotypecho](http://docs.typecho.org/_media/plugins/wordpresstotypecho_v1.0.3.zip)插件

</br>

4.启用wordpresstotypecho插件后，有数据库的配置信息填写，看着说明就会填写

</br>

5.填写完毕后，在控制台有wordpresstotypecho选项，点击就完成转换了。
</br>&nbsp;<span>注：如果不是用wordpress2.7和typecho0.6的版本，有可能出404或者其他错误。</span>

</br>

<span>6.转换成功后，在本地phpMyAdmin中，将</span>typecho的数据库导出

</br>

http://localhost/phpMyAdmin

</br>

7.在服务器phpMyAdmin中，将typecho的数据导入

</br>

<span>注：在服务器中已经安装了typecho0.8的版本了</span>

</br>

8.现在服务器上typecho的url使用的还是本地url，在phpMyAdmin中修改<span>typecho_users</span><span><span>中的url字段为</span></span>[http://dapeng.me/](http://dapeng.me/)

</br>

9.还需要修改<span>typecho_options</span>中中的siteurl字段为[http://dapeng.me/](http://dapeng.me/)

</br>

10.转换完毕，慢慢享受吧！

</br>

转换能把文章、评论、标签转换过来，其他的就慢慢再设定了！

</br>

现在大鹏博客得地址是[http://blog.dapeng.me](http://dapeng.me/)

</br>

[http://dapeng.me/](http://dapeng.me/)&nbsp;大鹏说事，说说程序的事。关于大鹏说事，就放在另外一篇文章中说吧！

</br>

&nbsp;
