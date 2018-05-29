<!DOCTYPE html>
<html lang="zh-cn" xmlns:c="http://www.w3.org/1999/html">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="keywords" content="${seo.meteKey}">
    <meta name="description" content="${seo.meteDes}">
<#assign basePath=request.contextPath>
<#if (sys.bsetName)??>
    <title><#if map.detailBean.productVo.goods.goodsSeoTitle?length &gt; 0> ${map.detailBean.productVo.goods.goodsSeoTitle!''}<#else>${map.detailBean.productVo.productName!''}</#if>${sys.bsetName}</title>
<#else>
    <title><#if map.detailBean.productVo.goods.goodsSeoTitle?length &gt; 0> ${map.detailBean.productVo.goods.goodsSeoTitle!''}<#else>${map.detailBean.productVo.productName!''}</#if>${seo.mete}</title>
</#if>
    <style>
        .pro-parameters-body table tr td {
            font-size:12px;
        }
    </style>
    <link rel="stylesheet" href="${basePath}/css/style.min.css"/>
    <link rel="stylesheet" href="${basePath}/css/v2/swiper.min.css"/>
    <link rel="stylesheet" href="${basePath}/css/goodsdetail.css"/>
    <link rel="stylesheet" href="${basePath}/css/add-ons.min.css"/>
    <link rel="stylesheet" type="text/css" href="${basePath}/css/v2/section-scroll.css"/>
    <script src="${basePath}/js/jquery-1.10.1.js"></script>
    <script src="${basePath}/js/idangerous.swiper.js"></script>
    <script src="${basePath}/js/pageAction.js"></script>
    <#--唤醒app-->
    <link rel="stylesheet" href="${basePath}/css/v1/css/arouse-app.css">
    <link rel="stylesheet" href="${basePath}/css/v2/goodsdetail.css">
    <link rel="stylesheet" href="${basePath}/css/tip-newbox.css">


    <style>

    </style>
</head>
<body>
<#--<div class="slideBar">-->
    <#--<div class="slideBar-item sTop"><i></i></div>-->
<#--</div>-->
<div class="arouse-app">
    <b class="aaclose"></b>
    <i><img src="/images/v1/img/logo@2x.png"/></i>
    <div class="aa-intro">
        <p>打开960客户端</p>
        <p>上新优惠一网打尽</p>
    </div>
    <div class="aa-down">打开App</div>
</div>
<div class="pro-details-top bg"></div>
<div class="pro-details-top">
    <#if map.k??>
    <a href="${basePath}/initMain.htm" class="back">
    <#else>
    <a href="javascript:history.back();" class="back">
    </#if>
        <i class="ion-ios-arrow-left"></i>
    </a>
        <a href="javascript:;" class="box-tool">
            <i class="ion-ios-more"></i>
        </a>

    <div class="slideTool-box" style="display:none;">
        <ul>
            <li><a href="${basePath}/main.html"><i class="mine"></i>首页</a></li>
            <#--<li><a href="${basePath}/main.html"><i class="home"></i>主页</a></li>-->
            <li><a href="javascript:void(0);" class="collection"><i class="collection"></i>收藏</a></li>
        </ul>
    </div>
</div>
<div class="content-detail" id="proTop">
    <input type="hidden" value="${basePath}" id="basePath"/>
    <input type="hidden" id="goodsId" value="${map.detailBean.productVo.goodsId}" />
    <input type="hidden" id="productId" value="${map.detailBean.productVo.goodsInfoId}" />
    <input type="hidden" id="brandId" value="${map.detailBean.productVo.goods.brandId}" />
    <input type="hidden" id="productStock" value="${map.detailBean.productVo.goodsInfoStock}" />
    <input type="hidden" id="catId" value="${map.detailBean.productVo.goods.catId}" />
    <input type="hidden" id="goodsInfoAdded" value="${map.detailBean.productVo.goodsInfoAdded}" />
    <input type="hidden" id="followPrice" value="${map.detailBean.productVo.goodsInfoPreferPrice}"/>
    <input type="hidden" id="marketingId" value=""/>
    <input type="hidden" id="thirdId" value="${map.detailBean.productVo.thirdId}"/>
    <input type="hidden" id="wxcode" value="${map.sessionOpedId!''}">
    <input type="hidden" id="beginToEnd" value="${map.beginToEnd!''}"/>
    <input type="hidden" id="rushTime" value="${map.rushTime!''}"/>
    <input type="hidden" id="longTime" value="${map.longTime!''}"/>
    <input type="hidden" id="rushDiscount" value="${map.rushDiscount!''}"/>
    <div class="scrollable-section" data-section-title="About Us">
        <#--<div class="scgd" style="height: 1px;"></div>-->
    <div class="good_img">
        <#--<div class="swiper-container">-->
            <#--<div class="swiper-wrapper">-->
                <#--<!--  商品详情页轮播图片 &ndash;&gt;-->
            <#--<#if map.detailBean.productVo.imageList??>-->
                <#--<#list map.detailBean.productVo.imageList as image>-->
                    <#--<div class="swiper-slide">&lt;#&ndash;<a href="${basePath}/showBigImage-${map.detailBean.productVo.goodsInfoId}.html">&ndash;&gt;<img alt="" src="${image.imageArtworkName!''}"></a></div>-->
                <#--</#list>-->
            <#--</#if>-->
            <#--</div>-->
        <#--</div>-->
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <!--  商品详情页轮播图片 -->
                <#if map.detailBean.productVo.imageList??>
                    <#list map.detailBean.productVo.imageList as image>
                        <div class="swiper-slide"  >
                        <#--<a href="${basePath}/showBigImage-${map.detailBean.productVo.goodsInfoId}.html">-->
                            <#--<img alt="" src="${image.imageArtworkName!''}">-->
                            <div class="dsd" style="width:100%;height:7.5rem;background:url(${image.imageArtworkName!''}) no-repeat;background-position:center center;background-size:contain;"></div>
                            </a>
                        </div>
                    </#list>
                </#if>
                </div>
            </div>
        <div class="swiper-pagination"></div>
    </div>
