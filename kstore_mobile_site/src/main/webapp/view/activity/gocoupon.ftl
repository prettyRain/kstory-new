<#assign basePath=request.contextPath>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>注册成功</title>
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
        .header{
            width:92.5%;
            height:1.32rem;
            background: url(../../images/v3/bg@2x.png) no-repeat;
            -webkit-background-size:3.75rem 1.84rem;
            background-size:3.75rem 1.84rem;
            padding: .52rem 0 0 .28rem;
            margin-bottom: .12rem;
        }
        .header p{
            font-size: .12rem;
            letter-spacing: .5px;
            color: #FFE2DF;
        }
        .header .title{
            font-size: .25rem;
            color: #fff;
            margin-bottom: .03rem;
            font-weight: bold;
        }
        .header span{
            display: block;
            position: absolute;
            top:.66rem;
            right:.4rem;
            width:.87rem;
            text-align: center;
            height:.35rem;
            line-height:.35rem;
            background: url(../../images/v3/btn_more@2x.png) no-repeat left center;
            -webkit-background-size:.87rem .39rem;
           background-position: 0px 0px;
            background-size:.87rem .39rem;
            opacity: 0.92;
            font-size: .12rem;
            color: #000000;
            letter-spacing: .5px;
        }
        .coupon{
            width:3.51rem;
            height:1.08rem;
            background: url(../../images/v3/blamk@2x.png) no-repeat;
            -webkit-background-size:3.51rem 1.08rem;
            background-size:3.51rem 1.08rem;
            margin: 0 auto;
            padding:.02rem .04rem;
        }
        .coupon .left{
            float: left;
            width:.95rem;
            height:1rem;
            /*background: pink;*/
            /*opacity:.5;*/
            color: #fff;
            display: flex;
            flex-direction:  column;
            justify-content: center;
            align-content: center;
        }
        .coupon .left p{
            font-size: .14rem;
            text-align: center;font-weight: bold;
        }
        .coupon .left p span{
            font-size: .30rem;
            padding-right: .04rem;
        }
        .coupon .left>span{
            font-size: .11rem;
            text-align: center;
            margin-bottom: .05rem;
        }
        .coupon .center{
            float: left;
            width:1.68rem;
            height:.79rem;
            /*background: green;*/
            /*opacity:.5;*/
            padding:.21rem 0 0 .21rem;
        }
        .coupon .center>span{
            font-size: .15rem;
            color: #000000;
            letter-spacing: 0.5px;
            line-height: .21rem;
            font-weight: bold;

        }
        .coupon .center>p{
            font-size: .12rem;
            color: #777777;
            letter-spacing: 0.5px;
            line-height: .17rem;
            margin-top: .02rem;
        }
        .coupon .right{
            float: left;
            width:.59rem;
            height:1rem;
            /*background: red;*/
            /*opacity:.5;*/
            display: flex;
            flex-direction:  column;
            justify-content: center;
            align-content: center;
        }
        .coupon .right img{
            width:.12rem;
            height:.42rem;
            display: block;
            margin: 0 auto;
        }
        .btn_go{
            position: absolute;
            bottom: .91rem;
            left:.16rem;
            width:3.43rem;
            height:.53rem;
            line-height:.53rem;
            background: #199301;
            border-radius: 4px;
            color: #fff;
            text-align: center;
            font-size: .15rem;
            letter-spacing: 0.58px;
        }
    </style>
</head>
<body>
<#--webview内嵌的优惠券页面-->
<div>
    <div class="header">
        <p class="title">注册成功</p>
        <p>新用户礼券已放进—我的—优惠券</p>
        <span onclick="goCoupon();">查看优惠券</span>
    </div>
    <div class="coupon">
        <div class="left">
            <p>￥<span>200</span></p>
            <span>满200.01元可用</span>
        </div>
        <div class="center">
            <span>注册优惠券</span>
            <p>仅限小康云雾红茶系列使用<p/>
            <p>有效期至2018.3.3</p>
        </div>
        <div class="right"><img src="../../images/v3/get@2x.png"></div>
    </div>
    <div class="btn_go" onclick="goBuy();">去使用</div>
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
    <!--无参无返回值-->
    var ua = navigator.userAgent.toLowerCase();
    //    document.getElementsByClassName("title")[0].innerHTML=ua;
    function goCoupon(){
        if(ua == "960"){
            window.webkit.messageHandlers.goCoupon.postMessage({name: 'goCoupon'});
        }else if(ua == "960android"){
            window.android.jumpActivity('goCoupon');
        }else{
            window.location.href = "${basePath}/customer/coupon.html?type=1";
        }
    }
    function goBuy(){
        if(ua == "960"){
            window.webkit.messageHandlers.goCoupon.postMessage({name: 'goBuy'});
        }else if(ua == "960android"){
            window.android.jumpActivity('goBuy');
        }else{
            window.location.href = "${basePath}/initMain.htm";
        }
    }
</script>
</body>
</html>