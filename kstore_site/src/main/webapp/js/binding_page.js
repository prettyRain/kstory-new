
var handlerPopup = function (captchaObj) {


    // 成功的回调
    captchaObj.onSuccess(function () {
        var validate = captchaObj.getValidate();
        var url = getQueryString("myurl");
        console.log(url);
        $.ajax({
            url: "/checkbangding.htm", // 进行二次验证
            type: "post",
            dataType: "json",
            data: {
                username: $('#username1').val(),
                password: $('#password1').val(),
                threePartType:$("#threePartType").val(),
                url: url,
                geetest_challenge: validate.geetest_challenge,
                geetest_validate: validate.geetest_validate,
                geetest_seccode: validate.geetest_seccode
            },
            success: function (data) {
                console.log(data)
                if (data && (data.status === "success")) {
                    window.location.href=data.url
                    // login();
                } else {
                    $("."+data.filed).removeClass("hide").html(data.msg);
                }
            }
        });
    });
    $("#popup-submit").click(function () {
        if(checkInput()){

            captchaObj.show();

        }
    });
    // 将验证码加到id为captcha的元素里
    captchaObj.appendTo("#popup-captcha");
    // 更多接口参考：http://www.geetest.com/install/sections/idx-client-sdk.html
};



var handlerPopup2 = function (captchaObj) {


    // 成功的回调
    captchaObj.onSuccess(function () {
        var validate = captchaObj.getValidate();
        var url = getQueryString("myurl");
        console.log(url);
        $.ajax({
            url: "/checkwanshan.htm", // 进行二次验证
            type: "post",
            dataType: "json",
            data: {
                mobile: $('#register_phone').val(),
                password: $('#register_password').val(),
                mobileCode: $('#register_yzm').val(),
                threePartType:$("#threePartType").val(),
                url:url
            },
            success: function (data) {
                console.log(data)
                if (data && (data.status === "success")) {
                    window.location.href=data.url
                    // login();
                } else {
                    $("."+data.filed).removeClass("hide").html(data.msg);
                }
            }
        });
    });
    /*立即注册点击事件*/
    $("#register_submit").click(function () {
        if(!$(".icheckbox_square-green").hasClass("checked")){
            $(".agreement_dia").show();
        }else {
            if(registerInput()) {
                captchaObj.show();
            }
        }

    });
    // 将验证码加到id为captcha的元素里
    captchaObj.appendTo("#popup-captcha");
    // 更多接口参考：http://www.geetest.com/install/sections/idx-client-sdk.html
};



function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]);
    return null;
}
// 验证开始需要向网站主后台获取id，challenge，success（是否启用failback）
$.ajax({
    url: "/gtRegister.htm?t=" + (new Date()).getTime(), // 加随机数防止缓存
    type: "get",
    dataType: "json",
    success: function (data) {
        // 使用initGeetest接口
        // 参数1：配置参数
        // 参数2：回调，回调的第一个参数验证码对象，之后可以使用它做appendTo之类的事件
        initGeetest({
            gt: data.gt,
            challenge: data.challenge,
            product: "popup", // 产品形式，包括：float，embed，popup。注意只对PC版验证码有效
            offline: !data.success // 表示用户后台检测极验服务器是否宕机，一般不需要关注
            // 更多配置参数请参见：http://www.geetest.com/install/sections/idx-client-sdk.html#config
        }, handlerPopup);
    }
});

