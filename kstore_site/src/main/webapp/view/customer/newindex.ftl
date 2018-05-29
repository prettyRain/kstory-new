<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>会员中心-${topmap.systembase.bsetName}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="Keywords" content="${topmap.seo.meteKey}">
    <meta name="description" content="${topmap.seo.meteDes}">
<#assign basePath=request.contextPath>
<#if (topmap.systembase.bsetHotline)??>
    <link rel = "Shortcut Icon" href="${(topmap.systembase.bsetHotline)!''}">
<#else>
    <link rel = "Shortcut Icon" href="${basePath}/images/Paistore.ico">
</#if>
    <link rel="stylesheet" type="text/css" href="${basePath}/css/pages.css"/>
    <#--shf-->
    <link rel="stylesheet" href="${basePath}/index_960/css/style.css"/>
    <style>
        .section_headerTop{
       /*     background: none!important;*/
            border-bottom: none!important;
        }

        .que-delete img {  margin-left: 20px; }
        .rightpar{
            display: none;
        }
        .nochange{
            cursor: default;
        }
        .active{
            font-size: 14px;
            color: #199301!important;
            letter-spacing: 0.58px;
            font-weight: bold;
        }
    </style>
</head>
<script type="text/javascript" src="${basePath}/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${basePath}/index_960/js/app.js"></script>
<body>
<#--一引入头部 <#include "/index/topnew.ftl" />  -->
<#--shf-->
<#assign giftCard=0>
<#include "../index/newheader3.ftl"/>
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
        <#--<#include "../index/newtop8.ftl">-->
    <#--<#elseif (topmap.temp.tempId==16)>-->
        <#--<#include "../index/newtop11.ftl">-->
    <#--<#elseif (topmap.temp.tempId==17)>-->
        <#--<#include "../index/newtop12.ftl">-->
    <#--<#elseif (topmap.temp.tempId==18)>-->
        <#--<#include "../index/newtop13.ftl">-->
    <#--<#elseif (topmap.temp.tempId==19)>-->
        <#--<#include "../index/newtop14.ftl">-->
    <#--<#elseif (topmap.temp.tempId==20)>-->
        <#--<#include "../index/newtop15.ftl">-->
    <#--<#elseif (topmap.temp.tempId==21)>-->
        <#--<#include "../index/newtop21.ftl">-->
    <#--<#else>-->
        <#--<#include "../index/newtop.ftl"/>-->
    <#--</#if>-->
<#--</#if>-->

<#--<#include "newtop.ftl"/>-->