<#if map.detailBean.productVo.productName?index_of("批发")!=-1>
    <input type="hidden" id="itemTypeNo" value="1"/>
<#else>
    <input type="hidden" id="itemTypeNo" value="0"/>
</#if>
    <div class="prodesc">
        <h3 class="title">${map.detailBean.productVo.productName!''}</h3>
        <p class="fav-info" style="text-align:center;color:#f46e37;margin-top:-3px;" >${map.detailBean.productVo.subtitle!''}</p>
        <!-- 商品销售价 -->
        <div class="pricewarp">
            <#assign price="${map.detailBean.productVo.goodsInfoPreferPrice}">
            <span class="price1 afterpri1"><span>￥</span>${price?number?string("0.00")?substring(0,price?number?string("0.00")?index_of(".")+1)}</span><span class="afterprispan" style="font-size: 12px;margin-right: 5px">${price?number?string("0.00")?substring(price?number?string("0.00")?index_of(".")+1)}</span>
            <span class="price1 preprice1" style="display:none;">原价:<i>￥${map.detailBean.productVo.goodsInfoPreferPrice?string("0.00")}</i></span>
                <input type="hidden" id="countprice" value="${map.detailBean.productVo.goodsInfoPreferPrice!''}"/>
        </div>
        <#--<p class="price preprice" style="margin-top: 20px;">¥&nbsp;<span class="num">${map.detailBean.productVo.goodsInfoPreferPrice?string("0.00")}</span></p>-->
    <#--shf添加的市场价-->
    <#--<span class="market-price">市场价：<b class="market-money"><#if map.detailBean.productVo.goodsInfoMarketPrice??>${map.detailBean.productVo.goodsInfoMarketPrice}<#else>10000</#if></b></span>-->
        <input type="hidden" id="oldPrice"  value="${map.detailBean.productVo.goodsInfoPreferPrice?string("0.00")}">

        <!-- 商品原价 -->
    <#--<p  hidden="hidden" id="oldPrice">¥&nbsp;<span class="num oldPrice"></span></p>-->
        <!-- 商品优惠价 -->
        <#--<p  class="price afterpri" hidden="hidden" id="oldPrice">¥&nbsp;<span class="num mark_price"></span></p>-->

    </div>
    <div class="summary-list">
        <div class="list-item clearfixed qianggou" id="qianggou" style="display: none;">
            <#--限时抢购剩余<span>12</span>天<span>28</span>分<span>56</span>秒-->
        </div>
        <div class="list-item clearfixed cuxiao" style="display:none;border:none;" >
            <a href="javascript:;">
                <label>促销信息</label>
                <div class="list-value">
                    <img src="../../images/v2/qinggou@2x.png">
                    <span>订单订单订单，得到的得到的</span>
                </div>
                <#--<i class="arrow-right" id="couponBtn"></i>-->
            </a>
        </div>
        <#--border-top: 1px solid #ececec;-->
        <div class="list-item clearfixed couponyhq">
        <#--shf零售价格批发数量-->
        <#--<p class="buyDetail">-->
        <#--<span class="buyInfo">零&nbsp;&nbsp;&nbsp;&nbsp;售：</span><a href="#" class="buyBorder buyClick">请拍下4件</a>-->
        <#--</p>-->
        <#--<p class="buyDetail">-->
        <#--<span class="buyInfo">批&nbsp;&nbsp;&nbsp;&nbsp;发：</span><a href="#" class="buyBorder">请拍下19件</a>-->
        <#--</p>-->
        <#--<p>-->
        <#--<span class="buyInfo">数&nbsp;&nbsp;&nbsp;&nbsp;量：</span>-->
        <#--<a href="#" class="sub"></a>-->
        <#--<input type="text" name="buyNum" id="buyNum" class="buyBorder buyClick" placeholder="1"  />-->
        <#--<a href="#" class="add"></a>-->
        <#--</p>-->
        <#--暂时还没有优惠卷-->
            <a href="javascript:;">
                <label>领优惠券</label>
                <div class="list-value" id="coupon">

                </div>
                <i class="arrow-right" id="couponBtn" onclick="arrowshow(this)" style="    top: .65em;"></i>
            </a>
        </div>
    <#--shf商品明细信息-->
        <div class="list-item details-list-p clearfixed" style="display: none;">
            <p>商品编码：${map.detailBean.productVo.goodsInfoItemNo}</p>
            <#list map.detailBean.expandPrams as prams>
                <#if prams.expandParamVo.expandparamName == '产地'>
                <p class="p1">产 地：${prams.expangparamValue.expandparamValueName}</p>
                </#if>
            </#list>
            <p class="p1">品 牌：${map.detailBean.brand.brandName}</p>
            <p class="p1">生产日期：见包装</p>
            <p class="p1">保 质 期：见包装</p>
        </div>

        <div class="list-item promotion-choose" style="display: none;">
            <label>促销</label>
            <div class="list-value">
                <div class="promotion-value">
                </div>
                <i class="arrow-right" id="marketBtn"></i>
            </div>

            <div class="list-value" style="display: none;">
                <span>可享受以下促销</span>
                <i class="arrow-up"></i>
                <ul class="fav-list promotions">

                </ul>
            </div>
        </div>
    <#--<div class="list-item promotions-list" style="display: none;">-->
    <#--<div class="list-value">-->
    <#--<span>可享受以下促销</span>-->
    <#--<ul class="fav-list promotions">-->

    <#--</ul>-->
    <#--</div>-->
    <#--</div>-->
        <#--<div class="scrollable-section" data-section-title="Example"> </div>-->
        <div class="list-item spec-choose" style="padding-bottom: 0;border-bottom: none;">
            <label>已选规格</label>
        <#list map.openSpec as spec>
            <#--<div class="list-item specNames">-->
                <#--<h3 class="item-head">${spec.spec.specName}</h3>-->
                <div class="list-value" id="specA">
                    <#list spec.specValList as specvalue>
                        <a onclick="clickSpecDetail(this,false);" data-parent="${spec.spec.specId}" data-value="${specvalue.specDetail.specDetailId}"   class="btn-grey _sku" href="javascript:void(0);">${specvalue.specValueRemark!''}</a>
                    </#list>
                </div>
            <#--</div>-->
        </#list>

        <#--<div class="list-value" id="specA">-->
            <#--<#list spec.specValList as specvalue>-->
                <#--<a onclick="clickSpecDetail(this,false);" data-parent="${spec.spec.specId}" data-value="${specvalue.specDetail.specDetailId}"   class="btn-grey _sku" href="javascript:void(0);">${specvalue.specValueRemark!''}</a>-->
            <#--</#list>-->
            <#--</div>-->
            <#--<div class="list-value" id="yixuan" style="width: auto;float: left;">-->

            <#--</div><p id="select_num" style=" color: #363636;font-size: 16px;float: left;">×1</p>-->
            <#--<i class="arrow-right" id="specBtn"></i>-->
        </div>
        <div class="list-item area-choose" style="display: none;">
            <label>送至</label>
            <div class="list-value" id="songzhi">
                <span class="current-location">${map.chAddress}</span>
                <i class="gps"></i>
            </div>
        </div>
        <div class="list-item" id="yunFeiShow" style="display: none;">
            <label>运费</label>
            <div class="list-value" id="yunfei"></div>
        </div>
    </div>
    </div>
    <div class="scrollable-section" data-section-title="Example">
        <div class="common mt10" id="comment">
            <div class="list-item" style="padding: 6px 14px;">
                <label>商品评价</label><span style="margin-left: 55px;">（<span id="commentCount" ></span>）</span>
                <#--<div class="list-value common-percent">-->
                    <#--好评度<span id="haoPingLv"></span>-->
                <#--</div>-->
                <#--<span class="curValue" onclick="showPingLun()"><span id="commentCount"></span>人评论</span>-->
                <#--<i class="arrow-right" id="commentBtn" onclick="showPingLun()"></i>-->
                <#--<div class="common-way">-->
                    <#--<a class="btn-grey selected" role="0" id="haoping"></a>-->
                    <#--<a class="btn-grey" onclick="" role="1" id="zhongping"></a>-->
                    <#--<a class="btn-grey" onclick="" role="2" id="chaping"></a>-->
                <#--</div>-->
            </div>
            <div id="commentBody">

            </div>
            <#--<div class="scrollable-section" data-section-title="Examxxxxple"></div>-->
            <div class="more"  onclick="showPingLun()">
                点击查看更多评论
            </div>
        </div>
    </div>
    <#--<div class="common mt10" id="comment">-->
        <#--<div class="list-item">-->
            <#--<label>商品评价</label>-->
            <#--<div class="list-value common-percent">-->
                <#--好评度<span id="haoPingLv"></span>-->
            <#--</div>-->
            <#--<span class="curValue" onclick="showPingLun()"><span id="commentCount"></span>人评论</span>-->
            <#--<i class="arrow-right" id="commentBtn" onclick="showPingLun()"></i>-->
            <#--<div class="common-way">-->
                <#--<a class="btn-grey selected" role="0" id="haoping"></a>-->
                <#--<a class="btn-grey" onclick="" role="1" id="zhongping"></a>-->
                <#--<a class="btn-grey" onclick="" role="2" id="chaping"></a>-->
            <#--</div>-->
        <#--</div>-->
        <#--<div id="commentBody" onclick="showPingLun()">-->

        <#--</div>-->
    <#--</div>-->

    <#--<div class="scrollable-section" data-section-title="Examxxxxple"></div>-->

    <#--<div class="see-more">-->
        <#--<h3>— — — 图文详情 — — —</h3>-->
    <#--</div>-->