// 验证开始需要向网站主后台获取id，challenge，success（是否启用failback）
$.ajax({
    url: "/gtRegister.htm?t=" + (new Date()).getTime(), // 加随机数防止缓存
    type: "get",
    dataType: "json",
    success: function (data) {
        // 使用initGeetest接口
        // 参数1：配置参数
        // 参数2：回调，回调的第一个参数验证码对象，之后可以使用它做appendTo之类的事件
        initGeetest({
            gt: data.gt,
            challenge: data.challenge,
            product: "popup", // 产品形式，包括：float，embed，popup。注意只对PC版验证码有效
            offline: !data.success // 表示用户后台检测极验服务器是否宕机，一般不需要关注
            // 更多配置参数请参见：http://www.geetest.com/install/sections/idx-client-sdk.html#config
        }, handlerPopup2);
    }
});
function removeError(){
    $(".cw_error").addClass("hide");
    $(".cw_error1").addClass("hide");
    $("#username1").removeClass("n_error");
    $("#password1").removeClass("n_error");
}
function login(){
    if(checkInput()){
        var type="";
        $("input[type='text']").next().next().hide();
        $.ajax({
            url: "checklogin.htm",
            type:"POST",
            data:{username:$("#username1").val(),
                password:$("#password1").val(),
                url:$("#urlhide").val(),
                type:type},
            success: function(data){
                if(data == 0){
                    $("#password1").addClass('n_error');
                    $(".cw_error1").removeClass("hide").html('密码和账户不匹配，请重新输入');
                }else if(data == 8){
                    $("#username1").addClass('n_error');
                    $(".cw_error").removeClass("hide").html('该账户已经被锁定，请在30分钟后再次登录');
                }else if(isNaN(data)){
                    if(typeof(data)=="string"){
                        window.location.href=data;
                    }else{
                        if(3<data.loginErrorCount && data.loginErrorCount<6){
                            $("#password1").addClass('n_error');
                            $(".cw_error1").removeClass("hide").html('密码错误6次将会锁定账号，您还有'+(6-data.loginErrorCount)+'次机会');
                        }else if(data.loginErrorCount==6){
                            $("#username1").addClass('n_error');
                            $(".cw_error").removeClass("hide").html('该账户已经被锁定，请在30分钟后再次登录');
                        }else{
                            $("#password1").addClass('n_error');
                            $(".cw_error1").removeClass("hide").html('密码和账户不匹配，请重新输入');
                        }
                    }
                }else if(data == 2){
                    $("#username1").addClass('n_error');
                    $(".cw_error").removeClass("hide").html('你输入的用户不存在，请重新输入');

                } else if (data == 3) {
                    $("#username1").addClass('n_error');
                    $(".cw_error").removeClass("hide").html('你输入的用户已经冻结,请联系管理员解锁');

                }
            }
        });
    }
    return false;
}
function checkInput(){
    var flag=false;
    var x = $("#username1").val();
    if(x == '' && $("#password1").val() == ''){
        $(".cw_error").removeClass("hide").html('请输入用户名和密码');
        $("#username1").addClass('n_error');
        $("#password1").addClass('n_error');
        return;
    }
    if(x == ''){
        $("#username1").addClass('n_error');
        $(".cw_error").removeClass("hide").html('请输入用户名');
        return;
    }
    else{
        $("#username1").removeClass('n_error');
        $(".cw_error").addClass("hide")
        flag=true;
    }
    var flagP=false;
    x = $("#password1").val();
    var regS=/\s/g;
    if(regS.test(x)){
        $("#password1").addClass('n_error');
        // $("#log_code").next().addClass('tips_error');
        $(".cw_error1").removeClass("hide").html('请勿输入空格');
        $("#password1").val("");
        return;
    }
    else if(x == ''){
        $("#password1").addClass('n_error');
        //$("#log_code").next().addClass('tips_error');
        $(".cw_error1").removeClass("hide").html('请输入密码');
        return;
    }
    else{
        $("#password1").removeClass('n_error');
        $(".cw_error").addClass("hide")
        flagP=true;
    }
    return flag&&flagP;
}


/*立即注册*/
function removeError1(){
    $(".cw_errorone").addClass("hide");
    $(".cw_errortwo").addClass("hide");
    $(".cw_errorthree").addClass("hide");
    $("#register_phone").removeClass("n_error");
    $("#register_password").removeClass("n_error");
    $("#register_yzm").removeClass("n_error");
}

