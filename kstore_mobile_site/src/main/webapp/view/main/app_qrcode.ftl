<!DOCTYPE html>
<html lang="zh-cn" xmlns:c="http://www.w3.org/1999/html">
<head>
    <title>960商城APP下载</title>
    <meta charset="utf-8">
    <#assign basePath=request.contextPath>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <style>
        .openBrowser,.openBrowser img{
            width:100%;
        }
        .openBrowser{
            margin-top: 10%;
            display:none;
        }
    </style>
</head>
<body>
<div class="openBrowser"><img src="/images/v1/img/openBrowser.jpg"></div>

<#--<p class="msg1" style="text-align: center;margin-top: 100px;"></p>-->
<#--<p class="msg2" style="text-align: center;"></p>-->
<script type="text/javascript" src="${basePath}/js/v1/jquery.min.js"></script>
<script type="text/javascript">

    //判断是否是微信打开
    function isWeiXin(){
        var ua = window.navigator.userAgent.toLowerCase();
        if(ua.match(/MicroMessenger/i) == 'micromessenger'){
            return true;
        }else{
            return false;
        }
    }

    /*
     * 智能机浏览器版本信息:
     *
     */
    var browser = {
        versions: function() {
            var u = navigator.userAgent, app = navigator.appVersion;
            return {//移动终端浏览器版本信息
                trident: u.indexOf('Trident') > -1, //IE内核
                presto: u.indexOf('Presto') > -1, //opera内核
                webKit: u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
                gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1, //火狐内核
                mobile: !!u.match(/AppleWebKit.*Mobile.*/) || !!u.match(/AppleWebKit/), //是否为移动终端
                ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
                android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或者uc浏览器
                iPhone: u.indexOf('iPhone') > -1 || u.indexOf('Mac') > -1, //是否为iPhone或者QQHD浏览器
                iPad: u.indexOf('iPad') > -1, //是否iPad
                webApp: u.indexOf('Safari') == -1 //是否web应该程序，没有头部与底部
            };
        }(),
        language: (navigator.browserLanguage || navigator.language).toLowerCase()
    }

    if (browser.versions.ios || browser.versions.iPhone || browser.versions.iPad) {
        window.location="http://itunes.apple.com/app/id1224473452";
    }
    else if (browser.versions.android) {
        if(isWeiXin()){
            $(".openBrowser").show()
            //$(".msg1").html("如长时间无反应");
            //$(".msg2").html("请点击右上角选择在浏览器中打开！");
        }
        window.location="http://m.ge960.com/app-ge960-release.apk";
    }

</script>
</body>
</html>