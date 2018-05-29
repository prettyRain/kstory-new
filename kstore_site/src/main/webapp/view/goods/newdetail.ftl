<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <title>
    <#if map.detailBean.productVo.isThird='0'>
        <#if map.detailBean.productVo.goods.goodsSeoTitle?length &gt; 0>
        ${map.detailBean.productVo.goods.goodsSeoTitle!''}
        <#else>
        ${map.detailBean.productVo.productName!''}
        </#if>
        -${topmap.systembase.bsetName}
    <#else>
    ${map.detailBean.productVo.productName!''} -${topmap.systembase.bsetName}
    </#if>
    </title>

    <meta name="description" content="${map.detailBean.productVo.goods.goodsSeoDesc!''}-${topmap.seo.meteDes}">
    <meta name="Keywords" content="${map.detailBean.productVo.goods.goodsSeoKeyword}-${topmap.seo.meteKey}">
<#assign basePath=request.contextPath>
    <link rel="stylesheet" type="text/css" href="${basePath}/css/base.min.css" />
<#--<link rel="stylesheet" type="text/css" href="${basePath}/css/brand.css" />-->
    <link rel="stylesheet" type="text/css" href="${basePath}/css/index.css" />
<#--<link rel="stylesheet" type="text/css" href="${basePath}/index_seven/css/style.css" />-->
    <link rel="stylesheet" type="text/css" href="${basePath}/css/iCheck/custom.css" />
    <link rel="stylesheet" type="text/css" href="${basePath}/css/receive.m.css" />

    <link rel="stylesheet" href="${basePath}/css/ui-dialog.css"/>
    <style type="text/css">
        .enter_dp{display:block; float:left; width:75px; height:38px; border:1px solid #ddd; background:#f6f6f6; margin-left:18px;border-radius:2px; line-height:38px; text-align:center;}
        .business_area{width:210px;}
        .business_area .business_info{border:1px solid #ddd;padding:10px;}
        .business_area .business_info .name{display:block;padding-left:25px;background:url(${basePath}/images/business_icon.png) no-repeat left top;}
        .business_area .business_info .name a{font-size:14px;font-weight:bold;line-height:20px;font-family:"微软雅黑", "宋体";}
        .business_area .approve{padding:10px 0;margin:10px 0;border-top:1px dotted #ddd;border-bottom:1px dotted #ddd;}
        .business_area .approve ul li{float:left;display:block;width:62px;height:26px;line-height:26px;font-size:14px;font-weight:bold;font-family:"微软雅黑", "宋体";padding-left:30px;color:#666;}
        .business_area .approve ul .item1{background:url(${basePath}/images/approve_icon.png) no-repeat left top;}
        .business_area .approve ul .item2{background:url(${basePath}/images/approve_icon.png) no-repeat left -26px;}
        .business_area .enter_shop{display:block;width:187px;height:36px;background:url(${basePath}/images/enter_shop.png) no-repeat;text-indent:-9999px;outline:none;}
        .dp_detail table tr td{ line-height:26px; color:#666; font-size:14px; font-family:"微软雅黑";}
        .dp_detail{border-bottom:1px dotted #ddd;}
        .publish_cmt {width: 200px;}
        .recommend_point {margin-left:25px; border-right:1px solid #eee; width:350px; height:90px; padding:0;}
        .customer_service:hover, .feedback:hover {background:#c33;}
        .customer_service:hover em, .feedback:hover em {font-size:12px; position:relative; top:3px; font-style:normal;}
        .customer_service b {background:url(/index_seven/images/-01.png) #fff no-repeat center center!important;}
        .feedback b {background:url(/index_seven/images/-02.png) #fff no-repeat center center!important;}
        .customer-box{position:absolute;background:#efefef;width:146px;min-height:150px;border:1px solid #ccc;padding:9px;right:50px;display:none;top:20px!important}
        .sideBar .customer-box a{width:auto;height:auto;background-color:transparent;border:none;line-height:normal}
        .close-cs{position:absolute!important;top:10px;right:10px;background:url(/index_seven/images/agree_close1.gif) no-repeat;width:10px!important;height:10px!important;display:block}
        .customer-box p {overflow:hidden; margin-top:10px;}
        .customer-box p .qq_name {float:right;}
        .customer-box p .qq_img {float:left;}
        .sideBar a span {font-size:12px!important; padding:2px 5px; width:28px!important; line-height:normal!important;}
        .onlineServiceQQ {height:100px;overflow-y:auto;}
        /* 设置滚动条的样式 */
        .onlineServiceQQ::-webkit-scrollbar {width:5px; }
        /* 滚动槽 */
        .onlineServiceQQ::-webkit-scrollbar-track { -webkit-box-shadow:inset006pxrgba(0,0,0,0.3); border-radius:0; }
        /* 滚动条滑块 */
        .onlineServiceQQ::-webkit-scrollbar-thumb{border-radius:0;background:rgba(0,0,0,0.1);-webkit-box-shadow:inset006pxrgba(0,0,0,0.5)}
        .sideBar{position:fixed;top:30%;right:50px;z-index:101}
        .sideBar a{display:block;width:38px;height:38px;border:1px solid #e8e8e8;text-align:center;line-height:38px;font-size:18px;color:#333;margin-top:-1px;background-color:#fff;position:relative}
        .customer_service em{display:none}
        .customer_service:hover,.feedback:hover{background:#c33}
        /*shf*/
        .footer{border:none!important;}
        .product_wp{margin-bottom:15px;}
        .details_box .details-more{width:100%;}
        .detail_show img {display: block;margin: 0 auto;width:95%;}/*详情图片居中*/
        .dia2{
            min-height: 160px;
        }
        .choose_type .choose_item {
            margin-right: 16px!important;
            padding: 4px 5px;
        }
        .browse_product .bigwarp .product{
            -moz-transition: transform 0.5s;
            -o-transition: transform 0.5s;
            -webkit-transition: transform 0.5s;
            transition: transform 0.5s;
        }
        .browse_product .bigwarp .product:hover{
            transform: translateY(-10px);
            -moz-transform: translateY(-10px);
            -o-transform: translateY(-10px);
            -webkit-transform: translateY(-10px);
        }
         .info_tip_title{
           line-height: 37px!important;
        }
        .iphoe_div_erweimaw a:hover{
            color: #7D7D7D;
        }
        .user_img{
            cursor: default;
        }
        .uname a{
            cursor: default;
        }
        .uname a:hover{
            color: #df1738;
        }
        .nohand{
            cursor: default!important;
        }
    </style>
<#--shf改版新增的样式文件-->
    <link href="https://cdn.bootcss.com/Swiper/3.4.2/css/swiper.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${basePath}/css/newdetail-mend.css" />
<#if (topmap.systembase.bsetHotline)??>
    <link rel = "Shortcut Icon" href="${(topmap.systembase.bsetHotline)!''}">
<#else>
    <link rel = "Shortcut Icon" href="${basePath}/images/Paistore.ico">
</#if>
</head>
<body>
<input type="hidden" value="${basePath}" id="basePathVal"/>
<#--一引入头部 <#include "/index/topnew.ftl" /> -->
<#if (topmap.temp)??>
    <#if (topmap.temp.tempId==1)>
        <#include "../index/topnew.ftl">
    <#elseif (topmap.temp.tempId==3)>
        <#include "../index/newheader.ftl">
    <#elseif (topmap.temp.tempId==9)>
        <#include "../index/newheader4.ftl">
    <#elseif (topmap.temp.tempId==10)>
        <#include "../index/newheader5.ftl">
    <#elseif (topmap.temp.tempId==11)>
        <#include "../index/newheader6.ftl">
    <#elseif (topmap.temp.tempId==12)>
        <#include "../index/newheader7.ftl">
    <#elseif (topmap.temp.tempId==13)>
        <#include "../index/newheader8s.ftl">
    <#elseif (topmap.temp.tempId==14)>
        <#include "../index/newheader9.ftl">
    <#elseif (topmap.temp.tempId==15)>
        <#include "../index/newheader10.ftl">
    <#elseif (topmap.temp.tempId==16)>
        <#include "../index/newheader11.ftl">
    <#elseif (topmap.temp.tempId==17)>
        <#include "../index/newheader12.ftl">
    <#elseif (topmap.temp.tempId==18)>
        <#include "../index/newheader13.ftl">
    <#elseif (topmap.temp.tempId==19)>
        <#include "../index/newheader14.ftl">
    <#elseif (topmap.temp.tempId==20)>
        <#include "../index/newheader15.ftl">
    <#elseif (topmap.temp.tempId==21)>
        <#include "../index/newheader21.ftl">
    <#else>
        <#include "../index/newheader3.ftl">
    </#if>
</#if>
<div class="container clearfix">
    <div class="page_locate mt10">
        <input type="hidden" class="bread_crumb_cat_id" value="${map.detailBean.productVo.goods.catId}" data-role="detail" />
        <input type="hidden" class="first_catId" value="${map.detailBean.cateVo.parentCat.catParentId}" />
    <#--<input type="hidden" class="index_url">-->
        <input type="hidden" value="${map.isFollow!''}" id="isFollow">
        <em><a style="font-size: 14px;color: #020202;"  href="${basePath}/index.html">首页</a></em>
        <#--隐藏内有大聚会面包屑-->
        <#if map.channel?? && map.channel.channelId!=247>
            &nbsp;&gt;&nbsp;
            <a style="font-size: 14px;color: #020202;" href="${basePath}/channel/${map.channel.channelId!''}.html">${map.channel.channelName}</a>
        </#if>
        &nbsp;&gt;&nbsp;
    <#if map.detailBean.cateVo.parentCat?? >
        <a style="font-size: 14px;color: #020202;cursor:default;" <#--href="${basePath}/list/${map.detailBean.cateVo.parentCat.catId}-${map.detailBean.cateVo.parentCat.catParentId}.html"-->href="javascript:void(0);">${map.detailBean.cateVo.parentCat.catName}</a>
    </#if>
    <#-- &nbsp;&gt;&nbsp;-->
    <#--<span>${map.detailBean.productVo.productName}</span>-->
    </div><!--/page_locate-->

    <div class="left_wp fl" id="relative-data" style="margin-top:10px;margin-right:35px;">
        <input id="rightbarcolor" type="hidden" value="${map.channel.keyword!''}"/>
        <div class="relevant">
            <div class="title">相关分类</div>
            <ul class="clearfix pt10 pb10" id="relativeCatGoods">

            </ul>
        </div>

        <div class="relevant">
            <div class="title">相关品牌</div>
            <ul class="clearfix pt10 pb10" id="relativeBrandGoods">
            </ul>
        </div>
    <#--新增相关产品-->
    <#if map.detailBean.releProductList??>
        <div class="relevant about_product">
            <div class="title">相关产品</div>
            <ul class="clearfix pt10 pb10" id="relativeProductGoods">
                <#list map.detailBean.releProductList as product>
                    <#if product??>
                        <li>
                            <a class="" target="_blank" title="${product.goodsInfoName}" href="${basePath}/item/${product.goodsInfoId}.html">
                                <img alt="${product.goodsInfoName}" src="${product.goodsInfoImgId}" target="_blank">
                                <div class="sidebar-title">${product.goodsInfoName}</div>
                                <div class="sidebar-charge">￥${product.goodsInfoMarketPrice?string("0.00")}</div>
                            </a>
                        </li>
                    </#if>
                </#list>
            </ul>
        </div>
    </#if>
    <#--<div class="left_box">-->
    <#--<h3>删除删除</h3>-->
    <#--&lt;#&ndash;<h3>浏览该商品的用户最终购买</h3>&ndash;&gt;-->
    <#--<ul class="show_list mt10" id="finalBuyGoods">-->

    <#--</div>-->

    <#--<div class="left_box" id="hotSalesGoodsRanking">-->
    <#--<h3>热销排行榜</h3>-->

    <#--</div>-->
    <#-- <#if map.detailBean.releProductList??>
         <div class="left_box">
             <h3>浏览了该商品的用户还浏览了</h3>
             <ul class="show_list mt10">
                 <#list map.detailBean.releProductList as product>
                     <#if product??>
                         <li>
                             <div class="browse_img"><a alt="${product.goodsInfoName}" title="${product.goodsInfoName}" target="_blank" href="${basePath}/item/${product.goodsInfoId}.html"><img class="lazy" alt="${product.goodsInfoName}" title="${product.goodsInfoName}" data-original="${product.goodsInfoImgId!''}"  width="182" height="182" /></a></div>
                             <p class="browse_name mt5"><a alt="${product.goodsInfoName}" title="${product.goodsInfoName}" target="_blank" href="javascript:;">${product.goodsInfoName}</a></p>
                             <p class="browse_price mt5">¥ ${product.goodsInfoPreferPrice?string("0.00")}</p>
                         </li>
                     </#if>
                 </#list>
             </ul><!--/show_list&ndash;&gt;
         </div><!--/left_box&ndash;&gt;
     </#if>-->
    </div><!--/left_wp-->



    <!-- 保存商品参数部分相关参数 -->
    <form id="paramGoodsForm" action="${map.detailBean.productVo.goodsInfoId}.html" method="post">
        <input  type="hidden" name="chAddress" class="ch_address" value="${map.chAddress}" />
        <input type="hidden" name="chProvince" class="ch_province" value="${map.chProvince}" />
        <input type="hidden" name="chCity" class="ch_city" value="${map.chCity}" />
        <input type="hidden" name="chDistinct" class="ch_distinct" value="${map.chDistinct}" />
        <input type="hidden" name="distinctId" class="ch_distinctId" value="${map.distinctId}"  />
        <input type="hidden" class="productStock" value="${map.detailBean.productVo.goodsInfoStock}" />
    </form>


<#list map.detailBean.groupVos as group>
    <#if group.groupPrefertype?? && group.groupPrefertype=="0">
        <#assign boxfl=0>
    </#if>
    <#if group.groupPrefertype?? && group.groupPrefertype=="1">
        <#assign isT=1>
    </#if>
</#list>

    <div class="content clearfix mt10" style="margin-top: 0">

        <div class="right_wp fr">

            <div class="product_wp clearfix">
                <div class="img_preview fl">
                    <div class="big_img">
                        <a class="cloud-zoom" id="zoom" rel="adjustX:10,adjustY:0" href="<#if map.detailBean.productVo.imageList?? && map.detailBean.productVo.imageList[0]??>${map.detailBean.productVo.imageList[0].imageArtworkName!''}</#if>">
                            <img alt="" src="<#if map.detailBean.productVo.imageList?? && map.detailBean.productVo.imageList[0]??>${map.detailBean.productVo.imageList[0].imageBigName!''}</#if>" width="330" height="330" />
                        </a>
                    </div><!--/big_img-->
                    <div class="thumb_img clearfix mt10 pr">
                        <div class="thumb_scroll_wp">
                            <ul class="clearfix">
                            <#if map.detailBean.productVo.imageList??>
                                <#list map.detailBean.productVo.imageList as image>
                                    <li <#if image_index==0>class="cur"</#if>>
                                        <a class="cloud-zoom-gallery" href="${image.imageArtworkName!''}" rel="useZoom:'zoom',smallImage:'${image.imageBigName!''}'">
                                            <img style="cursor: default;" alt="" src="${image.imageInName!''}"/>
                                        </a>
                                    </li>
                                </#list>
                            </#if>
                            </ul>
                        </div><!--/thumb_scroll_wp-->
                    <a class="thumb_scroll_prev disabled" href="javascript:;"></a>
                    <a class="thumb_scroll_next disabled" href="javascript:;"></a>
                    </div><!--/thumb_img-->

                    <div class="thumb_op mt15 clearfix pr">
                    <#--<a class="add_contrast fl compare" id="compare${map.detailBean.productVo.goodsInfoId}" product_id="${map.detailBean.productVo.goodsInfoId}" href="javascript:;" >加入对比</a>-->
                        <div class="share_wp fl" style="margin-top:5px;">
                            <script "text/javascript">
                            var jiathis_config = {
                            <!-- 分享网址 -->
                            url: "${topmap.mobSite.siteAddress}/item/${map.detailBean.productVo.goodsInfoId}.html?isWx=wx",
                            <!-- 获取页面标题内容 -->
                            title: "<#if map.detailBean.productVo.goods.goodsSeoTitle?length &gt; 0> ${map.detailBean.productVo.goods.goodsSeoTitle!''}<#else>${map.detailBean.productVo.productName!''}</#if> -${topmap.systembase.bsetName}",
                            <!-- 获取SEO描述内容 -->
                            summary:"${map.detailBean.productVo.goods.goodsSeoDesc!''}-${topmap.seo.meteDes}"
                            }
                            </script>
                            <#--<script src="http://v2.jiathis.com/code/jiathis_r.js?move=0"></script>-->

                            <#--<!-- JiaThis Button BEGIN &ndash;&gt;-->
                            <#--<div class="jiathis_style">-->
                            <#--<a class="jiathis_button_qzone"></a>-->
                            <#--<a class="jiathis_button_tsina"></a>-->
                            <#--<a class="jiathis_button_tqq"></a>-->
                            <#--<#if map.detailBean.productVo.showMobile?? && map.detailBean.productVo.showMobile=='1'>-->
                            <#--<a class="jiathis_button_weixin"></a>-->
                            <#--</#if>-->

                            <#--<a class="jiathis_button_renren"></a>-->
                            <#--<a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jtico jtico_jiathis" target="_blank"></a>-->
                            <#--<a class="jiathis_counter_style"></a>-->
                            <#--</div>-->
                            <#--<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>-->
                            <#--<!-- JiaThis Button END &ndash;&gt;-->
                            <!-- JiaThis Button BEGIN -->
                            <div class="jiathis_style"><span class="jiathis_txt" style="font-family: Helvetica Neue, Helvetica, tahoma, arial, 微软雅黑, 宋体;">分享到：</span>
                            <a class="jiathis_button_qzone"></a>
                                    <a class="jiathis_button_tsina"></a>
                                    <a class="jiathis_button_cqq"></a>
                                    <a class="jiathis_button_weixin"></a>
                                    <a class="jiathis_button_tqq" style="width" display="inline-block"></a>
                                    <!--<a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"></a>-->
                                    </div>
                                    <script type="text/javascript" >
                            var jiathis_config={
                                summary:"",
                                shortUrl:true,
                                hideMore:true
                            }
                            </script>
                            <script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
                            <!-- JiaThis Button END -->

                        </div>

                        <a class="store-goods fr cllect_btn"  product_id="${map.detailBean.productVo.goodsInfoId}" style="margin-bottom:5px;">
                            <i></i>
                            收藏
                        </a>

                    </div><!--/thumb_op-->
                </div><!--/img_preview-->

                <div class="product_info fl ml20">
                    <input type="hidden" id="goodsId" value="${map.detailBean.productVo.goodsId}" />
                    <input type="hidden" id="productId" value="${map.detailBean.productVo.goodsInfoId}" />
                    <input type="hidden" id="brandId" value="${map.detailBean.brand.brandId}" />
                    <input type="hidden" id="catId" value="${map.detailBean.productVo.goods.catId}" />
                    <input type="hidden" id="isCustomerDiscount" value="${map.detailBean.productVo.isCustomerDiscount}">
                    <input type="hidden" class="bread_crumb_cat_id" value="${map.detailBean.productVo.goods.catId}" data-role="detail" />
                    <div class="pd_title">
                        <h2>${map.detailBean.productVo.productName!''}</h2>
                        <strong>${map.detailBean.productVo.subtitle!''}</strong>
                    </div><!--/pd_title-->

                    <input type="hidden" id="disId" value="${map.distinctId}"/>
                    <input type="hidden" id="followPrice" value="${map.detailBean.productVo.goodsInfoPreferPrice}"/>

                    <dl class="pd_info clearfix mt10">
                        <div class="pd-bg clearfix" style="position: relative;">
                            <div class="saleswarp">
                                <div class="moresales" style="color:#FE7425; opacity: 1;">展开促销</div>
                                <div class="moreinfo">
                                <#-- <div style="position: relative;"><img class="img_img"src=" ${basePath}/images/cuxiao/manzengcuxiao1.png" ><p class="div_title">涨逾九成浦沅蛇龙珠干红葡萄酒</p></div>
                                    <div style="position: relative;"><img class="img_img"src=" ${basePath}/images/cuxiao/manzengcuxiao1.png" ><p class="div_title">涨逾九成浦沅蛇龙珠干红葡萄酒</p></div>
                                    <div style="position: relative;"><img class="img_img"src=" ${basePath}/images/cuxiao/manzengcuxiao1.png" ><p class="div_title">涨逾九成浦沅蛇龙珠干红葡萄酒</p></div>
                                    <div style="position: relative;"><img class="img_img"src=" ${basePath}/images/cuxiao/youhuijuan.png" ><p class="div_title">涨逾九成浦沅蛇龙珠干红葡萄酒</p><span class="coupon_span">已领取</span></div>
                                    <div style="position: relative;"><img class="img_img"src=" ${basePath}/images/cuxiao/youhuijuan.png" ><p class="div_title">涨逾九成浦沅蛇龙珠干红葡萄酒</p><span class="coupon_span coupon_active" >立即领取</span></div>
                                    &lt;#&ndash;<div>618&nbsp;&nbsp;&nbsp;&nbsp;满100元增<span>牛羊肉一斤</span>(赠完为止)</div>
                                    <div>618&nbsp;&nbsp;&nbsp;&nbsp;满50元直降15元</div>&ndash;&gt;-->
                                </div>
                            </div>
                        <#--<div class="moresales spread">展开促销</div>
                        <ul class="moreinfo">
                            &lt;#&ndash;<li>618&nbsp;&nbsp;&nbsp;&nbsp;满100元增<span>牛羊肉一斤</span>(赠完为止)</li>
                            <li>618&nbsp;&nbsp;&nbsp;&nbsp;满50元直降15元</li>&ndash;&gt;
                        </ul>-->
                        <#--<div class="cxyj" style="display:none;"><dt>原&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价</dt>
                            <dd><del class="f14 col6" style=" margin-left: 6px;display: inline-block;">${map.detailBean.productVo.goodsInfoPreferPrice?string("0.00")}</del></dd>
                        </div>-->

                            <dt id="priceflr" style="letter-spacing: 0.3px;opacity: 0.45;">商&nbsp;&nbsp;城&nbsp;&nbsp;价</dt>
                            <dd>
                                <span class="main_price"  style="line-height: 23px;display: inline-block; margin-left: 5px;vertical-align: middle"><span>¥ </span>${map.detailBean.productVo.goodsInfoPreferPrice?string("0.00")}</span>
                                <div class="cxyj">￥<span class="f14 col6">${map.detailBean.productVo.goodsInfoPreferPrice?string("0.00")}</span></div>
                                <span style="color: #F20010;" id="zk_price">&nbsp;</span><input type="hidden" id="mprice" value="${map.detailBean.productVo.goodsInfoPreferPrice?string("0.00")}"/>

                            </dd>
                        <#if map.detailBean.productVo.unitPriceStr??&&map.detailBean.productVo.unitPriceStr!=''>
                            <dt style="letter-spacing: 0.5px;opacity: 0.45;">单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价</dt>
                            <dd style="font-size: 14px;margin: 0 0 5px 16px;;line-height: 25px;" >
                            <#--<span style="color: #999;" >${map.detailBean.productVo.goods.unitPrice?string("0.00")}元/500克</span>-->
                                <span style="color: #000000; opacity: 0.45;margin-left: 5px;display: inline-block;" >${map.detailBean.productVo.unitPriceStr}</span>
                            </dd>
                        <#else>
                            <dt style="letter-spacing: 0.5px;opacity: 0.45;">单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价</dt>
                            <dd style="font-size: 14px;margin: 0 0 5px 16px;;line-height: 25px;" >
                            <#--<span style="color: #999;" >${map.detailBean.productVo.goods.unitPrice?string("0.00")}元/500克</span>-->
                                <span style="color: #000000; opacity: 0.45; margin-left: 5px;display: inline-block;" >无</span>
                            </dd>
                        </#if>

                            <dt style=" letter-spacing: 1.3px;opacity: 0.45;">商品编码</dt>
                            <dd style="opacity: 0.45;margin-left: 20px;letter-spacing: 1px;">${map.detailBean.productVo.goodsInfoItemNo}</dd>
                        <#-- <dd class="product_market "></dd>-->
                            <dt id="evaluate" style="clear:none;position: absolute;right: 21px; top: 40px;opacity: 0.45;">累计评价</dt>
                            <dd>
                             <span class="evaluate_number" style="font-size: 10px;color: #000000; opacity: 0.45;position:absolute; right: 45px;top: 55px; display: block;width: 45px;text-align: center;" >
                             <#if map.commentCount??>
                                 <#if (map.commentCount==0)>
                                     暂无
                                 <#elseif (map.commentCount<10)&&(map.commentCount>0)>
                                     0${map.commentCount}
                                 <#elseif (map.commentCount>=10&&map.commentCount<100)>
                                 ${(map.commentCount/10)?int}0+
                                 <#elseif (map.commentCount>=100&&map.commentCount<1000)>
                                 ${(map.commentCount/100)?int}00+
                                 <#elseif (map.commentCount>=1000)>
                                 ${(map.commentCount/100)?int}00+
                                 </#if>
                             <#else>暂无
                             </#if>
                             </span>
                            </dd>
                        </div>
                        <div class="pl20 pr20 pt10">
                        <#--<dt>评&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;分</dt>-->
                        <#--<dd><div class="star_wp" ><span class="star star_<#if map.detailBean.productVo.commentUtilBean??>${map.detailBean.productVo.commentUtilBean.score?substring(0,1)}</#if>_0"></span></div><a class="comment_target" href="javascript:;">（共有<#if map.detailBean.productVo.commentUtilBean??>${map.detailBean.productVo.commentUtilBean.count}<#else>0</#if>条评价）</a></dd>-->
                            <dt style="margin-top: 10px;letter-spacing: 0.3px;opacity: 0.45;">配&nbsp;&nbsp;送&nbsp;&nbsp;至</dt>
                            <dd>
                                <div class="choose_area fl pr" style="margin-left:0px;margin-top: 10px;">
                                    <div class="area_text choose_btn"><#if (map.chAddress?length>17)>${map.chAddress?substring(0,17)}<#else>${map.chAddress}</#if><b></b></div>
                                    <div class="locate_cont">
                                        <ul class="locate_tabs clearfix">
                                            <li class="cur show_province"><a href="javascript:;"><span class="province_text">${map.chProvince}</span><b></b></a></li>
                                            <li class="show_city" ><a href="javascript:;" ><span class="city_text">${map.chCity}</span><b></b></a></li>
                                            <li class="show_distinct"><a href="javascript:;" ><span class="distinct_text">${map.chDistinct}</span><b></b></a></li>
                                        </ul><!--/locate_tabs-->
                                        <div class="locate_wp">
                                            <ul class="locate_list clearfix province_list">
                                            </ul><!--/locate_list-->
                                            <ul class="locate_list clearfix city_list">
                                            </ul><!--/locate_list-->
                                            <ul class="locate_list clearfix distinct_list">
                                            </ul><!--/locate_list-->
                                        </div><!--/locate_wp-->
                                    <#--<a class="close_area" href="javascript:;"></a>-->
                                    </div><!--/locate_cont-->
                                </div><!--/choose_area-->
                                <div class="store-prompt fl ml10"><em style=" margin-top: 10px;display: inline-block;color: #333;font-weight: normal;">
                                <#if (map.detailBean.productVo.goodsInfoStock>0) >
                                    有货
                                <#else>
                                    无货
                                </#if></em><!--11:00前完成下单，预计今天（6月27日）送达--><span class="baoyou"></span></div>

                            </dd>
                        <#--<dt style="margin-top:8px;">服&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;务</dt>-->
                        <#--<dd style="margin-top:8px;    margin-bottom: 0px;">由“<#if map.detailBean.productVo.isThird='0'>${topmap.systembase.bsetName!''}<#else>${map.detailBean.productVo.thirdName!''}</#if>”直接销售和发货，并提供售后服务</dd>-->
                        <#if map.detailBean.productVo.productName?? && map.detailBean.productVo.productName?index_of("批发")!=-1>
                            <dd style="margin:0;color: #31A420;letter-spacing: 0.3px;font-size: 12px;">批发商品北京所有地区均可派送</dd>
                        </#if>
                            <dd>
                                <div class="wx_prompt clearfix">
                                <#if map.detailBean??&&map.detailBean.suppList??&&map.detailBean.suppList?size!=0>
                                    <#list map.detailBean.suppList as supp>
                                        <#if supp.serviceSupp??>
                                            <#if supp.serviceSupp.serviceImageUrl??>
                                                <img src="${supp.serviceSupp.serviceImageUrl!''}" height="20px;" width="20px;" style="float:left;"/>
                                            </#if>
                                            <#if supp.serviceSupp.helpId?? && supp.serviceSupp.serviceName??>
                                                <a class="fl" target="_blank" href="${basePath}/help/${supp.serviceSupp.helpId!''}">${supp.serviceSupp.serviceName!''}</a>
                                            </#if>
                                        </#if>
                                    </#list>
                                </#if>
                                </div><!--/wx_prompt-->
                            </dd>
                        </div>
                    </dl><!--/pd_info-->


                    <dl class="buy_info mt20 clearfix pl20" style="    margin-top: 4px; position: relative;">
                        <input type="hidden" id="allSpecLength" value="${map.detailBean.productVo.specVo?size}" />


                    <#list map.openSpec as spec>
                       <#if spec.spec.specName?? && spec.spec.specName?index_of("规格")!=-1>
                           <dt style="margin-top: 9px;letter-spacing: 0.5px;opacity: 0.45;" class="spec_name" data-value="${spec.specId}">${spec.spec.specName?substring(0,1)}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${spec.spec.specName?substring(1)}</dt>
                       <#elseif spec.spec.specName?? && spec.spec.specName?index_of("卡种")!=-1>
                           <dt style="margin-top: 9px;letter-spacing: 0.5px;opacity: 0.45;" class="spec_name" data-value="${spec.specId}">${spec.spec.specName?substring(0,1)}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${spec.spec.specName?substring(1)}</dt>
                       <#else>
                           <dt style="margin-top: 9px;letter-spacing: 1.3px;opacity: 0.45;" class="spec_name" data-value="${spec.specId}">${spec.spec.specName?substring(0,1)}${spec.spec.specName?substring(1)}</dt>
                       </#if>

                        <dd >
                            <div class="choose_type clearfix">
                                <#list spec.specValList as specvalue>
                                    <a class="choose_item _sku" style=" margin-top: 3px;   margin-bottom: 0px;display:none;" onClick="clickSpecDetail(this,false);" data-parent="${spec.spec.specId}" data-value="${specvalue.specDetail.specDetailId}" title="${specvalue.specValueRemark}" href="javascript:;">
                                        <#if specvalue.imgUrl?? && specvalue.imgUrl!=''>
                                            <img alt="" width="25px" height="25px" src="${specvalue.imgUrl}" />
                                        </#if>
                                        <em>${specvalue.specValueRemark}</em><b></b></a>
                                </#list>
                            </div><!--/choose_img-->
                        </dd>
                    </#list>
                        <!-- 保存已经选择的规格值 -->
                        <div class="hide">
                        <#if (map.detailBean.productVo.specVo??)>
                            <#list map.detailBean.productVo.specVo as spec>
                                <input type="hidden" class="chooseParamId" value="${spec.goodsSpecDetail.specDetailId!''}" data-spec="${spec.spec.specName!''}" data-detail="${spec.specValueRemark!''}" />
                            </#list>
                        </#if>
                        </div>

                        <dt style="letter-spacing: 0.5px;opacity: 0.45;">数&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;量</dt>
                        <dd style="width: 80%;position: relative;">
                            <a class=" num_minus fl" onclick="minus(this)" href="javascript:;"></a>
                            <#--<a class="minus num_minus fl" href="javascript:;"></a>-->
                            <input class="min_text num_text fl product_buy_num" onblur="product_buy_num(this)"type="text" value="1" />
                            <a class=" num_plus fl" onclick="plus(this)" href="javascript:;"></a>
                            <#--<a class="plus num_plus fl" href="javascript:;"></a>-->
                        <#if map.openSpec?size &gt; 0>
                            <p class="selected_type pl20 f14" style="opacity: 0.45;color: #000000;">已&nbsp;选&nbsp;择 <span class="check_param" style="margin-left: 9px;color: #000;opacity: 0.7;"></span></p>
                        </#if>
                        </dd>



                    </dl><!--/buy_info-->

                <#--auth 商品认证标识-->
                    <div class="mall_certification">
                        <p  style="opacity: 0.45;">商城认证</p>
                    <#--<div class="iphoe_div_erweima" id="mobile_code"></div>-->
                    </div>


                    <div style="margin-left: 16px;margin-top: 3px;" class="brand1">
                    <#if map.auths??>
                        <#list map.auths as auth>
                            <a title="${auth.authName}" style="cursor: default;">
                                <img src="${auth.authsrc}"  style="height:56px;width:56px;margin-right: 54px;"/>
                            </a>

                        </#list>
                    </#if>
                    </div>
                    <div class="by_cart mt20 clearfix" style="    margin-top: 13px;">
                    <#if (map.detailBean.productVo.goodsInfoStock>0)>
                    <#-- <a class="collect_pro mr20 go_buy" sellType="${map.detailBean.sellType}" product_id="${map.detailBean.productVo.goodsInfoId}" product_stock="${map.detailBean.productVo.goodsInfoStock}" distinct_id="${map.distinctId}"  >立即购买</a>-->
                        <a class="collect_pro mr20 go_buy"
                            <#if map.detailBean.productVo.productName?index_of("零售")!=-1>
                           sellType="0"
                            </#if>
                            <#if map.detailBean.productVo.productName?index_of("零售")!=-1>
                           sellType="1"
                            </#if>
                           product_id="${map.detailBean.productVo.goodsInfoId}" product_stock="${map.detailBean.productVo.goodsInfoStock}" distinct_id="${map.distinctId}"  >立即购买</a>
                        <a class="add_cart"  product_id="${map.detailBean.productVo.goodsInfoId}" product_stock="${map.detailBean.productVo.goodsInfoStock}" distinct_id="${map.distinctId}" href="javascript:;">加入购物车</a>
                        <div class="iphoe_div_erweimaw">
                            <a class="phone_orders"  style="cursor:default;"  href="javascript:;">
                                <i></i>手机下单<i class="phone_orders_i"></i>

                                <div class="iphoe_div_erweima" id="mobile_code"></div>



                            </a>

                        </div>





                    <#--<div class = "phone_orders_active">-->
                    <#--<img alt="" src="http://boss.ge960.com:80/upload/20170329/1490757244483!352.jpg">-->
                    <#--<a class="phone_orders"   href="javascript:;"> <i></i>手机单单<i class="phone_orders_i"></i></a>-->
                    <#--</div>-->
                    <#--<div class="iphoe_div_erweima" id="mobile_code">-->


                    <#else>
                        <a class="dis_cart" href="javascript:;"><i></i>加入购物车</a>

                        <a class="arrival_notice" href="javascript:;"><i></i>到货通知</a>
                        <div class="iphoe_div_erweima" id="mobile_code" style="display: none"></div>
                    </#if>
                    <#--<a class="add_contrast fl compare" id="compare${map.detailBean.productVo.goodsInfoId}" product_id="${map.detailBean.productVo.goodsInfoId}" href="javascript:;" >加入对比</a>-->


                    <#--<#if map.detailBean.productVo.isThird=='1'>-->
                    <#--<a class="enter_dp" third_id="${map.detailBean.productVo.thirdId}" href="${basePath}/thirdstoreindex/${map.detailBean.productVo.thirdId}" target="_blank">进入店铺</a>-->
                    <#--</#if>-->
                    </div><!--/by_cart-->

                </div><!--/product_info-->
            <#if map.detailBean.productVo.isThird=='1'>
                <div class="business_area fr">
                    <div class="business_info">
                        <p class="name">
                            <#if map.detailBean.storeInfo.isStoreIndex ?? && map.detailBean.storeInfo.isStoreIndex=="1">
                                <a href="${basePath}/thirdstoreindex/${map.detailBean.productVo.thirdId}">
                                ${map.detailBean.productVo.thirdName!''}</a>
                            <#else >
                            ${map.detailBean.productVo.thirdName!''}
                            </#if>
                        </p>

                        <div class="approve">
                            <ul>
                                <li class="item2"><a href="javascript:void(0)" class="collectstore">关注店铺</a></li>
                            </ul>
                            <div class="cb"></div>
                        </div>
                    <#--<div class="dp_detail">
                                <table>
                                    <tr>-->
                    <#--<td width="125">店铺动态评分</td>-->
                    <#--</tr>-->
                    <#--<tr>-->
                    <#--<td>综合评价：<span>-->
                    <#--<#if map.detailBean.comment??&&map.detailBean.comment.cscoreAvg??>-->
                    <#--<!--${(map.detailBean.comment.cscoreAvg)?string("0.0")}&ndash;&gt;-->
                    <#--<div class="star_wp"><span class="star star_${(map.detailBean.comment.cscoreAvg)?string("0.0")?substring(0,1)}_${(map.detailBean.comment.cscoreAvg)?string("0.0")?substring(2,3)}"></span></div>               						-->
                    <#--<#else>-->
                    <#--暂无评价-->
                    <#--</#if>-->
                    <#---->
                    <#--</span></td>-->
                    <#--</tr>-->
                        <!--<tr>
	                					<td>服务态度：<span>
	                					<#--<#if map.detailBean.comment??&&map.detailBean.comment.attscoteAvg??>
	                						<!--${(map.detailBean.comment.attscoteAvg)?string("0.0")}&ndash;&gt;
	                						<!--<div class="star_wp"><span class="star star_${(map.detailBean.comment.attscoteAvg)?string("0.0")?substring(0,1)}_${(map.detailBean.comment.attscoteAvg)?string("0.0")?substring(2,3)}"></span></div>
	                					<#else>
	                						  暂无评价
	                					</#if>-->
	                					</span></td>
	                				</tr>

	                				<tr>
	                					<td>发货速度：<span>
	                						<#--<#if map.detailBean.comment??&&map.detailBean.comment.dscoreAvg??>
	                							<!--${(map.detailBean.comment.dscoreAvg)?string("0.0")}&ndash;&gt;
	                							<!--<div class="star_wp"><span class="star star_${(map.detailBean.comment.dscoreAvg)?string("0.0")?substring(0,1)}_${(map.detailBean.comment.dscoreAvg)?string("0.0")?substring(2,3)}"></span></div>
		                					<#else>
		                						  暂无评价
		                					</#if>-->
	                					</span></td>
	                				</tr>

	                			</table>
	                		</div>-->
                        <#if map.detailBean.storeInfo.qqSwitch == '1'>
                            <div class="dp_detail" style="padding:5px 0px;">
                                <table>
                                    <tr>
                                        <#if map.detailBean??>
                                            <#if map.detailBean.storeInfo??>
                                                <#if map.detailBean.storeInfo.serviceQq??>
                                                    <td> <span class="fl">在线客服：</span><a target="_blank" class="fl" href="http://wpa.qq.com/msgrd?v=3&amp;uin=${(map.detailBean.storeInfo.serviceQq)!''}&amp;site=qq&amp;menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:${(map.detailBean.storeInfo.serviceQq)!''}:51" alt="点击这里给我发消息" title="点击这里给我发消息"></a></td>
                                                <#else>
                                                    <td> <span class="fl">在线客服：</span> 暂无在线客服</td>
                                                </#if>
                                            </#if>
                                        </#if>
                                    </tr>
                                </table>
                            </div>
                        </#if>
                        <div class="dp_detail">
                            <table>
                                <tr>
                                    <td>店铺名称：${(map.detailBean.storeInfo.storeName)!''}</td>
                                </tr>
                                <tr>
                                    <td>店铺地址：${(map.detailBean.storeInfo.companyAddrDel)!''}</td>
                                </tr>
                            </table>
                        </div>
                        <#if map.detailBean.storeInfo.isStoreIndex ?? && map.detailBean.storeInfo.isStoreIndex=="1">
                            <a href="${basePath}/thirdstoreindex/${map.detailBean.productVo.thirdId}" class="enter_shop" target="_blank"><del>进入店铺</del></a>
                        </#if>
                    </div><!-- /business_info -->
                </div>
            </#if>
            </div><!--/product_wp-->
        <#if boxfl??&&boxfl=0>
            <div class="group_box discount_group">
                <ul class="groups_tabs boxfl disc_tabs clearfix">
                    <#list map.detailBean.groupVos as group>
                        <#if group.groupPrefertype=="0">
                            <li><a href="javascript:;">${group.groupName}</a></li>
                        </#if>
                    </#list>
                </ul><!--/disc_tabs-->


                <div class="groups_wp disc_wp">
                    <#list map.detailBean.groupVos as group>
                        <#if group.groupPrefertype=="0">
                            <#assign preferPrice = 0>
                            <div class="groups_cont boxfl_count disc_cont clearfix">
                                <div style="width:980px; overflow-x:auto; float:left;">
                                    <ul class="gp_list fl clearfix">
                                    <#--<#list group.productList as product>-->
                                    <#--<#if product??&&product.productDetail??>-->
                                    <#--<#if product.productDetail.goodsInfoId == map.detailBean.productVo.goodsInfoId>-->
                                    <#--<li>-->
                                    <#--<div class="pg_img">-->
                                    <#--<a alt="${map.detailBean.productVo.productName}" title="${map.detailBean.productVo.productName}" target="_blank" href="${basePath}/item/${map.detailBean.productVo.goodsInfoId}.html"><img class="lazy" alt="${map.detailBean.productVo.productName}" title="${map.detailBean.productVo.productName}" data-original="${map.detailBean.productVo.goodsInfoImgId}"  width="120" height="120" /></a>-->
                                    <#--</div>-->
                                    <#--<p class="pg_name"><a alt="${map.detailBean.productVo.productName}" title="${map.detailBean.productVo.productName}" target="_blank" href="${basePath}/item/${map.detailBean.productVo.goodsInfoId}.html">${map.detailBean.productVo.productName}</a></p>-->
                                    <#--<div class="gp_check"><label class="m_check">¥ ${product.productDetail.goodsInfoPreferPrice?string("0.00")}</label><label style="color: #666 ">x<#if product.productNum??>${product.productNum}<#else>1</#if></label></div>-->
                                    <#--<#assign  preferPrice="${map.detailBean.productVo.goodsInfoPreferPrice?number+preferPrice?number}">-->
                                    <#--</li>-->
                                    <#--</#if>-->
                                    <#--</#if>-->
                                    <#--</#list>-->

                                        <#list group.productList as product>

                                            <#if product??&&product.productDetail??>
                                                <#if product.productNum??>
                                                    <#assign  productNum="${product.productNum}">
                                                </#if>
                                                <#if !product.productNum??>
                                                    <#assign  productNum="1">
                                                </#if>


                                                <li <#if product_index+1==group.productList?size>class="last_item"</#if>>
                                                    <div class="pg_img">
                                                        <a alt="${product.productDetail.goodsInfoName!''}" title="${product.productDetail.goodsInfoName!''}" target="_blank" href="${basePath}/item/${product.productDetail.goodsInfoId!''}.html"><img class="lazy" alt="${product.productDetail.goodsInfoName!''}" title="${product.productDetail.goodsInfoName!''}" data-original="${product.productDetail.goodsInfoImgId}"  width="120" height="120" /></a>
                                                    </div>
                                                    <p class="pg_name"><a alt="${product.productDetail.goodsInfoName!''}" title="${product.productDetail.goodsInfoName!''}" target="_blank" href="${basePath}/item/${product.productDetail.goodsInfoId}.html">${product.productDetail.goodsInfoName!''}</a></p>
                                                    <div class="gp_check"><label class="m_check" style="background: none">¥ ${product.productDetail.goodsInfoMarketPrice?string("0.00")}</label><label style="color: #666 ">x<#if product.productNum??>${product.productNum}<#else>1</#if></label></div>
                                                    <#assign  preferPrice="${product.productDetail.goodsInfoMarketPrice?number*productNum?number+preferPrice?number}">
                                                </li>
                                            </#if>
                                        </#list>
                                    </ul><!--/gp_list--></div>
                                <div class="gp_result fr">
                                    <div class="gp_name"><a href="javascript:;">购买${group.groupName}</a></div>
                                    <p>销售价：<b>¥</b> ${((preferPrice?number-group.groupPreferamount?number)?number)?string("0.00")}</p>
                                <#--<p>市场价：<del><b>¥</b> ${preferPrice?number?string("0.00")}</del></p>-->
                                    <a class="buy_pre_group buy_group" data-group="${group.groupId}" href="javascript:;">购买套装</a>
                                </div><!--/gp_result-->
                            </div><!--/groups_cont-->
                        </#if>
                    </#list>
                </div><!--/groups_wp-->
            </div><!--/discount_group-->
        </#if>
        <#if map.detailBean.groupVos?size &gt; 0>
            <div class="group_box popular_group isshowdiv">
                <ul class="groups_tabs groupfl pop_tabs clearfix">
                    <#list map.detailBean.groupVos as group>

                        <#if group.groupPrefertype?? && group.groupPrefertype=="1">
                            <li><a href="javascript:;">${group.groupName}</a><input type="hidden" class="inputdiv"></li>
                        </#if>
                    </#list>
                </ul><!--/pop_tabs-->
                <div class="groups_wp pop_wp">
                    <#list map.detailBean.groupVos as group>
                        <#if group.groupPrefertype?? && group.groupPrefertype=="1">
                            <div class="groups_cont groupfl_count pop_cont clearfix">
                                <div class="gp_con">
                                    <ul class="gp_list fl clearfix" style="width: 1000px;">
                                    <#--<li>-->
                                    <#--<div class="pg_img">-->
                                    <#--<a alt="${map.detailBean.productVo.productName}" title="${map.detailBean.productVo.productName}" target="_blank" href="${basePath}/item/${map.detailBean.productVo.goodsInfoId}.html"><img class="lazy" alt="${map.detailBean.productVo.productName}" title="${map.detailBean.productVo.productName}" data-original="${map.detailBean.productVo.goodsInfoImgId}"  width="120" height="120" /></a>-->
                                    <#--</div>-->
                                    <#--<p class="pg_name"><a alt="${map.detailBean.productVo.productName}" title="${map.detailBean.productVo.productName}" target="_blank" href="${basePath}/item/${map.detailBean.productVo.goodsInfoId}.html">${map.detailBean.productVo.productName}</a></p>-->
                                    <#--<input type="hidden" class="group_base_price" value="${map.detailBean.productVo.goodsInfoPreferPrice?string("0.00")}" />-->
                                    <#--</li>-->
                                        <#list group.productList as product>
                                            <#if product_index == 0>
                                                <#if product.productNum??>
                                                    <#assign pn = "${product.productNum?number}">
                                                <#else>
                                                    <#assign pn = 1>
                                                </#if>
                                                <input type="hidden" id="nowPro" value="${pn?number}"/>
                                            </#if>
                                            <li <#if product_index+1==group.productList?size>class="last_item"</#if>>
                                                <div class="pg_img">
                                                    <a alt="${product.productDetail.goodsInfoName}" title="${product.productDetail.goodsInfoName}" target="_blank" href="${basePath}/item/${product.productDetail.goodsInfoId}.html"><img class="lazy" alt="${product.productDetail.goodsInfoName}" title="${product.productDetail.goodsInfoName}" data-original="${product.productDetail.goodsInfoImgId}"  width="120" height="120" /></a>
                                                </div>
                                                <p class="pg_name"><a alt="${product.productDetail.goodsInfoName}" title="${product.productDetail.goodsInfoName}" target="_blank" href="${basePath}/item/${product.productDetail.goodsInfoId}.html">${product.productDetail.goodsInfoName}</a></p>
                                                <div class="gp_check">
                                                    <label class="m_check" <#if product_index == 0>style="background: none"</#if>>
                                                        <#if product_index gt 0><input
                                                                class="vm mr5 check_group_product check_group_product_${group.groupId}"
                                                                data-group="${group.groupId}"
                                                                data-market="${product.productDetail.goodsInfoMarketPrice!''}"
                                                                data-price="${product.productDetail.goodsInfoPreferPrice?string("0.00")}"
                                                                <#if product.productNum??>data-sum="${product.productNum}"
                                                                <#else>data-sum="1"</#if>value="${product.productDetail.goodsInfoId}"
                                                                type="checkbox"></#if>
                                                        ¥ ${product.productDetail.goodsInfoPreferPrice?string("0.00")}
                                                    </label>
                                                    <label style="color: #666 ">x${product.productNum!1}</label></div>
                                            </li>
                                        </#list>
                                    </ul><!--/gp_list-->
                                </div>
                                <div class="gp_result fr">
                                    <div class="gp_name"><a href="javascript:;">购买${group.groupName}</a></div>
                                    <p>销售价：<b>¥</b> <span class="group_prefer_price_${group.groupId}">${(map.detailBean.productVo.goodsInfoPreferPrice?string("0.00")?number*pn?number)?string("0.00")}</span></p>
                                <#--<p>市场价：<del><b>¥</b> <span class="group_market_price_${group.groupId}">${map.detailBean.productVo.goodsInfoMarketPrice?string("0.00")}</span></del></p>-->
                                    <a class="buy_pak_group buy_group" data-group="${group.groupId}" href="javascript:;">购买组合</a>
                                </div><!--/gp_result-->
                            </div><!--/groups_cont-->
                        </#if>
                    </#list>
                </div><!--/groups_wp-->
            </div><!--/popular_group-->
        </#if>
            <div class="product_detail" style="border: 1px solid #eee;border-top:none">
                <div class="tit_wp">
                    <div class="det_title detail_nav clearfix">
                        <ul class="nav_tabs fl clearfix">
                            <li class="cur"><a href="javascript:;">商品详情</a></li>
                            <li><a href="javascript:;">规格参数</a></li>
                            <li><a href="javascript:;">包装详情</a></li>
                            <li><a href="javascript:;">品牌故事</a></li>
                            <li class="product_comment"><a href="javascript:;">商品评价</a></li>
                        <#--<li class="product_ask"><a href="javascript:;">商品咨询</a></li>-->
                        </ul><!--/nav_tabs-->
                    <#if (map.detailBean.productVo.goodsInfoStock>0)>
                        <a class="add-cart-btn fr "  product_id="${map.detailBean.productVo.goodsInfoId}" product_stock="${map.detailBean.productVo.goodsInfoStock}" distinct_id="${map.distinctId}" href="javascript:;"><i></i>加入购物车</a>
                    <#else>
                    <#--<a class="dis-cart-btn dis_cart fr"  href="javascript:;"><i></i>加入购物车</a>-->
                    </#if>

                    </div><!--/det_title-->
                </div><!--/tit_wp-->

            <#--<div class="details_box ">
                <div class="details-more fl">
                    <a name="1f"></a>-->
                <#--<ul class="pro_introduce clearfix">
                    <li>商品名称：${map.detailBean.productVo.productName!''}</li>
                    <li>商品编号：${map.detailBean.productVo.goodsInfoItemNo}</li>
                    <li>店铺：<a href="javascript:;"><#if map.detailBean.productVo.isThird='0'>${topmap.systembase.bsetName!''}<#else>${map.detailBean.productVo.thirdName!''}</#if></a></li>
                    <li>时间：${map.detailBean.productVo.goodsInfoAddedTime?string("yyyy-MM-dd HH:mm:ss")}</li>
                <#list map.detailBean.expandPrams as expandParam>
                    <li>${expandParam.expandParamVo.expandparamName}：${expandParam.expangparamValue.expandparamValueName}</li>
                </#list>
                </ul>--><!--/pro_introduce-->
            <#-- <div class="intro_cont">-->
            <#--<div class="detail_show">     -->
            <#--&lt;#&ndash;<#if map.detailBean??&&map.detailBean.brand??>${map.detailBean.brand.brandName!''}</#if>&ndash;&gt;-->
            <#--</div>-->
                <#--<div class="detail_show">
                ${(map.detailBean.productVo.goods.goodsDetailDesc)!''}
                </div>--><!--/detail_show-->
            <#--<div class="det_explain customer_service1">-->
            <#--<a name="2f"></a>-->
            <#--<strong>售后保障</strong>-->
            <#--<p>本商家商品保证正品行货，严格按照国家三包政策提供售后服务，因质量问题或实物与描述不符产生的退换货服务运费由本店承担。</p>-->
            <#--</div><!--/det_explain&ndash;&gt;-->
            <#--<div class="det_explain service_promise">-->
            <#--<strong>服务承诺</strong>-->
            <#--<p>向您保证所售商品均为正品行货，与您亲临商场选购的商品享受相同的质量保证。本站为您提供具有竞争力的商品价格和服务保障，请放心购买！<br/>-->
            <#--注：因厂家会在没有任何提前通知的情况下更改产品包装、产地或者一些附件，本司不能确保客户收到的货物与商城图片、产地、附件说明完全一致。只能确保为原厂正货！并且保证与当时市场上同样主流新品一致。若本商城没有及时更新，请大家谅解！</p>-->
            <#--</div><!--/det_explain&ndash;&gt;-->
            <#--<div class="det_explain res_statement">-->
            <#--<a name="3f"></a>-->
            <#--<strong>责任声明</strong>-->
            <#--<p>所有商品信息、客户评价、商品咨询、网友讨论等内容，是商城重要的经营资源，未经许可，禁止非法转载使用。<br/>-->
            <#--注：本站商品信息均来自于厂商，其真实性、准确性和合法性由信息拥有者（厂商）负责。本站不提供任何保证，并不承担任何法律责任。</p>-->
            <#--</div><!--/det_explain&ndash;&gt;-->
                <#--</div>--><!--/intro_cont-->
                <#--</div>--><!--details-more-->
            <#--<div class="goods-dg">-->
            <#--<ul>-->
            <#--<li><a href="#1f">商品详情</a></li>-->
            <#--&lt;#&ndash;<li><a href="#2f">售后保障</a></li>&ndash;&gt;-->
            <#--&lt;#&ndash;<li><a href="#3f">责任声明</a></li>&ndash;&gt;-->
            <#--</ul>-->
            <#--</div>-->
                <#-- </div>--><!--/details_box-->

                <#--<div class="details_box">
                    &lt;#&ndash;<table class="parameter_tb w">
                        <tr>
                            <th colspan="2">详细参数</th>
                        </tr>
                    <#list map.detailBean.param as param>
                        <#if (param.paramValue)??&&(param.paramValue)!=''>
                            <tr>
                                <td width="20%">${param.param.paramName}：</td>
                                <td>${param.paramValue}</td>
                            </tr>
                        </#if>
                    </#list>
                     </table>&ndash;&gt;<!--/parameter_tb&ndash;&gt;
                </div>--><!--/details_box-->
                <div class="details_box">${(map.detailBean.productVo.goods.goodsDetailDesc)!''}</div>
                <div class="details_box">${(map.detailBean.productVo.goods.goodsSpecsificationDesc)!''}</div><!--/details_box-->
            <#--包装详情-->
                <div class="details_box">${(map.detailBean.productVo.goods.goodsWarpDesc)!''}</div><!--/details_box-->
            <#--品牌故事-->
                <div class="details_box" style="/*min-height:999px;*/">${(map.detailBean.productVo.goods.goodsBrandDesc)!''}</div><!--/details_box-->
                <div class="details_box " style="/*min-height:999px;*/">
                    <div class="evaluation_info clearfix mt10">
                        <div class="rate fl tc">
                            <strong><span   class="bigHaoPercent">95<b>%</b></strong></span>
                            <br/>
                            <span>好评度</span>
                        </div><!--/rate-->
                        <div class="percent fl ml20">
                            <dl class="per_info clearfix">
                                <dt>好评<em class="per">(<span class="haoPercent"></span>)</em></dt>
                                <dd><div class="per_bar"><span class="haoPercentLine"></span></div></dd>
                            </dl>
                            <dl class="per_info clearfix">
                                <dt>中评<em class="per">(<span class="zhongPercent"></span>)</em></dt>
                                <dd><div class="per_bar"><span class="zhongPercentLine"></span></div></dd>
                            </dl>
                            <dl class="per_info clearfix">
                                <dt>差评<em class="per">(<span class="chaPercent"></span>)</em></dt>
                                <dd><div class="per_bar"><span class="chaPercentLine"></span></div></dd>
                            </dl>
                        </div><!--/percent-->
                        <div class="recommend_point fl">
                        <#if map.tags?size  &gt; 0>
                            推荐点：

                            <ul class="rec_points mt10 clearfix">
                                <#list map.tags as tag>
                                    <li>${tag.goodsTag.tagName!""}</li>
                                </#list>
                            </ul>
                        <#--<ul class="rec_points mt10 clearfix">-->
                        <#--<#list map.tags as tag>-->
                        <#--<li><#if tag.goodsTag.tagImg??><img src="${tag.goodsTag.tagImg}"><#else>${tag.goodsTag.tagName!""}</#if></li>-->
                        <#--</#list>-->
                        <#--</ul><!--/rec_points&ndash;&gt;-->
                        </#if>
                        </div><!--/recommend_point-->
                        <div class="publish_cmt fl">
                            <p>您可对已购的商品进行评价</p>
                            <a class="pb_cmt pub_comment" target="_blank" href="${basePath}/customer/comment.html">发表评论拿积分</a>
                        <#--<p>1积分=1元&nbsp;&nbsp;<a class="cmt_rule" href="${basePath}/help/55">评论规则</a></p>-->
                        </div><!--/publish_cmt-->
                    </div><!--/evaluation_info-->

                    <div class="det_title mt10 clearfix">
                        <ul class="cmt_tabs fl clearfix">
                            <li class="cur"><a href="javascript:;" class="commentTab" data-role="3">全部评论（<span class="allCount"></span>）</a></li>
                            <li><a href="javascript:;" class="commentTab" data-role="0">好评（<span class="haoCount"></span>）</a></li>
                            <li><a href="javascript:;" class="commentTab" data-role="1">中评（<span class="zhongCount"></span>）</a></li>
                            <li><a href="javascript:;" class="commentTab" data-role="2">差评（<span class="chaCount"></span>）</a></li>
                        </ul><!--/cmt_tabs-->
                    </div><!--/det_title-->

                    <div class="comment_wp">
                        <div class="comment_cont" style="display:block;border:none;">
                            <div class="comment_list">
                                <!-- 评论主体 -->
                            </div>
                            <div class="clearfix mt10" id="sign">
                                <a class="all_cmt fl" target="_blank" href="${basePath}/comment/${map.detailBean.productVo.goodsInfoId}.html">[查看全部评价]</a>

                            </div>
                        </div><!--/comment_cont-->
                    </div><!--/comment_wp-->
                    <div class="paging_area">
                        <div class="paging comment_pages">

                        </div>
                    </div><!--/pages-->


                </div><!--/details_box-->

                <div class="details_box " style="/*min-height:999px;*/" >
                    <div class="det_title mt10 clearfix">
                        <ul class="consult_tabs fl clearfix">
                            <li class="cur" data-role="0"><a href="javascript:;">全部购买咨询</a></li>
                            <li data-role="1"><a href="javascript:;">商品咨询</a></li>
                            <li data-role="2"><a href="javascript:;">库存配送</a></li>
                            <li data-role="3"><a href="javascript:;">支付</a></li>
                            <li data-role="4"><a href="javascript:;">发票及配送</a></li>
                            <li data-role="5"><a href="javascript:;">促销及赠品</a></li>
                        </ul><!--/consult_tabs-->
                    </div><!--/det_title-->
                    <div class="consult_box clearfix">
                        <div class="consult_search fl">
                            咨询前请先搜索，方便又快捷：
                            <div class="consult_input mt10 clearfix">
                                <input class="consult_text fl" type="text" placeholder="请输入咨询关键词" />
                                <input class="cs_search_btn fl" type="button" onclick="loadCommentAsk(1,null);" value="搜索" />
                            </div><!--/consult_input-->
                        </div><!--/consult_search-->
                        <div class="consult_prompt fl">
                            <b>温馨提示：</b>因厂家更改产品包装、产地或者更换随机附件等没有任何提前通知，且每位咨询者购买情况、提问时间等不同，
                            为此以下回复仅对提问者3天内有效，其他网友仅供参考！若由此给您带来不便请多多谅解，谢谢！
                        </div><!--/consult_prompt-->
                    </div><!--/consult_box-->
                    <div class="consult_wp">
                        <div class="consult_cont" style="display:block">
                            <div class="consult_list">
                            </div>
                            <div class="all_consult clearfix tr">
                                <div class="fl">购买之前，如有问题，请<a class="issued_consult ml5" target="_blank" href="${basePath}/cosult/${map.detailBean.productVo.goodsInfoId}.html">[发表咨询]</a></div>
                                <div class="all_consult_tip tr">
                                    <em>共<b class="consult_count"></b>条</em><a class="ml20" target="_blank" href="${basePath}/cosult/${map.detailBean.productVo.goodsInfoId}.html">浏览所有咨询信息»</a>
                                </div>
                            </div>
                        </div><!--/consult_cont-->
                    </div><!--/consult_wp-->

                </div><!--/details_box-->
                <#--<img src="/images/xuanchuantu.png" alt="" style=" display: block;margin: 0 auto;">-->
            </div><!--/product_detail-->

        </div><!--/right_wp-->

    <#--新增的右侧边栏，轮播-->
        <div class="update-sidebar">
            <p class="sidebar-title">— 热销排行榜 —</p>
            <div class="swiper-container">
                <div class="swiper-wrapper bigdiv">
                <#-- <div class="swiper-slide">
                        <div class="sidebar-info"><a>
                            <img alt="" src="http://boss.ge960.com:80/upload/20170329/1490757244483!352.jpg">
                            <div class="sidebar-title">胶州大白菜每棵5斤零售胶州大白菜每棵5斤售</div>
                            <div class="sidebar-charge">￥256</div></a><a>
                            <img alt="" src="http://boss.ge960.com:80/upload/20170329/1490757244483!352.jpg">
                            <div class="sidebar-title">胶州大白菜每棵5斤零售胶州大白菜每棵5斤售</div>
                            <div class="sidebar-charge">￥256</div></a>
                        </div>
                   </div>-->
                </div>
                <!-- Add Pagination -->
                <div class="swiper-pagination"></div>
            </div>


        </div>
        <input type="hidden" id="cateTwo" value="${map.detailBean.cateVo.parentCat.catId}"/>
        <input type="hidden"  id="cateOne"  value="${map.detailBean.cateVo.parentCat.catParentId}"/>
        <input type="hidden" id="goodsId" value="${map.detailBean.productVo.goodsId}"/>
    <#--goods cat ID-->
        <input type="hidden" id="belongCatId" value="${map.detailBean.productVo.goods.catId}"/>
    <#--goods price-->
        <input type="hidden" id="goodsPriceVal" value="${map.detailBean.productVo.goodsInfoPreferPrice}"/>
    <#--goods branId-->
        <input type="hidden" id="goodsBrandIdVal" value="${map.detailBean.productVo.brandId!''}"/>


        <div style="clear:both; height:0;"></div>
    </div><!--/content-->

    <div style="clear:both; height:0;"></div>
<#--    <div class="line iconlist">
        <div style="width:1197px;margin:0 auto;">
            <a href="javascript:;" class="a1"><img src="${basePath}/index_960/images/icon_menu1.png"></a>
            <a href="javascript:;"><img src="${basePath}/index_960/images/icon_menu6.png"></a>
            <a href="javascript:;"><img src="${basePath}/index_960/images/icon_menu5.png"></a>
            <a href="javascript:;"><img src="${basePath}/index_960/images/icon_menu2.png"></a>
            <a href="javascript:;"><img src="${basePath}/index_960/images/icon_menu3.png"></a>
            <a href="javascript:;"><img src="${basePath}/index_960/images/icon_menu4.png"></a>
        </div>

    </div>-->
<#--shf-->
<#--<div class="footer_tab">-->
<#--<ul>-->

<#--<li class="list1"><a href="http://www.ge960.com/channel/237.html">食品荟萃</a></li>-->
<#--<li class="list2"><a href="http://www.ge960.com/channel/239.html">饮品总汇</a></li>-->
<#--<li class="list3"><a href="http://www.ge960.com/channel/241.html">购物中心</a></li>-->
<#--<li class="list4"><a href="http://www.ge960.com/channel/243.html">大药房</a></li>-->

<#--</ul>-->
<#--</div>-->


<#--新增的浏览过的商品-->

    <div class="browse_product">
        <div class="browse_title1">
            <i></i><span>浏览过的商品</span>
            <p>
                <span class="sub flip1 nohand" style="margin-right: 10px;"></span>
                <span class="last">1</span>
                <span class="or">/</span>
                <span class="next" >1</span>
                <span class="add flip3 nohand" style="margin-left: 10px;"></span>
            </p>
        </div>
        <div class="bigwarp">
            <div class="warp">
                <div class="one">
                <#--<div class="product">
                        <img alt=""src="http://boss.ge960.com:80/upload/20170329/1490769066225!352.jpg">
                        <div class="browse_title">元之源 牛里外脊肉牛里外脊肉2000g 零售 鲜嫩多汁</div>
                        <div class="browse_charge">￥256</div>
                    </div>
                    <div class="product">
                        <img alt=""src="http://boss.ge960.com:80/upload/20170329/1490769066225!352.jpg">
                        <div class="browse_title">元之源 牛里外脊肉牛里外脊肉2000g 零售 鲜嫩多汁</div>
                        <div class="browse_charge">￥256</div>
                    </div>-->
                </div>
                <div class="two"></div>
                <div class="three"></div>
            </div>
        </div>

    <#--<ul >-->
    <#--<li>-->
    <#--<a>-->
    <#--<img alt="" src="http://boss.ge960.com:80/upload/20170329/1490766584760!160.jpg">-->
    <#--<div class="sidebar-title">胶州大白菜每棵5斤零售胶州大白菜每棵5斤售</div>-->
    <#--<div class="sidebar-charge">￥256</div>-->
    <#--</a>-->
    <#--</li>-->
    <#--</ul>-->

    </div>






</div>
<#if (topmap.temp)??>
    <#if (topmap.temp.tempId==1)>
        <#include "../index/bottom.ftl">
    <#else>
        <#include "../index/newbottom.ftl" />
    </#if>
</#if>
<!--/container-->

<div class="sideBar">
<#if map.customerService?? && map.customerService.onlineIndex=='Y' && map.customerService.effectiveTerminal?index_of("1") != -1>
    <a class="customer_service" href="javascript:;"><em>${map.customerService.title!''}</em><b></b></a>
</#if>
    <div class="customer-box onlineServiceQQ">
    <#if map.customerService??&&map.customerService.onlineIndex=='Y'>
        <span class="title">${map.customerService.title!''}</span>
        <hr>
    </#if>
        <a href="javascript:;" class="close-cs"></a>
    <#if map.QQs??>
        <#list map.QQs as qq>
            <p><span class="qq_name">${qq.name}</span><span class="qq_img"><a style="float:right;" target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=${qq.contactNumber}&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:${qq.contactNumber}:51" alt="点击这里给我发消息" title="点击这里给我发消息"/></a></span></p>
        </#list>
    </#if>
    </div>
</div>

<div class="dialog dia22" style="top: 385px; left: 732.5px; display: none;">
    <div class="dia_tit clearfix">
        <h4 class="fl info_tip_title">到货通知</h4>
        <a class="dia_close fr" href="javascript:;" onclick="cls()">×</a>
    </div><!--/dia_tit-->
    <div class="dia_cont" style="padding-bottom: 61px">
        <div class="arrive-tips">
            当商品到货时，我们可以为您提供以下服务
        </div>
        <p class="col9">若商品在90日内到货，我们会通过邮件、短信来通知您哦</p>
        <dl class="arrive-dl">
            <dt>手机号码</dt>
            <dd>
                <input type="text" id="infoMobile" value="" onblur="checkMobile()">
                <div class="infoMobile" style="display: none;text-indent: 95px;color:#cc0000;"></div>
            </dd>
            <div class="clearfix"></div>
            <dt>邮箱地址</dt>
            <dd>
                <input type="text" id="infoEmail" value="" onblur="checkEmail()">
                <div class="infoEmail" style="display: none;text-indent: 95px;color:#cc0000;"></div>
            </dd>

        </dl>
        <div class="dia_ops mt20 tc">
            <a class="go_shopping" href="javascript:;" onclick="cls()">继续购物</a>
            <a class="go_pay" href="javascript:;" onclick="arrivalNotice()">确定</a>
        </div><!--/dia_ops-->
    </div><!--/dia_cont-->
</div>



<!-- 对比页面 -->
<#include "compare_box.ftl">

<!-- 提示框-->
<#include "../infotips.ftl">

<div class="side_tools">
    <a class="backtotop" href="javascript:;"><em>返回顶部</em><b></b></a>
</div><!--/side_tools-->
<#if map.shopKuaiShang?? && map.shopKuaiShang.operation?? && map.shopKuaiShang.isuseing?? && map.shopKuaiShang.isuseing =='0'>
${map.shopKuaiShang.operation!''}
</#if>
<script type="text/javascript" src="${basePath}/js/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="${basePath}/js/cloud-zoom.1.0.2.min.js"></script>
<script type="text/javascript" src="${basePath}/js/index.js"></script>
<script type="text/javascript" src="${basePath}/js/jsOperation.js"></script>
<script src="${basePath}/js/qrcode.min.js"></script>

<script>
    $(function(){
        var oUrl = window.location.href;
        var mUrl = oUrl.replace(window.location.host,"m.ge960.com");
        new QRCode(document.getElementById("mobile_code"), mUrl);
        $(".phone_orders").on("mouseover",function () {
            $(".iphoe_div_erweima").show();
            $(".phone_orders_i").css("background-image","url(../../images/btn_more2.png)");
        })
        $(".phone_orders").on("mouseout",function () {
            $(".iphoe_div_erweima").hide();
            $(".phone_orders_i").css({"background-image":"../images/btn_more.png"});
            $(".phone_orders_i").css("background-image","url(../../images/btn_more.png)");

        })
    })
    $(function(){
        $(".product_market").on("mouseover","#cut",function(){
            var _this = $(this);
            var _cont = '<p>会员等级 会员折扣率</p><p>普通会员：99%</p><p>黄金会员：95%</p><p>白金会员：91%</p><p>砖石会员：85%</p><p>金牌会员：65%</p><p>超级会员：33%</p>';
            var d = dialog({
                width: 150,
                align: 'right',
                quickClose: true,
                skin: 'prm-tip',
                content: _cont
            });
            var _time = setTimeout(function(){
                d.show(_this[0]);
            },300);
        });
        $(".product_market").on("mouseout","#cut",function(){
            clearTimeout(_time);
        });


        $(".typeshow").click(function(){

            $(this).siblings(".current").removeClass("current");
            $(this).addClass("current");
            var str=$(this).attr("attr_type");
            $(".ranking_list").hide();
            $("."+str).show();

        });

    });
    $(document).ready(function(){
        <!-- 加载规格值区域 -->
        var productList=null;
        $.get("${basePath}/all/"+$("#goodsId").val()+".html",function(data){
            productList=data;
            <!-- 把查询到的数据传递到js方法中 -->
            loadAllProduct(productList);
            loadChooseParam();
        });

        <!-- 加载商品促销的信息 -->
        loadGoodsMark();
        loadCoupons();
        $(".pro_sort").addClass("pro_sort_close");
    });
</script>
<script type="text/javascript" src="${basePath}/js/dialog-min.js"></script>
<script type="text/javascript" src="${basePath}/js/goods/goods_compare.js"></script>
<script type="text/javascript" src="${basePath}/js/goods/goods_comm.js"></script>
<script type="text/javascript" src="${basePath}/js/goods/new_list_common.js"></script>
<script type="text/javascript" src="${basePath}/js/goods/new_goods_detail.js"></script>
<script type="text/javascript">

    $(function(){

        var  st=$(".inputdiv").length;

        if(st>=1){
            $(".isshowdiv").show();

        }
        else{
            $(".isshowdiv").hide();
        }

        //商品套装
        $(".boxfl li").click(function(){
            var a=$(this).index();
            var ul=$(".groups_wp .boxfl_count:eq("+a+")").find(".gp_list");
            var li_width=ul.find("li").width()+80;
            var ul_width=li_width*ul.find("li").length;
            ul.width(ul_width);
        });
        $(".boxfl li").click();

        //商品组合
        $(".groupfl li").click(function(){
            var bb=$(this).index();
            var ul=$(".groups_wp .groupfl_count:eq("+bb+")").find(".gp_list");
            var li_width=ul.find("li").width()+80;
            var ul_width=li_width*ul.find("li").length;
            ul.width(ul_width);
        });
        $(".groupfl li").click();
    });
    $(function(){


        $(".collectstore").click(function(){
            $.post("${basePath}/addcollectionseller.htm?collectionThirdId=${map.detailBean.productVo.thirdId}",function(data){
                if(data=="2"){
                    /*初始化弹框样式*/
                    $(".info_tip_content2").html("您已经关注过该商家！");
                    $(".info_tip_img2").attr("src","../images/collect.png");
                    $(".info_tip_cancel2").attr("href","javascript:;").hide();
                    $(".info_tip_submit2").attr("href","javascript:;").show().html("确定").unbind("click");
                    $(".info_tip_submit2").click(function(){
                        cls();
                    });
                    dia(2);

                }else if(data=="3"){
                    /*初始化弹框样式*/
                    $(".info_tip_content2").html("是否跳转到登录页?");
                    $(".info_tip_img2").attr("src","../images/index_ques.png");
                    $(".info_tip_cancel2").attr("href","javascript:;").html("取消").show();
                    $(".info_tip_submit2").attr("href","../login.html").show().html("确定").unbind("click");
                    $(".info_tip_cancel2").click(function(){
                        cls();
                    });
                    dia(2);
                }else{
                    /*初始化弹框样式*/
                    $(".info_tip_content2").html("恭喜您关注成功！");
                    $(".info_tip_img2").attr("src","../images/collect.png");
                    $(".info_tip_cancel2").attr("href","javascript:;").hide();
                    $(".info_tip_submit2").attr("href","javascript:;").show().html("确定").unbind("click");
                    $(".info_tip_submit2").click(function(){
                        cls();
                    });
                    dia(2);
                }
            });
        });
    });

    //          shf:商品详情页商品小图，thumb_scroll_prev/thumb_scroll_next切换图片
    $(".thumb_scroll_prev").on("click",function(){
        var nowPru = $(".thumb_scroll_wp").find(".cur").index();
        if(nowPru>0){
            $(".thumb_scroll_wp li").eq(nowPru-1).addClass("cur");
            $(".thumb_scroll_wp li").eq(nowPru).removeClass("cur");
            imgsrc();
        }

    });
    $(".thumb_scroll_next").on("click",function(){
        var nowPru = $(".thumb_scroll_wp").find(".cur").index();
        var imgLength = $(".thumb_scroll_wp li").length;
        if(nowPru<imgLength-1){
            $(".thumb_scroll_wp li").eq(nowPru+1).addClass("cur");
            $(".thumb_scroll_wp li").eq(nowPru).removeClass("cur");
            imgsrc();
        }
    });
    function imgsrc(){
        var imgSrc = $(".thumb_scroll_wp").find(".cur").children("a").eq(0).attr("href");
        $(".cloud-zoom").attr("href",imgSrc);
        $(".cloud-zoom").find("img").attr({"href":imgSrc,"src":imgSrc});
    };
</script>
<script src="https://cdn.bootcss.com/Swiper/3.4.2/js/swiper.jquery.min.js"></script>

<#--详情页改版新增的js-->
<script type="text/javascript" src="${basePath}/js/index-mend.js"></script>

</body>

</html>
