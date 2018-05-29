<#assign basePath=request.contextPath>

<#include "newtop960.ftl"/>
<#if (map?? && map.channel?? && (map.channel.channelId == 237 || map.channel.channelId == 239 || map.channel.channelId == 241 || map.channel.channelId == 243 || map.channel.channelId == 247))>
    <#include "newheader960_"+map.channel.channelId+".html"/>
<#else>
    <#include "newheader960.html"/>
</#if>

<script>
    function browserRedirect() {
        var url = window.location.href;
        if(url.indexOf("weixin")>-1){
            url = url.replace(/item/,"mobile/getwxcode3.htm?toUrl=item");
            if(url.lastIndexOf(".html")==-1){
                url = url.replace(/#/,".html#");
            }
            url = url.substring(0,url.indexOf("#"));
            location = url;
        }
        var sUserAgent = navigator.userAgent.toLowerCase();
        var bIsIpad = sUserAgent.match(/ipad/i) == "ipad";
        var bIsIphoneOs = sUserAgent.match(/iphone os/i) == "iphone os";
        var bIsMidp = sUserAgent.match(/midp/i) == "midp";
        var bIsUc7 = sUserAgent.match(/rv:1.2.3.4/i) == "rv:1.2.3.4";
        var bIsUc = sUserAgent.match(/ucweb/i) == "ucweb";
        var bIsAndroid = sUserAgent.match(/android/i) == "android";
        var bIsCE = sUserAgent.match(/windows ce/i) == "windows ce";
        var bIsWM = sUserAgent.match(/windows mobile/i) == "windows mobile";
        if ( bIsIphoneOs || bIsMidp || bIsUc7 || bIsUc || bIsAndroid || bIsCE || bIsWM || bIsIpad) {
            //跳转到移动版
        <#if ((mobProjectUrl??) && (mobProjectUrl?length>0))>
            location = "${mobProjectUrl}";
        </#if>
        }
    }
    browserRedirect();
</script>
<#include "../shoppingcart/mincart.ftl"/>
<script type="text/javascript" src="${basePath}/index_960/js/app.js"></script>