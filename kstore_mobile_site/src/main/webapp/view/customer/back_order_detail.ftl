<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="keywords" content="${seo.meteKey}">
    <meta name="description" content="${seo.meteDes}">
    <#assign basePath=request.contextPath>
    <link rel="stylesheet" href="${basePath}/css/style.min.css"/>
    <link rel="stylesheet" href="${basePath}/css/v2/back_order.css"/>
    <link rel="stylesheet" href="${basePath}/css/v2/back_order_detail.css"/>
    <script src="${basePath}/js/jquery-1.10.1.js"></script>
    <script src="${basePath}/js/pageAction.js"></script>
</head>
<body>
<#assign vtitle="退款详情" />
<#assign backUrl="javascript:history.go(-1);" />
<#include "/common/head_back.ftl"/>
<#--<div class="vheader">-->
    <#--<a href="javascript:history.go(-1);" class="back link"><img src="${basePath}/images/v1/myimages/my-back.png" height="25" width="12" /></a>-->
    <#--<span></span>-->
    <#--<a id="icon-option" href="javascript:;"></a>-->
<#--</div>-->
<#--<#assign vtitle="" />-->
<#--&lt;#&ndash;<#assign backUrl="${basePath}/customer/myorder-6-1.html" />&ndash;&gt;-->
<#--<#assign backUrl="" />-->
<#--<#include "../common/head_back.ftl"/>-->

