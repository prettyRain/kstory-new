<!DOCTYPE html>
<html>
<head>
 <#assign basePath=request.contextPath>
  <meta charset="UTF-8">
  <title>会员中心 - 我的账户</title>
  <#include '/common/head.ftl' />
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
<div class="views">
    <div class="view view-main">
        <div class="navbar">
            <div class="navbar-inner">
                <div class="left"><a href="#" class="back link"> <i class="icon icon-back"></i><span></span></a></div>
                <div class="center sliding">个人资料</div>
                <div class="right">
                    <a href="#" class="link icon-only open-panel"> <i class="icon icon-bars"></i></a>
                </div>

            </div>

        </div>
        <div class="pages" >
            <div data-page="${basePath}/intoPage.htm?pageName=member/myinfo"  class="page no-toolbar">
                <div id="myorder" class="page-content  myorder-view">
                    <link rel="stylesheet" type="text/css" href="js/picker/mui.picker.min.css" />

                    <div class="content-block">
                        <div class="content-block-inner myinfo">

                            <div class="list-block service address">
                                <ul>
                                    <li>
                                        <div class="item-content" style="height:1.5rem">
                                            <div class="item-media"><i class="icon icon-form-email"></i></div>
                                            <div class="item-inner">
                                                <div class="item-title label" style="vertical-align: middle;width:80%;font-size:.24rem;color:#a6a6a6;"><img src="myimages/info-logo.png"/> 修改头像</div>
                                                <div class="item-input">
                                                    <img src="myimages/a.png" alt=""/>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="item-content">
                                            <div class="item-media"><i class="icon icon-form-name"></i></div>
                                            <div class="item-inner">
                                                <div class="item-title label">昵称</div>
                                                <div class="item-input">
                                                    <input type="text" placeholder="使用中英文、数字和下划线">
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="item-content">
                                            <div class="item-media"><i class="icon icon-form-email"></i></div>
                                            <div class="item-inner">
                                                <div class="item-title label">性别</div>
                                                <div class="item-input">
                                                    <input type="tel" placeholder="">
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="item-content">
                                            <div class="item-media"><i class="icon icon-form-url"></i></div>
                                            <div class="item-inner">
                                                <div class="item-title label">生日</div>
                                                <div class="item-input">
                                                    <div id='showCityPicker3'  data-options='{"type":"date","beginYear":1940,"endYear":2020}' class="btn"><img src="myimages/a.png" alt=""/></div>
                                                    <div id='cityResult3' class="ui-alert"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="item-content">
                                            <div class="item-media"><i class="icon icon-form-password"></i></div>
                                            <div class="item-inner">
                                                <div class="item-title label">电子邮箱</div>
                                                <div class="item-input">
                                                    <input  type="text"  placeholder="">
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li></li>
                                </ul>
                                <div class="set-out"><img  src="myimages/info-btn.png" alt=""/></div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>