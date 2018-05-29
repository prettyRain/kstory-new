<!DOCTYPE html>
<html lang="en">
<head>
<#assign basePath=request.contextPath>
    <meta charset="UTF-8">
    <title>忘记密码</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <link rel="stylesheet" href="${basePath}/css/v1/css/mall.css">
    <link rel="stylesheet" href="${basePath}/css/v1/css/time_css.css">
    <link rel="stylesheet" href="${basePath}/css/v1/css/css.css">
    <link rel="stylesheet" href="${basePath}/css/v1/css/foot.css">
    <script src="${basePath}/js/jquery-1.10.1.js"></script>
    <script src="${basePath}/js/pageAction.js"></script>
<#--新弹窗样式-->
    <style>
        .tip-box {
            position: fixed;
            top: 1%;
            /* margin-top: -50px;*/
            width: 100%;
            z-index: 9999;
            text-align: center
        }

        .tip-box .tip-body {
            align-items: center;
            display: inline-block;
            margin: 0 auto;
            padding: .2rem .3rem .2rem .3rem;
            -webkit-border-radius: 15px;
            -moz-border-radius: 15px;
            /*height: .46rem;*/
            /*    background-color: rgba(51, 51, 51, .9)*/
            background-image: linear-gradient(-228deg, #FFAC4C 0%, #FE7425 100%);
            box-shadow: 0 2px 7px 0 rgba(254, 116, 37, 0.46);
            border-radius: 15px;
        }

        .tip-box .tip-body:after {
            content: '';
            display: block;
            clear: both
        }

        .tip-box .tip-body h3 {
            line-height: 0.1rem;
            vertical-align: middle;
            font-size: .2rem;
            color: #FFFFFF;
            letter-spacing: 0.86px;
        }
    </style>
    <style>

        #reg .page-content .box {
            /*      margin: 20px;
                  padding: 20px;*/
            background: #fff;
            text-align: center;
        }

        #reg .page-content .box input {
            margin: 0;
            padding: 0;
            width: 1px;
            opacity: 0;
            height: 1px;
            border: none;
        }

        #reg .page-content .box label {
            display: block;
        }

        #reg .page-content .box .ul {
            font-size: 0;
            position: relative;

            width: 100%;
        }

        #reg .page-content .box .ul li {
            display: inline-block;
            width: 42px;
            height: 35px;
            font-size: 24px;
            font-weight: 700;
            text-align: center;
            line-height: 40px;
            border: none;

            border-bottom: 1px solid #e0e0e0;
            border-radius: 0px;
            vertical-align: middle;
            overflow: hidden;
            margin-left: 7px;
            color: #0d0d0d;

        }

        #reg .page-content .box .ul li:first-child {
            border-left: none;
            margin-left: 0px;
        }

        #reg .page-content .box a {
            height: 30px;
            padding: 0 20px;
            border: 1px solid #0064b6;
            border-radius: 3px;
            background: #0071ce;
            color: #fff;
            font-size: 14px;
            line-height: 30px;
            text-align: center;
            display: inline-block;
            outline: 0 none;
            text-decoration: none;
            margin-top: 40px;
        }

        #reg .page-content .box .show {
            padding: 20px;
        }

        #reg .page-content .box .show em {
            font-style: normal;
            color: #ff6600
        }
    </style>

    <style>
        #reg .page-content  .box{
            /*      margin: 20px;
                  padding: 20px;*/
            background: #fff;
            text-align: center;
        }
        #reg  .page-content .box input{
            margin-left: -100%;
            padding: 0;
            width: 100%;
            opacity: 0;
            height: 1px;
            border: none;
        }
        #reg  .page-content .box label{
            display: block;
        }
        #reg   .page-content .box .ul{
            font-size: 0;
            position: relative;

            width: 100%;
        }
        #reg    .page-content .box .ul li{
            display: inline-block;
            height: 35px;
            font-size: .34rem;
            font-weight: 700;
            text-align: center;
            line-height: 40px;
            border: none;
            width: .7rem;
            border-bottom: 1px solid #e0e0e0;
            border-radius: 0px;
            vertical-align: middle;
            overflow: hidden;
            margin: .21rem 0 .21rem  0.15rem;
            color: #0d0d0d;

        }
        #reg   .page-content .box .ul li:first-child {
            border-left: none;
            margin-left:0px;
        }

    </style>
    <style>
        .navbar-mark{filter:alpha(opacity=1);-moz-opacity:1;opacity: 1;}
        /*bug335注册页面优化*/
        #reg ul li,#reg ul li.list-2 .code,.password1 ul li.list-2 .code,#reg ul li.list-2 a img{border:1px solid #e0e0e0}
        #login ul li input[type="text"],#reg ul li input[type="text"],.password1 ul li input[type="text"],input[type="password"]{color:#000}
        #reg ul li.list-2 .code input[type="text"],.password1 ul li.list-2 .code input[type="text"]{width:73%}
        #reg ul li.list-2 a.a1,.password1 ul li.list-2 a.a1{width:41%}
        #reg ul li.list-2 .code,.password1 ul li.list-2 .code{width:56%}
        #reg ul li.list-2 a,.password1 ul li.list-2 a{width:41%}
        #login ul li.no label span,#reg ul li.no label span,#login ul li.no label.active span,#reg ul li.no label.active span{width:.31rem}
        .navbar-inner{position:relative}
        .navbar .left,.navbar .right{position:absolute;top:0;left:7px;height:100%}
        .navbar .login .title{display:block}
        .navbar .login .title span{display:block}
        .navbar .login i.icon.icon-back,.navbar .login a.link{height:100%}
        #reg ul li.list-2 a.a1, .password1 ul li.list-2 a.a1 {
            background: #50C896;color: #fff;}
        #reg ul li .input-reg {
            background: #50C896;}

    </style>
    <style>
        .page{
            padding-bottom: 0;
        }
        #login, #reg {
            margin-top: 0px;
            position: relative;
        }
        i.icon.icon-back {
            width: 10px;
            height: 1rem;
            background-image: url(/images/v1/myimages/my-back.png);
            margin-left: 14px;
            font-weight: 700;
        }
        .page-content .reg_zhuce {
            font-size: 0.48rem;
            color: #030303;
            letter-spacing: 0;
            display: block;
            margin: .25rem 0 0 .7rem;
            font-weight: 700;
        }
        .page {
            background: #ffffff;
            position: relative;
        }
        .page-content  .reg_span {
            font-size: .24rem;
            color: #1D1D1D;
            letter-spacing: 0;
            margin: 0.85rem 0 0 0;
            display: block;
            margin: .85rem 0 0 .7rem;
        }
        /*    #login ul, #reg ul {
                padding: 0 .7rem;
            }*/
        #login ul, #reg ul {
            padding: 0rem;
        }

        #login ul li input[type="text"], #reg ul li input[type="text"], .password1 ul li input[type="text"], input[type="password"] {
            padding: .2rem 0;
            height: .46rem;
            border: none;
            line-height: .46rem;
            font-size: .34rem;
            vertical-align: middle;
            width: 81%;
            color: #999999;
            letter-spacing: 0;
        }
        .page-content .reg_p {
            display: block;
            margin: .1rem 0 0 .7rem;
            font-size: .24rem;
            color: #999999;
            letter-spacing: 1px;
        }
        #reg ul li.no label {
            height: .8rem;
            font-size: .2rem;
            color: #858585;
            letter-spacing: 0;
            vertical-align: top;
            float: right;
        }
        #reg ul li.no a {
            font-size: .2rem;
            color: #858585;
            letter-spacing: 0;
        }

        #reg ul li .input-reg {
            background: #9B9B9B;
            border-radius: 5px;
            color: #ffffff;
            height: .7rem;
            border: none;
            line-height: .7rem;
            font-size: .24rem;
            vertical-align: middle;
            width: 100%;
            display: block;
            text-align: center;
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
                            docEl.style.fontSize = 100 * (clientWidth / 640) + 'px';
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
<form id="forgetPwdSecondForm" action="/forgetpwdthird.htm" method="post">
    <input type="hidden" id="urlhide" name="url" value="${url!''}"/>
    <input type="hidden" id="mobilehide" name="mobile" value="${mobile!''}"/>
