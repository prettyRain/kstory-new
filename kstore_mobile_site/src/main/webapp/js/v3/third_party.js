/*
 * 作者：shf
 * 时间：2018-5-7
 * 描述：第三方登陆
 *
 */

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

// Framework7
var myApp = new Framework7();
var $$ = Dom7;

// // 关闭面板
// $('.payPanel .affirm').on('click', function () {
//     //关闭输入密码面板
//     myApp.closeModal('.popup-about');
// });


$(function(){


    $("input").bind('input porpertychange',function(){
        $(".payPanel .prompt").removeClass("error").html("密码为6-16位数字加字母组合，不含特殊符号");
        if (!($(this).val()==null || $(this).val()=='')) {
            $(this).next(".clean").show();
            if($(this).hasClass("lpkPsd") && !$(".xieyi .active span").hasClass("unselected")){
                $(".affirm").addClass("affirmBtn")
            }
        }else{
            $(this).next(".clean").hide();
            if($(this).hasClass("lpkPsd")){
                $(".affirm").removeClass("affirmBtn")
            }
        }
        if(!($("#mobile").val()==null || $("#mobile").val()=='') && !($("#code").val()==null || $("#code").val()=='')){
            $(".input-next").addClass("nextGreen");
        }else{
            $(".input-next").removeClass("nextGreen");
        }
    });

    $(".bound_phone .li_li").on("touchstart",".clean",function(){
        $(this).prev().val("");
        $(this).hide();
        $(".input-next").removeClass("nextGreen");
    });

    $("#mobile").focus(function(){
        $(this).attr("placeholder","");
        if (!($(this).val()==null || $(this).val()=='')) {
            $(this).next(".clean").show();
        }
        $(".li_li").removeClass("error").find(".error").hide();
        $(this).parents(".li_li").addClass("focus1");
    }).blur(function(){
        if ($(this).val()==null || $(this).val()=='') {
            $(this).attr("placeholder","请输入手机号");
        }
        $(this).next(".clean").hide();
        $(this).parents(".li_li").removeClass("focus1");
    });
    $("#code").focus(function(){
        $(this).attr("placeholder","");
        if (!($(this).val()==null || $(this).val()=='')) {
            $(this).next(".clean").show();
        }
        $(".li_li").removeClass("error").find(".error").hide();
        $(this).parents(".li_li").addClass("focus1");
    }).blur(function(){
        if ($(this).val()==null || $(this).val()=='') {
            $(this).attr("placeholder","请输入验证码");
        }
        $(this).next(".clean").hide();
        $(this).parents(".li_li").removeClass("focus1");
    });



});


