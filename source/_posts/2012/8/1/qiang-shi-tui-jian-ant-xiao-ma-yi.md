title: 强势推荐ANT小蚂蚁
id: 83
categories: java
date: 2012-08-01 23:55:53
tags:
---

之前就知道ANT这个小蚂蚁，一直没有用过，这两天，下了点功夫，写了一个ANT的脚本。功能还行，可以完成同步svn代码、编译代码、打包代码、上传、部署的功能。
</br>直接上干货，看代码。
</br>[code]
</br>#JDK home
</br>jdk.home=/opt/Java/jdk1.6.0_33
</br>#webapp name
</br>webapp.name=pmeapp
</br>project.name=pmeapp
</br>#svn
</br>svn.url=http://127.0.0.1:9344/svn/pmeapp/trunk
</br>svn.uname=dapeng
</br>svn.pwd=dapengpwd
</br>#war
</br>war.exclude=
</br>war.exclude.classes=
</br>#ftp
</br>ftp.server=127.0.0.1
</br>ftp.password=dapengpwd
</br>ftp.userid=dapeng
</br>ftp.path=/opt/ftp/
</br>#ssh
</br>ssh.host=127.0.0.1
</br>ssh.path=/opt/tomcat6/webapps
</br>ssh.pwd=dapengpwd
</br>ssh.uname=dapeng
</br>#ssh
</br>ssh.path.webapp=/opt/tomcat6/webapps
</br>ssh.server.bin=/opt/tomcat6/bin
</br>ssh.cmd.sshClean=rm -rf /opt/tomcat6/webapps/${webapp.name}/
</br>ssh.server.start=/opt/tomcat6/bin/startup.sh
</br>ssh.server.stop=/opt/tomcat6/bin/shutdown.sh
</br>[/code]
</br>另外一个是关键中的核心
</br>[sourcecode]
</br>&lt;project basedir='.' default='usage' name='${project.name}'&gt;
</br> &lt;!-- =================================================================== --&gt;
</br> &lt;!-- 下句是import进ant属性配置文件，properties文件里存放基本的配置变量. --&gt;
</br> &lt;!-- 该变量可以在build.xml中直接引用. --&gt;
</br> &lt;!-- =================================================================== --&gt;
</br> &lt;property file='ant.properties'/&gt;
</br> &lt;!-- =================================================================== --&gt;
</br> &lt;!-- 以下的几个属性是系统自带的,初始了tstamp之后,它们就有值了 --&gt;
</br> &lt;!-- ${DSTAMP} ${TSTAMP} ${TODAY} --&gt;
</br> &lt;tstamp/&gt;
</br> &lt;property name='war.name' value='${webapp.name}' /&gt;
</br> &lt;!-- =================================================================== --&gt;
</br> &lt;!-- Init --&gt;
</br> &lt;!-- =================================================================== --&gt;
</br> &lt;target name='init'&gt;
</br> &lt;echo message='-------------------------------------'/&gt;
</br> &lt;echo message='start ant build ${project.name} -- ${DSTAMP}${TSTAMP}'/&gt;
</br> &lt;property name='debug' value='off'/&gt;
</br> &lt;property name='optimize' value='on'/&gt;
</br> &lt;property name='deprecation' value='on'/&gt;
</br> &lt;!-- java源文件路径 --&gt;
</br> &lt;property name='src.dir' value='${basedir}/src'/&gt;
</br> &lt;!-- jar包路径 --&gt;
</br> &lt;property name='lib.dir' value='${basedir}/WebRoot/WEB-INF/lib'/&gt;
</br> &lt;!-- webapp路径 --&gt;
</br> &lt;property name='webapp.dir' value='${basedir}/WebRoot'/&gt;
</br> &lt;!-- 准备源文件路径 --&gt;
</br> &lt;property name='build.src' value='${basedir}/AntBuild/build'/&gt;
</br> &lt;!-- 编译源文件路径 --&gt;
</br> &lt;property name='build.dest' value='${basedir}/AntBuild/bin'/&gt;
</br> &lt;!-- 准备webapp文件路径 --&gt;
</br> &lt;property name='buildwar.dest' value='${basedir}/AntBuild/warsrc'/&gt;
</br> &lt;!-- 打包war文件路径 --&gt;
</br> &lt;property name='war.dest' value='${basedir}/AntBuild/war'/&gt;
</br> &lt;!-- jre lib路径 --&gt;
</br> &lt;property name='jre.lib' value='${jdk.home}/jre/lib'/&gt;
</br> &lt;!-- 引用svn task文件，使用svn任务可以使用--&gt;
</br> &lt;typedef resource='org/tigris/subversion/svnant/svnantlib.xml' /&gt;
</br> &lt;!-- 设置svn相关属性 --&gt;
</br> &lt;svnSetting id='svn.setting' svnkit='true' username='${svn.uname}' password='${svn.pwd}' javahl='false' /&gt;
</br> &lt;!-- classpath --&gt;
</br> &lt;path id='classpath'&gt;
</br> &lt;!--web.lib--&gt;
</br> &lt;fileset dir='e:/lib'&gt;
</br> &lt;include name='**/*.jar'/&gt;
</br> &lt;/fileset&gt;
</br> &lt;fileset dir='${jre.lib}'&gt;
</br> &lt;include name='**/*.jar'/&gt;
</br> &lt;/fileset&gt;
</br> &lt;fileset dir='${lib.dir}'&gt;
</br> &lt;include name='**/*.jar'/&gt;
</br> &lt;/fileset&gt;
</br> &lt;!--&lt;pathelement location='lib/'/&gt;--&gt;
</br> &lt;/path&gt;
</br> &lt;/target&gt;
</br> &lt;!-- =================================================================== --&gt;
</br> &lt;!-- checkout --&gt;
</br> &lt;!-- =================================================================== --&gt;
</br> &lt;target name='checkout' depends='init'&gt;
</br> &lt;echo message='-------------------------------------'/&gt;
</br> &lt;echo message='start checkout ${project.name} -- ${DSTAMP}${TSTAMP}'/&gt;
</br> &lt;svn refid='svn.setting'&gt;
</br> &lt;checkout url='${svn.url}' revision='HEAD' destPath='.' /&gt;
</br> &lt;/svn&gt;
</br> &lt;/target&gt;
</br> &lt;!-- =================================================================== --&gt;
</br> &lt;!-- 编译源文件--&gt;
</br> &lt;!-- =================================================================== --&gt;
</br> &lt;target name='build' depends='checkout'&gt;
</br> &lt;echo message='-------------------------------------'/&gt;
</br> &lt;echo message='start build ${project.name} -- ${DSTAMP}${TSTAMP}'/&gt;
</br> &lt;mkdir dir='${buildwar.dest}/WEB-INF/classes'/&gt;
</br> &lt;delete&gt;
</br> &lt;fileset dir='${buildwar.dest}/WEB-INF/classes' includes='**/*.*'/&gt;
</br> &lt;/delete&gt;
</br> &lt;javac srcdir='${src.dir}' destdir='${buildwar.dest}/WEB-INF/classes' debug='${debug}' optimize='${optimize}' includeantruntime='on'&gt;
</br> &lt;classpath refid='classpath'/&gt;
</br> &lt;/javac&gt;
</br> &lt;copy todir='${buildwar.dest}/WEB-INF/classes'&gt;
</br> &lt;fileset dir='${src.dir}'&gt;
</br> &lt;include name='**/*.*'/&gt;
</br> &lt;exclude name='**/*.java'/&gt;
</br> &lt;/fileset&gt;
</br> &lt;/copy&gt;
</br> &lt;/target&gt;
</br> &lt;!-- =================================================================== --&gt;
</br> &lt;!-- 打war包--&gt;
</br> &lt;!-- =================================================================== --&gt;
</br> &lt;target name='war' depends='build'&gt;
</br> &lt;echo message='-------------------------------------'/&gt;
</br> &lt;echo message='start war ${project.name} -- ${DSTAMP}${TSTAMP}'/&gt;
</br> &lt;delete&gt;
</br> &lt;fileset dir='.' includes='**/*.war'/&gt;
</br> &lt;/delete&gt;
</br> &lt;!--needxmlfile 设为false才不会报错 web.xml不存在 ant会报错--&gt;
</br> &lt;war destfile='${war.name}.war' needxmlfile='false'&gt;
</br> &lt;!-- &lt;lib dir='${basedir}/WebRoot/WEB-INF/lib'/&gt; --&gt;
</br> &lt;classes dir='${buildwar.dest}/WEB-INF/classes' excludes='${war.exclude.classes}'/&gt;
</br> &lt;fileset dir='${webapp.dir}' excludes='${war.exclude}'/&gt;
</br> &lt;/war&gt;
</br> &lt;/target&gt;
</br> &lt;!-- =================================================================== --&gt;
</br> 上传本地文件到远程服务器，执行远程命令
</br> &lt;!-- =================================================================== --&gt;
</br> &lt;target name='ssh' depends='war'&gt;
</br> &lt;echo message='-------------------------------------'/&gt;
</br> &lt;echo message='start ssh ${project.name} -- ${DSTAMP}${TSTAMP}'/&gt;
</br> &lt;!--上传--&gt;
</br> &lt;scp file='${basedir}/${war.name}.war' todir='${ssh.uname}:${ssh.pwd}@${ssh.host}:${ssh.path}' trust='true'/&gt;
</br> &lt;/target&gt;
</br> &lt;!-- =================================================================== --&gt;
</br> &lt;!-- 停止服务器--&gt;
</br> &lt;!-- =================================================================== --&gt;
</br> &lt;target name='stop' depends='ssh'&gt;
</br> &lt;echo message='-------------------------------------'/&gt;
</br> &lt;echo message='stop server -- ${DSTAMP}${TSTAMP}'/&gt;
</br> &lt;sshexec host='${ssh.host}' username='${ssh.uname}' password='${ssh.pwd}' port='22' trust='true' verbose='true' command='${ssh.server.stop}'/&gt;
</br> &lt;/target&gt;
</br> &lt;!-- =================================================================== --&gt;
</br> &lt;!-- 启动服务器--&gt;
</br> &lt;!-- =================================================================== --&gt;
</br> &lt;target name='start' depends='stop'&gt;
</br> &lt;echo message='-------------------------------------'/&gt;
</br> &lt;echo message='start server -- ${DSTAMP}${TSTAMP}'/&gt;
</br> &lt;sshexec host='${ssh.host}' username='${ssh.uname}' password='${ssh.pwd}' port='22' trust='true' verbose='true' command='${ssh.server.start}'/&gt;
</br> &lt;/target&gt;
</br> &lt;!-- =================================================================== --&gt;
</br> &lt;!-- 清除临时文件--&gt;
</br> &lt;!-- =================================================================== --&gt;
</br> &lt;target name='clean' depends='init'&gt;
</br> &lt;echo message='-------------------------------------'/&gt;
</br> &lt;echo message='start clean ${project.name} -- ${DSTAMP}${TSTAMP}'/&gt;
</br> &lt;delete includeemptydirs='true'&gt;
</br> &lt;fileset dir='${basedir}' excludes='ant.properties,build.xml'/&gt;
</br> &lt;/delete&gt;
</br> &lt;/target&gt;
</br>&lt;/project&gt;
</br>[/sourcecode]
</br>注释写的还算详细哈！
</br>ANT的配置网上一大堆，google一下就知道了（有时宁愿用有道，也不愿意用百度）。
</br>想起之前svn下载、编译、上传、部署全部手动操作，唉！
</br>现在，一个命令搞定，好舒服！
</br>构建工具，还有另外一种选择，使用MAVEN，MAVEN更是一种更优秀的构建工具，也推荐学习一下的。
</br>多学习一种是好事哈！不能总用过myeclipse就行吧！目前我的系统采用的是linuxdeepin，基本都能满足我的日常使用了，下次有机会再介绍我的linux经历史了。
