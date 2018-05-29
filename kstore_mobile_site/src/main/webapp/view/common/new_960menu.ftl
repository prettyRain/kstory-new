<style>
    .bar-bottom:after, .pro-recommend .pro-recommend-body:after, .recommend-list ul:after {
        content: '';
        clear: both
    }
    .bar-bottom {
        position: fixed;
        bottom: 0;
        height: 54px;
        width: 100%;
        border-top: 1px solid #ececec;
        background-color: #fff;
        text-align: center;
        z-index: 999;
        border-top: 2px solid #50c896;
        font-size: 12px;
    }
    .bar-bottom:after {
        display: block
    }
    .bar-bottom .bar-item {
        float: left;
        width: 25%;
        height: 100%;
        font-size: .9em;
        color: #50c896
    }
    .bar-bottom .bar-item .bar-bottom-i {
        position: relative;
        display: block;
        width: 22px;
        height: 22px;
        margin: 6px auto 3px;
        background: url(../../images/commonbg2.png) -25px -5px no-repeat;
        -webkit-background-size: 250px 250px;
        background-size: 250px 250px
    }

    .bar-bottom .bar-item .bar-bottom-i.no-text {
        margin: 14px auto
    }

    .bar-bottom .bar-item .bar-bottom-i.home {
        background-position: -25px -30px
    }

    .bar-bottom .bar-item .bar-bottom-i.class {
        background-position: -47px -30px
    }

    .bar-bottom .bar-item .bar-bottom-i.cart {
        background-position: -72px -30px
    }

    .bar-bottom .bar-item .bar-bottom-i.mine {
        background-position: -94px -30px
    }

    .bar-bottom .bar-item .bar-bottom-i.love {
        background-position: -47px -55px
    }

    .bar-bottom .bar-item .bar-bottom-i.shop {
        background-position: -192px -75px
    }

    .bar-bottom .bar-item .bar-bottom-i .tip {
        position: absolute;
        top: -4px;
        right: -8px;
        width: 14px;
        height: 14px;
        color: #fff;
        font-size: .8572em;
        line-height: 16px;
        -webkit-border-radius: 14px;
        -moz-border-radius: 14px;
        border-radius: 14px;
        background-color: #E63D59
    }

    .bar-bottom .bar-item.selected {
        color: #fff;
        background: #50c896;
    }

    .bar-bottom .bar-item.selected .bar-bottom-i.home {
        background-position: -25px -5px
    }

    .bar-bottom .bar-item.selected .bar-bottom-i.class {
        background-position: -47px -5px
    }

    .bar-bottom .bar-item.selected .bar-bottom-i.cart {
        background-position: -72px -5px
    }

    .bar-bottom .bar-item.selected .bar-bottom-i.mine {
        background-position: -94px -5px
    }

    .bar-bottom .bar-item.selected .bar-bottom-i.love {
        background-position: -69px -55px
    }

    .bar-bottom .half {
        float: left;
        width: 50%;
        height: 50px;
        line-height: 50px
    }

    .bar-bottom .half .addToCart {
        display: block;
        width: 100%;
        height: 51px;
        color: #fff;
        font-size: 1.3em;
        line-height: 40px;
        background-color: #E63D59;
        border-radius: 0
    }

    .bar-bottom .half .bar-item {
        width: 100%;
        line-height: 18px;
        border-right: 1px solid #DDD;
        display: block;
        text-align: center
    }

    .bar-bottom .half .bar-item:last-child {
        border-right: 0
    }

</style>
<div class="bar-bottom">
    <a class="bar-item external" href="${basePath}/main.html"><i class="bar-bottom-i home"></i>首页</a>
    <a class="bar-item external" href="${basePath}/cates.html"><i class="bar-bottom-i class"></i>分类</a>
    <a class="bar-item external" href="${basePath}/myshoppingmcart.html"><i class="bar-bottom-i cart"></i>购物车</a>
    <a class="bar-item external" href="${basePath}/customercenter.html"><i class="bar-bottom-i mine"></i>我的</a>
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