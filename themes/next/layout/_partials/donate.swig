<! -- 添加捐赠图标 -->
    <div class ="post-donate">
      <div id="donate_board" class="donate_bar center" style="text-align: center;">
        <a id="btn_donate" class="btn_donate" href="javascript:;" title="Donate 打赏"></a>
        <h2>Enjoy it ? Donate me !  欣赏此文？求鼓励，求支持！</h2>
        <br>
      </div>  
  
    <!-- 支付宝打赏图案 -->
      <div id="donate_guide" class="donate_bar center hidden" style="text-align: center;">
          <a href="http://cdn.zhaopeng.me/alipay.JPG" title="支付宝打赏" class="fancybox" rel="article0"       style="float:left;margin-left:25%;margin-right:2px;">
          <img src="http://cdn.zhaopeng.me/alipay.JPG" title="支付宝打赏" height="164px" width="164px">
          </a> 
      </div>

    <!-- 微信打赏图案 -->
      <div id="donate_guide" class="donate_bar center hidden" style="text-align: center;">
          <a href="http://cdn.zhaopeng.me/wechatpay.JPG" title="微信打赏" class="fancybox" rel="article0"  >
          <img src="http://cdn.zhaopeng.me/wechatpay.JPG" title="微信打赏" height="164px" width="164px">
          </a> 
      </div>
  
      <script type="text/javascript">
        document.getElementById('btn_donate').onclick = function(){
          $('#donate_board').addClass('hidden');
          $('#donate_guide').removeClass('hidden');
        }
      </script>
    </div>
<! -- 添加捐赠图标 -->