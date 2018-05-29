<!DOCTYPE html>
<html lang="zh-cn">

<head>
<#assign basePath=request.contextPath>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="keywords" content="${seo.meteKey}">
    <meta name="description" content="${seo.meteDes}">
<#if (sys.bsetName)??>
    <title>
        <#if map.nowcate??>${map.nowcate.catName}
        <#else>所有商品</#if>列表页--${sys.bsetName}</title>
<#else>
    <title>
        <#if map.nowcate??>${map.nowcate.catName}
        <#else>所有商品</#if>列表页--${seo.mete}</title>
</#if>
    <link href="${basePath}/css/v3/mui.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${basePath}/css/v2/framework7.ios.min.css">
    <link rel="stylesheet" type="text/css" href="${basePath}/css/v2/framework7.ios.colors.min.css">
    <link rel="stylesheet" href="${basePath}/css/v1/css/frozen.css" />
    <link rel="stylesheet" href="${basePath}/css/style.min.css" />
    <link rel="stylesheet" href="${basePath}/css/list.css" />

<#--唤醒app-->
    <link rel="stylesheet" href="${basePath}/css/v1/css/arouse-app.css">
<#--样式改版新增style-->
    <link rel="stylesheet" href="${basePath}/css/new_list_style.css" />
<#--针对搜索的功能调整-->
    <link rel="stylesheet" type="text/css" href="${basePath}/css/v1/css/popup.css">
    <link rel="stylesheet" type="text/css" href="${basePath}/css/v2/index.css">
    <style>
        /*修正唤醒app的样式*/
        .pages{padding-top:45px;padding-bottom:0}
            .content{padding-top:0;background: #ffffff;}
        /*修改头部下拉时被遮盖*/
        .pages{position:absolute}
        .bar-top{position:absolute!important;}
        .arouse-app{position:absolute}
        .search{top:0}
        .search .search_box{position:absolute;top:0;width:100%}
        /*.ion-ios-arrow-left{ font-size: 28px;}*/
        #cartNum{
            width: 19px;
            height: 19px;
            position: absolute;
            right: -1px;
            top: -3px;
            background:url(../images/v1/img/tuoyuangouwuche.png) no-repeat;
            background-position: -3px -15px;
            color: #ffffff;
            border-radius: 50%;
            text-align: center;
            line-height: 19px;
            font-size: 10px;
        }
        .button{
            border:none;
        }
        .popup-overlay{
            background: none;
        }
        .popup-overlay {
            z-index: 0;
            visibility: hidden!important;
        }
    </style>
    <#--新增样式-->
    <style>
        .panel{
            width: 91%;
            z-index: 7001!important;
            padding: 0;
            margin: 0;
        }
        .marginbottom{
            border-bottom: none!important;

        }
        .content, .content-class{
            background: #ffffff;
        }
        .content .prolist{
            border-bottom:1px solid #ececec;
        }
    </style>
</head>

<body class="framework7-root box">

<script src="${basePath}/js/jquery.js"></script>
<script src="${basePath}/js/fly.js"></script>

<input type="hidden" id="show_status" value="${showStatus!" "}">
<input type="hidden" id="basePath" value="${basePath}">
<input type="hidden" class="ch_distinctId" value="${disID}"  />
<!--<script>
    $(function() {
        //列表条形块形样式切换
        $('.style-trans').click(function() {
            if ($("#showStatus").val() == 0) {
                $("#showStatus").val(1);
            } else {
                $("#showStatus").val(0);
            }
            if ($('.list-line').length > 0) {
                $('.list-line').addClass('list-box').removeClass('list-line');
                $(this).find('i.list-icon').addClass('list-2').removeClass('list-1');
            } else {
                $('.list-box').addClass('list-line').removeClass('list-box');
                $(this).find('i.list-icon').addClass('list-1').removeClass('list-2');
            }
        });
        if ($("#show_status").val() == 1) {
            $('.style-trans').click();
        }
    });