// 点击获取验证码
function codeNock(){
    var gc = $(".get-confirmcode");
    if($(gc).html()=="正在获取"){
        return
    }else{
        $(gc).html("正在获取");
        $(gc).css({"color":"#25A702","background":"#fff"});
    }

    var li_bp = $(".bound_phone .li_li");
    $(li_bp).removeClass("error").find("p").hide();

    if(!(/^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$/).test($("#mobile").val())){
        $(li_bp).eq(0).addClass("error").find("p").html("手机号格式错误 <img src='../../images/v3/falut@2x.png'>").show();
        $(gc).attr("onClick","codeNock();");
        $(gc).html("获取验证码").css({"color":"#25A702","background":"#fff"});
        $("#mobile").removeAttr("readonly");
        return false;
    }
    if($(gc).hasClass("done")){
        $(gc).attr("onClick","codeNock();");
        $(gc).html("获取验证码").css({"color":"#25A702","background":"#fff"});
        $("#mobile").removeAttr("readonly");
        return false;
    }else {
        $(gc).addClass("done");
    }
    $.ajax({
        url: "/sendcoderegNew.htm",
        type:"post",
        data:{mobile:$("#mobile").val()},
        success:function(data){
            $(gc).removeClass("done");
            if(data == 1){
                //发送成功
                $(gc).html('60s');
                $(gc).attr('data-t','60');
                $(gc).attr("onClick","");
                $(gc).css({"color":"#199301","background":"#fff"});
                // $("#mobile").attr("readonly","readonly");
                setTimeout(countDown, 1000);
                $(li_bp).eq(1).find("p").html("发送成功 <img style='width: 10px;margin-bottom: 1px' src='../../images/v3/right@2x.png'>").show();
                $(li_bp).eq(1).find("p").addClass("correct");
            }else{
                //发送失败
                $(gc).attr("onClick","codeNock();");
                $(gc).html("获取验证码").css({"color":"#25A702","background":"#fff"});
                $("#mobile").removeAttr("readonly");
                $(li_bp).eq(1).addClass("error").find("p").removeClass("correct").html("发送失败 <img src='../../images/v3/falut@2x.png'>").show();
            }
        }
    });
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


function subThirdParty(){
    $(".bound_phone .li_li").find("p").hide();
    if ($('.input-next').hasClass("nextGreen")) {

        if(!(/^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$/).test($("#mobile").val())){
            $(".bound_phone .li_li").eq(0).find("p").html("手机号格式错误 <img src='../../images/v3/falut@2x.png'>").show();
            return false;
        }
        if(!($("#code").val().length == 6)){
            $(".bound_phone .li_li").eq(1).addClass("error").find("p").removeClass("correct").html("验证码错误或已失效 <img src='../../images/v3/falut@2x.png'>").show();
            return false;
        }
        var code = $("#code").val();
        var mobile = $("#mobile").val();
        //1：code错误  2：未注册  3：该手机号已与这种登录方式绑定  4：用户被冻结  5：用户被锁定
        $.ajax({
            data:$("#partform").serialize(),
            url: "/checkCodeAndLonginPart.htm?code=" + code+"&mobile="+mobile,
            type: "post",
            success: function (data) {
                if (data == '1') {
                    $(".bound_phone .li_li").eq(1).addClass("error").find("p").removeClass("correct").html("验证码错误或已失效 <img src='../../images/v3/falut@2x.png'>").show();
                }else if(data=='3'){
                    //手机号已与该绑定方式绑定  现在不能绑定
                    /*$("#mobilehide").val(mobile);
                    $('.input-reg').removeClass("load").html("下一步");
                    $("#registerSecondForm").submit();*/
                    var partName = "";
                    switch(parseInt($("#partType").val())){
                        case 1:partName="QQ";break;
                        case 2:partName="微信";break;
                        case 3:partName="微博";break;
                    };
                    $(".bound_phone .li_li").eq(0).find("p").html("手机号已与"+partName+"绑定 <img src='../../images/v3/falut@2x.png'>").show();
                }else if(data=='2'){
                    $('.popup-about .price').html(mobile.toString());
                    $('.popup-about .price').html(mobile.toString().substring(0,3)+"****"+mobile.toString().substring(7));
                    //打开输入面板
                    myApp.popup('.popup-about');
                }else if(data=='4'){
                    $(".bound_phone .li_li").eq(0).find("p").html("用户已冻结 <img src='../../images/v3/falut@2x.png'>").show();
                }else if(data=='5'){
                    $(".bound_phone .li_li").eq(0).find("p").html("用户已锁定 <img src='../../images/v3/falut@2x.png'>").show();
                }else if(isNaN(Number(data))){
                    window.location.href=data;
                }
            }
        });


    }

}

// 弹出面板
$(".psdWarp").on("touchstart",".clean",function(){
    $(this).prev().val("");
    $(this).hide();
    $(".affirm").removeClass("affirmBtn")
});

$("#lpk_psd").focus(function(){
    $(".payPanel .prompt").removeClass("error").html("密码为6-16位数字加字母组合，不含特殊符号");
    $(this).attr("placeholder","");
    if (!($(this).val()==null || $(this).val()=='')) {
        $(this).next(".clean").show();
    }
    $(".prompt").removeClass("error");
}).blur(function(){
    if ($(this).val()==null || $(this).val()=='') {
        $(this).attr("placeholder","请输入登录密码");
    }
    $(this).next(".clean").hide();
});


$(".psdWarp").on("touchstart",".show_password",function(){
    if($(this).attr('class').indexOf('selected') > 0){
        $(this).removeClass('selected');
        $(this).parent().find("input").attr('type','password');
    }
    else{
        $(this).addClass('selected');
        $(this).parent().find("input").attr('type','text');
    }
});

$(".xieyi .active").on("touchstart","span",function(){
    if($(this).hasClass("unselected") && !($("#lpk_psd").val()==null || $("#lpk_psd").val()=='')){
        $(".affirm").addClass("affirmBtn")
    }else{
        $(".affirm").removeClass("affirmBtn")
    }
    $(this).toggleClass("unselected");
});

$(".payPanel").on("touchstart",".affirm",function(){
    if(!$(this).hasClass("affirmBtn")){
        return false;
    }
    var newPsd = $("#lpk_psd").val();
    if (newPsd.length < 6 || newPsd.length > 16) {
        $(".payPanel .prompt").addClass("error").html("设置密码格式有误 <img src='../../images/v3/falut@2x.png'>");
        $(this).removeClass("affirmBtn");
        return false;
    } else if (!(/^(([A-Za-z]+[0-9]+)|([0-9]+[A-Za-z]+))[A-Za-z0-9]*$/).test(newPsd)) {
        $(".payPanel .prompt").addClass("error").html("设置密码格式有误 <img src='../../images/v3/falut@2x.png'>");
        $(this).removeClass("affirmBtn");
        return false;
    }
    $.ajax({type:"get"
        ,data:$("#partform").serialize()
        ,url:"/registerNew.htm?mobile="+$("#mobile").val()+"&password="+newPsd+"&repassword="+newPsd
        ,success:function(data){
              console.log(data);
              if(isNaN(data)){
                  window.location.href=data;
              }else{
                  window.location.href="intoPage/activity/gocoupon.html";
              }
        }
    })
    //关闭输入密码面板
    myApp.closeModal('.popup-about');


});
