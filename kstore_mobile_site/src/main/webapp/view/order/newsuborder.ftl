<!DOCTYPE html>
<html lang="zh-cn" xmlns:c="http://www.w3.org/1999/html">
<#assign basePath=request.contextPath>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>确认订单</title>
<link rel="stylesheet" href="${basePath}/css/style.min.css"/>
<link rel="stylesheet" href="${basePath}/css/add-ons.min.css"/>
<link rel="stylesheet" href="${basePath}/css/ui-dialog.css"/>
<link rel="stylesheet" href="${basePath}/css/tip-newbox.css"/>
<link rel="stylesheet" href="${basePath}/css/mobiscroll.custom-2.6.2.min.css"/>
<link rel="stylesheet" href="${basePath}/css/v3/newsuborder.css"/>
<script src="${basePath}/js/jquery-1.10.1.js"></script>
<script type="text/javascript" src="${basePath}/js/mobiscroll.custom-2.6.2.min.js"></script>
</head>
<body>


<#assign vtitle="确认订单" />
<#assign backUrl="${basePath}/myshoppingmcart.html" />
<#include "/common/head_back.ftl"/>
<!--计算总商品数量-->
<#assign num=0>
<!--计算boss商品数量-->
<#assign bossNum=0>
<!--记录第三方商品数量-->
<#assign thirdNum=0>
<!--计算优惠金额-->
<#assign  youhui=map.youhui/>
<#assign bossyouhui=map.bossyouhui/>

<#assign choseDeliveryPoint=deliveryMap?? && deliveryMap.choseDeliveryPoint??/>
<#assign deliveries=deliveryMap?? && deliveryMap.deliveries??&&deliveryMap.deliveries?size!=0/>

<!--计算goods商品数量-->
<#assign goodsCount=0>
<!--计算goods商品sum-->
<#assign goodsWeight=0>

<form  method="post" id="subForm" action="${basePath}/newsubmitorder.htm">
    <!--支付方式 1在线支付 2 货到付款-->
    <input type="hidden"name="ch_pay" id="chPay"/>

    <#if choseDeliveryPoint><!-- 不为空的时候上门自提 -->
    <input type="hidden" name="typeId" value="1" id="typeId">
    <#else><!-- 其他配送方式 -->
    <input type="hidden" name="typeId" value="0" id="typeId">
</#if>

<#if coupon??>
    <input type="hidden" name="codeNo" value="${coupon.codeNo}">
</#if>
    <input type="hidden" value="${invoiceType!'0'}" name="invoiceType" id="invoiceType">
    <input type="hidden" value="${invoiceTitle!''}" name="invoiceTitle" id="invoiceTitle">
    <input type="hidden" name="taxpayerNumber" value="${taxpayerNumber!''}">

<#--<input type="hidden"name="addressId" value="${orderAddress.addressId!''}" id="addressId"/>-->
    <input id="sumOldPrice" type="hidden" value="${map.sumOldPrice!''}"/>
    <input id="sumPrice" type="hidden" value="${map.sumPrice!''}"/>
    <input id="zhek"  type="hidden" value="${map.zheKPrice}"/>
    <input id="fPrice"  type="hidden" value="${map.fPrice.freightmoney}"/>
    <input id="jfen" type="hidden" value="${map.customerPoint}"/>
    <input id="pointSet" type="hidden" value="${map.pointSet}"/>
    <input id="isOpen" type="hidden" value="${map.isOpen!''}"/>
    <input type="hidden"name="payPassword" id="subPassword"/>
    <input type="hidden" id="stockFlag" value="${stockFlag?string("1","0")}">
    <input name="deliveryPointId" type="hidden" id="deliveryPointId" value="31"/>
    <!--商品优惠价格-->
<#assign preprice=0>
<#--礼品电子卡-->
<#assign dianziCard=0>
<#assign lingshouCount=0>
<#--全部商品的数量-->
<#assign totalCount=0>
<#if map.shoplist??&&map.shoplist?size!=0>
    <#assign totalCount=map.shoplist?size>
</#if>
<#list map.shoplist as cart>
    <#assign bossNum=bossNum+1>
    <#if cart.fitId??>
        <#list cart.goodsGroupVo.productList as pro>
            <#assign vo=pro.productDetail>
            <#if cars.goodsDetailBean.productVo.productName??&&cars.goodsDetailBean.productVo.productName?index_of("电子卡")!=-1><#assign dianziCard=dianziCard+1></#if>
            <#if cart.goodsDetailBean.productVo.productName?index_of("零售")!=-1><#assign lingshouCount=lingshouCount+1></#if>
        </#list>
    <#elseif !cart.fitId??>
        <#if cart.goodsDetailBean.productVo.productName??&&cart.goodsDetailBean.productVo.productName?index_of("电子卡")!=-1><#assign dianziCard=dianziCard+1></#if>
        <#if cart.goodsDetailBean.productVo.productName?index_of("零售")!=-1><#assign lingshouCount=lingshouCount+1></#if>
    </#if>

    <#if cart.presentGoodsProducts??>
        <#list cart.presentGoodsProducts as presentGoodsProduct>
            <#if presentGoodsProduct.goodsInfoName?index_of("零售")!=-1><#assign lingshouCount=lingshouCount+1></#if>
            <#assign totalCount=totalCount+1>
            <#assign bossNum=bossNum+1>
        </#list>
    </#if>
</#list>
    <input  id="totalCount" type="hidden" value="${totalCount}" />
    <input type="hidden" id="dianziCard" name="dianziCard" value="${dianziCard}"/>
    <#--[debug]bossNum=${bossNum}
    [debug]lingshouCount=${lingshouCount}-->
    <div class="order content-order-confirm">

<#if (totalCount != dianziCard)>
        <div class="receive-info" style="height: auto;">
        <#if orderAddress??&&orderAddress.addressId??>

            <div class="list-item" style="    padding:15px 0 2px 0;">
                <#--<a href="${basePath}/addresslist.htm?flag=1&addressType=${(lingshouCount/bossNum)?string("0")}">-->

                    <#if lingshouCount<1 || lingshouCount lt bossNum >
                        <a href="${basePath}/addresslist.htm?flag=1&addressType=0" onclick="_czc.push(['_trackEvent', '购物车', '确认订单', '收货地址','0','suborder_addr']);">
                        <#--批发--普通地址-->
                        <#if orderAddress.addressType=='0'>
                            <input type="hidden"name="addressId" value="${orderAddress.addressId!''}" id="addressId"/>
                            <h3 style="padding: 0 15px 5px 15px;">
                                <span class="name" >${(orderAddress.addressName)!""}收</span>
                                <span class="phoneNum" >${(orderAddress.addressPhone)!""}</span>
                            </h3>
                            <p class="dress-info" style="padding: 0px 15px 13px 15px;">${(orderAddress.addressDetail)!""}&nbsp;
                            ${(orderAddress.addressDetailInfo)!""}</p>
                            <#if map.isware?? && map.isware=='0'>
                                <span style="color: #ff3b2f;padding: .4em 15px .4em 15px;">您当前所选的收货地址暂时无货！</span>
                            <#elseif map.repertory?? && map.repertory=='0'>
                                <span style="color: #ff3b2f;padding: .4em 15px .4em 15px;">您当前所选的收货地址暂时无货！</span>
                            </#if>
                        <#else>
                            <p style="padding:5px 10px;text-align: center;font-size:1.1em;height:60px;line-height:50px;    margin-bottom: 13px;">
                                <span>请选择收货地址</span>
                            </p>
                        </#if>
                    <#else>
                        <a href="${basePath}/addresslist.htm?flag=1&addressType=1" onclick="_czc.push(['_trackEvent', '购物车', '确认订单', '收货地址','0','suborder_addr']);">
                        <#--零售-- 社区店地址-->
                        <#if orderAddress.addressType=='1'>
                            <input type="hidden"name="addressId" value="${orderAddress.addressId!''}" id="addressId"/>
                            <h3 style="padding: 0px 15px 0 15px;">
                                <span class="name">${(orderAddress.addressName)!""}收</span>
                                <span class="phoneNum">${(orderAddress.addressPhone)!""}</span>
                            </h3>
                            <p class="dress-info" style="padding: 0px 15px 0 15px;line-height: 16px;margin:5px 0 15px 0;color: #000;font-size: 14px;">${(orderAddress.addressDetail)!""}
                            ${(orderAddress.addressDetailInfo)!""}</p>
                           <#-- <p class="dress-info" style="color: #50c896;">社区店联系人及地址：</p>-->
                            <div style="background: #f7f7f7;padding: 15px;line-height: 0;">
                            <p class="dress-info dress-infoafter" style="    margin-bottom: 10px;display: inline-block;height: 18px;line-height: 18px;  font-weight: bold;  font-size: 12px!important;">${communityStore.communityStoreName}</p>

                                <p class="dress-info dress-point">
                                ${communityStore.province.provinceName}&nbsp;${communityStore.city.cityName}&nbsp;${communityStore.district.districtName}&nbsp;${communityStore.communityStoreAddress!''}</p>
                            <p class="dress-info dress-point">${(communityStore.contact)!""}&nbsp;${(communityStore.contactMobile)!""}</p>

                            </div>
                           <#-- <#if stockFlag?? && !stockFlag>
                                <span style="color: red;">您的当前收货地址与仓库所在区域不一致！</span>
                            </#if>-->
                            <#if map.isware?? && map.isware=='0'>
                                <span style="color: #ff3b2f;padding: .4em 15px .4em 15px;">您当前所选的收货地址暂时无货！</span>
                            <#elseif map.repertory?? && map.repertory=='0'>
                                <span style="color: #ff3b2f;padding: .4em 15px .4em 15px;">您当前所选的收货地址暂时无货！</span>
                            </#if>
                        <#else>
                            <p style="padding:5px 10px;text-align: center;font-size:1.1em;height:40px;line-height: 30px;  margin-bottom: 13px;">
                                <span>请选择收货地址</span>
                            </p>
                        </#if>
                    </#if>
                <#--   <i class="arrow-right"></i>-->
                </a>

            <#--<#if (lingshouCount>=1 && lingshouCount==bossNum)>
                <div class="order-tage"><span><img src="/images/v1/img/tage.png"> 为何需要添加社区店地址？</span></div>
            </#if>-->
            </div>
        <#else>
            <div class="list-item" style="    padding:15px 0 .8em 0;">
                <a href="${basePath}/addresslist.htm?flag=1&addressType=${(lingshouCount/bossNum)?string("0")}" onclick="_czc.push(['_trackEvent', '购物车', '确认订单', '收货地址','0','suborder_addr']);">
                    <p style="padding:5px 10px;text-align: center;font-size:1.1em;height:40px;line-height: 30px;  margin-bottom: 13px;">
                        <#--<i class="ion-plus-round"></i>-->
                        <span>请选择收货地址</span>
                    </p>
                </a>
            </div>
        </#if>
        </div>