<#--shf background: #fff;-->
<div style="background: #fff;">
    <div class="container clearfix pt20 pb10">
        <#include "newleftmenu.ftl" />
      <!--new_member_left-->
            <iframe name="hidden_frame" style="display:none"></iframe>
        <div class="new_member-right">
            <div class="mod-main clearfix">
                <div class="mod-main-left fl clearfix">
                    <div class="mod_img fl">
                        <form id="upload_form${customer.customerId}" name="upload_form" method="post" enctype="multipart/form-data" action="${basePath}/uploadimg.htm?customerId=${customer.customerId}" target="hidden_frame">
                        <img style="cursor:pointer;" src="<#if customer.customerImg??>
							<#if customer.customerImg==''>
							    <#--${basePath}/images/default_head3.jpg-->
							    ${basePath}/images/head@2x.png
							<#else>
								${(customer.customerImg)!''}
							</#if>
						<#else>
							 <#--${basePath}/images/default_head3.jpg-->
							 ${basePath}/images/head@2x.png
						</#if>" width="87" height="87" id="customer_imgs"/>
                        <#--<p><a class=" upload_file">修改头像</a></p>-->
                        <input type="file" class="upload_file" id="imageFile" name="shareFile" customer_id="${customer.customerId}" style="cursor: pointer;width:87px;height:87px;top:0;left:0;filter:alpha(opacity=0);-moz-opacity:0.5;-khtml-opacity: 0;opacity: 0;position:absolute;z-index:98;font-size:0;">
                       </form>
                    </div>
                    <div class="mod-sugar fl ml10 " style="margin-left: 13px;margin-top: 16px;">
                        <div class="title"><#if customer.customerNickname??><#if customer.customerNickname=='0'><#else>${customer.customerNickname}</#if></#if></div>

                        <p class="mt10" style="background-color:#F1F1F1;font-size: 12px;color: #000000;letter-spacing: 0.5px;text-align: center;padding-left:0;border-radius: 100px; background-image: none;width: 74px;height: 31px;line-height: 32px;">${customer.pointLevelName!''}</p>

                     <#--   <div class="mod-icon pt10">
                            <a href="${basePath}/customer/securitycenter.html" class="pr10"><i><img src="${basePath}/images/mail.png"/></i>邮箱绑定</a>
                            &lt;#&ndash;<a href="#"><i><img src="../../images/mobile.png"/></i>设置支付密码</a>&ndash;&gt;
                        </div>-->
                    </div>
                    <div class="mod-safe mt10" style="display: inline-block;">账户安全：<span style="float:right;font-size: 14px;color: #199301;font-weight:bold;letter-spacing: 0.47px;" class="pl20"><#if  cust.isEmail == '0' &&  cust.isMobile == '0'>低<#elseif (cust.isEmail == '1' &&  cust.isMobile == '0') || (cust.isEmail == '0' &&  cust.isMobile == '1')>中<#elseif cust.isEmail == '1' &&  cust.isMobile == '1'>高</#if></span><div class="n_per_bar"><span style="width:<#if  cust.isEmail == '0' &&  cust.isMobile == '0'>33%<#elseif (cust.isEmail == '1' &&  cust.isMobile == '0') || (cust.isEmail == '0' &&  cust.isMobile == '1')>66%<#elseif cust.isEmail == '1' &&  cust.isMobile == '1'>100%</#if> "></span></div></div>
                </div>
                <div class="mod-main-mid fl">
                    <ul class="clearfix">
                        <li>
                            <i><img src="${basePath}/images/btn_daichuli@2x.png" width="25" /></i><br/>
                            <a
                            <#if notice.onDealNum != 0>
                                    class="active" target="_blank" href="${basePath}/customer/myorder-0-0-1.html"
                            <#else>
                                    href="javascript:void(0)" class="nochange"
                            </#if>
                                    >待处理<span>${notice.onDealNum!'0'}</span></a>
                        </li>
                        <li>
                            <i><img src="${basePath}/images/btn_daishouhuo@2x.png" width="25" style="margin-top: 3px;"/></i><br/>
                            <a
                            <#if notice.onReceiptNum != 0>
                                    class="active" target="_blank" href="${basePath}/customer/myorder-0-0-1.html"
                            <#else>
                                    href="javascript:void(0)" class="nochange"
                            </#if>
                                    >待收货<span>${notice.onReceiptNum!'0'}</span></a>
                        </li>
                        <li>
                            <i><img src="${basePath}/images/btn_daiziti@2x.png" width="25"/></i><br/>
                            <a
                            <#if notice.onMyNum != 0>
                                    class="active" target="_blank" href="${basePath}/customer/myorder-0-0-1.html"
                            <#else>
                                    href="javascript:void(0)" class="nochange"
                            </#if>
                                    >待自提<span>${notice.onMyNum!'0'}</span></a>
                        </li>
                        <li>
                            <i><img src="${basePath}/images/btn_daipingjia@2x.png" width="25" /></i><br/>
                            <a
                            <#if notice.commentNum != 0>
                                    class="active" target="_blank" href="${basePath}/customer/myorder-0-3-1.html"
                            <#else>
                                    href="javascript:void(0)" class="nochange"
                            </#if>
                                    >待评价<span>${notice.commentNum!'0'}</span></a>
                        </li>
                    </ul>
                </div>
                <div class="mod-main-rig">
                    <dl class="clearfix">
                       <#-- <dt>我的关注：</dt>-->
                        <dd>降价商品（<a<#if notice.reduceNum != 0>
                            class="active" target="_blank" href="${basePath}/customer/myfollw.html"
                        <#else>
                            href="javascript:void(0)" class="nochange"
                        </#if>
                            >${notice.reduceNum!'0'}</a>）</dd>
                        <#--<dd>新到货商品（<a-->
                        <#--<#if notice.goodsArriveNum != 0>-->
                                <#--class="active" target="_blank" href="${basePath}/customer/myfollw.html"-->
                        <#--<#else>-->
                                <#--href="javascript:void(0)"-->
                        <#--</#if>-->
                                <#-->${notice.goodsArriveNum!'0'}</a>）</dd>-->
                        <dd>关注商品（<a
                        <#if notice.activityGoodsNum != 0>
                                class="active" target="_blank" href="${basePath}/customer/myfollw.html"
                        <#else>
                                href="javascript:void(0)" class="nochange"
                        </#if>
                                >${notice.activityGoodsNum!'0'}</a>）</dd>
                    </dl>
                    <dl class="clearfix">
                        <#--<dt>消息中心：</dt>-->
                        <dd>提醒通知（<a <#if notice.noReadInsideNum != 0>
                            class="active" href="/customer/insideletter.html"
                        <#else>
                            href="javascript:void(0)" class="nochange"
                        </#if>
                            >${notice.noReadInsideNum!'0'}</a>）</dd>
                        <dd>咨询回复（<a
                        <#if notice.noReadNum != 0>
                                class="active" href="/customer/consult.html"
                        <#else>
                                href="javascript:void(0)" class="nochange"
                        </#if>
                                >${notice.noReadNum!'0'}</a>）</dd>
                    </dl>
                    <dl class="clearfix">
                        <#--<dt>预存款：</dt>-->
                        <dt>礼品卡账户余额：</dt>
                        <dd style="margin-left: 9px;"><a class="active" target="_blank" href="${basePath}/deposit/mydeposit.htm"><b>￥${(deposit.preDeposit+deposit.freezePreDeposit)?string('0.00')}</b></a></dd>
                    </dl>
                    <dl class="clearfix">
                        <dt>我的积分：</dt>
                        <dd style="margin-left: 56px;"><a class="active" target="_blank" href="${basePath}/customer/myintegral.html"><b>${customer.infoPointSum!'0'}</b>积分</a></dd>
                    </dl>
                    <dl class="clearfix">
                        <dt>优惠券：</dt>
                        <dd style="    margin-left: 71px;" ><a
                        <#if couponNum != 0>
                                class="active" target="_blank" href="${basePath}/mycoupon-1.html"
                        <#else>
                                href="javascript:void(0);" class="nochange"
                        </#if>
                        ><b>${couponNum}</b>张</a></dd>
                    </dl>
                </div>
            </div>
            <div class="mod-order mt20">
                <div class="tc-title clearfix">
                    <a href="${basePath}/customer/myorder.html">查看全部订单</a>我的订单
                </div>
                <div class="content pl20 pr20 pb20">
                    <div class="layout">
                    <table class="bought-table mt10">
                        <thead>
                        <tr>
                            <th width="420">订单信息</th>
                            <th>收货人</th>
                            <th>订单状态</th>
                            <th>支付金额</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                    <#if (pb.list?size!=0)>
                        <#list pb.list as order>
                        <#if (order_index<4)>
                            <tbody>
                            <tr class="sep-row">
                                <td colspan="5"></td>
                            </tr>
                            <tr class="order-hd">
                                <td class="first">
                                    <span>订单编号: ${order.orderNo!''}</span>
                                    <span>下单时间：<#if order.addTime??>
                                    ${order.addTime?string("yyyy-MM-dd HH:mm:ss")?substring(0,10)}
                                    </#if></span>
                                </td>
                                <td colspan="4">
                                    <div class="fr mr20">
                                        <#if order.orderStatus=='3' || order.orderStatus=='4'>
                                            <a href="javascript:;"  onclick="showDialogs('${order.orderId}');"><img src="${basePath}/images/delete1.png" width="11" height="15"/></a>
                                        </#if>

                                    </div>
                                </td>
                            </tr>
                            <#if order.cancelRemark?? && order.cancelRemark = "该订单已拆分">
                                <#list pb.objectBean as obj >
                                    <#if obj.orderNo = order.orderNo>
                                        <#list obj.splitList as order>
                                        <tr class="order-bd">
                                            <td class="baobei">
                                                <#assign cFlag=0 />
                                                <#assign sFlag=0 />
                                                <#assign gFlag=0 />
                                                <#list order.goods as good>
                                                    <#if good.evaluateFlag== '0'>
                                                        <#assign cFlag=cFlag+1 />
                                                    </#if>
                                                    <#--订单商品状态为1退货申请、2待商家收货、3退货成功-->
                                                    <#if good.orderGoodsStatus?? && good.orderGoodsStatus != '0'>
                                                        <#assign sFlag=sFlag+1 />
                                                    </#if>
                                                    <#--订单商品状态为3退货成功、5退款成功-->
                                                    <#if good.orderGoodsStatus?? && (good.orderGoodsStatus == '3' || good.orderGoodsStatus == '5')>
                                                        <#assign gFlag=gFlag+1 />
                                                    </#if>
                                                    <#if order.orderStatus??>
                                                        <div style="height:110px;">
                                                            <#if good.goodsName??&& (good.goodsName?index_of("电子卡")!=-1 || good.goodsName?index_of("实体卡")!=-1)><#assign giftCard=giftCard+1></#if>
                                                            <a target="_blank" class="pic" title="${good.goodsName!''}" href="${basePath}/item/${good.goodsId}.html"><img width="100" height="100" title="${(good.goodsName)!''}" alt="${(good.goodsName)!''}" src="${(good.goodsImg)!''}" /></a>
                                                            <div class="desc ml20">
                                                                <a href="${basePath}/item/${good.goodsId}.html" class="name"><#if good.isPresent?? && good.isPresent=="1"><span style="color: white;background-color: lightgrey;">&nbsp;赠品&nbsp;</span>&nbsp;</#if>${good.goodsName!''}<#--<#if  good.backFlag??&&good.backFlag=='1'><span style="color:red;">(已退货)</span></#if>--></a>
                                                                <p class="col9">
                                                                    <#list good.specVo as specVo>
                                                                    ${specVo.spec.specName}:<#if specVo.specValueRemark??>${specVo.specValueRemark}<#else>${specVo.goodsSpecDetail.specDetailName!''} </#if>&nbsp;
                                                                    </#list>
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </#if>

                                                </#list>
                                            </td>
                                            <td>
                                                <#if order.shippingPerson??>
                                        ${order.shippingPerson}
									</#if>
                                            </td>
                                            <td>
                                        <span href="#" class="red">
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
                                                    <#if order.orderExpressType??&&order.orderExpressType=='1'>
                                                        待自提
                                                    <#else>
                                                        已发货
                                                    </#if>
                                                <#elseif order.orderStatus=="3">
                                                    交易完成
                                                <#elseif order.orderStatus=="4">
                                                    交易关闭
                                                <#elseif order.orderStatus=="7">
                                                    退货审核
                                                <#elseif order.orderStatus=="8">
                                                    同意退货
                                                <#elseif order.orderStatus=="9">
                                                    拒绝退货
                                                <#elseif order.orderStatus=="10">
                                                    <#--待商家收货-->
                                                同意退货，请等待我们与您联系
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
                                        </span><br/>
                                                <a  target="_blank" href="${basePath}/customer/detail-${order.orderId}.html" class="blue" style="line-height:150%;">查看订单</a>
                                            </td>
                                            <td>
                                    <span class="red fb f14">￥ <#if order.moneyPaid??>
                                    ${order.moneyPaid?string('0.00')}
                                    </#if></span><br/>
                                                <span class="col9" style="line-height:150%;"><#if order.orderLinePay??>
                                                    <#if order.orderLinePay=="1">

                                                        在线支付

                                                    <#elseif order.orderLinePay=="0">

                                                        货到付款

                                                    </#if>
                                                </#if></span>
                                            </td>
                                            <td>
                                                <#if (order.orderStatus=="11") >
                                                    <a class="buy-again" href="${basePath}/customer/backdetail.htm?orderId=${order.orderId}">退货详情</a><br/>
                                                </#if>

                                                <#if ( order.orderStatus=="5" || order.orderStatus=="6") >
                                                    <a  class="buy-again" href="javascript:void(0)" onclick="timeBackOrder(${order.orderId})">申请退货</a><br/>
                                                </#if>

                                                <#if (order.orderStatus=="1" && isBackOrder==1 && giftCard == 0 && sFlag == 0) >
                                                    <a  class="buy-again"  href="${basePath}/customer/applybackmoneyprice.htm?orderId=${order.orderId}">申请退款</a><br/>
                                                </#if>

                                                <#if order.orderStatus=="0">
                                                    <#if order.orderLinePay='1'>
                                                        <a class="buy-again"  target="_blank" href="${basePath}/gopayorder-${order.orderId}.html">去付款</a><br/>
                                                    </#if>
                                                    <a class="buy-again"  href="javascript:void(0)" onclick="cancelOrder('${basePath}/customer/cancelorder-myorder-${order.orderId}.html','${order.orderId}')">取消订单</a><br/>
                                                <#elseif order.orderStatus=="2">
                                                    <a class="buy-again"  href="javascript:void(0)" onclick="comfirmgoods('${basePath}/customer/comfirmofgoods-myorder-${order.orderId}.html')"  >确认收货</a><br/>
                                                </#if>
                                                <#if isBackOrder==1>
                                                    <#if (order.orderStatus=="3" && cFlag>0  && (gFlag<(order.goods)?size)) >
                                                        <a  style="line-height:200%;" target="_blank" href="${basePath}/comment-${order.orderId}.html">评论晒单</a><br/>
                                                        <#if (sFlag==0)>
                                                        <a  class="buy-again" href="javascript:void(0)" onclick="timeBackOrder(${order.orderId})">申请退货</a><br/>
                                                        </#if>
                                                    </#if>
                                                    <#if (order.orderStatus=="3" && cFlag==0  && (gFlag<(order.goods)?size)) >
                                                        <#if (order.orderStatus=="3" && order.shareFlag >0)>
                                                            <a  style="line-height:200%;" target="_blank" href="${basePath}/comment-${order.orderId}.html">发表晒单</a><br/>
                                                        </#if>
                                                        <#if (sFlag==0)>
                                                        <a  class="buy-again"  href="javascript:void(0)" onclick="timeBackOrder(${order.orderId})">申请退货</a><br/>
                                                        </#if>
                                                    </#if>
                                                    <#if (order.orderStatus=="8") >
                                                        <a  class="buy-again"  href="javascript:void(0)" onclick="setwuliu('${order.orderNo}')">填写物流信息</a><br/>
                                                    </#if>
                                                    <#if (

                                                    order.orderStatus=="7" ||
                                                    order.orderStatus=="8" ||
                                                    order.orderStatus=="9" ||
                                                    order.orderStatus=="10" ||
                                                    order.orderStatus=="14" ||
                                                    order.orderStatus=="16" ||
                                                    order.orderStatus=="17" ||
                                                    order.orderStatus=="12"
                                                    )
                                                    >
                                                        <a class="buy-again" href="${basePath}/customer/backdetail.htm?orderId=${order.orderId}">退货详情</a><br/>
                                                    </#if>

                                                    <#if (order.orderStatus=="13" ||
                                                    order.orderStatus=="15" ||
                                                    order.orderStatus=="18")>
                                                        <#if order.getGoodsTime??>
                                                            <a class="buy-again" href="${basePath}/customer/backdetail.htm?orderId=${order.orderId}">退货详情</a><br/>
                                                        <#else>
                                                            <a class="buy-again" href="${basePath}/customer/backdetailprice.htm?orderId=${order.orderId}">退款详情</a><br/>
                                                        </#if>
                                                    </#if>
                                                <#elseif isBackOrder==2>
                                                    <#if (order.orderStatus=="3" && cFlag>0  && (gFlag<(order.goods)?size)) >
                                                        <a  style="display:initial;" target="_blank" href="${basePath}/comment-${order.orderId}.html">评论晒单</a><br/>
                                                    </#if>
                                                    <#if (order.orderStatus=="3" && cFlag==0  && (gFlag<(order.goods)?size)) >
                                                        <#if (order.orderStatus=="3" && order.shareFlag >0)>
                                                            <a  style="display:initial;" target="_blank" href="${basePath}/comment-${order.orderId}.html">评论晒单</a><br/>
                                                        </#if>
                                                    </#if>
                                                </#if>
                                                <a  class="buy-again againbuy" data-id="${order.orderId}" href="javascript:;">再次购买</a><br/>
                                            </td>
                                        </tr>
                                        </#list>
                                    </#if>
                                </#list>
                            <#else>
                            <tr class="order-bd">
                                <td class="baobei">
                                    <#assign cFlag=0 />
                                    <#assign sFlag=0 />
                                    <#assign gFlag=0 />
                                    <#list order.goods as good>
                                        <#if good.evaluateFlag== '0'>
                                            <#assign cFlag=cFlag+1 />
                                        </#if>
                                        <#--订单商品状态为1退货申请、2待商家收货、3退货成功-->
                                        <#if good.orderGoodsStatus?? && good.orderGoodsStatus!= '0'>
                                            <#assign sFlag=sFlag+1 />
                                        </#if>
                                        <#--订单商品状态为3退货成功、5退款成功-->
                                        <#if good.orderGoodsStatus?? && (good.orderGoodsStatus == '3' || good.orderGoodsStatus == '5')>
                                            <#assign gFlag=gFlag+1 />
                                        </#if>
                                    <div style="height:110px;">
                                        <#if good.goodsName??&& (good.goodsName?index_of("电子卡")!=-1 || good.goodsName?index_of("实体卡")!=-1)><#assign giftCard=giftCard+1></#if>
                                        <a target="_blank" class="pic" title="${good.goodsName!''}" href="${basePath}/item/${good.goodsId}.html"><img width="100" height="100" title="${(good.goodsName)!''}" alt="${(good.goodsName)!''}" src="${(good.goodsImg)!''}" /></a>
                                        <div class="desc ml20">
                                            <a href="#" class="name"><#if good.isPresent?? && good.isPresent=="1"><span style="color: white;background-color: lightgrey;">&nbsp;赠品&nbsp;</span>&nbsp;</#if>${good.goodsName!''}<#--<#if  good.backFlag??&&good.backFlag=='1'><span style="color:red;">(已退货)</span></#if>--></a>
                                            <p class="col9">
                                                <#list good.specVo as specVo>
                                                ${specVo.spec.specName}:<#if specVo.specValueRemark??>${specVo.specValueRemark}<#else>${specVo.goodsSpecDetail.specDetailName!''} </#if>&nbsp;
                                                </#list>
                                            </p>
                                        </div>
                                    </div>
                                    </#list>
                                </td>
                                <td>
                                    <#if order.address??>
                                        ${order.address.addressName}
									</#if>
                                </td>
                                <td>
                                    <span href="#" class="red">
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
                                                <#if order.orderExpressType??&&order.orderExpressType=='1'>
                                                    待自提
                                                <#else>
                                                    已发货
                                                </#if>
                                            <#elseif order.orderStatus=="3">
                                                交易完成
                                            <#elseif order.orderStatus=="4">
                                                交易关闭
                                            <#elseif order.orderStatus=="7">
                                                退货审核
                                            <#elseif order.orderStatus=="8">
                                                同意退货
                                            <#elseif order.orderStatus=="9">
                                                拒绝退货
                                            <#elseif order.orderStatus=="10">
                                                <#--待商家收货-->
                                               同意退货，请等待我们与您联系
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
                                    </span><br/>
                                    <a  target="_blank" href="${basePath}/customer/detail-${order.orderId}.html" class="blue" style="line-height:150%;">查看订单</a>
                                </td>
                                <td>
                                    <span class="red fb f14">￥ <#if order.moneyPaid??>
                                    ${order.moneyPaid?string('0.00')}
                                    </#if></span><br/>
                                    <span class="col9" style="line-height:150%;"><#if order.orderLinePay??>
                                        <#if order.orderLinePay=="1">

                                                在线支付

                                        <#elseif order.orderLinePay=="0">

                                                货到付款

                                        </#if>
                                    </#if></span>
                                </td>
                                <td>

                                    <#if (order.orderStatus=="11") >
                                        <a class="buy-again"  href="javascript:void(0)" onclick="cancelOrder('${basePath}/customer/cancelorder-myorder-${order.orderId}.html','${order.orderId}')">取消订单</a><br/>
                                    </#if>

                                    <#if ( order.orderStatus=="5" || order.orderStatus=="6") >
                                        <a  class="buy-again"  href="javascript:void(0)" onclick="timeBackOrder(${order.orderId})">申请退货</a><br/>
                                    </#if>

                                    <#if (order.orderStatus=="1" && giftCard == 0 && sFlag == 0) >
                                        <a  class="buy-again" href="${basePath}/customer/applybackmoneyprice.htm?orderId=${order.orderId}">申请退款</a><br/>
                                    </#if>

                                    <#if order.orderStatus=="0">
                                        <#if order.orderLinePay='1'>
                                            <a class="buy-again"  target="_blank" href="${basePath}/gopayorder-${order.orderId}.html">去付款</a><br/>
                                        </#if>
                                        <a class="buy-again"  href="javascript:void(0)" onclick="cancelOrder('${basePath}/customer/cancelorder-myorder-${order.orderId}.html',${order.orderId})">取消订单</a><br/>
                                    <#elseif order.orderStatus=="2">
                                        <a class="buy-again"  href="javascript:void(0)" onclick="comfirmgoods('${basePath}/customer/comfirmofgoods-myorder-${order.orderId}.html')"  >确认收货</a><br/>
                                    </#if>
                                    <#if (

                                    order.orderStatus=="7" ||
                                    order.orderStatus=="8" ||
                                    order.orderStatus=="9" ||
                                    order.orderStatus=="10" ||
                                    order.orderStatus=="14" ||
                                    order.orderStatus=="16" ||
                                    order.orderStatus=="17" ||
                                    order.orderStatus=="12"
                                    )
                                    >
                                        <a class="buy-again" href="${basePath}/customer/backdetail.htm?orderId=${order.orderId}">退货详情</a><br/>
                                    </#if>

                                    <#if (order.orderStatus=="13" ||
                                    order.orderStatus=="15" ||
                                    order.orderStatus=="18")>
                                        <#if order.getGoodsTime??>
                                            <a class="buy-again" href="${basePath}/customer/backdetail.htm?orderId=${order.orderId}">退货详情</a><br/>
                                        <#else>
                                            <a class="buy-again" href="${basePath}/customer/backdetailprice.htm?orderId=${order.orderId}">退款详情</a><br/>
                                        </#if>
                                    </#if>
                                    <#if isBackOrder==1>
                                        <#if (order.orderStatus=="3" && cFlag>0  && (gFlag<(order.goods)?size)) >
                                            <a  style="line-height:200%;" target="_blank" href="${basePath}/comment-${order.orderId}.html">评论晒单</a><br/>
                                            <#if (sFlag==0)>
                                            <a  class="buy-again"   href="javascript:void(0)" onclick="timeBackOrder(${order.orderId})">申请退货</a><br/>
                                            </#if>
                                        </#if>
                                        <#if (order.orderStatus=="3" && cFlag==0  && (gFlag<(order.goods)?size)) >
                                            <#if (order.orderStatus=="3" && order.shareFlag >0)>
                                                <a  style="line-height:200%;" target="_blank" href="${basePath}/comment-${order.orderId}.html">评论晒单</a><br/>
                                            </#if>
                                            <#if (sFlag==0)>
                                            <a  class="buy-again" href="javascript:void(0)" onclick="timeBackOrder(${order.orderId})">申请退货</a><br/>
                                            </#if>
                                        </#if>
                                        <#if (order.orderStatus=="8") >
                                            <a  class="buy-again"  href="javascript:void(0)" onclick="setwuliu('${order.orderNo}')">填写物流信息</a><br/>
                                        </#if>
                                        <#--<#if (order.orderStatus=="14" || order.orderStatus=="17" || order.orderStatus=="10" || order.orderStatus=="9" ||  order.orderStatus=="16" || order.orderStatus=="8")>
                                            <a class="buy-again" href="${basePath}/customer/backdetail.htm?orderId=${order.orderId}">退货详情</a><br/>
                                        </#if>

                                        <#if (order.orderStatus=="13" || order.orderStatus=="18")>
                                            <a class="buy-again"" href="${basePath}/customer/backdetailprice.htm?orderId=${order.orderId}">退款详情</a><br/>
                                        </#if>-->
                                    <#elseif isBackOrder==2>
                                        <#if (order.orderStatus=="3" && cFlag>0  && (gFlag<(order.goods)?size)) >
                                            <a  style="display:initial;" target="_blank" href="${basePath}/comment-${order.orderId}.html">评论晒单</a><br/>
                                        </#if>
                                        <#if (order.orderStatus=="3" && order.shareFlag >0  && (gFlag<(order.goods)?size))>
                                            <a  style="display:initial;" target="_blank" href="${basePath}/comment-${order.orderId}.html">评论晒单</a><br/>
                                        </#if>
                                    </#if>
                                    <a  class="buy-again againbuy" data-id="${order.orderId}" href="javascript:;">再次购买</a><br/>
                                </td>
                            </tr>
                            </#if>
                            </tbody>
                        </#if>
                     </#list>
                    <#else>
                        <tr>
                            <td colspan="5" style="font-size:18px; height:60px;text-align:center;">暂无订单！</td>
                        </tr>
                    </#if>
                    </table>
                </div>
            </div>
            </div>
            <div class="borwsing-history mt20">
                <div class="title">浏览记录</div>
                <div class="his-srcoll" id="proScroll_a">
                    <#if browses??&&browses?size!=0>
                            <div  class="new-proscoll">
                                <ul>
                                        <#list browses as browse>
                                                <li>
                                                    <a target="_blank" title="${(browse.goods.goodsName)!''}" href="${basePath}/item/${browse.goodsId}.html"><img src="<#if browse?? && browse.goods?? && browse.goods.goodsImageList??><#list browse.goods.goodsImageList as image><#if image_index==0>${image.imageBigName!''}</#if></#list></#if>" alt="${(browse.goods.goodsName)!''}" title="${(browse.goods.goodsName)!''}" width="215" height="215" >

                                                        <p>
                                                            <#if browse?? && browse.goods?? >
                                                                 <#if browse.goods.goodsName??&&((browse.goods.goodsName)?length>13)>
                                                                     ${(browse.goods.goodsName)?substring(0,13 )}
                                                                <#else>
                                                                    ${(browse.goods.goodsName)!''}
                                                                </#if>
                                                            </#if>

                                                        </p>
                                                        <p class="red">￥<#if browse?? && browse.goods??>${browse.goods.goodsMarketPrice?string('0.00')}</#if></p>
                                                    </a>
                                                </li>
                                        </#list>

                                </ul>
                            </div>
                            <a class="j-prev" href="javascript:;"></a>
                            <a class="j-next" href="javascript:;"></a>
                    <#else>
                       <div  style="margin-top:10px;border:1px #e8e8e8 solid; height:60px; text-align: center; font-size: 18px;line-height:60px;;">
                            暂无浏览信息！
                       </div>
                     </#if>
                </div>
            </div><!--borwsing-history-->
        </div>
    </div>
