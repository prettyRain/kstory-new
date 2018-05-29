<#assign basePath=request.contextPath>
<!--遮罩层-->
<style>
    .new_bgcolor:hover{
        background-color:${topmap.backgroundColor};
    }
   /* .new_bgcolor a:hover{
        color: #ffffff!important;
    }*/
   /* .header_nv_a:hover p{
       color:red!important;
    }*/
</style>
<script>
    $(function () {/**/
     /*   $(".header_nv_a").hover(function () {
            $(this).find("p").css({"color":"red"})
            $(this).find("img").attr("src","路径")
        },function () {
            $(this).find("p").css({"color":"#666666"})
            $(this).find("img").attr("src","原始路径")
        })*/
        $(".new_div_header:first").find("img").addClass("HelpNow");
        $(".header_nv:last").find(".header_nv_a").addClass("HelpNow1");
    })
</script>
<div id="sectionHeader" class="section-header">
    <div class="tm-content">
        <h1 id="logo">
            <#--<a href="${topmap.systembase.bsetAddress}"><img alt="" src="${topmap.systembase.bsetLogo}" style="width: 181px;height: 72px;"></a>-->
            <a href="${basePath}/index.html"><img alt="" src="${topmap.systembase.bsetLogo}" style="width: 181px;height: 72px;    margin-top: 25px;"></a>
        </h1>
      <#--  <div class="logoBanner">
        &lt;#&ndash;    <!-- 广告11111位置 &ndash;&gt;
        <#if topmap.logoAdv1??>
            <a href="${(topmap.logoAdv1.adverHref)!'#'}" target="_blank">
                <#if (topmap.logoAdv1.adverPath) ??>
                    <img alt="" src="${(topmap.logoAdv1.adverPath)}" style="max-width:480px;height:94px">
                </#if>
            </a>
        </#if>
        <#if topmap.logoAdv2??>
            <a href="${(topmap.logoAdv2.adverHref)!'#'}" target="_blank">
                <#if (topmap.logoAdv2.adverPath) ??>
                    <img alt="" src="${(topmap.logoAdv2.adverPath)}" style="max-width:480px;height:94px">
                </#if>
            </a>
        </#if>&ndash;&gt;

        </div>-->
        <div class="header_nv">
         <div style="float: left;height: 65px;padding-top: 59px;">
            <#if topmap.advs??>
                <#list topmap.advs as adv>
                    <#if (adv.adverSort>=3) && (adv.adverSort<=6)>
                    <a class="header_nv_a" onclick=" _czc.push(['_trackEvent', '首页', '头部', '${adv.adverName!''}',  'dianji_ok']);clickNav('${adv.adverHref!'#'}')"   href="javascript:;"style="padding-right: 0px;"  id="dianji_ok">
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
            <a href="/myshoppingcart.html" style="padding-right: 0px;" onclick="_czc.push(['_trackEvent', '首页', '查看', '购物车',  'XXcard']);" id="XXcard">
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
    <div class="mainnav">
        <div class="tm-content" style="height: 48px;">
            <div class="navLinks">
                <ul>
                <#if (topmap.navList)?? && (topmap.navList?size>0)>
                    <#list topmap.navList as nav>
                        <#if (nav_index < 8)>
                            <#if (nav.barId != 271 && nav.barId != 307 && nav.barId != 261  && nav.barId != 275 && nav.barId != 277 && nav.barId != 279 && nav.barId != 281 && nav.channelId??)>
                                <#if (nav.barId != 311)>
                                    <li><a  class="navLink <#if navId?? && nav.barId==navId>on</#if>" href="${nav.barUrl}?channelId=${nav.channelId}"  onclick="_czc.push(['_trackEvent', '首页', '头部', '${(nav.barName)!''}',  'toubu_ok']);" id="toubu_ok">${(nav.barName)!''}</a></li>
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
                                    <a class="navLink <#if navId?? && nav.barId==navId>on</#if>" data-subjectId="${nav.barUrl?substring(nav.barUrl?last_index_of('/')+1)}"  href="${nav.barUrl}?channelId=${nav.channelId}" onclick="_czc.push(['_trackEvent', '首页', '头部', '${(nav.barName)!''}',  'toubu_ok']);" id="toubu_ok">${(nav.barName)!''}</a>
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
              <#--  <span>&nbsp;<img id="shopcartid" class="searchbuttonarea_gw" src="${basePath}/index_960/images/index2_08.png"></span>-->
                <#--<div class="shopcarright_list headMiniShopcart" style="right:0px; display: none; top: -30px;">
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
                            <div class="searchdiv" style=" margin-right: 72px;width: 826px;">
                                <!-- 搜索框 -->
                <form id="mallSearch-form" action="${basePath}/goods/searchproduct2.html" method="get" >
                    <div style="float: right;  padding: 4px 6px 7px 0px;" onclick="hideSearch()">
                        <img src="${basePath}/index_960/images/index3_03.png" style="cursor: pointer;">
                    </div>
                    <div id="search" style="float: right;">
                        <input type="text" id="wd" class="search hotsearchInput" autocomplete="off" name="title" placeholder="搜索960商城商品">
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

                    <div style="float: right;padding: 4px 8px 7px 0px;cursor: default;" onclick="checkSearch()">
                        <img src="${basePath}/index_960/images/index2_06.png" tppabs="http://ge960.com/pic/index2_06.png">
                    </div>

                    <div class="clear"></div>
                </form>
                                <div class="cast_about1">
                                    <p>点击回车键进行搜索</p>
                                </div>
                                <div class="cast_about">
                                    <div class="cast_top">
                                        <img src="${basePath}/images/icon_jianyisousuo.png">
                                        <p>热搜建议</p>
                                    </div>
                                    <div class="cast_content">
                                        <ul>

                                       <#--     <li><p>猪 肉<img src="${basePath}/images/btn_more.png"></p><span>23件</span></li>
                                            <li><p>禽 蛋<img src="${basePath}/images/btn_more.png"></p><span>23件</span></li>
                                            <li><p>鱼 肉<img src="${basePath}/images/btn_more.png"></p><span>23件</span></li>
                                            <li><p>驴 肉<img src="${basePath}/images/btn_more.png"></p><span>23件</span></li>-->
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
                    <#if topmap.channel??>
                        <#if topmap.channel.channelName=='食品荟萃'||topmap.channel.channelName=='饮品总汇'||topmap.channel.channelName=='购物中心'||topmap.channel.channelName='原产地'>
                        ${topmap.channel.channelName+'分类'}
                        <#else>
                            所有商品分类
                        </#if>
                    <#else>
                        所有商品分类
                    </#if>
                    </a>
                </i>
          <#--      <ul class="list dropdown-menu" style="<#if topmap.backgroundColor??>background-color:${topmap.backgroundColor}</#if>">
                <#if (topmap.classifyBar.classifyBarList)?? && (topmap.classifyBar.classifyBarList?size>0)>
                    <#list topmap.classifyBar.classifyBarList as cBar>
                    &lt;#&ndash;隐藏多出部分的分类&ndash;&gt;
                    <li <#if (cBar_index>12) >style="display: none;" </#if>>
                        <div class="links">
                        <#if (cBar.barCate)?? && (cBar.barCate?size>0)>
                            <#list cBar.barCate as bcate>
                                <#if bcate.cateId==-1>
                                    <#if bcate.temp2=="">
                                        <a href="javascript:;">${bcate.cateName}</a>
                                    <#else>
                                        <a href="javascript:;">${bcate.cateName}</a>
                                    </#if>
                                <#elseif bcate.cateId??>
                                    <a href="javascript:;">${bcate.cateName}</a>
                                </#if>
                            </#list>
                        <#else>
                        <a href="javascript:;">${cBar.name}</a>
                        </#if>
                        </div>
                    </li>
                    </#list>
                </#if>
                </ul>-->

                <ul class="list dropdown-menu" style="<#if topmap.backgroundColor??>background-color:${topmap.backgroundColor}</#if>">
                    <#if (topmap.classifyBar.classifyBarList)?? && (topmap.classifyBar.classifyBarList?size>0)>
                        <#list topmap.classifyBar.classifyBarList as cBar>
                            <li <#if (cBar_index>12) >style="display: none;" </#if>>
                                <#--隐藏多出部分的分类-->
                                <div class="new_gang"></div>
                                <div class="links">
                                    <img class="new_iconimg" src="${cBar.imgSrc!''}" alt="">
                                    <#if (cBar.barCate)?? && (cBar.barCate?size>0)>
                                        <#list cBar.barCate as bcate>
                                            <#if bcate.cateId==-1>
                                                <#if bcate.temp2=="">
                                                    <a href="javascript:;">${bcate.cateName}</a>
                                                <#else>
                                                    <a href="javascript:;">${bcate.cateName}</a>
                                                </#if>
                                            <#elseif bcate.cateId??>
                                                <a href="javascript:;">${bcate.cateName}</a>
                                            </#if>
                                        </#list>
                                    <#else>
                                        <a href="javascript:;">${cBar.name}</a>
                                    </#if>
                                    <img class="new_youla" src="${basePath}/index_960/images/new_youlajiantou.png" alt="">
                                </div>
                            </li>
                        </#list>
                    </#if>

                <#--        <li>
                            <div class="new_gang"></div>
                            <div class="links">
                                <img class="new_iconimg" src="${basePath}/index_960/images/new_icon2.png" alt="">
                                <a href="javascript:;">时令水果</a>
                                <img class="new_youla" src="${basePath}/index_960/images/new_youlajiantou.png" alt="">
                            </div>
                        </li>
                        <li>
                            <div class="new_gang"></div>
                            <div class="links">
                                <img class="new_iconimg" src="${basePath}/index_960/images/new_icon3.png" alt="">
                                <a href="javascript:;">肉禽蛋品</a>
                                <img class="new_youla" src="${basePath}/index_960/images/new_youlajiantou.png" alt="">
                            </div>
                        </li>
                        <li>
                            <div class="new_gang"></div>
                            <div class="links">
                                <img class="new_iconimg" src="${basePath}/index_960/images/new_icon4.png" alt="">
                                <a href="javascript:;">水产熟食</a>
                                <img class="new_youla" src="${basePath}/index_960/images/new_youlajiantou.png" alt="">
                            </div>
                        </li>
                        <li>
                            <div class="new_gang"></div>
                            <div class="links">
                                <img class="new_iconimg" src="${basePath}/index_960/images/new_icon5.png" alt="">
                                <a href="javascript:;">粮油调味</a>
                                <img class="new_youla" src="${basePath}/index_960/images/new_youlajiantou.png" alt="">
                            </div>
                        </li>
                        <li>
                            <div class="new_gang"></div>
                            <div class="links">
                                <img class="new_iconimg" src="${basePath}/index_960/images/new_icon6.png" alt="">
                                <a href="javascript:;">素食冷冻</a>
                                <img class="new_youla" src="${basePath}/index_960/images/new_youlajiantou.png" alt="">
                            </div>
                        </li>
                        <li>
                            <div class="new_gang"></div>
                            <div class="links">
                                <img class="new_iconimg" src="${basePath}/index_960/images/new_icon7.png" alt="">
                                <a href="javascript:;">素食糕点</a>
                                <img class="new_youla" src="${basePath}/index_960/images/new_youlajiantou.png" alt="">
                            </div>
                        </li>
                        <li>
                            <div class="new_gang"></div>
                            <div class="links">
                                <img class="new_iconimg" src="${basePath}/index_960/images/new_icon8.png" alt="">
                                <a href="javascript:;">零食果茶</a>
                                <img class="new_youla" src="${basePath}/index_960/images/new_youlajiantou.png" alt="">
                            </div>
                        </li>
                        <li>
                            <div class="new_gang"></div>
                            <div class="links">
                                <img class="new_iconimg" src="${basePath}/index_960/images/new_icon9.png" alt="">
                                <a href="javascript:;">中外名酒</a>
                                <img class="new_youla" src="${basePath}/index_960/images/new_youlajiantou.png" alt="">
                            </div>
                        </li>
                        <li>
                            <div class="new_gang"></div>
                            <div class="links">
                                <img class="new_iconimg" src="${basePath}/index_960/images/new_icon10.png" alt="">
                                <a href="javascript:;">药酒保健</a>
                                <img class="new_youla" src="${basePath}/index_960/images/new_youlajiantou.png" alt="">
                            </div>
                        </li>
                        <li>
                            <div class="new_gang"></div>
                            <div class="links">
                                <img class="new_iconimg" src="${basePath}/index_960/images/new_icon11.png" alt="">
                                <a href="javascript:;">饮品果汁</a>
                                <img class="new_youla" src="${basePath}/index_960/images/new_youlajiantou.png" alt="">
                            </div>
                        </li>
                        <li>
                            <div class="new_gang"></div>
                            <div class="links">
                                <img class="new_iconimg" src="${basePath}/index_960/images/new_icon12.png" alt="">
                                <a href="javascript:;">功能饮料</a>
                                <img class="new_youla" src="${basePath}/index_960/images/new_youlajiantou.png" alt="">
                            </div>
                        </li>
                        <li>
                            <div class="new_gang"></div>
                            <div class="links">
                                <img class="new_iconimg"  src="${basePath}/index_960/images/new_icon13.png" alt="">
                                <a href="javascript:;">茶冲咖啡</a>
                                <img class="new_youla" src="${basePath}/index_960/images/new_youlajiantou.png" alt="">
                            </div>
                        </li>-->

                </ul>
