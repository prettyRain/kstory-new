// * 作者：shf
// * 时间：2017-08
// * 描述：改版，新增礼品卡页
var basePath = $("#basePath").val();
$(".vheader .back img").attr({"src":"/images/v2/my-back.png"});
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

$(function() {
    $(".dealtitle").prev().css("border-bottom","none")
});



var pageNo=1;
var flag = "go";//数据请求回来后才允许继续发起ajax
//滚动到底部

$(window).scroll(function(){
    if($(this).scrollTop() >= ($('body').height() - $(window).height()-60)){
        // console.log("滚动到底部");
        flag="done";
        pageNo++;

        //在当前底部加载下一页内容
        $.ajax({
            url: basePath+"/queryTradeInfoAjax.htm?pageNo="+pageNo,
            type: 'GET',
            dataType: 'text',
            async:'false',
            success:showResponse
        });
    }
});

function showResponse(data) {
    flag="go";
    var dateTime = $(".dealdetail .dealtitle").last().html();
    // console.info(data);
    var returnjson = eval("(" +data+")");
    var nextpagehtml = '';
    if(returnjson.pb.list !=null && returnjson.pb.list.length >0) {
        for (var i = 0; i < returnjson.pb.list.length; i++) {
            var trade =  returnjson.pb.list[i];

            var time = new Date(trade.createTime);
            var year = time.getFullYear();
            var month = (time.getMonth()+1)<10 ? ("0"+(time.getMonth()+1)):(time.getMonth()+1);
            var day = (time.getDate())<10 ? ("0"+time.getDate()):(time.getDate());
            var hour = (time.getHours())<10 ? ("0"+time.getHours()):(time.getHours());
            var minute = (time.getMinutes())<10 ? ("0"+time.getMinutes()):(time.getMinutes());
            var second = (time.getSeconds())<10 ? ("0"+time.getSeconds()):(time.getSeconds());
            if(dateTime != (year + "年" + month + "月")){
                dateTime = (year + "年" + month + "月");
                nextpagehtml +='<div class="dealtitle">';
                nextpagehtml +=year + '年' + month + '月</div>';
            }
            nextpagehtml += '<div class="liinfo">';
            nextpagehtml += '<div class="gtitle">';
                if(trade.orderType=='0'){
                    nextpagehtml += '在线充值';
                }else if(trade.orderType=='1'){
                    nextpagehtml += '订单退款';
                }else if(trade.orderType=='2'){
                    nextpagehtml += '线下提现';
                }else if(trade.orderType=='3'){
                    nextpagehtml += '订单消费';
                }else if(trade.orderType=='4'){
                    nextpagehtml += '线下现金充值';
                }else if(trade.orderType=='5'){
                    nextpagehtml += '线下刷卡充值';
                }else if(trade.orderType=='6'){
                    nextpagehtml += '线下支付宝充值';
                }else if(trade.orderType=='7'){
                    nextpagehtml += '线下微信充值';
                }else if(trade.orderType=='8'){
                    nextpagehtml += '转卡工本费';
                }

            nextpagehtml += '</div>';
            if(trade.orderType=='0' || trade.orderType=='1' || trade.orderType=='4' || trade.orderType=='5' || trade.orderType=='6' || trade.orderType=='7'){
                nextpagehtml += '<div class="gprice positive">';
                nextpagehtml += '+￥'+ trade.orderPrice;
            }else if(trade.orderType=='2' || trade.orderType=='3' || trade.orderType=='8'){
                nextpagehtml += '<div class="gprice">';
                nextpagehtml += '-￥'+ trade.orderPrice;
            }
            nextpagehtml += '</div>';
            // nextpagehtml += '<div class="gprice">';
                // if(trade.orderType=='0' || trade.orderType=='1' || trade.orderType=='4' || trade.orderType=='5' || trade.orderType=='6' || trade.orderType=='7'){
                //     nextpagehtml += '+￥'+ trade.orderPrice;
                // }else if(trade.orderType=='2' || trade.orderType=='3' || trade.orderType=='8'){
                //     nextpagehtml += '-￥'+ trade.orderPrice;
                // }
            // nextpagehtml += '</div>';
            nextpagehtml += '<div class="gtime">';
                // var time = new Date(trade.createTime);
                // var year = time.getFullYear();
                // var month = (time.getMonth()+1)<10 ? ("0"+(time.getMonth()+1)):(time.getMonth()+1);
                // var day = (time.getDate())<10 ? ("0"+time.getDate()):(time.getDate());
                // var hour = (time.getHours())<10 ? ("0"+time.getHours()):(time.getHours());
                // var minute = (time.getMinutes())<10 ? ("0"+time.getMinutes()):(time.getMinutes());
                // var second = (time.getSeconds())<10 ? ("0"+time.getSeconds()):(time.getSeconds());
            nextpagehtml += year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second;
            nextpagehtml += '</div>';
            nextpagehtml += '<div class="gstatus">';
                if(trade.orderStatus=='0'){
                    nextpagehtml += '待审核';
                }else if(trade.orderStatus=='1'){
                    nextpagehtml += '已打回';
                }else if(trade.orderStatus=='2'){
                    nextpagehtml += '已通过';
                }else if(trade.orderStatus=='3'){
                    nextpagehtml += '待确认';
                }else if(trade.orderStatus=='4'){
                    nextpagehtml += '已完成';
                }else if(trade.orderStatus=='5'){
                    nextpagehtml += '未支付';
                }else if(trade.orderStatus=='6'){
                    if(trade.orderCode.indexOf("G")!=-1){
                        nextpagehtml += '绑定成功';
                    }else{
                        nextpagehtml += '充值成功';
                    }
                }else if(trade.orderStatus=='7'){
                    <!-- 充值失败 状态修改-->
                }else if(trade.orderStatus=='8'){
                    nextpagehtml += '已取消';
                }else{
                    nextpagehtml += '已完成';
                }
            nextpagehtml += '</div>';
            nextpagehtml += '</div>';
        }
        $('.dealdetail').append(nextpagehtml);
        $(".dealtitle").prev().css("border-bottom","none")
    }
}



