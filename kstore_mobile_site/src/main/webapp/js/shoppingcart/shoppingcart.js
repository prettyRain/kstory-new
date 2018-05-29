var custId = $("#customerId").val();
var basePath = $("#basePath").val();
$(function () {
    //更换促销
    $(".fav-list .check-box").click(function () {
        if ($(this).parent().parent().prop("class") == 'selected') {
            $(this).parents(".fav-list").find(".selected").removeClass("selected");
        } else {
            $(this).parents(".fav-list").find(".selected").removeClass("selected");
            $(this).parents("li").addClass("selected");

        }
    });
    checkAll(true);
});
//全选
function checkAll(nextStatus) {
    var selected = $(".select-all .selected");
    var curStatus = selected.length == 1;
    nextStatus = nextStatus || !curStatus;

    if (nextStatus) {
        $(".select-all .select-box").addClass("selected");
        $(".select-part .select-box").addClass("selected");
        $('.cart-list').find('.select-box').each(function () {
            $(this).addClass("selected");
            checkone(this, true);
        })
    } else {
        $(".select-all .select-box").removeClass("selected");
        $(".select-part .select-box").removeClass("selected");
        $('.cart-list').find('.select-box').each(function () {
            $(this).removeClass("selected");
            checkone(this, false);
        })
    }

}
/**
 *
 * KKK 促销规则
 直降促销          1  可设置指定商品，进行直降M元进行促销
 买赠促销          2  为刺激消费，指定商品买即送赠品促销
 买送优惠券促销  3  可设置指定商品，进行送优惠券促销
 买折促销          4  可设置指定商品，进行折扣促销
 满减促销          5  可设置指定商品，购买单个商品满M元减N元促销
 满金额赠          6  可指定商品，设置单品满M元，赠送赠品促销
 满送优惠券促销  7  可指定商品，设置单品满M元，赠送优惠券促销
 满折促销          8  可指定商品，设置单品满M元，打N折促销
 限购              9  可指定商品，设置限购购买M件促销
 团购              10  可指定商品，设置团购促销
 抢购              11  可指定商品，设置抢购促销
 包邮              12  可指定商品，设置免运费促销
 买够件数打折      13  可指定购买M件不同的商品，打N折促销
 买够件数多少钱  14  可指定购买M件不同的商品，共N元促销
 折扣促销          15  可指定商品，设置不同折扣促销
 满数量赠          16  可指定商品，设置满M件，赠送赠品促销

 */
var tip = myAlertStr();
/**
 * cartItem 价格计算
 */
function ItemProcessor(cartItem) {
    var $cartItem = $(cartItem)
    this.item = $cartItem;

    this.price = $cartItem.find('.goodsPrice').val();
    this.num = $cartItem.find('.goodsNum').val();
    this.codeType = $cartItem.find('.fav-list').attr('attr-codextype');
    this.marketingId = $cartItem.find(".selected").find('.marketingAId').val();
    this.weight = $cartItem.find(".weight").val();

    this.youhui = 0;
    this.xiaoji = 0;
    this.oneweight = 0;
}

ItemProcessor.prototype.process = function () {

    // if(this.item.find('.select-box.selected').length > 0){
    if (this.item.find('.select-box').size() > 0) {

        if (this.item.find('.select-box').length > 0) {
            switch (this.codeType) {
                case "-1":
                    this._calGroup();
                    break;
                case "1":
                    this._calReduce();
                    break;
                case "5":
                    this._calFullReduce();
                    break;
                case "6":
                    this._calFullGift();
                    break;
                case "8":
                    this._calFullDiscount();
                    break;
                case "11":
                    this._calRush();
                    break;
                case "15":
                    this._calZhekou();
                    break;
                case "10":
                    this._calTuangou();
                    break;
                default:
                    this._calNoMarketing();
                    break;
            }
        }

    }
    this._render();
}
/**
 * 将结果 填充到cartItem 隐藏域
 * @private
 */
ItemProcessor.prototype._render = function () {
    this.item.parents(".group-atxt").find(".youhui").val(this.youhui);
    this.item.parents(".group-atxt").find(".oneprice").val(this.xiaoji);
    this.item.parents(".group-atxt").find(".oneweight").val(this.oneweight);
};
/**
 * 套装计算
 */
ItemProcessor.prototype._calGroup = function () {
    var groupPreferamount = this.item.find('.groupPreferamount').val(); // 优惠价

    this.youhui = _.multiply(this.num, groupPreferamount);
    this.xiaoji = _.multiply(this.num, this.price); // price = originPrice
};

/**
 * 直降
 */
