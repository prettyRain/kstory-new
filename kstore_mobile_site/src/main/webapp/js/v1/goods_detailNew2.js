// $('#proBottom').append($("#myvalue").html());
/*
 * 作者：shf
 * 时间：2017
 * 描述：
 * 菜单移动到顶部后定位在顶部
 * message[菜单的id名或者class类名]
 * height[菜单距离顶部的距离]
 */
$(function() {
    var barHeight = document.getElementById("bar-top").offsetTop;
    // console.log("barHeight----"+barHeight)
    // var barHeight = document.getElementById("bar-top").offsetTop-360;
function navChangeArea(message, height) {
    var liveDiv = $("#" + message).length ? $("#" + message) : $("." + message);
    if(/android/i.test(navigator.userAgent)){
            // console.log("$(this).scrollTop()----"+$(this).scrollTop());
            // console.log("height----"+height)
            if($(this).scrollTop()<= height){
                // console.log("不相等")
                liveDiv.removeClass("stickymark");
                liveDiv.css({"position": "relative","top":"0"});
                $(".pro-desc").css({"margin-top":"0"})
            }else{
                // console.log("相等")
                liveDiv.addClass("stickymark");
                if($(".arouse-app").css("display")=="block"){
                    liveDiv.css({"position": "fixed","top":"105px"});
                    // $(".pro-desc").css({"margin-top":"110px"});
                }else{
                    liveDiv.css({"position": "fixed","top":"51px"});
                    // $(".pro-desc").css({"margin-top":"54px"});
                }
            }
    }
    if(/(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent)){
        liveDiv.addClass("sticky");
        if($(".arouse-app").css("display")=="block"){
            $(".sticky").css({"top":"105px"})
        }else{
            $(".sticky").css({"top":"51px"})
        }
        if($(this).scrollTop()<= height-106){
            // console.log("不相等")
            liveDiv.removeClass("stickymark");
        }else{
            // console.log("相等")
            liveDiv.addClass("stickymark");
        }
    }
}
$(window).bind("scroll", function() {
    navChangeArea("bar-top", barHeight);
});
$(window).bind("touchmove", function() {
    navChangeArea("bar-top", barHeight);
});
})