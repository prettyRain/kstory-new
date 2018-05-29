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
    <link rel="stylesheet" href="${basePath}/css/v1/subjectSLSK.css">
    <script src="${basePath}/js/v1/jquery.min.js"></script>
</head>
<body>
<div class="listWarp">
    <div class="navbar">
        <div class="left">
            <a href="javascript:history.go(-1)" class="link"> <i class="backicon"></i></a>
        </div>
        <div class="center">狩猎时刻</div>
        <div class="right"><a href="javascript:void(null)" class="link link2 search"> <i class="searchicon"></i></a></div>
    </div>
    <div style="height: 65px;"></div>
    <div class="imgWarp">
        <!-- Swiper -->
        <div class="swiper-container">
            <div class="swiper-wrapper">
            <#if ChannelAdvers?exists && ChannelAdvers?size &gt; 0>
                <#list ChannelAdvers as ChannelAdver>
                    <div class="swiper-slide">
                        <#if ChannelAdver.adverHref?contains("item-")>
                        <#assign itemId = (ChannelAdver.adverHref)?split("-")[1] >
                        <a href="${basePath}/item/${itemId}.html">
                        <#elseif ChannelAdver.adverHref?contains("list-")>
                        <#assign listId = (ChannelAdver.adverHref)?split("-")[1] >
                        <a href="${basePath}/list/${listId}.html">
                        <#elseif ChannelAdver.adverHref?contains("http")>
                        <a href="${ChannelAdver.adverHref}">
                        <#else>
                        <a href="javascript:void(0);">
                        </#if>
                        <img alt="" src="${ChannelAdver.adverPath}">
                        </a>
                    </div>
                </#list>
            <#else>
                <div class="swiper-slide"><a href="#"><img alt="" src="images/group_banner.jpg"></a></div>
            </#if>

            </div>
            <div class="swiper-pagination"></div>
        </div>
    </div>
    <div class="zhuanti-list">
        <ul class="ul-s ul-8-s">
        <#list rushes as rush>
            <li>

                <a href="${basePath}/item/${rush.goodsProductVo.goodsInfoId}.html" class="external shf" style="width: 100%;height: 100%;display: block;">
                    <div class="leftwarp">
                        <img  src="${rush.marketing.rushs[0].mobileRushImage!''}">
                    </div>
                    <div class="rightwarp">

                        <div class="right-box1">
                            <!--<a href="javascript:void(null)">${10*rush.marketing.rushs[0].rushDiscount?number}折/ ${rush.goodsProductVo.productName}</a>-->
                            <span class="title">${rush.goodsProductVo.productName}</span>
                            <#--<span>&nbsp;&nbsp;&nbsp;&nbsp;¥${(rush.goodsProductVo.goodsInfoPreferPrice?string("0.00"))!""}&nbsp;&nbsp;&nbsp;&nbsp;</span>-->
                        </div>
                        <div class="right-box2">
                            <div class="left">
                                <span class="oldprice">&nbsp;¥${(rush.goodsProductVo.goodsInfoPreferPrice?string("0.00"))!""}&nbsp;</span>
                                <span class="newprice"><em style="padding-right: 3px;">¥</em>${((rush.marketing.rushs[0].rushDiscount?number*rush.goodsProductVo.goodsInfoPreferPrice?number)?string("0.00"))!""}</span>
                            </div>

                            <div class="right">
                                <#--<a href="${basePath}/item/${rush.goodsProductVo.goodsInfoId}.html" class="external">-->
                                    <#if rush.rushTime == '1'>
                                        <img src="${basePath}/images/qianggou1.png" id="img_${rush_index+1}">
                                    <#elseif rush.rushTime == '2'>
                                        <#if (rush.goodsProductVo.goodsInfoStock>0)>
                                            <img src="${basePath}/images/qianggou2.png" id="img_${rush_index+1}">
                                        <#else>
                                            <img src="${basePath}/images/qianggou3.png" id="img_${rush_index+1}">
                                        </#if>
                                    <#else>
                                        <img src="${basePath}/images/qianggou1.png" id="img_${rush_index+1}">
                                    </#if>
                                <#--</a>-->
                            </div>
                        </div>
                        <div class="right-box3">
                        <#--<div class="left">已售<span>500</span>件</div>-->
                            <div class="right countdown1">
                                <div class="activities" id="count${rush_index+1}">
                                    <span class="time"></span>
                                    <span class="days">00</span>天
                                    <span class="hours">00</span>时
                                    <span class="minutes">00</span>分
                                    <span class="seconds">00</span>秒
                                </div>
                            <#--<div id="end${rush_index+1}" class="end" ></div>-->
                            </div>
                        </div>
                        <div class="clearfixed"></div>
                    </div>
                    <div class="clearfixed"></div>
                </a>
                <div class="clearfixed"></div>
            </li>
            <input type="hidden" value="${rush.rushTime}" name="rushTime" id="rush${rush_index+1}">
            <input type="hidden" value="${rush.marketing.marketingBegin?string("yyyy-MM-dd HH:mm:ss")}" id="timebegin${rush_index+1}">
            <input type="hidden" class="alltimes" idattr="${rush_index+1}" value="${rush.marketing.marketingEnd?string("yyyy-MM-dd HH:mm:ss")}" id="time${rush_index+1}">
        </#list>
        </ul>
    </div>