</form>

<div id="reg" class="pages navbar-through toolbar-through">
    <div data-page="index" class="page">
        <div class="page-content">
            <a href="javascript:history.go(-1)" class="back link"> <i class="icon icon-back"></i></a>
            <span class="reg_zhuce">${mobile?substring(0,3)}****${mobile?substring(7)}</span>
            <p class="reg_p">验证码将发送至以上手机号</p>
            <span class="reg_span">手机验证码</span>
            <div class="box">
                <label for="ipt">
                    <ul class="ul">
                        <li class="li"></li>
                        <li class="li"></li>
                        <li class="li"></li>
                        <li class="li"></li>
                        <li class="li"></li>
                        <li class="li"></li>
                    </ul>
                </label>
                <input type="tel" id="ipt" maxlength="6" class="input" autofocus="autofocus" >
            </div>

            <ul style="padding: 0 .7rem;">


                <li class="no" style="margin-top: 0rem;">
                    <a href="javascript:;" onClick="subForgetPwdSecond();"><span class="input-reg">下一步</span></a>

                </li>
                <img class="show_img" src="images/v1/img/chongxinfasong.png" style="width: 54px;height: 54px;position: absolute;top:1.4rem;right:0.7rem; display: none;">
            </ul>

        </div>
    </div>

    <div class="game_time">

        <div class="hold">
            <div class="pie pie1"></div>
        </div>

        <div class="hold">
            <div class="pie pie2"></div>
        </div>

        <div class="bg"></div>

        <div class="time"></div>

    </div>
