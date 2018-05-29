<!DOCTYPE html>
<#assign basePath=request.contextPath>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, minimal-ui">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>中国960官方商城</title>
    <link href="${basePath}/css/v1/swiper.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${basePath}/css/v1/subject.css">
    <script src="${basePath}/js/v1/jquery.min.js"></script>
    <style>
        .ul-s li{ padding: 0 5px 5px 5px;  }
        .ul-s a>img{ vertical-align: bottom;  }
        .imgWarp{ margin-bottom: 5px;}
    </style>
</head>
<body>
<div class="listWarp">
    <div class="navbar">
        <div class="left">
            <a href="javascript:history.go(-1)" class="link"> <i class="backicon"></i></a>
        </div>
        <div class="center">展览馆</div>
        <div class="right"><a href="javascript:void(null)" class="link link2 search"> <i class="searchicon"></i></a></div>
    </div>
    <div style="height: 65px;"></div>
    <div class="imgWarp">
        <!-- Swiper -->
        <div class="swiper-container">
            <div class="swiper-wrapper">
                <#--<div class="swiper-slide"><a href="http://m.fang.com/zt/wap/201705/sphc1.html?city=cq&m=home"><img src="/images/v1/img/TIM20170523165503.jpg"></a></div>-->
                <div class="swiper-slide"><a href="${basePath}/list/6017"><img src="/images/v1/img/expo_ban@2x.jpg"></a></div>
            <#--<div class="swiper-slide"><a href="#"><img src="images/v1/img/mushroom_ban@2x.jpg"></a></div>-->
            <#--<div class="swiper-slide"><a href="#"><img src="images/v1/img/mushroom_ban@2x.jpg"></a></div>-->
            </div>
            <div class="swiper-pagination"></div>
        </div>
    </div>

    <ul class="ul-s">
        <li>
            <a href="${basePath}/list/6013"><img src="${basePath}/images/v1/img/expo_bj@2x.jpg"></a>
        </li>
        <li>
            <a href="${basePath}/list/5819"><img src="${basePath}/images/v1/img/expo_nm@2x.jpg"></a>
        </li>
        <li>
            <a href="${basePath}/list/6143"><img src="${basePath}/images/v1/img/expo_sh@2x.jpg"></a>
        </li>
        <li>
            <a href="${basePath}/list/6045"><img src="${basePath}/images/v1/img/expo_sx@2x.jpg"></a>
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
<script src="${basePath}/js/v1/swiper.min.js"></script>
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
