
<#if shopKuaiShang?? && shopKuaiShang.operation?? && shopKuaiShang.isuseing?? && shopKuaiShang.isuseing =='0'>
${shopKuaiShang.operation !''}
</#if>
<#assign basePath=request.contextPath>
<link rel="stylesheet" type="text/css" href="${basePath}/index_960/css/style.css"/>
<link rel="stylesheet" type="text/css" href="${basePath}/css/new_content.css"/>
<link rel="stylesheet" type="text/css" href="${basePath}/index_960/css/style_mend.css"/>
<style>
    /*.footer_tab{
        margin-top: 40px!important;
    }*/
</style>
<#--第一部分-->
<div class="content_one">
    <div class="one_ct">
    <#if topmap.advs??>
        <#list topmap.advs as adv>
            <#if (adv.adverSort>=15) && (adv.adverSort<=18)>
                <a href="${adv.adverHref!'#'}" onclick="_czc.push(['_trackEvent', '首页', '查看', '${adv.adverHref!'#'}',  'index_adver']);" id="index_adver"><img src="${adv.adverPath}"></a>
            </#if>
        </#list>
    </#if>
    </div>
</div>
<#--&lt;#&ndash;第二部分 限时抢购&ndash;&gt;
<#if bottom.marketingRush?? && (bottom.marketingRush.list?size>0)>
<div class="content_two">
    <div class="two_ct">
        <a href="http://www.ge960.com/marketingrushlist-1.html"><img src="${basePath}/images/ct_xianshiqianggou.png"></a>
            <ul class="two_ul">
                <#list bottom.marketingRush.list as rush>
                    <#assign rushPrice = 0.00>
                    <#if ((rush.marketing.rushs[0].rushDiscount?number*rush.goodsProductVo.goodsInfoPreferPrice?number))??>
                        <#if ((rush.marketing.rushs[0].rushDiscount?number*rush.goodsProductVo.goodsInfoPreferPrice?number)>0.005)>
                            <#assign rushPrice = (((rush.marketing.rushs[0].rushDiscount?number*rush.goodsProductVo.goodsInfoPreferPrice?number)-0.005)?string("0.00"))!"">
                        <#else>
                            <#assign rushPrice = ((rush.marketing.rushs[0].rushDiscount?number*rush.goodsProductVo.goodsInfoPreferPrice?number)?string("0.00"))!"">
                        </#if>
                    </#if>
                <li>
                    <a href="${basePath}/item/${rush.goodsProductVo.goodsInfoId}.html">
                         <img src="${rush.marketing.rushs[0].rushImage!''}" width="176" height="176">
                         <div class="li_div">
                             <p>${rush.goodsProductVo.productName}</p>
                             <div class="li_div_one">
                                 <span class="big_span">￥${rushPrice?split(".")[0]}.<span class="small_span">${rushPrice?split(".")[1]}</span></span>
                                 <i>￥${rush.goodsProductVo.goodsInfoPreferPrice?string('0.00')}</i>
                             </div>
                         </div>
                    </a>
                </li>
                </#list>
            </ul>
        <#if topmap.advs??>
            <#list topmap.advs as adv>
                <#if (adv.adverSort==19)>
                    <img src="${adv.adverPath}" width="160" height="264"
                         <#if adv.adverHref?? && (adv.adverHref?length>0)>
                            onclick="location.href='${adv.adverHref}'" style="cursor: pointer;"
                         </#if>
                         >
                </#if>
            </#list>
        <#else>
            <img src="${basePath}/images/ct_longmenmicu.png">
        </#if>
    </div>
</div>
</#if>

<#if bottom.channelStoreys?? && (bottom.channelStoreys?size>0)>
    <#list bottom.channelStoreys as storey>
    &lt;#&ndash;第三部分  楼层1的内容&ndash;&gt;
    <#if storey_index ==0>
        <div class="content_three">
            <div class="ct_three" style="background-image: url(${storey.storeyImg});">
                <ul class="three_top">
                    <#if storey.channelStoreyGoods?? && (storey.channelStoreyGoods?size>0)>
                        <#list storey.channelStoreyGoods as goods>
                            <li>
                                <a href="${basePath}/item/${goods.goodsproductId}.html">
                                    <img src="${goods.goodsproductImgsrc?replace('!160','!352')}" width="174" height="174">
                                    <div class="li_div">
                                        <p>${goods.goodsproductName}</p>
                                        <span class="big_span">￥${(goods.goodsproductPrice?string('0.00'))?split(".")[0]}.<span class="small_span">${(goods.goodsproductPrice?string('0.00'))?split(".")[1]}</span></span>
                                    </div>
                                </a>
                            </li>
                        </#list>
                    </#if>
                </ul>
            </div>
        </div>
    <#else>
        &lt;#&ndash;第四部分  楼层2及之后的楼层&ndash;&gt;
        <div class="content_four">
            <div class="ct_four">
                <div class="ct_four_top">
                    <h3>${storey.storeyName}</h3>
                    <p>${storey.temp4}</p>
                </div>
                <div class="ct_four_bottom">
                    <img class="four_img" src="${storey.storeyImg}" width="320" height="530">
                    <ul>
                        <#if storey.channelStoreyGoods?? && (storey.channelStoreyGoods?size>0)>
                            <#list storey.channelStoreyGoods as goods>
                                <#if (goods_index<10)>
                                    <li>
                                        <a href="${basePath}/item/${goods.goodsproductId}.html">
                                            <img src="${goods.goodsproductImgsrc?replace('!160','!352')}" width="174" height="174">
                                            <div class="li_div">
                                                <p>${goods.goodsproductName}</p>
                                                <span class="big_span">￥${(goods.goodsproductPrice?string('0.00'))?split(".")[0]}.<span class="small_span">${(goods.goodsproductPrice?string('0.00'))?split(".")[1]}</span></span>
                                            </div>
                                        </a>
                                    </li>
                                </#if>
                            </#list>
                        </#if>
                    </ul>
                </div>
            </div>
        </div>
    </#if>
    </#list>
</#if>-->
<script>
	<#if cust??>
	    $(".rightbar_body").find("div[name='showMy960']").show();
	</#if>

</script>
<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?f3f6849d9a09fbba55460140f3b889c5";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>