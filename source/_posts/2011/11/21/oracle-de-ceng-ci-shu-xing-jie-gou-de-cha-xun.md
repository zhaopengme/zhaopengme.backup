title: oracle的层次树形结构的查询
id: 147
categories: 闲言碎语
date: 2011-11-21 12:52:07
tags:
---

在数据库父子关系的模型中，经常会需要将数据表现为树形，带层次结构的表现，就可以采用connect by prior start with来实现了。
</br>代码
</br>
</br>
</br><pre><span> 1:</span></pre>
</br>&nbsp;
</br><pre><span> 2:</span> *******************************************************************************/</pre>
</br>&nbsp;
</br><pre><span> 3:</span></pre>
</br>&nbsp;
</br><pre><span> 4:</span> --创建测试表，增加测试数据</pre>
</br>&nbsp;
</br><pre><span> 5:</span></pre>
</br>&nbsp;
</br><pre><span> 6:</span><span>create</span><span>table</span> dapeng_test(superid varchar2(20),id varchar2(20));</pre>
</br>&nbsp;
</br><pre><span> 7:</span></pre>
</br>&nbsp;
</br><pre><span> 8:</span> insert <span>into</span> dapeng_test <span>values</span>(<span>'0'</span>,<span>'1'</span>);</pre>
</br>&nbsp;
</br><pre><span> 9:</span> insert <span>into</span> dapeng_test <span>values</span>(<span>'0'</span>,<span>'2'</span>);</pre>
</br>&nbsp;
</br><pre><span> 10:</span></pre>
</br>&nbsp;
</br><pre><span> 11:</span> insert <span>into</span> dapeng_test <span>values</span>(<span>'1'</span>,<span>'11'</span>);</pre>
</br>&nbsp;
</br><pre><span> 12:</span> insert <span>into</span> dapeng_test <span>values</span>(<span>'1'</span>,<span>'12'</span>);</pre>
</br>&nbsp;
</br><pre><span> 13:</span></pre>
</br>&nbsp;
</br><pre><span> 14:</span> insert <span>into</span> dapeng_test <span>values</span>(<span>'2'</span>,<span>'21'</span>);</pre>
</br>&nbsp;
</br><pre><span> 15:</span> insert <span>into</span> dapeng_test <span>values</span>(<span>'2'</span>,<span>'22'</span>);</pre>
</br>&nbsp;
</br><pre><span> 16:</span></pre>
</br>&nbsp;
</br><pre><span> 17:</span> insert <span>into</span> dapeng_test <span>values</span>(<span>'11'</span>,<span>'111'</span>);</pre>
</br>&nbsp;
</br><pre><span> 18:</span> insert <span>into</span> dapeng_test <span>values</span>(<span>'11'</span>,<span>'112'</span>);</pre>
</br>&nbsp;
</br><pre><span> 19:</span></pre>
</br>&nbsp;
</br><pre><span> 20:</span> insert <span>into</span> dapeng_test <span>values</span>(<span>'12'</span>,<span>'121'</span>);</pre>
</br>&nbsp;
</br><pre><span> 21:</span> insert <span>into</span> dapeng_test <span>values</span>(<span>'12'</span>,<span>'122'</span>);</pre>
</br>&nbsp;
</br><pre><span> 22:</span></pre>
</br>&nbsp;
</br><pre><span> 23:</span> insert <span>into</span> dapeng_test <span>values</span>(<span>'21'</span>,<span>'211'</span>);</pre>
</br>&nbsp;
</br><pre><span> 24:</span> insert <span>into</span> dapeng_test <span>values</span>(<span>'21'</span>,<span>'212'</span>);</pre>
</br>&nbsp;
</br><pre><span> 25:</span></pre>
</br>&nbsp;
</br><pre><span> 26:</span> insert <span>into</span> dapeng_test <span>values</span>(<span>'22'</span>,<span>'221'</span>);</pre>
</br>&nbsp;
</br><pre><span> 27:</span> insert <span>into</span> dapeng_test <span>values</span>(<span>'22'</span>,<span>'222'</span>);</pre>
</br>&nbsp;
</br><pre><span> 28:</span></pre>
</br>&nbsp;
</br><pre><span> 29:</span><span>commit</span>;</pre>
</br>&nbsp;
</br><pre><span> 30:</span></pre>
</br>&nbsp;
</br><pre><span> 31:</span> --层次查询示例</pre>
</br>&nbsp;
</br><pre><span> 32:</span><span>select</span><span>level</span>||<span>'层'</span>,lpad(<span>' '</span>,<span>level</span>*5)||id id</pre>
</br>&nbsp;
</br><pre><span> 33:</span><span>from</span> dapeng_test</pre>
</br>&nbsp;
</br><pre><span> 34:</span><span>start</span><span>with</span> superid = <span>'0'</span><span>connect</span><span>by</span><span>prior</span> id=superid;</pre>
</br>&nbsp;
</br>
</br>
</br>

结果

</br>

[](http://images.dapeng.me/dapengme/2011/11/oracle_B34D/oracle-path-tree.jpg)[![http://images.dapeng.me/dapengme/2011/11/oracle_B34D/oracle-path-tree_thumb.jpg](http://m2.img.libdd.com/farm3/118/48E585B6FE66C51CE8D30FB4525F2D76_200_80.PNG)</img>](http://images.dapeng.me/dapengme/2011/11/oracle_B34D/oracle-path-tree_thumb.jpg)
