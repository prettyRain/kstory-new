<!DOCTYPE html>
<html lang="en">
<head>
<#assign basePath=request.contextPath>
    <meta charset="UTF-8">
    <title>忘记密码</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <link href="${basePath}/css/style.min.css" rel="stylesheet">
    <link href="${basePath}/css/v3/loginm_register_v3.css" rel="stylesheet">
    <script src="${basePath}/js/jquery-1.10.1.js"></script>
    <script src="${basePath}/js/pageAction.js"></script>
    <style>
        .page-content{
            padding:.04rem 1.06rem 0 .95rem;
        }
        .page-content .forget {
            display: block;
            font-size: .48rem;
            color: #000000;
            letter-spacing: 0.8px;
            font-weight: 900;
        }
        .page-content .forget_p {
            font-size: .24rem;
            color: #7D7D7D;
            letter-spacing: 0.5px;
            line-height: .4rem;
            margin: .1rem 0 1rem 0;
        }
        .main-warp{
            position: absolute;
            top: 3.2rem;
            left:0;
            width:100%;
            height:100%;
            display: -webkit-box;
            display: -ms-flexbox;
            display: -webkit-flex;
            display: flex;
            -webkit-justify-content: center;
            justify-content: center;
        }
    </style>
    <script>
        baseUrl = '<%=PropertyUtils.getProperty("imgSite")%>';
        var mallId = '<%=mallId%>';
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
    </script>
</head>
<body>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script>
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
<#--<div class="content-login mb50">-->
<input type="hidden"  id="basePath" value="${basePath}"/>

<#--<form id="registerSecondForm" action="/registerthird.html" method="post">-->
    <#--<input type="hidden" id="urlhide" name="url" value="${url!''}"/>-->
    <#--<input type="hidden" id="mobilehide" name="mobile"/>-->
<#--</form>-->

<#assign vtitle="" />
<#assign backUrl="javascript:history.go(-1)" />
<#include "../common/head_back.ftl"/>

<form id="forgetPwdSecondForm" action="/forgetpwdthird.htm" method="post">
    <input type="hidden" id="urlhide" name="url" value="${url!''}"/>
    <input type="hidden" id="mobilehide" name="mobile"/>
</form>

    <div id="forget" class="reg_forget pages navbar-through toolbar-through">
        <div data-page="index" class="page">
            <div class="page-content">
                <span class="forget">忘记密码</span>
                <p class="forget_p">通过手机号找回您的密码</p>
                <div class="main-warp">
                <ul>
                    <li class="li_li">
                        <span class="images"><img src="images/v1/img/login-1.png" alt="" width="13" height="20"/></span>
                        <input type="number" pattern="[0-9]*" id="mobile" placeholder="请输入手机号"/>
                        <span class="clean"><img src="images/v3/btn_delect@2x.png" alt=""/></span>
                        <#--<p class="error correct">发送成功 <img style="margin-bottom: .02rem;" src="../../images/v3/right@2x.png"></p>-->
                        <#--<p class="error">发送成功&nbsp;<img style="width: .2rem;height: .14rem;" src="../../images/v3/right@2x.png"></p>-->
                        <p class="error correct">发送成功 <img style="width: 10px;margin-bottom: 1px" src="../../images/v3/right@2x.png"></p>
                    </li>

                    <li class="list-2 li_li">
                        <div class="code">
                            <span class="images"><img src="images/v1/img/login-6.png" alt="" width="15" height="17"/></span>
                            <input type="number" pattern="[0-9]*" name="code" id="code" maxlength="6" placeholder="请输验证码"/>
                            <span class="clean clean1"><img src="images/v3/btn_delect@2x.png" alt=""/></span>
                            <#--<p class="error" style="display: block;">手机号格式错误 <img src="../../images/v3/falut@2x.png"></p>-->
                            <#--<p class="error">手机号格式错误&nbsp;<img style="width: .14rem;height: .14rem;" src="../../images/v3/falut@2x.png"></p>-->
                            <p class="error">手机号格式错误 <img src="../../images/v3/falut@2x.png"></p>
                        </div>
                        <a class="a1 get-confirmcode" href="javascript:;" onClick="codeNocknew();">获取验证码</a>
                    </li>

                    <li  class="no">
                        <a href="javascript:;" onClick="subForgetPwdSecond();"><span class="input-forget input-next">下一步</span></a>
                    </li>
                </ul>
                </div>
            </div>
        </div>
    </div>
