<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
<#assign basePath=request.contextPath>
    <title>购物车</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
    <meta name="keywords" content="${seo.meteKey}">
    <meta name="description" content="${seo.meteDes}">

<#if (sys.bsetName)??>
    <title>购物车-${(sys.bsetName)!''}</title>
    <input type="hidden" id="bsetName" value="${(sys.bsetName)!''}">
    <input type="hidden" id="bsetDesc" value="${(sys.bsetDesc)!''}">
<#else>
    <title>购物车-${(seo.mete)!''}</title>
    <input type="hidden" id="bsetName" value="${(seo.mete)!''}">
    <input type="hidden" id="bsetDesc" value="${(sys.bsetDesc)!''}">
</#if>
    <link rel="stylesheet" href="${basePath}/css/style.min.css"/>
    <link rel="stylesheet" href="${basePath}/css/add-ons.min.css"/>
    <link rel="stylesheet" href="${basePath}/css/ui-dialog.css">
    <script src="${basePath}/js/jquery-1.10.1.js"></script>
    <script src="${basePath}/js/dialog-min.js"></script>
    <script src="${basePath}/js/idangerous.swiper.js"></script>
    <link rel="stylesheet" href="${basePath}/css/v2/cart.css">
    <link rel="stylesheet" href="${basePath}/css/tip-newbox.css">
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
<div class="content-cart">
    <div class="cart-head">
        <h1>购物车</h1>
   <#-- <#if customerId??>-->
        <#if shopMap.shoplist??&&shopMap.shoplist?size!=0>
            <a href="javascript:;" class="cart-edit" onclick="_czc.push(['_trackEvent', '购物车', '点击', '编辑','0','cart_edit']);">编辑</a>
        </#if>
    <#--</#if>-->
    </div>
    <input type="hidden" value="${customerId!''}" id="customerId">
    <input type="hidden" value="${basePath!''}" id="basePath">
    <input type="hidden" value="" id="myzongji">
    <input type="hidden" id="wxcode" value="${sessionOpedId!''}">

    <#if shopMap.shoplist??&&shopMap.shoplist?size!=0>
        <div class="select-part">
            <i class="select-box selected" onclick="checkAll()"></i>
            <label>960官方商城</label>
            <#--<span> - 北极</span>-->
        </div>
    </#if>

    <#--<div class="list-item notlogin">
        <h3><a class="btn" href="${basePath}/loginm.html?url=${basePath}/myshoppingmcart.html">登&nbsp;录</a>登录后可同步购物车里的商品哦~
        </h3>
    </div>-->


