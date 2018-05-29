
<!DOCTYPE html>
<#assign basePath=request.contextPath>
<html>


<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, minimal-ui">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>中国960官方商城</title>
    <link rel="stylesheet" href="${basePath}/css/v1/css/mall.css">
    <link rel="stylesheet" href="${basePath}/css/v1/css/css.css">
    <link rel="stylesheet" href="${basePath}/css/v1/css/foot.css">
<#--针对搜索的功能调整-->
    <link rel="stylesheet" href="${basePath}/css/v1/css/popup.css">
<#include "app.ftl">

</head>
<body >
<#--<div class="views">-->
    <div class="view view-main">
        <div class="navbar zhuangti-navbar" style="position: fixed;left: 0;top: 0;">
            <div class="navbar-inner">
                <div class="left"><a href="javascript:history.go(-1)" class="back link"> <i class="icon icon-back"></i><span></span></a></div>
                <div class="center sliding">狩猎时刻</div>
                <div class="right">
                    <a href="#"  class="open-about link icon-only"> <i class="icon icon-bars"></i></a>
                </div>
            </div>
        </div>
        <div id="zhuangti" class="pages navbar-through toolbar-through">
            <div data-page="zhuanti" class="page">
                <div class="page-content zhuangti8" >
                <#--轮播banner-->
                    <div id="homePromote" class="pagingArea">
                        <header>
                            <div id="slider" class="swipe" style="visibility: visible;">
                                <div class="swipe-wrap" id="bannerDIV">
                                    <figure>
                                        <div class="wrap">
                                            <a href="javascript:void(0);" class="external"><img src="/images/v1/img/xianshi_ban@2x.jpg"></a>
                                        </div>
                                    </figure>
                                <#--<figure>
                                    <div class="wrap">
                                        <a href="javascript:void(0);" class="external"><img src="/images/v1/img/spr_ban@2x.jpg"></a>
                                    </div>
                                </figure>
                                <figure>
                                    <div class="wrap">
                                        <a href="javascript:void(0);" class="external"><img src="/images/v1/img/spr_ban@2x.jpg"></a>
                                    </div>
                                </figure>-->
                                </div>
                            </div>
                            <nav>
                                <ul id="position">
                                    <li class="on"></li>
                                <#--  <li></li>
                                  <li></li>-->
                                </ul>
                            </nav>
                        </header>
                    </div>
                    <div class="zhuanti-list">
                        <ul class="ul-s ul-8-s">
                            <li>
                                <div class="left"><img class="mark-img" src="${basePath}/images/v1/img/85.png"><a href="#"><img src="${basePath}/images/v1/img/82.png"></a></div>
                                <div class="right">
                                    <div class="right-box1">
                                        <a href="#">休闲零食专场</a>
                                        <span>买二赠一</span>
                                    </div>
                                    <div class="right-box2">
                                        <div class="left">￥<span>49.90</span></div>
                                        <div class="right"><a href="#"><img src="${basePath}/images/v1/img/84.png"></a></div>
                                    </div>
                                    <div class="right-box3">
                                        <div class="left">已售<span>500</span>件</div>
                                        <div class="right countdown">
                                            <div class="activities"><img src="${basePath}/images/v1/img/83.png"> <span class="days">00</span>天<span class="hours">00</span>:<span class="minutes">00</span>:<span class="seconds">00</span></div>
                                            <div class="end">活动已结束</div>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div class="left"><img class="mark-img" style="display:block;" src="${basePath}/images/v1/img/85.png"><a href="#"><img src="${basePath}/images/v1/img/82.png"></a></div>
                                <div class="right">
                                    <div class="right-box1">
                                        <a href="#">休闲零食专场</a>
                                        <span>买二赠一</span>
                                    </div>
                                    <div class="right-box2">
                                        <div class="left">￥<span>49.90</span></div>
                                        <div class="right">
                                            <a href="#">
                                                <img src="${basePath}/images/v1/img/84.png">
                                            </a>
                                        </div>
                                    </div>
                                    <div class="right-box3">
                                        <div class="left">已售<span>500</span>件</div>
                                        <div class="right countdown1">
                                            <div class="activities">
                                                <img src="${basePath}/images/v1/img/83.png">
                                                <span class="days">00</span>天<span class="hours">00</span>:<span class="minutes">00</span>:<span class="seconds">00</span>
                                            </div>
                                            <div class="end">活动已结束</div>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div class="left"><img class="mark-img" style="display:block;" src="${basePath}/images/v1/img/85.png"><a href="#"><img src="${basePath}/images/v1/img/82.png"></a></div>
                                <div class="right">
                                    <div class="right-box1">
                                        <a href="#">休闲零食专场</a>
                                        <span>买二赠一</span>
                                    </div>
                                    <div class="right-box2">
                                        <div class="left">￥<span>49.90</span></div>
                                        <div class="right"><a href="#"><img src="${basePath}/images/v1/img/84.png"></a></div>
                                    </div>
                                    <div class="right-box3">
                                        <div class="left">已售<span>500</span>件</div>
                                        <div class="right countdown1">
                                            <div class="activities"><img src="${basePath}/images/v1/img/83.png"> <span class="days">00</span>天<span class="hours">00</span>:<span class="minutes">00</span>:<span class="seconds">00</span></div>
                                            <div class="end">活动已结束</div>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    <#include "childMenu.ftl">
    </div>
<#--</div>-->
<#--引入底部按钮-->
<#include "popup.ftl">
</body>
<script src="${basePath}/js/v1/swipe.js"  type="text/javascript"></script>
<script type="text/javascript">
    var slider = Swipe(document.getElementById('slider'), {
        auto: 3000,
        continuous: true,
        callback: function(pos) {

            var i = bullets.length;
            while (i--) {
                bullets[i].className = ' ';
            }
            bullets[pos].className = 'on';

        }
    });
    var bullets = document.getElementById('position').getElementsByTagName('li');

</script>
</html>