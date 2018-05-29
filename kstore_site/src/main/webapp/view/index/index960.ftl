<!DOCTYPE html>
<html>
<head>
<#assign basePath=request.contextPath>
    <meta charset="UTF-8">
    <title>${topmap.seo.mete!''}</title>
    <!-- SHOP QQ LOGIN -->
    <meta property="qc:admins" content="${(topmap.qqCode.authClientCode)!''}" />
    <!-- SINA LOGIN -->
    <meta property="wb:webmaster" content="${(topmap.sinaCode.authClientCode)!''}" />
    <meta name="description" content="${(topmap.seo.meteDes)!''}">
    <meta name="keywords" content="${(topmap.seo.meteKey)!''}">
    <meta name="renderer" content="webkit">
    <link rel="stylesheet" href="${basePath}/index_960/css/new_home_page.css"/>
<#if (topmap.systembase.bsetHotline)??>
    <link rel = "Shortcut Icon" href="${(topmap.systembase.bsetHotline)!''}">
<#else>
    <link rel = "Shortcut Icon" href="${basePath}/images/Paistore.ico">
</#if>

    <style>
        .dropdown-menu{display: block!important;}
        body,html{ background: #fcfcfc;}
        .bgPop1 {
            display: none;
            position: absolute;
            z-index: 100!important;
            left: 0;
            top: 0px!important;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,.71);
        }
        .bgPop1  .activity_zq{
            width: 500px;
            margin: 252px auto;
            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;
            right: 0;
        }
        .bgPop1  .activity_zq  .btn_click{
            float: right;
            cursor: pointer;
            position: absolute;
            right: 35px;
        }
        .bgPop1  .activity_zq .btn_activity{
            width: 330px;
            float: left;
            cursor: pointer;
            margin-left: 90px;
        }

        @media screen and (max-width: 1440px){
            .bgPop1 .activity_zq {
                width: 500px;
                margin: 200px auto;
                position: fixed;
                left: 0;
                top: 0;
                bottom: 0;
                right: 0;
            }
            .bgPop1 .activity_zq .btn_activity{
                width: 280px;
                float: left;
                cursor: pointer;
                margin-left: 140px;
            }
        }
        @media screen and (max-width: 1366px){
            .bgPop1 .activity_zq .btn_activity{
                width: 280px;
                float: left;
                cursor: pointer;
                margin-left: 140px;
            }
        }
    </style>
</head>
<body>
<#--首页顶部广告-->
<#if topmap.advs??>
    <#list topmap.advs as adv>
        <#if adv.adverSort==20>
            <div class="outermost" style="background-color:${adv.des!''}">
                <div class="otm">
                    <#if adv.adverHref?? && adv.adverHref?length gt 0>
                     <a href="${adv.adverHref}">
                    <#else>
                     <a href="javascript:void(0);">
                    </#if>
                    <img class="first_img" src="${adv.adverPath!''}" alt="">
                    <img src="${basePath}/images/advertising_x.png" class="advertising_btn" >
                    </a>
                </div>
            </div>
        </#if>
    </#list>
</#if>

<#--end-->
<#include "newheader960.ftl">
<#include "index960.html">

<#--<div class="footer_tab">-->
    <#--<ul>-->

    <#--<#if topmap.advs??>-->
        <#--<#list topmap.advs as adv>-->
            <#--<#if (adv.adverSort>=11) && (adv_index<=14)>-->
                <#--<li class="list${adv.adverSort-10}"><a href="${adv.adverHref!'#'}">${adv.adverName!''}</a></li>-->
            <#--</#if>-->
        <#--</#list>-->
    <#--</#if>-->

        <#--&lt;#&ndash;<li class="list4"><a style="text-indent:17px;" href="#" target="_self">大 药 房</a></li>&ndash;&gt;-->
    <#--</ul>-->
<#--</div>-->
<#--<div class="line iconlist">
    <div style="width:1197px;margin:0 auto;">
        <a href="javascript:;" class="a1"><img src="${basePath}/index_960/images/icon_menu1.png"></a>
        <a href="javascript:;"><img src="${basePath}/index_960/images/icon_menu6.png"></a>
        <a href="javascript:;"><img src="${basePath}/index_960/images/icon_menu5.png"></a>
        <a href="javascript:;"><img src="${basePath}/index_960/images/icon_menu2.png"></a>
        <a href="javascript:;"><img src="${basePath}/index_960/images/icon_menu3.png"></a>
        <a href="javascript:;"><img src="${basePath}/index_960/images/icon_menu4.png"></a>
    </div>
</div>-->

<#include "new_content.ftl">

<#include "newbottom.ftl">
<#--<div class="bgPop1" onclick="btnHD()">
    <div class="activity_zq">
        <img onclick="btnHD()" class="btn_click" src="${basePath}/images/btn_click.png">
        <a href="${basePath}register.html"><img class="btn_activity" src="${basePath}/images/yuandanhuodong.png"></a>
    </div>
</div>-->
<#--首页活动页-->
<script>
   /* $(function () {
        var count = sessionStorage.getItem("huodong");
        if(count == null || count == 0){
            sessionStorage.setItem("huodong", 1);
            $(".bgPop1").show();
        }/!*else{
            sessionStorage.clear();
        }*!/
    })*/
   /*  function btnHD() {
         $(".bgPop1").hide();
     }
    $(function () {
        $(".bgPop1").css({ "width": $(document).width(), "height": $(document).height() });
    })*/

</script>
<p style="display: none;">
<#--友盟CNZZ统计-->
    <script src="https://s13.cnzz.com/z_stat.php?id=1263930585&web_id=1263930585" language="JavaScript">
        //声明_czc对象:
        var _czc = _czc || [];
        //绑定siteid，请用您的siteid替换下方"XXXXXXXX"部分
        _czc.push(["_setAccount", "www.ge960.com"]);
    </script>
</p>
</body>
</html>

