

// 轮播代码
var bullets = document.getElementById('position').getElementsByTagName('li');
$(function(){
    /*<figure>
     <div class="wrap">
     <a href="javascript:;" class="image" ><img src="img/list.jpg"></a>
     </div>
     </figure>*/
    //banner
    var bannerDiv=$('#bannerDIV');
    var positonDiv=$('#position');
    $('.swiper-slide').each(function(index,item){
        var _this=$(item);
        var href=_this.children('a').attr("href");
        var src=_this.find('img').attr("src");
        var bannersb='<figure><div class="wrap"><a href="'+href+'" class="external"><img src="'+src+'"></a></div></figure>';
        bannerDiv.append(bannersb);
        var positonsb=$('<li></li>');
        positonDiv.append(positonsb);
    });
    //将第一个加上on状态
    $('#position li').eq(0).addClass("on");
    //初始化banner
    var slider = Swipe(document.getElementById('slider'), {
        auto: 3000,
        continuous: true,
        callback: function(pos) {
            var i = bullets.length;
            while (i--) {
                bullets[i].className = ' ';
            }

            bullets[pos].className = 'on';
        }
    });
    //专题
    var food = $('.food li');
    for(var i=0;i<food.length;i++){
        var dz = $('.zhuanti').eq(0).find("a").eq(i).attr("href");
        var imgdz = $('.zhuanti').eq(0).find("img").eq(i).attr("src");
        $('.food li').eq(i).find("a").attr({"href":dz});
        $('.food li').eq(i).find("img").attr({"src":imgdz});
    }
    var drink = $('.drink li');
    for(var j=0;j<drink.length;j++){
        var dz = $('.zhuanti').eq(1).find("a").eq(j).attr("href");
        var imgdz = $('.zhuanti').eq(1).find("img").eq(j).attr("src");
        $('.drink li').eq(j).find("a").attr({"href":dz});
        $('.drink li').eq(j).find("img").attr({"src":imgdz});
    }
    var other = $('.othermall .othermalls');
    for(var k=other.length-1;k>=0;k--){
        var dz = $('.zhuanti').eq(2).find("a").eq(k).attr("href");
        var imgdz = $('.zhuanti').eq(2).find("img").eq(k).attr("src");
        $('.othermall .othermalls').eq(other.length-k-1).attr({"href":dz});
        $('.othermall .othermalls').eq(other.length-k-1).find("img").attr({"src":imgdz});
    }

    var img_adv = $(".img_adv").find("img").attr("src");
    var img_href = $(".img_adv").find("a").attr("href");
    $(".advertise").find("img").attr("src",img_adv);
    if(img_href.indexOf("listByBrand") > -1){
        img_href = "/list.htm?brand"+img_href.substring(img_href.lastIndexOf("/")+1,img_href.lastIndexOf("."));
    }else if(img_href.indexOf("listByCateBar") > -1){
        img_href = "/list/"+img_href.substring(img_href.lastIndexOf("/")+1,img_href.length)+".html";
    }else if(img_href.indexOf("item") > -1){
        img_href = "/item/"+img_href.substring(img_href.lastIndexOf("/")+1,img_href.lastIndexOf("."))+".html";
    }
    $(".advertise").find("a").attr("href",img_href);

    // 热销商品
    var html="";
    $.ajax({
        url:"/hotsales.htm",
        async:true,
        success: function(data){
            console.log(data )
            for(var a=0;a<data.length;a++){
                var yuan = data[a].goodsInfoPreferPrice.toFixed(2).split(".")[0];
                var fen = data[a].goodsInfoPreferPrice.toFixed(2).split(".")[1];

                html += '<div class="hotsellgoods"><a href="/item/'+data[a].goodsInfoId+'.html" class="external"><img src='+data[a].goodsInfoImgId+'><p class="goodstitle">'+data[a].goodsInfoName+'</p><p class="goodscharge">￥'+ yuan +  '.<span class="goodsspan">' + fen + '</span></p></a></div>'
            }
            html = html+'<div class="clearfixed"></div>';
            $("#hotsell").append(html);
        }

    });

})