ItemProcessor.prototype._calReduce = function () {
    var self = this;
    var totalPrice = 0;
    var totalYouhui = 0;
    var totalWeight =0;


        this.item.parents("ul").children("li").find("div.list-item").find(".selected").parent().siblings("div.fav-list").find("li.selected").find(".marketingAId")
            .each(function () {
                // if ($(this).val() == self.marketingId) {
                // var zhijiang = $(this).parents(".fav-list").siblings("ul.fav-list").find(".zhijiang_offValue").val();
                // self.youhui = _.multiply(self.num, zhijiang);
                // self.xiaoji = _.multiply(self.num, self.price);
                // return false;
                // }
                var selected = $(this).parents('div.fav-list').siblings('.list-item').find('.select-box.selected').length > 0;

                if (selected && $(this).val() == self.marketingId) {
                    var weight = $(this).parents("div.fav-list").siblings("div.list-item").find(".weight").val();
                    var price = $(this).parents("div.fav-list").siblings("div.list-item").find(".goodsPrice").val();
                    var num = $(this).parents("div.fav-list").siblings("div.list-item").find(".goodsNum").val();
                    var zhijiang = $(this).parents(".fav-list").siblings("ul.fav-list").find(".zhijiang_offValue").val();
                    //totalYouhui = _.add(_.multiply(num, zhijiang), totalYouhui);
                    totalPrice = _.add(_.multiply(num, price), totalPrice);
                    totalWeight = _.add(_.multiply(num, weight), totalWeight);
                }

            });



    /**
     * render
     */
    this.item.find("div.list-item").parents('ul').children("li").find("div.fav-list").find("li.selected").find(".marketingAId").each(function () {

        if ($(this).val() == self.marketingId) {
            $(this).parents("div.fav-list").parent("li").find(".youhui").val(totalYouhui);
            $(this).parents("div.fav-list").parent("li").find(".oneprice").val(totalPrice);
        }
    });
    self.youhui = totalYouhui
    self.xiaoji = totalPrice
    self.oneweight = totalWeight;
};
/**
 *  满折
 * @private
 */
ItemProcessor.prototype._calFullDiscount = function () {
    var self = this;
    var item = this.item;
    var num = this.num;
    var price = this.price;

    self.xiaoji = _.multiply(num, price);

    //满折
    var totalPrice = 0;
    var totalYouhui = 0;
    var totalWeight =0;
    /**
     * 计算总价
     */
    item.parents("ul").children("li").find("div.list-item").find(".selected").parent().siblings("div.fav-list").find("li.selected").find(".marketingAId").each(function () {
        var selected = $(this).parents('div.fav-list').siblings('.list-item').find('.select-box.selected').length > 0;

        if (selected && $(this).val() == self.marketingId) {
            var weight = $(this).parents("div.fav-list").siblings("div.list-item").find(".weight").val();
            var price = $(this).parents("div.fav-list").siblings("div.list-item").find(".goodsPrice").val();
            var num = $(this).parents("div.fav-list").siblings("div.list-item").find(".goodsNum").val();
            totalPrice = accAdd(accMul(num, price), totalPrice);
            totalWeight = accAdd(accMul(num,weight),totalWeight);
        }

    });

    /**
     * 计算匹配的优惠
     */
    item.find(".manzhe_fullbuyDiscount").each(function () {
        var man = $(this).val().split(",")[0];
        var zhe = $(this).val().split(",")[1];
        if (_.subtract(totalPrice, man) >= 0) {
            var youhui = _.multiply(totalPrice, _.subtract(1, zhe));
            totalYouhui = Math.max(totalYouhui, youhui);
        }
    });

    /**
     * render
     */
    item.find("div.list-item").parents('ul').children("li").find("div.fav-list").find("li.selected").find(".marketingAId").each(function () {

        if ($(this).val() == self.marketingId) {
            $(this).parents("div.fav-list").parent("li").find(".oneprice").val(totalPrice);
            $(this).parents("div.fav-list").parent("li").find(".youhui").val(totalYouhui);
        }

    });

    self.youhui = totalYouhui
    self.xiaoji = totalPrice
    self.oneweight =totalWeight;
};

/**
 * 抢购促销 计算
 */
