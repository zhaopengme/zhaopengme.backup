title: Oracle 的dblink分析使用
id: 165
categories: 闲言碎语
date: 2011-09-22 00:58:13
tags:
---

　　数据库中的dblink是个好东西，可以很容易实现跨库的读取。
</br>　　在公司内部的各个系统之间，常常的要跨库读取数据，我们就建立了dblink。
</br>　　1.dblink的建立有两种方式
</br>　　a、在本地tnsnames.ora配置了主机服务
</br>　　语法：
</br>　　create public database
</br>　　link dapeng_link connect to dapeng
</br>　　identified by dapeng using 'dapengdb'
</br>　　CREATE DATABASE LINK数据库链接名CONNECT TO 用户名 IDENTIFIED BY 密码 USING '本地配置的数据的实例名'
</br>　　b、未在本地主机配置的
</br>　　语法：
</br>　　create database link dapeng_link
</br>　　connect to dapeng identified by dapeng
</br>　　using
</br>　　'(DESCRIPTION =
</br>　　(ADDRESS_LIST =
</br>　　(ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.128.129)(PORT = 1521))
</br>　　)
</br>　　(CONNECT_DATA =
</br>　　(SERVICE_NAME = dapengdb)
</br>　　)
</br>　　)'
</br>　　第二种其实也就是把tnsnames.ora中数据库的配置放进了建立dblink的过程中
</br>　　2.dblink的使用
</br>　　语法：
</br>　　select * from t_test@dapeng_link;
</br>　　操作和查询本地表的方式是一样的
</br>　　3.dblink使用注意
</br>　　在PL/SQL Developer的sql窗口执行带dblink的查询，会发现提交按钮和回滚按钮是高亮的，这个是由于dblink的查询会带一个事务，而且是一个distributed transaction（分布式事务），所以尽量的避免大量的使用dblink。
</br>　　使用dblink会占用远程数据库的session，本地的session没有释放掉或者出现异常信息，就会导致远程数据库的session大量占用。
</br>　　对于使用dblink之后，可以显示的用alter session close database dapeng_link来关闭手动的关闭远程数据库的session连接，但不能执行commit，否则会出现ORA-02080错误或者其他错误。
