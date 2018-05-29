<!DOCTYPE html>
<html>
<head lang="zh-cn">
<#assign basePath=request.contextPath>
    <meta charset="UTF-8">
    <title>支付成功</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <link rel="stylesheet" href="${basePath}/css/style.min.css">
    <script src="${basePath}/js/jquery-1.10.1.js"></script>
    <style>
        body{font-family:微软雅黑,Microsoft yahei;}
        /*body, html,.success_info {*/
        /*background: #eee;*/
        /*}*/
        /*.success_info {*/
        /*padding: 142px 0 0 0;*/
        /*}*/
        /*.success_info .success_icon {*/
        /*margin: 0 auto;*/
        /*}*/
        /*.success_info p{*/
        /*text-align: center;*/
        /*font-size: 14px;*/
        /*}*/
        /*.success_info p:nth-of-type(1){*/
        /*color: #333;*/
        /*margin-top: 30px;*/
        /*}*/
        /*.success_info p:nth-of-type(2) a{*/
        /*border:1px solid #199301;*/
        /*width:181px;*/
        /*height:29px;*/
        /*line-height:28px;*/
        /*background: #eee;*/
        /*display: block;*/
        /*margin: 0 auto;*/
        /*border-radius: 30px;*/
        /*color: #199301;*/
        /*text-decoration: none;*/
        /*margin-bottom: 30px;*/
        /*margin-top: 50px;*/
        /*}*/
        /*.success_info p:nth-of-type(3) a{*/
        /*border:none;*/
        /*width:181px;*/
        /*height:31px;*/
        /*line-height:31px;*/
        /*!*background: #199301;*!*/
        /*display: block;*/
        /*margin: 0 auto;*/
        /*border-radius: 30px;*/
        /*color: #fff;*/
        /*text-decoration: none;*/
        /*filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#0ead00',endColorstr='#0d9901',GradientType='1');*/
        /*background:-webkit-linear-gradient(left,#0ead00,#0d9901);*/
        /*background: -o-linear-gradient(left,#0ead00,#0d9901);*/
        /*background: -moz-linear-gradient(left,#0ead00,#0d9901);*/
        /*background: linear-gradient(left,#0ead00,#0d9901);*/
        /*}*/
        .container{
            width:7.5rem;
            height:13.34rem;
            background:url(../../images/v3/bg_success@2x.png) no-repeat left center;
            background-size:7.5rem 13.34rem;
            padding-top: 1.8rem;
        }
        .container .title{
            height: .72rem;
            line-height: .72rem;
            width: 2.46rem;
            text-align: center;
            background: url(../../images/v3/icon_success@2x.png) no-repeat left center;
            background-size: .72rem .72rem;
            font-size: .36rem;
            color: #2AB50A;
            letter-spacing: 0.6px;
            margin: 0 auto;
            padding-left: .86rem;
        }
        .container .info{
            font-size: .28rem;
            color: #000000;
            letter-spacing: 2px;
            padding-top: .48rem;
            padding-bottom: 1.66rem;
            width:5rem;
            text-align: center;
            margin:0 auto;
        }
        .container .price{
            height:1.36rem;
            line-height:1.36rem;
            width:6.08rem;
            text-align: center;
            background: #F8F8F8;
            border-radius: 8px;
            margin:0 auto;
            padding:0 .5rem 0 .5rem;
        }
        .container .price p{
            float: left;
            display:inline-block ;
            font-size: .28rem;
            color: #000000;
            letter-spacing: 0.54px;
        }
        .container .price span{
            float: right;
            display:inline-block ;
            font-size: .28rem;
            color: #2AB50A;
            letter-spacing: 0.35px;
        }
        .container .price span b{
            font-size: .4rem;
        }
        .container ul{
            width:6.68rem;
            margin:0 auto;
        }
        .container ul li{
            float: left;
            width:50%;
            text-align: center;
            vertical-align: bottom;
        }
        .container ul li:first-of-type{
            background:url(../../images/v3/Line@2x.png) no-repeat right center;
            background-size:.02rem .8rem;
        }
        .container ul li a{
            font-size: .3rem;
            color: #000000;
            letter-spacing: 0.5px;
        }
    </style>
</head>
<body>
<script type="text/javascript">
    $(function(){
        //礼品卡支付成功，异步更新订单状态到ERP
        $.ajax({
            url:"/synUpdateOrderToERP.htm",
            dataType:"json",
            type:"post",
            data:{"orderId":${orderId}},
            async:false
        })
    });
</script>
<div class="container">
    <div class="title">支付成功</div>
    <div class="info">我们将尽快为您安排发货</div>
    <div class="price">
    <#--<p>订单金额</p><span>￥<b>13</b>.00</span>-->

        <p>订单金额</p>
    <#if (payPrice)??>
        <span>￥<b>${(payPrice?string('0.00'))?split(".")[0]}</b>.${(payPrice?string('0.00'))?split(".")[1]}</span>
    </#if>


    </div>
    <div style="height: 2.28rem;width: 100%; "></div>
    <ul>
        <li><a href="${basePath}/customer/detail-${(orderId)!""}.html">查看订单</a></li>
        <li><a href="${basePath}/">返回首页</a></li>
    </ul>

<#--<div class="success_info">-->
<#--<div class="success_icon"></div>-->
<#--<p>恭喜您，您的订单已经支付成功！</p>-->
<#--<p><a href="${basePath}/customer/detail-${(orderId)!""}.html">查看订单</a></p>-->
<#--<p><a href="${basePath}/">继续购物</a></p>-->
<#--</div>-->

<#--<div class="relate_orders">-->
<#--<#list orderList as order>-->
<#--<div class="relate_order">-->
<#--<h4>订单号：${order.orderCode!''}</h4>-->
<#--<#list order.orderGoodsList as goods>-->
<#--<div class="good">-->
<#--<a href="#">-->
<#--<img class="img" alt="" src="${goods.goodsImg}">-->
<#--<p class="name">${goods.goodsInfoName}</p>-->
<#--</a>-->
<#--</div>-->
<#--</#list>-->
<#--</div>-->
<#--</#list>-->

<#--&lt;#&ndash;<div class="relate_order">&ndash;&gt;-->
<#--&lt;#&ndash;<h4>订单号：T2015090812349078</h4>&ndash;&gt;-->
<#--&lt;#&ndash;<div class="good">&ndash;&gt;-->
<#--&lt;#&ndash;<a href="#">&ndash;&gt;-->
<#--&lt;#&ndash;<img class="img" alt="" src="images/good_img.jpg">&ndash;&gt;-->
<#--&lt;#&ndash;<p class="name">米莱珠宝0.7克拉红宝石戒指18K金镶嵌10分……</p>&ndash;&gt;-->
<#--&lt;#&ndash;</a>&ndash;&gt;-->
<#--&lt;#&ndash;</div>&ndash;&gt;-->
<#--&lt;#&ndash;</div>&ndash;&gt;-->
<#--<div class="pay_total">-->
<#--<p>实付款：￥120.00</p>-->
<#--</div>-->
<#--</div>-->

</div>
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
                        docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
                    }
                };
        if (!doc.addEventListener) return;
        win.addEventListener(resizeEvt, recalc, false);
        doc.addEventListener('DOMContentLoaded', recalc, false);
    })(document, window);
</script>

</body>
</html>