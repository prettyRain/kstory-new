<#assign basePath=request.contextPath>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>


    <meta content="text/html; charset=UTF-8" http-equiv=Content-Type>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <#if navList?? && (navList?size>0)><#--子商城下有主题商城-->
        <#list navList as nav>
            <#if navId??><#--进入主题商城-->
                <#if nav.barId == navId >
                    <title><#if nav.expFleid1?? && nav.expFleid1!="">${nav.expFleid1}-<#elseif channel.temp2?? && channel.temp2!="">${channel.temp2}-</#if>${topmap.systembase.bsetName}</title>
                    <meta name="Keywords" content="<#if nav.expFleid2?? && nav.expFleid2!="">${nav.expFleid2}<#elseif channel.temp3?? && channel.temp3!="">${channel.temp3}<#else>${topmap.seo.meteKey}</#if>">
                    <meta name="description" content="<#if nav.des?? && nav.des!="">${nav.des}<#elseif channel.temp5?? && channel.temp5!="">${channel.temp5}<#else>${topmap.seo.meteDes}</#if>">
                    <#break>
                </#if>
            <#else><#--未进入主题商城-->
                <title><#if channel.temp2?? && channel.temp2!="">${channel.temp2}-</#if>${topmap.systembase.bsetName}</title>
                <meta name="Keywords" content="<#if channel.temp3?? && channel.temp3!="">${channel.temp3}<#else>${topmap.seo.meteKey}</#if>">
                <meta name="description" content="<#if channel.temp5?? && channel.temp5!="">${channel.temp5}<#else>${topmap.seo.meteDes}</#if>">
                <#break>
            </#if>
        </#list>
    <#else><#--子商城下没有主题商城-->
        <title><#if channel.temp2?? && channel.temp2!="">${channel.temp2}-</#if>${topmap.systembase.bsetName}</title>
        <meta name="Keywords" content="<#if channel.temp3?? && channel.temp3!="">${channel.temp3}<#else>${topmap.seo.meteKey}</#if>">
        <meta name="description" content="<#if channel.temp5?? && channel.temp5!="">${channel.temp5}<#else>${topmap.seo.meteDes}</#if>">
    </#if>
<#if (topmap.systembase.bsetHotline)??>
    <link rel="Shortcut Icon" href="${(topmap.systembase.bsetHotline)!''}">
<#else>
    <link rel="Shortcut Icon" href="${basePath}/images/Paistore.ico">
</#if>
<style>
    .showthis{display: block!important;}
    .form .li_top{
        height:auto;
    }
    .new_bgcolor:hover{
        background-color:${channel.keyword};
    }
  /*  .new_bgcolor a:hover{
        color: #ffffff!important;
    }*/
    .header_nv .header_nv_a{
        margin-right: 71px;
    }
</style>
    <#--原产地分类导航重新设计-->
<#if (channel.channelId==243)>
    <link rel="stylesheet" href="${basePath}/css/new_channel.css">
</#if>
    <#--960大聚惠-->
    <link rel="stylesheet" href="${basePath}/css/mall_themes.css">
    <link rel="stylesheet" href="${basePath}/css/swiper-4.2.2.min.css">
    <#--end-->
    <link rel="stylesheet" href="${basePath}/css/index.css">
