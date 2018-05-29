<!DOCTYPE html>
<html lang="zh-cn" xmlns="http://www.w3.org/1999/html">
<head>
<#assign basePath=request.contextPath>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="keywords" content="${seo.meteKey}">
    <meta name="description" content="${seo.meteDes}">
<#if (sys.bsetName)??>

    <title><#if map.nowcate?? >${map.nowcate.catName}<#else>所有商品</#if>列表页--${sys.bsetName}</title>
<#else>
    <title><#if map.nowcate?? >${map.nowcate.catName}<#else>所有商品</#if>列表页--${seo.mete}</title>
</#if>

    <link rel="stylesheet" href="${basePath}/css/v1/css/frozen.css"/>
    <link rel="stylesheet" href="${basePath}/css/style.min.css"/>
    <link rel="stylesheet" href="${basePath}/css/list.css"/>
</head>

<body class="framework7-root">
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script>
    var localUrl = window.location.href;
    $(function(){
        $.ajax({
            url: "${basePath}/queryWxConfig.htm",
            type: "POST",
            data:{curUrl: localUrl},
            success: function (data) {
                console.info(data);
                wx.config({
                    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                    appId: data.appId, // 必填，公众号的唯一标识
                    timestamp: data.timestamp, // 必填，生成签名的时间戳
                    nonceStr: data.nonceStr, // 必填，生成签名的随机串
                    signature: data.signature,// 必填，签名，见附录1
                    jsApiList: ['onMenuShareAppMessage','onMenuShareTimeline'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
                });
            },
            async:false
        });
    });

    wx.ready(function () {
        wx.onMenuShareAppMessage({
            title: '中国960官方商城',
            desc: '中国960官方商城',
            link: 'http://m.ge960.com/',
            imgUrl: 'http://boss.ge960.com:80/upload/20170327/1490602121555.jpg'
        });

        wx.onMenuShareTimeline({
            title: '中国960官方商城',
            link: 'http://m.ge960.com/',
            imgUrl: 'http://boss.ge960.com:80/upload/20170327/1490602121555.jpg'
        });
    })
</script><#--自定义分享到朋友圈-->
<div class="views">
    <div class="view view-main">


        <div class="bar-top" style="position: absolute;">
            <div class="search complete_search" style="position: relative;">
                <div class="search_box">
                    <div class="s_left">
                        <a href="${basePath}/initMain.htm" class="backto_page">
                            <i class="ion-ios-arrow-left"></i>
                        </a>
                    </div>
                    <div class="search_form">
                        <i class="ion-ios-search-strong submitfrom"></i>
                        <form action="${basePath}/searchProduct.htm" method="get" id="searchProductForm" >
                            <input id="searchInput"  id="searchInput"  value="<#if keyWords??>${keyWords}</#if>" placeholder="请输入商品名称"  name="keyWords"  type="text" placeholder="大双曲屏 三星S6 edge+">
                            <input type="hidden" value="${storeId!""}" name="storeId" id="storeId">
                        </form>
                    </div>
                    <div class="s_right">
                    <#--<a href="javascript:void(0);" id="searchBtn" class="search_btn">搜索</a>-->
                    </div>
                </div>
            </div>

        </div>


        <div class="pages navbar-through toolbar-through">

            <div class="panel-overlay"></div>
            <div class="panel panel-right panel-cover">
                <div class="content-block">
                    <div class="content-block-title">
                    <span>筛选</span>
                        <img class="img-close panel-overlay" src="/images/v1/img/close.png"" alt=""/>
                    </div>
                    <div class="content-block-menu">
                        <div class="content-block-select">
                            <span>分类</span>
                            <div class="ui-btn-wrap cateclass">
                                <#if map.cname??>
                                    <button class="ui-btn-s" val="${map.cid}">${map.cname}</button>
                                </#if>
                            </div>
                        </div>
                        <div class="content-block-select">
                            <span>品牌</span>
                            <div class="ui-btn-wrap brandclass">
                                <#if map.brands??>
                                    <#if map.brands?size!=0 >
                                      <#list map.brands as brand>
                                          <button class="ui-btn-s" val="${brand.brandId}">${brand.brandName}</button>
                                      </#list>
                                    </#if>
                                </#if>
                            </div>
                        </div>
                       <#-- <div class="content-block-select">
                            <span>产地</span>
                            <div class="ui-btn-wrap">
                                <button class="ui-btn-s">拒绝</button>
                                <button class="ui-btn-s">拒绝</button>
                            </div>
                        </div>-->
                        <div class="content-block-select" style="border-bottom:none;">
                            <span>价格区间</span>
                            <div class="qj">
                                <input class="minprice" type="text" value="" placeholder="0"/> <i>—</i>  <input class="maxprice" type="text" value="" placeholder="999"/>
                            </div>
                            <div class="ui-btn-wrap priceclass">
                                <button class="ui-btn-s" val="0-20">0-20</button>
                                <button class="ui-btn-s" val="20-60">20-60</button>
                                <button class="ui-btn-s" val="60-100">60-100</button>
                                <button class="ui-btn-s" val="100-200">100-200</button>
                                <button class="ui-btn-s" val="200-10000">200以上</button>
                            </div>
                        </div>
                        <div class="ui-btn-group">
                            <button class="ui-btn-lg ui-btn-primary external" id="agree">完成</button>
                            <button class="ui-btn-lg" id="reset">重置</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="bar-top" id="seleted"  style="position:relative;">
                <a val="3D" href="javascript:void(0);" class="bar-item filter-item change_sort <#if map.searchBean.sort!='' && map.searchBean.sort='33D' || map.searchBean.sort='3D' >active</#if>"  filter_default ">上架时间<#if map.searchBean.sort!='' && map.searchBean.sort='33D' ><i class="sharp-up"></i></#if><#if map.searchBean.sort!='' && map.searchBean.sort='3D' ><i class="sharp-down"></i></#if></a>
                <a val="2D" href="javascript:void(0);" class="bar-item filter-item change_sort <#if map.searchBean.sort!='' && map.searchBean.sort='22D' || map.searchBean.sort='2D' >active</#if>"  filter-sales">销量<#if map.searchBean.sort!='' && map.searchBean.sort='22D' ><i class="sharp-up"></i></#if><#if map.searchBean.sort!='' && map.searchBean.sort='2D' ><i class="sharp-down"></i></#if></a>
                <a val="1D" href="javascript:void(0);" class="bar-item filter-item change_sort <#if map.searchBean.sort!='' && map.searchBean.sort='11D' || map.searchBean.sort='1D'>active</#if>"  filter-price">价格<#if map.searchBean.sort!='' && map.searchBean.sort='11D' ><i class="sharp-up"></i></#if><#if map.searchBean.sort!='' && map.searchBean.sort='1D' ><i class="sharp-down"></i></#if></a>
                <a href="#" id="show_btn" class="bar-item style-trans filtercolor button open-panel" data-panel="right">筛选<i class="list-icon list-1"></i></a>
            </div>
            <input type="hidden" id="basePath" value="${basePath}">
            <input type="hidden" id="show_status" value="${showStatus!""}">




            <script src="${basePath}/js/jquery.js"></script>



        <script>
            //    $(function() {
            ////列表条形块形样式切换
            //        $('.style-trans').click(function () {
            //            if ($("#showStatus").val() == 0) {
            //                $("#showStatus").val(1);
            //            } else {
            //                $("#showStatus").val(0);
            //            }
            //            if ($('.list-line').length > 0) {
            //                $('.list-line').addClass('list-box').removeClass('list-line');
            //                $(this).find('i.list-icon').addClass('list-2').removeClass('list-1');
            //            }
            //            else {
            //                $('.list-box').addClass('list-line').removeClass('list-box');
            //                $(this).find('i.list-icon').addClass('list-1').removeClass('list-2');
            //            }
            //        });
            //
            //        if ($("#show_status").val() == 1) {
            //            $('.style-trans').click();
            //        }
            //    });
        </script>
        <div class="content"  style="padding-top:0;" >
            <div class="content-prolist" >
                <#--<div class="prolist list-line">-->
            <div class="prolist list-line" style="margin-bottom: 0">
            <#if map.pb.list??>
                <#if map.pb.list?size!=0>
                    <#list map.pb.list as product>
                        <div class="list-item">
                            <a class = "external" href="${basePath}/item/${product.goodsInfoId}.html">
                                <div class="propic">
                                <#--<img src="<#if  product.imageList?? && product.imageList?size &gt; 0 >${product.imageList[0].imageBigName!''}</#if>" alt="${product.productName!''}"/>-->
                                    <img src="${product.goodsInfoImgId}" alt="${product.productName!''}"/>
                                </div>
                                <div class="prodesc">
                                    <h3 class="title">${product.productName!''}</h3>
                                    <p class="price">&yen;&nbsp;<span>${product.warePrice?string('0.00')}</span>
                                        <#--<#list product.codeIds as code>-->
                                            <#--<#if code.codexId==5>-->
                                                <#--<span class="fav reduce">减</span>-->
                                            <#--</#if>-->
                                            <#--<#if code.codexId==1>-->
                                                <#--<span class="fav reduce">直</span>-->
                                            <#--</#if>-->
                                            <#--<#if code.codexId==8>-->
                                                <#--<span class="fav discount">折</span>-->
                                            <#--</#if>-->
                                            <#--<#if code.codexId==12>-->
                                                <#--<span class="fav reduce">邮</span>-->
                                            <#--</#if>-->
                                            <#--<#if code.codexId==10>-->
                                                <#--<span class="fav reduce">团</span>-->
                                            <#--</#if>-->
                                            <#--<#if code.codexId==11>-->
                                                <#--<span class="fav reduce">抢</span>-->
                                            <#--</#if>-->
                                        <#--</#list>-->
                                    </p>
                                    <p class="comm">
                                        <#assign goodCount=0 >
                                        <#assign count=0>
                                        <#if product.commentUtilBean??>
                                            <#assign goodCount="${(goodCount?number+product.commentUtilBean.goodCount)?number}">
                                            <#assign count="${(count?number+product.commentUtilBean.count)?number}">
                                            <#if product.commentUtilBean.goodCount?number gt 0 >
                                                <#assign goodCount="${goodCount?number/count?number}">
                                                <#assign goodCount="${goodCount?number*100}">

                                            </#if>
                                        </#if>
                                        <span class="item-percent">好评<span><#if product.commentUtilBean??>${goodCount!""}<#else>0</#if></span>%</span>
                                        <span class="item-pnum"><span><#if product.commentUtilBean??>${product.commentUtilBean.count!""}<#else>0</#if></span>人评价</span>
                                    </p>
                                </div>
                            </a>
                        </div>
                    </#list>
                <#else>
                    <div class="no_tips">
                        <p>木有搜索到商品哦</p>
                    </div>
                </#if>
            </#if>
                <div class="slideBar">
                    <div class="slideBar-item sTop"><i></i></div>
                </div>
            </div>
            <div id="showmore" class="list-loading" style="height:45px;padding:10px;"></div>
            </div>
        </div>
        </div>
        <#--引入footer-->
    <#--<#include "../common/smart_menu.ftl" />-->
        <input type="hidden" id="cateId" value="<#if map.nowcate??>${map.nowcate.catId}</#if>">
        <div class="hide">
            <form action="${basePath}/<#if storeId??&&storeId!=0>allGoodsListByStoreId.htm?storeId=${storeId}<#else>list/<#if map.nowcate?? >${map.nowcate.catId}<#else>allproduct</#if>.html</#if>" id="searchForm" method="post">
                <div class="filterList">
                    <ul class="clearfix">
                        <input type="hidden" name="pageNo" class="pageNo" value="${map.pb.pageNo}">
                        <input type="hidden" name="sort" class="list_sort" value="${map.searchBean.sort!''}">
                        <input type="hidden" name="showStock" class="show_stock" value="${map.searchBean.showStock!''}">
                        <input type="hidden" name="showStatus" id="showStatus" value="0">
                        <input type="hidden" id="showBrand" value="${map.searchBean.brandId!''}">
                        <input type="hidden" id="showCatBarId" value="${map.searchBean.cateBarId!''}">
                        <input type="hidden" name="brandid" id="brandid" value="<#if map.brandId??>${map.brandId}</#if>"/>
                        <input type="hidden" name="pricemin" id="priceminid" value="<#if map.pricemin??>${map.pricemin}</#if>"/>
                        <input type="hidden" name="pricemax" id="pricemaxid" value="<#if map.pricemax??>${map.pricemax}</#if>"/>
                    </ul>
                </div>
                <!--/filterList-->
            </form>
        </div>
        <input type="hidden" value="0" id="status">
        <input class="storeId" type="hidden" value="${storeId!""}">
    </div>
</div>


<script>
    window.onload=function()//用window的onload事件，窗体加载完毕的时候
    {
        $(".pageNo").val(1);
        $("#status").val(0);
        //do something
    }

    $(function(){
        //回到顶部
        $('.sTop>i').click(function(){
            $(".content").animate({scrollTop: 0}, 800);
        });

        /* 显示隐藏搜索 */
        $('.search-pro').click(function(){
            $('.pro-search-box').show();

        });

        $('.search_btn').click(function(){
            checkCookie($("#searchInput").val());
            $("#storeId").val($(".storeId").val());
            $("#searchProductForm").submit();
        });
        $('.search-cancel').click(function(){
            $('.pro-search-box').hide();
        });
//        筛选的点击效果
        $(".content-block-select button").on("click",function(){
            $(this).parents(".content-block-select").find("button").removeClass("active");
            $(this).addClass("active")
        })

        //筛选重置
        $("#reset").on("click",function(){
            $(".content-block-select button").each(function(index,item){
                $(item).removeClass("active");
            })
            $(".content-block-select .minprice").val(0);
            $(".content-block-select .maxprice").val(0);
        });
        //筛选完成
        $("#agree").on("click",function(){
            if(!!$(".content-block-select .cateclass .active").attr("val")){};
            if(!!$(".content-block-select .brandclass .active").attr("val")){
               $("#brandid").val($(".content-block-select .brandclass .active").attr("val"));
            }else{
               $("#brandid").val("");
            };
             if($(".content-block-select .minprice").val()>=0&&$(".content-block-select .maxprice").val()>
                     $(".content-block-select .minprice").val()){
                 //自定义区间价格
                 $("#priceminid").val($(".content-block-select .minprice").val());
                 $("#pricemaxid").val($(".content-block-select .maxprice").val());

             }else if(!!$(".content-block-select .priceclass .active").attr("val")){
                    //区间价格
                    var str=$(".content-block-select .priceclass .active").attr("val");
                    var arr=str.split("-");
                    $("#priceminid").val(arr[0]);
                    $("#pricemaxid").val(arr[1]);
             }else{
                    $("#priceminid").val("");
                    $("#pricemaxid").val("");
                }
                //触发关闭按钮
            $('.panel-overlay').trigger("click");
            $(".pageNo").val("1");
             $('#searchForm').submit();

        })
        //选中筛选的选中项
        var is='no';
        $('.content-block-select  button').each(function(index,item){
            if($(item).attr('val')==$('#brandid').val()){
                $(item).addClass('active');
            }else if($(item).attr('val')==($('#priceminid').val()+"-"+$('#pricemaxid').val())){
                $(item).addClass('active');
                is='yes';
            }
        })
        if('no'==is&&$('#priceminid').val()>0&&$('#priceminid').val()<$('#pricemaxid').val()){
            $(".minprice").val($('#priceminid').val());
            $(".maxprice").val($('#pricemaxid').val());
        }
        /* 商品列表排序 */

//        $("#seleted .bar-item").on("click",function(){
//            if($(this).hasClass("active")){
//                if($(this).hasClass("active-click")){
//                    $("#seleted a").removeClass("active-click");
//                }else{
//                    $(this).addClass("active-click");
//                }
//            }else{
//                $("#seleted a").removeClass("active-click");
//                $("#seleted a").removeClass("active");
//                $(this).addClass("active");
//
//            }
//
//        })

//        //默认排序
//        $('.filter_default').click(function(){
//            $('.filter-item').removeClass('active').find('i').remove();
//            $(this).addClass('active');
//        });
//
//        //销量排序
//        $('.filter-sales').click(function(){
//            $('.filter-item').removeClass('active').find('i').remove();
//            $(this).addClass('active');
//            $(this).append('<i class="sharp-down"></i>');
//        });
//
//        //价格排序
//        $('.filter-price').click(function(){
//            if($(this).find('i').length == 0){
//                $('.filter-item').removeClass('active').find('i').remove();
//                $(this).addClass('active');
//                $(this).append('<i class="sharp-up"></i>');
//            }
//            else if($(this).find('i').attr('class') == 'sharp-up'){
//                $(this).find('i').attr('class','sharp-down');
//            }
//            else{
//                $(this).find('i').attr('class','sharp-up');
//            }
//        });
    });
    var nowtime = 0;
    var lasttime = 0;
    //    $(".content").scroll(function(){
        $(".content").unbind("scroll").bind("scroll", function(e) {
            if ($("#status").val() == 1) {
                return null;

            }
        if($(this).scrollTop() >= ($('.content-prolist').height() - $('.content').height())){
//          var sum = this.scrollHeight;
//          if (sum - 200 <= $(this).scrollTop() + $(this).height()) {
            nowtime = new Date().getTime();
            time = nowtime - lasttime;//计算与上次触发的时间差
            console.log("时间差---------"+time);

            if(lasttime==0 || (lasttime!=0 && time>5000)){//控制当前时间和上次触发scroll时间差，第一次触发scroll或者 触发时间间隔大于1秒才能再次触发ajax
//                document.write(time);
                lasttime = nowtime;
                var pageNo = $(".pageNo").val();
                pageNo++;
                $(".pageNo").val(pageNo);

                var strRequest = "";
                if ($("#cateId").val() != null && $("#cateId").val() != "") {
                    strRequest += "&cid=" + $("#cateId").val();
                }
                if ($("#storeId").val() != null && $("#storeId").val() != "") {
                    strRequest += "&storeId=" + $("#storeId").val();
                }
                var showCatBarId = $("#showCatBarId").val();
                if (showCatBarId != null && showCatBarId != "") {
                    strRequest = "&cateBarId=" + showCatBarId;
                }
                var saixuanstr = "";
                var saixuanBrand = $("#brandid").val();
                if (saixuanBrand != null && saixuanBrand != "") {
                    saixuanstr += "&brandid=" + saixuanBrand;
                }
                var saixuanPricemin = $("#priceminid").val();
                if (saixuanPricemin != null && saixuanPricemin != "") {
                    saixuanstr += "&pricemin=" + saixuanPricemin;
                }
                var saixuanPricemax = $("#pricemaxid").val();
                console.log(saixuanPricemax)
                if (saixuanPricemax != null && saixuanPricemax != "") {
                    saixuanstr += "&pricemax=" + saixuanPricemax;
                }
                $.ajax({
                    type: "POST",
                    url: "${basePath}/allproajax.htm",
                    beforeSend: showLoadingImg,
                    error: showFailure,
                    data: "pageNo=" + $(".pageNo").val() + "&sort=" + $(".list_sort").val() + strRequest + saixuanstr,
                    success: function (msg) {
                        if (msg.pb.list.length == 0) {
                            $("#status").val(1);
                            $('#showmore').html('已无更多结果');
                        }
                        var str = "";

                        for (var i = 0; i < msg.pb.list.length; i++) {
                            var imgSrc = "";
                            if (msg.pb.list[i].imageList != null && msg.pb.list[i].imageList.length > 0) {
                                imgSrc = msg.pb.list[i].imageList[0].imageBigName;

                            }
                            var mStr = "";
                            var codes = msg.pb.list[i].codeIds
                            for (var j = 0; j < codes.length; j++) {
                                if (codes[j].codexId == 5) {
                                    mStr += '<span class="fav reduce">减</span>';
                                } else if (codes[j].codexId == 1) {
                                    mStr += '<span class="fav reduce">直</span>';
                                } else if (codes[j].codexId == 8) {
                                    mStr += '<span class="fav discount">折</span>';
                                } else if (codes[j].codexId == 12) {
                                    mStr += '<span class="fav reduce">邮</span>';
                                } else if (codes[j].codexId == 10) {
                                    mStr += '<span class="fav reduce">团</span>';
                                } else if (codes[j].codexId == 11) {
                                    mStr += '<span class="fav reduce">抢</span>';
                                }
                            }
                            var commentCount = 0;
                            var precentCount = 0;
                            if (msg.pb.list[i].commentUtilBean != null && msg.pb.list[i].commentUtilBean.goodCount > 0) {
                                commentCount = msg.pb.list[i].commentUtilBean.count;
                                precentCount = msg.pb.list[i].commentUtilBean.goodCount / commentCount;
                                precentCount = precentCount * 100;
                            }

                            str += '<div class="list-item">'
                                    + '<a class="external" href="${basePath}/item/' + msg.pb.list[i].goodsInfoId + '.html">'
                                    + '<div class="propic">'
                                    + '<img src="' + imgSrc + '" alt="' + msg.pb.list[i].productName + '"/>'
                                    + '</div>'
                                    + '<div class="prodesc"><h3 class="title">' + msg.pb.list[i].productName + '</h3> <p class="price">'
                                    + '&yen;&nbsp;<span>' + msg.pb.list[i].warePrice.toFixed(2) + '</span>' + mStr
                                    + '</p><p class="comm"><span class="item-percent">好评<span>' + precentCount + '</span>%</span>'

                                    + '<span class="item-pnum"><span>' + commentCount + '</span>人评价</span>'
                                    + '</p></div></a> </div>';
                        }
                        $(".prolist").append(str);


                    }
                });

            }
        }

// ccc



  });
    $('.submitfrom').click(function(){
        $('#searchProductForm').submit();
    })

    function showLoadingImg() {
        $('#showmore').html(' <img alt="" src="${basePath}/images/loading.gif"> <span>加载中……</span>');
    }

    function showFailure() {
        $('#showmore').html('<font color=red> 获取查询数据出错 </font>');
    }


</script>

</body>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="${basePath}/js/bootstrap.min.js"></script>
<script src="${basePath}/js/fastclick.min.js"></script>
<script src="${basePath}/js/idangerous.swiper-2.1.min.js"></script>
<script src="${basePath}/js/jquery.keleyi.js"></script>
<script src="${basePath}/js/jquery.lazyload.js"></script>
<script src="${basePath}/js/goods/goods_list.js"></script>
<script src="${basePath}/js/goods/goods_pro.js"></script>
<script src="${basePath}/js/v1/framework7.min.js"></script>
<script src="${basePath}/js/v1/index.js"></script>
<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?94d81cec8c55272bd7081c5126331fc1";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>
</html>