<#if (topmap.classifyBar.classifyBarList)?? && (topmap.classifyBar.classifyBarList?size>0)>
    <#list topmap.classifyBar.classifyBarList as cBar>
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
                             <#--去掉链接-->
                                <h3><#--<a href="${basePath}/list/${cbtwo.goodsCatId?c}-${cbtwo.temp3!'0'}.html">-->
                                    <a href="javascript:void(0)" style="cursor:default;">${cbtwo.name}</a></h3>
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
                      <#--  <h3></h3>
                        <p></p>-->
                    </li>
                </ul>
            </div>
        </#if>

    </#list>
</#if>

                       <#-- <div class="menuView hide">
                                <ul class="new_menu_ul">
                                    <li>
                                        <h3><a href="javascript:;" style="cursor:default;">米</a></h3>
                                        <p>
                                            <a href="javascript:;">大米</a>
                                            <a href="javascript:;">香米</a>
                                            <a href="javascript:;">糙米</a>
                                        </p>
                                    </li>
                                    <li>
                                        <h3><a href="javascript:;" style="cursor:default;">面</a></h3>
                                        <p>
                                            <a href="javascript:;">富强粉</a>
                                            <a href="javascript:;">小麦粉</a>
                                            <a href="javascript:;">面包粉</a>
                                            <a href="javascript:;">莜面</a>
                                            <a href="javascript:;">全麦粉</a>
                                            <a href="javascript:;">玉米粉</a>
                                            <a href="javascript:;">雪花粉</a>
                                            <a href="javascript:;">黄米面</a>
                                            <a href="javascript:;">糯米粉</a>
                                            <a href="javascript:;">淀粉</a>
                                        </p>
                                    </li>
                                    <li>
                                        <h3><a href="javascript:;" style="cursor:default;">杂粮</a></h3>
                                        <p>
                                            <a href="javascript:;">小米</a>
                                            <a href="javascript:;">红豆</a>
                                            <a href="javascript:;">黑米</a>
                                            <a href="javascript:;">藜麦</a>
                                        </p>
                                    </li>
                                    <li>
                                        <h3><a href="javascript:;" style="cursor:default;">食用油</a></h3>
                                        <p>
                                            <a href="javascript:;">花生油</a>
                                            <a href="javascript:;">橄榄油</a>
                                            <a href="javascript:;">调和油</a>
                                            <a href="javascript:;">黄油</a>
                                            <a href="javascript:;">大豆油</a>
                                            <a href="javascript:;">亚麻籽油</a>
                                            <a href="javascript:;">葵花籽油</a>
                                        </p>
                                    </li>
                                    <li>
                                        <h3><a href="javascript:;" style="cursor:default;">调味品</a></h3>
                                        <p>
                                            <a href="javascript:;">酱油</a>
                                            <a href="javascript:;">醋</a>
                                            <a href="javascript:;">料酒</a>
                                            <a href="javascript:;">甜面酱</a>
                                            <a href="javascript:;">盐</a>
                                            <a href="javascript:;">香油</a>
                                            <a href="javascript:;">芝麻酱</a>
                                            <a href="javascript:;">调味酱</a>
                                            <a href="javascript:;">火锅料</a>
                                            <a href="javascript:;">鸡精味精</a>
                                            <a href="javascript:;">耗油</a>
                                        </p>
                                    </li>
                                </ul>
                        </div>

                        <div class="menuView hide">
                            <ul class="new_menu_ul">
                                <li>
                                    <h3></h3>
                                    <p></p>
                                </li>
                            </ul>
                        </div>-->
            </div>
        </div>
    </div>
