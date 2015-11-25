title: javascript  进1取整的几种方式
id: 16
categories: java
date: 2013-01-17 15:00:02
tags:
---

javascript 进1取整的几种方式

最长见的都是四舍五入，业务中难免也有一些进一去整的要求。
</br>

进一去整，比如2.1 3.5 4.9，进1去整后的结果就是3 4 5.
</br>

方式一
</br>
<pre>var a = 2.0;
var b = 3.4;
var c = 8.9;

function modFoat(v) {
 var _max = parseInt(v) + 1;
 if( _max - v &lt; 1 ) {
  return _max;
 }
 return v;
}

alert(modFoat(a)); // 2
alert(modFoat(b)); // 4
alert(modFoat(c)); // 9
</pre>

方式二
</br>
<pre>var a = 2.0;

function parseNumber(number, splitChar) {
  var n = number + '';
  var s = splitChar == null ? '.' : splitChar;
  var nArr = n.split(s);
  if (nArr.length == 2) {//2.1
     return parseInt(nArr[0]) + 1;
  }
  else {//2.0
  return number;
  }
}

document.write(parseNumber(a));
</pre>

方式三
</br>

这种方式有bug，如果是2.0呢？
<pre>var a = 2.1;
var b = parseInt(a) + 1;  // b will be 3

parseInt是截掉尾数，然后再加一即可。
</pre>

方式四
</br>

最简单的
</br>
<pre>var a = 1.1
var s =  Math.ceil(a);
alert(s);
</pre>
