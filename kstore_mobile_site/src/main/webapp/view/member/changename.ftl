<!DOCTYPE html>
<html>
<head>
<#assign basePath=request.contextPath>
  <meta charset="UTF-8">
  <title>会员中心 - 我的账户</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <meta content="telephone=no" name="format-detection">
  <link rel="stylesheet" href="${basePath}/css/style.css"/>
  <link rel="stylesheet" href="${basePath}/css/tip-newbox.css">
  <script src="${basePath}/js/jquery-1.10.1.js"></script>
  <script src="${basePath}/js/idangerous.swiper.js"></script>
  <script type="text/javascript" src="${basePath}/js/tip-newbox.js"></script>
    <style>
        .member_form dl {
            position: relative;
            display: block;
            padding: 0 0 0 1em;
            height: 1.1rem;
            line-height: 1.1rem;
            border-bottom: 1px solid #f0f0f0;
        }
        .member_form dl dd input.text {
            width: 88%;
            border: 0;
            font-size: 15px;
            color: #000;
            letter-spacing: 0;
        }
        .member_form dl dd .empty_value{
            width: .36rem;
            height: .36rem;
            position: absolute;
            right: 1em;
            top: .37rem;
        }
        .vheader span {
            margin-right: 0!important;
            margin-left: 0.2rem!important;

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
<#assign vtitle="修改昵称" />
<#assign voption="完成" />

<#assign backUrl="${basePath}/myaccount.html?main=${main!''}" />
<#include "/common/head_back.ftl"/>
<div class="member_form">
<form action="${basePath}/savenickname.html" id="addForm" method="post">
  <dl>
 <#--   <dt>请输入昵称</dt>-->
    <dd style="position: relative">
        <input type="hidden" name="main" value="${main!''}">
      <input  onkeyup="way();" onfocus="way1();"type="text" placeholder="请输入昵称" value="${customer.customerNickname!''}" class="text" name="customerNickname"/>
        <img class="empty_value"  src="/images/v1/myimages/btn_xiaochacha.png" style="display: none;">
    </dd>
  </dl>
  <p class="help_block" style="display:none;" id="nickName_msg"></p>
<#--  <p class="help_block">4-20字符，由中文、英文、数字、-和_组成</p>-->
</form>
</div>

<#--<div class="p10 mb50">
  <a href="#" class="btn btn-full">保存</a>
</div>-->

<script>
     var tip = myAlertStr();

    $(".empty_value").click(function () {
        $(".text").val("");
        $(".empty_value").hide();
        $(".text").focus();
    })
    function way() {
        var val = $(".text").val();
        if (val === "") {
            $(".empty_value").hide();
        } else {
            $(".empty_value").show();
        }
    }
    function way1() {
        var val = $(".text").val();
        if (val === "") {
            $(".empty_value").hide();
        } else {
            $(".empty_value").show();
        }m
    }




    $(".bar-bottom a").removeClass("selected");
    $(".bar-bottom a:eq(3)").addClass("selected");

    $(".text").change(function(){
        $("#nickName_msg").html("");
        $("#nickName_msg").hide();
    });
    $("#icon-option").click(function(){
        var nickName = $(".text").val();
        if(nickName.length<3 || nickName.length>20){
            /*$('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>昵称长度不符合</h3></div></div>');
            setTimeout(function(){
                $('.tip-box').remove();
            },1000);*/
            tip("昵称长度不符合");
            return false;
        }
        var reg = new RegExp("^([a-zA-Z0-9_-]|[\\u4E00-\\u9FFF])+$", "g");
    var reg_number = /^[0-9]+$/; // 判断是否为数字的正则表达式
    //if (reg_number.test(nickName)) {
    //    $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>昵称不能设置为手机号等纯数字格式，请您更换哦^^</h3></div></div>');
    //    setTimeout(function(){
    //        $('.tip-box').remove();
    //    },1000);
    //    return false;
    //} 
     if (!reg.test(nickName)) {
    /* $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>昵称格式不正确</h3></div></div>');
        setTimeout(function(){
            $('.tip-box').remove();
        },1000);*/
        tip("昵称格式不正确");
        return false;
    }
      $("#addForm").submit();
    });
    $(".text").keydown(function(e){
        if(e.keyCode==13) {
            var nickName = $(".text").val();
            if (nickName.length < 3 || nickName.length > 20) {
               /* $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>昵称长度不符合</h3></div></div>');
                setTimeout(function () {
                    $('.tip-box').remove();
                }, 1000);*/
               tip("昵称长度不符合");
                return false;
            }
            var reg = new RegExp("^([a-zA-Z0-9_-]|[\\u4E00-\\u9FFF])+$", "g");
            var reg_number = /^[0-9]+$/; // 判断是否为数字的正则表达式
            //if (reg_number.test(nickName)) {
            //    $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>昵称不能设置为手机号等纯数字格式，请您更换哦^^</h3></div></div>');
            //    setTimeout(function(){
            //        $('.tip-box').remove();
            //    },1000);
            //    return false;
            //}
            if (!reg.test(nickName)) {
                /*$('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>昵称格式不正确</h3></div></div>');
                setTimeout(function () {
                    $('.tip-box').remove();
                }, 1000);*/
                tip("昵称格式不正确");
                return false;
            }
            $("#addForm").submit();
        }
    });
</script>
</body>
</html>