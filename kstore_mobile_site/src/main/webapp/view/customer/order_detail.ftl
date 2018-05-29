<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>订单详情</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="keywords" content="${seo.meteKey}">
    <meta name="description" content="${seo.meteDes}">
    <meta name="format-detection" content="telephone=no" />
   <#assign basePath=request.contextPath>
    <link rel="stylesheet" href="${basePath}/css/style.min.css"/>
    <link rel="stylesheet" href="${basePath}/css/add-ons.min.css"/>
    <link rel="stylesheet" href="${basePath}/css/v2/order_detail.css"/>
    <script src="${basePath}/js/jquery-1.10.1.js"></script>

    <link rel="stylesheet" href="${basePath}/css/ui-dialog.css"/>
    <link rel="stylesheet" href="${basePath}/css/add-ons.min.css"/>
    <link rel="stylesheet" href="${basePath}/css/tip-newbox.css"/>
 <#--   <script src="${basePath}/js/pageAction.js"></script>-->
    <script src="${basePath}/js/dialog-min.js"></script>
</head>
<body>
<input type="hidden" id="basePath" value="${basePath}">
<#assign vtitle="订单详情" />
<#assign backUrl="${basePath}/order_detail.html" />
<#include "/common/head_back.ftl"/>
<#if order??>
<div class="order content-order-detail mb50">
    <div class="order-number">
        <div class="list-item">
            <h3 class="item-head">
                <label for="">订单编号：</label>
                <span>
                 <#if order.orderNo?length lt 15>
                    ${(order.orderNo[0..15])!''}
                 <#else>
                    ${order.orderNo}
                 </#if>
               </span>
                <p style="margin-bottom: 2px"></p>
                <label for="">下单时间：</label>
                <span><#if order.addTime??>${order.addTime?string('yyyy-MM-dd')}&nbsp;&nbsp;${order.addTime?string('HH:mm:ss')}</#if></span>
            <#assign cFlag=0 />
            <#assign sFlag=0 />
            <#assign gFlag=0 />
                <#list order.goods as good>
                    <#if good.evaluateFlag== '0'>
                        <#assign cFlag=cFlag+1 />
                    </#if>
                <#--订单商品状态为1退货审核、2待商家收货、3退货成功、7拒绝退货、8退货失败、4退款审核、5退款成功、6拒绝退款-->
                    <#if good.orderGoodsStatus?? && good.orderGoodsStatus != '0'>
                        <#assign sFlag=sFlag+1 />
                    </#if>
                <#--订单商品状态为3退货成功、5退款成功-->
                    <#if good.orderGoodsStatus?? && (good.orderGoodsStatus == '3' || good.orderGoodsStatus == '5')>
                        <#assign gFlag=gFlag+1 />
                    </#if>
                </#list>
            <#--<span class="curValue text-them">-->
            <#--<#if order.orderStatus??>-->
				<#--<#if order.orderStatus=="0">-->
                    <#--<#if order.orderLinePay=="0">-->
                        <#--等待发货-->
                    <#--<#else>-->
					   <#--等待付款-->
                    <#--</#if>-->
				<#--<#elseif (order.orderStatus=="1" || order.orderStatus=="5" || order.orderStatus=="6") >-->
					<#--等待发货-->
				<#--<#elseif order.orderStatus=="2">-->
					<#--等待收货-->
				<#--<#elseif (order.orderStatus=="3" && cFlag>0) >-->
                	<#--等待评价-->
				<#--<#elseif order.orderStatus=="3">-->
					<#--交易完成-->
				<#--<#elseif (order.orderStatus=="4") >-->
					<#--交易取消-->
				<#--</#if>-->
			<#--</#if>-->
            <#--</span>-->
            </h3>
        </div>
        <#--<div class="list-item">-->
            <#--<h3>感谢您的购买，欢迎再次光临！</h3>-->
        <#--</div>-->
    </div>
    <#--<div class="receive-info mt10">-->
        <#--<div class="list-item">-->
            <#--<h3>-->
                <#--<span class="name"><i class="user"></i>-->

                    <#--<#if order.orderExpressType == 1><!-- 表示自提信息取用户收货信息 &ndash;&gt;-->
                        <#--${(shippingAddress.addressName)!''}-->
                    <#--<#else>-->
                        <#--<#if order.shippingPerson??>-->
                            <#--${order.shippingPerson}-->
                        <#--</#if>-->
                    <#--</#if>-->
                <#--</span>-->
				<#--<span class="phoneNum"><i class="phone"></i>-->
                    <#--<#if order.orderExpressType == 1><!-- 表示自提信息取用户收货信息 &ndash;&gt;-->
                        <#--${shippingAddress.addressMoblie!''}-->
                    <#--<#else>-->
                        <#--<#if order.shippingMobile??>-->
                            <#--${order.shippingMobile?default('')}-->
                        <#--</#if>-->
                    <#--</#if>-->
                <#--</span>-->
            <#--</h3>-->
            <#--<p class="dress-info"><i class="dress"></i>-->
              <#--<#if order.orderExpressType == 1><!-- 表示自提信息 &ndash;&gt;-->
                  <#--${(shippingAddress.province.provinceName)!''}-->
                  <#--${(shippingAddress.city.cityName)!''}-->
                  <#--${(shippingAddress.district.districtName)!''}-->
                  <#--${(shippingAddress.addressDetail)!''}-->
              <#--<#else>-->
                  <#--<#if order.shippingProvince??>${order.shippingProvince?default('')}</#if>-->
                  <#--<#if order.shippingCity??>${order.shippingCity?default('')}</#if>-->
                  <#--<#if order.shippingCounty??>${order.shippingCounty?default('')}</#if>-->
                  <#--<#if order.shippingAddress??>${order.shippingAddress?default('')}</#if>-->
              <#--</#if>-->

            <#--</p>-->

            <#--<#if communityStore??>-->

                <#--<div style="padding-left:30px;">-->
                    <#--<p class="dress-info">-->
                        <#--社区店：${(communityStore.communityStoreName)!''}-->
                    <#--</p>-->
                    <#--<p class="dress-info">-->
                        <#--地&nbsp;&nbsp;&nbsp;址：-->
                    <#--${(communityStore.province.provinceName)!''}-->
                    <#--${(communityStore.city.cityName)!''}-->
                    <#--${(communityStore.district.districtName)!''}-->
                    <#--${(communityStore.communityStoreAddress)!''}-->
                    <#--</p>-->
                    <#--<p class="dress-info">-->
                        <#--联系人：-->
                    <#--${communityStore.contact!''}-->
                    <#--${communityStore.contactMobile!''}-->
                    <#--</p>-->
                <#--</div>-->
            <#--</#if>-->
            <#--&lt;#&ndash;<i class="arrow-right"></i>&ndash;&gt;-->
        <#--</div>-->
    <#--</div>-->
    <div class="order-info mt10">
        <div class="ordertitle">
            <#assign goodsNums = 0>
            <#if order.goods?? && order.goods?size gt 0 >
                <#list order.goods as good>
                   <#assign goodsNums = "${goodsNums?number + good.goodsNum}">
                </#list>
            </#if>
            共<span>${goodsNums}</span>件&nbsp;
            <span>
            <#if order.orderStatus??>
                <#if order.orderStatus=="0">
                    <#if order.orderLinePay=="0">
                        <#--等待发货-->已支付：￥<#if order.moneyPaid??>${(order.moneyPaid)?string('0.00')}<#else>0.00</#if>
                    <#else>
                        <#--等待付款-->需支付：￥<#if order.moneyPaid??>${(order.moneyPaid)?string('0.00')}<#else>0.00</#if>
                    </#if>
                <#elseif (order.orderStatus=="1" || order.orderStatus=="5" || order.orderStatus=="6") >
                    <#--等待发货--> 已支付：￥<#if order.moneyPaid??>${(order.moneyPaid)?string('0.00')}<#else>0.00</#if>
                <#elseif order.orderStatus=="2">
                    <#--等待收货-->已支付：￥<#if order.moneyPaid??>${(order.moneyPaid)?string('0.00')}<#else>0.00</#if>
                <#elseif (order.orderStatus=="3" && cFlag>0) >
                    <#--等待评价-->已支付：￥<#if order.moneyPaid??>${(order.moneyPaid)?string('0.00')}<#else>0.00</#if>
                <#elseif order.orderStatus=="3">
                    <#--交易完成-->已支付：￥<#if order.moneyPaid??>${(order.moneyPaid)?string('0.00')}<#else>0.00</#if>
                <#elseif (order.orderStatus=="4") >
                    <#--交易取消-->合计：￥<#if order.moneyPaid??>${(order.moneyPaid)?string('0.00')}<#else>0.00</#if>
                </#if>
            </#if>
            </span>
            <span class="orderdetail">
            <#if order.orderStatus??>
				<#if order.orderStatus=="0">
                    <#if order.orderLinePay=="0">
                        待发货
                    <#else>
					   待付款
                    </#if>
				<#elseif (order.orderStatus=="1" || order.orderStatus=="5" || order.orderStatus=="6") >
					待发货
				<#elseif order.orderStatus=="2">
                    已发货
				<#elseif (order.orderStatus=="3" && cFlag>0 && (gFlag<(order.goods)?size)) >
                	待评价
				<#elseif order.orderStatus=="3" && (cFlag=0 || gFlag==(order.goods)?size)>
					交易完成
				<#elseif (order.orderStatus=="4" || order.orderStatus=="18") >
					交易关闭
                <#elseif order.orderStatus=="7">
                    退货审核
                <#elseif order.orderStatus=="8">
                    同意退货
                <#elseif order.orderStatus=="9">
                    拒绝退货
                <#elseif order.orderStatus=="10">
                    待商家收货
                <#elseif order.orderStatus=="11">
                    退货结束
                <#elseif order.orderStatus=="15">
                    退款审核
                <#elseif order.orderStatus=="13">
                    待发货<#--拒绝退款-->
                <#elseif order.orderStatus=="14">
                    退货审核
                <#elseif order.orderStatus=="16">
                    商家收货失败
                <#elseif order.orderStatus=="17">
                    交易完成<#--退款成功-->
                </#if>
			</#if>
            </span>
        </div>
        <#assign giftCard=0>
        <div class="list-body-line">
            <#if (order.goods)?size gt 0>
              <#list order.goods as good>
                  <#if good.goodsName??&& (good.goodsName?index_of("电子卡")!=-1 || good.goodsName?index_of("实体卡")!=-1)><#assign giftCard=giftCard+1></#if>
                  <#if good_index lt 2>
                       <a class="order_good_link"  href="${basePath}/item/${good.goodsId}.html">
                        <div class="list-item order-pro-item">
                            <div class="pro-item">
                                <div class="propic">
                                    <img width="71" height="71" title="${(good.goodsName)!''}" alt="${(good.goodsName)!''}" src="${(good.goodsImg)!''}" />
                                </div>
                                <div class="prodesc">
                                    <h3 class="title"><#if good.isPresent?? && good.isPresent == '1'>
                                        <span style="color: white;background-color: #81b119;font-size: 12px;border-radius: 2px;">&nbsp;赠品&nbsp;</span></#if> ${(good.goodsName)!''}

                                    </h3>
                                    <#--<p class="spec">-->
                                        <#--<#if good.specVo??>-->
                                            <#--<#list good.specVo as specVo>-->
                                                <#--${specVo.spec.specName}:<span><#if specVo.specValueRemark??&&specVo.specValueRemark!='undefined'>${specVo.specValueRemark}<#else>${specVo.goodsSpecDetail.specDetailName!''} </#if></span>-->
                                            <#--</#list>-->
                                        <#--</#if>-->
                                    <#--</p>-->
                                    <#--<p class="price">¥&nbsp;<span class="num"><#if good.goodsPrice??>-->
                                                        <#--${good.goodsPrice?string('0.00')}-->
                                                    <#--</#if> </span><span class="num num1">90</span><span class="pro-num">×${good.goodsNum}</span></p>-->
                                    <#if good.countRush?? && good.countRush?number != 0 && good.countRush?number lt good.goodsNum?number>
                                        <p class="price">¥&nbsp;
                                            <span class="num">${good.goodsOldPrice?string('0.00')?substring(0,good.goodsOldPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${good.goodsOldPrice?string('0.00')?substring(good.goodsOldPrice?string('0.00')?index_of('.'))}</span>
                                            <span class="pro-num">×${good.goodsNum?number - good.countRush?number}</span>
                                        </p>
                                        <p class="price">¥&nbsp;
                                            <span class="num">${good.goodsPrice?string('0.00')?substring(0,good.goodsPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${good.goodsPrice?string('0.00')?substring(good.goodsPrice?string('0.00')?index_of('.'))}</span>
                                            <span class="pro-num">×${good.countRush}</span>
                                            <i style="color: #f00;float:right;font-size: 12px;">
                                                <#if good.orderGoodsStatus??>
                                                    <#if good.orderGoodsStatus=='1'>
                                                        退货审核
                                                    <#elseif good.orderGoodsStatus=='2'>
                                                        待商家收货
                                                    <#elseif good.orderGoodsStatus=='3'>
                                                        退货成功
                                                    <#elseif good.orderGoodsStatus=='4'>
                                                        退款审核
                                                    <#elseif good.orderGoodsStatus=='5'>
                                                        退款成功
                                                    <#elseif good.orderGoodsStatus=='6'>
                                                        拒绝退款
                                                    <#elseif good.orderGoodsStatus=='7'>
                                                        拒绝退货
                                                    <#elseif good.orderGoodsStatus=='8'>
                                                        退货失败
                                                    </#if>
                                                </#if>
                                            </i>
                                        </p>

                                    <#else>
                                        <p class="price" style="    visibility: hidden;              ">¥&nbsp;
                                            <span class="num">${good.goodsPrice?string('0.00')?substring(0,good.goodsPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${good.goodsPrice?string('0.00')?substring(good.goodsPrice?string('0.00')?index_of('.'))}</span>
                                            <span class="pro-num">×${good.goodsNum}</span>
                                        </p>
                                        <p class="price">¥&nbsp;
                                            <span class="num">${good.goodsPrice?string('0.00')?substring(0,good.goodsPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${good.goodsPrice?string('0.00')?substring(good.goodsPrice?string('0.00')?index_of('.'))}</span>
                                            <span class="pro-num">×${good.goodsNum}</span>
                                            <i style="color: #f00;float:right;font-size: 12px;">
                                                <#if good.orderGoodsStatus??>
                                                    <#if good.orderGoodsStatus=='1'>
                                                        退货审核
                                                    <#elseif good.orderGoodsStatus=='2'>
                                                        待商家收货
                                                    <#elseif good.orderGoodsStatus=='3'>
                                                        退货成功
                                                    <#elseif good.orderGoodsStatus=='4'>
                                                        退款审核
                                                    <#elseif good.orderGoodsStatus=='5'>
                                                        退款成功
                                                    <#elseif good.orderGoodsStatus=='6'>
                                                        拒绝退款
                                                    <#elseif good.orderGoodsStatus=='7'>
                                                        拒绝退货
                                                    <#elseif good.orderGoodsStatus=='8'>
                                                        退货失败
                                                    </#if>
                                                </#if>
                                            </i>
                                        </p>
                                    </#if>
                                    <#--<span class="pro-num">×${good.goodsNum}</span>-->
                                </div>
                            </div>
                        </div>
                        </a>
	            <#else>
                    <a class="order_good_link"  href="${basePath}/item/${good.goodsId}.html">
                    <div class="list-item order-pro-item" style="display:none">
                        <div class="pro-item">
                            <div class="propic">
                                <img width="71" height="71" title="${(good.goodsName)!''}" alt="${(good.goodsName)!''}" src="${(good.goodsImg)!''}" />
                            </div>
                            <div class="prodesc">
                                <h3 class="title"><#if good.isPresent?? && good.isPresent == '1'>
                                    <span style="color: white;background-color: #81b119;font-size: 12px;border-radius: 2px;">&nbsp;赠品&nbsp;</span></#if> ${(good.goodsName)!''}
                                </h3>
                                <#--<p class="price">¥&nbsp;-->
                                    <#--<span class="num">-->
                                        <#--<#if good.goodsPrice??>-->
                                            <#--${good.goodsPrice?string('0.00')}-->
                                        <#--</#if>-->
                                    <#--</span>-->
                                    <#--<span class="num num1">90</span>-->
                                    <#--<span class="pro-num">×${good.goodsNum}</span>-->
                                <#--</p>-->
                                <#if good.countRush?? && good.countRush?number != 0 && good.goodsNum?number gt good.countRush?number>
                                    <p class="price">¥&nbsp;
                                        <span class="num">${good.goodsOldPrice?string('0.00')?substring(0,good.goodsOldPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${good.goodsOldPrice?string('0.00')?substring(good.goodsOldPrice?string('0.00')?index_of('.'))}</span>
                                        <span class="pro-num">×${good.goodsNum?number - good.countRush?number}</span>
                                    </p>
                                    <p class="price">¥&nbsp;
                                        <span class="num">${good.goodsPrice?string('0.00')?substring(0,good.goodsPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${good.goodsPrice?string('0.00')?substring(good.goodsPrice?string('0.00')?index_of('.'))}</span>
                                        <span class="pro-num">×${good.countRush}</span>
                                        <i style="color: #f00;float:right;font-size: 12px;">
                                            <#if good.orderGoodsStatus??>
                                                <#if good.orderGoodsStatus=='1'>
                                                    退货审核
                                                <#elseif good.orderGoodsStatus=='2'>
                                                    待商家收货
                                                <#elseif good.orderGoodsStatus=='3'>
                                                    退货成功
                                                <#elseif good.orderGoodsStatus=='4'>
                                                    退款审核
                                                <#elseif good.orderGoodsStatus=='5'>
                                                    退款成功
                                                <#elseif good.orderGoodsStatus=='6'>
                                                    拒绝退款
                                                <#elseif good.orderGoodsStatus=='7'>
                                                    拒绝退货
                                                <#elseif good.orderGoodsStatus=='8'>
                                                    退货失败
                                                </#if>
                                            </#if>
                                        </i>
                                    </p>

                                <#else>
                                    <p class="price" style="    visibility: hidden;">¥&nbsp;
                                        <span class="num">${good.goodsPrice?string('0.00')?substring(0,good.goodsPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${good.goodsPrice?string('0.00')?substring(good.goodsPrice?string('0.00')?index_of('.'))}</span>
                                        <span class="pro-num">×${good.goodsNum}</span>
                                    </p>
                                    <p class="price">¥&nbsp;
                                        <span class="num">${good.goodsPrice?string('0.00')?substring(0,good.goodsPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${good.goodsPrice?string('0.00')?substring(good.goodsPrice?string('0.00')?index_of('.'))}</span>
                                        <span class="pro-num">×${good.goodsNum}</span>
                                        <i style="color: #f00;float:right;font-size: 12px;">
                                            <#if good.orderGoodsStatus??>
                                                <#if good.orderGoodsStatus=='1'>
                                                    退货审核
                                                <#elseif good.orderGoodsStatus=='2'>
                                                    待商家收货
                                                <#elseif good.orderGoodsStatus=='3'>
                                                    退货成功
                                                <#elseif good.orderGoodsStatus=='4'>
                                                    退款审核
                                                <#elseif good.orderGoodsStatus=='5'>
                                                    退款成功
                                                <#elseif good.orderGoodsStatus=='6'>
                                                    拒绝退款
                                                <#elseif good.orderGoodsStatus=='7'>
                                                    拒绝退货
                                                <#elseif good.orderGoodsStatus=='8'>
                                                    退货失败
                                                </#if>
                                            </#if>
                                        </i>
                                    </p>
                                </#if>
                                <#--<span class="pro-num">×${good.goodsNum}</span>-->
                            </div>
                        </div>
                    </div>
                   </a>
            </#if>
          </#list>
       </#if>
      </div>
      <#if (order.goods)?size gt 2>
         <div class="list-item see-all">
            — 显示其他${order.goods?size-2}件商品 —
        </div>
      </#if>
        <#--对不同状态的订单操作-->
        <div class="orderopera">
            <#if order.orderStatus??>
                <#if order.orderStatus=="0">
                <#--<#if order.payId?? && order.payId==1>-->
                    <#--现在的支付方式2017.9.10-->
                    <a href="${basePath}/orderdetailpay-${order.orderId}.html" class="btn pay-btn">立即支付</a>
                <#--<a href="javascript:void(0);" class="btn pay-btn" onclick="payOrder('${order.orderId}','${order.moneyPaid}')">立即支付</a>-->
                <#--</#if>-->
                    <a href="javascript:void(0);" class="btn" onClick="cancelOrder('${order.orderId}',1)">取消订单</a>
                <#elseif (order.orderStatus=="2")>
                    <#list order.expressno as expressno>
                    <#--<#if expressno_index==0>-->
                    <#--<a href="http://m.kuaidi100.com/index_all.html?type=${expressno.expressName!''}&postid=${expressno.expressNo!''}&callbackurl=${sys.bsetAddress}/mobile/customer/myorder-3-1.html" class="btn">查看物流</a>-->
                    <#--</#if>-->
                    </#list>
                    <a href="javascript:void(0);" class="btn" onClick="comfirmgoods('${order.orderId}',1)">确认收货</a>
                </#if>
                <#if isBackOrder==1>
                    <#if (order.orderStatus=="3")>
                        <#if (cFlag>0 && (gFlag<(order.goods)?size))>
                            <a  href="${basePath}/comment-${order.orderId}.html" class="<#if cFlag gt 0>btn<#else>btn-grey</#if>">评价</a>
                        </#if>

                    <#-- <a href="javascript:void(0)" class="btn" onclick="addCar('${order.orderId}')">再次购买</a>-->
                        <#if (sFlag==0)>
                        <a class="btn"  href="javascript:;" onclick="timeBackOrder(${order.orderId})">申请退货</a>
                        </#if>
                    <#elseif order.orderStatus=="1"|| order.orderStatus=="4" || order.orderStatus=="5" || order.orderStatus=="6">
                    <#-- <a href="javascript:void(0)" class="btn" onclick="addCar('${order.orderId}')">再次购买</a>-->
                    <#elseif (order.orderStatus=="13" ||order.orderStatus=="15" ||order.orderStatus=="18") >
                        <#if order.getGoodsTime??>
                            <a class="btn" href="${basePath}/customer/backordergoodsdetail-${order.orderId}.html">退货详情</a>
                        <#else>
                            <a class="btn" href="${basePath}/customer/backorderpricedetail-${order.orderId}.html">退款详情</a>
                        </#if>
                    <#elseif order.orderStatus=="8">
                        <a class="btn fill-flow" href="javascript:void(0)" onclick="expressInfo('${(order.orderNo)!''}')" style="width:100px">填写物流信息</a>
                    <#elseif  (order.orderStatus=="7" ||
                    order.orderStatus=="8" ||
                    order.orderStatus=="9" ||
                    order.orderStatus=="10" ||
                    order.orderStatus=="11" ||
                    order.orderStatus=="14" ||
                    order.orderStatus=="16" ||
                    order.orderStatus=="17" ||
                    order.orderStatus=="12")>
                        <#if order.orderStatus=="8">
                            <a class="btn fill-flow" href="javascript:void(0)" onclick="expressInfo('${(order.orderNo)!''}')">物流信息</a>
                        </#if>
                        <a class="btn" href="${basePath}/customer/backordergoodsdetail-${order.orderId}.html">退货详情</a>
                    </#if>
                    <#if ( order.orderStatus=="5" || order.orderStatus=="6")>
                        <a  href="${basePath}/customer/applybackgoods-${order.orderId}.html">申请退货</a>
                    </#if>
                    <#if order.orderStatus=="1" && giftCard == 0 && sFlag==0>
                        <a  class="btn"  href="${basePath}/customer/mapplybackmoney-${order.orderId}.html">申请退款</a>
                    </#if>
                <#elseif  isBackOrder==2>
                    <#if (order.orderStatus=="3")>
                        <#if (cFlag>0 && (gFlag<(order.goods)?size))>
                            <a  href="${basePath}/comment-${order.orderId}.html" class="<#if cFlag gt 0>btn<#else>btn-grey</#if>">评价</a>
                        </#if>

                    <#-- <a href="javascript:void(0)" class="btn" onclick="addCar('${order.orderId}')">再次购买</a>-->
                    <#elseif order.orderStatus=="1"|| order.orderStatus=="4" || order.orderStatus=="5" || order.orderStatus=="6">
                    <#--  <a href="javascript:void(0)" class="btn" onclick="addCar('${order.orderId}')">再次购买</a>-->
                    </#if>
                </#if>
            </#if>
            <!--再次买 -->
            <a href="javascript:void(0)" class="btn" onclick="addCar('${order.orderId}')">再次购买</a>
        </div>
    </div>


    <#if order.shippingProvince?? && order.shippingProvince !=''>
<#--收货信息-->
    <div class="receive-info mt10">
        <div class="list-item">
            <h3>
                <span class="name" style="letter-spacing: 1px;">收货方式</span>:&nbsp;&nbsp;<span class="name"><#if order.orderExpressType??&&order.orderExpressType==1>社区店自提<#elseif order.orderExpressType==0>送货上门—新规</#if></span>
            </h3>
            <h3>
                <span class="name" style="letter-spacing: 8px;">收货人</span>:&nbsp;&nbsp;<span class="name"><#if order.shippingPerson??>${order.shippingPerson}</#if></span>
            </h3>
            <h3>
                <span class="phoneNum" style="letter-spacing: 1px;">联系电话</span>:&nbsp;&nbsp;<span class="phoneNum"><#if order.shippingMobile??>${order.shippingMobile}</#if></span>
            </h3>
            <div style="font-size:14px; color:#000; line-height:28px;">
                <span class="address" style="letter-spacing: 1px;">收货地址</span>
                <span style="padding: 0 0 0 2px;">:&nbsp;</span>
                <span class="address">${order.shippingProvince}&nbsp;${order.shippingCity}&nbsp;${order.shippingCounty}&nbsp;${order.shippingAddress}</span>
                <div class="clearfixed"></div>
            </div>
            <#if communityStore??>
                <h3>
                    <span class="address" style="letter-spacing: 8px;">社区店</span>:&nbsp;&nbsp;<span class="address">${communityStore.communityStoreName}</span>
                </h3>
                <p><i></i>${communityStore.contact}</p>
                <p><i></i>${communityStore.contactMobile}</p>
                <p><i></i>${communityStore.province.provinceName}&nbsp;${communityStore.city.cityName}&nbsp;${communityStore.district.districtName}&nbsp;${communityStore.communityStoreAddress}</p>
            </#if>
        </div>
    </div>
    </#if>
<#--发卡邮箱-->
    <#if order.giftcardEmail?? && order.giftcardEmail !=''>
    <div class="receive-info mt10" style="margin-top: 1px;">
        <div class="list-item" style="padding: 8px 15px">
            <h3>
                <span class="name">发卡邮箱</span>:&nbsp;&nbsp;<span class="name">${order.giftcardEmail}</span>
            </h3>
        </div>
    </div>
    </#if>



    <div class="paid-way mt10">
        <div class="list-item">
            <h3 class="item-head">支付方式及发票信息</h3>

            <div class="list-value">
                <p>
                    <label for="">支付方式：</label>
	                <#if order.payId??>
	                      <#if order.payId==2>
								货到付款
	                      <#else>
	                         	在线支付
	                      </#if>
	                </#if>
                </p>
               <!-- <ul>
                    <li><label for="">户名：</label>234</li>
                    <li><label for="">开户行：</label>中国银行</li>
                    <li><label for="">账号：</label>6223384773829847857</li>
                    <li><label for="">汇款识别码：</label>123456</li>
                </ul>-->
                <#if order.invoiceType??&&order.invoiceType!='0'>
                 <p><label for="">发票类型：</label>
                   <#if order.invoiceType=='1'>
                                    普通发票
                   <#elseif order.invoiceType=='2'>
                                     增值发票
                  </#if>
                </p>
                <p class="light">
                    <label for="">发票抬头：</label>

                        <#if order.invoiceTitle??>
                             ${order.invoiceTitle?default('')}
                        </#if>
                </p>
               <p class="light">
                   <label for="">发票内容：</label>

                        <#if order.invoiceContent??>
                             ${order.invoiceContent?default('')}
                        </#if>
                </p>
                <p class="light">
                    <label for="">
                        <#if order.invoiceTitle??>
                             <#if order.invoiceTitle?index_of('个人') lt 0>
                             纳税人号：</label>
                               <#if order.taxpayerNumber??>
                                ${order.taxpayerNumber?default('')}
                               </#if>
                             </#if>
                        </#if>
                </p>
             </#if>
            </div>
        </div>
        <#--<#if order.orderExpressType==1><!-- 表示自提信息 &ndash;&gt;-->
            <#--<div class="list-item">-->
                <#--<h3 class="item-head">配送信息</h3>-->
                <#--<div class="list-value">-->
                    <#--<p><label for="">配送方式：</label>上门自提 </p>-->
                    <#--<p><label for="">自提点：</label>${(deliveryPoint.name)!''}</p>-->
                    <#--<p><label for="">自提地址：</label>${(deliveryPoint.address)!''}</p>-->
                    <#--<p><label for="">联系电话：</label>${(deliveryPoint.telephone)!''}<a href="tel://${(deliveryPoint.telephone)!''}" class="tel"><i class="ion-ios-telephone-outline"></i></a> </p>-->
                    <#--<p><label for="">联系人：</label>${(deliveryPoint.linkman)!''}</p>-->
                <#--</div>-->
            <#--</div>-->
        <#--</#if>-->

    </div>
    <div class="all-info mt10">
        <div class="list-item" style="padding-bottom:20px;">
            <ul class="price-total">
                <li><label for="">商品金额</label><span class="value">￥${(order.oldPrice)?string('0.00')?substring(0,order.oldPrice?string('0.00')?index_of('.'))}<i style="font-size: 12px;">${(order.oldPrice)?string('0.00')?substring(order.oldPrice?string('0.00')?index_of('.'))}</i></span></li>
                      <#assign discountsSumPrice = 0>
                      <#if order.prePrice??>
                         <#assign discountsSumPrice="${discountsSumPrice?number + order.prePrice?number?abs}">
                      </#if>
                      <#if order.jfPrice??>
                        <#assign discountsSumPrice="${discountsSumPrice?number + order.jfPrice?number?abs}">
                      </#if>
                      <#if order.couponPrice??>
                        <#assign discountsSumPrice="${discountsSumPrice?number + order.couponPrice?number?abs}">
                      </#if>
                      <#if order.discountPrice??>
                         <#assign  discountsSumPrice="${order.discountPrice?number+discountsSumPrice?number}">
                      </#if>
                <li><label for="">减扣金额</label><span class="value up" onclick="showmore(this)">-&yen;${discountsSumPrice?number?string('0.00')?substring(0,discountsSumPrice?number?string('0.00')?index_of("."))}<i style="font-size: 12px;">${discountsSumPrice?number?string('0.00')?substring(discountsSumPrice?number?string('0.00')?index_of("."))}</i></span></li>
                <li class="showmore">
                    <label for="">优惠金额</label><span class="value">-&yen;&nbsp;<#if order.prePrice??>${order.prePrice?abs?string('0.00')}<#else>0.00</#if></span></br>
                    <label for="">积分金额</label><span class="value">-&yen;&nbsp;<#if order.jfPrice??>${order.jfPrice?string('0.00')}<#else>0.00</#if></span></br>
                    <label for="">优惠券金额</label><span class="value">-&yen;&nbsp;<#if order.couponPrice??>${order.couponPrice?string('0.00')}<#else>0.00</#if></span></br>
                    <label for="">会员折扣</label><span class="value">-&yen;&nbsp;<#if order.discountPrice??>${order.discountPrice?string('0.00')}<#else>0.00</#if></span>
                </li>
                <#--<li><label for="">使用积分</label><span class="value">-${(order.orderIntegral)!'0'}<#if (order.jfPrice)??>(￥${order.jfPrice})</#if></span></li>-->
                <li>
                    <label  for="">配送费</label><a class="info" href="${basePath}/intoPage.htm?pageName=member/standard"></a>
                    <span class="value">
                            ￥<#if order.shippingFee??> ${(order.shippingFee)?string('0.00')?substring(0,order.shippingFee?string('0.00')?index_of('.'))}<i style="font-size: 12px;">${(order.shippingFee)?string('0.00')?substring(order.shippingFee?string('0.00')?index_of('.'))}</i>
                        <#else>
                            0.<i style="font-size: 12px;">00</i>
                        </#if>
                    </span>
                </li>
                <li>
                    <label for="">订单总计</label>
                    <span class="value text-them" style="color: #199301!important;" >
                        ￥<#if order.moneyPaid??>
                           ${(order.moneyPaid)?string('0.00')?substring(0,order.moneyPaid?string("0.00")?index_of('.'))}<i style="font-size: 12px;">${(order.moneyPaid)?string('0.00')?substring(order.moneyPaid?string("0.00")?index_of('.'))}</i>
                          <#else>
                              0<i style="font-size: 12px;">00</i>
                          </#if>
                    </span>
                    <#--<span class="value text-them" style="color: #ff0000;">(礼品卡支付￥100.<i style="font-size: 12px;">00</i>)</span>-->
                </li>
            </ul>
        </div>
    </div>
   <!-- <div class="all-info mt10">
        <div class="application-after-sale">
            <a class="btn btn-full" href="order-aftersale.html"><i></i>申请售后</a>
        </div>
    </div>-->
</div>
</#if>
<div class="tip-box" id="confirm_order" style="display:none">
    <div class="tip-body2">
        <h3 id="tiptitle">是否确认收货？</h3>
        <div class="btn-group">
            <a class="btn btn-grey" href="javascript:;" onclick="cancelComfirmGoods()">取&nbsp;消</a>
            <a class="btn btn-them" href="javascript:;" onclick="comfirmGoodsSucc()">确&nbsp;定</a>
        </div>
    </div>
</div>
<input type="hidden" id="paymoneyId" value="">
<#--<#include "../common/smart_menu.ftl">-->
</body>
    <script src="${basePath}/js/tip-newbox.js"/></script>
    <script src="${basePath}/js/customer/myorder.js"></script>
    <script src="${basePath}/js/pageAction.js"></script>
    <script>
        (function (doc, win) {
            var docEl = doc.documentElement,
                    resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
                    recalc = function () {
                        var clientWidth = docEl.clientWidth;
                        if (!clientWidth) return;
                        if(clientWidth>=640){
                            docEl.style.fontSize = '100px';
                        }else{
                            docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
                        }
                    };
            if (!doc.addEventListener) return;
            win.addEventListener(resizeEvt, recalc, false);
            doc.addEventListener('DOMContentLoaded', recalc, false);
        })(document, window);
        $(function(){
            $(".bar-bottom a:eq(3)").addClass("selected");
            /* 显示隐藏的商品 */
            $('.see-all').click(function(){
                $(this).prev('.list-body-line').find('.list-item').show();
                $(this).remove();
            });
        });
        function showmore(a){

            if($(".price-total .showmore").css("display")=="none"){
                $(a).removeClass("up2");
                $(a).addClass("up1")
            }else{
                $(a).removeClass("up1");
                $(a).addClass("up2")
            }
            $(".price-total .showmore").toggle("fast");
        }

        var zhifu ='';
        $(function(){
           // $(".content-block-menu a[name=]").addClass("active").siblings().removeClass("active");
            zhifu = '<div class="pay-btns">';
            $.ajax({
                url: basePath+'/querypayments.htm',
                async:false,
                success:function(result){
                    if(result != ''){
                        for(var i=0;i<result.length;i++){
                            if(result[i].isOpen == '1' && result[i].payType=='3'&& isWeiXin()){
                                zhifu += '<a class="btn btn-full mb10 weixin" href="javascript:;"><i></i>微信支付</a>';
                            }else if(result[i].isOpen == '1' && result[i].payType=='1' && !isWeiXin()){
                                zhifu += '<a class="btn btn-full mb10 weixin" href="javascript:;"><i></i>支付宝支付</a>';
                            }else if(result[i].isOpen == '1' && result[i].payType=='5'){
                                zhifu += '<a class="btn btn-full mb10 yue" href="javascript:;"><i></i>预存款支付</a>';
                            }
                        }
                    }
                    zhifu += '</div>';
                }
            });
        })

        //判断是否是微信打开
        function isWeiXin(){
            var ua = window.navigator.userAgent.toLowerCase();
            if(ua.match(/MicroMessenger/i) == 'micromessenger'){
                return true;
            }else{
                return false;
            }
        }

        function payOrder(orderId,orderPrice) {
            $('#paymoneyId').val(orderId);
            /*if(isWeiXin()){
                zhifu = '<div class="pay-btns"><a class="btn btn-full-grey yue"><i></i>预存款支付</a></div>';
            }else{
                zhifu = '<div class="pay-btns"><a class="btn btn-full-grey yue"><i></i>预存款支付</a></div>';
            }*/
            var payBox = dialog({
                width: 300,
                title: '选择一种支付方式',
                content: zhifu,
                onshow: function (orderId) {
                    var weixinPay = dialog({
                        width: 260,
                        content: '<p class="tc">您需要为该笔订单支付</p><p class="tc"><span class="text-them" id="paymoney">￥55.00</span></p> ',
                        okValue: '继续支付',
                        cancelValue: '返回',
                        ok: function () {
                            if(isWeiXin()){
                                //确认离开，跳转到下一页面
                                $.ajax({
                                    type: "POST",
                                    url: "${basePath}/getmwxparam.htm",
                                    data: "orderId=" + $('#paymoneyId').val(),
                                    success: function (msg) {
                                        callpay(msg.appId, msg.timeStamp, msg.nonceStr, msg.package, msg.sign);
                                    }
                                });
                            }else{
                                window.location.href="${basePath}/orderlistpay.htm?orderId="+$('#paymoneyId').val();
                            }
                            return false;
                        },
                        cancel: function () {
                            //停留在当前页面
                            return true;
                        }
                    });

                    $('a.weixin').click(function () {
                        payBox.close().remove();
                        weixinPay.showModal();
                        $("#paymoney").text('￥' + orderPrice);
                        weixinPay.reset();
                    });
                    $('.yue').click(function(){
                        payBox.close().remove();
                        var orderId = $("#payOrderId").val();
                        $.ajax({
                            url:'${basePath}/checkDepositPay.htm?type=0&orderPrice='+orderPrice,
                            type:'get',
                            success: function(result){
                                var return_code = result.return_code;
                                if(return_code == 'success'){
                                    var yuePay = dialog({
                                        id: 'deposit-id',
                                        width : 260,
                                        content : '<form id="depositpay"> <div style="padding:0 5px"><p class="tc">请输入支付密码</p><p class="tc"><input onkeyup="validDeposit(this);" name="payPassword" type="password" class="p10" id="payPassword"></p><div class="error_tips" style="display: none"><a href="#" class="fr">忘记密码？</a><span>密码错误</span></div></div><div class="dia-buttons"><a onclick="closeDialog();" class="cancel">取消</a><a id="depositok" onclick="depositPay(this,'+orderId+');" class="ok disabled" style="margin-left: 4%;">确定</a></div></div>'
                                    });
                                    yuePay.showModal();
                                }else if(return_code == 'fail'){
                                    var fail_code = result.fail_code;
                                    var return_msg = result.return_msg;
                                    if(fail_code == 'pass_fail'){
                                        var passFail = dialog({
                                            id: 'deposit-pass',
                                            width : 260,
                                            content : '<div style="padding:0 5px"><p class="tc">'+ return_msg +'</p></div><div class="dia-buttons"><a onclick="closeDialog();" class="cancel">其他方式支付</a><a href="${basePath}/accountsafe.html" id="depositok" class="ok" style="margin-left: 4%;">设置支付密码</a></div></div>'
                                        });
                                        passFail.reset();
                                        passFail.showModal();
                                    }else if(fail_code == 'frozen_fail'){
                                        var frozenFail = dialog({
                                            id: 'deposit-frozen',
                                            width : 260,
                                            content : '<div style="padding:0 20px"><p class="tc">'+ return_msg +'</p></div><div class="dia-buttons" style="padding: 0 20px"><a onclick="closeDialog();" id="depositok" style="margin: 0;width: 100%" class="ok">确认</a></div></div>'
                                        });
                                        frozenFail.reset();
                                        frozenFail.showModal();
                                    }else if(fail_code == 'balance_fail'){
                                        var balanceFail = dialog({
                                            id: 'deposit-balance',
                                            width : 260,
                                            content : '<div style="padding:0 20px"><p class="tc">'+ return_msg +'</p></div><div class="dia-buttons" style="padding: 0 20px"><a onclick="closeDialog();" id="depositok" style="margin: 0;width: 100%" class="ok">确认</a></div></div>'
                                        });
                                        balanceFail.reset();
                                        balanceFail.showModal();
                                    }

                                }
                            }
                        });
                    });

                }
            });
            $("#payOrderId").val(orderId);
            payBox.showModal();
        }

        function validDeposit(obj){
            var pass = $(obj).val();
            if($(obj).val() != ''){
                $(".ok").removeClass("disabled");
//                depositdialog.reset();
            }else{
                $(".ok").addClass("disabled");
            }


        }


        function depositPay(obj,orderId){
            if($(obj).hasClass('disabled')){
                return false;
            }
            $("#chPay").val("5");
            $.ajax({
                url:'${basePath}/depositpayorder.htm',
                type:'post',
                data: {"orderId":$('#paymoneyId').val(),"payPassword":$('#payPassword').val()},
                success: function(result){
                    if(result.return_code == "success"){
                        $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><i class="success"></i><h3>支付成功！</h3></div></div>');
                        setTimeout(function(){
                            $('.tip-box').remove();
                            location.href="${basePath}/customer/myorder.html";
                        },1000);
                    }else if(result.return_code == "fail"){
                        var return_msg = result.return_msg;
                        var fail_code = result.fail_code;
                        if(fail_code == 'pass_fail'){
                            dialog.getCurrent().content('<div style="padding:0 5px"><p class="tc">'+ return_msg +'</p></div><div class="dia-buttons"><a class="cancel">选择其他支付方式</a><a id="depositok" href="${basePath}/accountsafe.html" class="ok" style="margin-left: 4%;">设置支付密码</a></div></div>');
                        }else if(fail_code == 'frozen_fail'){
                            dialog.getCurrent().content('<div style="padding:0 20px"><p class="tc">'+ return_msg +'</p></div><div class="dia-buttons" style="padding: 0 20px"><a id="depositok" onclick="closeDialog();" style="margin: 0;width: 100%" class="ok">确认</a></div></div>');
                        }else{
                            dialog.getCurrent().content('<form id="depositpay"><div style="padding:0 5px"><p class="tc">支付密码</p><p class="tc"><input onkeyup="validDeposit(this);" type="password" name="payPassword" id="payPassword" class="p10"></p><div class="error_tips"><a href="${basePath}/member/topaypassword.html" class="fr">忘记密码？</a><span>'+ return_msg +'</span></div></div><div class="dia-buttons"><a onclick="closeDialog();" class="cancel">取消</a><a id="depositok" onclick="depositPay(this,'+ orderId +');" class="ok disabled" style="margin-left: 4%;">确定</a></div></div>');
                        }
//                    this.content('<div style="padding:0 20px"><p class="tc">支付密码</p><p class="tc"><input type="text" class="p10"></p><div class="error_tips"><a href="#" class="fr">忘记密码？</a><span>密码错误</span></div></div> ');
                        dialog.getCurrent().reset();
                        return false;
                    }
                }
            });
        }

        function closeDialog(){
            dialog.getCurrent().close();
        }
        function callpay(appId,timeStamp,nonceStr,package,sign){
            WeixinJSBridge.invoke('getBrandWCPayRequest',{
                "appId" : appId,
                "timeStamp" : timeStamp,
                "nonceStr" : nonceStr,
                "package" : package,
                "signType" : "MD5",
                "paySign" : sign
            },function(res){
                WeixinJSBridge.log(res.err_msg);
                if(res.err_msg == "get_brand_wcpay_request:ok"){
                    $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><i class="success"></i><h3>支付成功！</h3></div></div>');
                    setTimeout(function(){
                        $('.tip-box').remove();
                        location.href="${basePath}/paysucccesswx.htm";
                    },1000);

                }else if(res.err_msg == "get_brand_wcpay_request:cancel"){
                    $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><i class="failed"></i><h3>用户取消支付！</h3></div></div>');
                    setTimeout(function(){
                        $('.tip-box').remove();
                        location.href=location;
                    },1000);
                }else{
                    $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><i class="failed"></i><h3>支付失败！</h3></div></div>');
                    setTimeout(function(){
                        $('.tip-box').remove();
                        location.href=location;
                    },1000);
                }
            })
        }
  </script>
</html>