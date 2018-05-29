<style>
    .bar-bottom:after,.pro-recommend .pro-recommend-body:after,.recommend-list ul:after{content:'';clear:both}
    .bar-bottom{position:absolute;bottom:0;height:54px;width:100%;background-color:#fff;text-align:center;z-index:999;border-top:1px solid #d7d7d7;font-size:12px}
    .bar-bottom:after{display:block}
    .bar-bottom .bar-item{float:left;width:25%;height:100%;font-size:10px;color:#4d4d4d;font-family:微软雅黑,Microsoft yahei}
    .bar-bottom .bar-item .bar-bottom-i{background: url(../../images/v2/commonbg2.png?timestamp=1524622349) -25px -5px no-repeat;position:relative;display:block;width:23px;height:23px;margin:9px auto 3px;-webkit-background-size:225px 219px;background-size:225px 219px}
    .bar-bottom .bar-item .bar-bottom-i.no-text{margin:14px auto}
    .bar-bottom .bar-item .bar-bottom-i.home{background-position:-20px -33px}
    .bar-bottom .bar-item .bar-bottom-i.class{background-position:-45px -33px}
    .bar-bottom .bar-item .bar-bottom-i.cart{background-position:-71px -33px}
    .bar-bottom .bar-item .bar-bottom-i.mine{background-position:-97px -33px}
    /*.bar-bottom .bar-item .bar-bottom-i.love{background-position:-47px -55px}*/
    /*.bar-bottom .bar-item .bar-bottom-i.shop{background-position:-192px -75px}*/
    .bar-bottom .bar-item .bar-bottom-i .tip{position:absolute;top:-4px;right:-8px;width:14px;height:14px;color:#fff;font-size:.8572em;line-height:16px;-webkit-border-radius:14px;-moz-border-radius:14px;border-radius:14px;background-color:#0d9901}
    .bar-bottom .bar-item.selected{color:#0d9901}
    .bar-bottom .bar-item.selected .bar-bottom-i.home{background-position:-20px -4.6px}
    .bar-bottom .bar-item.selected .bar-bottom-i.class{background-position:-45px -4.6px}
    .bar-bottom .bar-item.selected .bar-bottom-i.cart{background-position:-71px -4.6px}
    .bar-bottom .bar-item.selected .bar-bottom-i.mine{background-position:-97px -4.6px}
    /*.bar-bottom .bar-item.selected .bar-bottom-i.love{background-position:-69px -55px}*/
    .bar-bottom .half{float:left;width:50%;height:50px;line-height:50px}
    .bar-bottom .half .addToCart{display:block;width:100%;height:51px;color:#fff;font-size:1.3em;line-height:40px;background-color:#E63D59;border-radius:0}
    .bar-bottom .half .bar-item{width:100%;line-height:18px;border-right:1px solid #DDD;display:block;text-align:center}
    .bar-bottom .half .bar-item:last-child{border-right:0}
    .bar-bottom .bar-item .cart{position:relative}
    .bar-bottom .bar-item span.hasgood{position:absolute;top:-4px;right:-6px;width:10px;height:10px;border-radius:50%;background:#FA6B13}
    .bar-bottom .bar-item{line-height:1.4!important}
    .bar-item.selected.scale{
        -webkit-animation: gobig ease-in 1s ; /* Chrome, Safari, Opera */
        animation: gobig ease-in 1s ;
    }
    @-webkit-keyframes gobig {
        50% {-webkit-transform: scale(1.15);}
    }
    @keyframes gobig {
        50% {transform: scale(1.15);}
    }
</style>
<div class="bar-bottom">
    <a class="bar-item external"  href="${basePath}/main.html" onclick="_czc.push(['_trackEvent', '首页', '首页', '首页','0','index']);"><i class="bar-bottom-i home"></i>首页</a>
    <a class="bar-item external"  href="${basePath}/cates.html" onclick="_czc.push(['_trackEvent', '分类', '分类', '分类','0','cate']);"><i class="bar-bottom-i class"></i>分类</a>
    <a class="bar-item external"  href="${basePath}/myshoppingmcart.html" onclick="_czc.push(['_trackEvent', '购物车', '购物车', '购物车','0','cart']);"><i class="bar-bottom-i cart"><span class=""></span></i>购物车</a>
    <a class="bar-item external"  href="${basePath}/customercenter.html" onclick="_czc.push(['_trackEvent', '我的', '我的', '我的','0','main']);"><i class="bar-bottom-i mine"></i>我的</a>
</div>
<script>
    (function() {
        $.ajax({
            type : 'get',
            url : '${basePath}/myshoppingmcartNum.htm',
            async : false,
            success : function(data) {
                if(data > 0){
                   $(".bar-item .cart span").addClass("hasgood");
                }else{
                    $(".bar-item .cart span").removeClass("hasgood");
                }
            }
        });

    //$(".bar-item.selected").addClass("scale")


    })();
</script>
<p style="display: none;">
    <!--友盟CNZZ统计-->
    <script src="https://s13.cnzz.com/z_stat.php?id=1264375679&web_id=1264375679" language="JavaScript">
        var _czc = _czc || [];
        _czc.push(["_setAccount", "m.ge960.com"]);
    </script>
</p>