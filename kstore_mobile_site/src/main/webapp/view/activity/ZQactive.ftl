<#--<#assign basePath=request.contextPath>-->
<#--<!DOCTYPE html>-->
<#--<html lang="en">-->
<#--<head>-->
    <#--<meta charset="UTF-8">-->
    <#--<title>960中秋心意价</title>-->
    <#--<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">-->
    <#--<meta name="apple-mobile-web-app-capable" content="yes">-->
    <#--<meta name="apple-mobile-web-app-status-bar-style" content="black">-->
    <#--<link href="${basePath}/css/v1/swiper.min.css" rel="stylesheet">-->
    <#--<link href="${basePath}/css/v2/ZQactive.css" rel="stylesheet">-->
    <#--<script  src="${basePath}/js/jquery.js"></script>-->
    <#--<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>-->
    <#--<script>-->
        <#--var localUrl = window.location.href;-->
        <#--$(function(){-->
            <#--$.ajax({-->
                <#--url: "${basePath}/queryWxConfig.htm",-->
                <#--type: "POST",-->
                <#--data:{curUrl: localUrl},-->
                <#--success: function (data) {-->
                    <#--wx.config({-->
                        <#--debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。-->
                        <#--appId: data.appId, // 必填，公众号的唯一标识-->
                        <#--timestamp: data.timestamp, // 必填，生成签名的时间戳-->
                        <#--nonceStr: data.nonceStr, // 必填，生成签名的随机串-->
                        <#--signature: data.signature,// 必填，签名，见附录1-->
                        <#--jsApiList: ['onMenuShareAppMessage','onMenuShareTimeline'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2-->
                    <#--});-->
                <#--},-->
                <#--async:false-->
            <#--});-->
        <#--});-->

        <#--wx.ready(function () {-->
            <#--wx.onMenuShareAppMessage({-->
                <#--title: '中秋让美味和心意一起团圆！购礼品卡送500元高档茶叶，送的轻松，收的满意！还能抽奖哦！',-->
                <#--desc: '中秋让美味和心意一起团圆！购礼品卡送500元高档茶叶，送的轻松，收的满意！还能抽奖哦！',-->
                <#--link: "http://m.ge960.com/toActivity.htm",-->
                <#--imgUrl: 'http://boss.ge960.com/upload/20170910/logo2.png'-->
            <#--});-->

            <#--wx.onMenuShareTimeline({-->
                <#--title: '中秋让美味和心意一起团圆！购礼品卡送500元高档茶叶，送的轻松，收的满意！还能抽奖哦！',-->
                <#--link: "http://m.ge960.com/toActivity.htm",-->
                <#--imgUrl: 'http://boss.ge960.com/upload/20170910/logo2.png'-->
            <#--});-->
        <#--})-->
    <#--</script>&lt;#&ndash;自定义分享到朋友圈&ndash;&gt;-->
<#--</head>-->
<#--<body>-->
<#--<div style="position:absolute; top:-300px;"><img src="http://boss.ge960.com/upload/20170910/logo2.png"></div>-->
<#--<div class="banner">-->
    <#--<img src="${basePath}/images/v2/active/zq-banner.png">-->
    <#--<img src="${basePath}/images/v2/active/zq-part2.png">-->
<#--</div>-->
<#--<div class="banner ban">-->
    <#--<img src="${basePath}/images/v2/active/zq-part3.png">-->
    <#--<a href="${basePath}/item/7967.html" onclick="_czc.push(['_trackEvent', 'H5-TOP1', '查看', '心意卡', '0', 'card']);" id="card"><img src="${basePath}/images/v2/active/lijigoumai.png"></a>-->
<#--</div>-->
<#--<div class="banner">-->
    <#--<img src="${basePath}/images/v2/active/zq-part4.png">-->
