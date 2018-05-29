<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="Keywords" content="${topmap.seo.meteKey}">
    <meta name="description" content="${topmap.seo.meteDes}">
<#assign basePath=request.contextPath>
    <title>${topmap.systembase.bsetName}</title>
    <link rel="stylesheet" type="text/css" href="${basePath}/css/base.min.css" />
    <link rel="stylesheet" type="text/css" href="${basePath}/css/style.css" />
    <link rel="stylesheet" type="text/css" href="${basePath}/css/pages.css"/>
    <link rel="stylesheet" href="${basePath}/index_seven/css/style.css"/>
    <link rel="stylesheet" href="${basePath}/index_twentyone/css/index_css.m.css"/>
    <link rel="stylesheet" href="${basePath}/css/receive.m.css"/>
    <script type="text/javascript" src="${basePath}/js/jquery-1.7.2.min.js"></script>
<#if (topmap.systembase.bsetHotline)??>
    <link rel = "Shortcut Icon" href="${(topmap.systembase.bsetHotline)!''}">
<#else>
    <link rel = "Shortcut Icon" href="${basePath}/images/Paistore.ico">
</#if>
    <link rel="stylesheet" type="text/css" href="${basePath}/index_two/css/header.css" />
    <style>
        .agreement_dia {
            width: 910px !important;
            height: auto;
            border: 5px solid rgba(238, 238, 238, .5);
            padding: 0;
        }

        .agreement_wp {
            height: 360px;
            overflow-y: scroll;
            padding: 0 20px;
        }

        .agreement_dia .dia_tit {
            background: #eee;
            text-align: center;
            font-size: 14px;
            font-weight: 700;
            color: #666;
        }

        .agreement_dia .dia_close {
            position: absolute;
            top: 8px;
            right: 20px;
            margin-top: 0;
            background: url(${basePath}/images/agree_close.gif) no-repeat;
        }
        .nbalance,.ngiftcard{
            color: red;
        }
        .nbalance a,.ngiftcard a{
            margin-left: 20px;
        }
        #logo{
            padding-top: 0px!important;
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
<#--<#include "../index/newtop5.ftl">-->
<#--<#elseif (topmap.temp.tempId==11)>-->
<#--<#include "../index/newtop6.ftl">-->
<#--<#elseif (topmap.temp.tempId==12)>-->
<#--<#include "../index/newtop7.ftl">-->
<#--<#elseif (topmap.temp.tempId==13)>-->
<#--<#include "../index/newtop8.ftl">-->
<#--<#elseif (topmap.temp.tempId==14)>-->
<#--<#include "../index/newtop9.ftl">-->
<#--<#elseif (topmap.temp.tempId==15)>-->
<#--<#include "../index/newtop7.ftl">-->
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

<#--<div class="container clearfix pr">-->
<#--<div class="mini_head">-->
<#--<h1 class="logo">-->
<#--<a href="${topmap.systembase.bsetAddress}">-->
<#--<img src="${topmap.systembase.bsetLogo}" alt="" style="width: 165px;height: 70px;"/>-->
<#--</a>-->
<#--</h1>-->
<#--</div>-->
<#--</div>-->

