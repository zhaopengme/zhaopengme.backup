title: myeclipse插件安装
id: 137
categories: java
date: 2011-12-18 21:36:07
tags:
---

myeclipse7以前都是可以很容易通过link方式来安装eclipse的插件的，自从myeclipse7以后，myeclipse修改的安装配置的方式，直接用link方式安装插件很麻烦，这里找到一个用link方式的插件配置代码的生成器，用这个安装，简单的一米，推荐必备软件。

步骤如下
</br>1.比如给myeclipse10安装hibernate的插件，我的hibernate插件之前是eclipse3.2的版本安装的里面。

在D:toolsMyEclipse 10MyEclipse 10建立myplugins文件，将hibernate插件放入文件中，不要有eclipse的目录。

hibernate插件目录如下 &nbsp;&nbsp;&nbsp;

D:toolsMyEclipse 10MyEclipse 10mypluginshibernatepluginscom.hudson.hibernatesynchronizer_3.1.9_lclgv1.0

2.使用MyEclipse插件配置代码生成器，修改里面的路径
<pre></pre><pre config="brush:java;toolbar:false;">import java.io.File;

import java.util.ArrayList;

import java.util.List;

/**
 *
 *
 * @ClassName : PluginConfigCreator
 *
 * @ClassDescription : MyEclipse插件配置代码生成器
 *
 * @Author : dapeng
 *
 * @CreateTime : 2011-12-18 下午8:39:31
 *
 *
 */

public class PluginConfigCreator {

    public PluginConfigCreator() {

    }

    public void print(String path) {

        List&lt;String&gt; list = getFileList(path);

        if (list == null) {

            return;

        }

        int length = list.size();

        for (int i = 0; i &lt; length; i++) {

            String result = &quot;&quot;;

            String thePath = getFormatPath(getString(list.get(i)));

            File file = new File(thePath);

            if (file.isDirectory()) {

                String fileName = file.getName();

                if (fileName.indexOf(&quot;_&quot;) &lt; 0) {

                    print(thePath);

                    continue;

                }

                String[] filenames = fileName.split(&quot;_&quot;);

                String filename1 = filenames[0];

                String filename2 = filenames[1];

                result = filename1 + &quot;,&quot; + filename2 + &quot;,file:/&quot; + path + &quot;/&quot;

                + fileName + &quot;\,4,false&quot;;

                System.out.println(result);

            } else if (file.isFile()) {

                String fileName = file.getName();

                if (fileName.indexOf(&quot;_&quot;) &lt; 0) {

                    continue;

                }

                int last = fileName.lastIndexOf(&quot;_&quot;);// 最后一个下划线的位 置

                String filename1 = fileName.substring(0, last);

                String filename2 = fileName.substring(last + 1,

                fileName.length() - 4);

                result = filename1 + &quot;,&quot; + filename2 + &quot;,file:/&quot; + path + &quot;/&quot;

                + fileName + &quot;,4,false&quot;;

                System.out.println(result);

            }

        }

    }

    public List&lt;String&gt; getFileList(String path) {

        path = getFormatPath(path);

        path = path + &quot;/&quot;;

        File filePath = new File(path);

        if (!filePath.isDirectory()) {

            return null;

        }

        String[] filelist = filePath.list();

        List&lt;String&gt; filelistFilter = new ArrayList&lt;String&gt;();

        for (int i = 0; i &lt; filelist.length; i++) {

            String tempfilename = getFormatPath(path + filelist[i]);

            filelistFilter.add(tempfilename);

        }

        return filelistFilter;

    }

    public String getString(Object object) {

        if (object == null) {

            return &quot;&quot;;

        }

        return String.valueOf(object);

    }

    public String getFormatPath(String path) {

        path = path.replaceAll(&quot;\\&quot;, &quot;/&quot;);

        path = path.replaceAll(&quot;//&quot;, &quot;/&quot;);

        return path;

    }

    public static void main(String[] args) {

        /* 你的插件的安装目录 */

        String plugin = &quot;C:/Users/Administrator/AppData/Local/MyEclipse Blue Edition/MyEclipse Blue Edition 10/My-plugins/findbugs-1.3.8&quot;;

        new PluginConfigCreator().print(plugin);

    }

}</pre>

&nbsp;

3.复制配置信息

&nbsp;

MyEclipse插件配置代码生成器会生成一串配置信息

&nbsp;

com.hudson.hibernatesynchronizer,3.1.9,file:/D:/tools/MyEclipse 10/MyEclipse 10/myplugins/hibernate/plugins/com.hudson.hibernatesynchronizer_3.1.9_lclgv1.0,4,false

&nbsp;

4.添加配置信息

&nbsp;

 &nbsp;&nbsp;用文本编辑器打开D:toolsMyEclipse 10MyEclipse 10configurationorg.eclipse.equinox.simpleconfiguratorbundles.info

&nbsp;

 &nbsp;&nbsp;将那段配置信息添加到bundles.info最后

&nbsp;

重启myeclipse，查看hibernate插件，ok！完成了！
