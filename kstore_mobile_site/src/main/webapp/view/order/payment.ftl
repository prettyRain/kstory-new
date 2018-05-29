<#assign basePath=request.contextPath>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>订单支付</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="stylesheet" type="text/css" href="${basePath}/css/v2/framework7.ios.min.css">
    <link rel="stylesheet" type="text/css" href="${basePath}/css/v2/framework7.ios.colors.min.css">
    <link href="${basePath}/css/ui-dialog.css" rel="stylesheet">
    <link href="${basePath}/css/v2/payment.css" rel="stylesheet">
    <script src="${basePath}/js/jquery-1.10.1.js"></script>
    <script src="${basePath}/js/dialog-min.js"></script>
</head>
<body>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>

<input type="hidden" id="orderId" value="${orderId}" />

<div class="views">
    <div class="view view-main">
        <div class="pages">
            <div data-page="home" class="page navbar-fixed">
                <div class="navbar">
                    <#assign vtitle="支付" />
                    <#assign backUrl="${basePath}/customer/myorder-1-1.html" />
                    <#include "../common/head_back.ftl"/>
                </div>
                <div class="page-content">
                    <div class="content-block">

                        <div class="paytitle">
                            <p class="payinfo">订单已提交</p>
                            <div class="paydetail">请于次日00:00前进行支付，超时订单将自动取消</div>
                        </div>
                        <div class="paymethod">
                            <div class="method">选择支付方式</div>
                            <div class="payprice">
                                <span>订单金额</span>
                                <span>￥<span >${payPrice?number?string("0.00")?substring(0,payPrice?number?string("0.00")?index_of("."))}</span>${payPrice?number?string("0.00")?substring(payPrice?number?string("0.00")?index_of("."))}</span>
                            </div>

                        <#list pays as pay>
                            <#if pay.payDefault=="1">
                                <input type="hidden" value="${pay.payId}" name="payId" id="payId"/>
                                <input type="hidden" value="${pay.payType}" name="payType" id="payType"/>
                            </#if>
                            <#--微信支付-->
                            <#if pay.isOpen == '1' && pay.payType=="3">
                                <div class="weixin choose way">
                                    <p>微信支付</p>
                                    <i class="select-box selected" onclick="payTypeClick(this,'${pay.payId}','${pay.payType}')"></i>
                                    <#--<i class="select-box selected" ></i>-->
                                </div>
                            <#--支付宝支付-->
                            <#elseif pay.payId == 25>
                                <div class="zhifb choose way">
                                    <p>支付宝支付</p>
                                    <i class="select-box selected" onclick="payTypeClick(this,'${pay.payId}','${pay.payType}')"></i>
                                    <#--<i class="select-box selected" ></i>-->
                                </div>
                            </#if>
                        </#list>
                        <#--礼品卡账户支付 货品包含礼品卡不能使用-->
                        <#if (cardNum == 0)>
                            <div class="lpCard choose unable">
                                <p>礼品卡账户</p>
                                <div class="status sta1">不可使用</div>
                                <div class="status sta2" onclick="_czc.push(['_trackEvent', '确认订单', '支付', '礼品卡']);">点击抵扣</div>
                                <div class="status sta3">点击取消</div>
                                <i class="select-box selected before" >￥0.00</i>
                                <i class="select-box selected after" >￥0.00</i>
                            </div>
                        </#if>
                            <a href="javascript:;" class="gotopay pay-btn">
                                <span>立即支付&nbsp;&nbsp;￥</span><span id="integer">${payPrice?string("0.00")?substring(0,payPrice?string("0.00")?index_of('.'))}</span><span id="decimal">${payPrice?string("0.00")?substring(payPrice?string("0.00")?index_of('.'))}</span>
                            </a>
                            <strong class="needgcprice" style="display: none;">${payPrice?string("0.00")}</strong>
                            <input id="integerMoney" value="0" type="hidden">
                            <input id="decimalMoney" value="0" type="hidden">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="popup popup-about">
    <div class="content-block">
        <#--礼品卡输入密码面板-->
        <div class="payPanel">
            <a href="#" class="close-popup">返</a>
            <div class="price">￥<span class="integer"></span><span class="decimals"></span></div>
            <p class="prompt">请输入6-16位支付密码，该密码不同于登录密码</p>
            <input type="password" id="lpk_psd" class="lpkPsd" placeholder="请输入支付密码" />
            <a href="javascript:;" class="affirm"><span>确认</span></a>
        </div>
    </div>