<#--</div>-->
<#--<div class="detail">-->
    <#--<div>-->
        <#--<a href="http://m.ge960.com/item/7954.html" onclick="_czc.push(['_trackEvent', 'H5-TOP1', '查看', '小康云雾红茶(150g)', '0', 'redtea150']);" id="redtea150">-->
            <#--<img src="${basePath}/images/v2/active/2_10.png">-->
        <#--</a>-->
    <#--</div>-->
    <#--<div>-->
        <#--<a href="http://m.ge960.com/item/7959.html" onclick="_czc.push(['_trackEvent', 'H5-TOP1', '查看', '小康云雾红茶(250g)', '0', 'redtea250']);" id="redtea250">-->
            <#--<img src="${basePath}/images/v2/active/2_12.png">-->
        <#--</a>-->
    <#--</div>-->
    <#--<div>-->
        <#--<a href="http://m.ge960.com/item/7956.html" onclick="_czc.push(['_trackEvent', 'H5-TOP1', '查看', '小康云雾五百年(150g)', '0', 'fivehundred150']);" id="fivehundred150">-->
            <#--<img src="${basePath}/images/v2/active/2_14.png">-->
        <#--</a>-->
    <#--</div>-->
    <#--<div>-->
        <#--<a href="http://m.ge960.com/item/7957.html" onclick="_czc.push(['_trackEvent', 'H5-TOP1', '查看', '小康云雾五百年(250g)', '0', 'fivehundred250']);" id="fivehundred250">-->
            <#--<img src="${basePath}/images/v2/active/2_20.png">-->
        <#--</a>-->
    <#--</div>-->
    <#--<div>-->
        <#--<a href="http://m.ge960.com/item/7955.html" onclick="_czc.push(['_trackEvent', 'H5-TOP1', '查看', '小康云雾黑茶(150g)', '0', 'blacktea150']);" id="blacktea150">-->
            <#--<img src="${basePath}/images/v2/active/2_21.png">-->
        <#--</a>-->
    <#--</div>-->
    <#--<div>-->
        <#--<a href="http://m.ge960.com/item/7958.html" onclick="_czc.push(['_trackEvent', 'H5-TOP1', '查看', '小康云雾黑茶(250g)', '0', 'blacktea250']);" id="blacktea250">-->
            <#--<img src="${basePath}/images/v2/active/2_22.png">-->
        <#--</a>-->
    <#--</div>-->
    <#--<p class="clearfixed"></p>-->
<#--</div>-->
<#--<div class="floor2">-->
    <#--<img src="${basePath}/images/v2/active/zq-part5.png">-->