<#assign goodsNum=0/>
<#assign sumPrice=0/>
<#assign youhui=0/>
<#if shopMap.shoplist??&&shopMap.shoplist?size!=0>
    <div class="cart-list">
        <#if shopMap.marketinglist??&&shopMap.marketinglist?size!=0>
            <#list shopMap.marketinglist as mar>
                <#assign yhprice=0/>
                    <#assign onePrice=0/><!--参加同种促销商品总价格-->
                    <#assign zjPrice=0/><!--直降的优惠-->
                    <#assign marNum=0/><!--促销的商品个数-->
                    <#assign oneweight=0/><#--商品重量-->
                <#if shopMap.shoplist??&&shopMap.shoplist?size!=0>
                    <#list shopMap.shoplist as cars>
                        <#if cars.goodsDetailBean??>
                            <#if cars.marketingActivityId??&&cars.marketingActivityId!=0&&cars.marketingActivityId==mar.marketingId>
                                <#assign marNum=1>
                            </#if>
                        </#if>
                    </#list>
                </#if>
                    <#assign marNum2=1/><!--促销的商品个数-->
                 <#--同类促销下的商品种类个数-->
                 <div class="group-atxt">
                     <ul>
                         <#list shopMap.shoplist as shop>
                            <#if shop.goodsDetailBean??>
                                <#if shop.marketingActivityId??&&shop.marketingList?size!=0&&shop.marketingActivityId!=0>
                                    <#if shop.marketingActivityId==mar.marketingId>

                                    <li <#if marNum2==0> style="display:none;"</#if>>
                                        <ul class="fav-list c-discount" style="display:none;" attr-codextype="${mar.codexType}">
                                            <#if mar.codexType=='1'>
                                                <li>
                                                    <a href="#" class="change_discount">

                                                        <span class="fav gift">降</span>
                                                        <span>  直降${mar.priceOffMarketing.offValue}元;</span>
                                                        <input type="hidden" value="${mar.priceOffMarketing.offValue}"
                                                               class="zhijiang_offValue"/>
                                                    </a>
                                                </li>
                                            </#if>

                                            <#if mar.codexType=='11'>
                                                <li>
                                                    <a href="#" class="change_discount">

                                                        <span class="fav gift">抢</span>
                                                        <span>  ${10*mar.rushs[0].rushDiscount?number}折抢购</span>
                                                        <input type="hidden"
                                                               value="${((shop.goodsDetailBean.productVo.goodsInfoPreferPrice?number-(mar.rushs[0].rushDiscount?number*shop.goodsDetailBean.productVo.goodsInfoPreferPrice?number))?string("0.00"))!""}"
                                                               class="qianggou_offValue"/>
                                                    </a>
                                                </li>
                                            </#if>

                                            <#if mar.codexType=='5'>
                                                <li>
                                                    <a href="#" class="change_discount">

                                                        <span class="fav gift">减</span>
                                                        <#list mar.fullbuyReduceMarketings as fr>
                                                            <#if fr_index==0>
                                                                <span>  满 ${fr.fullPrice}减${fr.reducePrice}元 &nbsp;</span>
                                                                <input type="hidden" value="${fr.fullPrice},${fr.reducePrice}"
                                                                       class="manjian_reducePrice"/>
                                                            </#if>
                                                        </#list>
                                                    </a>
                                                </li>
                                                <#list mar.fullbuyReduceMarketings as fr>
                                                    <#if fr_index!=0>
                                                        <a href="#" class="change_discount">

                                                            <li>
                                                                <span> 满 ${fr.fullPrice}减${fr.reducePrice}元 &nbsp;</span>
                                                                <input type="hidden" value="${fr.fullPrice},${fr.reducePrice}"
                                                                       class="manjian_reducePrice"/>
                                                            </li>
                                                        </a>
                                                    </#if>
                                                </#list>
                                            </#if>
                                            <#if mar.codexType=='8'>
                                                <li>
                                                    <a href="#" class="change_discount">

                                                        <span class="fav gift">折</span>
                                                        <#list mar.fullbuyDiscountMarketings as mz>
                                                            <#if mz_index==0>
                                                                <span> 满 ${mz.fullPrice}打 ${mz.fullbuyDiscount*10}折 &nbsp;</span>
                                                                <input type="hidden"
                                                                       value="${mz.fullPrice},${mz.fullbuyDiscount}"
                                                                       class="manzhe_fullbuyDiscount"/>
                                                            </#if>
                                                        </#list>
                                                    </a>
                                                </li>
                                                <#list mar.fullbuyDiscountMarketings as mz>
                                                    <#if mz_index!=0>
                                                        <a href="#" class="change_discount">
                                                            <li>
                                                                <span> 满 ${mz.fullPrice}打 ${mz.fullbuyDiscount*10}折 &nbsp;</span>
                                                                <input type="hidden"
                                                                       value="${mz.fullPrice},${mz.fullbuyDiscount}"
                                                                       class="manzhe_fullbuyDiscount"/>
                                                            </li>
                                                        </a>
                                                    </#if>
                                                </#list>
                                            </#if>
                                            <#if mar.codexType=='6'>
                                                <li>
                                                    <a href="#" class="select_gift">

                                                        <span class="fav gift">满赠</span>
                                                        <#list mar.fullbuyPresentMarketings as fr>
                                                            <#if fr_index==0>
                                                                <#if fr.presentType == '0'>
                                                                    <span>  满 ${fr.fullPrice}元送赠品 &nbsp;</span>
                                                                <#elseif fr.presentType == '1'>
                                                                    <span>  满 ${fr.fullPrice?number}件送赠品 &nbsp;</span>
                                                                </#if>
                                                                <input type="hidden"
                                                                       value="${fr.fullPrice},${mar.marketingId},${fr.fullbuyPresentMarketingId},${fr.presentMode},${fr.presentType}"
                                                                       class="fullbuy_present"/>
                                                            </#if>
                                                        </#list>
                                                    </a>
                                                </li>
                                                <#list mar.fullbuyPresentMarketings as fr>
                                                    <#if fr_index!=0>
                                                        <a href="#" class="select_gift">

                                                            <li>
                                                                <#if fr.presentType == '0'>
                                                                    <span>  满 ${fr.fullPrice}元送赠品 &nbsp;</span>
                                                                <#elseif fr.presentType == '1'>
                                                                    <span>  满 ${fr.fullPrice?number}件送赠品 &nbsp;</span>
                                                                </#if>
                                                                <input type="hidden"
                                                                       value="${fr.fullPrice},${mar.marketingId},${fr.fullbuyPresentMarketingId},${fr.presentMode},${fr.presentType}"
                                                                       class="fullbuy_present"/>
                                                            </li>
                                                        </a>
                                                    </#if>
                                                </#list>
                                            </#if>
                                        </ul>
                                        <#if mar.codexType=='1'>
                                            <#assign zjPrice=zjPrice+mar.priceOffMarketing.offValue?number*shop.goodsNum?number/>
                                        </#if>
                                        <div class="list-item cart-pro-item">
                                            <div class="shademask"></div>
                                            <input type="hidden" class="goodInfoId"
                                                   value="${shop.goodsDetailBean.productVo.goodsInfoId}"/>
                                            <input type="hidden" class="shoppingCartId" value="${shop.shoppingCartId}"/>
                                            <input type="hidden" class="distinctId" value="${shop.distinctId!''}"/>
                                            <#if (shop.goodsDetailBean.productVo.goodsInfoStock?number-shop.goodsNum?number<0)||shop.goodsDetailBean.productVo.goodsInfoAdded=='0'>
                                                <input type="hidden" value="1" class="noexit"/>
                                            </#if>

                                            <#if shop.goodsDetailBean.productVo.productName?index_of("零售")!=-1><input type="hidden" class="sell-type" value="0"/></#if>
                                            <#if shop.goodsDetailBean.productVo.productName?index_of("批发")!=-1><input type="hidden" class="sell-type" value="1"/></#if>

                                            <i class="select-box selected" onclick="checkone(this)"></i>

                                            <div class="propic">
                                                <a href="${basePath}/item/${shop.goodsDetailBean.productVo.goodsInfoId}.html"
                                                   title="${shop.goodsDetailBean.productVo.productName}">
                                                    <img src="${shop.goodsDetailBean.productVo.goodsInfoImgId}" alt="产品图">
                                                    <#--<#if (shop.goodsDetailBean.productVo.goodsInfoStock?number-shop.goodsNum?number<0)>
                                                        <span class="sell-out">无货</span>
                                                    <#elseif shop.goodsDetailBean.productVo.goodsInfoAdded=='0'>
                                                        <span class="pull-down">下架</span>
                                                    </#if>-->
                                                    <#if (shop.goodsDetailBean.productVo.goodsInfoStock?number==0)>
                                                        <span class="sell-out">无货</span>
                                                    <#elseif shop.goodsDetailBean.productVo.goodsInfoAdded=='0'>
                                                        <span class="pull-down">下架</span>
                                                    </#if>
                                                </a>
                                            </div>
                                            <div class="prodesc">
                                                <h3 class="title">
                                                    <a href="${basePath}/item/${shop.goodsDetailBean.productVo.goodsInfoId}.html"
                                                       title="${shop.goodsDetailBean.productVo.productName}">
                                                    ${shop.goodsDetailBean.productVo.productName!''}
                                                    </a>
                                                </h3>
                                                <div class="specification">规格：<span>${shop.goodsDetailBean.productVo.specVo[0].specValueRemark}</span></div>
                                                     <#assign  rushsprice = "0"><#--抢购商品的原价-->
                                                     <#assign  rushsbuy = 0><#--限购数量-->
                                                     <#assign  rushDiscount=0>
                                                     <#assign price = "${shop.goodsDetailBean.productVo.goodsInfoPreferPrice?number}">
                                                <#if  mar.codexType=="11">
                                                <#assign rushsprice = "${shop.goodsPrice?number}">
                                                <#--<#assign rushsprice = "${shop.goodsDetailBean.productVo.goodsInfoPreferPrice?number/mar.rushs[0].rushDiscount?number}">-->
                                                    <#assign rushsbuy = "${mar.customerbuynum?number}">
                                                    <#assign rushDiscount = "${mar.rushs[0].rushDiscount?number}">
                                                </#if>
                                                <#if mar.codexType=="11" && mar.customerbuynum?? && shop.goodsNum?number gt mar.customerbuynum?number && mar.customerbuynum !=0>

                                                        <p class="price" style="">
                                                            ¥&nbsp;<span>${rushsprice?number?string("0.00")?substring(0,1)}</span><em style="font-size: 12px">${(rushsprice?number)?string("0.00")?substring((rushsprice?number)?string("0.00")?index_of("."))}</em><b>×${(shop.goodsNum?number-mar.customerbuynum?number)?string("0")}</b>
                                                        </p>
                                                        <p class="ohtherprice">
                                                            ¥&nbsp;<span>${price?number?string("0.00")?substring(0,price?number?string("0.00")?index_of(".")+1)}</span><em style="font-size: 12px">${price?number?string("0.00")?substring(price?number?string("0.00")?index_of(".")+1)}</em><b>×${mar.customerbuynum?number}</b>
                                                        </p>

                                                    <#else>
                                                        <p class="price" style="display:none;">
                                                            ¥&nbsp;<span></span><em style="font-size: 12px">00</em><b>×</b>
                                                        </p>
                                                        <p class="ohtherprice">
                                                            ¥&nbsp;<span>${price?number?string("0.00")?substring(0,price?number?string("0.00")?index_of(".")+1)}</span><em style="font-size: 12px">${price?number?string("0.00")?substring(price?number?string("0.00")?index_of(".")+1)}</em><b>×${shop.goodsNum}</b>
                                                        </p>
                                                    </#if>
                                                <#assign weight="${shop.goodsDetailBean.productVo.goodsInfoWeight}">
                                                <#assign oneweight="${oneweight?number+weight?number*shop.goodsNum}">
                                                <input type="hidden" class="weight" value="${weight}"/>
                                                <input type="hidden" class="goodsPrice"
                                                       value="${shop.goodsDetailBean.productVo.goodsInfoPreferPrice}"/>
                                                <#--<#if stockinfos ?? >
                                                    <#list  stockinfos as stockinfo>
                                                        <#if stockinfo.goodsId == shop.goodsDetailBean.productVo.goodsInfoId>
                                                            <div><p class="num" style="color: red">仅剩 ${stockinfo.stockNum}件</p>
                                                            </div>
                                                        </#if>
                                                    </#list>
                                                </#if>-->
                                        <#if (shop.goodsDetailBean.productVo.goodsInfoStock?number!=0)&&shop.goodsDetailBean.productVo.goodsInfoAdded!='0'>
                                            <#if (shop.goodsDetailBean.productVo.goodsInfoStock?number - shop.goodsNum?number) gte 0>
                                                <span class="insufficient "></span>
                                            <#--(shop.goodsDetailBean.productVo.goodsInfoStock?number gte shop.goodsNum?number)&&(shop.goodsDetailBean.productVo.goodsInfoStock?number<10)-->
                                            <#else >
                                               <span class="insufficient "> 仅剩${shop.goodsDetailBean.productVo.goodsInfoStock}件</span>
                                            </#if>
                                        <#else>
                                            <#if (shop.goodsDetailBean.productVo.goodsInfoStock?number==0)>
                                                <span class="insufficient ">库存不足</span>
                                            <#elseif shop.goodsDetailBean.productVo.goodsInfoAdded=='0'>
                                                <span class="insufficient ">已下架</span>
                                            </#if>
                                        </#if>
                                                <div class="buy-num">
                                                    <span class="minuss <#if (shop.goodsNum?number>1)>canclick</#if>" data-added="${shop.goodsDetailBean.productVo.goodsInfoAdded}" onclick="minuss(this,${shop.shoppingCartId},${shop.goodsDetailBean.productVo.goodsInfoId});"></span>
                                                    <#--<input type="text" class="goodsNum goods-num" onclick="minuss(this,${shop.shoppingCartId});">&#8722</span>-->
                                                    <input type="hidden" class="goodsNum goods-num cartItemNum" readonly="readonly"
                                                           attr-maxnum="${shop.goodsDetailBean.productVo.goodsInfoStock}"
                                                           <#--onblur="opblur(this,${shop.shoppingCartId});"-->
                                                           value="${shop.goodsNum}" rushsprice="${rushsprice}" rushsbuy="${rushsbuy}" rushDiscount="${rushDiscount}"/>
                                                    <i style="width: 35px;height: 28px;display: inline-block;border:1px solid #d4d4d4;border-top:none;border-bottom: none;" class="goodsNumShow">${shop.goodsNum}</i>
                                                    <span data-added="${shop.goodsDetailBean.productVo.goodsInfoAdded}" onclick="pluss(this,${shop.shoppingCartId},${shop.goodsDetailBean.productVo.goodsInfoId});"></span>
                                                </div>
                                                <#assign marNum=marNum+shop.goodsNum?number/>
                                                <#assign goodsNum=goodsNum+shop.goodsNum?number/>
                                                <#assign onePrice=onePrice+shop.goodsNum?number*shop.goodsDetailBean.productVo.goodsInfoPreferPrice?number/>
                                                <#assign sumPrice=sumPrice+shop.goodsNum?number*shop.goodsDetailBean.productVo.goodsInfoPreferPrice?number/>
                                            </div>
                                        <#--<div class="tool-btn">-->
                                        <#--<a class="in-collection collection" href="javascript:;" >移入<br>收藏</a>-->
                                        <#--<a class="delete" onclick="del(${shop.shoppingCartId},${shop.goodsInfoId})" href="javascript:;"> 删除</a>-->
                                        <#--</div>-->
                                        </div>
                                    <#--<a href="javascript:;" class="change_discount">-->
                                    <#--<input type="hidden" value="${shop.shoppingCartId}"/>-->
                                    <#--<span>重新选择优惠活动</span>-->
                                    <#--<i class="arrow-right"></i>-->
                                    <#--</a>-->
                                        <div class="fav-list f1 promotions-box${shop.shoppingCartId}" style="display: none;">
                                            <ul class="promotions">
                                                <#list shop.marketingList as mar>
                                                    <#if  mar.codexType=='5'|| mar.codexType=='1'|| mar.codexType=='8'||mar.codexType=='11' || mar.codexType=='6'||mar.codexType=='10'||mar.codexType=='15'>
                                                        <li class="<#if mar.marketingId==shop.marketingActivityId>selected</#if>">
                                                            <a href="javascript:void(0);">
                                                                <span class="fav gift"> <#if mar.codexType=='5'>
                                                                    减<#elseif mar.codexType=='1'>降<#elseif mar.codexType=='8'>
                                                                    折<#elseif mar.codexType=='11'>抢</#if></span>
                                                            ${mar.marketingName!''}<i class="check-box"></i></a>
                                                            <input type="hidden" class="marketingAId"
                                                                   value="${mar.marketingId}"/>
                                                        </li>
                                                    </#if>
                                                </#list>
                                            </ul>
                                        </div>
                                    </li>
                                    </#if>
                                </#if>

                            </#if>
                        </#list>

                        <#if  marNum!=0>
                            <input class="oneprice" type="hidden" value="${onePrice}"/>
                            <input type="hidden" class="oneweight" value="${oneweight}"/>
                            <!--判断满减-->
                            <#assign yhprice=zjPrice>
                            <!--满减-->
                            <#if mar.codexType=='5'>
                                <#list mar.fullbuyReduceMarketings as fr>
                                    <#if (onePrice?number>=fr.fullPrice?number)>
                                        <#assign yhprice="${fr.reducePrice}">
                                    </#if>
                                    <!-- 满 ${fr.fullPrice}减${fr.reducePrice}元 &nbsp;-->
                                </#list>
                            </#if>
                            <!--满折-->
                            <#if mar.codexType=='8'>
                                <#list mar.fullbuyDiscountMarketings as mz>
                                    <#if (onePrice?number>=mz.fullPrice?number)>
                                        <#assign yhprice="${onePrice?number*(1-mz.fullbuyDiscount?number)}">
                                    </#if>
                                </#list>
                            </#if>
                            <!--满赠-->
                        <#--<#if mar.codexType=='6'>
                            <input  class="youhui" type="hidden" value="${yhprice}"/>
                        </#if>-->

                            <#--<input class="youhui" type="hidden" value="${yhprice}"/>-->
                            <#--不计算优惠-->
                            <input class="youhui" type="hidden" value="0"/>
                            <#assign youhui=youhui?number+yhprice?number/>

                            <#--<!--已选赠品信息开始&ndash;&gt;-->
                            <#--<div class="cart_gifts"  >-->
                                <#--<#if mar.codexType=='6' && mar.fullbuyPresentMarketing??>-->
                                    <#--<#list mar.fullbuyPresentMarketing.fullbuyPresentScopes as fullbuyPresentScope>-->
                                        <#--<#if fullbuyPresentScope.coupon??&&fullbuyPresentScope.scopeType?? && fullbuyPresentScope.scopeType=='1'>-->
                                            <#--<p style="font-size: 12px;padding: .2rem .2rem 0;">-->
                                                <#--<span>赠品</span>&nbsp;&nbsp;&nbsp;&nbsp;-->
                                                <#--<span class="name" style="position: absolute;left: 0; color: #999;padding: 0 1rem 0 1rem; overflow: hidden;text-overflow: ellipsis;white-space: nowrap;width: 100%;">优惠券${fullbuyPresentScope.coupon.couponName}</span>-->
                                                <#--<span class="num1" style="position: absolute;right: 0.2rem;text-align: right;">×${fullbuyPresentScope.scopeNum}</span>-->
                                                <#--<input type="hidden" value="${fullbuyPresentScope.presentScopeId}">-->
                                            <#--</p>-->
                                            <#--<#if mar.fullbuyPresentMarketing.presentMode == '1'>-->
                                                <#--<#break>-->
                                            <#--</#if>-->
                                       <#--<#elseif fullbuyPresentScope.scopeType?? && fullbuyPresentScope.scopeType=='0'>-->
                                           <#--<p style="font-size: 12px;padding: .2rem .2rem 0;">-->
                                               <#--<span>赠品</span>&nbsp;&nbsp;&nbsp;&nbsp;-->
                                               <#--<span class="name" style="position: absolute;left: 0; color: #999;padding: 0 1rem 0 1rem; overflow: hidden;text-overflow: ellipsis;white-space: nowrap;width: 100%;">${fullbuyPresentScope.goodsProduct.goodsInfoName}</span>-->
                                               <#--<span class="num1" style="position: absolute;right: 0.2rem;text-align: right;">×${fullbuyPresentScope.scopeNum}</span>-->
                                               <#--<input type="hidden" value="${fullbuyPresentScope.presentScopeId}">-->
                                           <#--</p>-->
                                           <#--<#if mar.fullbuyPresentMarketing.presentMode == '1'>-->
                                               <#--<#break>-->
                                           <#--</#if>-->
                                        <#--</#if>-->
                                    <#--</#list>-->

                                    <#--&lt;#&ndash;<a href="javascript:;" class="change_gift"&ndash;&gt;-->
                                       <#--&lt;#&ndash;id="select-gift_${mar.marketingId}_${mar.fullbuyPresentMarketing.fullbuyPresentMarketingId}_${mar.fullbuyPresentMarketing.presentMode}_${mar.fullbuyPresentMarketing.presentType}">修改赠品</a>&ndash;&gt;-->
                                <#--</#if>-->
                            <#--</div>-->
                            <#--<div class="div_line" style="display:none;"></div>-->
                            <#--<!--已选赠品信息结束&ndash;&gt;-->
                            <!---满赠赠品弹层开始-->
                           <#if mar.fullbuyPresentMarketings??>
                                <#list mar.fullbuyPresentMarketings as fullbuyPresentMarketing>
                                    <div class="set_gift"
                                         id="gift_box_${mar.marketingId}_${fullbuyPresentMarketing.fullbuyPresentMarketingId}_${fullbuyPresentMarketing.presentMode}_${fullbuyPresentMarketing.presentType}"
                                        <#if mar.fullbuyPresentMarketing??><#if mar.fullbuyPresentMarketing.fullbuyPresentMarketingId != fullbuyPresentMarketing.fullbuyPresentMarketingId>
                                         style="display:none" </#if><#else>style="display:none"</#if>>
                                        <div class="minigifts"
                                             id="gifts_${mar.marketingId}_${fullbuyPresentMarketing.fullbuyPresentMarketingId}_${fullbuyPresentMarketing.presentMode}_${fullbuyPresentMarketing.presentType}">
                                            <a href="javascript:;" class="close"></a>
                                            &lt;#&ndash;<h4>修改赠品</h4>&ndash;&gt;
                                            <div class="swiper-container"
                                                 id="chooseGifts_${mar.marketingId}_${fullbuyPresentMarketing.fullbuyPresentMarketingId}">
                                                <div class="swiper-wrapper">
                                                    <#list fullbuyPresentMarketing.fullbuyPresentScopes as fullbuyPresentScope>
                                                        <div class="swiper-slide">
                                                        <#if fullbuyPresentScope.coupon??&&fullbuyPresentScope.scopeType?? && fullbuyPresentScope.scopeType=='1'>
                                                            <div class="gift_item gift_${fullbuyPresentScope.presentScopeId}">
                                                                <em><i class="ion-ios-checkmark-empty"></i></em>
                                                                <p class="name">${fullbuyPresentScope.coupon.couponName}</p>
                                                                <p class="num" scopenum="${fullbuyPresentScope.scopeNum}">
                                                                    ×${fullbuyPresentScope.scopeNum}</p>
                                                                <input type="hidden"
                                                                       value="${fullbuyPresentScope.presentScopeId}">
                                                            </div>
                                                        <#elseif fullbuyPresentScope.scopeType?? && fullbuyPresentScope.scopeType=='0'>
                                                            <div class="gift_item gift_${fullbuyPresentScope.presentScopeId}">
                                                                <em><i class="ion-ios-checkmark-empty"></i></em>
                                                                <img alt=""
                                                                     src="${fullbuyPresentScope.goodsProduct.goodsInfoImgId}"
                                                                     width="110">
                                                                <p class="name">${fullbuyPresentScope.goodsProduct.goodsInfoName}</p>
                                                                <p class="num" scopenum="${fullbuyPresentScope.scopeNum}">
                                                                    ×${fullbuyPresentScope.scopeNum}</p>
                                                                <input type="hidden"
                                                                       value="${fullbuyPresentScope.presentScopeId}">
                                                            </div>
                                                        </#if>
                                                        </div>
                                                    </#list>
                                                </div>
                                            </div>
                                            <a href="javascript:;" class="btn  btn-full" onclick="changeGift(this);">确认</a>
                                        </div>
                                    </div>
                                </#list>
                                <!---满赠赠品弹层开始-->
                            </#if>
                        </li>
                        </#if>
                        <li>
                            <div class="cx-line"></div>
                            <div class="cart-promotions list-item" style="padding-left: 0; position: relative;">
                                <h3 style="font-size: 12px;padding-left: 0;position: relative;height: .36rem;line-height: .36rem;">促销活动</h3>
                                <div class="salename">
                                    <#if mar.codexType=='1'>
                                        <img src="../../images/v2/zhijiang@2x.png">
                                        <span>${mar.marketingName}</span>
                                    <#elseif mar.codexType=='5'>
                                        <img src="../../images/v2/manjian@2x.png">
                                        <span>${mar.marketingName}</span>
                                    <#elseif mar.codexType=='6'>
                                        <img src="../../images/v2/manzeng@2x.png">
                                        <span>${mar.marketingName}</span>
                                    <#elseif mar.codexType=='8'>
                                        <img src="../../images/v2/manjian@2x.png">
                                        <span>${mar.marketingName}</span>
                                    <#elseif mar.codexType=='10'>
                                        <img src="../../images/v2/tuangou@2x.png">
                                        <span>${mar.marketingName}</span>
                                    <#elseif mar.codexType=='11'>
                                        <img src="../../images/v2/qinggou@2x.png">
                                        <span>${mar.marketingName}</span>
                                    <#elseif mar.codexType=='15'>
                                        <img src="../../images/v2/zhekou@2x.png">
                                        <span>${mar.marketingName}</span>
                                    </#if>
                                </div>
                            <#--<i class="arrow-right"></i>-->
                            </div>
                            <!--已选赠品信息开始-->
                            <div class="cart_gifts"  >
                                <#if mar.codexType=='6' && mar.fullbuyPresentMarketing??>
                                    <#list mar.fullbuyPresentMarketing.fullbuyPresentScopes as fullbuyPresentScope>
                                        <#if fullbuyPresentScope.coupon??&&fullbuyPresentScope.scopeType?? && fullbuyPresentScope.scopeType=='1'>
                                            <p style="font-size: 12px;padding: .2rem .2rem 0;">
                                                <span>赠品</span>&nbsp;&nbsp;&nbsp;&nbsp;
                                                <span class="name" style="position: absolute;left: 0; color: #999;padding: 0 1rem 0 1rem; overflow: hidden;text-overflow: ellipsis;white-space: nowrap;width: 100%;">优惠券${fullbuyPresentScope.coupon.couponName}</span>
                                                <span class="num1" style="position: absolute;right: 0.2rem;text-align: right;">×${fullbuyPresentScope.scopeNum}</span>
                                                <input type="hidden" value="${fullbuyPresentScope.presentScopeId}">
                                            </p>
                                            <#if mar.fullbuyPresentMarketing.presentMode == '1'>
                                                <#break>
                                            </#if>
                                        <#elseif fullbuyPresentScope.scopeType?? && fullbuyPresentScope.scopeType=='0'>
                                            <p style="font-size: 12px;padding: .2rem .2rem 0;">
                                                <span>赠品</span>&nbsp;&nbsp;&nbsp;&nbsp;
                                                <span class="name" style="position: absolute;left: 0; color: #999;padding: 0 1rem 0 1rem; overflow: hidden;text-overflow: ellipsis;white-space: nowrap;width: 100%;">${fullbuyPresentScope.goodsProduct.goodsInfoName}</span>
                                                <span class="num1" style="position: absolute;right: 0.2rem;text-align: right;">×${fullbuyPresentScope.scopeNum}</span>
                                                <input type="hidden" value="${fullbuyPresentScope.presentScopeId}">
                                            </p>
                                            <#if mar.fullbuyPresentMarketing.presentMode == '1'>
                                                <#break>
                                            </#if>
                                        </#if>
                                    </#list>

                                <#--<a href="javascript:;" class="change_gift"-->
                                <#--id="select-gift_${mar.marketingId}_${mar.fullbuyPresentMarketing.fullbuyPresentMarketingId}_${mar.fullbuyPresentMarketing.presentMode}_${mar.fullbuyPresentMarketing.presentType}">修改赠品</a>-->
                                </#if>
                            </div>
                            <div class="div_line" style="display:none;"></div>
                            <!--已选赠品信息结束-->
                        </li>
                    </ul>
                 </div>
            </#list>

        </#if>


        <#list shopMap.shoplist as shop>
            <#if shop.fitId??>
                <#assign groupVo = shop.goodsGroupVo>

                <div class="group-atxt">
                    <ul>
                        <li>
                            <input type="hidden" class="shoppingCartId" value="${shop.shoppingCartId}"/>
                            <ul class="fav-list" style="display:none;" attr-codextype="-1">
                            <#--<li class="selected">-->
                        <#--<input type="hidden" class="marketingAId" value="${groupVo.groupId}">-->
                    <#--</li>-->
                            </ul>

                            <div class="cart-group-item">
                                <div class="group-name">
                                    <i class="select-box selected" onclick="checkone(this)"></i>
                                    <span class="label-line">套装</span>
                                    <span>${groupVo.groupName}</span>
                                </div>
                            </div>
                            <div class="xcyclass">
                                <#list groupVo.productList as product>
                                    <div class="list-item cart-pro-item">
                                        <div class="shademask"></div>
                                        <div class="propic">
                                            <a href="${basePath}/item/${product.productDetail.goodsInfoId}.html">
                                                <img src="${product.productDetail.goodsInfoImgId}"
                                                     alt="${product.productDetail.goodsInfoName}">
                                            </a>
                                        </div>
                                        <div class="prodesc">
                                            <a href="${basePath}/item/${product.productDetail.goodsInfoId}.html">
                                                <h3 class="title">${product.productDetail.goodsInfoName}</h3>
                                                <p class="price">¥&nbsp;
                                                    <span class="num">${product.productDetail.goodsInfoPreferPrice?string('0.00')}</span><span style="font-size: 12px">00</span><b>×1</b>

                                                    <#if product.productDetail.goodsInfoName?index_of("零售")!=-1><input type="hidden" class="sell-type" value="0"/></#if>
                                                    <#if product.productDetail.goodsInfoName?index_of("批发")!=-1><input type="hidden" class="sell-type" value="1"/></#if>
                                                </p>
                                                <p class="ohtherprice">
                                                    ¥&nbsp;<span>${shop.goodsDetailBean.productVo.goodsInfoPreferPrice?string('0.00')}</span><span style="font-size: 12px">00</span><b>×1</b>
                                                </p>
                                                <p class="amount">${shop.goodsNum}件/套</p>

                                                <input type="hidden" class="goods-num group-goods-num" value="${shop.goodsNum}"/>
                                            </a>
                                        </div>
                                    </div>
                                </#list>
                            </div>
                            <div class="group-settle">
                                <div class="buy-num">

                                    <span  onclick="minuss(this,${shop.shoppingCartId});"></span>


                                    <input type="text" readonly="readonly" class="goodsNum" attr-maxnum="${groupVo.stock}"

                                           onblur="opblur(this,${shop.shoppingCartId});"
                                           value="${shop.goodsNum}"/>
                                    <span  onclick="pluss(this,${shop.shoppingCartId});"></span>
                                </div>

                                <p>套装价：<span class="price">￥${groupVo.price?string('0.00')}</span></p>

                                <#assign originPrice = groupVo.price?number + groupVo.groupPreferamount?number/>
                                <#assign youhui=shop.goodsNum?number*groupVo.groupPreferamount?number/>
                                <#assign oneprice=shop.goodsNum?number*originPrice?number/>
                                <#assign sumPrice=sumPrice+oneprice/>

                                <input class="groupPreferamount" type="hidden" value="${groupVo.groupPreferamount}"/>
                                <input class="goodsPrice" type="hidden" value="${originPrice}"/>
                                <input class="youhui" type="hidden" value="${youhui}"/>
                                <input class="oneprice" type="hidden" value="${oneprice}"/>
                            </div>
                        </li>
                    </ul>

                </div>


            <#else>
                <#if shop.goodsDetailBean??>
                    <#assign marketnum=0>
                <#--&lt;#&ndash; 没明白这部分代码什么作用,这部分代码会阻断促销商品，false放过去-->
                    <#if shop.marketingActivityId??&&shop.marketingList?size!=0&&shop.marketingActivityId!=0>
                    <#else>
                        <div class="group-atxt">
                            <ul>
                                <li>
                                    <div class="list-item cart-pro-item">
                                        <div class="shademask"></div>
                                        <input type="hidden" class="goodInfoId"
                                               value="${shop.goodsDetailBean.productVo.goodsInfoId}"/>
                                        <input type="hidden" class="shoppingCartId" value="${shop.shoppingCartId}"/>
                                        <input type="hidden" class="distinctId" value="${shop.distinctId!''}"/>
                                        <#if (shop.goodsDetailBean.productVo.goodsInfoStock?number-shop.goodsNum?number<0)||shop.goodsDetailBean.productVo.goodsInfoAdded=='0'>
                                            <input type="hidden" value="1" class="noexit"/>
                                        </#if>
                                        <i class="select-box selected" onclick="checkone(this)"></i>

                                        <#if shop.goodsDetailBean.productVo.productName?index_of("零售")!=-1><input type="hidden" class="sell-type" value="0"/></#if>
                                        <#if shop.goodsDetailBean.productVo.productName?index_of("批发")!=-1><input type="hidden" class="sell-type" value="1"/></#if>
                                        <div class="propic">
                                            <a href="${basePath}/item/${shop.goodsDetailBean.productVo.goodsInfoId}.html"
                                               title="${shop.goodsDetailBean.productVo.productName}">
                                                <img src="${shop.goodsDetailBean.productVo.goodsInfoImgId}" alt="产品图">
                                                <#if (shop.goodsDetailBean.productVo.goodsInfoStock?number==0)>
                                                    <span class="sell-out">无货</span>
                                                <#elseif shop.goodsDetailBean.productVo.goodsInfoAdded=='0'>
                                                    <span class="pull-down">下架</span>
                                                </#if>
                                            </a>
                                        </div>
                                        <div class="prodesc">
                                            <h3 class="title">
                                                <a href="${basePath}/item/${shop.goodsDetailBean.productVo.goodsInfoId}.html"
                                                   title="${shop.goodsDetailBean.productVo.productName}">
                                                ${shop.goodsDetailBean.productVo.productName!''}
                                                </a>
                                            </h3>
                                            <div class="specification">规格：<span>${shop.goodsDetailBean.productVo.specVo[0].specValueRemark}</span></div>
                                            <p class="ohtherprice">
                                                <#assign price = "${shop.goodsDetailBean.productVo.goodsInfoPreferPrice?number}">
                                                ¥&nbsp;<span>${price?number?string("0.00")?substring(0,price?number?string("0.00")?index_of(".")+1)}</span><span style="font-size: 12px">${price?number?string("0.00")?substring(price?number?string("0.00")?index_of(".")+1)}</span><b>×${shop.goodsNum}</b>
                                            </p>
                                            <input type="hidden" class="goodsPrice"
                                                   value="${shop.goodsDetailBean.productVo.goodsInfoPreferPrice}">
                                            <#--<#if stockinfos ?? >
                                                <#list  stockinfos as stockinfo>
                                                    <#if stockinfo.goodsId == shop.goodsDetailBean.productVo.goodsInfoId>
                                                        <div><p class="num" style="color: red">仅剩 ${stockinfo.stockNum}件</p></div>
                                                    </#if>
                                                </#list>
                                            </#if>-->
                                            <#if (shop.goodsDetailBean.productVo.goodsInfoStock?number!=0)&&shop.goodsDetailBean.productVo.goodsInfoAdded!='0'>
                                                <#if ((shop.goodsDetailBean.productVo.goodsInfoStock?number) - (shop.goodsNum?number)) gte 0>
                                                    <span class="insufficient "></span>
                                                <#--if (shop.goodsDetailBean.productVo.goodsInfoStock?number gte shop.goodsNum?number)&&(shop.goodsDetailBean.productVo.goodsInfoStock?number<10)-->
                                                <#else>
                                                    <span class="insufficient "> 仅剩${shop.goodsDetailBean.productVo.goodsInfoStock}件</span>
                                                </#if>
                                            <#else>
                                               <#if (shop.goodsDetailBean.productVo.goodsInfoStock?number==0)>
                                                   <span class="insufficient ">库存不足</span>
                                               <#elseif shop.goodsDetailBean.productVo.goodsInfoAdded=='0'>
                                                   <span class="insufficient ">已下架</span>
                                               </#if>
                                            </#if>
                                            <div class="buy-num">

                                                <span class="minuss <#if (shop.goodsNum?number>1)>canclick</#if>" name="${shop.shoppingCartId}" data-added="${shop.goodsDetailBean.productVo.goodsInfoAdded}" onclick="minuss(this,${shop.shoppingCartId},${shop.goodsDetailBean.productVo.goodsInfoId})"></span>
                                                <input type="hidden" class="goodsNum goods-num cartItemNum" readonly="readonly"
                                                       attr-maxnum="${shop.goodsDetailBean.productVo.goodsInfoStock}"
                                                       <#--onblur="opblur(this,${shop.shoppingCartId});"--> value="${shop.goodsNum}" />
                                                <i style="width: 35px;height: 28px;display: inline-block;border:1px solid #d4d4d4;border-top:none;border-bottom: none;"  class="goodsNumShow">${shop.goodsNum}</i>
                                                <span  name="${shop.shoppingCartId}" data-added="${shop.goodsDetailBean.productVo.goodsInfoAdded}" onclick="pluss(this,${shop.shoppingCartId},${shop.goodsDetailBean.productVo.goodsInfoId});"></span>
                                            </div>
                                            <#assign goodsNum=goodsNum+shop.goodsNum?number/>
                                            <#assign oneprice=shop.goodsNum?number*shop.goodsDetailBean.productVo.goodsInfoPreferPrice?number/>
                                            <#assign sumPrice=sumPrice+oneprice/>
                                            <input class="oneprice" type="hidden" value="${oneprice}">
                                            <input type="hidden" class="weight" value="${shop.goodsDetailBean.productVo.goodsInfoWeight?number}"/>
                                            <input type="hidden" class="oneweight" value="${shop.goodsDetailBean.productVo.goodsInfoWeight?number*shop.goodsNum?number}">
                                        </div>
                                    <#--<div class="tool-btn">-->
                                    <#--<a class="in-collection collection" href="javascript:;" >移入<br>收藏</a>-->
                                    <#--<a class="delete" href="javascript:;"> 删除</a>-->
                                    <#--</div>-->
                                    </div>
                                </li>
                            </ul>

                        </div>
                    </#if>
                </#if>

            </#if>
        </#list>


    </div>

    <div class="pay-box">
        <div class="select-all">
            <i class="select-box selected" onclick="checkAll()" id="selectAll"></i><label>全选</label>
        </div>
        <a class="btn cart-pay" onclick="onpay()">结算</a>
        <div class="cart-money">
            <h4>合计：<span class="zongji">¥<span>${(sumPrice?number-youhui?number)?string('0.00')}</span></span><span style="font-size: 12px" class="xiaoshu">00</span></h4>
            <p>已选<span class="num"></span>件，约重<#--<span class="fanxian" style="color: #999;">${youhui?string('0.00')}</span>--><span class="zjweight" style="color: #999;"></span></p>
        </div>

        <div class="goods-ctrl">
            <a href="javascript:;" class="btn btn-grey">移到收藏夹</a>
            <a href="javascript:;" class="btn btn-them">删除</a>
        </div>
    </div>
