<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>我的礼品卡-${topmap.systembase.bsetName}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="Keywords" content="${topmap.seo.meteKey}">
    <meta name="description" content="${topmap.seo.meteDes}">
<#assign basePath=request.contextPath>
<#if (topmap.systembase.bsetHotline)??>
    <link rel="Shortcut Icon" href="${(topmap.systembase.bsetHotline)!''}">
<#else>
    <link rel="Shortcut Icon" href="${basePath}/images/Paistore.ico">
</#if>
    <link rel="stylesheet"href="${basePath}/css/pages.css"/>
    <link rel="stylesheet" href="${basePath}/index_twentyone/css/index_css.m.css"/>
    <link rel="stylesheet" href="${basePath}/index_seven/css/style.css"/>
    <link rel="stylesheet" href="${basePath}/css/receive.m.css"/>
    <script type="text/javascript" src="${basePath}/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${basePath}/index_960/js/app.js"></script>
    <style>
        .cart-top {
            top: 5px !important;
        }
        #logo{
            padding-top:0;
        }
        label.error {
            display: block;
            line-height: 20px;
            padding-left: 18px;
            background: url('../images/ero.png') no-repeat left center;
            color: #E45050;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<div style="">
<#include "../common/newHeaderShopcart.ftl"/>

    <div style="background: #f5f5f5;">
        <div class="container clearfix pt20 pb10">
            <div class="recharge-box">
                <div class="title">
                    <p class="h2">我的礼品卡</p>
                </div>
                <div class="body">
                    <form action="${basePath}/giftcard/updateGiftcard.htm" id="rechargeForm" method="post">
                        <input type="hidden" id="giftcardPwd" name="giftcardPwd" value="${giftcardPwd!''}">
                        <div class="box">
                            <p class="h4">请设置支付密码：</p>
                            <div class="charge-form">
                                <input type="password" class="text" placeholder="请输入支付密码" id="payPassword" name="payPassword" style="width: 300px;"/>
                            </div>
                        </div>
                        <div class="box">
                            <div class="charge-form">
                                <input type="password" class="text" placeholder="请再次输入支付密码" id="repassword" name="repassword" style="width: 300px;"/>
                            </div>
                        </div>
                        <div class="box">
                            <a href="javascript:;" class="charge-btn" onclick="validateForm();">确认</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>


    <div class="member-dialog dia1" id="dia1">
        <div class="member-dialog-body">
            <div class="title"><a href="javascript:;" onclick="cls()">×</a>提示</div>
            <div class="dia-tips">
                <p class="txt">
                    请确认是否已经完成支付
                </p>
            </div>
            <div class="dia-btn">
                <a class="btn active" href="${basePath}/deposit/mydeposit.htm">完成支付</a>
                <a class="btn" href="javascript:void(0)" onclick="showHelp()" id="payhelp">付款遇到问题</a>
            </div>
        </div>
    </div>
</div>

<#--引入底部 <#include "/index/bottom.ftl" />  -->
<#if (topmap.temp)??>
    <#if (topmap.temp.tempId==1)>
        <#include "../index/bottom.ftl">
    <#else>
        <#include "../index/newbottom.ftl" />
    </#if>
</#if>

<div class="mask"></div>

<script type="text/javascript" src="${basePath}/js/default.js"></script>
<script type="text/javascript" src="${basePath}/js/tab-switch.js"></script>
<script type="text/javascript" src="${basePath}/js/customer/customer.js"></script>
<script type="text/javascript" src="${basePath}/js/jsOperation.js"></script>

<script type="text/javascript" src="${basePath}/js/common/jquery.validate.js"></script>
<script type="text/javascript" src="${basePath}/js/common/jquery.validate_extend.js"></script>

<script>

    $(function () {
        $("#payPassword").blur(function(){
            psdchk($(this));
        });

        $("#repassword").blur(function(){
            psdconf($(this));
        });
    });

    //自定义验证规则（/^[\x21-\x7E]{6,20}$/）
    $.validator.addMethod("pwd",function (value, element) {
        return this.optional(element) || /^[\x21-\x7E]{6,16}$/.test(value);
    }, "密码必须是6-16位数字或字母或符号组成");

    var $form = $("#rechargeForm");
    $form.validate({
        rules: {
            payPassword: {
                required: true,
                pwd:true
            },
            repassword: {
                equalTo: "#payPassword",
                pwd:true
            },
        },
        messages: {
            payPassword: {
                required: '请输入支付密码'
            },
            repassword: {
                equalTo: '两次填写的密码必须一致'
            },
        },
        errorPlacement: function (error, element) {
            $(element).parents('.box').append(error);
        },
    });

    $form.validate();

    function validateForm() {
        if ($form.valid()) {

            $form.submit();
        }
    }

</script>

</body>
</html>