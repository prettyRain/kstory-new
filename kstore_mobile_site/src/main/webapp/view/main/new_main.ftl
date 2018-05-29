<#assign basePath=request.contextPath>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, minimal-ui">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>中国960官方商城</title>
    <link rel="stylesheet" href="${basePath}/css/ui-dialog.css">
    <link rel="stylesheet" type="text/css" href="${basePath}/css/v2/framework7.ios.min.css">
    <link rel="stylesheet" type="text/css" href="${basePath}/css/v2/framework7.ios.colors.min.css">
    <#--<link rel="stylesheet" type="text/css" href="${basePath}/css/v2/swiper.min.css"/>-->
    <link href="${basePath}/css/v3/swiper.css" rel="stylesheet">
    <#--针对搜索的功能调整-->
    <#--<link rel="stylesheet" type="text/css" href="${basePath}/css/v1/css/popup.css">-->
    <link rel="stylesheet" type="text/css" href="${basePath}/css/v2/index.css?timestamp=1524885061">
    <link rel="stylesheet" type="text/css" href="${basePath}/css/v3/index_3.css?timestamp=1524885062">
    <script type="text/javascript" src="${basePath}/js/v1/jquery.min.js"></script>
    <script type="text/javascript" src="${basePath}/js/v1/framework7.min.js"></script>
    <script src="http://api.map.baidu.com/api?v=2.0&amp;ak=ItDz5Ey45vZKcyhGCtPCB2L3xzzpkjNN"></script>
    <script src="http://api.map.baidu.com/getscript?v=2.0&amp;ak=ItDz5Ey45vZKcyhGCtPCB2L3xzzpkjNN&amp;services=&amp;" type="text/javascript"></script>
