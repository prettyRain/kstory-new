<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>会员中心</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta content="telephone=no" name="format-detection">
    <#assign basePath=request.contextPath>
    <link rel="stylesheet" href="${basePath}/css/style.min.css"/>
    <#--<link rel="stylesheet" href="${basePath}/css/add-ons.min.css"/>-->
    <script type="text/javascript" src="${basePath}/js/jquery-1.10.1.js"></script>
    <script type="text/javascript" src="${basePath}/js/idangerous.swiper.js"></script>
    <script type="text/javascript" src="${basePath}/js/appfont.js"></script>
    <script src="${basePath}/js/wechatauth.js"></script>
    <#--<link rel="stylesheet" href="${basePath}/css/v1/main-mend.css"/>-->
    <#--<link rel="stylesheet" href="${basePath}/css/v1/my_page.css"/>-->
    <link rel="stylesheet" href="${basePath}/css/tip-newbox.css">
    <link rel="stylesheet" href="${basePath}/css/v3/head_animate_v3.css">
    <link rel="stylesheet" href="${basePath}/css/v3/swiper.css">

    <link rel="stylesheet" href="${basePath}/css/v2/my_main.css">
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
<input type="hidden" id="wxcode" value="${sessionOpedId!''}">
<input type="hidden" class="ch_distinctId" value="${distinctId}" />

<div class="top-nav">
${cust.customerNickname!''}
    <span>
        <img src="<#if cust.customerImg?? && cust.customerImg!=''>${cust.customerImg}<#else>${basePath}/images/v1/myimages/head_small@2x.png</#if>">
    </span>
</div>
<a class="setting" href="${basePath}/intoPage.htm?pageName=member/mysetting" onclick="_czc.push(['_trackEvent', '我的', '点击', '设置','0','main_setting']);">
    <img style="opacity: 1;" src="/images/v3/btn_setting_white@2x.png" alt=""/>
    <img style="opacity: 0;" src="/images/v3/btn_setting_black@2x.png" alt=""/>
</a>



<div class="homepage">
    <header class="header" id="header"></header>
    <div class="user-logo-wrapper" id="user-logo-wrapper">
        <div class="user-logo">
            <img id="userLogo" src="<#if cust.customerImg?? && cust.customerImg!=''>${cust.customerImg}<#else>${basePath}/images/v1/myimages/my-logo1.png</#if>">
        </div>
    </div>