ItemProcessor.prototype._calRush = function () {
    var goodsNum = this.item.find(".goodsNum").val();
    var rushsbuy = this.item.find(".goodsNum").attr("rushsbuy");
    var rushsprice = this.item.find(".goodsNum").attr("rushsprice");//原价
    //超出抢购数量时
    if(rushsbuy!="0" && parseInt(goodsNum)>parseInt(rushsbuy)){
       this.item.find(".price").find("span").html(parseInt(rushsprice)+".");
       this.item.find(".price").find("em").html(Number(rushsprice).toFixed(2).toString().substring(Number(rushsprice).toFixed(2).toString().indexOf(".")+1));
       this.item.find(".price").find("b").html("×"+(goodsNum-rushsbuy));
       this.item.find(".price").css("display","inline-block");
       this.item.find(".ohtherprice").find("span").html(parseInt(this.price)+".");
       this.item.find(".ohtherprice").find("em").html(Number(this.price).toFixed(2).toString().substring(Number(this.price).toFixed(2).toString().indexOf(".")+1));
       this.item.find(".ohtherprice").find("b").html("×"+rushsbuy);
       //没超出限购数量
    }else{
        this.item.find(".price").css("display","none");
        this.item.find(".ohtherprice").find("span").html(parseInt(this.price)+".");
        this.item.find(".ohtherprice").find("em").html(Number(this.price).toFixed(2).toString().substring(Number(this.price).toFixed(2).toString().indexOf(".")+1));
        this.item.find(".ohtherprice").find("b").html("×"+this.num);
    }

    var self = this;
    if(this.item.find("div.list-item").find(".selected").length>0){
        this.item.find("div.list-item").find(".selected").parent().siblings(".fav-list").find("li.selected").find(".marketingAId").each(function () {
            if ($(this).val() == self.marketingId) {
                var zhijiang = $(this).parents(".fav-list").siblings("ul.fav-list").find(".qianggou_offValue").val();
                self.youhui = _.multiply(self.num, zhijiang);
                if(rushsbuy!="0" && parseInt(goodsNum)>parseInt(rushsbuy)){
                    self.xiaoji =  accAdd(accMul(rushsprice,Subtr(goodsNum,rushsbuy)),accMul(self.price,rushsbuy));
                }else{
                    self.xiaoji = _.multiply(self.num, self.price);
                }
                var weight = $(this).parents("div.fav-list").siblings("div.list-item").find(".weight").val();
                self.oneweight = _.multiply(self.num,weight);
                return false;
            }
        });
    }else{

        self.xiaoji = 0;
        self.oneweight =0;
        return false;
    }
};
/**
 * 折扣促销
 */
ItemProcessor.prototype._calZhekou = function() {
    var self = this;
    var totalXiaoji = 0;
    var totalWeight = 0;
    //如果有选中
    if (this.item.find("div.list-item").find(".selected").length > 0) {
        var xiaoji = 0;
        this.item.parents("ul").find("div.list-item").find(".selected").parent().siblings(".fav-list").find("li.selected").find(".marketingAId").each(function () {
            var weight = $(this).parents("div.fav-list").prev().find(".weight").val();
            var num = $(this).parents("div.fav-list").prev().find(".goodsNum").val();
            var price = $(this).parents("div.fav-list").prev().find(".goodsPrice").val();
            var thisprice = _.multiply(num, price);
            totalXiaoji = accAdd(totalXiaoji, thisprice);
            totalWeight = accAdd(_.multiply(num, weight), totalWeight);
        })

        self.xiaoji = totalXiaoji;
        self.oneweight = totalWeight;
        return false;
         }else {
         var oldxiaoji = this.item.parents(".group-atxt").find(".oneprice").val();
         //如果小计不为零
         if(oldxiaoji!="0"){
         var num = this.item.find("div.list-item").find(".goodsNum").val();
         var price = this.item.find("div.list-item").find(".goodsPrice").val();
         var weight = this.item.find("div.list-item").find(".weight").val();
         var thisprice = _.multiply(num,price);
         var thisweight = _.multiply(num,weight);
         var oldweight = this.item.parents(".group-atxt").find(".oneweight").val();
         self.oneweight = Subtr(oldweight,thisweight);
         self.xiaoji = Subtr(oldxiaoji,thisprice);
         return false;
         }
    }
}
/**
 * 满减
 * @private
 */