</div>

<div class="rightpar">
    <div class="rightbar on0" style="padding:0;z-index:99;background: #9d9ca2; <#--<#if (topmap.backgroundColor??)>background-color:${topmap.backgroundColor}</#if>-->" >
        <div class="<#--rightbar_body-->" style="margin-top: 0px;">
            <div  style="padding:0 0px;margin: 0;border-bottom: 1px solid #ffffff;">
                <div class="new_bgcolor" style="margin: 0;height: 50px;"><a href="${basePath}/index.html"><img class="homeicon" style="margin-top: 13px;" src="${basePath}/index_960/images/new_fixiconzhuye.png"></a></div>

           <#-- <#if topmap.advs??>
                <#list topmap.advs as adv>
                    <#if (adv.adverSort>=7) && (adv.adverSort<=10)>
                    <div style="margin: 0; height: 50px;" class="rightbar_list${adv.adverSort-6} new_bgcolor"><a style="margin: 0;" href="${adv.adverHref!'#'}">${adv.adverName!''}</a></div>
                    </#if>
                </#list>
            </#if>-->
                <#--<div class="rightbar_list1"> <a href="#">食品荟萃</a></div>
                <div class="rightbar_list2"><a href="#">饮品总汇</a></div>
                <div class="rightbar_list3"><a href="#">购物中心</a></div>
                <div class="rightbar_list4"><a href="#">大药房</a></div>-->

                <div style="display: none" class="showMy960" name="showMy960"><a href="${basePath}/customer/index.html"><img src="${basePath}/index_960/images/fixicon4.png"></a></div>
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
            <div class="shopcarright new_bgcolor" style="position: relative;margin: 0;height: 50px;" >
                <a class="login shopcarright_img" style="display:block;" href="/myshoppingcart.html" >
                    <img style="margin-right:5px;" src="${basePath}/index_960/images/new_gowuche.png" >
                   <#-- <a href="/myshoppingcart.html"><span  style="color:#fff;font-size: 12px">购<br>物<br>车</span></a>-->
                </a>
           <#--     <div class="shopcaritemnum" onclick="window.location.href='/myshoppingcart.html'"></div>-->
                <div class="shopcarright_list headMiniShopcart gouwuche" style="height: 236px;right:40px; display: none;position: absolute;top: -206px;z-index: 999;bottom:-130px; background: #fafafa;">
                    <div class="form cart-goods" style="margin:0;max-height: 202px; overflow-y: scroll;overflow-x: hidden;background: rgb(250, 250, 250);">

                    </div>
                    <div class="li_btn" style="text-align: left;background: rgb(250, 250, 250);">
                        <p style="float:left;padding-left:5px;padding-top: 5px;">
                            <span>共 <i class="li_g mcNumTotal">1</i> 件商品</span>&nbsp;&nbsp;
                            <span>共计：<font style="font-weight: bold; color: #ff4e01;">¥<b class="li_m mcTotalFee">0.00</b></font></span>&nbsp;&nbsp;
                        </p>
                        <a  style="color:#fff;background: #35a400;" href="${basePath}/myshoppingcart.html" class="login submit_btn1">去购物车</a>
                    </div>
                </div>
            </div>
            <!---->
            <div class="scroll_top new_bgcolor" style="margin: 20px 0 0 0;height: 50px;"><a href="javascript:;" title="回到顶部" style="color: #ffffff;font-size: 14px;padding-top: 10px;display: block;">顶部<img src="${basePath}/index_960/images/top_xiangshang.png"></a></div>
        </div>

    </div>