</div>








<#--礼品卡账户支付 货品包含礼品卡不能使用-->
<#--<#if (cardNum == 0)>-->
    <#--<div class="giftcard">-->
        <#--<div class="gchoose">-->
            <#--<p>使用礼品卡</p>-->
            <#--<i class="choose-box" onclick="payGiftCard(this)"></i>-->
        <#--</div>-->
        <#--<p class="info ypay hide">已使用礼品卡账户内 <span id="predeposit">null</span>元，剩余 <span id="balance">null</span>元。<span class="hide giftcard">还需使用其他方式支付 <strong class="needgcprice">0</strong> 元。<p></p>-->
        <#--<p class="info nbalance hide">您的礼品卡账户余额为 ￥<span>0.00</span></p>-->
        <#--<p class="info ngiftcard hide">您尚未绑定礼品卡</p>-->
        <#--<input type="password" id="lpk_psd" placeholder="请输入6-16位支付密码" class="hide info" />-->
        <#--<p class="info hide msg" style="margin: 0;"></p>-->
    <#--</div>-->
<#--</#if>-->
    <input type="hidden" id="payPrice" value="${payPrice?string('0.00')}">
    <img src="../../images/v3/doing.gif" width="49" height="49" style="display:none;">




<script type="text/javascript" src="${basePath}/js/v1/framework7.min.js"></script>
<script src="${basePath}/js/shoppingcart/jsOperation.js"></script><#--运算-->
<script src="${basePath}/js/v2/payment.js"></script>
<p style="display: none;">
    <!--友盟CNZZ统计-->
    <script src="https://s13.cnzz.com/z_stat.php?id=1264375679&web_id=1264375679" language="JavaScript">
        var _czc = _czc || [];
        _czc.push(["_setAccount", "m.ge960.com"]);
    </script>
