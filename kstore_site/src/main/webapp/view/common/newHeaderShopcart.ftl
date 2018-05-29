<#assign basePath=request.contextPath>
<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
<script type="text/javascript" src="${basePath}/js/jquery.slides.min.js"></script>
<script src="${basePath}/js/jsOperation.js"></script>
<link rel="stylesheet" href="${basePath}/index_960/css/style.css"/>
<link rel="stylesheet" href="${basePath}/index_960/css/newheader.css"/>
<link rel="stylesheet" href="${basePath}/index_960/css/new_home_page.css"/>
<style>
    .searchID{
        margin-right: 45px;
    }
    .n_head{
        padding:0;
        height: 48px;
        background: none;
        height:auto;
    }
    .cartfd-mem .cartit-mem span:after{
        width: 0;
        border:none;
    }
    .cartfd-mem .cartit-mem span {
        width:auto;
    }
    .cartfd-mem .cartit-mem {
        background: none;
        border:none;
    }
    /*shf*/
    .cartfd-mem:hover{
        background:none!important;
        border-radius: 2px;
    }
    .cartfd-mem:hover .miniCart-mem:before {
        position: absolute;
        top:-10px;
        right:0;
        bottom:auto;
        left:auto;
        content: "";
        width: auto!important;
        height: 10px;
        border:none!important;
        background: #fff;
    }
    .cartfd-mem:hover .cartit-mem{
        background:none!important;
    }
    .cartfd-mem {
        top: 0;
        right: 9px;
    }
    .section-header{
        background: none!important;
        height:150px;
    }

