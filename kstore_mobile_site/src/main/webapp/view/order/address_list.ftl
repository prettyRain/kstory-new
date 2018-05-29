<!DOCTYPE html>
<html lang="en">
<head>
<#assign basePath=request.contextPath>
    <meta charset="UTF-8">
    <title>订单确认-选择收货地址</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <link rel="stylesheet" href="${basePath}/css/style.min.css">
    <link rel="stylesheet" href="${basePath}/css/v2/address_list.css">
    <link rel="stylesheet" href="${basePath}/css/v2/my_account_address_list.css">
    <link rel="stylesheet" href="${basePath}/css/tip-newbox.css">
    <script src="${basePath}/js/jquery-1.10.1.js"></script>
    <script src="${basePath}/js/tip-newbox.js"></script>

</head>
<body>
<#assign vtitle="收货地址" />
<#assign backUrl="${basePath}/order/suborder.html" />
<#include "../common/head_back.ftl"/>
<input type="hidden" value="${addressType}" id="addressType">
<div class="order content-order-confirm">
    <div class="chose-receive-info">

    <#if addresses??>
        <input type="hidden" value="${addresses?size}" id="mynum">
    </#if>
    <#if addresses??&&addresses?size!=0>
        <#list addresses as address>
        <div class="con checkaddr">
            <input class="select-box1" type="hidden" value="${address.addressId}"/>
            <a href="javascript:void(0);">
                <div class="warp">
                    <div class="item-title-top">
                        <div class="left">
                            <span>${address.addressName!''}</span>
                        </div>
                        <div class="right">
                            <span>${address.addressMoblie!''}</span>
                        </div>
                        <div class="clearfixed"></div>
                    </div>
                    <div class="address">${address.province.provinceName!''}${address.city.cityName!''}${address.district.districtName!''}
            <#if address.street??>${address.street.streetName!''}</#if>${address.addressDetail!''}</div>
                    <#if address.communityStore??&& address.addressType=='1'>
                        <div class="item-title-ress">
                            <div class="community">${address.communityStore.communityStoreName}</div>
                        <#--<div class="show"><span class=""></span>展开</div>-->
                            <div class="clearfixed"></div>
                        </div>
                        <ul class="moreinfo">
                            <li>${address.communityStore.province.provinceName} ${address.communityStore.city.cityName} ${address.communityStore.district.districtName} ${address.communityStore.communityStoreAddress} </li>
                            <li>${address.communityStore.contact} ${address.communityStore.contactMobile}</li>
                        </ul>
                    </#if>
                </div>
                <#--window.location.href ="${basePath}/toAddAddress.htm?flag=1&addressType="+$("#addressType").val();-->
                <div class="operate">
                <#--<a href="javascript:void(0);" onclick="doCancel(this,'${address.addressId}')" class="delete">删除</a>-->
            <#if address.communityStore??&& address.addressType=='1'>
                <a href="${basePath}/toupdateAddress.html?addressId=${address.addressId}&flag=1&addressType=1" class="edit" style="margin-right:15px;">编辑</a>
            <#else>
                <a href="${basePath}/toupdateAddress.html?addressId=${address.addressId}&flag=1&addressType=" class="edit" style="margin-right:15px;">编辑</a>
            </#if>
                    <#if address.isDefault=='1'>
                        <a href="javascript:void(0);" class="addr selected" style="margin-left:15px;visibility: hidden;">默认地址</a>
                    <#else>
                        <a href="javascript:void(0);" class="addr" onclick="setDefaultAddress('${address.addressId}',this)" style="margin-left:15px;visibility: hidden;">设为默认</a>
                    </#if>
                    <input type="hidden" name="addressId" value="${address.addressId}">
                    <div class="clearfixed"></div>
                </div>
            </a>
        </div>
            <#--<div class="list-item">-->
                <#--<div class="checkaddr">-->
                    <#--<i class="select-box <#if address.isDefault=='1'>selected</#if>" style="visibility: hidden;"></i>-->
                    <#--<input type="hidden" value="${address.addressId}"/>-->
                    <#--<h3><span class="name">${address.addressName!''}</span></h3>-->
                    <#--<p class="phoneNum">${address.addressMoblie!''}</p>-->
                    <#--<p class="dress-info">${address.province.provinceName}${address.city.cityName}${address.district.districtName}${address.addressDetail}</p>-->
                    <#--<#if address.communityStore??&& address.addressType=='1'>-->
                        <#--<p class="dress-info community">${address.communityStore.communityStoreName}</p>-->
                        <#--<p class="dress-info" style="visibility: hidden;display: none">地&nbsp;址：${address.communityStore.province.provinceName} ${address.communityStore.city.cityName} ${address.communityStore.district.districtName} ${address.communityStore.communityStoreAddress}</p>-->
                        <#--<p class="dress-info" style="visibility: hidden;display: none"">联系人：${address.communityStore.contact} ${address.communityStore.contactMobile}</p>-->
                        <#--<p class="dress-info"></p>-->
                    <#--</#if>-->
                <#--</div>-->
                <#--<i class="edit" style="visibility: hidden;" onclick="window.location='${basePath}/toupdateAddress.htm?addressId=${address.addressId}&flag=1'"></i>-->
            <#--</div>-->
        </#list>
    <#else>
        <div class="no_tips">
            <#if (addressType == '0')>
                <p>您尚未添加个人收货地址</p>
                <#else>
                <p>您尚未添加社区服务中心收货地址</p>
                    <span style="display: inline-block;width: 100%;text-align: center;color: #199301;margin: 10px 0 0 0;font-size: 14px;">什么是社区服务中心？</span>
            </#if>
        </div>
        <#--<div class="list-item bottom-full">-->
            <#--<a class="btn btn-full" onclick="mychecknum()" href="javascript:;"><i></i>新增收货地址</a>-->
        <#--</div>-->
    </#if>


        <form id="subForm" method="post">
            <input type="hidden" name="addressId" id="addressId">
        </form>


    </div>
