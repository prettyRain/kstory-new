<!DOCTYPE html>
<html>
<head>
    <#assign basePath=request.contextPath/>
  <meta charset="UTF-8">
  <title>会员中心 - 系统通知</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <meta content="telephone=no" name="format-detection">
  <link rel="stylesheet" href="${basePath}/css/style.min.css"/>
  <link rel="stylesheet" href="${basePath}/css/ui-dialog.css">
  <link rel="stylesheet" href="${basePath}/css/v2/notice2.css"/>
  <script src="${basePath}/js/jquery-1.10.1.js"></script>
  <script src="${basePath}/js/dialog-min.js"></script>
</head>
<body>
<#assign vtitle="系统通知" />
<#--<#assign backUrl="${basePath}/customers/notice.htm?mark="+${mark} />-->
<#if (mark?? && mark == '0')>
    <#assign backUrl="${basePath}/customers/notice.htm?mark=0" />
<#else>
    <#assign backUrl="${basePath}/customers/notice.htm?mark=1" />
</#if>
<#--<#assign backUrl="javascript:history.go(-1)" />-->
<#--<#assign backUrl="${basePath}/customers/notice.htm" />-->
<#include "../common/head_back.ftl"/>
<input type="hidden" id="basePath" value="${basePath}"/>
<div  style="margin-top: 65px;margin-bottom: 10px;">

<#if (pb?size!=0)>
    <#list pb as notice>
        <div class="info">
            <div class="datetime"><b>${notice.createTime?string('MM-dd HH:mm')}</b></div>
            <div class="detail">
                <p class="title">${notice.noticeTitle}</p>
                <span class="digest">${notice.noticeContent!''}</span>
                <#if notice.orderId??>
                <a href="${basePath}/customer/detail-${notice.orderId}.html" class="moreinfo"><span>查看订单</span></a>
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
            title: '删除系统消息',
            content: "确定删除全部系统消息吗？",
            okValue: '确定',
            cancelValue: '取消',
            ok: function () {
                $.ajax({
                    url:"${basePath}/remove_ordernotice.htm",
                    type:"post",
                    success:function(data){
                        if(data == 1){
                            setTimeout(function () {
                                $('.tip-box').remove();
                                $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><i class="success"></i><h3>系统消息删除成功！</h3></div></div>');
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