</script>-->
<div class="views">
    <div class="view view-main">
        <div class="aatips"><img src="/images/v1/img/feed.png" /></div>
    <#--头部搜索栏-->
        <div class="bar-top" style="position:absolute">
            <div class="search complete_search" style="position:relative">
            <#--唤醒app-->
                <div class="arouse-app">
                    <b class="aaclose external"></b>
                    <i><img src="/images/v1/img/logo@2x.png"/></i>
                    <div class="aa-intro">
                        <p>打开960客户端</p>
                        <p>上新优惠一网打尽</p>
                    </div>
                    <div class="aa-down external">打开App</div>
                </div>

                <div class="search_box">
                    <div class="s_left">
                        <a href="javascript:;" onClick="javascript:history.back(-1);" class="backto_page">
                            <i class="ion-ios-arrow-left"></i>
                        </a>
                    </div>
                    <div class="search_form " >
                        <a href="#" class="open-about ">
                        <i class="ion-ios-search-strong submitfrom"></i>
                        <form action="${basePath}/searchProduct.htm" method="get" id="">
                            <input id="searchInput" id="searchInput" value="<#if keyWords??>${keyWords}</#if>" placeholder="搜索960商品 按类别 按属性" name="keyWords" type="text" placeholder="大双曲屏 三星S6 edge+">
                            <input type="hidden" value="${storeId!" "}" name="storeId" id="storeId">
                        </form>
                        </a>
                    </div>
                    <div class="s_right">
                    <a href="javascript:;" onclick="javascript:window.location.href='${basePath}/cates.html'" class="classify" >分类</a>
                    </div>
                </div>
            </div>

        </div>


        <div class="pages navbar-through toolbar-through new_style">
        <#--筛选弹出遮罩面板-->
            <div class="panel-overlay"></div>
            <div class="panel panel-right panel-cover">
                <div class="content-block scroll2">
                    <div style="margin-bottom: 100px;">
                    <#--<div class="content-block-title">
                        <span>筛选</span>
                        <img class="img-close panel-overlay" src="../images/v1/img/close.png" " alt=" "/>
                    </div>-->
                        <div class="content-block-select " style="border-bottom:none; ">
                            <span>价格区间（元）</span>
                            <div class="qj ">
                                <input type="text " value placeholder="最低价格" class="priceMin" /> <i>至</i>  <input type="text " value placeholder="最高价格" class="priceMax" />
                            </div>
                        <#--<div class="ui-btn-wrap priceclass">
                            <button class="ui-btn-s" val="0-20">0-20</button>
                            <button class="ui-btn-s " val="20-60">20-60</button>
                            <button class="ui-btn-s " val="60-100">60-100</button>
                            <button class="ui-btn-s " val="100-200">100-200</button>
                            <button class="ui-btn-s " val="200-10000">200以上</button>
                        </div>-->
                        </div>
                        <div class="content-block-select ">
                            <span class="btn_pp">品牌<i class="img_pp btn1"></i></span>

                            <div class="ui-btn-wrap brandclass">
                            <#if brands??>
                                <#if brands?size!=0>
                                    <#list brands as brand>
                                        <button class="ui-btn-s " >${brand.brandName}</button>
                                    </#list>
                                </#if>

                            </#if>
                            </div>
                        </div>
                    <div class="content-block-menu ">
                        <div class="content-block-select ">
                            <span class="btn_pq">分类<i class="img_pq btn2"></i></span>
                            <div class="ui-btn-wrap cateclass">
                            <#if goodsCateVos??>
                                <#list goodsCateVos as cate>
                                    <button class="ui-btn-s " val="${cate.catId}" >${cate.catName}</button>
                                </#list>
                            </#if>
                            </div>
                        </div>

                    <#--<div class="content-block-select ">
                        <span>产地</span>
                        <div class="ui-btn-wrap ">
                            <button class="ui-btn-s ">拒绝</button>
                            <button class="ui-btn-s ">拒绝</button>
                            <button class="ui-btn-s ">拒绝</button>
                            <button class="ui-btn-s ">拒绝</button>
                            <button class="ui-btn-s ">拒绝</button>
                            <button class="ui-btn-s ">拒绝</button>
                            <button class="ui-btn-s ">拒绝</button>
                            <button class="ui-btn-s ">拒绝</button>
                            <button class="ui-btn-s ">拒绝</button>
                            <button class="ui-btn-s ">拒绝</button>
                        </div>
                    </div>-->


                    </div>
                    </div>
                </div>
                <div class="ui-btn-group " style="position: fixed;bottom: 0;">

                    <button class="ui-btn-lg " id="reset">重置</button>
                    <button id="agree " class="ui-btn-lg ui-btn-primary external" >完成</button>
                </div>
            </div>







            <div class="bar-top" style="position:relative">
                <a val="" href="javascript:void(0);" class="bar-item filter-item change_sort <#if sort=='' <#--|| sort='3D'||sort='33D'-->>active</#if> filter_default">综合<#--<#if sort!='' && sort='33D'><i class="sharp-up"></i></#if><#if sort!='' && sort='3D'><i class="sharp-down"></i></#if>--></a>
                <a val="2D" href="javascript:void(0);" class="bar-item filter-item change_sort <#if sort!='' && sort='2D'<#-- || sort='22D'-->>active</#if> filter-sales">销量<#--<#if sort!='' && sort='22D'><i class="sharp-up"></i></#if><#if sort!='' && sort='2D'><i class="sharp-down"></i></#if>--></a>
                <a val="1D" href="javascript:void(0);"<#-- style="padding-left: 15px;"--> class="bar-item filter-item change_sort <#if sort!='' && sort='11D' || sort='1D'>active</#if> filter-price">价格
                <div style="    margin-left: 27px;
    margin-top: -30px;">
                <#if sort='1D'>
                    <i class="sharp-down2"></i>
                <#else>
                    <i class="sharp-down"></i>
                </#if>
                <#if sort='11D'>
                    <i class="sharp-up2" ></i>
                <#else>
                    <i class="sharp-up" ></i>
                </#if>
                </div>
                </a>
                <a href="#" class="bar-item style-trans filtercolor button open-panel" data-panel="right">筛选<#--<i class="list-icon list-1 "></i>--></a>
            </div>

            <input type="hidden" value="<#if keyWords??>${keyWords}</#if>" id="keywords_v">



            <div class="mui-scroll-wrapper" id="muiscroll">
                <div class="mui-scroll" >
                    <!--这里放置真实显示的DOM内容-->


               <div class="content scroll">
                <div class="content-prolist" >
                    <div class="prolist list-line" <#if  map.pb.data?? || map.pb.data?size==0> style="border-bottom: none;" </#if>>
                    <#if map.pb.data??>
                        <#if map.pb.data?size!=0>

                            <#list map.pb.data as product>

                                <#assign finalPrice=product.finalPrice>
                                <#assign productPrice=product.goodsInfoPreferPrice>
                                <#assign stock=product.goodsInfoStock>
                                <#--<#if product.wareList??&&product.wareList?size &gt;0>
                                    <#list product.wareList as ware>
                                        <#if ware.wareId==wareId>
                                            &lt;#&ndash;<#assign productPrice=ware.warePrice>&ndash;&gt;
                                            <#assign stock=ware.wareStock>
                                            <#break>
                                        </#if>
                                    </#list>
                                </#if>-->
                                <div class="list-item">
                                    <a class = "external" href="${basePath}/item/${product.goodsInfoId}.html">
                                        <div class="propic">

                                        <#--<img src="<#if  product.imgList?? && product.imgList?size &gt; 0 >${product.imgList[0].imageBigName!''}</#if>" alt="${product.productName!''}" />-->
                                            <img src="${product.goodsInfoImgId}" alt="${product.productName!''}" />
                                        </div>
                                        <div class="prodesc">
                                            <h3 class="title">${product.goodsInfoName!''}</h3>

                                            <#if (product.typeId > 0)>
                                                <#if (product.typeId == 1)>
                                                <#--直降-->
                                                <p class="price">&yen;&nbsp;<span>
                                                ${((finalPrice?number)?string('0.00'))?split(".")[0]}.<span style="font-size: 12px;">${((finalPrice?number)?string('0.00'))?split(".")[1]}</span></span>
                                                <#elseif (product.typeId == 10)>
                                                <#--团购-->
                                                <p class="price">&yen;&nbsp;<span>
                                                ${((finalPrice?number)?string('0.00'))?split(".")[0]}.<span style="font-size: 12px;">${((finalPrice?number)?string('0.00'))?split(".")[1]}</span></span>
                                                <#elseif (product.typeId == 11)>
                                                <#--抢购-->
                                                <p class="price">&yen;&nbsp;<span>
                                                ${((finalPrice?number)?string('0.00'))?split(".")[0]}.<span style="font-size: 12px;">${((finalPrice?number)?string('0.00'))?split(".")[1]}</span></span>
                                                <#elseif (product.typeId == 15)>
                                                <#--折扣-->
                                                <p class="price">&yen;&nbsp;<span>
                                                    ${((finalPrice?number)?string('0.00'))?split(".")[0]}.<span style="font-size: 12px;">${((finalPrice?number)?string('0.00'))?split(".")[1]}</span></span>
                                                </#if>
                                                <em class="price1">&yen;&nbsp;<span>${(productPrice?string('0.00'))?split(".")[0]}.<span style="font-size: 12px;">${(productPrice?string('0.00'))?split(".")[1]}</span></span></em>
                                            <#else>
                                            <p class="price">&yen;&nbsp;<span>${(productPrice?string('0.00'))?split(".")[0]}.<span style="font-size: 12px;">${(productPrice?string('0.00'))?split(".")[1]}</span></span>
                                            </#if>

                                            </p>

                                            <p class="comm">
                                                <#assign goodCount=0>
                                                <#assign count=0>
                                                <#if product.commentUtilBean??>
                                                    <#assign goodCount="${(goodCount?number+product.commentUtilBean.goodCount)?number}">
                                                    <#assign count="${(count?number+product.commentUtilBean.count)?number}">
                                                    <#if product.commentUtilBean.goodCount?number gt 0>
                                                        <#assign goodCount="${goodCount?number/count?number}">
                                                        <#assign goodCount="${goodCount?number*100}">

                                                    </#if>
                                                </#if>
                                                <#--<span class="item-percent">好评<span><#if product.commentUtilBean??>${goodCount!""}<#else>0</#if></span>%</span>-->
                                                <#--<span class="item-pnum"><span>评价&nbsp;&nbsp;<#if product.commentUtilBean??>${product.commentUtilBean.count!""}<#else>0</#if></span>+</span>-->
                                            <#--修改评价显示shf-->
                                                <span class="item-pnum"><span>
                                                    <#if product.commentUtilBean.count?number gt 1000>评价&nbsp;&nbsp;1000+
                                                    <#elseif product.commentUtilBean.count?number gt 0>评价&nbsp;&nbsp;${product.commentUtilBean.count!""}
                                                    <#else>暂无评价
                                                    </#if>


                                            </p>
                                            <#--促销活动-->
                                            <div class="promotion">
                                                 <#if product.codeUtils??>
                                                 <#list product.codeUtils as code>
                                                 <#--直降-->
                                                 <#if code.codexId==1>
                                                     <img style="width: 28px;" src="${basePath}/images/v1/img/zhijiang.png">
                                                 </#if>
                                                 <#--满减-->
                                                 <#if code.codexId==5 || code.codexId==8>
                                                     <img style="width: 28px;" src="${basePath}/images/v1/img/manjian.png">
                                                 </#if>
                                                 <#--满赠-->
                                                 <#if code.codexId==6>
                                                     <img style="width: 28px;" src="${basePath}/images/v1/img/manzeng.png">
                                                 </#if>
                                                 <#--团购-->
                                                 <#if code.codexId==10>
                                                     <img style="width: 28px;" src="${basePath}/images/v1/img/tuangou.png">
                                                 </#if>
                                                 <#--抢购-->
                                                 <#if code.codexId==11>
                                                     <img style="width: 28px;" src="${basePath}/images/v1/img/qianggou.png">
                                                 </#if>
                                                 <#--折扣-->
                                                 <#if code.codexId==15>
                                                     <img style="width: 28px;" src="${basePath}/images/v1/img/zhekou.png">
                                                 </#if>
                                                 </#list>
                                                 </#if>
                                            </div>

                                         <#--   <div class="add_shoppingcart">
                                                <img class="button orange addcar" style="width:25px; height: 25px;" src="${basePath}/images/v1/img/jiarugouwuche.png" alt="">
                                            </div>-->
                                        </div>

                                    </a>
                                    <div style="  position: absolute;bottom:2px;right: 0px;width:50px; height: 50px;">
                                    <a href="javascript:;" class=" addcar" onclick="addShoppingCart(this,'${product.goodsInfoId}')"></a>
                                    </div>
                                </div>
                            </#list>
                        <#--新增-->
                            <#--<div class="shopping_cart status">-->
                                <#--<a href="javascript:void(0);"  onclick="javascript:window.location.href='${basePath}/myshoppingmcart.html'" class="shoppingcart_item cart"><span id="cartNum"></span></a>-->
                            <#--</div>-->
                        <#else>
                            <div class="no_tips">
                                <p>木有搜索到商品哦</p>
                            </div>
                        </#if>
                    </#if>
                       <#-- <div class="slideBar">
                            <div class="slideBar-item sTop"><i></i></div>
                        </div>-->

                    </div>
                    <#if map.pb.data?size!=0>
                    <div id="showmore" class="list-loading" style="height:45px;padding:10px;"></div>
                    </#if>
                </div>
                </div>


                </div>
            </div>
        <#--新增-->
            <#if map.pb.data?size!=0>
            <div class="shopping_cart status">
                <a href="javascript:void(0);"  onclick="javascript:window.location.href='${basePath}/myshoppingmcart.html'" class="shoppingcart_item cart"><span id="cartNum"></span></a>
            </div>
            </#if>
            <div class="hide">
                <form action="${basePath}/list/${cate}" id="searchForm" method="post">
                    <div class="filterList">
                        <ul class="clearfix">
                        <#if storeId??&&storeId!=0>
                            <input type="hidden" name="storeId" value="${storeId}">
                        </#if>
                            <input type="hidden" name="pageNo" class="pageNo" value="${map.pb.pageNo}">
                            <input type="hidden" name="sort" class="list_sort" value="${sort!''}">
                            <input type="hidden" name="showStock" class="show_stock" value="${showStock!''}">
                            <input type="hidden" name="showStatus" id="showStatus" value="0">
                            <input type="hidden" name="cate" value="<#if cate??>${cate}</#if>">
                            <input type="hidden" name="brand" value="<#if brand??>${brand}</#if>">
                            <input type="hidden" name="priceMin" value="<#if priceMin??>${priceMin}</#if>">
                            <input type="hidden" name="priceMax" value="<#if priceMax??>${priceMax}</#if>">
                        </ul>
                    </div>
                    <!--/filterList-->
                </form>
            </div>


            <input class="storeId" type="hidden" value="${storeId!" "}">
            <input type="hidden" value="${wareId!" "}" id="wareId_v">

        <#--<#include "../common/smart_menu.ftl" />-->
            <input type="hidden" id="cateId" value="<#if map.nowcate??>${map.nowcate.catId}</#if>">
            <input type="hidden" id="basePath" value="${basePath}">
            <input type="hidden" value="0" id="status">

            <img src="../images/v1/img/tuoyuangouwuche.png" style="display:none;">
        </div>
    </div>