</head>
<body>
<#include "../index/newtop960.ftl"/>
<div id="sectionHeader" class="section-header">

    <div class="tm-content">
        <h1 id="logo">
            <a href="${topmap.systembase.bsetAddress}"><img alt="" src="${topmap.systembase.bsetLogo}" style="width: 181px;height: 72px;    margin-top: 25px;"></a>
        </h1>
     <#--   <div class="logoBanner">
            <!-- 广告位置 &ndash;&gt;
        <#if logoAdv1??>
            <a href="${(logoAdv1.adverHref)!'#'}" target="_blank">
                <#if (logoAdv1.adverPath) ??>
                    <img alt="" src="${(logoAdv1.adverPath)}" style="max-width:480px;height:94px">
                </#if>
            </a>
        </#if>
        <#if logoAdv2??>
            <a href="${(logoAdv2.adverHref)!'#'}" target="_blank">
                <#if (logoAdv2.adverPath) ??>
                    <img alt="" src="${(logoAdv2.adverPath)}" style="max-width:480px;height:94px">
                </#if>
            </a>
        </#if>
        </div>-->
        <div class="header_nv">
            <div style="float: left;height: 65px;padding-top: 59px;">
            <#if topmap.advs??>
                <#list topmap.advs as adv>
                    <#if (adv.adverSort>=3) && (adv.adverSort<=6)>
                        <a class="header_nv_a" onclick=" _czc.push(['_trackEvent', '首页', '头部', '${adv.adverName!''}',  'dianji_ok']);clickNav('${adv.adverHref!'#'}')"  href="javascript:;"style="padding-right: 0px;">
                            <div class="new_div_header">
                                <img src="${basePath}/index_960/images/m${adv.adverSort-2}.png" style="width: 33px;height: 33px;" >
                                <div class="new_box_div">
                                    <p class="_color${adv.adverSort-2}">${adv.adverName!''}</p>
                                    <p style="font-size: 14px;">${adv.des!''}</p>
                                </div>
                            </div>
                        </a>


                    </#if>
                </#list>
            </#if>
            </div>
            <a href="/myshoppingcart.html" style="padding-right: 0px;">
                <div class="new_shoppingcart">
                    <div class="new_sp1">
                        <img src="${basePath}/index_960/images/new_gouwuche_header.png" alt="">
                    </div>
                    <div class="new_sp2">
                        <p>购物车</p>
                        <span class="shopcaritemnum" style="background: none;margin-left: 0px!important;">0</span>
                    </div>

                </div>
            </a>
        </div>
    </div>

    <#--这里-->
    <div class="mainnav">
        <div class="tm-content <#if (channel.channelId==243)>new_content</#if>">
            <div class="navLinks">
                <ul>
                <#if (navList)?? && (navList?size>0)>
                    <#list navList as nav>
                        <#if (nav_index < 8)>
                            <#if (nav.barId != 271 && nav.barId != 307 && nav.barId != 261  && nav.barId != 275 && nav.barId != 277 && nav.barId != 279 && nav.barId != 281)>
                                <#if (nav.barId != 311)>
                                    <li><a class="navLink <#if navId?? && nav.barId==navId>on</#if>" href="${nav.barUrl}?channelId=${channel.channelId}" onclick="_czc.push(['_trackEvent', '首页', '头部', '${(nav.barName)!''}',  'toubu_ok']);" id="toubu_ok">${(nav.barName)!''}</a></li>
                                <#else>
                                    <li><a class="navLink <#if navId?? && nav.barId==navId>on</#if>" href="http://www.ge960.com/marketingrushlist-1.html" onclick="_czc.push(['_trackEvent', '首页', '头部', '${(nav.barName)!''}',  'toubu_ok']);" id="toubu_ok">${(nav.barName)!''}</a></li>
                                </#if>
                            <#elseif (nav.barId == 271 || nav.barId == 307 || nav.barId == 261 ||nav.barId == 275 ||  nav.barId == 277 || nav.barId == 279 || nav.barId == 281)>
                            <#--茶馆-->
                                <li>
                                <#--<form name="form1" action="${nav.barUrl}" method="post">
                                    <input type="hidden" name="channelId" value="237">
                                </form>
                                <a class="navLink <#if navId?? && nav.barId==navId>on</#if>" href="javascript:document.form1.submit();">${(nav.barName)!''}</a>-->
                                    <a class="navLink <#if navId?? && nav.barId==navId>on</#if>" href="${nav.barUrl}?channelId=${channel.channelId}" onclick="_czc.push(['_trackEvent', '首页', '头部', '${(nav.barName)!''}',  'toubu_ok']);" id="toubu_ok">${(nav.barName)!''}</a>
                                </li>
                            <#else>
                                <li><a class="navLink <#if navId?? && nav.barId==navId>on</#if>" href="${nav.barUrl}" onclick="_czc.push(['_trackEvent', '首页', '头部', '${(nav.barName)!''}',  'toubu_ok']);" id="toubu_ok">${(nav.barName)!''}</a></li>
                            </#if>
                        </#if>
                    </#list>
                </#if>
                </ul>
            </div>
            <div class="searchID searchbuttonarea">
                <img src="${basePath}/index_960/images/index2_06.png" style="padding-top:3px;" onclick="showSearch()"/>
                <#--<span>&nbsp;<img id="shopcartid" class="searchbuttonarea_gw" src="${basePath}/index_960/images/index2_08.png"></span>
                <div class="shopcarright_list headMiniShopcart" style="right:0px; display: none;top:48px;">
                    <div class="form cart-goods" style="margin:0;">

                    </div>

                    <div class="li_btn" style="text-align: left;">
                        <p style="float:left;padding-left:5px;">
                            <span>共 <i class="li_g mcNumTotal">1</i> 件商品</span>&nbsp;&nbsp;
                            <span>共计：<font style="font-weight: bold; color: #ff4e01;">¥<b class="li_m mcTotalFee">0.00</b></font></span>&nbsp;&nbsp;
                        </p>
                        <a style="color:#fff;background: #35a400;" href="${basePath}/myshoppingcart.html" class="login submit_btn1">去购物车</a>
                    </div>
                </div>-->
            </div>
            <div class="searchdiv" style="margin-right: 72px;width: 832px;">
                <!-- 搜索框 -->
                <form id="mallSearch-form" action="${basePath}/goods/searchproduct2.html" method="get" >
                    <div style="float: right; padding: 5px 6px;" onclick="hideSearch()">
                        <img src="${basePath}/index_960/images/index3_03.png" style="cursor: pointer;">
                    </div>
                    <div id="search" style="float: right;">
                        <input type="text" id="wd" class="search hotsearchInput" name="title" autocomplete="off" placeholder="搜索960商城商品">
                        <div class="searchcont">
                            <div class="history_list">
                                <p><span>历史记录</span><a class="move" href="javascript:;">删除</a></p>
                                <ul>
                                    <li><a href="javascript:;"></a></li>
                                </ul>
                            </div>
                            <div class="hot_list">
                            <#if (topmap.hotsearch?size>1)>
                                <input type="hidden" value="${(topmap.hotsearch[0].keyword)!''}" class = "hotsearch" />
                            </#if>
                                <dl>
                                    <dt>热门搜索</dt>
                                <#list topmap.hotsearch as hots>
                                    <#if hots_index<=10>
                                        <#if (hots.keyword?length>7)>
                                            <dd><a href="javascript:;" onclick="changeSearchKey(this);">${(hots.keyword)?substring(0,7)}</a></dd>
                                        <#else>
                                            <dd><a href="javascript:;" onclick="changeSearchKey(this);">${(hots.keyword)!''}</a></dd>
                                        </#if>
                                    </#if>
                                </#list>
                                </dl>
                            <#if (topmap.hotsearch?size>11)>
                                <dl>
                                    <dt>热门搜索</dt>
                                    <#list topmap.hotsearch as hots>
                                        <#if (hots_index>=11 && hots_index<20)>
                                            <#if (hots.keyword?length>7)>
                                                <dd><a href="javascript:;" onclick="changeSearchKey(this);">${(hots.keyword)?substring(0,7)}</a></dd>
                                            <#else>
                                                <dd><a href="javascript:;" onclick="changeSearchKey(this);">${(hots.keyword)!''}</a></dd>
                                            </#if>
                                        </#if>
                                    </#list>
                                </dl>
                            </#if>
                            </div>
                        </div>
                    </div>
                    <div style="float: right; padding: 4px 8px 7px 0;cursor: default;" onclick="checkSearch()">
                        <img src="${basePath}/index_960/images/index2_06.png" tppabs="http://ge960.com/pic/index2_06.png">
                    </div>

                    <div class="clear"></div>
                </form>
                <div class="cast_about1" style="width: 832px;">
                    <p>点击回车键进行搜索</p>
                </div>
                <div class="cast_about" style="width: 832px;">
                    <div class="cast_top">
                        <img src="${basePath}/images/icon_jianyisousuo.png">
                        <p>热搜建议</p>
                    </div>
                    <div class="cast_content">
                        <ul>

                        </ul>
                    </div>
                    <div class="cast_top">
                        <img src="${basePath}/images/icon_jianyipinpai.png">
                        <p>品牌建议</p>
                    </div>
                    <div class="cast_bottom">

                    </div>
                    <div class="cast_bottom1">
                        <p><a href="/customer/browserecord.html">最近浏览</a><img src="${basePath}/images/btn_more1.png"></p>

                    </div>
                </div>
            </div>


            <div class="showlist">
                <i class="btnnav menucat" style="font-style: normal">
                    <a class="hover" href="javascript:;" style="cursor: default;">
                        <#if channel.channelName??>
                            <#if channel.channelName=='食品荟萃'||channel.channelName=='饮品总汇'||channel.channelName=='购物中心'>
                            ${channel.channelName+'分类'}
                            <#elseif channel.channelName='原产地'>
                                原产地生态特色小镇产品
                            <#else>
                                所有商品分类
                            </#if>
                         <#else>
                            所有商品分类
                        </#if>
                       </a>
                </i>
                <#--原产地分类导航-->
                <#if channel.channelId ==243>
                    <ul class="list dropdown-menu" style="<#if channel.keyword??>background-color:${channel.keyword}</#if>">
                    <#if (classifyBar.classifyBarList)?? && (classifyBar.classifyBarList?size>0)>
                        <#list classifyBar.classifyBarList as cBar>
                        <#-- 隐藏多出部分的分类 -->
                        <li <#if (cBar_index>12) >style="display: none;" </#if>>
                            <div class="new_gang"></div>
                            <div class="links">
                                <a href="javascript:;">${cBar.name}</a>
                            </div>
                        </li>
                        </#list>
                    </#if>
                    </ul>

                    <#if (classifyBar.classifyBarList)?? && (classifyBar.classifyBarList?size>0)>
                        <#list classifyBar.classifyBarList as cBar>
                            <#if (cBar.childs)?? && (cBar.childs?size>0)>
                                <div class="menuView hide">
                                <ul>
                                    <#list cBar.childs as cbtwo>

                                            <li>
                                                <#if cbtwo.goodsCatId==-1>
                                                    <#if !cbtwo.url?? || cbtwo.url=="">
                                                        <h3><a href="javascript:;" style="cursor:default;">${cbtwo.name}</a></h3>
                                                    <#else>
                                                        <h3><a href="javascript:void(0);" style="cursor:default;">${cbtwo.name}</a></h3>
                                                    </#if>
                                                <#else>
                                                    <h3><a href="javascript:void(0)" style="cursor:default;">${cbtwo.name}</a></h3>
                                                </#if>
                                                <p>
                                                    <#if (cbtwo.childs)?? && (cbtwo.childs?size>0)>
                                                        <#list cbtwo.childs as cbthird>
                                                            <#if cbthird.goodsCatId==-1>
                                                                <#if cbthird.url=="">
                                                                    <a href="javascript:;">${cbthird.name}</a>
                                                                <#else>
                                                                    <a href="${basePath}/${cbthird.url!'0'}">${cbthird.name}</a>
                                                                </#if>
                                                            <#else>
                                                                <#if cbthird.goodsCatId?? && (cbthird.goodsCatId>0) && cbthird.temp3?? && (cbthird.temp3>0)>
                                                                    <a href="${basePath}/list/${cbthird.goodsCatId?c}-${cbthird.temp3!'0'}.html">${cbthird.name}</a>
                                                                <#else>
                                                                    <a href="${basePath}/goods/searchProduct2.html?title=${cbthird.name!''}">${cbthird.name}</a>
                                                                </#if>
                                                            </#if>
                                                        </#list>
                                                    </#if>
                                                </p>
                                            </li>

                                    </#list>
                                </ul>
                                </div>
                            <#else>
                              <div class="menuView hide">
                                    <ul>
                                        <li>
                                           <#-- <h3></h3>
                                            <p></p>-->
                                        </li>
                                    </ul>
                                </div>
                            </#if>
                        </#list>
                    </#if>
                    <#--<div class="menuView hide">
                        <ul>
                            <li>
                                <h3>
                                    <a>奇异果</a>
                                    <a>草莓</a>
                                    <a>香蕉</a>
                                </h3>
                                <p>
                                    <a>四川苍溪红心猕猴桃</a>
                                    <a>贵州修文贵长猕猴桃</a>
                                    <a>河南西峡黄心金桃猕猴桃</a>
                                    <a>东阿草莓</a>
                                    <a>盱眙草莓</a>
                                    <a>砖埠草莓</a>
                                    <a>淮阴草莓</a>
                                    <a>广饶草莓</a>
                                    <a>长安草莓</a>
                                    <a>昌邑草莓</a>
                                    <a>广东香蕉</a>
                                    <a>广西香蕉</a>
                                    <a>海南香蕉</a>
                                    <a>福建香蕉</a>
                                    <a>云南香蕉</a>
                                </p>
                            </li>
                            <li>
                                <h3>
                                    <a>橙子</a>
                                    <a>柠檬</a>
                                    <a>丑柑</a>
                                </h3>
                                <p>
                                    <a>江西赣南脐橙</a>
                                    <a>四川邻水脐橙</a>
                                    <a>重庆奉节脐橙</a>
                                </p>
                            </li>
                        </ul>
                    </div>-->
                <#--其他分类导航-->
                <#else>
                    <ul class="list dropdown-menu" style="<#if channel.keyword??>background-color:${channel.keyword}</#if>">
                        <#if (classifyBar.classifyBarList)?? && (classifyBar.classifyBarList?size>0)>
                            <#list classifyBar.classifyBarList as cBar>
                            <#-- 隐藏多出部分的分类 -->
                                <li <#if (cBar_index>12) >style="display: none;" </#if>>
                                    <div class="new_gang"></div>
                                    <div class="links">
                                        <img class="new_iconimg" src="${cBar.imgSrc!''}" alt="">
                                        <a href="javascript:;">${cBar.name}</a>
                                        <img class="new_youla" src="${basePath}/index_960/images/new_youlajiantou.png" alt="">
                                    </div>
                                </li>
                            </#list>
                        </#if>
                    </ul>
                    <#if (classifyBar.classifyBarList)?? && (classifyBar.classifyBarList?size>0)>
                        <#list classifyBar.classifyBarList as cBar>
                            <#if (cBar.childs)?? && (cBar.childs?size>0)>
                                <div class="menuView hide">
                                <ul>
                                    <#list cBar.childs as cbtwo>

                                            <li>
                                                <#if cbtwo.goodsCatId==-1>
                                                    <#if !cbtwo.url?? || cbtwo.url=="">
                                                        <h3><a href="javascript:;" style="cursor:default;">${cbtwo.name}</a></h3>
                                                    <#else>
                                                        <h3><#--<a href="${basePath}/${cbtwo.url!'0'}">--><a href="javascript:void(0);" style="cursor:default;">${cbtwo.name}</a></h3>
                                                    </#if>
                                                <#else>
                                                    <h3><#--<a href="${basePath}/list/${cbtwo.goodsCatId?c}-${cbtwo.temp3!'0'}.html">--><a href="javascript:void(0)" style="cursor:default;">${cbtwo.name}</a></h3>
                                                </#if>
                                                <p>
                                                    <#if (cbtwo.childs)?? && (cbtwo.childs?size>0)>
                                                        <#list cbtwo.childs as cbthird>
                                                            <#if cbthird.goodsCatId==-1>
                                                                <#if cbthird.url=="">
                                                                    <a href="javascript:;">${cbthird.name}</a>
                                                                <#else>
                                                                    <a href="${basePath}/${cbthird.url!'0'}">${cbthird.name}</a>
                                                                </#if>
                                                            <#else>
                                                                <a href="${basePath}/list/${cbthird.goodsCatId?c}-${cbthird.temp3!'0'}.html">${cbthird.name}</a>
                                                            </#if>
                                                        </#list>
                                                    </#if>
                                                </p>
                                            </li>

                                    </#list>
                                </ul>
                                </div>
                            <#else>
                                <div class="menuView hide">
                                    <ul>
                                        <li>
                                           <#-- <h3></h3>
                                            <p></p>-->
                                        </li>
                                    </ul>
                                </div>
                            </#if>
                        </#list>
                    </#if>
                </#if>


            </div>

     <#--这里-->
        </div>
    </div>
