title: Myeclipse开发web应用部署到tomcat根目录
id: 30
categories:

date: 2012-11-29 12:45:50
tags:
---

Web应用部署在tomcat中，默认是带了web应用名称的。
</br>

例如：web应用项目名称为：testweb，则部署到tomcat后，是部署在tomcat/webapps/testweb中，网址为：http://localhost:8080/testweb。
</br>

一般我们实际使用是不带testweb的，发现了一个小方法。
</br>

![](http://m2.img.libdd.com/farm4/2012/1129/12/058A1F01550AC4220D9F72FDF943BA9C01C9C0A84F91A_500_439.jpg)</img>
</br>

修改Web Context-root的值为“/”，就可以将testweb去掉，看webapps，testweb是部署到了webapps/ROOT中的，实际的应用部署也需要部署在ROOT中。
</br>

原理不解释，看下tomcat文档就能明白，不看也行，知道怎么用也就够了！
</br>

注意：建议使用tomcat7，tomcat6没测试。
</br>

另外：如果想更简单的开发使用，推荐使用内嵌jetty。