title: ubuntu使用
id: 382
categories:
  - 闲言碎语
date: 2009-07-14 22:37:07
tags:
---

这次使用wine很完美的解决了远程控制主机，让我可以想在windows下一样来操作了！
</br>firefox也升级到了3.5，有点技巧的啊！
</br>
</br><span>1、到官方网站上去下载firefox-3.5.tar.bz2的压缩包</span>
</br><span>2、解压缩得到firefox文件夹，然后把该文件夹放到某个目录（我是放在用户目录下的）</span>
</br><span>3、打开终端，运行:</span>
</br><span>cd /usr/bin</span>
</br><span>sudo mv firefox firefox-old.bak</span>
</br><span>sudo ln -s (你移动的firefox文件夹的路径)/firefox/firefox firefox</span>
</br><span>比如我的firefox文件夹放在/home/username下，命令就是</span>
</br><span>sudo ln -s /home/username/firefox/firefox firefox
</br></span>
</br><span>
</br></span>
</br><span>这样，原来的旧版本的firefox也存在，但打开图标运行的是新的3.5版本，旧版本的各种设置也都会在的。</span>
</br>这个办法是别人想出来的，我还没理解他们的原理的！
</br>而且也解决了flash乱码的问题！
</br>
</br>sudo cp /etc/fonts/conf.d/49-sansserif.conf /etc/fonts/conf.d/49-sansserif.conf.bak
</br>sudo rm /etc/fonts/conf.d/49-sansserif.conf
</br>使用这两条命令就可以了！