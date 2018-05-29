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
        <div class="center">饮品总汇</div>
        <div class="right"><a href="javascript:void(null)" class="link link2 search"> <i class="searchicon"></i></a></div>
    </div>
    <div style="height: 65px;"></div>
    <div class="imgWarp">
        <!-- Swiper -->
        <div class="swiper-container">
            <div class="swiper-wrapper">
                <div class="swiper-slide"><a href="${basePath}/list/6279"><img src="/images/v1/img/yinpin_ban@2x.jpg"></a></div>
            <#--<div class="swiper-slide"><a href="#"><img src="images/v1/img/mushroom_ban@2x.jpg"></a></div>-->
            <#--<div class="swiper-slide"><a href="#"><img src="images/v1/img/mushroom_ban@2x.jpg"></a></div>-->
            </div>
            <div class="swiper-pagination"></div>
        </div>
    </div>
    <ul class="navList">
        <li><a href="${basePath}/intoPage.htm?pageName=main/subjectSMZY">生命之源</a></li>
        <li><a href="${basePath}/intoPage.htm?pageName=main/subjectHJZY">红酒庄园</a></li>
        <li><a href="${basePath}/intoPage.htm?pageName=main/subjectGJMJL">国际名酒廊</a></li>
    </ul>
    <ul class="ul-s">
        <li>
            <a href="${basePath}/intoPage.htm?pageName=main/subjectSMZY"><img src="/images/v1/img/yinpin_1@2x.png"></a>
        </li>
        <li>
            <a href="${basePath}/intoPage.htm?pageName=main/subjectHJZY"><img src="/images/v1/img/wine_ban@2x11.png"></a>
        </li>
        <li>
            <a href="${basePath}/intoPage.htm?pageName=main/subjectGJMJL"><img src="/images/v1/img/yinpin_3@2x.png"></a>
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
//        , autoplay: 1000
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