</div>
<script>

    $('.input').focus(function(event) {
        $(window).scrollTop(1);
    });

    $('.input').on('input', function (e) {

        var numLen = 6;
        var pw = $('.input').val();
        var list = $('.li');
        for (var i = 0; i < numLen; i++) {
            if (pw[i]) {
                $(list[i]).text(pw[i]);
                $(list[i]).css("border-bottom", " 1px solid #199301");
            } else {
                $(list[i]).text('');
                $(list[i]).css("border-bottom", " 1px solid #e0e0e0");
            }
        }

        if (pw.length == 6 && $(".show_img").css("display")=="none") {
            $('.input-reg ').css({'background-color': '#199301', 'color': '#ffffff'});
            $('.input-reg').addClass("nextGreen");
        } else {
            $('.input-reg').css({'background-color': '#9B9B9B', 'color': '#ffffff'});
            $('.input-reg').removeClass("nextGreen");
        }
    });
</script>

<script src="${basePath}/js/time_js.js"></script>

<script>

    <#--重新发送-->
    $(".show_img").on("touchstart", function (e) {
        $(".pie").attr("style","");
        codeNock();
        e.preventDefault();
    })

    function codeNock() {
        $.ajax({
            url: "${basePath}/sendcoderegNew.htm",
            type: "post",
            data: {mobile: $("#mobilehide").val()},
            success: function (data) {
                if (data == 1) {
                    countDown();
                    $(".show_img").hide();
                    $(".game_time").show();
                } else {
                    //发送失败
                    alertStr("发送失败");
                    $(".show_img").show();
                    $(".game_time").hide();
                    $('.input-reg').css({'background-color': '#9B9B9B', 'color': '#ffffff'});
                    $('.input-reg').removeClass("nextGreen");
                    return false;
                }
            }
        });
    }

    function subForgetPwdSecond() {
        if ($('.input-reg').hasClass("nextGreen")) {
            var code = $(".input").val();
            $.ajax({
                url: "/customer/checkCode.htm?code=" + code,
                type: "post",
                success: function (data) {
                    if (data == 1) {
                        alertStr("手机验证码错误或者已经失效");
                        return false;
                    } else {
                        $("#forgetPwdSecondForm").submit();
                    }
                }
            });
        }
    }

    function alertStr(str) {
        $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>' + str + '</h3></div></div>');
        $('.input-reg').removeClass("nextGreen");
        $(".tip-box").animate({top: "12%"});
        setTimeout(function () {
            $('.tip-box').remove();
            $('.input-reg').addClass("nextGreen");
        }, 2500);
    }

    function showlincence() {
        $.dialog({
            title: '注册协议',
            id: 'DemoDialog  ',
            content: '<div id="dialogCont" style="overflow: auto; height: 480px; line-height: 1.5;"></div>',
            lock: true,
            width: 300,
            fixed: true,
            height: 250
        });

        $('#dialogCont').html('1111')

    }
</script>
<#--发送短信验证码-->
<script type="text/javascript">
    codeNock();
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