ItemProcessor.prototype._calFullReduce = function () {
    var self = this;
    var item = this.item;

    // self.xiaoji = _.multiply(num, price);
    //
    // item.find(".manjian_reducePrice").each(function () {
    //   var man = $(this).val().split(",")[0];
    //   var jian = $(this).val().split(",")[1];
    //   if (_.subtract(self.xiaoji, man) >= 0) {
    //     self.youhui = Math.max(self.youhui, jian);
    //   }
    // });

    var totalPrice = 0;
    var totalYouhui = 0;
    var totalWeight =0;

    item.parents("ul").children("li").find("div.list-item").find(".selected").parent().siblings("div.fav-list").find("li.selected").find(".marketingAId")
        .each(function () {
            // if ($(this).val() == self.marketingId) {
            // var zhijiang = $(this).parents(".fav-list").siblings("ul.fav-list").find(".zhijiang_offValue").val();
            // self.youhui = _.multiply(self.num, zhijiang);
            // self.xiaoji = _.multiply(self.num, self.price);
            // return false;
            // }
            var selected = $(this).parents('div.fav-list').siblings('.list-item').find('.select-box.selected').length > 0;

            if (selected && $(this).val() == self.marketingId) {
                var price = $(this).parents("div.fav-list").siblings("div.list-item").find(".goodsPrice").val();
                var num = $(this).parents("div.fav-list").siblings("div.list-item").find(".goodsNum").val();
                 var weight = $(this).parents("div.fav-list").siblings("div.list-item").find(".weight").val();
                totalPrice = _.add(_.multiply(num, price), totalPrice);
                totalWeight = _.add(_.multiply(num,weight),totalWeight);
            }

        });

    /**
     * 计算匹配的优惠
     */
    item.find(".manjian_reducePrice").each(function () {
        var man = $(this).val().split(",")[0];
        var jian = $(this).val().split(",")[1];
        if (_.subtract(totalPrice, man) >= 0) {
            totalYouhui = Math.max(totalYouhui, jian);
        }
    });

    /**
     * render
     */
    this.item.find("div.list-item").parents('ul').children("li").find("div.fav-list").find("li.selected").find(".marketingAId").each(function () {

        if ($(this).val() == self.marketingId) {
            $(this).parents("div.fav-list").parent("li").find(".youhui").val(totalYouhui);
            $(this).parents("div.fav-list").parent("li").find(".oneprice").val(totalPrice);
        }
    });
    self.youhui = totalYouhui
    self.xiaoji = totalPrice
    self.oneweight = totalWeight
};

/**
 * 满赠
 * @private
 */
ItemProcessor.prototype._calFullGift = function () {
    var self = this;
    var item = this.item;
    var totalPrice = 0;
    var totalCount = 0;
    var totalWeight = 0;

    item.find("div.list-item").parents('ul').children("li").find("div.fav-list").find("li.selected").find(".marketingAId").each(function () {
        // cart_item 是否被选中
        var selected = $(this).parents('div.fav-list').siblings('.list-item').find('.select-box.selected').length > 0;
        // 计算 选中商品 的数量 和总价
        if (selected && $(this).val() == self.marketingId) {
            var price = $(this).parents("div.fav-list").siblings("div.list-item").find(".goodsPrice").val();
            var num = $(this).parents("div.fav-list").siblings("div.list-item").find(".goodsNum").val();
            var weight = $(this).parents("div.fav-list").siblings("div.list-item").find(".weight").val();

            totalWeight = accAdd(_.multiply(num, weight), totalWeight);
            totalCount = accAdd(num, totalCount);
            totalPrice = accAdd(_.multiply(num, price), totalPrice);
        }
    });


    item.find("div.list-item").parents('ul').children("li").find("div.fav-list").find("li.selected").find(".marketingAId").each(function () {
        if ($(this).val() == self.marketingId) {
            $(this).parents("div.fav-list").parent("li").find(".oneprice").val(totalPrice);
        }
    });

    self.xiaoji = totalPrice;
    self.oneweight = totalWeight;
    var ojb;
    item.find("div.list-item").siblings(".fav-list").find(".marketingAId").each(function () {
        if ($(this).val() == self.marketingId) {
            if ($(this).parents(".group-atxt").find(".set_gift").length > 0) {
                ojb = this;
            }
        }
    });
    var flag = 0;
    item.find(".fullbuy_present").each(function () {
        var splited = $(this).val().split(",");
        var man = splited[0];
        var marketId = splited[1];
        var presentId = splited[2];
        var presentMode = splited[3];
        var presentType = splited[4];
        if ((presentType == '0' && Subtr(totalPrice, man) >= 0) || ((presentType == '1' && Subtr(totalCount, man) >= 0))) {
            flag += 1;
            $(ojb).parents(".group-atxt").find(".set_gift").attr("style", "display:none");
            $("#gift_box_" + marketId + "_" + presentId + "_" + presentMode + "_" + presentType).attr("style", "display:inline");
            var selectedGifts = '';
            if (presentMode == '1') {
                $("#gift_box_" + marketId + "_" + presentId + "_" + presentMode + "_" + presentType).find(".gift_item").each(function () {
                    //if($(this).hasClass("checked")){
                    selectedGifts += '<p><span>赠品</span>&nbsp;&nbsp;&nbsp;&nbsp;' +
                        '<span class="name">' + $(this).find(".name").html() + '</span>' +
                        '<span class="num1" scopenum=' + $(this).find(".num").attr("scopenum") + '>×' + $(this).find(".num").attr("scopenum") + '</span>' +
                        '<input type="hidden" value="' + $(this).find("input").val() + '">' +
                        '</p>';
                    return false;
                    //}
                });

            } else if (presentMode == '0') {
                $("#gift_box_" + marketId + "_" + presentId + "_" + presentMode + "_" + presentType).find(".gift_item").each(function () {
                    //if($(this).hasClass("checked")){
                    selectedGifts += '<p><span>赠品</span>&nbsp;&nbsp;&nbsp;&nbsp;' +
                        '<span class="name">' + $(this).find(".name").html() + '</span>' +
                        '<span class="num1" scopenum=' + $(this).find(".num").attr("scopenum") + '>×' + $(this).find(".num").attr("scopenum") + '</span>' +
                        '<input type="hidden" value="' + $(this).find("input").val() + '">' +
                        '</p>';
                    //}
                });
            }
            var selectGift = "select-gift_" + marketId + "_" + presentId + "_" + presentMode + "_" + presentType;
            $(ojb).parents(".group-atxt").find(".cart_gifts").find("a").remove();
            //去掉修改赠品的功能
            //$(ojb).parents(".group-atxt").find(".cart_gifts").append('<a href="javascript:;" class="change_gift" onclick="showchangegift(this);" id="' + selectGift + '">修改赠品</a>');
            //$(ojb).parents("li").find(".cart_gifts").append('<a href="javascript:;" class="change_gift" id="select-gift_"+marketId+"_"+presentId+"_"+presentMode+"_"+presentType>修改赠品</a>');
            //$(ojb).parents("li").find(".cart_gifts").find(".change_gift").attr("id",);
            $(ojb).parents(".group-atxt").find(".cart_gifts").find("p").remove();
            //如果该级赠品中有赠品（主要针对赠送优惠券）
            if(!!selectedGifts){
                $(ojb).parents(".group-atxt").find(".cart_gifts").next(".div_line").show();
            }else{
                $(ojb).parents(".group-atxt").find(".cart_gifts").next(".div_line").hide();
            }
            console.log(!!selectedGifts);
            $(ojb).parents(".group-atxt").find(".cart_gifts").append(selectedGifts);

        }
        if (flag == 0) {
            $(ojb).parents(".group-atxt").find(".cart_gifts").next(".div_line").hide();
            $(ojb).parents(".group-atxt").find(".cart_gifts").html("");
        }
    });
};
ItemProcessor.prototype._calTuangou = function(){
    if(this.item.find("div.list-item").find(".selected").length>0){
        this.xiaoji = _.multiply(this.num, this.price);
        this.oneweight = _.multiply(this.num,this.weight);
    }
}
/**
 * 普通商品
 * @private
 */