<section id="wrapper">
    <div id="scroller" style="padding-top: 202px; transform: translate(0px, 0px) translateZ(0px);">

        <div class="personal-details">
            <p>${cust.customerNickname!''}</p>
            <a href="${basePath}/myaccount.html?main=1" class="details-more" onclick="_czc.push(['_trackEvent', '我的', '点击', '编辑资料','0','main_info']);">点击编辑资料</a>
        </div>
        <#--优惠券、我的积分、礼品卡-->
        <div class="message config">
            <div>
                <a href="${basePath}/customer/coupon.html?type=1" onclick="_czc.push(['_trackEvent', '我的', '点击', '优惠券','0','main_couponCount']);">
                    <span>${couponCount}</span>优惠券
                </a>
            </div>
            <div>
                <a href="${basePath}/customer/myintegral.html" onclick="_czc.push(['_trackEvent', '我的', '点击', '我的积分','0','main_point']);">
                    <span>${point}</span>我的积分
                </a>
            </div>
            <div>
                <a href="${basePath}/customer/mygiftcard.htm" onclick="_czc.push(['_trackEvent', '我的', '点击', '礼品卡','0','main_giftcard']);">
                    <span style="font-size: 10px;">
                    <#if (depositInfo.giftcardNo?? && depositInfo.giftcardNo != '')>
                        &yen;&nbsp;<span>${depositInfo.preDeposit?string('0.00')?split(".")[0]}</span>.${depositInfo.preDeposit?string('0.00')?split(".")[1]}
                        <#--&yen;&nbsp;${depositInfo.preDeposit}-->
                    <#else>
                        &yen;&nbsp;<span>0</span>.00
                    </#if>
                    </span>礼品卡
                </a>
            </div>
        </div>
        <#--各种会员-->
        <div class="my-hydj">
            <#--<img src="../../images/v3/bronzeCard@2x.png"><span>银卡会员</span>-->
            <#if cust.pointLevelName == '注册会员'>
                <img class="my-dj" src="${basePath}/images/v3/bronzeCard@2x.png"/>
                <span>注册会员</span>
            <#elseif cust.pointLevelName == '银卡会员'>
                <img class="my-dj" src="${basePath}/images/v3/silverCard@2x.png"/>
                <span>银卡会员</span>
            <#elseif cust.pointLevelName == '金卡会员'>
                <img class="my-dj" src="${basePath}/images/v3/goldCard@2x.png"/>
                <span>金卡会员</span>
            <#elseif cust.pointLevelName == '钻卡会员'>
                <img class="my-dj" src="${basePath}/images/v3/diamondCard@2x.png"/>
                <span>钻卡会员</span>
            </#if>
        </div>


        <div class="order_area member_box member_boxx">
            <#--我的订单-->
            <div class="my-order">
                <div>我的订单</div>
                <a class="more-order" href="${basePath}/customer/myorder.html">查看全部订单</a>
            </div>
            <div class="top row">
                <div class="col-6"  >
                    <a href="${basePath}/customer/myorder-1-1.html" onclick="_czc.push(['_trackEvent', '我的', '点击', '待付款','0','main_dfk']);">
                        <p class="order_state_1">
                            <i class="icon">
                                <img src="images/v2/my-1.png" alt=""/>
                                <span>待付款</span>
                            <#if noMoneyCount?? && noMoneyCount != 0>
                                <span class="badge bg-red">${noMoneyCount!''}</span>
                            </#if>
                            </i>
                        </p>
                    </a>
                </div>
                <div class="col-6">
                    <a href="${basePath}/customer/myorder-2-1.html" onclick="_czc.push(['_trackEvent', '我的', '点击', '待发货','0','main_dfh']);">
                        <p class="order_state_1">
                            <i class="icon">
                                <img src="images/v2/my-2.png" alt=""/>
                                <span>待发货</span>
                            <#if noFaHuoCount?? && noFaHuoCount != 0>
                                <span class="badge bg-red">${noFaHuoCount!''}</span>
                            </#if>
                            </i>
                        </p>
                    </a>
                </div>
                <div class="col-6">
                    <a href="${basePath}/customer/myorder-3-1.html" onclick="_czc.push(['_trackEvent', '我的', '点击', '待收货','0','main_dsh']);">
                        <p class="order_state_1">
                            <i class="icon">
                                <img src="images/v2/my-3.png" alt=""/>
                                <span>待收货</span>
                            <#if noShowHuoCount?? && noShowHuoCount != 0>
                                <span class="badge bg-red">${noShowHuoCount!''}</span>
                            </#if>
                            </i>
                        </p>
                    </a>
                </div>
                <div class="col-6">
                    <a href="${basePath}/customer/myorder-4-1.html" onclick="_czc.push(['_trackEvent', '我的', '点击', '待评价','0','main_dpj']);">
                        <p class="order_state_1">
                            <i class="icon">
                                <img src="images/v2/my-4.png" alt=""/>
                                <span>待评价</span>
                            <#if noCommentCount?? && noCommentCount != 0>
                                <span class="badge bg-red">${noCommentCount!''}</span>
                            </#if>
                            </i>
                        </p>
                    </a>
                </div>
                <div class="col-6">
                    <a href="${basePath}/customer/myorder-6-1.html" onclick="_czc.push(['_trackEvent', '我的', '点击', '退款售后','0','main_tksh']);">
                        <p class="order_state_1">
                            <i class="icon">
                                <img src="images/v2/my-5.png" alt=""/>
                                <span>退款/售后</span>
                            <#if cancelCount?? && cancelCount != 0>
                                <#if cancelCount <= 99>
                                    <span class="badge bg-red" style="left:85%;">${cancelCount!''}</span>
                                <#else>
                                    <span class="badge bg-red" style="left:85%;">99+</span>
                                </#if>
                            </#if>
                            </i>
                        </p>
                    </a>
                </div>
            </div>
            <#--礼品卡-->
            <div class="my-order">
                <div>礼品卡</div>
                <a class="more-order" href="${basePath}/list/6331.html" onclick="_czc.push(['_trackEvent', '我的', '点击', '买礼品卡','0','main_buygiftcard']);">快来选购</a>
            </div>
            <div class="giftcard">
                <div class="warpimg"><img src="../../images/v3/card2@2x.png" /></div>
                <div class="price">
                    <#--<p>账户余额</p><b>￥<span>1000</span>.00</b>-->
                    <p>账户余额:</p>
                    <b>
                    <#if (depositInfo.giftcardNo?? && depositInfo.giftcardNo != '')>
                        &yen;&nbsp;<span>${depositInfo.preDeposit?string('0.00')?split(".")[0]}</span>.${depositInfo.preDeposit?string('0.00')?split(".")[1]}
                    <#else>
                        &yen;&nbsp;<span>0</span>.00
                    </#if>
                    </b>
                </div>
                <a href="${basePath}/customer/mygiftcard.htm" onclick="_czc.push(['_trackEvent', '我的', '点击', '礼品卡','0','main_giftcard']);">查看</a>
            </div>
            <#--其他服务-->
            <div class="my-order">
                <div>其他服务</div>
            </div>
            <div>
                <div class="col-61">
                    <a href="${basePath}/customer/mycollections.html" onclick="_czc.push(['_trackEvent', '我的', '点击', '我的收藏','0','main_collect']);">
                        <p class="order_state_2">
                            <i class="icon">
                                <img src="images/v2/my-7.png" alt=""/>
                                <span>我的收藏</span>
                            </i>
                        </p>
                    </a>
                </div>
                <div class="col-61 ">
                    <a href="${basePath}/customer/mybrowerecord.html" onclick="_czc.push(['_trackEvent', '我的', '点击', '足迹','0','main_collect']);">
                        <p class="order_state_1">
                            <i class="icon">
                                <img src="images/v2/my-6.png" alt=""/>
                                <span>足迹</span>
                            </i>
                        </p>
                    </a>
                </div>
                <div class="col-61">
                    <a href="${basePath}/customers/notice.htm?mark=1" onclick="_czc.push(['_trackEvent', '我的', '点击', '我的消息','0','main_message']);">
                        <p class="order_state_4">
                            <i class="icon" style="position: relative">
                                <img src="images/v2/my-9.png" alt=""/>
                                <#--<b>${noticeCount}</b>-->
                            <#if (noticeCount > 0)>
                                <b>${noticeCount}条未读&nbsp;&nbsp;</b>
                            </#if>
                                <span>我的消息</span>
                            </i>
                        </p>
                    </a>
                </div>
                <div class="col-61 ">
                    <a href="${basePath}/addresslist.html?mainAddress=1" onclick="_czc.push(['_trackEvent', '我的', '点击', '地址','0','main_address']);">
                        <p class="order_state_1">
                            <i class="icon">
                                <img src="images/v2/my-10.png" alt=""/>
                                <span>地址</span>
                            </i>
                        </p>
                    </a>
                </div>



            </div>

            <#--猜你喜欢-->
            <div class="my-order">
                <div>猜你喜欢</div>
            </div>
            <div class="like_goods">
                <div class="swiper-container">
                    <div class="swiper-wrapper">
                    <#if guessLikes??>
                        <#list guessLikes as like>
                            <div class="swiper-slide">
                                <a href="${basePath}/item/${like.goodsInfoId}.html">
                                    <div class="goodsImg"><img alt="" src="${like.goodsInfoImgId!''}"></div>
                                </a>
                                <div class="goodsInfo">
                                    <a href="${basePath}/item/${like.goodsInfoId}.html"> <h3>${like.goodsInfoName!''}</h3>
                                    </a>  <div class="price">￥<span>${like.goodsInfoPreferPrice?string("0.00")?substring(0,like.goodsInfoPreferPrice?string("0.00")?index_of("."))}</span>${like.goodsInfoPreferPrice?string("0.00")?substring(like.goodsInfoPreferPrice?string("0.00")?index_of("."))}</div>
                                        <p onclick="addShoppingCart(this,${like.goodsInfoId})">加购物车</p>
                                    </div>

                            </div>
                        </#list>
                    </#if>
                    </div>
                </div>
            </div>
            <#--<div class="slide_goods">-->
                <#--<div class="swiper-container">-->
                    <#--<div class="swiper-wrapper">-->
                        <#--<#if guessLikes??>-->
                            <#--<#list guessLikes as like>-->
                                <#--<div class="swiper-slide">-->
                                    <#--<div class="like_good">-->
                                        <#--<a href="${basePath}/item/${like.goodsInfoId}.html">-->
                                            <#--<div class="img"><img alt="" src="${like.goodsInfoImgId!''}"></div>-->
                                            <#--<p class="name">${like.goodsInfoName!''}</p>-->
                                            <#--<p class="price">￥${like.goodsInfoPreferPrice?string("0.00")?substring(0,like.goodsInfoPreferPrice?string("0.00")?index_of("."))}<span>${like.goodsInfoPreferPrice?string("0.00")?substring(like.goodsInfoPreferPrice?string("0.00")?index_of("."))}</span></p>-->
                                        <#--</a>-->
                                    <#--</div>-->
                                <#--</div>-->
                            <#--</#list>-->
                        <#--</#if>-->
                    <#--</div>-->
                <#--</div>-->
            <#--</div>-->








        <div class="content-home" style="padding-top:0px;padding-bottom: 0px;">
            <div class="member_brief member_box">
                <div class="cover" style="display:none">

                    <img class="myindex-top-bg" src="${basePath}/images/v1/myimages/background.png" alt=""/>
                    <a href="${basePath}/myaccount.html">
                        <div class="avatar">
                            <div class="bg"></div>
                            <img class="img" alt="" src="<#if cust.customerImg?? && cust.customerImg!=''>${cust.customerImg}<#else>${basePath}/images/v1/myimages/my-logo.jpg</#if>">
                            <h2>${cust.customerNickname!''}
                            <#if cust.pointLevelName == '注册会员'>
                                <img class="my-dj" src="${basePath}/images/v1/myimages/my_dj1.png"/>
                            <#elseif cust.pointLevelName == '银卡会员'>
                                <img class="my-dj" src="${basePath}/images/v1/myimages/my_dj2.png"/>
                            <#elseif cust.pointLevelName == '金卡会员'>
                                <img class="my-dj" src="${basePath}/images/v1/myimages/my_dj3.png"/>
                            <#elseif cust.pointLevelName == '钻卡会员'>
                                <img class="my-dj" src="${basePath}/images/v1/myimages/my_dj4.png"/>
                            </#if>
                            </h2>
                        </div>
                    </a>
                    <a href="${basePath}/accountsafe.html">
                        <div class="mod-safe">
                            账户安全：<div class="n_per_bar"><span style="width:<#if  cust.isEmail == '0' &&  cust.isMobile == '0'>33%<#elseif (cust.isEmail == '1' &&  cust.isMobile == '0') || (cust.isEmail == '0' &&  cust.isMobile == '1')>66%<#elseif cust.isEmail == '1' &&  cust.isMobile == '1'>100%</#if> "></span></div><span style="color: #ffffff;font-size: .26rem;margin-left: 10px;" ><#if  cust.isEmail == '0' &&  cust.isMobile == '0'>低<#elseif (cust.isEmail == '1' &&  cust.isMobile == '0') || (cust.isEmail == '0' &&  cust.isMobile == '1')>中<#elseif cust.isEmail == '1' &&  cust.isMobile == '1'>高</#if></span>
                        </div>
                    </a>
                    <a class="setting" href="${basePath}/intoPage.htm?pageName=member/mysetting"><img src="/images/v1/myimages/setting.png" alt=""/></a>

                    <div class="message config">

                        <div>
                        <#--浏览记录原始的-->
                        <#--  <a href="${basePath}/customer/mybrowerecord.html">
                              <span>${browereCount!'0'}</span>浏览记录 </a>-->
                            <a href="${basePath}/customer/mygiftcard.htm">
                            <span>
                            <#if (depositInfo.giftcardNo?? && depositInfo.giftcardNo != '')>
                                &yen;&nbsp;${depositInfo.preDeposit}
                            <#else>
                                --
                            </#if>
                                </span>礼品卡 </a>
                        </div>
                        <div>
                        <#--新增的，模拟上方写法-->
                            <a href="${basePath}/customer/myintegral.html">
                                <span>${point}</span>我的积分 </a>
                        </div>
                        <div style=" border-right:1px solid rgba(255,255,255,0.8);">
                        <#--我的收藏原始的-->
                        <#--   <a href="${basePath}/customer/mycollections.html">
                               <span style="display: block;">${(mycollectcount)!'0'}</span>我的收藏 </a>-->
                            <a href="${basePath}/customer/coupon.html?type=1">
                                <span style="display: block;">${couponCount}</span>优惠券</a>
                        </div>

                    </div>

                </div>
            </div>

            <#--<div class="order_area member_box">
                    <div class="common_line row">
                  <div class="item-content">
                      <a href="#" ><h4>我的资产</h4></a>
                  </div>
            </div>-->
                <div style="display: none; border-top: 1px solid #eeeeee; width: 95%;height: 1px;background: #eeeeee; margin: 0px 10px 0px 10px;"></div>
                <div class="top row" style="display: none;padding:  0 0rem  0.25rem 0; border-bottom-right-radius: 5px;border-bottom-left-radius: 5px;">
                    <div class="col-61" style="border-left: none;">
                        <a href="${basePath}/customer/myorder-6-1.html">
                            <p class="order_state_1">
                                <i class="icon">
                                    <img src="images/v2/my-5.png" alt=""/>
                                    <span>退款/售后</span>
                                <#if cancelCount?? && cancelCount != 0>
                                    <span class="badge bg-red" style="left:85%;">${cancelCount!''}</span>
                                </#if>
                                </i>
                            </p>
                        </a>
                    </div>
                    <div class="col-61">
                        <a href="${basePath}/customers/notice.htm?mark=1">
                            <p class="order_state_4">
                                <i class="icon" style="position: relative">
                                    <img src="images/v2/my-9.png" alt=""/>
                                <#if (noticeCount > 0)>
                                    <b></b>
                                </#if>
                                    <span>我的消息</span>
                                </i>
                            </p>
                        </a>
                    </div>
                    <div class="col-61">
                        <a href="${basePath}/customer/mycollections.html">
                            <p class="order_state_2">
                                <i class="icon">
                                    <img src="images/v2/my-7.png" alt=""/>
                                    <span>我的收藏</span>
                                </i>
                            </p>
                        </a>
                    </div>
                    <div class="col-61 ">
                        <a href="${basePath}/customer/mybrowerecord.html">
                            <p class="order_state_1">
                                <i class="icon">
                                    <img src="images/v2/my-6.png" alt=""/>
                                    <span>浏览记录</span>
                                </i>
                            </p>
                        </a>
                    </div>
                    <#--  <div class="col-61">
                        &lt;#&ndash;<a href="${basePath}/intoPage.htm?pageName=customer/functiondeveloping">&ndash;&gt;
                        <a href="${basePath}/customer/coupon.html?type=1">
                            <p class="order_state_3">
                                <i class="icon">
                                    <img src="images/v2/my-8.png" alt=""/>
                                    <span>我的卡券</span>
                                </i>
                            </p>

                        </a>
                    </div>-->
                    </a>
                </div>
            </div>
            <div class="member_box" style="display: none">
                <div class="common_line row">
                    <div class="item-content" style="border-bottom:none;">
                        <a href="javascript:;">
                            <h4>猜你喜欢</h4>
                        </a>
                    </div>
                </div>
                <div class="slide_goods">
                    <div class="swiper-container" style="padding-top: 5px;">
                        <div class="swiper-wrapper">
                        <#if guessLikes??>
                            <#list guessLikes as like>
                                <div class="swiper-slide">
                                    <div class="like_good">
                                        <a href="${basePath}/item/${like.goodsInfoId}.html">
                                            <div class="img">
                                                <img alt="" src="${like.goodsInfoImgId!''}" height="110px;">
                                            </div>
                                        </a>
                                        <a href="${basePath}/item/${like.goodsInfoId}.html"><p class="name">${like.goodsInfoName!''}</p></a>
                                            <p class="price">
                                                ￥${like.goodsInfoPreferPrice?string("0.00")?substring(0,like.goodsInfoPreferPrice?string("0.00")?index_of("."))}<span>${like.goodsInfoPreferPrice?string("0.00")?substring(like.goodsInfoPreferPrice?string("0.00")?index_of("."))}</span>
                                            </p>
                                    </div>
                                </div>
                            </#list>
                        <#else>

                        </#if>
                        </div>
                    </div>
                </div>
            </div>
    </div>
