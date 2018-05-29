// * 作者：shf
// * 时间：2017-08
// * 描述：改版，新增支付页


(function (doc, win) {
    var docEl = doc.documentElement,
        resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
        recalc = function () {
            var clientWidth = docEl.clientWidth;
            if (!clientWidth) return;
            docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
        };
    if (!doc.addEventListener) return;
    win.addEventListener(resizeEvt, recalc, false);
    doc.addEventListener('DOMContentLoaded', recalc, false);
})(document, window);


// * 作者：shf
// * 时间：2018-04
// * 描述：支付页效果优化
$(function() {
    $(".vheader .back img").attr({"src":"/images/v2/my-back.png"});


    // Framework7
    var myApp = new Framework7();
    var $$ = Dom7;

    // 判断礼品卡密码是否正确
    $$('.payPanel .affirm').on('click', function () {
        if (!$$(this).hasClass("affirmBtn")) {
            return;
        }
        $.ajax({
            url:"/checkPayPassword.htm",
            data:{"payPassword":$("#lpk_psd").val(),"orderPrice":$("#payPrice").val()},
            type:"post",
            async:false,
            beforeSend:function () {
                $(".affirm.affirmBtn").html('<img src="../../images/v3/doing.gif" width="49" height="49">')
            },
            success:function (result) {
                // console.log(result)
                var return_code = result.return_code;
                var fail_code = result.fail_code;
                var return_msg = result.return_msg;
                $(".affirm.affirmBtn").html('<span>确认</span>');
                if(result.return_code == "success"){
                    $("#integer").html($("#integerMoney").val());
                    $("#decimal").html( $("#decimalMoney").val());
                    $(".needgcprice").text($("#integerMoney").val()+$("#decimalMoney").val());
                    if($("#integerMoney").val()==0 && $("#decimalMoney").val()==0){
                        $(".way .select-box").removeClass("selected");
                    }
                    $(".lpCard.choose .before").hide();
                    $(".lpCard.choose .after").show();
                    $(".lpCard.choose .sta1").hide();
                    $(".lpCard.choose .sta2").hide();
                    $(".lpCard.choose").removeClass("open-popup");
                    $(".lpCard.choose .sta3").show();

                    //关闭输入密码面板
                    myApp.closeModal('.popup-about');
                }else if(result.return_code == "fail"){
                    $(".prompt").text(return_msg).addClass("error");
                    cancelcardPay();

                }
            }
        });

    });

    //取消礼品卡金额抵扣
    function cancelcardPay(){
        $(".lpCard.choose .after").hide();
        $(".lpCard.choose .sta1").hide();
        $(".lpCard.choose .sta3").hide();
        $(".lpCard.choose .sta2").show();
        $(".lpCard.choose").addClass("open-popup");
        $(".lpCard.choose .before").show();
        $("#integer").html(Subtr($('#payPrice').val(),0).toString().substring(0,Subtr($('#payPrice').val(),0).toString().indexOf('.')));
        $("#decimal").html(Subtr($('#payPrice').val(),0).toString().substring(Subtr($('#payPrice').val(),0).toString().indexOf('.')));
        $("#lpk_psd").val("");
        $(".way .select-box").addClass("selected");
        $(".affirm").removeClass("affirmBtn")
    }


    $('.lpCard .sta3').on('click', function () {
        var cancelGiftcard;
        cancelGiftcard = dialog({
            width: 260,
            title: '提示',
            content: "您确定要取消礼品卡金额抵扣吗？",
            okValue: '确定',
            cancelValue: '再想想',
            ok: function () {
                cancelcardPay();
            },
            cancel: function () {
                return true;
            }
        });
        cancelGiftcard.showModal();
    });


    //获取礼品卡金额等信息
    //activeFlag 激活状态（'-1'：无效，'0'：未激活，'1'：已激活，'2'：已失效(已绑定或者未绑定已过期)）
    //return_msg : （礼品卡错误信息）和（账余额）
    //return_code : fail失败    success成功
    //fail_code: pass_fail（账户锁定方面的失败）    balance_fail（余额不足的失败）  frozen_fail(账户锁定)
    var orderId = $("#orderId").val();
    $.ajax({
        url:'order/depositpay.html?orderId='+orderId,
        type:'post',
        success: function(result){
            console.log(result);
            var return_code = result.return_code;
            var fail_code = result.fail_code;
            var return_msg = result.return_msg;
            if(return_code == "nocard"){
                //您尚未绑定礼品卡
                $(".choose.lpCard").addClass("unable");
                $(".status.sta1").text("您尚未绑定礼品卡")
            }else{
                if(result.activeFlag == '-2'){
                    //您的卡片已挂失，请联系客服人员
                    $(".choose.lpCard").addClass("unable");
                    $(".status.sta1").text("您的卡片已挂失，请联系客服人员");
                    return;
                }
                if(return_msg <= '0'){
                    $(".choose.lpCard").addClass("unable");
                    $(".status.sta1").text("您的礼品卡账户余额为￥"+return_msg);
                    return;
                }
                if(fail_code == 'frozen_fail'){
                    $(".choose.lpCard").addClass("unable");
                    $(".status.sta1").text(return_msg);
                    return;
                }
                var orderPrice = 0;
                if(fail_code != 'pass_fail' && fail_code != 'frozen_fail'){
                    $(".choose.lpCard").removeClass("unable");
                    $(".choose.lpCard .sta1").hide();
                    $(".choose.lpCard .sta3").hide();
                    $(".choose.lpCard .sta2").show();
                    $(".lpCard.choose").addClass("open-popup");
                    return_msg = return_msg.toFixed(2);
                    orderPrice = result.order_price.toFixed(2);
                    $(".lpCard.choose .before").html("￥"+return_msg);
                    $(".lpCard.choose .sta2").html('<a href="#" class="open-popup">点击抵扣</a>');
                    if(Number(orderPrice)<=Number(return_msg)){
                        $(".price .integer").html(Subtr(orderPrice,0).toString().substring(0,Subtr(orderPrice,0).toString().indexOf('.')));
                        $(".price .decimals").html(Subtr(orderPrice,0).toString().substring(Subtr(orderPrice,0).toString().indexOf('.')));
                        $("#integerMoney").val(Subtr($('#payPrice').val(),orderPrice).toString().substring(0,Subtr($('#payPrice').val(),orderPrice).toString().indexOf('.')));
                        $("#decimalMoney").val(Subtr($('#payPrice').val(),orderPrice).toString().substring(Subtr($('#payPrice').val(),orderPrice).toString().indexOf('.')));
                        $(".lpCard.choose .sta3").html('<a href="#" class="cancel">已抵扣￥'+Subtr(orderPrice,0)+'元，点击取消</a>');
                        $(".lpCard.choose .after").html("￥"+Subtr(orderPrice,0))
                    }else{
                        $(".price .integer").html(Subtr(return_msg,0).toString().substring(0,(return_msg,0).toString().indexOf('.')));
                        $(".price .decimals").html(Subtr(return_msg,0).toString().substring((return_msg,0).toString().indexOf('.')));
                        $("#integerMoney").val(Subtr($('#payPrice').val(),return_msg).toString().substring(0,Subtr($('#payPrice').val(),return_msg).toString().indexOf('.')));
                        $("#decimalMoney").val(Subtr($('#payPrice').val(),return_msg).toString().substring(Subtr($('#payPrice').val(),return_msg).toString().indexOf('.')));
                        $(".lpCard.choose .sta3").html('<a href="#" class="cancel">已抵扣￥'+Subtr(return_msg,0)+'元，点击取消</a>');
                        $(".lpCard.choose .after").html("￥"+Subtr(return_msg,0))
                    }
                }
            }
        }
    });
});