<#--<div class="slideBar">-->
<#--<div class="slideBar-item sTop"><i></i></div>-->
<#--</div>-->
</div>
<#--</li>-->
<!-- 这个里面的内容是后续加载进来的 -->
<#--<li>-->
<div class="scrollable-section" data-section-title="Examxxxxple">
<div class="pro-details-box" id="proBottom">
</div>
<#--</li></ul>-->
<#--</div>-->
<div class="bar-bottom">
    <div class="half row">
        <div class="col-12">
            <a class="bar-item" id="end" href="${basePath}/myshoppingmcart.html">
                <i class="bar-bottom-i cart"><span class="tip" id="shopCartNum" style="line-height:20px;"></span></i>
            </a>
        </div>
        <div class="list-value">
            <div class="num">
                <span class="reduce a disabled num_minus"></span>
                <input type="text" value="1" class="count_num product_count" onblur="checkGoodsNum()">
                <span class="add num_plus"></span>
            </div>
            <p style="color: #c00;" id="showError"></p>
            <span class="kucun"><span id="numError" style="color: red; "></span></span>
        </div>




    <#--<#if (map.detailBean.productVo.thirdId)??>-->
        <#--<#if map.detailBean.productVo.thirdId != 0>-->
            <#--<#if map.storeInfo.qqSwitch == '1'>-->
                <#--<div class="col-6">-->
                    <#--<a class="bar-item " href="${basePath}/myshoppingmcart.html">-->
                        <#--<i class="bar-bottom-i cart"><span class="tip" id="shopCartNum"></span></i>加入购物车-->
                    <#--</a>-->
                <#--</div>-->
                <#--<div class="col-6">-->
                    <#--<a class="bar-item " href="${basePath}/thirdStoreIndex.htm?storeId=${map.detailBean.productVo.thirdId}">-->
                        <#--<i class="bar-bottom-i shop"></i>店铺-->
                    <#--</a>-->
                <#--</div>-->
                <#--<div class="col-6" id="onlineService">-->
                    <#--<a class="bar-item" href="http://wpa.qq.com/msgrd?v=3&uin=${map.storeInfo.serviceQq}&site=qq&menu=yes" target="_blank">-->
                        <#--<i class="bar-bottom-i mine"></i>分享-->
                    <#--</a>-->
                <#--</div>-->

                <#--<div class="col-6">-->
                    <#--<a class="bar-item collection" href="javascript:;" style=" top: -238px;">-->
                        <#--<i class="bar-bottom-i love"></i>收藏-->
                    <#--</a>-->
                <#--</div>-->
            <#--<#else>-->
                <#--<div class="col-8">-->
                    <#--<a class="bar-item " href="${basePath}/myshoppingmcart.html">-->
                        <#--<i class="bar-bottom-i cart"><span class="tip" id="shopCartNum"></span></i>购物车-->
                    <#--</a>-->
                <#--</div>-->

                <#--<div class="col-8">-->
                    <#--<a class="bar-item " href="${basePath}/thirdStoreIndex.htm?storeId=${map.detailBean.productVo.thirdId}">-->
                        <#--<i class="bar-bottom-i shop"></i>店铺-->
                    <#--</a>-->
                <#--</div>-->

                <#--<div class="col-8">-->
                    <#--<a class="bar-item collection" href="javascript:;" style=" top: -238px;">-->
                        <#--<i class="bar-bottom-i love"></i>收藏-->
                    <#--</a>-->
                <#--</div>-->
            <#--</#if>-->
        <#--<#else>-->
            <#--<#if map.url !="" >-->
                <#--<div class="col-8">-->
                    <#--<a class="bar-item " href="${basePath}/myshoppingmcart.html">-->
                        <#--<i class="bar-bottom-i cart"><span class="tip" id="shopCartNum"></span></i>购物车-->
                    <#--</a>-->
                <#--</div>-->

            <#--&lt;#&ndash;<#if map.type !="NO">&ndash;&gt;-->
            <#--&lt;#&ndash;<#if map.type =="QQ" >&ndash;&gt;-->
            <#--&lt;#&ndash;<div class="col-8" id="onlineService">&ndash;&gt;-->
            <#--&lt;#&ndash;<a class="bar-item kstService" href="http://wpa.qq.com/msgrd?v=3&uin=${map.url}&site=qq&menu=yes">&ndash;&gt;-->
            <#--&lt;#&ndash;<i class="bar-bottom-i mine"></i>分享&ndash;&gt;-->
            <#--&lt;#&ndash;</a>&ndash;&gt;-->

            <#--&lt;#&ndash;</div>&ndash;&gt;-->
            <#--&lt;#&ndash;<#else>&ndash;&gt;-->
            <#--&lt;#&ndash;<div class="col-8" id="onlineService">&ndash;&gt;-->
            <#--&lt;#&ndash;<a class="bar-item kstService" href="${basePath}/${map.url}">&ndash;&gt;-->
            <#--&lt;#&ndash;<i class="bar-bottom-i mine"></i>客服&ndash;&gt;-->

            <#--&lt;#&ndash;</a>&ndash;&gt;-->
            <#--&lt;#&ndash;</div>&ndash;&gt;-->
            <#--&lt;#&ndash;</#if>&ndash;&gt;-->
            <#--&lt;#&ndash;</#if>&ndash;&gt;-->

                <#--<div class="col-8">-->
                    <#--<a class="bar-item collection" href="javascript:;" style=" top: -238px;">-->
                        <#--<i class="bar-bottom-i love"></i>收藏-->
                    <#--</a>-->
                <#--</div>-->
            <#--<#else>-->
                <#--<div class="col-12">-->
                    <#--<a class="bar-item " href="${basePath}/myshoppingmcart.html">-->
                        <#--<i class="bar-bottom-i cart"><span class="tip" id="shopCartNum"></span></i>购物车-->
                    <#--</a>-->
                <#--</div>-->
                <#--<div class="col-12">-->
                    <#--<a class="bar-item collection" href="javascript:;" style=" top: -238px;">-->
                        <#--<i class="bar-bottom-i love"></i>收藏-->
                    <#--</a>-->
                <#--</div>-->
            <#--</#if>-->
        <#--</#if>-->
    <#--</#if>-->

















    </div>
    <div class="half">
        <a class="btn addToCart" id="add_cart1" href="javascript:;">加入购物车</a>
        <#--<a class="btn buyNow addToCart check" id="add_cart2" href="javascript:;">立即购买</a>-->
    </div>
