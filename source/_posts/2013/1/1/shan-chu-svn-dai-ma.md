title: 删除.svn代码
id: 20
categories:
  - java
date: 2013-01-01 20:37:34
tags:
---

写了一段代码，删除.svn的，用系统查找出来的删除，老是弄的电脑死机。
</br>

代码没啥含量，java实现。
</br>
<pre config="brush:java;toolbar:false;">

import java.io.File;
/**
 *
 * @author zhaopeng
 * @time  2013年1月1日 20:36:20
 *
 */
public class Delsvn {
    public static void main(String[] args) {

        Long time = System.currentTimeMillis();
        String path = &quot;D:/Workspace&quot;;
        delsvn(path, &quot;.svn&quot;);
        System.out.println(&quot;耗时：&quot; + (System.currentTimeMillis() - time) / 1000
                + &quot;s&quot;);
    }

    public static void delsvn(String path, String delFileFix) {
        File file = new File(path);
        String fileName = file.getName();
        if (delFileFix.equals(fileName)) {
            delDirectory(file, delFileFix);
        } else if (file.isDirectory()) {
            File[] files = file.listFiles();
            int size = files.length;
            for (int i = 0; i &lt; size; i++) {
                File fileTemp = files[i];
                if (fileTemp.isDirectory()) {
                    delsvn(fileTemp.getPath(), delFileFix);
                }
            }
        }
    }

    public static void delFile(File file) {
        file.delete();
        System.out.print(&quot;.&quot;);
    }

    public static void delDirectory(File file, String delFileFix) {
        File[] files = file.listFiles();
        String fileName = file.getName();
        int size = files.length;
        for (int i = 0; i &lt; size; i++) {
            File tempFile = files[i];
            if (tempFile.isDirectory()) {
                delDirectory(tempFile, delFileFix);
            } else {
                delFile(tempFile);
            }
        }
        file.delete();
        System.out.println(&quot;.&quot;);
    }

}
</pre>