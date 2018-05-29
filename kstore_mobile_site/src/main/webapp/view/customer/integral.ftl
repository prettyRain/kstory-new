<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>会员中心 - 我的积分</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <meta name="keywords" content="${(seo.meteKey)!''}">
  <meta name="description" content="${(seo.meteDes)!''}">
  <meta content="telephone=no" name="format-detection">
  <#assign basePath=request.contextPath>
  <link rel="stylesheet" type="text/css" href="${basePath}/css/style.css"/>
  <link rel="stylesheet" type="text/css" href="${basePath}/css/v2/integral.css"/>
  <script src="${basePath}/js/jquery-1.10.1.js"></script>
  <script src="${basePath}/js/idangerous.swiper.js"></script>
    <style>
        .vheader img{
            width: 10px!important;
            height: 16px!important;
            margin-left: 10px!important;
        }
    </style>
</head>
<body>
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
<#assign vtitle="我的积分" />
<#assign backUrl="${basePath}/customercenter.html" />
<#include "../common/head_back.ftl"/>
<div class="my_balance member_box">
    <div class="cover">
        <div>
            <h2>${(customer.infoPointSum)!'0'}</h2>
            <p><i></i>&nbsp;&nbsp;当前积分&nbsp;&nbsp;<i></i></p>
        </div>
    </div>
</div>

<div class="income_details member_box">
  <#--<h2>收支明细</h2>-->
  <div class="tabs row">
    <!--<a href="${basePath}/customer/myintegral.html" <#if !type??>class="active"</#if>>全部</a>
    <a href="#" <#if type?? && type=='1'>class="active"</#if>>收入</a>
    <a href="#" <#if type?? && type=='0'>class="active"</#if>>支出</a>-->
    <a href="#" data-val='' class="active">全部</a>
    <a href="#" data-val='1'>收入</a>
    <a href="#" data-val='0'>支出</a>
  </div>
  <!--<div class="swiper-container">
    <div class="swiper-wrapper">
      <div class="swiper-slide">-->
        <div class="content-slide">
          <div class="income_list" id="items">

              <#--<div class="income_info">-->
                  <#--<p>登录赠送</p>-->
                  <#--<p>+1</p>-->
                  <#--<p>2017-10-31 13:06:26</p>-->

              <#--</div>-->


          <#if (pb.list?size!=0)>
              <#list pb.list as point>
                  <#if point.point!=0 && point.point??>
                      <div class="income_info">
                          <p>
                          <#--${(point.pointDetail)!''}-->
                          <#if point.pointDetail=="订单取消返还订单使用积分">
                              返还使用积分
                          <#elseif point.pointDetail=="扣除订单消费系统赠送积分">
                              扣除消费赠送积分
                          <#else>
                            ${(point.pointDetail)!''}
                          </#if>
                          </p>
                          <p>
                              <#if point.pointType??>
                                  <#if point.pointType=='1'>
                                      +${point.point}
                                  <#else>
                                      -${point.point}
                                  </#if>
                              </#if>
                            </p>
                          <p>${point.createTime?string("yyyy-MM-dd HH:mm:ss")}</p>

                      </div>
                  </#if>
              </#list>
          </#if>
          </div>
        </div>
	    <div class="list-loading" style="display:none" id="showmore">
	        <img alt="" src="${basePath}/images/loading.gif">
	        <span>加载中……</span>
	    </div>
	    <#if !pb?? ||  (pb.list?size=0)>
	    <div class="no_tips" id="no">
	     <p>木有积分哦</p>
	    </div>
	   </#if>
      </div>
     
 
  <input id="type" type="hidden" value="${(type)!''}" /> 
  <input id="basePath" type="hidden" value="${basePath}" />
 <input id="status" value="0" type="hidden">

<script>
    $(".bar-bottom  a").removeClass("selected");
    $(".bar-bottom:eq(0) a:eq(3) ").addClass("selected");
  $(".tabs a").on('touchstart mousedown',function(e){
    e.preventDefault();
    $(".tabs .active").removeClass('active');
    $(this).addClass('active');
    $(this).attr("data-val");
    $("#type").val($(this).attr("data-val"))
    showType();
  });
  $(".tabs a").click(function(e){
    e.preventDefault();
  })

    $(".vheader .back img").attr({"src":"/images/v2/my-back.png"})
</script>
</body>
<script src="${basePath}/js/customer/integral.js"></script>
<script src="${basePath}/js/dataformat.js"></script>
</html>