<#--
<div class="smart_menu">
      <ul id="keleyi-menu">
        <li><a href="${basePath}/main.html">首页</a></li>
        <li><a href="${basePath}/cates.html">商品分类</a></li>

        <li><a href="javascript:;">个人中心</a>
          <ul>
            <li><a href="${basePath}/customer/myorder.html">我的订单</a></li>
            <li><a href="${basePath}/customercenter.html">账户中心</a></li>
            <li class="corner"></li>
          </ul>
        </li>
        <li><a href="${basePath}/myshoppingmcart.html">购物车</a></li>
        <li><a href="javascript:;"onclick="javascript:history.go(-1)" ></a></li>
      </ul>
    </div>-->
<style>
    .bar-bottom {
        border-top: 2px solid #50C896;
    }
    .bar-bottom .bar-item .bar-bottom-i {
        height: 40px;background: none;
        background-size: 100% auto;
        background-repeat: no-repeat;
    }
    .bar-bottom .bar-item .bar-bottom-i.home{
        background-image: url(/images/v1/img/home1.png);
        background-position: inherit;
    }
    .bar-bottom .bar-item .bar-bottom-i.class {
        background-image: url(/images/v1/img/menu1.png);
        background-position: inherit;
    }

    .bar-bottom .bar-item .bar-bottom-i.cart {
        background-image: url(/images/v1/img/gw1.png);
        background-position: inherit;
        width: 33px;
    }
    .bar-bottom .bar-item .bar-bottom-i.mine {
        background-image: url(/images/v1/img/my1.png);
        background-position: inherit;
    }
    .bar-bottom .bar-item.selected .bar-bottom-i.home {
        background-image: url(/images/v1/img/home.png);
        background-position: inherit;
    }

    .bar-bottom .bar-item.selected .bar-bottom-i.class {
        background-image: url(/images/v1/img/menu.png);
        background-position: inherit;
    }

    .bar-bottom .bar-item.selected .bar-bottom-i.cart {
        background-image: url(/images/v1/img/gw.png);
        background-position: inherit;
    }

    .bar-bottom .bar-item.selected .bar-bottom-i.mine {
        background-image: url(/images/v1/img/my.png);
        background-position: inherit;
    }
    .cart_num{    position: absolute;
        left: 55%;
        top: -.5em;
        width: 1.6em;
        height: 1.6em;
        border-radius: 50%;
        background: red;
        color: white;
        text-align: center;
        line-height: 160%;
        font-size: .8em;
    }
    .bar-bottom .bar-item.selected {
        background-color: #50C896;
    }

</style>
<div class="bar-bottom">
  <a class="bar-item" href="${basePath}/main.html"><i class="bar-bottom-i home"></i></a>
  <a class="bar-item" href="${basePath}/cates.html"><i class="bar-bottom-i class"></i></a>
    <a class="bar-item" href="${basePath}/myshoppingmcart.html"><i class="bar-bottom-i cart"></i></a>
  <a class="bar-item" href="${basePath}/customercenter.html"><i class="bar-bottom-i mine"></i></a>
</div>
<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?94d81cec8c55272bd7081c5126331fc1";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>


