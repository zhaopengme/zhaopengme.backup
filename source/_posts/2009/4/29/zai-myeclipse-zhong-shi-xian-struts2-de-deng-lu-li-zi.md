title: 在myeclipse中实现struts2的登录例子
id: 459
categories:

date: 2009-04-29 01:44:00
tags:
---

　　在myeclipse中实现struts2的登录例子
</br>　　环境：myeclipse 6.0.1 GA
</br>　　jdk：myeclipse自带
</br>　　tomcat：6.0
</br>　　struts2：2.1.6
</br>　　过程：
</br>　　1、使用myeclipse建立web工程
</br>　　2、由于在struts2中使用过滤器调用action的机制，所以需要在web.xml中添加过滤器代码
</br>　　
</br>　　struts2
</br>　　
</br>　　org.apache.struts2.dispatcher.FilterDispatcher
</br>　　
</br>　　
</br>　　
</br>　　struts2
</br>　　/*
</br>　　
</br>　　3、将struts2的所需的jar拷到lib目录下
</br>　　commons-logging-1.1.jar
</br>　　freemarker-2.3.13.jar
</br>　　ognl-2.6.11.jar
</br>　　struts2-core-2.1.6.jar
</br>　　xwork-2.1.2.jar
</br>　　在许多教程中都写着，只要有以上5个jar包就可以了，但是我在使用中却不行，添加了commons-fileupload-1.2.1.jar这个jar包以后，才可以正确执行。
</br>　　4、在src建立struts.xml文件，
</br>　　
</br>　　http://struts.apache.org/dtds/struts-2.0.dtd
</br>　　
</br>　　
</br>　　
</br>　　/result.jsp
</br>　　
</br>　　
</br>　　
</br>　　5、建立LoginAction文件
</br>　　6、建立login.jsp和result.jsp文件
</br>　　7、发布
</br>
</br>
</br>