<div class="order content-order-return">
    <div class="order-number back_order">

        <div class="back_order_title">

            <div class="title">

            <#if bOrder.backCheck??>
                <#if bOrder.backCheck=="0">
                    退货审核
                <#elseif bOrder.backCheck=="1">
                    同意退货
                <#elseif bOrder.backCheck=="2">
                    拒绝退货
                <#elseif bOrder.backCheck=="3">
                    待商家收货
                <#elseif bOrder.backCheck=="4">
                    <#--退单结束-->
                    <#if (bOrder.isBack)??>
                        <#if bOrder.isBack=="2">
                            退款成功
                        <#else>
                            退货成功
                        </#if>
                    </#if>
                <#elseif bOrder.backCheck=="6">
                    退款审核
                <#elseif bOrder.backCheck=="7">
                    拒绝退款
                <#elseif bOrder.backCheck=="8">
                    退货失败
                <#elseif bOrder.backCheck=="9">
                    待填写物流地址
                <#elseif bOrder.backCheck=="10">
                    退款成功
                </#if>
            </#if>
            </div>
        <#--退货详情-->
            <ul class="status th">
            <#if backOrderLogs??>
                <#list backOrderLogs as  backOrderLog>
                    <#if backOrderLog.backLogStatus??>
                        <li>
                            <div class="diagram"><span class="line"></span><p class="dot"></p></div>
                            <p>
                                <#if backOrderLog.backLogStatus == '1'>
                                    申请退货审核<#if backOrderLog.backRemark?? && backOrderLog.backRemark !=''></#if>
                                </#if>
                                <#if backOrderLog.backLogStatus == '2'>
                                    退货审核通过<#if backOrderLog.backRemark?? && backOrderLog.backRemark !=''></#if>
                                </#if>
                                <#if backOrderLog.backLogStatus == '3'>
                                    拒绝退货<#--退货审核不通过--><#if backOrderLog.backRemark?? && backOrderLog.backRemark !=''></#if>
                                </#if>
                                <#if backOrderLog.backLogStatus == '4'>
                                    填写快递信息<#if backOrderLog.backRemark?? && backOrderLog.backRemark !=''></#if>
                                </#if>
                                <#if backOrderLog.backLogStatus == '5'>
                                    确认收货<#if backOrderLog.backRemark?? && backOrderLog.backRemark !=''></#if>
                                </#if>
                                <#if backOrderLog.backLogStatus == '6'>
                                    退货失败<#--收货失败--><#if backOrderLog.backRemark?? && backOrderLog.backRemark !=''></#if>
                                </#if>
                                <#if backOrderLog.backLogStatus == '7' || backOrderLog.backLogStatus == '8'>
                                    退款${bOrder.backPrice?string('0.00')}元<#if backOrderLog.backRemark?? && backOrderLog.backRemark !=''></#if>
                                </#if>
                                <#if backOrderLog.backLogStatus == '9'>
                                    拒绝退款<#if backOrderLog.backRemark?? && backOrderLog.backRemark !=''></#if>
                                </#if>
                            </p>
                            <p style="font-size: 12px">${backOrderLog.backLogTime?string("yyyy-MM-dd")}</p>
                        </li>
                    </#if>
                </#list>
            </#if>
                <#--<li>-->
                    <#--<div class="diagram"><span class="line"></span><p class="dot"></p></div>-->
                    <#--<p>申请退货审核</p>-->
                    <#--<p>2017-06-07</p>-->
                <#--</li>-->
                <#--<li>-->
                    <#--<div class="diagram">-->
                        <#--<span class="line"></span>-->
                        <#--<p class="dot"></p>-->
                    <#--</div>-->
                    <#--<p>退货审核通过</p>-->
                    <#--<p>2017-06-07</p>-->
                <#--</li>-->
                <#--<li class="active">-->
                    <#--<div class="diagram">-->
                        <#--<span class="line"></span>-->
                        <#--<p class="dot active">-->
                            <#--<img src="../../images/v2/backsuccess@2x.png">-->
                        <#--</p>-->
                    <#--</div>-->
                    <#--<p>退款1589.80元</p>-->
                    <#--<p>2017-06-07</p>-->
                <#--</li>-->
            </ul>
        <#--退款详情-->
            <ul class="status tk">
            <#if backOrderLogs??>
                <#list backOrderLogs as  backOrderLog>
                    <#if backOrderLog.backLogStatus??>
                        <li>
                            <div class="diagram"><span class="line"></span><p class="dot"></p></div>
                            <p>
                                <#if backOrderLog.backLogStatus == '1'>
                                    申请退款审核<#if backOrderLog.backRemark?? && backOrderLog.backRemark !=''></#if>
                                </#if>
                                <#if backOrderLog.backLogStatus == '2'>
                                    申请审核通过<#if backOrderLog.backRemark?? && backOrderLog.backRemark !=''></#if>
                                </#if>
                                <#if backOrderLog.backLogStatus == '3'>
                                    申请审核不通过<#if backOrderLog.backRemark?? && backOrderLog.backRemark !=''></#if>
                                </#if>
                                <#if backOrderLog.backLogStatus == '4'>
                                    填写快递信息<#if backOrderLog.backRemark?? && backOrderLog.backRemark !=''></#if>
                                </#if>
                                <#if backOrderLog.backLogStatus == '5'>
                                    确认收货<#if backOrderLog.backRemark?? && backOrderLog.backRemark !=''></#if>
                                </#if>
                                <#if backOrderLog.backLogStatus == '6'>
                                    收货失败<#if backOrderLog.backRemark?? && backOrderLog.backRemark !=''></#if>
                                </#if>
                                <#if backOrderLog.backLogStatus == '7' || backOrderLog.backLogStatus == '8'>
                                    退款${bOrder.backPrice?string('0.00')}元<#if backOrderLog.backRemark?? && backOrderLog.backRemark !=''></#if>
                                </#if>
                                <#if backOrderLog.backLogStatus == '9'>
                                    退款失败<#--拒绝退款--><#if backOrderLog.backRemark?? && backOrderLog.backRemark !=''></#if>
                                </#if>
                            </p>
                            <p style="font-size: 12px">${backOrderLog.backLogTime?string("yyyy-MM-dd")}</p>
                        </li>
                    </#if>
                </#list>
            </#if>
                <#--<li>-->
                    <#--<div class="diagram"><span class="line"></span><p class="dot"></p></div>-->
                    <#--<p>申请退款审核</p>-->
                    <#--<p>2017-06-07</p>-->
                <#--</li>-->
                <#--<li class="active">-->
                    <#--<div class="diagram">-->
                        <#--<span class="line"></span>-->
                        <#--<p class="dot active">-->
                            <#--&lt;#&ndash;<img src="../../images/v2/backsuccess@2x.png">&ndash;&gt;-->
                        <#--</p>-->
                    <#--</div>-->
                    <#--<p>退款1589.80元</p>-->
                    <#--<p>2017-06-07</p>-->
                <#--</li>-->
            </ul>
        </div>

        <div class="list-item">
            <#--<h3 class="item-head text-them">-->
                <#--<#if bOrder.backCheck??>-->
                    <#--<#if bOrder.backCheck=="0">-->
                       	 <#--退货审核-->
                    <#--<#elseif bOrder.backCheck=="1">-->
                         <#--同意退货-->
                    <#--<#elseif bOrder.backCheck=="2">-->
                      	  <#--拒绝退货-->
                    <#--<#elseif bOrder.backCheck=="3">-->
                       	 <#--待商家收货-->
                    <#--<#elseif bOrder.backCheck=="4">-->
                        	<#--退单结束-->
                    <#--<#elseif bOrder.backCheck=="6">-->
                        	<#--退款审核-->
                    <#--<#elseif bOrder.backCheck=="7">-->
                        	<#--拒绝退款-->
                    <#--<#elseif bOrder.backCheck=="8">-->
                       	 <#--拒绝收货-->
                    <#--<#elseif bOrder.backCheck=="9">-->
                        	<#--待填写物流地址-->
                    <#--<#elseif bOrder.backCheck=="10">-->
                      	 <#--退款成功-->
                    <#--</#if>-->
                <#--</#if>-->
            <#--</h3>-->
            <h3 class="item-head"><label for="">订单号：</label><span>${(backorder.orderCode)!''}</span></h3>
            <h3 class="item-head"><label for="">退单号：</label><span>${(bOrder.backOrderCode)!''}</span></h3>
        </div>
    </div>


    <div class="mt10">
        <div class="order-info">
            <div class="list-body-line">
                <#if bOrder.orderGoodsList?? && bOrder.orderGoodsList?size gt 0>
                    <#list bOrder.orderGoodsList as list>
	                    <#if list_index lt 2>
                                <a title="${list.goodsInfoName!''}" href="javascript:void(0);">
                                <div class="list-item">
                                    <div class="pro-item">
                                        <div class="propic">
                                            <img alt="" src="${list.goodsImg}"/>
                                        </div>
                                        <div class="prodesc" id="prodesc_id">
                                            <h3 class="title">
                                                <#if list.isPresent?? && list.isPresent == '1'>
                                                <img src="../../images/v2/gift@2x.png" width="28" height="16" style="vertical-align: middle;margin-bottom: 2px;">
                                                    <#--<span style="color: white;font-size: 10px; margin-bottom: 3px;background-color: #81b119;border-radius: 2px;line-height: 14px;height: 13px;vertical-align: middle">&nbsp;赠品&nbsp;</span>-->
                                                </#if> ${(list.goodsInfoName)!''}</h3>

                                            <#--<p class="price">¥&nbsp;<span class="num" style="display: initial">${(list.goodsInfoPrice)?string('0.00')}</span></p>
                                            <span class="pro-num" style="margin-top: -3rem;">×${list.goodsInfoNum}</span>-->
                                            <#if list.countRush?? && list.countRush?number != 0 && list.countRush?number lt list.goodsInfoNum?number>
                                                <p class="price">¥&nbsp;
                                                    <span class="num">${list.goodsInfoOldPrice?string('0.00')?substring(0,list.goodsInfoOldPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${list.goodsInfoOldPrice?string('0.00')?substring(list.goodsInfoOldPrice?string('0.00')?index_of('.'))}</span>
                                                    <span class="pro-num">×${list.goodsInfoNum?number - list.countRush?number}</span>
                                                </p>
                                                <p class="price">¥&nbsp;
                                                    <span class="num">${list.goodsInfoPrice?string('0.00')?substring(0,list.goodsInfoPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${list.goodsInfoPrice?string('0.00')?substring(list.goodsInfoPrice?string('0.00')?index_of('.'))}</span>
                                                    <span class="pro-num">×${list.countRush}</span>
                                                </p>

                                            <#else>
                                                <p class="price" style="    visibility: hidden;              ">¥&nbsp;
                                                    <span class="num">${list.goodsInfoPrice?string('0.00')?substring(0,list.goodsInfoPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${list.goodsInfoPrice?string('0.00')?substring(list.goodsInfoPrice?string('0.00')?index_of('.'))}</span>
                                                    <span class="pro-num">×${list.goodsInfoNum}</span>
                                                </p>
                                                <p class="price">¥&nbsp;
                                                    <span class="num">${list.goodsInfoPrice?string('0.00')?substring(0,list.goodsInfoPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${list.goodsInfoPrice?string('0.00')?substring(list.goodsInfoPrice?string('0.00')?index_of('.'))}</span>
                                                    <span class="pro-num">×${list.goodsInfoNum}</span>
                                                </p>
                                            </#if>
                                        </div>
                                    </div>
                              </div>
                              </a>
	                	  <#else>
	                        <a title="${list.goodsInfoName!''}" href="javascript:void(0);">
	                        <div class="list-item" style="display:none">
			                    <div class="pro-item">
			                        <div class="propic">
			                            <img alt="" src="${list.goodsImg}" style="width:78px;height:78px;"/>
			                        </div>
			                        <div class="prodesc" id="prodesc_id">
			                            <h3 class="title"><#if list.isPresent?? && list.isPresent == '1'>
                                            <#--<span style="color: white;font-size: 12px;background-color: #81b119;">&nbsp;赠品&nbsp;</span>-->
                                            <img src="../../images/v2/gift@2x.png" width="28" height="16" style="vertical-align: middle;margin-bottom: 2px;">
                                        </#if> ${(list.goodsInfoName)!''}</h3>

			                            <#--<p class="price">¥&nbsp;<span class="num" style="display: initial">${(list.goodsInfoPrice)?string('0.00')}</span></p>
			                            <span class="pro-num" style="margin-top: -3rem;">×${list.goodsInfoNum}</span>-->
                                        <#if list.countRush?? && list.countRush?number != 0 && list.countRush?number lt list.goodsInfoNum?number>
                                            <p class="price">¥&nbsp;
                                                <span class="num">${list.goodsInfoOldPrice?string('0.00')?substring(0,list.goodsInfoOldPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${list.goodsInfoOldPrice?string('0.00')?substring(list.goodsInfoOldPrice?string('0.00')?index_of('.'))}</span>
                                                <span class="pro-num">×${list.goodsInfoNum?number - list.countRush?number}</span>
                                            </p>
                                            <p class="price">¥&nbsp;
                                                <span class="num">${list.goodsInfoPrice?string('0.00')?substring(0,list.goodsInfoPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${list.goodsInfoPrice?string('0.00')?substring(list.goodsInfoPrice?string('0.00')?index_of('.'))}</span>
                                                <span class="pro-num">×${list.countRush}</span>
                                            </p>

                                        <#else>
                                            <p class="price" style="    visibility: hidden;              ">¥&nbsp;
                                                <span class="num">${list.goodsInfoPrice?string('0.00')?substring(0,list.goodsInfoPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${list.goodsInfoPrice?string('0.00')?substring(list.goodsInfoPrice?string('0.00')?index_of('.'))}</span>
                                                <span class="pro-num">×${list.goodsInfoNum}</span>
                                            </p>
                                            <p class="price">¥&nbsp;
                                                <span class="num">${list.goodsInfoPrice?string('0.00')?substring(0,list.goodsInfoPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${list.goodsInfoPrice?string('0.00')?substring(list.goodsInfoPrice?string('0.00')?index_of('.'))}</span>
                                                <span class="pro-num">×${list.goodsInfoNum}</span>
                                            </p>
                                        </#if>
			                        </div>
			                    </div>
	                	  </div>
	                	  </a>
	                	 </#if>
                    </#list>
                </#if>
            </div>
            <#if (bOrder.orderGoodsList)?size gt 2>
	         <div class="list-item see-all">— 显示其他${bOrder.orderGoodsList?size-2}件商品 —</div>
     	 </#if>
        </div>
    </div>








    <#--<div class="mt10">-->
        <#--<div class="list-item">-->
            <#--<ul class="tep-strip">-->
               <#--<#if backOrderLogs??>-->
	             <#--<#list backOrderLogs as  backOrderLog>-->
	                <#--<#if backOrderLog.backLogStatus??>-->
	                    <#--<li>-->
	                    <#--<div class="body">-->
	                         <#--<span class="vertical-line"></span>-->
	                         <#--<span class="point"><b><i></i></b></span>-->
	                    <#--<#if backOrderLog.backLogStatus == '9'>-->
	                        <#--<h4>拒绝退款(操作：平台)<#if backOrderLog.backRemark?? && backOrderLog.backRemark !=''><#if backOrderLog.backRemark?length gt 3>留言：${backOrderLog.backRemark?substring(0,2)}...<#else >留言：${backOrderLog.backRemark}</#if></#if></h4>-->
	                    <#--</#if>-->
	                    <#--<#if backOrderLog.backLogStatus == '7' || backOrderLog.backLogStatus == '8'>-->
	                        <#--<h4>退款${backorder.backPrice!''}元成功 (操作：平台)<#if backOrderLog.backRemark?? && backOrderLog.backRemark !=''><#if backOrderLog.backRemark?length gt 3>留言：${backOrderLog.backRemark?substring(0,2)}...<#else >留言：${backOrderLog.backRemark}</#if></#if></h4>-->
	                    <#--</#if>-->
	                    <#--<#if backOrderLog.backLogStatus == '6'>-->
	                        <#--<h4>收货失败 (操作：平台)<#if backOrderLog.backRemark?? && backOrderLog.backRemark !=''><#if backOrderLog.backRemark?length gt 3>留言：${backOrderLog.backRemark?substring(0,2)}...<#else >留言：${backOrderLog.backRemark}</#if></#if></h4>-->
	                    <#--</#if>-->
	                    <#--<#if backOrderLog.backLogStatus == '5'>-->
	                        <#--<h4>确认收货(操作：平台)<#if backOrderLog.backRemark?? && backOrderLog.backRemark !=''><#if backOrderLog.backRemark?length gt 3>留言：${backOrderLog.backRemark?substring(0,2)}...<#else >留言：${backOrderLog.backRemark}</#if></#if></h4>-->
	                    <#--</#if>-->
	                    <#--<#if backOrderLog.backLogStatus == '4'>-->
	                        <#--<h4>填写快递信息(操作：顾客)<#if backOrderLog.backRemark?? && backOrderLog.backRemark !=''><#if backOrderLog.backRemark?length gt 3>留言：${backOrderLog.backRemark?substring(0,2)}...<#else >留言：${backOrderLog.backRemark}</#if></#if></h4>-->
	                    <#--</#if>-->
	                    <#--<#if backOrderLog.backLogStatus == '3'>-->
	                        <#--<h4>申请审核不通过(操作：平台)<#if backOrderLog.backRemark?? && backOrderLog.backRemark !=''><#if backOrderLog.backRemark?length gt 3>留言：${backOrderLog.backRemark?substring(0,2)}...<#else >留言：${backOrderLog.backRemark}</#if></#if></h4>-->
	                    <#--</#if>-->
	                    <#--<#if backOrderLog.backLogStatus == '2'>-->
	                        <#--<h4>申请审核通过(操作：平台)<#if backOrderLog.backRemark?? && backOrderLog.backRemark !=''><#if backOrderLog.backRemark?length gt 3>留言：${backOrderLog.backRemark?substring(0,2)}...<#else >留言：${backOrderLog.backRemark}</#if></#if></h4>-->
	                    <#--</#if>-->
	                    <#--<#if backOrderLog.backLogStatus == '1'>-->
	                        <#--<h4>申请退单审核(操作：顾客)<#if backOrderLog.backRemark?? && backOrderLog.backRemark !=''><#if backOrderLog.backRemark?length gt 3>留言：${backOrderLog.backRemark?substring(0,2)}...<#else >留言：${backOrderLog.backRemark}</#if></#if></h4>-->
	                    <#--</#if>-->
	                        <#--<p>${backOrderLog.backLogTime?string("yyyy-MM-dd HH:mm:ss")}</p>-->
	                    <#--</div>-->
	                   <#--</li>-->
	                <#--</#if>-->
	            <#--</#list>-->
	           <#--</#if>-->
            <#--</ul>-->
        <#--</div>-->
    <#--</div>-->



    <div class="all-info mt10">
        <div class="list-item" style="padding: 0!important;">
            <ul class="price-total">
                <li style="background: #fff;"><label for="">退款金额</label><b class="showmore hide"  onclick="showmoreinfo()"></b><span class="value text-them" style="margin-right:0;">￥ ${(bOrder.backPrice)?string('0.00')}</span></li>
               <#-- <#if bOrder.backCheck=='4'>
                <#if backorder.backPrice??>
                    <li><label for="">实退金额</label><span class="value text-them">￥ ${(backorder.backPrice)?string('0.00')}</span></li>
                </#if>
                </#if>-->
                <li class="more_info"><label for=""><#if bOrder.isBack=='1'>退货原因<#else>退款原因</#if></label>
                	<span class="value">
                	 <#if bOrder.backReason??>
                        <#if bOrder.backReason=='1'>
                            不想买了
                         <#elseif bOrder.backReason=='2'>
                             收货信息有误
                        <#elseif bOrder.backReason=='3'>
                            商品未按时发货
                        <#elseif bOrder.backReason=='4'>
                            其他
                        <#elseif bOrder.backReason=='5'>
                            商品质量问题
                        <#elseif bOrder.backReason=='6'>
                            收到商品与描述不符
                        </#if>
                    </#if>
                	</span>
                </li>
                <li class="more_info"><label for="">问题说明</label><span class="value" style=" max-width: 75%;;text-align: right">${(bOrder.backRemark)!''}</span></li>
                <#if bOrder.isBack=='1'>
                <li class="more_info"><label for="">返回方式</label><span class="value"><#--快递-->上门取件</span></li>
                <#--<li><label for="">申请凭据</label>-->
	                <#--<span class="value">-->
	                 <#--<#if bOrder.applyCredentials??>-->
                        <#--<#if bOrder.applyCredentials=='3'>-->
                           	 <#--没有任何凭证-->
                        <#--<#elseif bOrder.applyCredentials=='1'>-->
                            	<#--有发票-->
                        <#--<#elseif bOrder.applyCredentials=='2'>-->
                            	<#--有质检报告-->
                        <#--<#else>-->
                            	<#--有发票、有质检报告-->
                        <#--</#if>-->
                    <#--</#if>-->
	                <#--</span>-->
                <#--</li>-->
             </#if>
                <#--<li>-->
                    <#--<label for="">物流公司</label>-->
                    <#--<span class="value" style="text-indent:2em">-->
                        <#--<#if general??>-->
                            <#--<#if general.ogisticsName??>-->
                            <#--${general.ogisticsName!''}-->
                            <#--<#else>-->
                                <#--无-->
                            <#--</#if>-->
                        <#--<#else>-->
                            <#--无-->
                        <#--</#if>-->
                    <#--</span>-->
                <#--</li>-->
                <#--<li>-->
                    <#--<label for="">物流单号</label>-->
                    <#--<span class="value" style="text-indent:2em">-->
                        <#--<#if general??>-->
                            <#--<#if general.ogisticsNo??>-->
                            <#--${general.ogisticsNo}-->
                            <#--<#else>-->
                                <#--无-->
                            <#--</#if>-->
                        <#--<#else>-->
                            <#--无-->
                        <#--</#if>-->
                    <#--</span>-->
                <#--</li>-->
            </ul>
        </div>
    </div>



















    <#if backOrderLogs??>
	    <div class="mt10">
	        <div class="list-item seller">
	            <h3 class="item-head">卖家留言</h3>
	            <ul class="message">
	                <#assign notice = 0>
		             <#list backOrderLogs as  backOrderLog>
		                <#if (backOrderLog.backRemark)?? && backOrderLog.backRemark !=''>
	                <#assign notice = 1>
		                <li style="margin-top: 10px; font-size:13px;color: #666;">
                            ${(backOrderLog.backRemark)!''}
		                    <p class="time">${backOrderLog.backLogTime?string("yyyy-MM-dd")}</p>
		                </li>
		                </#if>
	                </#list>
	                <#if notice ==0>
	                   <li style="margin:5px 0 12px 0;text-align:center;color: #f7f7f7;font-size:13px">暂无留言<li>
	               </#if>
	            </ul>
	        </div>
	    </div>
    </#if>
    <#assign showflag =0 />
<#if imglist?? && imglist?size gt 0>
    <#list imglist as imgs>
        <#if imgs?? && imgs !=''>
            <#assign showflag =1 />
        </#if>
    </#list>
</#if>
<#--<#if showflag==1>-->
<#--<div class="mt10">-->
    <#--<div class="list-item">-->
        <#--<div class="recommend-list">-->
              <#--<ul>-->
                <#--<#list imglist as imgs>-->
                    <#--<#if imgs?? && imgs !=''>-->
                    <#--<li><img src="${imgs}" alt="" style="width:70px;height:70px;"/></li>-->
                    <#--</#if>-->
                <#--</#list>-->
                <#--</ul>-->
        <#--</div>-->
    <#--</div>-->
<#--</div>-->
<#--</#if>-->
    <!-- <div class="cancel">
         <div class="list-item">
             <a class="btn btn-full" href="javascript:;"><i></i>取消申请</a>
         </div>
     </div>-->
</div>
</body>
<script>
    $(function(){
        $('.recommend-list ul').width($('.recommend-list ul li').width()*$('.recommend-list ul li').length+($('.recommend-list ul li').length-1)*10);
      /* 显示隐藏的商品 */
            $('.see-all').click(function(){
                $(this).prev('.list-body-line').find('.list-item').show();
                $(this).remove();
            });
    });

    //判断是退款还是退货
    var backhref = window.location.pathname.split("/")[2];
    if(backhref.indexOf("backordergoodsdetail")!=-1){
        //退货
        $(".back_order_title .th").show();
        $(".vheader span").html("退货详情");
        document.title="退货详情"
    }else{
        //退款
        $(".back_order_title .tk").show();
        $(".vheader span").html("退款详情");
        document.title="退款详情"
    }
    //退货退款进度
    $(".back_order_title .status li:last-of-type").addClass("active");
    $(".back_order_title .status li:last-of-type .diagram p:last-of-type").addClass("active");

    //退款金额展开收起
    function showmoreinfo(){
        $(".price-total .more_info").toggle("fast");
        var backstaus=$(".price-total .showmore.hide").hasClass("hide");
        if(backstaus){
            $(".price-total .showmore").removeClass("hide").addClass("show")
        }else{
            $(".price-total .showmore").removeClass("show").addClass("hide")
        }

    }

</script>
</html>