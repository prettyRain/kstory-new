<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <#assign basePath=request.contextPath/>
  <meta charset="UTF-8">
  <title>会员中心 - 优惠券</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <meta content="telephone=no" name="format-detection">
  <link rel="stylesheet" href="${basePath}/css/style.min.css"/>
  <link rel="stylesheet" href="${basePath}/css/tip-newbox.css">
  <script src="${basePath}/js/jquery-1.10.1.js"></script>
  <script src="${basePath}/js/tip-newbox.js" type="text/javascript"></script>
    <style>
        .member_form2 dl {
            position: relative;
            display: block;

            padding: 0;
            border-bottom: 1px solid #D6D6D6;
        }
       /* .member_form2 dl dt {
            position: absolute;
            left: .8em;
            top: .26rem;
            color: #999999;
            font-size: .28rem;
        }*/
        .member_form2 dl dd input.text, .member_form2 dl dd textarea.text{
            color: #000;
            font-size: .3rem;
            height:1.1rem;
        }
      .empty_value {
            width: 1.3em;
            height: 1.3em;
            position: absolute;
            right: 1em;
            top: .28rem;
        }
        .member_form2{
            margin-top: 10px;
        }
        .bottom-fixed {
            position: relative;
            background: #f7f7f7;
            bottom: 0;
            left: 0;
            width: 100%;
            border-top: none;
            padding: 40px;
        }
        .btn-full {
            border-radius: 8px;
            margin: 0 auto;
            /*background: linear-gradient(right , rgb(25, 147, 1) 5% , rgb(55, 184, 65) 96%);*/
            /*background: -o-linear-gradient(right , rgb(25, 147, 1) 5% , rgb(55, 184, 65) 96%);*/
            /*background: -ms-linear-gradient(right ,rgb(25, 147, 1) 5% , rgb(55, 184, 65) 96%);*/
            /*background: -moz-linear-gradient(right , rgb(25, 147, 1) 5% , rgb(55, 184, 65) 96%);*/
            /*background: -webkit-linear-gradient(right , rgb(25, 147, 1) 5% , rgb(55, 184, 65) 96%);*/
            background:#199301;
            padding:13px;
            color: #ffffff!important;
            border: none;
            line-height: 24px;
            font-size: 15px;
            letter-spacing: 0;
        }
        :-moz-placeholder { /* Mozilla Firefox 4 to 18 */
            color: #999999;
        }

        ::-moz-placeholder { /* Mozilla Firefox 19+ */
            color: #999999;
        }

        input:-ms-input-placeholder{
            color: #999999;
        }

        input::-webkit-input-placeholder{
            color: #999999;
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
<#assign vtitle="券码兑换" />
<#if flag??>
    <#if flag?number ==0>
        <#assign backUrl="javascript:history.go(-1)" />
        <#--<#assign backUrl = "${basePath}/customer/coupon.html?type=1">-->
    <#elseif flag?number == 1>
        <#assign backUrl = "${basePath}/tocouponlist.htm?codeNo=${codeNo!''}&invoiceTitle=${invoiceTitle!''}&invoiceType=${invoiceType!''}&addressId=${addressId!''}&typeId=${typeId!''}&ch_pay=${ch_pay!''}&deliveryPointId=${deliveryPointId!''}&taxpayerNumber=${taxpayerNumber!''}&orderComment=${orderComment!''}">
    </#if>
</#if>

<#include "../common/head_back.ftl"/>
<#--<div class="form_title">
  <dl>
    <dt>已绑手机</dt>
    <dd>
      <span><#if customercon.infoMobile?? && customercon.infoMobile!=''>${customercon.infoMobile?substring(0,3)}***${customercon.infoMobile?substring(customercon.infoMobile?length-4)}<#else>未绑定</#if></span>
    </dd>
  </dl>
</div>-->
<div class="member_form2">
  <dl>
  <#--  <dt>券号</dt>-->
    <dd>
      <input type="text" onkeyup="way2();" onfocus="way3();" id="couponCode" class="text" placeholder="请输入券码"/>
        <img class="empty_value" src="/images/v1/myimages/btn_xiaochacha.png" style="display: none;">
    </dd>
  </dl>
</div>
<input type="hidden" id="flag" value="${flag!'0'}"/>
<div class="bottom-fixed p10">
  <a href="javascript:;" class="btn btn-full">确认兑换</a>
</div>

<script>
    var tip = myAlertStr();
    $(".empty_value").click(function () {
        $(".text").val("");
        $(".empty_value").hide();
        $(".text").focus();
    });
    function way2() {
        var val = $(".text").val();
        if (val === "") {
            $(".empty_value").hide();
        } else {
            $(".empty_value").show();
        }
    }
    function way3() {

        var val = $(".text").val();
        if (val === "") {
            $(".empty_value").hide();
        } else {
            $(".empty_value").show();
        }
    }
  $(function(){
  });
  
  $(".btn-full").click(function(){
        var couponCode = $("#couponCode").val();
        if(couponCode == "" || couponCode == null){
           /* $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>请输入券号</h3></div></div>');
            setTimeout(function(){
                $('.tip-box').remove();
            },1000);*/
           tip("请输入券号");
            return false;
        }
        if(!(/^[A-Za-z0-9]{16}$/).test(couponCode)){
            /*$('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>券号格式不正确</h3></div></div>');
            setTimeout(function(){
                $('.tip-box').remove();
            },1000);*/
            tip("券号格式不正确");
            return false;
        }
        
        $.ajax({
            url:"addcoupons.htm",
            type:"post",
            data:{couponCode:couponCode},
            success:function(data){
                if(data == 2){
                   /* $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><i class="success"></i><h3>添加成功</h3></div></div>');
                    setTimeout(function(){
                        $('.tip-box').remove();
                    },1000);*/
                   tip("添加成功");
                   setTimeout(function(){
                       if($("#flag").val()=='0'){
                           window.location.href="${basePath}/customer/coupon.html?type=1";
                       }else{
                           window.location.href="${basePath}/tocouponlist.htm?codeNo=${codeNo!''}&invoiceTitle=${invoiceTitle!''}&invoiceType=${invoiceType!''}&addressId=${addressId!''}&typeId=${typeId!''}&ch_pay=${ch_pay!''}&deliveryPointId=${deliveryPointId!''}&taxpayerNumber=${taxpayerNumber!''}&orderComment=${orderComment!''}";
                       }
                   },1000)
                }else if(isNaN(data)){
                    window.location.href="${basePath}/data";
                }else if(data == 3){
                    /*$('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>您领取的该优惠券已达上限</h3></div></div>');
                    setTimeout(function(){
                        $('.tip-box').remove();
                    },1000);*/
                    tip("您领取的该优惠券已达上限");
                }else{
                    /* $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>输入的券码无效</h3></div></div>');
                    setTimeout(function(){
                        $('.tip-box').remove();
                    },1000);*/
                    tip("输入的券码无效");
                }
            }
        });
        
  });
</script>
</body>
</html>