</style>
<div class="section_headerTop" style="background-color:#f7f7f7;border:none">
    <input type="hidden" id="basePath" value="${basePath}">
    <div class="slot slot_headerTop01">
        <#--<div class="header_nv">
        <#if topmap.advs??>
            <#list topmap.advs as adv>
                <#if (adv.adverSort>=3) && (adv.adverSort<=6)>
                    <a style="margin-left: 20px" href="javascript:;" onclick="clickNav('${adv.adverHref!'#'}')" class="_color${adv.adverSort-2}">${adv.adverName!''}</a>
                    <span><img src="${basePath}/index_960/images/m${adv.adverSort-2}.png"></span>
                </#if>
            </#list>
        </#if>

        </div>-->
            <div class="topmenu">
                <p style="padding: 0px 10px 0px 10px">手机版</p>
                <div id="menucontent4" class="toplinkmenu">
                    <div class="outer_shell">
                        <div>
                            <img style="width: 82px;height: 80px;" src="/images/erweima1.png">
                            <span>960手机APP</span>
                        </div>
                        <img src="${basePath}/index_960/images/erweima_shugang.png" alt="" style="float: left;margin: 20px 23px 0px 23px;">
                        <div>
                            <img style="width: 82px;height: 80px;" src="/images/erweima2.png">
                            <span>960微信公众号</span>
                        </div>

                    </div>
                </div>
            </div>
        <div class="navItem">
            <div class="topmenu" id="3">
                <p>网站导航</p>
                <div id="menucontent3" class="toplinkmenu toplinkmenu2">
                    <div><#--<img src="${basePath}/index_960/images/sy.png" style="vertical-align: middle;"> --><a class="nav_a" href="http://www.ge960.com/" onclick="_czc.push(['_trackEvent', '导航', '网站导航', '首页',  'sites_index']);" id="sites_index">首页</a></div>
                    <div style="padding-left: 13px;">
                        <a href="${basePath}/subject/85" onclick="_czc.push(['_trackEvent', '导航', '网站导航', '茶馆',  'sites_teahouse']);" id="sites_teahouse">茶馆</a> &nbsp;&nbsp;&nbsp;
                        <a href="${basePath}/channel/247.html?navId=309" onclick="_czc.push(['_trackEvent', '导航', '网站导航', '960大聚惠',  'sites_polyhui']);" id="sites_polyhui">960大聚惠</a> &nbsp;&nbsp;&nbsp;
                        <a href="${basePath}/marketingrushlist-1.html" onclick="_czc.push(['_trackEvent', '导航', '网站导航', '狩猎时刻',  'sites_hunting']);" id="sites_hunting">狩猎时刻</a> &nbsp;&nbsp;&nbsp;
                        <a href="${basePath}/channel/247.html?navId=313" onclick="_czc.push(['_trackEvent', '导航', '网站导航', '展览馆',  'sites_exhibition']);" id="sites_exhibition">展览馆</a> &nbsp;&nbsp;&nbsp;
                    </div>
                    <div><#--<img src="${basePath}/index_960/images/sp.png" style="vertical-align: middle;"> --><a  class="nav_a" href="http://www.ge960.com/channel/237.html" onclick="_czc.push(['_trackEvent', '导航', '网站导航', '食品荟萃',  'sites_combo']);" id="sites_combo">食品荟萃</a></div>
                    <div style="padding-left: 13px;">
                        <a href="${basePath}/subject/85" onclick="_czc.push(['_trackEvent', '网站导航','食品荟萃', '茶馆',  'sites_exhibition1']);" id="sites_exhibition1" >茶馆</a> &nbsp;&nbsp;&nbsp;
                        <a href="${basePath}/channel/237.html?navId=273" onclick="_czc.push(['_trackEvent', '网站导航','食品荟萃', '老字号',  'old_firm']);" id="old_firm">老字号</a> &nbsp;&nbsp;&nbsp;
                        <a href="${basePath}/channel/237.html?navId=275" onclick="_czc.push(['_trackEvent', '网站导航','食品荟萃', '菌临天下',  'bacteria_world']);" id="bacteria_world">菌临天下</a> &nbsp;&nbsp;&nbsp;
                    </div>
                    <div><#--<img src="${basePath}/index_960/images/yd.png" style="vertical-align: middle;">--> <a class="nav_a" href="${basePath}/channel/239.html" onclick="_czc.push(['_trackEvent', '导航', '网站导航', '饮品总汇',  'drinks_company']);" id="drinks_company">饮品总汇</a></div>
                    <div style="padding-left: 13px;">
                        <a href="${basePath}/channel/239.html?navId=277" onclick="_czc.push(['_trackEvent', '网站导航', '饮品总汇', '生命之源',  'drinks_company']);" id="drinks_company">生命之源</a> &nbsp;&nbsp;&nbsp;
                        <a href="${basePath}/channel/239.html?navId=279" onclick="_czc.push(['_trackEvent', '网站导航', '饮品总汇', '红酒庄园',  'wine_estate']);" id="wine_estate">红酒庄园</a> &nbsp;&nbsp;&nbsp;
                        <a href="${basePath}/channel/239.html?navId=281" onclick="_czc.push(['_trackEvent', '网站导航', '饮品总汇', '国际名酒廊',  'a_lounge']);" id="a_lounge">国际名酒廊</a> &nbsp;&nbsp;&nbsp;
                    </div>
                    <div><#--<img src="${basePath}/index_960/images/jd.png" style="vertical-align: middle;">--> <a class="nav_a" href="${basePath}/channel/241.html" onclick="_czc.push(['_trackEvent', '导航', '网站导航', '购物中心',  'shop_center']);" id="shop_center">购物中心 </a></div>
                    <div style="padding-left: 13px;">
                    </div>
                    <div><#--<img src="${basePath}/index_960/images/dd.png" style="vertical-align: middle;">--> <a class="nav_a" href="${basePath}/channel/243.html" onclick="_czc.push(['_trackEvent', '导航', '网站导航', '原产地',  'source_area']);" id="source_area">原产地 </a></div>
                    <div style="padding-left: 13px;">
                    </div>
                </div>
            </div>

            <div class="topmenu" id="2">
                <p><a href="${basePath}/help.htm" onclick="_czc.push(['_trackEvent', '首页', '导航','帮助中心',  'bangzhu_center1']);" id="bangzhu_center1">帮助中心</a></p>
                <div id="menucontent2" class="toplinkmenu">
                    <div><a href="${basePath}/help/135"  onclick="_czc.push(['_trackEvent', '首页', '导航', '购物指南',  'shopping_guide1']);" id="shopping_guide1">购物指南</a></div>
                    <div><a href="${basePath}/help/137" onclick="_czc.push(['_trackEvent', '首页', '导航', '配送服务',  'distribution_service1']);" id="distribution_service1">配送服务</a></div>
                    <div><a href="${basePath}/help/145" onclick="_czc.push(['_trackEvent', '首页', '导航', '支付方式',  'mode_of_payment1']);" id="mode_of_payment1">支付方式</a></div>
                    <div><a href="${basePath}/help/157" onclick="_czc.push(['_trackEvent', '首页', '导航', '售后服务',  'after_sales_service1']);" id="after_sales_service1">售后服务</a></div>
                    <div><a href="${basePath}/help/169" onclick="_czc.push(['_trackEvent', '首页', '导航', '客户服务',  'customer_service1']);" id="customer_service1">客户服务</a></div>
                <#--友情链接用不到-->
                <#--<div><a href="${basePath}/toFriendLink.html" target="_blank">友情链接</a></div>-->
                </div>
            </div>
            <div class="topmenu last_topmenu" id="1">
                <p><a href="${basePath}/customer/index.html" class="login" onclick="_czc.push(['_trackEvent', '首页', '导航', '我的960',  'main_jll']);" id="main_jll">我的960</a></p>
                <div id="menucontent1" class="toplinkmenu">
                    <div><a href="${basePath}/customer/myorder.html" onclick="_czc.push(['_trackEvent',  '导航', '我的960','我的订单',  'wode_order']);" id="wode_order">我的订单</a></div>
                    <div><a href="${basePath}/customer/myintegral.html" onclick="_czc.push(['_trackEvent',  '导航', '我的960','我的积分',  'wode_order']);" id="wode_order">我的积分</a></div>
                    <div><a href="${basePath}/customer/myfollw.html" onclick="_czc.push(['_trackEvent',  '导航', '我的960','我的收藏',  'wode_favorite']);" id="wode_favorite">我的收藏</a></div>
                    <div><a href="${basePath}/customer/insideletter.html" onclick="_czc.push(['_trackEvent',  '导航', '我的960','我的消息',  'wode_message']);" id="wode_message">我的消息</a></div>
                </div>
            </div>
            <#--<div class="topmenu first_topmenu" id="4">-->
                <#--<p><a href="#" class="login">960微商城</a></p>-->
                <#--<div id="menucontent4" class="toplinkmenu" style="display: none;">-->
                    <#--<img style="width:140px;" src="http://www.ge960.com/pic/960ewm.png" alt="960微商城">-->
                <#--</div>-->
            <#--</div>-->
            <div class="register">
                <p style="display: inline-block;">HI~</p>
            <#if cust??>
                <a href="${basePath}/customer/index.html"><font color="red">${cust.customerNickname!''}</font></a>
                <a href=""><font color="red"></font></a> <a class="reg_newa" href="${basePath}/logout.html">退出</a>
            <#else>
                <a href="${basePath}/login.html" class="login_newa"  onclick="_czc.push(['_trackEvent', '首页', '导航', '登录',  'Xlogin']);" id="Xlogin"><span>[&nbsp;</span>登录<span>&nbsp;]</span></a>
                <a id="regUrl" href="${basePath}/register.html"  class="reg_newa"  onclick="_czc.push(['_trackEvent', '首页', '导航', '注册',  'regUrl']);" ><span>[&nbsp;</span >注册<span>&nbsp;]</span></a>
            </#if>
            <#--测试链接-->
                <a href="${basePath}/list/6331-6329.html" style="padding-left: 10px;border-left: 1px solid #999999;border-right: 1px solid #999999;padding-right: 10px;" onclick="_czc.push(['_trackEvent', '首页', '导航', '礼品卡',  'gift_card']);" id="gift_card">礼品卡</a>
            <#--正式链接-->
            <#--<a href="${basePath}/list/6324-6323.html" style="margin-left: 13px;">礼品卡</a>-->
            </div>
            <div class="clear"></div>
        </div>
    </div>
