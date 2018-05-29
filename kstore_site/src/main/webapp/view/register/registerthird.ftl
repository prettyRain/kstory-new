<!DOCTYPE html>
<html>
<head lang="zh">
  <meta charset="UTF-8">
  <title>注册页</title>
<#assign basePath=request.contextPath>
  <#--<link rel="stylesheet" href="http://kstore.qianmi.com/index_seven/css/style.css">-->
  <link rel="stylesheet" href="${basePath}/css/iCheck/custom.css">
  <link rel="stylesheet" href="${basePath}/css/receive.m.css">
    <link rel="stylesheet" href="${basePath}/index_960/css/style.css"/>
<#--shf-->
    <link rel="stylesheet" type="text/css" href="${basePath}/css/pages.css" />
  <script src="${basePath}/js/jquery.js"></script>
  <script type="text/javascript" src="${basePath}/js/register.js"></script>
    <style>
        /*shf*/
        .section-header{
            height:auto;
        }
        .mainnav .showlist .btnnav{
            background: none;
        }
      /*  .mainnav .showlist .btnnav a{
            text-indent: 50px;
        }*/
        #logo{
            padding-top: 0;
        }
        .mainnav{
            margin-top: 0;
        }
        /*.dropdown-menu .links a{
            color: #fff!important;
        }*/
     /*   .dropdown-menu{
            background: #0d9901!important;
        }*/
        /*.dropdown-menu .links a:hover {
            color: #0d9901!important;
        }*/
      /*  .dropdown-menu li:hover{
            background-color:#fff!important;
        }*/
        .search{
            position: static!important;
        }
        .rightpar{
            display: none;
        }
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
        .nextGrey{
            background: #999999!important;
            border: 1px solid #999999!important;
        }
        .loading{
            display: block;
            width: 298px;
            height: 40px;
            line-height: 40px;
            text-align: center;
            color: #fff;
            font-size: 16px;
            border: 1px solid #0d9901;
            letter-spacing: 0.5px;
            cursor: pointer;
            background:  #00991D url(${basePath}/images/tigger_green.gif) no-repeat 50%!important;
            background-size: 15%!important;
        }
    </style>
</head>
<body class="grey_bg">
<#include "../index/newheader3.ftl"/>
<div class="container">

  <#--<div class="mini_head">-->
    <#--<h1 class="logo">-->
      <#--<a href="${basePath}/index.html">-->
        <#--<img alt="kstore" src="" id="reg_third" style="height:70px;width:165px;">-->
      <#--</a>-->
      <#--<span>欢迎注册</span>-->
    <#--</h1>-->
  <#--</div>-->

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
      <div class="step active">
        <i>2</i>
        <span>设置用户信息</span>
      </div>
      <div class="step">
        <i>3</i>
        <span>注册成功</span>
      </div>
    </div>
    <form action="${basePath}/addcust.html" method="post" id="regform">
      <input type="hidden" name="cusId" id="cusId" value="" />
      <input type="hidden" name="infoMobile" id="mobile" value="${mobile}" />
      <input type="hidden" name="customerUsername" value="${mobile}" />
        <div class="reg_form">
          <div class="reg_form_item">
            <label class="for_text">账号密码</label>
            <div class="item">
              <input type="password" class="text long passwordconf" name="customerPassword" placeholder="设置账号密码">
              <i class="correct" style="display: none"></i>
              <p class="tips pass" style="display: none">密码为6-16位字母加数字的组合，不得含特殊字符</p>
            </div>
          </div>
          <div class="reg_form_item">
            <label class="for_text">确认密码</label>
            <div class="item">
              <input type="password" class="text long repasswordconf" placeholder="确认账号密码">
              <i class="correct" style="display: none"></i>
              <p class="tips repass" style="display: none">密码为6-16位字母加数字的组合，不得含特殊字符</p>
            </div>
          </div>
      </form>
      <div class="reg_form_item">
        <label class="for_text">&nbsp;</label>
        <div class="item">
          <div class="sub_btn nextGrey " onclick="register()" style="cursor: pointer;">下一步</div>
        </div>
      </div>
    </div>

  </div>
<#--<div class="footer_tab">-->
    <#--<ul>-->

        <#--<li class="list1"><a href="http://www.ge960.com/channel/237.html">食品荟萃</a></li>-->
        <#--<li class="list2"><a href="http://www.ge960.com/channel/239.html">饮品总汇</a></li>-->
        <#--<li class="list3"><a href="http://www.ge960.com/channel/241.html">购物中心</a></li>-->
        <#--<li class="list4"><a href="http://www.ge960.com/channel/243.html">大药房</a></li>-->

    <#--</ul>-->
<#--</div>-->


</div>
<#if (topmap.temp)??>
    <#if (topmap.temp.tempId==1)>
        <#include "../index/bottom.ftl">

    <#else>
        <#include "../index/newbottom.ftl" />
    </#if>
</#if>
<script src="${basePath}/js/jquery.min.js"></script>
<script src="${basePath}/js/icheck.min.js"></script>
<script type="text/javascript" src="${basePath}/index_960/js/app.js"></script>
<script>

  $(function(){

      //文本框有输入内容才变绿
      $('.text').on('input change',function(){
          var password = $(".passwordconf").val();
          var repassword = $(".repasswordconf").val();
          if(($.trim(password)!=="")&&($.trim(repassword)!=="")){
              $('.sub_btn').removeClass("nextGrey");
          }else {
              $('.sub_btn').addClass("nextGrey");
          }
      });
    $(".i-checks").iCheck({
      checkboxClass:"icheckbox_square-green",
      radioClass:"iradio_square-green"
    })
      $.ajax({
          url: 'loadlogo.htm',
          success: function(data){
              $("#reg_third").prop("src",data.logo.bsetLogo);
          }
      });
  });
</script>

</body>
</html>