//数字累加
$.fn.countTo = function(a) {
    a = a || {};
    return $(this).each(function() {
        var c = $.extend({},
            $.fn.countTo.defaults, {
                from: $(this).data("from"),
                to: $(".giftprice").html(),
                speed: 1000,
                refreshInterval: $(this).data("refresh-interval"),
                decimals: $(this).data("decimals")
            },
            a);
        var h = Math.ceil(c.speed / c.refreshInterval),
            i = (c.to - c.from) / h;
        var j = this,
            f = $(this),
            e = 0,
            g = c.from,
            d = f.data("countTo") || {};
        f.data("countTo", d);
        if (d.interval) {
            clearInterval(d.interval)
        }
        d.interval = setInterval(k, c.refreshInterval);
        b(g);
        function k() {
            g += i;
            e++;
            b(g);
            if (typeof(c.onUpdate) == "function") {
                c.onUpdate.call(j, g)
            }
            if (e >= h) {
                f.removeData("countTo");
                clearInterval(d.interval);
                g = c.to;
                if (typeof(c.onComplete) == "function") {
                    c.onComplete.call(j, g)
                }
            }
        }
        function b(m) {
            var l = c.formatter.call(j, m, c);
            f.html(l)
        }
    })
};
$.fn.countTo.defaults = {
    from: 0,
    to: 0,
    speed: 1000,
    refreshInterval: 100,
    decimals: 0,
    formatter: formatter,
    onUpdate: null,
    onComplete: null
};
function formatter(b, a) {
    return b.toFixed(2)
}
$("#count-number").data("countToOptions", {
    formatter: function(b, a) {
        return b.toFixed(2).replace(/\B(?=(?:\d{3})+(?!\d))/g, ",")
    }
});
$(".timer").each(count);
function count(a) {
    var b = $(this);
    a = $.extend({},
        a || {},
        b.data("countToOptions") || {});
    b.countTo(a)
};