<#else>
    <div class="cart-empty">
        <i></i>
        <h3>&nbsp;您的购物车空空如也</h3>
        <a class="btn btn-full" href="${basePath}/main.html">去逛逛</a>
    </div>
    <#--<div class="cart-recommend">-->
        <#--<h3 class="recommend-top"><span class="splitline">— — — — </span>猜你喜欢<span class="splitline">— — — — </span>-->
        <#--</h3>-->
        <#--<div class="pro-recommend">-->
            <#--<div class="pro-recommend-body">-->
                <#--<#if goods??&&goods?size!=0>-->
                    <#--<#list goods as good>-->
                        <#--<a href="${basePath}/item/${good.goodsInfoId}.html">-->
                            <#--<div class="list-item">-->
                                <#--<div class="propic">-->
                                    <#--<img src="${good.goodsInfoImgId!''}" alt="产品图">-->
                                <#--</div>-->
                                <#--<div class="prodesc">-->
                                    <#--<h5 class="title">${good.goodsInfoName!''}</h5>-->
                                   <#--<p class="price">¥&nbsp;<span class="num">${good.goodsInfoPreferPrice!'0.00'}</span><b>×1</b>-->
                                    <#--</p>-->
                                    <#--&lt;#&ndash;<p class="ohtherprice">-->
                                        <#--¥&nbsp;<span>${goods.goodsInfoPreferPrice?string('0.00')}</span><b>×${}</b>-->
                                    <#--</p>&ndash;&gt;-->
                                <#--</div>-->
                            <#--</div>-->
                        <#--</a>-->
                    <#--</#list>-->
                <#--</#if>-->
            <#--</div>-->
        <#--</div>-->
    <#--</div>-->