</div>
</div>
<div class="pro-chose" style="display: none;">
    <input type="hidden" id="allSpecLength" value="${map.detailBean.productVo.specVo?size}" />
    <i class="close"></i>
    <div class="prodesc">
        <div class="propic">
        <#if map.detailBean.productVo.imageList??>
            <#list map.detailBean.productVo.imageList as image>
                <#if image_index==0>
                    <img src="${image.imageInName!''}" alt=""/>
                </#if>
            </#list>
        </#if>

        </div>
        <p  class="price preprice">¥&nbsp;<span class="num">${map.detailBean.productVo.goodsInfoPreferPrice?string("0.00")}</span></p>
        <input type="hidden" id="oldPrice"  value="${map.detailBean.productVo.goodsInfoPreferPrice?string("0.00")}">
        <!-- 商品原价 -->
    <#--<p  hidden="hidden" id="oldPrice">¥&nbsp;<span class="num oldPrice"></span></p>-->
        <!-- 商品优惠价 -->
        <p  class="price afterpri" hidden="hidden" id="oldPrice">¥&nbsp;<span class="num mark_price"></span></p>
        <h3 class="title">${map.detailBean.productVo.productName!''}</h3>
    </div>
    <input type="hidden" id="allSpecLength" value="${map.detailBean.productVo.specVo?size}" />