<#--</div>-->
<#--<div class="detail wine">-->
    <#--<div>-->
        <#--<a href="http://m.ge960.com/item/7143.html" onclick="_czc.push(['_trackEvent', 'H5-TOP2', '查看', '张裕贵馥晚采甜红葡萄酒750ml/瓶', '0', 'redwine']);" id="redwine">-->
            <#--<img src="${basePath}/images/v2/active/2_29.png">-->
        <#--</a>-->
    <#--</div>-->
    <#--<div>-->
        <#--<a href="http://m.ge960.com/item/7139.html" onclick="_czc.push(['_trackEvent', 'H5-TOP2', '查看', '张裕贵馥晚采甜白葡萄酒750ml/瓶', '0', 'whitewine']);" id="whitewine">-->
            <#--<img src="${basePath}/images/v2/active/2_31.png">-->
        <#--</a>-->
    <#--</div>-->
    <#--<div>-->
        <#--<a href="http://m.ge960.com/item/7147.html" onclick="_czc.push(['_trackEvent', 'H5-TOP2', '查看', '张裕酒城葡园蛇龙珠干红葡萄酒750ml/瓶', '0', 'dryredwine_slz']);" id="dryredwine_slz">-->
            <#--<img src="${basePath}/images/v2/active/2_33.png">-->
        <#--</a>-->
    <#--</div>-->
    <#--<div>-->
        <#--<a href="http://m.ge960.com/item/7151.html" onclick="_czc.push(['_trackEvent', 'H5-TOP2', '查看', '张裕卡斯特庄主珍藏蛇龙珠干红葡萄酒750ml/瓶', '0', 'dryredwine_kst']);" id="dryredwine_kst">-->
            <#--<img src="${basePath}/images/v2/active/2_39.png">-->
        <#--</a>-->
    <#--</div>-->
    <#--<div>-->
        <#--<a href="http://m.ge960.com/item/7155.html" onclick="_czc.push(['_trackEvent', 'H5-TOP2', '查看', '张裕酒城葡园干红葡萄酒750ml/瓶', '0', 'dryredwine']);" id="dryredwine">-->
            <#--<img src="${basePath}/images/v2/active/2_41.png">-->
        <#--</a>-->
    <#--</div>-->
    <#--<div>-->
        <#--<a href="http://m.ge960.com/item/7221.html" onclick="_czc.push(['_trackEvent', 'H5-TOP2', '查看', '元之源 精选牛腩2000g内蒙草原纯天然牛肉', '0', 'yzy_niunan']);" id="yzy_niunan">-->
            <#--<img src="${basePath}/images/v2/active/2_42.png">-->
        <#--</a>-->
    <#--</div>-->
    <#--<div>-->
        <#--<a href="http://m.ge960.com/item/7835.html" onclick="_czc.push(['_trackEvent', 'H5-TOP2', '查看', '元之源 牛肉切块2000g 内蒙直供新鲜牛肉', '0', 'yzy_nrqk']);" id="yzy_nrqk">-->
            <#--<img src="${basePath}/images/v2/active/2_47.png">-->
        <#--</a>-->
    <#--</div>-->
    <#--<div>-->
        <#--<a href="http://m.ge960.com/item/7233.html" onclick="_czc.push(['_trackEvent', 'H5-TOP2', '查看', '元之源 羊肉馅1000g 无碎肉拼接 饺子馅', '0', 'yzy_yrx']);" id="yzy_yrx">-->
            <#--<img src="${basePath}/images/v2/active/2_49.png">-->
        <#--</a>-->
    <#--</div>-->
    <#--<div>-->
        <#--<a href="http://m.ge960.com/item/7239.html" onclick="_czc.push(['_trackEvent', 'H5-TOP2', '查看', '元之源 精羊卷2000g内蒙草原纯天然羊肉', '0', 'yzy_yangrou']);" id="yzy_yangrou">-->
            <#--<img src="${basePath}/images/v2/active/2_51.png">-->
        <#--</a>-->
    <#--</div>-->
    <#--<div>-->
        <#--<a href="http://m.ge960.com/item/7235.html" onclick="_czc.push(['_trackEvent', 'H5-TOP2', '查看', '元之源 内蒙新鲜羊肉卷（火锅）1000g', '0', 'yzy_yangroujuan']);" id="yzy_yangroujuan">-->
            <#--<img src="${basePath}/images/v2/active/2_56.png">-->
        <#--</a>-->
    <#--</div>-->
    <#--<div>-->
        <#--<a href="http://m.ge960.com/item/7732.html" onclick="_czc.push(['_trackEvent', 'H5-TOP2', '查看', '元之源 羔羊肉卷2.5kg', '0', 'yzy_gyrj']);" id="yzy_gyrj">-->
            <#--<img src="${basePath}/images/v2/active/2_58.png">-->
        <#--</a>-->
    <#--</div>-->
    <#--<div>-->
        <#--<a href="http://m.ge960.com/item/7231.html" onclick="_czc.push(['_trackEvent', 'H5-TOP2', '查看', '元之源 牛肉馅1000g 无碎肉拼接 饺子馅', '0', 'yzy_nrx']);" id="yzy_nrx">-->
            <#--<img src="${basePath}/images/v2/active/2_59.png">-->
        <#--</a>-->
    <#--</div>-->
    <#--<p class="clearfixed"></p>-->