</div>
<#if channel.channelId ==243>
<div class="new_navigation_bar">
    <div>
        <h3 class="new_h3" style="position:absolute;padding:0;z-index:99;<#if channel.keyword??>background-color:${channel.keyword}</#if>">全&nbsp;部&nbsp;分&nbsp;类</h3>
        <ul class="new_ul">
            <li name="9,10,11,12,13,14,15"><a href="javascript:;">华东</a></li>
            <li name="16,17,18"><a href="javascript:;">华中</a></li>
            <li name="1,2,3,4,5"><a href="javascript:;">华北</a></li>
            <li name="19,20,21"><a href="javascript:;">华南</a></li>
            <li name="27,28,29,30,31"><a href="javascript:;">西北</a></li>
            <li name="22,23,24,25,26"><a href="javascript:;">西南</a></li>
            <li name="6,7,8"><a href="javascript:;">东北</a></li>
            <li name="32,33,34"><a href="javascript:;">港澳台</a></li>
          <#--  <li><a href="#">全部产地</a></li>-->
        </ul>
    </div>
</div>

<div style="width: 1200px;margin: 0 auto;">
    <div style="width:200px;float: left;height: 500px;"></div>
    <div class="hide two_categories">
          <#--<div class="imaginary_line">
                <div class="line_left">
                    <h3>安徽</h3>
                    <span>&nbsp;&nbsp;></span>
                </div>
              <ul>
                  <li><a href="#">祁门红茶（天之红牌）</a></li>
                  <li><a href="#">祁门红茶（祥源茶牌）</a></li>
                  <li><a href="#">黄淮白山羊</a></li>
                  <li><a href="#">润思牌红茶</a></li>
                  <li><a href="#">黄山毛峰</a></li>
                  <li><a href="#">六安瓜片</a></li>
                  <li><a href="#">泾县特尖</a></li>
                  <li><a href="#">太平猴魁（松谷牌）</a></li>
                  <li><a href="#">屯溪绿茶</a></li>
                  <li><a href="#">太岳西翠兰</a></li>
                  <li><a href="#">泾县特尖</a></li>
                  <li><a href="#">涌溪火青</a></li>
                  <li><a href="#">桐城小花</a></li>
                  <li><a href="#">桐城小花</a></li>
              </ul>
          </div>
        <div class="imaginary_line">
            <div class="line_left">
                <h3>福建</h3>
                <span>&nbsp;&nbsp;></span>
            </div>
            <ul>
                <li><a href="#">祁门红茶（天之红牌）</a></li>
                <li><a href="#">祁门红茶（祥源茶牌）</a></li>
                <li><a href="#">黄淮白山羊</a></li>
                <li><a href="#">润思牌红茶</a></li>
                <li><a href="#">黄山毛峰</a></li>
                <li><a href="#">六安瓜片</a></li>
            </ul>
        </div>
        <div class="imaginary_line">
            <div class="line_left">
                <h3>浙江</h3>
                <span>&nbsp;&nbsp;></span>
            </div>
            <ul>
                <li><a href="#">祁门红茶（天之红牌）</a></li>
                <li><a href="#">祁门红茶（祥源茶牌）</a></li>
                <li><a href="#">黄淮白山羊</a></li>
                <li><a href="#">润思牌红茶</a></li>
                <li><a href="#">黄山毛峰</a></li>

            </ul>
        </div>-->
    </div>
    <#--<div class="hide two_categories">

    </div>-->