</div>
<input type="hidden" value="${token!''}" id="hi_token" />
<div class="mask"></div>
<div class="member-dialog dia4">
    <div class="member-dialog-body">
        <div class="title"><a href="javascript:;" onclick="cls()">×</a></div>
        <div class="tc">
            <img src="${basePath}/images/btn_tips@2x.png" alt="" style="width: 45px;height: 45px;margin: 0 auto; margin-top:13px;display: block;">
            <div class="que-delete clearfix">
                <div class="fl tl" style="float: none">
                    <p class="f16 new_p" id="titleerr">头像上传成功！</p>

                    <div class="m-btn " style="text-align: center">
                        <a id="go_pay_00" href="javascript:cls();" class="bnt_ok">确定</a>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
<div class="member-dialog dia3">
    <div class="member-dialog-body">
        <div class="title"><a href="javascript:;" onclick="cls()">×</a></div>
        <div class="tc">
            <img src="${basePath}/images/btn_waringcopy@2x.png" alt="" style="width: 45px;height: 45px;margin: 0 auto; margin-top:13px;display: block;"
            <div class="que-delete clearfix">
                <div class="fl tl">
                    <p class="f16 new_p" >确定确认收货吗？小心钱货两空哦！</p>
                    <div class="m-btn">
                        <a class="" href="javascript:cls();">取消</a>
                        <a  id="go_pay_01" href="javascript:;" class="bnt_ok">确定</a>

                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<div class="member-dialog promotion_dialog_1">
    <div class="member-dialog-body">
        <div class="title"><a href="javascript:;" onclick="cls()">×</a></div>
        <div class="tc">
            <img src="${basePath}/images/btn_waringcopy@2x.png" alt="" style="width: 45px;height: 45px;margin: 0 auto; margin-top:13px;display: block;">
            <div class="que-delete clearfix">

                <div class="fl tl">
                    <p class="f16 new_p">您确定要删除该订单吗？删除后，您将无法恢复！</p>
                  <#--  <p ></p>-->
                    <div class="m-btn ">
                        <a onclick="cls()">取消</a>
                        <a href="javascript:;"onclick="clsd()" class="bnt_ok">确定</a>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