</div>
<div class="bgPop"></div>
<p style="display: none;">
<#--友盟CNZZ统计-->
    <script src="https://s13.cnzz.com/z_stat.php?id=1263930585&web_id=1263930585" language="JavaScript">
        //声明_czc对象:
        var _czc = _czc || [];
        //绑定siteid，请用您的siteid替换下方"XXXXXXXX"部分
        _czc.push(["_setAccount", "www.ge960.com"]);
    </script>
</p>
<script>

    window.onload = function () {
        $(".slidesjs-pagination-item").find("a").html("");
    };
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
    $(document).scroll(function(){
        var distance = $(document).scrollTop();
       // console.log(distance);
        if(distance >= 200) {
            $(".scroll_top").show();
        } else {
            $(".scroll_top").hide();
        }

    })
    $(function () {
     /*   var h = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
        var top = (h - 1)/2;
        $(".rightpar").css({"top":top});*/
        $(".bgPop").css({ "width": $(document).width(), "height": $(document).height() });
    })

</script>

<script type="text/javascript">
    function clickNav(url,sort){
        if(url.indexOf("http://")!=-1){
            window.open(url);
        }else{
            window.open("${basePath}/"+url);
        }
    }
    //点击热门搜索的时候
    function changeSearchKey(obj){
        $(".inputSearch").val($(obj).html());
        $(".mallSearch-form").submit();
    }
    //搜索
    function checkSearch(){
       /* var search=$.trim($(".inputSearch").val());
        if(search==""){
            $(".inputSearch").val($(".inputSearch").attr("placeholder"));
        }else if(search.length>100){
            //限制长度，过长截取
            $(".inputSearch").val(search.substring(0,100));
        }*/
        var hotsearch = $(".hotsearch").val();
        if(hotsearch != "" && hotsearch != "undefined" && ($(".hotsearchInput").val() == "" || $(".hotsearchInput").val() == "undefined")){
            $(".hotsearchInput").val(hotsearch);
        }
        $("#mallSearch-form").submit();
    }

</script>