<#assign dianziCard=0>
<#if map.orders??>
    <#list map.orders as order>
        <#if order_index == 0>
            <#if order.orderLinePay=='1'><!-- 在线支付 -->

            <div style="background: #f5f5f5;min-height:600px;">
                <form action="" class="payOrder" method="post" target="_blank" style="height: 403px;">
                    <input type="hidden" name="orderCount" value="${map.orders?size}"/>
                    <!-- 阻止自动enter 提交-->
                    <input type="text" name="stopenter" style="display: none">
                    <input type="text" name="stopenter1" style="display: none">
                    <input type="hidden" id="orderSum" value="${map.totalPrice?string("0.00")}" />
                    <div class="container clearfix pt20 pb10" style="position: relative;">
                        <div class="order_info_simple clearfix">
                            <div class="total fr">
                                <div style="margin: 0 20px 0 20px; border-bottom: 1px dashed #cccccc;height: 99px;">
                                    <p>订单总额：<strong style="float: right;margin-right: 10px;">&yen;${order.orderPrice?string("0.00")}</strong></p>

                                    <p class="giftcard">礼品卡：<strong style="float: right;margin-right: 10px;">-&yen;<strong style="float: right;" id="uesgcprice">0.00</strong></strong></p>

                                </div>
                                <p class="giftcard" style="margin-top: 30px;margin-left: 22px;font-size: 22px;">需支付：<strong style="color: #E45050;float: right;margin-right: 30px;font-size: 22px;font-weight: normal;">&yen;<strong style="color: #E45050;float: right;font-size: 22px;font-weight: normal;" class="needgcprice">${order.orderPrice?string("0.00")}</strong></strong></p>

                            </div>
                            <div class="info fl">
                                <div class="words">
                                    <p>
                                        <strong>
                                            商品名称：
                                            <#if order.orderGoodsList??>
                                                <#list order.orderGoodsList as good>
                                                    <#if good_index==0>
                                                    ${good.goodsInfoName!''}
                                                    </#if>
                                                    <#if good.goodsInfoName??&& (good.goodsInfoName?index_of("电子卡")!=-1 || good.goodsInfoName?index_of("实体卡")!=-1)><#assign dianziCard=dianziCard+1></#if>
                                                </#list>
                                                <#if order?? && order.orderGoodsList?? && (order.orderGoodsList?size>1)>
                                                    &nbsp;等多件
                                                </#if>
                                            </#if>
                                        </strong>
                                    </p>
                                    <p><strong>订单编号：${order.orderCode}</strong></p>
                                    <#assign oocode = "${order.orderCode}">
                                    <p><strong><a href="/customer/detail-${order.orderId}.html" target="_blank">订单详情&gt;&gt;</a></strong>
                                    </p>
                                </div>
                            </div>
                            <div class="clr"></div>

                            <#if order.businessId==0>
                                <#assign pid="${order.payId}">
                            <#else >
                                <#assign thirdpid="${order.payId}">
                            </#if>
                            <#if pid?? && pid=='1'>
                                <input type="hidden" value="${order.orderCode}" name="orderCode" id="orderCode"/>
                                <input type="hidden" value="${order.orderId}" name="orderId" id="orderId"/>
                                <input type="hidden" value="${order.orderOldCode}" name="orderOldCode"/>
                            </#if>
                            <#if thirdpid?? && thirdpid=='1'>
                                <input type="hidden" value="${order.orderCode}" name="orderCode"/>
                                <input type="hidden" value="${order.orderId}" name="orderId" id="orderId"/>
                                <input type="hidden" value="${order.orderOldCode}" name="orderOldCode"/>
                            </#if>

                        </div>

                        <div class="payment-box" style="    height: 403px;">
                            <div class="box" style="     padding: 40px 40px 56px 0px;border-bottom: 1px dashed #cccccc;width: 57%;margin-left: 40px;margin-bottom: 56px;">
                                <p class="h4">请选择支付方式：</p>
                                <ul class="types clearfix">
                                    <#if map.payList??>
                                        <#list map.payList as pay>
                                            <#if pay.payDefault=="1">
                                                <#if pay.payType=='5'>
                                                    <script>
                                                        var firstPayType = '${pay.payType}';
                                                    </script>
                                                </#if>
                                                <input type="hidden" value="${pay.payId}" name="payId" id="payId"/>
                                                <input type="hidden" value="${pay.payType}" name="payType" id="payType"/>
                                            </#if>

                                            <#if (pay.isOpen=='1'&& (pay.payType=='1'||pay.payType=='2'||pay.payType=='4' ||pay.payType=='7' ||pay.payType=='8')) && pay.payId != 26>
                                                <li title="${pay.payName}">

                                                    <a paytype="${pay.payType}"
                                                       onclick="payTypeClick(this,'${pay.payId}','${pay.payType}');"
                                                        <#if pay.payDefault=="1">
                                                       class="selected"
                                                        </#if>
                                                       href="javascript:;">
                                                        <#if pay.payType=='1'>
                                                            <img src="${basePath}/images/payment1.jpg" alt="${pay.payName}">
                                                            <!-- 支付宝 -->
                                                            <#elseif pay.payType=='2'><!-- 银联 -->
                                                            <img src="${basePath}/images/payment4.jpg" alt="${pay.payName}">
                                                            <#elseif pay.payType=='4'><!-- 千米收银台 -->
                                                            <img src="${basePath}/images/payment5.jpg" alt="${pay.payName}">
                                                            <#elseif pay.payType=='7'><!-- 微信扫码支付 -->
                                                            <img src="${basePath}/images/weixin_pay.png">
                                                            <#elseif pay.payType=='8'><!-- 银行卡支付 -->
                                                            <img src="${basePath}/images/yifubao.png">
                                                        <#else>
                                                            <img src="${pay.payImage!''}" alt="${pay.payName}">
                                                        </#if>
                                                    </a>
                                                </li>
                                            </#if>
                                        </#list>
                                    </#if>
                                </ul>
                            </div>

                        <#--如果订单货品中包含礼品卡商品则不能使用礼品卡账户进行支付-->
                            <#if (dianziCard == 0)>
                                <h3 style="margin-bottom: 20px;margin-left: 40px;font-size: 16px;font-weight: normal;"><input type="checkbox" id="isGiftCardPay" style="zoom: 150%;margin-right: 4px;" value="0" name="isgiftcard">使用商城礼品卡进行抵扣</h3>

                                <div class="box for-pre-deposit">
                                    <div class="alert-box" style="margin-bottom: 10px;">
                                        <p class="fl ypay hide" style="width: 100%;    color: #333333;">已使用礼品卡账户内 <span id="predeposit">null</span>元，剩余 <span id="balance">null</span>元。<span class="hide giftcard" style="    color: #333333;">还需使用其他方式支付 <strong class="needgcprice" style="color: #E45050;font-weight: normal;">0</strong> 元。</span><p></p>
                                        <p class="fl nbalance hide" style="color: #333333;">您的礼品卡账户余额为<span id="predeposit" style="color: #333333;">0.00</span><a href="${basePath}/customer/mygiftcard.html" style="color: #0d9901;">立即充值</a></p>
                                        <p class="fl ngiftcard hide" style="color: #333333;">您尚未绑定礼品卡<a href="${basePath}/customer/mygiftcard.html" style="color: #0d9901;">立即绑定</a></p>
                                        <p class="tip-alert fl">
                                            <!--
                                            预存款不足，请使用其他支付方式
                                            -->
                                        </p>
                                        <div class="clr"></div>
                                    </div>

                                    <div id="payInput" style="display: none;">
                                        <p class="h4"></p>
                                        <div class="charge-form" style="margin-left: 65px;">
                                            请输入支付密码：<input type="password" style="display: none;"><!-- 防止密码自动填充 -->
                                            <!--
                                            <input type="password" name="payPassword" id="payPassword" class="text">
                                             -->
                                            <input style="width: 128px;height: 26px;letter-spacing: 2px;font-size: 26px;" class="text" type="text" name="payPassword" id="payPassword" onfocus="this.type='password'" autocomplete="off" />
                                            <a href="${basePath}/deposit/changepaypasswordview.htm" target="_blank" style="color:#0d9901;">忘记密码？</a>
                                        </div>
                                        <p class="error"></p>
                                    </div>
                                    <p class="error" id="errorMsg" style="margin-left: 164px;width: 100%;"></p>
                                </div>
                            </#if>
                            <div class="box" style="position: absolute;right: 157px;top: 395px;">
                                <a href="javascript:;" class="pay-btn disabled" onclick="_czc.push(['_trackEvent', '确认支付', '查看', '确认支付',  'confirm_payment']);" id="confirm_payment">确认支付</a>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <#elseif order.orderLinePay=='0'><!-- 货到付款 -->
            <div class="container clearfix pt20 pb10">
                <div class="order_submit_success clearfix">
                    <input type="hidden" value="${order.orderId}" name="orderId" id="orderId"/>
                    <div class="total fr">
                        <p>应付总额：<strong>￥${map.totalPrice?string("0.00")}</strong></p>
                    </div>
                    <div class="info fl">
                        <div class="words">
                            <h2>订单提交成功！我们会尽快为您发货！</h2>
                            <p><strong>订单编号：${order.orderCode}</strong></p>
                            <p class="count">
                                <span id="countNum">3</span>
                                秒后自动跳转到订单详情……
                                <a href="/customer/detail-${order.orderId}.html">立即查看&gt;&gt;</a>
                            </p>
                        </div>
                    </div>
                    <div class="clr"></div>
                </div>
            </div>
            </#if>
        </#if>
    </#list>
