<!DOCTYPE html>
<html>
<head lang="zh-cn">
<#assign basePath=request.contextPath>
    <meta charset="UTF-8">
    <title>提交成功</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <link rel="stylesheet" href="${basePath}/css/style.min.css">
    <script src="${basePath}/js/jquery-1.10.1.js"></script>
    <style>
        body{font-family:微软雅黑,Microsoft yahei;}
        body, html,.success_info {
            background: #ffffff;
        }
        .success_info {
            padding: 100px 0 0 0;
        }
        .success_info p{
            text-align: center;
            font-size: 14px;
        }
        .success_info p:nth-of-type(1){
            font-size: 15px;
            color: #030303;
            letter-spacing: 1.04px;

        }
        .success_info p:nth-of-type(2) a{
            background: -webkit-linear-gradient(left,#0ead00,#0d9901);
            background: -o-linear-gradient(left,#0ead00,#0d9901);
            background: -moz-linear-gradient(left,#0ead00,#0d9901);
            background: linear-gradient(left,#0ead00,#0d9901);
            width:188.8px;
            height:35.8px;
            line-height:35.8px;
            display: block;
            margin: 0 auto;
            border-radius: 30px;
            font-size: 14px;
            color: #FFFFFF;
            letter-spacing: 0;
            text-decoration: none;
            margin-bottom: 30px;
            margin-top:150px;
        }
        .success_info p:nth-of-type(3) a{
            border:none;
            width:181px;
            height:31px;
            line-height:31px;
            /*background: #199301;*/
            display: block;
            margin: 0 auto;
            border-radius: 30px;
            color: #fff;
            text-decoration: none;
            filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#0ead00',endColorstr='#0d9901',GradientType='1');
            background:-webkit-linear-gradient(left,#0ead00,#0d9901);
            background: -o-linear-gradient(left,#0ead00,#0d9901);
            background: -moz-linear-gradient(left,#0ead00,#0d9901);
            background: linear-gradient(left,#0ead00,#0d9901);
        }
        .container .success_info img {
            width: 185px;
            height: 168px;
            margin: 0 auto;
            display: block;
        }

    </style>
</head>
<body>
<#assign vtitle="提交成功" />
<#assign backUrl="${basePath}/customer/myorder.html" />
<#include "/common/head_back.ftl"/>
<div class="container">
    <div class="success_info">
        <img src="${basePath}/images/shenqingtijiaochenggong.png">
        <p>申请提交成功</p>
        <p><a href="${basePath}/customer/myorder.html">返回我的订单</a></p>
    </div>
</div>
</body>
</html>