<!DOCTYPE html>
<html>
<head lang="zh">
  <meta charset="UTF-8">
  <title>注册页</title>
<#assign basePath=request.contextPath>
  <#--<link rel="stylesheet" href="http://kstore.qianmi.com/index_seven/css/style.css">-->
  <link rel="stylesheet" href="${basePath}/css/iCheck/custom.css">

    <link rel="stylesheet" href="${basePath}/css/receive.m.css">
    <link rel="stylesheet" href="${basePath}/css/new_register.css">
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
       /* .mainnav .showlist .btnnav a{
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
       /* .dropdown-menu{
            background: #0d9901!important;
        }*/
        /*.dropdown-menu .links a:hover {
            color: #0d9901!important;
        }*/
       /* .dropdown-menu li:hover{
            background-color:#fff!important;
        }*/
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

  <#--<div class="mini_head">-->
    <#--<h1 class="logo">-->
      <#--<a href="${basePath}/index.html">-->
        <#--<img alt="kstore" src="" style="height:70px;width:165px;" id="reg_fouth">-->
      <#--</a>-->
      <#--<span>欢迎注册</span>-->
    <#--</h1>-->
  <#--</div>-->

  <p class="login_tip" style="margin-top: 10px;display:none;">
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
      <#assign m="${cust.customerUsername}" />
      <#assign mo="${m?substring(3,m?length-4)}" />
      <#assign mob="${m?replace(mo,'****')}" />

    <#assign registerIntegral="${registerIntegral!0}"   />
    <#assign basicSet="${basicSet!0}"   />
    <#assign couponId="${couponId!0}"   />
      <p class="p">恭喜您，${mob}账号注册成功！</p>
      <#--<a href="${basePath}/index.html" class="btn">立即购物</a>-->
        <p class="p1"><span class="timeleft">10s</span>后将自动返回注册前页面，或者点击下方按钮立即返回</p>
          <#if coupon??>
            <div class="register_coupon">
                <div class="coupon_div">
                    <span class="span_one">￥</span><span class="span_two">
                        <#if coupon.couponRulesType?? && coupon.couponRulesType=='1'>
                                     ${coupon.couponStraightDown.downPrice}
                        <#elseif coupon.couponRulesType?? && coupon.couponRulesType=='2'>
                        ${coupon.couponFullReduction.reductionPrice}
                        </#if>
                    </span>
                </div>
                <div class="coupon_div1">
                    <span>${coupon.couponName}</span>
                    <span>已添加至我的优惠券</span>
                </div>
                <div class="coupon_div2">
                    <#if registerIntegral?number!=0 || couponId?number!=0>
                        <a href="${basePath}/mycoupon-1.html">点击查看</a>
                    </#if>
                </div>
            </div>

          </#if>
        <a href="${beforeRegUrl!'/'}" class="btn" style="margin:0 auto;">立即返回</a>

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
<script src="js/jquery.min.js"></script>
<script src="js/icheck.min.js"></script>
<script type="text/javascript" src="${basePath}/index_960/js/app.js"></script>
<script>
  $(function(){
      countDown();
      //计时器
      function countDown(){
          var time = parseInt($(".timeleft").text());
          $(".timeleft").text(time - 1+"s");
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