title: nginx和tomcat的集成笔记
id: 189
categories:
  - web
date: 2011-03-31 01:06:28
tags:
---

nginx和tomcat的集成笔记
</br>在php下面，php+mysql+apche称之为黄金搭配，apache作为官方的web服务器，用户相当的多！
</br>在nginx出现之后，以绝对的高性能抢夺了大家的眼球，这些都是网络上说的。
</br>不过至少，有很多大型的网站都在用，比如新浪、搜狐、腾讯、豆瓣、人人等等等。
</br>我本来是打算采用php+nginx做为架构的，时间、能力不允许啊！
</br>还是回归自己的路了，tomcat当然是首选的服务器，数据库当然是mysql。
</br>这几个月，有些顺了，最近有些偏离轨迹，工作没做好，今天挨批了，认错。人啊！在顺一点的时候，真会忘乎所以的！受点打击是好事，能清醒不少！
</br>扯远了！还是继续原来的话题。
</br>我分别在win2008 和虚拟机ubuntu10.10上面搭建了nginx-0.9.6+tomcat-7.0.11的服务器，这样，还可以做负载均衡！
</br>win下面nginx-0.9.6+tomcat-7.0.11的搭建
</br>在http://nginx.org/en/download.html下载nginx，zip格式的是win平台的，tar.gz格式的是linux平台的
</br>解压之后，在DOS下面直接使用D:server
</br>ginx-0.9.6
</br>ginx.exe，就可以启动nginx，默认是80端口，打开http://localhost/ 就能看到nginx的欢迎界面！
</br>tomcat7依旧使用D:serverapache-tomcat-7.0.11instartup.bat启动，默认8080端口，打开http://localhost:8080/ 就能看到tomcat的欢迎界面！
</br>我的目的是能够实现就行，具体的一些细节配置信息，要根据时间的环境再配置。
</br>我的额配置如下：
</br>打开D:server
</br>ginx-0.9.6conf
</br>ginx.conf
</br>内容
</br>worker_processes &nbsp;1;
</br>events {
</br>worker_connections &nbsp;1024;
</br>}
</br>http {
</br>include &nbsp; &nbsp;mime.types;
</br>default_type &nbsp;application/octet-stream;
</br>sendfile &nbsp;on;
</br>keepalive_timeout &nbsp;65;
</br>upstream tomcat_server {
</br>server localhost:8080;
</br>}
</br>server {
</br>listen &nbsp; &nbsp;80;
</br>server_name &nbsp;localhost;
</br>location / {
</br>proxy_set_header Host $host;
</br>proxy_set_header X-Forwarded-For $remote_addr;
</br>proxy_pass http://tomcat_server;
</br>index &nbsp;index.html index.htm index.jsp;
</br>}
</br>error_page &nbsp; 500 502 503 504 &nbsp;/50x.html;
</br>location = /50x.html {
</br>root &nbsp; html;
</br>}
</br>}
</br>}
</br>完成，重启一下tomcat和nginx
</br>nginx的停止命令：
</br>D:server
</br>ginx-0.9.6
</br>ginx.exe -s stop
</br>再次打开http://localhost/ &nbsp;就打开的tomcat的欢迎页面了，http://localhost:8080/ &nbsp;也是可以访问的。
</br>ubuntu下面nginx-0.9.6+tomcat-7.0.11的搭建
</br>对了，我使用的jdk是1.6的版本，取当前最新版的稳定版本，安装jdk并且配置好环境变量，tomcat解压后，修改tomcat-7.0.11/bin/startup.sh的权限，简单就使用
</br>sudo chmod 777 *，其实这些shell脚本有可执行的权限就可以了。
</br>这时启动startup.sh，打开http://192.168.128.131:8080/ 就是tomcat的界面了，我的ubuntu的虚机ip是192.168.128.131，把防火墙关闭了。
</br>在linux下面安装软件就是麻烦，可能这就是证明是技术N人的方法吧！
</br>下载的linux下的nginx是二进制文件，需要编译，才能安装的，这样也稳定。
</br>解压nginx-0.9.6.tar.gz，进入nginx-0.9.6，开始编译
</br>sudo ./configure
</br>编译 很有可能出错，缺少依赖库，会有提醒的，根据提醒安装就行。
</br>我在ubutnu上面搭建了git服务器，现在只缺少g++，使用命令
</br>sudo apt-get install g++ &nbsp;就可以安装好了。
</br>我之前配置过apache，apache使用的也是80端口，和nginx冲突，看修改端口，我嫌麻烦，就直接卸载了。
</br>sudo apt-get remove apahce2
</br>卸载之后，可能会有一些遗留无用的，使用sudo apt-get autoremove 可以自动卸载
</br>还需要PCRE的支持，在 ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/ &nbsp;下载就可以，我用的是8.02的版本，其实最新版是8.12的，他们的排序有问题，这个能用就行了。
</br>PCRE也是二进制文件，需要编译安装。
</br>解压pcre-8.02.tar.gz &nbsp;进入pcre-8.02 &nbsp;快的话，可以用sudo ./configure &amp;&amp; make &amp;&amp; make install 一次搞定，我习惯一句一句执行，这样可以看看编译情况。
</br>PCRE好了之后，就开始编译nginx了，命令依旧可以用 sudo ./configure &amp;&amp; make &amp;&amp; make install
</br>使用sudo /usr/local/nginx/sbin/nginx 来启动nginx，打开http://192.168.128.131 就能看到nginx的欢迎页面。
</br>使用sudo /usr/local/nginx/sbin/nginx -s stop 来停止nginx。
</br>开始配置文件，我是把win下面的配置copy过来的。
</br>用sudo /usr/local/nginx/sbin -t &nbsp;可以验证配置文件是否正确
</br>用sudo /usr/local/nginx/sbin/nginx 启动nginx，就可以发现这个时候，这次打开是tomcat的欢迎界面了！
</br>今天的任务就算是完成了！
</br>还有一些遗憾是，因为安装的时候，nginx用的是root权限编译安装的，tomcat用的是普通管理员，最后不能把tomcat和nginx作为开机的自动启动项。应该是可以设置的，今天的目的已经完成，暂时就作为手动启动额吧！
</br>现在操作linux，我都是使用ssh来完成的，现在公司里面，登录ssh后都有一些欢迎信息，还把一些常用的命令、目录打印了出来，方便使用，我也把tomcat和nginx的命令整理了出来，修改的方法如下：
</br>1.编辑 vi /etc/issue.net
</br>2.vi /etc/ssh/sshd_config 找到 #Banner /some/path 并修改。去掉#号的注释，然后把路径指向 /etc/issue.net 这个文件。改为：Banner /etc/issue.net
</br>3.重启 sshd服务或者重启机器，就能看到欢迎信息了
</br>我的 /etc/issue.net 内容
</br>Welcome to dapeng.me
</br>tomcat7 /apps/tomcat-7.0.11/bin/startup.sh
</br>/apps/tomcat-7.0.11/bin/shutdown.sh
</br>nginx sudo /usr/local/nginx/sbin/nginx
</br>sudo /usr/local/nginx/sbin/nginx -s stop
</br>注意：在ubuntu下面执行脚本或者命令，在脚本或者命令前加sudo
</br>