<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>订单-评价晒单</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="keywords" content="${seo.meteKey}">
    <meta name="description" content="${seo.meteDes}">
    <#assign basePath=request.contextPath>
    <link rel="stylesheet" href="${basePath}/css/style.min.css"/>
    <script src="${basePath}/js/jquery-1.10.1.js"></script>
    <script src="${basePath}/js/pageAction.js"></script>
	<style>
		html,body{
			background: #eee;
            font-family:微软雅黑,Microsoft yahei;
		}
		.order .title{
            height:45px;
            line-height:40px;
            border-top:5px solid #eee;
            color: #333;
			font-size: 14px;
            text-align: center;
			background: #fff;
		}
        .order textarea{
            border:none;
			border-radius: 0;
            background: #f8f8f8;
            resize : none;
            font-size: 14px;
		}
        .order .starwarp{
            height:40px;
			line-height:40px;
            padding: 8px 0 0 0;
			background: #fff;
		}
        .order .starwarp .star{
            margin: 0 auto;
		}
        .star {
            position: relative;
            width: 153px;
            height: 25px;
        }

        .star .star1, .star .star2, .star .star3, .star .star4, .star .star5 {
            width: 153px;
            height: 25px;
            background:url(../images/star.png) no-repeat;
        }

        .star .star1, .star .star2 {
            -webkit-background-size: 300px 30px;
            background-size: 300px 30px;
        }

        .star .star1 {
            background-position: -120px -3px;
            -webkit-background-size: 300px 30px;
            background-size: 300px 30px;
        }

        .star .star2 {
            background-position: -90px -3px;
            -webkit-background-size: 300px 30px;
            background-size: 300px 30px;
        }

        .star .star3, .star .star4 {
            -webkit-background-size: 300px 30px;
            background-size: 300px 30px;
        }

        .star .star3 {
            background-position: -60px -3px;
            -webkit-background-size: 300px 30px;
            background-size: 300px 30px;
        }

        .star .star4 {
            background-position: -30px -3px;
            -webkit-background-size: 300px 30px;
            background-size: 300px 30px;
        }

        .star .star5 {
            background-position: 0 -3px;
            -webkit-background-size: 300px 30px;
            background-size: 300px 30px;
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

        .list-item {
            position: fixed;
            bottom: 0;
            width: 100%;
            padding: 0;
            border-bottom: 1px solid #ececec;
            background-color: #fff;
        }
        .btn-full {
            line-height: 24px;
            border: 1px solid #199301;
            border-radius: 0;
            filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#0ead00',endColorstr='#0d9901',GradientType='1');
            background:-webkit-linear-gradient(left,#0ead00,#0d9901);
            background: -o-linear-gradient(left,#0ead00,#0d9901);
            background: -moz-linear-gradient(left,#0ead00,#0d9901);
            background: linear-gradient(left,#0ead00,#0d9901);
        }
        .order:last-of-type{
            margin-bottom: 100px;
        }

	</style>
</head>
<body>
<input type="hidden" id="basePath" value="${basePath}">
<#assign vtitle="订单评价" />
<#assign backUrl="${basePath}/customer/myorder-4-1.html" />
<#include "/common/head_back.ftl"/>
<div>
<#if order.goods?size!=0>
    <form role="form" id="commForm" action="${basePath}/addgoodscommentBatch.htm" method="post">
        <#list order.goods as good>
            <div class="order">
            <input name="orderId" value="${(order.orderId)!''}" type="hidden" id="orderId"/>
            <input name="customerId" value="${(order.customerId)!''}" type="hidden" />
            <input name="goodsId" value="${(good.goodsId)!''}" type="hidden" />
            <input name="goodsName" value="${(good.goodsName)!''}" type="hidden" />
            <input name="isAnonymous" value="1" type="hidden" id="isnoname"/>
            <input name="orderGoodsId" value="${(good.orderGoodsId)!''}" type="hidden" />
            <div class="title">${(good.goodsName)!''}</div>
            <textarea style="color: #aeaeae" name="commentContent" class="complaincons" cols="30" rows="7" maxlength="500" onfocus="if (value =='给我写一句评价吧！'){value ='';this.style.color='#363636'}" onblur="if (value ==''){value='给我写一句评价吧！';this.style.color='#aeaeae'}">给我写一句评价吧！</textarea>
            <div class="starwarp">
                <div class="star">
                    <div class="mark star5"></div>
                    <div class="star-btn">
                        <a href="javascript:;" data-star="1"></a>
                        <a href="javascript:;" data-star="2"></a>
                        <a href="javascript:;" data-star="3"></a>
                        <a href="javascript:;" data-star="4"></a>
                        <a href="javascript:;" data-star="5"></a>
                    </div>
                    <input type="hidden" name="commentScore"  id="commentScore_${good_index}" value="5"/>
                </div>
            </div>
        </div>
    </#list>
    </form>
</#if>
</div>
<div class="list-item bottom-full">
    <a class="btn btn-full" href="javascript:void(0);" onclick="commentSubmit()">立即评价</a>
</div>



<#--<div class="order">-->
    <#--<div class="order-common">-->
        <#--<div class="wcommon-list">-->
            <#--<div class="order-info">-->
                <#--<div class="list-body-line">-->
                    <#--<#if order.goods?size!=0>-->
			         <#--<#list order.goods as good>-->
	                    <#--<div class="list-item">-->
	                      <#--<a href="${basePath}/item/${good.goodsId}.html">-->
	                        <#--<div class="pro-item">-->
	                            <#--<div class="propic">-->
	                                <#--<img alt="${good.goodsName}" src="${good.goodsImg}" width="60" height="60" />-->
	                            <#--</div>-->
	                            <#--<div class="prodesc">-->
	                                <#--<h3 class="title">${(good.goodsName)!''}</h3>-->
	                                <#--<p class="price">¥&nbsp;<span class="num" style="display: inline;">-->
	                                <#--<#if good.goodsPrice??>-->
										<#--${good.goodsPrice?string('0.00')}-->
									<#--</#if></span></p>-->
	                            <#--</div>-->
	                        <#--</div>-->
	                        <#--</a>-->
		                        <#--<#if !good.evaluateFlag?? || good.evaluateFlag=='0'>-->
	                       		 <#--<a class="btn common-go" href="${basePath}/commentgoods-${(order.orderId)!''}-${(good.goodsId)!''}.html">-->
		                       		 <#--评价-->
		                          <#--<#else>-->
		                          	<#--<a class="btn common-go" href="${basePath}/commentgoods-${(order.orderId)!''}-${(good.goodsId)!''}-${(good.commentId)!''}.html">-->
		                          	<#--已评价-->
		                        <#--</#if>-->
	                       		 <#--</a>-->
	                    <#--</div>-->
			         <#--</#list>-->
			        <#--</#if>-->
                <#--</div>-->
            <#--</div>-->
        <#--</div>-->
    <#--</div>-->
<#--</div>-->
<script src="${basePath}/js/customer/comment.js"></script>
<script>
    $(function(){
        $('.star-btn a').click(function(){
            var starNum = parseInt($(this).attr('data-star'));
            $(this).parents(".star").find(".mark").attr('class',('mark star' + starNum));
            $(this).parent().next("input").val(starNum);
        });
    });
    function commentSubmit() {
        $(".complaincons").each(function () {
            if($(this).val()=="给我写一句评价吧！"){
                $(this).val("用户已对该商品做出评价");
            }
        })
        $('#commForm').submit();
    }
</script>
</body>
</html>














