<#assign basePath=request.contextPath>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>第三方登录</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="stylesheet" type="text/css" href="${basePath}/css/v2/framework7.ios.min.css">
    <link rel="stylesheet" type="text/css" href="${basePath}/css/v2/framework7.ios.colors.min.css">
    <link href="${basePath}/css/ui-dialog.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${basePath}/css/v3/third_party.css">
    <script src="${basePath}/js/jquery-1.10.1.js"></script>
    <script src="${basePath}/js/dialog-min.js"></script>
</head>
<body>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<form action="#" id="partform">
    <input type="hidden" id="partType" name="partType" value="${partType!''}">
    <input type="hidden" id="openId" name="openId" value="${openId!''}">
    <input type="hidden" id="accessToken" name="accessToken" value="${accessTokenn!''}">
    <input type="hidden" id="url" name="url" value="${url!''}">
</form>

<div class="views">
    <div class="view view-main">
        <div class="pages">
            <div data-page="home" class="page navbar-fixed">
                <div class="navbar">
                <#assign vtitle="绑定手机号" />
                <#assign backUrl="${basePath}/loginm.html?url=/customercenter.html" />
                <#include "../common/head_back.ftl"/>
                </div>
                <div class="page-content">
                    <div class="content-block">
                        <ul class="bound_phone">
                            <li class="li_li">
                                <input type="number" pattern="[0-9]*" id="mobile" placeholder="请输入手机号"/>
                                <span class="clean"><img src="${basePath}/images/v3/btn_delect@2x.png" alt=""/></span>
                                <p class="error">手机号不存在×</p>
                            </li>

                            <li class="list-2 li_li">
                                <div class="code">
                                    <input type="number" pattern="[0-9]*" name="code" id="code" maxlength="6" placeholder="请输验证码"/>
                                    <span class="clean clean1"><img src="${basePath}/images/v3/btn_delect@2x.png" alt=""/></span>
                                    <p class="error">手机号不存在×</p>
                                </div>
                                <a class="a1 get-confirmcode" href="javascript:;" onClick="codeNock();">获取验证码</a>
                            </li>

                        <#--<li class="no no-reg">-->
                        <#--<label class="active"><span></span>阅读并同意</label><a href="${basePath}/intoPage.htm?pageName=member/servclause">《960用户协议》</a>-->
                        <#--</li>-->

                            <li  class="no">
                                <a href="javascript:;" onClick="subThirdParty();"><span class="input-next">提交</span></a>
                            </li>
                        </ul>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="popup popup-about">
    <div class="content-block">
    <#--面板-->
        <div class="payPanel">
            <a href="#" class="close-popup">返</a>
            <div class="price"></div>
            <p class="prompt">密码为6-16位数字加字母组合，不含特殊符号</p>
            <div class="psdWarp">
                <input type="password" id="lpk_psd" pattern="[0-9]*" class="lpkPsd" placeholder="请输入登录密码" />
                <span class="clean cleanpwd"><img src="${basePath}/images/v3/btn_delect@2x.png" alt=""/></span>
                <span class="show_password"></span>
            </div>
            <div class="xieyi">
                <label class="active"><span class=""></span>阅读并同意</label>
                <a class="external" href="${basePath}/intoPage.htm?pageName=member/servclause">《960用户协议》</a>
            </div>
            <a href="javascript:;" class="affirm"><span>完成</span></a>
        </div>
    </div>
</div>
<script type="text/javascript" src="${basePath}/js/v1/framework7.min.js"></script>
<script type="text/javascript" src="${basePath}/js/v3/third_party.js"></script>
</body>
</html>
