<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<#assign basePath=request.contextPath>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>绑定${topmap.systembase.bsetName}</title>
    <link rel="stylesheet" href="${basePath}/css/binding_page.css">
    <link rel="stylesheet" href="${basePath}/css/iCheck/custom.css">
    <style type="text/css">
        .rightpar{
            display: none;
        }

    </style>
</head>
<body>
<#include "../index/newheader3.ftl"/>

<div class="binding_page">
    <ul class="page_ul">
        <li class="binding_page_active one_li" onclick="add_page();">
            <img src="${basePath}/images/icon_link@2x.png" alt="">
            <p>已有商城账号，请绑定</p>
        </li>
        <li onclick="remove_page();" class="two_li">
            <img src="${basePath}/images/icon_not_link_none@2x.png" alt="">
            <p>没有商城账号，请完善资料</p>
        </li>
    </ul>
    <div class="box">
        <div class="con0">
            <div class="popup">
                <div class="get_information">
                    <img src="${headimg}" alt="">
                    <div>
                        <p>Hi，<span><#if (screen_name?length>3)>${screen_name?substring(0,3)}..<#else>${screen_name}</#if></span> 欢迎来960商城，绑定后可以用<span>${three_part_type}</span>账号一键登录哦~</p>
                    </div>
                </div>
                <p class="share_p">
                    <label>商城账号：</label>
                    <input id="username1" class="inp" type="text" value=""placeholder="请输入已验证手机" onfocus="removeError()" >
                    <span class="cw_error"></span>
                </p>

                <p class="share_p">
                    <label>密码：</label>
                    <input id="password1" class="inp" type="password"  placeholder="请输入密码" onfocus="removeError()">
                    <span class="cw_error1"></span>
                </p>

                <input class="btn" id="popup-submit" type="submit" value="立即绑定">
            <#--<input type=hidden id="urlhide" value="${url}" />-->
                <div id="popup-captcha"></div>
                <a href="/findpwd.html" class="fr  forget_password">忘记密码？</a>
            </div>
        </div>
        <div class="con1">
            <div class="twocon1">
                <div class="get_information">
                    <img src="${headimg}" alt="">
                    <div>
                        <p>Hi，<span><#if (screen_name?length>3)>${screen_name?substring(0,3)}..<#else>${screen_name}</#if></span> 欢迎来960商城，绑定后可以用<span>${three_part_type}</span>账号一键登录哦~</p>
                    </div>
                </div>
                <p class="share_p">
                    <label>手机号：</label>
                    <input id="register_phone"  class="inp" type="text" value=""placeholder="请输入常用手机号"onfocus="removeError1()" >
                    <span class="cw_errorone"></span>
                </p>
                <p class="share_p">
                    <label>设置密码：</label>
                    <input id ="register_password" class="inp" type="password"  placeholder="请输入密码" onfocus="removeError1()">
                    <span class="cw_errortwo"></span>
                </p>
                <div class="share_p" style="width: 100%;height: 77px;position: relative;">
                    <label>验证码：</label>
                    <form style="float: right;">
                        <input type="text" id="register_yzm" class="inp" placeholder="请输入验证码" onfocus="removeError1()">
                    </form>
                    <span class="cw_errorthree"></span>
                <#-- <input class="inp" type="text"  placeholder="请输入验证码">-->
                    <button type="button" class="active_btn btn" onclick="sendMessage()" id="sendbtn"><p id="getcode">获取验证码</p>

                        <p class="tips code_send" style="display: none">
                            <span class="timeleft">59</span>秒后重新获取
                        </p>

                    </button>


                </div>
                <div class="reg_form_item">
                    <div class="item">
                        <div class="agreement_confirm">
                            <label>
                                <input type="checkbox" class="i-checks" checked id="readme">
                                我已阅读并同意<a href="javascript:void(0)" onclick="showpro();" id="protocol">《商城用户注册协议》</a>
                            </label>
                        </div>
                        <p class="tips pro_info" style="display: none">请接受服务条款</p>
                    </div>
                </div>
                <input class="btn" id="register_submit" type="submit" value="立即注册">
            </div>
        </div>
    </div>
