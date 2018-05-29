<#assign basePath=request.contextPath>
<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
<script type="text/javascript" src="${basePath}/js/jquery.slides.min.js"></script>
<script src="${basePath}/js/jsOperation.js"></script>
<link rel="stylesheet" href="${basePath}/index_960/css/style.css"/>
<link rel="stylesheet" href="${basePath}/index_960/css/cebianlan.css"/>
<link rel="stylesheet" href="${basePath}/index_960/css/castabout.css"/>
<link rel="stylesheet" href="${basePath}/index_960/css/new_home_page.css"/>
<style>
    .choose_area2 {
        float: left;
        position: relative;
        display: inline;
        margin-top: 9px;
        width:234px;
    }
    . header_nv {
        padding-left:0!important;
    }

    .area_text2 {height:24px; line-height:24px;cursor:pointer; position:relative; z-index:10;    background: url(../images/area_fixed.png) no-repeat 0px 3px;  padding-left: 21px;font-size: 14px;color: #333333; }
    .area_text2 b {    display: inline-block;
        zoom: 1;
        width: 8px;
        height: 7px;
        background: /*url(../index_960/images/xia.png) no-repeat;*/none;
        background-size: 100%;
        margin-left: 5px;}
    .choose_area_hover2 .area_text2 {border-bottom-color:#fff;}
    .locate_cont2 {position:absolute; width:400px; border:1px solid #ddd; top:24px; left:0px; z-index:9; padding:10px 15px; background:#fff; display:none;}
    .choose_area_hover2 .locate_cont2 {display:block;}
    .locate_tabs2 {border-bottom:2px solid #edd28b; height:25px;}
    .locate_tabs2 li {float:left;}
    .locate_tabs2 li a {display:block; height:23px; line-height:23px; padding:0 10px 1px 10px;  border-bottom:none;}
    .locate_tabs2 a b {display:inline-block; zoom:1; *display:inline; width:7px; height:4px; background:url(../images/arrow_down.png) no-repeat; margin-left:5px;}
    .locate_tabs2 .cur2 a {height:24px; line-height:21px; border:2px solid #edd28b; border-bottom:none; background:#fff;}
    .locate_list2 {padding-top:5px; display:none;}
    .locate_list2 li {float:left; width:80px; line-height:20px; padding:2px 0 2px 15px;}
    .locate_list2 li a {float:left; padding:2px 5px 2px 5px;}
    .locate_list2 li a:hover {color:#fff!important; background: #df1738;}
</style>
<script>
    $(function(){
        /*新增首页顶部广告*/
        $(".advertising_btn").click(function () {
            $(".outermost").hide();
        })
        /*end*/
        jQuery.fn.isChildAndSelfOf = function(b){ return (this.closest(b).length > 0); };
        $(".choose_area2").click(function(){
            var cur = $(this);
            c_tm = setTimeout(function(){
                cur.addClass("choose_area_hover2");
            },200);
        });

        $(document).click(function(event){
            if(!$(event.target).isChildAndSelfOf(".choose_area2")) {
                $(".choose_area2").removeClass("choose_area_hover2");
            };
        });
        $(".close_area2").click(function(){
            $(".choose_area2").removeClass("choose_area_hover2");
        });
        $(".choose_area2").mouseleave(function(){
            $(".choose_area2").removeClass("choose_area_hover2");
        });
        $(".show_province2").click(function(){
            $(".province_list2").attr("style","display: block;");
            $(".city_list2").attr("style","");
            $(".distinct_list2").attr("style","");
            $(".show_province2").addClass("cur2");
            $(".show_city2").removeClass("cur2");
            $(".show_distinct2").removeClass("cur2");
        });
        $(".show_city2").click(function(){
            $(".province_list2").attr("style","");
            $(".city_list2").attr("style","display: block;");
            $(".distinct_list2").attr("style","");
            $(".show_city2").addClass("cur2");
            $(".show_province2").removeClass("cur2");
            $(".show_distinct2").removeClass("cur2");
        });
        $(".show_distinct2").click(function(){
            $(".province_list2").attr("style","");
            $(".city_list2").attr("style","");
            $(".distinct_list2").attr("style","display: block;");
            $(".show_distinct2").addClass("cur2");
            $(".show_province2").removeClass("cur2");
            $(".show_city2").removeClass("cur2");
        });
        $(".thisUrl2").val(window.location.href);
        $.ajax({
            url:"/getDistinctByIP.htm",
            type:"post",
            async:false,
            success:function(data){
                if (data != null && data != "" && data.ipProvince != null) {
                    console.info(data);
                    $(".province_text2").text(data.ipProvince);
                    $(".city_text2").text(data.ipCity);
                    $(".distinct_text2").text(data.ipDistinct);
                    $(".area_text2").html(data.ipCity + "<b></b>");
                    //填充表单
                    $(".ch_distinctId2").val(data.ipDistinctId);
                    $(".ch_province2").val(data.ipProvince);
                    $(".ch_city2").val(data.ipCity);
                    $(".ch_distinct2").val(data.ipDistinct);
                }
                loadInit2();
            }
        });
    });



    /*初始化已经选择的城市*/
    function loadInit2(){

        $.ajax({
            type: 'post',
            url:"/getAllProvince.htm",
            async:false,
            success: function(data) {
                var provinceHtml="";
                for(var i=0;i<data.length;i++){
                    provinceHtml+="<li><a class='check_province2'  onClick='loadCity2("+data[i].provinceId+",this);' href='javascript:;'>"+data[i].provinceName+"</a></li>";
                }
                $(".province_list2").html(provinceHtml);
            }
        });

        var provinces = $(".check_province2");
        for(var i = 0;i<provinces.length;i++){
            if($(provinces[i]).html()==$(".province_text2").html()){
                var click = $(provinces[i]).attr("onclick");
                var pid = click.substring(10,click.indexOf(","));
                var url = "/getAllCityByPid.htm?provinceId="+pid;
                $.ajax({
                    type: 'post',
                    url:url,
                    async:false,
                    success: function(data) {
                        var cityHtml="";
                        for(var i=0;i<data.length;i++){
                            cityHtml+="<li><a class='check_city2'  onClick='loadDistinct2("+data[i].cityId+",this);' href='javascript:;'>"+data[i].cityName+"</a></li>";
                        }
                        $(".city_list2").html(cityHtml);
                    }
                });
            }
        }
        var citys = $(".check_city2");
        for(var i = 0;i<citys.length;i++){
            if($(citys[i]).html()==$(".city_text2").html()){
                var click = $(citys[i]).attr("onclick");
                var cid = click.substring(14,click.indexOf(","));
                var url="/getAllDistrictByCid.htm?cityId="+cid;
                $.ajax({
                    type: 'post',
                    url:url,
                    async:false,
                    success: function(data) {
                        var distinctHtml="";
                        for(var i=0;i<data.length;i++){
                            distinctHtml+="<li><a class='check_distinct2'  onClick='checkDistinct2("+data[i].districtId+",this);' href='javascript:;'>"+data[i].districtName+"</a></li>";
                        }
                        $(".distinct_list2").html(distinctHtml);
                    }
                });
            }
        }
    }


    /*根据点击的省份加载城市*/
    function loadCity2(pid,pro){
        $(".ch_address2").val("");
        $(".ch_province2").val($(pro).text());
        $(".province_text2").text($(pro).text());
        $(".show_province2").removeClass("cur2");
        $(".show_city2").addClass("cur2");
        $(".city_text2").click();
        $(".province_list2").attr("style","");
        $(".city_list2").attr("style","display: block;");
        $.get("/getAllCityByPid.htm?provinceId="+pid,function(data){
            $(".ch_city2").val(data[0].cityName);
            $(".city_text2").text(data[0].cityName);
            var cityHtml="";
            for(var i=0;i<data.length;i++){
                cityHtml+="<li><a class='check_city2'  onClick='loadDistinct2("+data[i].cityId+",this);' href='javascript:;'>"+data[i].cityName+"</a></li>";
            }
            $(".city_list2").html(cityHtml);
        });
    }


    /*根据点击的城市加载区县*/
    function loadDistinct2(cid,city){
        $(".city_list2").attr("style","");
        $(".distinct_list2").attr("style","display: block;");
        $(".ch_city2").val($(city).text());
        $(".city_text2").text($(city).text());
        $(".show_city2").removeClass("cur2");
        $(".show_distinct2").addClass("cur2");
        $(".distinct_text2").click();
        $.get("/getAllDistrictByCid.htm?cityId="+cid,function(data){
            $(".ch_distinct2").val(data[0].districtName);
            $(".distinct_text2").text(data[0].districtName);
            var distinctHtml="";
            for(var i=0;i<data.length;i++){
                distinctHtml+="<li><a class='check_distinct2'  onClick='checkDistinct2("+data[i].districtId+",this);' href='javascript:;'>"+data[i].districtName+"</a></li>";
            }
            $(".distinct_list2").html(distinctHtml);
        });
    }
    /*点击区县的时候*/
    function checkDistinct2(dId,dis){
        $(".ch_distinct2").prop("value",$(dis).html());
        $(".dir_xz2").html($(dis).html());
        $(".ch_distinctId2").attr("value",dId);
        $(".ch_address2").val($(".ch_province2").val()+$(".ch_city2").val()+$(".ch_distinct2").val());
        $(".subDis2").submit();
    }
</script>
<script>
    $(function () {
        var url = window.location.href;
        if(url.indexOf("beforeRegUrl")<0){
            $("#regUrl").attr("href",$("#basePath").val() + "/register.html?beforeRegUrl="+ url);
        }else {
            url = url.substring(url.indexOf("beforeRegUrl=")+13);
            $("#regUrl").attr("href",$("#basePath").val() + "/register.html?beforeRegUrl="+ url);
        }
    });
</script>


<div class="section_headerTop">
    <input type="hidden" id="basePath" value="${basePath}">
    <div class="slot slot_headerTop01">
        <div class="choose_area2 fl pr" style="margin-left: 0;">
            <div class="area_text2"><i></i>${chCity!'获取定位'}<b></b></div>
            <div class="locate_cont2">
                <ul class="locate_tabs2 clearfix">
                    <li class="cur2 show_province2"><a href="javascript:;"><span class="province_text2">${chProvince!''}</span><b></b></a></li>
                    <li class="show_city2" ><a href="javascript:;" ><span class="city_text2">${chCity!''}</span><b></b></a></li>
                    <li class="show_distinct2"><a href="javascript:;" ><span class="distinct_text2">${chDistinct!''}</span><b></b></a></li>
                </ul><!--/locate_tabs-->
                <div class="locate_wp2">
                    <ul style="display: block;" class="locate_list2 clearfix province_list2 show">
                    </ul><!--/locate_list-->
                    <ul class="locate_list2 clearfix city_list2">
                    </ul><!--/locate_list-->
                    <ul class="locate_list2 clearfix distinct_list2">
                    </ul><!--/locate_list-->
                </div><!--/locate_wp-->
                <a class="close_area2" href="javascript:;"></a>
            </div><!--/locate_cont-->
        </div><!--/choose_area-->
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
        <div class="navItem">
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
            <#--shf-->

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
              <#--  <a href="${basePath}/list/6331-6329.html" style="padding-left: 10px;border-left: 1px solid #999999;border-right: 1px solid #999999;padding-right: 10px;" onclick="_czc.push(['_trackEvent', '首页', '导航', '礼品卡',  'gift_card']);" id="gift_card">礼品卡</a>-->
                <#--正式链接-->
                <a href="${basePath}/list/6324-6323.html" style="padding-left: 10px;border-left: 1px solid #999999;border-right: 1px solid #999999;padding-right: 10px;"  onclick="_czc.push(['_trackEvent', '首页', '导航', '礼品卡',  'gift_card']);" id="gift_card">礼品卡</a>
            </div>
            <div class="clear"></div>
        </div>
    </div>
</div>
<form action ="/updateIpProvince.htm" method="post" class="subDis2">
    <!--存放地址信息-->
    <input type="hidden" class="thisUrl2" name="url">
    <input type="hidden" value="<#if distinctId??>${distinctId}</#if>" name="distinctId" class="ch_distinctId2">
    <input type="hidden" value="<#if chProvince??>${chProvince}</#if>" name="chProvince" class="ch_province2">
    <input type="hidden" value="<#if chCity??>${chCity}</#if>" name="chCity" class="ch_city2">
    <input type="hidden" value="<#if chDistinct??>${chDistinct}</#if>" name="chDistinct" class="ch_distinct2">
    <input type="hidden" name="chAddress" class="ch_address2">
</form>
