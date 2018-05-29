<!DOCTYPE html>
<html>
<head>
    <title>会员中心 - 关于我们</title>
    <#assign basePath=request.contextPath>
    <#include '/common/head.ftl' />
    <style>
     /*   .vheader{padding: 0px!important;}*/
        .list-block .item-title{
            font-size: 15px;
            color: #000;
            letter-spacing: 0;

        }
        .myabout .list {
           border-top: none;
        }
     .myabout-bottom {
         margin-bottom:70px;
     }
     .list-block .item-link .item-inner {
         background-image: url(/images/icon_v1.0/btn_more_right@2x.png);
         background-size: 22px 22px;
         background-repeat: no-repeat;
         background-position: 95% center;
         background-position: -webkit-calc(100% - 10px) center;
         background-position: calc(100% - 10px) center;
     }
     .list-block .item-content{
         height:1.1rem;
     }
    </style>
</head>
<body>
<#assign vtitle="关于我们" />
<#assign backUrl="${basePath}/intoPage.htm?pageName=member/mysetting" />
<#include "/common/head_back.ftl"/>
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

<script>

    (function (doc, win) {
        var docEl = doc.documentElement,
                resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
                recalc = function () {
                    var clientWidth = docEl.clientWidth;
                    if (!clientWidth) return;
                    if(clientWidth>=640){
                        docEl.style.fontSize = '100px';
                    }else{
                        docEl.style.fontSize =100 * (clientWidth / 750) + 'px';
                    }
                };

        if (!doc.addEventListener) return;
        win.addEventListener(resizeEvt, recalc, false);
        doc.addEventListener('DOMContentLoaded', recalc, false);
    })(document, window);
</script>
<div class="views" style="background: #f7f7f7;">
    <div class="view view-main">
        <div class="pages " >
            <div data-page="myabout"  class="page page-on-center no-toolbar">
                <div id="myorder" class="page-content">

                    <div class="content-block mymobile myabout">
                        <div class="content-block-inner">
                            <div class="list-block  service address">
                                <div class="myorder myscore">
                                    <div class="myscore-top" style="background: #f7f7f7;">
                                        <div class="myscore-jf">

                                        </div>
                                    <#--    <div class="myscore-hy" style="text-align: center;">1.0测试版</div>-->

                                    </div>
                                    <ul>
                                        <li class="list">
                                            <a href="${basePath}/intoPage.htm?pageName=member/servclause" class="item-link">
                                                <div class="item-content">
                                                    <div class="item-inner">
                                                        <div class="item-title">服务条款</div>
                                                    </div>
                                                </div>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="${basePath}/intoPage.htm?pageName=member/intimityclause" class="item-link">
                                                <div class="item-content">
                                                    <div class="item-inner">
                                                        <div class="item-title">隐私条款</div>
                                                        <div class="item-title"></div>
                                                    </div>
                                                </div>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="${basePath}/intoPage.htm?pageName=member/standard" class="item-link">
                                                <div class="item-content">
                                                    <div class="item-inner">
                                                        <div class="item-title">配送收费标准</div>
                                                        <div class="item-title"></div>
                                                    </div>
                                                </div>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="${basePath}/intoPage.htm?pageName=member/community_directory" class="item-link">
                                                <div class="item-content">
                                                    <div class="item-inner">
                                                        <div class="item-title">社区店名录</div>
                                                        <div class="item-title"></div>
                                                    </div>
                                                </div>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="javascript:void(0)" class="item-link">
                                                <div class="item-content">
                                                    <div class="item-inner" style="background: none;padding-right: 15px;">
                                                        <div class="item-title">客服电话</div>
                                                        <div class="item-title">400-808-8880</div>
                                                    </div>
                                                </div>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="myabout-bottom">
                            <#--Copyright© 2015  中国960官方商城<br/>  版权所有  京ICP备14057741号  京ICP证150185号-->
                            <img style="    width: 2.2rem;" src="/images/v1/myimages/jiuliulingcom.png">

                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>