</#if>
    <div class="show-box">
        <div id="slides">
        <#if avc?? && (avc?size>0)>
            <#list avc as bigAdvert>
                <a class="slide" href="${bigAdvert.adverHref!''}" style="background-image:url(${bigAdvert.adverPath});"></a>
            </#list>
        </#if>
        </div>
    </div>
<#if channel.channelId ==243>
</div>
</#if>
<#--960大聚惠改版-->
<#if navId??&&navId==309>
    <div class="big_poly_hui">
        <img src="${basePath}/images/new_jinriqianggou.png" alt="">
        <h3>商品大聚惠</h3>
    </div>
    <div class="poly_first">
        <div class="first_left">
            <h2>商品促销中</h2>
            <h3>爆款热卖</h3>
            <!-- Swiper -->
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <#if avs??&&(avs?size>0)>
                        <#list avs as smallAdvert>
                            <div class="swiper-slide" >
                                <a href="${smallAdvert.adverHref!'javascript:void(0);'}" >
                                    <img src="${smallAdvert.adverPath}" alt="">
                                </a>
                            </div>
                        </#list>
                    </#if>

                </div>
                <!-- Add Pagination -->
                <div class="swiper-pagination"></div>
                <#--<!-- Add Arrows &ndash;&gt;
                <div class="swiper-button-next"></div>
                <div class="swiper-button-prev"></div>-->
            </div>
        </div>
        <#if pageAdvs??&&(pageAdvs?size>0)>
            <#if (pageAdvs?size>=4)>
            <ul class="first_ul">
                <#list pageAdvs as pageAdv>
                    <#if (pageAdv_index < 4)>
                        <li>
                            <a href="${pageAdv.adverHref!'javascript:void(0);'}">
                                <div>
                                    <h3>${pageAdv.adverName!''}</h3>
                                    <p class="poly_p${pageAdv_index?number+1}">${pageAdv.temp2!''}</p>
                                </div>
                                <img src="${pageAdv.adverPath}" alt="">
                            </a>
                        </li>
                    </#if>
                </#list>
            </ul>
            </#if>
            <#if (pageAdvs?size>=5)>
                <div class="first_right">
                    <#list pageAdvs as pageAdv>
                        <#if pageAdv_index==4>
                            <img src="${pageAdv.adverPath}" alt="" class="title_img">
                        </#if>
                    </#list>

                <#if navGoods??>
                    <ul>
                        <#list navGoods as goods>
                            <#if (goods_index<4)>
                            <li>
                                <div class="right_one">
                                    <a href="${basePath}/item/${goods.goodsproductId}.html">
                                        <img src="${goods.goodsproductImgsrc?replace('!160','!352')}" alt="${goods.goodsproductName}" class="poly_soy">
                                        <#if (goods_index==0)>
                                              <img src="${basePath}/images/absolute_one.png" alt="" class="absolute_img">
                                        <#elseif (goods_index==1)>
                                              <img src="${basePath}/images/absolute_two.png" alt="" class="absolute_img">
                                        <#elseif (goods_index==2)>
                                              <img src="${basePath}/images/absolute_three.png" alt="" class="absolute_img">
                                        <#elseif (goods_index==3)>

                                        </#if>
                                    </a>
                                </div>
                                <div class="right_two">
                                    <a href="${basePath}/item/${goods.goodsproductId}.html">
                                    ${goods.goodsproductName!''}
                                    </a>
                                    <span>￥</span><span>${goods.goodsproductPrice}</span>
                                </div>
                            </li>
                            </#if>
                        </#list>
                    </ul>
                </#if>
                </div>
            </#if>
        </#if>
    </div>

    <#--promationinfo-->

    <div class="poly_list">
        <table>
        <#if mdNavGoods??>
            <#list mdNavGoods as goods>
                 <#if (goods_index%4==0)>
                        <tr>
                 </#if>
                <td>
                    <a href="${basePath}/item/${goods.goodsproductId}.html">
                        <img src="${goods.goodsproductImgsrc?replace('!160','!352')}" alt="" class="poly_list_images">
                    </a>
                    <a href="${basePath}/item/${goods.goodsproductId}.html" class="poly_list_a">
                     ${goods.goodsproductName!''}
                    </a>
                    <div class="poly_list_div">
                        <#if goods.promationinfo??>
                            <div>
                                <p>${goods.promationinfo!''}</p>
                                <i>折</i>
                            </div>
                        <#else>
                        <i style="display:inline-block;width:23px;"></i>
                        </#if>

                        <span>￥</span><span>${goods.goodsproductPrice}</span>
                        <a href="javascript:void(0);" class="poly_list_shop add_shop_cart" distinct_id="${distinctId}" data-role="${goods.goodsproductId}">
                            <img src="${basePath}/images/poly_list_shop.png" alt="${goods.goodsproductName}">
                        </a>
                    </div>

                </td>
                <#if (goods_index%4==3)>
                    </tr>
                </#if>
            </#list>
        </#if>
        </table>
    </div>
    <#--end-->