<#--</div>-->
<#--<div class="floor3">-->
    <#--<img src="${basePath}/images/v2/active/zq-part6.png">-->
<#--</div>-->
<#--<div class="detail wine">-->
    <#--<div>-->
        <#--<a href="http://m.ge960.com/item/7868.html" onclick="_czc.push(['_trackEvent', 'H5-TOP3', '查看', '元之源卤汁牛筋（香辣）75g/袋', '0', 'yzy_niujin']);" id="yzy_niujin">-->
            <#--<img src="${basePath}/images/v2/active/2_66.png">-->
        <#--</a>-->
    <#--</div>-->
    <#--<div>-->
        <#--<a href="http://m.ge960.com/item/7864.html" onclick="_czc.push(['_trackEvent', 'H5-TOP3', '查看', '元之源卤汁牛肉（香辣）75g/袋', '0', 'yzy_niurou']);" id="yzy_niurou">-->
            <#--<img src="${basePath}/images/v2/active/2_68.png">-->
        <#--</a>-->
    <#--</div>-->
    <#--<div>-->
        <#--<a href="http://m.ge960.com/item/7852.html" onclick="_czc.push(['_trackEvent', 'H5-TOP3', '查看', '元之源牛板筋（烧烤味）228g/袋', '0', 'yzy_niubanjin']);" id="yzy_niubanjin">-->
            <#--<img src="${basePath}/images/v2/active/2_70.png">-->
        <#--</a>-->
    <#--</div>-->
    <#--<div>-->
        <#--<a href="http://m.ge960.com/item/7846.html" onclick="_czc.push(['_trackEvent', 'H5-TOP3', '查看', '元之源风干牛肉（麻辣）228g/袋', '0', 'yzy_ganniurou']);" id="yzy_ganniurou">-->
            <#--<img src="${basePath}/images/v2/active/2_76.png">-->
        <#--</a>-->
    <#--</div>-->
    <#--<div>-->
        <#--<a href="http://m.ge960.com/item/7870.html" onclick="_czc.push(['_trackEvent', 'H5-TOP3', '查看', '元之源烧烤牛肉75g/袋', '0', 'yzy_sknr']);" id="yzy_sknr">-->
            <#--<img src="${basePath}/images/v2/active/2_78.png">-->
        <#--</a>-->
    <#--</div>-->
    <#--<div>-->
        <#--<a href="http://m.ge960.com/item/7965.html" onclick="_czc.push(['_trackEvent', 'H5-TOP3', '查看', '元之源手撕牛肉435g/袋', '0', 'yzy_ssnr']);" id="yzy_ssnr">-->
            <#--<img src="${basePath}/images/v2/active/2_79.png">-->
        <#--</a>-->
    <#--</div>-->
    <#--<div>-->
        <#--<a href="http://m.ge960.com/item/7848.html" onclick="_czc.push(['_trackEvent', 'H5-TOP3', '查看', '元之源风干牛肉（香辣）118g/袋', '0', 'yzy_fgnr']);" id="yzy_fgnr">-->
            <#--<img src="${basePath}/images/v2/active/2_84.png">-->
        <#--</a>-->
    <#--</div>-->
    <#--<div>-->
        <#--<a href="http://m.ge960.com/item/7860.html" onclick="_czc.push(['_trackEvent', 'H5-TOP3', '查看', '元之源牛蹄筋（香辣）228g/袋 零售', '0', 'yzy_ntj']);" id="yzy_ntj">-->
            <#--<img src="${basePath}/images/v2/active/2_86.png">-->
        <#--</a>-->
    <#--</div>-->
    <#--<div>-->
        <#--<a href="http://m.ge960.com/item/7874.html" onclick="_czc.push(['_trackEvent', 'H5-TOP3', '查看', '元之源亚麻籽油食用油250ml/瓶', '0', 'yzy_you']);" id="yzy_you">-->
            <#--<img src="${basePath}/images/v2/active/2_88.png">-->
        <#--</a>-->
    <#--</div>-->
    <#--<p class="clearfixed"></p>-->
