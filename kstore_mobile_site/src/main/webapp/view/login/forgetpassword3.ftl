<!DOCTYPE html>
<html lang="en">
<head>
<#assign basePath=request.contextPath>
    <meta charset="UTF-8">
    <title>忘记密码</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <#--<link rel="stylesheet" href="${basePath}/css/v1/css/mall.css">-->
    <#--<link rel="stylesheet" href="${basePath}/css/v1/css/time_css.css">-->
    <#--<link rel="stylesheet" href="${basePath}/css/v1/css/css.css">-->
    <#--<link rel="stylesheet" href="${basePath}/css/v1/css/foot.css">-->
    <link href="${basePath}/css/style.min.css" rel="stylesheet">
    <script src="${basePath}/js/jquery-1.10.1.js"></script>
    <script src="${basePath}/js/pageAction.js"></script>

    <style>
        * {
            -webkit-tap-highlight-color: transparent;
        }
        body, html {
            background: #fff;
            font-family: 微软雅黑, Microsoft yahei;
        }
        .vheader{
            border-bottom: none!important;
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
        .page-content{
            padding:.04rem 0 0 .85rem;
        }
        .page-content .reg_zhuce{
            display: block;
            font-size: .48rem;
            color: #000000;
            letter-spacing: 0.8px;
            font-weight: 900;
            font-family: HelveticaNeue-Bold;
            /*transform: scale(2.5);*/
            /*-webkit-transform: scale(2.5);*/
            /*-ms-transform: scale(2.5);*/
            /*font-family: "黑体";*/

        }
        .page-content .reg_p{
            font-size: .24rem;
            color: #7D7D7D;
            letter-spacing: 0.5px;
            line-height: .4rem;
            margin: .17rem 0 1rem 0;

        }
        .page-content ul{
            position: relative;
        }

        .page-content .li_pwd{
            border-bottom:1px solid #DFDFDF;
            position: relative;
            padding-left: .72rem;
            width:5.62rem;
            height: .8rem;
            margin-bottom: .55rem;
        }
        .page-content .li_pwd.focus1{
            border-bottom:1px solid #000;
        }
        .page-content .li_pwd.error{
            border-bottom:1.5px solid #FF0000;
        }

        .page-content .li_pwd .images{
            position: absolute;
            top:.2rem;
            left:0;
            width:.36rem;
            height:.32rem;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .page-content .li_pwd .clean{
            display: none;
            position: absolute;
            top:.24rem;
            right:0;
            width:.32rem;
            height:.32rem;
        }
        .page-content .li_pwd .clean.cleanpwd{
            right:.8rem;
        }
        .page-content .li_pwd .clean img{
            width:.32rem;
            height:.32rem;
        }
        .page-content .li_pwd .show_password{
            display: block;
            position: absolute;
            top:.24rem;
            right:0;
            width:.4rem;
            height:.4rem;
            background: url(../../images/icon_v1.0/none@2x.png?timestamp=15253278411) no-repeat center center;
            background-size: .4rem .4rem;
        }
        .page-content .li_pwd .show_password.selected{
            background: url(../../images/icon_v1.0/show@2x.png?timestamp=15253278411) no-repeat center center;
            background-size: .4rem .4rem;
        }
        .page-content .li_pwd input{
            width:4.6rem;
            height: .74rem;
            border:none;
            font-weight: 600;
            font-size: .3rem;
        }
        .page-content .li_pwd input::-webkit-input-placeholder{
            color: #B2B2B2;
            font-weight: normal;
        }
        .page-content .li_pwd .error{
            display: none;
            position: absolute;
            left:0;
            bottom: -.42rem;
            font-size: .22rem;
            color: #FF0000;
            letter-spacing: 0.5px;
            font-weight: 600;
        }
        .page-content .li_pwd p img{
            height: .14rem;
        }
        #reg .li_pwd p img{
            height: .14rem;
        }

        .page-content .input-reg{
            position: absolute;
            top: 2.8rem;
            right:0;
            width:1.56rem;
            height: .78rem;
            text-align: center;
            line-height: .78rem;
            color: #fff;
            background: #B0B0B0;
            box-shadow: 0 2px 8px 0 rgba(176,176,176,0.47);
            border-radius: 1rem;
            font-size: .3rem;
            font-weight: 600;
        }
        .page-content .input-reg.load{
            /*background: #25A702 url(../../images/v3/login_reg.gif) no-repeat center center!important;*/
            /*background-size: .33rem .33rem!important;*/
            /*color: transparent!important;*/
        }
        .nextGreen{
            background-color:#25A702!important;
            color:#ffffff!important;
            box-shadow: 0 2px 8px 0 rgba(27,149,1,0.30)!important;
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
                        if (clientWidth >= 640) {
                            docEl.style.fontSize = '100px';
                        } else {
                            docEl.style.fontSize = 100 * (clientWidth /750) + 'px';
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
    $(function () {
        $.ajax({
            url: "${basePath}/queryWxConfig.htm",
            type: "POST",
            data: {curUrl: localUrl},
            success: function (data) {
                console.info(data);
                wx.config({
                    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                    appId: data.appId, // 必填，公众号的唯一标识
                    timestamp: data.timestamp, // 必填，生成签名的时间戳
                    nonceStr: data.nonceStr, // 必填，生成签名的随机串
                    signature: data.signature,// 必填，签名，见附录1
                    jsApiList: ['onMenuShareAppMessage', 'onMenuShareTimeline'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
                });
            },
            async: false
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

<#assign vtitle="" />
<#assign backUrl="javascript:history.go(-1)" />
<#include "../common/head_back.ftl"/>
<input type="hidden" id="basePath" value="${basePath}"/>
<input type="hidden" id="urlhide" value="${url!''}"/>
<input type="hidden" id="mobilehide" value="${mobile!''}"/>

<div id="reg" class="pages navbar-through toolbar-through">
    <div data-page="index" class="page">
        <div class="page-content">
            <a href="javascript:history.go(-1)" class="back link"> <i class="icon icon-back"></i></a>
            <span class="reg_zhuce">${mobile?substring(0,3)}****${mobile?substring(7)}</span>
            <p class="reg_p">为上述账号重置密码</p>
            <div class="main-warp">
            <ul>
                <#--<span class="reg_span1">输入密码</span>-->
                <li class="li_pwd" style="display: none;">
                    <#--<input type="password" name="newpassword" id="newpassword" placeholder="请输入密码"/>-->
                    <img class="images" src="/images/v1/img/login-2.png" alt=""/>
                    <input type="password" name="newpassword" id="newpassword"  placeholder="请输入密码"/>
                    <span class="clean"><img src="images/v3/btn_delect@2x.png" alt=""/></span>
                    <p class="error">手机号不存在 <img src="../../images/v3/falut@2x.png"></p>
                </li>
                <#--<span class="reg_span1" style="margin: 0.45rem 0 0 0;">确认密码</span>-->
                <li class="li_pwd">
                    <#--<input type="password" name="repassword" id="repassword" placeholder="请再次输入密码"/>-->
                    <img class="images" src="/images/v1/img/login-2.png" alt=""/>
                    <input type="password" name="repassword" id="repassword"  placeholder="请输入密码"/>
                    <span class="clean cleanpwd"><img src="images/v3/btn_delect@2x.png" alt=""/></span>
                    <span class="show_password"></span>
                    <p class="error">手机号不存在 <img src="../../images/v3/falut@2x.png"></p>
                </li>
                <li class="no" >
                    <a href="javascript:;" onClick="subForgetPwdNew();"><span class="input-reg">完成</span></a>
                </li>
            </ul>
            </div>
        </div>
    </div>
</div>
<img style="visibility: hidden" src="../../images/v3/login_reg.gif" alt=""/>
<script>

    /*密码和确认密码都不为空，下一步才变色*/
    $('input').on('input change', function () {
        //if (($.trim($('#newpassword').val()) !== "") && ($.trim($('#repassword').val()) !== "")) {
        if ($.trim($('#repassword').val()) !== "") {
            $('.input-reg').addClass("nextGreen");
        } else {
            $('.input-reg').removeClass("nextGreen");
        }
    });
    //提交手机号和密码
    function subForgetPwdNew() {
        if ($('.input-reg').hasClass("nextGreen")) {
            if($('.input-reg').hasClass("load")){
                return
            }else{
                $('.input-reg').addClass("load").html("提交中");
            }
            var url = $("#urlhide").val();
            var mobile = $("#mobilehide").val();
            //var newpassword = $("#newpassword").val();
            var newpassword = $("#repassword").val();
            var repassword = $("#repassword").val();
            if (newpassword.length < 6 || newpassword.length > 16) {
                //alertStrNew("密码为6-16位字母加数字的组合，不得含特殊字符");
                $(".li_pwd").addClass("error").eq(1).find("p").html("设置密码格式有误 <img src='../../images/v3/falut@2x.png'>").show()
                $('.input-reg').removeClass("load").html("完成");
                return false;
            } else if (!(/^(([A-Za-z]+[0-9]+)|([0-9]+[A-Za-z]+))[A-Za-z0-9]*$/).test(newpassword)) {
                //alertStrNew("密码为6-16位字母加数字的组合，不得含特殊字符");
                $(".li_pwd").addClass("error").eq(1).find("p").html("设置密码格式有误 <img src='../../images/v3/falut@2x.png'>").show()
                $('.input-reg').removeClass("load").html("完成");
                return false;
            } else if (newpassword != repassword) {
                //alertStrNew("两次输入的密码不一致");
                $(".li_pwd").addClass("error").eq(1).find("p").html("两次密码不一致 <img src='../../images/v3/falut@2x.png'>").show()
                $('.input-reg').removeClass("load").html("完成");
                return false;
            }
            $.ajax({
                type: 'post',
                url: "forgetpasswordNew.htm?mobile=" + mobile + "&newpassword=" + newpassword + "&url=" + url ,
                success: function (data) {
                    if (isNaN(data)) {
                        $('.input-reg').removeClass("load").html("完成");
                        window.location.href = $("#basePath").val() + data;
                    }
                }
            });
        }
    }


    //点击删除
    function changeborder(ele,tip){
        $(ele).on("focus",function(){
            $(this).attr("placeholder","");
            //if (!($(this).val()==null || $(this).val()=='')) {
                //$(this).next(".clean").show();
            //}
            $(".li_pwd").removeClass("error").find(".error").hide();
            $(this).parents(".li_pwd").addClass("focus1");

        });
        $(ele).on("blur",function(){
            if ($(this).val()==null || $(this).val()=='') {
                $(this).attr("placeholder",tip);
            }
            //$(this).next(".clean").hide();
            $(this).parents(".li_pwd").removeClass("focus1");

        });
    }
    changeborder("#newpassword","请输入密码");
    changeborder("#repassword","请再次输入密码");

    $(function(){
        $(".li_pwd input").bind('input porpertychange',function(){
            if (!($(this).val()==null || $(this).val()=='')) {
                $(this).next(".clean").show();
            }else{
                $(this).next(".clean").hide();
            }
        });
    });

    $(".li_pwd").on("touchstart",".clean",function(){
        //$("#password").val("");
        $(this).prev("input").val("");
        $(this).hide();
        $(".input-reg").removeClass("nextGreen");
    });

//    function alertStrNew(str) {
//        $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>' + str + '</h3></div></div>');
//        $('.input-reg').removeClass("nextGreen");
//        $(".tip-box").animate({top: "12%"});
//        setTimeout(function () {
//            $('.tip-box').remove();
//            $('.input-reg').addClass("nextGreen");
//        }, 2500);
//    }
//
//    function showlincence() {
//        $.dialog({
//            title: '注册协议',
//            id: 'DemoDialog  ',
//            content: '<div id="dialogCont" style="overflow: auto; height: 480px; line-height: 1.5;"></div>',
//            lock: true,
//            width: 300,
//            fixed: true,
//            height: 250
//        });
//
//        $('#dialogCont').html('1111')
//    }
    /* 显示密码 */
    $('.show_password').click(function(){
        if($(this).attr('class').indexOf('selected') > 0){
            $(this).removeClass('selected');
            $(this).parent().find("input").attr('type','password');
        }
        else{
            $(this).addClass('selected');
            $(this).parent().find("input").attr('type','text');
        }
    });
</script>
<script>
    var _hmt = _hmt || [];
    (function () {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?94d81cec8c55272bd7081c5126331fc1";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>
</body>
</html>