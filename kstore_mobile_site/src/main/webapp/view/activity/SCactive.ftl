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
                link: "http://m.ge960.com/toRegisterActivity.htm",
                imgUrl: 'http://boss.ge960.com/upload/20171227/wx2.jpg'
            });

            wx.onMenuShareTimeline({
                title: '这个冬天暖到你心里',
                link: "http://m.ge960.com/toRegisterActivity.htm ",
                imgUrl: 'http://boss.ge960.com/upload/20171227/wx2.jpg'
            });
        })
    </script><#--自定义分享到朋友圈-->
    <style>
        .floor img,.list img{
            width:7.5rem;
            vertical-align: bottom;
        }
        .list li{
            float: left;
            width:50%;
            min-height:3.32rem;
            position: relative;
        }

        .list li:nth-of-type(1) .buy-now{
            position: absolute;
            right: .25rem;
            bottom: .28rem;
        }
        .list li:nth-of-type(2) .buy-now{
            position: absolute;
            right: .95rem;
            bottom: .28rem;
        }
        .list li:nth-of-type(3) .buy-now{
            position: absolute;
            right:.25rem;
            bottom:.79rem;
        }
        .list li:nth-of-type(4) .buy-now{
            position: absolute;
            right:.95rem;
            bottom:.79rem;
        }

        .list li .buy-now,.list li .buy-now img{
            width:1.1rem;
            height:.36rem;
            vertical-align: bottom;
        }
        .product{
            position: relative;
        }
        .product:nth-of-type(2n) .buy-now{
            position: absolute;
            left:2.9rem;
            bottom:.29rem;
        }
        .product:nth-of-type(2n+1) .buy-now{
            position: absolute;
            right: .95rem;
            bottom: .32rem;
        }
        .product .buy-now,.product .buy-now img{
            width:1.1rem;
            height:.36rem;
        }
        .product>img{
            width:7.5rem;
            vertical-align: bottom;
        }

    </style>
</head>
<body>

<div class="floor">
    <img style="height:3.57rem" class="lazy" data-original="${basePath}/images/v3/yd_activity/sc1.jpg">
    <img style="height:1.21rem" class="lazy" data-original="${basePath}/images/v3/yd_activity/sc1_1.jpg">
</div>
<div class="floor">
    <img style="height:3.02rem" class="lazy" data-original="${basePath}/images/v3/yd_activity/sc2.jpg">
</div>
<div class="list">
    <ul>
        <li>
            <img style="height:3.32rem;width: 100%;" class="lazy" data-original="${basePath}/images/v3/yd_activity/sc3.jpg">
            <a href="${basePath}/item/7954.html" class="buy-now" onclick="_czc.push(['_trackEvent', 'Register-Up-BlackTea150', '查看', '上-红茶150g', '0', 'Up_BlackTea150']);" id="Up_BlackTea150"><img src="${basePath}/images/v3/yd_activity/buy_now_sc.png"></a>
        </li>
        <li>
            <img style="height:3.32rem;width: 100%;" class="lazy" data-original="${basePath}/images/v3/yd_activity/sc4.jpg">
            <a href="${basePath}/item/7959.html" class="buy-now" onclick="_czc.push(['_trackEvent', 'Register-Up-BlackTea250', '查看', '上-红茶250g', '0', 'Up_BlackTea250']);" id="Up_BlackTea250"><img src="${basePath}/images/v3/yd_activity/buy_now_sc.png"></a>
        </li>
        <li>
            <img style="height:3.42rem;width: 100%;" class="lazy" data-original="${basePath}/images/v3/yd_activity/sc5.jpg">
            <a href="${basePath}/item/7956.html" class="buy-now" onclick="_czc.push(['_trackEvent', 'Register-Up-FiveHundred150', '查看', '上-五百年150g', '0', 'Up_FiveHundred150']);" id="Up_FiveHundred150"><img src="${basePath}/images/v3/yd_activity/buy_now_sc.png"></a>
        </li>
        <li>
            <img style="height:3.42rem;width: 100%;" class="lazy" data-original="${basePath}/images/v3/yd_activity/sc6.jpg">
            <a href="${basePath}/item/7957.html" class="buy-now" onclick="_czc.push(['_trackEvent', 'Register-Up-FiveHundred250', '查看', '上-五百年250g', '0', 'Up_FiveHundred250']);" id="Up_FiveHundred250"><img src="${basePath}/images/v3/yd_activity/buy_now_sc.png"></a>
        </li>
    </ul>
    <div class="clearfixed"></div>
</div>
<div class="floor">
    <img style="height:.58rem" class="lazy" data-original="${basePath}/images/v3/yd_activity/sc7.jpg">
</div>
<div class="product">
    <img style="height:2.01rem" class="lazy" data-original="${basePath}/images/v3/yd_activity/sc8.jpg">
    <a href="${basePath}/item/7954.html" class="buy-now" onclick="_czc.push(['_trackEvent', 'Register-Down-BlackTea150', '查看', '下-红茶150g', '0', 'Down_BlackTea150']);" id="Down_BlackTea150"><img src="${basePath}/images/v3/yd_activity/buy_now_sc.png"></a>
</div>
<div class="product" style="height:2.08rem;overflow: hidden;">
    <img style="height:2.09rem" class="lazy" data-original="${basePath}/images/v3/yd_activity/sc9.jpg">
    <a href="${basePath}/item/7959.html" class="buy-now" onclick="_czc.push(['_trackEvent', 'Register-Down-BlackTea250', '查看', '下-红茶250g', '0', 'Down_BlackTea250']);" id="Down_BlackTea250"><img src="${basePath}/images/v3/yd_activity/buy_now_sc.png"></a>
</div>
<div class="product">
    <img style="height:2.10rem" class="lazy" data-original="${basePath}/images/v3/yd_activity/sc10.jpg">
    <a href="${basePath}/item/7957.html" class="buy-now" onclick="_czc.push(['_trackEvent', 'Register-Down-FiveHundred250', '查看', '下-五百年250g', '0', 'Down_FiveHundred250']);" id="Down_FiveHundred250"><img src="${basePath}/images/v3/yd_activity/buy_now_sc.png"></a>
</div>
<div class="product">
    <img style="height:2.09rem" class="lazy" data-original="${basePath}/images/v3/yd_activity/sc11.jpg">
    <a href="${basePath}/item/7956.html" style="bottom: .2rem;" class="buy-now" onclick="_czc.push(['_trackEvent', 'Register-Down-FiveHundred150', '查看', '下-五百年150g', '0', 'Down_FiveHundred150']);" id="Down_FiveHundred150"><img src="${basePath}/images/v3/yd_activity/buy_now_sc.png"></a>
</div>
<div class="product">
    <img style="height:1.08rem" class="lazy" data-original="${basePath}/images/v3/yd_activity/sc12.jpg">
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