</div>

<div class="mask" style="display:none"></div>
<div class="dialog dia1 agreement_dia" style="display:none">
    <div class="dia_tit">
    ${(topmap.systembase.bsetName)!''}用户协议
        <a class="dia_close" href="javascript:;" onclick="cls()"></a>
    </div><!--/dia_tit-->
    <div class="dia_cont">
        <div class="agreement_wp mt15">
        <#if (topmap.systembase.bsetUseragreement)??>
        ${(topmap.systembase.bsetUseragreement)!''}
        <#else>
            <h4>960用户注册协议</h4>
            <p>本协议是用户（以下简称“您”）与960网站（网址：包括但不限于demo.ningpai.com等，简称“本站”）所有者及其关联公司（以下简称为“960”）之间就960网站服务等相关事宜所订立的契约，请您仔细阅读本注册协议，您点击"同意并继续"按钮后，即视为您接受并同意遵守本协议的约定。</p>
            <h4>第1条 本站服务条款的确认和接纳</h4>
            <p>1.1本站的各项电子服务的所有权和运作权归960所有。您同意所有注册协议条款并完成注册程序，才能成为本站的正式用户。您确认：本协议条款是处理双方权利义务的依据，始终有效，法律另有强制性规定或双方另有特别约定的，依其规定或约定。</p>
            <p>1.2您点击同意本协议的，即视为您确认自己具有享受本站服务、下单购物等相应的权利能力和行为能力，能够独立承担法律责任。</p>
            <p>1.3您确认，如果您在18周岁以下，您只能在父母或其他监护人的监护参与下才能使用本站。</p>
            <p>1.4960保留在中华人民共和国大陆地区施行之法律允许的范围内独自决定拒绝服务、关闭用户账户、清除或编辑内容或取消订单的权利。</p>
            <p>1.5您使用本站提供的服务时，应同时接受适用于本站特定服务、活动等的准则、条款和协议（以下统称为“其他条款”）；如果以下使用条件与“其他条款”有不一致之处，则以“其他条款”为准。</p>
            <p>1.6为表述便利，商品和服务简称为“商品”或“货物”。</p>
            <h4>第2条 本站服务</h4>
            <p>2.1960通过互联网依法为您提供互联网信息等服务，您在完全同意本协议及本站相关规定的情况下，方有权使用本站的相关服务。</p>
            <p>2.2您必须自行准备如下设备和承担如下开支：（1）上网设备，包括并不限于电脑或者其他上网终端、调制解调器及其他必备的上网装置；（2）上网开支，包括并不限于网络接入费、上网设备租用费、手机流量费等。</p>
            <p>2.2.1上网设备，包括并不限于电脑或者其他上网终端、调制解调器及其他必备的上网装置；</p>
            <h4>第1条 本站服务条款的确认和接纳</h4>
            <p>1.1本站的各项电子服务的所有权和运作权归960所有。您同意所有注册协议条款并完成注册程序，才能成为本站的正式用户。您确认：本协议条款是处理双方权利义务的依据，始终有效，法律另有强制性规定或双方另有特别约定的，依其规定或约定。</p>
            <p>1.2您点击同意本协议的，即视为您确认自己具有享受本站服务、下单购物等相应的权利能力和行为能力，能够独立承担法律责任。</p>
            <p>1.3您确认，如果您在18周岁以下，您只能在父母或其他监护人的监护参与下才能使用本站。</p>
            <p>1.4960保留在中华人民共和国大陆地区施行之法律允许的范围内独自决定拒绝服务、关闭用户账户、清除或编辑内容或取消订单的权利。</p>
            <p>1.5您使用本站提供的服务时，应同时接受适用于本站特定服务、活动等的准则、条款和协议（以下统称为“其他条款”）；如果以下使用条件与“其他条款”有不一致之处，则以“其他条款”为准。</p>
            <p>1.6为表述便利，商品和服务简称为“商品”或“货物”。</p>
            <h4>第2条 本站服务</h4>
            <p>2.1960通过互联网依法为您提供互联网信息等服务，您在完全同意本协议及本站相关规定的情况下，方有权使用本站的相关服务。</p>
            <p>2.2您必须自行准备如下设备和承担如下开支：（1）上网设备，包括并不限于电脑或者其他上网终端、调制解调器及其他必备的上网装置；（2）上网开支，包括并不限于网络接入费、上网设备租用费、手机流量费等。</p>
            <p>2.2.1上网设备，包括并不限于电脑或者其他上网终端、调制解调器及其他必备的上网装置；</p>
        </#if>
        </div><!--/agreement_wp-->
        <div class="mt20 tc" style="text-align: center"><a class="agree_btn" href="javascript:;" onclick="agreepro();">同意并继续</a></div>
    </div><!--/dia_cont-->
