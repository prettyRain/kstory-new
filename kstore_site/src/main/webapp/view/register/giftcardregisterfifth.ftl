<!DOCTYPE html>
<html>
<head lang="zh">
  <meta charset="UTF-8">
  <title>礼品卡注册页</title>
<#assign basePath=request.contextPath>
  <link rel="stylesheet" href="${basePath}/css/iCheck/custom.css">
  <link rel="stylesheet" href="${basePath}/css/receive.m.css">
    <link rel="stylesheet" href="${basePath}/index_960/css/style.css"/>
    <#--shf-->
    <link rel="stylesheet" type="text/css" href="${basePath}/css/pages.css" />
  <script src="${basePath}/js/jquery.js"></script>
  <script type="text/javascript" src="${basePath}/js/register.js"></script>
    <style>
        html body.grey_bg {
            display: block;
            height: 100%;
            background: #ffffff;
        }
        .user_box {
            padding: 40px 85px;
            margin-top: 10px;
            background: #fff;
            border: 3px solid rgb(224, 224, 224);
            min-height: 500px;
        }
        /*shf*/
        .section-header{
            height:auto;
        }
        .mainnav .showlist .btnnav{
            background: none;
        }
        .mainnav .showlist .btnnav a{
            text-indent: 50px;
        }
        #logo{
            padding-top: 0;
        }
        .mainnav{
            margin-top: 0;
        }
        .dropdown-menu{
            background: #0d9901!important;
        }
        .dropdown-menu li:hover{
            background-color:#fff!important;
        }
        .search{
            position: static!important;
        }
        .rightpar{
            display: none;
        }
        .timeleft{
            color: #f00;
        }
    </style>
</head>
<body class="grey_bg">
<#include "../index/newheader3.ftl"/>
<div class="container">

  <p class="login_tip" style="margin-top: 10px;">
    我已经注册，马上
    <a href="${basePath}/login.html">登录 &gt;</a>
  </p>

  <div class="user_box">

    <div class="user_flow step3">
      <div class="step">
        <i>1</i>
        <span>设置登录名</span>
      </div>
      <div class="step">
        <i>2</i>
        <span>设置用户信息</span>
      </div>
      <div class="step active">
        <i>3</i>
        <span>注册成功</span>
      </div>
    </div>

    <div class="success_tips">
      <i class="successIcon"></i>
      <#assign m="${mobile}" />
      <#assign mo="${m?substring(3,m?length-4)}" />
      <#assign mob="${m?replace(mo,'****')}" />
      <p>恭喜您，${mob}账号注册成功！</p>
      <p style="font-size: 14px;"><span class="timeleft">10</span>秒后将自动返回注册前页面，或者点击下方按钮立即返回</p>
      <a href="${beforeRegUrl}" class="btn">立即返回</a>
    </div>

  </div>
<#if (topmap.temp)??>
    <#if (topmap.temp.tempId==1)>
        <#include "../index/bottom.ftl">

    <#else>
        <#include "../index/newbottom.ftl" />
    </#if>
</#if>

</div>

<script src="js/jquery.min.js"></script>
<script src="js/icheck.min.js"></script>
<script type="text/javascript" src="${basePath}/index_960/js/app.js"></script>
<script>
  $(function(){
      countDown();
      //计时器
      function countDown(){
          var time = $(".timeleft").text();
          $(".timeleft").text(time - 1);
          if (time == 1) {
             location.href = $(".btn").attr("href");
          } else {
              setTimeout(countDown, 1000);
          }
      }

    $(".i-checks").iCheck({
      checkboxClass:"icheckbox_square-green",
      radioClass:"iradio_square-green"
    })
      $.ajax({
          url: 'loadlogo.htm',
          success: function(data){
              $("#reg_fouth").prop("src",data.logo.bsetLogo);
          }
      });
  });
</script>

</body>
</html>