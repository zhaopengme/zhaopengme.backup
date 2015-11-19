title: 【版本管理】windows上搭建git+apache服务器 1
id: 124
categories:
  - 软件工具
date: 2012-02-13 12:43:12
tags:
---

git服务器最大的特点是分布式版本控制，而且更为强大的是合并功能，这点也是常用的。就抛弃svn了。在windows上面搭建svn很容易，下次再说。

在windows上面搭建git版本服务器，常用msysGit +Cygwin来搭建，曾经用此种方法搭建过一次，繁琐的很，这次用git+apache来搭建，搭建很容易的。

准备软件

[msysgit](http://msysgit.googlecode.com/files/Git-1.7.9-preview20120201.exe)&nbsp;[http://code.google.com/p/msysgit/downloads/list](http://code.google.com/p/msysgit/downloads/list "http://code.google.com/p/msysgit/downloads/list")

[apache server](http://apache.etoak.com//httpd/binaries/win32/httpd-2.2.22-win32-x86-openssl-0.9.8t.msi)[http://httpd.apache.org/download.cgi](http://httpd.apache.org/download.cgi "http://httpd.apache.org/download.cgi")&nbsp;&nbsp;&nbsp;&nbsp; 下载包含OpenSSL的版本

tortoisegit&nbsp; [http://code.google.com/p/tortoisegit/downloads/list](http://code.google.com/p/tortoisegit/downloads/list "http://code.google.com/p/tortoisegit/downloads/list")&nbsp; 和tortoisesvn一样的客户端工具，操作方便，推荐使用

操作步骤

1.安装msysGit 

&nbsp;&nbsp;&nbsp; 我安装在D:serverGit 
</br>&nbsp;&nbsp;&nbsp; 注：图中请选择**Run git from the Windows Command prompt**

&nbsp;&nbsp;&nbsp; ![](http://m2.img.libdd.com/farm4/2012/0821/18/2205114A5FD9DD7C8AF1E5FDF1294EF812658D5EF698_363_277.JPEG)</img>

2.复制dll文件

&nbsp;&nbsp;&nbsp; 在git中的D:serverGitlibexecgit-coregit-http-backend.exe是用来处理HTTP 请求的，直接运行会出现错误。

![](http://m2.img.libdd.com/farm4/2012/0821/18/09B649EE072D0F50F486E5B57D0D1AE95411E805049E_499_101.JPEG)</img>

&nbsp;&nbsp;&nbsp; 缺少libiconv-2.dll，libiconv-2.dll位于D:serverGitbinlibiconv-2.dll，将D:serverGitbinlibiconv-2.dll复制到D:serverGitlibexecgit-core，再次运行git-http-backend.exe就不会出现错误。

&nbsp;&nbsp;&nbsp; git分就算是完成了。

3.安装apache服务器

&nbsp;&nbsp;&nbsp; 我安装在D:serverApache2.2，正常完成后，apache会自动启动，并且占用80端口，打开浏览器，进入[http://localhost](http://localhost) ，如果出现“It works!”，就说明apache服务器安装成功了。

4.配置用户帐号

&nbsp;&nbsp;&nbsp; 使用命令提示符进入D:serverApache2.2bin目录，输入命令：
<pre>htpasswd -cmb htpassword dapeng dapeng</pre>
</br>
</br>

&nbsp;&nbsp;&nbsp; 执行成功后，就会在当前目录下生成htpassword 文件，内容如下，用户名 ：dapeng&nbsp; 密码：dapeng，密码是加密过的。

</br>
</br><pre>dapeng:$apr1$uF7Kv.a9$iHcUdyOeGA7GnWWWjkd3T/</pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 复制htpassword到D:GitRepos，D:GitRepos是作为版本库的地方。
</br>
</br>5.配置Apache服务器
</br>&nbsp;&nbsp;&nbsp; 进入D:serverApache2.2conf，用文本编辑器打开httpd.conf，找到 &lt;directory /&gt;，修改如下：
</br>
</br><pre>&lt;directory /&gt;
Options FollowSymLinks
AllowOverride None
Order deny,allow
Allow from all
&lt;/directory&gt;</pre>
</br>
</br>然后在 httpd.conf 文件末尾追加：
</br>
</br>
</br><pre><span># Set this to the root folder containing your Git repositories.</span><span># 指定 Git 版本库的位置</span>
SetEnv GIT_PROJECT_ROOT C:/workspace
<span># Set this to export all projects by default (by default,</span><span># git will only publish those repositories that contain a</span><span># file named “git-daemon-export-ok”</span><span># 该目录下的所有版本库都可以透过 HTTP(S)</span> 的方式存取
SetEnv GIT_HTTP_EXPORT_ALL
<span># Route specific URLS matching this regular expression to the git http server.</span><span># 令 Apache 把 Git 相关 URL 导向给 Git 的 http 处理程序</span>
ScriptAliasMatch
&quot;(<span>?</span>x)<span>^</span>/(<span>.</span><span>*</span>/(HEAD |
info/refs |
objects/(info/[<span>^</span>/]+ |
[0-9a-f]{2}/[0-9a-f]{38} |
pack/pack-[0-9a-f]{40}<span>.</span>(pack|idx)) |
git-(upload|receive)-pack))<span>$</span>&quot;
&quot;D:/server/Git/libexec/git-core/git-http-backend<span>.</span>exe/<span>$</span>1&quot;

<span>&lt;</span>Location /<span>&gt;</span>
AuthType Basic
AuthName &quot;GIT Repository&quot;
AuthUserFile &quot;D:/GitRepos/htpasswd&quot;
Require valid-user
<span>&lt;</span>/Location<span>&gt;</span></pre>
</br>
</br>

上面修改内容中，第一个指令设置 Git 的版本库位置；第二个指令表示，该目录下的所有版本库都可以通过 HTTP(S) 的方式存取；第三个指令则是让 Apache 把 Git 相关 URL 导向给 Git 的 HTTP 处理程序，也就是我们前面提到的 git-http-backend.exe。最后的 &lt;Location /&gt; 区段设定了虚拟根路径 &quot;/&quot; 的验证规则；D:/GitRepos/htpasswd 是账号密码文件，该文件可以在任何位置，也可以使任何名字，只要在这里指定即可。

</br>

在httpd.conf大概46行，配置Apache的端口，默认是80，我修改为801

</br>

完成上述修改之后，重启 Apache 服务。

</br>

如果你希望将来透过远端存取版本库时，一律使用 [http://my-server/git/*](http://my-server/git/*) 开头的 URL，则可将 ScriptAliasMatch 指令改为 &quot;(?x)^/git/(.*/(HEAD |  …….&quot;

</br> 6.初始化版本库
</br> &nbsp;&nbsp;&nbsp; 打开命令提示符，进入D:GitRepos
</br> &nbsp;&nbsp;&nbsp;
</br>
</br><pre>mkdir demo<span>.</span>git
cd demo<span>.</span>git
git init --bare
git update-server-info</pre>
</br>
</br>
</br> 这样就完成了一个空白的版本库的初始化了。
</br> 7.测试
</br> &nbsp;&nbsp;&nbsp; 在windows上面直接使用tortoisegit，不使用git命令了。
</br> &nbsp;&nbsp;&nbsp; 安装tortoisegit，我用的win7 64位，安装tortoisegit 64位的版本后，就开始测试吧！
</br> &nbsp;&nbsp;&nbsp; 在d:wordspace文件夹中点击右键，选择git clone，相当于就svn checkout
</br>
</br>&nbsp;&nbsp;&nbsp; 在Url中输入[http://localhost:801/demo.git](http://localhost:801/demo.git "http://localhost:801/demo.git")
</br> &nbsp;
</br>![](http://m2.img.libdd.com/farm4/2012/0821/18/E01D1B2143C89E4135250275AC1D27289A33F45EF698_393_296.JPEG)</img>
</br>
</br>输入用户名和密码
</br>

![](http://m3.img.libdd.com/farm5/2012/0821/18/5585CDD702BCFE469F7A356A889B9140088E495EF698_390_255.JPEG)</img>

</br>

clone成功

</br>

![](http://m1.img.libdd.com/farm4/2012/0821/18/97405244D1E72A021C7A5513F7C3B3B7652D2A5EF698_403_267.JPEG)</img>

</br>

在demo文件夹中，增加demo.txt文件，使用tortoisegit的add命令，

</br>

![](http://m2.img.libdd.com/farm5/2012/0821/18/39A54985647329B463AE7DF48F8020C0ADE83A05049E_405_201.JPEG)</img>

</br>

紧接着可以选择commit，提交到本地版本库中，

</br>

![](http://m3.img.libdd.com/farm5/2012/0821/18/B4B90A038A9052FBB62A1671314E873200712D05049E_390_134.JPEG)</img>

</br>

设置提交人员的信息

</br>

![](http://m2.img.libdd.com/farm4/2012/0821/18/DD44FA1B5E9EF1469F783A2CA308B1EC3AE6625EF698_379_235.JPEG)</img>

</br>

填写版本注释

</br>

![](http://m1.img.libdd.com/farm5/2012/0821/18/938FA6F2E7D2360B24E8AB8F489758E9CF2F4A5EF698_324_359.JPEG)</img>

</br>

这样就提交到本地的版本库了

</br>

![](http://m3.img.libdd.com/farm4/2012/0821/18/5E26E936B957E112F6B3EAE2736136204503D25EF698_340_227.JPEG)</img>

</br>

紧接着还可以选择PUSH,提交到git服务器的版本库

</br>

选择Push all branches，将本地所有分支都提交主干

</br>

![](http://m2.img.libdd.com/farm4/2012/0821/18/AA40C3455A9CB98DF6EC9D384A4A23A5C03E7E5EF698_332_285.JPEG)</img>

</br>

ok，这样就完成了。

</br>

![](http://m1.img.libdd.com/farm4/2012/0821/18/8C06E86BB5D1DFB1076995203661B5C876406A5EF698_352_235.JPEG)</img>