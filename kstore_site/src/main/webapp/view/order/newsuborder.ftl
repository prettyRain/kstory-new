<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
<#assign basePath=request.contextPath>
    <meta name="Keywords" content="${topmap.seo.meteKey}">
    <meta name="description" content="${topmap.seo.meteDes}">
    <title>订单结算页-${topmap.systembase.bsetName}</title>
    <link rel="stylesheet" type="text/css" href="${basePath}/css/pages.css"/>
    <link rel="stylesheet" type="text/css" href="${basePath}/css/suborder/base.min.css"/>

    <link rel="stylesheet" type="text/css" href="${basePath}/css/suborder/style.css"/>
    <link rel="stylesheet" type="text/css" href="${basePath}/index_two/css/header.css"/>

    <script type="text/javascript" src="${basePath}/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${basePath}/index_960/js/app.js"></script>
    <style>
        html {
            overflow-x: hidden;
        }

        .cust_allAddress {
            position: relative;
        }

        input:-webkit-autofill {
            -webkit-box-shadow: 0 0 0 1000px white inset;
        }

        .goods-suit .goods-suit-tit p {
            font-family: verdana;
            color: #e4393c;
            display: inline-block;
            vertical-align: middle;
            width: 90px;
            font-weight: bold;
        }

        .wp a {
            color: #555;
            outline: none;
        }

        .wp a:hover {
            text-decoration: none;
            color: #F63;
        }

        .dia_tit {
            height: 37px;
            line-height: 37px;
            padding: 0 0px;
            font-family: microsoft YaHei;
            font-size: 14px;
            color: #fff;
            background: #fff;
            border-radius: 4px 4px 0 0;
        }
        .dia_close{
            width: 12px;
            height: 12px;
            margin-top: 25px;
            margin-right: 25px;
            float: right;
            text-indent: -9999px;
            line-height: 0;
            overflow: hidden;
            background: url(../images/popover_btn.png) no-repeat;
            background-size: 100%;
        }
        .dia_tit h4 {
            line-height: 30px;
        }
        .dia_intro{
            min-height: 0px;
        }
        .new_span{
            text-align: center;
            width: 480px;
            font-size: 15px;
            color: #000000;
            letter-spacing: 0.54px;
            font-weight: bold;
            margin-top: 20px;
            display: block;
        }

         .go_pay{
             text-align: center;
             background: #ffffff;
             margin:0 7px 0 0!important;
             zoom: 1;
             width: 114px;
             height: 35px;
             line-height: 35px;
             color: #333333!important;
             border: 1px solid #7F7F7F;
             border-radius: 4px;
             display: inline-block;
             font-size: 14px;
             letter-spacing: 0.5px;
             padding: 0px 0px!important;
         }
        .bnt_ok {
            background: #199301 !important;
            color: #fff !important;
            border: 1px solid #199301 !important;
        }
        .picksite-box .pick-sites-more {
            max-height: 276px;
            _height: expression(this.scrollHeight>276?'276px':'auto');
            position: relative;
            top: 0;
            left: 0;
        }
        .overflow{
            overflow-y:scroll;
        }
        .picksite-box .pick-sites {
            width: 660px;
        }
        .picksite-box .site-item {
            margin: 0 0 10px;
        }
        .picksite-box .site-item-selected .site-in-short {
            border: 2px solid #e4393c;
            padding: 7px 10px;
        }
        .picksite-box .site-in-short {
            float: left;
            position: relative;
            top: 0;
            left: 0;
            border: 1px solid #ebebeb;
            height: 22px;
            line-height: 22px;
            padding: 4px 10px;
            width: 250px;
            margin-right: 10px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            cursor: pointer;
        }
        .picksite-box .site-item-selected .site-in-short b {
            display: block;
            position: absolute;
            right: 0;
            bottom: 0;
            width: 12px;
            height: 12px;
            overflow: hidden;
            background: url(http://misc.360buyimg.com/user/purchase/2.0.0/css/i/selected-icon.png) no-repeat;
        }
        .picksite-box .field {
            float: left;
            position: relative;
            top: 0;
            left: 0;
            width: 295px;
            line-height: 18px;
            padding-right: 55px;
        }
        .picksite-box .field .tip {
            color: #b3b3b3;
            display: block;
            height: 36px;
            line-height: 18px;
            overflow: hidden;
        }
        .picksite-box .field .map-link {
            display: block;
            position: absolute;
            right: 0;
            height: 18px;
            line-height: 18px;
            top: 0;
        }
        .clear, .clr {
            display: block;
            overflow: hidden;
            clear: both;
            height: 0;
            line-height: 0;
            font-size: 0;
        }
        .shopping-list .dis-modes .mode-tab-nav li.current {
            border: 2px solid #e4393c;
            padding: 4px 0;
            width: 146px;
        }
        .shopping-list .dis-modes .mode-tab-nav li.current b{  display: block;
            position: absolute;
            right: 0;
            bottom: 0;
            width: 12px;
            height: 12px;
            overflow: hidden;
            background: url(http://misc.360buyimg.com/user/purchase/css/i/user_purchase20150409154845.png?__sprite) no-repeat;
            background-position: 0 0;}
        .dia_tip{
            background: #fff;
            padding-bottom: 20px;
            min-height: 120px;
        }
        .item-selected{
            border:1px solid #008842!important;
        }
        .shopping-list .dis-modes .mode-tab-nav li.disabled{
            border:1px solid #ddd!important;
        }
        .goods-msg{
            width:300px!important;
            padding:5px;
            text-align:left;
        }
        .shopping-list{
            border:0px!important;
            padding:0px;
        }
        .p-img{
            margin-left:5px;
            border:0px!important;
        }
        td {
            text-align: center;
        }
        .goods-suit-tit{
            text-align:left;
        }
        .xianshi{
            display: none;
            position: absolute;
            left: -132px;
            top: 25px;
            width: 247px;
            /*height: 70px;*/
            border: 1px solid #f4e4b4;
            padding: 5px;
            background: #fffdee;
        }
        #click_1.tab-item-selected ,
        #click_2.tab-item-selected {
            padding:6px 24px!important;
            border:1px solid #008842!important;
        }
        .invoice-item-selected {
            padding:5px 19px!important;
            border:1px solid #008842!important;
        }
        #click_2.tab-item-selected  b,
        #click_1.tab-item-selected  b,
        .invoice-item-selected b {
            background:url(/css/suborder/suborder-icon.png) no-repeat!important;
        }
        li.b {
            background:url(/css/suborder/suborderselect.png) no-repeat right bottom!important;
        }
    </style>
    <style>
        .email-cont .input-email{
            border: 1px solid #dddddd;
            height: 28px;
            width: 314px;
            font-size: 14px;
            padding-left: 10px;
            margin-left: 40px;
            margin-top: 20px;
            color: #999999;
            line-height: 28px;
        }
        .email-cont  .clean-email{
            height: 28px;
            width: 54px;
            border: 1px solid #dddddd;
            border-radius: 4px;
            margin-top: 20px;
            color: #333333;
            margin-left: 10px;
        }
        .email-cont{
            margin-bottom: 20px;
        }
        .shopping-list {
            position: relative;
            border: solid #ddd;
            border-width: 2px 1px 1px;
            padding: 0;
            width: 989px;
        }
        .bought-table tbody td {
            border: 1px solid #e8e8e8;

        }
        .loading{
            float: right;
            position: relative;
            margin: 8px 10px 0 0;
            padding: 0;
            overflow: hidden;
            display: block;
            width: 135px;
            height: 36px;
            line-height: 36px;
            font-size: 18px;
            font-weight: bold;
            color: #fff;
            text-align: center;
            border: 1px solid #0d9901;
            letter-spacing: 0.5px;
            cursor: pointer;
            background:  #00991D url(${basePath}/images/tigger_green.gif) no-repeat 50%!important;
            background-size: 30%!important;
        }
    </style>
</head>
<body>
<#--shf引入头-->
<#include "../common/newHeaderShopcart.ftl"/>
<#--<#if (topmap.temp)??>-->
    <#--<#if (topmap.temp.tempId==8)>-->
        <#--<#include "../index/newtop3.ftl">-->
    <#--<#elseif (topmap.temp.tempId==9)>-->
        <#--<#include "../index/newtop4.ftl">-->
    <#--<#elseif (topmap.temp.tempId==10)>-->
        <#--<#include "../index/newtop7.ftl">-->
    <#--<#elseif (topmap.temp.tempId==11)>-->
        <#--<#include "../index/newtop6.ftl">-->
    <#--<#elseif (topmap.temp.tempId==12)>-->
        <#--<#include "../index/newtop7.ftl">-->
    <#--<#elseif (topmap.temp.tempId==13)>-->
        <#--<#include "../index/newtop8.ftl">-->
    <#--<#elseif (topmap.temp.tempId==14)>-->
        <#--<#include "../index/newtop9.ftl">-->
    <#--<#elseif (topmap.temp.tempId==15)>-->
        <#--<#include "../index/newtop10.ftl">-->
    <#--<#elseif (topmap.temp.tempId==16)>-->
        <#--<#include "../index/newtop11.ftl">-->
    <#--<#elseif (topmap.temp.tempId==17)>-->
        <#--<#include "../index/newtop12.ftl">-->
    <#--<#elseif (topmap.temp.tempId==18)>-->
        <#--<#include "../index/newtop13.ftl">-->
    <#--<#elseif (topmap.temp.tempId==19)>-->
        <#--<#include "../index/newtop14.ftl">-->
    <#--<#elseif (topmap.temp.tempId==21)>-->
        <#--<#include "../index/newtop21.ftl">-->
    <#--<#else>-->
        <#--<#include "../index/newtop.ftl"/>-->
    <#--</#if>-->
<#--</#if>-->
<input type="hidden" id="currentProvince" value="${chProvince!''}" />
<input type="hidden" id="basePath" value="${basePath}" />
<input type="hidden" id="isOpen" value="${pointSet.isOpen!''}" />
<div style="font-family: arial;">
    <div class="container">
    <#--<#if (topmap.temp.tempId!=10)>-->
        <#--&lt;#&ndash;<div class="logo fl head2">&ndash;&gt;-->
            <#--&lt;#&ndash;<!--&ndash;&gt;-->
        <#--&lt;#&ndash;<a href="${basePath}/index.html"><img src="${basePath}/index_two/images/logo.png" alt="" /></a>&ndash;&gt;-->
		<#--&lt;#&ndash;&ndash;&gt;&ndash;&gt;-->
            <#--&lt;#&ndash;<a href="${topmap.systembase.bsetAddress}"><img src="${topmap.systembase.bsetLogo}" alt="" style="width:165px;height:70px;"/></a>&ndash;&gt;-->
        <#--&lt;#&ndash;</div>&ndash;&gt;-->
    <#--</#if>-->
        <div class="head_s mb20">
            <div class="fr w700 pt10">
                <div class="flow_progress2">
                    <ul>
                        <li class="step1">1.查看购物车</li>
                        <li class="step2">2.填写核对订单信息</li>
                        <li class="step3">3.提交订单成功</li>
                    </ul>
                </div>
            </div>
            <div id="logo">
                <!--<a class="logo fl" href="${basePath}/index.html"><img alt="" src="${basePath}/images/logo.gif" /></a>-->
            </div>
            <div class="cb"></div>
        </div><!-- /head_s -->
    <#--自提点名称-->
    <#assign pickflag='0'>
    <#--自提点id中间变量-->
    <#assign pickIdflag=0>
        <#-- 零售商品的数量 -->
    <#assign lingshouCount=0>
        <#--礼品电子卡-->
    <#assign dianziCard=0>
        <#--全部商品的数量-->
    <#assign totalCount=0>
    <#if cartMap.shoplist??&&cartMap.shoplist?size!=0>
        <#assign totalCount=cartMap.shoplist?size>
    </#if>

    <#if cartMap?? && cartMap.shoplist??&&cartMap.shoplist?size!=0>
        <#list cartMap.shoplist as cars>
            <#if !cars.fitId??>
            <#-- <#if cars.goodsDetailBean.sellType?? && cars.goodsDetailBean.sellType=='0'><#assign lingshouCount=lingshouCount+1></#if>-->
                <#if cars.goodsDetailBean.productVo.productName??&&cars.goodsDetailBean.productVo.productName?index_of("零售")!=-1><#assign lingshouCount=lingshouCount+1></#if>
                <#if cars.goodsDetailBean.productVo.productName??&&cars.goodsDetailBean.productVo.productName?index_of("电子卡")!=-1><#assign dianziCard=dianziCard+1></#if>
            <#else>
                <#if cars.goodsGroupVo.productList??&&cars.goodsGroupVo.productList?size!=0>
                    <#list cars.goodsGroupVo.productList as pro>
                    <#--<#if pro.productDetail.sellType?? && pro.productDetail.sellType=='0'><#assign lingshouCount=lingshouCount+1></#if>-->
                        <#if pro.productDetail.goodsInfoName??&&pro.productDetail.goodsInfoName?index_of("电子卡")!=-1><#assign dianziCard=dianziCard+1></#if>
                        <#if pro.productDetail.goodsInfoName??&&pro.productDetail.goodsInfoName?index_of("零售")!=-1><#assign lingshouCount=lingshouCount+1></#if>
                    </#list>
                </#if>
            </#if>
        </#list>
    </#if>

    <#if (cartMap.fulllist?? && cartMap.fulllist?size>0)>
        <#list cartMap.fulllist as goods>
                    <#list goods.fullbuyPresentScopes as good>
                        <#if good.scopeType == '0'>
                        <#if good.goodsProduct.goodsInfoName?index_of("零售")!=-1><#assign lingshouCount=lingshouCount+1></#if>
                        <#assign totalCount=totalCount+1>
                        </#if>
                    </#list>
        </#list>
    </#if>
        <input  id="totalCount" type="hidden" value="${totalCount}" />
    <#--运费存储隐藏域-->
        <input  id="yfprice" type="hidden"/>
    <#--boss运费存储隐藏域-->
        <input  id="bossyfprice" type="hidden"/>
    <#--应付总额隐藏域-->
        <input  id="sumpriceflag" type="hidden"/>
        <div class="jd-dialog  dia8 z-dialog"  >
            <div class="jd-dialog-title">选择自提点<a href="#" class="jd-dialog-close" onclick="cls()">×</a></div>
            <div id="selfpick_siteDiv" class="p10"><!-- 选择自提点 -->

                <div class="form picksite-box">
                    <div class="item clearfix">
                        <span class="label">选择自提点：</span>
                        <div class="fl since">


                        </div>
                    </div>
                    <div class="item">
                        <span class="label">&nbsp;</span>
                        <div class="fl">
                            <div class="op-btns">
                                <a class="btn-9" onclick="doSaveDialogPickSite()">确定</a>
                                <a class="btn-9 ml10" href="javascript:;" onclick="cls()">取消</a>
                            </div>
                            <div class="ftx-03 mt10">自提时付款，支持现金、POS刷卡、支票支付 </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="w990">
            <div class="jd_tit">
                <h2>填写并核对订单信息</h2>
            </div>
            <form name="subForm" id="sub_order" action="${basePath}/order/submitOrder.html" method="post">

                <input type="hidden" id="isbuynow" name="isbuynow" value="${isbuynow!''}">
                <input type="hidden" id="csrfNo" name="CSRFToken" value="<#if sx??>${sx}</#if>"/>
                <input type="hidden" name="deliveryPointId" id="deliveryPointId" >
                <input type="hidden" name="typeId" id="typeId" />
                <input type="hidden" name="presentScopeIds" value="<#if presentScopeIds??>${presentScopeIds}</#if>" />
                <div class="jd_order_det">


                    <input type="hidden" name="custAddress" class="ch_address" value="0"/>
                    <input type="hidden" name="distinctId" class="ch_distinctId" value=""/>
                    <#if (totalCount != dianziCard)>
                    <div class="step-tit clearfix">
                        <h3>收货人信息</h3>
                        <a href="javascript:void(0);" onclick="toaddaddress()">新增收货地址</a>
                    </div>
                    <div class="step-cont">
                        <div class="consignee-addr" style="margin-bottom: 20px;">
                            <div class="consignee-cont">

                                <ul class="cust_allAddress">

                                </ul>
                            <#--<#if (lingshouCount>0)><span style="color:red;">注:订单中包含零售商品,只能选择社区店地址.</span></#if>-->
                            </div>
                            <!--consignee-cont-->
                            <div id="addr-up" class="addr-up disabled"></div>
                            <div id="addr-down" class="addr-down"></div>
                        </div>
                    </div>
                    </#if>
                    <#if (dianziCard > 0)>
                        <div class="email-cont">
                            <div >

                                <h3 class="pt20 mb10 pb10" style="border-bottom:1px solid #ddd;font-size:14px;">请输入收取电子礼品卡的邮箱地址<span style="color: red;font-weight: 700;font-size: 14px;">(务必仔细核对，以防填错收不到卡密)*</span></h3>
                            </div>
                            <input type="email" class="input-email" name="giftcardEmail" placeholder="请输入电子邮箱地址" />&nbsp;&nbsp;
                            <input type="button" value="清空"  class="clean-email" />
                        </div>
                    </#if>
                        <!--consignee-cont-->
                        <!--consignee-addr-->
                    <!--step_cont-->

                    <#--<div class="step-tit clearfix">
                        <a href="../myshoppingcart.html">返回修改购物车</a>

                        <h3>送货清单</h3>
                    </div>-->
                    <!--step-tit-->
                    <div class="step-cont">
                    <#--后台传过来的优惠金额-->
                    <#assign freePrice=0>
                    <#--原总金额-->
                    <#assign sumOldPrice="${sumOldPrice!0}">
                    <#--应付金额-->
                    <#assign sumPrice="${sumPrice!0}">
                    <#--boss商品总价格-->
                    <#assign bosssumPrice="${bossSumPrice!0}">

                    <#assign freePrice="${sumOldPrice?number-sumPrice?number}">

                    <#assign sumcount=0>
                    <#if cartMap??>

                        <input type="hidden" id="lingshouCount" value="${lingshouCount}"/>
                        <input type="hidden" id="dianziCard" name="dianziCard" value="${dianziCard}"/>
                        <#if cartMap.thirds??&&cartMap.thirds?size!=0>
                            <#list cartMap.thirds as third>

                                <div class="dis-modes">

                                    <div class="mode-item mode-tab pr">

                                        <#if third.thirdId==0>

                                            <h3 class="pt20 mb10 pb10" style="border-bottom:1px solid #ddd;font-size:14px;">支付方式</h3>

                                            <!--step-tit-->
                                            <div class="step-cont pt10" style="margin-bottom: 20px;">
                                                <div class="payment-list">
                                                    <div class="list-cont clearfix">
                                                        <input type="hidden" name="ch_pay" class="ch_pay"/>
                                                        <ul class="clearfix">
                                                            <#if payList??>
                                                                <#list payList as pl>
                                                                    <#if pl.isOpen=="1" && pl.paymentId==1>

                                                                        <li>
                                                                            <div class="payment-item bossitem  <#if pl_index==0> item-selected</#if> payset_radio_${pl.paymentId}" <#--<#if pl.temp4=='1'> onclick="dia(5)"</#if>-->
                                                                                 data-id=${pl.paymentId}>
                                                                                <b></b>
                                                                                <span class="qmark-icon qmark-tip" data-tips="${(pl.temp1)!''}"></span>
                                                                                <span>${(pl.name)!''}</span>
                                                                            </div>
                                                                        </li>
                                                                    </#if>
                                                                </#list>
                                                            </#if>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        <#else>

                                            <h4>支付方式:</h4>
                                            <!--step-tit-->
                                            <div class="step-cont pt10">
                                                <div class="payment-list" style="padding-left:0px;">
                                                    <div class="list-cont clearfix">
                                                        <input type="hidden" name="ch_paythird" class="ch_paythird"/>
                                                        <ul class="clearfix">


                                                            <li>
                                                                <div class="payment-item thirditem item-selected " data-id="1">
                                                                    <b></b>
                                                                    <span class="qmark-icon qmark-tip" data-tips="即时到帐，支持支付宝及微信支付。银行卡支付即将上线"></span>
                                                                    <span>在线支付</span>
                                                                </div>
                                                            </li>


                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </#if>

                                <#if (dianziCard == 0)>
                                        <h3 class="pt20 mb10 pb10" style="border-bottom:1px solid #ddd;font-size:14px;">配送方式<#--（<a class="ftx-05 alink" href="#">对应商品</a>）--></h3>
                                        <div class="mode-tab-nav payment-list" style="margin-bottom: 20px; padding-top: 10px;">
                                            <ul class=" clearfix list-cont">
                                                <#if cartMap??&& cartMap.frightlist?? &&(cartMap.frightlist?size>0)>
                                                    <#list cartMap.frightlist as freight>
                                                        <#if freight.freightThirdId==third.thirdId>
                                                            <li class="mode-tab-item payment-item item-selected  curr <#if third.thirdId==0>fretype bossfretype</#if>" id="jd_shipment_item">
                                                                <b></b>
                                                                <span id="jdShip-span-tip"   class="m-txt">
                                                                <#if third.thirdId==0><i class="qmark-icon qmark-tip" data-tips="商城自营配送方式"></i>
                                                                <#else><i class="qmark-icon qmark-tip" data-tips="商家配送方式"></i>
                                                                </#if>
                                                                ${freight.freightTemplateName}
                                                                </span>
                                                            </li>
                                                        </#if>


                                                    </#list>
                                                <#else>
                                                    <li class="mode-tab-item  curr"
                                                        id="jd_shipment_item">
                                                        <input type="hidden" name="distributionId"
                                                               id="distributionId" value="" expressname=""/>
                                                            <span id="jdShip-span-tip"
                                                                  class="m-txt"><#if third.thirdId==0><i class="qmark-icon qmark-tip" data-tips="商城自营配送方式"></i>
                                                            <#else><i class="qmark-icon qmark-tip" data-tips="商家配送方式"></i>
                                                            </#if>快递运输</span><b></b>
                                                    </li>

                                                </#if>
                                                <#if (lingshouCount>0) && (lingshouCount==totalCount)>
                                                <#--<#if third.thirdId==0>-->
                                                    <li class="mode-tab-item payment-item fretype thirditem"
                                                        id="ziti">
                                                        <b></b>
														<span id="jdShip-span-tip"  class="m-txt">
                                                          <i class="qmark-icon qmark-tip ziti" data-tips="商品将配送到您选择的社区店，请及时查看订单状态前往自提哦！"></i>
                                                            社区店自提
                                                    </li>
                                                <#--</#if>-->
                                                </#if>

                                            </ul>
                                        </div>

                                        <div class="mode-tab-con layout" id="selfpick_shipment" style="display:none">
                                            <ul class="mode-list">
                                                <li class="clearfix">
                                                    <div class="fore1" ><span class="ftx-03">自提地点：</span><b id="selfpick_name"></b></div>
                                                    <div class="fore2"><a href="javascript:;" onclick="dia(8)" class="ftx-05 picksite-edit">修改</a></div>
                                                </li>
                                            </ul>
                                        </div>
                                    </#if>
                                        <input type="hidden" id="bosspaySum" name="bosspaySum"
                                               value="${paySum!'0'}"/>
                                    </div>

                                </div>
                                <div class="step-tit clearfix pt20 mb10 pb10" style="border-bottom:1px solid #ddd;    line-height: 17px;">
                                    <a href="../myshoppingcart.html">返回修改购物车</a>

                                    <h3 style="font-size:14px; line-height: 17px; height: 17px;">送货清单</h3><span id="goodsweight"></span>
                                </div>
                                <div class="shopping-list clearfix mt20" style="margin-top: 11px;">
                                    <div class="goods-list fl">
                                        <#--<h4>商家：<#if third.thirdId==0>商城自营<#else>${third.thirdName} </#if></h4>-->
                                        <table class="bought-table mt10">
                                            <thead>
                                            <tr>
                                                <th width="420">商品</th>
                                                <#--<th>包装</th>-->
                                                <th>单价</th>
                                                <th>小计</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <#--<div class="goods-items">-->
                                                <input type="hidden" value="${third.thirdId?string('0')}" name="thirdIds"id="thirdIds"/>
                                                <#if cartMap.marketinglist??&&cartMap.marketinglist?size!=0>
                                                    <#list cartMap.marketinglist as market>
                                                        <#if market.businessId??&&market.businessId==third.thirdId>
                                                            <div class="goods-suit goods-last clearfix">
                                                            <#--一件货品有多个促销,得到选择的一个促销展示出来-->
                                                                <tr>
                                                                    <td colspan="3">
                                                                    <div class="goods-suit-tit" <#assign haveGoods="0">
                                                                        <#if cartMap.shoplist??&&cartMap.shoplist?size!=0>
                                                                            <#list cartMap.shoplist as cars>
                                                                                <#if cars.marketingActivityId??&&cars.marketingActivityId!=0&&cars.marketingActivityId==market.marketingId>
                                                                                    <#assign haveGoods="1">
                                                                                </#if>
                                                                            </#list>
                                                                        </#if>
                                                                        <#if haveGoods=="0">
                                                                         style="display:none;"
                                                                        </#if>>


                                                                        <strong style="color:red;margin-left: 6px; ">
                                                                            <!--直降-->
                                                                            <#if market.codexType=='1'>
                                                                                <#--直降${market.priceOffMarketing.offValue}
                                                                                元-->
                                                                               ${market.marketingName}
                                                                            </#if>

                                                                            <!--满减-->
                                                                            <#if market.codexType=='5'>
                                                                                <#--<#list market.fullbuyReduceMarketings as fr>
                                                                                    满 ${fr.fullPrice}
                                                                                    减${fr.reducePrice}元 &nbsp;
                                                                                </#list>-->
                                                                             ${market.marketingName}
                                                                            </#if>

                                                                            <!--满折-->
                                                                            <#if market.codexType=='8'>
                                                                               <#-- <#list market.fullbuyDiscountMarketings as mz>
                                                                                    满 ${mz.fullPrice}
                                                                                    打 ${mz.fullbuyDiscount*10}折
                                                                                    &nbsp;
                                                                                </#list>-->
                                                                            ${market.marketingName}
                                                                            </#if>
                                                                        <#--团购-->
                                                                        <#if market.codexType=='10'>
                                                                        ${market.marketingName}
                                                                        <#--${market.groupon.grouponDiscount*10}折团购-->
                                                                        </#if>
                                                                        <#--折扣-->
                                                                        <#if market.codexType=='15'>
                                                                            <#--${(market.preDiscountMarketings[0].discountInfo*10)?string('0.#')}折促销-->
                                                                        ${market.marketingName}
                                                                        </#if>
                                                                        <#--抢购-->
                                                                            <#if market.codexType=='11'>
                                                                            ${market.marketingName}
                                                                           <#-- ${(market.rushs[0].rushDiscount*10)?string('0.#')}折抢购-->
                                                                                <input id="bosscgprice" type="hidden" value="1">
                                                                            </#if>
                                                                            <!--包邮-->
                                                                        <#--<#if market.codexType=='12'>-->
                                                                        <#--<#if market.shippingMoney??>满 ${market.shippingMoney} 包邮</#if>-->
                                                                        <#--</#if>-->
                                                                            <!--满赠-->
                                                                            <#if market.codexType=='6'>
                                                                                 ${market.marketingName}
                                                                                <#--<#if market.fullbuyPresentMarketings??>-->

                                                                                   <#-- <#list market.fullbuyPresentMarketings as mz>
                                                                                        <#if mz.presentType??>
                                                                                            <#if mz.presentType=='0'>
                                                                                                满 ${mz.fullPrice}元送赠品
                                                                                            <#else>
                                                                                                满 ${mz.fullPrice}件送赠品
                                                                                            </#if>
                                                                                        </#if>
                                                                                        &nbsp;
                                                                                    </#list>-->
                                                                                <#--</#if>-->
                                                                            </#if>
                                                                        </strong>
                                                                    </div>
                                                                    </td>
                                                                </tr>
                                                                <#if cartMap.shoplist??&&cartMap.shoplist?size!=0>

                                                                    <#list cartMap.shoplist as cars>
                                                                        <#if cars.marketingActivityId??&&cars.marketingActivityId!=0&&cars.marketingActivityId==market.marketingId>
                                                                            <#if cars.goodsDetailBean.productVo.thirdId==third.thirdId>
                                                                                <input type="hidden"
                                                                                       class="shoppingCartId${cars.thirdId}"
                                                                                       name="shoppingCartId"
                                                                                       value="${cars.shoppingCartId?string('0')}"/>
                                                                                <input type="hidden" name="box" class="box"
                                                                                       value="${cars.shoppingCartId?string('0')}"
                                                                                       productNum="${cars.goodsNum}"/>
                                                                                <#assign sumcount="${sumcount?number+cars.goodsNum?number}">



                                                                                <tr>
                                                                                    <td>
                                                                                        <div class="goods-item clearfix">
                                                                                            <div class="p-img">
                                                                                                <a target="_blank"
                                                                                                   href="${basePath}/item/${cars.goodsDetailBean.productVo.goodsInfoId}.html"><img
                                                                                                        src="<#if cars.goodsDetailBean.productVo.goodsInfoImgId??>${cars.goodsDetailBean.productVo.goodsInfoImgId}</#if>"
                                                                                                        alt="" width="80"
                                                                                                        height="80"></a>
                                                                                            </div>
                                                                                            <div class="goods-msg">
                                                                                                <div class="p-name">
                                                                                                    <a href="${basePath}/item/${cars.goodsDetailBean.productVo.goodsInfoId}.html"
                                                                                                       target="_blank">
                                                                                                    ${cars.goodsDetailBean.productVo.productName}
                                                                                                    </a>

                                                                                                </div>
                                                                                                <div class="p-price">
                                                                                                    <span class="p-inventory stock_${cars.goodsDetailBean.productVo.goodsInfoId!'0'}" skuid="335154"
                                                                                                          id="product${cars.goodsDetailBean.productVo.goodsInfoId!'0'}">
                                                                                                        <#if (cars.goodsDetailBean.productVo.goodsInfoStock>0)>
                                                                                                            现货
                                                                                                        <#else>
                                                                                                            无货
                                                                                                        </#if>
                                                                                                    </span>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </td>
                                                                                    <#--<td>-->
                                                                                        <#--<span style="margin:8px;border:1px solid #dcbb19;border-radius: 4px;font-size:14px;padding:0px 3px;color:#dcbb19;line-height: 18px;">-->
                                                                                            <#--&lt;#&ndash;<#if cars.goodsDetailBean.sellType?? && cars.goodsDetailBean.sellType=='0'>零售</#if>-->
                                                                                        <#--<#if cars.goodsDetailBean.sellType?? && cars.goodsDetailBean.sellType=='1'>批发</#if>&ndash;&gt;-->
                                                                                                <#--<#if cars.goodsDetailBean.productVo.productName??&&cars.goodsDetailBean.productVo.productName?index_of("零售")!=-1>零售</#if>-->
                                                                                                <#--<#if cars.goodsDetailBean.productVo.productName??&&cars.goodsDetailBean.productVo.productName?index_of("批发")!=-1>批发</#if>-->
                                                                                        <#--</span>-->
                                                                                    <#--</td>-->
                                                                                    <td>
                                                                                        <div class="p-price">

                                                                                            <font style="color:#666666;" class="price_${cars.goodsDetailBean.productVo.goodsInfoId}">
                                                                                                <#assign price=0>
                                                                                                <#assign sumprice="0">
                                                                                                <#if market.codexType=='1'>
                                                                                                    <#assign sumprice="${((cars.goodsDetailBean.productVo.goodsInfoPreferPrice?number-market.priceOffMarketing.offValue?number)*cars.goodsNum?number)?string('0.00')}">
                                                                                                    ¥  ${(cars.goodsDetailBean.productVo.goodsInfoPreferPrice?number-market.priceOffMarketing.offValue?number)?string("0.00")}
                                                                                                    x <#if cars.goodsNum??>${cars.goodsNum}</#if>
                                                                                                <#elseif market.codexType=='10'>
                                                                                                   <#assign  sumprice="${((cars.goodsDetailBean.productVo.goodsInfoPreferPrice?number*market.groupon.grouponDiscount?number)*cars.goodsNum?number)?string('0.00')}">
                                                                                                    ¥  ${(cars.goodsDetailBean.productVo.goodsInfoPreferPrice?number*market.groupon.grouponDiscount?number)?string("0.00")}
                                                                                                    x <#if cars.goodsNum??>${cars.goodsNum}</#if>
                                                                                                <#elseif market.codexType=='15'>
                                                                                                    <#assign  sumprice="${((cars.goodsDetailBean.productVo.goodsInfoPreferPrice?number*market.preDiscountMarketings[0].discountInfo?number)*cars.goodsNum?number)?string('0.00')}">
                                                                                                    ¥  ${(cars.goodsDetailBean.productVo.goodsInfoPreferPrice?number*market.preDiscountMarketings[0].discountInfo?number)?string('0.00')}
                                                                                                    x <#if cars.goodsNum??>${cars.goodsNum}</#if>
                                                                                                <#elseif market.codexType=='11'>
                                                                                                       <#if market.customerbuynum?? && market.customerbuynum gt 0>
                                                                                                       <#if market.customerbuynum?? && cars.goodsNum?number gt market.customerbuynum>
                                                                                                           <#assign sumprice="${(((market.rushs[0].rushDiscount?number*cars.goodsDetailBean.productVo.goodsInfoPreferPrice?number)*market.customerbuynum!1)+((cars.goodsNum?number-market.customerbuynum!1)*cars.goodsDetailBean.productVo.goodsInfoPreferPrice?number))?string('0.00')}">
                                                                                                           <span>¥ ${(market.rushs[0].rushDiscount?number*cars.goodsDetailBean.productVo.goodsInfoPreferPrice?number)?string("0.00")}
                                                                                                               x ${market.customerbuynum!1}</span><br/>
                                                                                                           ¥ ${(cars.goodsDetailBean.productVo.goodsInfoPreferPrice?number)?string("0.00")}
                                                                                                           x ${cars.goodsNum?number-market.customerbuynum!1}
                                                                                                       <#else>
                                                                                                           <#assign  sumprice="${((market.rushs[0].rushDiscount?number*cars.goodsDetailBean.productVo.goodsInfoPreferPrice?number)*cars.goodsNum?number)?string('0.00')}">
                                                                                                           ¥ ${(market.rushs[0].rushDiscount?number*cars.goodsDetailBean.productVo.goodsInfoPreferPrice?number)?string("0.00")}
                                                                                                           x <#if cars.goodsNum??>${cars.goodsNum}</#if>
                                                                                                       </#if>
                                                                                                       <#else>
                                                                                                           <#assign sumprice="${(cars.goodsDetailBean.productVo.goodsInfoPreferPrice?number*cars.goodsNum?number)?string('0.00')}">
                                                                                                           ¥  ${cars.goodsDetailBean.productVo.goodsInfoPreferPrice?string('0.00')}
                                                                                                           x <#if cars.goodsNum??>${cars.goodsNum}</#if>
                                                                                                       </#if>
                                                                                                <#else>
                                                                                                    <#assign sumprice="${(cars.goodsDetailBean.productVo.goodsInfoPreferPrice?number*cars.goodsNum?number)?string('0.00')}">
                                                                                                    ¥  ${cars.goodsDetailBean.productVo.goodsInfoPreferPrice?string('0.00')}
                                                                                                    x <#if cars.goodsNum??>${cars.goodsNum}</#if>
                                                                                                </#if>
                                                                                                <#assign price="${cars.goodsDetailBean.productVo.goodsInfoPreferPrice}">
                                                                                            </font>

                                                                                        <#--计算各个商家的费用-->
                                                                                            <#assign payPrice=0>
                                                                                            <#assign  payPrice="${payPrice+(price?number*cars.goodsNum?number)}">

                                                                                        </div>
                                                                                    </td>
                                                                                    <td>
                                                                                        <span class="ml20" style="margin-left: 0;">
                                                                                            <#if cars.goodsNum??>¥  ${sumprice}</#if>
                                                                                        </span>
                                                                                    </td>
                                                                                </tr>
                                                                                <!--good-suit-->
                                                                            </#if>
                                                                        </#if>
                                                                    </#list>

                                                                </#if>
                                                                <#if market.codexType=='6'>
                                                                    <#if market.fullbuyPresentMarketings??>
                                                                        <#if (cartMap.fulllist?? && cartMap.fulllist?size>0)>
                                                                            <#list cartMap.fulllist as goods>
                                                                                <#if (goods.marketingId==market.marketingId && goods.fullbuyPresentScopes?? && goods.fullbuyPresentScopes?size>0)>
                                                                                    <div style="color:#999999;margin-bottom: 10px;">
                                                                                        <#list goods.fullbuyPresentScopes as good>
                                                                                            <#if good.scopeType?number==0>
                                                                                                <#if good.goodsProduct??>
                                                                                                    <p style="margin-bottom: 5px;"><span>【赠品】 ${good.goodsProduct.goodsInfoName}</span> × <span>${good.scopeNum}</span></p>
                                                                                                </#if>
                                                                                            </#if>
                                                                                        </#list>
                                                                                    </div>
                                                                                </#if>
                                                                            </#list>
                                                                        </#if>

                                                                    </#if>
                                                                </#if>
                                                            </div>
                                                        </#if>
                                                    </#list>

                                                </#if>
                                            <#--没有参与促销-->
                                                <#if cartMap.shoplist??&&cartMap.shoplist?size!=0>
                                                    <#list cartMap.shoplist as cars>
                                                        <!--是套装-->
                                                        <#if cars.fitId??>
                                                            <#if cars.thirdId==third.thirdId>
                                                                <input type="hidden" class="shoppingCartId${cars.thirdId}"
                                                                       name="shoppingCartId"
                                                                       value="${cars.shoppingCartId?string('0')}"/>
                                                                <input type="hidden" name="box" class="box"
                                                                       value="${cars.shoppingCartId?string('0')}"
                                                                       productNum="${cars.goodsNum}"/>
                                                                <#assign sumcount="${sumcount?number+cars.goodsNum?number}">
                                                            <tr>
                                                                <td colspan="3">
                                                                    <div class="goods-suit-tit">

                                                                        <strong>【套装】${cars.goodsGroupVo.groupName}
                                                                            每套优惠${cars.goodsGroupVo.groupPreferamount}
                                                                            元<input type="hidden"
                                                                                    value="${cars.goodsGroupVo.groupPreferamount}"
                                                                                    class="groupPreferamount"/></strong>
                                                                    </div>
                                                                </td>
                                                            </tr>

                                                        <#if cars.goodsGroupVo.productList??&&cars.goodsGroupVo.productList?size!=0>
                                                            <#list cars.goodsGroupVo.productList as pro>
                                                            <tr>
                                                                <td>
                                                                    <div class="goods-suit goods-last clearfix">

                                                                        <div class="goods-item clearfix">
                                                                            <div class="p-img">
                                                                                <a href="${basePath}/item/${pro.productDetail.goodsInfoId}.html"
                                                                                   target="_blank"
                                                                                   title="${basePath}/item/${pro.productDetail.goodsInfoId}.html">
                                                                                    <img style="width:50px;height:50px;"
                                                                                         title="${pro.productDetail.goodsInfoName}"
                                                                                         alt="${pro.productDetail.goodsInfoName}"
                                                                                         src="<#if pro.productDetail.goodsInfoImgId??>${pro.productDetail.goodsInfoImgId}</#if>"/></a>
                                                                            </div>
                                                                            <div class="goods-msg">
                                                                                <div class="p-name">
                                                                                    <a href="javascript:void(0);"
                                                                                       target="_blank">
                                                                                    ${pro.productDetail.goodsInfoName}
                                                                                    </a>
                                                                                </div>
                                                                                <div class="p-price">

                                                                                    <span class="p-inventory stock_${pro.productDetail.goodsInfoId}" skuid="335154"
                                                                                          id="product${pro.productDetail.goodsInfoId!'0'}">
                                                                                        <#if (cars.goodsGroupVo.stock>0)>
                                                                                            现货
                                                                                        <#else>
                                                                                            无货
                                                                                        </#if>
                                                                                    </span>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                    </div>
                                                                </td>
                                                                <#--<td>-->
                                                                    <#--<span style="margin:8px;border:1px solid #dcbb19;border-radius: 4px;font-size:14px;padding:0px 3px;color:#dcbb19;line-height: 18px;">-->
                                                                        <#--<&lt;#&ndash;#if pro.productDetail.sellType?? && pro.productDetail.sellType=='0'>零售</#if>-->
                                                                        <#--<#if pro.productDetail.sellType?? && pro.productDetail.sellType=='1'>批发</#if>&ndash;&gt;-->
                                                                        <#--<#if pro.productDetail.goodsInfoName??&&pro.productDetail.goodsInfoName?index_of("零售")!=-1>零售</#if>-->
                                                                        <#--<#if pro.productDetail.goodsInfoName??&&pro.productDetail.goodsInfoName?index_of("批发")!=-1>批发</#if>-->
                                                                    <#--</span>-->
                                                                <#--</td>-->
                                                                <td>
                                                                    <div class="p-price">
                                                                    <#--计算各个商家的费用-->
                                                                        <#assign payPrice=0>
                                                                        <#if pro.productNum??>
                                                                            <#assign pn = "${pro.productNum?number}">
                                                                        <#else>
                                                                            <#assign pn = 1>
                                                                        </#if>
                                                                        <#assign  payPrice="${payPrice+(pro.productDetail.goodsInfoPreferPrice?number*cars.goodsNum?number*pn?number)}">
                                                                        <span class="pv_smprice price_${pro.productDetail.goodsInfoId}" style="color:red">¥ ${pro.productDetail.goodsInfoPreferPrice?number*cars.goodsNum?number*pn?number} </span>

                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <span class="ml20" >${pn?number}件/套 x<#if cars.goodsNum??>${cars.goodsNum}</#if></span>
                                                                </td>
                                                            </tr>

                                                            </#list>
                                                        </#if>
                                                                <!--good-suit-->



                                                            </#if>
                                                        <#else>
                                                        <#--不是套装-->
                                                            <#if cars.marketingActivityId??&&cars.marketingActivityId!=0>
                                                            <#else >
                                                                <#if cars.goodsDetailBean.productVo.thirdId==third.thirdId>

                                                                    <input type="hidden" class="shoppingCartId${cars.thirdId}"
                                                                           name="shoppingCartId"
                                                                           value="${cars.shoppingCartId?string('0')}"/>
                                                                    <input type="hidden" name="box" class="box"
                                                                           value="${cars.shoppingCartId?string('0')}"
                                                                           productNum="${cars.goodsNum}"/>
                                                                    <#assign sumcount="${sumcount?number+cars.goodsNum?number}">
                                                                    <div class="goods-suit goods-last clearfix">
                                                                    <#--<div class="goods-suit-tit">-->


                                                                    <#--<strong>-->
                                                                    <#--普通商品-->
                                                                    <#--</strong>-->
                                                                    <#--</div>-->

                                                                        <tr>
                                                                            <td>
                                                                                <div class="goods-item clearfix">
                                                                                    <div class="p-img">
                                                                                        <a target="_blank"
                                                                                           href="${basePath}/item/${cars.goodsDetailBean.productVo.goodsInfoId}.html"><img
                                                                                                src="<#if cars.goodsDetailBean.productVo.goodsInfoImgId??>${cars.goodsDetailBean.productVo.goodsInfoImgId}</#if>"
                                                                                                alt="" width="80" height="80"></a>
                                                                                    </div>
                                                                                    <div class="goods-msg">
                                                                                        <div class="p-name">
                                                                                            <a href="${basePath}/item/${cars.goodsDetailBean.productVo.goodsInfoId}.html" target="_blank">
                                                                                            ${cars.goodsDetailBean.productVo.productName}
                                                                                            </a>
                                                                                        </div>
                                                                                        <div class="p-price">


                                                                                            <span class=" p-inventory stock_${cars.goodsDetailBean.productVo.goodsInfoId}" skuid="335154"
                                                                                                  id="product${cars.goodsDetailBean.productVo.goodsInfoId!'0'}">
                                                                                                <#if (cars.goodsDetailBean.productVo.goodsInfoStock>0)>
                                                                                                    现货
                                                                                                <#else>
                                                                                                    无货
                                                                                                </#if>
                                                                                            </span>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </td>
                                                                            <#--<td>-->
                                                                                <#--<span style="margin:8px;border:1px solid #dcbb19;border-radius: 4px;font-size:14px;padding:0px 3px;color:#dcbb19;line-height: 18px;">-->
                                                                                    <#--&lt;#&ndash;<#if cars.goodsDetailBean.sellType?? && cars.goodsDetailBean.sellType=='0'>零售</#if>-->
                                                                                    <#--<#if cars.goodsDetailBean.sellType?? && cars.goodsDetailBean.sellType=='1'>批发</#if>&ndash;&gt;-->
                                                                                        <#--<#if cars.goodsDetailBean.productVo.productName??&&cars.goodsDetailBean.productVo.productName?index_of("零售")!=-1>零售</#if>-->
                                                                                        <#--<#if cars.goodsDetailBean.productVo.productName??&&cars.goodsDetailBean.productVo.productName?index_of("批发")!=-1>批发</#if>-->
                                                                                <#--</span>-->
                                                                            <#--</td>-->
                                                                            <#assign price=0>
                                                                            <td>
                                                                                <div class="p-price">

                                                                                    <font style="color:#666666;" class="price_${cars.goodsDetailBean.productVo.goodsInfoId}">

                                                                                        <#if cars.marketingId??>
                                                                                            <#if cars.marketingList??&&cars.marketingList?size!=0>
                                                                                                <!--判断是否参与折扣促销-->
                                                                                                <#assign mflag=0>

                                                                                                <#assign price="${cars.goodsDetailBean.productVo.goodsInfoPreferPrice}">
                                                                                                <!--循环促销-->
                                                                                                <#list cars.marketingList as market>
                                                                                                    <!--判断是否是相同促销，并且是折扣促销-->
                                                                                                    <#if cars.marketingId==market.marketingId&&market.codexType=='15'>
                                                                                                        <!--促销范围-->
                                                                                                        <#list market.preDiscountMarketings as m>
                                                                                                            <!--是否是当前的商品-->
                                                                                                            <#if m.goodsId ==cars.goodsInfoId >
                                                                                                                <!--显示折后价格-->
                                                                                                                <strong>¥ ${m.discountPrice?string("0.00")}</strong>
                                                                                                                <#assign price="${m.discountPrice}">
                                                                                                                <#assign mflag=1>
                                                                                                            </#if>
                                                                                                        </#list>

                                                                                                    </#if>
                                                                                                </#list>
                                                                                                <#if mflag==0>
                                                                                                    <strong>¥${price}</strong>
                                                                                                </#if>
                                                                                            <#else>
                                                                                                ¥  ${cars.goodsDetailBean.productVo.goodsInfoPreferPrice?string("0.00")}
                                                                                                <#assign price="${cars.goodsDetailBean.productVo.goodsInfoPreferPrice}">
                                                                                            </#if>
                                                                                        <#else>
                                                                                            ¥  ${cars.goodsDetailBean.productVo.goodsInfoPreferPrice?string("0.00")}
                                                                                            <#assign price="${cars.goodsDetailBean.productVo.goodsInfoPreferPrice}">
                                                                                        </#if>
                                                                                        x <#if cars.goodsNum??>${cars.goodsNum}</#if>
                                                                                    </font>
                                                                                    <#assign payPrice=0>
                                                                                    <#assign  payPrice="${payPrice+(price?number*cars.goodsNum?number)}">

                                                                                </div>

                                                                            </td>
                                                                            <td>
                                                                                <span class="ml20" style="margin-left: 0;"><#if cars.goodsNum??>¥  ${(cars.goodsDetailBean.productVo.goodsInfoPreferPrice * cars.goodsNum)?string('0.00')}</#if></span>
                                                                            </td>
                                                                        </tr>


                                                                    </div>
                                                                    <!--good-suit-->



                                                                </#if>
                                                            </#if>
                                                        </#if>
                                                    </#list>
                                                </#if>
                                                <input id="third_${third.thirdId}" value="${payPrice!''}" type="hidden"/>
                                            <#--</div>-->
                                            <!--goods-itmes-->
                                            </tbody>
                                        </table>

                                    </div>
                                    <!--goods-list-->

                                </div>


                            </#list>
                        </#if>
                    </#if>
                        <div class="order-remarks hide" id="orderRemarkItem" style="display: block;padding-left: 40px;">
                            <div class="remark-tit">添加订单备注(限45个字)</div>
                            <div id="remarkId" style="margin-bottom:7px">
                                <div class="form remark-cont">
                                    <textarea style="width: 300px;height: 60px;" id="message_left" name="customerRemark"
                                              size="15" class="itxt itxt01" maxlength="45"></textarea>
                                    <span class="ftx-03 ml10">&nbsp;&nbsp;提示：请勿填写有关支付、收货、发票方面的信息</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--step-cont-->
                    <div class="step-tit clearfix">
                        <h3>发票信息</h3>
                    </div>
                    <div class="step-content">
                        <div id="part-inv" class="invoice-cont">
                            <span class="mr10 ch_invoiceType"> 不需要发票 &nbsp; </span>
                            <input type="hidden" name="ch_voinceType" class="ch_invoceTypeValue" value="0">
                            <span class="mr10 tr_invoiceTitleView" style="display:none"> 个人&nbsp; </span>
                            <input type="hidden" name="chInvoiceTitle" class="ch_invoceTitleValue" value="">
                            <span class="mr10 invoiceContentMing" style="display:none"> 明细&nbsp; </span>
                            <input type="hidden" name="chInvoiceContent" class="ch_invoiceContentValue" value="">
                            <input type="hidden" name="taxpayerNumber" value="">
                            <a href="javascript:void(0)" class="ftx-05 invoice-edit" onclick="dia(4)">修改</a>
                        </div>
                    </div>

                    <div class="coupon ml20">
                        <a class="part_open" href="javascript:;">使用优惠券抵消部分金额</a>

                        <div class="coupon_cont" style="display:none;">
                            <h4>可用优惠券<span class="red cpl">(0)</span></h4>

                            <div class="coupon_choice">
                                <input type="hidden" value="" id="codeNo" name="codeNo"/>
                            <#if cartMap??&&cartMap.couponlist??&&(cartMap.couponlist?size>0)>
                                <input type="hidden" value=${cartMap.couponlist?size} id="cpLength">

                                <p><input type="radio" name="couponNo" value="" onclick="couponChange(this,0);"/><label>不使用优惠劵</label>
                                </p>
                                <#list cartMap.couponlist as coupon>

                                    <#if coupon.couponRulesType=='1'>
                                        <p><input type="radio" name="couponNo" value="${coupon.codeNo}"
                                                  onclick="couponChange(this,${coupon.couponStraightDown.downPrice});"/><label>${coupon.couponName}</label>
                                        </p>
                                    </#if>
                                    <#if coupon.couponRulesType=='2'>
                                    <#--<#if (payPrice?number>=coupon.couponFullReduction.fullPrice?number) >-->
                                        <p><input type="radio" name="couponNo" value="${coupon.codeNo}"
                                                  onclick="couponChange(this,${coupon.couponFullReduction.reductionPrice});"/><label>${coupon.couponName}</label>
                                        </p>
                                    <#--</#if>-->
                                    </#if>
                                </#list>
                            <#else>
                                <p class="coupon_empty light_9">
                                    您账户中没有可使用的优惠券。<!--您可以
												<a href="#" class="ml10 red">查看优惠券</a>
												了解使用限制。-->
                                    <#--<a href="#" class="ml10 red">[了解优惠券使用规则]</a>-->
                                </p>
                            </#if>

                            <#--<ul>
                                <li><label><input type="radio" name="coupon" />满100减10元</label></li>
                                <li><label><input type="radio" name="coupon" />满200减15元</label></li>
                                <li><label><input type="radio" name="coupon" />满500减20元</label></li>
                            </ul>-->
                            </div>
                            <div class="entity" id="inputCoupon">
                            </div>
                            <div class="coupon_total">
                            </div>
                            <div class="add_coupon_warn" style="display:none;color:red;"></div>
                        </div>
                    </div>
                    <!-- /coupon -->

                    <!-- 0063336: 订单结算页面，使用优惠券，会员积分样式变形,去掉margin: 20px;-->
                    <div class="remark" style="">
                        <a class="part_open" href="javascript:void(0)">使用会员积分抵消部分金额</a>

                        <div class="money_card_cont" style="display: none; margin-left:20px;">
                            <div class="beans">
                                <!-- 未使用过京豆 -->
                            <#if cartMap??&&cartMap.customerPoint?? && cartMap.pointSet?? >
                                <div class="bs-t">
                                    <span>本次使用</span>
                                    <input id="amount" style="IME-MODE: disabled; WIDTH: 60px; HEIGHT: 15px"
                                           onkeyup="this.value=this.value.replace(/\D/g,'')"
                                           onafterpaste="this.value=this.value.replace(/\D/g,'')"
                                           maxlength="10" size="14" name="amount" fmax="40" type="text"/>
                                    <span>积分用于兑换</span>
                                    <input type="button" id="shiyong" value="使用"
                                           style="width: 60px; height: 25px; background-color:#B87070"
                                           onclick="jifen()" class="btn-add btn-1">


                                    <input type="button" id="shiyong" value="清零"
                                           style="width: 60px; height: 25px; background-color:#B87070"
                                           onclick="changeScre()" class="btn-add btn-1">
                                    <span id="tishi" style="color:red"></span>
                                    <input type="hidden" id="customerPoint" value="${cartMap.customerPoint}"/>
                                    <input type="hidden" id="pointSet" name="pointSet" value="${cartMap.pointSet}"/>
                                <#--<input type="hidden" id="zongjiage" name="zongjiage" value=""/>-->
                                <#--<input type="hidden" id="duihuanjifen" name="duihuanjifen" value=""/>-->
                                    <input type="hidden" id="jifen1" value="${cartMap.customerPoint}"/>
                                    <input type="hidden" id="jifen2" value="0"/>
                                    <input type="hidden" id="bosssumPrice" />

                                    <input type="hidden" id="bossNum" name="bossNum" value="0"/>
                                    <label class="error" for="userBeans">
                                        您本次最多可以使用<span
                                            style="font-size: 14px; text-decoration:underline;font-weight:bold;">
                                    ${cartMap.customerPoint}</span>积分</label>
                                </div>
                                <div class="bs-m">
                                    <!-- 使用过京豆 -->
									<span class="rest">您有积分<s id="muqianjifen" style="font-size: 14px; text-decoration:underline;font-weight:bold;">
                                    ${(cartMap.customerPoint)?string('0')}</s>个<b
                                            id="muqianjifen1" style="display: none;">${(cartMap.customerPoint)?string('0')}</b></span>,
                                    每10积分兑换人民币¥${cartMap.pointSet}元。
                                </div>
                            </#if>

                            </div>
                        </div>
                        <!--money_card_cont-->
                    </div>
                    <!-- /remark -->
                    <div class="order-summary clearfix" style="padding-right:10px;">
                        <div class="statistic fr" style="position:relative;">

                            <div class="list">
                                <span><font color="red">${(sumcount?number)?string("0")} </font>件商品，总商品金额：</span>
                                <em class="price" id="sumOldPrice">¥${(sumOldPrice?number)?string('0.00')}</em>
                            </div>
                            <div class="list" >
                                <span class="xiaoshi" style="background: url(/css/suborder/suborder-icon.png) no-repeat;background-position: 6px -68px; width:58px;margin-left: 122px;">运费：</span>
                                <em class="price" id="ep"> ¥0.00</em>
                            </div>
                            <div class="xianshi"></div>
                            <div class="list">
                                <span>优惠券：</span>
                                <em class="price" id="yh"> ¥0.00</em>
                                <input type="hidden" id="youhui">
                            </div>
                            <div class="list">
                                <#--<span>返现金额：</span>-->
                                <span>优惠金额：</span>
                                <em class="price" id="yhprice"> ¥0.00</em>

                            </div>
                            <div class="list">
                                <span>会员折扣：</span>
                                <em class="price" id="discount">¥0.00</em>

                            </div>
                            <div class="list">
                                <span>积分兑换金额：</span>
                                <em class="price" id="jf"> ¥0.00</em>
                            </div>

                            <div class="list">
                                <span>应付总额：</span>
                                <em class="price" id="lastpay"> ¥0.00</em>
                            </div>
                        </div>
                    </div>
                    <!--order-summary-->

                    <div class="trade-foot">
                        <div id="checkout-floatbar" class="group">
                            <div class="ui-ceilinglamp checkout-buttons ui-ceilinglamp-current">
                                <div class="sticky-placeholder hide" style="display: none;">
                                </div>
                                <div class="sticky-wrap">
                                    <div class="inner">
                                        <button type="button" class="checkout-submit btn-1" id="tijiao_order" onclick="_czc.push(['_trackEvent', '提交订单', '查看', '提交订单',  'tijiao_order']);submitForm(this);" style="background: #00991D;border-radius: 4px;font-weight:400;font-size: 15px;letter-spacing: 0.54px;">
                                            提交订单
                                        </button>
                                        <input type="hidden" id="sumPrice"/><!--记录未使用优惠券和积分兑换之前的总价格-->

                                        <input type="hidden" id="payPrice" />
	                    <span class="total">应付总额：<strong id="lastpays" style="color: red;"></strong>
	            <label class="noShowMoney hide" id="giftBuyHidePriceDiv">
                    <input type="checkbox" id="giftBuyHidePrice" checked="">隐藏礼品价格
                </label>
	          </span>
                                        <span id="checkCodeDiv"></span>

                                        <div class="checkout-submit-tip" id="changeAreaAndPrice" style="display: none;">
                                            由于价格可能发生变化，请核对后再提交订单
                                        </div>
                                        <div style="display:none" id="factoryShipCodShowDivBottom" class="dispatching">
                                            部分商品货到付款方式：先由京东配送“提货单”并收款，然后厂商发货。
                                        </div>
                                    </div>
                                    <span id="submit_message" style="display:none" class="submit-error"></span>

                                    <div class="submit-check-info" id="submit_check_info_message"
                                         style="display:none"></div>
                                </div>
                            </div>
                        </div>

                        <div class="consignee-foot">
                        <#--<p>
							寄送至： 江苏 南京市 建邺区 南湖街道  湖西街露园小区13栋55号202室<br>
							收货人：彭斯斯 186****6787
						</p>-->
                        </div>
                        <!--/ /widget/checkout-floatbar/checkout-floatbar.tpl -->
                    </div>
                </div>
                <!--jd_order_det-->
            </form>
        </div>
        <!--w990-->

    </div>
    <!--container-->
</div>
<!--font-family: arial;-->
<div class="mask"></div>
<div class="jd-dialog dia1 address_dia">
    <div class="jd-dialog-title"><p id="addressinfo">新增收货人信息</p><a href="javascript:void(0)" class="jd-dialog-close"
                                           onclick="cls(),setDefaultForm();">×</a></div>
    <div class="jd-dialog-con clearfix p10">
        <div class="form" id="consignee-form" name="consignee-form">
            <div class="item clearfix" >
                <span class="label"><span style="color:red">*</span>&nbsp;地址类型：</span>

                <div class="fl">
                    <input type="radio" id="addressType1" name="addressType" value="1" style="width:14px;height: 30px;<#if lingshouCount!=totalCount>display:none;</#if>" onclick="$('#community_div').show()" <#if (lingshouCount>0) && (lingshouCount==totalCount)>checked</#if>>
                        <#if (lingshouCount>0) && (lingshouCount==totalCount)>社区店</#if>
                    <input type="radio" id="addressType0" name="addressType" value="0" style="width:14px;height: 30px;<#if (lingshouCount>0) && (lingshouCount==totalCount)>display:none;</#if>" onclick="$('#community_div').hide()" <#if lingshouCount!=totalCount>checked</#if>>
                        <#if lingshouCount!=totalCount>自选地址</#if>
                </div>
            </div>
            <#if (lingshouCount>0) && (lingshouCount==totalCount)>
            <div class="item clearfix" id="community_div">
                <span class="label"><span style="color:red">*</span>&nbsp;社区店：</span>
                <div class="fl">
                    <span id="span_province"><select class="selt" id=infoProvinceCommunity tabindex="2"><option value="">请选择：</option></select></span>
                    <span id="span_city"><select class="selt" id=infoCityCommunity tabindex="3"><option value="">请选择：</option></select></span>
                    <span id="span_county"><select class="selt" id=infoCountyCommunity tabindex="4"><option value="">请选择：</option></select></span>
                    <span id="span_area">
                      <span id="community_stores"><select id="community_stores_select" class="selt" name="communityStoreId" tabindex="2" onchange="checkCommunityStore()"><option value="">请选择：</option></select></span>
                    </span>
                </div>
                <span class="error-msg communityTips" id="community_div_error"></span>
            </div>
            </#if>
            <div class="item clearfix" id="name_div">
                <span class="label"><span style="color:red">*</span>&nbsp;收货人：</span>

                <div class="fl">
                    <input type="hidden" class="save_update_add_id">
                    <input type="hidden" id="consignee_form_id" name="consigneeParam.id" value="">
                    <input type="hidden" id="consignee_type" name="consigneeParam.type" value="">
                    <input type="hidden" id="consignee_ceshi1" name="consignee_ceshi1" value="">
                    <input type="text" class="itxt save_add_name" id="consignee_name" onblur="checkAddressName();"
                           name="addressName" maxlength="12" value="" tabindex="1">
                    <span class="error-msg addressNameTip" id="name_div_error"></span>
                </div>
            </div>
            <div class="item clearfix" id="area_div">
                <span class="label"><span style="color:red">*</span>&nbsp;所在地区：</span>

                <div class="fl">
			<span id="span_area">
			  <span id="span_province"><select class="selt" name="infoProvince" id=infoProvince tabindex="2"><option value="">请选择：</option></select></span>
			   <span id="span_city"><select class="selt" name="infoCity" id=infoCity tabindex="3"><option value="">请选择：</option></select></span>
			   <span id="span_county"><select class="selt" name="infoCounty" id=infoCounty tabindex="4"><option value="">请选择：</option></select></span>
            <#--<span id="span_town"><select class="selt" name="infoStreet" id=infoStreet tabindex="5"><option value="">请选择：</option></select></span>-->
	        </span>
                <#--<span class="error-msg" id="area_div_error"></span>
                <div class="ftx-03">标“*”的为支持货到付款的地区，<a href="javascript:void(0)" target="_Blank" class="ftx-05" id="codHelpUrl">查看货到付款地区</a></div>-->
                </div>
            </div>
            <div class="item clearfix">
                <span class="label" id="address_div"><span style="color:red">*</span>&nbsp;详细地址：</span>

                <div class="fl">
                    <!--span id="areaNameTxt"></span-->
                    <input type="text" class="itxt itxt02 save_add_detail" name="addressDetail"
                           onblur="checkAddressDetail();" maxlength="40" onblur="check_Consignee('address_div')"
                           value="" tabindex="6">
                    <span class="error-msg addressDetailTip" id="address_div_error"></span>
                </div>
            </div>
            <div class="item clearfix" id="call_div">
                <span class="label"><span style="color:red">*</span>&nbsp;手机号码：</span>

                <div class="fl">
                    <input type="text" class="itxt save_add_mobile" onblur="checkAddressMobile();" name="addressMoblie"
                           onblur="check_Consignee('call_mobile_div')" onfocus="if(value == defaultValue){value='';}"
                           maxlength="11" value="" tabindex="7">
                </div>
                <div class="fl">
                    <span class="label">固定电话：</span>
                    <input type="text" class="itxt save_add_phone" onblur="checkAddressPhone();" size="30"
                           name="addressPhone" onblur="check_Consignee('call_phone_div')"
                           onfocus="if(value == defaultValue){value='';}" maxlength="20" value="" tabindex="8">
                </div>
                <span class="error-msg addressPhoneTip" id="call_div_error"></span>
            </div>
        <#--<div class="item clearfix" id="email_div">
            <span class="label">邮箱：</span>
            <div class="fl">
                <input type="text" class="itxt save_add_email" name="addressEmail" onblur="" maxlength="50" onblur="check_Consignee('email_div')" value="" onfocus="if(value == defaultValue){value='';}" tabindex="9">
                <span class="error-msg addressEmailTip" id="email_div_error"></span>
                <div class="ftx-03">用来接收订单提醒邮件，便于您及时了解订单状态</div>
            </div>
        </div>-->
            <div class="item clearfix" id="addressZip_div">
                <span class="label">邮政编码：</span>

                <div class="fl">
                    <input type="text" class="itxt save_add_post" name="addressZip" maxlength="50"
                           onblur="checkAddressPost();" value="" onfocus="if(value == defaultValue){value='';}"
                           tabindex="9">
                    <span class="error-msg addPostTips" id="addressZip_div_error"></span>
                </div>
            </div>
            <div class="item clearfix">
                <span class="label">&nbsp;</span>

                <div class="fl">
                    <a href="javascript:void(0)" class="btn-9 save_address"><span
                            id="saveConsigneeTitleDiv">保存收货人信息</span></a>

                    <div class="loading loading-1" style="display:none"><b></b>正在提交信息，请等待！</div>
                    <!--a href="#none" class="btn-9 ml10">取消</a-->
                </div>
                <div style="display:none"><input id="consignee_form_reset" name="" type="reset"></div>
            </div>
        </div>
    </div>
    <!--jd-dialog-con-->
</div>
<!--jd-dialog-->

<div class="jd-dialog dia2 time_dia">
    <div class="jd-dialog-title">配送时间<a href="javascript:void(0)" class="jd-dialog-close" onclick="cls()">×</a></div>
    <div class="jd-dialog-con clearfix p10">
        <div class="date-thickbox" id="delivery-tab-311">
            <div class="tab-nav">
                <ul class="clearfix">
                    <li class="tab-nav-item tab-item-selected" id="li_311_id" onclick="doSwith311Tab('311')"> 指定时间
                        <b> </b></li>
                    <li class="tab-nav-item hide" id="li_411_id" onclick="doSwith311Tab('411')"> 极速达 <b> </b></li>

                </ul>
            </div>
            <div class="tab-con" id="tab_311_div">
                <div class="date-delivery" id="date-delivery1">
                    <div class="inner">
                        <dl class="th">
                            <dt>时间段</dt>
                            <dd class="date"><span row="-1" col="0">4-27<br>今天</span> <span row="-1" col="1">4-28<br>周二</span>
                                <span row="-1" col="2">4-29<br>周三</span> <span row="-1" col="3">4-30<br>周四</span> <span
                                        row="-1" col="4">5-1<br>周五</span> <span row="-1" col="5">5-2<br>周六</span> <span
                                        row="-1" col="6">5-3<br>周日</span> <span class="last" row="-1" col="7">5-4<br>周一</span>
                            </dd>
                            <dd class="time"><span row="0" col="-1">09:00-15:00</span> <span class="last" row="1"
                                                                                             col="-1">15:00-19:00</span>
                            </dd>
                        </dl>
                        <div class="data">
                            <ul>
                                <li class="checkbox disabled" data-status="0" row="0" col="0"></li>
                                <li class="checkbox disabled" data-status="0" row="1" col="0"></li>
                            </ul>
                            <ul>
                                <li class="checkbox selected" data-status="1" row="0" col="1"
                                    val="4-28 (周二) 09:00-15:00" day="2015-4-28" range="09:00-15:00"
                                    date-range="{&quot;1&quot;:1,&quot;35&quot;:1,&quot;30&quot;:1}">已选
                                </li>
                                <li class="checkbox last" data-status="1" row="1" col="1" val="4-28 (周二) 15:00-19:00"
                                    day="2015-4-28" range="15:00-19:00"
                                    date-range="{&quot;1&quot;:1,&quot;35&quot;:2,&quot;30&quot;:1}">可选
                                </li>
                            </ul>
                            <ul>
                                <li class="checkbox" data-status="1" row="0" col="2" val="4-29 (周三) 09:00-15:00"
                                    day="2015-4-29" range="09:00-15:00"
                                    date-range="{&quot;1&quot;:1,&quot;35&quot;:1,&quot;30&quot;:1}">可选
                                </li>
                                <li class="checkbox last" data-status="1" row="1" col="2" val="4-29 (周三) 15:00-19:00"
                                    day="2015-4-29" range="15:00-19:00"
                                    date-range="{&quot;1&quot;:1,&quot;35&quot;:2,&quot;30&quot;:1}">可选
                                </li>
                            </ul>
                            <ul>
                                <li class="checkbox" data-status="1" row="0" col="3" val="4-30 (周四) 09:00-15:00"
                                    day="2015-4-30" range="09:00-15:00"
                                    date-range="{&quot;1&quot;:1,&quot;35&quot;:1,&quot;30&quot;:1}">可选
                                </li>
                                <li class="checkbox last" data-status="1" row="1" col="3" val="4-30 (周四) 15:00-19:00"
                                    day="2015-4-30" range="15:00-19:00"
                                    date-range="{&quot;1&quot;:1,&quot;35&quot;:2,&quot;30&quot;:1}">可选
                                </li>
                            </ul>
                            <ul>
                                <li class="checkbox" data-status="1" row="0" col="4" val="5-1 (周五) 09:00-15:00"
                                    day="2015-5-1" range="09:00-15:00"
                                    date-range="{&quot;1&quot;:1,&quot;35&quot;:1,&quot;30&quot;:1}">可选
                                </li>
                                <li class="checkbox last" data-status="1" row="1" col="4" val="5-1 (周五) 15:00-19:00"
                                    day="2015-5-1" range="15:00-19:00"
                                    date-range="{&quot;1&quot;:1,&quot;35&quot;:2,&quot;30&quot;:1}">可选
                                </li>
                            </ul>
                            <ul>
                                <li class="checkbox" data-status="1" row="0" col="5" val="5-2 (周六) 09:00-15:00"
                                    day="2015-5-2" range="09:00-15:00"
                                    date-range="{&quot;1&quot;:1,&quot;35&quot;:1,&quot;30&quot;:1}">可选
                                </li>
                                <li class="checkbox last" data-status="1" row="1" col="5" val="5-2 (周六) 15:00-19:00"
                                    day="2015-5-2" range="15:00-19:00"
                                    date-range="{&quot;1&quot;:1,&quot;35&quot;:2,&quot;30&quot;:1}">可选
                                </li>
                            </ul>
                            <ul>
                                <li class="checkbox" data-status="1" row="0" col="6" val="5-3 (周日) 09:00-15:00"
                                    day="2015-5-3" range="09:00-15:00"
                                    date-range="{&quot;1&quot;:1,&quot;35&quot;:1,&quot;30&quot;:1}">可选
                                </li>
                                <li class="checkbox last" data-status="1" row="1" col="6" val="5-3 (周日) 15:00-19:00"
                                    day="2015-5-3" range="15:00-19:00"
                                    date-range="{&quot;1&quot;:1,&quot;35&quot;:2,&quot;30&quot;:1}">可选
                                </li>
                            </ul>
                            <ul class="last">
                                <li class="checkbox" data-status="1" row="0" col="7" val="5-4 (周一) 09:00-15:00"
                                    day="2015-5-4" range="09:00-15:00"
                                    date-range="{&quot;1&quot;:1,&quot;35&quot;:1,&quot;30&quot;:1}">可选
                                </li>
                                <li class="checkbox last" data-status="1" row="1" col="7" val="5-4 (周一) 15:00-19:00"
                                    day="2015-5-4" range="15:00-19:00"
                                    date-range="{&quot;1&quot;:1,&quot;35&quot;:2,&quot;30&quot;:1}">可选
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="ftx-03 mt20">
                    温馨提示：我们会努力按照您指定的时间配送，但因天气、交通等各类因素影响，您的订单有可能会有延误现象！
                </div>
                <div class="op-btns mt10 ac"><a id="timeSave311" href="javascript:void(0);" class="btn-9"> 保存 </a> <a
                        href="javascript:void(0)" class="btn-9 ml10"> 取消 </a></div>
            </div>
            <div class="tab-con hide" id="tab_411_div">
                <div> 下单后或支付成功后3小时送达，运费 <span class="ftx-01"> 49 </span> 元</div>
                <div class="ftx-03 mt20" id="message_show_411">
                    温馨提示：我们会努力按照您指定的时间配送，但因天气、交通等各类因素影响，您的订单有可能会有延误现象！
                </div>
                <div class="op-btns mt10 ac"><a id="timeSave411" class="btn-9"> 保存 </a> <a href="javascript:void(0);"
                                                                                           class="btn-9 ml10"> 取消 </a>
                </div>
            </div>
        </div>
    </div>
    <!--jd-dialog-con-->
</div>
<!--jd-dialog-->

<#--<div class="jd-dialog dia3 time_dia">
    <div class="jd-dialog-title">大件商品配送时间<a href="#" class="jd-dialog-close" onclick="cls()">×</a></div>
    <div class="jd-dialog-con clearfix p10">
        <div class="date-box">
            <div class="date-list">
            <ul>
                <li class="li_shipment selected" shipdate_offset="1" shipdate_date="4月28日" shipdate_weekday="周二" onclick="doSwithBigShip('0',this)">
                    4月28日
                    <span class="data">周二</span>
                </li>
                <li class="li_shipment" shipdate_offset="2" shipdate_date="4月29日" shipdate_weekday="周三" onclick="doSwithBigShip('0',this)">
                    4月29日
                    <span class="data">周三</span>
                </li>
                <li class="li_shipment" shipdate_offset="3" shipdate_date="4月30日" shipdate_weekday="周四" onclick="doSwithBigShip('0',this)">
                    4月30日
                    <span class="data">周四</span>
                </li>
                <li class="li_shipment" shipdate_offset="4" shipdate_date="5月1日" shipdate_weekday="周五" onclick="doSwithBigShip('0',this)">
                    5月1日
                    <span class="data">周五</span>
                </li>
                <li class="li_shipment" shipdate_offset="5" shipdate_date="5月2日" shipdate_weekday="周六" onclick="doSwithBigShip('0',this)">
                    5月2日
                    <span class="data">周六</span>
                </li>
                <li class="li_shipment" shipdate_offset="6" shipdate_date="5月3日" shipdate_weekday="周日" onclick="doSwithBigShip('0',this)">
                    5月3日
                    <span class="data">周日</span>
                </li>
                <li class="li_shipment" shipdate_offset="7" shipdate_date="5月4日" shipdate_weekday="周一" onclick="doSwithBigShip('0',this)">
                    5月4日
                    <span class="data">周一</span>
                </li>
                <li class="li_shipment" shipdate_offset="8" shipdate_date="5月5日" shipdate_weekday="周二" onclick="doSwithBigShip('0',this)">
                    5月5日
                    <span class="data">周二</span>
                </li>
                <li class="li_shipment" shipdate_offset="9" shipdate_date="5月6日" shipdate_weekday="周三" onclick="doSwithBigShip('0',this)">
                    5月6日
                    <span class="data">周三</span>
                </li>
                <li class="li_shipment" shipdate_offset="10" shipdate_date="5月7日" shipdate_weekday="周四" onclick="doSwithBigShip('0',this)">
                    5月7日
                    <span class="data">周四</span>
                </li>
            </ul>
        </div>
            <div class="ftx-03 mt10">
                温馨提示：<br>
                1、您选择的时间可能会因库存不足等因素导致订单延迟，请您谅解！<br>
                2、我们会在您选定提货日期的前一天处理您的订单，在此之前您的订单处于暂停状态。

            </div>
            <div class="op-btns mt20 ac">
                <a href="#none" onclick="doSaveBigShipDate('0')" class="btn-9">保存</a>
                <a href="javascript:jQuery.closeDialog();" class="btn-9 ml10">取消</a>
            </div>
        </div>
    </div>--jd-dialog-con
</div>jd-dialog-->
<div class="jd-dialog dia4 ticket_dia">
    <div class="jd-dialog-title">发票信息<a href="javascript:void(0)" class="jd-dialog-close" onclick="cls()">×</a></div>
    <div class="jd-dialog-con clearfix p10">
        <div class="invoice-thickbox" id="invoice-tab">
            <div class="tab-nav clearfix">
                <ul class="clearfix">
                    <li id="click_1" class="tab-nav-item invoiceType  tab-item-selected" name="invoiceType" value="0">
                        不需要发票<b></b></li>
                    <li id="click_2" class="tab-nav-item " value="1" name="invoiceType">普通发票<b></b></li>
                <#--	<li id="click_2" class="tab-nav-item  disabled" value="3" title="您的订单中部分商品不支持此发票类型">电子发票<b></b></li>
                    <li id="click_3" class="tab-nav-item  disabled" value="2" title="您的订单中部分商品不支持此发票类型">增值税发票<b></b></li>
                -->
                </ul>
            </div>
            <div id="fapiao" class="form" style="display:none">
                <div class="item">
                    <span class="label">发票抬头：</span>

                    <div class="fl">
                        <div class="invoice-list invoice-tit-list" id="invoice-tit-list">
                            <div class="invoice-item invoice-item-selected has self" style="cursor:pointer">
                                <input type="hidden" id="commonInvoiceSize">

                                <div id="invoice-1" style="cursor:pointer">
                                    <span class="hide"><input type="hidden" value="4"></span>
                                    <input type="hidden" class="invoice_title" value="个人" ><#--没有用-->
                                    <span class="fore2" id="" name="usualInvoiceList" value="1100">
										<input type="text" style="cursor:pointer" class="itxt " id="caption_personinput" data-r="个人" value=""  placeholder="请输入个人发票抬头"><b></b>
										</span>
                                </div>
                                <div id="caption_person" style="width:58px;line-height:18px;position:absolute;left:3px;top:50%;margin-top:-7px;">个人：</div>
                            </div>

                        <#--<div id="save-invoice" class="invoice-item hide new_add">
                            <div class="add-invoice-tit">
                                <input type="text" name="invoiceTitle" class="itxt itxt04 invoice_title"
                                       placeholder="新增单位发票抬头" autocomplete="off" maxlength="30">

                                <div class="btns">
                                    <a href="javascript:void(0)" class="ftx-05 update-tit hide">编辑</a>
                                    <a href="javascript:void(0)" class="ftx-05 save-tit">保存</a>&nbsp;
                                &lt;#&ndash;<a href="#none" class="ftx-05 delete-tit hide">删除</a>&ndash;&gt;
                                </div>
                            </div>
                        </div>-->
                            <input type="hidden" name="chInvoiceTitle" class="ch_invoceTitleValue" value=""/>
                        </div>
                        <div id="add-invoice" class="add-invoice"><a href="javascript:void(0)"
                                                                     class="ftx-05 add-invoice-btn"
                                                                     onclick="add_save()">新增单位发票</a></div>

                    </div>
                </div>
            </div>
            <#--添加的纳税人识别号 2017.8.4-->
            <div class="persondl clearfix hide">
                <div class="dt" style="width:120px;line-height:24px;text-align:right;float:left;margin:5px 0;" ><em style="color:red;font-style:normal;">* </em>纳税人识别号：</div>
                <div class="dd" style="position:relative;float:left;width:342px;height:18px;padding:5px 10px 5px 13px;border:1px solid #ebebeb;margin:5px 0;">
                    <input type="text" id="taxpayer_id" name="taxpayerNumber" style="outline-style:none;border-width:0;line-height:15px;width:320px;" placeholder="纳税人识别号">
                    <span id="warpTaxpayerNumber_id" style="color:red;position:absolute;bottom: -20px;left:0;display:none;">您尚未填写纳税人识别号</span>
                </div>
            </div>
            <div class="tab-box">
                <div class="tab-con ui-switchable-panel-selected">
                    <div class="form">
                        <div class="item invoice_con" style="display:none">
                            <span class="label">发票内容：</span>

                            <div class="fl">
                                <div class="invoice-list">
                                    <ul id="electro_book_content_radio">
                                        <li class="invoice-item invoice-item-selected b" id="electro-invoice-content-1"
                                            name="invoiceContent" value="1" style="cursor:pointer">
                                            明细
                                        </li>
                                        <#--<li class="invoice-item" id="electro-invoice-content-2" name="invoiceContent"
                                            value="2" style="cursor:pointer">
                                            办公用品

                                        </li>
                                        <li class="invoice-item" id="electro-invoice-content-3" name="invoiceContent"
                                            value="3" style="cursor:pointer">

                                        </li>
                                        <li class="invoice-item" id="electro-invoice-content-19" name="invoiceContent"
                                            value="19" style="cursor:pointer">

                                        </li>-->
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="item">

                            <div class="fl">
                                <div class="invoice-list">
                                    <ul>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="item">
                            <span class="label">&nbsp;</span>

                            <div class="fl mt30">
                                <div class="op-btns">
                                    <a href="javascript:void(0)" class="btn-9 save_invoice">保存发票信息</a>
                                    <a href="javascript:void(0)" class="btn-9 ml10" onclick="quxiao()">取消</a>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>
    </div>
    <!--jd-dialog-con-->
</div>
<!--jd-dialog-->
<div class="jd-dialog ok-pay dia5">
    <div class="jd-dialog-title">请确认支付方式<a href="javascript:void(0)" class="jd-dialog-close" onclick="cls()">×</a></div>
    <div class="jd-dialog-con p10">
        <div class="payment-dialog">
            <div class="dialog-item dialog-item-activate">
                <div class="dialog-item-tit">以下商品<strong class="ftx-02">支持货到付款</strong></div>
                <div class="dialog-item-inner">
                    <div class="dialog-item-list">
                        <div class="dialog-goods">
                            <ul>
                                <li>
                                    <div class="p-img">
                                        <img src="http://img10.360buyimg.com/n4/jfs/t1054/115/424728135/429902/93b957f5/55225adfN7f79107d.jpg"
                                             title="静哲2015春夏季韩版学院风休闲可爱牛仔连衣裙女j8877 图片色 M"
                                             alt="静哲2015春夏季韩版学院风休闲可爱牛仔连衣裙女j8877 图片色 M">
                                    </div>
                                </li>
                                <li>
                                    <div class="p-img">
                                        <img src="http://img10.360buyimg.com/n4/jfs/t568/356/554503580/57036/5d2a2e84/5472e503Nd065333b.jpg"
                                             title="水之密语（AQUAIR） 凝润水护 洗发露 600ml（资生堂授权正品）"
                                             alt="水之密语（AQUAIR） 凝润水护 洗发露 600ml（资生堂授权正品）">
                                    </div>
                                </li>
                                <li>
                                    <div class="p-img">
                                        <img src="http://img10.360buyimg.com/n4/jfs/t724/29/1288837885/130475/5d3694d1/552e3dabNae909bdc.jpg"
                                             title="创维酷开（coocaa）A43 43英寸 智能酷开系统高清平板液晶电视(银色)"
                                             alt="创维酷开（coocaa）A43 43英寸 智能酷开系统高清平板液晶电视(银色)">
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="dialog-item dialog-item-deactivate">
                <div class="dialog-item-tit">以下商品<strong class="ftx-01">不支持货到付款，将使用在线支付</strong></div>
                <div class="dialog-item-inner">
                    <div class="dialog-item-list">
                        <div class="dialog-goods">
                            <ul>
                                <li>
                                    <div class="p-img">
                                        <img src="http://img10.360buyimg.com/n4/jfs/t1177/164/677013689/83117/2004a8e9/55385071N01ce83bc.jpg"
                                             title="康夫（Kangfu）KF8894 专业电吹风机冷热风大功率2200W吹风筒理发店专用"
                                             alt="康夫（Kangfu）KF8894 专业电吹风机冷热风大功率2200W吹风筒理发店专用">
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="op-btns ac">
                <a href="javascript:save_Pay(1);closeDialog();" class="btn-9">确定</a>
                <a href="javascript:closeDialog();" class="btn-9 ml10">取消</a>
            </div>
        </div>

    </div>
    <!--jd-dialog-con-->
</div>
<!--jd-dialog-->

<div class="jd-dialog tip_dia dia6 new_jd-dialog">
    <input type="hidden" id="addressflag">
    <div class="dia_tit clearfix">
        <h4 class="fl"></h4>
        <a class="dia_close fr" href="javascript:void(0)" onclick="cls()"></a>
    </div>
    <!--/dia_tit-->
    <div class="dia_tip">
        <img src="${basePath}/images/btn_tips@2x.png" alt="" style="width: 45px;height: 45px;margin: 0 auto; margin-top:13px;display: block;">
        <div class="dia_intro ">
            <span id="con_00" class="new_span">修改成功！</span>
        </div>
        <div class="dia_ops tc" style="margin-top: 40px;">
            <a class="go_pay bnt_ok" id="go_pay_00" href="javascript:cls();" style='margin:auto'>确定</a>
        </div>
        <!--/dia_ops-->
    </div>
    <!--/dia_cont-->
</div>

<div class="jd-dialog tip_dia dia10 new_jd-dialog">
    <input type="hidden" id="addressflag">
    <div class="dia_tit clearfix">
        <h4 class="fl"></h4>
        <a class="dia_close fr" href="javascript:void(0)" onclick="closeAddresswindow()"></a>
    </div>
    <!--/dia_tit-->
    <div class="dia_tip">
        <img src="${basePath}/images/btn_tips@2x.png" alt="" style="width: 45px;height: 45px;margin: 0 auto; margin-top:13px;display: block;">
        <div class="dia_intro">
            <span id="con_flag" class="new_span">修改成功！</span>
        </div>
        <div class="dia_ops  tc" style="margin-top: 40px;">
            <a class="go_pay bnt_ok"  onclick="closeAddresswindow()" style='margin:auto'>确定</a>
        </div>
        <!--/dia_ops-->
    </div>
    <!--/dia_cont-->
</div>
<!--/dialog-->
<div class="jd-dialog tip_dia dia7 new_jd-dialog">
    <div class="dia_tit clearfix">
        <input type="hidden" id="deladdress"/>
        <h4 class="fl"></h4>
        <a class="dia_close fr" href="javascript:void(0)" onclick="cls()"></a>
    </div>
    <!--/dia_tit-->
    <div class="dia_tip">
        <img src="${basePath}/images/btn_waringcopy@2x.png" alt="" style="width: 45px;height: 45px;margin: 0 auto; margin-top:13px;display: block;">
        <div class="dia_intro">
            <span id="con_01" class="new_span">确定删除？</span>
        </div>
        <div class="dia_ops tc" style="margin-top: 40px;">
            <a class="go_pay" href="javascript:cls();">取消</a>
            <a class="go_pay bnt_ok" id="go_pay_01" onclick="delAddress()" href="javascript:cls();">确定</a>
        </div>
        <!--/dia_ops-->
    </div>
    <!--/dia_cont-->
</div>

<div class="jd-dialog tip_dia dia9 new_jd-dialog">
    <div class="dia_tit clearfix">
        <input type="hidden" id="diffaddress"/>
        <h4 class="fl"></h4>
        <a class="dia_close fr" href="javascript:void(0)" onclick="cls()"></a>
    </div>
    <!--/dia_tit-->
    <div class="dia_tip">
        <img src="${basePath}/images/btn_tips@2x.png" alt="" style="width: 45px;height: 45px;margin: 0 auto; margin-top:13px;display: block;">
        <div class="dia_intro " style="padding-left: 23px;">
            <span id="con_01" class="new_span">您当前选择的收货地址无库存，请重新选择后提交订单！</span>
        </div>
        <div class="dia_ops tc" style="margin-top: 40px;">
            <a class="go_pay" href="${basePath}/myshoppingcart.html">调整购物车</a>
            <a class="go_pay bnt_ok" href="javascript:cls();">修改收货地址</a>
        </div>
        <!--/dia_ops-->
    </div>
    <!--/dia_cont-->
</div>
<div class="jd-dialog tip_dia dia17 new_jd-dialog">
    <input type="hidden" id="addressflag">
    <div class="dia_tit clearfix">
        <h4 class="fl"></h4>
        <a class="dia_close fr" href="javascript:void(0)" onclick="cls()"></a>
    </div>
    <!--/dia_tit-->
    <div class="dia_tip">
        <img src="${basePath}/images/btn_tips@2x.png" alt="" style="width: 45px;height: 45px;margin: 0 auto; margin-top:13px;display: block;">
        <div class="dia_intro ">
            <span id="con_00" class="new_span">收货地址上限:10个！</span>
        </div>
        <div class="dia_ops tc" style="margin-top: 40px;">
            <a class="go_pay bnt_ok" id="go_pay_00" href="javascript:cls();" style='margin:auto'>确定</a>
        </div>
        <!--/dia_ops-->
    </div>
    <!--/dia_cont-->
</div>

<!--jd-dialog-->
<#--<div class="foot" style="height:300px;background:#ddd;"></div>-->
<#--shf-->
<#--<div class="footer_tab">-->
    <#--<ul>-->

        <#--<li class="list1"><a href="http://www.ge960.com/channel/237.html">食品荟萃</a></li>-->
        <#--<li class="list2"><a href="http://www.ge960.com/channel/239.html">饮品总汇</a></li>-->
        <#--<li class="list3"><a href="http://www.ge960.com/channel/241.html">购物中心</a></li>-->
        <#--<li class="list4"><a href="http://www.ge960.com/channel/243.html">大药房</a></li>-->

    <#--</ul>-->
<#--</div>-->
<#if (topmap.temp)??>
    <#if (topmap.temp.tempId==1)>
        <#include "../index/bottom.ftl">
    <#else>
        <#include "../index/newbottom.ftl" />
    </#if>
</#if>

<script type="text/javascript" src="${basePath}/js/dialog-min.js"></script>
<script type="text/javascript" src="${basePath}/js/order/loadAddress.js"></script>
<script type="text/javascript" src="${basePath}/js/order/newSuborder.js"></script>
<script type="text/javascript" src="${basePath}/js/jsOperation.js"></script>
<script type="text/javascript" src="${basePath}/index_two/js/index.js"></script>
<script type="text/javascript" src="${basePath}/js/default.js"></script>

<script type="text/javascript">
    $(function () {
        $(".new_div_header:first").find("img").addClass("HelpNow");
        $(".header_nv:last").find(".header_nv_a").addClass("HelpNow1");
    })
    $(function () {
        loadProvice();
        if ($("#cpLength").val() > 0) {
            $(".cpl").html("(" + $("#cpLength").val() + ")");
        }
        //是否需要发票
        $("li[name=invoiceType]").click(function () {
            if ($(this).val() == 0) {
                $(".invoice_con").hide();
                $("#fapiao").hide();
            } else {
                $(".invoice_con").show();
                $("#fapiao").show();
            }
        });



        $(".qmark-tip").mouseover(function () {
            var a = $(this).parents("li").width();
            a = a - parseInt($(this).css("right"));
            var x = a;
            var y = $(this).css("top");
            x = parseInt(x) - 35;
            y = parseInt(y) + 21;
            var dd = $(this).attr("data-tips");
            $(this).after(
                    "<div class='online_tips'><div class='pr sanjiao'><span><img src='${basePath}/images/sanjiao.png'/></span>" + dd + "</div></div>"
            );
            $(".online_tips").css("left", x);
            $(".online_tips").css("top", y);
        });


        $('.part_open').click(function () {

            if ($(this).attr('class').indexOf('close') < 0) {
                $(this).addClass('part_close');
                $(this).next().show();
            }
            else {
                $(this).removeClass('part_close');
                $(this).next().hide();
            }
        });

//        $('.open_link').click(function () {
//            $(this).next().toggle();
//        });



        //商品详情导航条
        if ($(".checkout-buttons").length > 0) {
            var a = $(".coupon_cont").height() + $(".money_card_cont").height();
            var b = 700;
            var _y = $("#checkout-floatbar").offset().top;

            function onScroll(e) {
                if ($(document.body).scrollTop() + b >= _y || $(document.documentElement).scrollTop() + b >= _y || window.scrollY + b >= _y) {
                    $(".checkout-buttons").removeClass("ui-ceilinglamp-current");
                } else {
                    $(".checkout-buttons").addClass("ui-ceilinglamp-current");
                }
                ;
            };
            $(window).scroll(function () {
                onScroll();
            });
        }

        $(".bossitem ,.mode-tab-item ").mouseleave(function () {
            $(".online_tips").remove();
        });
        //第三方
        $(".thirditem ,.mode-tab-item ").mouseleave(function () {
            $(".online_tips").remove();
        });

        //$('#fapiao').hide();
        $('#fff').focus();
        $('.invoice-list .invoice-item').bind('click', function () {
            $(this).addClass('invoice-item-selected').siblings().removeClass('invoice-item-selected');
        });
        $(".invoice-thickbox .tab-nav-item").bind('click', function () {
            $(this).addClass('tab-item-selected').siblings().removeClass('tab-item-selected');
        });



    });

</script>
<script type="text/javascript">

    function openLink(obj){
        if($(obj).next().css("display")=="none"){
            $(obj).next().css("display","block");
            $(".add_coupon_warn").show();
            $(".coupon_total").hide();
            inputChange();
        }else{
            $(obj).next().css("display","none");
            $(".add_coupon_warn").html("");
        }
    }

    //确定选择的
    function doSaveDialogPickSite(){
        $("#deliveryPointId").val($(".site-item-selected").attr('pickid'));
        $("#selfpick_name").html($(".site-item-selected").attr('pickname'));
        cls();
    }
    //选择自提点
    function doSelectPicksite(thisElement){
        if($(thisElement).hasClass("site-item-disabled")){
            return;
        }
        $(".site-item").removeClass("site-item-selected");
        $(thisElement).addClass("site-item-selected");
        $("#deliveryPointId").val($(thisElement).attr('pickid'));

    }
    function win() {
        var _wd = $(window).width();
        var _hd = $(window).height();
        $(".z-dialog").css("top", (_hd - $(".z-dialog").height()) / 2).css("left", (_wd - $(".z-dialog").width()) / 2);
        $(".ok-pay").css("top", (_hd - $(".ok-pay").height()) / 2).css("left", (_wd - $(".ok-pay").width()) / 2);
        $(".ticket_dia").css("top", (_hd - $(".ticket_dia").height()) / 2).css("left", (_wd - $(".ticket_dia").width()) / 2);
        $(".time_dia").css("top", (_hd - $(".time_dia").height()) / 2).css("left", (_wd - $(".time_dia").width()) / 2);
        $(".address_dia").css("top", (_hd - $(".address_dia").height()) / 2).css("left", (_wd - $(".address_dia").width()) / 2);
        $(".tip_dia").css("top", (_hd - $(".tip_dia").height()) / 2).css("left", (_wd - $(".tip_dia").width()) / 2);
    }
    ;

    function dia(n) {
        win();
        $(".mask").fadeIn();
        $(".dia" + n).fadeIn();
    }
    ;

    function cls() {
        $(".dialog").fadeOut();
        $(".jd-dialog").fadeOut();
        $(".mask").fadeOut();
        $(".checkout-submit").removeClass('loading').html("提交订单");
    }
    ;
//    点击不需要发票
    $('#click_1').click(function(){
        $('.persondl').addClass('hide');
    })
//    点击需要发票
    $('#click_2').click(function(){
        $('.dwfp').each(function(){
            if($(this).hasClass('invoice-item-selected')){
                $('.persondl').removeClass('hide');
            }
        })
    })
    document.getElementById('taxpayer_id').oninput=document.getElementById('taxpayer_id').onpropertychange=function(){
        if(!!this.value){
            $('#warpTaxpayerNumber_id').hide();
        }
    }
    $('#taxpayer_id').blur(function(){
        if(!this.value){
            $('#warpTaxpayerNumber_id').show();
        }
    })
    function add_save() {
        //添加单位发票按钮隐藏
        $(".add-invoice-btn").hide();
        //取消所有框为未选中
        $('.invoice-tit-list .invoice-item').each(function(index,item){
            $(item).removeClass('invoice-item-selected');
        })
        $('.persondl').removeClass('hide');
        var str='<div id="save-invoice" class="invoice-item  invoice-item-selected new_add dwfp">'
                +'<div class="add-invoice-tit">'
                +'<input type="text" name="invoiceTitle" class="itxt itxt04 invoice_title" placeholder="新增单位发票抬头" autocomplete="off" maxlength="30">'
                +'<div class="btns">'
                +'<input type="hidden" name="update-tit">'
                +'<a href="javascript:void(0);" class="ftx-05 update-tit hide">编辑</a>&nbsp;'
                +'<a href="javascript:void(0);" class="ftx-05 save-tit">保存</a>&nbsp;'
                +'<a href="javascript:void(0)" class="ftx-05 delete-tit hide">删除</a>'
                +'</div>'
                +'<b></b>'
                +'</div>'
                +'<div id="caption_monad" style="width:58px;line-height:18px;position:absolute;left:3px;top:50%;margin-top:-8px;">单位：</div>'
                +'</div>';

        $('.invoice-tit-list').append(str);
        //加载切换点击事件
        $('.invoice-list .invoice-item').click('mouseup', function () {
            var that = $(this);
            $(this).addClass('invoice-item-selected').siblings().removeClass('invoice-item-selected');
            //遍历自己之外的兄弟 如果为空就删除
            $.each(that.siblings(".invoice-item"),function(index,item){
                var _this = $(this);
                if(_this.find('.invoice_title')&&!_this.hasClass('dwfp_update')){
                    if(_this.find('.invoice_title').val()==''||!_this.hasClass('has')){
                        document.getElementsByClassName("invoice-tit-list")[0].removeChild(item);
                        $(".add-invoice-btn").show();
                    }
                }
            })
            if($('.dwfp').length<=0||$('.self').hasClass('invoice-item-selected')){
                $('.persondl').addClass('hide');
            }else{
                $('.persondl').removeClass('hide');
            }
        });
        //删除单位名称
        $('.delete-tit').click(function(event){
            var event = event || window.event;
            if(event.stopPropagetion){
                event.stopPropagation();
            }else{
                event.cancelable=true;
            }
            if($(this).parents('.dwfp').hasClass('invoice-item-selected')){
                if($(this).parents('.dwfp').prev().attr("class")=="ch_invoceTitleValue"){
                    //个人发票选中
                    $('.self').addClass('invoice-item-selected');
                }else{
                    //自己的上一个兄弟选中
                    $(this).parents('.dwfp').prev().addClass("invoice-item-selected");
                }
            }
            $('.invoice-tit-list').get(0).removeChild($(this).parents('.dwfp').get(0));
            if($('.dwfp').length<=0||$('.self').hasClass('invoice-item-selected')){
                $('.persondl').addClass('hide');
            }
        })
        //保存单位名称
        $('.save-tit').click(function(event){
            var event = event || window.event;
            if(event.stopPropagation){
                event.stopPropagation();
            }else{
                event.cancelBubble=true;
            }
            var $invoice_title = $(this).parents('.dwfp').find('.invoice_title');
            if($invoice_title.val()==""){
                $invoice_title.attr("placeholder","不能为空");
                return;
            } else {
                var reg= /^([\u4e00-\u9fa5_A-Za-z0-9 \\`\\~\\!\\@\\#\\$\\^\\&\*\(\)\=\{\}\'\:\;\'\,[\]\.\/\?\~\！\@\#\￥\…\…\&\*\（\）\;\—\|\{\}\【\】\‘\；\：\”\“\'\。\，\、\？])+$/;
                if(!reg.test($invoice_title.val())){
                    $invoice_title.val("");
                    $invoice_title.attr("placeholder","不能输入特殊字符！");
                    return;
                }
            }
            $(this).parents('.dwfp').addClass("has");
            $(this).parents('.dwfp').removeClass('dwfp_update');
            $(".add-invoice-btn").show();
            $(this).addClass("hide");
            $(this).parent().parent().append("<b></b>");
            $(this).parents(".add-invoice-tit").find("input[name='invoiceTitle']").attr("readonly","readonly");
            $(".dwfp").on("mouseover",function(){
                $(this).find(".update-tit").removeClass("hide");
                $(this).find(".delete-tit").removeClass("hide");
            });
            $(".dwfp").on("mouseout",function(){
                $(this).find(".update-tit").addClass("hide");
                $(this).find(".delete-tit").addClass("hide");
            });
        })
        //修改单位名称
        $(".update-tit").click(function(event){
            //防止冒泡
            var event = event || window.event;
            if(event.stopPropagation){
                event.stopPropagation();
            }else{
                event.cancelBubble=true;
            }
            //把修改前的内容保存起来
            $(this).prev().val($(this).parents(".add-invoice-tit").find("input[name='invoiceTitle']").val());
            $(this).parents(".add-invoice-tit").find("input[name='invoiceTitle']").get(0).focus();
            $(this).parents('.dwfp').addClass("dwfp_update");
            $(this).addClass("hide");
            $(this).next().removeClass("hide");
            $(this).parents(".add-invoice-tit").find("input[name='invoiceTitle']").removeAttr("readonly");
            $(".dwfp").on("mouseover",function(){
                $(this).find('.update-tit').addClass("hide");
                $(this).find(".delete-tit").removeClass("hide");
            });
            $(".dwfp").on("mouseout",function(){
                $(this).find('.update-tit').addClass("hide");
                $(this).find('.delete-tit').addClass("hide");
            });
            $(this).parents('.dwfp').find("input[name='invoiceTitle']").blur(function(){
                if(!!$(this).parents('.dwfp').hasClass('dwfp_update')){
                    var val = $(this).val();
                    if(!val){
                        val = $(this).val($(this).parents('.dwfp').find('input[name=update-tit]').val());
                    }
                    //触发保存事件
                    $('.save-tit').trigger('click');
                }
            })
        });


    }

    $(".alink").click(function () {
        if ($(this).parent().next().is(':hidden')) {
            $(this).parent().next().show();
            $(".close").click(function () {
                $(this).parents(".tooltip-goods").parent().hide();
            })
        }
        else {
            $(this).parent().next().hide();
        }
    });

    $(".clean-email").click(function(){
        $(".input-email").val("");
    });


    function couponChange(obj, num) {
        if(num==0){
            $("#inputCoupon").show();
            $(".add_coupon_warn").show();
            $(".coupon_total").hide();
            inputChange();
        }else{
            $("#inputCoupon").hide();
            $(".add_coupon_warn").hide();
            $(".coupon_total").show();
        }
        var discountPrice = $("#discount").val()    //会员折扣价
        var amount = $('#amount').val();                //需要兑换的积分
        var pointSet = $('#pointSet').val();          //积分兑换规则
        var zhekou = amount * pointSet / 10;                //积分兑换的折扣价格
        $("#yh").html("-¥" + num.toFixed(2));
        $("#youhui").val(num);
        var sumPrice = $("#sumPrice").val();
        var sum = Subtr(Subtr(sumPrice, num),discountPrice);
        var lastpay = Number(sum).toFixed(2);

        //判断是否有积分兑换 如果有，总价格减去积分兑换的金额
        if (zhekou != 0) {
            lastpay = lastpay - zhekou;
            lastpay = lastpay.toFixed(2);
        }
        //设置商品金额减去的积分兑换的金额 与总积分数
        $('#jf').html("-¥"+zhekou);
        $('#muqianjifen').html($('#jifen1').val());
        //订单总金额
        $("#lastpay").html("¥" +lastpay);
        $("#lastpays").html("¥" + lastpay);
        if (num == 0) {
            $(".us").html('0');
        } else {
            $(".us").html('1');
        }
        $(".up").html(num.toFixed(2));
        $("#codeNo").val($(obj).val());
        //金额小于1  设置总订单的价格为1分钱
        if (lastpay < 0.02) {
            $("#lastpay").html("¥" +0.01);
            $("#lastpays").html("¥" + 0.01);
        }
    }

    var issubmit = 0;
    function submitForm(obj){
        if ($(".checkout-submit").hasClass("loading")) return;
        if( myBrowser() == "Safari"){
            $(".checkout-submit").html("正在提交...");
        }else {
            $(".checkout-submit").addClass('loading').html("");
        }
        var dianziCardNum = $("#dianziCard").val();
        if(dianziCardNum > 0){
            var inputEmail = $(".input-email").val();
            if(inputEmail == "" || $.trim(inputEmail) == ""){
                $(".input-email").focus();
                $(".no_tc").css("padding-left","60px");
                $("#con_00").html("请输入电子邮箱地址！");
                dia(6);
                return null;
            }else{
                var reg = /\w+[@]{1}\w+[.]\w+/;
                if(!reg.test(inputEmail)){
                    $(".no_tc").css("padding-left","35px");
                    $("#con_00").html("电子邮箱地址有误，请重新输入！");
                    dia(6);
                    return null;
                }
            }
        }

        var regexp = new RegExp("[''\\[\\]<>?\\\\!]");
        if ($("#message_left").val().length > 45) {
            $("#con_00").html("客户留言长度限45个字符！");
            dia(6);
            return null;
        }
        if (regexp.test($("#message_left").val())) {
            $("#con_00").html("客户留言存在特殊字符！");
            dia(6);
            return null;
        }
        if($(".curr").hasClass("fretype")){
            if($("#deliveryPointId").val()==0){
                if ($(this).attr("id") == 'ziti') {
                    $("#typeId").val('');
                    $("#con_00").html("自提点不能为空!");
                    dia(6);
                    return null;
                }

            }
        }
        if($(".ch_pay").val() == ""){
            $("#con_00").html("请联系商城配置支付方式！");
            dia(6);
            return null;
        }
        //收货地址所在仓库无货
        var flag = true;
        $(".shopping-list .goods-list .goods-item .p-price span").each(function () {
            var diffAddress = $(this).text();
            if(diffAddress == "无货" || !stockFlag){
                dia(9);
                flag = false;
                return false;
            }
        });
        if(!flag){
            return null;
        }

        var totalCount = $("#totalCount").val();
        if(dianziCardNum != totalCount){
            if(!$(".consignee-item").hasClass("item-selected")){
                $(".no_tc").css("padding-left","65px");
                $("#con_00").html("请选择收货人信息！");
                dia(6);
                return null;
            }
        }

        var thirdIds=document.getElementsByName("thirdIds");
        issubmit = 1;
        var amount = $('#amount').val();                //需要兑换的积分
        var sum = $('#lastpay').html();                 //订单总价格
        var pointSet = $('#pointSet').val();            //积分兑换规则
        //判断积分是否超额
        if (jifen() == false) {
            return;
        }
        $(obj).attr("disabled", "disabled");

        //$("#sub_order").submit();
        $.ajax({
            url:"${basePath}/beforeSuborder.htm",
            type:"post",
            success:function(data){
                $("#sub_order").submit();
                if(myBrowser() == "Safari"){
                    $(".checkout-submit").removeClass('loading').html("提交订单");
                }
            }
        });
    }
    function myBrowser(){
        var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
        var isOpera = userAgent.indexOf("Opera") > -1;
        if (isOpera) {
            return "Opera"
        }; //判断是否Opera浏览器
        if (userAgent.indexOf("Firefox") > -1) {
            return  "FF";
        } //判断是否Firefox浏览器
        if (userAgent.indexOf("Chrome") > -1){
            return  "Chrome";
        }
        if (userAgent.indexOf("Safari") > -1) {
            return  "Safari";
        } //判断是否Safari浏览器
        if (userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera) {
            return  "IE";
        }; //判断是否IE浏览器
    }
</script>
<script>
    $(function(){
        $(".xiaoshi").mouseover(function(){
            var lingshouCount = $("#lingshouCount").val();
            var totalCount = $("#totalCount").val();
            //订单中商品数量与零售数量一样（都是零售），则只显示社区店地址；否则（都是批发/批发+零售），只显示自选地址；
            if(lingshouCount>0&&lingshouCount==totalCount){
                $(".xianshi").html("您购买的商品是零售类，不产生任何运费，请抓紧下单吧！");
            }else{
                $(".xianshi").html("您购买的商品是批发类，运费组成将综合订单金额、商品重量收取基础费用和续重费用，详情可参考<a target='_blank' href='http://www.ge960.com/help/141' style='color: blue;'>运费计算说明。</a>");
            }
            $(".xianshi").show();
        }).mouseout(function(){
            $(".xianshi").hide();
        });
        $(".xianshi").mouseover(function(){
            $(".xianshi").show();
        }).mouseout(function(){
            $(".xianshi").hide();
        });
    })

</script>
<p style="display: none;">
<#--友盟CNZZ统计-->
    <script src="https://s13.cnzz.com/z_stat.php?id=1263930585&web_id=1263930585" language="JavaScript">
        //声明_czc对象:
        var _czc = _czc || [];
        //绑定siteid，请用您的siteid替换下方"XXXXXXXX"部分
        _czc.push(["_setAccount", "www.ge960.com"]);
    </script>
</p>
</body>
</html>