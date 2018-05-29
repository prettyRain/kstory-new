<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>会员中心 - 首页</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta content="telephone=no" name="format-detection">
    <#assign basePath=request.contextPath>
    <link rel="stylesheet" href="${basePath}/css/style.min.css"/>
    <script src="${basePath}/js/jquery-1.10.1.js"></script>
    <style>
        .warp{
            margin:67px 0 50px 0;
        }
        .tips{
            margin: 0 auto;
            display: block;
        }
        p{
            color: #333;
            text-align: center;
            font-size: 14px;
            font-family:微软雅黑,Microsoft yahei;
        }
    </style>
</head>
<body>
<#assign vtitle="我的钱包" />
<#assign backUrl="${basePath}/customercenter.html" />
<#include "../common/head_back.ftl"/>
<div class="warp"><img alt="" src="../../images/v2/functiondeveloping@2x.png" class="tips" width="80%" height="80%"></div>
<p>该功能即将开放，敬请期待！</p>
</body>
</html>