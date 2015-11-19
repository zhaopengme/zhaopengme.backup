title: xml和字符串的转换
id: 392
categories:
  - 闲言碎语
date: 2009-07-06 18:18:54
tags:
---

<pre>
// 字符串转XML
String xmlStr = &quot;&quot;;
StringReader sr = new StringReader(xmlStr);
InputSource is = new InputSource(sr);
DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
DocumentBuilder builder=factory.newDocumentBuilder();
Document doc = builder.parse(is);
//XML转字符串
TransformerFactory tf = TransformerFactory.newInstance();
Transformer t = tf.newTransformer();
t.setOutputProperty(&quot;encoding&quot;,&quot;utf-8&quot;);
ByteArrayOutputStream bos = new ByteArrayOutputStream();
t.transform(new DOMSource(doc), new StreamResult(bos));
String xmlStr = bos.toString();
</pre>