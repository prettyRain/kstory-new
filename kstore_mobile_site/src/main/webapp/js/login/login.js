/**
 *
 */

$(".input-login").on("touchstart",function (e) {
    $("input").blur();

    if($(this).hasClass("nextGreen")){

        var varification = "";
        if ($('#codeDiv').is(':visible')) {
            varification = $("#code").val();
        }
        if($(this).hasClass("load")){
            return
        }else{
            $(this).addClass("load");
            $(this).html("登录中");
        }


    if (checkInput()) {
        $("input[type='text']").next().hide();
        var url = "checklogin.htm?username=" + $("#log_user").val() + "&password="
            + $("#log_psd").val() + "&url=" + $("#urlhide").val() + "&code=" + varification + "&keeppwd=" + $("#keeppwd").val();
        var li_li = $("#login .li_li");
        $.ajax({
            url: url,
            success: function (data) {
                if (isNaN(data)) {
                    window.location.href = data;
                } else if (data == 3) {
                    //alertStrNew("验证码错误");
                } else if (data == 2) {
                    $(li_li).eq(0).addClass("error").find("p").html("手机号不存在 <img src='../../images/v3/falut@2x.png'>").show();
                } else if (data == 4) {
                    $(li_li).addClass("error").eq(1).find("p").html("手机号密码不匹配 <img src='../../images/v3/falut@2x.png'>").show();
                } else if (data == 5) {
                    $(li_li).addClass("error").eq(1).find("p").html("账户已锁定，请联系客服人员 <img src='../../images/v3/falut@2x.png'>").show()
                } else if (data == 0) {
                    $(li_li).addClass("error").eq(1).find("p").html("用户名被冻结,请联系管理员解锁 <img src='../../images/v3/falut@2x.png'>").show()
                } else {
                    $(li_li).addClass("error").eq(1).find("p").html("手机号密码不匹配 <img src='../../images/v3/falut@2x.png'>").show();
                }
                $(".input-login").removeClass("load").html("登录");
                // if (isNaN(data)) {
                //     window.location.href = data;
                // } else if (data == 3) {
                //     alertStrNew("验证码错误");
                //     $(".eye").show();
                //     $("#code_image").click();
                //     $(".valid_img").show();
                // } else if (data == 2) {
                //     alertStrNew("用户名不存在");
                //     $(".eye").show();
                //     $("#code_image").click();
                //     $(".valid_img").show();
                // } else if (data == 4) {
                //     alertStrNew("用户名和密码不匹配");
                //     $(".eye").show();
                //     $("#code_image").click();
                //     $(".valid_img").show();
                // } else if (data == 5) {
                //     alertStrNew("该账户已经被锁定，请在30分钟后再次登录");
                //     $("#codeDiv").show();
                //     $("#codeDiv .valid_img").show();
                //     $(".eye").show();
                //     $("#code_image").click();
                //     $(".valid_img").show();
                // } else if (data == 0) {
                //     alertStrNew("用户名被冻结,请联系管理员解锁");
                //     $("#codeDiv").show();
                //     $("#codeDiv .valid_img").show();
                //     $(".eye").show();
                //     $("#code_image").click();
                //     $(".valid_img").show();
                // } else {
                //     alertStrNew("用户或者密码错误，请重新输入");
                //     $(".eye").show();
                //     $("#code_image").click();
                //     $(".valid_img").show();
                // }
            }
        });
    }
}
e.preventDefault();//阻止“默认行为”
})
//注册协议
function xieyi(){
	window.location.href='getXieYi.htm';
}