</#if>


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

<#--
<div class="mask"></div>
<div class="dialog dia1">
    <div class="dia_tit clearfix">
        <h4 class="fl">支付提示</h4>
        <a class="dia_close fr" href="javascript:;" onclick="cls()"></a>
    </div>
    <div class="dia_cont">
        <div class="dia_intro no_tc pt30">
            <em>付款进行中...</em>
            <div class="mt20">
                <p class="lh180">支付完成前，请不要关闭此支付验证窗口。</p>
                <p class="lh180">支付完成后，请根据您支付的情况点击下面按钮。</p>
            </div>
        </div>
        <div class="dia_ops mt20 tc">
            <a class="go_shopping" href="${basePath}/customer/myorder.html">完成支付</a>
            <a class="go_shopping" href="javaScript:void(0)" onclick="showHelp(this)" date-value=""
               id="payhelp">付款遇到问题</a>
        </div>
    </div>
</div>
-->
<div class="member-dialog dia1">
    <div class="member-dialog-body">
        <div class="title"><a href="javascript:;" onclick="cls()">×</a></div>
        <img src="${basePath}/images/btn_waringcopy@2x.png" alt="" style="width: 45px;height: 45px;margin: 0 auto; margin-top:13px;display: block;">
        <div class="dia-tips">
            <p class="txt">
                支付完成前请勿关闭此窗口
                请确认是否已经完成支付
            </p>
        </div>
        <div class="dia-btn" style="margin-top: 40px;">
            <a class="btn new_order_active1" href="javascript:void(0)" onclick="showHelp(this)" date-value="" id="payhelp">付款遇到问题</a>
            <a class="btn active new_order_active" href="${basePath}/customer/myorder.html">完成支付</a>
        </div>
    </div>