</#if>
</div>
<!--修改优惠-->
<form method="post" action="${basePath}/changeshoppingcartmarts.htm" class="change_shopping">
    <input type="hidden" name="shoppingCartId" class="shopping_cart_id">
    <input type="hidden" name="marketingActivityId" class="marketing_activity_id">
    <input type="hidden" name="marketingId" class="marketing_id">
</form>
<!--修改优惠-->
<form method="post" action="${basePath}/order/suborder.html" class="subForm">
</form>
<#--<#include "../common/smart_menu1.ftl"/>-->
<#include "../common/new_960menu_index.ftl"/>
<script type="text/javascript">
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

<script src="${basePath}/js/lodash.min.js"></script>
<script src="${basePath}/js/shoppingcart/jsOperation.js"></script>
<script src="${basePath}/js/tip-newbox.js"></script>
<script src="${basePath}/js/shoppingcart/shoppingcart.js"></script>
<script src="${basePath}/js/wechatauth.js"></script>
<script>
    var tip = myAlertStr();

    $(function () {
        $(".bar-bottom a:eq(2)").addClass("selected");
        /* 显示/隐藏优惠 */
        //$('.cart-promotions').click(function () {
            //$(this).toggleClass('open');
            //$(this).parent().next().find('.c-discount').slideToggle('fast');
        //});


        /* 选择赠品 */
        $('.get-gift-btn').click(function () {
            $('body').append('<div class="opacity-bg-4"></div>');
            $('.getgift').slideDown('fast');
        });
        $('.getgift .close').click(function () {
            $('.opacity-bg-4').remove();
            $('.getgift').slideUp('fast');
        });
        /* 删除商品 */
        $('.btn-them').click(function () {
            if ($('.cart-list .select-box.selected').length != 0) {
                var discountBox = dialog({
                    width: 260,
                    title: '删除商品',
                    content: "确定从购物车中删除选择的商品？",
                    okValue: '确定',
                    cancelValue: '取消',
                    ok: function () {
                        var goodsInfoIds = '';
                        var shoppingCartIds = '';
                        $('.cart-list .select-box.selected').each(function () {
                            var obj = $(this).parents("li");
                            var goodsInfoId = $(obj).find(".goodInfoId").val() || 0;
                            var shoppingCartId = $(obj).find(".shoppingCartId").val() || 0;
                            goodsInfoIds += goodsInfoId+",";
                            shoppingCartIds += shoppingCartId+",";
                        })
                        $.post("${basePath}/delshoppingcartbyid.htm",{goodsInfoIds:goodsInfoIds,shoppingCartIds:shoppingCartIds},function (data) {
                            if(data == '1'){
                                /*setTimeout(function () {
                                    $('.tip-box').remove();
                                    $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><i class="success"></i><h3>删除商品成功！</h3></div></div>');
                                }, 10);*/
                                tip("删除商品成功");
                                setTimeout(function () {
                                    //$(".tip-box").hide();
                                    location.reload();
                                }, 1000)
                            }
                        });

                        return true;
                    },
                    cancel: function () {

                        return true;
                    }
                });
                discountBox.showModal();
            } else {
                /*setTimeout(function () {
                    $('.tip-box').remove();
                    $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><i class="failed"></i><h3>请选择商品！</h3></div></div>');
                }, 10);
                setTimeout(function () {
                    $(".tip-box").hide();
                }, 1000)*/
                tip("请选择商品");
            }

        });

        /* 选择优惠 */
        $('.change_discount').click(function () {
            var sid = $(this).parent().parents("li").find(".shoppingCartId").val();
            var discountBox = dialog({
                fixed: true,
                width: 260,
                title: '选择一个优惠活动',
                content: $('.promotions-box' + sid),
                okValue: '确定',
                cancelValue: '取消',
                ok: function () {
                    var newMarId = $('.promotions-box' + sid).find(".selected").find(".marketingAId").val();
                    if (newMarId != '') {
                        $(".marketing_activity_id").val(newMarId)
                        $(".shopping_cart_id").val(sid);
                        $(".change_shopping").submit();
                    }
                    return true;
                },
                cancel: function () {

                    return true;
                }
            });
            discountBox.showModal();
        });
        /* 点击编辑显示编辑按钮 */
        var cartEditable = false;
        $('.cart-edit').click(function () {
            if (cartEditable) {
                $('.pay-box').removeClass('editable');
                $(this).text('编辑');
                $(".select-all .select-box").removeClass("selected");
                $(".prodesc .buy-num").fadeOut("fast");
                cartEditable = !cartEditable;
                $(".ohtherprice").css({"opacity":"1"});
                $(".price").css({"opacity":"1"});
                $(".shademask").hide();
//                仅剩几件 或者是 库存不足
//                $(".insufficient").css({
//                    bottom:"0",right:"0"
//                });
            }
            else {
                $('.pay-box').addClass('editable');
                $(this).text('完成');
//                $(".select-all").addClass("selected");
                $(".select-all .select-box").addClass("selected");
                $(".prodesc .buy-num").fadeIn("fast");
                cartEditable = !cartEditable;
                $(".ohtherprice").css({"opacity":"0"});
                $(".price").css({"opacity":"0"});
                $(".shademask").show();

//                仅剩几件 或者是 库存不足
//                $(".insufficient").css({
//                    bottom:"30px",right:"26px"
//                });
            }
            checkAll();
        });


        /**
         * 收藏商品
         * */
        $(".btn-grey").click(function () {
            if ($(".list-item .selected").length != 0) {


                var discountBox = dialog({
                    width: 260,
                    title: '移到收藏夹',
                    content: "该商品将从购物车移除,确定移入收藏？",
                    okValue: '确定',
                    cancelValue: '取消',
                    ok: function () {
                        $(".list-item .selected").each(function () {
                            var districtId = $(this).parents(".list-item").find(".distinctId").val();
                            var goodsprice = $(this).parents(".list-item").find(".goodsPrice").val();
                            var productId = $(this).parents(".list-item").find(".goodInfoId").val();
                            var _this = $(this);
                            $.post("${basePath}/addcollection.htm", {
                                productId: productId,
                                districtId: districtId,
                                goodsprice: goodsprice
                            }, function (data) {
                                if (data == "-2") {
                                    //返回结果为2代表用户未登录，跳转到登录页面4444
                                    location.href = "../loginm.html?url=/customercenter.html";
                                } else if (data == "1") {
                                    // 返回购物车页面
                                    location.href = "${basePath}/myshoppingmcart.html";
                                } else {
                                    /*setTimeout(function () {
                                        $('.tip-box').remove();
                                        $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><i class="success"></i><h3>系统异常请重试！</h3></div></div>');
                                    }, 10);
                                    setTimeout(function () {
                                        $(".tip-box").hide();
                                    }, 1000)*/
                                    tip("系统异常请重试");
                                }
                            });
                        })
                        return true;
                    },
                    cancel: function () {

                        return true;
                    }
                });
                discountBox.showModal();
            } else {
                /*setTimeout(function () {
                    $('.tip-box').remove();
                    $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><i class="failed"></i><h3>请选择商品！</h3></div></div>');
                }, 10);
                setTimeout(function () {
                    $(".tip-box").hide();
                }, 1000)*/
                tip("请选择商品");
            }

        });

        /* 选择赠品 */
        $('.select_gift').click(function () {
            var sid = $(this).parent().parents("li").find(".shoppingCartId").val();
            var discountBox = dialog({
                fixed: true,
                width: 260,
                title: '选择一个优惠活动',
                content: $('.promotions-box' + sid),
                okValue: '确定',
                cancelValue: '取消',
                ok: function () {
                    var newMarId = $('.promotions-box' + sid).find(".selected").find(".marketingAId").val();
                    if (newMarId != '') {
                        $(".marketing_activity_id").val(newMarId)
                        $(".shopping_cart_id").val(sid);
                        $(".change_shopping").submit();
                    }
                    return true;
                },
                cancel: function () {

                    return true;
                }
            });
            discountBox.showModal();
        });

        /* 点击选择赠品/关闭 */
        $('.change_gift').click(function () {
            var selectGiftIdValue = $(this).attr("id");
            var selectGiftValue = selectGiftIdValue.substring(selectGiftIdValue.indexOf("_") + 1);
            $(this).parent().find("input").each(function () {
                $("#gift_box_" + selectGiftValue).find(".gift_" + $(this).val()).addClass("checked");
            });
            $("#gift_box_" + selectGiftValue).css({'top': 0});
            setTimeout(function () {
                $("#gifts_" + selectGiftValue).animate({'bottom': 0}, 500)
            }, 10);
            var mySwiper = new Swiper('#chooseGifts_' + selectGiftValue, {
                paginationClickable: true,
                slidesPerView: 3,
                loop: true
            });
        });
        $('.set_gift .close').click(function () {
            $('.set_gift .minigifts').animate({'bottom': '-300px'});
            setTimeout(function () {
                $('.set_gift').css({'top': '999px'});
            }, 500)
        });

        /* 赠品选择勾选 */
        $(document).on('click', '.gift_item', function () {
            var minigifts = $(this).parents(".minigifts").attr("id");
            var presentModel = minigifts.split("_")[3];
            if (presentModel == '1') {
                $(this).parents(".minigifts").find(".gift_item").removeClass("checked");
            }
            $(this).toggleClass('checked');
        });
    });

    function changeGift(obj) {
        var selectedGifts = '';
        $(obj).parents(".set_gift").find(".gift_item").each(function () {
            if ($(this).hasClass("checked")) {
                selectedGifts += '<p ><span>赠品</span>&nbsp;&nbsp;&nbsp;&nbsp;' +
                        '<span class="name">' + $(this).find(".name").html() + '</span>' +
                        '<span class="num1" scopenum=' + $(this).find(".num").attr("scopenum") + '>×' + $(this).find(".num").attr("scopenum") + '</span>' +
                        '<input type="hidden" value="' + $(this).find("input").val() + '">' +
                        '</p>';
            }
        });

//        var changebutton = $(".cart_gifts").find("a").clone();
        $(".cart_gifts").find("p").remove();
        $(".cart_gifts").find("a").before(selectedGifts);
        $('.set_gift .minigifts').animate({'bottom': '-300px'});
        setTimeout(function () {
            $('.set_gift').css({'top': '999px'});
        }, 500)
//        $(".cart_gifts").append(changebutton);
    }

    function showchangegift(obj) {
        var selectGiftIdValue = $(obj).attr("id");
        var selectGiftValue = selectGiftIdValue.substring(selectGiftIdValue.indexOf("_") + 1);
        $(obj).parent().find("input").each(function () {
            $("#gift_box_" + selectGiftValue).find(".gift_" + $(this).val()).addClass("checked");
        });
        $("#gift_box_" + selectGiftValue).css({'top': 0});
        setTimeout(function () {
            $("#gifts_" + selectGiftValue).animate({'bottom': 0}, 500)
        }, 10);
        var mySwiper = new Swiper('#chooseGifts_' + selectGiftValue, {
            paginationClickable: true,
            slidesPerView: 3,
            loop: true
        });
    }

