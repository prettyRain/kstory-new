<!doctype html>
<html ng-app>
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
    <link rel="stylesheet" href="${basePath}/index_eight/css/style.css"/>
<#if (topmap.systembase.bsetHotline)??>
    <link rel = "Shortcut Icon" href="${(topmap.systembase.bsetHotline)!''}">
<#else>
    <link rel = "Shortcut Icon" href="${basePath}/images/Paistore.ico">
</#if>
    <style>
        .dropdown-menu {display:block!important;}
        .customer_service:hover{background:#c33;}
        .customer_service:hover em, .feedback:hover em {font-size:12px; position:relative; top:3px; font-style:normal;}
        .customer_service b {background:url(${basePath}/index_seven/images/-01.png) #fff no-repeat center center!important;}
        .customer-box {
            position: absolute;
            background: #efefef;
            width: 146px;
            min-height: 150px;
            border: 1px solid #ccc;
            padding: 9px;
            right: 50px;
            display: none;
        }
        .sideBar .customer-box a {width:auto; height:auto; background-color:transparent; border:none; line-height:normal;}
        .close-cs {
            position: absolute!important;
            top: 10px;
            right: 10px;
            background: url(${basePath}/index_seven/images/agree_close1.gif) no-repeat;
            width: 10px!important;
            height: 10px!important;
            display: block;
        }
        .customer-box p {overflow:hidden; margin-top:10px;}
        .customer-box p .qq_name {float:right;}
        .customer-box p .qq_img {float:left;}
        .sideBar a span {font-size:12px!important; padding:2px 5px; width:28px!important; line-height:normal!important;}
        .onlineServiceQQ {height:100px;overflow-y:auto;}
        /* 设置滚动条的样式 */
        .onlineServiceQQ::-webkit-scrollbar {
            width:5px;
        }
        /* 滚动槽 */
        .onlineServiceQQ::-webkit-scrollbar-track {
            -webkit-box-shadow:inset006pxrgba(0,0,0,0.3);
            border-radius:0;
        }
        /* 滚动条滑块 */
        .onlineServiceQQ::-webkit-scrollbar-thumb {
            border-radius:0;
            background:rgba(0,0,0,0.1);
            -webkit-box-shadow:inset006pxrgba(0,0,0,0.5);
        }
    </style>
</head>
<body>
<#include "newheader8.ftl">
<#include "index8.html"/>
<#include "newbottom.ftl">
</body>
</html>