<!DOCTYPE html>
<html>
<head>
    <#assign basePath=request.contextPath/>
  <meta charset="UTF-8">
  <title>会员中心 - 我的账户</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <meta content="telephone=no" name="format-detection">
  <link rel="stylesheet" href="${basePath}/css/style.min.css"/>
  <link rel="stylesheet" href="${basePath}/css/tip-newbox.css">
  <script src="${basePath}/js/jquery-1.10.1.js"></script>
  <script src="${basePath}/js/idangerous.swiper.js"></script>
  <script type="text/javascript" src="${basePath}/js/tip-newbox.js"></script>
    <style>

        .member_form2 dl dt {
            position: absolute;
            left: 0;
            top: 1.2em;
            color: #000;
            letter-spacing: 0;
            font-size: 15px;
        }


        .member_form2 dl {
            position: relative;
            display: block;
            padding: .85em 0 1em 6em;
            height: 3.76em;
            border-bottom: 1px solid #eee;
        }
        .member_form2 dl dd input.text{
            color: #000;
            letter-spacing: 0;
            font-size: 15px;
            position: absolute;
            left: 6.5em;
            top: 1.2em;
            padding: 0;
            width: 4rem;
        }
        .member_form2 dl dd input::-webkit-input-placeholder{
            color: #7f7f7f;
            font-size: 15px;
        }
        
        .member_form2 {
            background: #fff;
            border-top: 1px solid #f0f0f0;
            border-bottom: 1px solid #f0f0f0;

            padding-left: .3rem;
        }
        .tishi_p{
            font-size: .22rem;
            color: #858585;
            letter-spacing: 0;
            margin: .2rem 0 0 .3rem;
        }

        .btn-full {
            border-radius: 8px;
            margin: 0 auto;
            /*background: linear-gradient(left , rgb(85, 204, 0) , rgb(25,147,1) 100%);*/
            /*background: -o-linear-gradient(left , rgb(85, 204, 0) , rgb(25,147,1) 100%);*/
            /*background: -ms-linear-gradient(left , rgb(85, 204, 0) , rgb(25,147,1) 100%);*/
            /*background: -moz-linear-gradient(left , rgb(85, 204, 0) , rgb(25,147,1) 100%);*/
            /*background: -webkit-linear-gradient(left , rgb(85, 204, 0) , rgb(25,147,1) 100%);*/
            background:#199301;
            color: #ffffff!important;
            border: none;
            line-height: 24px;
            font-size: 15px;
            letter-spacing: 0;
            padding: 13px;
        }
        .ion-eye{
            width:20px;
            height:20px;
            background: url(../../images/icon_v1.0/none@2x.png?timestamp=15253278411) no-repeat center center;
            background-size: 20px 20px;
            margin: 0!important;
        }
        .selected .ion-eye{
            background: url(../../images/icon_v1.0/show@2x.png?timestamp=15253278411) no-repeat center center;
            background-size: 20px 20px;
        }

        .ion-eye:before{
            content: "";
        }
        .member_form2 dl dd a{
            width:20px;
            height:20px;
            padding:0;
            top:17px;
        }
        .member_form2 dl dd .clean{
            display: none;
            position: absolute;
            top: 17px;
            right: 40px;
            width: 20px;
            height: 20px;
        }
        .member_form2 dl dd .clean img{
            width: 20px;
            height: 20px;
        }
    </style>

</head>
<script>
    (function (doc, win) {
        var docEl = doc.documentElement,
                resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
                recalc = function () {
                    var clientWidth = docEl.clientWidth;
                    if (!clientWidth) return;
                    docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
                };
        if (!doc.addEventListener) return;
        win.addEventListener(resizeEvt, recalc, false);
        doc.addEventListener('DOMContentLoaded', recalc, false);
    })(document, window);
</script>

<body>

<#assign vtitle="登录密码" />
<#assign backUrl="${basePath}/accountsafe.html" />
<#include "/common/head_back.ftl"/>
<#--<div class="form_title">
    <input type="hidden"  id="basePath" value="${basePath}"/>
  <dl>
    <dt>当前账号</dt>
    <dd>
      <span>${cust.customerUsername?substring(0,2)}***${cust.customerUsername?substring(cust.customerUsername?length-2)}</span>
    </dd>
  </dl>
</div>-->

<div class="member_form2">
  <dl>
    <dt>当前密码</dt>
    <dd>
      <input type="password" class="text" id="password"  placeholder="请输入密码"/>
      <a href="javascript:;" class="show_password"><i class="ion-eye"></i></a>
      <span class="clean" style="display: none;"><img src="images/v3/btn_delect@2x.png" alt=""></span>
    </dd>
  </dl>
  <dl>
    <dt>新密码</dt>
    <dd>
      <input type="password" id="newpassword" placeholder="请设置登录密码" class="text">
      <a href="javascript:;" class="show_password"><i class="ion-eye"></i></a>
      <span class="clean" style="display: none;"><img src="images/v3/btn_delect@2x.png" alt=""></span>
    </dd>
  </dl>
    <#--<dl>-->
        <#--<dt>确认新密码</dt>-->
        <#--<dd>-->
            <#--<input type="password" id="newpasswordagain" placeholder="请再次输入密码" class="text">-->
            <#--<a href="javascript:;" class="show_password">-->
                <#--<i class="ion-eye"></i>-->
            <#--</a>-->
        <#--</dd>-->
    <#--</dl>-->



    <#--<dl>
        <dt>验证码</dt>
        <dd>
            <input type="text" id="code" placeholder="验证码" class="text"/>
            <span class="valid_img">
                <img alt="" id="code_image" src="${basePath}/patchca.htm" alt="验证码" onclick="this.src=this.src+'?'+Math.random();"/>
            </span>
        </dd>
    </dl>-->

