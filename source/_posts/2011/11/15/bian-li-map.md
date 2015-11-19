title: 遍历MAP
id: 158
categories:
  - java
date: 2011-11-15 00:46:23
tags:
---

<span><span></span><span><span></span>jsp页面遍历map</span></span>&lt;c:forEach var=&quot;person&quot; items=&quot;${personMap}&quot; varStatus=&quot;status&quot; &gt;&nbsp;
</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;index:${status.index } Name:${person.value.name&nbsp;&nbsp;&lt;br /&gt;
</br>&lt;/c:forEach&gt;