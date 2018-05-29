<#assign basePath=request.contextPath>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>这个冬天暖到你心里</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link href="${basePath}/css/v2/ZQactive.css" rel="stylesheet">
    <script  src="${basePath}/js/jquery.js"></script>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script>
        var localUrl = window.location.href;
        $(function(){
            $.ajax({
                url: "${basePath}/queryWxConfig.htm",
                type: "POST",
                data:{curUrl: localUrl},
                success: function (data) {
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
                title: '这个冬天暖到你心里',
                desc: '这个冬天暖到你心里',
                link: "http://m.ge960.com/toNewYearActivity.htm",
                imgUrl: 'http://boss.ge960.com/upload/20171227/wx1.jpg'
            });

            wx.onMenuShareTimeline({
                title: '这个冬天暖到你心里',
                link: "http://m.ge960.com/toNewYearActivity.htm",
                imgUrl: 'http://boss.ge960.com/upload/20171227/wx1.jpg'
            });
        })
    </script><#--自定义分享到朋友圈-->
    <style>
        .floor img{
            width:100%;
            vertical-align: bottom;
        }
        .floor{
            position: relative;
        }
        .floor .buy-now{
            position: absolute;
            right:.5rem;
            bottom:.5rem;
            width:.81rem;
            height:.3rem;
        }
        .floor .buy-now img{
            width:.81rem;
            height:.3rem;
        }
    </style>
</head>
<body>

<div class="floor">
    <img style="height:4.62rem" class="lazy" data-original="${basePath}/images/v3/yd_activity/activity_01.jpg">
</div>
<div class="floor">
    <img style="height:.83rem " class="lazy" data-original="${basePath}/images/v3/yd_activity/activity_02.jpg">
    <img style="height:2.91rem " class="lazy" data-original="${basePath}/images/v3/yd_activity/activity_03.jpg">

</div>
<div class="floor">
    <img style="height:.81rem " class="lazy" data-original="${basePath}/images/v3/yd_activity/activity_04.jpg">
    <img style="height:3.57rem " class="lazy" data-original="${basePath}/images/v3/yd_activity/activity_05.jpg">
    <a href="${basePath}/item/8155.html" class="buy-now" onclick="_czc.push(['_trackEvent', 'NewYear-AiXin', '查看', '爱心卡', '0', 'AXcard']);" id="AXcard"><img src="${basePath}/images/v3/yd_activity/buy_now_sk.png"></a>

</div>
<div class="floor">
    <img style="height:.79rem " class="lazy" data-original="${basePath}/images/v3/yd_activity/activity_06.jpg">
    <img style="height:3.56rem " class="lazy" data-original="${basePath}/images/v3/yd_activity/activity_07.jpg">
    <a href="${basePath}/item/7967.html" class="buy-now" onclick="_czc.push(['_trackEvent', 'NewYear-XinYi', '查看', '心意卡', '0', 'XYcard']);" id="XYcard"><img src="${basePath}/images/v3/yd_activity/buy_now_sk.png"></a>
</div>
<div class="floor">
    <img style="height:.81rem " class="lazy" data-original="${basePath}/images/v3/yd_activity/activity_08.jpg">
    <img style="height:3.61rem " class="lazy" data-original="${basePath}/images/v3/yd_activity/activity_09.jpg">
    <a href="${basePath}/item/8157.html" class="buy-now" onclick="_czc.push(['_trackEvent', 'NewYear-XiaoXin', '查看', '孝心卡', '0', 'XXcard']);" id="XXcard"><img src="${basePath}/images/v3/yd_activity/buy_now_sk.png"></a>
</div>




<p style="display: none;">
<#--友盟CNZZ统计-->
    <script src="https://s19.cnzz.com/z_stat.php?id=1264375679&web_id=1264375679" language="JavaScript">
        //声明_czc对象:
        var _czc = _czc || [];
        //绑定siteid，请用您的siteid替换下方"XXXXXXXX"部分
        _czc.push(["_setAccount", "m.ge960.com"]);
    </script>
</p>
<script>
    (function(doc, win) {
        var docEl = doc.documentElement,
                resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
                recalc = function() {
                    var clientWidth = docEl.clientWidth;
                    if (!clientWidth) return;
                    docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
                };
        if (!doc.addEventListener) return;
        win.addEventListener(resizeEvt, recalc, false);
        doc.addEventListener('DOMContentLoaded', recalc, false);
    })(document, window);
</script>
<script  src="${basePath}/js/v3/jquery.lazyload.js"></script>
<script>
    $(function() {
        $("img.lazy").lazyload();
    })
</script>
</body>
</html>