<#--引入搜索页面-->
<#include '../main/popup.ftl'>
    <script type="text/javascript">
        $('.prodesc:last').addClass("marginbottom");

        $(".ui-btn-s").on("touchstart",function (e) {
            $(this).css("color","#666666");
            e.stopPropagation();
        })
        $(".ui-btn-s").on("touchmove",function (e) {
            $(this).css("color","#666666");
            e.stopPropagation();
        })
        $(".ui-btn-s").on("touchend",function (e) {
            $(this).css("color","#666666");
            e.stopPropagation();
        })
        /*重置*/
        $("#reset").on("touchstart",function (e) {
            $(this).css("color","#333333");
            e.stopPropagation();
        })
        $("#reset").on("touchmove",function (e) {
            $(this).css("color","#333333");
            e.stopPropagation();
        })
        $("#reset").on("touchend",function (e) {
            $(this).css("color","#333333");
            e.stopPropagation();
        })
    </script>
    <script>
        var flag = true;

        $(".btn1").on("touchstart",function(e) {
            if( flag ){
                $(".brandclass").slideUp();
                $(".img_pp").addClass("img_pp1").removeClass("img_pp");

                flag = false;
            } else {
                $(".brandclass").slideDown();
                $(".img_pp1").removeClass("img_pp1").addClass("img_pp");
                flag = true;
            }
            e.stopPropagation();
        });
    </script>
    <script>
        var flag = true;

        $(".btn2").on("touchstart",function(e) {
            if( flag ){
                $(".cateclass").slideUp();
                $(".img_pq").addClass("img_pq1").removeClass("img_pq");

                flag = false;
            } else {
                $(".cateclass").slideDown();
                $(".img_pq1").removeClass("img_pq1").addClass("img_pq");
                flag = true;
            }
            e.stopPropagation();
        });
    </script>
    <script>

        var tip = myAlertStr();
        function addShoppingCart(ele,goodsInfoId) {
              addCart(goodsInfoId,tip,ele,function(obj,event){
                  //function addFly(obj,event) {
                      var addcar = $(obj);
                      /*    var img = (addcar.prev().find("img")[0]).src;*/
                      var offset = $('.cart').offset(), flyer = /*$('<img style="z-index: 6000;" width="24" class="u-flyer" src="'+img+'">')*/$('<img  style="width: 19px;" class="u-flyer" src="../images/v1/img/tuoyuangouwuche.png"/>');
                  $(".shopping_cart").addClass("status");
                      flyer.fly({
                          start: {
                              left: event.pageX-40,
                              top: event.pageY-20
                          },
                          end: {
                              left: offset.left+36,
                              top: offset.top+20,
                              width: 19,
                              height: 19,
                          },
                          onEnd: function() {
                              $(".u-flyer").hide();
                              setTimeout(function () {
                                  $("#cartNum").show();
                              },700)
                          }
                      });
                 // }
              });


        }
    </script>

    <script>
        $(function() {

            //回到顶部
            $('.sTop>i').click(function() {
                $('.content').animate({
                    scrollTop: 0
                }, 800);
            });
            // 筛选的点击效果
            $(".content-block-select button").on("click",function(){
                $(this).parents(".content-block-select").find("button").removeClass("active");
                $(this).addClass("active")
            });
            $(".ui-btn-lg").on("click",function(){

            })
            /*价格区间focus事件*/
            $(".priceMin").focus(function () {
                $(this).attr("placeholder","");
                $(this).val("");
            })
            $(".priceMax").focus(function () {
                $(this).attr("placeholder","");
                $(this).val("");
            })
            //筛选重置
            $("#reset").on("click",function(){
                $(".content-block-select button").each(function(index,item){
                    $(item).removeClass("active");
                })
                $(".content-block-select .priceMin").val("");
                $(".content-block-select .priceMin").attr("placeholder","最低价格");
                $(".content-block-select .priceMax").val("");
                $(".content-block-select .priceMax").attr("placeholder","最高价格");
            });
            //筛选完成
            $(".ui-btn-primary").on("click",function(){
                var cate=$(".content-block-select .cateclass  .active").attr("val");

                var brand=$(".content-block-select .brandclass  .active").html();
                var priceMinInput=$(".priceMin").val();
                var priceMaxInput=$(".priceMax").val();
                var price=$(".content-block-select .priceclass .active").attr("val");

                if(!!cate){
                    $("input[name=cate]").val(cate);
                }else{
                    $("input[name=cate]").val("");
                }
                if(!!brand){
                    $("input[name=brand]").val(brand);
                }else{
                    $("input[name=brand]").val("");
                }
                if(!!priceMinInput&&!!priceMaxInput&&priceMinInput<priceMaxInput){
                    $("input[name=priceMin]").val(priceMinInput);
                    $("input[name=priceMax]").val(priceMaxInput);
                }else if(!!price){
                    var arr=price.split("-");
                    $("input[name=priceMin]").val(arr[0]);
                    $("input[name=priceMax]").val(arr[1]);
                }else{
                    $("input[name=priceMin]").val("");
                    $("input[name=priceMax]").val("");
                }
                //触发关闭按钮
                $('.panel-overlay').trigger("click");
                $(".pageNo").val("1");
                $('#searchForm').submit();

            });
            //选中筛选的选中项
            var is='no';
            $('.content-block-select .brandclass button').each(function(index,item){
                if($(item).html()==$('input[name=brand]').val()){
                    $(item).addClass('active');
                }else if($(item).attr('val')==($('input[name=priceMin]').val()+"-"+$('input[name=priceMax]').val())){
                    $(item).addClass('active');
                    is='yes';
                }
            })
            $('.content-block-select .cateclass button').each(function(index,item){
                if($(item).attr('val')==$('input[name=cate]').val()){
                    $(item).addClass('active');
                }
            })
            if('no'==is&&$('input[name=priceMin]').val()>0&&$('input[name=priceMin]').val()<$('input[name=priceMax]').val()){
                $(".priceMin").val($('input[name=priceMin]').val());
                $(".priceMax").val($('input[name=priceMax]').val());
            }

            /* 显示隐藏搜索 */
            $('.search-pro').click(function() {
                $('.pro-search-box').show();
            });
            /*$('.search_btn').click(function() {
                checkCookie($("#searchInput").val());
                $("#storeId").val($(".storeId").val());
                $("#searchProductForm").submit();
            });*/
            $('.search-cancel').click(function() {
                $('.pro-search-box').hide();
            });
            /* 商品列表排序 */
            //默认排序
            /*$('.filter_default').click(function() {
               $('.filter-item').removeClass('active').find('i').remove();
                $(this).addClass('active');
            });
            //销量排序
            $('.filter-sales').click(function() {
             $('.filter-item').removeClass('active').find('i').remove();
                $(this).addClass('active');
              $(this).append('<i class="sharp-down"></i>');
            });
            //价格排序
            $('.filter-price').click(function() {
                if ($(this).find('i').length == 0) {
                    $('.filter-item').removeClass('active').find('i').remove();
                    $(this).addClass('active');
                    $(this).append('<i class="sharp-up"></i>');
                } else if ($(this).find('i').attr('class') == 'sharp-up') {
                    $(this).find('i').attr('class', 'sharp-down');
                } else {
                    $(this).find('i').attr('class', 'sharp-up');
                }
            });*/
        });
        window.onload = function() //用window的onload事件，窗体加载完毕的时候
        {
            $(".pageNo").val(1);
            $("#status").val(0);
            //do something
            if( $("input[name=brand]").val()|| $("input[name=cate]").val() || $("input[name=priceMax]").val() || $("input[name=priceMin]").val()){
                //$('.filter-item').removeClass('active');
                $('.filtercolor.open-panel').addClass('active');

            }
        }
        function scrollbottom(){
//        $('.content').scroll(function() {
            if ($("#status").val() == 1) {
                return null;
            }
            if ($(this).scrollTop() >= ($('.content-prolist').height() - $('.content').height())) {

                var pageNo = $(".pageNo").val();
                pageNo++;
                $(".pageNo").val(pageNo);
                var strRequest = "";
                if ($("#catId").val != null && $("#catId").val != "") {
                    strRequest = "&cid=" + $("#cateId").val();
                }
                if ($("#storeId").val != null && $("#storeId").val != "") {
                    strRequest = "&storeId=" + $("#storeId").val();
                }
                var sb="";
                if($("input[name=priceMin]").val() !=null && $("input[name=priceMin]").val() !=""){
                    sb+=+"&priceMin="+$("input[name=priceMin]").val();
                }
                if($("input[name=priceMax]").val() !=null && $("input[name=priceMax]").val() !=""){
                    sb+="&priceMax="+$("input[name=priceMax]").val();
                }
                if($("input[name=brand]").val() !=null && $("input[name=brand]").val() !=""){
                    sb+="&brand="+$("input[name=brand]").val();
                }
                if($("input[name=cate]").val() !=null && $("input[name=cate]").val() !=""){
                    sb+="&cate="+$("input[name=cate]").val();
                }

                $.ajax({
                    type: "POST",
                    url: "${basePath}/searchproductnew.htm",
                    beforeSend: showLoadingImg,
                    error: showFailure,
                    data: "pageNo=" + $(".pageNo").val() + "&sort=" + $(".list_sort").val() + strRequest + "&keyWords=" + $("#keywords_v").val()+sb,
                    success: function(msg) {
                        if (msg.pb.data.length == 0) {
                            $("#status").val(1);
                            $('#showmore').html('已无更多结果');
                        }
                        var str = "";
                        var wareId = $("#wareId_v").val();
                        for (var i = 0; i < msg.pb.data.length; i++) {
                            var mStr = "";
                            var codes = msg.pb.data[i].codeUtils;
                            mStr += '<div class="promotion">';
                            if(codes != "") {
                                for (var j = 0; j < codes.length; j++) {
                                    if (codes[j].codexId == 1) {
                                        mStr += '<img style="width: 28px;" src="${basePath}/images/v1/img/zhijiang.png">';
                                    } else if (codes[j].codexId == 5 || codes[j].codexId == 8) {
                                        mStr += ' <img style="width: 28px;" src="${basePath}/images/v1/img/manjian.png">';
                                    } else if (codes[j].codexId == 6) {
                                        mStr += ' <img style="width: 28px;" src="${basePath}/images/v1/img/manzeng.png">';
                                    } else if (codes[j].codexId == 10) {
                                        mStr += '  <img style="width: 28px;" src="${basePath}/images/v1/img/tuangou.png">';
                                    } else if (codes[j].codexId == 11) {
                                        mStr += '     <img style="width: 28px;" src="${basePath}/images/v1/img/qianggou.png">';
                                    } else if (codes[j].codexId == 15) {
                                        mStr += ' <img style="width: 28px;" src="${basePath}/images/v1/img/zhekou.png">';
                                    }

                                }
                            }
                                    mStr += '</div>';
                                    if (msg.pb.data[i].wareList != null) {
                                        for (var j = 0; j < msg.pb.data[i].wareList.length; j++) {
                                            if (msg.pb.data[i].wareList[j] != null) {
                                                if (wareId == msg.pb.data[i].wareList[j].wareId) {
                                                    price = msg.pb.data[i].wareList[j].warePrice;
                                                }
                                            }
                                        }
                                    }
                                    var imgSrc = "";
                                    if (msg.pb.data[i].imgList != null && msg.pb.data[i].imgList.length > 0) {
                                        imgSrc = msg.pb.data[i].goodsInfoImgId;
                                    }
                                    var commentCount = 0;
                                    var precentCount = 0;
                                    if (msg.pb.data[i].commentUtilBean != null && msg.pb.data[i].commentUtilBean.goodCount > 0) {
                                        commentCount = msg.pb.data[i].commentUtilBean.count;
                                        precentCount = msg.pb.data[i].commentUtilBean.goodCount / commentCount;
                                        precentCount = precentCount * 100;
                                    }
                                    //str += '<div class="list-item">' + '<a class="external" href="${basePath}/item/' + msg.pb.data[i].goodsInfoId + '.html">' + '<div class="propic">' + '<img src="' + imgSrc + '" alt="' + msg.pb.data[i].goodsInfoName + '"/>' + '</div>' + '<div class="prodesc"><h3 class="title">' + msg.pb.data[i].goodsInfoName + '</h3> <p class="price">' + '&yen;&nbsp;<span>' + price.toFixed(2) + '</span>' + mStr + '</p><p class="comm"><span class="item-percent">好评<span>' + precentCount + '</span>%</span>' + '<span class="item-pnum"><span>' + commentCount + '</span>人评价</span>' + '</p></div></a> </div>';
                                    var oldPrice = msg.pb.data[i].goodsInfoPreferPrice;
                                    var finalPrice = msg.pb.data[i].finalPrice;
                                    var p = oldPrice.toFixed(2);
                                    var p2 = finalPrice.toFixed(2);
                                    str += "<div class='list-item'><a class='external' href='/item/" + msg.pb.data[i].goodsInfoId + ".html'><div class='propic'><img src=" + imgSrc + " alt=" + msg.pb.data[i].goodsInfoName + "/></div><div class='prodesc'><h3 class='title'>" + msg.pb.data[i].goodsInfoName +"</h3> ";
                                    //判断促销方式
                                    var priceStr = "&yen;&nbsp;<span>" + p.split(".")[0] + ".<span style='font-size: 12px;'>"+ p.split(".")[1] +"</span></span>";
                                    if(oldPrice!=finalPrice){
                                        priceStr = "&yen;&nbsp;<span>" + p2.split(".")[0] + ".<span style='font-size: 12px;'>"+ p2.split(".")[1] +"</span></span>" + " <em class='price1'>"+ priceStr +"</em>";
                                    }
                                    str += "<p class='price'>"+priceStr + mStr + "  </p>   ";
                                    if(commentCount<1){
                                        str += "<p class='comm'><span class='item-pnum'>暂无评价</span></p></div></a>  <div style=' position: absolute;bottom:2px;right: 0px;width:50px; height: 50px;'><a href='javascript:;' class='addcar' onclick='addShoppingCart(this,"+ msg.pb.data[i].goodsInfoId +");'></a></div></div>";
                                    }else if(commentCount>1000){
                                        str += "<p class='comm'><span class='item-pnum'>1000+</span></p></div></a>  <div style=' position: absolute;bottom:2px;right: 0px;width:50px; height: 50px;'><a href='javascript:;' class='addcar' onclick='addShoppingCart(this,"+ msg.pb.data[i].goodsInfoId +");'></a></div></div>";

                                    }else{
                                        str += "<p class='comm'><span class='item-pnum'><span>评价&nbsp;&nbsp;" + commentCount +"</span></span></p></div></a>  <div style=' position: absolute;bottom:2px;right: 0px;width:50px; height: 50px;'><a href='javascript:;' class='addcar' onclick='addShoppingCart(this,"+ msg.pb.data[i].goodsInfoId +");'></a></div></div>";

                                    }
                                    //str += "<p class='comm'><span class='item-pnum'><span>" + commentCount +"</span>人评2价</span></p></div></a>  <div style=' position: absolute;bottom:2px;right: 0px;width:50px; height: 50px;'><a href='javascript:;' class='addcar' onclick='addShoppingCart(this,"+ msg.pb.data[i].goodsInfoId +");'></a></div></div>";


                        }
                        $(".prolist").append(str);
                    }
                });
            }
        };

        function showLoadingImg() {
            $('#showmore').html(' <img alt="" src="${basePath}/images/loading.gif"> <span>加载中……</span>');
        }

        function showFailure() {
            $('#showmore').html('<font color=red> 获取查询数据出错 </font>');
        }


        var overscroll = function(el) {
            el.addEventListener('touchstart', function() {
//                alert("asasasa");
                var top = el.scrollTop
                        ,totalScroll = el.scrollHeight
                        ,currentScroll = top + el.offsetHeight;
                if(top === 0) {
                    el.scrollTop = 1;
                }else if(currentScroll === totalScroll) {
                    el.scrollTop = top - 1;
                }
            });

            el.addEventListener('touchmove', function(evt) {
                if(el.offsetHeight < el.scrollHeight)
                    evt._isScroller = true;
            });
        }

        overscroll(document.querySelector('.scroll'));
        document.body.addEventListener('touchmove', function(evt) {
            if(!evt._isScroller) {
                evt.preventDefault();
            }
        }, {passive: false});
        var overscroll_2 = function(el) {
            el.addEventListener('touchstart', function() {
//                alert("asasasa");
                var top = el.scrollTop
                        ,totalScroll = el.scrollHeight
                        ,currentScroll = top + el.offsetHeight;
                if(top === 0) {
                    el.scrollTop = 1;
                }else if(currentScroll === totalScroll) {
                    el.scrollTop = top - 1;
                }
            });

            el.addEventListener('touchmove', function(evt) {
                if(el.offsetHeight < el.scrollHeight)
                    evt._isScroller = true;
            });
        }

        overscroll_2(document.querySelector('.scroll2'));
        document.body.addEventListener('touchmove', function(evt) {
            if(!evt._isScroller) {
                evt.preventDefault();
            }
        }, {passive: false});

        /*$('.submitfrom').click(function(){
            $('#searchProductForm').submit();
        })
*/

    </script>
