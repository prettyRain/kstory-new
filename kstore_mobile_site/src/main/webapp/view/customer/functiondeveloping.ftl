<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>会员中心 - 优惠券</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta content="telephone=no" name="format-detection">
    <#assign basePath=request.contextPath>
    <link rel="stylesheet" href="${basePath}/css/style.min.css"/>
    <script src="${basePath}/js/jquery-1.10.1.js"></script>
    <style>
        body,html{
            font-family: "微软雅黑";
        }
        .warp{
            margin:109px 0 21px 0;
        }
        .tips{
            margin: 0 auto;
            display: block;
        }
        p{
            text-align: center;
            font-family:微软雅黑,Microsoft yahei;
            opacity: 0.58;
            font-size: 15px;
            color: #000;
            letter-spacing: 1.07px;
        }
        .vheader span {
            text-align: center;
            margin: 0;
            margin-right: 0em!important;
            margin-left: 3.2em!important;
            font-size: 17px;
            position: relative;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            -webkit-flex-shrink: 10;
            -ms-flex: 0 10 auto;
            flex-shrink: 10;
            display: -webkit-box;
            display: -ms-flexbox;
            display: -webkit-flex;
            display: flex;
            -webkit-box-align: center;
            -ms-flex-align: center;
            -webkit-align-items: center;
            align-items: center;

        }
        .vheader  a{
            font-size: 1em!important;
            color: #333333!important;
        }
    </style>
    <style>
        .coupon{
            height:2.56rem;
            margin: 10px;
        }
        .coupon_red{
            background: url(../images/coupon_red.png) no-repeat;
            background-size:100% 100%;
        }
        .coupon_yellow{
            background: url(../images/coupon_yellow.png) no-repeat;
            background-size:100% 100%;
        }
        .coupon .coupon_left{
            width: 40%;
            height:2.56rem;
            text-align: center;
        }
        .coupon .coupon_left .cp_symbol{
            font-size: .5rem;
            color: #ffffff;
            font-weight: bold;
        }
        .coupon .coupon_left .cp_state{
            display: block;
            color: #ffffff;
            font-size: 12px;
            letter-spacing: 1px;
            margin-left: .2rem;
        }
        .coupon .coupon_left .cp_money{
            font-size: 1rem;
            color: #ffffff;
            font-weight: bold;
            margin-top: .31rem;
            display: inline-block;
            height: 1.2rem ;
        }
        .coupon .coupon_right{
            width: 60%;
            height:2.56rem;
            padding: 0 .4rem 0 .45rem;
        }
        .coupon .coupon_right .cp_title{
            font-size: .48rem;
            color: #ffffff;
            font-weight: bold;
            margin-top: .55rem;
            display: block;
            overflow: hidden;
            height: .56rem;
            line-height: .56rem;
        }
        .coupon .coupon_right .cp_title1{
            color: #ffffff;
            font-size: 12px;
            letter-spacing: 1px;
            margin-top: .35rem;
            display: inline-block;
            height: .32rem;

        }
        .coupon .coupon_right .cp_date{
            height: .32rem;
            display: inline-block;
        }
        .coupon .coupon_right .cp_title2{
            color: #ffffff;
            font-size: 12px;
            letter-spacing: 1px;
            display: block;
            height: .64rem;
            line-height: .3rem;
            overflow:hidden;
        }
        .coupon .coupon_left,.coupon .coupon_right{
            float: left;
        }
        body, html {
            color: #363636;
            background-color: #ffffff;
        }
    </style>
</head>
<script>
    (function (doc, win) {
        var docEl = doc.documentElement,
                resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
                recalc = function () {
                    var clientWidth = docEl.clientWidth;
                    if (!clientWidth) return;
                    docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
                };
        if (!doc.addEventListener) return;
        win.addEventListener(resizeEvt, recalc, false);
        doc.addEventListener('DOMContentLoaded', recalc, false);
    })(document, window);