</div>
<#--引入底部-->
<#--<#include "../common/new_960menu.ftl"/>-->
<#--引入搜索页-->
<#include "../main/popupSearch.ftl">
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
        , autoplay: 2000,
        loop:true
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
<script type="text/javascript">
    $(function () {
        $('.alltimes').each(function(index,item){
            var _this=$(item);
            var id=_this.attr("idattr");
            qianggoutime($('#time'+id).val(),$('#timebegin'+id).val(),'#count'+id,$('#rush'+id).val(),'#count'+id,id);
            if($('#rush'+id).val()==3){
                $('#count'+id).html('');
                $('#count'+id).html('活动已结束');
//                $('#count'+id).parents("li").hide();
            }
        })
        function  qianggoutime(timeend,timebegin,content,rush,end,n) {
            //alert(timeend,timebegin,content,rush,end);
            var now=Date.parse(new Date());
            var datetime;
            if(rush==1){
                datetime=timebegin;
                //$(end).html('活动未开始');
            }else if(rush==2){
                datetime=timeend;
                //$(end).html("活动进行中");
            }else if(rush==3){
                datetime=timeend;
                $(content).find('.time').html('');
                $(end).html('活动已结束');
            }
            var datestr = datetime.replace(/-/g,"/");
            var haomiao=Date.parse(new Date(datestr));
            var timeca=haomiao-now;
            var day=Math.floor(timeca/1000/60/60/24);
            timeca=timeca-day*1000*60*60*24;
            var hour=Math.floor(timeca/1000/60/60);
            timeca=timeca-hour*60*60*1000;
            var mm=Math.floor(timeca/1000/60);
            timeca=timeca-mm*60*1000;
            var ss=Math.floor(timeca/1000);
            if(day<10){
                day="0"+day;
            }
            if(hour<10){
                hour="0"+hour;
            }
            if(mm<10){
                mm="0"+mm;
            }
            if(ss<10){
                ss="0"+ss;
            }
            if(day==0&&hour==0&&mm==0&&ss==0){
                if(rush==1){
                    rush=2;
                    qianggoutime(timeend,timebegin,content,rush,end,n)
                    $("#img_"+n).attr("src","${basePath}/images/qianggou2.png");
                    return;
                }else if(rush==2){
                    $(content).html('');
                    $(end).html('活动已结束');
                    $("#img_"+n).attr("src","${basePath}/images/qianggou1.png");
                    return;
                }
            }else{
                if(rush==1){
                    $(content).find('.time').html("距离开始：");
                    $(content).find('.days').html(day);
                    $(content).find('.hours').html(hour);
                    $(content).find('.minutes').html(mm);
                    $(content).find('.seconds').html(ss);
                }else if(rush==2){
                    $(content).find('.time').html("剩余：");
                    $(content).find('.days').html(day);
                    $(content).find('.hours').html(hour);
                    $(content).find('.minutes').html(mm);
                    $(content).find('.seconds').html(ss);
                }else if(rush==3){
                    $(content).html('');
                    $(end).html('活动已结束');
                    return;
                }
                //在jquery中这样用
                window.setTimeout(function(){qianggoutime(timeend,timebegin,content,rush,end,n)},1000);
            }
        }
        //抢购时间
    })

//    $(".zhuanti-list li a").on("click",function(e){
//        e && e.preventDefault?e.preventDefault():window.event.returnValue = false;
//        $(".zhuanti-list li").css({"background":"#fff"});
//        $(this).parents("li").css({"background":"#eaeaea"});
//        window.location.href=$(this).attr("href");
//    })




</script>
</body>
</html>