</#if>
    <#if bossNum!=0>
        <div class="order-info mt10">

            <#if (lingshouCount>0) && (lingshouCount==totalCount)>
            <div class="list-item">
                <div class="send-way">

                <#-- <h3 class="item-head" >收货方式</h3>-->
                    <li id="sex">
                        <i class="arrow-right"></i>
                        <div class="mbase-menu-title item-head">收货方式  <div class="mbase-menu-txt" style="display: inline-block;float: right;">
                        <#if map.frightlist??&&map.frightlist?size!=0>
                            <#list map.frightlist as  fr>
                                <#if fr_index == 0>
                                    ${fr.freightTemplateName!''}
                                </#if>
                            </#list>
                        </#if>
                        </div></div>
                        <div class="clear"></div>
                    </li>
                    <ul id="sex-list" style="display: none">
                            <#if map.frightlist??&&map.frightlist?size!=0>
                                <#list map.frightlist as  fr>
                                    <li>${fr.freightTemplateName!''}</li>
                                </#list>
                            </#if>
                            <li class="ziti">社区店自提</li>
                    </ul>
                <#--   <div class="list-value list_down" style="display: none;">
                       <#if map.frightlist??&&map.frightlist?size!=0>

                           <#list map.frightlist as  fr>
                               <#if fr.freightThirdId==0>
                                   <a class="btn-grey selected" href="javascript:;">${fr.freightTemplateName!''}</a>
                               </#if>
                           </#list>
                           <#list map.frightlist as  fr>
                               <#if fr.freightThirdId==0>
                                   <a class="btn-grey selected" href="javascript:;">${fr.freightTemplateName!''}</a>
                               </#if>
                           </#list>
                       </#if>
                   &lt;#&ndash;只有全部商品为零售才显示社区店自提&ndash;&gt;
                       <#if (lingshouCount>=1 && lingshouCount==bossNum)>
                           <!-- 将条件放入 &ndash;&gt;
                       &lt;#&ndash;<#if deliveries||choseDeliveryPoint>
                           <#if choseDeliveryPoint>
                               <a class="btn-grey selected" href="javascript:;" id="selfPick">
                                   社区店自提
                               </a>
                           <#else>&ndash;&gt;
                           <a class="btn-grey" href="javascript:;" id="selfPick">
                               社区店自提
                           </a>
                       &lt;#&ndash;</#if>
                   </#if>&ndash;&gt;
                       </#if>
                   </div>-->

                </div>
            </div>
            </#if>
            <input type="hidden" value="${dianziCard}" id="dianziCard" />
            <#--电子邮箱-->
            <#if (dianziCard > 0)>
            <div class="list-item" style="position: relative;border-top: 10px solid #f7f7f7;">
                 <#--   <i class="arrow-right"></i>-->
                    <h3 class="item-head">电子邮箱<input onkeyup="way();"  class="curValue text-them text input-email" type="text" name="giftcardEmail" style="width: 80%; border: none;font-size: 1em;color: #999999;" placeholder="必填，用于接收电子礼品卡">
                    <img class="empty_value"  style="  width: 1.3em;height: 1.3em;position: absolute;right: 1em; top: .9em; display: none;"src="/images/v1/myimages/btn_xiaochacha.png">
                    </h3>
            </div>
            <#--!-->
            </#if>
            <div class="list-body-line" style="border-top: 10px solid #f7f7f7">

                <#assign bnum=0/>
                <#list map.shoplist as cart>
                <#--[debug]cart=${cart}-->
                    <#assign bnum=bnum?number+1 />
                    <#if bnum==1>
                    <#--<div class="profrom-way">-->
                    <#--<span class="some-tip">自营商品</span>-->
                    <#--</div>-->
                    </#if>
                    <#if cart.goodsDetailBean??&&cart.goodsDetailBean.productVo??&&cart.goodsDetailBean.productVo.thirdId?? &&cart.goodsDetailBean.productVo.thirdId==0>

                        <div class="list-item confirm-pro-item" style="border-top: none; border-bottom: none;padding: 10px 0 0 15px;"   <#if (bnum?number>3)>style="display:none" </#if>>

                            <#assign goodsCount=goodsCount+cart.goodsNum />
                            <#assign goodsWeight=goodsWeight+(cart.goodsNum * cart.goodsDetailBean.productVo.goodsInfoWeight) />
                            <a target="_blank" title="${cart.goodsDetailBean.productVo.productName}">
                                <div class="pro-item" >
                                    <div class="propic">
                                        <input type="hidden" value="${cart.shoppingCartId}" name="shoppingCartId">
                                        <img src="${cart.goodsDetailBean.productVo.goodsInfoImgId}" alt="产品图">
                                    </div>


                                             <div class="prodesc" >


                                        <h3 class="title" style="    padding-right: 15px;"> ${cart.goodsDetailBean.productVo.productName!''}</h3>

                                        <#--<p class="price" style="margin-top: 5px;    height: 16px;">-->
                                            <#--<span class="num">¥&nbsp;${cart.goodsDetailBean.productVo.goodsInfoPreferPrice?string("0.")}</span>-->
                                            <#--<#list cart.goodsDetailBean.productVo.goodsInfoPreferPrice?string('0.00')?split(".") as price>-->
                                                <#--<#if price_index==1>-->
                                                    <#--<span style="color: #333333;margin-left: -3px;font-size:.8572em;">${price}</span>-->
                                                <#--</#if>-->
                                            <#--</#list>-->
                                            <#--<span class="pro-num2" style="    padding-right: 15px;">×${cart.goodsNum!''}-->
                                            <#--</span>-->
                                        <#--</p>-->


                                        <#--<p class="price" style="">¥&nbsp;<span class="num">${cart.goodsDetailBean.productVo.goodsInfoPreferPrice?string("0.")}</span>
                                            <#list cart.goodsDetailBean.productVo.goodsInfoPreferPrice?string('0.00')?split(".") as price>
                                                <#if price_index==1>
                                                    <span style="color: #333333;margin-left: -3px;font-size:.8572em;">${price}</span>
                                                </#if>
                                            </#list>
                                            <span class="pro-num1" style="    padding-right: 15px;">×${cart.goodsNum!''}</span>
                                        </p>
                                        <p class="price" style="">¥&nbsp;<span class="num">${cart.goodsDetailBean.productVo.goodsInfoPreferPrice?string("0.")}</span>
                                            <#list cart.goodsDetailBean.productVo.goodsInfoPreferPrice?string('0.00')?split(".") as price>
                                                <#if price_index==1>
                                                    <span style="color: #333333;margin-left: -3px;font-size:.8572em;">${price}</span>
                                                </#if>
                                            </#list>
                                            <span class="pro-num1" style="    padding-right: 15px;">×${cart.goodsNum!''}</span>

                                            <span style="font-size: .9rem;    float: right;margin-right: 15px;">¥&nbsp;<span class="num">${(cart.goodsDetailBean.productVo.goodsInfoPreferPrice * cart.goodsNum)?string("0.")}</span>
                                                <#list (cart.goodsDetailBean.productVo.goodsInfoPreferPrice * cart.goodsNum)?string('0.00')?split(".") as price>
                                                    <#if price_index==1>
                                                        <span style="color: #333333;margin-left: -3px;font-size:.8572em;">${price}</span>
                                                    </#if>
                                                </#list>
                                            </span>
                                        </p>-->




                                        <#assign flag=1>
                                        <#if cart.marketingList??&&cart.marketingList?size!=0>

                                            <#list cart.marketingList as mar>
                                                <#if cart.marketingActivityId??&&mar.marketingId==cart.marketingActivityId>
                                                    <#assign flag=2>
                                                    <#--折扣-->
                                                    <#if mar.codexType=='15'>
                                                        <#if mar.preDiscountMarketings?? && mar.preDiscountMarketings?size gt 0>
                                                            <#list mar.preDiscountMarketings as preDiscountMarketing>
                                                                <#if preDiscountMarketing.goodsId == cart.goodsDetailBean.productVo.goodsInfoId>
                                                                    <#assign price = "${(cart.goodsDetailBean.productVo.goodsInfoPreferPrice?number*preDiscountMarketing.discountInfo?number)}">
                                                                    <p class="price" style="margin-top: 5px;    height: 16px;"></p>
                                                                    <p class="price" style=""><span>¥</span>&nbsp;<span class="num">${price?number?string("0.00")?substring(0,price?number?string("0.00")?index_of("."))}</span>
                                                                        <span style="color: #333333;">${price?number?string("0.00")?substring(price?number?string("0.00")?index_of("."))}</span>
                                                                        <span class="pro-num1" style="    padding-right: 15px;">×${cart.goodsNum!''}</span>
                                                                        <span style="font-size: .288rem;    float: right;margin-right: 15px;"><span>¥</span>&nbsp;<span class="num">${(price?number*cart.goodsNum)?string("0.00")?substring(0,(price?number*cart.goodsNum)?string("0.00")?index_of("."))}</span>
                                                                        <span style="color: #333333;">${(price?number*cart.goodsNum)?string("0.00")?substring((price?number*cart.goodsNum)?string("0.00")?index_of("."))}</span>
                                                                        </span>
                                                                    </p>
                                                                </#if>
                                                            </#list>
                                                        </#if>
                                                    </#if>

                                                    <!--直降-->
                                                   <#if mar.codexType=='1'>
                                                       <#--直降${mar.priceOffMarketing.offValue}
                                                        元-->
                                                       <#assign price = "${cart.goodsDetailBean.productVo.goodsInfoPreferPrice-mar.priceOffMarketing.offValue}">
                                                       <p class="price" style="margin-top: 5px;    height: 16px;"></p>

                                                       <p class="price" style=""><span>¥</span>&nbsp;<span class="num">${price?number?string('0.00')?substring(0,price?number?string('0.00')?index_of("."))}</span>
                                                            <span style="color: #333333;">${price?number?string('0.00')?substring(price?number?string("0.00")?index_of("."))}</span>
                                                            <span class="pro-num1" style="    padding-right: 15px;">×${cart.goodsNum!''}</span>
                                                            <span style="font-size: .288rem;    float: right;margin-right: 15px;"><span>¥</span>&nbsp;<span class="num">${(price?number*cart.goodsNum)?string("0.00")?substring(0,(price?number*cart.goodsNum)?string("0.00")?index_of("."))}</span>
                                                                <span style="color: #333333;">${(price?number*cart.goodsNum)?string("0.00")?substring((price?number*cart.goodsNum)?string("0.00")?index_of("."))}</span>
                                                            </span>
                                                        </p>
                                                        <#--<p class="some-info">-->
                                                        <#--<span style="display: initial;">-->
                                                        <#--${mar.marketingName}-->
                                                        <#--</span>-->
                                                        <#--</p>-->
                                                    </#if>
                                                    <!--满减-->
                                                    <#if mar.codexType=='5'>
                                                        <#--<#list mar.fullbuyReduceMarketings as fr>
                                                            满 ${fr.fullPrice}
                                                            减${fr.reducePrice}元 &nbsp;
                                                        </#list>-->
                                                        <#assign price = "${cart.goodsDetailBean.productVo.goodsInfoPreferPrice?number}">
                                                        <p class="price" style="margin-top: 5px;    height: 16px;"></p>

                                                        <p class="price" style=""><span>¥</span>&nbsp;<span class="num">${price?number?string("0.00")?substring(0,price?number?string("0.00")?index_of('.'))}</span>
                                                                    <span style="color: #333333;">${price?number?string("0.00")?substring(price?number?string("0.00")?index_of('.'))}</span>
                                                                    <span class="pro-num1" style="    padding-right: 15px;">×${cart.goodsNum!''}</span>
                                                            <span style="font-size: .288rem;    float: right;margin-right: 15px;"><span>¥</span>&nbsp;<span class="num">${(price?number*cart.goodsNum)?string('0.00')?substring(0,(price?number*cart.goodsNum)?string('0.00')?index_of('.'))}</span>
                                                                    <span style="color: #333333;">${(price?number*cart.goodsNum)?string('0.00')?substring((price?number*cart.goodsNum)?string('0.00')?index_of('.'))}</span>
                                                            </span>
                                                        </p>
                                                        <#--<p class="some-info">-->
                                                        <#--<span style="display: initial;">-->
                                                        <#--${mar.marketingName}-->
                                                        <#--</span>-->
                                                        <#--</p>-->
                                                    </#if>
                                                    <!--满折-->
                                                    <#if mar.codexType=='8'>
                                                       <#--<#list mar.fullbuyDiscountMarketings as mz>
                                                            满 ${mz.fullPrice}
                                                            打 ${mz.fullbuyDiscount*10}折
                                                                    &nbsp;
                                                        </#list>-->
                                                        <p class="price" style="margin-top: 5px;    height: 16px;"></p>

                                                        <#assign price = "${cart.goodsDetailBean.productVo.goodsInfoPreferPrice?number}">
                                                        <p class="price" style=""><span>¥</span>&nbsp;<span class="num">${price?number?string("0.00")?substring(0,price?number?string("0.00")?index_of('.'))}</span>
                                                            <span style="color: #333333;">${price?number?string("0.00")?substring(price?number?string("0.00")?index_of('.'))}</span>
                                                            <span class="pro-num1" style="    padding-right: 15px;">×${cart.goodsNum!''}</span>
                                                            <span style="font-size: .288rem;    float: right;margin-right: 15px;"><span>¥</span>&nbsp;<span class="num">${(price?number*cart.goodsNum)?string('0.00')?substring(0,(price?number*cart.goodsNum)?string('0.00')?index_of('.'))}</span>
                                                                    <span style="color: #333333;">${(price?number*cart.goodsNum)?string('0.00')?substring((price?number*cart.goodsNum)?string('0.00')?index_of('.'))}</span>
                                                            </span>
                                                        </p>
                                                        <#--<p class="some-info">-->
                                                        <#--<span style="display: initial;">-->
                                                        <#--${mar.marketingName}-->
                                                        <#--</span>-->
                                                        <#--</p>-->
                                                    </#if>
                                                    <#--团购-->
                                                    <#if mar.codexType=='10'>
                                                         <#--${mar.groupon.grouponDiscount}折团购-->
                                                        <p class="price" style="margin-top: 5px;    height: 16px;"></p>

                                                        <#assign price = "${cart.goodsDetailBean.productVo.goodsInfoPreferPrice?number*mar.groupon.grouponDiscount?number}">
                                                        <p class="price" style=""><span>¥</span>&nbsp;<span class="num">${price?number?string('0.00')?substring(0,price?number?string('0.00')?index_of('.'))}</span>
                                                            <span style="color: #333333;">${price?number?string("0.00")?substring(price?number?string('0.00')?index_of('.'))}</span>
                                                            <span class="pro-num1" style="    padding-right: 15px;">×${cart.goodsNum!''}</span>
                                                            <span style="font-size: .288rem;    float: right;margin-right: 15px;"><span>¥</span>&nbsp;<span class="num">${(price?number*cart.goodsNum)?string('0.00')?substring(0,(price?number*cart.goodsNum)?string('0.00')?index_of('.'))}</span>
                                                                        <span style="color: #333333;">${(price?number*cart.goodsNum)?string('0.00')?substring((price?number*cart.goodsNum)?string('0.00')?index_of('.'))}</span>
                                                            </span>
                                                        </p>
                                                        <#--<p class="some-info">-->
                                                        <#--<span style="display: initial;">-->
                                                        <#--${mar.marketingName}-->
                                                        <#--</span>-->
                                                        <#--</p>-->
                                                    </#if>
                                                    <#--抢购-->
                                                    <#if mar.codexType=='11'><input id="purchase" type="hidden" value="1"><#--value为1抢购商品--></#if>
                                                    <#if mar.codexType=='11'&& mar.customerbuynum !=0>

                                                    <#--${(mar.rushs[0].rushDiscount*10)?string('0.#')}折抢购  setCustomerbuynum-->
                                                          <#assign price = "${cart.goodsDetailBean.productVo.goodsInfoPreferPrice?number}">
                                                          <#assign rushPrice = "${cart.goodsDetailBean.productVo.goodsInfoPreferPrice?number*mar.rushs[0].rushDiscount?number}">
                                                         <#if mar.customerbuynum?? &&  cart.goodsNum gt mar.customerbuynum >

                                                             <p class="price" style=""><span>¥</span>&nbsp;<span class="num">${price?number?string('0.00')?substring(0,price?number?string('0.00')?index_of('.'))}</span>
                                                                         <span style="color: #333333;">${price?number?string('0.00')?substring(price?number?string('0.00')?index_of('.'))}</span>
                                                                 <span class="pro-num1" style="    padding-right: 15px;">×${cart.goodsNum?number-mar.customerbuynum?number}</span>
                                                             </p>

                                                             <p class="price" style=""><span>¥</span>&nbsp;<span class="num">${rushPrice?number?string('0.00')?substring(0,rushPrice?number?string('0.00')?index_of('.'))}</span>
                                                                 <span style="color: #333333;">${rushPrice?number?string('0.00')?substring(rushPrice?number?string('0.00')?index_of('.'))}</span>
                                                                 <span class="pro-num1" style="    padding-right: 15px;">×${mar.customerbuynum}</span>
                                                                 <span style="font-size: .288rem;    float: right;margin-right: 15px;"><span>¥</span>&nbsp;<span class="num">${(price?number*(cart.goodsNum?number-mar.customerbuynum?number)+rushPrice?number*mar.customerbuynum?number)?string("0.00")?substring(0,(price?number*(cart.goodsNum?number-mar.customerbuynum?number)+rushPrice?number*mar.customerbuynum?number)?string("0.00")?index_of('.'))}</span>
                                                                     <span style="color: #333333;">${(price?number*(cart.goodsNum?number-mar.customerbuynum?number)+rushPrice?number*mar.customerbuynum?number)?string("0.00")?substring((price?number*(cart.goodsNum?number-mar.customerbuynum?number)+rushPrice?number*mar.customerbuynum?number)?string("0.00")?index_of('.'))}</span>
                                                                 </span>
                                                             </p>
                                                         <#else>
                                                             <p class="price" style="margin-top: 5px;    height: 16px;"></p>

                                                             <p class="price" style=""><span>¥</span>&nbsp;<span class="num">${rushPrice?number?string('0.00')?substring(0,rushPrice?number?string('0.00')?index_of('.'))}</span>

                                                                 <span style="color: #333333;">
                                                                    ${rushPrice?number?string('0.00')?substring(rushPrice?number?string('0.00')?index_of('.'))}
                                                                 </span>

                                                                 <span class="pro-num1" style="    padding-right: 15px;">×${cart.goodsNum!''}</span>
                                                                 <span style="font-size: .288rem;    float: right;margin-right: 15px;"><span>¥</span>&nbsp;<span class="num">${(rushPrice?number * cart.goodsNum?number)?string("0.00")?substring(0,(rushPrice?number * cart.goodsNum?number)?string("0.00")?index_of('.'))}</span>
                                                                     <span style="color: #333333;">${(rushPrice?number * cart.goodsNum?number)?string("0.00")?substring((rushPrice?number * cart.goodsNum?number)?string("0.00")?index_of('.'))}</span>
                                                                 </span>
                                                             </p>
                                                         </#if>
                                                        <#--<p class="some-info">-->
                                                        <#--<span style="display: initial;">-->
                                                        <#--${mar.marketingName}-->
                                                        <#--</span>-->
                                                        <#--</p>-->
                                                    <#elseif mar.codexType=='11'&& mar.customerbuynum ==0>
                                                       <#assign flag = 1>

                                                    </#if>
                                                        <!--包邮-->
                                                    <#--<#if market.codexType=='12'>-->
                                                    <#--<#if market.shippingMoney??>满 ${market.shippingMoney} 包邮</#if>-->
                                                    <#--</#if>-->
                                                    <#--${mar.marketingName}-->
                                                        <!--满赠-->
                                                    <#if mar.codexType=='6'>
                                                        <#--<#list mar.fullbuyPresentMarketings as fp>
                                                            <#if fp.presentType == '0'>
                                                                满 ${fp.fullPrice}元送赠品&nbsp;
                                                            <#elseif fp.presentType == '1'>
                                                                满 ${fp.fullPrice?number}件送赠品&nbsp;
                                                            </#if>
                                                        </#list>-->
                                                        <p class="price" style="margin-top: 5px;    height: 16px;"></p>

                                                        <#assign price = "${cart.goodsDetailBean.productVo.goodsInfoPreferPrice?number}">
                                                        <p class="price" style=""><span>¥</span>&nbsp;<span class="num">${price?number?string("0.00")?substring(0,price?number?string("0.00")?index_of('.'))}</span>
                                                            <span style="color: #333333;">${price?number?string("0.00")?substring(price?number?string("0.00")?index_of('.'))}</span>
                                                            <span class="pro-num1" style="    padding-right: 15px;">×${cart.goodsNum!''}</span>
                                                            <span style="font-size: .288rem;    float: right;margin-right: 15px;"><span>¥</span>&nbsp;<span class="num">${(price?number*cart.goodsNum)?string('0.00')?substring(0,(price?number*cart.goodsNum)?string('0.00')?index_of('.'))}</span>
                                                                    <span style="color: #333333;">${(price?number*cart.goodsNum)?string('0.00')?substring((price?number*cart.goodsNum)?string('0.00')?index_of('.'))}</span>
                                                            </span>
                                                        </p>
                                                        <#--<p class="some-info">-->
                                                        <#--<span style="display: initial;">-->
                                                        <#--${mar.marketingName}-->
                                                        <#--</span>-->
                                                        <#--</p>-->
                                                    </#if>

                                                </#if>
                                            </#list>
                                        </#if>

                                        <#if flag==1>

                                            <p class="price" style="margin-top: 5px;    height: 16px;"></p>

                                            <#assign price = "${cart.goodsDetailBean.productVo.goodsInfoPreferPrice?number}">
                                            <p class="price" style=""><span>¥</span>&nbsp;<span class="num">${price?number?string("0.00")?substring(0,price?number?string("0.00")?index_of('.'))}</span>
                                                <span style="color: #333333;">${price?number?string("0.00")?substring(price?number?string("0.00")?index_of('.'))}</span>
                                                <span class="pro-num1" style="    padding-right: 15px;">×${cart.goodsNum!''}</span>
                                                <span style="font-size: .288rem;    float: right;margin-right: 15px;"><span>¥</span>&nbsp;<span class="num">${(price?number*cart.goodsNum)?string('0.00')?substring(0,(price?number*cart.goodsNum)?string('0.00')?index_of('.'))}</span>
                                                                    <span style="color: #333333;">${(price?number*cart.goodsNum)?string('0.00')?substring((price?number*cart.goodsNum)?string('0.00')?index_of('.'))}</span>
                                                            </span>
                                            </p>
                                        </#if>

                                    </div>
                                </div>
                            </a>
                            <!--赠品--商品-->
                            <#if cart.presentGoodsProducts?? ||cart.presentCoupon??>
                                <div class="cart_gifts">
                                    <#if cart.presentGoodsProducts??>
                                        <#list cart.presentGoodsProducts as presentGoodsProduct>
                                            <#assign goodsCount=goodsCount+presentGoodsProduct.scopeNum />
                                            <#assign goodsWeight=goodsWeight+(presentGoodsProduct.scopeNum * presentGoodsProduct.goodsInfoWeight) />
                                            <input type="hidden" name="presentScopeId" value="${presentGoodsProduct.presentScopeId}">
                                            <a target="_blank" title="${presentGoodsProduct.goodsInfoName}">
                                                <div class="pro-item">
                                                    <div class="propic">
                                                        <img src="${presentGoodsProduct.goodsInfoImgId}" alt="产品图">
                                                    </div>

                                                    <div class="prodesc" style="border: none;">
                                                        <div style="width;100%;line-height: 18px;height: 36px;">

                                                            <#--  <h3 class="title" style=" ">-->
                                                                  <img style="width:28px;height: 16px;vertical-align:middle;float: left" src="${basePath}/images/v2/gift@2x.png">${presentGoodsProduct.goodsInfoName!''}
                                                              <#--</h3>-->
                                                        </div>
                                                        <p class="price" >&nbsp;</p>
                                                        <#--!-->
                                                        <p class="price" ><span>¥</span>&nbsp;<span class="num">${presentGoodsProduct.goodsInfoPreferPrice?string("0.")}</span>
                                                            <#list presentGoodsProduct.goodsInfoPreferPrice?string('0.00')?split(".") as price>
                                                                <#if price_index==1>
                                                                    <span style="color: #333333;">${price}</span>
                                                                </#if>
                                                            </#list>
                                                            <span class="pro-num1" style="padding-right: 15px;">×${presentGoodsProduct.scopeNum!''}</span>

                                                            <span style="float: right;margin-right: 15px;"><span>¥</span>&nbsp;<span class="num">0</span><span style="color: #333333;">.00</span></span>
                                                        </p>
                                                        <#--!-->

                                                    </div>
                                                </div>
                                            </a>
                                        </#list>
                                    </#if>
                                    <#if cart.presentCoupon??>
                                        <#list cart.presentCoupon as coupon>
                                            <input type="hidden" name="coupon_presentScopeId" value="${coupon.presentScopeId}">
                                        </#list>
                                    </#if>
                                </div>
                            </#if>
                        </div>

                    <#elseif cart.fitId??>
                        <input type="hidden" value="${cart.shoppingCartId}" name="shoppingCartId">

                        <#assign group = cart.goodsGroupVo>
                        <div class="list-item confirm-pro-item">
                            <div class="group-title">
                                <span class="amount">×${cart.goodsNum!0}套</span>
                                <span class="price">¥${group.price?string("0.00")}</span>
                                <p><span class="label-line">套装</span>${group.groupName}</p>
                            </div>
                            <#list group.productList as product>
                                <#assign vo = product.productDetail/>
                                <a href="${basePath}/item/${vo.goodsInfoId}.html">
                                    <div class="pro-item">
                                        <div class="propic">
                                            <img src="${vo.goodsInfoImgId}">
                                        </div>
                                        <div class="prodesc">
                                            <h3 class="title">${vo.goodsInfoName}</h3>
                                            <p class="price">¥&nbsp;<span class="num">${vo.goodsInfoPreferPrice?string("0.00")}</span>
                                            </p>
                                            <#assign goodsCount=goodsCount+cart.goodsNum />
                                            <#assign goodsWeight=goodsWeight+(cart.goodsNum * vo.goodsInfoWeight) />
                                            <span class="pro-num">×${cart.goodsNum!0}件/套</span>
                                        </div>
                                    </div>
                                </a>
                            </#list>
                        </div>
                   </#if>


                </#list>


            </div>

           <#-- <#if (bossNum>3)>
                <div class="list-item see-all" onclick="showGoods(this)" style="border-bottom: 1px solid #eeeeee;">
                    <input type="hidden" class="storeId" value="0">
                         显示其他${bossNum-3}件商品
                </div>
            </#if>-->
            <!-- 自提点，有已经选择的提点直接展示 -->
        <#--<#if choseDeliveryPoint>
            <div class="list-item" id="deliverylist">
                <a href="javascript:;">
                    <i class="arrow-right"></i>
                    <h3 class="item-head">自提地点<span class="curValue" dpId="${deliveryMap.choseDeliveryPoint.deliveryPointId!''}">${deliveryMap.choseDeliveryPoint.name!''}</span></h3>
                </a>
            </div>
        <!-- 没有勾选自提点,存在自提点 &ndash;&gt;
        <#elseif deliveries>
            <div class="list-item" style="display:none;" id="deliverylist">
                <a href="javascript:;">
                    <i class="arrow-right"></i>
                    <h3 class="item-head">自提地点
                        <#list deliveryMap.deliveries as dp>
                            <#if dp_index == 0>
                                <span class="curValue" dpId="${dp.deliveryPointId!''}">${dp.name!''}</span>
                            </#if>
                        </#list>
                    </h3>
                </a>
            </div>
        <#else>

        </#if>-->
            <#--备注-->
            <div class="list-item remark">
            <#--   <i class="arrow-right"></i>-->
                <h3 class="item-head"><span class="beizhu">备注</span><input onkeyup="way();"  class="curValue text-them text" type="text" style="float: left;width: 80%; border: none;font-size: 1em;color: #999999;" placeholder="选填30字以内" name="orderComment" value="${orderComment!''}"></h3>
            </div>
            <#--重量共？件，重约？KG-->
            <#--<div class="list-item weight" >-->
                <#--<p style="float: right;">共<span>${goodsCount}</span>件，重约<span>${goodsWeight/1000}</span>KG</p>-->
            <#--</div>-->

        </div>
    </#if>
    <#if thirdNum!=0>
        <#list map.thirds as store>
            <#if store.thirdId!=0>
                <div class="order-info mt10">
                    <#assign tNum=0 />
                    <#list  map.shoplist as cart>
                        <#if cart.goodsDetailBean??&& cart.goodsDetailBean.productVo.thirdId?? && cart.goodsDetailBean.productVo.thirdId==store.thirdId&&store.thirdId!=0>
                            <#assign tNum=tNum+1/>
                            <div class="list-item  goods${store.thirdId}"  <#if (tNum?number>3)>style="display:none" </#if>>
                                <#if tNum==1>
                                    <div class="profrom-way"><span class="some-tip">${store.thirdName!''}</span></div>
                                </#if>
                                <div class="pro-item" >
                                    <a href="${basePath}/item/${cart.goodsDetailBean.productVo.goodsInfoId}.html" target="_blank" title="${cart.goodsDetailBean.productVo.productName}">
                                        <div class="propic">
                                            <input type="hidden" value="${cart.shoppingCartId}" name="shoppingCartId">
                                            <img src="${cart.goodsDetailBean.productVo.goodsInfoImgId}" alt="产品图">
                                        </div>
                                        <div class="prodesc">
                                            <h3 class="title">${cart.goodsDetailBean.productVo.productName!''}</h3>

                                            <p class="price">¥&nbsp;<span class="num">${cart.goodsDetailBean.productVo.goodsInfoPreferPrice?string("0.00")}</span></p>
                                            <span class="pro-num">×${cart.goodsNum!''}</span>
                                            <#if cart.marketingList??&&cart.marketingList?size!=0>
                                                <#list cart.marketingList as mar>
                                                    <#if cart.marketingActivityId??&&mar.marketingId==cart.marketingActivityId>
                                                        <p class="some-info">优惠：
                                                            <span>
                                                                     <!--直降-->
                                                                <#if mar.codexType=='1'>
                                                                    直降${mar.priceOffMarketing.offValue}
                                                                    元
                                                                </#if>

                                                                <!--满减-->
                                                                <#if mar.codexType=='5'>
                                                                    <#list mar.fullbuyReduceMarketings as fr>
                                                                        满 ${fr.fullPrice}
                                                                        减${fr.reducePrice}元 &nbsp;
                                                                    </#list>

                                                                </#if>

                                                                <!--满折-->
                                                                <#if mar.codexType=='8'>
                                                                    <#list mar.fullbuyDiscountMarketings as mz>
                                                                        满 ${mz.fullPrice}
                                                                        打 ${mz.fullbuyDiscount*10}折
                                                                            &nbsp;
                                                                    </#list>
                                                                </#if>
                                                            <#--团购-->
                                                            <#if market.codexType=='10'>
                                                            ${market.groupon.grouponDiscount}折团购
                                                            </#if>
                                                            <#--抢购-->
                                                                <#if mar.codexType=='11'>
                                                                ${(mar.rushs[0].rushDiscount*10)?string('0.#')}折抢购
                                                                </#if>
                                                                <!--包邮-->
                                                            <#--<#if market.codexType=='12'>-->
                                                            <#--<#if market.shippingMoney??>满 ${market.shippingMoney} 包邮</#if>-->
                                                            <#--</#if>-->
                                                            <#--${mar.marketingName}-->
                                                            </span></p>
                                                    </#if>
                                                </#list>
                                            </#if>

                                        </div>
                                    </a>
                                </div>
                            </div>
                        </#if>
                    </#list>


              <#--      <#if (tNum>3)>
                        <div class="list-item see-all" onclick="showGoods(this)" style="border-bottom: 1px solid #eeeeee;">
                            <input type="hidden" class="storeId" value="${store.thirdId}">
                                显示其他${tNum-3}件商品
                        </div>
                    </#if>-->

                    <#--<div class="list-item">-->
                        <#--<div class="send-way">-->
                            <#--<h3 class="item-head">配送方式</h3>-->

                            <#--<div class="list-value">-->
                                <#--<#if map.frightlist??&&map.frightlist?size!=0>-->
                                    <#--<#list map.frightlist as  fr>-->
                                        <#--<#if fr.freightThirdId==store.thirdId>-->
                                            <#--<a class="btn-grey selected" href="javascript:;">${fr.freightTemplateName!''}</a>-->
                                        <#--</#if>-->
                                    <#--</#list>-->
                                <#--</#if>-->
                            <#--</div>-->
                        <#--</div>-->
                    <#--</div>-->

                </div>
            </#if>
        </#list>
    </#if>

        <div class="all-info" style="border-bottom: 10px solid #f7f7f7;">
            <div class="all-info-one">
            <div class="list-item groupa">
                <a href="${basePath}/tochangeInvoice.htm?invoiceTitle=${invoiceTitle!''}&invoiceType=${invoiceType!''}<#if orderAddress??>&addressId=${orderAddress.addressId!''}</#if>&typeId=${typeId!''}&ch_pay=${ch_pay!''}&deliveryPointId=${deliveryPointId!''}&codeNo=<#if coupon??>${coupon.codeNo!''}</#if>&taxpayerNumber=${taxpayerNumber!''}&orderComment=${orderComment!''}" class="invoic">
                    <i class="arrow-right"></i>
                    <h3 class="item-head">发票<span class="curValue text-them">
                    <#if invoiceTitle??>
                        <#if taxpayerNumber?? && taxpayerNumber != "">
                            单位
                        <#else>
                            个人
                        </#if>
                    <#else>
                        不开发票
                    </#if>
                </span></h3>
                </a>
            </div>
        <#assign  couponPrice=0/>
        <#assign  bosscouponPrice=0/>
        <#if map.couponlist??&&map.couponlist?size!=0>
            <div class="list-item groupa">
                <a href="${basePath}/tocouponlist.htm?invoiceTitle=${invoiceTitle!''}&invoiceType=${invoiceType!''}<#if orderAddress??>&addressId=${orderAddress.addressId!''}</#if>&typeId=${typeId!''}&ch_pay=${ch_pay!''}&deliveryPointId=${deliveryPointId!''}&codeNo=<#if coupon??>${coupon.codeNo!''}</#if>&taxpayerNumber=${taxpayerNumber!''}&orderComment=${orderComment!''}"  class="invoic">
                    <i class="arrow-right"></i>
                    <h3 class="item-head">优惠券
                        <small id="coupon" style="  font-size: 1em;  float: right;padding: 0px;color: #0072BC;">
                            <#if coupon??>
                                <#if coupon.couponRulesType=='2'>
                                    减${coupon.couponFullReduction.reductionPrice?string("0.00")}元
                                <#elseif coupon.couponRulesType=='1'>
                                    减${coupon.couponStraightDown.downPrice?string("0.00")}元
                                </#if>
                            <#else>
                               有${map.couponlist?size}张优惠券可用
                            </#if>
                        </small></h3>
                    <input id="couponPrice" value="<#if coupon??&&coupon.couponRulesType=='2'>${coupon.couponFullReduction.reductionPrice}<#elseif coupon??&&coupon.couponRulesType=='1'>${coupon.couponStraightDown.downPrice}</#if>" type="hidden"/>
                    <#if coupon??&&coupon.couponRulesType=='2'>
                        <#assign  couponPrice=coupon.couponFullReduction.reductionPrice?number+couponPrice?number/>
                    <#elseif coupon??&&coupon.couponRulesType=='1'>
                        <#assign  couponPrice=couponPrice?number+coupon.couponStraightDown.downPrice?number/>

                    </#if>
                    <#if coupon??&& coupon.businessId==0>
                        <#if map.bossPrice?number-couponPrice?number<0.01>
                            <#--<#assign  youhui=youhui?number+ map.bossPrice?number-0.01 />-->
                            <#assign  bosscouponPrice= map.bossPrice?number-0.01/>
                        <#else>
                            <#assign  bosscouponPrice=couponPrice?number/>
                            <#--<#assign  youhui=youhui?number+couponPrice?number />-->
                        </#if>
                    <#else>
                        <#list map.storeList as store>
                            <#if coupon??&&store.thirdId==coupon.businessId>
                                <#if store.sumPrice?number-couponPrice?number<0.01>
                                    <#--<#assign  youhui=youhui?number+ store.sumPrice?number-0.01 />-->
                                <#else>
                                    <#--<#assign  youhui=youhui?number+couponPrice?number />-->
                                </#if>
                            </#if>
                        </#list>
                    </#if>
                </a>
            </div>
        <#else>
            <div class="list-item groupa">
                <a href="${basePath}/tocouponlist.htm?invoiceTitle=${invoiceTitle!''}&invoiceType=${invoiceType!''}<#if orderAddress??>&addressId=${orderAddress.addressId!''}</#if>&typeId=${typeId!''}&ch_pay=${ch_pay!''}&deliveryPointId=${deliveryPointId!''}&codeNo=<#if coupon??>${coupon.codeNo!''}</#if>&taxpayerNumber=${taxpayerNumber!''}&orderComment=${orderComment!''}"  class="invoic">
                    <i class="arrow-right"></i>
                    <h3 class="item-head">优惠券<span class="curValue text-them">
                有0张优惠券可用
                </span></h3>
                </a>
            </div>
        </#if>
            <input type="hidden" id="bossPrice" value="${map.bossPrice}">
            <input type="hidden" name="allpricee" value="${map.allPrice}">
        <#--<input id="bossPrice" type="hidden" value="${map.allPrice?number+map.fPrice.bossfreight?number}"/>-->
            <input id="bosscouponPrice" type="hidden" value="${bosscouponPrice}"/>
            <input id="youhui" type="hidden"  value="${youhui}"/>
            <input type="hidden" id="isThirdSku" value="${bossNum}">
        <#if bossNum!=0>
       <div class="list-item li_css" >
        <div id="jifenonjudeg" class="use-points on-off"></div>
        <h3 class="item-head">积分<small><span class="small" id="jfSmall" style="font-size:0.256rem;line-height: 20px;display: block;height: 23px;color: #999;">可用<span>1150</span>积分，抵扣¥<span></span></span><img class="question" src="../../images/v3/btn_help@2x.png"></small>
        <input type="hidden" id="maxjf"/>
        </h3>
        </div>
            <div class="list-item use-points-form" style="display: none;padding: 0px;">
                <h3 class="item-head" style=" height: 46px;">
                    <span class="use-jifen" style="line-height: 47px;height: 45px;display: inline-block;">使用
                        <#--<input type="text" class="judge" id="jifen" name='point' onkeyup="caljifen(this)"/>分，可减-->
                        <input type="text" class="judge" id="jifen" name='point' />分，可减
                        <span id="jifenPrice" style="font-size:.256rem; color: #199301;    line-height: 20px;">0.00</span>元
                    </span>
                    <span id="jifenError" style="font-size:.24rem;color:red;float: right;height: 40px;line-height: 48px;"></span>
                </h3>
            </div>
        </#if>
        </div>
        </div>


         <#--!-->
    <#assign payPrice=map.sumOldPrice?number+map.fPrice.freightmoney?number-map.zheKPrice?number-youhui?number-bosscouponPrice?number/>
        <input value="${payPrice}" type="hidden" id="payPrice"/>
        <input  type="hidden" id="jfPrice"/><!--使用积分后-->
        <div class="all-info " >
            <div class="list-item" style="padding-bottom:0">
                <ul class="price-total">
                    <li><label for="">商品金额</label><span class="value">¥${map.sumOldPrice?string("0.00")}</span></li>
                    <li class="btn_payment"><#setting number_format="0.00"><label for="">减扣金额</label><span class="value" id="yPrice">-¥${(youhui?number+bosscouponPrice?number+map.zheKPrice?number)!'0'}&nbsp;<div class="unfold"></div></span></li>
                    <li class="payment" style=" display: none; height: auto;    margin-top: -10px;" >
                        <div>
                            <#setting number_format="0.00">
                            <span style="float: left;">优惠金额</span>
                            <span style="float: right;">-¥${youhui!'0'}</span>
                        </div>
                        <div>
                            <span style="float: left;" >积分兑换</span>
                            <span style="float: right;" class="newjfPrice">-¥0.00</span>
                        </div>
                        <div>
                            <span style="float: left;">优惠券</span>
                            <span style="float: right;">-¥${bosscouponPrice!'0.00'}</span>
                        </div>
                        <div>
                            <span style="float: left;">会员折扣</span>
                            <#setting number_format="0.00">
                            <span style="float: right;">-¥${map.zheKPrice}</span>
                        </div>
                    </li>
                    <#--<li><label for="">会员折扣</label><span class="value">-¥${map.zheKPrice}</span></li>-->
                    <li><label class="deliverycost" for="" style="position: relative;">
                        <p>配送费</p>
                        <span>约重${goodsWeight/1000}Kg</span>
                        <a href="${basePath}/intoPage.htm?pageName=member/standard"><img style="width: 22px; " src="${basePath}/images/v3/btn_help@2x.png"></a></label><span class="value">¥<#if stockFlag?? && !stockFlag>0.00<#else>${map.fPrice.freightmoney!'00'}</#if></span></li>
                    <li><label for="">需支付</label><span class="value text-them" id="sPrice">¥${payPrice?string("0.00")}</span></li>
                </ul>
            </div>
        </div>
        <div class="all-info payTrue" style="position: fixed;bottom: 0;width: 100%;" onclick="_czc.push(['_trackEvent', '购物车', '确认订单', '去支付','0','gotopay']);">
            <div class="pay_pay">
                <span>去支付&nbsp;¥&nbsp;<span>${payPrice?string("0.00")?substring(0,payPrice?string("0.00")?index_of("."))}</span><span style="font-size:12px;">${payPrice?string("0.00")?substring(payPrice?string("0.00")?index_of("."))}</span></span>
            </div>
        </div>
    </div>
