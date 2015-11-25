title: myeclipse注册机源码
id: 514
categories: java
date: 2009-01-24 04:33:00
tags:
---

myeclipse注册机源码，自己得到自己的注册码。
</br>
</br>/**
</br> * @author joypen
</br> * MyEclipse注册机
</br> */
</br>import java.io.BufferedReader;
</br>import java.io.IOException;
</br>import java.io.InputStreamReader;
</br>
</br>public class MyEclipseGen {
</br> private static final String LL = &quot;Decompiling this copyrighted software is a violation of both your license agreement and the Digital Millenium Copyright Act of 1998 (http://www.loc.gov/copyright/legislation/dmca.pdf). Under section 1204 of the DMCA, penalties range up to a $500,000 fine or up to five years imprisonment for a first offense. Think about it; pay for a license, avoid prosecution, and feel better about yourself.&quot;;
</br>
</br> public String getSerial(String userId, String licenseNum) {
</br> java.util.Calendar cal = java.util.Calendar.getInstance();
</br> cal.add(1, 3);
</br> cal.add(6, -1);
</br> java.text.NumberFormat nf = new java.text.DecimalFormat(&quot;000&quot;);
</br> licenseNum = nf.format(Integer.valueOf(licenseNum));
</br> String verTime = new StringBuilder(&quot;-&quot;).append(
</br> new java.text.SimpleDateFormat(&quot;yyMMdd&quot;).format(cal.getTime()))
</br> .append(&quot;0&quot;).toString();
</br> String type = &quot;YE3MP-&quot;;
</br> String need = new StringBuilder(userId.substring(0, 1)).append(type)
</br> .append(&quot;300&quot;).append(licenseNum).append(verTime).toString();
</br> String dx = new StringBuilder(need).append(LL).append(userId)
</br> .toString();
</br> int suf = this.decode(dx);
</br> String code = new StringBuilder(need).append(String.valueOf(suf))
</br> .toString();
</br> return this.change(code);
</br> }
</br>
</br> private int decode(String s) {
</br> int i;
</br> char[] ac;
</br> int j;
</br> int k;
</br> i = 0;
</br> ac = s.toCharArray();
</br> j = 0;
</br> k = ac.length;
</br> while (j &lt; k) {
</br> i = (31 * i) + ac[j];
</br> j++;
</br> }
</br> return Math.abs(i);
</br> }
</br>
</br> private String change(String s) {
</br> byte[] abyte0;
</br> char[] ac;
</br> int i;
</br> int k;
</br> int j;
</br> abyte0 = s.getBytes();
</br> ac = new char[s.length()];
</br> i = 0;
</br> k = abyte0.length;
</br> while (i &lt; k) {
</br> j = abyte0[i];
</br> if ((j &gt;= 48) &amp;&amp; (j &lt;= 57)) {
</br> j = (((j - 48) + 5) % 10) + 48;
</br> } else if ((j &gt;= 65) &amp;&amp; (j &lt;= 90)) {
</br> j = (((j - 65) + 13) % 26) + 65;
</br> } else if ((j &gt;= 97) &amp;&amp; (j &lt;= 122)) {
</br> j = (((j - 97) + 13) % 26) + 97;
</br> }
</br> ac[i] = (char) j;
</br> i++;
</br> }
</br> return String.valueOf(ac);
</br> }
</br>
</br> public MyEclipseGen() {
</br> super();
</br> }
</br>
</br> public static void main(String[] args) {
</br> try {
</br> System.out.println(&quot;please input register name:&quot;);
</br> BufferedReader reader = new BufferedReader(new InputStreamReader(
</br> System.in));
</br> String userId = null;
</br> userId = reader.readLine();
</br> MyEclipseGen myeclipsegen = new MyEclipseGen();
</br> String res = myeclipsegen.getSerial(userId, &quot;5&quot;);
</br> System.out.println(&quot;Serial:&quot; + res);
</br> reader.readLine();
</br> } catch (IOException ex) {
</br> }
</br> }
</br>}
</br>
</br>提供一个
</br>Subscriber:joypen
</br>Serial:wLR8ZC-855550-67567757580397971
</br>
</br>建议：注册的时候最好断网。
