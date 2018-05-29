<!doctype html>
<html lang="en" style="overflow-y:hidden;">
<head>
<#assign basePath=request.contextPath>
    <meta charset="UTF-8">
    <title>登录${topmap.systembase.bsetName}</title>
    <link rel="stylesheet" type="text/css" href="${basePath}/css/pages.css" />
    <link rel="stylesheet" type="text/css" href="${basePath}/css/jd.base.min.css"/>
    <link rel="stylesheet" type="text/css" href="${basePath}/css/jd.style.css"/>
    <style>
        .n_row .n_btn_a{
            height: 40px;
            background: #ec6a1e;
            color: #fff;
            text-align: center;
            line-height: 40px;
            font-size: 16px;
            border-radius: 3px;
            border: none;
            display: block;
            font-family: "微软雅黑";
            cursor: pointer;
            width:48.3%;
            float:left;
            margin-right:10px;
        }
        #login_name{ width: 18px;height: 18px;background: url(images/user.png) no-repeat; position: absolute; top: 9px; left: 12px;}
        #login_code{ width: 18px;height: 22px;background: url(images/code.png) no-repeat; position: absolute; top: 8px; left: 12px;}
        input:-webkit-autofill {
            -webkit-box-shadow: 0 0 0px 1000px white inset;
            -webkit-text-fill-color: #333;
        }
        .footer{
            border:none!important;
        }
        /*shg*/
        html, body {
            height: 100% !important;
            overflow: auto!important;
        }
        .rightpar{
            display: none;
        }
        .border{
            border: 1px solid #000000!important;
        }
        :-moz-placeholder { /* Mozilla Firefox 4 to 18 */
            color:#868686;
        }

        ::-moz-placeholder { /* Mozilla Firefox 19+ */
            color:#868686;
        }

        input:-ms-input-placeholder{
            color: #868686;
        }

        input::-webkit-input-placeholder{
            color: #868686;
        }
        .piaochecked {
            width: 14px;
            height: 14px;
            float: left;
            cursor: pointer;
            text-align: center;
            background-image: url(${basePath}images/bg_blank.png);
            background-repeat: no-repeat;
            background-position: 0 0;
            margin-top: 2px;
        }
        .on_check {
            width: 14px;
            height: 14px;
            float: left;
            cursor: pointer;
            text-align: center;
            background-image: url(${basePath}images/bg_blank1.png);
            background-repeat: no-repeat;
            background-position: 0 0;
            margin-top: 3px;
        }/*
        .re {
            opacity: 0;
            cursor: pointer;
            -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=0)";
            filter: alpha(opacity=0);
        }*/
        /*     @media screen and (min-width: 1349px) and (max-width: 1903px){
                 .adaptive{
                     width: 100%!important;
                     background-size:100% 100%;
                     background-position:-147px 0px!important;
                 }

             }
             @media screen and(min-width: 1080px) and(max-width: 1349px){
                 .adaptive{
                     width: 100%!important;
                     background-size: 100% 100%;
                     background-position:-286px 0px!important;
                 }
             }*/
        .adaptive{
            background: url(${basePath}/images/dl_img.png) no-repeat;
            position: absolute;
            left: 0;
            top: 0;
            width: 100%;
            margin: 0 auto;
            background-position:50% 50%;
            height: 500px;
        }
        .new_login_con .cw_error{
            position:absolute;
            line-height:36px;
            left: 0;
            top: 0;
            width: 100%;
            height: 36px;
            background-image: linear-gradient(-128deg, #FA6C6C 0%, #F43A3A 100%);
        }
        .new_login_con .cw_error{
            text-align: center;
            color: #ffffff;
            font-size: 12px;
            letter-spacing: 1.71px;
        }
        .loading{
            height: 36px;
            color: rgb(255, 255, 255);
            text-align: center;
            line-height: 36px;
            font-size: 14px;
            letter-spacing: 0.5px;
            display: block;
            width: 100%;
            font-family: 微软雅黑;
            cursor: pointer;
            background:  #00991D url(${basePath}/images/tigger_green.gif) no-repeat 50%;
            border-radius: 3px;
            border-width: initial;
            border-style: none;
            border-color: initial;
            border-image: initial;
            background-size: 15%!important;

        }
        .login_span_sj{
            display: block;
            position: relative;
            border-top:1px solid #eeeeee;
            width: 99%;
            height: 1px;
            margin-left: 1px;

        }
        .login_span_sj p{
            display: block;
            position: absolute;
            left: 32%;
            top: -11px;
            padding: 0px 15px 0px 15px;
            background-color: #fff;font-size: 10px;
            color: #7F7F7F;
            letter-spacing: 0.42px;
        }
        .login_img_sj img{
            width: 30px;
            height: 30px;
            margin-right: 6px;
            cursor: pointer;
            transition: all 0.6s;
        }
        .login_img_sj a:first-of-type{
            margin-left: 10px;
        }
        .login_img_sj a:last-of-type{
            margin-right: 0px;
        }
        .login_img_sj a{
            margin-right: 38px;
            font-size: 10px;
            color: #7F7F7F;
            letter-spacing: 0;
        }
        .login_img_sj {
            margin-top: 20px;
        }
        .login_img_sj img:hover{
            transform: scale(1.25);
            -webkit-transform: scale(1.25);
            -ms-transform: scale(1.25);
        }
    </style>
<#if (topmap.systembase.bsetHotline)??>
    <link rel = "Shortcut Icon" href="${(topmap.systembase.bsetHotline)!''}">
<#else>
    <link rel = "Shortcut Icon" href="${basePath}/images/Paistore.ico">
</#if>
    <script type="text/javascript" src="${basePath}/js/jquery.js"></script>

</head>
<body>
<#include "../index/newheader3.ftl"/>

<#--<div class="container">-->
<#--<div class="head2">-->
<#--<a href="${topmap.systembase.bsetAddress}"><img id="logo_pic" alt="" src="" style="height:45px;width:auto;"></a><h1>欢迎2登录</h1>-->
<#--</div>-->
<#--</div>-->
<div style="overflow: hidden;position: relative;height: 500px;" >
    <div class="adaptive">
        <div class="n_login_bg" style="background-position:center center; background-repeat: no-repeat;height:500px;width:1200px;margin:0px auto;">
            <div class="container" style="width:1200px;">
                <div class="new_login clearfix">
                    <div class="new_login_con" style="position: relative;">
                    <#--错误提示-->
                        <div class="cw_error hide">
                        </div>
                    <#--end-->
                        <div class="n_title clearfix">
                            <span>会员登录</span>
                            <a href="${basePath}/register.html?beforeRegUrl=${basePath}${url}" style="    text-align: center;float:right;font-size: 12px;color: #000000;letter-spacing: 1.71px;">立即注册</a>
                        <#--<p style="display:none;position: absolute;top: 380px;"><span style="color:red;font-size: 14px;">注：密码输入错误6次将会锁定账号</span></p>-->
                        </div><!--n_title-->
                        <div style="margin-top: 26px;">
                            <form id="login_form" name="" action="${basePath}/signin.html" method="post">
                                <div class="n_row" style="margin-bottom:20px;">
                                    <input type="text" maxLength="40" name="username" value="${username!''}" placeholder="已验证手机/邮箱/用户名" class="n_text" id="log_user"/>
                                    <span id="login_name"></span>
                                </div>
                                <div class="n_row" style="margin-bottom:11px;">
                                    <input  maxLength="20" type="password" name="password" placeholder="密码" class="n_text" id="log_code" oncopy="return false;" oncut="return false;" onpaste="return false" onfocus="removeError()"/>
                                    <span id="login_code"></span>
                                </div>
                                <div class="n_row clearfix" style="margin-bottom: 25px;">
                                    <a href="${basePath}/findpwd.html" class="fr" style="font-size: 12px;color: #868686;letter-spacing: 1.71px;position: absolute;right: -5px;">忘记密码？</a>
                                    <div id="piao" class="piaochecked "><#--<input type="checkbox" name="remember" class="re">--></div><label style="margin-top: -3px;letter-spacing: 1.71px;">&nbsp;记住账号</label>
                                    <!--<input type="checkbox" name="remember" class="re "><label>&nbsp;&nbsp;自动登录</label>-->
                                </div>
                                <input type=hidden id="urlhide" value="${url}" />
                                <div class="n_row clearfix">
                                    <input type="button" name="login"  id="login_btn"
                                    <#if isTemp??&&isTemp=='1'>
                                           class="n_btn_a"
                                    <#else>
                                           class="n_btn"
                                    </#if>value="登录"/>
                                <#if isTemp??&&isTemp=='1'>
                                    <input type="button" name="suorder" id="suborder_btn" class="n_btn_a" style="margin-right:0; background:#cc3333;" value="一键下单" />
                                </#if>

                                </div><!--n_row-->
                            </form>
                            <div class="n_row" style="margin-bottom: 0px;margin-top: 30px;">
                       <span class="login_span_sj">
                            <p class="f14 col6">社交账号登录</p>
                       </span>
                                <div class=" login_img_sj"  >
                                <#if t??>
                                    <#list t as tt >
                                        <#if tt.authType == '1'>
                                            <a href="loginqq.html?preurl=${url}" class="mr20"><img src="images/icon_qq@2x.png"/>QQ</a><!--腾讯QQ&ndash;&gt;-->
                                        <#--   <a href="#" class="mr20"><img src="images/q2.png"/></a><!--支付宝&ndash;&gt;&ndash;&gt;-->
                                        <#elseif tt.authType == '7'>
                                            <a href="loginweixin.html?preurl=${url}" class="mr20"><img src="images/icon_wechat@2x.png"/>微信</a><!--微信&ndash;&gt;-->
                                        <#elseif tt.authType == '2'>
                                            <a href="loginsina.html?preurl=${url}" class="mr20"><img src="images/icon_weibo@2x.png"/>微博</a><!--新浪微博&ndash;&gt;-->



                                        <#--<!--<a href="#"><img src="images/q5.png"/></a>&ndash;&gt;<!--人人&ndash;&gt;-->
                                        <#--<#elseif tt.authType == '11'>-->
                                        <#--<a href="logintaobao.html?preurl=${url}" class="mr20"><img src="images/q2.png"/></a><!--淘宝登陆&ndash;&gt;-->
                                        </#if>
                                    </#list>
                                </#if>
                                </div>
                            </div>

                        <#if isTemp??&&isTemp=='1'>
                            <form  action="order/suborder.html" method="post" class="suborder_form">
                                <#list box as b>
                                    <input type="hidden" name="box" value="${b}">
                                </#list>
                                <input type="hidden" value="1" name="isTemp">
                            </form>
                        </#if>

                        </div><!--mt20-->
                    </div><!--new_login_con-->

                </div><!--new_login-->

            </div><!--container-->

        </div><!--n_login_bg-->
    </div>
</div>

<#--shf-->
<#--<div class="footer_tab">-->
<#--<ul>-->

<#--<li class="list1"><a href="${basePath}/channel/237.html">食品荟萃</a></li>-->
<#--<li class="list2"><a href="${basePath}/channel/239.html">饮品总汇</a></li>-->
<#--<li class="list3"><a href="${basePath}/channel/241.html">购物中心</a></li>-->
<#--<li class="list4"><a href="${basePath}/channel/243.html">大药房</a></li>-->

<#--</ul>-->
<#--</div>-->
<#include "../index/newbottom.ftl">


<#--<li class="list4"><a style="text-indent:17px;" href="#" target="_self">大 药 房</a></li>-->
<#--</ul>-->
<#--</div>-->
<#--<#if (topmap.temp)??>-->
<#--<#if (topmap.temp.tempId==1)>-->
<#--<#include "../index/bottom.ftl">-->
<#--<#else>-->
<#--<#include "../index/newbottomLogo.ftl" />-->
<#--</#if>-->
<#--</#if>-->
<script type="text/javascript" src="${basePath}/index_960/js/app.js"></script>
<script type="text/javascript">
    //    $(document).ready(function(){
    //        var random_bg=Math.floor(Math.random()*4+1);
    //        var bg='url(images/bg_'+random_bg+'.jpg)';
    //        $(".n_login_bg").css("background-image",bg);
    //    });
    var flag = true;
    $(".piaochecked").click(function() {
        if( flag ){
            $(".piaochecked").removeClass("piaochecked").addClass("on_check");
            flag = false;
        } else {
            $(".on_check").removeClass("on_check").addClass("piaochecked");
            flag = true;
        }
    });

    $(".n_text").on("focus",function () {
        $(this).addClass("border")
    })
    $(".n_text").on("blur",function () {
        $(this).removeClass("border")
    })
    $(function(){
        $("input[type='text']").blur(function(){
            $(this).next().next().hide();
        });

        $.ajax({
            url: 'loadlogo.htm',
            success: function(data){
                $("#logo_pic").prop("src",data.logo.bsetLogo);
                /* $(".n_login_bg").css("background-image",'url('+data.logo.siteLoginImg+')');*/
                //$("#loginImg").prop("src",data.logo.siteLoginImg);
            }
        });

        $("#login_btn").click(function(){
            login();
        });

        $("#suborder_btn").click(function(){
            $(".suborder_form").submit();
        });
    });
    function removeError(){
        $(".cw_error").addClass("hide")

    }
    function login(){
        if($("#login_btn").hasClass("loading")){
            return;
        }
        if(checkInput()){
            var type="";
            /*if($(".re").prop("checked")){
                type="0";
            }*/
            if($("#piao").hasClass("on_check")){
                type="0";
            }

            //if($(".au").prop("checked")){
            //if($(".re").prop("checked")){
            //type="1";
            //}
            //}
            $("input[type='text']").next().next().hide();
            $("#login_btn").removeClass("n_btn").addClass("loading");
            $("#login_btn").val("");
            //var url="checklogin-"+$("#log_user").val()+"-"+$("#log_psd").val()+"-"+$("#urlhide").val()+type;
            $.ajax({
                url: "checklogin.htm",
                type:"POST",
                data:{username:$("#log_user").val(),
                    password:$("#log_code").val(),
                    url:$("#urlhide").val(),
                    type:type},
                success: function(data){
                    if(data == 0){

                        $(".cw_error").removeClass("hide").html('密码和账户不匹配，请重新输入');
                        $("#login_btn").val("登录").removeClass("loading").addClass("n_btn");
                    }else if(data == 8){
                        $(".cw_error").removeClass("hide").html('该账户已经被锁定，请在30分钟后再次登录');
                        $("#login_btn").val("登录").removeClass("loading").addClass("n_btn");
                    }else if(isNaN(data)){
                        if(typeof(data)=="string"){
                            window.location.href=data;
                        }else{
                            if(3<data.loginErrorCount && data.loginErrorCount<6){
                                $(".cw_error").removeClass("hide").html('密码错误6次将会锁定账号，您还有'+(6-data.loginErrorCount)+'次机会');
                                $("#login_btn").val("登录").removeClass("loading").addClass("n_btn");
                            }else if(data.loginErrorCount==6){
                                $(".cw_error").removeClass("hide").html('该账户已经被锁定，请在30分钟后再次登录');
                                $("#login_btn").val("登录").removeClass("loading").addClass("n_btn");
                            }else{
                                $(".cw_error").removeClass("hide").html('密码和账户不匹配，请重新输入');
                                $("#login_btn").val("登录").removeClass("loading").addClass("n_btn");
                            }
                        }
                    }else if(data == 2){
                        $(".cw_error").removeClass("hide").html('你输入的用户不存在，请重新输入');
                        $("#login_btn").val("登录").removeClass("loading").addClass("n_btn");
                    } else if (data == 3) {
                        $(".cw_error").removeClass("hide").html('你输入的用户已经冻结,请联系管理员解锁');
                        $("#login_btn").val("登录").removeClass("loading").addClass("n_btn");
                    }
                }
            });
        }
    }

    function checkInput(){

        var flag=false;
        var x = $("#log_user").val();
        if(x == '' && $("#log_code").val() == ''){

            $(".cw_error").removeClass("hide").html('请输入用户名和密码');

            return;
        }
        if(x == ''){
            $("#log_user").addClass('n_error');
            $(".cw_error").removeClass("hide").html('请输入用户名');
            return;
        }
        else{
            $("#log_user").removeClass('n_error');
            $(".cw_error").addClass("hide")
            flag=true;
        }
        var flagP=false;
        x = $("#log_code").val();
        var regS=/\s/g;
        if(regS.test(x)){
            $("#log_code").addClass('n_error');
            // $("#log_code").next().addClass('tips_error');
            $(".cw_error").removeClass("hide").html('请勿输入空格');
            $("#log_code").val("");
            return;
        }
        else if(x == ''){
            $("#log_code").addClass('n_error');
            //$("#log_code").next().addClass('tips_error');
            $(".cw_error").removeClass("hide").html('请输入密码');
            return;
        }
        else{
            $("#log_code").removeClass('n_error');
            $(".cw_error").addClass("hide")
            flagP=true;
        }
        return flag&&flagP;
    }
    function isUser(x){
        var reg = /^\w+[@\.]?$/;
        if((x.length >=6) && (x.length <= 20)){
            return true;
        }
        else{
            return false;
        }
    }
    document.onkeydown=function(event){
        var e = event || window.event || arguments.callee.caller.arguments[0];
        if(e && e.keyCode==13){ // enter 键
            login();
        }
    };
</script>
</body>
</html>