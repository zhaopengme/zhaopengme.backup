title: jsp页面遍历List
id: 157
categories:
  - java
date: 2011-11-15 00:48:47
tags:
---

jsp页面遍历List&lt;c:forEach var=&quot;person&quot; items=&quot;${personList}&quot; varStatus=&quot;status&quot;&gt;&nbsp;
</br>&nbsp;&nbsp;&nbsp;&nbsp;index:${status.index}&nbsp;&nbsp;name:${person.name} &lt;br /&gt;
</br>&lt;/c:forEach&gt;