</p>
</body>
</html>
<script>

    $(function() {
        if (isWeiXin()) {
            $(".weixin").show();
            $(".zhifb").hide();
            $("#payId").val(37);
            $("#payType").val(3);
        }else{
            $(".weixin").hide();
            $(".zhifb").show();
        }

        $("#lpk_psd").keyup(function(){
            var val = $(this).val();
            if(!val){
                $(".prompt").addClass("error").text('密码不能为空');
                $(".affirm").removeClass('affirmBtn');
            }else{
                $(".prompt").removeClass("error").text('请输入6-16位支付密码，该密码不同于登录密码');
                $(".affirm").addClass('affirmBtn');
            }
        });

        //确认支付点击的时候
        var flagtap = true;
        $('.pay-btn').click(function() {
            var gopaycharge = $(".gotopay.pay-btn").html();

            if ($(this).hasClass("disabled")) {
                return;
            }
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

            var payMark = 0;
            var orderId = $("#orderId").val();
            var payType = $("#payType").val();
            var payId =  $("#payId").val();
            var mark = 0;
            if ($(".status.sta3").css("display") == "block") {
                var needgcprice = $(".needgcprice").text();
                if(needgcprice == "0"){
                    $("#payId").val("");
                }else{
                    if(payId == ""){
                        $(".msg").text('请选择一个支付方式支付剩余金额！').removeClass("hide");
                        $(".gotopay.pay-btn").removeClass("load");$(".gotopay.pay-btn").html(gopaycharge);
                        flagtap=true;
                        return;
                    }
                }
                var payPassword = $("#lpk_psd").val();
                if(!payPassword){//密码为空
                    $(".msg").text('密码不能为空').removeClass("hide");
                    //提交按钮置灰
                    $(".pay-btn").addClass('disabled');
                    $(".gotopay.pay-btn").removeClass("load");$(".gotopay.pay-btn").html(gopaycharge);
                    flagtap=true;
                    return;
                }else{
                    $.ajax({
                        url:'${basePath}/depositpayorder.htm',
                        type:'post',
                        data: {"orderId":orderId,"payPassword":payPassword},
                        async:false,
                        success: function(result){
                            if(result.return_code == "success"){
                                $(".msg").text("支付成功！").removeClass("hide");
                                mark = 1;
                                setTimeout(function(){
                                    $(".pay-btn").addClass('disabled');
                                    location.href="${basePath}/intoPage.htm?pageName=order/pay_success_new&orderId="+orderId+"&payPrice="+$("#payPrice").val();
                                },1000);
                            }else if(result.return_code == "fail"){
                                var return_msg = result.return_msg;
                                var fail_code = result.fail_code;
                                if(fail_code == 'pass_fail'){
                                    //无密码
                                    $(".msg").text(return_msg).removeClass("hide");
                                    mark = 1;
                                }else if(fail_code == 'frozen_fail'){
                                    //账户锁定
                                    $(".msg").text(return_msg).removeClass("hide");
                                    mark = 1;
                                }else if(fail_code == 'balance_fail'){
                                    //余额不足
                                    mark = 0;
                                    payMark = 1;
                                }else{
                                    $(".msg").text("系统异常，请稍后重试！").removeClass("hide");
                                    mark = 1;
                                }
                                $(".gotopay.pay-btn").removeClass("load");$(".gotopay.pay-btn").html(gopaycharge);
                                flagtap=true;
                            }
                        }
                    });
                }
            }
            if(payId != "" && mark == 0){
                if(payType == 1){
                    $(".gotopay.pay-btn").removeClass("load");$(".gotopay.pay-btn").html(gopaycharge);
                    flagtap=true;
                    window.location.href = "${basePath}/alipay.htm?orderId="+orderId+"&payId="+payId+"&mark="+payMark;

//                    setTimeout(function(){$(".gotopay.pay-btn").removeClass("load");},2000)
                }else if(payType == 3){
                    $.ajax({
                        type: "POST",
                        url: "${basePath}/getwxparam.htm?orderId="+orderId+"&payId="+payId+"&mark="+payMark,
                        success: function(msg){
                            if(msg==''){
                                location.href="${basePath}/customer/myorder.html";
                            }
                            $("#orderId").val(msg.orderId);
                            callpay(msg.appId,msg.timeStamp,msg.nonceStr,msg.package,msg.sign);
                            $(".gotopay.pay-btn").removeClass("load");$(".gotopay.pay-btn").html(gopaycharge);
                            flagtap=true;
                        }
                    });
                }
            }
        });
    });

    //判断是否是微信打开
    function isWeiXin(){
        var ua = window.navigator.userAgent.toLowerCase();
        if(ua.match(/MicroMessenger/i) == 'micromessenger'){
            return true;
        }else{
            return false;
        }
    }

