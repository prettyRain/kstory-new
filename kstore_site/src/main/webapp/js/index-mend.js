$(function() {
    function fun() {
        var _1y = $(".product_detail").offset().top;
        $(".about_product").addClass("normal")
        $(".about_product").css("top", _1y)
        $(window).scroll(function () {
            var _2y = $(".footer_tab").offset().top - $(".about_product").height() - 410 - 40;
            if (($(document.body).scrollTop() >= _1y && $(document.body).scrollTop() <= _2y) || ($(document.documentElement).scrollTop() >= _1y && $(document.documentElement).scrollTop() <= _2y) || (window.scrollY >= _1y && window.scrollY <= _2y)) {
                $(".about_product").css("top", "0")
                $(".about_product").addClass("sticky");
                $(".about_product").removeClass("normal");
            } else if ($(document.body).scrollTop() >= _2y || $(document.documentElement).scrollTop() >= _2y || window.scrollY >= _2y) {
                $(".about_product").addClass("normal")
                $(".about_product").css("top", _2y)
            } else {
                $(".about_product").removeClass("sticky");
                $(".about_product").css("top", _1y)
                $(".about_product").addClass("normal");
            }
            ;
        });
    }

    setTimeout(fun, 500);
    // 促销信息
    $(".pd-bg .saleswarp").on("mouseover", function () {
        $(".pd-bg .moreinfo").show();
        $(".pd-bg .moresales").hide()
    })
    $(".pd-bg .saleswarp").on("mouseout", function () {
        $(".pd-bg .moreinfo").hide();
        $(".pd-bg .moresales").show()

    })

    var pageLength;//请求的数据长度,请求过来的
    var nowspage = 1;
    //加载浏览记录跟热销排行
    $.ajax({
        type: "get",
        url: "/queryHistoryPros.htm",
        async: false,
        data: {
            cateIdOne: $("#cateOne").val(),
            cateIdTwo: $('#cateTwo').val(),
            goodsId: $('#goodsId').val()
        },
        success: function (result) {
            var products;
            var productsSalesTop;

            //浏览记录 star
            if (result.type == 1) {
                products = result.browHist;
                if (products.length > 0) {
                    pageLength = products.length>15?15:products.length;
                    for (var i = 0; i < products.length; i++) {
                        if (i >= 0 && i <= 4) {

                            var str = '<div class="product">'
                                + '<a href="/item/' + products[i].goodsId + '.html">'
                                + '<img alt=""src="' + products[i].goods.goodsImageList[0].imageBigName + '">'
                                + '<div class="browse_title">' + products[i].goods.goodsName + '</div>'
                                + '<div class="browse_charge">￥' + products[i].goods.goodsMarketPrice.toFixed(2) + '</div>'
                                + '</a>'
                                + '</div>';

                            $(".warp").find('.one').append(str);
                        }
                        if (i >= 5 && i <= 9) {
                            var strtwo = '<div class="product">'
                                + '<a href="/item/' + products[i].goodsId + '.html">'
                                + '<img alt=""src="' + products[i].goods.goodsImageList[0].imageBigName + '">'
                                + '<div class="browse_title">' + products[i].goods.goodsName + '</div>'
                                + '<div class="browse_charge">￥' + products[i].goods.goodsMarketPrice.toFixed(2) + '</div>'
                                + '</div>'
                                + '</a>';
                            $(".warp").find('.two').append(strtwo);
                        }
                        if (i >= 10 && i <= 14) {
                            var strthree = '<div class="product">'
                                + '<a href="/item/' + products[i].goodsId + '.html">'
                                + '<img alt=""src="' + products[i].goods.goodsImageList[0].imageBigName + '">'
                                + '<div class="browse_title">' + products[i].goods.goodsName + '</div>'
                                + '<div class="browse_charge">￥' + products[i].goods.goodsMarketPrice.toFixed(2) + '</div>'
                                + '</a>'
                                + '</div>';
                            $(".warp").find('.three').append(strthree);
                        }
                    }
                }
            } else if (result.type == 2) {
                products = result.productList;
                if (products.length > 0) {
                    pageLength = products.length>15?15:products.length;
                    for (var i = 0; i < products.length; i++) {
                        if (i >= 0 && i <= 4) {
                            var str = '<div class="product">'
                                + '<a href="/item/' + products[i].goodsInfoId + '.html">'
                                + '<img alt=""src="' + products[i].imageList[0].imageBigName + '">'
                                + '<div class="browse_title">' + products[i].productName + '</div>'
                                + '<div class="browse_charge">￥' + products[i].goodsInfoMarketPrice.toFixed(2) + '</div>'
                                + '</a>'
                                + '</div>';
                            $(".warp").find('.one').append(str);
                        }
                        if (i >= 5 && i <= 9) {
                            var strtwo = '<div class="product">'
                                + '<a href="/item/' + products[i].goodsInfoId + '.html">'
                                + '<img alt=""src="' + products[i].imageList[0].imageBigName + '">'
                                + '<div class="browse_title">' + products[i].productName + '</div>'
                                + '<div class="browse_charge">￥' + products[i].goodsInfoMarketPrice.toFixed(2) + '</div>'
                                + '</a>'
                                + '</div>';
                            $(".warp").find('.two').append(strtwo);
                        }
                        if (i >= 10 && i <= 14) {
                            var strthree = '<div class="product">'
                                + '<a href="/item/' + products[i].goodsInfoId + '.html">'
                                + '<img alt=""src="' + products[i].imageList[0].imageBigName + '">'
                                + '<div class="browse_title">' + products[i].productName + '</div>'
                                + '<div class="browse_charge">￥' + products[i].goodsInfoMarketPrice.toFixed(2) + '</div>'
                                + '</a>'
                                + '</div>';
                            $(".warp").find('.three').append(strthree);
                        }
                    }
                }
            }


            //热销 start
            if (!!result.listrela) {
                productsSalesTop = result.listrela;
                var bigdiv$ = $('.bigdiv');
                for (var i = 0; i < productsSalesTop.length; i++) {
                    var div$;
                    var divInfo$;
                    if (i % 2 == 0) {
                        div$ = $('<div class="swiper-slide"></div>');
                        divInfo$ = $('<div class="sidebar-info"></div>');
                        div$.append(divInfo$);
                        bigdiv$.append(div$);
                    }
                    var sb = "";
                    sb += '<a href="/item/' + productsSalesTop[i].goodsInfoId + '.html">'
                        + '<img alt="" style="width:140px;height:140px;"src="' + productsSalesTop[i].goodsInfoImgId + '">'
                        + '<div class="sidebar-title">' + productsSalesTop[i].goodsInfoName + '</div>'
                        + '<div class="sidebar-charge">￥' + productsSalesTop[i].goodsInfoMarketPrice.toFixed(2) + '</div>'
                        + '</a>';
                    divInfo$.append(sb);
                }
                //轮播的效果
                var swiper = new Swiper('.swiper-container', {
                    pagination: '.swiper-pagination',
                    paginationClickable: true,
                    autoplayDisableOnInteraction: false,
                    loop: true,
                    speed: 600,
                    autoplay: 3000
                });
            }
        }
    })

    if (pageLength <= 5) {
        $(".browse_product").find(".next").html(1);
        $(".browse_product").find(".sub").addClass("nohand");
        $(".browse_product").find(".add").addClass("nohand");
    } else if (5 < pageLength && pageLength <= 10) {
        $(".browse_product").find(".next").html(2);
        $(".browse_product").find(".add").addClass("flip2");
        $(".browse_product").find(".add").removeClass("flip3");
        $(".browse_product").find(".sub").addClass("nohand");
        $(".browse_product").find(".add").removeClass("nohand");
    } else {
        $(".browse_product").find(".next").html(3);
        $(".browse_product").find(".add").addClass("flip2");
        $(".browse_product").find(".add").removeClass("flip3");
        $(".browse_product").find(".sub").addClass("nohand");
        $(".browse_product").find(".add").removeClass("nohand");
    }
    $(".browse_product").find(".add").on("click", function () {

        if (pageLength <= 5) {
            $(".browse_product").find(".last").html(1)
        } else if (5 < pageLength && pageLength <= 10) {
            $(".warp").removeClass("floor3 floor2");
            $(".warp").addClass("floor1");
            $(".browse_product").find(".last").html(2);
            $(".browse_product").find(".add").addClass("flip3");
            $(".browse_product").find(".add").removeClass("flip2");
            $(".browse_product").find(".sub").addClass("flip4");
            $(".browse_product").find(".sub").removeClass("flip1");
            $(".browse_product").find(".sub").removeClass("nohand");
            $(".browse_product").find(".add").addClass("nohand");
        } else if (10 < pageLength && nowspage == 1) {
            nowspage++;
            $(".warp").removeClass("floor2 floor3");
            $(".warp").addClass("floor1");
            $(".browse_product").find(".last").html(2);
            $(".browse_product").find(".add").addClass("flip2");
            $(".browse_product").find(".add").removeClass("flip3");
            $(".browse_product").find(".sub").addClass("flip4");
            $(".browse_product").find(".sub").removeClass("flip1");
            $(".browse_product").find(".sub").removeClass("nohand");
            $(".browse_product").find(".add").removeClass("nohand");
        } else if (10 < pageLength && nowspage == 2) {
            nowspage++;
            $(".warp").removeClass("floor1 floor2");
            $(".warp").addClass("floor3");
            $(".browse_product").find(".last").html(3);
            $(".browse_product").find(".add").addClass("flip3");
            $(".browse_product").find(".add").removeClass("flip2");
            $(".browse_product").find(".sub").addClass("flip4");
            $(".browse_product").find(".sub").removeClass("flip1");
            $(".browse_product").find(".sub").removeClass("nohand");
            $(".browse_product").find(".add").addClass("nohand");
        } else if (10 < pageLength && nowspage == 3) {
            //没有任何操作
            $(".browse_product").find(".sub").removeClass("nohand");
            $(".browse_product").find(".add").addClass("nohand");
        }
    });
    $(".browse_product").find(".sub").on("click", function () {
        if (pageLength <= 5) {
            $(".browse_product").find(".last").html(1);
        } else if (5 < pageLength && pageLength <= 10) {
            console.log(1111)
            $(".warp").removeClass("floor1");
            $(".warp").removeClass("floor3");
            $(".warp").addClass("floor2");
            $(".browse_product").find(".last").html(1);
            $(".browse_product").find(".add").addClass("flip2");
            $(".browse_product").find(".add").removeClass("flip3");
            $(".browse_product").find(".sub").addClass("flip1");
            $(".browse_product").find(".sub").removeClass("flip4");
            $(".browse_product").find(".sub").addClass("nohand");
            $(".browse_product").find(".add").removeClass("nohand");
        } else if (10 < pageLength && nowspage == 1) {
            console.log(2222)
            $(".browse_product").find(".last").html(1)
        } else if (10 < pageLength && nowspage == 2) {
            console.log(3333)
            nowspage--;
            $(".warp").removeClass("floor1");
            $(".warp").removeClass("floor3");
            $(".warp").addClass("floor2");
            $(".browse_product").find(".last").html(1);
            $(".browse_product").find(".add").addClass("flip2");
            $(".browse_product").find(".add").removeClass("flip3");
            $(".browse_product").find(".sub").addClass("flip1");
            $(".browse_product").find(".sub").removeClass("flip4");
            $(".browse_product").find(".sub").addClass("nohand");
            $(".browse_product").find(".add").removeClass("nohand");
        } else if (10 < pageLength && nowspage == 3) {
            console.log(444)
            nowspage--;
            $(".warp").removeClass("floor2");
            $(".warp").removeClass("floor3");
            $(".warp").addClass("floor1");
            $(".browse_product").find(".last").html(2);
            $(".browse_product").find(".sub").removeClass("nohand");
            $(".browse_product").find(".add").removeClass("nohand");
        }
    });
});