<img style="visibility: hidden" src="../../images/v3/login_reg.gif" alt=""/>
<script src="${basePath}/js/v3/swiper.js"></script>
<script src="${basePath}/js/login/login.js"></script>
<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?94d81cec8c55272bd7081c5126331fc1";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>
<script>
    var li_forget = $(".reg_forget .li_li");
    //登陆用户名和密码都填写了就变绿
    $(function(){
        $('input').on('input change',function(){
            if($(this).attr("id") == "code"){
                $(this).val($(this).val().slice(0,6));
            }
            if(($.trim($('#mobile').val())!=="")&&($.trim($('#code').val())!=="")){
                $('.input-forget').addClass("nextGreen");
            }else {
                $('.input-forget').removeClass("nextGreen");
            }

        });
    });

    $(li_forget).on("touchstart",".clean",function(){
        $(this).prev("input").val("");
        $(this).hide();
        $(".input-next").removeClass("nextGreen");
    });

    //提交手机号和验证码
    function subForgetPwdSecond() {
        $(li_forget).removeClass("error").find("p").hide();
        if ($('.input-next').hasClass("nextGreen")) {
            if($('.input-next').hasClass("load")){
                return
            }else{
                $('.input-next').addClass("load").html("加载中")
            }
            if(!(/^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$/).test($("#mobile").val())){
                $(li_forget).eq(0).addClass("error").find("p").removeClass("correct").html("手机号格式错误 <img src='../../images/v3/falut@2x.png'>").show();
                $('.input-next').removeClass("load").html("下一步");
                return false;
            }
            if(!($("#code").val().length == 6)){
                $(li_forget).eq(1).addClass("error").find("p").removeClass("correct").removeClass("correct").html("验证码错误或已失效 <img src='../../images/v3/falut@2x.png'>").show();
                $('.input-next').removeClass("load").html("下一步");
                return false;
            }
            var code = $("#code").val();
            var mobile = $("#mobile").val();
            $.ajax({
                url: "/customer/checkCode.htm?code=" + code,
                type: "post",
                success: function (data) {
                    if (data == 1) {
                        $(li_forget).eq(1).addClass("error").find("p").removeClass("correct").html("验证码错误或已失效 <img src='../../images/v3/falut@2x.png'>").show();
                        $('.input-next').removeClass("load").html("下一步");
                        return false;
                    } else {
                        $("#mobilehide").val(mobile);
                        $('.input-next').removeClass("load").html("下一步");
                        $("#forgetPwdSecondForm").submit();
                    }
                }
            });
        }
    }


    function countDownnew(){
        var time = $(".get-confirmcode").attr('data-t');
        $(".get-confirmcode").html((time - 1)+"s");
        $(".get-confirmcode").attr('data-t',(time - 1));
        time = time - 1;
        if (time < 1) {
            $(".get-confirmcode").attr("onClick","codeNocknew();");
            $(".get-confirmcode").html("重新获取");
            $(".get-confirmcode").css({"color":"#4A90E2","background":"#fff"});
            $("#mobile").removeAttr("readonly");
        } else {
            setTimeout(countDownnew, 1000);
        }
    }



    function codeNocknew() {
        if($(".get-confirmcode").html()=="正在获取"){
            return
        }else{
            $(".get-confirmcode").html("正在获取");
            $(".get-confirmcode").css({"color":"#199301","background":"#fff"});
        }
        $(li_forget).removeClass("error").find("p").hide();
        if(!(/^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$/).test($("#mobile").val())){
            $(li_forget).eq(0).addClass("error").find("p").html("手机号格式错误 <img src='../../images/v3/falut@2x.png'>").show();
            $(".get-confirmcode").attr("onClick","codeNocknew();");
            $(".get-confirmcode").html("获取验证码");
            $(".get-confirmcode").css({"color":"#25A702","background":"#fff"});
            $("#mobile").removeAttr("readonly");
            return false;
        }
        if($(".get-confirmcode").hasClass("done")){
            $(".get-confirmcode").attr("onClick","codeNocknew();");
            $(".get-confirmcode").html("获取验证码");
            $(".get-confirmcode").css({"color":"#25A702","background":"#fff"});
            $("#mobile").removeAttr("readonly");
            return false;
        }else {
            $(".get-confirmcode").addClass("done");
        }
        $.ajax({
            url: "/mobileExistAndSendcodereg.htm?mobile=" + $("#mobile").val(),
            type: "post",
//            data: {mobile: $("#mobile").val()},
            success: function (data) {
                $(".get-confirmcode").removeClass("done");
                if (data == 1) {
                    //发送成功
                    $(".get-confirmcode").html('60s');
                    $(".get-confirmcode").attr('data-t','60');
                    $(".get-confirmcode").attr("onClick","");
                    $(".get-confirmcode").css({"color":"#199301","background":"#fff"});
                    setTimeout(countDownnew(), 1000);
                    $(li_forget).eq(1).find("p").addClass("correct").html("发送成功 <img style='width: 10px;margin-bottom: 1px' src='../../images/v3/right@2x.png'>").show();
                } else if(data == 0){
                    //发送失败
                    $(li_forget).eq(1).find("p").removeClass("correct").html("发送失败 <img src='../../images/v3/falut@2x.png'>").show();
                    $(".get-confirmcode").attr("onClick","codeNocknew();");
                    $(".get-confirmcode").html("获取验证码");
                    $(".get-confirmcode").css({"color":"#25A702","background":"#fff"});
                    $("#mobile").removeAttr("readonly");
                } else if(data == 2){
                    //用户不存在
                    $(li_forget).eq(0).addClass("error").find("p").removeClass("correct").html("手机号未注册 <img src='../../images/v3/falut@2x.png'>").show();
                    $(".get-confirmcode").attr("onClick","codeNocknew();");
                    $(".get-confirmcode").html("获取验证码");
                    $(".get-confirmcode").css({"color":"#25A702","background":"#fff"});
                    $("#mobile").removeAttr("readonly");
                } else {
                    //发送失败
                    $(li_forget).eq(1).find("p").removeClass("correct").html("发送失败 <img src='../../images/v3/falut@2x.png'>").show();
                    $(".get-confirmcode").attr("onClick","codeNocknew();");
                    $(".get-confirmcode").html("获取验证码");
                    $(".get-confirmcode").css({"color":"#25A702","background":"#fff"});
                    $("#mobile").removeAttr("readonly");
                }
            }
        });
    }
</script>
</body>
</html>