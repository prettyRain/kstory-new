/*
 * 作者：shf
 * 时间：2017-12-15
 * 描述：首页H5改版3.0 js
 *
 */



$(function() {
    $(".bar-bottom a:eq(0)").addClass("selected");
    //给导航轮播第一个添加选中状态
    $(".sheadwarp .swiper-slide").eq(0).addClass("headactive");
    var sheadsd = "",
        maincolumn ="",
        seccolumn = "",
        grouphtml = "",
        dataMark,
        posihtml = "";

    var posilength = $(".shead .swiper-slide").length;
    for(var pp=0;pp<posilength-1;pp++){
        posihtml +='<div class="swiper-slide bodyslide"><div class="loading"><img src="../../images/v3/loading2.gif"></div></div>';
    }

    $(".sbody>.swiper-wrapper").append(posihtml);



    // 拼接首页推荐轮播
    $("#roll_adv1 .swiper-slide").each(function(index,item){
        var _this1=$(item);
        var href1=_this1.children('a').attr("href");
        var src1=_this1.find('img').attr("src");
        if(href1.indexOf("listByCateBar") > -1){
            href1 = "/list/"+href1.substring(href1.lastIndexOf("/")+1,href1.length)+".html";
        }else if(href1.indexOf("item") > -1){
            href1 = "/item/"+href1.substring(href1.lastIndexOf("/")+1,href1.lastIndexOf("."))+".html";
        }else{
            href1 = href1;
        }
        var czc_push1 = "_czc.push(['_trackEvent', '首页', '推荐页', '轮播"+index+"','0','main_slide"+index+"']);"
        sheadsd += '<div class="swiper-slide"><a href="'+href1+'" class="external"  onclick="'+czc_push1+'"><img src="'+src1+'"></a></div>'
    });
    $(".lunbos>.swiper-wrapper").html(sheadsd);

    // 拼接首页推荐轮播下方广告图，可能多张,和首页推荐下方分组的商品
    var term= $(".app_item.app_cube");
    for(var ij=0;ij<term.length;ij++){
        var cube =term.eq(ij).find("div").attr("tag");
        var cubenext = term.eq(ij).next().find("div").attr("tag");
        if(cube!==cubenext){
            var href2=term.eq(ij).find("a").attr("href");
            var src2=term.eq(ij).find("img").attr("src");
            if(href2.indexOf("listByCateBar") > -1){
                href2 = "/list/"+href2.substring(href2.lastIndexOf("/")+1,href2.length)+".html";
            }else if(href2.indexOf("item") > -1){
                href2 = "/item/"+href2.substring(href2.lastIndexOf("/")+1,href2.lastIndexOf("."))+".html";
            }else{
                href2 = href2;
            }
            var czc_push2 = "_czc.push(['_trackEvent', '首页', '活动', '狩猎时刻','0','panicbuyinglist']);";
            maincolumn += '<a href="'+href2+'" class="external" onclick="'+czc_push2+'"><img src="'+src2+'" /></a>'
        }
    }
    $(".main-column").html(maincolumn);




    // 拼接首页推荐轮播下方广告图下方的专题，茶馆什么的
    $(".zhuanti .img-nav-item").each(function(index,item){
        var _this3=$(item);
        var name3= _this3.find('span').html();
        var href3=_this3.attr("href");
        var src3=_this3.find('img').attr("src");
        if(href3.indexOf("listByCateBar") > -1){
            href3 = "/list/"+href3.substring(href3.lastIndexOf("/")+1,href3.length)+".html";
        }else if(href3.indexOf("item") > -1){
            href3 = "/item/"+href3.substring(href3.lastIndexOf("/")+1,href3.lastIndexOf("."))+".html";
        }else{
            href3 = href3;
        }
        var czc_push3 = "_czc.push(['_trackEvent', '首页', '活动', '"+name3+"','0','zhuanti"+index+"']);";
        if(index==0){
            seccolumn += '<a href="'+href3+'" class="external endways" onclick="'+czc_push3+'"><img src="'+src3+'"></a>'
        }else{
            seccolumn += '<a href="'+href3+'" class="external transversely1" onclick="'+czc_push3+'"><img src="'+src3+'"></a>'
        }
    });
    seccolumn += '<div class="clearfixed"></div>';
    $(".sec-column").html(seccolumn);


    // 拼接首页推荐的分组商品
    $.ajax({
        url: "home/module.htm?pageId="+$(".shead .headactive").attr("index"),
        async: true,
        success: function (data) {
            for(var m=0;m<data.length;m++){
                grouphtml += '<div class="floor">';
                var img_href =data[m].sliders[0].action;
                if(!img_href){
                    img_href = "javascript:void(0)";
                } else if (img_href.indexOf("GoodsList") > -1) {
                    img_href = "/list/" + data[m].sliders[0].actionParam + ".html";
                }else if (img_href.indexOf("GoodsDetail") > -1) {
                    img_href = "/item/" + data[m].sliders[0].actionParam + ".html";
                }else{
                    img_href =  data[m].sliders[0].actionParam
                }
                grouphtml += '<a href="'+img_href+'" class="external floor-banner"><img src="'+data[m].sliders[0].img+'"></a>';
                grouphtml += '<div class="floor-swiper" id="floor-swiper"><div class="swiper-wrapper">';
                for(var n=0;n<data[m].goodsInfoList.length;n++){
                    var yuan5 = data[m].goodsInfoList[n].finalPrice.toFixed(2).split(".")[0];
                    var fen5 = data[m].goodsInfoList[n].finalPrice.toFixed(2).split(".")[1];
                    grouphtml += '<div class="swiper-slide">';
                    grouphtml += '<a href="/item/'+data[m].goodsInfoList[n].id+'.html" class="external">';
                    grouphtml += '<img src="'+data[m].goodsInfoList[n].image+'">';
                    grouphtml += '<p class="title">'+data[m].goodsInfoList[n].name+'</p>';
                    grouphtml += '<p class="price">￥<span>'+yuan5+'</span>.'+fen5+'</p>';
                    grouphtml += '</a>';
                    grouphtml += '<span class="cart" onclick="addShoppingCart(this,'+data[m].goodsInfoList[n].id+')"><img src="../../images/v3/btn_shopping%20cart@2x.png"></span>';
                    grouphtml += '</div>';
                }
                grouphtml += '</div></div></div>';
            }
            $(".bodyslide.swiper-slide-active .pro-detail").append(grouphtml);
            $(".bodyslide.swiper-slide-active .pro-detail").append('<div style="height:53px;"></div>');
            //每个切换页面中楼层的轮播
            var floorSwiper = new Swiper('.floor-swiper', {
                // nested:true,
                slidesPerView: 'auto',
                spaceBetween: 8
            });
        }
    });




// 加载每个slide商品
function slidePro(group,index) {
    var html = "";
    $.ajax({
        url: "/home/content.htm?pageId="+group,
        // url: "/home/content.htm?pageId=191",
        async: true,
        success: function (data) {
            html += '<div class="pro-detail" data-mark="on"><div class="navbarBg"></div>';
            html += '<div class="lunbowarp">';
            html += '<div class="lunboslide lunboslide'+index+'">';
            html += '<div class="swiper-wrapper">';
            // 拼接轮播
            for(var slidenum=0;slidenum<data.sliders.length;slidenum++){
                html += '<div class="swiper-slide">'
                var slide_href =data.sliders[slidenum].action;
                if(!slide_href){
                    slide_href = "javascript:void(0)";
                } else if (slide_href.indexOf("GoodsList") > -1) {
                    slide_href = "/list/" + data.sliders[slidenum].actionParam + ".html";
                }else if (slide_href.indexOf("GoodsDetail") > -1) {
                    slide_href = "/item/" + data.sliders[slidenum].actionParam + ".html";
                }else{
                    slide_href =  data.sliders[slidenum]
                }
                html += '<a href="'+slide_href+'" class="external"><img src="'+data.sliders[slidenum].img+'"></a></div>'
            }
            html += '</div>';
            html += '<div class="swiper-pagination spagination'+index+'"></div>';
            html += '</div>';
            html += '</div>';
            //拼接商品列表
            for(var spronum=0;spronum<data.goodsInfoList.length;spronum++){
                var yuan = data.goodsInfoList[spronum].finalPrice.toFixed(2).split(".")[0];
                var fen = data.goodsInfoList[spronum].finalPrice.toFixed(2).split(".")[1];
                html += '<div class="pro-info">';
                html += '<a href="/item/'+data.goodsInfoList[spronum].id+'.html" class="external">';
                html += '<div class="pro-left"><img src="'+data.goodsInfoList[spronum].image+'"/></div>';
                html += '<div class="pro-right"> ';
                html += '<p class="title">'+data.goodsInfoList[spronum].name+'</p>';
                html += '<div class="price"><p class="new-price">￥<span>'+yuan+'</span>.'+fen+'</p> ';
                if(data.goodsInfoList[spronum].finalPrice !== data.goodsInfoList[spronum].preferPrice){
                    html += '<p class="old-price">&nbsp;￥'+data.goodsInfoList[spronum].preferPrice.toFixed(2)+'&nbsp;</p> ';
                }
                html += '</div></div></a>';
                html += '<span class="cart" onclick="addShoppingCart(this,'+data.goodsInfoList[spronum].id+')"><img src="../../images/v3/btn_shopping%20cart@2x.png"></span>';
                html += '</div>';
            }
            html += '<div style="height:53px;"></div></div>';
            $(".bodyslide.swiper-slide").eq(index).html(html);
            //每个切换页面中的轮播

            var lunbos1 = new Swiper(".lunboslide"+index, {
                autoplay: {
                    delay: 5000, //5秒切换一次
                    disableOnInteraction: false,
                },
                // speed:1500,
                loop : true,
                // pagination:' .swiper-pagination'+index,
                // nested:true,
                pagination: {
                    el: '.spagination'+index,
                    // dynamicBullets: true
                }
            });


        },
        error : function(){
            console.log("error")
            // $(".bodyslide.swiper-slide-active .loading").html("加载失败");
        }
    });

}


function slidecenter(clickedIndex) {
    var onheadactive = $(".headactive").offset().left;//选中元素距离视口的距离
    var hweight = $(".headactive").width();//元素的宽度
    var hweightone = $(".shead .swiper-slide").eq(0).width();
    var winweight = $(window).width()/2;//屏幕宽度的一半
    // var indexnum = clickedIndex+1;//当前选中的index
    var indexnum = clickedIndex;//当前选中的index的索引
    var rr = indexnum*hweight-(hweight/2)+hweightone;//选中元素中点距离开始点的距离
    var slidenum = $(".shead .swiper-slide").length;

    //判断在屏幕的右边：选中元素中点距离视口的距离大于屏幕宽度一半
    //判断元素在可以移动到中心位置的距离范围内：全部元素的宽度-选中元素中点距离开始点的距离大于屏幕宽度一半
    // if(onheadactive+hweight/2>winweight && (slidenum*hweight-rr)>winweight){
    if(onheadactive+hweight/2>winweight && ((slidenum-1)*hweight+hweightone-rr)>winweight){
        //console.log("左移");
        shead.setTransition(500);
        shead.setTranslate(winweight-rr);
    }else if(onheadactive+hweight/2<winweight && rr>winweight){
        //console.log("右移");
        shead.setTransition(500);
        shead.setTranslate(winweight-rr);
    }else if(onheadactive+hweight/2>winweight){
        //console.log("左移");
        // shead.slideTo(this.clickedIndex, 500, false);
        shead.setTransition(500);
        shead.setTranslate(-((slidenum-1)*hweight+hweightone)+2*winweight);
    }else if(onheadactive+hweight/2<winweight){
        //console.log("右移");
        shead.setTransition(500);
        shead.setTranslate(0);
    }
}


// 头部导航轮播
var shead = new Swiper('#shead', {
    slidesPerView: 'auto',
    speed:500,
    on: {
        click: function() {
            $("#shead .swiper-slide").removeClass("headactive");
            $("#shead .swiper-slide").eq(this.clickedIndex).addClass("headactive");
            dataMark = $("#sbody>.swiper-wrapper>.swiper-slide").eq(this.clickedIndex).find(".pro-detail").attr("data-mark");
            sbody.slideTo(this.clickedIndex, 10, false);
            if(this.clickedIndex!==0 && !dataMark){
                slidePro($("#shead .swiper-slide").eq(this.clickedIndex).attr("index"),this.clickedIndex);
            }
            if(this.clickedIndex == 0){
                $(".shead").removeClass("slideAfter");
                $(".search_bg").removeClass("slideAfter");
            }else{
                $(".shead").addClass("slideAfter");
                $(".search_bg").addClass("slideAfter");
            }
            slidecenter(this.clickedIndex);
        }
    }
});

// 主体轮播部分
var sbody = new Swiper('#sbody', {
    on: {
        slideChangeTransitionEnd: function() {
            shead.slideTo(sbody.activeIndex, 500, false);
            $("#shead .swiper-slide").removeClass("headactive");
            $("#shead .swiper-slide").eq(sbody.activeIndex).addClass("headactive");
            dataMark = $("#sbody>.swiper-wrapper>.swiper-slide").eq(sbody.activeIndex).find(".pro-detail").attr("data-mark");
            if(sbody.activeIndex!==0 &&  !dataMark){
                slidePro($("#shead .swiper-slide").eq(sbody.activeIndex).attr("index"),sbody.activeIndex);
            }
            if(sbody.activeIndex == 0){
                $(".shead").removeClass("slideAfter");
                $(".search_bg").removeClass("slideAfter");

            }else{
                $(".shead").addClass("slideAfter");
                $(".search_bg").addClass("slideAfter");

            }
            slidecenter(sbody.activeIndex);

        }
    }
});


//每个切换页面中的轮播  推荐
var lunbos = new Swiper('.lunbos', {
    autoplay: {
		delay: 5000, //5秒切换一次
        disableOnInteraction: false,
    },
    loop : true,
    // nested:true,
    pagination: {
        el: '.spagination1',
    }
});


});

