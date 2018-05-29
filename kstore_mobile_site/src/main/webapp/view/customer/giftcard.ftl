<#assign basePath=request.contextPath>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>会员中心 - 礼品卡</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link href="${basePath}/css/ui-dialog.css" rel="stylesheet">
    <link href="${basePath}/css/v2/giftcard.css" rel="stylesheet">
    <script  src="${basePath}/js/jquery.js"></script>
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
<input type="hidden" id="basePath" value="${basePath}">
<#assign vtitle="礼品卡" />
<#assign backUrl="${basePath}/customercenter.html" />
<#include "../common/head_back.ftl"/>
<div class="gifttitle">
    <div class="giftdetail">账户余额 ( 元 )</div>
    <#--<p class="giftinfo">您尚未绑定礼品卡</p>-->
        <#if deposit?? && deposit.giftcardNo??>
        <p class="giftprice timer count-title" id="count-number">
            ${(deposit.preDeposit+deposit.freezePreDeposit)?string('0.00')}
        </p>

            <span class="explain" onclick="location.href='/intoPage.htm?pageName=customer/giftcard_protocol'">
                    礼品卡说明
            </span>

        <#else>
            <p class="giftinfo">
                您尚未绑定礼品卡
                <#--<img onclick="location.href='/intoPage.htm?pageName=customer/giftcard_protocol'" src="/images/v2/wenhao@2x.png" style="height: .35rem;margin-left: .2rem;margin-bottom: 0.05rem;">-->


            </p>
            <span class="explain" onclick="location.href='/intoPage.htm?pageName=customer/giftcard_protocol'">
                    礼品卡说明
                </span>
        </#if>
    <ul>
        <li>
            <p>可用余额</p>
            <span>
                <#if deposit?? && deposit.giftcardNo??>
                    ${deposit.preDeposit?string('0.00')}
                <#else>
                    0.00
                </#if>
            </span>
        </li>
        <li>
            <p>冻结额度</p>
            <span>
                <#if deposit?? && deposit.giftcardNo??>
                    ${deposit.freezePreDeposit?string('0.00')}
                <#else>
                    0.00
                </#if>
            </span>
        </li>
    </ul>
</div>
<#if deposit?? && deposit.giftcardNo??>

<#assign dateTime="" />
<div style="height: 50px; margin-top: 3.46rem;"></div>
<div class="dealdetail">
    <#if pb??&&(pb.list?size!=0)>
        <#list pb.list as trade>

            <#if trade.createTime?string("yyyy年MM月") != dateTime>
                <#assign dateTime=trade.createTime?string("yyyy年MM月")  />
                <#--<div >${dateTime}</div>-->
                <div class="dealtitle">${trade.createTime?string("yyyy年MM月")}</div>
            </#if>

        <div class="liinfo">

            <div class="gtitle">
                <!-- 判断订单类型 -->
                <#if trade.orderType=='0'>
                    在线充值
                <#elseif trade.orderType=='1'>
                    订单退款
                <#elseif trade.orderType=='2'>
                    线下提现
                <#elseif trade.orderType=='3'>
                    订单消费
                <#elseif trade.orderType=='4'>
                    线下现金充值
                <#elseif trade.orderType=='5'>
                    线下刷卡充值
                <#elseif trade.orderType=='6'>
                    线下支付宝充值
                <#elseif trade.orderType=='7'>
                    线下微信充值
                <#elseif trade.orderType=='8'>
                    转卡工本费
                <#else>
                    线下充值
                </#if>
            </div>

            <#if trade.orderType=='0' || trade.orderType=='1' || trade.orderType=='4' || trade.orderType=='5' || trade.orderType=='6' || trade.orderType=='7'>
                <div class="gprice positive">
                    +￥${trade.orderPrice?string('0.00')}
                </div>
            <#elseif trade.orderType=='2' || trade.orderType=='3' || trade.orderType=='8'>
                <div class="gprice">
                    -￥${trade.orderPrice?string('0.00')}
                </div>
            </#if>

            <div class="gtime">
                ${trade.createTime?string("yyyy-MM-dd HH:mm")}
            </div>
            <div class="gstatus">
                <!-- 0【提现】待审核 1【提现】已打回 2【提现】已通过待打款 3【提现】已打款待确认 4【提现】已完成 5充值中 6充值成功 7充值失败 8已取消-->
                <#if trade.orderStatus??&&trade.orderStatus=='0'>
                    待审核
                <#elseif trade.orderStatus??&&trade.orderStatus=='1'>
                    已打回
                <#elseif trade.orderStatus??&&trade.orderStatus=='2'>
                    已通过
                <#elseif trade.orderStatus??&&trade.orderStatus=='3'>
                    待确认
                <#elseif trade.orderStatus??&&trade.orderStatus=='4'>
                    已完成
                <#elseif trade.orderStatus??&&trade.orderStatus=='5'>
                    <!--充值中 状态修改-->
                    未支付
                <#elseif trade.orderStatus??&&trade.orderStatus=='6'>
                    <#if trade.orderCode?index_of("G")!=-1><#--第一次礼品卡绑定提示不同-->
                        绑定成功
                    <#else>
                        充值成功
                    </#if>
                <#elseif trade.orderStatus??&&trade.orderStatus=='7'>
                    <!-- 充值失败 状态修改-->
                <#elseif trade.orderStatus??&&trade.orderStatus=='8'>
                    已取消
                <#else>
                    已完成
                </#if>
            </div>
        </div>
        </#list>
    </#if>
</div>
<#else>
<div style="height: 50px; margin-top: 3.46rem;"></div>
<div style="margin: 1.6rem auto .6rem;width: 1.9rem;height: 2.78rem;">
    <img src="../../images/v3/famal@2x.png" style="width: 1.9rem;height: 2.78rem;">
</div>
<p style="text-align:  center;font-size: .24rem;color: #7F7F7F;letter-spacing: 0.5px;">暂无记录</p>
</#if>
<script src="${basePath}/js/v2/giftcard.js"></script>
</body>
</html>