<#list map.openSpec as spec>
    <div class="list-item specNames">
        <h3 class="item-head">${spec.spec.specName}</h3>
        <div class="list-value" id="specA">
            <#list spec.specValList as specvalue>
                <a onclick="clickSpecDetail(this,false);" data-parent="${spec.spec.specId}" data-value="${specvalue.specDetail.specDetailId}"   class="btn-grey _sku" href="javascript:void(0);">${specvalue.specValueRemark!''}</a>
            </#list>
        </div>
    </div>
</#list>

    <!-- 保存已经选择的规格值 -->
    <div class="hide">
    <#if (map.detailBean.productVo.specVo??)>
        <#list map.detailBean.productVo.specVo as spec>
            <input type="hidden" class="chooseParamId" value="${spec.goodsSpecDetail.specDetailId}" data-spec="${spec.spec.specName}" data-detail="${spec.specValueRemark!''}" />
        </#list>
    </#if>
    </div>

    <div class="list-item">
        <h3 class="item-head">数量</h3>
        <div class="list-value">
            <div class="num">
                <span class="reduce disabled num_minus"></span>
                <input type="text" value="1" class="count_num product_count" onblur="checkGoodsNum()">
                <span class="add num_plus"></span>
            </div>
            <p style="color: #c00;" id="showError"></p>
            <span class="kucun"><span id="numError" style="color: red; "></span></span>
        </div>
    </div>
    <a class="btn btn-full push-cart" id="add_cart_sure" href="javascript:void(0);">确&nbsp;定</a>
</div>


<div class="screen area-box-lv1" style="display:none;">
    <div class="screen-header">
        <a class="back" href="javascript:;" id="dqCancle">取消</a>
        请选择省
    </div>
    <div class="screen-cont">
        <div class="lists province">
            <dl id="province">

            </dl>
        </div>
    </div>
</div>

<div class="screen area-box-lv2" style="display:none;">
    <div class="screen-header">
        <a class="back" href="javascript:;"><i class="back-icon" id="back-icon1"></i></a>
        请选择市
    </div>
    <div class="current-area">
        已选择：
        <span id="okProvince"></span>
    </div>
    <div class="screen-cont">
        <div class="lists city">
            <dl id="city">
            </dl>
        </div>
    </div>