</script>

<script>

    /* 选择赠品时左右滑动查看赠品 */
    var mySwiper = new Swiper('#chooseGifts', {
        paginationClickable: true,
        slidesPerView: 3,
        loop: true
    });

    function getQueryString(name)
    {
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)return  unescape(r[2]); return null;
    }

    var buyingLimitError = '${buyingLimitError!''}'
    var buyerror =  getQueryString("buyingLimitError");
    if(buyerror){
        var msg = "所买抢购商品达到了限购上限";
        /*$('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>'+msg +'</h3></div></div>');
        setTimeout(function(){
            $('.tip-box').remove();
        },1000);*/
        tip(msg);
    }
//    由于在华为nova上不能生效selected类名，此处在添加一次
    $(".bar-bottom").find(".bar-item").eq(2).addClass("selected");
</script>
<script>
    $(".reduce").on('touchstart',function (e) {
      var id =$(this).attr("name");
        var $goodsNum = $(this).siblings('.goodsNum');
        var amount=parseInt($('.amount').html());
        var nowNum = parseInt($goodsNum.val()) || 1;
        var minNum = 1;
        var nextNum = Math.max(nowNum - 1, minNum);

        if (nextNum != nowNum) {
            $('.amount').html(amount-1);
            $goodsNum.val(nextNum);
            $(this).parent().parent('.group-settle').prev('.xcyclass').children('.cart-pro-item').children('.prodesc').children().children('.amount').each(function(index,item){
                $(item).html(nextNum+'件/套');
            });
            $(this).parents('.group-settle').prev('.xcyclass').find('.goods-num').each(function(index,item){
                $(this).val(nextNum);
            });
            changeNum(id, nextNum);
            jisuan(this);
        }
        e.preventDefault();
    })
    $(".add").on('touchstart',function (e) {
      /*  console.log(e);*/
        var id =$(this).attr("name");
        var $goodsNum = $(this).siblings('.goodsNum');
        var nowNum = parseInt($goodsNum.val()) || 1;
        var maxNum = $goodsNum.attr("attr-maxnum");
        var nextNum = Math.min(nowNum + 1, maxNum);

        if (nextNum != 0) {
            var $curItem = $(this).parents(".list-item");
            $curItem.find(".sell-out").remove();
            $curItem.find(".noexit").remove();
        }

        $goodsNum.val(nextNum);
        $(this).parent().parent('.group-settle').prev('.xcyclass').children('.cart-pro-item').children('.prodesc').children().children('.amount').each(function(index,item){
            $(item).html(nextNum+'件/套');
        });
        $(this).parents('.group-settle').prev('.xcyclass').find('.goods-num').each(function(index,item){
            $(this).val(nextNum);
        });
        changeNum(id, nextNum);
        jisuan(this);

        e.preventDefault();
    })
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