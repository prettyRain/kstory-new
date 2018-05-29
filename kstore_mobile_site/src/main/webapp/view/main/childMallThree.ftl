<!DOCTYPE html>
<#assign basePath=request.contextPath>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no,
minimal-ui">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>中国960官方商城</title>
    <link href="${basePath}/css/v1/swiper.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${basePath}/css/v1/childMall.css">
    <script src="${basePath}/js/v1/jquery.min.js"></script>
    <style>
        .content-block-menu{background:#f7f7f7;padding:.1rem 0;    margin-top: .5rem}
        .content-block-menu span,.content-block-list span{display:block;line-height:.4rem;font-size:.24rem}
        .content-block-menu a,.content-block-list a{-webkit-box-shadow:1px 1px 3px #adadad;-moz-box-shadow:1px 1px 3px #adadad;box-shadow:1px 1px 3px #adadad;-webkit-flex-shrink:1;-ms-flex:0 1 auto;flex-shrink:1;position:relative;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;width:100%;box-sizing:border-box;display:-webkit-box;display:-ms-flexbox;display:-webkit-flex;display:flex;-webkit-box-pack:center;-ms-flex-pack:center;-webkit-justify-content:center;justify-content:center;-webkit-box-align:center;-ms-flex-align:center;-webkit-align-items:center;align-items:center;overflow:visible;-webkit-box-flex:1;-ms-flex:1;-webkit-box-orient:vertical;-moz-box-orient:vertical;-ms-flex-direction:column;-webkit-flex-direction:column;flex-direction:column;padding-top:4px;padding-bottom:4px;-webkit-box-pack:justify;-ms-flex-pack:justify;-webkit-justify-content:space-between;justify-content:space-between}
        .content-block-menu div{width:100%;background:#fff;box-sizing:border-box;;display:-webkit-box;display:-ms-flexbox;display:-webkit-flex;display:flex;-webkit-box-pack:justify;-ms-flex-pack:justify;-webkit-justify-content:space-between;justify-content:space-between;-webkit-box-align:center;-ms-flex-align:center;-webkit-align-items:center;align-items:center}
        .content-block-menu i.icon{height:1rem;display:block}
        .content-block-menu .menu1 span{color:#0d9901}
        .content-block-menu .menu2 span{color:#fb6b14}
        .content-block-menu .menu3 span{color:#1dc3cd}
        .content-block-menu .menu4 span{color:#a90c32}
        i.menu-1{width:1rem;height:30px;background-image:url(../../../images/v1/img/101.jpg)}
        i.menu-2{width:1rem;height:30px;background-image:url(../../../images/v1/img/102.jpg)}
        i.menu-3{width:1rem;height:30px;background-image:url(../../../images/v1/img/103.jpg)}
        i.menu-4{width:1rem;height:30px;background-image:url(../../../images/v1/img/104.jpg)}
        i.icon{display:inline-block;vertical-align:middle;background-size:100% auto;background-position:center;background-repeat:no-repeat;font-style:normal;position:relative}
    </style>
</head>
<body>
<div class="listWarp">
    <div class="navbar">
        <div class="left">
            <a href="javascript:history.go(-1)" class="link"> <i class="backicon"></i></a>
        </div>
        <div class="center">购物中心</div>
        <div class="right"><a href="javascript:void(null)" class="link search"> <i class="searchicon"></i></a></div>
    </div>
    <div style="height: 65px;"></div>
    <div class="imgWarp">
        <!-- Swiper -->
        <div class="swiper-container">
            <div class="swiper-wrapper">
                <div class="swiper-slide"><a href="http://mobile.ronghere.com/shangmengmeng?code=zhongguo960guanfangshangcheng0523"><img src="/images/v1/img/coming_ban.jpg"></a></div>
            <#--<div class="swiper-slide"><a href="${basePath}/list/5777"><img src="/images/v1/img/shipin_ban@2x.jpg"></a></div>-->
            <#--<div class="swiper-slide"><a href="#"><img src="images/v1/img/mushroom_ban@2x.jpg"></a></div>-->
            </div>
            <div class="swiper-pagination"></div>
        </div>
    </div>
    <div class="content-block-menu">
        <div>
            <a href="${basePath}/intoPage.htm?pageName=main/childMallOne" class="external tab-link menu1"><span class="tabbar-label">食品荟萃</span> <i class="icon menu-1"></i></a>
            <a href="${basePath}/intoPage.htm?pageName=main/childMallTwo" class="external tab-link menu2"> <span class="tabbar-label">饮品总汇</span><i class="icon menu-2"></i></a>
            <a href="${basePath}/intoPage.htm?pageName=main/childMallThree" class="external tab-link menu3"><span class="tabbar-label">购物中心</span> <i class="icon menu-3"></i></a>
            <a href="${basePath}/intoPage.htm?pageName=main/childMallFour" class="external tab-link menu4"> <span class="tabbar-label">大药房</span><i class="icon menu-4"></i></a>
        </div>
    </div>
<#--<ul class="navList">-->
<#--<li><a href="${basePath}/intoPage.htm?pageName=main/subjectCG">茶馆</a></li>-->
<#--<li><a href="${basePath}/intoPage.htm?pageName=main/subjectJLTX">菌临天下</a></li>-->
<#--<li><a href="${basePath}/intoPage.htm?pageName=main/subjectLZH">老字号</a></li>-->
<#--</ul>-->
<#--<ul class="ul-s">-->
<#--<li>-->
<#--<a href="${basePath}/intoPage.htm?pageName=main/subjectCG"><img src="/images/v1/img/shipin_tea@2x.jpg"></a>-->
<#--</li>-->
<#--<li>-->
<#--<a href="${basePath}/intoPage.htm?pageName=main/subjectJLTX"><img src="/images/v1/img/shipin_mushroom@2xx.jpg   "></a>-->
<#--</li>-->
<#--<li>-->
<#--<a href="${basePath}/intoPage.htm?pageName=main/subjectLZH"><img src="/images/v1/img/shipin_old@2x.jpg"></a>-->
<#--</li>-->
<#--</ul>-->
</div>
<#--引入底部-->
<#--<#include "../common/new_960menu.ftl"/>-->
<#--引入搜索页-->
<#include "popupSearch.ftl">
<script type="text/javascript">
    (function(doc, win) {
        var docEl = doc.documentElement,
                resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
                recalc = function() {
                    var clientWidth = docEl.clientWidth;
                    if (!clientWidth) return;
                    docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
                };
        if (!doc.addEventListener) return;
        win.addEventListener(resizeEvt, recalc, false);
        doc.addEventListener('DOMContentLoaded', recalc, false);
    })(document, window);
</script>
<script src="https://cdn.bootcss.com/Swiper/3.4.2/js/swiper.min.js"></script>
<script>
    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        paginationClickable: true
//        , autoplay: 3000
//        ,loop:true
    });
</script>
<script>
    $(function () {
        $(".bar-bottom a:eq(0)").addClass("selected");
    })
    $(".search").on("click",function(){
        $(".listWarp").css({display:"none"})
        $(".searchWarp").css({display:"block"})
    })


</script>
</body>
</html>