<#else>
    <#if navGoods??>
    <div class="greyBg">
        <div class="listContainer">
            <ul class="ul_list on products">
                <#list navGoods as goods>
                    <li>
                        <a href="${basePath}/item/${goods.goodsproductId}.html">
                            <img alt="${goods.goodsproductName}" src="${goods.goodsproductImgsrc?replace('!160','!352')}">
                            <span>${goods.goodsproductName!''}</span>
                        </a>
                        <div class="cx_yj">￥<strong>${goods.goodsproductPrice}</strong>
                            <a href="javascript:void(0);<#--${basePath}/item/${goods.goodsproductId}.html-->" data-role="${goods.goodsproductId}" distinct_id="${distinctId}" class="jiaru login add_shop_cart">立即购买</a>
                        </div>
                    </li>
                </#list>
            </ul>
        <#--<#if floors.indexAdvertList??>
            <ul class="ul_list on advs">
                <#list floors.indexAdvertList as adv>
                    <li>
                        <a href="${adv.adverHref!'#'}">
                            <img alt="${adv.adverName!''}" src="${adv.adverPath!'0'}">
                            &lt;#&ndash;<span>${goods.name!''}</span>&ndash;&gt;
                        </a>
                        &lt;#&ndash;<div class="cx_yj">￥<strong>${goods.price}</strong>&ndash;&gt;
                            &lt;#&ndash;<a href="${basePath}/item/${goods.id}.html" class="jiaru login">立即购买</a>&ndash;&gt;
                        &lt;#&ndash;</div>&ndash;&gt;
                    </li>
                </#list>
            </ul>
        </#if>-->
        </div>
    </div>
    </#if>