</form>
<#--<img style="visibility: hidden;height: 1px;" src="../../images/v3/doing.gif" alt=""/>-->
<input type="hidden" id="orderId"/>
<input value="${basePath}" type="hidden" id="basePath"/>
<script src="${basePath}/js/dialog-min.js"></script>
<script src="${basePath}/js/pageAction.js"></script>
<script type="text/javascript" src="${basePath}/js/shoppingcart/jsOperation.js"></script>
<script src="${basePath}/js/customer/wxforward.js"></script>
<script type="text/javascript" src="${basePath}/js/tip-newbox.js"></script>
<script>
    $('.prodesc:last').addClass("marginbottom");
    if($('.cart_gifts').find('.prodesc').length==0){
        $('.cart_gifts').css("padding","0px");
    }
    (function (doc, win) {
        var docEl = doc.documentElement,
                resizeEvt = 'onorientationchange' in window ? 'onorientationchange' : 'resize',
                recalc = function () {
                    var clientWidth = docEl.clientWidth;
                    if (!clientWidth) return;
                    if(clientWidth>=750){
                        docEl.style.fontSize = '100px';
                    }else{
                        docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
                    }
                };

        if (!doc.addEventListener) return;
        win.addEventListener(resizeEvt, recalc, false);
        doc.addEventListener('DOMContentLoaded', recalc, false);
    })(document, window);