ItemProcessor.prototype._calNoMarketing = function () {
    if(this.item.find("div.list-item").find(".selected").length>0){
        this.xiaoji = _.multiply(this.num, this.price);
        this.oneweight = _.multiply(this.num,this.weight);
    }

};


function checkone(ojb, nextStatus) {

    var curNotSelected

    if (nextStatus != undefined) {
        curNotSelected = nextStatus
    }
    else {
        var selected = $(ojb).parent().find(".selected");
        curNotSelected = selected.length == 0;
    }
    if (curNotSelected) {
        $(ojb).addClass("selected");
    } else {
        $(ojb).removeClass("selected");
    }

    // var $cartItem = $(ojb).parents('li');
    var processor = new ItemProcessor($(ojb).parents('li')[0]);
    processor.process();

    //点击购物车商品左侧选择，全不选时取消底下全选按钮
    if ($(".cart-list .select-box.selected").length == 0) {
        $(".select-all .select-box").removeClass("selected");
        $(".select-part .select-box").removeClass("selected");
    }
    //点击购物车商品左侧选择，全选时底下全选按钮全选
    if ($(".cart-list .select-box.selected").length >= $(".cart-list .select-box").length) {
        $(".select-all .select-box").addClass("selected");
        $(".select-part .select-box").addClass("selected");
    } else {
        $(".select-all .select-box").removeClass("selected");
        $(".select-part .select-box").removeClass("selected");
    }

    lastsum();

}
//减少数量
function minuss(obj, cartId,goodsInfoId) {
    var $goodsNum = $(obj).siblings('.goodsNum');
    var amount=parseInt($('.amount').html());
    var nowNum = parseInt($goodsNum.val()) || 1;
    var minNum = 1;
    var nextNum = Math.max(nowNum - 1, minNum);
    if(nextNum == 1) {
        $(obj).parents(".buy-num").find(".minuss").removeClass("canclick");
    }else{
        $(obj).parents(".buy-num").find(".minuss").addClass("canclick");
    }
    if (nextNum != nowNum) {
        $('.amount').html(amount-1);
        $goodsNum.val(nextNum);
        $goodsNum.next(".goodsNumShow").text(nextNum);
        $(obj).parent().parent('.group-settle').prev('.xcyclass').children('.cart-pro-item').children('.prodesc').children().children('.amount').each(function(index,item){
            $(item).html(nextNum+'件/套');
        });
        $(obj).parents('.group-settle').prev('.xcyclass').find('.goods-num').each(function(index,item){
            $(this).val(nextNum);
        });
        if($(obj).siblings(".goodsNum").attr("rushsbuy")=="0" || !$(obj).siblings(".goodsNum").attr("rushsbuy")){
            $(obj).parents(".prodesc").find(".ohtherprice b").html("×"+nextNum);
        }
        //通过判断 提示仅剩几件 和库存不足  以及修改结算开关
        var stock = $goodsNum.attr("attr-maxnum");
        if(nextNum > stock && $(obj).parents(".prodesc").find(".insufficient").length>0 && stock>0 && $(obj).attr("data-added")=='1'){
            $(obj).parents(".list-item").find(".insufficient").html("仅剩"+stock+"件");
        }else if($(obj).parents(".prodesc").find(".insufficient").length>0 && stock>0 && $(obj).attr("data-added")=='1'){
            $(obj).parents(".list-item").find(".insufficient").html("");
            $(obj).parents(".list-item").find(".noexit").remove();
        }else if(nextNum > stock ||  $(obj).attr("data-added")=='0'){
            if($(obj).parents(".list-item").find(".noexit").length==0){
                $(obj).parents(".list-item").append('<input type="hidden" value="1" class="noexit"/>');
            }
        }
        changeNum(cartId, nextNum,goodsInfoId);
        jisuan(obj);
    }
}
var tip = myAlertStr();
function opblur(obj, cartId) {

    var reg = new RegExp("^[0-9]*$");
    var $goodsNum = $(obj);
    var nowNum = parseInt($goodsNum.val()) || 1;
    var maxNum = parseInt($goodsNum.attr("attr-maxnum")) || 1;
    var nextNum;

    if (reg.test(nowNum)) {
        nextNum = Math.min(Math.max(1, nowNum), maxNum);
    }
    else {
        nextNum = 1;
    }
    $goodsNum.val(nextNum);
    $(obj).parent().parent('.group-settle').prev('.xcyclass').children('.cart-pro-item').children('.prodesc').children().children('.amount').each(function(index,item){
        $(item).html(nextNum+'件/套');
    });
    $(obj).parents('.group-settle').prev('.xcyclass').find('.goods-num').each(function(index,item){
        $(this).val(nextNum);
    });
    if($(obj).siblings(".goodsNum").attr("rushsbuy")=="0" || !$(obj).siblings(".goodsNum").attr("rushsbuy")){
        $(obj).parents(".prodesc").find(".ohtherprice b").html("×"+nextNum);
    }

    if($(obj).parents(".list-item").find(".insufficient").length>0 && maxNum<10 && maxNum>0){
        $(obj).parents(".list-item").find(".insufficient").html("仅剩"+maxNum+"件");
        $(obj).parents(".list-item").find(".noexit").remove();
    }
    changeNum(cartId, nextNum,goodsInfoId);
    jisuan(obj);
}

