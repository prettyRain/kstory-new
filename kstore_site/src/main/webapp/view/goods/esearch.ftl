<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<#assign basePath=request.contextPath>
    <title>${keyWorlds}搜索结果-${topmap.systembase.bsetName}</title>
    <meta name="description" content="${topmap.seo.meteDes}">
    <meta name="Keywords" content="${topmap.seo.meteKey}">
    <link rel="stylesheet" type="text/css" href="${basePath}/css/base.min.css" />
    <link rel="stylesheet" type="text/css" href="${basePath}/css/index.css" />
    <link rel="stylesheet" type="text/css" href="${basePath}/css/serach_list_update.css" />
<#if (topmap.systembase.bsetHotline)??>
    <link rel = "Shortcut Icon" href="${(topmap.systembase.bsetHotline)!''}">
<#else>
    <link rel = "Shortcut Icon" href="${basePath}/images/Paistore.ico">
</#if>
    <style>
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
        .dia_tit {
            height: 40px;
            line-height: 40px;
        }
        .info_tip_title{
            line-height: 37px!important;
        }
        .price_con{margin-top: 12px; margin-left: 20px;}
        .price_con input{display:inline-block;width:50px; padding:0px 5px; height:24px; border:1px solid #ddd;color:#666; }
        .price_con button{border: none; background: #df1738;border-radius:3px; height:24px; width:40px; color:#fff; text-align: center; line-height: 24px; display: inline-block; margin-left: 10px;}
        .nohand{
            cursor: default!important;
        }
    </style>
</head>

<body  style="background: #FFFFFF">
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
<input  type="hidden" value="${keyWorlds}" id="keyWorlds"/>
<div class="container" >
    <div class="page_locate mt10">
        <label style="font-size: 14px;color: #020202;letter-spacing: 1.17px;">全部结果</label><span style="font-size: 14px;color: #020202;letter-spacing: 1.17px;">&gt;</span>
        <span>"<b style="font-size: 14px;color: #2554A7;letter-spacing: 1.17px;font-weight: normal;">${keyWorlds}</b>"</span>
    </div><!--/page_locate-->
    <input type="hidden" id="appBasePath" value="${basePath}"/>
    <div class="content clearfix mt10">
        <div class="pro_filter mt10">
            <div class="filterBox">
                <dl id="selected_filter" <#if (params?? && params?size &gt; 0)||(brands?? && brands?size &gt; 0)>style="display:block"<#else>style="display:none"</#if> class="filter_wp clearfix">
                    <dt style="padding: 0px 43px 0px 16px;">已选择</dt>
                    <dd style="height: 22px;">
                        <form id="searchForm" method="post" action="${basePath}/goods/searchProduct2.html?title=${keyWorlds!''}">
                            <div class="filterList">
                                <ul class="clearfix">
                                <#--已选的品牌与扩展属性-->
                                <#if brands??>
                                    <#list brands as brand>
                                        <li data-num="brand"><input type="hidden" name="brands" value="${brand}"><a href="javascript:;"><em>${brand}</em><b></b></a></li>
                                    </#list>
                                </#if>
                                <#if params??>
                                    <#list params as param>
                                        <li data-num="param"><input type="hidden" name="params" value="${param}"><a href="javascript:;"><em>${(param?split(":")[1])!''}</em><b></b></a></li>
                                    </#list>
                                </#if>
                                <#--<#if param.type="spec">
                                    <li data-num="s${param.parentId}"><input type="hidden" name="params" value="s${param.value}"><a href="javascript:;">${param.title}：<em>${param.text}</em><b></b></a></li>
                                </#if>-->
                                </ul>
                            </div><!--/filterList-->

                            <a class="cancel_filter" href="javascript:;" style="font-size: 14px;color: #6E6E6E;letter-spacing: 1.17px;/* margin-right: 9px;*/">全部撤销</a>
                    </dd>
                </dl><!--/filter_wp-->
            <#if map.brands?? && map.brands?size &gt;0>
                <dl class="filter_item clearfix" data-num="brand">
                    <dt>品牌</dt>
                    <dd>
                        <div class="filterList">
                            <ul class="clearfix">
                                <#list map.brands as brand>
                                    <li style="width: 70px;"><a  role="brand" style="color: #2554A7;overflow: hidden;" param="${brand.brandName!''}" href="javascript:;">${brand.brandName}</a></li>
                                </#list>
                            </ul>
                        </div><!--/filterList-->
                        <a class="filter_op f_more none" href="javascript:;">更多<b></b></a>
                        <a class="filter_op f_less none" href="javascript:;">收起<b></b></a>
                    </dd>
                </dl><!--/filter_wp-->
            </#if>
            <#if map.params?? && map.params?size &gt;0>
                <#list map.params as param>
                    <#if param.paramName != '保质期'>
                    <dl class="filter_item clearfix" data-num="${param.paramName}">
                        <dt <#if param.paramName?length == 3>style="padding: 0px 26px 0px 32px;" </#if>>${param.paramName}</dt>
                        <dd >
                            <div class="filterList">
                                <ul class="clearfix">
                                    <#if param.valueVoList?? && param.valueVoList?size &gt;0>
                                        <#list param.valueVoList as value>
                                            <li style="width: 70px;"><a role="eparam" style="color: #2554A7;overflow: hidden;" param="${param.paramName}:${value.valueName}" href="javascript:;">${value.valueName}</a></li>
                                        </#list>
                                    </#if>
                                </ul>
                            </div><!--/filterList-->
                            <a class="filter_op f_more none" href="javascript:;">更多<b></b></a>
                            <a class="filter_op f_less none" href="javascript:;">收起<b></b></a>
                        </dd>
                    </dl><!--/filter_wp-->
                    </#if>
                </#list>
            </#if>
            <#--<#if map.type??&& map.type.specVos??>
                <input type="hidden" name="cId" class="" value="${map.cate.catId!''}">
                <#list map.type.specVos as spec>
                    <!-- 如果规格的显示方式是显示到列表页,就显示到页面 ,否则就不显示&ndash;&gt;
                    <#if spec.goodsSpec.specShowmode=="1">
                        <dl class="filter_item clearfix" data-num="s${spec.goodsSpec.specId}">
                            <dt>${spec.goodsSpec.specName}：</dt>
                            <dd>
                                <div class="filterList">
                                    <ul class="clearfix">
                                        <#list spec.goodsSpec.specDetails as detail>
                                            <li><a role="spec" param="${detail.specDetailId}" href="javascript:;">${detail.specDetailName}</a></li>
                                        </#list>
                                    </ul>
                                </div><!--/filterList&ndash;&gt;
                                <a class="filter_op f_more none" href="javascript:;">更多<b></b></a>
                                <a class="filter_op f_less none" href="javascript:;">收起<b></b></a>
                            </dd>
                        </dl><!--/filter_wp&ndash;&gt;
                    </#if>
                </#list>
            </#if>-->
            </div><!--/filterBox-->
        </div><!--/pro_filter-->
    <#if map.brands??&&map.params??&&map.brands?size+map.params?size &gt;4>
        <#--<div class="filter_handle tc">-->
            <#--<div class="show_more"><a href="javascript:;">展开<b></b></a></div>-->
            <#--<div class="show_less"><a href="javascript:;">收起<b></b></a></div>-->
        <#--</div><!--/filter_handle&ndash;&gt;-->
    </#if>
        <div class="left_wp fl"style="padding-top:10px;">
        <#if map.pb.data?? && (map.pb.data?size>0)>
            <div class="left_box" style="margin-top: 10px;">
                <p class="p11111">热销排行榜</p>
                <ul class="show_list mt10">
                    <#list map.pb.data as product>
                        <#if (map.pb.data?size<5 && product_index<2)||(map.pb.data?size>4 && map.pb.data?size<9 && product_index<3)||(map.pb.data?size>8 && map.pb.data?size<13 && product_index<4)||(map.pb.data?size>12 && map.pb.data?size<17 && product_index<6)>
                            <li>
                                <div class="browse_img">
                                    <a class="ranking_img fl" alt="${product.goodsInfoName!''}" title="${product.goodsInfoName!''}" target="_blank" href="${basePath}/item/${product.goodsInfoId}.html">
                                        <img class="lazy" alt="${product.goodsInfoName!''}" title="${product.goodsInfoName!''}" data-original="${(product.goodsInfoImgId!'')?replace('!160','!352')}"  width="188px" height="188px" />
                                    </a>
                                </div>
                                <p class="browse_name fl mt5">
                                    <a class="ranking_name" alt="${product.goodsInfoName!''}" title="${product.goodsInfoName!''}" target="_blank" href="${basePath}/item/${product.goodsInfoId}.html">${product.goodsInfoName!''}</a>
                                </p>
                                    <#--<#assign productPrice=product.finalPrice>
                                    <#if product.productWares??&&product.productWares?size &gt;0>
                                        <#list product.productWares as ware>
                                            <#if wareId?? && ware.wareId==wareId>
                                                <#assign productPrice=ware.warePrice>
                                                <#break>
                                            </#if>
                                        </#list>
                                    </#if>-->
                                    <p class="browse_price fl mt5">¥ ${product.finalPrice?string("0.00")}</p>
                            </li>
                        </#if>
                    </#list>
                </ul><!--/ranking_list-->
            </div><!--/left_box&ndash;&gt;-->
        </#if>
        </div><!--/left_wp-->
        <div class="right_wp fr">



            <div class="operation_bar mt10">
                <div class="operation_wp clearfix"  style="height: 45px;">
                    <div class="sorting_box fl clearfix" style="height: 45px;">
                        <em style="font-weight: normal;">排序</em>
                        <a val="2D" attr="${sort!''}"  onClick="changeSearch(this,'searchSort','2D');" class="change_sort  <#if sort??><#if sort='22D' || sort='2D'>checked</#if> <#if sort='22D'> s_up<#elseif sort='2D'> s_down</#if></#if>" href="javascript:;"><span>销量</span></a>
                        <a val="1D" attr="${sort!''}" onClick="changeSearch(this,'searchSort','1D');"  class="change_sort  <#if sort??><#if sort='11D' || sort='1D'>checked</#if> <#if sort='11D'> s_up<#elseif sort='1D'> s_down</#if></#if>" href="javascript:;"><span>价格</span></a>
                        <a val="4D" attr="${sort!''}" onClick="changeSearch(this,'searchSort','4D');"  class="change_sort  <#if sort??><#if sort='44D' || sort='4D'>checked</#if> <#if sort='44D'>s_up<#elseif sort='4D'>s_down</#if></#if>" href="javascript:;"><span>人气</span></a>
                        <a val="3D" attr="${sort!''}"  onClick="changeSearch(this,'searchSort','3D');" class="change_sort  <#if sort??><#if sort='33D' || sort='3D'>checked</#if> <#if sort='33D'>s_up<#elseif sort='3D'>s_down</#if></#if>" href="javascript:;"><span>上架时间</span></a>
                    </div><!--/sorting_box-->
                    <!-- 保存查询参数 -->
                 <#--   <div class="price_con fl">
                        <input type="text" style=" font-family: 'Verdana';" placeholder="¥" id="priceMin" name="priceMin" <#if priceMin??>value="${priceMin}"</#if> onkeyup="value=value.replace(/[^\d]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/>&nbsp;-&nbsp;
                        <input type="text"  style=" font-family: 'Verdana';" placeholder="¥" id="priceMax" name="priceMax" <#if priceMax??>value="${priceMax}"</#if> onkeyup="value=value.replace(/[^\d]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/>
                        <button onclick="confirmButton()">确定</button>
                    </div><!--price_con&ndash;&gt;-->

                    <input type="hidden" name="showStock" class="show_stock" value="${showStock!''}">
                    <input type="hidden" name="isThird" class="is_third" value="${isThird!''}">
                <#--<input type="hidden" id="search_title" name="title" value="${keyWorlds}" />-->
                    <input type="hidden" id="searchSort" name="sort" value="${sort!''}"/>
                    <input type="hidden" id="pageBeanShowSize" name="pageSize" value="${map.pb.pageSize}" />
                    <input type="hidden" id="pageBeanShowPage" name="pageNo" class="pageNo"  value="${map.pb.pageNo}" />
                    <input type="hidden" name="inMarketing" class="inMarketing" value="${inMarketing!''}">
                    </form>
                    <div class="op_pages fr">
                        <span class="mr10"><b>${map.pb.pageNo}</b>/${map.pb.lastPageNo}</span>
					<#if (map.pb.pageNo==1)>
                        <a class="op_prev no_pages" href="javascript:;">上一页</a>
					<#else>
                        <a class="op_prev" <#if (map.pb.nextPageNo>0)>onClick="changeSearch(this,'pageBeanShowPage','${map.pb.prePageNo}');"</#if>  href="javascript:;">上一页</a>
					</#if>
					<#if (map.pb.lastPageNo > map.pb.pageNo)>
                        <a style="margin-right: 38px;" class="op_next" <#if (map.pb.nextPageNo>0)>onClick="changeSearch(this,'pageBeanShowPage','${map.pb.nextPageNo}');"</#if>  href="javascript:;">下一页</a>
					<#else>
                        <a style="margin-right: 38px;"  class="no_pages op_next" href="javascript:void(0);">下一页</a>
					</#if>
                    </div><!--/op_pages-->
                    <span class="goods_num fr">共<b>${map.pb.rows}</b>件商品</span>
                </div><!--/operation_wp-->
                <div class="goodsTip ml15">
                    <#--<label class="m_check mr20 <#if showStock??&&showStock='1'>checked</#if>"><input class="vm mr5 check_show_stock" type="checkbox">仅显示有货</label>-->
                    <label style="cursor:pointer;" class="m_check mr20 <#if isThird??&&isThird='0'>checked</#if>"><input class="vm mr5 check_show_third" type="checkbox" style="cursor:pointer;" />自营商品</label>
                    <label style="cursor:pointer;" class="m_check mr20 <#if inMarketing??&&inMarketing='1'>checked</#if>"><input class="vm mr5 check_show_marketing" type="checkbox" style="cursor:pointer;" />促销商品</label>
                </div><!--/goodsTip-->
            </div><!--/operation_bar-->

            <div class="goods_wp mt20">
            <#if map.pb.data?? && (map.pb.data?size>0)>
                <ul class="goodsList clearfix">
                    <#if map.pb?? && map.pb.data??>
                        <#list map.pb.data as product>
                        <#--设置该商品的价格与库存-->
                            <#assign productPrice=product.finalPrice>
                            <#assign stock=product.goodsInfoStock>
                            <#if product.wareList??&&product.wareList?size &gt;0>
                                <#list product.wareList as ware>
                                    <#if wareId?? && ware.wareId==wareId>
                                        <#--<#assign productPrice=ware.warePrice>-->
                                        <#--<#assign stock=stock + ware.wareStock>-->
                                        <#break>
                                    </#if>
                                </#list>
                            </#if>
                            <input type="hidden" id="disId" value="${distinctId}"/>
                            <li class="goodsBox" style="position: relative;">
                                <#if product.marketings??&& product.marketings?size!=0>
                                    <#if product.marketings[0].codexType?number == 5>
                                        <a  href="${basePath}/item/${product.goodsInfoId}.html"> <div class="list_xiaotubiao" style="   background:url(../images/cuxiao/manjiancuxiao.png) no-repeat; background-size: 86px 28px;"></div></a>
                                    </#if>
                                    <#if product.marketings[0].codexType?number == 8>
                                        <a  href="${basePath}/item/${product.goodsInfoId}.html"> <div class="list_xiaotubiao"  style=" background: url(../images/cuxiao/manjiancuxiao.png) no-repeat; background-size: 86px 28px;"></div></a>
                                    </#if>
                                    <#if product.marketings[0].codexType?number == 6>
                                        <a href="${basePath}/item/${product.goodsInfoId}.html"> <div class="list_xiaotubiao"  style=" background: url(../images/cuxiao/manzengcuxiao.png) no-repeat; background-size: 86px 28px;"></div></a>
                                    </#if>
                                    <#if product.marketings[0].codexType?number == 10>
                                        <a href="${basePath}/item/${product.goodsInfoId}.html"><div class="list_xiaotubiao"  style=" background: url(../images/cuxiao/tuangoushangpin.png) no-repeat; background-size: 86px 28px;" ></div></a>
                                    </#if>
                                    <#if product.marketings[0].codexType?number == 11>
                                        <a href="${basePath}/item/${product.goodsInfoId}.html"><div class="list_xiaotubiao"  style="background: url(../images/cuxiao/xianshiqianggou2.png)no-repeat;  background-size: 86px 28px;"></div></a>
                                    </#if>
                                    <#if product.marketings[0].codexType?number == 15>
                                        <a href="${basePath}/item/${product.goodsInfoId}.html"> <div class="list_xiaotubiao" style="  background: url(../images/cuxiao/zhekoushangpin.png) no-repeat;  background-size: 86px 28px;"></div></a>
                                    </#if>
                                    <#if product.marketings[0].codexType?number == 1>
                                        <a href="${basePath}/item/${product.goodsInfoId}.html"> <div class="list_xiaotubiao" style="background: url(../images/cuxiao/zhijiangshangpin.png) no-repeat; background-size: 86px 28px; "></div></a>
                                    </#if>
                                </#if>
                                <div class="gd_wp" style="position: relative;">
                                    <div class="g-img">

                                        <a target="_blank" href="${basePath}/item/${product.goodsInfoId}.html" alt="${product.goodsInfoName!''}" title="${product.goodsInfoName!''}"><img class="lazy" alt="${product.goodsInfoName!''}" title="${product.goodsInfoName!''}" data-original="<#if product.imgList?size &gt; 0 >${(product.imgList?sort_by(["goodsImgSort"]))[0].imageBigName!''}</#if>"  width="221" height="224" /></a>
                                    </div><!--/g-img-->
                                    <div class="g-scroll mt5 clearfix">
                                        <a class="g-scroll-prev disabled" href="javascript:;"></a>
                                        <div class="g-scroll-wrap">
                                            <ul class="clearfix">
                                                <#list product.imgList?sort_by(["goodsImgSort"]) as image>
                                                    <li data-big="${image.imageBigName!''}"><a href="javascript:;" name="${image.goodsImgSort}"><img style="cursor: default;" alt="${product.goodsInfoName!''}" title="${product.goodsInfoName!''}" src="${image.imageThumName!''}" /></a></li>
                                                </#list>
                                            </ul>
                                        </div><!--/g-scroll-wrap-->

                                        <a class="g-scroll-next" href="javascript:;"></a>
                                        <span style="font-size: 12px;color: #000000;opacity: 0.54; margin: 5px 3px 0px 0px;" class="<#if stock &gt;0><#else>no-goods</#if> fr">
                                            <#if stock &gt;0>有货<#else>无货</#if>
                                        </span>
                                    </div><!--/g-scroll-->

                                    <div  class="b-price mt10">
                                    <#--<#if product.unitPrice??>
                                           <span style="font-size: 14px;color: #f36b19">
                                           <#if product.sellType?? && product.sellType=='0'>零售单价：</#if>
                                               <#if product.sellType?? && product.sellType=='1'>批发单价：</#if>
                                              ${product.unitPrice?string('0.00')}元/500克
                                       </span>
                                       </#if>-->
                                        <span style="font-size: 18px;color: #FB6624;letter-spacing: 0.11px;margin-left: 3px;  ">¥${productPrice?number?string('0.00')}</span>
                                        <#if product.unitPriceStr??&&product.unitPriceStr!=''>
                                            <span style="font-size:12px;color: #767676; float: right;margin-right: 3px;">
                                                <#if product.goodsInfoName?? && product.goodsInfoName?index_of("零售")!=-1>零售单价：
                                                <#elseif product.goodsInfoName?? && product.goodsInfoName?index_of("批发")!=-1>批发单价:
                                                <#else>单价</#if>
                                                <p style="display: inline-block;color: #FB6624;">${product.unitPriceStr}</p>
                                            </span>
                                        </#if>

                                    </div>
                                    <p class="g-name mt5" style="margin:9px 0 0 3px;font-size: 14px;width: 223px;"><a target="_blank" class="goods_name_wa_repl" href="${basePath}/item/${product.goodsInfoId}.html" alt="${product.goodsInfoName!''}" title="${product.goodsInfoName!''}">${product.goodsInfoName!''}</a>


                                    <#--<div class="clearfix " >-->


                                    <#--    </div>-->
                                    </p>
                                    <img src="../images/icon_pinglun.png" style="margin-left: 3px;width:12px;">
                                    <p style="    margin:4px 0 0 2px;display: inline-block ; "><span style="font-size: 12px;color: #31A420;">
                                        <#if product.commentUtilBean.count??>
                                            <#if (product.commentUtilBean.count?length==1)>
                                            ${product.commentUtilBean.count}
                                            <#elseif (product.commentUtilBean.count?length==2)>
                                            ${product.commentUtilBean.count?substring(0,1)}0+
                                            <#elseif (product.commentUtilBean.count?length==3)>
                                            ${product.commentUtilBean.count?substring(0,1)}00+
                                            <#elseif (product.commentUtilBean.count?length==4)>
                                            ${product.commentUtilBean.count?substring(0,2)}00+
                                            <#elseif (product.commentUtilBean.count?length>=5)>
                                            ${product.commentUtilBean.count?substring(0,2)}000+
                                            </#if>
                                        <#else>0
                                        </#if>
                                            </span></p>
                                    <p style="    margin-top: 4px; display: inline-block;float: right; margin-right: 3px;font-size: 12px;">销量<span style="font-size: 12px;color: #59A832;">
                                        <#if product.saleCount??>${product.saleCount}</#if>
                                            </span></p>


                                    <div class="nw-btn clearfix mt10">
                                        <a href="javascript:;" ><label class="m_check n_check compare" id="compare${product.goodsInfoId}" product_id="${product.goodsInfoId}">对比</label></a>

                                        <a class="attentionG  <#if goodsIds ?? && goodsIds?size!=0>12
                                              <#if goodsIds?seq_contains('${product.goodsInfoId?string}')>liked</#if>
                                            </#if>" onclick="cllectbtnlist(${product.goodsInfoId},
                                            <#if product.wareList??&&product.wareList?size &gt;0>
                                            ${product.wareList[0].warePrice?string('0.00')}
                                            <#else>
                                            ${product.goodsInfoPreferPrice?string('0.00')}
                                            </#if>
                                                ,this )" product_id="${product.goodsInfoId}" href="javascript:;"><i></i>收藏</a>
                                        <a class="add_shop_cart Joincart" product_id="${product.goodsInfoId}" product_stock="${stock}" distinct_id="${distinctId}" href="javascript:;"><i></i>加入购物车</a>


                                    </div><!--/good-operation-->
                                </div><!--/gd_wp-->
                            <#--<div class="shop_name tc"><a href="javascript:;"><#if product.thirdId=0>${topmap.systembase.bsetName!''}<#else>${product.thirdName!''}</#if></a></div>-->
                            </li><!--/goodsBox-->
                        </#list>
                    </#if>
                </ul><!--/goodsList-->

                <div class="paging_area">
                    <div class="paging">

                        <#if ((map.pb.pageNo-2)>0)>
                            <#assign pageNo="${map.pb.pageNo-2}" />
                        <#else>
                            <#assign pageNo="${map.pb.firstPageNo}" />
                        </#if>
                        <#if ((map.pb.lastPageNo-1)>0)>
                            <#assign endNo="${map.pb.lastPageNo-2}" />
                        <#else>
                            <#assign endNo="1" />
                        </#if>
                        <#if (map.pb.pageNo==1)>
                            <a class=" no_pages" href="javascript:;">上一页</a>
                        <#else>
                            <a class="changePages" pages="${map.pb.prePageNo}" href="javascript:;">上一页</a>
                        </#if>
                        <#if (map.pb.pageNo>3)>
                            <a class="changePages" pages="1" href="javascript:;">1</a>
                            <#if (map.pb.pageNo>4)>
                                <a>...</a>
                            </#if>
                        </#if>
                        <#list pageNo?number .. map.pb.endNo as item>
                            <#if (item_index<=4)>
                                <#if (item=map.pb.pageNo)>
                                    <a class="num_cur prev" href="javascript:;">${item}</a>
                                <#else>
                                    <a class="changePages" pages="${item}" href="javascript:;">${item}</a>
                                </#if>
                            </#if>
                        </#list>
                        <#if map.pb.pageNo!=map.pb.lastPageNo>
                            <#if ((map.pb.lastPageNo-map.pb.pageNo)>3) >
                                <#if (map.pb.lastPageNo>5)>
                                    <a>...</a>
                                </#if>
                            </#if>
                        </#if>
                        <#if (map.pb.pageNo == map.pb.lastPageNo || map.pb.endNo <= 1)>
                            <#if (map.pb.lastPageNo > map.pb.pageNo)>
                                <a class="num_cur prev" href="javascript:;">${map.pb.lastPageNo}</a>
                            </#if>
                            <a class=" no_pages" style="margin-right: 0px;" href="javascript:void(0);">下一页</a>
                        <#else>
                            <#if ((map.pb.lastPageNo - map.pb.pageNo)>=3)>
                                <#if (map.pb.lastPageNo>5)>
                                    <a class="changePages" pages="${map.pb.lastPageNo}" href="javascript:;">${map.pb.lastPageNo}</a>
                                </#if>
                            </#if>
                            <a class="changePages" style="margin-right: 0px;"  pages="${map.pb.nextPageNo}"  href="javascript:void(0);">下一页</a>
                        </#if>
                    </div><!--/pages-->
                </div>
            <#else>
                <center>暂无商品</center>
            </#if>

            </div><!--/goods_wp-->



        </div><!--/goods_wp-->
        </div><!--/right_wp-->
<#--新增的浏览过的商品-->
    <div class="browse_product">
        <div class="browse_title1">
            <i></i><span>浏览过的商品</span>
            <p>
                <span class="sub flip1" style="margin-right: 10px;"></span>
                <span class="last">1</span>
                <span class="or">/</span>
                <span class="next" >1</span>
                <span class="add flip3" style="margin-left: 10px;"></span>
            </p>
        </div>

        <div class="bigwarp"><input type="hidden" id="pageLength" value="${browserProduct.pageLength!0}">
            <div class="warp">
            <#if browserProduct??&&(browserProduct.type==1)>
                <#if browserProduct.browHist??>
                    <#list browserProduct.browHist as product>
                        <#if product.goods??>
                        <#if (product_index<15)>
                        <#if (product_index==0)><div class="one"></#if>
                        <#if (product_index==5)><div class="two"></#if>
                        <#if (product_index==10)><div class="three"></#if>
                        <div class="product">
                            <a alt="${product.goods.goodsName!''}" title="${product.goods.goodsName!''}" target="_blank" href="${basePath}/item/${product.goodsId}.html">
                                <img class="lazy" alt="${product.goods.goodsName!''}" title="${product.goods.goodsName!''}" data-original="<#if  product.goods.goodsImageList?? && product.goods.goodsImageList?size &gt; 0 >${product.goods.goodsImageList[0].imageBigName!''}</#if>"  width="182" height="182" />
                            </a>
                            <div class="browse_title">
                                <a alt="${product.goods.goodsName!''}" title="${product.goods.goodsName!''}" target="_blank" href="${basePath}/item/${product.goodsId}.html" style="opacity: 0.85;color: #000000;">
                                    ${product.goods.goodsName!''}
                                </a>
                            </div>
                            <div class="browse_charge">¥ ${product.goods.goodsMarketPrice?string("0.00")}</div>
                        </div>

                        <#if (product_index==4)></div></#if>
                        <#if (product_index==9)></div></#if>
                        <#if (product_index==14)></div></#if>
                        </#if>
                        </#if>
                    </#list>
                </#if>
            <#else>
                <#if browserProduct??>
                    <#if browserProduct.productList??>
                        <#list browserProduct.productList as product>
                            <#if (product_index<15)>
                            <#if (product_index==0)><div class="one"></#if>
                            <#if (product_index==5)><div class="two"></#if>
                            <#if (product_index==10)><div class="three"></#if>
                            <div class="product">
                                <a alt="${product.productName!''}" title="${product.productName!''}" target="_blank" href="${basePath}/item/${product.goodsInfoId}.html">
                                    <img class="lazy" alt="${product.productName!''}" title="${product.productName!''}" data-original="<#if  product.imageList?? && product.imageList?size &gt; 0 >${product.imageList[0].imageBigName!''}</#if>"  width="182" height="182" />
                                </a>
                                <div class="browse_title">
                                    <a alt="${product.productName!''}" title="${product.productName!''}" target="_blank" href="${basePath}/item/${product.goodsInfoId}.html" style="opacity: 0.85;color: #000000;">
                                        ${product.productName!''}
                                    </a>
                                </div>
                                <div class="browse_charge">¥ ${product.goodsInfoMarketPrice?string("0.00")}</div>
                            </div>
                            <#if (product_index==4)></div></#if>
                            <#if (product_index==9)></div></#if>
                            <#if (product_index==14)></div></#if>
                            </#if>
                        </#list>
                    </#if>
                </#if>
            </#if>
            </div>
        </div>
    </div><!--/content-->
</div><!--/container-->
<#if (topmap.temp)??>
	<#if (topmap.temp.tempId==1)>
		<#include "../index/bottom.ftl">
	<#else>
		<#include "../index/newbottom.ftl" />
	</#if>
</#if>
<!-- 对比页面 -->
<#include "compare_box.ftl">
<!-- 提示框-->
<#include "../infotips.ftl">

<div class="side_tools">
    <a class="backtotop" href="javascript:;"><em>返回顶部</em><b></b></a>
</div><!--/side_tools-->


<script type="text/javascript" src="${basePath}/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${basePath}/js/jquery.slides.min.js"></script>
<script type="text/javascript" src="${basePath}/js/jcarousellite_1.0.1.js"></script>
<script type="text/javascript" src="${basePath}/js/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="${basePath}/js/goods/goods_compare.js"></script>
<script type="text/javascript" src="${basePath}/js/goods/goods_param_filter.js"></script>
<script type="text/javascript" src="${basePath}/js/goods/new_list_common.js"></script>
<#--<script type="text/javascript" src="${basePath}/js/goods/goods_comm.js"></script>-->
<script>
    $(function(){
        var keyWorlds=$("#keyWorlds").val();
        if(keyWorlds!=null){
            $(".hot").parent().find("a").each(function(){
                $(this).removeClass("hot");
                if($(this).html()==keyWorlds){
                    $(this).addClass("hot");
                }
            })
        }

        /*点击显示有货*/
        $(".check_show_stock").change(function(){
            var cur = $(this);
            if(cur.parent("label").hasClass("checked")){
                cur.parent("label").removeClass("checked");
                $(".show_stock").val("0");
            }else{
                cur.parent("label").addClass("checked");
                $(".show_stock").val("1");
            }
            /*提交表单*/
            $(".pageNo").val("1");
            $("#searchForm").submit();
        });

        /**
         * 点击显示自营商品
         */
        $(".check_show_third").change(function(){
            var cur = $(this);
            if(cur.parent("label").hasClass("checked")){
                cur.parent("label").removeClass("checked");
                $(".is_third").val("");
            }else{
                cur.parent("label").addClass("checked");
                $(".is_third").val("0");
            }
            /*提交表单*/
            $(".pageNo").val("1");
            $("#searchForm").submit();
        });
        // 查询营销中商品
        $(".check_show_marketing").change(function () {
            var cur = $(this);
            if(cur.parent("label").hasClass("checked")){
                cur.parent("label").removeClass("checked");
                $(".inMarketing").val("");
            }else{
                cur.parent("label").addClass("checked");
                $(".inMarketing").val("1");
            }
            /*提交表单*/
            $(".pageNo").val("1");
            $("#searchForm").submit();
        });

        //列表商品图
        $(".goodsBox").each(function(){
            var _this = $(this);
            var _next = _this.find(".g-scroll-next");
            var _prev = _this.find(".g-scroll-prev");
            var _ul = _this.find(".g-scroll-wrap ul");
            var _width = _ul.find("li").length *31;
            var n = _ul.find("li").length - 5;
            var _step = 0;
            var _time = 0;
            _ul.find("li").mouseover(function(){
                var _li = $(this);
                var _src = _li.attr("data-big");
                _time = setTimeout(function(){
                    _li.siblings(".cur").removeClass("cur");
                    _li.addClass("cur");
                    _this.find(".g-img img").attr({"src":_src},{"data-original":_src});
                },200);
            }).mouseout(function(){
                clearTimeout(_time);
            });
            if(n <= 0) {
                _this.find(".g-scroll-prev, .g-scroll-next").hide();
            } else {
                _this.find(".g-scroll-wrap ul").width(_width);

                _next.click(function(){
                    _prev.removeClass("disabled");
                    if(_step < n) {
                        _step++;
                        go_next();
                    };
                });

                _prev.click(function(){
                    _next.removeClass("disabled");
                    if(_step > 0) {
                        _step--;
                        go_prev();
                    };
                });

                function go_next(){
                    _ul.animate({
                        left: -31*_step
                    });
                    if(_step == n) {
                        _next.addClass("disabled");
                    };
                };
                function go_prev(){
                    _ul.animate({
                        left: -31*_step
                    });
                    if(_step == 0) {
                        _prev.addClass("disabled");
                    };
                };
            };
        });
    });
    /**$(document).ready(function(){
		$(".pro_sort").addClass("pro_sort_close");
		<!--$("#catelist").hide();-->
    var goods_name_wa_repl = $(".goods_name_wa_repl");
    var search_text = $(".orange").html().replace(" ","");
    for(var i =0;i<search_text.length;i++){
        for(var j=0;j<goods_name_wa_repl.length;j++){
            var index=$(goods_name_wa_repl[j]).html().indexOf(search_text[i].trim());
            var ltIndex=$(goods_name_wa_repl[j]).html().indexOf("<");
            var gtIndex=$(goods_name_wa_repl[j]).html().indexOf(">");
            if(index<ltIndex || index>gtIndex){
                if(search_text[i].trim()!="" && $(goods_name_wa_repl[j]).html().indexOf(search_text[i].trim())!=-1){
                    $(goods_name_wa_repl[j]).html($(goods_name_wa_repl[j]).html().replace(search_text[i],'<span style="color:red">'+search_text[i]+'</span>'));
                }
            }
        }
    }
    });*/
</script>
<script>

    $(document).ready(function(){
        var pageLength = $("#pageLength").val();//请求的数据长度,请求过来的
        var nowspage = 1;
        if(pageLength<=5){
            $(".browse_product").find(".next").html(1);
            $(".browse_product").find(".sub").addClass("nohand");
            $(".browse_product").find(".add").addClass("nohand");
        }else if( 5 < pageLength && pageLength<= 10 ){
            $(".browse_product").find(".next").html(2);
            $(".browse_product").find(".add").addClass("flip2");
            $(".browse_product").find(".add").removeClass("flip3");
            $(".browse_product").find(".sub").addClass("nohand");
            $(".browse_product").find(".add").removeClass("nohand");
        }else{
            $(".browse_product").find(".next").html(3);
            $(".browse_product").find(".add").addClass("flip2");
            $(".browse_product").find(".add").removeClass("flip3");
            $(".browse_product").find(".sub").addClass("nohand");
            $(".browse_product").find(".add").removeClass("nohand");
        }
        $(".browse_product").find(".add").on("click",function(){

            if(pageLength<=5){
                $(".browse_product").find(".last").html(1);
            }else if(5 < pageLength && pageLength<= 10){
                $(".warp").removeClass("floor3 floor2");
                $(".warp").addClass("floor1");
                $(".browse_product").find(".last").html(2);
                $(".browse_product").find(".add").addClass("flip3");
                $(".browse_product").find(".add").removeClass("flip2");
                $(".browse_product").find(".sub").addClass("flip4");
                $(".browse_product").find(".sub").removeClass("flip1");
                $(".browse_product").find(".sub").removeClass("nohand");
                $(".browse_product").find(".add").addClass("nohand");
            }else if(10<pageLength && nowspage==1){
                nowspage++;
                $(".warp").removeClass("floor2 floor3");
                $(".warp").addClass("floor1");
                $(".browse_product").find(".last").html(2);
                $(".browse_product").find(".add").addClass("flip2");
                $(".browse_product").find(".add").removeClass("flip3");
                $(".browse_product").find(".sub").addClass("flip4");
                $(".browse_product").find(".sub").removeClass("flip1");
                $(".browse_product").find(".sub").removeClass("nohand");
                $(".browse_product").find(".add").removeClass("nohand");
            }else if(10<pageLength && nowspage==2){
                nowspage++;
                $(".warp").removeClass("floor1 floor2");
                $(".warp").addClass("floor3");
                $(".browse_product").find(".last").html(3);
                $(".browse_product").find(".add").addClass("flip3");
                $(".browse_product").find(".add").removeClass("flip2");
                $(".browse_product").find(".sub").addClass("flip4");
                $(".browse_product").find(".sub").removeClass("flip1");
                $(".browse_product").find(".sub").removeClass("nohand");
                $(".browse_product").find(".add").addClass("nohand");
            }else if(10<pageLength && nowspage==3){
                //没有任何操作
                $(".browse_product").find(".sub").removeClass("nohand");
                $(".browse_product").find(".add").addClass("nohand");
            }
        });
        $(".browse_product").find(".sub").on("click",function(){
            if(pageLength<=5){
                $(".browse_product").find(".last").html(1);
            }else if(5 < pageLength && pageLength<= 10){
                $(".warp").removeClass("floor1");
                $(".warp").removeClass("floor3");
                $(".warp").addClass("floor2");
                $(".browse_product").find(".last").html(1);
                $(".browse_product").find(".add").addClass("flip2");
                $(".browse_product").find(".add").removeClass("flip3");
                $(".browse_product").find(".sub").addClass("flip1");
                $(".browse_product").find(".sub").removeClass("flip4");
                $(".browse_product").find(".sub").addClass("nohand");
                $(".browse_product").find(".add").removeClass("nohand");
            }else if(10<pageLength && nowspage==1){
                $(".browse_product").find(".last").html(1);
            }else if(10<pageLength && nowspage==2){
                nowspage--;
                $(".warp").removeClass("floor1");
                $(".warp").removeClass("floor3");
                $(".warp").addClass("floor2");
                $(".browse_product").find(".last").html(1);
                $(".browse_product").find(".add").addClass("flip2");
                $(".browse_product").find(".add").removeClass("flip3");
                $(".browse_product").find(".sub").addClass("flip1");
                $(".browse_product").find(".sub").removeClass("flip4");
                $(".browse_product").find(".sub").addClass("nohand");
                $(".browse_product").find(".add").removeClass("nohand");
            }else if(10<pageLength && nowspage==3){
                nowspage--;
                $(".warp").removeClass("floor2");
                $(".warp").removeClass("floor3");
                $(".warp").addClass("floor1");
                $(".browse_product").find(".last").html(2);
                $(".browse_product").find(".sub").removeClass("nohand");
                $(".browse_product").find(".add").removeClass("nohand");
            }
        });
    })
</script>
<script>
    $(".n_check").mouseover(function () {
        $(this).css("color","#35a400");
    })
    $(".n_check").mouseout(function () {
        $(this).css("color","#6B6B6B");
    })
</script>
</body>
</html>