</body>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="${basePath}/js/bootstrap.min.js"></script>
<script src="${basePath}/js/fastclick.min.js"></script>
<script src="${basePath}/js/idangerous.swiper-2.1.min.js"></script>
<script src="${basePath}/js/jquery.keleyi.js"></script>
<script src="${basePath}/js/jquery.lazyload.js"></script>
<script src="${basePath}/js/goods/goods_list.js"></script>

<#--<script src="${basePath}/js/goods/goods_pro.js"></script>-->
<script src="${basePath}/js/v1/framework7.min.js"></script>
<script src="${basePath}/js/v1/index.js"></script>
<script src="${basePath}/js/v3/mui.min.js"></script>
<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?94d81cec8c55272bd7081c5126331fc1";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>
<#--唤醒app-->
<script>
//    // 下载消失效果
//    function aaclose(){
//        $(".arouse-app").hide();
//        $(".search .search_box").css({ "top": "0"});
//        $(".pages").css({ "padding-top": "51px"});
//    }
//    // 展示
//    function aashow(){
//        $(".arouse-app").show();
//        $(".search .search_box").css({ "top": "54px"});
//        $(".pages").css({ "padding-top": "105px"});
//    }

    //滑动处理
//滑动处理
var startX, startY;
function GetSlideDirection(startX, startY, endX, endY) {
    var dy = startY - endY;
    //var dx = endX - startX;
    var result = 0;
    if(dy>0) {//向上滑动
        result=1;
    }else if(dy<0){//向下滑动
        result=2;
    }
    else
    {
        result=0;
    }
    return result;
}
$('.mui-scroll').on("touchstart",function(ev){
    startX = ev.originalEvent.touches[0].pageX;
    startY = ev.originalEvent.touches[0].pageY;
}).on("touchmove",function(ev){
    var endX, endY;
    endX = ev.originalEvent.changedTouches[0].pageX;
    endY = ev.originalEvent.changedTouches[0].pageY;
    var direction = GetSlideDirection(startX, startY, endX, endY);
    switch(direction) {
        case 0:
            //无操作
            break;
        case 1:
            // 向上
            $(".shopping_cart").removeClass("status");
            break;
        case 2:
            // 向下
            $(".shopping_cart").addClass("status");
            break;
        default:
    }
});

mui('.mui-scroll-wrapper').scroll({
    scrollY: true, //是否竖向滚动
    scrollX: false, //是否横向滚动
    startX: 0, //初始化时滚动至x
    startY: 0, //初始化时滚动至y
    indicators: false, //是否显示滚动条
    deceleration:0.002, //阻尼系数,系数越小滑动越灵敏
    bounce: false
});

document.getElementById('muiscroll').addEventListener('scrollbottom',function(){
//    console.log('scrollbottom');
    scrollbottom()
});
</script>
<script src="${basePath}/js/v1/arouse-app.js"  type="text/javascript"></script>
</html>