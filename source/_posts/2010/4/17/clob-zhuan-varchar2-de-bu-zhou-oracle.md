title: 'clob转varchar2的步骤[oracle]'
id: 258
categories:
  - 闲言碎语
date: 2010-04-17 19:08:02
tags:
---

clob转varchar2分四步
</br>1、加-添加一个varchar2类型的字段
</br> alter table formfeedback_bak2 add xml varchar2(4000);
</br>2、截-将clob的内容截取插入的新添加的varcha2的字段中
</br> update formfeedback_bak2 set xml=dbms_lob.substr(XMLCONTENT,4000);
</br>3、删-删除clob类型的字段
</br> alter table formfeedback_bak2 drop column XMLCONTENT;
</br>4、改-将varchar2类型的字段名字改为clob类型的名字
</br> alter table formfeedback_bak2 rename column xml to XMLCONTENT;