</script>
<script>
$(function (){

    var tip = myAlertStr();
    var flag = true;
    $("#yPrice").on("touchstart",function(e) {
        if( flag ){
            $(".payment").slideDown();
            $(".unfold").addClass("pack_up").removeClass("unfold");
            flag = false;
        } else {
            $(".payment").slideUp();
            $(".pack_up").removeClass("pack_up").addClass("unfold");
            flag = true;
        }

        e.preventDefault();
    });
    //把备注给a标签
    $('input[name=orderComment]').blur(function(){
        var _this = this;
        $('.invoic').each(function(){
            if($(this).attr("href").indexOf("orderComment")!=-1){
                var str = $(this).attr("href").substring(0,$(this).attr("href").indexOf("orderComment"));
                $(this).attr("href",str+"&orderComment="+$(_this).val());
            }
        })

    })
    payTrue();
    function payTrue(){
        var dianziCardNum = $("#dianziCard").val();
        if(dianziCardNum > 0) {
            var inputEmail = $(".input-email").val();
            if (inputEmail == "" || $.trim(inputEmail) == "") {
                return;
            } else {
                var reg = /\w+[@]{1}\w+[.]\w+/;
                if (!reg.test(inputEmail)) {
                    return;
                }
            }
        }
       /* if($("#stockFlag").val()=="0"){
            return;
        }*/
        if(${map.isware} == '0'){
            return;
        }
        if(${map.repertory} == '0'){
            return;
        }
//
//        if (typeof($("#jifenonjudeg").attr("on")) == "undefined") {
//            var judgejifen = $(".judge").val();
//
//            if(parseInt($("#isOpen").val()) == 1){
//                if(parseInt($("#isThirdSku").val()) > 0){
//                    return;
//                }
//                if (judgejifen % 10 != 0) {
//                    return;
//                }
//            }
//        }


        /**
         * 判断选择使用的优惠券是否能使用
         *
         * */
        var flagss = true;
        if($("input[name='codeNo']").val() ==null ){

        }else{
            $.ajax({
                url:"${basePath}/queryStatus.htm?couponNo="+$("input[name='codeNo']").val(),
                type:"post",
                async:false,
                success:function(data){
                    if(data != 0){
                        flagss = false;
                    }
                }
            });
        }
        if(flagss==false){
            return;
        }
        var totalCount = $("#totalCount").val();
        if(dianziCardNum != totalCount) {
            if ($("#addressId").val() == '' || $("#addressId").val() == undefined) {
                return;
            }
        }
        var orderpayPrice=$("#payPrice").val();
        if(Number(orderpayPrice) < 0){
            return ;
        }
        $('.pay_pay').css("backgroundColor","#199301");
    }
    var flagtap = true;
    $(".pay_pay").click(function(){
//      $(".pay_pay").on("touchstart",function(){
          var gopaycharge = $(".pay_pay").html();
        if(flagtap){
            flagtap=false;
        }else{
            return
        }
        setTimeout('flagtap=true', 1000);
        if($(this).hasClass("load")){
            return
        }else{
            $(this).addClass("load");
            $(this).html("支付中...")
        }



        var dianziCardNum = $("#dianziCard").val();
        if(dianziCardNum > 0) {
            var inputEmail = $(".input-email").val();
           if (inputEmail == "" || $.trim(inputEmail) == "") {
                $(".input-email").focus();
               /* setTimeout(function () {
                    $('.tip-box').remove();
                    $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><i class="failed"></i><h3>请输入电子邮箱地址！</h3></div></div>');
                }, 10);
                setTimeout(function () {
                    $(".tip-box").hide();
                }, 1000)*/
               tip("请输入电子邮箱地址");
               $(".pay_pay").removeClass("load");$(".pay_pay").html(gopaycharge)
                return;
            } else {
                var reg = /\w+[@]{1}\w+[.]\w+/;
                if (!reg.test(inputEmail)) {
                   /* setTimeout(function () {
                        $('.tip-box').remove();
                        $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><i class="failed"></i><h3>电子邮箱地址有误，请检查后重新输入！</h3></div></div>');
                    }, 10);
                    setTimeout(function () {
                        $(".tip-box").hide();
                    }, 1000)*/
                   tip("电子邮箱地址有误，请检查后重新输入");
                    $(".pay_pay").removeClass("load");$(".pay_pay").html(gopaycharge)
                    return;
                }
            }
        }



       /* if($("#stockFlag").val()=="0"){
            /!*setTimeout(function(){
                $('.tip-box').remove();
                $('body').append('<div class="tip-box" style="z-index:99999;width: 75%;left: 12.5%;"><div class="tip-body"><i class="failed" style="float:none;margin:0 auto;"></i><h3>收货地址与仓库所在区域不一致，请再次核对地址！</h3></div></div>');
            },10);
            setTimeout(function(){
                $(".tip-box").hide();
            },2000)*!/
            tip("收货地址与仓库所在区域不一致，请再次核对地址");
            return;
        }*/
        if(${map.isware} == '0'){
            tip("您当前所选的收货地址暂时无货");
            $(".pay_pay").removeClass("load");$(".pay_pay").html(gopaycharge)
            return;
        }
        if(${map.repertory} == '0'){
            tip("您当前所选的收货地址暂时无货");
            $(".pay_pay").removeClass("load");$(".pay_pay").html(gopaycharge)
            return;
        }
//        if (typeof($("#jifenonjudeg").attr("on")) == "undefined") {
//            var judgejifen = $(".judge").val();
//
//            if(parseInt($("#isOpen").val()) == 1){
//                if(parseInt($("#isThirdSku").val()) > 0){
//                    if (judgejifen == '') {
//                        $("#jifenError").html("请输入积分");
//                        $(".pay_pay").removeClass("load");$(".pay_pay").html(gopaycharge)
//                        return;
//                    }
//
//                    if (judgejifen % 10 != 0) {
//                        $(".judge").val('');
//                        $("#jifenPrice").html('0.00');
//                        $("#jifenError").html("请输入10的倍数");
//                        $(".pay_pay").removeClass("load");$(".pay_pay").html(gopaycharge)
//                        return;
//                    }
//                }
//            }
//        }

        /**
         * 判断选择使用的优惠券是否能使用
         *
         * */
        var flagss = true;
        if($("input[name='codeNo']").val() ==null ){

        }else{
            $.ajax({
                url:"${basePath}/queryStatus.htm?couponNo="+$("input[name='codeNo']").val(),
                type:"post",
                async:false,
                success:function(data){
                    if(data != 0){
                        flagss = false;
                    }
                }
            });
        }
        if(flagss==false){
            /*setTimeout(function(){
                $('.tip-box').remove();
                $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><i class="failed"></i><h3>使用的优惠券无效！</h3></div></div>');
            },10);
            setTimeout(function(){
                $(".tip-box").hide();
            },1000)*/
            tip("使用的优惠券无效");
            $(".pay_pay").removeClass("load");$(".pay_pay").html($(".pay_pay").html(gopaycharge))
            return;
        }

        var totalCount = $("#totalCount").val();
        if(dianziCardNum != totalCount) {
            if ($("#addressId").val() == '' || $("#addressId").val() == undefined) {
               /* setTimeout(function () {
                    $('.tip-box').remove();
                    $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><i class="failed"></i><h3>请选择收货地址！</h3></div></div>');
                }, 10);
                setTimeout(function () {
                    $(".tip-box").hide();
                }, 1000)*/
               tip("请选择收货地址");
                $(".pay_pay").removeClass("load");$(".pay_pay").html($(".pay_pay").html(gopaycharge))
                return;
            }
        }
        var orderpayPrice=$("#payPrice").val();
        if(Number(orderpayPrice) < 0){
            /*setTimeout(function(){
                $('.tip-box').remove();
                $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><i class="failed"></i><h3>订单金额有误,无法提交！</h3></div></div>');
            },10);
            setTimeout(function(){
                $(".tip-box").hide();
            },1000)*/
            tip("订单金额有误,无法提交");
            $(".pay_pay").removeClass("load");$(".pay_pay").html($(".pay_pay").html(gopaycharge))
            return ;
        }
        if ($('.on-off').attr('on')) {
            $("#jifen").val($("#maxjf").val());
        }else{
            $("#jifen").val(0);
        }

        $(".pay_pay").removeClass("load");
        $(".pay_pay").html(gopaycharge)
        $("#subForm").submit();
    });

    /*邮箱*/
    $(".empty_value").click(function () {
        $(".text").val("");
        $(".empty_value").hide();
        $(".text").focus();
    })
})