<div class="member-dialog promotion_dialog_2">
    <div class="member-dialog-body">
        <div class="title"><a href="javascript:;" onclick="cls()">×</a></div>
        <div class="tc">
            <img src="${basePath}/images/btn_waringcopy@2x.png" alt="" style="width: 45px;height: 45px;margin: 0 auto; margin-top:13px;display: block;">
            <div class="que-delete clearfix">
                <div class="fl tl">
                    <p class="f16 new_p">您确定要删除该订单吗？删除后，您将无法恢复！</p>
                    <p ></p>
                    <div class="m-btn ">
                        <a onclick="cls()">取消</a>
                        <a href="javascript:;" onclick="deleteBackOrder()" class="bnt_ok">确定</a>

                    </div>
                </div>
            </div>

        </div>
    </div>
</div>


<!--退货物流-->
<div class="member-dialog big-dialog dia15">
    <div class="member-dialog-body">
        <div class="title"><a href="javascript:;" onclick="cls()">×</a></div>
        <div class="tc">
            <div class="que-delete clearfix">
                <img src="${basePath}/images/images_l6.png"/>
                <div class="fl tl">
                    <div style=" padding-top: 10px; padding-left:20px; font-size: 12px; font-weight:bold;">亲！请填写物流信息!</div>
                    <input type="hidden" id="orderNo" name="orderNo" value=""/>
                    <table style="height:100px;margin-top:20px; margin-left:10px;" id="backtable">
                        <tr>
                            <td>*物流公司：</td>
                            <td><input type="text" maxlength="20" onBlur="wuliuname()" style=" border-radius:3px;" name="wlname" id="wlname"/></td>
                            <td class="yanzhengname">&nbsp;&nbsp;请填写正确的物流公司！</td>
                        <tr/>
                        <tr>
                            <td>*物流单号：</td>
                            <td>
                                <input type="text" maxlength="20" onBlur="wuliudanhao()" style=" border-radius:3px;" name="wlno" id="wlno"
                                       onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',
						  clipboardData.getData('text').replace(/[^\d]/g,''))"
                                        />
                            </td>
                            <td class="yanzhengno" width="172px">&nbsp;&nbsp;请填写正确的物流单号！</td>
                        <tr/>
                        <tr>
                            <td colspan="3"><img src='../images/gantanhao_1.gif'/>注：物流公司信息必须真实有效！</td>
                        </tr>
                    </table>
                    <div class="m-btn mt20">
                        <a   id="go_pay_01" href="javascript:;" onclick="quedingwl('00');" style="margin-left:80px;" >确定</a>
                        <a href="javascript:cls();" id="go_pay_00" onclick="quxiaowuliu()">取消</a>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<div class="member-dialog dia2 big-dialog">
    <div class="member-dialog-body">
        <div class="title"><a href="javascript:;" onclick="cls()">×</a></div>
        <div class=" clearfix" style="margin-top: 43px;">
       <#--     <img src="${basePath}/images/btn_tips@2x.png" alt="" style="width: 45px;height: 45px;margin: 0 auto; margin-top:13px;display: block;">-->

            <div class="fl" style="width: 480px;">
                <em class="fl new_em">取消订单原因：</em>
                <div class="s-mn_sel mn_sel">发票信息有误/发票未开</div>
                <div class="s-selCont selCont">
                    <label><input class="vm mr5" name="res" type="radio" value="现在不想买">现在不想买</label>
                    <label><input class="vm mr5" name="res" type="radio" value="商品价格较贵">商品价格较贵</label>
                    <label><input class="vm mr5" name="res" type="radio" value="价格波动">价格波动</label>
                    <label><input class="vm mr5" name="res" type="radio" value="商品缺货">商品缺货</label>
                    <label><input class="vm mr5" name="res" type="radio" value="重复下单">重复下单</label>
                    <label><input class="vm mr5" name="res" type="radio" value="添加或删除商品">添加或删除商品</label>
                    <label><input class="vm mr5" name="res" type="radio" value="收货人信息有误">收货人信息有误</label>
                    <label><input class="vm mr5" name="res" type="radio" value="发票信息有误/发票未开">发票信息有误/发票未开</label>
                    <label><input class="vm mr5" name="res" type="radio" value="送货时间过长">送货时间过长</label>
                    <label><input class="vm mr5" name="res" id="other_yy" type="radio" value="其他原因">其他原因</label>
                </div>
                <div class="s-err_tip">请选择取消原因!</div>
                <div class="s-input_tip">请输入10个以上字符!</div>
                <div class="m-btn mt20 pb10" style="margin-top: 55px;padding-bottom: 20px;">
                    <a href="javascript:cls();">取消</a>
                    <a  id="go_pay_00" href="javascript:;" onclick="changeUrl();" class="bnt_ok">确定</a>

                </div>
            </div>

        </div>
    </div>
