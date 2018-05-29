<#assign basePath=request.contextPath>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <script  src="${basePath}/js/jquery.js"></script>
    <style>
        @charset "utf-8";
        body,h1,h2,h3,h4,h5,h6,hr,p,blockquote,figure,dl,dt,dd,ul,ol,li,fieldset,lengend,button,input,textarea,th,td,pre{margin:0;padding:0;box-sizing:border-box}
        body{ font-family:微软雅黑,Microsoft yahei;font-size:12px;  box-sizing:border-box}
        ul,ol,menu{padding:0}
        ul,ol{list-style:none}
        address,cite,dfn,em,var{font-style:normal}
        a{text-decoration:none}
        a:hover{}
        img{border:none}
        input,textarea{outline:none}
        .clearfixed:after{content:".";clear:both;display:block;height:0px;visibility:hidden}
        body{
            background: #f9f9f9;
        }
        .floor{
            position: relative;
        }
        .floor img{
            vertical-align: bottom;
            width:100%;
        }
        .floor .buynow{
            position: absolute;
            bottom:.2rem;
            right:.5rem;
            width:1rem;
            height:.24rem;
        }
        .list li{
            float: left;
            width:50%;
            position: relative;
        }
        .list li .product{
            width:100%;
            vertical-align: bottom;
        }
        .list li .buy{
            position: absolute;
            bottom:.2rem;
            left:.4375rem;
            width:1rem;
            height:.24rem;
        }
    </style>