function way() {
    var val = $(".text").val();
    if (val === "") {
        $(".empty_value").hide();
    } else {
        $(".empty_value").show();
        $('.pay_pay').css("backgroundColor","#199301");
    }
}
</script>
<script>
    $("#sex").click(function () {
        var that = this;
        $("#sex-list").mobiscroll().treelist({
            theme: "android-ics light",
            lang: "zh",
            display: 'modal',
            mode: "scroller",
            closeOnSelect: false,
            inputClass: 'tmp',
            headerText: '请您选择',
            onSelect: function (valueText) {
                var classN = $(this).find("li").eq(valueText).attr("class");
                var m = $(this).find("li").eq(valueText).html();
                $(".mbase-menu-txt").text(m);
                if (classN == 'ziti') {
                    $("#typeId").val('1');
                }else{
                    $("#typeId").val('0');
                }
                /*$.post("inc/person.org.php", {apart: "resume_base", sex: m}, function (result) {
                    if (result == 'ok') {
                        $(that).find(".mbase-menu-txt").html(m);
                    }
                    else {
                        error('网络繁忙，请您稍后再试');
                    }
                });*/
            }
        });
        $("input[id^=sex-list]").focus();
    });

</script>
<#--<script>
    $(".item-head").click(function () {
$(".list_down").show();
    })
