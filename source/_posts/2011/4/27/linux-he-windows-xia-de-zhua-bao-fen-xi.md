title: linux和windows下的抓包分析
id: 183
categories: 闲言碎语
date: 2011-04-27 01:15:55
tags:
---

linux和windows下的抓包分析
</br>linux下抓包分析
</br>1.使用root帐号对需要监听的端口进行抓包
</br><span> </span>tcpdump -X -s 0 -w ssh.cap port 22
</br>2.将生成的ssh.cap下载到本地，使用Wireshark来打开ssh.cap分析具体内容
</br>&nbsp;
</br>windows下抓包分析
</br>1.打开capture，选择interfaces
</br>2.选择需要监听的ip
</br>

</br>