</div>

<div class="mask"></div>
<div class="dialog dia2 agreement_dia">
    <div class="dia_tit clearfix">
        支付问题描述
        <a class="dia_close fr" href="javascript:;" onclick="cls()"></a>
    </div>
    <div class="dia_cont">
        <div class="agreement_wp no_tc pt30" id="payHelpDesc" style="width:auto">

            <input type="hidden" id="customer_id" value="${cust.customerId}"/>
            <input type="hidden" value="${token!''}" id="hi_token" />
            <div class="content">
                <div class="layout">
                    <table class="complain-table">
                        <tr>
                            <td>涉及订单：${oocode}</td>
                        </tr>
                        <tr>
                            <td>问题描述：<textarea id="complaincon" maxlength="250" style="height: 60px;"></textarea><br/>
                                <p style="margin-left: 70px;">请输入您支付时遇到的问题，以便我们能够及时协助您！</td></tr>
                        <tr>
                            <td><a class="complain-submit" onclick="addcomplain1()" style="margin-left: 70px;">提交</a></td>
                        </tr>
                    </table>
                </div>
                <p>
                    <br />
                </p>
                <p style="font-size:13px;color:#6B717A;font-family:&quot;">
                    <strong>支付中遇到问题</strong>
                </p>
                <p style="font-size:13px;color:#6B717A;font-family:&quot;">
                    <strong>1、页面提示“支付密码错误，请重试”怎么办？</strong>
                </p>
                <p style="font-size:13px;color:#6B717A;font-family:&quot;">
                    <strong>答：点击“重试”，输入正确支付密码！</strong>
                </p>
                <p style="font-size:13px;color:#6B717A;font-family:&quot;">
                    <strong>2、页面提示“银行卡可用余额不足（如信用卡则为可透支额度不足），请核实后再试“怎么办？</strong>
                </p>
                <p style="font-size:13px;color:#6B717A;font-family:&quot;">
                    <strong>答：点击“添加新卡支付”添加一张余额可以支付的银行卡。重新支付！</strong>
                </p>
                <p style="font-size:13px;color:#6B717A;font-family:&quot;">
                    <strong>3、系统繁忙或网络连接错误怎么办？</strong>
                </p>
                <p style="font-size:13px;color:#6B717A;font-family:&quot;">
                    <strong>答：请检查网络状态是否正常，正常状态下重新支付！</strong>
                </p>
                <p>
                    <br />
                </p>
            </div>
        </div>
        <div class="dia_ops mt20 tc">

        </div>
    </div>
