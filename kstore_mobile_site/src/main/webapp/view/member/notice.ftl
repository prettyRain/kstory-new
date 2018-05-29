<!DOCTYPE html>
<html>
<head>
    <#assign basePath=request.contextPath/>
  <meta charset="UTF-8">
  <title>会员中心 - 我的消息</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <meta content="telephone=no" name="format-detection">
  <link rel="stylesheet" href="${basePath}/css/style.min.css"/>
  <link rel="stylesheet" href="${basePath}/css/v2/notice1.css"/>
  <script src="${basePath}/js/jquery-1.10.1.js"></script>
    <style>
        .common_tabs .col-12 .right span{
            width: 96%;
            overflow: hidden;
            text-overflow:ellipsis;
            white-space: nowrap;
            height: 20px;
        }
        .marginbottom{
            border-bottom: none!important;

        }
    </style>
</head>
<body>

<#assign vtitle="我的消息" />
<#if (mark?? && mark == '0')>
    <#assign backUrl="${basePath}/main.html" />
<#else>
    <#assign backUrl="${basePath}/customercenter.html" />
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
<div class="common_tabs member_box row">

 <#if insideLetterVo.letterTitle?? || orderNotice.noticeTitle??>

     <#if (flag == 0)>
         <#if orderNotice.noticeTitle??>
             <div class="col-12">
                 <#if (mark?? && mark == '0')>
                    <a href="${basePath}/ordernotice.html?mark=0">
                 <#else>
                    <a href="${basePath}/ordernotice.html?mark=1">
                 </#if>
                 <#--<a href="${basePath}/ordernotice.html">-->
                     <div class="left">
                         <img src="${basePath}/images/icon_v1.0/mall@2x.png">
                         <#if (orderNotice.unReadNum > 0)>
                             <i></i>
                         </#if>
                     </div>
                     <div class="right">
                         <p <#if (orderNotice.unReadNum > 0)>style="font-weight: bold;"</#if>>系统通知</p>
                         <span <#if (orderNotice.unReadNum > 0)>style="font-weight: 700;"</#if>>${orderNotice.noticeTitle}</span>
                         <b>${orderNotice.createTime?string('yyyy-MM-dd')}</b>
                     </div>
                 </a>
             </div>
         </#if>

         <#if insideLetterVo.letterTitle??>
             <div class="col-12">
                 <#if (mark?? && mark == '0')>
                    <a href="${basePath}/adminnotice.html?mark=0">
                 <#else>
                    <a href="${basePath}/adminnotice.html?mark=1">
                 </#if>
                 <#--<a href="${basePath}/adminnotice.html">-->
                     <div class="left">
                         <img src="${basePath}/images/icon_v1.0/system@2x.png">
                         <#if (insideLetterVo.unReadNum > 0)>
                             <i></i>
                         </#if>
                     </div>
                     <div class="right">
                         <p <#if (insideLetterVo.unReadNum > 0)>style="font-weight: bold;"</#if>>商城消息</p>
                         <span <#if (insideLetterVo.unReadNum > 0)>style="font-weight: 700;"</#if>>${insideLetterVo.letterTitle}</span>
                         <b>${insideLetterVo.createTime?string('yyyy-MM-dd')}</b>
                     </div>
                 </a>
             </div>
         </#if>
     <#else>
         <#if insideLetterVo.letterTitle??>
             <div class="col-12">
                 <a href="${basePath}/adminnotice.html">
                     <div class="left">
                         <img src="${basePath}/images/v2/icon_tongzhi@2x.png">
                         <#if (insideLetterVo.unReadNum > 0)>
                             <i></i>
                         </#if>
                     </div>
                     <div class="right" >
                         <p <#if (insideLetterVo.unReadNum > 0)>style="font-weight: bold;"</#if>>商城消息</p>
                         <span <#if (insideLetterVo.unReadNum > 0)>style="font-weight: 700;"</#if>>${insideLetterVo.letterTitle}</span>
                         <b>${insideLetterVo.createTime?string('yyyy-MM-dd')}</b>
                     </div>
                 </a>
             </div>
         </#if>
         <#if orderNotice.noticeTitle??>
             <div class="col-12">
                 <a href="${basePath}/ordernotice.html">
                     <div class="left">
                         <img src="${basePath}/images/v2/icon_xiaoxi@2x.png">
                         <#if (orderNotice.unReadNum > 0)>
                             <i></i>
                         </#if>
                     </div>
                     <div class="right">
                         <p <#if (orderNotice.unReadNum > 0)>style=" font-weight: bold;"</#if>>系统通知</p>
                         <span <#if (orderNotice.unReadNum > 0)>style="font-weight: 700;"</#if>>${orderNotice.noticeTitle}</span>
                         <b>${orderNotice.createTime?string('yyyy-MM-dd')}</b>
                     </div>
                 </a>
             </div>
         </#if>
     </#if>
<#else>
    <div class="no_tips">
        <p>暂无消息</p>
    </div>
    </#if>
</div>
<script>
    $('.right:last').addClass("marginbottom");
    $(".bar-bottom a").removeClass("selected");
      $(".bar-bottom a:eq(3)").addClass("selected");
</script>
<script>
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

    function GetRequest() {
        var url = location.search; //获取url中"?"符后的字串
        var theRequest = new Object();
        if (url.indexOf("?") != -1) {
            var str = url.substr(1);
            strs = str.split("&");
            for(var i = 0; i < strs.length; i ++) {
                theRequest[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]);
            }
        }
        return theRequest;
    }

</script>
</body>
</html>