title: Oracle11.2.0非安装版(简装版)
id: 108
categories: 软件工具
date: 2012-03-12 13:19:39
tags:
---

推荐给oracle11的简装版给开发测试人员，不用去装那么几百兆大的原版了。

&nbsp;

作者: iihero@CSDN, 2012.3.11\. 请尊重个人劳动。如若转载，请注明原始出处。Thanks.
</br>下载地址:
</br>[http://download.csdn.net/detail/iihero/4131001](http://download.csdn.net/detail/iihero/4131001)
</br>(免责声明):
</br>这是一个精简版的oracle11g for windows 32bit x86平台.
</br>此压缩包，仅供学习研究使用，本文作者不负任何责任。适合于开发人员使用。切不可将其用于商业用途，请遵守
</br>Oracle公司相关商业规定。如因私自将其用于商业用途，由此带来的法律纠纷或其它问题，概与本人无关.
</br>author: iihero@CSDN&nbsp; (iiihero AT hotmail.com;&nbsp; iihero AT qq.com)
</br>0\. 如果你已经安装了别的版本的oracle，
</br>请自行备份注册表:[HKEY_LOCAL_MACHINE/SOFTWARE/ORACLE], 这样即算有冲突，
</br>你也可以重新导入以前的注册项而得已恢复
</br>1\. 将压缩包解压至目录，设该目录值为: d:,
</br>其下将有目录：
</br>&lt;D&gt;/oracle/*
</br>&lt;D&gt;/oracle/11.2.0

</br>2\. 新的ORACLE_HOME将为：&lt;D&gt;/oracle/11.2.0
</br>运行完iihero.ora11g.bat运行完以后，(一个批处理一次安装全部完成)
</br>你需要将&lt;D&gt;/oracle/11.2.0/BIN添加到path里头
</br>缺省的ORACLE_SID为iihero，你可以自行修改iihero.ora11g.bat中的SID值，不要超过8个字符。

</br>3\. 安装完以后，别忘了添加环境变量ORACLE_SID=iihero以及将%ORACLE_HOME%/bin
</br>添加到PATH环境变量里头，在这之后，
</br>即可使用sqlplus system/manager进入并修改密码，执行表空间、用户管理相关操作。
</br>如：
<pre><span>   1:</span> [sql] view plaincopy</pre>
</br>
</br><pre><span>   2:</span> D:Oracle&gt;<span>;sqlplus system/manager  </span></pre>
</br>
</br><pre><span>   3:</span></pre>
</br>
</br><pre><span>   4:</span> SQL*Plus: Release 11.2.0.1.0 Production on 星期日 3月 11 13:14:35 2012  </pre>
</br>
</br><pre><span>   5:</span></pre>
</br>
</br><pre><span>   6:</span> Copyright (c) 1982, 2010, Oracle.  All rights reserved.  </pre>
</br>
</br><pre><span>   7:</span></pre>
</br>
</br><pre><span>   8:</span></pre>
</br>
</br><pre><span>   9:</span> 连接到:  </pre>
</br>
</br><pre><span>  10:</span> Oracle Database 11g Enterprise Edition Release 11.2.0.1.0 - Production  </pre>
</br>
</br><pre><span>  11:</span><span>With</span> the Partitioning, OLAP, Data Mining and Real Application Testing options  </pre>
</br>
</br><pre><span>  12:</span></pre>
</br>
</br><pre><span>  13:</span> SQL&gt;<span>; quit  </span></pre>
</br>
</br><pre><span>  14:</span> 从 Oracle Database 11g Enterprise Edition Release 11.2.0.1.0 - Production  </pre>
</br>
</br><pre><span>  15:</span><span>With</span> the Partitioning, OLAP, Data Mining and Real Application T</pre>
</br>
</br>
</br>

esting options 断开&nbsp;
</br>欢迎大家试用，如果发现有什么问题，可以与本人联系。
</br>
</br>这个11g的包，既可充当server，同时也可以用作oci, jdbc,sqlplus,odbc等的客户端工具。还是比较齐全的。
</br>
</br>11g比10g的非安装包，确实大了不少。10g的时候，总共才50M不到，这不，到了11g，压缩完以后，也有100来兆。不过，不管怎样，比原始的安装包，那可是小了很多了。

</br>

作者地址：[http://iihero.iteye.com/blog/1450186](http://iihero.iteye.com/blog/1450186)