function checkInput() {
	var x = $("#log_user").val();
	if (x == '' || x == null) {
        $("#login .li_li").eq(0).addClass("error").find("p").html("请输入手机号 <img src='../../images/v3/falut@2x.png'>").show();
        $(".input-login").removeClass("load").html("登录");
        return false;
	} else if (x != '' && x != null && !isUser(x)) {
        $("#login .li_li").eq(0).addClass("error").find("p").html("手机号格式错误 <img src='../../images/v3/falut@2x.png'>").show();
        $(".input-login").removeClass("load").html("登录");
        return false;
	}
	x = $("#log_psd").val();
	if (x == '' || x == null) {
        $("#login .li_li").addClass("error").eq(1).find("p").html("请输入密码 <img src='../../images/v3/falut@2x.png'>").show()
        $(".input-login").removeClass("load").html("登录");
        return false;
	}
	//else if(!(/^[A-Za-z0-9\\w]{6,20}$/).test(x)){
	//	$('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>密码格式必须是6-20位字母数字组合</h3></div></div>');
     //   setTimeout(function(){
     //       $('.tip-box').remove();
     //   },1000);
     //   return false;
	//}
    // if(($('#codeDiv').is(':visible'))&&($("#code").val()==null ||$("#code").val()=='')){
     //    alertStrNew("请输入验证码");
     //    return false;
    // }
	return true;
}
// function alertStrNew(str){
//     $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>'+str+'</h3></div></div>');
//     $('.input-login').removeClass("nextGreen");
//     $(".tip-box").animate({top: "12%"});
//     setTimeout(function(){
//         $('.tip-box').remove();
//         $('.input-login').addClass("nextGreen");
//     },2500);
// }
function isUser(x) {
	// if ((x.length >= 4) && (x.length <= 30)) {
	if (x.length == 11) {
		return true;
	} else {
		return false;
	}
}
// document.onkeydown = function(event) {
// 	var e = event || window.event || arguments.callee.caller.arguments[0];
// 	if (e && e.keyCode == 13) { // enter 键
// 		login();
// 	}
// };
$(function(){
    $("input").bind('input porpertychange',function(){

        if (!($(this).val()==null || $(this).val()=='')) {
            $(this).next(".clean").show();
        }else{
            $(this).next(".clean").hide();
        }
    });
});





$("#log_user").focus(function(){
	$(this).attr("placeholder","");
    //$(this).next(".clean").show();
    if (!($(this).val()==null || $(this).val()=='')) {
        $(this).next(".clean").show();
    }
    $(".li_li").removeClass("error").find(".error").hide();
    $(this).parents(".li_li").addClass("focus1");
});
$("#log_user").blur(function(){
	if ($(this).val()==null || $(this).val()=='') {
		$(this).attr("placeholder","请输入手机号");
	}
    $(this).next(".clean").hide();
    $(this).parents(".li_li").removeClass("focus1");
});



$("#log_psd").focus(function(){
	$(this).attr("placeholder","");
    // $(this).next(".clean").show();
    if (!($(this).val()==null || $(this).val()=='')) {
        $(this).next(".clean").show();
    }
    $(".li_li").removeClass("error").find(".error").hide();
    $(this).parents(".li_li").addClass("focus1");
});
$("#log_psd").blur(function(){
	if ($(this).val()==null || $(this).val()=='') {
		$(this).attr("placeholder","请输入密码");

	}
    $(this).next(".clean").hide();
    $(this).parents(".li_li").removeClass("focus1");
});
$("#mobile").focus(function(){
    $(this).attr("placeholder","");
    //$(this).next(".clean").show();
    if (!($(this).val()==null || $(this).val()=='')) {
        $(this).next(".clean").show();
    }
    $(".li_li").removeClass("error").find(".error").hide();
    $(this).parents(".li_li").addClass("focus1");
});
$("#mobile").blur(function(){
    if ($(this).val()==null || $(this).val()=='') {
        $(this).attr("placeholder","请输入手机号");

    }
    $(this).next(".clean").hide();
    $(this).parents(".li_li").removeClass("focus1");
});
$("#code").focus(function(){
    $(this).attr("placeholder","");
    //$(this).next(".clean").show();
    if (!($(this).val()==null || $(this).val()=='')) {
        $(this).next(".clean").show();
    }
    $(".li_li").removeClass("error").find(".error").hide();
    $(this).parents(".li_li").addClass("focus1");
});
$("#code").blur(function(){
    if ($(this).val()==null || $(this).val()=='') {
        $(this).attr("placeholder","请输入验证码");

    }
    $(this).next(".clean").hide();
    $(this).parents(".li_li").removeClass("focus1");
});

$("#login .li_li:eq(0)").on("touchstart",".clean",function(){
    $("#log_user").val("");
    $(this).hide();
    $("#login .input-login").removeClass("nextGreen");
});
$("#login .li_li:eq(1)").on("touchstart",".clean",function(){
    $("#log_psd").val("");
    $(this).hide();
    $("#login .input-login").removeClass("nextGreen");
});
$("#reg .li_li:eq(0)").on("touchstart",".clean",function(){
    $("#mobile").val("");
    $(this).hide();
    $("#reg .input-reg").removeClass("nextGreen");
});
$("#reg .li_li:eq(1)").on("touchstart",".clean",function(){
    $("#code").val("");
    $(this).hide();
    $("#reg .input-reg").removeClass("nextGreen");
});