</div>

<div class="screen area-box-lv3" style="display:none;">
    <div class="screen-header">
        <a class="back" href="javascript:;"><i class="back-icon" id="back-icon2"></i></a>
        请选择地区
    </div>
    <div class="current-area">
        已选择：
        <span id="okProvince1"></span>
        <span id="okCity"></span>
    </div>
    <div class="screen-cont">
        <div class="lists district">
            <dl id="district">
            </dl>
        </div>
    </div>
</div>

<div id="myvalue" hidden="hidden">
    <div class="bar-top" id="bar-top">
        <p class="titlewarp">
            <a class="bar-item half active">商品介绍</a>
            <a class="bar-item half">商品参数</a>
            <b></b>
        </p>

    <#--<a-->
    <#--class="bar-item half"-->
    <#--onclick="$(this).addClass('active').siblings().removeClass('active');$('.pro-desc').hide();$('.pro-brand').hide();$('.pro-parameters').hide();$('.pro-details').show();">包装详情</a>-->
    <#--<a-->
    <#--class="bar-item half"-->
    <#--onclick="$(this).addClass('active').siblings().removeClass('active');$('.pro-desc').hide();$('.pro-details').hide();$('.pro-parameters').hide();$('.pro-brand').show();">品牌故事</a>-->
    </div>
    <div class="pro-desc" style="padding-top: 0px;">
        <div class="pro-desc-body">${map.detailBean.productVo.goods.mobileDesc!''}

        </div>
        <img style="    width: 100%; height: 100%;" src="/images/v1/myimages/xuanchuantu1.jpg">
    </div>
    <div class="pro-parameters" style="display:none;padding-top: 0;">
        <div class="pro-parameters-body">
            <table>
                <#--<thead>
                <tr>
                    <td colspan="2">详细参数</td>
                </tr>
                </thead>-->
                <tbody>
                <tr>
                    <td>商品编码：</td>
                    <td>${map.detailBean.productVo.goodsInfoItemNo}</td>
                </tr>
                <#list map.detailBean.param as param>
                        <#if (param.paramValue)??&&(param.paramValue)!=''>
                    <tr>
                        <td width="150">${param.param.paramName}：</td>
                        <td>${param.paramValue}</td>
                    </tr>
                        </#if>

                 </#list>
                </tbody>
            </table>
        </div>
    </div>
    <div class="pro-details">
    <#--<p>包装详情</p>-->
        <#--<img src="../images/pro-desc02.png">-->
    </div>
    <div class="pro-brand">
    <#--<p>品牌故事</p>-->
        <#--<img src="../images/pic_ads_01.jpg">-->
    </div>
</div>


<!-- 保存商品参数部分相关参数 -->
<form id="paramGoodsForm" action="${map.detailBean.productVo.goodsInfoId}.html" method="post">
    <input  type="hidden" name="chAddress" class="ch_address" value="${map.chAddress}" />
    <input type="hidden" name="chProvince" class="ch_province" value="${map.chProvince}" />
    <input type="hidden" name="chCity" class="ch_city" value="${map.chCity}" />
    <input type="hidden" name="chDistinct" class="ch_distinct" value="${map.chDistinct}" />
    <input type="hidden" name="distinctId" class="ch_distinctId" value="${map.distinctId}"  />
    <input type="hidden" class="productStock" value="${map.detailBean.productVo.goodsInfoStock}" />
    <input type="hidden" id="isAjax" value="${map.isAjax}" name="isAjax"/>
</form>

