<#assign basePath=request.contextPath>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>分类</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="keywords" content="${(seo.meteKey)!''}">
    <meta name="description" content="${(seo.meteDes)!''}">
<#if (sys.bsetName)??>
    <title>${sys.bsetName}</title>
    <input type="hidden" id="bsetName" value="${(sys.bsetName)!''}">
    <input type="hidden" id="bsetDesc" value="${(sys.bsetDesc)!''}">

<#else>
    <title>${(seo.mete)!''}</title>
    <input type="hidden" id="bsetName" value="${(seo.mete)!''}">
    <input type="hidden" id="bsetDesc" value="${(sys.bsetDesc)!''}">
</#if>
    <link href="${basePath}/css/style.min.css" rel="stylesheet">
    <link href="${basePath}/css/ui-dialog.css" rel="stylesheet">
    <#--<link rel="stylesheet" href="${basePath}/css/v1/css/index.css">-->
    <#--<link rel="stylesheet" href="${basePath}/css/v1/css/css.css">-->
    <link rel="stylesheet" href="${basePath}/css/v2/cates.css">
    <script  src="${basePath}/js/jquery.js"></script>
</head>
<body>
<div class="bodywarp">
<div class="header">
    <h4 style="text-align: center;font-size:16px">分类</h4>
    <div class="right"><a href="javascript:void(0)" class="link search"><i class="searchicon"></i></a></div>
</div>
<div class="content-class">

        <div class="main-list" id="mainlist">
            <div id="wrapper1">
                <div id="scroller1">
                    <#if catebars??&&catebars?size!=0>
                        <#list catebars as cate>
                            <a class="list-item <#if cate.cateBarId==cateId>selected</#if>" href="${basePath}/cates/${cate.cateBarId}" onclick="_czc.push(['_trackEvent', '分类', '一级分类', '${cate.name?replace("　",'</span><span class="name">')}','0','cate${cate.cateBarId}']);">
                                <input type="hidden" value="${cate.name}"/>
                                <span class="name">${cate.name?replace("　",'</span><span class="name">')}</span>
                            </a>
                        </#list>
                    </#if>
                </div>
            </div>
    </div>
    <div id="wrapper">
        <div id="scroller">
            <div class="list" id="list">
            <#if cateBarVos??&&cateBarVos?size!=0>
                <#list cateBarVos as cateBarVo>
                    <dl class="list-box">
                        <dt>${cateBarVo.name!''}<i></i></dt>
                        <div class="list-body">
                            <#if cateBarVo.childs??&&cateBarVo.childs?size!=0>
                                <#list cateBarVo.childs as cate>
                                    <dd>
                                        <a class="sub-list-item" href="${basePath}/list/${(cate.cateId)!''}">
                                            <img alt="" src="${cate.imgSrc!''}" style="height: 65px;width: 65px">
                                            <span style="display: block;height: 18px;overflow: hidden;word-wrap: break-word;white-space: nowrap;">${cate.name!''}</span>
                                        </a>
                                    </dd>
                                </#list>
                            </#if>
                        </div>
                    </dl>
                </#list>
            </#if>
            </div>
        </div>
    </div>
</div>


    <script id="t:_1234-abcd-1" type="text/html">
        <div class="list" id="list">
            <%for(var i=0;i<list.length;i++){%>
            <dl class="list-box">
                <dt><%=list[i].name%><i></i></dt>
                <div class="list-body">
                    <%for(var j=0;j<list[i].childs.length;j++){%>
                        <dd>
                            <a class="sub-list-item" href="${basePath}/list/<%=list[i].childs[j].cateId%>">
                                <img alt="" src="<%=list[i].childs[j].imgSrc%>" style="height: 65px;width: 65px">
                                <span style="display: block;height: 18px;overflow: hidden;word-wrap: break-word;white-space: nowrap;"><%=list[i].childs[j].name%></span>
                            </a>
                        </dd>
                    <%}%>
                </div>
            </dl>
            <%}%>
        </div>
    </script>