</div>


<div class="member-dialog dia20">
    <div class="member-dialog-body">
        <div class="title"><a href="javascript:;" onclick="cls()">×</a></div>
        <div class="tc">
            <img src="${basePath}/images/btn_tips@2x.png" alt="" style="width: 45px;height: 45px;margin: 0 auto; margin-top:13px;display: block;">
            <div class="que-delete clearfix">
                <div class="fl tl">
                    <p class="f16  new_p">该商品已超出退货限时。</p>
                    <div class="m-btn ">
                        <a  id="go_pay_01" href="javascript:cls();" class="bnt_ok">确定</a>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
<div class="member-dialog dia20">
    <div class="member-dialog-body">
        <div class="title"><a href="javascript:;" onclick="cls()">×</a></div>
        <div class="tc">
            <img src="${basePath}/images/btn_tips@2x.png" alt="" style="width: 45px;height: 45px;margin: 0 auto; margin-top:13px;display: block;">
            <div class="que-delete clearfix">
                <div class="fl tl">
                    <p class="f16  new_p">该商品已超出退货限时。</p>
                    <div class="m-btn ">
                        <a  id="go_pay_01" href="javascript:cls();" class="bnt_ok">确定</a>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
<#--shf-->
<#--<div class="footer_tab">-->
    <#--<ul>-->


        <#--<li class="list1"><a href="http://www.ge960.com/channel/237.html">食品荟萃</a></li>-->
        <#--<li class="list2"><a href="http://www.ge960.com/channel/239.html">饮品总汇</a></li>-->
        <#--<li class="list3"><a href="http://www.ge960.com/channel/241.html">购物中心</a></li>-->
        <#--<li class="list4"><a href="http://www.ge960.com/channel/243.html">大药房</a></li>-->

    <#--</ul>-->
