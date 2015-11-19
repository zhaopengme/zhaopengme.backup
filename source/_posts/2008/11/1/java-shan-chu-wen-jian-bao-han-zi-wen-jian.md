title: java删除文件包含子文件
id: 604
categories:
  - java
date: 2008-11-01 11:32:00
tags:
---

//文件删除测试
</br>
</br>import java.io.*;
</br>
</br>public class Delete {
</br>
</br>&nbsp;public static void main(String[] args) throws IOException {
</br>&nbsp;&nbsp;
</br>&nbsp;&nbsp;Delete.delete(&quot;F:b&quot;);
</br>
</br>&nbsp;&nbsp;System.out.println(&quot;ok&quot;);
</br>&nbsp;}
</br>
</br>&nbsp;
</br>&nbsp;
</br>&nbsp;//文件名或者文件删除（可以删除包含的子文件和文件夹）
</br>&nbsp;public static boolean delete(String s) throws IOException {
</br>&nbsp;&nbsp;File file = new File(s);
</br>&nbsp;&nbsp;if(!file.delete()) {
</br>&nbsp;&nbsp;&nbsp;String[] f = file.list();//列出当前文件夹中的所以文件包括文件夹
</br>&nbsp;&nbsp;&nbsp;for(int i = 0; i &lt; f.length; i++) {
</br>&nbsp;&nbsp;&nbsp;&nbsp;delete(file.getAbsolutePath() + &quot;&quot; + f[i]);//对子文件夹进行处理
</br>&nbsp;&nbsp;&nbsp;&nbsp;return &nbsp;delete(file.getAbsolutePath());//返回上级目录
</br>&nbsp;&nbsp;&nbsp;}
</br>&nbsp;&nbsp;}
</br>&nbsp;&nbsp;return true;
</br>&nbsp;}
</br>
</br>&nbsp;
</br>
</br>}