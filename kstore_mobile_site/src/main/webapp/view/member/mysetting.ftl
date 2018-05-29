<!DOCTYPE html>
<html>
<head>

    <title>会员中心 - 设置</title>
    <#assign basePath=request.contextPath>
    <#include '/common/head.ftl' />

    <style>
        .list-block ul:after{
            content:"";
            position: absolute;
            left: 0;
            top: 0;
            bottom: none;
            right: auto;
            height: 0px;
            width: 100%;
            display: block;
            z-index: -1!important;
            -webkit-transform-origin: 50% 0;
            transform-origin: 50% 0;
        }
     /*   .vheader{padding: 0px!important;}*/
        .list-block .item-link .item-inner{
            /*height: 3.76em;*/
            height: 1.1rem;
            background-image: url(/images/icon_v1.0/btn_more_right@2x.png);
            background-size: 22px 22px;
            background-repeat: no-repeat;
            background-position: 95% center;
            background-position: -web.shopping_cart .shoppingcart_itemkit-calc(100% - 15px) center;
            background-position: calc(100% - 15px) center;
        }
        .mysetting ul {  border-bottom: 10px solid #f7f7f7;  }
        /*.mysetting ul:first-of-type{  border-top: .7em solid #f7f7f7;  }*/
        #myorder .content-block-inner, #myorder .content-block {  background: #f7f7f7;  padding: 0;  }
        .mysetting .item-title {  font-size: 15px;  color: #000;  letter-spacing: 0;  }
        .set-out {
            padding: 0 0;
            height: 3.76em;
            width: 100%;
            background: #ffffff;
        }
        .set-out p{
            font-size: 15px;
            color: #ff3b2f!important;
            letter-spacing: 0;
            text-align: center;
            line-height: 3.76em;
        }
        .list-block .item-content {
            box-sizing: border-box;
            padding-left: .3rem;
            height: 3.76em;
            display: -webkit-box;
            display: -ms-flexbox;
            display: -webkit-flex;
            display: flex;
            -webkit-box-pack: justify;
            -ms-flex-pack: justify;
            -webkit-justify-content: space-between;
            justify-content: space-between;
            -webkit-box-align: center;
            -ms-flex-align: center;
            -webkit-align-items: center;
            align-items: center;
        }
        .view, .views {  z-index: 999;  }
    </style>
</head>
<body>
<#assign vtitle="设置" />
<#assign backUrl="${basePath}/customercenter.html" />
<#include "../common/head_back.ftl"/>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script>
    var localUrl = window.location.href;
    $(function(){
        $.ajax({
            url: "${basePath}/queryWxConfig.htm",
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
        /*wx.onMenuShareAppMessage({
            title: '<%=shareTitle %>',
            desc: '<%=shareContent %>',
            link: '<%=currentUrl %>',
            imgUrl: '<%=shareImageUrl %>'
        });*/

        wx.onMenuShareTimeline({
            title: '中国960官方商城',
            link: 'http://m.ge960.com/',
            imgUrl: 'http://boss.ge960.com:80/upload/20170327/1490602121555.jpg'
        });
    })

</script><#--自定义分享到朋友圈-->
<script>
    (function (doc, win) {
        var docEl = doc.documentElement,
                resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
                recalc = function () {
                    var clientWidth = docEl.clientWidth;
                    if (!clientWidth) return;
                    docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
                };
        if (!doc.addEventListener) return;
        win.addEventListener(resizeEvt, recalc, false);
        doc.addEventListener('DOMContentLoaded', recalc, false);
    })(document, window);
</script>
<div class="views">
    <div class="view view-main">

        <div class="pages " >
            <div data-page="mysetting"  class="page page-on-center no-toolbar">
                <div id="myorder" class="page-content">

                    <div class="content-block">
                        <div class="content-block-inner">
                            <div class="mysetting">
                                <div class="list-block">
                                    <ul>
                                        <li>
                                            <a href="${basePath}/myaccount.html?main=2" class="item-link" onclick="_czc.push(['_trackEvent', '我的', '设置', '个人资料','0','setting_data']);">
                                                <div class="item-content">
                                                    <div class="item-inner">
                                                        <div class="item-title"><#--<img src="images/v1/myimages/set-1.png" alt=""/>-->个人资料</div>

                                                    </div>
                                                </div>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="${basePath}/addresslist.html?mainAddress=2" class="item-link" onclick="_czc.push(['_trackEvent', '我的', '设置', '收货地址','0','setting_address']);">
                                                <div class="item-content">
                                                    <div class="item-inner">
                                                        <div class="item-title"><#--<img src="images/v2/my-888.png" alt=""/>--><i>我的收货地址</i></div>
                                                    </div>
                                                </div>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="${basePath}/accountsafe.html" class="item-link" onclick="_czc.push(['_trackEvent', '我的', '设置', '账户安全','0','setting_safe']);">
                                                <div class="item-content">
                                                    <div class="item-inner">
                                                        <div class="item-title"><#--<img src="images/v1/myimages/set-2.png" alt=""/>--><i>账户安全</i></div>
                                                    </div>
                                                </div>
                                            </a>
                                        </li>

                                    </ul>
                                    <ul>
                                        <li>
                                            <a href="${basePath}/intoPage.htm?pageName=member/about" class="item-link" onclick="_czc.push(['_trackEvent', '我的', '设置', '关于我们','0','setting_ourselves']);">
                                                <div class="item-content">
                                                    <div class="item-inner">
                                                        <div class="item-title"><#--<img src="images/v1/myimages/set-3.png" alt=""/>-->关于我们</div>
                                                    </div>
                                                </div>
                                            </a>
                                        </li>

                                    </ul>
                                    <div class="set-out" id="loginout">
                                        <a href="javascript:;" onclick="_czc.push(['_trackEvent', '我的', '设置', '退出','0','setting_exit']);"><#--<img  src="images/v1/myimages/set-tc.png" alt=""/>-->
                                            <p>安全退出</p>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="myabout-bottom">
                            <#--Copyright© 2015  中国960官方商城<br/>  版权所有  京ICP备14057741号  京ICP证150185号-->
                                <img style="       width: 10.7em;" src="/images/v1/myimages/jiuliulingcom.png">

                            </div>
                            <div class="box2">

                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<p style="display: none;">
    <!--友盟CNZZ统计-->
    <script src="https://s13.cnzz.com/z_stat.php?id=1264375679&web_id=1264375679" language="JavaScript">
        var _czc = _czc || [];
        _czc.push(["_setAccount", "m.ge960.com"]);
    </script>
</p>
</body>
<script>
    $(function () {
        $("#loginout").click(function(){
            var discountExit;
            discountExit = dialog({
                width: 260,
                title: '提示',
                content: "确定要退出登录吗？",
                okValue: '确定',
                cancelValue: '取消',
                ok: function () {
                    window.location.href="${basePath}/logout.html";
                },
                cancel: function () {
                    return true;
                }
            });
            discountExit.showModal();
        });
    })
</script>
</html>