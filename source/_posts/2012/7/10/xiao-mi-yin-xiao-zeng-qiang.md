title: 小米音效增强
id: 91
categories:

date: 2012-07-10 13:05:16
tags:
---

小米的音效，还算是一般吧！如果把音量放到最大，偶尔会听到一些爆音。

这里强烈推荐使用DSP管理器，来进行管理。

这边已经由puterjam进行整理打包好的工具了。

puterjam就是pjblog的大神，相当不错一款博客程序。

我对这些音效也算是个音盲，可用过Beats Audio + DSP 管理器后，也能十分的发现音效的确变了，音效可以自己选择，我选择的是改变的低音，这样听起来深沉些。

&nbsp;

截图：

![](http://m2.img.libdd.com/farm5/2012/0821/18/45FA6AA2B09DCE3551E21B4BF3693263BC5DF005049E_338_600.PNG)</img>&nbsp;

![](http://m3.img.libdd.com/farm5/2012/0821/18/21C8C957A1188024C519EC3FDC89A09561260A05049E_338_600.PNG)</img>&nbsp;

![](http://m3.img.libdd.com/farm4/2012/0821/18/26C45968A3D55284F8C3F004129231A1B45E5E05049E_338_600.PNG)</img>&nbsp;

&nbsp;

**安装方法：
</br>方法1：**第一次安装前先执行 **1.备份系统文件.bat** 根据引导即可自动完成安装。![](http://m2.img.libdd.com/farm5/2012/0821/18/A62A9F7310B43A2507342C5D86286DC279FFEB004114_20_20.GIF)</img>
</br>
</br>**方法2：**执行 **1.备份系统文件.bat** 后中断继续安装流程，可以选择不带DSP的安装方式 **2.安装(不带DSP).bat**
</br>
</br> （注意：已经安装过7.1版本的，备份文件系统是无效的，请参考安装问题解决中的 6.1或者6.2 来解决卸载问题）
</br>
</br>**卸载方法：**
</br>**3.卸载.bat** 不用多说了吧![](http://m1.img.libdd.com/farm4/2012/0821/18/763E7E9DB5085E355721B2AA5D1BD405F60AF0004114_20_20.GIF)</img>
</br>
</br> (卸载的时候,自动把system_bak目录中备份的文件进行覆盖，需要手动制作备份文件的请参考安装问题解决中 的 6.2 说明)
</br>
</br>
</br>
</br>
</br> --------------------------------------------------- 我是分割线 ---------------------------------------------------
</br>**安装问题 Q&amp;A**
</br> 1\. 安装失败的问题，建议在 **MIUI V4** (我是最新的2.6.29版本)下试试看(其他版本系统没尝试过)，**如果是android 2.3内核的这个不保证可以安装。**
</br>
</br> 2\. DSP安装有问题的，可以尝试下载 去掉DSP 的audio_effects.conf 的文件
</br>

</br> 覆盖/system/etc/audio_effects.conf 下的文件，别忘记修改权限成644 wr-r-r
</br> 以及用RE删除 /system/app/DSPManager.apk
</br> 可以保留BA的音效
</br>
</br> 3\. 如果还出现其他问题，小米手机可以切换到另外的系统来修复。![](http://m1.img.libdd.com/farm5/2012/0821/18/31F019AAB107505DDAB6406C1F410CE32B6302004114_20_20.GIF)</img>
</br>
</br> 4\. 安装先关闭 豌豆莱或者QQ手机管家等软件，避免adb server冲突
</br>
</br> 5\. 如果发现copy文件失败，请手动执行一下 adb root 后在执行install.bat
</br>
</br>**6\. 安装方式因为修改到了系统文件可能会导致OTA升级时文件验证失败而无法升级系统，7.1号安装的朋友请根据一下方式解决**
</br>**6.1 情况1：** 如果是 2.6.29 的系统，可以下载这个版本对应的系统文件，解压到心的安装包里system_bak目录下，然后执行 **3.卸载.bat** 进行系统文件还原。
</br>

</br>**6.2 情况2：**如果不是这个系统的，需要自己找到对应系统的的几个文件按照system的目录结构放到system_bak目录中进行还原
</br> 系统升级需要检查的文件列表, 这些文件可以在您的系统对应的完整安装里找到

1.  /system/etc/audio_effects.conf
</br>
2.  /system/lib/soundfx/libvisualizer.so
</br>
3.  /system/lib/soundfx/libreverbwrapper.so
</br>
4.  /system/lib/soundfx/libbundlewrapper.so
</br>
5.  /system/lib/soundfx/libaudiopreprocessing.so
</br>
6.  /system/lib/libwebrtc_audio_preprocessing.so
</br>
7.  /system/lib/libSR_AudioIn.so
</br>
8.  /system/lib/libaudcal.so
</br>
9.  /system/lib/libacdbmapper.so_复制代码_

对应备份目录的结构图
</br>![](http://m3.img.libdd.com/farm5/2012/0821/18/EBCD565CB663CABBAF1A15731B6B79411022EA5EF698_384_248.PNG)</img>
<span>6 天前</span> 上传[**下载附件**<span>(17.06 KB)</span>](http://www.miui.com/forum.php?mod=attachment&amp;aid=NjU1NjgxfGMwN2EzYTBmfDEzNDE4OTYzMzR8NDAxNjIwfDYzMDA3Mg%3D%3D&amp;nothumb=yes "捕获.PNG 下载次数:0")

[发送到手机](http://www.miui.com/api.php?mod=att_pushphone&amp;aid=655681&amp;infloat=yes&amp;handlekey=miphonepush_655681)

</br> 最后同样执行，**3.卸载.bat** 进行系统还原后进行OTA升级。
</br>
</br> 7\. 最后，还是需要你要胆大心细 ：P

原文地址：[http://www.miui.com/thread-630072-1-1.html](http://www.miui.com/thread-630072-1-1.html)

下载地址：[http://l3.yunpan.cn/lk/080fswmvve](http://l3.yunpan.cn/lk/080fswmvve)