//    function payTypeClick(ele,payId,payType) {
//        var needgcprice = $(".needgcprice").text();
//        if(needgcprice == "0"){
//            //$(".giftcard .choose-box").removeClass("selected");
//            //$(".giftcard .info").addClass("hide");
//            //取消抵扣
//            cancelcardPay();
//            $("#integer").html($('#payPrice').val().toString().substring(0,$('#payPrice').val().toString().indexOf(".")));
//            $("#decimal").html($('#payPrice').val().toString().substring($('#payPrice').val().toString().indexOf(".")));
//        }else{
//            $(".msg").text('').addClass("hide");
//        }
//        $(".paymethod .select-box").removeClass("selected");
//        $(ele).addClass("selected");
//        $("#payId").val(payId);
//        $("#payType").val(payType);
//        $(".pay-btn").removeClass("disabled");
//    }



    <#--function payGiftCard(ele) {-->
        <#--//var orderId = $("#orderId").val();-->
        <#--$("#lpk_psd").val("");-->
        <#--if ($(ele).hasClass("selected")) {-->
            <#--$("#integer").html($('#payPrice').val().toString().substring(0,$('#payPrice').val().toString().indexOf(".")));-->
            <#--$("#decimal").html($('#payPrice').val().toString().substring($('#payPrice').val().toString().indexOf(".")));-->
            <#--$(".info").addClass("hide");-->
            <#--$("#lpk_psd").addClass("hide");-->
            <#--$(ele).removeClass("selected");-->
        <#--} else {-->
            <#--//提交按钮置灰-->
            <#--$(".pay-btn").addClass('disabled');-->
            <#--$(ele).addClass("selected");-->
            <#--$(".paymethod .select-box").removeClass("selected");-->
            <#--$("#payId").val("");$("#payType").val("");-->
            <#--$.ajax({-->
                <#--url:'${basePath}/order/depositpay.html?orderId='+orderId,-->
                <#--type:'post',-->
                <#--success: function(result){-->
                    <#--var return_code = result.return_code;-->
                    <#--var fail_code = result.fail_code;-->
                    <#--var return_msg = result.return_msg;-->
                    <#--if(return_code == "nocard"){-->
                        <#--$(".ngiftcard").removeClass("hide");-->
                    <#--}else{-->
                        <#--if(result.activeFlag == '-2'){-->
                            <#--$(".msg").text("您的卡片已挂失，请联系客服人员！").removeClass("hide");-->
                            <#--$(".gotopay.pay-btn").removeClass("load");-->
                            <#--return;-->
                        <#--}-->
                        <#--var orderPrice = 0;-->
                        <#--if(fail_code != 'pass_fail' && fail_code != 'frozen_fail'){-->
                            <#--return_msg = return_msg.toFixed(2);-->
                            <#--orderPrice = result.order_price.toFixed(2);-->
                            <#--if(Number(orderPrice)<=Number(return_msg)){-->
                                <#--$("#integer").html(Subtr($('#payPrice').val(),orderPrice).toString().substring(0,Subtr($('#payPrice').val(),orderPrice).toString().indexOf('.')));-->
                                <#--$("#decimal").html(Subtr($('#payPrice').val(),orderPrice).toString().substring(Subtr($('#payPrice').val(),orderPrice).toString().indexOf('.')));-->
                            <#--}else{-->
                                <#--$("#integer").html(Subtr($('#payPrice').val(),return_msg).toString().substring(0,Subtr($('#payPrice').val(),return_msg).toString().indexOf('.')));-->
                                <#--$("#decimal").html(Subtr($('#payPrice').val(),return_msg).toString().substring(Subtr($('#payPrice').val(),return_msg).toString().indexOf('.')));-->
                            <#--}-->
                        <#--}-->
                        <#--if(return_code == 'success'){-->
                            <#--$(".ypay").removeClass("hide");-->
                            <#--$("#lpk_psd").removeClass("hide");-->
                            <#--$("#predeposit").text(orderPrice);-->
                            <#--$("#balance").text((return_msg - orderPrice).toFixed(2));-->
                        <#--}else if(return_code == 'fail'){-->
                            <#--if(fail_code == 'pass_fail'){-->
                                <#--$(".msg").text(return_msg).removeClass("hide");-->
                            <#--}else if(fail_code == 'frozen_fail'){-->
                                <#--$(".msg").text(return_msg).removeClass("hide");-->
                            <#--}else if(fail_code == 'balance_fail'){-->
                                <#--if(return_msg == 0){-->
                                    <#--$(".nbalance").removeClass("hide");-->
                                <#--}else{-->
                                    <#--$(".giftcard").removeClass("hide");-->
                                    <#--$("#lpk_psd").removeClass("hide");-->
                                    <#--$(".ypay").removeClass("hide");-->
                                    <#--$("#predeposit").text(return_msg);-->
                                    <#--$("#balance").text("0.00");-->
                                    <#--$(".needgcprice").text((orderPrice - return_msg).toFixed(2));-->
                                <#--}-->

                            <#--}-->

                        <#--}-->
                    <#--}-->
                <#--}-->
            <#--});-->

        <#--}-->
    <#--}-->

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
                    location.href="${basePath}/paysucccesswx.htm?orderId="+$("#orderId").val()+"&payPrice="+$("#payPrice").val();
                },1000);

            }else if(res.err_msg == "get_brand_wcpay_request:cancel"){
                $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><i class="failed"></i><h3>用户取消支付！</h3></div></div>');
                setTimeout(function(){
                    $('.tip-box').remove();
                    location.href="${basePath}/customer/detail-"+$("#orderId").val()+".html";
                },1000);
            }else{
                $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><i class="failed"></i><h3>支付失败！</h3></div></div>');
                setTimeout(function(){
                    $('.tip-box').remove();
                    location.href="${basePath}/customer/detail-"+$("#orderId").val()+".html";
                },1000);
            }
        })
    }
</script>