<#--</div>-->
<#--引入底部 <#include "/index/bottom.ftl" />  -->
<#if (topmap.temp)??>
    <#if (topmap.temp.tempId==1)>
        <#include "../index/bottom.ftl">
    <#else>
        <#include "../index/newbottom.ftl" />
    </#if>
</#if>
<script type="text/javascript" src="${basePath}/js/customer/customer.js"></script>
<script type="text/javascript" src="${basePath}/js/tab-switch.js"></script>
<script type="text/javascript" src="${basePath}/js/customer/uploadImg.js"></script>
<script type="text/javascript" src="${basePath}/js/jcarousellite_1.0.1.js"></script>
<script type="text/javascript" src="${basePath}/js/default.js"></script>
<script type="text/javascript" src="${basePath}/js/newapp.js"></script>
<script type="text/javascript" src="${basePath}/js/customer/findcode.js"></script>
<script type="text/javascript" src="${basePath}/js/jsOperation.js"></script>
<script type="text/javascript" src="${basePath}/index_960/js/app.js"></script>
<script>

</script>
<script type="text/javascript">
    $(".pro_sort").addClass("pro_sort_close");
    $(document).ready(function(){
        //前台会员中心浏览记录滚动
        if($("#proScroll_a").length > 0) {
            var count=$("#proScroll_a .new-proscoll ul li").length;
            //大于4条记录
            if(count >4){
                $(".new-proscoll").jCarouselLite({
                    btnNext: ".j-next",
                    btnPrev: ".j-prev",
                    auto: 3600,
                    speed: 500,
                    visible: 4,
                    onMouse: true,
                    scroll: 2
                });
            }else{
                //浏览记录小于4条时不让轮播
                $(".new-proscoll").jCarouselLite({
                    speed: 0,
                    visible: count,
                    onMouse: true,
                    scroll: 1
                });
            }

        };
        $('.item_title').each(function(){
            $(this).click(function(){
                $(this).next().toggle('fast',function(){
                    if($(this).is(':visible')){
                        $(this).prev().removeClass('up');
                        $(this).prev().addClass('down');
                    }
                    else{
                        $(this).prev().removeClass('down');
                        $(this).prev().addClass('up');
                    }
                });
            });
        });
            $(".guess_goods_list").jCarouselLite({
                btnNext: ".next",
                btnPrev: ".prev",
                visible: 6,
                auto: 2000,
                speed: 800,
                onMouse: true
            });
        jQuery.fn.isChildAndSelfOf = function(b){ return (this.closest(b).length > 0); };
        $(".mn_sel").click(function(){
            $(this).next(".selCont").show();
            $(".sel_txa").hide();
            $(".err_tip").hide();
            $(".input_tip").hide();
            $(document).click(function(event){
                if(!$(event.target).isChildAndSelfOf(".mn_sel, .selCont")) {
                    $(".selCont").hide();
                    if( $("#other_yy").prop("checked")){
                        $(".sel_txa").show();
                    }
                };
            });
        });
        $(".selCont input").click(function(){
            $(".mn_sel").html($(this).val());
            $("#rea_hid").val($(this).val());
            $(".selCont").hide();
            $(".sel_txa").hide();
        });
        $("#other_yy").click(function(){
            $(".sel_txa").show();
        });

        $(".againbuy").click(function(){
            $.post('${basePath}/customer/againbuy/'+$(this).attr("data-id")+'.html',
                    function(data){
                        if(data != null && data.length > 0){
                            var againbuytip = '';
                            for(var i = 0;i<data.length;i++){
                                var namestr = data[i].productName;
                                namestr = namestr.length > 12? namestr.substring(0,12)+'...':namestr;
                                againbuytip += '商品:'+namestr+'已下架<br>';
                            }
                            $(".againbuytip").html(againbuytip);
                            $("#againbuyconfirm").click(function(){
                                window.location.href = '${basePath}/myshoppingcart.html';
                            })
                            $(".dia4").fadeIn();
                        }else{
                            window.location.href = '${basePath}/myshoppingcart.html';
                        }
                    })
        })

    });

    var id = '';
    function showDialogs(orderId) {
        id = orderId;
        $(".mask").fadeIn();
        $(".promotion_dialog_1").fadeIn();
    }

    function clsd(){
        jQuery.ajax({
            type: 'post',
            url: 'deleteOrderById.htm?orderId='+id,
            success:function(data) {

                clsc();
                if(data>0)
                    location.reload();
            }
        });
    }
    function clsc() {
        $(".dialog").fadeOut();
        $(".mask").fadeOut();
    }


    //退货弹窗  取消
    function quxiaokuan(){
        $(".dialog").fadeOut();
        $(".mask").fadeOut();
        $(".err_yuanyin").html("<img src='../images/gantanhao_1.gif'/>收件原因不能超过100个字！");
        $(".err_yuanyin").addClass("black");
        $(".err_tuikuan").addClass("black");
        $(".err_tuikuan").removeClass("red");
    }

    /*验证退货时间*/
    function timeBackOrder(orderId){
        jQuery.ajax({
            type: 'post',
            url: 'timeBackOrderById.htm?OrderId='+orderId,
            success:function(data) {
                if(data>0){
                    location.href = "${basePath}/customer/applybackmoney.htm?orderId="+orderId;
                }else{
                    dia(20)
                }
            }
        });
    }
</script>
</body>
</html>