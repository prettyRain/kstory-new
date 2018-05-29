<!DOCTYPE html>
<html lang="en" >
<head>
<#assign basePath=request.contextPath>
    <meta charset="UTF-8">
    <title>登录/注册</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <link href="${basePath}/css/style.min.css" rel="stylesheet">
    <link href="${basePath}/css/v3/swiper.css" rel="stylesheet">
    <link href="${basePath}/css/v3/loginm_register_v3.css?timestamp=1525656298" rel="stylesheet">
    <script src="${basePath}/js/jquery-1.10.1.js"></script>
</head>
<body >
<#--自定义分享到朋友圈-->
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
</script>
<#--自定义分享到朋友圈-->
<input type="hidden" id="basepath" value="${basePath}"/>
<input type="hidden" id="urlhide" value="${url}" />
<input type="hidden" id="wxcode" value="${sessionOpedId!''}" />
<input type="hidden" id="keeppwd" value="1" />

<#assign vtitle="" />
<#assign backUrl="javascript:history.go(-1)" />
<#include "../common/head_back.ftl"/>

<form id="registerSecondForm" action="/registerthird.html" method="post">
    <input type="hidden" id="urlhide" name="url" value="${url!''}"/>
    <input type="hidden" id="mobilehide" name="mobile" value="${mobile!''}"/>
</form>


<div class="login_reg">
    <ul>
        <li ><p class="active">登录</p></li>
        <li><p>注册</p></li>
    </ul>
    <span></span>
</div>

<div class="main-warp">
<div class="swiper-container">
    <div class="swiper-wrapper swiper-no-swiping">
    <#--登录-->
        <div class="swiper-slide swiper-no-swiping">
            <div id="login" class="pages navbar-through toolbar-through" >
                <div data-page="index" class="page">
                    <div class="page-content">
                        <#--<a  href="javascript:history.go(-1)" > <i  class="icon icon-back"></i></a>-->
                        <#--<a href="${basePath}/register.html?url=${url}"><span class="input-reg">注册</span></a>-->
                        <#--<img class="login-logo" src="images/v1/img/login-logo.png" alt=""/>-->
                        <#--<span class="login_denglu">会员登录</span>-->
                        <#--<p class="login_p">使用此账号登录以方便购买</p>-->
                        <ul>
                            <#--<span  class="login_span">手机号</span>-->
                            <li class="li_li">
                                <span class="images"><img src="images/v1/img/login-1.png" alt="" width="13" height="20"/></span>
                                <input type="number" pattern="[0-9]*" id="log_user" placeholder="请输入手机号"/>
                                <span class="clean"><img src="images/v3/btn_delect@2x.png" alt=""/></span>
                                <p class="error">手机号不存在 <img src="../../images/v3/falut@2x.png"></p>
                            </li>
                            <#--<span  class="login_span">密码</span>-->
                            <li class="li_li" >
                                <span class="images"><img src="images/v1/img/login-2.png" alt="" width="18" height="16"/></span>
                                <input type="password" id="log_psd" placeholder="请输入密码"/>
                                <span class="clean cleanpwd"><img src="images/v3/btn_delect@2x.png" alt=""/></span>
                                <span class="show_password"></span>
                                <p class="error">手机号不存在 <img src="../../images/v3/right@2x.png"></p>
                            </li>
                            <li class="no no-login">
                                <label class="active"><span></span>开启自动登录</label>
                            </li>
                            <div class="denglu">
                                <span class="input-login" <#--onclick="login()"-->>登录</span>
                            </div>
                            <div class="forget_paw">
                                <a href="${basePath}/valididentity.html?url=${url}"  class="forget_password">忘记密码？</a>
                            </div>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    <#--注册-->
        <div class="swiper-slide swiper-no-swiping">
            <div id="reg" class="reg_forget pages navbar-through toolbar-through">
                <div data-page="index" class="page">
                    <div class="page-content">
                        <#--<a href="javascript:history.go(-1)" class="back link"> <i class="icon icon-back"></i></a>-->
                        <#--<span class="reg_zhuce">会员注册</span>-->
                        <#--<p class="reg_p">诚挚邀请您加入960会员</p>-->
                        <ul>
                            <li class="li_li">
                                <span class="images"><img src="images/v1/img/login-1.png" alt="" width="13" height="20"/></span>
                                <input type="number" pattern="[0-9]*" id="mobile" placeholder="请输入手机号"/>
                                <span class="clean"><img src="images/v3/btn_delect@2x.png" alt=""/></span>
                                <p class="error">手机号不存在×</p>
                            </li>

                            <li class="list-2 li_li">
                                <div class="code">
                                    <span class="images"><img src="images/v1/img/login-6.png" alt="" width="15" height="17"/></span>
                                    <input type="number" pattern="[0-9]*" name="code" id="code" maxlength="6" placeholder="请输验证码"/>
                                    <span class="clean clean1"><img src="images/v3/btn_delect@2x.png" alt=""/></span>
                                    <p class="error">手机号不存在×</p>
                                </div>
                                <a class="a1 get-confirmcode" href="javascript:;" onClick="codeNock();">获取验证码</a>
                            </li>

                            <li class="no no-reg">
                                <label class="active"><span></span>阅读并同意</label><a href="${basePath}/intoPage.htm?pageName=member/servclause">《960用户协议》</a>
                            </li>

                            <li  class="no">
                                <a href="javascript:;" onClick="subRegisterFirst();"><span class="input-reg input-next">下一步</span></a>
                            </li>
                        </ul>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</div>
<div class="third-part-warp">
    <div class="third-part">
        <div class="title">
            <span>社交账号登录</span>
        </div>
        <div class="way">
            <div class="login-way" data-threePartType="1">
                <img src="../../images/v3/qq@2x.png" alt="qq" />
                <p>QQ</p>
            </div>
            <div class="login-way" data-threePartType="2">
                <img src="../../images/v3/wechat@2x.png" alt="wechat" />
                <p>微信</p>
            </div>
            <div class="login-way"  data-threePartType="3">
                <img src="../../images/v3/blog@2x.png" alt="blog" />
                <p>微博</p>
            </div>
        </div>

    </div>
</div>
<#--<img style="visibility: hidden" src="../../images/v3/login_reg.gif" alt=""/>-->

<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?94d81cec8c55272bd7081c5126331fc1";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();

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
<script src="${basePath}/js/v3/swiper.js"></script>
<script src="${basePath}/js/login/login.js?timestamp=1525656298"></script>
<script src="${basePath}/js/wechatauth.js"></script>
</body>
</html>