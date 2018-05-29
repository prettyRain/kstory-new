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
<input type="hidden" id="urlhide" value="${url!''}" />


<div class="navbar-mark" style="position: fixed;left: 0;top: 0;">
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
</div>
<div id="reg" class="pages navbar-through toolbar-through">
    <div data-page="index" class="page">
        <div class="page-content">
            <ul>
                <li>
                    <img src="images/v1/img/login-5.png" alt=""/><i>手&nbsp; 机&nbsp; 号：</i>
                    <input type="text" name="mobile" id="mobile" placeholder="请输入手机号"/>
                </li>
                <li class="list-2">
                    <div class="code"><img src="/images/v1/img/login-6.png" style="width: .3rem;height: .4rem;" alt=""/><input type="text" id="checkCode" name="checkCode" placeholder="请输入验证码"/></div>
                    <a href="javascript:repatchca();"><img src="${basePath}/patchca.htm" id="patchca" onclick="this.src=this.src+'?'+Math.random();" /> 换一张</a>
                </li>
                <li class="list-2">
                    <div class="code"><img src="/images/v1/img/login-7.png" alt=""/><input type="text" name="code" id="code" placeholder="请输入手机验证码"/></div>
                    <a class="a1 get-confirmcode" href="javascript:;" onClick="codeNock();">获取短信验证码</a>
                </li>
                <li>
                    <img src="/images/v1/img/login-2.png" alt=""/><i>密<i style="color:rgba(255,255,255,0)">密码</i>码：</i><input type="password" name="password" id="password"  placeholder="6-16位数字、字母组合"/>
                </li>
                <li>
                    <img src="/images/v1/img/login-2.png" alt=""/><i>确认密码：</i><input type="password" name="rePassword" id="repassword"  placeholder="6-16位数字、字母组合"/>
                </li>
                <li class="no">
                    <label class="active"><span></span> 我已阅读并同意<a href="${basePath}/intoPage.htm?pageName=member/servclause">《960用户协议》</a></label>
                </li>
                <li  class="no">
                    <a href="javascript:;" onClick="subRegister();"><span class="input-reg">注册</span></a>

                </li>
            </ul>

        </div>
    </div>
</div>



<#--<#include '../common/smart_menu.ftl' />-->

<script>

    $(function(){
        $("li.no label").click(function(){

            if($(this).hasClass("active")){
                $(this).removeClass("active");
            }else{
                $(this).addClass("active");
            }
        })
    });

    function repatchca(){
        $("#patchca").attr("src","${basePath}/patchca.htm?"+Math.random())
    }

    function codeNock(){
        if($("#mobile").val()==null || $("#mobile").val()==''){
            $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>请输入手机号</h3></div></div>');
            setTimeout(function(){
                $('.tip-box').remove();
            },1000);
            return false;
        }
        if(!(/^0?1[3|4|5|8|7][0-9]\d{8}$/).test($("#mobile").val())){
            $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>手机号格式错误</h3></div></div>');
            setTimeout(function(){
                $('.tip-box').remove();
            },1000);
            return false;
        }
        if($("#checkCode").val()==null || $("#checkCode").val()==''){
            $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>请输入图片验证</h3></div></div>');
            setTimeout(function(){
                $('.tip-box').remove();
            },1000);
            return false;
        }
        $.ajax({
            url:"${basePath}/sendcodereg.htm",
            type:"post",
            data:{mobile:$("#mobile").val(),checkCode:$("#checkCode").val()},
            success:function(data){
                if(data == 1){
                    //发送成功
                    //alert("发送成功");
                    $(".get-confirmcode").html('60秒后重新获取');
                    $(".get-confirmcode").attr('data-t','60');
                    $(".get-confirmcode").attr("onClick","");
                    $(".get-confirmcode").css({"color":"#fff","background":"#e0e0e0"});
                    $("#mobile").attr("readonly","readonly");
                    setTimeout(countDown, 1000);
                }else if(data == 2){
                    $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>该手机号已被注册</h3></div></div>');
                    setTimeout(function(){
                        $('.tip-box').remove();
                    },1000);
                }else if(data==3){
                    $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>图片验证不正确</h3></div></div>');
                    setTimeout(function(){
                        $('.tip-box').remove();
                    },1000);
                }else{
                    //发送失败
                    //alert("发送失败");
                    $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>发送失败</h3></div></div>');
                    setTimeout(function(){
                        $('.tip-box').remove();
                    },1000);
                }
            }
        });
    }

    function countDown(){
        var time = $(".get-confirmcode").attr('data-t');
        $(".get-confirmcode").html((time - 1)+"秒后重新获取");
        $(".get-confirmcode").attr('data-t',(time - 1));
        time = time - 1;
        if (time < 1) {
            $(".get-confirmcode").attr("onClick","codeNock();");
            $(".get-confirmcode").html("获取验证码");
            $(".get-confirmcode").css({"color":"#fff","background":"#50C896"});
            $("#mobile").removeAttr("readonly");
        } else {
            setTimeout(countDown, 1000);
        }
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
            $(this).parent().css("border-color","#50C896")

        });
        $(ele).on("blur",function(){
            $(this).parent().css("border-color","#e0e0e0")

        });
    };
    changeborder("#mobile");
    changeborder("#checkCode");
    changeborder("#code");
    changeborder("#password");
    changeborder("#repassword");
    $("#checkCode").focus(function(){
        $(this).attr("placeholder","");
    });
    $("#checkCode").blur(function(){
        if ($(this).val()==null || $(this).val()=='') {
            $(this).attr("placeholder","请输入验证码");
        }
    });
</script>
<script src="${basePath}/js/customer/allvalid.js"></script>
</body>
</html>