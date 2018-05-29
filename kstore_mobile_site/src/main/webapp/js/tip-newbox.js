/**
 * Created by Administrator on 2017/9/9.
 */

function myAlertStr(){
    var myTimer = null;
    var i=0;
    return function(content){
        console.log(myTimer);
        clearTimeout(myTimer);
        myTimer = setTimeout(function(){
            $("body").append('<div class="tip-newbox" style="z-index:99999"><div class="tip-newbody"><h3>'+content+'</h3></div></div>')
            $(".tip-newbox").animate({top: "18px"});
            window.setTimeout(function(){
                $(".tip-newbox").remove();
            },2000)
        },500);


    }
}