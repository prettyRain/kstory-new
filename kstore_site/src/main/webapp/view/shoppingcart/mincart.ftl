<#assign basePath=request.contextPath>
<script type="text/javascript">
$(function(){
    $(".shopcarright_img").live("mouseover",minicartonloadNew);
    $(".searchbuttonarea_gw").live("mouseover",minicartonloadNew);
    $(".delect_minicart").live("click", function(){
        var emp1 = $(this).next().val();
        var emp2 = $(this).next().next().val();
        $.ajax({ url: "${basePath}/delshoppingcartbyid.htm?shoppingCartId="+emp1+"&goodsInfoId="+emp2,
            async:false,
            success: function(dats){
                if(dats == 1){
                    minicartonloadNew();
                }
            }});
    });
    //预加载mini购物车
    loadCartNum();
    minicartonloadNew();
});

function loadCartNum(){
    $.ajaxSetup({ cache: false });
    $.ajax({
        url: "${basePath}/minisscart.htm",
        async:false ,
        success: function(datee){
            var cartgoods = datee.shopcart.miniGoodsList;
            //比如一件商品买了3件,详细统计购买商品数量
            var countgoods=0;
            //购物车中有商品
            if(cartgoods != null && cartgoods.length>0){
                for(var i = 0 ; i < cartgoods.length ; i++) {
                    countgoods += cartgoods[i].buNum;
                }

            }
            $(".shopcaritemnum").text(countgoods);
        }
    });
};
function img_click(goodinfoid) {
    window.location.href='${basePath}/item/' + goodinfoid;
}
function minicartonloadNew(){
    console.log("minicart11111");
    $(".mcTotalFee").html('0.00')
    $(".shopcaritemnum").html('0');
    $(".mcNumChecked").html('0');
    $.ajaxSetup({ cache: false });
    $.ajax({ url: "${basePath}/minisscart.htm",  async:false ,success: function(datee){
        var cartgoods = datee.shopcart.miniGoodsList;
        var empvalue = 0;
        //设置我的购物车显示购物车商品数量
        if(cartgoods != null){
            $(".sc_num em").html(cartgoods.length);
        }else{
            $(".sc_num em").html("0");
        }
        //比如一件商品买了3件,详细统计购买商品数量
        var countgoods=0;
        //购物车中有商品
        if(cartgoods != null && cartgoods.length>0){
            //mini购物车头部
            //循环输出购物车中的商品
            $(".cart-goods").html("");
            for(var i = 0 ; i < cartgoods.length ; i++) {
                countgoods += cartgoods[i].buNum;
                var cartgood = "";
                if (cartgoods[i].fitId == null) {
                    if(cartgoods[i].marketing !=null && cartgoods[i].marketing.codexType == "11" && Number(cartgoods[i].marketing.customerbuynum!=0)){
                        cartgood =
                                '   <li>' +
                                '       <div class="li_top">' +
                                '           <div class="li_a">'+
                                '               <img style="width:80px;height:80px;cursor:pointer;" alt="" src="' + cartgoods[i].productPic + '" onclick="img_click(' + cartgoods[i].goodsInfoId + ')">' +
                                '               <a href="${basePath}/item/' + cartgoods[i].goodsInfoId + '" title="' + cartgoods[i].productName + '">'
                                + cartgoods[i].productName +
                                '               </a> ' +
                                '           </div>' +
                                '           <div class="li_div"> ' ;
                         if(Number(cartgoods[i].marketing.customerbuynum) < Number(cartgoods[i].buNum)){
                             var oldPrice = accDiv(cartgoods[i].productPrice,cartgoods[i].marketing.rushs[0].rushDiscount);
                             cartgood +=
                                     '               <p>￥' +
                                     '                   <span class="li_p">'+ Number(cartgoods[i].productPrice).toFixed(2) +'</span>'+
                                     '                   <span>×'+ cartgoods[i].marketing.customerbuynum +'</span>' +
                                     '               </p> ' +
                                     '               <p>￥' +
                                     '                   <span class="li_p">'+ oldPrice +'</span>'+
                                     '                   <span>×'+ (parseInt(cartgoods[i].buNum)-parseInt(cartgoods[i].marketing.customerbuynum)) +'</span>' +
                                     '               </p> ' +
                                     '               <a href="javascript:;" class="delete del delect_minicart" >删除</a>'+
                                     "               <input type= 'hidden' class= 'goodsid' value = '" + cartgoods[i].shoppingCartId + "'>" +
                                     "               <input type= 'hidden' class= 'goodsinfo' value = '" + cartgoods[i].goodsInfoId + "'>" +
                                     '           </div> ' +
                                     '        </div> ' +
                                     '   </li>';
                         }else{
                             cartgood +=
                             '               <p>￥' +
                             '                   <span class="li_p">'+ Number(cartgoods[i].productPrice).toFixed(2) +'</span>'+
                             '                   <span>×'+ cartgoods[i].buNum +'</span>' +
                             '               </p> ' +
                             '               <a href="javascript:;" class="delete del delect_minicart" >删除</a>'+
                             "               <input type= 'hidden' class= 'goodsid' value = '" + cartgoods[i].shoppingCartId + "'>" +
                             "               <input type= 'hidden' class= 'goodsinfo' value = '" + cartgoods[i].goodsInfoId + "'>" +
                             '           </div> ' +
                             '        </div> ' +
                             '   </li>';
                         }
                    }else{
                        cartgood =
                                '   <li>' +
                                '       <div class="li_top">' +
                                '           <div class="li_a">'+
                                '               <img style="width:80px;height:80px;cursor:pointer;" alt="" src="' + cartgoods[i].productPic + '" onclick="img_click(' + cartgoods[i].goodsInfoId + ')">' +
                                '               <a href="${basePath}/item/' + cartgoods[i].goodsInfoId + '" title="' + cartgoods[i].productName + '">'
                                + cartgoods[i].productName +
                                '               </a> ' +
                                '           </div>' +
                                '           <div class="li_div"> ' +
                                '               <p>￥' +
                                '                   <span class="li_p">'+ Number(cartgoods[i].productPrice).toFixed(2) +'</span>'+
                                '                   <span>×'+ cartgoods[i].buNum +'</span>' +
                                '               </p> ' +
                                '               <a href="javascript:;" class="delete del delect_minicart" >删除</a>'+
                                "               <input type= 'hidden' class= 'goodsid' value = '" + cartgoods[i].shoppingCartId + "'>" +
                                "               <input type= 'hidden' class= 'goodsinfo' value = '" + cartgoods[i].goodsInfoId + "'>" +
                                '           </div> ' +
                                '        </div> ' +
                                '   </li>';
                    }

//                        console.log(cartgood);
                    $(".cart-goods").append(cartgood);
                } else {
                    var cartgood =
                        '<li>' +
                        '<div class="li_top" style="height:40px; "> ' +
                        '   <div class="li_a">'+
                        '       <strong>[套装]</strong>' +
                        '       <span>' + cartgoods[i].miniFit.fitName + '</span>'+
                        '   </div>' +
                        '   <div class="li_div"> ' +
                        '       <span>' +
                        '           <b>优惠：</b>&yen;'+cartgoods[i].miniFit.fitPrice+'<em>×' + cartgoods[i].buNum + '</em>' +
                        '       </span>'+
                        '       <a href="javascript:;" class="delete del delect_minicart" style="text-align: right;float: right;">删除</a>'+
                        "       <input type= 'hidden' class= 'goodsid' value = '" + cartgoods[i].shoppingCartId + "'>" +
                        "       <input type= 'hidden' class= 'goodsinfo' value = '" + cartgoods[i].goodsInfoId + "'>" +
                        '   </div>' +
                        '</div>' +
                        '</li>';
                    $(".cart-goods").append(cartgood);
                    var goodsList = cartgoods[i].miniFit.miniGoods;
                    //套装中货品的销售价格
                    var suitPrice =0;
                    for (var j = 0; j < goodsList.length; j++) {
                        cartgood =
                            '<li>' +
                            '<div class="li_top"> ' +
                            '   <div class="li_a">' +
                            '       <img alt="80" height="80" src="' + goodsList[j].productPic + '">' +
                            '       <a href="${basePath}/item/' + goodsList[j].goodsInfoId + '" title="' + goodsList[j].productName + '">' +
                            goodsList[j].productName +
                            '       </a> ' +
                            '   </div>' +
                            '   <div class="li_div"> ' +
                            '       <p>' +
                            '           <span>￥'+ goodsList[j].productPrice +'</span>'+
                            '           <span>×'+ cartgoods[i].buNum +'</span>' +
                            '       </p>' +
                            '   </div> ' +
                            '</div>' +
                            '</li>';
                        suitPrice=suitPrice+goodsList[j].productPrice*goodsList[j].buNum;
                        $(".cart-goods").append(cartgood);
                    }
                }
                //计算总价格
                if(cartgoods[i].fitId==null){
                    //如果是抢购 并且还没超出数量
                    if(cartgoods[i].marketing !=null && cartgoods[i].marketing.codexType == "11" && Number(cartgoods[i].marketing.customerbuynum!=0)){
                        if(Number(cartgoods[i].marketing.customerbuynum) < Number(cartgoods[i].buNum)){
                            var oldPrice = accDiv(cartgoods[i].productPrice,cartgoods[i].marketing.rushs[0].rushDiscount);
                            empvalue =accAdd(empvalue,accAdd(accMul(cartgoods[i].productPrice,cartgoods[i].marketing.customerbuynum),accMul(oldPrice,(cartgoods[i].buNum-cartgoods[i].marketing.customerbuynum))));
                        }else {
                            empvalue =accAdd(empvalue,accMul(cartgoods[i].productPrice,cartgoods[i].buNum));
                        }
                    }else{
                        empvalue =accAdd(empvalue,accMul(cartgoods[i].productPrice,cartgoods[i].buNum));
                    }
                }else{
                    empvalue=accAdd(empvalue,accMul(suitPrice-cartgoods[i].miniFit.fitPrice,cartgoods[i].buNum));
                }
            }
            //设置mini购物车底部
            $(".li_btn").show();
            $(".mcNumTotal").text(countgoods);
            $(".shopcaritemnum").text(countgoods);
            $(".mcTotalFee").text(empvalue);
//                $(".shopcarright_list").show();
            $(".minicart_empty").hide();
        }else{
            cartgood ='<div style="padding-left:70px;background:url(${basePath}/index_twentyone/images/nogoods.png) 20px center no-repeat;text-align: center;font-size:14px;line-height: 60px;height:60px;">购物车中还没有商品，赶快选购吧</div>';
            $(".cart-goods").html(cartgood);
            $(".li_btn").hide();
//            $(".shopcarright_list").show();
        }
    }});
};
</script>