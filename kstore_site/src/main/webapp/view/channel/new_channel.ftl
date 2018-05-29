
<#if shopKuaiShang?? && shopKuaiShang.operation?? && shopKuaiShang.isuseing?? && shopKuaiShang.isuseing =='0'>
${shopKuaiShang.operation !''}
</#if>
<#assign basePath=request.contextPath>
<link rel="stylesheet" type="text/css" href="${basePath}/index_960/css/style.css"/>
<link rel="stylesheet" type="text/css" href="${basePath}/css/channel/new_newchannel.css"/>
<link rel="stylesheet" type="text/css" href="${basePath}/index_960/css/style_mend.css"/>
<style>

</style>
<#--第一部分：今日限时抢-->
<#if marketingRush?? && (marketingRush?size>0)>
<div id="content_one">
    <div class="one_top">
        <img src="${basePath}/images/new_jinriqianggou.png" alt="">
        <p>今日限时抢</p>
        <a href="${basePath}/channel/247.html?navId=309">更多</a>
    </div>
    <div class="one_bottom">
        <#--限时抢购广告图-->
        <#if rushAdv??>
        <img src="${(rushAdv.adverPath)}" alt="" width="340" height="435">
        </#if>
        <div class="flash_sale">
            <div class="bottom_border">
                <img src="${basePath}/images/new_sale.png" alt="">
            </div>
            <ul class="flash_sale_ul">
                <#list marketingRush as rush>
                    <#if (rush_index < 3)>
                        <li>
                        <a href="${basePath}/item/${rush.goodsproductId}.html">
                            <img src="${rush.goodsproductImgsrc?replace('!160','!352')}" alt="" width="136" height="166">
                            <div class="new_li_div">
                                <p>${rush.goodsproductName}</p>
                                <div>
                                    <span>￥</span><span class="new_span">${rush.goodsproductPrice?string('0.00')}</span><span>${rush.goodsInfoPreferPrice?string('0.00')}</span>
                                </div>
                            </div>
                        </a>
                        </li>
                    </#if>
                </#list>
            </ul>
        </div>
    </div>
</div>
</#if>
<#if floor?? && floor.floorList?? && (floor.floorList?size>0)>
    <#list floor.floorList as storey>
        <#if storey_index==0>
            <#--第二部分，楼层1-->
            <div id="content_two" class="hiddenBottom">
                <div class="two_left" style="background-image: url(${storey.storeyImg})">
                    <div class="new_left_ct">
                        <ul class="new_ct_ul">
                            <#if storey.indexGoodsList?? && (storey.indexGoodsList?size>0)>
                                <#list storey.indexGoodsList as goods>
                                    <#if (goods_index < 6)>
                                    <li>
                                        <a href="${basePath}/item/${goods.id}.html">
                                            <img src="${goods.urlpic?replace('!160','!352')}" alt="" width="136" height="126">
                                            <div class="ct_div">
                                                <p>${goods.name}</p>
                                                <#--<p>${goods.number}</p>-->
                                                <div>
                                                    <span>￥</span><span>${goods.price?number?string("0.00")}</span>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    </#if>
                                </#list>
                            </#if>
                        </ul>
                    </div>
                </div>
                <div class="two_right">
                    <#if storey.indexAdvertList?? && (storey.indexAdvertList?size>0)>
                        <#list storey.indexAdvertList as adv>
                            <#if (adv.adverSort==1)>
                                <a href="<#if (adv.adverHref)?? && (adv.adverHref)!="">${adv.adverHref}<#else>javascript:;</#if>">
                                    <img src="${adv.adverPath}" alt="" width="175" height="236">
                                </a>
                            </#if>
                            <#if (adv.adverSort==2)>
                                <a href="<#if (adv.adverHref)?? && (adv.adverHref)!="">${adv.adverHref}<#else>javascript:;</#if>">
                                    <img src="${adv.adverPath}" alt="" width="175" height="236">
                                </a>
                            </#if>
                        </#list>
                    </#if>
                </div>
            </div>
        <#else>
            <#--第三部分，楼层2及以后-->
            <div id="content_three" class="hiddenBottom">
                <div class="three_top">
                    <img src="${storey.storeyRightImg}" alt="" width="24" height="22">
                    <p>${storey.storeyName}</p>
                    <span>${storey.storeySubTitle}</span>
                    <a href="<#if (storey.storeyImgHref)?? && (storey.storeyImgHref)!="">${storey.storeyImgHref}<#else>javascript:;</#if>">更多</a>
                </div>
                <#if storey.indexAdvertList?? && (storey.indexAdvertList?size>0)>
                    <#list storey.indexAdvertList as adv>
                        <#if (adv.adverSort==1)>
                        <div class="three_banner">
                            <a href="<#if (adv.adverHref)?? && (adv.adverHref)!="">${adv.adverHref}<#else>javascript:;</#if>">
                                <img src="${adv.adverPath}" alt="" width="1200" height="334">
                            </a>
                        </div>
                        </#if>
                    </#list>
                </#if>
                <#if storey.indexGoodsList?? && (storey.indexGoodsList?size>0)>
                    <table cellspacing="0">
                        <#list storey.indexGoodsList as goods>
                            <#if ((goods_index+1)%4==1)>
                            <tr>
                            </#if>
                                <td>
                                    <a href="${basePath}/item/${goods.id}.html">
                                        <img src="${goods.urlpic?replace('!160','!352')}" alt="">
                                        <p>${goods.name}</p>
                                        <span>￥</span><span>${goods.price?number?string("0.00")}</span>
                                        <i></i>
                                    </a>
                                </td>
                            <#if ((goods_index+1)%4==0)>
                            </tr>
                            </#if>
                        </#list>
                    </table>
                </#if>
                <#if storey.indexAdvertList?? && (storey.indexAdvertList?size>0)>
                    <#list storey.indexAdvertList as adv>
                        <#if (adv.adverSort==2)>
                            <div class="three_banner2">
                                <a href="<#if (adv.adverHref)?? && (adv.adverHref)!="">${adv.adverHref}<#else>javascript:;</#if>">
                                    <img src="${adv.adverPath}" alt="" width="1200" height="248">
                                </a>
                            </div>
                        </#if>
                    </#list>
                </#if>
            </div>
        </#if>
    </#list>
</#if>
<script>
    <#if cust??>
    $(".rightbar_body").find("div[name='showMy960']").show();
    </#if>
    $(function () {
        $(".new_ct_ul li:last").css("margin-right","0px");
        $(".flash_sale_ul li:last").css("margin-right","0px");
        $(".hiddenBottom:last").css("border-bottom","none").css("padding-bottom","0");
    })
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