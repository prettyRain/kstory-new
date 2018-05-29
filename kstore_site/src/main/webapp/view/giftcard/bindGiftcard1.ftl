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
                    <form action="${basePath}/giftcard/bindGiftcardSecond.htm" id="rechargeForm" method="post">
                        <div class="box">
                            <p class="h4">请输入您的礼品卡密码进行绑定：</p>
                            <div class="charge-form">
                                <input type="text" class="text" placeholder="请输入礼品卡密码" id="giftcardPwd" name="giftcardPwd" style="width: 300px;"/>
                            </div>
                            <label for="giftcardPwd" generated="true" class="error" id="giftcardPwderror" style="display: none;">密码无效，请核对后输入</label>
                        </div>
                        <div class="box">
                            <div class="charge-form">
                                <input type="text" class="text" placeholder="请输入图片验证码" name="checkCode" id="checkCode"/>
                                <div class="vCode" style="display: inline-block;">
                                    <img id="checkCodeImg" src="${basePath}/patchca.htm" onclick="this.src=this.src+'?'+Math.random(); " alt="验证码">
                                    <a id="checkCodeA" href="javascript:void(0)">换一张</a>
                                </div>
                            </div>
                            <input type="hidden" id="errorCode" value="${errorCode!0}">
                            <label for="checkCode" generated="true" class="error" id="checkCodeerror" style="display: none;">验证码错误</label>
                        </div>
                        <div class="box">
                            <a href="javascript:;" class="charge-btn" onclick="resetForm();">清空</a>
                            <a href="javascript:;" class="charge-btn" onclick="validateForm();">下一步</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>


    <div class="member-dialog dia1" id="dia1">
        <div class="member-dialog-body">
            <div class="title"><a href="javascript:;" onclick="cls()">×</a></div>
            <img src="${basePath}/images/btn_tips@2x.png" alt="" style="width: 45px;height: 45px;margin: 0 auto; margin-top:13px;display: block;">
            <div class="dia-tips">
                <p class="txt">

                </p>
            </div>
            <div class="dia-btn" style="margin-top: 40px;">
                <a class="btn active new_order_active" href="javascript:;">下一步</a>
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

    $(function(){
        //验证码绑定onclick事件
        $("#checkCodeA").click(
            function(){
                $("#checkCodeImg").click();
            }
        );
        $("#checkCode").focus(function () {
            $("#checkCodeerror").hide();
        });
        $("#giftcardPwd").focus(function () {
            $("#giftcardPwderror").hide();
        });
    });

    function resetForm() {
        $("#giftcardPwd").val("");
        $("#checkCode").val("");
        $("#checkCodeImg").click();
        $("#checkCodeerror").hide();
        $("#giftcardPwderror").show();
    }

    var $form = $("#rechargeForm");
    $form.validate({
        rules: {
            giftcardPwd: {
                required: true
            },
            checkCode: {
                required: true
            },
        },
        messages: {
            giftcardPwd: {
                required: '请输入礼品卡密码'
            },
            checkCode: {
                required: '请输入验证码'
            },
        },
        errorPlacement: function (error, element) {
            $(element).parents('.box').append(error);
        },
    });

    $form.validate();

    function validateForm() {
        if ($form.valid()) {
            //先判断验证码是否正确
            $.ajax({
                url:"/giftcard/checkCode.htm",
                type:"post",
                data:"checkCode="+$("#checkCode").val(),
                async:false,
                success:function (data) {
                    if(data==0){
                        $("#checkCodeerror").show();
                        return false;
                    }else{
                        $.post(
                            "/giftcard/getGiftcard.htm",
                            "giftcardPwd="+$("#giftcardPwd").val(),
                            function (data) {
                                if(data!=null && data.activeFlag=="1" && data.deposit==null){
                                    $(".txt").html("您绑定的礼品卡ID为"+data.giftcardNo+",当前余额为"+data.giftcardPrice+"元");
                                    dia(1);
                                }else{
                                    $("#giftcardPwderror").show();
                                    return false;
                                }
                            }
                        );
                    }
                }
            });
        }
    }
    $(".btn").on("click",function () {
        $form.submit();
    });

</script>

</body>
</html>