</script>-->
<script>

    var jf=$("#jfen").val();
    var pointset=$("#pointSet").val();
    var bossPrice=Subtr($("#bossPrice").val(),$("#bosscouponPrice").val());
    if(bossPrice.indexOf(".") != -1){
        bossPrice = bossPrice.substring(0,bossPrice.indexOf(".")+2);
    }
    function caljifen(obj) {

        if (parseInt($("#isOpen").val()) == 1) {
            if (!isNaN($(obj).val())) {
                if ($(obj).val() == '') {
                    $("#jifenError").text("请输入兑换积分");
                    return;
                }
                if ($(obj).val() > 0) {
                    if (Subtr($("#maxjf").val(), $(obj).val()) < 0) {
                        $(obj).val('');
                        $("#jifenError").text("积分不足");
                        return;
                    } else if ($(obj).val() % 10 != 0) {
                        $("#jifenError").text("请输入10的倍数");
                        return;
                    } else {
                        $("#jifenError").text("");
                    }
                } else {
                    $(obj).val('');
                    $("#jifenError").text("格式有误");
                    return;
                }
            } else {
                $(obj).val('');
                $("#jifenError").text("格式有误");
                return;
            }
        }else{
            $(obj).val('');
            $("#jifenError").text("无法使用积分");
            return;
        }

        var price = accDiv(accMul(accAddInt($(obj).val(), 0), pointset), 10);
        var myprice = Subtr($("#payPrice").val(), price);
        if (myprice <= 0) {
            $("#sPrice").html("¥" + "0.00");
            $(".pay_pay").children("span").find("span:first").html("0");
            $(".pay_pay").children("span").find("span:eq(1)").html(".00");
            //$("#yPrice").html("-¥" + accAdd(accAdd(price, myprice), $("#youhui").val())+'&nbsp;<div class="unfold"></div>');
            $("#yPrice").html("-¥" + accAdd(accAdd(accAdd(price, $("#youhui").val()),$("#bosscouponPrice").val()),${map.zheKPrice?string('0.00')})+'&nbsp;<div class="unfold"></div>');
            $(".newjfPrice").html("-¥"+price);
        } else {
            $(".pay_pay").children("span").find("span:first").html(Subtr($("#payPrice").val(), price).toString().substring(0,Subtr($("#payPrice").val(), price).toString().indexOf(".")));
            $(".pay_pay").children("span").find("span:eq(1)").html(Subtr($("#payPrice").val(), price).toString().substring(Subtr($("#payPrice").val(), price).toString().indexOf(".")));
            $("#yPrice").html("-¥" + accAdd(accAdd(accAdd(price, $("#youhui").val()),$("#bosscouponPrice").val()),${map.zheKPrice?string('0.00')})+'&nbsp;<div class="unfold"></div>');
            $(".newjfPrice").html("-¥"+price);
            $("#sPrice").html("¥" + Subtr($("#payPrice").val(), price));
        }

        $("#jfPrice").val(price);
        $("#jifenPrice").html(price);
    }


    function checkjifen(obj){
        if(!isNaN($(obj).val())) {
            if($(obj).val() > 0){
                if (Subtr($("#maxjf").val(), $(obj).val()) < 0) {
                    $(obj).val('');
                    $("#jifenError").text("积分不足");
                } else if ($(obj).val() % 10 != 0) {
                    $(obj).val('');
                    $("#jifenError").text("请输入10的倍数");
                }else if(parseInt($("#isOpen").val()) == 0){
                    $(obj).val('');
                    $("#jifenError").text("无法使用");
                }else {
                    $("#jifenError").text("");
                }
            }else{
                $(obj).val('');
                $("#jifenError").text("格式有误");
            }
        }else{
            $(obj).val('');
            $("#jifenError").text("格式有误");
        }
        var price=  accDiv(accMul(accAddInt($(obj).val(),0),pointset),10);
        var myprice = Subtr($("#payPrice").val(),price);
        if(myprice<=0){
            $("#sPrice").html("¥"+"0.00");
            $(".pay_pay").children("span").find("span:first").html("0");
            $(".pay_pay").children("span").find("span:eq(1)").html(".00");
//            $("#yPrice").html("-¥"+accAdd(accAdd(price,myprice),$("#youhui").val())+'&nbsp;<div class="unfold"></div>')

            $("#yPrice").html("-¥" + accAdd(accAdd(accAdd(price, $("#youhui").val()),$("#bosscouponPrice").val()),${map.zheKPrice?string('0.00')})+'&nbsp;<div class="unfold"></div>');

            $(".newjfPrice").html("-¥"+price);
        }else{
            $("#sPrice").html("¥"+Subtr($("#payPrice").val(),price));
            $(".pay_pay").children("span").find("span:first").html(Subtr($("#payPrice").val(), price).toString().substring(0,Subtr($("#payPrice").val(), price).toString().indexOf(".")));
            $(".pay_pay").children("span").find("span:eq(1)").html(Subtr($("#payPrice").val(), price).toString().substring(Subtr($("#payPrice").val(), price).toString().indexOf(".")));
            $("#yPrice").html("-¥" + accAdd(accAdd(accAdd(price, $("#youhui").val()),$("#bosscouponPrice").val()),${map.zheKPrice?string('0.00')})+'&nbsp;<div class="unfold"></div>');

            $(".newjfPrice").html("-¥"+price);
        }

        $("#jfPrice").val(price);
        $("#jifenPrice").html(price);
    }

    function toDecimal2(x) {
        var f = parseFloat(x);
        if (isNaN(f)) {
            return false;
        }
        var f = Math.round(x*100)/100;
        var s = f.toString();
        var rs = s.indexOf('.');
        if (rs < 0) {
            rs = s.length;
            s += '.';
        }
        while (s.length <= rs + 2) {
            s += '0';
        }
        return s;
    }


    $(function(){
        /* 使用积分 */
        $('.use-points').click(function(){
            //$(this).toggleClass('on');
            $("#jifenError").text("");
            if($(".use-points").parent().find(".on").length>0){
                checkjifen($("#maxjf"));
            }else{
                $("#jifen").val('');
                checkjifen($("#jifen"));
            }
        });
        var newbossPrice=Subtr($("#bossPrice").val(),$("#bosscouponPrice").val());
        newbossPrice=toDecimal2(newbossPrice);
        if(jf<10){
            $("#jifenonjudeg").hide();
            $("#jfSmall").html("<span></span><span></span>暂不可用");
            $("#maxjf").val(0);
        }else if(newbossPrice<0.1){
            $("#jifenonjudeg").hide();
            $("#jfSmall").html("<span></span><span></span>暂不可用");
            $("#maxjf").val(0);
        }else if(Subtr(accDiv(accMul(bossPrice,10),pointset),jf)<0){
            //用户积分足够
            //运费
            if(newbossPrice.substr(-1)>0){
                //第二位小数>0
                $("#jfSmall").html("使用<span>"+parseInt(accDiv(accMul(bossPrice,10),pointset))+"</span>抵扣<span>¥"+accDiv(accMul(parseInt(accDiv(accMul(bossPrice,10),pointset)),pointset),10)+"</span>");
                $("#maxjf").val(parseInt(accDiv(accMul(bossPrice,10),pointset)));
            }else if($("#fPrice").val()>0 || $("#purchase").val()==1){
                //有运费或者含有抢购商品就无需支付0.1元
                $("#jfSmall").html("使用<span>"+parseInt(accDiv(accMul(bossPrice,10),pointset))+"</span>抵扣<span>¥"+accDiv(accMul(parseInt(accDiv(accMul(bossPrice,10),pointset)),pointset),10)+"</span>");
                $("#maxjf").val(parseInt(accDiv(accMul(bossPrice,10),pointset)));
            }else{
                $("#jfSmall").html("使用<span>"+Subtr(parseInt(accDiv(accMul(bossPrice,10),pointset)),10)+"</span>抵扣<span>¥"+Subtr(accDiv(accMul(parseInt(accDiv(accMul(bossPrice,10),pointset)),pointset),10),0.1)+"</span>");
                $("#maxjf").val(Subtr(parseInt(accDiv(accMul(bossPrice,10),pointset)),10));
            }
            //$("#jfSmall").html("使用<span>"+Subtr(parseInt(accDiv(accMul(bossPrice,10),pointset)),10)+"</span>抵扣<span>¥"+Subtr(accDiv(accMul(parseInt(accDiv(accMul(bossPrice,10),pointset)),pointset),10),0.1)+"</span>");
            //$("#jfSmall span").eq(0).html(parseInt(accDiv(accMul(bossPrice,10),pointset)));
            //$("#jfSmall span").eq(1).html(accDiv(accMul(parseInt(accDiv(accMul(bossPrice,10),pointset)),pointset),10));
            //$("#jfSmall").html("可用"+parseInt(accDiv(accMul(bossPrice,10),pointset))+"积分，抵扣¥"+accDiv(accMul(parseInt(accDiv(accMul(bossPrice,10),pointset)),pointset),10));
            //$("#maxjf").val(Subtr(parseInt(accDiv(accMul(bossPrice,10),pointset)),10));
        }else{
            $("#jfSmall").html("使用<span>"+parseInt(accMul(parseInt(accDiv(accAddInt(jf,0),10)),10))+"</span>抵扣<span>¥"+accDiv(parseInt(accMul(jf,pointset)),10)+"</span>");
            //$("#jfSmall span").eq(0).html(parseInt(accMul(parseInt(accDiv(accAddInt(jf,0),10)),10)));
            //$("#jfSmall span").eq(1).html(accDiv(parseInt(accMul(jf,pointset)),10));
            //$("#jfSmall").html("可用"+parseInt(accAd dInt(jf,0))+"积分，抵扣¥"+accDiv(accMul(jf,pointset),10));
            $("#maxjf").val(parseInt(accMul(parseInt(accDiv(accAddInt(jf,0),10)),10)));
        }
    });
    /* 显示隐藏的商品 */
    function showGoods(obj){
        var storeId=$(obj).find("input").val();
        if(storeId=='0'){
            $('.confirm-pro-item').show();
        }else{
            $('.goods'+storeId).show();
        }
        $(obj).remove();
    }

    //
    function validDeposit(obj){
        var pass = $(obj).val();
        if($(obj).val() != ''){
            $(".ok").removeClass("disabled");
//                depositdialog.reset();
        }else{
            $(".ok").addClass("disabled");
        }


    }

    function closeDialog(){
        dialog.getCurrent().close();
    }