</div>
<div class="bottom-fixed p10 mb50" style="margin-bottom: 0;">
    <a href="javascript:;" class="btn btn-full" onclick="mychecknum()">新增收货地址</a>
</div>



<div class="warpbg">
</div>
<div class="warptip">
    <div style="position: relative;">
        <img src="${basePath}/images/v2/blank_backgroud@2x.png" alt="">
        <div class="info">
            <p>
                您本次购买的商品为零售商品，接下来我们将配送至您所选择的社区店，以供您自提。当然，您也可以选择送货上门，社区店的工作人员会将商品送至您的家门口。
            </p>
        </div>
    </div>
    
    <span class="info_close"><img src="${basePath}/images/v2/btn_close_pre@2x.png" alt=""></span>
</div>
</body>
<script src="${basePath}/js/jquery-1.11.1.min.js"></script>
<script>
    var tip = myAlertStr();
    $(function(){
        $(".checkaddr").click(function(){
            $("#addressId").val($(this).find(".select-box1").val());
            $("#subForm").attr("action","${basePath}/changeAddress.htm").submit();
        })
    })

    function mychecknum() {
        var num = $("#mynum").val();
        if (num>=10) {
           /* $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>收货地址最多10个</h3></div></div>');
            setTimeout(function(){
                $('.tip-box').remove();
            },1000);*/
           tip("收货地址最多10个");
        }else
        {
            window.location.href ="${basePath}/toAddAddress.htm?flag=1&addressType="+$("#addressType").val();
        }

    }
    $("#icon-option").on("click",function(){
        mychecknum();
    });
    $(".no_tips span").on("click",function(){
        $(".warpbg").show();
        $(".warptip").show();
        $(".bottom-fixed").hide();
    });
    $(".warptip .info_close").on("click",function(){
        $(".warpbg").hide();
        $(".warptip").hide();
        $(".bottom-fixed").show();
    });


    function setDefaultAddress(id,obj) {
        $.ajax({
            url:"${basePath}/setDefaultAddress.htm?addressId="+id,
            type:"post",
            success:function(data){
                if(data == 1){
                    /* setTimeout(function () {
                         $('.tip-box').remove();
                         $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><i class="success"></i><h3>修改默认地址成功！</h3></div></div>');
                     }, 50);*/
                    tip("修改默认地址成功");
                   /* setTimeout(function () {
                        //$(".tip-box").hide();
                        location.reload();
                    }, 1000)*/
                    $('<a href="javascript:void(0);" class="addr selected" style="margin-left:15px;">默认地址</a>').insertAfter($(obj));
                    var $sel = $(obj).parents('.con').siblings().find(".selected");
                    var addressId = $(obj).parents('.con').siblings().find(".selected").next("input[name=addressId]").val();
                    $('<a href="javascript:void(0);" class="addr" onclick="setDefaultAddress('+addressId+',this)" style="margin-left:15px;">设为默认</a>').insertAfter($sel);
                    $sel.remove();
                    $(obj).remove();
                    return true;
                }else{
                    window.location.href = "${basePath}/loginm.html";
                }
            }
        });
    }



    (function (doc, win) {
        var docEl = doc.documentElement,
                resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
                recalc = function () {
                    var clientWidth = docEl.clientWidth;
                    if (!clientWidth) return;
                    docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
                };
        if (!doc.addEventListener) return;
        win.addEventListener(resizeEvt, recalc, false);
        doc.addEventListener('DOMContentLoaded', recalc, false);
    })(document, window);
</script>
</html>