//注册页面

function codeNock(){
    if($(".get-confirmcode").html()=="正在获取"){
        return
    }else{
        $(".get-confirmcode").html("正在获取");
        $(".get-confirmcode").css({"color":"#25A702","background":"#fff"});
    }

    var li_reg = $("#reg .li_li");
    $(li_reg).removeClass("error").find("p").hide();

    if(!(/^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$/).test($("#mobile").val())){
        $(li_reg).eq(0).addClass("error").find("p").html("手机号格式错误 <img src='../../images/v3/falut@2x.png'>").show();
        $(".get-confirmcode").attr("onClick","codeNock();");
        $(".get-confirmcode").html("获取验证码");
        $(".get-confirmcode").css({"color":"#25A702","background":"#fff"});
        $("#mobile").removeAttr("readonly");
        return false;
    }
    if($(".get-confirmcode").hasClass("done")){
        $(".get-confirmcode").attr("onClick","codeNock();");
        $(".get-confirmcode").html("获取验证码");
        $(".get-confirmcode").css({"color":"#25A702","background":"#fff"});
        $("#mobile").removeAttr("readonly");
        return false;
    }else {
        $(".get-confirmcode").addClass("done");
    }
    $.ajax({
        url: "/sendcodereg.htm",
        type:"post",
        data:{mobile:$("#mobile").val(),checkCode:$("#code").val()},
        success:function(data){
            $(".get-confirmcode").removeClass("done");
            if(data == 1){
                //发送成功
                $(".get-confirmcode").html('60s');
                $(".get-confirmcode").attr('data-t','60');
                $(".get-confirmcode").attr("onClick","");
                $(".get-confirmcode").css({"color":"#199301","background":"#fff"});
                // $("#mobile").attr("readonly","readonly");
                setTimeout(countDown, 1000);
                $(li_reg).eq(1).find("p").html("发送成功 <img style='width: 10px;margin-bottom: 1px' src='../../images/v3/right@2x.png'>").show();
                $(li_reg).eq(1).find("p").addClass("correct");
            }else if(data == 2){
                $(li_reg).eq(0).addClass("error").find("p").removeClass("correct").html("手机号已存在 <img src='../../images/v3/falut@2x.png'>").show();
                $(".get-confirmcode").attr("onClick","codeNock();");
                $(".get-confirmcode").html("获取验证码");
                $(".get-confirmcode").css({"color":"#25A702","background":"#fff"});
                $("#mobile").removeAttr("readonly");
            }else if(data==3){
                $(li_reg).addClass("error").eq(1).find("p").removeClass("correct").html("图片验证不正确 <img src='../../images/v3/falut@2x.png'>").show();
                $(".get-confirmcode").attr("onClick","codeNock();");
                $(".get-confirmcode").html("获取验证码");
                $(".get-confirmcode").css({"color":"#25A702","background":"#fff"});
                $("#mobile").removeAttr("readonly");
            }else{
                //发送失败
                $(".get-confirmcode").attr("onClick","codeNock();");
                $(".get-confirmcode").html("获取验证码");
                $(".get-confirmcode").css({"color":"#25A702","background":"#fff"});
                $("#mobile").removeAttr("readonly");
                $(li_reg).eq(1).find("p").removeClass("correct").html("发送失败 <img src='../../images/v3/falut@2x.png'>").show();
            }
        }
    });
    // }
}

function countDown(){
    var time = $(".get-confirmcode").attr('data-t');
    $(".get-confirmcode").html((time - 1)+"s");
    $(".get-confirmcode").attr('data-t',(time - 1));
    time = time - 1;
    if (time < 1) {
        $(".get-confirmcode").attr("onClick","codeNock();");
        $(".get-confirmcode").html("重新获取");
        $(".get-confirmcode").css({"color":"#4A90E2","background":"#fff"});
        $("#mobile").removeAttr("readonly");
    } else {
        setTimeout(countDown, 1000);
    }
}



