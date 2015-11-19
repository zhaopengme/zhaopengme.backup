title: axis开发webservices
id: 418
categories:
  - java
date: 2009-05-25 23:48:43
tags:
---

对webservices蒙了一天，研究了使用axis来开发webservices的过程，做记录。
</br>我使用的工具：myeclipse7 , axis1.4, tomcat6
</br>1、新建一个web工程，把axis的jar复制到web工程的lib文件夹下面。
</br>2、新建一个java类，还是最简单。
</br><pre>package server;
public class SayHello {
	public String sayName() {
		return &quot;hello&quot;;
	}
}</pre>
</br>3、在web-info下面新建文件server-config.wsdd
</br>填充配置信息
</br><pre>
＜?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?＞
＜deployment name=&quot;defaultClientConfig&quot;
xmlns:java=&quot;http://xml.apache.org/axis/wsdd/providers/java&quot;
xmlns:handler=&quot;http://xml.apache.org/axis/wsdd/providers/handler&quot; xmlns=&quot;http://xml.apache.org/axis/wsdd/&quot;＞
  ＜globalConfiguration name=&quot;defaultClientConfig&quot;＞
    ＜requestFlow name=&quot;RequestFlow1&quot; type=&quot;&quot;＞
        ＜handler name=&quot;Handler1&quot; type=&quot;java:org.apache.axis.handlers.JWSHandler&quot;＞
          ＜parameter name=&quot;scope&quot; value=&quot;session&quot;/＞
        ＜/handler＞
        ＜handler name=&quot;Handler2&quot; type=&quot;java:org.apache.axis.handlers.JWSHandler&quot;＞
            ＜parameter name=&quot;scope&quot; value=&quot;request&quot;/＞
            ＜parameter name=&quot;extension&quot; value=&quot;.jwr&quot;/＞
        ＜/handler＞
      ＜/requestFlow＞
    ＜/globalConfiguration＞
    ＜handler name=&quot;URLMapper&quot; type=&quot;java:org.apache.axis.handlers.http.URLMapper&quot;/＞
    ＜handler name=&quot;LocalResponder&quot; type=&quot;java:org.apache.axis.transport.local.LocalResponder&quot;/＞
    ＜handler name=&quot;Authenticate&quot; type=&quot;java:org.apache.axis.handlers.SimpleAuthenticationHandler&quot;/＞
    ＜transport name=&quot;http&quot; type=&quot;&quot;＞
        ＜requestFlow name=&quot;RequestFlow1&quot; type=&quot;&quot;＞
        ＜handler name=&quot;Handler1&quot; type=&quot;URLMapper&quot;/＞
        ＜handler name=&quot;Handler2&quot; type=&quot;java:org.apache.axis.handlers.http.HTTPAuthHandler&quot;/＞
      ＜/requestFlow＞
    ＜/transport＞
    ＜transport name=&quot;local&quot; type=&quot;&quot;＞
        ＜responseFlow name=&quot;ResponseFlow1&quot; type=&quot;&quot;＞
            ＜handler name=&quot;Handler1&quot; type=&quot;LocalResponder&quot;/＞
        ＜/responseFlow＞
    ＜/transport＞
  ＜!--这里配置了一个Web Service，如果有多个Web Service，就按这种格式在下面增加即可--＞
	＜service name=&quot;SayHello&quot; provider=&quot;java:RPC&quot;＞
		＜parameter name=&quot;allowedMethods&quot; value=&quot;*&quot; /＞
		＜parameter name=&quot;className&quot; value=&quot;server.SayHello&quot; /＞
	＜/service＞
＜/deployment＞
</pre>
</br>4、此时打开http://localhost:8080/test/services，会出现
</br>And now... Some Services
</br>SayHello (wsdl)
</br>sayName
</br>SayHello (wsdl) 是可以点击的。
</br>5、使用axis的工具WSDL2Java来制作客户端，在dos窗口下进入web-info文件夹，输入命令：
</br>Java -Djava.ext.dirs=lib org.apache.axis.wsdl.WSDL2Java http://localhost:8080/test/services/SayHello?wsdl
</br>就会得到四个客户端的java文件了！
</br>6、测试文件
</br><pre>
package localhost.test.services.SayHello;
import java.net.MalformedURLException;
import java.net.URL;
import java.rmi.RemoteException;
import javax.xml.rpc.ServiceException;
public class TestSayHello {
	public static void main(String[] args) throws MalformedURLException, ServiceException, RemoteException {
		SayHelloServiceLocator locator = new SayHelloServiceLocator();
		URL wddlUrl = new URL(&quot;http://localhost:8080/test/services/SayHello?wsdl&quot;);
		SayHello say = locator.getSayHello(wddlUrl);
		System.out.print(say.sayName());
	}
}
</pre>
</br>这样就能在控制台看到hello了！
</br>做的是一个非常简单的例子，步骤也没有过多的介绍，只为做个记录！
</br>提供一个完整的下载地址：
</br>[webservicesTest.rar](http://cid-099fd6acbff5c9ab.skydrive.live.com/embedrowdetail.aspx/javaProject/webservicestest.rar)