//加入购物车
var tip = myAlertStr();
function addShoppingCart(ele,goodsInfoId) {
    addCart(goodsInfoId,tip,ele);

}
function addCart(goodsInfoId,tip,ele) {
    $.ajax({
        url: "/addproducttoshopcarnew.htm?goodsNum=1&productId=" + goodsInfoId + "&distinctId="+ $(".ch_distinctId").val() +"&mark=0",
        type: "post",
        async:false,
        success: function (data) {
            if (data > 0) {
                tip("加入购物车成功");
                return true;
            }else if (data == -1) {
                tip("购物车已达上限");
                return false;
            }else if(data == -5){
                tip("库存不足");
                return false;
            } else if(data == -3){
                tip("货品已下架");
                return false;
            }else {
                tip("加入购物车失败");
                return false;
            }
        }
    });
}


$(".sbody>.swiper-wrapper>.swiper-slide").scroll(function(){
    console.log($(this).scrollTop());
    if($(this).scrollTop()<100 && $(this).scrollTop()>1){
        $('.search_bg').removeClass("scrollBefore").find(".position").css('opacity',$(this).scrollTop()*0.00999);
        $('.search_bg').removeClass("scrollBefore").find(".message").css('opacity',$(this).scrollTop()*0.00999);
        $('.shead').removeClass("scrollBefore").find(".swiper-slide").css('opacity',$(this).scrollTop()*0.00999);
        $(".search").css('opacity',$(this).scrollTop()*0.00999);
        $('.search_bg .innerBg').css('opacity',$(this).scrollTop()*0.00999);
    }else if($(this).scrollTop()>=100){
        $('.search_bg .position').css('opacity',1);
        $('.search_bg .message').css('opacity',1);
        $('.search_bg .innerBg').css('opacity',1);
        $('.shead .swiper-slide').css('opacity',1);
        $(".search").css('opacity',1);
    }else if($(this).scrollTop()<=1){
        $('.search_bg .position').css('opacity',0);
        $('.search_bg .message').css('opacity',0);
        $('.shead .swiper-slide').css('opacity',0);
        $('.search_bg .innerBg').css('opacity',0);
        $('.search_bg').addClass("scrollBefore");
        $('.shead ').addClass("scrollBefore");
        $(".search").css('opacity',0);
    }
});


//解决华为自带浏览器头部适配问题
var hwUa = navigator.userAgent.toLocaleLowerCase();
if(hwUa.indexOf('huawei')>0 && hwUa.indexOf('qq')==-1 && hwUa.indexOf('chrome')==-1 ){
    alert(11)
    $(".navbar .center").css("width","4.8rem");
}