function subRegisterFirst() {
    $("#reg .li_li").removeClass("error").find("p").hide();
    if ($('.input-reg').hasClass("nextGreen")) {
        if($('.input-reg').hasClass("load")){
            return
        }else{
            $('.input-reg').addClass("load").html("加载中")
        }

        if(!(/^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$/).test($("#mobile").val())){
            $("#reg .li_li").eq(0).addClass("error").find("p").html("手机号格式错误 <img src='../../images/v3/falut@2x.png'>").show();
            $('.input-reg').removeClass("load").html("下一步");
            return false;
        }
        if(!($("#code").val().length == 6)){
            $("#reg .li_li").eq(1).addClass("error").find("p").removeClass("correct").html("验证码错误或已失效 <img src='../../images/v3/falut@2x.png'>").show();
            $('.input-reg').removeClass("load").html("下一步");
            return false;
        }
        var code = $("#code").val();
        var mobile = $("#mobile").val();
        $.ajax({
            url: "/customer/checkCode.htm?code=" + code,
            type: "post",
            success: function (data) {
                if (data == 1) {
                    $("#reg .li_li").eq(1).addClass("error").find("p").removeClass("correct").html("验证码错误或已失效 <img src='../../images/v3/falut@2x.png'>").show();
                    $('.input-reg').removeClass("load").html("下一步");
                    return false;
                }else {
                    $("#mobilehide").val(mobile);
                    $('.input-reg').removeClass("load").html("下一步");
                    $("#registerSecondForm").submit();
                }
            }
        });
    }
}





/*自动登录*/
$("li.no-login label").on("touchstart",function(e){
    if($(this).hasClass("active")){
        $(this).removeClass("active");
        $("#keeppwd").val(0);
    }else{
        $(this).addClass("active");
        $("#keeppwd").val(1);
    }
    e.preventDefault();
});
$("li.no-reg label").on("touchstart",function(e){
    if($(this).hasClass("active") ){
        $(this).removeClass("active");
        $("#reg .input-reg").removeClass("nextGreen");
    }else{
        $(this).addClass("active");
        if(($.trim($('#mobile').val())!=="")&&($.trim($('#code').val())!=="")){
            $("#reg .input-reg").addClass("nextGreen");
        }

    }
    e.preventDefault();
});


$(function(){
    // <#--登陆用户名和密码都填写了就变绿-->
    $('input').on('input change',function(){
        if($(this).attr("id") == "code"){
            $(this).val($(this).val().slice(0,6));
        }
        if(($.trim($('#log_user').val())!=="")&&($.trim($('#log_psd').val())!=="")){
            $('.input-login ').addClass("nextGreen");
        }else {
            $('.input-login').removeClass("nextGreen");
        }
        if(($.trim($('#mobile').val())!=="")&&($.trim($('#code').val())!=="")&&($("#reg .no label").hasClass("active"))){
            $('.input-reg').addClass("nextGreen");
        }else {
            $('.input-reg').removeClass("nextGreen");
        }
    });





});





var swiper = new Swiper('.swiper-container',{
    noSwiping : true
});




$(".login_reg").on("click","p",function(){
    $(".login_reg p").removeClass("active");
    $(this).addClass("active");
    var clickindex = $(this).parents("li").index();
    if(clickindex==0){
        $(".login_reg span").animate({"left":".75rem"},250,"linear");
        swiper.slideTo(clickindex, 500, false);
    }else{
        $(".login_reg span").animate({"left":"2.75rem"},250,"linear");
        swiper.slideTo(clickindex, 500, false);
    }
});




/* 显示密码 */
$("#login .li_li:eq(1)").on("touchstart",".show_password",function(){
    if($(this).attr('class').indexOf('selected') > 0){
        $(this).removeClass('selected');
        $(this).parent().find("input").attr('type','password');
    }
    else{
        $(this).addClass('selected');
        $(this).parent().find("input").attr('type','text');
    }
});



// 第三方登陆
$(".way").on("click",".login-way",function(){
    var way = $(this).find("p").html();
    var partType = parseInt($(this).attr("data-threePartType"));
    var preurl = $('#urlhide').val();
    var thirdParty;
    thirdParty = dialog({
        width: 260,
        title: '提示',
        content: '"960商城"想打开'+way,
        okValue: '打开',
        cancelValue: '取消',
        ok: function () {
           switch(partType){
               case 1:window.location.href="/loginmqq.html?preurl="+preurl;
                      break;
               case 2:window.location.href="/loginmwx.htm?preurl="+preurl;
                      break;
               case 3:window.location.href="/loginsina.html?preurl="+preurl;
                      break;
           }
            // window.location.href="${basePath}/logout.html";
        },
        cancel: function () {
            return true;
        }
    });
    thirdParty.showModal();
});


















