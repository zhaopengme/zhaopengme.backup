title: 简单的dom4j和xpth的使用
id: 453
categories:
  - java
date: 2009-05-08 03:53:00
tags:
---

公司项目要解析xml文件，很简单的，也就需要一点点信息，用的是java本身的解析方式，很麻烦。我做了一个DEMO，使用了dom4j中的xpath，简单，想去哪里的信息就去哪里的信息，简单灵活。
</br>
</br><pre>
package com.inspur.eoms.pbb.open;</pre>
</br>
</br>import java.io.UnsupportedEncodingException;
</br>import java.util.List;
</br>
</br>import org.dom4j.Document;
</br>import org.dom4j.DocumentException;
</br>import org.dom4j.DocumentHelper;
</br>import org.dom4j.Element;
</br>import org.dom4j.Node;
</br>
</br>public class TestMain {
</br>
</br>public static void main(String[] args) throws UnsupportedEncodingException,
</br>DocumentException {
</br>StringBuffer sb1 = new StringBuffer();
</br>sb1.append(&quot;
</br>&quot;);
</br>sb1.append(&quot;0
</br>&quot;);
</br>sb1.append(&quot;失败原因
</br>&quot;);
</br>sb1.append(&quot;
</br>&quot;);
</br>sb1.append(&quot;
</br>&quot;);
</br>sb1.append(&quot;接入设备ID
</br>&quot;);
</br>sb1.append(&quot;接入设备类型
</br>&quot;);
</br>sb1.append(&quot;预占端口ID
</br>&quot;);
</br>sb1.append(&quot;预占端口名称
</br>&quot;);
</br>sb1.append(&quot;
</br>&quot;);
</br>sb1.append(&quot;
</br>&quot;);
</br>sb1.append(&quot;
</br>&quot;);
</br>
</br>Document doc = DocumentHelper.parseText(sb1.toString());
</br>
</br>List list = doc.selectNodes(&quot;/RESPONSE/RESULTS/RESULT/NAME&quot;);
</br>Element elm = (Element) list.get(0);
</br>System.out.println(elm.getText());
</br>
</br>list = doc.selectNodes(&quot;/RESPONSE/DESCRIPTION&quot;);
</br>elm = (Element) list.get(0);
</br>System.out.println(elm.getText());
</br>
</br>list = doc.selectNodes(&quot;/RESPONSE/RESULTS/RESULT&quot;);
</br>Node node = (Node) list.get(0);
</br>System.out.print(node.valueOf(&quot;@TYPE&quot;));
</br>
</br>}
</br>}
</br><pre></pre>
</br>dom4j需要的jar包的地址
</br>[http://www.box.net/shared/axb0oesgsu](http://www.box.net/shared/axb0oesgsu)