</div>
<input id="threePartType" type="hidden" value="${threePartType}"/>
<script src="/js/gt.js"></script>
<script src="${basePath}/js/icheck.min.js"></script>
<script src="${basePath}/js/binding_page.js"></script>
<#include "../index/newbottom.ftl">



<script>
    function sendMessage() {
        var message = $("#message").val();
        var mobile = $("#register_phone").val();
        if(mobile == "") {
            $(".cw_errorone").removeClass("hide").html('手机号不能为空');
            return;
        }
        if(!(/^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$/).test(mobile)){
            $(".cw_errorone").removeClass("hide").html('手机号格式错误');
            return false;
        }


        $("#sendbtn").attr("disabled", "disabled");
        $("#sendbtn").css("background-color","#F7F7F7");
        $("#sendbtn").css("color","#000000");
        $(".cw_errorthree").addClass("hide")
        $(".timeleft").text(59);

        $.ajax({
            url: "regsendcodeNoCheckCode.htm?mobile=" + mobile,
            context: document.body,
            success: function (data) {
                if (data == 1) {
                    //发送成功
                    $("#getcode").text("");
                    $(".timeleft").text(59);
//                    $(".code_info").parents(".reg_form_item").removeClass("error");
//                    $(".code_info").hide();
                    $(".code_send").show();
                    setTimeout(countDown, 1000);
                    $("#sendbtn").attr("disabled", "disabled");
                    $(".cw_errorthree").addClass("hide")
                } else if (data == 2) {
//                    $(".code_info").html("该手机号已被注册");
//                    $(".code_info").parents(".reg_form_item").addClass("error");
//                    $(".code_info").show();
                } else if (data == -1) {
//                    $(".code_info1").html("请输入正确的验证码");
//                    $(".code_info1").parents(".reg_form_item").addClass("error");
//                    $(".code_info1").show();
                    $("#sendbtn").removeAttr("disabled");
                    $("#sendbtn").css("background-color","#3478F6");
                    $("#sendbtn").css("color","#fff");

                } else {
                    $("#sendbtn").removeAttr("disabled");
                    $("#sendbtn").css("background-color","#3478F6");
                    $("#sendbtn").css("color","#fff");
                    $(".cw_errorthree").removeClass("hide").html('发送失败');
//                    $(".code_info").html("发送失败");
//                    $(".code_info").parents(".reg_form_item").addClass("error");
//                    $(".code_info").show();
                }
            },
            error: function () {
                //网络异常
                $("#sendbtn").removeAttr("disabled");
                $("#sendbtn").css("background-color","#3478F6");
                $("#sendbtn").css("color","#fff");
                $(".cw_errorthree").removeClass("hide").html('网络异常');
                //dia(2);
            }
        });
        function countDown() {
            var time = $(".timeleft").text();
            $(".timeleft").text(time - 1);
            if (time == 1) {
                $(".code_send").hide();
                $("#sendbtn").removeAttr("disabled");
                $("#sendbtn").css("background-color","#3478F6");
                $("#sendbtn").css("color","#fff");
                $("#getcode").text("获取验证码");
            } else {
                setTimeout(countDown, 1000);
            }
        }
    }
</script>

</body>
</html>