/*立即注册验证*/
function registerInput(){

    var flag=false;
    var x = $("#register_phone").val();
    if(x == '' && $("#register_password").val() == ''){
        $(".cw_errorone").removeClass("hide").html('请输入手机号');
        $(".cw_errortwo").removeClass("hide").html('请输入密码');
        $(".cw_errorthree").removeClass("hide").html('请输入验证码');
        $("#register_phone").addClass('n_error');
        $("#register_password").addClass('n_error');
        $("#register_yzm").addClass('n_error');
        return;
    }
    if(x == ''){
        $("#register_phone").addClass('n_error');
        $(".cw_errorone").removeClass("hide").html('请输入手机号');
        return;
    }
    else{
        $("#register_phone").removeClass('n_error');
        $(".cw_errorone").addClass("hide")
        flag=true;
    }

    var flagP=false;
    x = $("#register_password").val();
    var regS=/\s/g;
    if(regS.test(x)){
        $("#register_password").addClass('n_error');
        // $("#log_code").next().addClass('tips_error');
        $(".cw_errortwo").removeClass("hide").html('请勿输入空格');
        $("#register_password").val("");
        return;
    }
    else if (x.length < 6 || x.length > 16) {
        $("#register_password").addClass('n_error');
        // $("#log_code").next().addClass('tips_error');
        $(".cw_errortwo").removeClass("hide").html('密码长度应为6-16位，格式为字母+数字的组合');
        $("#register_password").val("");
        return;
    }
    else if(checkPass(x) == 0) {
        $("#register_password").addClass('n_error');
        // $("#log_code").next().addClass('tips_error');
        $(".cw_errortwo").removeClass("hide").html('密码格式为字母+数字的组合');
        $("#register_password").val("");
        return;
    }
    else if (checkPass(x) == 0) {
        $("#register_password").addClass('n_error');
        // $("#log_code").next().addClass('tips_error');
        $(".cw_errortwo").removeClass("hide").html('密码必须是数字和英文字母组合');
        $("#register_password").val("");
        return;
    }
    else if(x == ''){
        $("#register_password").addClass('n_error');
        //$("#log_code").next().addClass('tips_error');
        $(".cw_errortwo").removeClass("hide").html('请输入密码');
        return;
    }
    else{
        $("#register_password").removeClass('n_error');
        $(".cw_errortwo").addClass("hide")
        flagP=true;
    }
    var flagY=false;
    var yzm =$("#register_yzm").val();
    if(yzm == ''){
        $("#register_yzm").addClass('n_error');
        $(".cw_errorthree").removeClass("hide").html('请输入验证码');
        return;
    }
    else{
        $("#register_yzm").removeClass('n_error');
        $(".cw_errorthree").addClass("hide")
        flagY=true;
    }
    return flag&&flagP&&flagY;
}

function checkPass(obj) {
    if (null == obj || obj.length < 6) {
        return 0;
    }

    var reg = /^(([a-z]+[0-9]+)|([0-9]+[a-z]+))[a-z0-9]*$/i;

    if (reg.test(obj)) {
        return 1;
    }

    return 0;
}

function psdchk(obj) {
    var x = obj.val();
    var regS = /\s/g;
    if (regS.test(x)) {
        obj.addClass('n_error');
        obj.next().next().hide();
        obj.next().next().next().show().html('请勿输入空格');
        obj.val('');
        return false;
    }
    else if (x.length < 6 || x.length > 16) {
        obj.addClass('n_error');
        obj.next().next().hide();
        if (obj.find('.n_tips').length == 0) {
            obj.next().next().next().show().html('密码长度应为6-16位，格式为字母+数字的组合');
            return false;
        }
    }
    else if (checkPass(x) == 0) {
        obj.addClass('n_error');
        obj.next().next().hide();
        if (obj.find('.n_tips').length == 0) {
            obj.next().next().next().show().html('密码必须是数字和英文字母组合');
            return false;
        }
    }
    else {
        obj.removeClass('n_error');
        obj.next().next().hide();
        obj.next().next().next().hide();
        return true;
    }
}

function dia(n){
    $(".mask").fadeIn();
    $(".dia"+n).fadeIn();
};
function cls(){
    $(".dialog").fadeOut();
    $(".mask").fadeOut();
};
function showpro(){
    dia(1);
}
function win(){
    var _wd = $(window).width();
    var _hd = $(window).height();
    $(".dialog").css("top",(_hd - $(".dialog").height())/2).css("left",(_wd - $(".dialog").width())/2);
};
function agreepro(){
    $(".icheckbox_square-green").addClass("checked");
    cls();
}

$(".i-checks").iCheck({
    checkboxClass:"icheckbox_square-green",
    radioClass:"iradio_square-green",
});
win();
$(window).resize(function(){
    win();
});


$(function(){
    /*边框色值变化*/
    $(".inp").on("focus",function () {
        $(this).addClass("border")
    })
    $(".inp").on("blur",function () {
        $(this).removeClass("border")
    })
    /*tab切换*/
    $(".page_ul li").click(function(){
        $(this).addClass('binding_page_active').siblings('li').removeClass('binding_page_active');
        var liIndex = $(".page_ul li").index(this);
        $(".con" + liIndex).show().siblings("div").hide();
    });
})
/*tab切换图片*/
function add_page() {
    $(".one_li").find("img").attr("src","../images/icon_link@2x.png");
    $(".two_li").find("img").attr("src","../images/icon_not_link_none@2x.png");
};
function remove_page() {
    $(".two_li").find("img").attr("src","../images/icon_not_link@2x.png");
    $(".one_li").find("img").attr("src","../images/icon_link_none@2x.png");
};