function pluss(obj, cartId,goodsInfoId) {
    $(obj).parents(".buy-num").find(".minuss").addClass("canclick");
    var $goodsNum = $(obj).siblings('.goodsNum');
    var nowNum = parseInt($goodsNum.val()) || 1;
    var maxNum = $goodsNum.attr("attr-maxnum");
    //var nextNum = Math.min(nowNum + 1, maxNum);
    //不管有没有库存都可以加数量
    var nextNum = nowNum + 1;
    var goodsNum = $goodsNum.val();
    //可以享受抢购的数量
    var rushsbuy = $(obj).siblings('.goodsNum').attr("rushsbuy");

   /* if((nowNum + 1)>maxNum){
        tip("库存不足");
    } else*/ if(!!rushsbuy){
        if(nowNum==Number(rushsbuy) && (nextNum-nowNum)==1){
            tip("该商品仅有"+rushsbuy+"件享受优惠哦");
        }
    }
    /*if (nextNum != 0) {
        var $curItem = $(obj).parents(".list-item");
        $curItem.find(".sell-out").remove();
        $curItem.find(".noexit").remove();
    }*/
    //通过判断 提示仅剩几件 和库存不足  以及修改结算开关
    if($(obj).parents(".list-item").find(".insufficient").length>0 && parseInt(nextNum)>parseInt(maxNum) && parseInt(maxNum)>0 && $(obj).attr("data-added")=='1'){
        $(obj).parents(".list-item").find(".insufficient").html("仅剩"+maxNum+"件");
        if($(obj).parents(".list-item").find(".noexit").length==0){
            console.log(11);
            $(obj).parents(".list-item").append('<input type="hidden" value="1" class="noexit"/>');
        }
    }else if($(obj).attr("data-added")=='0'|| parseInt(nextNum)>parseInt(maxNum)){
        if($(obj).parents(".list-item").find(".noexit").length==0){
            $(obj).parents(".list-item").append('<input type="hidden" value="1" class="noexit"/>');
        }
    }else {
        $(obj).parents(".list-item").find(".noexit").remove();
    }
    nextNum = Math.min(99,nextNum);




    // $goodsNum.val(nextNum);
    // $goodsNum.next(".goodsNumShow").text(nextNum);
    $(obj).parent().parent('.group-settle').prev('.xcyclass').children('.cart-pro-item').children('.prodesc').children().children('.amount').each(function(index,item){
        $(item).html(nextNum+'件/套');
    });
    $(obj).parents('.group-settle').prev('.xcyclass').find('.goods-num').each(function(index,item){
        $(this).val(nextNum);
    });
    // /*库存不足,点击+数量不动*/
    /*if((nowNum + 1)>maxNum){
        $goodsNum.val(nowNum);
        $goodsNum.next(".goodsNumShow").text(nowNum);
        if($(obj).siblings(".goodsNum").attr("rushsbuy")=="0" || !$(obj).siblings(".goodsNum").attr("rushsbuy")){
            $(obj).parents(".prodesc").find(".ohtherprice b").html("×"+nowNum);
        }
    }else{*/
        $goodsNum.val(nextNum);
        $goodsNum.next(".goodsNumShow").text(nextNum);
        if($(obj).siblings(".goodsNum").attr("rushsbuy")=="0" || !$(obj).siblings(".goodsNum").attr("rushsbuy")){
            $(obj).parents(".prodesc").find(".ohtherprice b").html("×"+nextNum);
        }
   /* }*/

    changeNum(cartId, nextNum,goodsInfoId);
    jisuan(obj);

}

