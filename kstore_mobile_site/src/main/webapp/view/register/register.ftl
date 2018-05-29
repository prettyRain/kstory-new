<!DOCTYPE html>
<html lang="en">
<head>
<#assign basePath=request.contextPath>
    <meta charset="UTF-8">
    <title>注册</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <link rel="stylesheet" href="${basePath}/css/v1/css/mall.css">
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
            box-shadow: 0 2px 7px 0 rgba(254,116,37,0.46);
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
            position: fixed;
        }
        i.icon.icon-back {
            width: 10px;
            height: 1rem;
            background-image: url(/images/v1/myimages/my-back.png);
            margin-left: 14px;
        }
        .page-content .reg_zhuce {
            font-size: 0.48rem;
            color: #030303;
            letter-spacing: 0;
            display: block;
            margin: .25rem 0 0 .7rem;
        }
        .page {
            background: #ffffff;
        }
        .page-content ul .reg_span {
            font-size: .24rem;
            color: #1D1D1D;
            letter-spacing: 0;
            margin: 0.85rem 0 0 0;
            display: block;
        }
        #login ul, #reg ul {
             padding: 0 .7rem;
         }

        #login ul li, #reg ul li {
            border: none;
            border-radius: 0px;
            height: .86rem;
            background: #fff;
            margin: .2rem 0;
            padding-top: 0.2rem;
            border-bottom: 1px solid #c5c5c5;
        }
        #login ul li input[type="text"], #reg ul li input[type="text"], .password1 ul li input[type="text"], input[type="password"] {
            padding: .2rem 0;
            height: .46rem;
            border: none;
            line-height: .46rem;
            font-size: .34rem;
            vertical-align: middle;
            width: 81%;
            color: #000;
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
            height: .25rem;
            font-size: .2rem;
            color: #858585;
            letter-spacing: 0;
            vertical-align: top;
            float: right;    line-height: .25rem;

        }
        #reg ul li.no a {
            font-size: .2rem;
            color: #199301;
            letter-spacing: 0;

        }
        #login ul li.no label.active span, #reg ul li.no label.active span {
            background:#ffffff url(../images/btn_selected@2x.png) no-repeat ;
            border:none!important;
            display: inline-block;
            width: .2rem;
            height: .21rem;
            background-size: 100%;
            vertical-align: top;
            border-radius: 100%;
            margin-top: .01rem;
        }
        #login ul li.no label span, #reg ul li.no label span {
            background: url(/images/v1/img/btn_select@2x111.png) no-repeat;
            display: inline-block;
            width: .2rem;
            height: .21rem;
            background-size: 100%;
            vertical-align: top;
            border-radius: 100%;
            margin-top: .01rem;
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
        .reg_zhuce{
            font-family: "华文细黑";
            font-weight: 700;
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
<form id="registerFirstForm" action="/registersecond.html" method="post">
    <input type="hidden" id="urlhide" name="url" value="${url!''}" />
    <input type="hidden" id="mobilehide" name="mobile" />
</form>

        <#--<div class="navbar-mark" style="position: fixed;left: 0;top: 0;">
             <div class="navbar">
                 <div class="navbar-inner login">
                        <div class="left">
                            <a href="javascript:history.go(-1)" class="back link"> <i class="icon icon-back"></i></a>
                        </div>
                         <div class="center sliding title" ><span>会员注册</span></div>
                            <div class="right">
                             <a href="#"  style="visibility: hidden;" data-panel="right"  class="link icon-only open-panel"> <i class="icon icon-bars"></i></a>

                          </div>

                 </div>
            </div>
        </div>-->
        <div id="reg" class="pages navbar-through toolbar-through">
            <div data-page="index" class="page">
                <div class="page-content">
                    <a href="javascript:history.go(-1)" class="back link"> <i class="icon icon-back"></i></a>
                    <span class="reg_zhuce">会员注册</span>
                    <p class="reg_p">诚挚邀请您加入960会员</p>
                    <ul>
                        <span  class="reg_span">手机号</span>
                        <li>
                            <#--<img src="images/v1/img/login-5.png" alt=""/>--><#--<i>手&nbsp; 机&nbsp; 号：</i>-->
                            <input type="text" id="mobile" placeholder="请输入手机号"/>
                        </li>
                        <#--<li class="list-2">-->
                            <#--<div class="code"><img src="/images/v1/img/login-6.png" style="width: .3rem;height: .4rem;" alt=""/><input type="text" id="checkCode" name="checkCode" placeholder="请输入验证码"/></div>-->
                            <#--<a href="javascript:repatchca();"><img src="${basePath}/patchca.htm" id="patchca" onclick="this.src=this.src+'?'+Math.random();" /> 换一张</a>-->
                        <#--</li>-->
                        <#--<li class="list-2">-->
                            <#--<div class="code"><img src="/images/v1/img/login-7.png" alt=""/><input type="text" name="code" id="code" placeholder="请输入手机验证码"/></div>-->
                            <#--<a class="a1 get-confirmcode" href="javascript:;" onClick="codeNock();">获取短信验证码</a>-->
                        <#--</li>-->
                        <#--<li>-->
                            <#--<img src="/images/v1/img/login-2.png" alt=""/><i>密<i style="color:rgba(255,255,255,0)">密码</i>码：</i><input type="password" name="password" id="password"  placeholder="6-16位数字、字母组合"/>-->
                        <#--</li>-->
                        <#--<li>-->
                            <#--<img src="/images/v1/img/login-2.png" alt=""/><i>确认密码：</i><input type="password" name="rePassword" id="repassword"  placeholder="6-16位数字、字母组合"/>-->
                        <#--</li>-->
                        <li class="no" style="padding: 0;">
                            <a style="float: right;    height: .25rem;    line-height: .25rem;" href="${basePath}/intoPage.htm?pageName=member/servclause">《960用户协议》</a><label class="active"><span></span> 我已阅读并同意</label>
                        </li>

                        <li  class="no">
                            <a href="javascript:;" onClick="subRegisterFirst();"><span class="input-reg">注册</span></a>

                        </li>
                    </ul>

                </div>
            </div>
        </div>
<#--<#include '../common/smart_menu.ftl' />-->

<script>
    $(function(){
        /*手机号不为空，且同意协议，下一步才变色*/
        $("li.no label").click(function(){
            if($(this).hasClass("active")){
                $(this).removeClass("active");
            }else{
                $(this).addClass("active");
            }
            if(($.trim($('#mobile').val())!=="")&&($(this).hasClass("active"))){
                $('.input-reg ').css({'background-color':'#199301','color':'#ffffff'});
                $('.input-reg').addClass("nextGreen");
            }else {
                $('.input-reg').css({'background-color':'#9B9B9B','color':'#ffffff'});
                $('.input-reg').removeClass("nextGreen");
            }
        })
        /*手机号不为空，且同意协议，下一步才变色*/
        $('input').on('input change',function(){
            if(($.trim($('#mobile').val())!=="")&&($('li.no label').hasClass("active"))){
                $('.input-reg ').css({'background-color':'#199301','color':'#ffffff'});
                $('.input-reg').addClass("nextGreen");
            }else {
                $('.input-reg').css({'background-color':'#9B9B9B','color':'#ffffff'});
                $('.input-reg').removeClass("nextGreen");
            }
        });
    });

    function subRegisterFirst() {
        if($('.input-reg').hasClass("nextGreen")){
            var mobile = $("#mobile").val();
            if(!(/^0?1[3|4|5|8|7][0-9]\d{8}$/).test(mobile)){
                alertStr("手机号格式错误");
                return false;
            }
            $.ajax({
                url:"/customer/mobileExist.htm?mobile="+mobile,
                type:"post",
                success:function (data) {
                    if(data==1){
                        alertStr("手机号已存在");
                        return false;
                    }else{
                        $("#mobilehide").val(mobile);
                        $("#registerFirstForm").submit();
                    }
                }
            });
        }
    }

    function alertStr(str){
        $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>'+str+'</h3></div></div>');
        $('.input-reg').removeClass("nextGreen");
        $(".tip-box").animate({top: "12%"});
        setTimeout(function(){
            $('.tip-box').remove();
            $('.input-reg').addClass("nextGreen");
        },2500);
    }

    function showlincence(){
        $.dialog({
            title:'注册协议',
            id:'DemoDialog  ',
            content:'<div id="dialogCont" style="overflow: auto; height: 480px; line-height: 1.5;"></div>',
            lock: true,
            width:300,
            fixed: true,
            height:250
        });

        $('#dialogCont').html('1111')

    }
</script>
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
    //bug335注册页面优化，按照ios改的
    function changeborder(ele){
        $(ele).on("focus",function(){
            $(this).parent().css("border-color","#199301")

        });
        $(ele).on("blur",function(){
            $(this).parent().css("border-color","#e0e0e0")

        });
    };
    changeborder("#mobile");
</script>
</body>
</html>