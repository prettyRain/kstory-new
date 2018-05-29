<!DOCTYPE html>
<html>
<head lang="zh">
  <meta charset="UTF-8">
  <title>礼品卡注册页</title>
<#assign basePath=request.contextPath>
<#--shf-->
    <link rel="stylesheet" type="text/css" href="${basePath}/css/pages.css" />
  <#--<link rel="stylesheet" href="http://kstore.qianmi.com/index_seven/css/style.css">-->
  <link rel="stylesheet" href="${basePath}/css/iCheck/custom.css">
  <link rel="stylesheet" href="${basePath}/css/receive.m.css">
    <link rel="stylesheet" href="${basePath}/index_960/css/style.css"/>

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
        .nextGrey{
            background: #999999!important;
            border: 1px solid #999999!important;
        }
    </style>
</head>
<body class="grey_bg">
<#include "../index/newheader3.ftl"/>
<div class="container">

  <#--<div class="mini_head">-->
    <#--<h1 class="logo">-->
      <#--<a href="${basePath}/index.html">-->
        <#--<img alt="kstore" src="" id="reg_two" style="height:70px;width:165px;">-->
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
      <div class="step active">
        <i>1</i>
        <span>设置登录名</span>
      </div>
      <div class="step">
        <i>2</i>
        <span>设置用户信息</span>
      </div>
      <div class="step">
        <i>3</i>
        <span>注册成功</span>
      </div>
    </div>

    <div class="user_tips" style="display: none">
      <h4>验证手机</h4>
      <p class="info">验证码已经发送到你的手机，5分钟内输入有效，请勿泄露</p>
      <a href="javascript:;" class="close"></a>
    </div>

    <div class="reg_form">
      <div class="reg_form_item">
        <label class="for_text">手机号码</label>
        <input type="hidden" id="sign" value="${sign!0}"/>
          <form action="${basePath}/giftcardregisterthird.html" id="registSecondForm" method="post">
              <input type="hidden" id="giftcardPwd" name="giftcardPwd" value="${giftcardPwd!''}"/>
              <input type="hidden" id="mobileNum" name="mobile" value="${mobile!''}"/>
          </form>
        <div class="item">
          <#assign mo="${mobile?substring(3,mobile?length-4)}" />
          <#assign mob="${mobile?replace(mo,'****')}" />
          <b>${mob}</b>
        </div>
      </div>
        <div class="reg_form_item">
            <label class="for_text"><span style="color:red;">*</span>验证码</label>
            <div class="item">
                <input type="text" class="text medium" placeholder="请输入图片验证码" name="checkCode" id="checkCode">
                <div class="vCode">
                    <img id="checkCodeImg" src="${basePath}/patchca.htm" onclick="this.src=this.src+'?'+Math.random(); " alt="验证码">
                    <a id="checkCodeA" href="javascript:void(0)">换一张</a>
                </div>
                <p class="tips code_info1" style="display: none">请输入验证码</p>
            </div>
        </div>
      <div class="reg_form_item">
        <label class="for_text">验证码</label>
        <div class="item">
            <input type="text" class="text small" name="checkCode" placeholder="请输入验证码" id="message">
            <div class="tCode">
            <button type="button" class="active_btn btn" onclick="sendMessage()" id="sendbtn">获取验证码</button>
          </div>
          <p class="tips code_info" style="display: none">请输入验证码</p>
          <p class="tips code_send" style="display: none">
              验证码已发出，如未收到，<span class="timeleft">59</span>秒后重新获取
          </p>
        </div>
      </div>
      <div class="reg_form_item">
        <label class="for_text">&nbsp;</label>
        <div class="item">
          <button type="submit" class="sub_btn free nextGrey" onclick="submitSecondGiftcard()">确定</button>
        </div>
      </div>
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

<script src="${basePath}/js/jquery.min.js"></script>
<script src="${basePath}/js/icheck.min.js"></script>
<script type="text/javascript" src="${basePath}/index_960/js/app.js"></script>
<script>
  $(function(){
      //文本框有输入内容才变绿
      $('.text').on('input change',function(){
          var message = $("#message").val();
          var checkCode = $("#checkCode").val();
          if(($.trim(message)!=="")&&($.trim(checkCode)!=="")){
              $('.sub_btn').removeClass("nextGrey");
          }else {
              $('.sub_btn').addClass("nextGrey");
          }
      });

      if($("#sign").val() == "1"){
          $(".code_send").hide();
          $(".code_info").html("请输入正确的验证码");
          $(".code_info").parents(".reg_form_item").addClass("error");
          $(".code_info").show();
      }
      if($("#sign").val() == "2"){
          $(".code_send").hide();
          $(".code_info").html("错误次数过多，验证码已失效，请重新获取");
          $(".code_info").parents(".reg_form_item").addClass("error");
          $(".code_info").show();
      }
    $(".i-checks").iCheck({
      checkboxClass:"icheckbox_square-green",
      radioClass:"iradio_square-green"
    })
      $.ajax({
          url: 'loadlogo.htm',
          success: function(data){
              $("#reg_two").prop("src",data.logo.bsetLogo);
          }
      });
  });
</script>

</body>
</html>