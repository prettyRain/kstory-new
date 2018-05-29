<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="Keywords" content="${topmap.seo.meteKey}">
    <meta name="description" content="${topmap.seo.meteDes}">
    <#assign basePath=request.contextPath>
    <title>${topmap.systembase.bsetName}</title>
    <link rel="stylesheet" type="text/css" href="${basePath}/css/pages.css"/>
    <link rel="stylesheet" href="${basePath}/index_seven/css/style.css"/>
    <link rel="stylesheet" href="${basePath}/index_twentyone/css/index_css.m.css"/>
    <link rel="stylesheet" href="${basePath}/index_seven/css/style.css"/>
    <link rel="stylesheet" href="${basePath}/css/receive.m.css"/>
    <script type="text/javascript" src="${basePath}/js/jquery-1.7.2.min.js"></script>
    <#if (topmap.systembase.bsetHotline)??>
        <link rel = "Shortcut Icon" href="${(topmap.systembase.bsetHotline)!''}">
    <#else>
        <link rel = "Shortcut Icon" href="${basePath}/images/Paistore.ico">
    </#if>
        <link rel="stylesheet" type="text/css" href="${basePath}/index_two/css/header.css" />
    <style type="text/css">
        .content{
            width: 100%;
            height: 600px;
            background: #f5f5f5;
        }
        .content .top_div{
            width: 1200px;
            height: 60px;
            margin: 0 auto;
        }
        .content .top_div p{
            display: inline-block;
            font-size: 14px;
            color: #333333;

            margin-top: 21px;
        }
        .content .top_div span{
            font-size: 14px;
            color: #333333;
        }
        .content .bottom_div{
            width: 1200px;
            height: 475px;
            background: #ffffff;
            margin:0 auto;
        }
        .content .bottom_div .bottom_left_div{
            width: 540px;
            height: 475px;
            float: left;
        }
        .content .bottom_div .bottom_left_div p{
            display: inline-block;
            margin-left: 40px;
        }
        .content .bottom_div .bottom_left_div p span{
            color: #e45050;
        }
        .content .bottom_div .bottom_left_div .p1{
            font-size: 12px;
        }
        .content .bottom_div .bottom_left_div .qrcode{
            width: 240px;
            height: 240px;
            background: #f5f5f5;
            margin:40px 0px 0px 261px;
        }
        .content .bottom_div .bottom_left_div .erweima_img{
            margin:20px 0px 0px 261px;
        }
        .content .bottom_div .bottom_right_div{
            width: 660px;
            height: 475px;
            float: left;

        }
        .content .bottom_div .bottom_right_div .erweima_img1{
            margin:65px 0px 0px 38px;
        }
        .content .bottom_div .bottom_left_div p:first-of-type {
            font-size: 16px;
            padding-top: 5px;
        }
    </style>
</head>

<body>
<#include "../common/newHeaderShopcart.ftl"/>
<div class="content">
    <input type="hidden" id="urlCode" value="${urlCode}">
    <input type="hidden" id="orderId" value="${orderCode}">
    <div class="top_div">
        <p>${body}</p>
    </div>

    <div class="bottom_div">
        <div class="bottom_left_div">
            <p>微信支付</p>
            <p class="pay_desc">等待支付&nbsp;&nbsp;<span style="font-size: 16px;font-weight: 700;">￥${order_price}</span></p>
            <div class="qrcode" id="qrcode" style="text-align: center">
                <img src="${basePath}/images/load.jpg">
            </div>
            <img src="${basePath}/images/weixin_saoma.png" class="erweima_img">
        </div>
        <div class="bottom_right_div">
            <img src="${basePath}/images/weixin_saomatishi.png" class="erweima_img1">
        </div>
    </div>

</div>
<#if (topmap.temp)??>
    <#if (topmap.temp.tempId==1)>
        <#include "../index/bottom.ftl">
    <#else>
        <#include "../index/newbottom.ftl" />
    </#if>
</#if>
</body>
<script type="text/javascript" src="${basePath}/js/default.js"></script>
<script src="${basePath}/js/qrcode.min.js"></script>
<script type="text/javascript">

    $(function(){
        var urlCode = $("#urlCode").val();
        if(urlCode != null){
            $("#qrcode").empty();
            var qrcode = new QRCode('qrcode', {
                text: urlCode,
                width: 240,
                height: 240,
                correctLevel : QRCode.CorrectLevel.H
            });
        }

        pay_status();
    });


    function pay_status(){
        var order_id = $("#orderId").val();
        $.ajax({
            url:'/rechargepay_status_check.htm',
            dataType:'json',
            type:'post',
            data:{'orderCode':order_id},
            success:function(data){
                if(data == '6'){
                    window.clearTimeout(int);//去掉定时器
                    $(".pay_desc").html("充值成功，3秒后自动跳转至我的预付款...");
                    setTimeout(function(){
                        //跳转到结果页面，并传递状态
                        window.location.href= "/deposit/mydeposit.htm"
                    },3000);
                }else if(data =='5'){

                }else{
                    window.location.href= "/login.html";
                }
            },
            error:function(){
               alert("支付异常，请稍后重试！");
            },

        });
    }

    //启动定时器
    var int = self.setInterval(function(){pay_status()},1000);
</script>
</html>