</head>
<body>
<div class="views">
    <div class="view view-main">
        <div class="navbar">
             <div class="search_bg scrollBefore">
                 <div class="innerBg"></div>
                <div class="navbar-inner">
                    <div class="left position" onclick="_czc.push(['_trackEvent', '首页', '定位城市', '定位城市','0','main_city']);"><span id="defaultcity"><#if city??>${city.cityName}</#if></span><input type="hidden" id="positioncity" value=""><b></b></div>
                    <#--<div class="center sliding logo open-about">-->
                        <#--<p class="searchbar"></p>-->
                        <#--&lt;#&ndash;<img class="seach" src="../../images/v2/logo@2x2.png" alt=""/>&ndash;&gt;-->
                    <#--</div>-->
                    <div class="center sliding indexsearch">
                        <a href="#" class="open-about" onclick="_czc.push(['_trackEvent', '首页', '搜索', '搜索','0','main_search']);">
                            <input type="text" class="searcho" value="" readonly="readonly"  placeholder="搜索960商品 按类别 按属性">
                            <input type="text" class="search" value="" readonly="readonly"  placeholder="搜索960商品 按类别 按属性">
                            <i class="icon icon-bars"></i>
                        </a>
                    </div>
                    <#--<div class="right search open-about">-->
                        <#--<a href="javascript:;" data-panel="right"  class="link icon-only open-panel external"><i class="icon icon-bars"></i></a>-->
                    <#--</div>-->
                    <div class="right message" onclick="_czc.push(['_trackEvent', '首页', '消息', '消息','0','main_message']);">
                        <a href="${basePath}/customers/notice.htm?mark=0" data-panel="right"  class="link icon-only open-panel external">
                            <i class="icon icon-bars">
                            <#if noticeCount &gt; 0>
                                <b class="remindMsg"></b>
                            </#if>
                            </i>
                        </a>
                    </div>
                </div>
            </div>
            <#--头部导航-->
            <div class="sheadwarp">
                <div class="shead scrollBefore" id="shead">
                    <div class="swiper-wrapper">
                    <#list topTitles?split(";") as fileName>
                        <#if fileName_index != 0>
                            <div class="swiper-slide" index="${fileName?split("-")[0]}" onclick="_czc.push(['_trackEvent', '首页', '推荐分类', '${fileName?split("-")[1]}','0','${fileName?split("-")[0]}']);">${fileName?split("-")[1]}<i></i></div>
                        </#if>
                    </#list>
                    </div>
                </div>
                <#--<img class="vague" src="../../images/v3/Rectangle%203@2x.png"/>-->
            </div>
        </div>
        <div class="page-content">
            <div class="content-block">
                <#--改版3开始-->
                    <div class="sbodywarp">
                        <div class="sbody" id="sbody">
                            <div class="swiper-wrapper">
                                <div class="swiper-slide bodyslide bodyslide0" id="bodyslide">
                                    <!--首页推荐开始-->
                                    <div class="pro-detail">
                                        <#--<div class="navbarBg" style=""></div>-->
                                        <div class="lunbowarp">
                                            <div class="lunbos swiper-container">
                                                <div class="swiper-wrapper">
                                                    <#--<div class="swiper-slide"><a href="#"><img src="http://boss.ge960.com:80/upload/20171201/1512122918372.jpg" /></a></div>-->
                                                    <#--<div class="swiper-slide"><a href="#"><img src="http://boss.ge960.com:80/upload/20171201/1512122900237.jpg" /></a></div>-->
                                                    <#--<div class="swiper-slide"><a href="#"><img src="http://boss.ge960.com:80/upload/20171201/1512122881137.jpg" /></a></div>-->
                                                </div>
                                                <div class="swiper-pagination spagination1"></div>
                                            </div>
                                        </div>
                                        <div class="main-column">
                                            <#--<a href="#" class="external"><img src="../../images/v3/btn_shoulieshike@2x.png" /></a>-->
                                            <#--<a href="#" class="external"><img src="../../images/v3/btn_shoulieshike@2x.png" /></a>-->
                                        </div>
                                        <div class="sec-column">
                                            <#--<a href="#" class="external endways">-->
                                                <#--<img src="../../images/v3/blank_zhanlanguan@2x.png">-->
                                            <#--</a>-->
                                            <#--<a href="#" class="external transversely1">-->
                                                <#--<img src="../../images/v3/blank_chaguan@2x.png">-->
                                            <#--</a>-->
                                            <#--<a href="#" class="external transversely2">-->
                                                <#--<img src="../../images/v3/blank_laozihao@2x.png">-->
                                            <#--</a>-->
                                            <#--<div class="clearfixed"></div>-->
                                        </div>
                                        <#--楼层开始-->
                                        <#--<div class="floor">-->
                                            <#--<a href="#" class="external floor-banner"><img src="../../images/v3/btn_shuiguozhuanqu@2x.png"></a>-->
                                            <#--<div class="floor-swiper" id="floor-swiper">-->
                                                <#--<div class="swiper-wrapper">-->
                                                    <#--<div class="swiper-slide">-->
                                                        <#--<a href="#" class="external">-->
                                                            <#--<img class="lazy" data-original="../../images/good_6.jpg">-->
                                                            <#--<p class="title">大苹果大苹果大苹果大苹果大苹果大苹果大苹果大苹果</p>-->
                                                            <#--<p class="price">￥<span>786</span>.50</p>-->
                                                        <#--</a>-->
                                                        <#--<span class="cart" onclick="addShoppingCart(this,'7861')"><img src="../../images/v3/btn_shopping%20cart@2x.png"></span>-->
                                                    <#--</div>-->
                                                <#--</div>-->
                                            <#--</div>-->
                                        <#--</div>-->

                                    </div>
                                    <!--首页推荐结束-->
                                </div>
                                <#--<div class="swiper-slide bodyslide"><div class="loading"><img src="../../images/v3/loading2.gif"></div></div>-->
                                <#--<div class="swiper-slide bodyslide"><div class="loading"><img src="../../images/v3/loading2.gif"></div></div>-->
                                <#--<div class="swiper-slide bodyslide"><div class="loading"><img src="../../images/v3/loading2.gif"></div></div>-->
                                <#--<div class="swiper-slide bodyslide"><div class="loading"><img src="../../images/v3/loading2.gif"></div></div>-->
                                <#--<div class="swiper-slide bodyslide"><div class="loading"><img src="../../images/v3/loading2.gif"></div></div>-->
                                <#--<div class="swiper-slide bodyslide"><div class="loading"><img src="../../images/v3/loading2.gif"></div></div>-->
                                <#--<div class="swiper-slide bodyslide"><div class="loading"><img src="../../images/v3/loading2.gif"></div></div>-->
                                <#--<div class="swiper-slide bodyslide"><div class="loading"><img src="../../images/v3/loading2.gif"></div></div>-->
                                <#--<div class="swiper-slide bodyslide"><div class="loading"><img src="../../images/v3/loading2.gif"></div></div>-->
                                <#--<div class="swiper-slide bodyslide"><div class="loading"><img src="../../images/v3/loading2.gif"></div></div>-->
                            </div>
                        </div>
                    </div>
                <#--改版3结束-->
            </div>
        </div>
    <#--活动开始    -->
    <#--<div class="activewarp">-->
        <#--<div class="zqactive">-->
            <#--<div class="zqwarp">-->

                <#--<img class="zqimg" style="width:5.68rem;height:4.66rem;" src="../../images/v3/yd_activity/logo@2x.png"/>-->
                <#--<p class="external btn" onclick="openactive()"></p>-->
                <#--&lt;#&ndash;<a href="#" class="external" onclick="zqclose()">&ndash;&gt;-->
                <#--<img class="zqclose" onclick="zqclose()" src="../../images/v3/yd_activity/btn_close@2x.png"  /></a>-->
            <#--</div>-->
        <#--</div>-->
    <#--</div>-->
    <#--活动结束    -->
    <#--引入底部-->
        <div class="toolbar tabbar tabbar-labels"><#include "../common/new_960menu_index.ftl"/></div>
    </div>