</section>
</div>







<#--    </div>-->
<#--<#include '/common/smart_menu.ftl' />-->
<#include "../common/new_960menu_index.ftl"/>
<script src="${basePath}/js/tip-newbox.js"></script>
<script type="text/javascript" src="${basePath}/js/v2/transform.js"></script>
<script type="text/javascript" src="${basePath}/js/v2/alloy_touch.css.js"></script>
<script type="text/javascript" src="${basePath}/js/v3/head_animate_v3.js"></script>
<script type="text/javascript" src="${basePath}/js/v2/swiper.min.js"></script>

    <script>
        (function (doc, win) {
            var docEl = doc.documentElement,
                    resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
                    recalc = function () {
                        var clientWidth = docEl.clientWidth;
                        if (!clientWidth) return;
                        docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
                    };
            if (!doc.addEventListener) return;
            win.addEventListener(resizeEvt, recalc, false);
            doc.addEventListener('DOMContentLoaded', recalc, false);
        })(document, window);



        var mySwiper = new Swiper('.swiper-container',{
            //loop : true,
            loopedSlides :12,
            slidesPerView:"auto",
            spaceBetween: 10
        });
        $(".bar-bottom a").removeClass("selected");
        $(".bar-bottom a:eq(3)").addClass("selected");

        //加入购物车
        var tip = myAlertStr();
        function addShoppingCart(ele,goodsInfoId) {
            addCart(goodsInfoId,tip,ele);
        }
        function addCart(goodsInfoId,tip,ele) {
            $.ajax({
                url: "/addproducttoshopcarnew.htm?goodsNum=1&productId=" + goodsInfoId + "&distinctId="+ $(".ch_distinctId").val() +"&mark=0",
                type: "post",
                async:false,
                success: function (data) {
                    if (data > 0) {
                        tip("加入购物车成功");
                        return true;
                    }else if (data == -1) {
                        tip("购物车已达上限");
                        return false;
                    }else if(data == -5){
                        tip("库存不足");
                        return false;
                    } else if(data == -3){
                        tip("货品已下架");
                        return false;
                    }else {
                        tip("加入购物车失败");
                        return false;
                    }
                }
            });
        }



    </script>
<p style="display: none;">
    <!--友盟CNZZ统计-->
    <script src="https://s13.cnzz.com/z_stat.php?id=1264375679&web_id=1264375679" language="JavaScript">
        var _czc = _czc || [];
        _czc.push(["_setAccount", "m.ge960.com"]);
    </script>
</p>
</body>
</html>