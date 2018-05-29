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
</head>
<body>
<div class="listWarp">
    <div class="navbar">
        <div class="left">
            <a href="javascript:history.go(-1)" class="link"> <i class="backicon"></i></a>
        </div>
        <div class="center">食品荟萃</div>
        <div class="right"><a href="javascript:void(null)" class="link link2 search"> <i class="searchicon"></i></a></div>
    </div>
    <div style="height: 65px;"></div>
    <div class="imgWarp">
        <!-- Swiper -->
        <div class="swiper-container">
            <div class="swiper-wrapper">
                <div class="swiper-slide"><a href="http://m.ge960.com/list/5815"><img src="/images/v1/img/banner0726.png"></a></div>
                <#--<div class="swiper-slide"><a href="${basePath}/list/5777"><img src="/images/v1/img/shipin_ban@2x.jpg"></a></div>-->
            <#--<div class="swiper-slide"><a href="#"><img src="images/v1/img/mushroom_ban@2x.jpg"></a></div>-->
            </div>
            <div class="swiper-pagination"></div>
        </div>
    </div>
    <ul class="navList">
        <li><a href="${basePath}/intoPage.htm?pageName=main/subjectCG">茶馆</a></li>
        <li><a href="${basePath}/intoPage.htm?pageName=main/subjectJLTX">菌临天下</a></li>
        <li><a href="${basePath}/intoPage.htm?pageName=main/subjectLZH">老字号</a></li>
    </ul>
    <ul class="ul-s">
        <li>
            <a href="${basePath}/intoPage.htm?pageName=main/subjectCG"><img src="/images/v1/img/shipin_tea@2x.jpg"></a>
        </li>
        <li>
            <a href="${basePath}/intoPage.htm?pageName=main/subjectJLTX"><img src="/images/v1/img/shipin_mushroom@2xx.jpg   "></a>
        </li>
        <li>
            <a href="${basePath}/intoPage.htm?pageName=main/subjectLZH"><img src="/images/v1/img/shipin_old@2x.jpg"></a>
        </li>
    </ul>
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
