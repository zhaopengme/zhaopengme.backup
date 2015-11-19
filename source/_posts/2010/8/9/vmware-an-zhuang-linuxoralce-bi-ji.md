title: vmware安装linux、oralce笔记
id: 238
categories:
  - web
date: 2010-08-09 12:59:21
tags:
---

　　<span>1</span>.vmware安装linux 笔记
</br>　　linux版本：Red Hat Enterprise Linux as<span>4</span>.<span>8</span>
</br>　　vmware<span>7</span>.<span>0</span>
</br>　　linux安装软件，全部选择
</br>　　语言：英语
</br>　　防火墙：打开ssh、ftp、web常用端口
</br>　　安装vmware tools，使用默认
</br>　　分配内容：<span>512M</span>
</br>　　分区： 总共<span>20G</span>
</br>　　<span>20G</span>分法
</br>　　<span>/</span>boot<span>200M</span>
</br>　　<span>/</span>swap<span>1G</span>
</br>　　<span>/</span>home<span>1G</span>
</br>　　linux安装完毕
</br>　　<span>2</span>.安装oracle10G
</br>　　在vmware下直接操作linux，分辨率看这很不舒服，我使用的是secureCRT，命令行进行操作的
</br>　　<span>2</span>.<span>1</span>创建oralce组和账户
</br>　　使用root用户可以直接使用
</br>　　<span>#groupadd oinstall</span>
</br>　　<span>#groupadd dba</span>
</br>　　<span>#useradd -m -g oinstall -G dba oracle</span>
</br>　　如果出现找不到命令的话，就使用<span>/</span>usr<span>/</span>sbin<span>/</span><span>+</span>命令来解决
</br>　　<span>2</span>.<span>2</span>创建安装目录
</br>　　<span>#mkdir -p /oracle/app</span>
</br>　　<span>#mkdir -p /oracle/data</span>
</br>　　<span>#chown -R oracle:oinstall /oracle/app /oracle/data</span>
</br>　　<span>#chmod -R 775 /oracle/app /oracle/data</span>
</br>　　<span>2</span>.<span>3</span>配置linux内容参数
</br>　　<span>#cat&gt;&gt;/etc/sysctl.conf&lt;&lt;EOF</span>
</br>　　kernel.shmall<span>=</span><span>2097152</span>
</br>　　kernel.shmmax<span>=</span><span>2147483648</span>
</br>　　kernel.shmmni<span>=</span><span>4096</span>
</br>　　kernel.sem<span>=</span><span>250</span><span>32000</span><span>100</span><span>128</span>
</br>　　fs.file<span>-</span>max<span>=</span><span>65536</span>
</br>　　net.ipv4.ip_local_port_range<span>=</span><span>1024</span><span>65000</span>
</br>　　EOF
</br>　　<span># /sbin/sysctl -p</span>
</br>　　<span>2</span>.<span>4</span> oracle 用户设置 Shell 限制
</br>　　<span>#cat &gt;&gt; /etc/security/limits.conf &lt;&lt;EOF</span>
</br>　　oracle soft nproc<span>2047</span>
</br>　　oracle hard nproc<span>16384</span>
</br>　　oracle soft nofile<span>1024</span>
</br>　　oracle hard nofile<span>65536</span>
</br>　　EOF
</br>　　<span>#cat &gt;&gt; /etc/pam.d/login &lt;&lt;EOF</span>
</br>　　session required<span>/</span>lib<span>/</span>security<span>/</span>pam_limits.so
</br>　　EOF
</br>　　<span>#cat &gt;&gt; /etc/profile &lt;&lt;EOF</span>
</br>　　<span>**if**</span> [ $USER<span>=</span><span>&quot;oracle&quot;</span> ];<span>**then**</span>
</br>　　<span>**if**</span> [ $SHELL<span>=</span><span>&quot;/bin/ksh&quot;</span> ];<span>**then**</span>
</br>　　ulimit<span>-</span>p<span>16384</span>
</br>　　ulimit<span>-</span>n<span>65536</span>
</br>　　<span>**else**</span>
</br>　　ulimit<span>-</span>u<span>16384</span><span>-</span>n<span>65536</span>
</br>　　<span>**fi**</span>
</br>　　umask<span>022</span>
</br>　　<span>**fi**</span>
</br>　　EOF
</br>　　<span>#cat &gt;&gt; /etc/csh.login &lt;&lt;EOF</span>
</br>　　<span>**if**</span> ( $USER<span>==</span><span>&quot;oracle&quot;</span> )<span>**then**</span>
</br>　　limit maxproc<span>16384</span>
</br>　　limit descriptors<span>65536</span>
</br>　　umask<span>022</span>
</br>　　endif
</br>　　EOF
</br>　　<span>2</span>.<span>5</span>配置oralce用户的环境变量
</br>　　仅仅是配置oracle的环境变量，就用oracle帐号登陆或者使用root命令使用
</br>　　刚才忘记设置oracle用户的秘密了
</br>　　使用root帐号执行
</br>　　<span>#passwd oracle</span>
</br>　　输入两次密码为oracle
</br>　　<span>#su - oracle</span>
</br>　　切换到oracle用户
</br>　　设置用户变量
</br>　　$vi<span>~</span><span>/</span>.bash_profile
</br>　　增加以下内容：
</br>　　ORACLE_BASE<span>=</span><span>/</span>oracle; export ORACLE_BASE
</br>　　ORACLE_HOME<span>=</span>$ORACLE_BASE<span>/</span>app<span>/</span>product<span>/</span><span>10</span>.<span>2</span>.<span>0</span><span>/</span>db_1; export ORACLE_HOME
</br>　　ORACLE_SID<span>=</span>orcl; export ORACLE_SID
</br>　　PATH<span>=</span>$PATH<span>:</span>$ORACLE_HOME<span>/</span>bin; export PATH
</br>　　注意：sid为oracl，必须与之后建立的sid名称一直，不然，就会创建两个sid，在系统中生效的此处的sid
</br>　　保存，用oracle帐号登陆，就生效了
</br>　　<span>2</span>.<span>6</span>安装oralce
</br>　　使用图形化的界面来安装，简单，点下一步就行。
</br>　　我本地系统和虚拟机做了共享，直接解压到本地安装
</br>　　$unzip<span>10201_database_linux32</span>.zip
</br>　　$ cd database<span>/</span>
</br>　　$ .<span>/</span>runInstaller
</br>　　有一大堆的检查什么的，通过了就可以安装了，出现的界面和windows一样的，之后的工作就是下一步的事情了。
</br>　　注意sid要和刚才一直，刚才用的是orcl，默认也就是orcl了。
</br>　　填入密码就行了
</br>　　<span>1</span>.安装过程中，出现了需specify inventory directory<span>and</span> creadentials的安装，按照提醒，默认安装就行。
</br>　　<span>/</span>oracle<span>/</span>oraInventory 会提醒没有权限，查看一下就行，建立了文件，付给oralce
</br>　　<span>#mkdir oracle/oraInventory</span>
</br>　　<span>#chown -R oracle:oinstall oracle/oraInventory</span>
</br>　　<span>2</span>.有时出现了一些什么错误，也不管了，我也没有搞明白，说是没有权限，我直接赋值为<span>777</span>，够大的权限了吧！还出现同样的错误，不管他了。忽略，忽略掉。
</br>　　<span>3</span>.安装完毕后，会有个让root用户执行的脚本，按照给出的路径执行脚本就行。
</br>　　至此，oracle安装成功了。
</br>　　<span>2</span>.<span>7</span>打开oracle数据库端口
</br>　　<span># vi /etc/sysconfig/iptables</span>
</br>　　加入
</br>　　<span>-</span>A RH<span>-</span>Firewall<span>-</span><span>1</span><span>-</span>INPUT<span>-</span>m state<span>--</span>state NEW<span>-</span>m tcp<span>-</span>p tcp<span>--</span>dport<span>1521</span><span>-</span>j ACCEPT
</br>　　<span>#service iptables restart</span>
</br>　　service iptables restart
</br>　　在windows下的cmd下可以测试连接
</br>　　sqlplus scott<span>/</span>scott@<span>192</span>.<span>168</span>.<span>23</span>.<span>131</span>
</br>　　<span>2</span>.<span>8</span>设置oracle自动启动
</br>　　oracle软件中有这样的说明，但我按照里面说明，没有成功。
</br>　　把我自己的设置文件拿出来了。
</br>　　新建一个文件
</br>　　<span>#vi /etc/init.d/dbora</span>
</br>　　<span>**case**</span><span>&quot;$1&quot;</span><span>**in**</span>
</br>　　start)
</br>　　su<span>-</span> oracle<span>-</span>c<span>&quot;dbstart&quot;</span>
</br>　　su<span>-</span> oracle<span>-</span>c<span>&quot;lsnrctl start&quot;</span>
</br>　　;;
</br>　　stop)
</br>　　su<span>-</span> oracle<span>-</span>c<span>&quot;lsnrctl stop&quot;</span>
</br>　　su<span>-</span> oracle<span>-</span>c<span>&quot;dbshut&quot;</span>
</br>　　;;
</br>　　<span>*</span>)
</br>　　<span>**exit**</span><span>1</span>
</br>　　<span>**esac**</span>
</br>　　保存之后
</br>　　<span># chgrp dba dbora</span>
</br>　　<span># chmod 750 dbora</span>
</br>　　<span># ln -s /etc/init.d/dbora /etc/rc.d/rc3.d/K01dbora</span>
</br>　　<span># ln -s /etc/init.d/dbora /etc/rc.d/rc3.d/S99dbora</span>
</br>　　<span># ln -s /etc/init.d/dbora /etc/rc.d/rc5.d/K01dbora</span>
</br>　　<span># ln -s /etc/init.d/dbora /etc/rc.d/rc5.d/S99dbora</span>
</br>　　okay！完了。。。
</br>　　reboot一下，就可以进行测试了。