<#--</div>-->
<#--<div class="floor4">-->
    <#--<img src="${basePath}/images/v2/active/zq-part7.png">-->
<#--</div>-->
<#--<div class="floor5" style="padding-top: .25rem;">-->
    <#--<img src="${basePath}/images/v2/active/zq-part8.png">-->
<#--</div>-->
<#--<div class="award">-->
    <#--<a href="http://m.ge960.com/item/7959.html" onclick="_czc.push(['_trackEvent', 'H5-TOP4', '查看', '一等奖', '0', 'firstprice']);" id="firstprice"><img src="${basePath}/images/v2/active/3_96.png"></a>-->
    <#--<a href="http://m.ge960.com/item/7143.html" onclick="_czc.push(['_trackEvent', 'H5-TOP4', '查看', '二等奖', '0', 'secondprice']);" id="secondprice"><img src="${basePath}/images/v2/active/3_97.png"></a>-->
    <#--<a href="http://m.ge960.com/item/7874.html" onclick="_czc.push(['_trackEvent', 'H5-TOP4', '查看', '三等奖', '0', 'thirdprice']);" id="thirdprice"><img src="${basePath}/images/v2/active/3_98.jpg"></a>-->

<#--</div>-->
<#--<div class="floor6">-->
    <#--<img src="${basePath}/images/v2/active/zq-part9.png">-->
<#--</div>-->
<#--<div class="interact">-->
    <#--<div class="interact1">-->
        <#--<div class="swiper-container">-->
            <#--<div class="swiper-wrapper">-->
                <#--<div class="swiper-slide"><img src="${basePath}/images/v2/active/swiper.png"></div>-->
                <#--<div class="swiper-slide"><img src="${basePath}/images/v2/active/swiper1.png"></div>-->
                <#--<div class="swiper-slide"><img src="${basePath}/images/v2/active/swiper2.png"></div>-->
            <#--</div>-->
            <#--<div class="swiper-pagination"></div>-->
        <#--</div>-->
    <#--</div>-->
<#--</div>-->


<#--<p style="display: none;">-->
<#--&lt;#&ndash;友盟CNZZ统计&ndash;&gt;-->
    <#--<script src="https://s19.cnzz.com/z_stat.php?id=1264375679&web_id=1264375679" language="JavaScript">-->
    <#--//声明_czc对象:-->
    <#--var _czc = _czc || [];-->
    <#--//绑定siteid，请用您的siteid替换下方"XXXXXXXX"部分-->
    <#--_czc.push(["_setAccount", "m.ge960.com"]);-->
<#--</script>-->
<#--</p>-->
<#--<script>-->
    <#--(function(doc, win) {-->
        <#--var docEl = doc.documentElement,-->
                <#--resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',-->
                <#--recalc = function() {-->
                    <#--var clientWidth = docEl.clientWidth;-->
                    <#--if (!clientWidth) return;-->
                    <#--docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';-->
                <#--};-->
        <#--if (!doc.addEventListener) return;-->
        <#--win.addEventListener(resizeEvt, recalc, false);-->
        <#--doc.addEventListener('DOMContentLoaded', recalc, false);-->
    <#--})(document, window);-->
<#--</script>-->
<#--<script src="${basePath}/js/v1/swiper.min.js"></script>-->
<#--<script>-->
    <#--var swiper = new Swiper('.swiper-container', {-->
        <#--pagination: '.swiper-pagination'-->
        <#--,paginationClickable: true-->
        <#--, autoplay: 3000-->
        <#--,loop:true-->
    <#--});-->
<#--</script>-->
<#--</body>-->
<#--</html>-->