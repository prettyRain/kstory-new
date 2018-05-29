<#--<!DOCTYPE html>-->
<#--<#assign basePath=request.contextPath>-->
<#--<html>-->
<#--<head>-->
    <#--<meta charset="utf-8">-->
    <#--<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, minimal-ui">-->
    <#--<meta name="apple-mobile-web-app-capable" content="yes">-->
    <#--<meta name="apple-mobile-web-app-status-bar-style" content="black">-->
    <#--<title>中国960官方商城</title>-->
    <#--&lt;#&ndash;<link rel="stylesheet" href="${basePath}/css/v1/subject.css">&ndash;&gt;-->
    <#--<script src="${basePath}/js/v1/jquery.min.js"></script>-->
<#--</head>-->
<#--<body style="background: #fff;margin: 0;">-->
<style>
    /*------------------------搜索页面样式--------------------------*/
    body,html{
        background: #fff;}
    .searchbar {
        background: #f7f7f7;
        padding: 8px 65px 8px 16px;
    }
    .searchbar .searchBack{
        display: inline-block;
        position: absolute;
        top: 0;
        text-align: center;
        color:#000;
        font-size: 14px;
        height: 44px;
        vertical-align: middle;
        line-height: 44px;
        right:0;
        width: 1.2rem;
    }
    .searchbar input[type=search]{
        height: 33px;
        background-repeat: no-repeat;
        background-position: 7px center;
        background-image: url(../../../images/icon_v1.0/btn_search_nav@2x.png);
        -webkit-background-size: 22px 22px;
        background-size: 22px 22px;
        padding-left: 36px;
        border:none;
        width:100%;
        line-height:28px;
        background-color: #dddddd;
        border-radius: 30px;
    }
    .searchbar input::-webkit-input-placeholder { color: #7F7F7F;  font-size: 14px;  }

    .searchbar-not-found {
        display: none;
    }

    .page-content {
        padding: 0 .3rem;
        padding-top:20px;
    }
    .hot-search .title,.history-search .title{
        color:#7f7f7f;
        font-size: .24rem;
        padding: 0 0 .1rem 0;
    }
    .hot-search ul{
        /*display: flex;*/
        /*justify-content: space-between;*/
        margin-bottom: .2rem;
    }
    .hot-search .item-content,.history-search .item-content{
        float: left;
        padding: .14rem .24rem;
        font-size: .28rem;
        background: #f7f7f7;
        border-radius: 5px;
        margin: .16rem .14rem 0 0;
    }
    .hot-search .item-content a,.history-search .item-content a{
        color: #000;
    }
    .history-search .title span {
        position: absolute;
        right: 15px;
        background-image:url(/images/icon_v1.0/btn_delete@2x.png);
        background-size: 22px 22px;
        background-position: 0;
        background-repeat: no-repeat;
        width: 22px;
        height: 22px;
    }
    .history-search {  padding-top: .7rem;}
    .searchbar input[type=search] {
        background-color: #f7f7f7;
        height: 33px;
        font-size: 14px;
    }
    .searchbar {
        height: 45px;
        padding: 6px 1.2rem 6px 15px;
        display: block;
        margin-bottom: 0;
        background: #fff;
        border-bottom: 1px solid #eeee;
        box-sizing: border-box;
    }

</style>
<div class="searchWarp">
    <form action="${basePath}/searchProduct.htm" method="get" data-search-list=".search-here" data-search-in=".item-title" class="searchbar searchbar-init" id="searchProductForm">
        <#--<a href="javascript:history.go(-1)" class="searchBack">×</a>-->
        <#--<a href="javascript:history.go(-1)" class="searchBack">×</a>-->
        <div class="searchbar-input">
            <input type="search" name="keyWords" placeholder="搜索960商品 按类别 按属性" onfocus="this.placeholder=''" onblur="this.placeholder='搜索'" id="title"/><a href="#" class="searchbar-clear"></a>
            <input type="hidden" value="0" name="storeId" id="storeId">
        </div>
            <a href="javascript:history.go(-1)" class="searchBack">取消</a>
        <#--<span id="searchBtn" class="search-btn">搜索</span>-->
    </form>
    <div class="searchbar-overlay"></div>
    <div class="page-content">
        <div class="list-block searchbar-not-found">
            <ul>
                <li class="item-content">
                    <div class="item-inner">
                        <div class="item-title">0</div>
                    </div>
                </li>
            </ul>
        </div>
        <div class="list-block searchbar-found">
            <div class="hot-search" id="hot-search">
                <div class="title">热门搜索</div>
                <ul>
                    <li class="item-content">
                        <div class="item-inner">
                            <div class="item-title"><a class="external" href="${basePath}/intoPage.htm?pageName=main/childMallOne">食品荟萃</a></div>
                        </div>
                    </li>
                    <li class="item-content">
                        <div class="item-inner">
                            <div class="item-title "><a class="external" href="${basePath}/intoPage.htm?pageName=main/childMallTwo">饮品总汇</a></div>
                        </div>
                    </li>
                    <#--<li class="item-content">
                        <div class="item-inner">
                            <div class="item-title"><a class="external" href="${basePath}/intoPage.htm?pageName=main/childMallThree">购物中心</a></div>
                        </div>
                    </li>
                    <li class="item-content">
                        <div class="item-inner">
                            <div class="item-title"><a class="external" href="${basePath}/intoPage.htm?pageName=main/childMallFour">大药房</a></div>
                        </div>
                    </li>-->
                </ul>
                <div class="clearfixed"></div>
            </div>
            <div class="history-search">
                <div class="title">搜索历史 <a id="deletehistory"><span ></span></a></div>
                <ul id="historySearch">
                <#--<li class="item-content">-->
						<#--<div class="item-inner">-->
							<#--<div class="item-title"><a href="#" class="history">茶馆</a></div>-->
						<#--</div>-->
				<#--</li>-->
                </ul>
            </div>

        </div>
    </div>
</div>
<script>
    $(".searchWarp").css({display:"none"})
    $(".searchBack").on("click",function(e){
        e.preventDefault();
        $(".searchWarp").css({display:"none"})
        $(".listWarp").css({display:"block"})
    })
    $(".search-btn").on("click",function(){
        $(".searchWarp").css({display:"none"})
        $(".listWarp").css({display:"block"})
    })
    $(".hot-search .item-content").on("click",function(){
        console.log("1111.hot-search .item-content")
        $(".searchWarp").css({display:"none"})
        $(".listWarp").css({display:"block"})
    })

</script>
<script type="text/javascript">
    (function(doc, win) {
        var docEl = doc.documentElement,
                resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
                recalc = function() {
                    var clientWidth = docEl.clientWidth;
                    if (!clientWidth) return;
                    docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
                };
        if (!doc.addEventListener) return;
        win.addEventListener(resizeEvt, recalc, false);
        doc.addEventListener('DOMContentLoaded', recalc, false);
    })(document, window);
</script>
<script type="text/javascript">
    $(function(){
        //查询历史搜索
        getcookie('selectTitle');
        $("#title").on('keypress',function(e) {
            var keycode = e.keyCode;
            var searchName = $(this).val();

            if(keycode=='13') {
                e.preventDefault();
                if(searchName == ''){
                    return;
                }
                //请求搜索接口
                if($("#title").val()==''){
                    $("#title").val($("#title").attr("placeholder"));
                }
                setcookie("selectTitle",$('input[name=keyWords]').val(),1);
                $("#searchProductForm").submit();

            }
        });
        $("#searchBtn").click(function(){
            //.$("#storeId")val($(".storeId").val());
            if($("#title").val()==''){
                $("#title").val($("#title").attr("placeholder"));
            }
            setcookie("selectTitle",$('input[name=keyWords]').val(),1);
            $("#searchProductForm").submit();
        })
        //删除历史记录
        $('#deletehistory').click(function(){
            cleancookie("selectTitle","",0);
            getcookie('selectTitle');
        })
        $('.history').click(function(){
            var content=$(this).html();
            $("#title").val(content);
            $(".searchWarp").css({display:"none"})
            $(".listWarp").css({display:"block"})
            $("#searchProductForm").submit();
        })
    })
    //清空历史搜索
    function cleancookie(name,value,outTime){

        var nameandvalues=document.cookie.split(";");
        $.each(nameandvalues,function (i,e) {
            if(e.indexOf(name)!=-1){

                var date=new Date();
                date.setTime(date.getTime()+outTime*1000*60*60*0);

                document.cookie=name+"="+value+";"+"expires="+date.toUTCString();
                getcookie(name);
            }
        })

    }
    //设置cookie
    function setcookie(name,value,outTime){
        var str='';

        var cookiearr=document.cookie.split(";");
        if(cookiearr.length>0){
            for(var i=0;i<cookiearr.length;i++ ){
                var nameandvalue=cookiearr[i];

                if(nameandvalue.indexOf(name)!=-1){
                    str+=decodeURIComponent(nameandvalue.substring(nameandvalue.indexOf("=")+1,nameandvalue.length));
                }
            }
        }
        if(!!str){
            //如果已经搜索过  就不会添加到搜索列表
            if(str==value){
                return;
            }
            if(str.indexOf('---')!=-1){

                var arr=str.split("---");
                for(var i=0;i<arr.length;i++){
                    // alert(arr[i]==value)
                    if(arr[i]==value){
                        return;
                    }
                }
                //大于十五条时停止添加
                if(arr.length>15){
                    return;
                }
            }
            value=str+"---"+value;

        }
        var date=new Date();
        date.setTime(date.getTime()+(outTime*1000*60*60*24));
        document.cookie=name+"="+encodeURIComponent(value)+";"+"expires="+date.toUTCString();
    }
    //获取历史搜索
    function getcookie(name){
        $('#historySearch').empty();
        var cookiearr=document.cookie.split(";");
        if(cookiearr.length>0){
            for(var i=0;i<cookiearr.length;i++ ){
                var nameandvalue=cookiearr[i];

                if(nameandvalue.indexOf(name)!=-1){
                    var values=decodeURIComponent(nameandvalue.substring(nameandvalue.indexOf("=")+1,nameandvalue.length));

                    var arr=new Array();
                    arr=values.split("---");

                    $.each(arr,function(i,e){
                        $('#historySearch').append('<li class="item-content" ><div class="item-inner">' +
                                '<div class="item-title"><a href="javascript:void(null)" class="history">'+e+'</a></div></div></li>');
                    })

                }
            }
        }
    }
</script>
<#--</body>-->
<#--</html>-->
