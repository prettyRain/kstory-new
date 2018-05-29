// * 作者：shf
// * 时间：2017-08
// * 描述：改版


// 整页滚动导航
$(document).ready(function () {
    $('body').sectionScroll();
});

var env = {
    agent: window.navigator.userAgent.toLowerCase(),
    isAndroid: function() {
        return this.agent.match(/android/i) == 'android';
    },
    isIphone: function() {
        return this.agent.match(/iphone/i) == 'iphone';
    }
};

$(function() {
    $(window).scroll(function(){
        //回到顶部
        $(this).scrollTop()<28?$('.arouse-app').css('opacity',1-($(this).scrollTop()*0.007)): $('.arouse-app').css('opacity',0.8)
        $(this).scrollTop()>800?$('.slideBar').show(): $('.slideBar').hide();
        //整页滚动导航
        if($(this).scrollTop()<70){
            $('.pro-details-top.bg').css('opacity',0);
            $('.bullets-container').css('opacity',0);
            $(".pro-details-top").css("border-bottom","none");
        }else if( $(this).scrollTop()<300 && $(this).scrollTop()>70){
            $(".pro-details-top").css("border-bottom","0.5px solid #eee");
            $('.pro-details-top.bg').css('opacity',$(this).scrollTop()*0.004);
            $('.bullets-container').css('opacity',$(this).scrollTop()*0.004);
        }else{
            $('.pro-details-top.bg').css('opacity',1);
            $('.bullets-container').css('opacity',1);
        };

        //视差滚动
        if(env.isIphone()){
            var height = $(".dsd").height();
            var scrollTop = $(document.body).scrollTop() / 2;
            var offset = scrollTop > height ? height : scrollTop;
            $(".dsd").css('background-position', '50% ' + offset + 'px');
        };
    });
});



















