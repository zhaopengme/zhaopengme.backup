title: redhat9 jdk安装笔记
id: 254
categories: java
date: 2010-05-21 03:56:36
tags:
---

redhat9上面，默认的java环境是1.3的，用java -version就能看得出来。如果要替换成其他的版本，总结下自己的安装过程。
</br>卸载原有的jdk，（网上有种说法，可以让多个jdk的版本并存，我相信，windows可以的，linux一样可以，我需要一个默认的就行，如果某个应用需要其他版本的，单独设置classpath就行了。）
</br>1、查看当前jdk的一些包，会出现一些包信息
</br>#rpm -qa | grep gcj
</br>libgcj-devel-4.1.2-14.el5
</br>java-1.4.2-gcj-compat-src-1.4.2.0-40jpp.112
</br>....这里的不是标准
</br>2、使用卸载命令
</br>rpm -e --nodeps libgcj-devel-4.1.2-14.el5
</br>将上面出现的包一一进行卸载
</br>3、使用java -version查看，会出现no such file or diretory
</br>4、安装jdk，从sun上面下载到的是bin文件，需要修改权限，使用chmod 777就行.
</br> chmod 777 ./jdk.bin
</br>一路enter，安装结束
</br>5、设置环境变量，有好几种设置方法。
</br>a、仅针对当前shell的
</br>b、针对用户的
</br>命令是 vi .bashrc
</br>set JAVA_HOME=/home/joypen/jdk1.5.0_22
</br>export JAVA_HOME
</br>set PATH=$JAVA_HOME/bin
</br>export PATH
</br>set CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
</br>export CLASSPATH
</br>c、针对所有人的
</br>命令是 vi /etc/profile
</br>JAVA_HOME=/home/joypen/jdk1.5.0_22
</br>PATH=$JAVA_HOME/bin
</br>CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
</br>export JAVA_HOME PATH CLASSPATH
</br>6、让设置生效
</br>#source /etc/profile
</br>7、再使用java -version查看
</br>[root@localhost joypen]# java -version
</br>java version &quot;1.5.0_22&quot;
</br>Java(TM) 2 Runtime Environment, Standard Edition (build 1.5.0_22-b03)
</br>Java HotSpot(TM) Client VM (build 1.5.0_22-b03, mixed mode, sharing)
</br>8、编写Test测试
</br>class Test{
</br> public static void main(String[] args){
</br> System.out.println(&quot;this is a test!&quot;);
</br> }
</br>}
</br>9、javac Test.java
</br>10、java Test
</br> this is a test!
</br>11、结束
</br>注：杯具的事情是，最后这样运行，影响了整个环境。
