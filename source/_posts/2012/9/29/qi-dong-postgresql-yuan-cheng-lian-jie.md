title: 启动PostgreSql远程连接
id: 70
categories: 软件工具
date: 2012-09-29 12:40:05
tags:
---

启动PostgreSql远程连接
</br> PostgreSql安装后，默认是不允许远程连接的，需要进行一些配置。配置有两种办法，一种是界面配置，另外一种通过修改文件（界面配置也就是修改文件的）。
</br>**界面配置方法：**
</br> 打开pgAdmin，工具-服务器配置。
</br>![](http://m2.img.libdd.com/farm4/2012/0929/12/ABFB4C3DD3C373C7F3C17BE174ED0E96DDE79705049E_426_211.JPEG)</img>
</br> 1.配置postgresql.conf
</br>![](http://m2.img.libdd.com/farm5/2012/0929/12/9CB8EDFD36C772917901B227AF79B87EBC17AB05049E_497_212.JPEG)</img>
</br> 2.配置pg_hba.conf
</br>![](http://m1.img.libdd.com/farm4/2012/0929/12/D9A5EF6190975F9E02C29E882E0124AE0F3E3D8D7D8E_500_228.jpg)</img>
</br>**修改文件方法：**
</br>
> 1.修改PostgreSQL9.2datapostgresql.conf，将listen_addresses的值修改为'*',监听所有IP。如下：
> > listen_addresses = '*'
> > </br>
>
> 2.修改PostgreSQL9.2datapg_hba.conf，将注释着IPV4的127.0.0.1修改数据库服务器IP，如下：
> > # TYPE DATABASE USER ADDRESS METHOD #IPv4 local connections: host all all 192.168.1.20/24 md5
> > </br>

注：
> 24对应服务器网关为255.255.255.0 32对应服务器网关为255.255.255.255 配置完成后，重启PostgreSQL服务。
> </br>

#### 关于pg_hba.conf中的几个参数说明：

# TYPE DATABASE USER CIDR-ADDRESS METHOD
</br> # IPv4 local connections:
</br> host all all 127.0.0.1/32 md5
</br> 这里面的字段的含义是：连接类型、可用数据库名、使用者、DIDR地址、验证方法
</br> 一、TYPE
</br>
> 可选择local或者host，分别区分只能本地，与可远程

二、DATABASE
</br>
> all或者具体数据库的名字

三、USER
</br>
> all或者指定用户的名字

四、DIDR－ADDRESS
</br>
> 这个是指地址与掩码，指示一个IP或者IP网段，格式 IP/掩码。掩使用小于等于32的正数来表示。
> </br> 掩码24，表示255.255.255.0 说明高24位是1.
> </br> 掩码32，表示255.255.255.255,说明高32位是1.即这个掩码只表示当前一个IP地址。
> </br> 所以直接使用32来表示一个指定的IP。
> </br>

五、METHOD
</br>
> 验证方法可以选择以下几个：
> </br> reject ：拒绝访问
> </br> md5 ：以MD5作为hash编码
> </br> password ：密码作为明文传输
> </br> krb5 ：密码以krb5作为hash编码
> </br> trust ：可信任的