</div>

<div class="member-dialog dia3">
    <div class="member-dialog-body">
        <div class="title"><a href="javascript:;" onclick="cls1()">×</a></div>
        <img src="${basePath}/images/btn_waringcopy@2x.png" alt="" style="width: 45px;height: 45px;margin: 0 auto; margin-top:13px;display: block;">

        <div class="tc">
            <div class="que-delete clearfix">
                <div class="fl tl">
                    <p class="f16 new_p" id="errorContent"></p>

                    <div class="m-btn">
                        <a href="javascript:;" onclick="cls1()" class="bnt_ok">确定</a>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
<script type="text/javascript" src="${basePath}/js/minShopping.js"></script>
<script type="text/javascript" src="${basePath}/js/customer/customer.js"></script>
<script type="text/javascript" src="${basePath}/js/default.js"></script>

<script type="text/javascript">

    $(function () {
        $(".new_div_header:first").find("img").addClass("HelpNow");
    })
    //首次进入页面的时候，当支付方式为余额支付的时候，手动触发余额支付的点击事件
    var firstPayType = firstPayType||"";
    if((firstPayType||"")==5){
        $(".types li a[payType='5']").click();
    }else{//其他支付方式，按钮点亮
        $(".pay-btn").removeClass("disabled");
    }

    setTimeout(countDown, 1000);
    function countDown(){
        var time = $("#countNum").text();
        $("#countNum").text(time - 1);
        if (time == 1) {
            var orderId = $("#orderId").val();
            //location.href='${basePath}/index.html';
            window.location.href='/customer/detail-'+orderId+'.html';
        } else {
            setTimeout(countDown, 1000);
        }
    }

    function showHelp(obj){
    <#--$(".dia1").hide();-->
    <#--$("#payhelp").attr("date-value");-->
    <#--var payId = ( $("#payhelp").attr("date-value"));-->
    <#--$.ajax({-->
    <#--type:"POST",-->
    <#--url:"${basePath}/findpayone.htm",-->
    <#--data:"payid="+payId,-->
    <#--success:function(data){-->
    <#--$("#payHelpDesc").html(data.payHelp);-->
    <#--var _wd = $(window).width();-->
    <#--var _hd = $(window).height();-->
    <#--$(".dia2").css("top",(_hd - $(".dia2").height())/2).css("left",(_wd - $(".dia2").width())/2);-->
    <#--$(".dia2").show();-->
    <#--}-->
    <#--});-->
        $(".dia1").hide()
        var _wd = $(window).width();
        var _hd = $(window).height();
        $(".dia2").css("top",(_hd - $(".dia2").height())/2).css("left",(_wd - $(".dia2").width())/2);
        $(".dia2").show();
    }
    function payTypeClick(dom, payId, payType) {
        var orderSum = $("#orderSum").val();
        var needgcprice = $(".needgcprice").eq(0).text();
        if(needgcprice == orderSum){
            $("#isGiftCardPay").removeAttr("checked");
        }
        if(needgcprice == "0.00"){
            $("#isGiftCardPay").removeAttr("checked");
            $(".box.for-pre-deposit").hide();
            $("#uesgcprice").text("0.00");
            $(".needgcprice").text(orderSum);

        }else{
            $(".tip-alert.fl").html("");
        }
        var $this = $(dom);
        $(".types li a").removeClass("selected");
        $this.addClass("selected");
        $("#payId").val(payId);
        $("#payType").val(payType);
        $("#errorMsg").text("").hide();
        $(".pay-btn").removeAttr('disabled').removeClass("disabled");
    }

    //确认支付点击的时候
    $('.pay-btn').click(function(){
        if($(this).hasClass("disabled")){
            return;
        }
        var status = 0;
        $(".payOrder").attr("action", "payorder.html");
        var payType = $("#payType").val();
        var payId =  $("#payId").val();
        if($("#isGiftCardPay").is(':checked')){
            var needgcprice = $(".needgcprice").text();
            if(needgcprice == "00"){
                $("#payId").val("");
            }
            var payPassword = $("#payPassword").val();
            if(!payPassword){//密码为空
                $(".box.for-pre-deposit #errorMsg").text('密码不能为空').show();
                //提交按钮置灰
                $(".pay-btn").addClass('disabled');
                return;
            }else{
                //支付。。。。
                var defer = $.ajax({
                    url:'/payorder.html',
                    type:'post',
                    data:$(".payOrder").serialize(),
                    async:false
                });
                defer.done(function(res){
                    if(typeof(res.retcode)=="undefined"){
                        status = 0;
                    }else {
                        if (res.retcode == '-1' || res.retcode=='-2') {
                            status = -1;
                            $(".tip-alert.fl").html("");
                            $("#errorMsg").text(res.msg).show();
                        } else if (res.retcode == '0') {
                            //支付成功
                            var orderId = $("#orderId").val();
                            window.location.href = "/depositpaysuccess.htm?orderId=" + orderId;
                        }
                    }
                });
            }
        }
        if(payId != "" && status == 0){
            if(payType == 7){
                $(".payOrder").attr("action", "/weixinpay.htm");
                dia(1);
                $('.payOrder').submit();
            }else{
                dia(1);
                $('.payOrder').submit();
            }
        }
    });

    //事件处理
    function bindEvent(){
        $("#payPassword").keyup(function(){
            var val = $(this).val();
            if(!val){
                $(".box.for-pre-deposit #errorMsg").text('密码不能为空').show();
                $(".pay-btn").addClass('disabled');
            }else{
                $(".box.for-pre-deposit #errorMsg").text('').hide();
                $(".pay-btn").removeClass('disabled');
            }
        });
    }
    bindEvent();

    /*
    $(function(){
        var orderId = $("#orderId").val();
        var countNum = 3;//初始秒数
        var countInterval = setInterval(function(){
            if(countNum>0){
                countNum--;
                $('#countNum').text(countNum);
            }
            else{
                clearInterval(countInterval);
                window.location.href='/customer/detail-'+orderId+'.html';
            }
        },1000);
    });
    */
    function backspace(evt){
        evt=evt?evt:window.event;
        if (evt.keyCode == 8 && evt.srcElement.tagName != "INPUT" && evt.srcElement.type != "text")
            evt.returnValue=false;
    }

    function cls1(){
        $(".dia3").fadeOut();
    };

    function addcomplain1() {
        var reg1=/^(([^\^\.<>%&',;=?$"'#~\]\[{}\\/`\|])*)$/;
        var orderNo = $("#orderCode").val();
        var comType = "其他方面";
        var comCon = $("#complaincon").val();
        var customerId=$("#customer_id").val();

        if (comCon == null || $.trim(comCon).length < 10 || $.trim(comCon).length > 250) {
            $("#errorContent").html("字数在10-250字内!");
            dia(3)
            return;
        } else {
            if(!reg1.test(comCon)){
                $("#errorContent").html("不能包含特殊字符!");
                dia(3)
                return;
            }
            $(".c_tip").removeClass("m_tip").html("不能包含特殊字符请您如实填写原因，字数在10-250字内且不要包含特殊字符。");

        }
        var paramStr = "complainType=" + comType;
        paramStr += "&complainContext=" + comCon;
        paramStr += "&orderNo=" + orderNo;
        if("undefined" != typeof(customerId)){
            paramStr += "&customerId=" + parseInt(customerId);
        }
        paramStr += "&CSRFToken="+$("#hi_token").val();
        $.ajax({
            type : 'post',
            url : '/customer/addcomplain.html',
            data : paramStr,
            async : false,
            success : function(data) {
                if (data > 0) {
                    $("#errorContent").html("提交成功！");
                    dia(3);
                    setTimeout(function(){
                        //跳转到结果页面，并传递状态
                        window.location.href= "/customer/myorder.html"
                    },1000)
                } else {
                    $("#errorContent").html("提交失败，请稍后重试！");
                    dia(3);
                }
            },
            error : function(){
                $("#errorContent").html("系统繁忙，请稍后重试！");
                dia(3);
            }
        });
    }

    $(function(){
        $("#payPassword").val("");
        var orderSum = $("#orderSum").val();
        $("#isGiftCardPay").click(function(){
            if($(this).is(':checked')){
                $("#payId").val("");
                $(this).val(1);
                $(".types li a").removeClass("selected");
                $("#errorMsg").text("").hide();
                //提交按钮置灰
                $(".pay-btn").addClass('disabled');
                //查询后台的余额信息
                var defer = $.ajax({
                    url:'/checkdepositpay.htm',
                    type:'post',
                    data:$(".payOrder").serialize()
                });
                defer.done(function(res){

                    if(res.giftcardNo == "" || res.giftcardNo == null){
                        $(".ngiftcard").removeClass("hide");
                    }else{
                        if(res.activeFlag == '-2'){
                            $(".tip-alert").html("您的卡片已挂失，请联系客服人员！");
                            return;
                        }
                        if(res.retcode=='-1'){ //返回码
                            if(res.errorcode==1){//错误码1没有设置支付密码。
                                $(".tip-alert").html(res.msg + '&nbsp;&nbsp;<a href="${basePath}/customer/securitycenter.html">去设置</a>');
                                return;
                            }else if(res.errorcode==2){
                                $(".tip-alert").html(res.msg);
                                return;
                            }
                        }else if(res.retcode=='0'){
                            $(".tip-alert").html("");
                        }
                        //debugger;
                        $(".for-pre-deposit .f1").addClass("hide");
                        if(res.predeposit!=null){
                            res.predeposit = res.predeposit.toFixed(2);
                            if(res.predeposit == 0){
                                $(".nbalance").removeClass("hide");
                                $("#predeposit").text(orderSum);
                            }else{
                                $(".giftcard").removeClass("hide");
                                $(".ypay").removeClass("hide");
                                $("#payInput").show();
                                if(res.predeposit - orderSum > 0){
                                    $("#predeposit").text(orderSum);
                                    $("#uesgcprice").text(orderSum);
                                    $("#balance").text((res.predeposit - orderSum).toFixed(2));
                                    $(".needgcprice").text("0.00");
                                }else{
                                    $(".tip-alert.fl").html("");
                                    $("#predeposit").text(res.predeposit);
                                    $("#uesgcprice").text(res.predeposit);
                                    $("#balance").text("0.00");
                                    $(".needgcprice").text((orderSum - res.predeposit).toFixed(2))
                                }
                                if(res.errorcode == null){
                                    $("#payInput").show();
                                }
                            }
                        }
                    }

                    $(".box.for-pre-deposit").show();
                });
            }else{
                $(".box.for-pre-deposit").hide();
                $(this).val(0);
                $("#uesgcprice").text("0.00");
                $(".needgcprice").text(orderSum);
            }
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