</#if>


<#--<div class="footer_tab">-->
    <#--<ul>-->

    <#--<#if topmap.advs??>-->
        <#--<#list topmap.advs as adv>-->
            <#--<#if (adv.adverSort>=11) && (adv_index<=14)>-->
                <#--<li class="list${adv.adverSort-10}"><a href="javascript:;" onclick="clickNav('${adv.adverHref!'#'}')">${adv.adverName!''}</a></li>-->
            <#--</#if>-->
        <#--</#list>-->
    <#--</#if>-->
        <#--&lt;#&ndash;<li class="list1"><a href="#" target="_self">食品荟萃</a></li>-->
        <#--<li class="list2"><a href="#" target="_self">饮品总汇</a></li>-->
        <#--<li class="list3"><a href="#" target="_self">购物中心</a></li>-->
        <#--<li class="list4"><a style="text-indent:17px;" href="#" target="_self">大 药 房</a></li>&ndash;&gt;-->
    <#--</ul>-->
<#--</div>-->
<#--<div class="line iconlist">
    <div style="width:1197px;margin:0 auto;">
        <a href="#" class="a1"><img src="${basePath}/index_960/images/icon_menu1.png"></a>
        <a href="#"><img src="${basePath}/index_960/images/icon_menu6.png"></a>
        <a href="#"><img src="${basePath}/index_960/images/icon_menu5.png"></a>
        <a href="javascript:;"><img src="${basePath}/index_960/images/icon_menu2.png"></a>
        <a href="javascript:;"><img src="${basePath}/index_960/images/icon_menu3.png"></a>
        <a href="javascript:;"><img src="${basePath}/index_960/images/icon_menu4.png"></a>
    </div>
