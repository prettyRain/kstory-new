<style>
    * {
        -webkit-tap-highlight-color: transparent;
        -webkit-touch-callout: none
    }
    :focus, a, a:active, a:focus, a:hover, button, button:focus {
        outline: 0;
    }

    .vheader {
        top: 0;
        height: 60px;
        line-height: 40px;
        width: 100%;
        padding: 5px 29px 5px 5px;
        z-index: 9999;
        background-color: #fff;
        border-bottom: 10px solid #f7f7f7;
        box-sizing: border-box;
        display: -webkit-box;
        display: -ms-flexbox;
        display: -webkit-flex;
        display: flex;
        -webkit-box-pack: justify;
        -ms-flex-pack: justify;
        -webkit-justify-content: space-between;
        justify-content: space-between;
        -webkit-box-align: center;
        -ms-flex-align: center;
        -webkit-align-items: center;
        align-items: center;
        align-items: center;
    }
    .vheader  a{
        -webkit-flex-shrink: 0;
        -ms-flex: 0 0 auto;
        flex-shrink: 0;
        display: -webkit-box;
        display: -ms-flexbox;
        display: -webkit-flex;
        display: flex;
        -webkit-box-pack: start;
        -ms-flex-pack: start;
        -webkit-justify-content: flex-start;
        justify-content: flex-start;
        -webkit-box-align: center;
        -ms-flex-align: center;
        -webkit-align-items: center;
        align-items: center;
        -webkit-transform: translate3d(0, 0, 0);
        transform: translate3d(0, 0, 0);
    }
    .vheader span {
        text-align: center;
        margin: 0;
        /*margin-right: 0.096rem;*/
        font-size: 16px;
        position: relative;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        -webkit-flex-shrink: 10;
        -ms-flex: 0 10 auto;
        flex-shrink: 10;
        display: -webkit-box;
        display: -ms-flexbox;
        display: -webkit-flex;
        display: flex;
        -webkit-box-align: center;
        -ms-flex-align: center;
        -webkit-align-items: center;
        align-items: center;

    }
    .vheader img {
        vertical-align:middle;margin-left: 5px;text-align: inherit;
        width: 22px;
        height: 22px;
    }
    .ui-dialog-footer button.ui-dialog-autofocus {
        color: #ffffff;
        background-color: #199301;
        border-color: #199301;
    }
</style>
<link rel="stylesheet" href="${basePath}/css/ui-dialog.css">
<script src="${basePath}/js/dialog-min.js"></script>
<div class="vheader">
    <a href="javascript:;" class="back link"><img src="${basePath}/images/icon_v1.0/back_ios@2x.png" height="22" width="22" /></a>
    <span>${vtitle}</span>
    <a id="icon-option" href="javascript:;">${voption!''}</a>
</div>
<script>
    $(function(){
        $(".vheader a").eq(0).click(function(){
            var backUrl = "${backUrl}";
            var noweUrl = window.location.href;
            var discountBox;
            if(noweUrl.indexOf("suborder") > 0 ){
                discountBox = dialog({
                    width: 260,
                    title: '提示',
                    content: "您确定要放弃该订单吗？",
                    okValue: '放弃订单',
                    cancelValue: '再想想',
                    ok: function () {
                        if(backUrl.indexOf("order_detail") > 0 || window.location.href.indexOf("servclause")>0 || window.location.href.indexOf("standard")>0 || window.location.href.indexOf("comment-")>0 || window.location.href.indexOf("customer/mapplybackmoney-")>0 || window.location.href.indexOf("customer/applybackgoods-")>0){
                            history.back();
                        }else{
                            window.location.href="${backUrl}";
                        }
                    },
                    cancel: function () {
                        return true;
                    }
                });
                discountBox.showModal();
            }else if((noweUrl.indexOf("newsubmitorder") > 0) || (noweUrl.indexOf("orderdetailpay") > 0)){
                discountBox = dialog({
                    width: 260,
                    title: '提示',
                    content: "您确定要退出支付吗？",
                    okValue: '暂不支付',
                    cancelValue: '再想想',
                    ok: function () {
                        if(backUrl.indexOf("order_detail") > 0 || window.location.href.indexOf("servclause")>0 || window.location.href.indexOf("standard")>0 || window.location.href.indexOf("comment-")>0 || window.location.href.indexOf("customer/mapplybackmoney-")>0 || window.location.href.indexOf("customer/applybackgoods-")>0){
                            history.back();
                        }else{
                            window.location.href="${backUrl}";
                        }
                    },
                    cancel: function () {
                        return true;
                    }
                });
                discountBox.showModal();
            }else if(noweUrl.indexOf("registerthird") > 0){
                discountBox = dialog({
                    width: 260,
                    title: '提示',
                    content: "您确定要退出注册？",
                    okValue: '确认退出',
                    cancelValue: '取消',
                    ok: function () {
                        if(backUrl.indexOf("order_detail") > 0 || window.location.href.indexOf("servclause")>0 || window.location.href.indexOf("standard")>0 || window.location.href.indexOf("comment-")>0 || window.location.href.indexOf("customer/mapplybackmoney-")>0 || window.location.href.indexOf("customer/applybackgoods-")>0){
                            history.back();
                        }else{
                            window.location.href="${backUrl}";
                        }
                    },
                    cancel: function () {
                        return true;
                    }
                });
                discountBox.showModal();
            }else{
                if(backUrl.indexOf("order_detail") > 0 || window.location.href.indexOf("servclause")>0 || window.location.href.indexOf("standard")>0 || window.location.href.indexOf("comment-")>0 || window.location.href.indexOf("customer/mapplybackmoney-")>0 || window.location.href.indexOf("customer/applybackgoods-")>0){
                    history.back();
                }else{
                    window.location.href="${backUrl}";
                }
            };

        });
    });
</script>
<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?94d81cec8c55272bd7081c5126331fc1";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>