</div>
${mobIndexHtml}
<#--引入搜索页面-->
<#include 'popup.ftl'>
<#include 'citychange.ftl'>
<input type="hidden" class="ch_distinctId" value="${distinctId}"  />

<#--<script src="${basePath}/js/v1/arouse-app.js"  type="text/javascript"></script>-->
<#--<script src="${basePath}/js/v1/swipe.js"  type="text/javascript"></script>-->
<#--<script src="${basePath}/js/v2/index.js"  type="text/javascript"></script>-->
<script src="${basePath}/js/dialog-min.js"></script>
<script src="${basePath}/js/tip-newbox.js"></script>
<script src="${basePath}/js/v3/swiper.js"></script>
<script src="${basePath}/js/v3/citychange_2.js"></script>
<script src="${basePath}/js/v3/jquery.lazyload.js"></script>
<script>
    //定位城市
    if(!sessionStorage.getItem("citychange")){
        baiduPosition(35);
        sessionStorage.setItem("citychange", "yes");
    }
    //中秋元旦活动
    <#--var zqactive = sessionStorage.getItem("zqactive");-->
    <#--if(zqactive == null ){-->
        <#--$(".activewarp").show();-->
        <#--$("body").bind("touchmove",function(e){-->
            <#--e.preventDefault();-->
        <#--});-->
    <#--}-->
    <#--if($(".activewarp").css("display") == "block"){-->
        <#--$("body").bind("touchmove",function(e){-->
            <#--e.preventDefault();-->
        <#--});-->
    <#--}-->
    <#--&lt;#&ndash;${basePath}/loginm.html?url=/customercenter.html&ndash;&gt;-->
    <#--function zqclose(){-->
        <#--$(".activewarp").hide();-->
        <#--sessionStorage.setItem("zqactive", "yes");-->
        <#--$("body").unbind("touchmove");-->
        <#--//定位城市-->
        <#--if(!sessionStorage.getItem("citychange")){-->
            <#--baiduPosition(35);-->
            <#--sessionStorage.setItem("citychange", "yes");-->
        <#--}-->

    <#--}-->
    <#--function openactive(){-->
            <#--$(".activewarp").hide();-->
            <#--sessionStorage.setItem("zqactive", "yes");-->
            <#--$("body").unbind("touchmove");-->
        <#--window.location.href="${basePath}/loginm.html?url=/customercenter.html"-->
    <#--}-->
</script>
<script src="${basePath}/js/v3/index_3.js?timestamp=1524885061"  type="text/javascript"></script>
<p style="display: none;">
    <!--友盟CNZZ统计-->
    <script src="https://s13.cnzz.com/z_stat.php?id=1264375679&web_id=1264375679" language="JavaScript">
        //声明_czc对象:
        var _czc = _czc || [];
        //绑定siteid，请用您的siteid替换下方"XXXXXXXX"部分
        _czc.push(["_setAccount", "m.ge960.com"]);
    </script>
</p>
</body>
</html>