</head>
<body>
<#--webview内嵌的页面-->
<div>
    <div class="floor">
        <img src="${basePath}/images/v3/xn_activity/XQ1.jpg">
    </div>
    <div class="list">
        <ul>
            <li>
                <img class="product godetail" data-id="7840" src="${basePath}/images/v3/xn_activity/XQ2.jpg">
            </li>
            <li>
                <img class="product godetail" data-id="7850" src="${basePath}/images/v3/xn_activity/XQ3.jpg">
            </li>
            <li>
                <img class="product godetail" data-id="7862" src="${basePath}/images/v3/xn_activity/XQ4.jpg">
            </li>
            <li>
                <img class="product godetail" data-id="7866" src="${basePath}/images/v3/xn_activity/XQ5.jpg">
            </li>
        </ul>
        <div class="clearfixed"></div>
    </div>
    <div class="floor">
        <img class="product  godetail" data-id="7870"  src="${basePath}/images/v3/xn_activity/XQ6.jpg">
    </div>
    <div class="floor">
        <img src="${basePath}/images/v3/xn_activity/XQ7.jpg">
    </div>
    <div class="list">
        <ul>
            <li>
                <img class="product" src="${basePath}/images/v3/xn_activity/XQ8.jpg">
                <img class="buy godetail" data-id="7840" src="${basePath}/images/v3/xn_activity/buy.png">
            </li>
            <li>
                <img class="product" src="${basePath}/images/v3/xn_activity/XQ9.jpg">
                <img class="buy godetail" data-id="7842" src="${basePath}/images/v3/xn_activity/buy.png">
            </li>
            <li>
                <img class="product" src="${basePath}/images/v3/xn_activity/XQ10.jpg">
                <img class="buy godetail" data-id="7838" src="${basePath}/images/v3/xn_activity/buy.png">
            </li>
            <li>
                <img class="product" src="${basePath}/images/v3/xn_activity/XQ11.jpg">
                <img class="buy godetail" data-id="7844" src="${basePath}/images/v3/xn_activity/buy.png">
            </li>
            <li>
                <img class="product" src="${basePath}/images/v3/xn_activity/XQ12.jpg">
                <img class="buy godetail" data-id="7846" src="${basePath}/images/v3/xn_activity/buy.png">
            </li>
            <li>
                <img class="product" src="${basePath}/images/v3/xn_activity/XQ13.jpg">
                <img class="buy godetail" data-id="7848" src="${basePath}/images/v3/xn_activity/buy.png">
            </li>
        </ul>
        <div class="clearfixed"></div>
    </div>
    <div class="floor">
        <img src="${basePath}/images/v3/xn_activity/XQ14.jpg">
    </div>
    <div class="list">
        <ul>
            <li>
                <img class="product" src="${basePath}/images/v3/xn_activity/XQ15.jpg">
                <img class="buy godetail" data-id="7850" src="${basePath}/images/v3/xn_activity/buy.png">
            </li>
            <li>
                <img class="product" src="${basePath}/images/v3/xn_activity/XQ16.jpg">
                <img class="buy godetail" data-id="7852" src="${basePath}/images/v3/xn_activity/buy.png">
            </li>
        </ul>
        <div class="clearfixed"></div>
    </div>
    <div class="floor">
        <img class="product"  src="${basePath}/images/v3/xn_activity/XQ17.jpg">
        <img class="buynow godetail" data-id="7854" src="${basePath}/images/v3/xn_activity/buy.png">
    </div>
    <div class="floor">
        <img src="${basePath}/images/v3/xn_activity/XQ18.jpg">
    </div>
    <div class="list">
        <ul>
            <li>
                <img class="product" src="${basePath}/images/v3/xn_activity/XQ19.jpg">
                <img class="buy godetail" data-id="7862" src="${basePath}/images/v3/xn_activity/buy.png">
            </li>
            <li>
                <img class="product" src="${basePath}/images/v3/xn_activity/XQ20.jpg">
                <img class="buy godetail" data-id="7864" src="${basePath}/images/v3/xn_activity/buy.png">
            </li>
            <li>
                <img class="product" src="${basePath}/images/v3/xn_activity/XQ21.jpg">
                <img class="buy godetail" data-id="7866" src="${basePath}/images/v3/xn_activity/buy.png">
            </li>
            <li>
                <img class="product" src="${basePath}/images/v3/xn_activity/XQ22.jpg">
                <img class="buy godetail" data-id="7868" src="${basePath}/images/v3/xn_activity/buy.png">
            </li>
            <li>
                <img class="product" src="${basePath}/images/v3/xn_activity/XQ23.jpg">
                <img class="buy godetail" data-id="7856" src="${basePath}/images/v3/xn_activity/buy.png">
            </li>
            <li>
                <img class="product" src="${basePath}/images/v3/xn_activity/XQ24.jpg">
                <img class="buy godetail" data-id="7860" src="${basePath}/images/v3/xn_activity/buy.png">
            </li>
            <li>
                <img class="product" src="${basePath}/images/v3/xn_activity/XQ25.jpg">
                <img class="buy godetail" data-id="7858" src="${basePath}/images/v3/xn_activity/buy.png">
            </li>
            <li>
                <img class="product" src="${basePath}/images/v3/xn_activity/XQ26.jpg">
                <img class="buy godetail" data-id="7870" src="${basePath}/images/v3/xn_activity/buy.png">
            </li>
        </ul>
        <div class="clearfixed"></div>
    </div>
    <div class="floor">
        <img class="product" src="${basePath}/images/v3/xn_activity/XQ27.jpg">
        <img class="buynow godetail" data-id="7965" style="bottom: .5rem" src="${basePath}/images/v3/xn_activity/buy.png">
    </div>
</div>

<script>
    (function(doc, win) {
        var docEl = doc.documentElement,
                resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
                recalc = function() {
                    var clientWidth = docEl.clientWidth;
                    if (!clientWidth) return;
                    docEl.style.fontSize = 100 * (clientWidth / 375) + 'px';
                };
        if (!doc.addEventListener) return;
        win.addEventListener(resizeEvt, recalc, false);
        doc.addEventListener('DOMContentLoaded', recalc, false);
    })(document, window);
</script>
<script type="text/javascript">
    var ua = navigator.userAgent.toLowerCase();
    $(".godetail").on("click",function(){
        var pru = {goDetail: $(this).attr("data-id")};
        if(ua == "960"){
            window.webkit.messageHandlers.goDetail.postMessage(pru);
        }else if(ua == "960android"){
            window.android.jumpActivity(JSON.stringify(pru));
        }else{
            window.location.href = "${basePath}/item/"+$(this).attr("data-id")+".html";
        }
    });
</script>
</body>
</html>