</div>
<p class="tishi_p">密码格式为6-16位字母加数字组合</p>
<div class="p10 mb50" style="padding: 40px;">
  <a href="#" class="btn btn-full">提交</a>
</div>

<script>
  $(function(){
    /* 显示密码 */
    $('.show_password').click(function(){
      if($(this).attr('class').indexOf('selected') > 0){
        $(this).removeClass('selected');
        $(this).prev().attr('type','password');
      }
      else{
        $(this).addClass('selected');
        $(this).prev().attr('type','text');
      }
    });

    $(".member_form2 dl dd input").bind('input porpertychange',function(){

        if (!($(this).val()==null || $(this).val()=='')) {
            $(this).parent().find(".clean").show();
        }else{
            $(this).parent().find(".clean").hide();
        }
    });

    $(".member_form2 dl dd").on("touchstart",".clean",function(){
        console.log($(this).parent().find("input"))
        $(this).parent().find("input").val("");
        $(this).hide();
    });


    $("#password").focus(function(){
       $(this).attr("placeholder","");
       if (!($(this).val()==null || $(this).val()=='')) {$(this).parent().find(".clean").show();}
    }).blur(function(){
       if ($(this).val()==null || $(this).val()=='') {$(this).attr("placeholder","请输入密码");}
       $(this).parent().find(".clean").hide();
    });

    $("#newpassword").focus(function(){
        $(this).attr("placeholder","");
        if (!($(this).val()==null || $(this).val()=='')) {$(this).parent().find(".clean").show();}
    }).blur(function(){
        if ($(this).val()==null || $(this).val()=='') {$(this).attr("placeholder","请设置登录密码");}
        $(this).parent().find(".clean").hide();
    });










  });
  var tip = myAlertStr();
  $(".btn-full").click(function(){

        var password = $("#password").val();
        var newpassword = $("#newpassword").val();
   /*     var code = $("#code").val();*/

        if(checkInput()){
            $.ajax({
            type: 'post',
            url: "modifypassword.htm?password="+password+"&newPassword="+newpassword/*"&code="+code*/,
            success: function(data){
               /* console.log(data)*/
                if(data == 2){
                    //alertStr("当前密码错误");
                    tip("当前密码错误");
                }else if(data == 1){
//                    alertStr("修改成功");
                    tip("修改成功");
                    setTimeout(function(){
                        <#--window.location.href="${basePath}/logout.html";-->
                        window.location.href="${basePath}/accountsafe.html";
                    },1000)

                }else if(data == 0){
                    //alertStr("修改失败");
                    tip("修改失败");
                }else if(data == 3){
                    //alertStr("登陆账号异常，请重新登录");
                    tip("登陆账号异常，请重新登录");
                }/*else if (data == -1)
                {
                    /!*alertStr("验证码错误，请重新输入");*!/
                    $("#code_image").click();
                }*/

        }});
        }
  });

  function checkInput(){
      var password = $("#password").val();
      var newpassword = $("#newpassword").val();
      var passwordagain = $("#newpasswordagain").val();
 /*     var code = $("#code").val();*/

      if(password == null || password == ''){
          //alertStr("请输入当前密码");
          tip("请输入当前密码");
          return false;
      }

      if (newpassword == null || newpassword == '') {
          //alertStr("请输入新密码");
          tip("请输入新密码");
          return false;
      } else if(newpassword.length<6 || newpassword.length > 16){
          //alertStr("密码为6-16位字母加数字的组合，不得含特殊字符");
          tip("密码为6-16位字母加数字组合,不含特殊字符");
          return false;
//      } else if (passwordagain != newpassword) {
//          //alertStr("两次输入的密码不一致");
//          tip("两次输入的密码不一致");
//          return false;
      } else if (!(/^(([A-Za-z]+[0-9]+)|([0-9]+[A-Za-z]+))[A-Za-z0-9]*$/).test(newpassword)) {
          //alertStr("密码为6-16位字母加数字的组合，不得含特殊字符");
          tip("密码为6-16位字母加数字组合,不含特殊字符");
          return false;
      }

     /* if (code == null || code == "") {
          alertStr("请输入验证码");
          return false;
      }*/
    return true;
 }
  
  function alertStr(str){
    $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>'+str+'</h3></div></div>');
    setTimeout(function(){
        $('.tip-box').remove();
    },1000);
}

$("#password").focus(function(){
    $(this).attr("placeholder","");
});
$("#password").blur(function(){
    if ($(this).val()==null || $(this).val()=='') {
        $(this).attr("placeholder","当前密码");
    }
});
$("#newpassword").focus(function(){
    $(this).attr("placeholder","");
});
$("#newpassword").blur(function(){
    if ($(this).val()==null || $(this).val()=='') {
        $(this).attr("placeholder","请设置登录密码");
    }
});
  $("#newpasswordagain").focus(function(){
      $(this).attr("placeholder","");
  });
  $("#newpasswordagain").blur(function(){
      if ($(this).val()==null || $(this).val()=='') {
          $(this).attr("placeholder","请再次输入密码");
      }
  });

      $(".bar-bottom a").removeClass("selected");
      $(".bar-bottom a:eq(3)").addClass("selected");
</script>
</body>
</html>