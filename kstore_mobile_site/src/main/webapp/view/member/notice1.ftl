<!DOCTYPE html>
<html>
<head>
    <#assign basePath=request.contextPath/>
  <meta charset="UTF-8">
  <title>会员中心 - 商城消息</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <meta content="telephone=no" name="format-detection">
  <link rel="stylesheet" href="${basePath}/css/style.min.css"/>
  <link rel="stylesheet" href="${basePath}/css/ui-dialog.css">
  <link rel="stylesheet" href="${basePath}/css/v2/notice2.css"/>
  <script src="${basePath}/js/jquery-1.10.1.js"></script>
  <script src="${basePath}/js/dialog-min.js"></script>
</head>
<body>
<#assign vtitle="商城消息" />
<#--<#assign backUrl="${basePath}/customers/notice.htm?mark="+${mark} />-->
<#if (mark?? && mark == '0')>
    <#assign backUrl="${basePath}/customers/notice.htm?mark=0" />
<#else>
    <#assign backUrl="${basePath}/customers/notice.htm?mark=1" />
</#if>
<#--<#assign backUrl="${basePath}/customers/notice.htm" />-->
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
<div  style="margin-top: 65px;margin-bottom: 10px;">
<#if (pb?size!=0)>
    <#list pb as letter>
        <div class="info" id="notice${letter.letterId}">
            <input type="hidden" value="${letter.letterId}" id="letterId"/>
            <div class="datetime"><b>${letter.createTime?string('MM-dd HH:mm')}</b></div>
            <div class="detail">
                <p class="title">${letter.letterTitle}</p>
                <span class="digest">${letter.letterContent!''}</span>

                <#if letter.hrefUrl??>
                    <#if letter.hrefUrl?contains("item-")>
                        <#assign itemId = (letter.hrefUrl)?split("-")[1] >
                    <a href="${basePath}/item/${itemId}.html" class="moreinfo"><span>查看详情</span>
                    <#elseif letter.hrefUrl?contains("list-")>
                        <#assign listId = (letter.hrefUrl)?split("-")[1] >
                    <a href="${basePath}/list/${listId}.html" class="moreinfo"><span>查看详情</span>
                    <#elseif letter.hrefUrl?contains("http")>
                    <a href="${letter.hrefUrl}" class="moreinfo"><span>查看详情</span>
                    </#if>
                    </a>
                </#if>
            </div>
        </div>
    </#list>
<#else>
    <div class="content" id="no">
        <div class="no_tips">
            <p>暂无消息</p>
        </div>
    </div>
</#if>
</div>

<script>

//    $(function () {
//        $("#icon-option").click(function(){
//            doCancel();
//        });
//    });


    function doCancel(){
        var discountBox = dialog({
            width: 260,
            title: '删除商城消息',
            content: "确定删除全部商城消息吗？",
            okValue: '确定',
            cancelValue: '取消',
            ok: function () {
                $.ajax({
                    url:"${basePath}/remove_adminnotice.htm",
                    type:"post",
                    success:function(data){
                        if(data == 1){
                            setTimeout(function () {
                                $('.tip-box').remove();
                                $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><i class="success"></i><h3>商城消息删除成功！</h3></div></div>');
                            }, 10);
                            setTimeout(function () {
                                $(".tip-box").hide();
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

</script>
</body>
</html>