</div>



<#--shfnew-->
<div id="sectionHeader" class="section-header">
    <div class="tm-content">
        <h1 id="logo">
            <a href="${topmap.systembase.bsetAddress}"><img alt="" src="${topmap.systembase.bsetLogo}" style="width: 181px;height: 72px;    margin-top: 25px;"></a>
        <#--<a href="http://127.0.0.1:7070/site"><img alt="" src="http://tboss.ge960.com:80/upload/20170317/1489739915621.jpg" style="width: 181px;height: 72px;"></a>-->
        </h1>
        <#--<div class="logoBanner">
            <!-- 广告11111位置 &ndash;&gt;
            <a href="http://www.ge960.com/item/7221.html" target="_blank">
                <img alt="" src="http://boss.ge960.com:80/upload/20170314/1489488081314.jpg" style="max-width:480px;height:94px">
            </a>
            <a href="http://www.ge960.com/item/7139.html" target="_blank">
                <img alt="" src="http://boss.ge960.com:80/upload/20170315/1489550314355.jpg" style="max-width:480px;height:94px">
            </a>
        </div>-->
        <div class="header_nv">
            <div style="float: left;height: 65px;padding-top: 59px;">
            <#if topmap.advs??>
                <#list topmap.advs as adv>
                    <#if (adv.adverSort>=3) && (adv.adverSort<=6)>
                        <a class="header_nv_a " onclick="_czc.push(['_trackEvent', '首页', '头部', '${adv.adverName!''}',  'dianji_ok']);clickNav('${adv.adverHref!'#'}')" id="dianji_ok"  href="javascript:;"style="padding-right: 0px;">
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
            <div class="new_shoppingcart" style="background: #ffffff; padding-right:0px;">
               <#-- <div class="new_sp1">
                    <a href="#">
                        <img src="${basePath}/index_960/images/new_gouwuche_header.png" alt="">
                    </a>
                </div>

                <div class="new_sp2">
                    <p>购物车</p>
                    <span class="shopcaritemnum" style="background: none;margin-left: 0px!important;">0</span>
                </div>-->
            </div>
        </div>

    </div>




</div>




<script type="text/javascript">

    function clickNav(url,sort){
        if(url.indexOf("http://")!=-1){
            window.open(url);
        }else{
            window.open("/"+url);
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