</script>
<body>

<#assign vtitle="优惠券" />
<#--<#assign backUrl="${basePath}/customercenter.html" />-->
<#assign backUrl="javascript:history.go(-1)" />
<#assign voption="券码兑换" />
<#include "../common/head_back.ftl"/>
<#if pb?? && pb?size!=0>
    <#list pb as coupon>
            <#if (coupon.couponRulesType=="1") >
                <div class="coupon coupon_red">
                    <div class="coupon_left">
                        <span class="cp_symbol">￥<span class="cp_money">${((coupon.couponStraightDown.downPrice)!'0.00')}</span></span>
                        <span class="cp_state">无门槛使用</span>
                    </div>
                    <div class="coupon_right">
                        <span class="cp_title"><span style="width:100%;height=200%;display:block;">${coupon.couponName}</span></span>
                        <span class="cp_title1">有效期至<span class="cp_date">${coupon.couponEndTime?string("yyyy.MM.dd")}</span></span>
                        <span class="cp_title2">
                            <#if coupon.couponRemark??>
                                  ${coupon.couponRemark}

                            </#if>
                        </span>
                    </div>
                </div>
            <#elseif coupon.couponRulesType=="2" && coupon.couponFullReduction.fullPrice?number==0>
                <div class="coupon coupon_red">
                    <div class="coupon_left">
                        <span class="cp_symbol">￥<span class="cp_money">${((coupon.couponFullReduction.reductionPrice)!'0.00')}</span></span>
                        <span class="cp_state">无门槛使用</span>
                    </div>
                    <div class="coupon_right">
                        <span class="cp_title"><span style="width:100%;height=200%;display:block;">${coupon.couponName}</span></span>
                        <span class="cp_title1">有效期至<span class="cp_date">${coupon.couponEndTime?string("yyyy.MM.dd")}</span></span>
                        <span class="cp_title2">
                             <#if coupon.couponRemark??>
                                ${coupon.couponRemark}
                             </#if>
                        </span>
                    </div>
                </div>
            <#else>
                <div class="coupon coupon_yellow">
                    <div class="coupon_left">
                        <span class="cp_symbol">￥<span class="cp_money">${((coupon.couponFullReduction.reductionPrice)!'0.00')}</span></span>
                        <span class="cp_state">满${((coupon.couponFullReduction.fullPrice)!'0.00')}元可用</span>
                    </div>
                    <div class="coupon_right">
                        <span class="cp_title">${coupon.couponName}</span>
                        <span class="cp_title1">有效期至<span class="cp_date">${coupon.couponEndTime?string("yyyy.MM.dd")}</span></span>
                        <span class="cp_title2">
                              <#if coupon.couponRemark??>
                                        ${coupon.couponRemark}
                              </#if>
                        </span>
                    </div>
                </div>
            </#if>
    </#list>
<#else>
    <div class="warp"><img alt="" src="../../images/v2/icon_youhuiquan@2x.png" class="tips" width="140" height="140"></div>
    <p>暂无优惠券</p>
</#if>
<#--<div class="coupon coupon_yellow">
    <div class="coupon_left">
        <span class="cp_symbol">￥<span class="cp_money">20</span></span>
        <span class="cp_state">满100元可用</span>
    </div>
    <div class="coupon_right">
        <span class="cp_title">中秋吃肉卷</span>
        <span class="cp_title1">有效期至<span class="cp_date">2017.10.11</span></span>
        <span class="cp_title2">仅限元之源品牌使用</span>
    </div>
</div>-->
</body>
</html>
<script>
    $("#icon-option").attr("href","${basePath}/toaddcoupons.htm?flag=0<#if codeNo??>&codeNo=${codeNo}</#if><#if invoiceTitle??>&invoiceTitle=${invoiceTitle}</#if><#if invoiceType??>&invoiceType=${invoiceType}</#if>")
</script>