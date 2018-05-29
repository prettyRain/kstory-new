<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>订单-评价</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="keywords" content="${(seo.meteKey)!''}">
    <meta name="description" content="${(seo.meteDes)!''}">
    <meta content="telephone=no" name="format-detection">
    <#assign basePath=request.contextPath>
    <link rel="stylesheet" href="${basePath}/css/style.min.css"/>
    <script src="${basePath}/js/jquery-1.10.1.js"></script>
    <script src="${basePath}/js/pageAction.js"></script>
    <style>
        body{font-family:微软雅黑,Microsoft yahei;}
        body, html,.success_info {  background: #eee;  }
        .success_info {  padding: 111px 0 0 0;  }
        .success_info .success_icon {  width: 295px;  height: 193px;  margin: 0 auto;  background: url(../images/v2/pjsuccess@2x.png) no-repeat;  background-size: 100% 100%;  }
        .success_info p{  text-align: center;  font-size: 14px;  }
        .success_info p:nth-of-type(1){  color: #666;  margin-top: 25px;  font-size: 20px;  font-weight: 600;  letter-spacing: 1px;  }
        .success_info p:nth-of-type(2) a{  margin: 0 auto;  margin-bottom: 30px;  margin-top: 50px;  }
        .success_info .evaluate{  width:181px;  height:31px;  line-height:31px;  display: block;  margin: 0 auto;  border-radius: 30px;  text-decoration: none;  margin-bottom: 30px;  margin-top: 50px;  color: #fff;
            filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#0ead00',endColorstr='#0d9901',GradientType='1');
            background:-webkit-linear-gradient(left,#0ead00,#0d9901);
            background: -o-linear-gradient(left,#0ead00,#0d9901);
            background: -moz-linear-gradient(left,#0ead00,#0d9901);
            background: linear-gradient(left,#0ead00,#0d9901);
            border:none;
        }
        .success_info .back{  width:181px;  height:31px;  line-height:30px;  display: block;  margin: 0 auto;  border-radius: 30px;  color: #199301;  background: #eee;  text-decoration: none;  border:1px solid #199301;  }
    </style>
</head>
<body>
<div class="container">
    <div class="success_info">
        <div class="success_icon"></div>
        <p>评价成功</p>
        <#if isContinue?? && (isContinue>0)>
            <p><a class="evaluate" href="/customer/myorder-4-1.html">继续评价</a></p>
        </#if>
        <p><a class="back" href="/customer/myorder.html">返回我的订单</a></p>
    </div>
</div>




<#--<input type="hidden" id="basePath" value="${basePath}">-->
<#--<#assign vtitle="q评价商品" />-->
<#--<#assign backUrl="${basePath}/comment-${good.orderId}.html" />-->
<#--<#include "/common/head_back.ftl"/>-->
<#--<div class="order">-->
    <#--<div class="order-common">-->
    <#--<div class="order-info">-->
    <#--<div class="list-body-line">-->
    <#--<#if good??>-->
        <#--<form role="form" id="commForm" action="${basePath}/addgoodscomment.htm" method="post">-->
            <#--<input name="goodsId" value="${(good.goodsId)!''}" type="hidden" />-->
            <#--<input name="orderGoodsId" value="${(good.orderGoodsId)!''}" type="hidden" />-->
            <#--<input name="customerId" value="${(cusId)!''}" type="hidden" />-->
            <#--<input name="orderId" value="${(good.orderId)!''}" type="hidden" id="orderId"/>-->
            <#--<input name="isAnonymous" value="1" type="hidden" id="isnoname"/>-->
            <#--<div class="list-item">-->
                <#--<div class="pro-item">-->
                    <#--<a href="${basePath}/item/${good.goodsId}.html">-->
                        <#--<div class="propic">-->
                            <#--<img alt="${good.goodsName}" src="${good.goodsImg}" width="78" height="78" />-->
                        <#--</div>-->
                        <#--<div class="prodesc">-->
                            <#--<h3 class="title">${(good.goodsName)!''}</h3>-->

                            <#--<p class="price">¥&nbsp;<span class="num" style="display: inline;">-->
                                <#--<#if good.goodsPrice??>-->
									<#--${good.goodsPrice?string('0.00')}-->
								<#--</#if></span></p>-->
                        <#--</div>-->
                <#--</div>-->
            <#--</div>-->
            <#--</a>-->
    <#--</div>-->
    <#--</div>-->
        <#--<div class="list-item common-box">-->
            <#--<h3 class="item-head">评分-->
                <#--<div class="star">-->
                    <#--<#if !good.evaluateFlag?? || good.evaluateFlag=='0'>-->
                        <#--<div class="star5"></div>-->
                    <#--<#else> <div class="star${(good.commentScore)!'5'}"></div>-->
                    <#--</#if>-->
                    <#--<div class="star-btn">-->
                        <#--<a href="javascript:;" data-star="1"></a>-->
                        <#--<a href="javascript:;" data-star="2"></a>-->
                        <#--<a href="javascript:;" data-star="3"></a>-->
                        <#--<a href="javascript:;" data-star="4"></a>-->
                        <#--<a href="javascript:;" data-star="5"></a>-->
                    <#--</div>-->
                <#--</div>-->
            <#--</h3>-->
            <#--<input type="hidden" name="commentScore"  id="commentScore" value="5"/>-->
            <#--<div class="edit-box">-->
                <#--<#if !good.evaluateFlag?? || good.evaluateFlag=='0'>-->
                    <#--<textarea style="color: #aeaeae" name="commentContent" id="complaincon" cols="30" rows="4" maxlength="150"-->
                              <#--onFocus="if (value =='说说你对它的想法和使用心得吧~'){value ='';this.style.color='#363636'}"-->
                              <#--onBlur="if (value ==''){value='说说你对它的想法和使用心得吧~';this.style.color='#aeaeae'}">说说你对它的想法和使用心得吧~</textarea>-->
                <#--<#else>-->
                    <#--<span>${(good.commentContent)!''}</span>-->
                <#--</#if>-->
            <#--</div>-->
            <#--<label class="pull-left" id="commTip">&nbsp;</label>-->
        <#--</div>-->
        <#--<h3 class="niming"><i class="select-box <#if !(good.isAnonymous)?? ||((good.isAnonymous)?? && good.isAnonymous='1')>selected</#if>"></i>匿名评价</h3>-->
        <#--</form>-->
    <#--</#if>-->
    <#--<#if !(good.evaluateFlag)?? || good.evaluateFlag=='0'>-->
        <#--<div class="list-item bottom-full">-->
            <#--<a class="btn btn-full" href="javascript:void(0);" onclick="checkComment()">提&nbsp;交</a>-->
        <#--</div>-->
    <#--</#if>-->
    <#--</div>-->
<#--</div>-->

</body>
<#--<script>-->
    <#--<#if !(good.evaluateFlag)?? || good.evaluateFlag=='0'>-->
    <#--$(function(){-->
        <#--$('.star-btn a').click(function(){-->
            <#--var starNum = parseInt($(this).attr('data-star'));-->
            <#--$('.star>div:first-child').attr('class',('star' + starNum));-->
            <#--$("#commentScore").val(starNum);-->
        <#--});-->

        <#--$(".select-box").click(function(){-->
            <#--if($(this).hasClass("selected")){-->
                <#--$(this).removeClass("selected");-->
                <#--$("#isnoname").val(0);-->
            <#--}else{-->
                <#--$(this).addClass("selected");-->
                <#--$("#isnoname").val(1);-->
            <#--}-->
        <#--});-->
    <#--});-->
    <#--</#if>-->
<#--</script>-->
</html>