title: 'oracle时间的加减[oracle]'
id: 265
categories: 闲言碎语
date: 2010-03-26 00:18:43
tags:
---

时间加减的方式很简单，例如加一天，你就是sysdate+1，加两天就是sysdate+2，如果需要进行小时的加减，例如要加8小时，那就是sysdate+8/24，加16小时就是sysdate+16/24，以此类推，如果加10分钟，那就是sysdate+10/(24*60)了，东西和简单，但是很使用的小技巧了。