<script src="${basePath}/js/tip-newbox.js"></script>
<script src="${basePath}/js/goods/goods_detailNew.js"></script>
<script src="${basePath}/js/lodash.min.js"></script>
<script src="${basePath}/js/wechatauth.js"></script>
<script>
    $(function(){

        /* 顶部随页面滑动显示 */
        $(window).scroll(function(){
            if($(this).scrollTop() <= 200){
                $('.pro-details-top h1').css({
                    opacity : $(this).scrollTop() * 0.005
                });
            }
            else{
                $('.pro-details-top h1').css({
                    opacity : 1
                });
            }
        });

        //顶部工具箱
        $('.box-tool').click(function(){
            $(this).next().slideToggle('fast');
        });

        /* 商品大图展示 */
        $('.good_img,.good_img img').css('height',parseInt($(window).width()) + 'px');
        var mySwiper = new Swiper('.swiper-container',{
            pagination: '.swiper-pagination',
            loop:true,
            grabCursor: true
            //,autoplay : 3000
        });

        /**
         * 取消选择地区
         * */
        $('#dqCancle').click(function(){
            $('.opacity-bg-3').remove();
            $('.area-box-lv1').hide();
        });

        /**
         * 返回到选择省
         * */
        $('#back-icon1').click(function(){
            $('.area-box-lv2').hide();
            $('.area-box-lv1').show();
        });
        /**
         * 返回到选择市
         * */
        $('#back-icon2').click(function(){
            $('.area-box-lv3').hide();
            $('.area-box-lv2').show();
        });


        /* 促销选择 */
        $('.promotion-choose .list-value').click(function () {
            $(this).hide().siblings().show();
        });
//        /* 规格选择 */
//        $('.spec-choose').click(function(){
//            $('body').append('<div class="opacity-bg-4" onclick="offOpacity()"></div>');
//            $('.pro-chose').slideDown('fast');
//            if($(this).has('.buyNow')){
//                $(this).removeClass('check');
//            }
//        });
        /* 规格选择 */
//        $('.spec-choose').click(function(){
//            $('body').append('<div class="opacity-bg-4" onclick="offOpacity()"></div>');
//            $('.pro-chose').slideDown('fast');
//        });
//        $('.pro-chose .close,#add_cart_sure').click(function(){
//            $('.opacity-bg-4').remove();
//            $('.pro-chose').hide();
////            $('.buyNow').addClass('check');
//        });


        /* 加入购物车 */
//        $('.push-cart').click(function(){
//            $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><i class="waiting"></i><h3>正在加入购物车</h3></div></div>');
//
//        });

        /* 选择地区 */
        $('#songzhi').click(function(){
            $('body').append('<div class="opacity-bg-3"></div>');
            $('.area-box-lv1').show();
        });
        $('.province dd').click(function(){
            $('.area-box-lv1').hide();
            $('.area-box-lv2').show();
        });
        $('.city dd').click(function(){
            $('.area-box-lv2').hide();
            $('.area-box-lv3').show();
        });
//        $('.district dd').click(function(){
//            $('.opacity-bg-3').remove();
//            $('.area-box-lv3').hide();
//        });

        /* 悬浮工具框 */
        //工具箱
        //回到顶部
        $('.sTop>i').click(function(){
            $('html,body').animate({scrollTop: 0}, 800);
        });


        /* 点击查看图文详情 */
//        $('.see-more').click(function(){
//            if($('#proBottom .bar-top').length > 0){
//                $(this).find('h3').text('— — — 点击这里，查看图文详情 — — —')
//                $('.content-detail').animate({
//                    paddingBottom : '50px',
//                    marginTop : 0
//                },800);
//                setTimeout(function(){
//                    $('#proBottom').html('');
//                },800)
//            }
//            else{
//                $('#proBottom').append($("#myvalue").html());
//                $(this).find('h3').text('— — — 点击这里，回到商品信息 — — —');
//                $('body').scrollTop(0);
//                $('.content-detail').animate({
//                    paddingBottom : 0,
//                    marginTop : - $('.content-detail').height() + 40 + 'px'
//                },800);
//            }
//
//        });


        <!-- 加载商品促销的信息 houyichang 2015/10-->
        loadGoodsPromotion();

        <!-- 加载优惠券列表 -->
        loadCoupon();

        <!-- 加载商品评论 -->
        loadComment(1,0);

        <!-- 默认选中一个规格以及显示第一个规格在主页 -->
        //showDefaultSpec();

        <!-- 加载规格值区域 -->
        var productList=null;
        $.get("${basePath}/all/"+$("#goodsId").val()+".html",function(data){
            productList=data;
            <!-- 把查询到的数据传递到js方法中-->
            loadAllProduct(productList);
            loadChooseParam();
        });

        /*初始化已经选择的城市*/
        loadInit();

        <!-- 加载购物车数量 -->
        loadShopCartNum();

        <!-- 查询改用户是否收藏该商品 -->
        loadCollection();

        <!-- 判断是否是切换规格 -->
//        if($("#isAjax").val() == "1"){
//            $('body').append('<div class="opacity-bg-4" onclick="offOpacity()"></div>');
//            $('.pro-chose').slideDown('fast');
//        }

    });
    $('#proBottom').append($("#myvalue").html());
</script>
<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?94d81cec8c55272bd7081c5126331fc1";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>

<script>
    <#--唤醒app-->
    function aaclose(){
        $(".arouse-app").hide();
        $(".content-detail").css({ "margin-top": "0"});
        $(".pro-details-top").css({ "top": "0"});
        $(".bullets-container").css({ "top": "0"});
    };
    function aashow(){
        $(".arouse-app").show();
        $(".content-detail").css({ "margin-top": "54px"});
        $(".pro-details-top").css({ "top": "54px"});
        $(".bullets-container").css({ "top": "54px"});
    };
    function arrowshow(obj){
        $("#coupon").find("span").not( $("#coupon").find("span").eq(0) ).toggle();
        $("#coupon").find("b").not( $("#coupon").find("b").eq(0) ).toggle();
        $(obj).hasClass("pickup")?$(obj).removeClass("pickup"):$(obj).addClass("pickup");
    }
