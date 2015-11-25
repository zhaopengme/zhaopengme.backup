title: expdp使用记录
id: 125
categories: 闲言碎语
date: 2012-02-08 18:03:31
tags:
---

工作中需要进行数据迁移，使用expdp做的，做个记录。

expdp是oracle10g中提出来的，比exp的速度高的不是一般，这个是体验过的。和DBA在做数据迁移的时候，开始用的exp，超过半个小时后，我们就忍受不了了，太慢了，就改成了expdb，4分钟，8个G，速度不错吧！

看下我们使用 脚本
<pre><span>   1:</span> expdp dbusername/dbpassword dumpfile=dmpfilename.dmpdirectory=DMPDIRECTORY tables=tablename:partname exclude=index;</pre>
</br>
</br>
</br>&nbsp;
</br>

分析一下

</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br> expdp<span>&nbsp;</span>
</br> 导出命令 dbusername/dbpassword 数据库用户名和密码（注：要有执行expdp命令的权利） dumpfile=dmpfilename.dmp
</br>
</br> 导出的数据文件 logfile=dmpfilelog.log 导出时的日志文件 directory=DMPDIRECTORY 数据文件的保存位置(需要提前创建) tables=tablename:partname 按表分区导出，tablename是表名，partname是分区名 exclude=index 不导出索引
</br>

详细介绍下expdp

</br>

1\. 执行expdp之前必须创建directory对象，并且分配权限，如：

</br>
</br>
</br><pre><span>   </span><span>connect</span> system/<span>admin</span></pre>
</br>
</br><pre><span>   </span><span>create</span><span>or</span> replace directory expdir <span>as</span><span>'e:dmpfile'</span>;</pre>
</br>
</br><pre><span>   </span><span>grant</span><span>read</span>,<span>write</span><span>on</span> directory expdir <span>to</span><span>public</span>;</pre>
</br>
</br>
</br>

2\. 常见用法：(我这里直接用命令行的方式，还有使用配置文件的方式)

</br>

2.1 导出scott整个schema

</br>
</br>
</br><pre><span>   </span>expdp system/<span>admin</span>@dapengdb DIRECTORY=expdir DUMPFILE=scott_full.dmp LOGFILE=scott_full.log SCHEMAS=SCOTT</pre>
</br>
</br>
</br>

配置文件的方式

</br>
</br>
</br><pre><span>   </span>expdp system/<span>admin</span>@dapengdb parfile=c:exp.par </pre>
</br>
</br>
</br>

exp.par内容：

</br>
</br>
</br><pre><span>   </span>DIRECTORY=expdir</pre>
</br>
</br><pre><span>   </span>DUMPFILE=scott_full.dmp</pre>
</br>
</br><pre><span>   </span>LOGFILE=scott_full.log</pre>
</br>
</br><pre><span>   </span>SCHEMAS=SCOTT</pre>
</br>
</br>
</br>

2.2 导出scott下的dept，emp表

</br>
</br>
</br><pre><span>   </span>expdp scott/tiger@dapengdb DIRECTORY=expdir DUMPFILE=scott.dmp LOGFILE=scott.log TABLES=DEPT,EMP</pre>
</br>
</br>
</br>

2.4 导出scott下的存储过程

</br>
</br>
</br><pre><span>   </span>expdp scott/tiger@bright DIRECTORY=expdir DUMPFILE=scott.dmp LOGFILE=scott.log <span>INCLUDE</span>=PROCEDURE</pre>
</br>
</br>
</br>

2.5 导出scott下以'E'开头的表

</br>
</br><pre>expdp scott/tiger@bright DIRECTORY=expdir DUMPFILE=scott.dmp LOGFILE=scott.log <span>INCLUDE</span>=<span>TABLE</span>:&quot;<span>LIKE</span><span>'E%'</span>&quot;   –可以改成　<span>NOT</span><span>LIKE</span>,就导出不以E开头的表</pre>
</br>
</br>
</br>2.6 带QUERY导出
</br>
</br><pre>expdp scott/tiger@bright DIRECTORY=expdir DUMPFILE=scott.dmp LOGFILE=scott.log TABLES=EMP,DEPT QUERY=EMP:&quot;<span>where</span> empno &gt;=8000″ QUERY=DEPT:&quot;<span>where</span> deptno &gt;=10 <span>and</span> deptno &lt;=40″</pre>
</br>
</br>
</br>注：处理这样带查询的多表导出，如果多表之间有外健关联，可能需要注意查询条件所筛选的数据是否符合这样的外健约束，比如：EMP中有一栏位是deptno，是关联dept中的主键，如果”where empno &gt;=8000″中得出的deptno=50的话，那么，你的dept的条件”where deptno &gt;=10 and deptno &lt;=40″就不包含deptno=50的数据，那么在导入的时候就会出现错误！
</br>&nbsp;
</br>摘抄网址：[http://www.dbifan.com/200802/common-usage-of-expdp.html](http://www.dbifan.com/200802/common-usage-of-expdp.html "http://www.dbifan.com/200802/common-usage-of-expdp.html")
</br>原文采用配置文件的方式。
</br>
</br>
