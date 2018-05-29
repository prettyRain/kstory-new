<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>商品评价</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <#assign basePath=request.contextPath>
    <link rel="stylesheet" href="${basePath}/css/style.min.css"/>
    <script src="${basePath}/js/jquery-1.10.1.js"></script>
    <style>
        /*bug324*/
        body, html {  background-color: #ffffff;  font-family:微软雅黑,Microsoft yahei;}
        .common .list-item .star{position:absolute;top:12px;left:60px}
        .content-common .common .list-item .user-item{position:relative;right:0;top:0;font-size: 14px;
            color: #7f7f7f;}
        .common .list-item .user-item span:first-of-type{
            position:absolute;left:0;top:0;

        }
        .content-common .common .list-item .text {
            font-size: 12px;
            color: #000;
            line-height: 18px;
            margin: 10px 0 0 0;
        }
        .content-common .common .list-item{
            padding:16px 0;
            margin:0 14px;
            border-top: 1px solid #eee;
            border-bottom: none;
        }
        .common .list-item .user-item span:last-of-type{position:absolute;right:0;top:0}
        .pro-details-top a.back{
            background: none;
            width: 22px;
            height:22px;
            left: 7px;
        }
        .comment{
            position: absolute;
            width:100%;
            text-align: center;
            height: 52px;
            line-height: 48px;
            color: #000;
            background: #fff;
            font-size: 18px;
            border-bottom: 1px solid #eee;
        }
        .bar-top .bar-item{border-bottom: none;}
        .mt10 {  margin-top: 0;  }
        .bar-top {top: 52px;    border-bottom: 1px solid #eee;}
        .content-common {
            padding-top: 100px;
        }
        .bar-top.common .bar-item{ width:25%;}
        .ion-ios-arrow-left:before {
            color: transparent;
            width: 22px;
            height:22px;
            background:  url(../../images/icon_v1.0/back_ios@2x.png) no-repeat left center;
            background-size: 22px 22px;

        }
        .bar-top.common {
            height: 49px;
        }
        .bar-top.common .bar-item {
            width: 25%;
            height: 49px;
            line-height: 22px;
            padding: 5px 0 7px 0;
            font-size: 15px;
        }
        .bar-top.common .bar-item span.num {
            font-size: 12px;
            color: #7f7f7f!important;
            line-height: 18px;

        }

        .bar-top .bar-item.active {
            color: #199301;
        }
        .bar-top.common b {
            position: absolute;
            bottom: 0;
            left: 7%;
            width: 11%;
            height: 2px;
            background-color: #199301;
        }
        .content-common .common .all-evaluate{
            width:100%;
            height: 45px;
            line-height: 45px;
            text-align: center;
            color: #999;
            font-size: 12px;
            margin: 0;
            border-top: 1px solid #eee;
        }
        .star {
            position: relative;
            width: 70px;
            height: 25px;
        }

        .star .star1, .star .star2, .star .star3, .star .star4, .star .star5 {
            height: 25px;
            background:url(../images/star.png) no-repeat;
        }
        .star .star5 {  width: 70px;  }
        .star .star4 {  width: 56px;  }
        .star .star3 {  width: 42px;  }
        .star .star2 {  width: 28px;  }
        .star .star1 {  width: 14px;  }


        .star .star1, .star .star2 {
            -webkit-background-size: 140px 14px;
            background-size: 140px 14px;
        }

        .star .star1 {
            background-position: 0 6px;
            -webkit-background-size: 140px 14px;
            background-size: 140px 14px;
        }

        .star .star2 {
            background-position: 0 6px;
            -webkit-background-size: 140px 14px;
            background-size: 140px 14px;
        }

        .star .star3, .star .star4 {
            -webkit-background-size: 140px 14px;
            background-size: 140px 14px;
        }

        .star .star3 {
            background-position: 0 6px;
            -webkit-background-size: 140px 14px;
            background-size: 140px 14px;
        }

        .star .star4 {
            background-position: 0 6px;
            -webkit-background-size: 140px 14px;
            background-size: 140px 14px;
        }

        .star .star5 {
            background-position: 0 6px;
            -webkit-background-size: 140px 14px;
            background-size: 140px 14px;
        }

        .star .star-btn {
            position: absolute;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%
        }

        .star .star-btn:after {
            content: '';
            display: block;
            clear: both
        }

        .star .star-btn a {
            display: block;
            float: left;
            width: 30px;
            height: 25px
        }

    </style>
</head>
<body>
<div class="pro-details-top">
    <a href="javascript:history.back();" class="back">
        <i class="ion-ios-arrow-left"></i>
    </a>
    <div class="comment">商品评价</div>
</div>
<div class="bar-top common">
    <input type="hidden" id="basePath" value="${basePath}"/>
    <input type="hidden" id="productId" value="${productId}"/>
    <a class="bar-item active haopingall">全部<span class="num" id="haopingall"></span></a>
    <a class="bar-item haoping">好评<span class="num" id="haoping"></span></a>
    <a class="bar-item zhongping">中评<span class="num" id="zhongping"></span></a>
    <a class="bar-item chaping">差评<span class="num" id="chaping"></span></a>
    <#--<a class="bar-item">有图<span class="num">2345</span></a>-->
    <b></b>
</div>
<div class="content-common">
    <div class="common mt10" id="commentBody">

    </div>
</div>
<script src="${basePath}/js/goods/pro_common.js"></script>

<script>
    $(function(){
        $('.commonpic ul').width($('.commonpic ul li').width()*$('.commonpic ul li').length)
        loadComment(1,4)
    })
</script>
</body>
</html>