//    $("#couponBtn").on("touchstart",function(){
//        $("#coupon").find("span").not( $("#coupon").find("span").eq(0) ).toggle();
//        $("#coupon").find("b").not( $("#coupon").find("b").eq(0) ).toggle();
//        $(this).hasClass("pickup")?$(this).removeClass("pickup"):$(this).addClass("pickup");
//    });
    //立即领取
    function nowget(e) {
        goCoupon();
        //$(e.target).html("已领取");
        //$(e.target).css("color","#999");
    }

    $("#bar-top a").eq(0).on("click",function(){
        $(this).addClass('active').siblings().removeClass('active');
        $('.pro-desc').show();
        $('.pro-details').hide();
        $('.pro-brand').hide();
        $('.pro-parameters').hide();
        $(".pro-details-box .bar-top b").animate({"left":"19%"});
        if($("#bar-top").hasClass("stickymark")){
            if($(".arouse-app").css("display")=="block"){
                $(window).scrollTop($(".more").offset().top-54)
            }else{
                $(window).scrollTop($(".more").offset().top)
            }
        }
    });
    $("#bar-top a").eq(1).on("click",function(){
        $(this).addClass('active').siblings().removeClass('active');
        $('.pro-desc').hide();
        $('.pro-details').hide();
        $('.pro-brand').hide();
        $('.pro-parameters').show();
        $(".pro-details-box .bar-top b").animate({"left":"69%"});
        if($("#bar-top").hasClass("stickymark")){
            if($(".arouse-app").css("display")=="block"){
                $(window).scrollTop($(".more").offset().top-54)
            }else{
                $(window).scrollTop($(".more").offset().top)
            }
        }
    });


    window.onload = function() {
        var rushtime = $("#rushTime").attr("value");
        var longtime = $("#longTime").attr("value");
        var rushdiscount = $("#rushDiscount").attr("value");
        var begintoend = $("#beginToEnd").attr("value");
        var countprice =  $("#countprice").attr("value");

        if(rushtime == 1 || rushtime == 2){
            //活动未开始,活动进行中
            countDown(longtime,rushtime,begintoend);
        }else if(rushtime == 3){
            //活动已结束
            $("#qianggou").show().html("活动已结束");
        }else{
            //没有活动
            $("#qianggou").hide();
        }

        function countDown(longtime,rushtime,begintoend){
            var time =  longtime;
            time = parseInt(time / 1000);
            var day = Math.floor(time / (60*60*24));
            time -= day * (60*60*24);
            var hour = Math.floor(time /(60*60));
            time -= hour * (60*60);
            var minute = Math.floor(time / 60);
            var second = time - (minute * 60);
            if(day<10){
                if(day<0 && rushtime == 1){
                    // 切换到正在抢购
                    rushtime = 2;
                    window.setTimeout(function(){countDown(begintoend,rushtime,begintoend);},1000);
                }else if(day<0){
                    $("#qianggou").show().html("活动已结束");
                    $(".afterpri1").html("￥"+(countprice*1).toFixed(2).split(".")[0]+".");
                    $(".afterprispan").html((countprice*1).toFixed(2).split(".")[1]);
                    $(".preprice1").html("").hide();
                    return;
                }else{
                    day="0"+day;
                }
            }
            if(hour<10){
                hour="0"+hour;
            }
            if(minute<10){
                minute="0"+minute;
            }
            if(second<10){
                second="0"+second;
            }
            if(rushtime == 2){
                $(".preprice1 i").html((countprice*1).toFixed(2));
                $(".afterpri1").html("￥"+(countprice*rushdiscount).toFixed(2).split(".")[0]+".");
                $(".afterprispan").html((countprice*rushdiscount).toFixed(2).split(".")[1]);
                $(".preprice1").show();
            }
            if(rushtime == 1 && day==0&&hour==0&&minute==0&&second==1){
                $("#qianggou").show().html("距离抢购还有&nbsp;&nbsp;&nbsp;"+day+"天"+hour+"时"+minute+"分"+second+"秒");
                rushtime = 2;
                window.setTimeout(function(){countDown(begintoend,rushtime,begintoend);},1000);
            }else if(rushtime == 1){
                $("#qianggou").show().html("距离抢购还有&nbsp;&nbsp;&nbsp;"+day+"天"+hour+"时"+minute+"分"+second+"秒");
                longtime = longtime-1000;
                window.setTimeout(function(){countDown(longtime,rushtime,begintoend);},1000);
            }else if(day==0&&hour==0&&minute==0&&second==0){
                $("#qianggou").show().html("活动已结束");
                $(".afterpri1").html("￥"+(countprice*1).toFixed(2).split(".")[0]+".");
                $(".afterprispan").html((countprice*1).toFixed(2).split(".")[1]);
                $(".preprice1").html("").hide();
                return;
            }else{
                $("#qianggou").show().html("限时抢购剩余&nbsp;&nbsp;&nbsp;"+day+"天"+hour+"时"+minute+"分"+second+"秒");
                longtime = longtime-1000;
                window.setTimeout(function(){countDown(longtime,rushtime,begintoend);},1000);
            }
        }
    };
</script>
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
<script src="${basePath}/js/v1/goods_detailNew2.js"></script>
<script type="text/javascript" src="${basePath}/js/v1/arouse-app.js"></script>
<script type="text/javascript" src="${basePath}/js/v2/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="${basePath}/js/v2/jquery.section-scroll.js"></script>
<script type="text/javascript" src="${basePath}/js/v2/jquery.fly.min.js"></script>
<script type="text/javascript" src="${basePath}/js/v2/goodsdetail.js"></script>
</body>
</html>