</div>-->

<div class="rightpar">
    <div class="rightbar on0" style="padding:0;z-index:99;background: #9d9ca2; <#--<#if channel.keyword??>background-color:${channel.keyword}</#if>-->">
        <div class="<#--rightbar_body-->"  style="margin-top: 0px;">
            <div style="padding:0 0px;margin-top: 0px;border-bottom: 1px solid #ffffff;" >
                <div class="new_bgcolor" style="margin: 0;height: 50px;"><a href="${basePath}/index.html"><img style="margin-top: 13px;"   class="homeicon" src="${basePath}/index_960/images/new_fixiconzhuye.png"></a></div>
<#--
                <#if topmap.advs??>
                    <#list topmap.advs as adv>
                        <#if (adv.adverSort>=7) && (adv.adverSort<=10)>
                            <div style="margin: 0; height: 50px;" class="rightbar_list${adv.adverSort-6} new_bgcolor"><a style="margin: 0;" href="javascript:;" onclick="clickNav('${adv.adverHref!'#'}')">${adv.adverName!''}</a></div>
                        </#if>
                    </#list>
                </#if>-->
                <#--<div class="rightbar_list1"> <a href="#">食品荟萃</a></div>
                <div class="rightbar_list2"><a href="#">饮品总汇</a></div>
                <div class="rightbar_list3"><a href="#">购物中心</a></div>
                <div class="rightbar_list4"><a href="#">大药房</a></div>-->
                <div  style="display: none" name="showMy960" class="showMy960"><a href="${basePath}/customer/index.html"><img src="${basePath}/index_960/images/fixicon4.png"></a></div>
            </div>
            <!--侧边栏二维码-->
            <div  class="iphone_download new_bgcolor" style="margin: 0;height: 50px;border-bottom: 1px solid #ffffff;">
                <a href="#"   class="a" style="cursor: default;margin: 0;">
                    <img src="${basePath}/images/btn_erweima_iphone.png">
                <#--  <a style="cursor: default;"><span  style="color:#fff;font-size: 12px">手<br>机<br>端<br>下<br>载</span></a>-->
                </a>
                <div class="iphone_download_sidebar">
                    <div>
                        <img src="${basePath}/images/erweima2.png">
                        <p> 960微信公众号</p>
                    </div>
                    <img class="img" src="${basePath}/images/blank.png" >
                    <div>
                        <img src="${basePath}/images/erweima1.png">
                        <p> 960手机APP</p>
                    </div>
                </div>
            </div>
        <#--客服电话-->
            <div class="new_service new_bgcolor">
                <a href="#"   class="a" style="cursor: default;margin: 0;">
                    <img src="${basePath}/index_960/images/new_zaixiankefu.png">
                </a>
                <div class="new_service_sidebar">
                    <h3>400-808-8880</h3>
                    <p>周一至周日（8:00~20:00）</p>
                </div>
            </div>
            <div class="shopcarright new_bgcolor" style="position: relative;margin: 0;height: 50px;">

                <a class="login shopcarright_img" style="display:block;" href="/myshoppingcart.html">
                    <img style="margin-right:5px;" src="${basePath}/index_960/images/new_gowuche.png" >
                  <#--  <a class="hide_a" href="/myshoppingcart.html"><span style="color:#fff;font-size: 12px">购<br>物<br>车</span></a>-->
                </a>
                <#--<div class="shopcaritemnum"  onclick="window.location.href='/myshoppingcart.html'"></div>-->
                <div class="shopcarright_list headMiniShopcart gouwuche" style="height: 236px;right:40px; display: none;position: absolute;top: -206px;z-index: 999;bottom:-130px; background: #fafafa;">
                    <div class="form cart-goods" style="margin:0;max-height: 202px; overflow-y: scroll;overflow-x: hidden;background: rgb(250, 250, 250);">

                    </div>
                    <div class="li_btn" style="text-align: left;background: rgb(250, 250, 250);">
                        <p style="float:left;padding-left:5px;padding-top: 5px;">
                            <span>共 <i class="li_g mcNumTotal">0</i> 件商品</span>&nbsp;&nbsp;
                            <span>共计：<font style="font-weight: bold; color: #ff4e01;">¥<b class="li_m mcTotalFee">0.00</b></font></span>&nbsp;&nbsp;
                        </p>
                        <a style="color:#fff;background: #35a400;" href="${basePath}/myshoppingcart.html" class="login submit_btn1">去购物车</a>
                    </div>

                </div>


            </div>
            <div class="scroll_top new_bgcolor" style="margin: 20px 0 0 0;height: 50px;"><a href="javascript:;" title="回到顶部" style="color: #ffffff;font-size: 14px;padding-top: 10px;display: block;">顶部<img src="${basePath}/index_960/images/top_xiangshang.png"></a></div>
        </div>
    </div>

</div>
<div class="bgPop"></div>