</script>
<script>
    $(function() {
        $(".order-tage span").on("click", function () {
            var oMask = $('<div>').attr('id', 'mask').appendTo($('body'));
            var oTage = "<div id='tage'>";
            oTage += "<img class='bg' src='../images/v1/img/tage1.png' alt=''/>";
            oTage += "<div class='dec_txt'>由于您所购买的商品中包含零售商品，中国960官方商城的零售商品仅配送到960社区店。您可以选择添加一个社区店，并前往自提货品，或选择一家社区店，并附加您的个人地址，960社区店的工作人员将送货上门。</div>";
            oTage += "<img class='close_close' src='../images/v1/img/tage-close.png' alt=''/>";
            oTage += "</div>";
            $('body').append(oTage);
            $(".close_close,#mask").on("click", function () {
                $("#mask").remove();
                $("#tage").remove();
            })
        })
    });

    $(function() {
      $(".prodesc .title img").css({"float":"left"});
    })
    $(".question").on("click", function () {
        var question;
        question = dialog({
            width: 260,
            title: '提示',
            content: "1.100积分可抵扣1元现金 2.积分使用需为10的倍数",
            okValue: '我知道了',
            //cancelValue: '取消',
            ok: function () {
                <#--window.location.href="${basePath}/logout.html";-->
            }
            //cancel: function () {
                //return true;
            //}
        });
        question.showModal();
    })
</script>
<p style="display: none;">
    <!--友盟CNZZ统计-->
    <script src="https://s13.cnzz.com/z_stat.php?id=1264375679&web_id=1264375679" language="JavaScript">
        var _czc = _czc || [];
        _czc.push(["_setAccount", "m.ge960.com"]);
    </script>
</p>
</body>
</html>