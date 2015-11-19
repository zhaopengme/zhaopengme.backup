title: 全国省市信息数据以及模型
id: 151
categories:
  - 闲言碎语
date: 2011-11-17 00:08:06
tags:
---

全国省市信息数据以及模型两种不同的数据建模方式，各有优点！ORACLE数据库模型一，省市同一张表的，结构如下**REGION_ID****PROVINCE_NAME****REGION_CODE****REGION_EN_NAME****REGION_CN_NAME****REGION_GRADE****REGION_ORDER****PARENT_REGION_ID****REMARK****CREATE_TIME**201山东省201　滨州市2　16　　202山东省202　菏泽市2　16　　203河南省203　郑州市2　17　　204河南省204　开封市2　17　　&nbsp;create table REGION&nbsp;
</br>(
</br>&nbsp;&nbsp;REGION_ID NUMBER(6) not null,
</br>&nbsp;&nbsp;PROVINCE_NAME VARCHAR2(50),
</br>&nbsp;&nbsp;REGION_CODE VARCHAR2(10),
</br>&nbsp;&nbsp;REGION_EN_NAME VARCHAR2(25),
</br>&nbsp;&nbsp;REGION_CN_NAME VARCHAR2(50),
</br>&nbsp;&nbsp;REGION_GRADE NUMBER(1),
</br>&nbsp;&nbsp;REGION_ORDER NUMBER(3),
</br>&nbsp;&nbsp;PARENT_REGION_ID NUMBER(6),
</br>&nbsp;&nbsp;REMARK VARCHAR2(255),
</br>&nbsp;&nbsp;CREATE_TIME DATE
</br>)&nbsp;模型二，省市分两张表，结构如下**CID****CNAME****PID**40北京市141天津市242上海市343重庆市444石家庄市545唐山市5&nbsp;create table CITY&nbsp;
</br>(
</br>&nbsp;&nbsp;CID NUMBER,
</br>&nbsp;&nbsp;CNAME VARCHAR2(32),
</br>&nbsp;&nbsp;PID NUMBER
</br>)create table PROVINCE&nbsp;
</br>(
</br>&nbsp;&nbsp;PID NUMBER,
</br>&nbsp;&nbsp;PNAME VARCHAR2(32)
</br>)&nbsp;下载地址：[http://dl.dbank.com/c02i3dc2dk](http://dl.dbank.com/c02i3dc2dk)&nbsp;&nbsp;