<#--引入底部-->
<#include "../common/new_960menu_index.ftl"/>
</div>
<#--引入搜索页-->
<#include "../main/popupSearch.ftl">
<#--<#include "../common/new_960menu.ftl"/>-->
<#--<div class="bar-bottom" >-->
<#--<a class="bar-item" href="${basePath}/main.html"><i class="bar-bottom-i home"></i>首页</a>-->
<#--<a class="  active bar-item"   style="color: #ffffff;" href="${basePath}/cates.html"><i class="bar-bottom-i class"></i>分类</a>-->
<#--<a class="   bar-item" href="${basePath}/myshoppingmcart.html"><i class=" active1 bar-bottom-i cart  "></i>购物车</a>-->
<#--<a class="  bar-item" href="${basePath}/customercenter.html"><i class="bar-bottom-i mine"></i>我的</a>-->
<#--</div>-->
<script src="${basePath}/js/jquery.js"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script>
    var localUrl = window.location.href;
    $(function(){
        $.ajax({
            url: "${basePath}/queryWxConfig.htm",
            type: "POST",
            data:{curUrl: localUrl},
            success: function (data) {
                //console.info(data);
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
<script type="text/javascript">
    $(function(){
        $(".bar-bottom a:eq(1)").addClass("selected");

        $(".search-label").click(function(){
            if($("#searchInput").val()==''){
                $("#searchInput").val($(".selected").find("input").val());
            }
            $("#searchProductForm").submit();
        })
    })
</script>
<p style="display: none;">
    <!--友盟CNZZ统计-->
    <script src="https://s13.cnzz.com/z_stat.php?id=1264375679&web_id=1264375679" language="JavaScript">
        var _czc = _czc || [];
        _czc.push(["_setAccount", "m.ge960.com"]);
    </script>
</p>
<script  src="${basePath}/js/v2/baiduTemplate.js"></script>
<script  src="${basePath}/js/v2/alloy_touch.js"></script>
<script  src="${basePath}/js/v2/transform.js"></script>
<script>
    $(".header .right .searchicon").on("click",function(e){
        e.preventDefault();
        $(".bodywarp").toggle();
        $(".searchWarp").toggle();
    })
    $(".searchBack").on("click",function(){
        $(".bodywarp").show();
        $(".searchWarp").hide();
    })
    var a = $(window).height()-$(".header .link").height()-$(".bar-bottom").height();
    $(".list").css("min-height",a);
    $(".main-list").css("height",a+$(".bar-bottom").height());
    var b = $(window).height()-$(".header .link").height()-$(".bar-bottom").height()-$(".list").height();
    if(b>=0) b = 0;
    var c = $(".main-list").height() - $(".main-list a").length*($(".main-list a").eq(0).height()+1);
    var scroller = document.querySelector("#scroller"),
            scroller1 = document.querySelector("#scroller1");
    list = document.querySelector("#list");
    Transform(scroller, true);
    var alloyTouch = new AlloyTouch({
        touch: "#wrapper",
        vertical: true,
        target: scroller,
        property: "translateY",
        initialValue: 0,
        min: b,
        max: 0
    });
    Transform(scroller1, true);
    var alloyTouch1 = new AlloyTouch({
        touch: "#wrapper1",
        vertical: true,
        target: scroller1,
        property: "translateY",
        initialValue: 0,
        min: c,
        max: 0
    });

    $("#scroller1 a").on("click",function(e){
        e.preventDefault();
        alloyTouch.to(0);
        $("#scroller1 a").removeClass("selected");
        $(this).addClass("selected");
        var hrefid = $(this).attr("href");
        hrefid =hrefid.substring(7,hrefid.length);
        $.ajax({
            url:"/queryJsonMobCateBar.htm?cateId="+hrefid+"",
            async:true,
            success: function(data){
                var htmlStr = baidu.template('t:_1234-abcd-1', {list: data});
                $("#scroller").html(htmlStr);
                b = $(window).height()-$(".header .link").height()-$(".bar-bottom").height()-$(".list").height();
                if(b>=0) b = 0;
                alloyTouch.min = b;
            }
        });
    });
</script>
</body>
</html>