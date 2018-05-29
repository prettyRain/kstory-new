<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>订单-<#if type?? && type='1'>待付款<#elseif  type?? && type='3'>待收货<#elseif  type?? && type='2'>待发货<#elseif  type?? && type='4'>待评价<#elseif  type?? && type='6'>待退款/退货<#else>全部</#if>订单</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="keywords" content="${seo.meteKey}">
    <meta name="description" content="${seo.meteDes}">
    <#assign basePath=request.contextPath>
    <link rel="stylesheet" href="${basePath}/css/style.min.css"/>
    <link rel="stylesheet" href="${basePath}/css/ui-dialog.css"/>
    <link rel="stylesheet" href="${basePath}/css/add-ons.min.css"/>
    <link rel="stylesheet" href="${basePath}/css/v2/order_list.css"/>
    <link rel="stylesheet" href="${basePath}/css/tip-newbox.css"/>
    <script src="${basePath}/js/jquery-1.10.1.js"></script>
    <script src="${basePath}/js/pageAction.js"></script>
    <script src="${basePath}/js/dialog-min.js"></script>
</head>
<body>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
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
    var localUrl = window.location.href;
    $(function(){
        $.ajax({
            url: "${basePath}/queryWxConfig.htm",
            type: "POST",
            data:{curUrl: localUrl},
            success: function (data) {
                console.info(data);
                wx.config({
                    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                    appId: data.appId, // 必填，公众号的唯一标识
                    timestamp: data.timestamp, // 必填，生成签名的时间戳
                    nonceStr: data.nonceStr, // 必填，生成签名的随机串
                    signature: data.signature,// 必填，签名，见附录1
                    jsApiList: ['onMenuShareAppMessage','onMenuShareTimeline'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
                });
            },
            async:false
        });
    });

    wx.ready(function () {
        wx.onMenuShareAppMessage({
            title: '中国960官方商城',
            desc: '中国960官方商城',
            link: 'http://m.ge960.com/',
            imgUrl: 'http://boss.ge960.com:80/upload/20170327/1490602121555.jpg'
        });

        wx.onMenuShareTimeline({
            title: '中国960官方商城',
            link: 'http://m.ge960.com/',
            imgUrl: 'http://boss.ge960.com:80/upload/20170327/1490602121555.jpg'
        });
    })
</script><#--自定义分享到朋友圈-->
<#assign vtitle="我的订单" />
<#assign backUrl="${basePath}/customercenter.html" />
<#include "/common/head_back.ftl"/>
<input type="hidden" id="type" value="${type!''}">
<input type="hidden" id="basePath" value="${basePath}">
<div id="seleted" class="content-block-menu">
    <div>
        <a href="${basePath}/customer/myorder.html" class="tab-link" name="0"><span class="tabbar-label">全部</span><i></i></a>
        <a href="${basePath}/customer/myorder-1-1.html" class="tab-link" name="1"><span class="tabbar-label">待付款</span><i></i></a>
        <a href="${basePath}/customer/myorder-2-1.html" class="tab-link" name="2"><span class="tabbar-label">待发货</span><i></i></a>
        <a href="${basePath}/customer/myorder-3-1.html" class="tab-link" name="3"><span class="tabbar-label">待收货</span><i></i></a>
        <a href="${basePath}/customer/myorder-4-1.html" class="tab-link" name="4"><span class="tabbar-label">待评价</span><i></i></a>
    </div>

</div>
<#assign giftCard=0>
<div class="order content-order-all" id="items">
<#if (pb.list?size!=0)>
    <#list pb.list as order>
        <#assign cFlag=0 />
        <#assign sFlag=0 />
        <#assign gFlag=0 />
        <#assign giftCard=0>
        <#if order.cancelRemark?? && order.cancelRemark = "该订单已拆分">
            <#assign goodsCount=0 />
            <div class="order-item">
            <#list pb.objectBean as obj >
                <#if obj.orderNo = order.orderNo>
                    <#list obj.splitList as order>
                        <#list order.goods as good>
                            <#assign goodsCount=goodsCount+good.goodsNum />
                        </#list>
                    </#list>
                </#if>
            </#list>
            <div class="order-number">
                <div class="list-item" style="border-bottom: 1px solid #ececec">
                    <h3 class="item-head">
                        <label for="">共<span>${goodsCount}</span>件</label>
                        <label for="" class="haspay">实付款：&yen;<span class="price">${(order.moneyPaid?string('0.00'))?split(".")[0]}.<i>${(order.moneyPaid?string('0.00'))?split(".")[1]}</i></span></label>
                    </h3>
                </div>
                    </div>
            <#list pb.objectBean as obj >
                <#if obj.orderNo = order.orderNo>
                    <#list obj.splitList as order>
                        <div>
                            <div class="order-number">
                                <div class="list-item">
                                    <h3 class="item-head"><#--<label for="">订单号：</label><span>${order.orderNo}</span>--><span>&nbsp;</span>
                                    <#--<i>${order.addTime?string("yyyy-MM-dd")}</i>-->
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
                                        <span class="curValue text-them">
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
                                                <#elseif (order.orderStatus=="4") >
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
                                                <#elseif order.orderStatus=="18">
                                                    交易关闭<#--退款成功-->
                                                </#if>
                                            </#if>
                    </span>
                                    </h3>
                                </div>
                            </div>
                            <div class="order-info">
                                <#if (order.goods?size>2)>
                                    <div class="list-body-box">
                                        <div class="list-item">
                                            <div class="box-body">
                                                <ul>
                                                    <#list order.goods as good>
                                                        <li>
                                                            <a href="${basePath}/customer/detail-${order.orderId}.html">
                                                                <img width="80" height="80" title="${(good.goodsName)!''}" alt="${(good.goodsName)!''}" src="${(good.goodsImg)!''}" />
                                                            </a>
                                                        </li>
                                                    </#list>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                <#else>
                                    <#list order.goods as good>
                                        <div class="list-body-line list-body-line2">
                                            <div class="list-item">
                                                <a href="${basePath}/customer/detail-${order.orderId}.html">
                                                    <#if good.goodsName??&& (good.goodsName?index_of("电子卡")!=-1 || good.goodsName?index_of("实体卡")!=-1)><#assign giftCard=giftCard+1></#if>

                                                    <div class="pro-item">
                                                        <div class="propic">
                                                            <img width="71" height="71" title="${(good.goodsName)!''}" alt="${(good.goodsName)!''}" src="${(good.goodsImg)!''}" />
                                                        </div>
                                                        <div class="prodesc">
                                                            <div class="left">
                                                                <h3 class="title"><#if good.isPresent?? && good.isPresent == '1'>
                                                                    <img src="../../images/v2/gift@2x.png" width="26" height="14" style="vertical-align: middle;margin-bottom: 3px;">
                                                                    <#--<span style="color: white;background-color: #81b119;display:inline;font-size: 12px;border-radius: 2px;">&nbsp;赠品&nbsp;</span>-->
                                                                </#if> ${good.goodsName!''}</h3>
                                                                <#--<span style="font-size: 0.8rem">商品编号：${good.goodsNo}</span>-->
                                                            </div>
                                                            <#--<#if (!good.countRush?? || good.countRush == 0 || (good.goodsNum - good.countRush != 0))>
                                                                <#if !good.countRush?? || good.countRush == 0>
                                                                    <div class="right"></div>
                                                                </#if>
                                                                <div class="right">
                                                                    <p class="price">
                                                                        <#if (good.countRush?? && good.countRush>0)>
                                                                            ￥${(good.goodsOldPrice?string('0.00'))?split(".")[0]}.<span>${(good.goodsOldPrice?string('0.00'))?split(".")[1]}</span>
                                                                        <#else>
                                                                            ￥${(good.goodsPrice?string('0.00'))?split(".")[0]}.<span>${(good.goodsPrice?string('0.00'))?split(".")[1]}</span>
                                                                        </#if>

                                                                    </p>
                                                                    <span class="pro-num">
                                                                        <#if (good.countRush?? && good.countRush>0)>
                                                                            x${good.goodsNum - good.countRush}
                                                                        <#else>
                                                                            x${good.goodsNum}
                                                                        </#if>
                                                                </span>
                                                                </div>
                                                            </#if>

                                                            <#if (good.countRush?? && good.countRush>0)>
                                                                <#if (good.goodsNum - good.countRush == 0)>
                                                                    <div class="right"></div>
                                                                </#if>
                                                                <div class="right">
                                                                    <p class="price">
                                                                        ￥${(good.goodsPrice?string('0.00'))?split(".")[0]}.<span>${(good.goodsPrice?string('0.00'))?split(".")[1]}</span>
                                                                    </p>
                                                                    <span class="pro-num">x${good.countRush}</span>
                                                                </div>
                                                            </#if>-->
                                                            <#if good.countRush?? && good.countRush?number != 0 && good.goodsNum?number gt good.countRush?number>
                                                                <div class="right">
                                                                    <p class="price">
                                                                        ￥${good.goodsOldPrice?string('0.00')?substring(0,good.goodsOldPrice?string('0.00')?index_of('.'))}<span >${good.goodsOldPrice?string('0.00')?substring(good.goodsOldPrice?string('0.00')?index_of('.'))}</span>
                                                                    </p>
                                                                    <span class="pro-num">
                                                                       ×${good.goodsNum?number - good.countRush?number}
                                                                     </span>
                                                                </div>
                                                                <div class="right">
                                                                    <p class="price">
                                                                        ￥${good.goodsPrice?string('0.00')?substring(0,good.goodsPrice?string('0.00')?index_of('.'))}<span >${good.goodsPrice?string('0.00')?substring(good.goodsPrice?string('0.00')?index_of('.'))}</span>
                                                                    </p>
                                                                    <span class="pro-num">
                                                                       ×${good.countRush}
                                                                    </span>

                                                                </div>
                                                            <#else>
                                                                <div class="right"></div>
                                                                <div class="right">
                                                                    <p class="price">
                                                                        ￥${good.goodsPrice?string('0.00')?substring(0,good.goodsPrice?string('0.00')?index_of('.'))}<span >${good.goodsPrice?string('0.00')?substring(good.goodsPrice?string('0.00')?index_of('.'))}</span>
                                                                    </p>
                                                                    <span class="pro-num">
                                                                      ×${good.goodsNum?number}
                                                                   </span>
                                                                </div>
                                                            </#if>
                                                        </div>
                                                    </div>
                                                </a>
                                            </div>
                                        </div>
                                    </#list>
                                </#if>
                            </div>
                            <div class="order-bottom">
                                <div class="list-item" style="padding: 0 10px;height: 35px;line-height: 35px;    overflow: hidden;">
                                    <#--<h3 class="item-head">-->
                                        <#--<label for="">实付款：</label><span class="pay-money">￥-->
                                        <#--<#if order.moneyPaid??>-->
                                        <#--${order.moneyPaid?string('0.00')}-->
                                        <#--</#if></span>-->
                                    <#--</h3>-->
                                    <div class="too-btn">
                                        <#if order.orderStatus??>
                                            <#--<#if order.orderStatus=="0">-->
                                                <#--&lt;#&ndash;<#if order.payId?? && order.payId==1>&ndash;&gt;-->
                                                    <#--<a href="${basePath}/orderdetailpay-${order.orderId}.html" class="btn pay-btn">1立即支付</a>-->
                                                <#--&lt;#&ndash;</#if>&ndash;&gt;-->
                                                <#--<a href="javascript:void(0);" class="btn" onClick="cancelOrder('${order.orderId}')">取消订单</a>-->
                                            <#--<#elseif (order.orderStatus=="2")>-->
                                                <#--<#list order.expressno as expressno>-->
                                                <#--&lt;#&ndash;<#if expressno_index==0>&ndash;&gt;-->
                                                <#--&lt;#&ndash;<a href="http://m.kuaidi100.com/index_all.html?type=${expressno.expressName!''}&postid=${expressno.expressNo!''}&callbackurl=${sys.bsetAddress}/mobile/customer/myorder-3-1.html" class="btn">查看物流</a>&ndash;&gt;-->
                                                <#--&lt;#&ndash;</#if>&ndash;&gt;-->
                                                <#--</#list>-->
                                                <#--<a href="javascript:void(0);" class="btn pay-btn" onClick="comfirmgoods('${order.orderId}')">1确认收货</a>-->
                                            <#--</#if>-->
                                            <#if isBackOrder==1>
                                                <#if order.orderStatus!="0">
                                                    <!--再次买 -->
                                                    <a href="javascript:void(0)" class="btn" onclick="addCar('${order.orderId}')">再次购买</a>
                                                </#if>
                                                <#if (order.orderStatus=="3")>
                                                <#-- <a href="javascript:void(0)" class="btn" onclick="addCar('${order.orderId}')">再次购买</a>-->
                                                    <#if (sFlag==0)>
                                                        <a class="btn"  href="javascript:;" onclick="timeBackOrder(${order.orderId})">申请退货</a>
                                                    </#if>
                                                    <#if (cFlag>0 && (gFlag<(order.goods)?size))>
                                                        <a  href="${basePath}/comment-${order.orderId}.html" class="<#if cFlag gt 0>btn<#else>btn-grey</#if> pay-btn">立即评价</a>
                                                    </#if>
                                                <#elseif order.orderStatus=="1"|| order.orderStatus=="4" || order.orderStatus=="5" || order.orderStatus=="6">
                                                <#-- <a href="javascript:void(0)" class="btn" onclick="addCar('${order.orderId}')">再次购买</a>-->
                                                <#elseif (order.orderStatus=="13" ||order.orderStatus=="15" ||order.orderStatus=="18") >${order.getGoodsTime}
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
                                                <#if ( order.orderStatus=="5" || order.orderStatus=="6") >
                                                    <a  href="${basePath}/customer/applybackgoods-${order.orderId}.html">申请退货</a>
                                                </#if>
                                                <#if order.orderStatus=="1" && giftCard == 0 && sFlag == 0>
                                                    <a  class="btn"  href="${basePath}/customer/mapplybackmoney-${order.orderId}.html">申请退款</a>
                                                </#if>
                                            <#elseif  isBackOrder==2>
                                                <#if (order.orderStatus=="3")>
                                                    <a  href="${basePath}/comment-${order.orderId}.html" class="<#if cFlag gt 0>btn<#else>btn-grey</#if>">评价</a>
                                                <#-- <a href="javascript:void(0)" class="btn" onclick="addCar('${order.orderId}')">再次购买</a>-->
                                                <#elseif order.orderStatus=="1"|| order.orderStatus=="4" || order.orderStatus=="5" || order.orderStatus=="6">
                                                <#--  <a href="javascript:void(0)" class="btn" onclick="addCar('${order.orderId}')">再次购买</a>-->
                                                </#if>
                                            </#if>
                                            <#if order.orderStatus=="0">
                                            <#--<#if order.payId?? && order.payId==1>-->
                                                <a href="${basePath}/orderdetailpay-${order.orderId}.html" class="btn pay-btn">立即支付</a>
                                            <#--</#if>-->
                                                <a href="javascript:void(0);" class="btn" onClick="cancelOrder('${order.orderId}',2)">取消订单</a>
                                            <#elseif (order.orderStatus=="2")>
                                                <#list order.expressno as expressno>
                                                <#--<#if expressno_index==0>-->
                                                <#--<a href="http://m.kuaidi100.com/index_all.html?type=${expressno.expressName!''}&postid=${expressno.expressNo!''}&callbackurl=${sys.bsetAddress}/mobile/customer/myorder-3-1.html" class="btn">查看物流</a>-->
                                                <#--</#if>-->
                                                </#list>
                                                <a href="javascript:void(0);" class="btn pay-btn" onClick="comfirmgoods('${order.orderId}',2)">确认收货</a>
                                            </#if>
                                        </#if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </#list>
                </#if>
            </#list>
        </div>
        <#else>
            <#assign goodsCount=0 />
            <div class="order-item">
            <div class="order-number">
                <div class="list-item">
                    <h3 class="item-head">
                        <#list order.goods as good>
                            <#assign goodsCount=goodsCount+good.goodsNum />
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
                        <label for="">共<span>${goodsCount}</span>件</label>
                        <label for="" class="haspay">实付款：&yen;<span class="price">${(order.moneyPaid?string('0.00'))?split(".")[0]}.<i>${(order.moneyPaid?string('0.00'))?split(".")[1]}</i></span></label>
                        <span class="curValue text-them">
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
                                <#elseif (order.orderStatus=="4") >
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
                                <#elseif order.orderStatus=="18">
                                    交易关闭<#--退款成功-->
                                </#if>
                            </#if>
                    </span>
                    </h3>
                </div>
            </div>
            <div class="order-info">
                <#if (order.goods?size>2)>
                    <div class="list-body-box">
                        <div class="list-item" style="padding: 10px 5px 0 5px">
                            <div class="box-body">
                                <ul>
                                    <#list order.goods as good>
                                        <li>
                                            <a href="${basePath}/customer/detail-${order.orderId}.html">
                                                <img width="80" height="80" title="${(good.goodsName)!''}" alt="${(good.goodsName)!''}" src="${(good.goodsImg)!''}" />
                                            </a>
                                        </li>
                                    </#list>
                                </ul>
                            </div>
                        </div>
                    </div>
                <#else>
                    <#list order.goods as good>
                        <div class="list-body-line list-body-line2">
                            <div class="list-item">
                                <a href="${basePath}/customer/detail-${order.orderId}.html">
                                    <div class="pro-item">
                                        <div class="propic">
                                            <img width="71" height="71" title="${(good.goodsName)!''}" alt="${(good.goodsName)!''}" src="${(good.goodsImg)!''}" />
                                        </div>
                                        <#if good.goodsName??&& (good.goodsName?index_of("电子卡")!=-1 || good.goodsName?index_of("实体卡")!=-1)><#assign giftCard=giftCard+1></#if>

                                        <div class="prodesc">
                                            <div class="left">
                                                <h3 class="title"><#if good.isPresent?? && good.isPresent == '1'>
                                                    <img src="../../images/v2/gift@2x.png" width="26" height="14" style="vertical-align: middle;margin-bottom: 3px;">
                                                    <#--<span style="color: white;background-color: #81b119;display:inline;font-size: 10px;border-radius: 2px;">&nbsp;赠品&nbsp;</span>-->
                                                </#if> ${good.goodsName!''}</h3>
                                                <#--<span style="font-size: 0.8rem">商品编号：${good.goodsNo}</span>-->
                                            </div>

                                       <#--     <#if (!good.countRush?? || good.countRush == 0 || (good.goodsNum - good.countRush != 0))>
                                            <#if !good.countRush?? || good.countRush == 0>
                                                <div class="right"></div>
                                            </#if>
                                            <div class="right">
                                                <p class="price">
                                                    <#if (good.countRush?? && good.countRush>0)>
                                                        ￥${(good.goodsOldPrice?string('0.00'))?split(".")[0]}.<span>${(good.goodsOldPrice?string('0.00'))?split(".")[1]}</span>
                                                    <#else>
                                                        ￥${(good.goodsPrice?string('0.00'))?split(".")[0]}.<span>${(good.goodsPrice?string('0.00'))?split(".")[1]}</span>
                                                    </#if>

                                                </p>
                                                <span class="pro-num">
                                                <#if (good.countRush?? && good.countRush>0)>
                                                    x${good.goodsNum - good.countRush}
                                                <#else>
                                                    x${good.goodsNum}
                                                </#if>
                                                </span>
                                            </div>
                                                </#if>

                                            <#if (good.countRush?? && good.countRush>0)>
                                                <#if (good.goodsNum - good.countRush == 0)>
                                                    <div class="right"></div>
                                                </#if>
                                            <div class="right">
                                                    <p class="price">
                                                        ￥${(good.goodsPrice?string('0.00'))?split(".")[0]}.<span>${(good.goodsPrice?string('0.00'))?split(".")[1]}</span>
                                                    </p>
                                                    <span class="pro-num">x${good.countRush}</span>
                                            </div>
                                            </#if>-->
                                            <#if good.countRush?? && good.countRush?number != 0 && good.goodsNum?number gt good.countRush?number>
                                                <div class="right">
                                                    <p class="price">
                                                        ￥${good.goodsOldPrice?string('0.00')?substring(0,good.goodsOldPrice?string('0.00')?index_of('.'))}<span >${good.goodsOldPrice?string('0.00')?substring(good.goodsOldPrice?string('0.00')?index_of('.'))}</span>
                                                    </p>
                                                    <span class="pro-num">
                                                        ×${good.goodsNum?number - good.countRush?number}
                                                    </span>
                                                </div>
                                                <div class="right">
                                                    <p class="price">
                                                        ￥${good.goodsPrice?string('0.00')?substring(0,good.goodsPrice?string('0.00')?index_of('.'))}<span >${good.goodsPrice?string('0.00')?substring(good.goodsPrice?string('0.00')?index_of('.'))}</span>
                                                    </p>
                                                    <span class="pro-num">
                                                        ×${good.countRush}
                                                    </span>

                                                </div>
                                            <#else>
                                                <div class="right"></div>
                                                <div class="right">
                                                    <p class="price">
                                                        ￥${good.goodsPrice?string('0.00')?substring(0,good.goodsPrice?string('0.00')?index_of('.'))}<span >${good.goodsPrice?string('0.00')?substring(good.goodsPrice?string('0.00')?index_of('.'))}</span>
                                                    </p>
                                                    <span class="pro-num">
                                                        ×${good.goodsNum?number}
                                                    </span>
                                                </div>
                                            </#if>

                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </#list>
                </#if>
            </div>
            <div class="order-bottom">
                <div class="list-item"  style="padding: 0 10px;height: 35px;line-height: 35px;    overflow: hidden;">
                    <#--<h3 class="item-head">-->
                        <#--<label for="">实付款：</label><span class="pay-money">￥-->
                        <#--<#if order.moneyPaid??>-->
                        <#--${order.moneyPaid?string('0.00')}-->
                        <#--</#if></span>-->
                    <#--</h3>-->
                    <div class="too-btn">
                        <#if order.orderStatus??>
                            <#if order.orderStatus=="0">
                                <a href="javascript:void(0);" class="btn" onClick="cancelOrder('${order.orderId}',2)">取消订单</a>
                                <a href="javascript:void(0)" class="btn" onclick="addCar('${order.orderId}',2)">再次购买</a>
                                <#--<#if order.payId?? && order.payId==1>-->
                                    <a href="${basePath}/orderdetailpay-${order.orderId}.html" class="btn pay-btn">立即支付</a>
                                <#--</#if>-->
                            <#elseif (order.orderStatus=="2")>
                                <#list order.expressno as expressno>
                                    <#--<#if expressno_index==0>-->
                                        <#--<a href="http://m.kuaidi100.com/index_all.html?type=${expressno.expressName!''}&postid=${expressno.expressNo!''}&callbackurl=${sys.bsetAddress}/mobile/customer/myorder-3-1.html" class="btn">查看物流</a>-->
                                    <#--</#if>-->
                                </#list>
                                <a href="javascript:void(0)" class="btn" onclick="addCar('${order.orderId}')">再次购买</a>
                                <a href="javascript:void(0);" class="btn pay-btn" onClick="comfirmgoods('${order.orderId}',2)">确认收货</a>
                            </#if>
                            <#if isBackOrder==1>
                                <#if (order.orderStatus=="3")>

                                    <a href="javascript:void(0)" class="btn" onclick="addCar('${order.orderId}')">再次购买</a>
                                    <#if (sFlag==0)>
                                    <a class="btn"  href="javascript:;" onclick="timeBackOrder(${order.orderId})">申请退货</a>
                                    </#if>
                                    <#if (cFlag>0 && (gFlag<(order.goods)?size))>
                                    <a  href="${basePath}/comment-${order.orderId}.html" class="btn pay-btn">立即评价</a>
                                    </#if>
                                <#elseif order.orderStatus=="1"|| order.orderStatus=="4" || order.orderStatus=="5" || order.orderStatus=="6">
                                 <#--<a href="javascript:void(0)" class="btn" onclick="addCar('${order.orderId}')">再次购买</a>-->
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
                                <#if ( order.orderStatus=="5" || order.orderStatus=="6") >
                                    <a href="javascript:void(0)" class="btn" onclick="addCar('${order.orderId}')">再次购买</a>
                                    <a  href="${basePath}/customer/applybackgoods-${order.orderId}.html">申请退货</a>
                                </#if>
                                <#if order.orderStatus=="1">
                                    <a href="javascript:void(0)" class="btn" onclick="addCar('${order.orderId}')">再次购买</a>
                                    <#if  giftCard == 0 && sFlag == 0>
                                    <a  class="btn"  href="${basePath}/customer/mapplybackmoney-${order.orderId}.html">申请退款</a>
                                    </#if>
                                </#if>
                            <#elseif  isBackOrder==2>
                                <#if (order.orderStatus=="3")>
                                    <#if (cFlag>0 && (gFlag<(order.goods)?size))>
                                    <a  href="${basePath}/comment-${order.orderId}.html" class="<#if cFlag gt 0>btn<#else>btn-grey</#if> pay-btn">立即评价</a>
                                    </#if>
                                 <a href="javascript:void(0)" class="btn" onclick="addCar('${order.orderId}')">再次购买</a>
                                <#elseif order.orderStatus=="1"|| order.orderStatus=="4" || order.orderStatus=="5" || order.orderStatus=="6">
                                  <a href="javascript:void(0)" class="btn" onclick="addCar('${order.orderId}')">再次购买</a>
                                </#if>
                            </#if>
                        </#if>
                    </div>
                </div>
            </div>
        </div>
        </#if>
    </#list>
<#else>
    <div class="no-orders">
        <div class="list-item">
            <i class="dingdan"></i>
            <h3> 暂无订单</h3>
            <#--<p>再去逛逛吧~</p>-->
        </div>
        <#--<div class="list-item">-->
            <#--<a class="btn btn-full" href="${basePath}/main.html">去逛逛</a>-->
        <#--</div>-->
    </div>
</#if>
</div>
<div class="list-loading" id="showmore"  style="display:block" >
    <#--<img alt="" src="${basePath}/images/loading.gif">-->
    <span>&nbsp;</span>
</div>



<div class="opacity-bg-1" style="display:none"></div>
<input id="payOrderId" value="" type="hidden">
<input id="status" value="0" type="hidden">

<div class="tip-box" id="confirm_order" style="display:none">
    <div class="tip-body2">
        <h3 id="tiptitle">是否确认收货？</h3>
        <div class="btn-group">
            <a class="btn btn-grey" href="javascript:;" onclick="cancelComfirmGoods()">取&nbsp;消</a>
            <a class="btn btn-them" href="javascript:;" onclick="comfirmGoodsSucc()">确&nbsp;定</a>
        </div>
    </div>
</div>

<form class="fill-flow-form" style="display:none;" id="fillForm">
    <input type="hidden" id="orderNo" name="orderNo" value=""/>
    <div class="list-item">
        <h3 class="item-head pr0"><label for="">物流公司</label>
        </h3>
        <div class="list-value">
            <div class="shuoming">
                <input type="text" class="text" placeholder="请填写正确的物流公司" name="wlname" id="wlname" onBlur="wuliuname()">
                <label id="yanzhengname"></label>
            </div>
        </div>
    </div>
    <div class="list-item">
        <h3 class="item-head pr0"><label for="">物流单号</label>
        </h3>
        <div class="list-value">
            <div class="shuoming">
                <input type="text" class="text" placeholder="请填写准确的物流单号"  name="wlno" id="wlno" onBlur="wuliudanhao()">
                <label id="yanzhengno"></label>
            </div>
        </div>
    </div>
</form>
<script src="${basePath}/js/tip-newbox.js"/></script>
<script src="${basePath}/js/customer/myorder.js"></script>
<script>

    $(function(){
        $(".content-block-menu a[name=${type}]").addClass("active").siblings().removeClass("active");
    });

    var falg = "go";//数据请求回来后才允许继续发起ajax
    $(window).scroll(function(){
        if($(this).scrollTop() >= ($('body').height() - $(window).height()) && falg=="go"){
            falg="done";
            show();
        }
    });

</script>
</body>

</html>