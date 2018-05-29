<!DOCTYPE html>
<html>
<head>
<#assign basePath=request.contextPath>
    <meta charset="UTF-8">
    <title>会员中心 - 地址管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta content="telephone=no" name="format-detection">
    <link rel="stylesheet" href="${basePath}/css/style.min.css"/>
    <link rel="stylesheet" href="${basePath}/css/v2/my_account_address_list.css">
    <link rel="stylesheet" href="${basePath}/css/ui-dialog.css">
    <link rel="stylesheet" href="${basePath}/css/tip-newbox.css">
    <script src="${basePath}/js/jquery-1.10.1.js"></script>
    <script src="${basePath}/js/idangerous.swiper.js"></script>
    <script src="${basePath}/js/appfont.js"></script>
    <script src="${basePath}/js/dialog-min.js"></script>
    <script src="${basePath}/js/tip-newbox.js"></script>

</head>
<body>
<#assign vtitle="地址管理" />
<#if mainAddress??&& mainAddress=='1'>
    <#assign backUrl="${basePath}/customercenter.html" />
<#else>
    <#assign backUrl="${basePath}/intoPage.htm?pageName=member/mysetting" />
</#if>

<#include "../common/head_back.ftl"/>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script>
    var localUrl = window.location.href;
    $(function(){
        $.ajax({
            url: "${basePath}/queryWxConfig.htm",
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
        /*wx.onMenuShareAppMessage({
            title: '<%=shareTitle %>',
            desc: '<%=shareContent %>',
            link: '<%=currentUrl %>',
            imgUrl: '<%=shareImageUrl %>'
        });*/

        wx.onMenuShareTimeline({
            title: '中国960官方商城',
            link: 'http://m.ge960.com/',
            imgUrl: 'http://boss.ge960.com:80/upload/20170327/1490602121555.jpg'
        });
    })
</script><#--自定义分享到朋友圈-->

<#if addresses?size!=0>

    <#list addresses as address>
<#--&lt;#&ndash;第一种社区店情况&ndash;&gt;-->

<div class="con">
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
        <div class="operate">
            <#--<a href="javascript:void(0);" onclick="doCancel(this,'${address.addressId}')" class="delete">删除</a>-->
            <a href="${basePath}/toupdateAddress.html?addressId=${address.addressId}&mainAddress=${mainAddress!'2'}" class="edit" style="margin-right:15px;">编辑</a>
            <#if address.isDefault=='1'>
                <a href="javascript:void(0);" class="addr selected" style="margin-left:15px;">默认地址</a>
            <#else>
                <a href="javascript:void(0);" class="addr" onclick="setDefaultAddress('${address.addressId}',this)" style="margin-left:15px;">设为默认</a>
            </#if>
                <input type="hidden" name="addressId" value="${address.addressId}">
            <div class="clearfixed"></div>
        </div>
    </a>
</div>

</#list>
<#else>
<div class="content" id="no">
    <div class="no_tips">
        <p>您尚未添加个人收货地址</p>
    </div>
</div>

</#if>
<div class="bottom-fixed p10 mb50" style="margin-bottom: 0;">
    <a href="javascript:;" class="btn btn-full" onclick="mychecknum()">新增收货地址</a>
</div>

<script>
    var tip = myAlertStr();
    function mychecknum() {
        var num = $("#mynum").val();
        if (num>=10) {
            /*$('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>收货地址最多10个</h3></div></div>');
            setTimeout(function(){
                $('.tip-box').remove();
            },1000);*/
            tip("收货地址最多10个");
        }else
        {
            window.location.href ="${basePath}/toAddAddress.html?mainAddress=${mainAddress!'2'}";
        }
    }

    function doCancel(obj,id){
        var discountBox = dialog({
            width: 260,
            title: '删除地址',
            content: "确定删除该收货地址吗？",
            okValue: '确定',
            cancelValue: '取消',
            ok: function () {
                $.ajax({
                    url:"${basePath}/delAddress.html?addressId="+id,
                    type:"post",
                    success:function(data){
                        if(data == 1){
                            /*setTimeout(function () {
                                $('.tip-box').remove();
                                $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><i class="success"></i><h3>地址删除成功！</h3></div></div>');
                            }, 10);*/
                            tip("地址删除成功");
                            setTimeout(function () {
                               // $(".tip-box").hide();
                                location.reload();
                            }, 1000)
                            return true;
                        }else{
                            window.location.href = "${basePath}/loginm.html";
                        }
                    }
                });
            },
            cancel: function () {
                return true;
            }
        });
        discountBox.showModal();
    };

    function setDefaultAddress(id,obj) {

        defaultAdress = dialog({
            width: 260,
            title: '提示',
            content: "确定设置为默认地址吗？",
            okValue: '确定',
            cancelValue: '取消',
            ok: function () {
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
                            $('<a href="javascript:void(0);" class="addr selected" style="margin-left:15px;">默认地址</a>').insertAfter($(obj));
                            var $sel = $(obj).parents('.con').siblings().find(".selected");
                            var addressId = $(obj).parents('.con').siblings().find(".selected").next("input[name=addressId]").val();
                            $('<a href="javascript:void(0);" class="addr" onclick="setDefaultAddress('+addressId+',this)" style="margin-left:15px;">设为默认</a>').insertAfter($sel);
                            $sel.remove();
                            $(obj).remove();
                            /* setTimeout(function () {
                                 //$(".tip-box").hide();
                                 //location.reload();
                             }, 1000)*/
                            return true;
                        }else{
                            window.location.href = "${basePath}/loginm.html";
                        }
                    }
                });
            },
            cancel: function () {
                return true;
            }
        });
        defaultAdress.showModal();

    }

    function doCancel(obj,id){
        var discountBox = dialog({
            width: 260,
            title: '删除地址',
            content: "确定删除该收货地址吗？",
            okValue: '确定',
            cancelValue: '取消',
            ok: function () {
                $.ajax({
                    url:"${basePath}/delAddress.html?addressId="+id,
                    type:"post",
                    success:function(data){
                        if(data == 1){
                           /* setTimeout(function () {
                                $('.tip-box').remove();
                                $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><i class="success"></i><h3>地址删除成功！</h3></div></div>');
                            }, 10);*/
                           tip("地址删除成功");
                            setTimeout(function () {
                               // $(".tip-box").hide();
                                location.reload();
                            }, 1000)
                            return true;
                        }else{
                            window.location.href = "${basePath}/loginm.html";
                        }
                    }
                });
            },
            cancel: function () {
                return true;
            }
        });
        discountBox.showModal();
    };

    $("#icon-option").on("click",function(){
        mychecknum();
    });
    $(".item-title-ress .show").on("click",function(){
        $(this).parents(".con").find(".moreinfo").toggle();
        $(this).find("span").hasClass("change")?$(this).html("<span class=''></span>展开"):$(this).html("<span class='change'></span>收起");
    })
//    $(".operate .addr").on("click",function(){
//        if(!$(this).hasClass("selected")){
//            $(".operate .addr").removeClass("selected").html("设为默认");
//            $(this).addClass("selected");
//            $(this).html("默认地址");
//        }
//    })
</script>
</body>
</html>