<input id="channelId" value="${channel.channelId}" type="hidden">
<#--960大聚会小图轮播-->
<p style="display: none;">
<#--友盟CNZZ统计-->
    <script src="https://s13.cnzz.com/z_stat.php?id=1263930585&web_id=1263930585" language="JavaScript">
        //声明_czc对象:
        var _czc = _czc || [];
        //绑定siteid，请用您的siteid替换下方"XXXXXXXX"部分
        _czc.push(["_setAccount", "www.ge960.com"]);
    </script>
</p>
<script src="${basePath}/js/swiper-4.2.2.min.js"></script>
<script>
    $(function () {
        var swiper = new Swiper('.swiper-container', {
            spaceBetween: 30,
            centeredSlides: true,
            autoplay: {
                delay: 2500,
                disableOnInteraction: false,
            },
            pagination: {
                el: '.swiper-pagination',
                clickable: true,
            },
            /*navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            },*/
        });
    })

</script>
<#--end-->
<script>

$(function () {
  /*      var h = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
        var top = (h - 406)/2;
        $(".rightpar").css({"top":top});*/
        $(".bgPop").css({ "width": $(document).width(), "height": $(document).height() });

    })
   $(document).scroll(function(){
       var distance = $(document).scrollTop();
       // console.log(distance);
       if(distance >= 200) {
           $(".scroll_top").show();
       } else {
           $(".scroll_top").hide();
       }

   })
</script>
<#--主题商城不加楼层-->
<#if navId?? && (navId >0)>
<#else>
<#include "../channel/new_channel.ftl">
</#if>
<#include "../index/newbottom.ftl">
<#include "../shoppingcart/mincart.ftl"/>
<!-- 提示框-->
<#include "../infotips.ftl">
<script type="text/javascript" src="${basePath}/js/goods/goods_comm.js"></script>
<script type="text/javascript" src="${basePath}/index_960/js/app.js?v=012"></script>
<script type="text/javascript">
    $(function () {
        $(".menuView").mouseout(function () {
            $(".new_gang").hide();
        })
        $(".dropdown-menu").find("li").hover(function () {
            $(this).find(".new_gang").show();
        },function () {
            $(this).find(".new_gang").hide();
        })
        $(".menuView").mouseover(function () {
            $(".new_gang").show();
        })

    })
    $(function () {
        var  time = "";
        $(".new_ul li").mouseover(function(){
            var provinceId = $(this).attr("name");
            $.ajax({
                url:"/selectClassifyByProvinceWithAjax.htm",
                type:"post",
                data:"provinceId="+provinceId,
                async:false,
                success:function (map) {
                    var str = "";
                    for(var key in map){
                        //console.info(key + "---------" + map[key]);
                        var list = map[key];
                        str += '<div class="imaginary_line"><div class="line_left">';
                        str += '<h3>'+key+'</h3>';
                        str += '<span>&nbsp;&nbsp;></span></div><ul>';
                        for(var index in list) {
                            str += '<li><a href="${basePath}/goods/searchProduct2.html?title='+list[index]+'">' + list[index] + '</a></li>';
                        }
                        str += '</ul></div>';
                    }
                    $(".two_categories").html(str);
                    $('.imaginary_line:last').addClass("marginbottom");
                }
            })
            var cur = $(this);
            var index = $(this).index();
            var dl = $(".new_ul").children("li");
            time = setTimeout(function(){
                dl.removeClass("hover_bg").eq(index).addClass("hover_bg");
                dl.find("a").removeClass("color_hover").eq(index).addClass("color_hover");
                $(".new_ul").addClass("new_new_ul");
                $(".two_categories:visible").hide();
                $(".two_categories").show();
            },100);
        }).mouseout(function(){
            clearTimeout(time);

        });
        function hideTime(){
            $(".new_ul").find(".hover_bg").removeClass("hover_bg");
            $(".new_ul").find(".color_hover").removeClass("color_hover");
            $(".two_categories:visible").hide();
        };
        $(".two_categories").mouseleave(function(){
            hideTime();
            $(".new_ul").removeClass("new_new_ul");
        });
        $(".section-header").mouseover(function(){
            hideTime();
        });
        $(".dropdown-menu li").mouseleave(function(){
            hideTime();
        });
    });
    function clickNav(url){
        if(url.indexOf("http://")!=-1){
            window.open(url);
        }else{
            window.open("${basePath}/"+url);
        }
    }
    $(function () {
        $(".new_div_header:first").find("img").addClass("HelpNow");
        $(".header_nv:last").find(".header_nv_a").addClass("HelpNow1");
    })

    /*侧边栏二维码*/
    $(function () {
        $(".iphone_download").mouseover(function () {
            $("iphone_download_sidebar").show();
        })
        $(".iphone_download").mouseout(function () {
            $("iphone_download_sidebar").hide();
        })
        if(${channel.channelId}== 243 ){
            $(".slidesjs-pagination-item").find("a").html("");

        }
    })


    function dia(n){
        win();
        $(".mask").fadeIn();
        $(".dia"+n).fadeIn();
    };

    function cls(){
        $(".dialog").fadeOut();
        $(".mask").fadeOut();
    };
    function win(){
        var _wd = $(window).width();
        var _hd = $(window).height();
        $(".dia1").css("top",(_hd - $(".dialog").height())/2).css("left",(_wd * .5) - ($(".dia1").width() *  .5));
        $(".dia2").css("top",(_hd - $(".dialog").height())/2).css("left",(_wd * .5) - ($(".dia2").width() *  .5));
    };
</script>
</body>
</html>
