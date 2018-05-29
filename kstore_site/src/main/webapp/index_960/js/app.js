$(function(){
    $(".topmenu").hover(function(){
        $(this).addClass("topmenuon");
        $(this).find("p").css("background-color","#ffffff");
        $(this).find("p").find("a").css("background-color","#ffffff");
        $(this).find(".toplinkmenu").show();
    },function(){
        $(".topmenu").removeClass("topmenuon");
        $(this).find("p").css("background-color","#f7f7f7");
        $(this).find("p").find("a").css("background-color","#f7f7f7");
        $(this).find(".toplinkmenu").hide();
    });

    //全部商品分类
    //$(".dropdown-menu li:gt(8)").hide();
    var local = window.location.href;
    if(local.indexOf("/channel/")<1 || local.indexOf("?navId=")>-1){
        $(".showlist").mouseover(function(){
            $(".dropdown-menu").show();
        }).mouseout(function(){
            $(".dropdown-menu").hide();
        });
    }else{
        $(".dropdown-menu").addClass("showthis");
    }

    var t = "";
    $(".dropdown-menu li").mouseover(function(){
        var cur = $(this);
        var index = $(this).index();
        var dl = $(".dropdown-menu").children("li");
        t = setTimeout(function(){
            dl.removeClass("hover").eq(index).addClass("hover");
            $(".menuView:visible").hide();
            $(".menuView").eq(index).show();
        },100);
    }).mouseout(function(){
        clearTimeout(t);
    });
    function hideSort(){
        $(".dropdown-menu").find(".hover").removeClass("hover");
        $(".menuView:visible").hide();
    };
    $(".showlist").mouseleave(function(){
        hideSort();
    });
    $(".menucat").mouseover(function(){
        hideSort();
    });

    //首页幻灯
    if($("#slides").length>0 && $("#slides .slide").length>1) {
        $("#slides").slidesjs({
            play: {
                active: false,
                effect: "fade",
                auto: true,
                interval: 4000,
                pauseOnHover: true,
                restartDelay: 2500
            },
            navigation: {
                active: true,
                effect: "slide"
            },
            pagination: {
                active: true,
                effect: "fade"
            }
        });
    };

    /*侧边栏二维码*/

    $(".iphone_download").mouseover(function () {
        $(".iphone_download_sidebar").show();
    })
    $(".iphone_download").mouseout(function () {
        $(".iphone_download_sidebar").hide();
    })
    $(".shopcarright").mouseover(function () {
        $(".gouwuche").show();
    })
    /*客服电话*/
    $(".new_service").mouseover(function () {
        $(".new_service_sidebar").show();
    })
    $(".new_service").mouseout(function () {
        $(".new_service_sidebar").hide();
    })


    $(".shopcarright").mouseout(function () {
        $(".gouwuche").hide();
    })
    $(".shopcaritemnum").mouseout(function () {
        $(".gouwuche").hide();
    })
    $(".hide_a").mouseout(function () {
        $(".gouwuche").hide();
    })
    $(".shopcarright_img").mouseout(function () {
        $(".gouwuche").hide();
    })
});
function showSearch(){
    $(".searchbuttonarea").hide();
    $(".navLinks").hide(400);
    $(".searchdiv").fadeIn(600);

    $("#wd").focus();
    //shf隐藏购物车img
    $(".searchbuttonarea_gw").hide();
   /* $(".bgPop").show();*/

};
function hideSearch(){
    $(".searchbuttonarea").show();
    $(".navLinks").show(500);
    $(".searchdiv").hide();
    //shf显示购物车img
    $(".searchbuttonarea_gw").show();
   /* $(".bgPop").hide();*/
};
$(".bgPop").click(function () {
    $(".searchbuttonarea").show();
    $(".navLinks").show(500);
    $(".searchdiv").hide();
    //shf显示购物车img
    $(".searchbuttonarea_gw").show();
    $(".bgPop").hide();
})
$("#wd").bind("input propertychange",function(){
    var value=$(this).val();
    if(value){
        $.post(
            "/findAllByKeywordAjax.htm",
            {searchKeyword:value},
            function(data){
                $(".cast_content").find("ul").empty();
                $(".cast_bottom").empty();
                if(data!=null){
                    //conole.info(data);
                    var cates = data.cates;
                    var brands = data.brands;
                    if(cates!=null){
                        for(var i=0;i<cates.length;i++){
                            $(".cast_content").find("ul").append("<li><p><a href='/list/"+cates[i].catId+"-"+cates[i].catParentId+".html'>"+cates[i].catName+"</a><img src='/images/btn_more1.png'></p><span>"+cates[i].goodsCount+"件</span></li>");
                        }
                    }else{
                        $(".cast_content").find("ul").append("<span style='margin: 0 220px;line-height: 70px;'>暂未找到相关的分类推荐，请点击回车键搜索</span>");
                    }
                    if(brands!=null){
                        for(var i=0;i<brands.length;i++){
                            var url = (brands[i].brandUrl == null) ? "javascript:void(0);": brands[i].brandUrl;
                            $(".cast_bottom").append("<a href='"+url+"' style='height: 24px;width: 100px; display: inline-block;margin-bottom: 6px;'><img src='"+brands[i].brandLogo+"'style='height: 24px;width: 69px;'></a>");
                        }
                    }else{
                        $(".cast_bottom").append("<span style='margin: 0 220px;'>暂未找到相关的品牌推荐，请点击回车键搜索</span>");
                    }
                    $(".cast_about").show();
                }else{
                    $(".cast_about").hide();
                    $(".cast_about1").show();
                }
            },
            "json"
        );
    }else{
        $(".cast_about1").hide();
        $(".cast_about").hide();
    }
});

var is_login1 = 1;

$('.searchbuttonarea_gw').click(function(){
    $(".searchbuttonarea .shopcarright_list").show();
})
$('.searchbuttonarea').mouseleave(function(){
    $(".searchbuttonarea .shopcarright_list").hide();
})

$('.scroll_top').click(function(){
    $("body,html").animate({
        scrollTop:0  //回到页面顶端
    },500);
})

$('.shopcarright_img').mouseenter(function(e){
    $(".rightbar .shopcarright_list").show();
})
$('.shopcarright').mouseleave(function(){
    $(".rightbar .shopcarright_list").hide();
})
$(window).on('scroll resize', function() {
    cent($('.rightbar_body'))
});
cent($('.rightbar_body'));
jQuery.extend(jQuery.easing, {
    easeOutQuart: function(x, t, b, c, d) {
        return -c * ((t = t / d - 1) * t * t * t - 1) + b;
    }
});


function cent(obj){
    var $window = $(window),
        $document =  $(document),
        $conTar = obj;
    var ypos = ($window.height() - $conTar.height()) * 0.5 ;
    var scrollHeight = Math.max($window.height(), document.documentElement.scrollHeight, document.body.scrollHeight);
    $conTar.css({ 'top':ypos + 'px','left':'0','margin-top':'0px'});
};