//<!--已登录修改数量-->
function changeNum(id, num,goodsInfoId) {
    $.post(basePath + "/changeshoppingmcartbyid/" + id + "-" + num+"-"+goodsInfoId, function (data) {
        if (data == 1) {
        }
    });
}
function jisuan(obj) {
    //计算价格 总计和优惠
    var $cartItem = $(obj).parents("li")[0];
    var itemProcessor = new ItemProcessor($cartItem);
    itemProcessor.process();

    lastsum();
}

function lastsum() {
    var zongji = 0;
    var fanxian = 0;
    var num = 0;
    var zjweight =0 ;
    $(".oneprice").each(function () {
        zongji = accAdd(zongji, $(this).val());
    });
    $(".goodsNum").each(function(){
        var _this = $(this);
        if(_this.parents(".list-item").find(".select-box").hasClass("selected")){
            num = accAdd(num,$(this).val());
        }
    })
    $(".oneweight").each(function(){
        zjweight = accAdd(zjweight,$(this).val());
    })
    // var zongji = _.reduce($(".oneprice"), function (sum, item) {
    //   _.add($(this).val(), sum)
    //
    // }, 0);

    $(".youhui").each(function () {
        fanxian = accAdd(fanxian, $(this).val());
    });

    // var fanxian = _.reduce($(".oneprice"), function (sum, item) {
    //   _.add($(this).val(), sum)
    //
    // }, 0);
    var allcount = _.reduce($('.cart-list .select-box.selected'), function (sum, item) {
        var itemNum = parseInt($(item).parent().find(".goodsNum").val()) || 1;
        return _.add(itemNum, sum);
    }, 0);


    $("#goodsNum").html(allcount);
    $(".fanxian").html("¥" + fanxian);

    var actualPrice = Subtr(zongji, fanxian);
    $(".payPrice").html("¥" + actualPrice);
    $(".zongji").html("<span>¥</span>" + parseInt(zongji));
    $(".xiaoshu").html(zongji.toString().substring(zongji.toString().indexOf(".")));
    $("#myzongji").val(actualPrice);
    $("span.num").html(parseInt(num));
    $("span.zjweight").html(accDiv(zjweight,1000)+"kg");
}
//去结算
var onpayCount = 0;
function onpay(e) {
    _czc.push(['_trackEvent', '购物车', '结算', '点击结算','0','cart_onpay']);
    if($(".btn.cart-pay").hasClass("load")){
        return
    }else{
        $(".btn.cart-pay").addClass("load");
        $(".btn.cart-pay").html("结算中...");
    }

    var obj = $('.cart-list .select-box.selected');
    var markIds = [];
    if (obj.length != 0) {
        var vHtm = "";
        $(".shopbox").remove();
        var pifaCount = 0;
        var lingshouCount = 0;
        for (var i = 0; i < obj.length; i++) {
            if ($(obj[i]).parent().find(".noexit").length != 0) {
                /*var discountBox = dialog({
                    width: 260,
                    title: '操作提示',
                    content: "包含无货或下架商品，请重新选择!",
                    okValue: '确定',
                    cancelValue: '取消',
                    ok: function () {
                        return true;
                    },
                    cancel: function () {

                        return true;
                    }
                })
                discountBox.showModal();*/
                //新用的提示框 2017.9.18
                tip("包含无库存商品，请检查后提交");
                $(".btn.cart-pay").removeClass("load");
                $(".btn.cart-pay").html("结算");
                return;
            }
            if($(obj[i]).parents(".cart-group-item").length>0){
                $(obj[i]).parents(".cart-group-item").parent().find(".cart-pro-item").each(function () {
                    if ($(this).find(".sell-type").val() == '1') {
                        $(this).find(".goods-num").each(function () {
                            pifaCount = pifaCount + parseInt($(this).val());
                        });
                    }
                    if ($(this).find(".sell-type").val() == '0') {
                        $(this).find(".goods-num").each(function () {
                            lingshouCount = lingshouCount + parseInt($(this).val());
                        });
                    }
                });
            } else {

                if ($(obj[i]).parents("li").find(".sell-type").val() == '1') {
                    $(obj[i]).parents("li").find(".goods-num").each(function () {
                        pifaCount = pifaCount + parseInt($(this).val());
                    });
                }else {
                    $(obj[i]).parents("li").find(".goods-num").each(function () {
                        lingshouCount = lingshouCount + parseInt($(this).val());
                    });
                }
            }


            vHtm += "<input type='hidden' class='shopbox' value=" + $(obj[i]).parents('li').find('.shoppingCartId').val() + " name='box'/>";
            var marketingAId = $(obj[i]).parents("li").find("div.list-item").siblings(".fav-list").find(".marketingAId");
            var flag = true;
            for (var j = 0; j < markIds.length; j++) {
                if (markIds[j] == marketingAId.val()) {
                    flag = false;
                }
            }
            if (flag == true) {
                $(obj[i]).parents("li").find("div.list-item").siblings(".fav-list").find(".marketingAId").each(function () {

                    if (marketingAId != undefined && $(this).val() == marketingAId.val()) {
                        if ($(this).parents(".group-atxt").find(".set_gift").length > 0) {
                            var selectedGifts = $(this).parents(".group-atxt").find(".cart_gifts");
                            if (selectedGifts && selectedGifts.length > 0) {
                                var selectedGiftIds = '';
                                selectedGifts.find("input").each(function () {
                                    selectedGiftIds += $(this).val() + "a";
                                });
                                var boxgift = $(obj[i]).parent().find(".shoppingCartId").val() + ":" + selectedGiftIds;
                                boxgift = boxgift.toString();
                                boxgift = boxgift.substring(0, boxgift.lastIndexOf("a"));
                                vHtm += '<input type="hidden" value="' + boxgift + '" name="boxgift"/>';
                                markIds.push(marketingAId.val());

                            }
                        }
                    }
                });
            }


        }

        /*if(lingshouCount>0 && lingshouCount<10) {
            var tipBox = dialog({
                width: 260,
                title: '操作提示',
                content: "因商城优惠多，无法单个配送，零售商品的总数量须满足10个及以上，请及时调整，给您带来的不便，请谅解",
                cancelValue: '关闭',
                cancel: function () {
                    return true;
                }
            });
            tipBox.showModal();
            return;
        }*/
        /*if(onpayCount<1 && pifaCount>0&&lingshouCount>0) {
            var tipBox = dialog({
                width: 260,
                title: '操作提示',
                content: "960商城批发商品可配送至北京任意区域，若含零售商品仅配送到960社区店，您可以分开结算",
                okValue: '继续',
                cancelValue: '取消',
                ok: function () {
                    onpayCount ++;
                    onpay();
                    return true;
                },
                cancel: function () {

                    return true;
                }
            });
            tipBox.showModal();
            return;
        }*/

        // 判断总的费用 是否小于0
        var myzongjie = $("#myzongji").val();
        if (myzongjie < 0) {
            /*$('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>价格有误</h3></div></div>');
            setTimeout(function () {
                $('.tip-box').remove();
            }, 1000);*/
            tip("价格有误");
            $(".btn.cart-pay").removeClass("load");
            $(".btn.cart-pay").html("结算");
            return;
        }
        $(".subForm").append(vHtm);



        // setTimeout(function(){},4000)
        $(".btn.cart-pay").removeClass("load");
        $(".btn.cart-pay").html("结算");

        $(".subForm").submit();
    } else {
        var discountBox = dialog({
            width: 260,
            title: '操作提示',
            content: "购物车没有选中商品，是否跳转到首页",
            okValue: '确定',
            cancelValue: '取消',
            ok: function () {
                location.href = basePath + "/main.html"
                return true;
            },
            cancel: function () {

                return true;
            }
        });
        discountBox.showModal();
    }

}