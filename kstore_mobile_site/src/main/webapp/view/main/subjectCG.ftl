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
    <link rel="stylesheet" href="${basePath}/css/v1/subjectCG.css">
    <script src="${basePath}/js/v1/jquery.min.js"></script>
</head>
<style>
    .ul-s li .title {
        background: #fff;
        font-size: 12px;
        border-radius: 0 0 8px 8px;
        padding: .2rem .05rem .2rem .1rem;
</style>
<body>
<div class="listWarp">
    <div class="navbar">
        <div class="left">
            <a href="javascript:history.go(-1)" class="link backicon"></a>
        </div>
        <div class="center">茶馆</div>
        <div class="right"><a href="javascript:void(null)" class="link link2 search"> <i class="searchicon"></i></a></div>
    </div>
    <div style="height: 65px;"></div>
    <#--页面商品信息-->
    <div class="zhuanti-list">
        <ul class="seleted-tab">
            <li><a href="${basePath}/list/6171">茶具套组</a></li>
            <li><a href="${basePath}/list/6171">茶道配件</a></li>
            <li><a href="${basePath}/list/6157">十大名茶</a></li>
            <li><a href=""></a></li>
        </ul>
        <span class="filter-icon1"></span>
        <ul class="ul-s">
            <li>
                <a href="${basePath}/list/6171"><img class="showImg" src="${basePath}/images/v1/img/tea_view@2x.png"></a>
                <div class="title">
                    <a class="left" href="/list/6171">品茗者尽享茶趣，啜饮一口，齿颊留香。</a>
                  <#--  <a class="right" href="/list/6171"><img src="/images/v1/img/brandIcon1@2x.jpg"></a>-->
                    <div class="clearfixed"></div>
                </div>
            </li>
            <li>
                <a href="http://m.ge960.com/searchProduct.htm?keyWords=小康&storeId=0"><img class="showImg" <img src="${basePath}/images/v1/img/tea_view@2x1.png"></a>
                <div class="title">
                    <a class="left" href="http://m.ge960.com/searchProduct.htm?keyWords=小康&storeId=0">自然野生纯香，珍品只留给懂茶的人。</a>
                <#--    <a class="right" href="/list/6171"><img src="${basePath}/images/v1/img/brandIcon2@2x.jpg"></a>-->
                    <div class="clearfixed"></div>
                </div>
            </li>
            <#--<div class="clearfixed"></div>-->
        </ul>
    </div>
    <#--筛选-->
    <div class="filterPlate">
        <div class="filter-title">
            <div class="tea-title">筛选<span class="filter-icon2"></span></div>
        </div>
        <div class="tea-title">茶具</div>
        <ul>
            <li><a href="${basePath}/item/7663.html">宜兴紫砂</a></li>
            <li><a href="${basePath}/item/7417.html">景德镇瓷器</a></li>
            <li><a href="${basePath}/item/7419.html">德化白瓷</a></li>
            <li><a href="${basePath}/item/7421.html">唐山陶瓷</a></li>
            <li><a href="${basePath}/item/7423.html">玻璃器皿</a></li>
            <li><a href="${basePath}/item/7427.html">铁器茶具</a></li>
            <li><a href="${basePath}/item/7411.html">茶具配件</a></li>
            <li><a href="${basePath}/item/7425.html">茶卓茶几</a></li>
            <li><a href="${basePath}/list/6171.html">其他茶具</a></li>
            <div class="clearfixed"></div>
        </ul>
        <div class="tea-title">茶叶</div>
        <ul>
            <li><a href="${basePath}/item/7313.html">西湖龙井</a></li>
            <li><a href="${basePath}/item/7317.html">洞庭碧螺春</a></li>
            <li><a href="${basePath}/searchProduct.htm?keyWords=正山小种&storeId=0">正山小种</a></li>
            <li><a href="${basePath}/item/7319.html">云南普洱</a></li>
            <li><a href="${basePath}/item/7323.html">六安瓜片</a></li>
            <li><a href="${basePath}/item/7347.html">黄山毛峰</a></li>
            <li><a href="${basePath}/item/7311.html">祁门红茶</a></li>
            <li><a href="${basePath}/item/7321.html">信阳毛尖</a></li>
            <li><a href="${basePath}/searchProduct.htm?keyWords=铁观音&storeId=0">安溪铁观音</a></li>
            <li><a href="${basePath}/searchProduct.htm?keyWords=岩茶&storeId=0">武夷岩茶</a></li>
            <li><a href="${basePath}/item/7327.html">庐山云雾</a></li>
            <li><a href="${basePath}/item/7343.html">台湾乌龙</a></li>
            <li><a href="${basePath}/item/7325.html">潮州单枞</a></li>
            <li><a href="${basePath}/item/6159.html">福鼎白茶</a></li>
            <li><a href="${basePath}/item/7329.html">蒙顶黄牙</a></li>
            <li><a href="${basePath}/item/7339.html">蒙顶甘露</a></li>
            <li><a href="${basePath}/item/7331.html">太平猴魁</a></li>
            <li><a href="${basePath}/item/7341.html">君山银针</a></li>
            <div class="clearfixed"></div>
        </ul>
    </div>
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
//        , autoplay: 1000
    });
</script>
<script>
    $(function () {
        $(".bar-bottom a:eq(0)").addClass("selected");
    })
    $(".search").on("click",function(){
        $(".listWarp").css({display:"none"});
        $(".searchWarp").css({display:"block"});
    })
    $(".filter-icon1").on("click",function(){
        $(".zhuanti-list").css({display:"none"});
        $(".filterPlate").css({display:"block"});

    })
    $(".filter-icon2").on("click",function(){
        $(".filterPlate").css({display:"none"});
        $(".zhuanti-list").css({display:"block"});
    })
</script>
</body>
</html>
