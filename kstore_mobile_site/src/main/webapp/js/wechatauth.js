window.onload=function(){
    var url = window.location.href;
    if(isWeiXin()){
        if(url.indexOf("code=") > 0){
            $.ajax({
                url: "/getwechatauth.htm",
                type: "post",
                data: {code: getUrlParam("code"),state: getUrlParam("state")},
                success: function (data) {
                    $("#wxcode").val("wx");
                }
            });
        }else{
            if($("#wxcode").val() == "" && url.indexOf("//m.ge960") >= 0){
                window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxc3d05e27929ba2a5&redirect_uri="+encodeURIComponent(window.location.href)+"&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
            }
        }
    }
};

//判断是否是微信打开
function isWeiXin(){
    var ua = window.navigator.userAgent.toLowerCase();
    if(ua.match(/MicroMessenger/i) == 'micromessenger'){
        return true;
    }else{
        return false;
    }
}

//获取url中的参数
function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
    var r = window.location.search.substr(1).match(reg);  //匹配目标参数
    if (r != null) return unescape(r[2]); return null; //返回参数值
}