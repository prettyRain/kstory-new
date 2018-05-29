<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="Keywords" content="${topmap.seo.meteKey}">
    <meta name="description" content="${topmap.seo.meteDes}">
<#assign basePath=request.contextPath>
    <title>${topmap.systembase.bsetName}</title>
<#--<link rel="stylesheet" type="text/css" href="${basePath}/css/base.min.css" />-->
    <link rel="stylesheet" type="text/css" href="${basePath}/css/style.css" />
    <link rel="stylesheet" type="text/css" href="${basePath}/css/index.css" />
<#if (topmap.systembase.bsetHotline)??>
    <link rel = "Shortcut Icon" href="${(topmap.systembase.bsetHotline)!''}">
<#else>
    <link rel = "Shortcut Icon" href="${basePath}/images/Paistore.ico">
</#if>
    <link rel="stylesheet" type="text/css" href="${basePath}/index_two/css/header.css" />
    <link rel="stylesheet" href="${basePath}/css/hunting_moment.css">
    <style type="text/css">
        .yi_over{background: Gray;}
    </style>
    <style>
        body {
            font-family: "Helvetica Neue", "Helvetica", "tahoma", "arial", "\5FAE\8F6F\96C5\9ED1", "\5b8b\4f53"!important;
            font-size: 12px;
            color: #666;
        }
        body,html{ background: #fff!important; }
        .content-wp {
            width: 1090px;
            margin: 0 auto;
        }
        .container{ width: 1200px; margin: 0px auto;}
        a{color:#666;}
        .show-boxbb {
            position: relative;
            height: 500px;
        }


        /*.greyBg {
            background: #f2f2f2;
            padding: 25px 0;
            margin-left: 11px;
        }
        .greyBg .listContainer {

            width: 1208px;
            margin: 0px auto;
        }

        .ul_list {
            overflow: hidden;
            display: none;
            width: 1220px;
            margin-top:10px;
        }

        .ul_list li {
            float: left;
            width: 226px;
            margin-right: 14px;
            background: #fff;
            border: 1px #eaeaea solid;
            padding-bottom: 10px;
            height: 330px;
        }

        .ul_list.on {
            display: block;
        }

        .ul_list li:hover {
            border: 1px solid #37ab40;
        }

        .ul_list li img {
            width: 226px;
            height: 226px;
            display: block;
            margin: 0 auto;
        }

        .ul_list a span {
            display: block;
            height: 48px;
            line-height: 24px;
            font-size: 15px;
            text-align: left;
            padding: 0 5px;
            overflow: hidden;
        }
        .ul_list .cx_qg{
            height:30px;
            margin-top:6px;
            padding: 0 5px;
        }
        .ul_list .cx_qg .img{
            width: 20px;
            height: 20px;
            margin: 0;
            display: inline-block;
        }
        .ul_list .cx_qg p{
            display: inline-block;
            !*  color: #f36b19; *!


        }
        .ul_list .cx_qg span{
            font-size: 16px;
            display: inline-block;
            line-height: 10px;
            color: #f36b19;

        }

        .ul_list .cx_yj {
            color: #ff5500;
            font-size: 12px;
            text-align: left;
            padding: 0px 5px 5px 0px;
            position: relative;
        }
        .ul_list .cx_yj strong {
            font-size: 20px;
            font-weight: normal;
        }

        .ul_list .cx_yj a {
            position: absolute;
            right: 5px;
            bottom: 5px;
            line-height: 22px;
            font-size: 12px;
            color: #fff;
            text-align: center;
            width: 70px;
            height: 22px;
            background: #35a400;
        }

        .ul_list .cx_yj i {
            font-style: normal;
            text-decoration: line-through;
            color: #ffa169;
            padding-left: 5px;
        }*/

        /*新的抢购页面*/

        .show-boxbb #slidesbb {
            width: 100%;
            height: 500px;
            position: absolute;
            top: 0;
            right: auto;
            bottom: auto;
            left: 0;
            z-index: 90
        }

        .show-boxbb #slidesbb .slide {
            display: block;
            width: 100%;
            height: 500px;
            background-repeat: no-repeat;
            background-position: center top
        }

        .show-boxbb #slidesbb .slidesjs-pagination {
            position: absolute;
            top: auto;
            right: auto;
            bottom: 10px;
            left: 0;
            width: 100%;
            text-align: center!important;
            z-index: 99
        }

        .show-boxbb #slidesbb .slidesjs-pagination li {
            display: inline-block;
            *display: inline;
            *zoom: 1;
            vertical-align: middle;
            margin: 0 5px
        }

        .show-boxbb #slidesbb .slidesjs-pagination li a {
            display: inline-block;
            *display: inline;
            *zoom: 1;
            vertical-align: middle;
            width: 8px;
            height: 8px;
           /* background: rgba(0,0,0,0.3);*/
            background: none;
            border: 1px solid #ffffff;
            border-radius: 50%;
            color: #fff;
            text-indent: -999999px
        }

        .slidesjs-pagination li{
            float: none;
        }
        .show-boxbb #slidesbb .slidesjs-pagination li a.active {
            background: #ffffff;
        }
        .brandList .title{
            color: #333;
            text-align: center;
            font-size: 24px;
            padding: 30px 0;
        }
        .proIntro{
            width: 1090px;
            margin-bottom: 20px;
            border: 1px solid #e3e3e3;
            box-shadow: 1px 1px 4px #e3e3e3;
            background: #fff;
            position: relative;
        }
        .proLeft{
            width: 590px;
            float: left;
        }
        .proLeft a{
            display: block;
            height: 338px;
            width: 588px;
        }
        .proRight{
            width: 465px;
            float: right;
            margin-right: 19px;
        }
        .flagBox{
            /*         padding: 20px 0px;*/
            /* border-bottom: 1px dashed #dddddd;*/
            /*//background: url(images/time.jpg) no-repeat left center;*/
            font-size: 16px;
            color: #333;
            padding-left: 48px;
            float: left;
            margin-top: -19px;
        }
        .numtimer{
            display: inline-block;
            *display: inline;
            *zoom:1;
            font-size: 12px;
            color: #f0375e;
            font-weight: bold;
        }
        .flagCon .flagtit{
            font-size: 16px;
            color: #f0375e;
            padding-top: 20px;
            height: 18px;

        }
        .flagCon .pro_des{
            font-size: 14px;
            color: #666;
            line-height: 24px;
            word-wrap: break-word;
            word-break: break-all;
            height: 80px;
            margin-top: 25px;
        }
        .bigPrice{
            font-family: "Verdana";
            font-size: 36px;
            color: #db5858;
        }
        .bigPrice em{
            font-size: 20px;
        }
        .p-original{
            font-size: 12px;
            font-family: "Verdana";
            text-decoration: line-through;
        }
        .flagPri{
            position: relative;
        }
        .flagPri a{
            display: inline-block;
            *display:inline;
            *zoom:1;
            width: 120px;
            height: 36px;
            color: #fff;
            background: #f0375e;
            font-size: 16px;
            line-height: 36px;
            text-align: center;
            position: absolute;
            right: 0;
            bottom: -2px;
            border-radius: 4px;
        }
        .flagPri a:hover{
            color: #fff;
        }
        .advanceTip{
            font-size: 16px;
        }
        .advanceTip span{
            color: #f0375e;
        }
        .proIntro:hover{
            box-shadow:0 2px 17px rgba(000,000,000,.3);
        }
        .pro_column{
            width: 348px;
            height: 494px;
            float: left;
            margin-right: 19px;
            border: 1px solid #e3e3e3;
            box-shadow: 1px 1px 4px #e3e3e3;
            background: #fff;
            margin-bottom: 20px;
        }
        .pro_column:hover{
            box-shadow:0 2px 17px rgba(000,000,000,.3);
        }
        .pro_column .proImg{
            display: block;
            height: 348px;
            width: 348px;
            position: relative;
        }
        .pro_column .m-over{
            display: block;
            position: absolute;
            top:105px;
            left:105px;
            z-index: 99;
        }
        .pro_column .proName{
            font-size: 14px;
            line-height: 22px;
            padding: 15px 20px;
        }
        .pro_column .proName span{
            color: #f0375e;
        }
        .pro_column .proName a{
            display: block;
            height: 44px;
            overflow:hidden;
        }
        .flagPri a.small{
            width: 100px;
            height: 30px;
            line-height: 30px;
            margin-top: -2px;
        }
        .proTime em{
            color: #f0375e;
        }
        .proTime .numtimer{ font-size: 12px; font-weight: bold;}
        /*返回顶部样式*/
        .side_tools {
            width: 40px;
            background: #fff;
            position: fixed;
            right: 20px;
            display: none;
        }

        .backtotop {
            border: 1px solid #ddd;
            cursor: pointer;
            display: block;
            width: 38px;
            height: 33px;
            text-align: center;
        }

        .backtotop em {
            display: none;
        }

        .backtotop b {
            display: block;
            width: 38px;
            height: 33px;
            background: url(images/backtotop.gif) no-repeat;
        }

        .backtotop:hover b {
            display: none;
        }

        .backtotop:hover em {
            display: block;
            padding: 3px 5px;
            line-height: 14px;
            color: #fff !important;
            background: #f0375e;
        }

        .mt30 {
            margin-top: 30px;
        }
        .paging a:hover{background:#df1738;border-color:#df1738;}
        .paging{margin-right:-12px;}
        .footer_tab{
            background:#ffffff;
            margin-top:0;
        }
    </style>
</head>
<body>
<#--一引入头部 <#include "/index/topnew.ftl" /> -->
<#if (topmap.temp)??>
    <#if (topmap.temp.tempId==1)>
        <#include "../index/topnew.ftl">
    <#elseif (topmap.temp.tempId==3)>
        <#include "../index/newheader.ftl">
    <#elseif (topmap.temp.tempId==9)>
        <#include "../index/newheader4.ftl">
    <#elseif (topmap.temp.tempId==10)>
        <#include "../index/newheader5.ftl">
    <#elseif (topmap.temp.tempId==11)>
        <#include "../index/newheader6.ftl">
    <#elseif (topmap.temp.tempId==12)>
        <#include "../index/newheader7.ftl">
    <#elseif (topmap.temp.tempId==13)>
        <#include "../index/newheader8s.ftl">
    <#elseif (topmap.temp.tempId==14)>
        <#include "../index/newheader9.ftl">
    <#elseif (topmap.temp.tempId==15)>
        <#include "../index/newheader10.ftl">
    <#elseif (topmap.temp.tempId==16)>
        <#include "../index/newheader11.ftl">
    <#elseif (topmap.temp.tempId==17)>
        <#include "../index/newheader12.ftl">
    <#elseif (topmap.temp.tempId==18)>
        <#include "../index/newheader13.ftl">
    <#elseif (topmap.temp.tempId==19)>
        <#include "../index/newheader14.ftl">
    <#elseif (topmap.temp.tempId==20)>
        <#include "../index/newheader15.ftl">
    <#elseif (topmap.temp.tempId==21)>
        <#include "../index/newheader21.ftl">
    <#else>
        <#include "../index/newheader3.ftl">
    </#if>
</#if>


<div class="show-boxbb">
    <div id="slidesbb">
    <#if avc?? && (avc?size>0)>
        <#list avc as bigAdvert>
    <#--<a class="slide" href="${bigAdvert.adverHref}" style="background-image:url(http://tboss.ge960.com:80/upload/20170321/1490060983896.jpg);"></a>-->
        <a class="slide" href="${bigAdvert.adverHref!''};" style="background-image:url(${bigAdvert.adverPath!''});"></a>
    </#list>

    </#if>

    </div>

</div>
<#--！！！！！！！！！！！！！！！！原抢购页面代码！！！！！！！！！！！！！！！！！！-->
<#--<div class="greyBg"style="background: #FFFFFF; margin-left: 11px;">
    <div class="listContainer">
        <ul class="ul_list on products">
        <#list pb.list as rush>
            <li>
                <a href="${basePath}/item/${rush.goodsProductVo.goodsInfoId}.html">
                    <img alt="六必居 脆鲜瓜290g 北京特产 酱菜 咸菜" src="${rush.marketing.rushs[0].rushImage!''}">
                    <span style="font-size: 14px">&lt;#&ndash;${10*rush.marketing.rushs[0].rushDiscount?number}折/&ndash;&gt; ${rush.goodsProductVo.productName}</span>
                </a>
                <div class="cx_qg">
                    <img style="float:left;" class="img" src="${basePath}/images/time.jpg">
                    <font class="status" style="float: left;">剩余:</font>
                    <div class="flagBox">
                        <div id="count${rush_index+1}" class="numtimer">
                            <span style ="margin-left: 17px"class="day"></span><font></font>
                            <span class="hour"></span><font></font>
                            <span class="minute"></span><font></font>
                            <span class="second"></span><font></font>
                        </div>
                    </div>
                &lt;#&ndash;<p style="margin-left:3px;color:black">剩余:</p>
                <span>281</span>
                <p>天</p>
                <span>12</span>
                <p>时</p>
                <span>50</span>
                <P>分</P>
                <span>00</span>
                <p>秒</p>&ndash;&gt;
                </div>
                <div class="cx_yj" style="    padding: 0px 5px 5px 0px;"><strong>
                    <#if ((rush.marketing.rushs[0].rushDiscount?number*rush.goodsProductVo.goodsInfoPreferPrice?number))??>
                        <#if ((rush.marketing.rushs[0].rushDiscount?number*rush.goodsProductVo.goodsInfoPreferPrice?number)>0.005)>
                            <em>￥</em>${(((rush.marketing.rushs[0].rushDiscount?number*rush.goodsProductVo.goodsInfoPreferPrice?number)-0.005)?string("0.##"))!""}
                        <#else>
                            <em>￥</em>${((rush.marketing.rushs[0].rushDiscount?number*rush.goodsProductVo.goodsInfoPreferPrice?number)?string("0.##"))!""}
                        </#if>
                    </#if>
                </strong>
                    <a href="${basePath}/item/${rush.goodsProductVo.goodsInfoId}.html" id="goumai${rush_index+1}" class="goumai jiaru login">立即抢购</a>
                </div>
            </li>
            <input type="hidden" value="${rush.rushTime}" name="rushTime" id="rush${rush_index+1}">
            <input type="hidden" value="${rush.marketing.marketingBegin?string("yyyy-MM-dd HH:mm:ss")}" id="timebegin${rush_index+1}">
            <input type="hidden" class="alltimes" idattr="${rush_index+1}" value="${rush.marketing.marketingEnd?string("yyyy-MM-dd HH:mm:ss")}" id="time${rush_index+1}">
        </#list>
        </ul>
    </div>
</div>-->


<#--！！！！！！！！！！！！！！！！！！！！！end！！！！！！！！！！！！！！！！！！！！！！！-->


<#--！！！！！！！！新狩猎时刻页面！！！！！！！！！！2018.4.19-->
<div class="hunting_moment">
    <img src="${basePath}/images/hunting_images.png" alt="" class="hunting_images">
    <ul>
        <#if marketingRushTimes??>
        <#list marketingRushTimes as marketingRushTime>
            <#if show??&&show==1>
                <li>

                    <#if tDate??&&tDate==marketingRushTime.tDate>
                        <h3 class="color_start" data_end="${marketingRushTime.temp2!''}" data_time="${marketingRushTime.tDate}" data_tId="${marketingRushTime.tId}">${marketingRushTime.tDate}:00</h3>
                        <span class=" color_start rushing">抢购中</span>
                    <#elseif tDate??&&tDate gt marketingRushTime.tDate>
                        <h3 class="color_end" data_end="${marketingRushTime.temp2!''}" data_time="${marketingRushTime.tDate}" data_tId="${marketingRushTime.tId}">${marketingRushTime.tDate}:00</h3>
                        <span class="color_end">已结束</span>
                    <#elseif tDate??&&tDate lt marketingRushTime.tDate>
                        <h3 class="color_upcoming" data_end="${marketingRushTime.temp2!''}" data_time="${marketingRushTime.tDate}" data_tId="${marketingRushTime.tId}">${marketingRushTime.tDate}:00</h3>
                        <span class="color_upcoming">即将开场</span>
                    </#if>
                </li>
            <#elseif show??&&show==2>
                <li>
                    <h3 class="color_upcoming" data_time="${marketingRushTime.tDate}" data_tId="${marketingRushTime.tId}">${marketingRushTime.tDate}:00</h3>
                        <span class=" color_upcoming timestart">即将开场</span>
                </li>
            <#elseif show??&&show==3>
                <li>
                    <h3 class="color_end" data_time="${marketingRushTime.tDate}" data_tId="${marketingRushTime.tId}">${marketingRushTime.tDate}:00</h3>
                    <span class="color_end timeend">已结束</span>
                </li>
            </#if>
        </#list>
        </#if>
    </ul>
</div>


<#if pageAdvs?? && pageAdvs?size gt 0>
<div class="panic_buying" style="background:url(${pageAdvs[0].adverPath!''})">
<#else>
<div class="panic_buying" style="background:url('')">
</#if>
       <a href="#" class="purchase_more">
           <img src="${basePath}/images/hunting_images5.png" alt="">
       </a>
       <#if pb??>
       <ul>
           <#list pb.list as rush>
              <#if rush.marketing.rushs[0].temp1??&&rush.marketing.rushs[0].temp1=='2'>
                   <li>
                       <a href="${basePath}/item/${rush.goodsProductVo.goodsInfoId}.html">
                           <img src="${rush.marketing.rushs[0].rushImage!''}" alt="" class="hunting_images1">
                       </a>
                       <div class="marign_hunting">
                           <a href="${basePath}/item/${rush.goodsProductVo.goodsInfoId}.html" class="li_a">${rush.goodsProductVo.productName}</a>
                           <span>￥</span><span>${((rush.marketing.rushs[0].rushDiscount?number*rush.goodsProductVo.goodsInfoPreferPrice?number)?string("0.##"))!""}</span>
                           <i>￥</i><i>${rush.goodsProductVo.goodsInfoPreferPrice?string("0.00")}</i>

                       <#-- <div class="hunting_span">
                            <em>已售<em>20%</em></em>
                            <div class="span_span">
                                <span style="width:20% "></span>
                            </div>
                        </div>-->
                       </div>
                   </li>
              </#if>
           </#list>
       </ul>
       </#if>

</div>
<#assign index="0">
<div class="panic_list">
    <table>
        <#if pb??>
            <#list pb.list as rush>

                <#if rush.marketing.rushs[0].temp1??&&rush.marketing.rushs[0].temp1=='1'>
                <#if index?number%4==0> <tr></#if>
                <#assign index ="${index?number+1}">
                    <td>
                        <a href="${basePath}/item/${rush.goodsProductVo.goodsInfoId}.html">
                            <img src="${rush.marketing.rushs[0].rushImage!''}" alt="" class="hunting_images2">
                        </a>
                        <a href="${basePath}/item/${rush.goodsProductVo.goodsInfoId}.html" class="td_a">${rush.goodsProductVo.productName}</a>
                        <div class="td_div">
                            <div class="price_vip">
                                <img src="${basePath}/images/hunting_images3.png" alt="">
                                <p>￥${rush.goodsProductVo.goodsInfoPreferPrice?string("0.00")}</p>
                            </div>
                            <span>￥</span><span>${((rush.marketing.rushs[0].rushDiscount?number*rush.goodsProductVo.goodsInfoPreferPrice?number)?string("0.##"))!""}</span>
                            <a href="${basePath}/item/${rush.goodsProductVo.goodsInfoId}.html">
                                <img src="${basePath}/images/hunting_images4.png" alt="">
                            </a>
                        </div>
                    </td>
                    <#if index?number%4==0> </tr></#if>
                </#if>

            </#list>
        </#if>
    </table>
</div>

<input type="hidden" name="setTimes" value="${setTimes}" class="setTimes">
<#--！！！！！！！！！！end！！！！！！！！！！！！！-->


<#--<div class="footer_tab" style="background:#ffffff;margin-top:0;">-->
    <#--<ul>-->
        <#--<li class="list1"><a href="http://www.ge960.com/channel/237.html">食品荟萃</a></li>-->
        <#--<li class="list2"><a href="http://www.ge960.com/channel/239.html">饮品总汇</a></li>-->
        <#--<li class="list3"><a href="http://www.ge960.com/channel/241.html">购物中心</a></li>-->
        <#--<li class="list4"><a href="http://www.ge960.com/channel/243.html">大药房</a></li>-->

    <#--</ul>-->
<#--</div>-->
<#--<div class="content-wp">
    <div class="brandList mt20">-->

<#-- <#list pb.list as rush>
 <li>
 <div class="proIntro clearfix">
     <div class="proLeft">
         <a href="${basePath}/item/${rush.goodsProductVo.goodsInfoId}.html"><img src="${rush.marketing.rushs[0].rushImage!''}" width="588" height="338"/></a>
     </div>
     <div class="proRight">
         <div class="flagBox">
             <font class="status">距离结束还有：</font>
             <div id="count${rush_index+1}" class="numtimer">
                 <span class="day"></span><font></font>
                 <span class="hour"></span><font></font>
                 <span class="minute"></span><font></font>
                 <span class="second"></span><font></font>
             </div>
         </div>
         <div class="flagCon">
             <p class="flagtit">${10*rush.marketing.rushs[0].rushDiscount?number}折/ ${rush.goodsProductVo.productName}</p>
             <p class="pro_des">
             ${rush.goodsProductVo.subtitle!''}
             </p>
             <div class="flagPri clearfix mt30">
                 <span class="bigPrice">
                     <!--
                         判断抢购金额是否大于0.005
                         如果大于就拿到当前的抢购价格减去0.005
                              减去0.005是为了让当前价格不四舍五入与商品详情页保持统一
                         如果不大于就直接展示
                      &ndash;&gt;
                     <#if ((rush.marketing.rushs[0].rushDiscount?number*rush.goodsProductVo.goodsInfoPreferPrice?number))??>
                         <#if ((rush.marketing.rushs[0].rushDiscount?number*rush.goodsProductVo.goodsInfoPreferPrice?number)>0.005)>
                             <em>￥</em>${(((rush.marketing.rushs[0].rushDiscount?number*rush.goodsProductVo.goodsInfoPreferPrice?number)-0.005)?string("0.##"))!""}
                         <#else>
                             <em>￥</em>${((rush.marketing.rushs[0].rushDiscount?number*rush.goodsProductVo.goodsInfoPreferPrice?number)?string("0.##"))!""}
                         </#if>
                     </#if>
                 </span>
                 <span class="p-original">￥${(rush.goodsProductVo.goodsInfoPreferPrice?string("0.00"))!""}</span>
                 <a href="${basePath}/item/${rush.goodsProductVo.goodsInfoId}.html" class="fr">立即抢购</a>
             </div>
             <div class="advanceTip mt30 clearfix">
                 <div class="fl">为您节省<span>${((rush.goodsProductVo.goodsInfoPreferPrice?number-rush.marketing.rushs[0].rushDiscount?number*rush.goodsProductVo.goodsInfoPreferPrice?number)?string("0.00"))!""}</span>元</div>
                 &lt;#&ndash;<div class="fr"><span>1657</span>人已购买</div>&ndash;&gt;
             </div>
         </div>
     </div>
 </div><!--proIntro&ndash;&gt;
 <input type="hidden" value="${rush.rushTime}" name="rushTime" id="rush${rush_index+1}">
 <input type="hidden" value="${rush.marketing.marketingBegin?string("yyyy-MM-dd HH:mm:ss")}" id="timebegin${rush_index+1}">
 <input type="hidden" class="alltimes" idattr="${rush_index+1}" value="${rush.marketing.marketingEnd?string("yyyy-MM-dd HH:mm:ss")}" id="time${rush_index+1}">
 </li>
</#list>
 </ul>
</div>
</div>-->
<#-- </div>--><!--brandList-->
<#--分页-->

<#-- </div>--><!--co<#--<div class="pages mt10 tr">
        <#if (pb.list?size!=0)>
            &lt;#&ndash; 分页 &ndash;&gt;
            <#import "../pagination/pageBean.ftl" as page>
            <@page.pagination pb />
            </#if>
        </div>-->ntent-wp-->




<div class="side_tools" style="bottom: 20%; display: block;">
    <a class="backtotop" href="javascript:;" ><em>返回顶部</em><b></b></a>
</div>
<!--这是底部-->
<#if (topmap.temp)??>
    <#if (topmap.temp.tempId==1)>
        <#include "../index/bottom.ftl">
    <#else>
        <#include "../index/newbottom.ftl" />
    </#if>
</#if>

<script type="text/javascript" src="${basePath}/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${basePath}/js/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="${basePath}/js/jquery.slides.min.js"></script>
<script type="text/javascript" src="${basePath}/js/cloud-zoom.1.0.2.min.js"></script>
<script type="text/javascript" src="${basePath}/js/template.js"></script>
<script type="text/javascript" src="${basePath}/js/jsOperation.js"></script>
<script type="text/javascript">

    function RushProduct(option){
        this.marketingRushTimes = option.marketingRushTimes;
        this.pb = option.pb;
        this.hours = option.hours;
        this.show = option.show;
        this._init();
        this.config={
            hunting_moment:document.querySelector(".hunting_moment"),
            panic_buying:document.querySelector(".panic_buying"),
            panic_list:document.querySelector(".panic_list")
        }
    }
    RushProduct.prototype={
        _init:function(){
            this.bindRushTimes();
            this.bindsellProduct();
            this.bindcommonProduct();
        },
        bindRushTimes:function(){
            var source = '<img src="/images/hunting_images.png" alt="" class="hunting_images">'+
                    '<ul>'+
                    '{{each marketingRushTimes as marketingRushTime i}}'+
                    '{{if show == 1}}'+
                    '<li>'+
                    '{{if hours==marketingRushTime.tDate}}'+
                    '<h3 class="color_start" data_end="{{marketingRushTime.temp2}}" data_tId="{{marketingRushTime.tId}}" data_time="{{marketingRushTime.tDate}}">{{marketingRushTime.tDate}}:00</h3>'+
                    '<span class=" color_start rushing">抢购中</span>'+
                    '{{else if hours > marketingRushTime.tDate}}'+
                    '<h3 class="color_end" data_end="{{marketingRushTime.temp2}}" data_tId="{{marketingRushTime.tId}}" data_time="{{marketingRushTime.tDate}}">{{marketingRushTime.tDate}}:00</h3>'+
                    '<span class="color_end">已结束</span>'+
                    '{{else if hours < marketingRushTime.tDate}}'+
                    '<h3 class="color_upcoming" data_end="{{marketingRushTime.temp2}}" data_tId="{{marketingRushTime.tId}}" data_time="{{marketingRushTime.tDate}}">{{marketingRushTime.tDate}}:00</h3>'+
                    '<span class="color_upcoming">即将开场</span>'+
                    '{{/if}}'+
                    '</li>'+
                    '{{else if show == 2}}' +
                    '<li>'+
                    '<h3 class="color_upcoming" data_time="{{marketingRushTime.tDate}}" data_end="{{marketingRushTime.temp2}}" data_tId="{{marketingRushTime.tId}}">{{marketingRushTime.tDate}}:00</h3>'+
                    '<span class=" color_upcoming timestart">即将开场</span>'+
                    '</li>'+
                    '{{else if show == 3}}'+
                    '<li>'+
                    '<h3 class="color_end" data_time="{{marketingRushTime.tDate}}" data_end="{{marketingRushTime.temp2}}" data_tId="{{marketingRushTime.tId}}">{{marketingRushTime.tDate}}:00</h3>'+
                    '<span class="color_end timeend">已结束</span>'+
                    '</li>'+
                    '{{/if}}'+
                    '{{/each}}'+
                    '</ul>';
            var render = template.compile(source);
            $(".hunting_moment").html(render({marketingRushTimes:this.marketingRushTimes,hours:this.hours,show:this.show}));

        },
        bindsellProduct:function(){
            var pb = this.pb;
            var str = '<a href="#" class="purchase_more"><img src="/images/hunting_images5.png" alt=""></a><ul>';
            for(var i = 0;i < pb.list.length;i++){
                if(pb.list[i].marketing.rushs[0].temp1=='2'){
                    str += '<li>'
                            +'<a href="/item/'+pb.list[i].goodsProductVo.goodsInfoId+'.html">'
                            +'<img src="'+pb.list[i].marketing.rushs[0].rushImage+'" alt="" class="hunting_images1">'
                            +'</a>'
                            +'<div class="marign_hunting">'
                            +'<a href="/item/'+pb.list[i].goodsProductVo.goodsInfoId+'.html" class="li_a">'+pb.list[i].goodsProductVo.productName+'</a>'
                            +'<span>￥</span><span>'+accMul(pb.list[i].marketing.rushs[0].rushDiscount,pb.list[i].goodsProductVo.goodsInfoPreferPrice)+'</span>'
                            +'<i>￥</i><i>'+pb.list[i].goodsProductVo.goodsInfoPreferPrice+'</i>'
                            +'</div>'
                            +'</li>';
                }
            }
            str += '</ul>';
           $(".panic_buying").html(str);
        },
        bindcommonProduct:function(){
            var pb = this.pb;
            var str = '<div class="panic_list"> <table>';
            var j = 0;
            for(var i = 0;i < pb.list.length;i++){
                if(pb.list[i].marketing.rushs[0].temp1=='1'){
                    if(j%4==0){
                        str += '<tr>';
                    }
                    j++;
                    str += '<td>'
                           +'<a href="/item/'+pb.list[i].goodsProductVo.goodsInfoId+'.html">'
                            +'<img src="'+pb.list[i].marketing.rushs[0].rushImage+'" alt="" class="hunting_images2">'
                            +'</a>'
                            +'<a href="/item/'+pb.list[i].goodsProductVo.goodsInfoId+'.html" class="td_a">'+pb.list[i].goodsProductVo.productName+'</a>'
                            +'<div class="td_div">'
                            +'<div class="price_vip">'
                            +'<img src="/images/hunting_images3.png" alt="">'
                            +'<p>原价￥'+pb.list[i].goodsProductVo.goodsInfoPreferPrice.toFixed(2)+'</p>'
                           +'</div>'
                           +'<span>￥</span><span>'+accMul(pb.list[i].marketing.rushs[0].rushDiscount,pb.list[i].goodsProductVo.goodsInfoPreferPrice)+'</span>'
                            +'<a href="/item/'+pb.list[i].goodsProductVo.goodsInfoId+'.html">'
                            +'<img src="/images/hunting_images4.png" alt="">'
                            +'</a>'
                            +'</div>'
                            +'</td>' ;
                    if(j%4==0){
                        str += '</tr>';
                    }
                }
            }
            str += '</table></div>';
            $(".panic_list").html(str);
        }
    }

        var setTimes = Number($('.setTimes').val());
        window.setInterval(function(){
            setTimes += 1000;
            var newtime = new Date();
            newtime.setTime(setTimes);
            var hours = newtime.getHours();
            console.log(hours+":"+newtime.getMinutes()+":"+newtime.getSeconds());
            // console.log(newtime.getHours()+"-"+newtime.getMinutes()+"-"+newtime.getSeconds());
            //如果抢购中存在
            if($('.rushing').length>0){
                //时间段  时间段id  结束时间
                var time,tId,endTime;
                //如果抢购中不是最后一个
                if($('.rushing').parent('li').next().length>0){
                    time = $('.rushing').parent('li').next().children("h3").attr("data_time");
                    tId = $('.rushing').parent('li').next().children("h3").attr("data_tId");
                    if(time==hours){
                        $.ajax({url:"selectmrlistajax.htm",type:"post",data:{tId:tId,show:1},success:function(data){
                            new RushProduct({pb:data.pb,marketingRushTimes:data.marketingRushTimes,hours:time,show:data.show})
                        }})
                    }
                }else{
                    //如果抢购中是最后一个
                    endTime = $('.rushing').parent('li').children("h3").attr("data_end");
                    time = $('.rushing').parent('li').children("h3").attr("data_time");
                    tId = $('.rushing').parent('li').children("h3").attr("data_tId");
                    if(parseInt(endTime) <= hours){
                        $.ajax({url:"selectmrlistajax.htm",type:"post",data:{tId:tId,show:3},success:function(data){
                            new RushProduct({pb:data.pb,marketingRushTimes:data.marketingRushTimes,hours:time,show:data.show})
                        }})
                    }
                }
                //如果都是即将开场
            }else if($('.timestart').length>0&&$('.timeend').length == 0){
                var time = $('.timestart').parent('li').parent('ul').find('li:first').find("h3").attr("data_time");
                var tId = $('.timestart').parent('li').parent('ul').find('li:first').find("h3").attr("data_tId");
                if(time==hours){
                    $.ajax({url:"selectmrlistajax.htm",type:"post",data:{tId:tId,show:1},success:function(data){
                        new RushProduct({pb:data.pb,marketingRushTimes:data.marketingRushTimes,hours:time,show:data.show})
                    }})
                }
                //如果都是已结束
            }else if($('.timeend').length > 3&&$('.timestart').length == 0){
                if(hours==0||hours==24){
                    $.ajax({url:"selectmrlistajax.htm",type:"post",data:{tId:0,show:2},success:function(data){
                        new RushProduct({pb:data.pb,marketingRushTimes:data.marketingRushTimes,hours:time,show:data.show})
                    }})
                }
            }
        },1000)



    if($("#slidesbb").length > 0 && $("#slidesbb a").length > 1) {
        $("#slidesbb").slidesjs({
            play: {
                active: false,
                effect: "fade",
                auto: true,
                interval: 4000,
                pauseOnHover: true,
                restartDelay: 2500
            },
            navigation: {
                active: false
            },
            pagination: {
                active: true,
                effect: "fade"
            }
        });
    };
    $(".side_tools").css("bottom","20%");
    $(window).scroll(function() {
        if ($(document.documentElement).scrollTop() > 300 || $(document.body).scrollTop() > 300) {
            $(".side_tools").css('display','block');
            $(".backtotop").on("click",
                    function() {
                        $("body,html").animate({
                            scrollTop: 0
                        },0);
                    });
        } else {
            $(".side_tools").css('display','none');
        }
    });

    $(function(){

        $(".alltimes").each(function(){
            var id=$(this).attr("idattr");
            countDown($("#time"+id).val(),$("#timebegin"+id).val(),'#count'+id,$("#rush"+id).val())
            if($("#rush"+id).val()==3){
                $('#count'+id).parent().prev().html("已结束");
                $('#count'+id).html("");
                $("#goumai"+id).css("display","none");
            }
        });
    });
    //date是结束日期，例如"2014/05/19";count是容器
    function countDown(dateend,datebegin,count,rush){
        var now = Date.parse(new Date());
        //alert(now);
        var date;
        if(rush==1){
            date=datebegin;
            $(count).parent().siblings().find("a").css("background","grey").removeAttr("href");
        }else if(rush==2){
            date=dateend;
        }else if(rush ==3){
            date=dateend;
            $(count).parent().siblings().find("a").css("background","grey").removeAttr("href");
        }
        var str =  date.replace(/-/g,"/");
        var target = Date.parse(new Date(str));
        var time = target - now;
        time = parseInt(time / 1000);
        var day = Math.floor(time / (60*60*24));
        time -= day * (60*60*24);
        var hour = Math.floor(time /(60*60));
        time -= hour * (60*60);
        var minute = Math.floor(time / 60);
        var second = time - (minute * 60);
        if(day<10){
            if(day<0){
                return;
            }else{
                day="0"+day;
            }
        }
        if(hour<10){
            hour="0"+hour;
        }
        if(minute<10){
            minute="0"+minute;
        }
        if(second<10){
            second="0"+second;
        }
        if(day==0&&hour==0&&minute==0&&second==0){
            if(rush==1){
                rush= 2;
                countDown(dateend,datebegin,count,rush);
                return;
            }else if(rush==2){
                $(count).parent().prev().html("已结束");
                $(count).parent().siblings().find("a").css("background","grey").removeAttr("href");
                $(count).html("");
                $(count).parent().parent().next().children('a').css("display","none");
                return;
            }
        }else{
            if(rush==1){
                $(count).parent().prev().html("离开始:");
                $(count).parent().parent().next().children('a').css("display","none");
                $(count).find('.day').html(day);
                $(count).find('.day').next().html(" 天");
                $(count).find('.hour').html(hour);
                $(count).find('.hour').next().html(" 时");
                $(count).find('.minute').html(minute);
                $(count).find('.minute').next().html(" 分");
                $(count).find('.second').html(second);
                $(count).find('.second').next().html(" 秒");
            }else if(rush==2){
                $(count).parent().prev().html("离结束:");
                $(count).parent().parent().next().children('a').css("display","inline");
                $(count).find('.day').html(day);
                $(count).find('.day').next().html(" 天");
                $(count).find('.hour').html(hour);
                $(count).find('.hour').next().html(" 时");
                $(count).find('.minute').html(minute);
                $(count).find('.minute').next().html(" 分");
                $(count).find('.second').html(second);
                $(count).find('.second').next().html(" 秒");
            }else if(rush ==3){
                $(count).parent().prev().html("已结束");
                $(count).parent().siblings().find("a").css("background","grey").removeAttr("href");
                $(count).html("");
                $(count).parent().parent().next().children('a').css("display","none");
            }
            window.setTimeout(function(){countDown(dateend,datebegin,count,rush);},1000);
        }
    }
//    shf为狩猎时刻加上背景色
    $(function(){
        $(".navLinks li").eq(1).find("a").addClass("on");
    })

</script>
</body>
</html>