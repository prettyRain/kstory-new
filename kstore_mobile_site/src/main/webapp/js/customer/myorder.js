var pageNo=1;
var iIntervalId = null;
var basePath = $("#basePath").val();
var type = $("#type").val();
$(function(){
    window.onload=function(){
        $("#status").val(0);
    }
});
function show(){
    if($("#status").val()==1){
        return;
    }
	 pageNo++;
  $.ajax({
    url: basePath+'/allmyorder.htm?pageNo='+pageNo+'&type='+type,
    type: 'GET',
    dataType: 'text',
    async:'false',
	beforeSend: showLoadingImg,
    error: showFailure,
    success:showResponse
  });
}

function showLoadingImg() {
	 $('#showmore').html(' <img src='+basePath+'/images/loading.gif /><span>加载中……</span>');
	 $('#showmore').show();

}

function showFailure() {
    falg="go";
	 $('#showmore').html('<font color=red> 获取查询数据出错 </font>');
}
//根据ajax取出来的json数据转换成html
function showResponse(responseData) {
    falg="go";
		 var returnjson = eval("(" +responseData+")");
		 var nextpagehtml = '';
		 var giftCard = 0;
		 if(returnjson.pb.list !=null && returnjson.pb.list.length >0){
			 for(var i=0; i<returnjson.pb.list.length; i++) {
				 var order =  returnjson.pb.list[i];
                 giftCard = 0;
                 if(order.cancelRemark !=null && order.cancelRemark =="该订单已拆分"){
                     var goodCounts = 0;
                     for(var j=0;j<returnjson.pb.objectBean.length;j++) {
                         var obj = returnjson.pb.objectBean[j];
                         if (obj.orderNo == order.orderNo) {
                             for (var k = 0; k < obj.splitList.length; k++) {
                                 var order2 = obj.splitList[k];
                                 for(var m=0;m<order2.goods.length;m++){
                                     goodCounts += order2.goods[m].goodsNum;
                                 }
                             }
                         }
                     }
                     nextpagehtml +='<div class="order-item">';
                     nextpagehtml +='<div class="order-number">';
                     nextpagehtml +='<div class="list-item" style="border-bottom: 1px solid #ececec">';
                     nextpagehtml +='<h3 class="item-head"><label for="">共<span>'+goodCounts+'</span>件</label>' +
                         '<label for="" class="haspay">实付款：&yen;<span class="price">'+order.moneyPaid.toFixed(2).split(".")[0]+'.<i>'+order.moneyPaid.toFixed(2).split(".")[1]+'</i></span></label>' +
                         '</h3></div></div>';
                     for(var j=0;j<returnjson.pb.objectBean.length;j++){
                     	var obj = returnjson.pb.objectBean[j];
                     	if(obj.orderNo == order.orderNo){
                     		for(var k=0;k<obj.splitList.length;k++){
                     			order = obj.splitList[k];
                                nextpagehtml +='<div>';
                                nextpagehtml +='<div class="order-number">';
                                nextpagehtml +='<div class="list-item">';
                                nextpagehtml +='<h3 class="item-head">';
                                var cFlag = 0;
                                var sFlag = 0;
                                var gFlag = 0;
                                for(var j=0;j<order.goods.length;j++){
                                    var good = order.goods[j];
                                    if(good.evaluateFlag=="0"){
                                        cFlag = cFlag +1;
                                    }
                                    if(good.orderGoodsStatus!="0"){
                                        sFlag = sFlag +1;
                                    }
                                    if(good.orderGoodsStatus=="3" || good.orderGoodsStatus == '5'){
                                        gFlag = gFlag +1;
                                    }
                                }
                                nextpagehtml +='<span>&nbsp;</span><span class="curValue text-them">';
                                if(order.orderStatus != null && order.orderStatus != ''){
                                    if(order.orderStatus == "0"){
                                        if(order.orderLinePay=="0"){
                                            nextpagehtml +='待发货';
                                        }else{
                                            nextpagehtml +='待付款';
                                        }
                                    }else if(order.orderStatus=="1" || order.orderStatus=="5" || order.orderStatus=="6"){
                                        nextpagehtml +='待发货';
                                    }else if(order.orderStatus=="2"){
                                        nextpagehtml +='已发货';
                                    }else if(order.orderStatus=="3" ){
                                        if(cFlag > 0 && gFlag<order.goods.length){
                                            nextpagehtml +='待评价';
                                        }else if(cFlag == 0 || gFlag==order.goods.length){
                                            nextpagehtml +='交易完成';
                                        }
                                    }else if(order.orderStatus=="4"){
                                        nextpagehtml +='交易关闭';
                                    }else if(order.orderStatus=="7"){
                                        nextpagehtml +='退货审核';
                                    }else if(order.orderStatus=="8"){
                                        nextpagehtml +='同意退货';
                                    }else if(order.orderStatus=="9"){
                                        nextpagehtml +='拒绝退货';
                                    }else if(order.orderStatus=="10"){
                                        nextpagehtml +='待商家收货';
                                    }else if(order.orderStatus=="11"){
                                        nextpagehtml +=' 退货结束';
                                    }else if(order.orderStatus=="15"){
                                        nextpagehtml +='退款审核';
                                    }else if(order.orderStatus=="13"){
                                        nextpagehtml +='拒绝退款';
                                    }else if(order.orderStatus=="14"){
                                        nextpagehtml +='退货审核';
                                    }else if(order.orderStatus=="16"){
                                        nextpagehtml +='商家收货失败';
                                    }else if(order.orderStatus=="17"){
                                        //nextpagehtml +='退款成功';
                                        nextpagehtml +='交易完成';
                                    }else if(order.orderStatus=="18"){
                                        nextpagehtml +='交易关闭';
                                    }
                                }
                                nextpagehtml +='</span></h3>';
                                nextpagehtml +='</div></div>';
                                nextpagehtml +='<div class="order-info">';
                                if(order.goods.length > 2){
                                    nextpagehtml +='<div class="list-body-box">';
                                    nextpagehtml +='<div class="list-item">';
                                    nextpagehtml +='<div class="box-body">';
                                    nextpagehtml +='<ul>';
                                    for(var n=0;n<order.goods.length;n++){
                                        var good = order.goods[n];
                                        nextpagehtml +='<li>';
                                        nextpagehtml +='<a href="'+basePath+'/customer/detail-'+order.orderId+'.html">';
                                        nextpagehtml +='<img width="80" height="80" title="'+good.goodsName+'" alt="'+good.goodsName+'" src="'+good.goodsImg+'" />';
                                        nextpagehtml +='</a>';
                                        nextpagehtml +='</li>';
                                    }
                                    nextpagehtml +='</ul>';
                                    nextpagehtml +='</div>';
                                    nextpagehtml +='</div>';
                                    nextpagehtml +='</div>';
                                }else{
                                    for(var m=0;m<order.goods.length;m++){
                                        var good = order.goods[m];

                                        if(good.goodsName.indexOf("电子卡") != -1 || good.goodsName.indexOf("实体卡") != -1){
                                            giftCard += 1;
                                        }

                                        nextpagehtml +='<div class="list-body-line list-body-line2">';
                                        nextpagehtml +='<div class="list-item">';
                                        nextpagehtml +='<a href="'+basePath+'/customer/detail-'+order.orderId+'.html">';
                                        nextpagehtml +='<div class="pro-item">';
                                        nextpagehtml +='<div class="propic">';
                                        nextpagehtml +='<img width="78" height="78" title="'+good.goodsName+'" alt="'+good.goodsName+'" src="'+good.goodsImg+'" />';
                                        nextpagehtml +='</div>';
                                        nextpagehtml +='<div class="prodesc">';
                                        nextpagehtml +=' <div class="left"><h3 class="title">';
                                        if(good.isPresent == '1'){
                                            nextpagehtml +='<img src="../../images/v2/gift@2x.png" width="26" height="14" style="vertical-align: middle;margin-bottom: 3px;"> ';
                                        }
                                        nextpagehtml +=''+good.goodsName+'';
                                        nextpagehtml +='</h3></div>';
                                        /**
                                         *   <#if good.countRush?? && good.countRush?number != 0 && good.goodsNum?number gt good.countRush?number>
                                         <div class="right">
                                         <p class="price">
                                         ￥${good.goodsPrice?string('0.00')?substring(0,good.goodsPrice?string('0.00')?index_of('.'))}<span >${good.goodsPrice?string('0.00')?substring(good.goodsPrice?string('0.00')?index_of('.'))}</span>
                                         </p>
                                         <span class="pro-num">
                                         ×${good.countRush}
                                         </span>

                                         </div>
                                         <div class="right">
                                         <p class="price">
                                         ￥${good.goodsOldPrice?string('0.00')?substring(0,good.goodsOldPrice?string('0.00')?index_of('.'))}<span >${good.goodsOldPrice?string('0.00')?substring(good.goodsOldPrice?string('0.00')?index_of('.'))}</span>
                                         </p>
                                         <span class="pro-num">
                                         ×${good.goodsNum?number - good.countRush?number}
                                         </span>
                                         </div>
                                         <#else>
                                         <div class="right"></div>
                                         <div class="right">
                                         <p class="price">
                                         ￥${good.goodsPrice?string('0.00')?substring(0,good.goodsPrice?string('0.00')?index_of('.'))}<span >${good.goodsPrice?string('0.00')?substring(good.goodsPrice?string('0.00')?index_of('.'))}</span>
                                         </p>
                                         <span class="pro-num">
                                         ×${good.goodsNum?number - good.countRush?number}
                                         </span>
                                         </div>
                                         </#if>
                                         * @type {string}
                                         */

                                        if(good.countRush!=null && good.countRush != 0 && good.goodsNum > good.countRush){
                                            nextpagehtml += ' <div class="right">';
                                            nextpagehtml +='<p class="price">&yen;'+good.goodsPrice.toFixed(2).split(".")[0]+'.<span>'+good.goodsPrice.toFixed(2).split(".")[1]+'</span></p><span style="display: block;" class="pro-num">x'+good.countRush+'</span>';
                                            nextpagehtml +='</div>';
                                            nextpagehtml += ' <div class="right"><p class="price">&yen;'+good.goodsOldPrice.toFixed(2).split(".")[0]+'.<span>'+good.goodsOldPrice.toFixed(2).split(".")[1]+'</span></p>';
                                            nextpagehtml +='<span style="display: block;" class="pro-num">x'+good.goodsNum - good.countRush+'</span>';
                                        }else{
                                            nextpagehtml += ' <div class="right"></div>';
                                            nextpagehtml += '<div class="right">';
                                            nextpagehtml += '<p class="price">';
                                            nextpagehtml += '<p class="price">&yen;'+good.goodsPrice.toFixed(2).split(".")[0]+'.<span>'+good.goodsPrice.toFixed(2).split(".")[1]+'</span></p>';
                                            nextpagehtml += '<span class="pro-num">x'+good.goodsNum+'</span></div>';
                                        }

                                        nextpagehtml +=' </div>';
                                        nextpagehtml +=' </div>';
                                        nextpagehtml +='</a>';
                                        nextpagehtml +='</div>';
                                        nextpagehtml +='</div>';
                                    }
                                }
                                nextpagehtml +='</div>';
                                nextpagehtml +='<div class="order-bottom">';
                                nextpagehtml +='<div class="list-item">';
                                nextpagehtml +='<h3 class="item-head">';
                                nextpagehtml +='<label for="">实付款：</label><span class="pay-money">&yen;';
                                var moneyPaid = 0.00;
                                if(order.moneyPaid != null && order.moneyPaid != ''){
                                    moneyPaid = order.moneyPaid.toFixed(2);
                                }
                                nextpagehtml +=''+moneyPaid+'';
                                nextpagehtml +='</span>';
                                nextpagehtml +='</h3>';
                                nextpagehtml +='<div class="too-btn">';
                                if(order.orderStatus != null && order.orderStatus !=''){

                                    if(returnjson.isBackOrder == '1'){
                                        //再次买
                                        if(order.orderStatus != "0") {
                                            nextpagehtml += '<a class="btn" href="javascript:void(0)" onclick="addCar(' + order.orderId + ')">再次购买</a>';
                                        }
                                        if(order.orderStatus=="3"){
                                            /*  nextpagehtml +='<a href="javascript:void(0)" class="btn" onclick="addCar('+order.orderId+')">再次购买</a>';*/
                                            if(sFlag==0) {
                                                nextpagehtml += '<a class="btn"  href="javascript:;" onclick="timeBackOrder(' + order.orderId + ')">申请退货</a>';
                                            }
                                            if( cFlag > 0  && gFlag<order.goods.length){
                                                nextpagehtml +='<a href="'+basePath+'/comment-'+order.orderId+'.html" class="btn  pay-btn">立即评价</a>';
                                            }
                                        }else if(order.orderStatus=="1" || order.orderStatus=="4" || order.orderStatus=="5" || order.orderStatus=="6"){
											/* nextpagehtml +='<a href="javascript:void(0)" class="btn" onclick="addCar('+order.orderId+')">再次购买</a>';*/
                                        }else if(order.orderStatus=="13" ||order.orderStatus=="15" ||order.orderStatus=="18"){
                                            if(order.getGoodsTime!=null && order.getGoodsTime!=""){
                                                nextpagehtml +='<a class="btn" href="'+basePath+'/customer/backordergoodsdetail-'+order.orderId+'.html">退货详情</a>';
                                            }else {
                                                nextpagehtml += '<a class="btn" href="' + basePath + '/customer/backorderpricedetail-' + order.orderId + '.html">退款详情</a>';
                                            }
                                        }else if(order.orderStatus=="8"){
                                            nextpagehtml +='<a class="btn" href="javascript:void(0)" onclick="expressInfo('+order.orderNo+')" style="width:100px">填写物流信息</a>';
                                        }
                                        else if(order.orderStatus=="7" ||
                                            order.orderStatus=="8" ||
                                            order.orderStatus=="9" ||
                                            order.orderStatus=="10" ||
                                            order.orderStatus=="11" ||
                                            order.orderStatus=="14" ||
                                            order.orderStatus=="16" ||
                                            order.orderStatus=="17" ||
                                            order.orderStatus=="12"){
                                            nextpagehtml +='<a class="btn" href="'+basePath+'/customer/backordergoodsdetail-'+order.orderId+'.html">退货详情</a>';
                                        }
                                        if(order.orderStatus=="5" || order.orderStatus=="6"){
                                            nextpagehtml +='<a class="btn" href="javascript:;" onclick="timeBackOrder('+order.orderId+')">申请退货</a>';
                                        }
                                        if(order.orderStatus=="1" && giftCard == 0 && sFlag == 0){
                                            nextpagehtml +='<a class="btn" href="'+basePath+'/customer/mapplybackmoney-'+order.orderId+'.html">申请退款</a>';
                                        }
                                    }else if(returnjson.isBackOrder == '2'){
                                        if(order.orderStatus=="3"){
                                            if( cFlag > 0){
                                                nextpagehtml +='<a href="'+basePath+'/comment-'+order.orderId+'.html" class="btn  pay-btn">立即评价</a>';
                                            }
											/*   nextpagehtml +='<a href="javascript:void(0)" class="btn" onclick="addCar('+order.orderId+')">再次购买</a>';*/
                                        }else if(order.orderStatus=="1" || order.orderStatus=="4" || order.orderStatus=="5" || order.orderStatus=="6") {
											/*  nextpagehtml += '<a href="javascript:void(0)" class="btn" onclick="addCar(' + order.orderId + ')">再次购买</a>';*/
                                        }
                                    }
                                    if(order.orderStatus == "0"){
                                        nextpagehtml +='<a href="javascript:;" class="btn" onClick="cancelOrder('+order.orderId+')">取消订单</a>';
                                        nextpagehtml +='<a href="javascript:void(0)" class="btn" onclick="addCar('+order.orderId+')">再次购买</a>';
                                        // if(order.payId != null && order.payId==1){
                                        nextpagehtml +='<a href="/orderdetailpay-'+order.orderId+'.html" class="btn pay-btn">立即支付</a>';
                                        // }
                                    }else if(order.orderStatus=="2"){
                                        nextpagehtml +='<a href="javascript:;" class="btn pay-btn" onClick="comfirmgoods('+order.orderId+')">确认收货</a>';
                                    }
                                }
                                nextpagehtml +='</div>';
                                nextpagehtml +='</div>';
                                nextpagehtml +='</div>';
                                nextpagehtml +='</div>';
							}
						}
					 }
                     nextpagehtml +='</div>';
				 }else{//未拆分
                     var cFlag = 0;
                     var sFlag = 0;
                     var gFlag = 0;
                     var goodCounts = 0;
                     for(var j=0;j<order.goods.length;j++){
                         var good = order.goods[j];
                         if(good.evaluateFlag=="0"){
                             cFlag = cFlag +1;
                         }
                         if(good.orderGoodsStatus!="0"){
                             sFlag = sFlag +1;
                         }
                         if(good.orderGoodsStatus=="3" || good.orderGoodsStatus == '5'){
                             gFlag = gFlag +1;
                         }
                         goodCounts += good.goodsNum;
                     }
                     nextpagehtml +='<div class="order-item">';
                     nextpagehtml +='<div class="order-number">';
                     nextpagehtml +='<div class="list-item">';
                     nextpagehtml +='<h3 class="item-head"><label for="">共<span>'+goodCounts+'</span>件</label>';
                     nextpagehtml +='<label for="" class="haspay">实付款：&yen;<span class="price">'+order.moneyPaid.toFixed(2).split(".")[0]+'.<i>'+order.moneyPaid.toFixed(2).split(".")[1]+'</i></span></label>';

                     nextpagehtml +='<span class="curValue text-them">';
                     if(order.orderStatus != null && order.orderStatus != ''){
                         if(order.orderStatus == "0"){
                             if(order.orderLinePay=="0"){
                                 nextpagehtml +='待发货';
                             }else{
                                 nextpagehtml +='待付款';
                             }
                         }else if(order.orderStatus=="1" || order.orderStatus=="5" || order.orderStatus=="6"){
                             nextpagehtml +='待发货';
                         }else if(order.orderStatus=="2"){
                             nextpagehtml +='已发货';
                         }else if(order.orderStatus=="3" ){
                             if(cFlag > 0 && gFlag<order.goods.length){
                                 nextpagehtml +='待评价';
                             }else if(cFlag == 0 || gFlag==order.goods.length){
                                 nextpagehtml +='交易完成';
                             }
                         }else if(order.orderStatus=="4"){
                             nextpagehtml +='交易关闭';
                         }else if(order.orderStatus=="7"){
                             nextpagehtml +='退货审核';
                         }else if(order.orderStatus=="8"){
                             nextpagehtml +='同意退货';
                         }else if(order.orderStatus=="9"){
                             nextpagehtml +='拒绝退货';
                         }else if(order.orderStatus=="10"){
                             nextpagehtml +='待商家收货';
                         }else if(order.orderStatus=="11"){
                             nextpagehtml +=' 退货结束';
                         }else if(order.orderStatus=="15"){
                             nextpagehtml +='退款审核';
                         }else if(order.orderStatus=="13"){
                             nextpagehtml +='拒绝退款';
                         }else if(order.orderStatus=="14"){
                             nextpagehtml +='退货审核';
                         }else if(order.orderStatus=="16"){
                             nextpagehtml +='商家收货失败';
                         }else if(order.orderStatus=="17"){
                             nextpagehtml +='退款成功';
                         }else if(order.orderStatus=="18"){
                             nextpagehtml +='交易关闭';
                         }
                     }
                     nextpagehtml +='</span></h3>';
                     nextpagehtml +='</div></div>';
                     nextpagehtml +='<div class="order-info">';
                     if(order.goods.length > 2){
                         nextpagehtml +='<div class="list-body-box">';
                         nextpagehtml +='<div class="list-item">';
                         nextpagehtml +='<div class="box-body">';
                         nextpagehtml +='<ul>';
                         for(var n=0;n<order.goods.length;n++){
                             var good = order.goods[n];
                             nextpagehtml +='<li>';
                             nextpagehtml +='<a href="'+basePath+'/customer/detail-'+order.orderId+'.html">';
                             nextpagehtml +='<img width="80" height="80" title="'+good.goodsName+'" alt="'+good.goodsName+'" src="'+good.goodsImg+'" />';
                             nextpagehtml +='</a>';
                             nextpagehtml +='</li>';
                         }
                         nextpagehtml +='</ul>';
                         nextpagehtml +='</div>';
                         nextpagehtml +='</div>';
                         nextpagehtml +='</div>';
                     }else{
                         for(var m=0;m<order.goods.length;m++){
                             var good = order.goods[m];

                             if(good.goodsName.indexOf("电子卡") != -1 || good.goodsName.indexOf("实体卡") != -1){
                                 giftCard += 1;
                             }

                             nextpagehtml +='<div class="list-body-line list-body-line2">';
                             nextpagehtml +='<div class="list-item">';
                             nextpagehtml +='<a href="'+basePath+'/customer/detail-'+order.orderId+'.html">';
                             nextpagehtml +='<div class="pro-item">';
                             nextpagehtml +='<div class="propic">';
                             nextpagehtml +='<img width="78" height="78" title="'+good.goodsName+'" alt="'+good.goodsName+'" src="'+good.goodsImg+'" />';
                             nextpagehtml +='</div>';
                             nextpagehtml +='<div class="prodesc">';
                             nextpagehtml +=' <div class="left"><h3 class="title">';
                             if(good.isPresent == '1'){
                                 nextpagehtml +='<img src="../../images/v2/gift@2x.png" width="26" height="14" style="vertical-align: middle;margin-bottom: 3px;"> ';
                             }
                             nextpagehtml +=''+good.goodsName+'';
                             nextpagehtml +='</h3></div>';

                             /*if(good.countRush == null || good.countRush == 0 || good.goodsNum - good.countRush != 0) {
                                 if(good.countRush == null || good.countRush == 0){
                                     nextpagehtml += ' <div class="right"></div>';
                                 }
                                nextpagehtml += ' <div class="right">';
                                 if(good.countRush != null && good.countRush>0) {
                                     nextpagehtml += '<p class="price">&yen;' + good.goodsOldPrice.toFixed(2).split(".")[0] + '.<span>' + good.goodsOldPrice.toFixed(2).split(".")[1] + '</span></p>';
                                 }else{
                                     nextpagehtml += '<p class="price">&yen;' + good.goodsPrice.toFixed(2).split(".")[0] + '.<span>' + good.goodsPrice.toFixed(2).split(".")[1] + '</span></p>';
                                 }

                                 nextpagehtml +='<span style="display: block;" class="pro-num">x';

                                 if(good.countRush != null && good.countRush>0) {
                                     nextpagehtml += '' + (good.goodsNum - good.countRush) + '</span>';
                                 }else{
                                     nextpagehtml += '' + good.goodsNum + '</span>';
                                 }
                             nextpagehtml +='</div>';
                             }

                             if(good.countRush != null && good.countRush>0) {
                                 if (good.goodsNum - good.countRush == 0){
                                     nextpagehtml +='<div class="right"></div>';
                                }
                                nextpagehtml += ' <div class="right">';
                                 nextpagehtml +='<p class="price">&yen;'+good.goodsPrice.toFixed(2).split(".")[0]+'.<span>'+good.goodsPrice.toFixed(2).split(".")[1]+'</span></p><span style="display: block;" class="pro-num">x'+good.goodsNum+'</span>';
                                nextpagehtml +='</div>';
                             }*/

                             if(good.countRush!=null && good.countRush != 0 && good.goodsNum > good.countRush){
                                 nextpagehtml += '<div class="right"><p class="price">&yen;'+good.goodsOldPrice.toFixed(2).split(".")[0]+'.<span>'+good.goodsOldPrice.toFixed(2).split(".")[1]+'</span></p>';
                                 nextpagehtml += '<span style="display: block;" class="pro-num">x'+(good.goodsNum - good.countRush)+'</span>';
                                 nextpagehtml += '</div>';
                                 nextpagehtml += '<div class="right">';
                                 nextpagehtml += '<p class="price">&yen;'+good.goodsPrice.toFixed(2).split(".")[0]+'.<span>'+good.goodsPrice.toFixed(2).split(".")[1]+'</span></p><span style="display: block;" class="pro-num">x'+good.countRush+'</span>';
                                 nextpagehtml += '</div>';
                             }else{
                                 nextpagehtml += ' <div class="right"></div>';
                                 nextpagehtml += '<div class="right">';
                                 nextpagehtml += '<p class="price">';
                                 nextpagehtml += '<p class="price">&yen;'+good.goodsPrice.toFixed(2).split(".")[0]+'.<span>'+good.goodsPrice.toFixed(2).split(".")[1]+'</span></p>';
                                 nextpagehtml += '<span class="pro-num">x'+good.goodsNum+'</span></div>';
                             }


                             nextpagehtml +=' </div>';
                             nextpagehtml +=' </div>';
                             nextpagehtml +='</a>';
                             nextpagehtml +='</div>';
                             nextpagehtml +='</div>';
                         }
                     }
                     nextpagehtml +='</div>';
                     nextpagehtml +='<div class="order-bottom">';
                     nextpagehtml +='<div class="list-item">';
                     nextpagehtml +='<div class="too-btn">';
                     if(order.orderStatus != null && order.orderStatus !=''){
                         if(order.orderStatus == "0"){
                             nextpagehtml +='<a href="javascript:;" class="btn" onClick="cancelOrder('+order.orderId+')">取消订单</a>';
                             nextpagehtml += '<a class="btn" href="javascript:void(0)" onclick="addCar(' + order.orderId + ')">再次购买</a>';
                             // if(order.payId != null && order.payId==1){
                             nextpagehtml +='<a href="/orderdetailpay-'+order.orderId+'.html" class="btn pay-btn">立即支付</a>';
                             // }
                         }else if(order.orderStatus=="2"){
                             nextpagehtml += '<a class="btn" href="javascript:void(0)" onclick="addCar(' + order.orderId + ')">再次购买</a>';
                             nextpagehtml +='<a href="javascript:;" class="btn pay-btn" onClick="comfirmgoods('+order.orderId+')">确认收货</a>';
                         }
                         if(returnjson.isBackOrder == '1'){
                             if(order.orderStatus=="3"){

								 nextpagehtml +='<a href="javascript:void(0)" class="btn" onclick="addCar('+order.orderId+')">再次购买</a>';
								 if(sFlag==0) {
                                     nextpagehtml += '<a class="btn"  href="javascript:;" onclick="timeBackOrder(' + order.orderId + ')">申请退货</a>';
                                 }
                                 if( cFlag > 0  && gFlag<order.goods.length) {
                                     nextpagehtml += '<a href="' + basePath + '/comment-' + order.orderId + '.html" class="btn pay-btn">立即评价</a>';
                                 }

                             }else if(order.orderStatus=="1" || order.orderStatus=="4" || order.orderStatus=="5" || order.orderStatus=="6"){
								 // nextpagehtml +='<a href="javascript:void(0)" class="btn" onclick="addCar('+order.orderId+')">再次购买</a>';
                             }else if(order.orderStatus=="13" ||order.orderStatus=="15" ||order.orderStatus=="18"){
                                 if(order.getGoodsTime!=null && order.getGoodsTime!=""){
                                     nextpagehtml +='<a class="btn" href="'+basePath+'/customer/backordergoodsdetail-'+order.orderId+'.html">退货详情</a>';
                                 }else {
                                     nextpagehtml += '<a class="btn" href="' + basePath + '/customer/backorderpricedetail-' + order.orderId + '.html">退款详情</a>';
                                 }
                             }else if(order.orderStatus=="8"){
                                 nextpagehtml +='<a class="btn" href="javascript:void(0)" onclick="expressInfo('+order.orderNo+')" style="width:100px">填写物流信息</a>';
                             }
                             else if(order.orderStatus=="7" ||
                                 order.orderStatus=="8" ||
                                 order.orderStatus=="9" ||
                                 order.orderStatus=="10" ||
                                 order.orderStatus=="11" ||
                                 order.orderStatus=="14" ||
                                 order.orderStatus=="16" ||
                                 order.orderStatus=="17" ||
                                 order.orderStatus=="12"){
                                 nextpagehtml +='<a class="btn" href="'+basePath+'/customer/backordergoodsdetail-'+order.orderId+'.html">退货详情</a>';
                             }
                             if(order.orderStatus=="5" || order.orderStatus=="6"){
                                 nextpagehtml +='<a class="btn" href="javascript:;" onclick="timeBackOrder('+order.orderId+')">申请退货</a>';
                             }
                             if(order.orderStatus=="1"){
                                 nextpagehtml +='<a href="javascript:void(0)" class="btn" onclick="addCar('+order.orderId+')">再次购买</a>';
                                 if(giftCard == 0 && sFlag == 0){
                                     nextpagehtml +='<a class="btn" href="'+basePath+'/customer/mapplybackmoney-'+order.orderId+'.html">申请退款</a>';
                                 }
                             }

                         }else if(returnjson.isBackOrder == '2'){
                             if(order.orderStatus=="3"){
                                 if( cFlag > 0){
                                     nextpagehtml +='<a href="'+basePath+'/comment-'+order.orderId+'.html" class="btn  pay-btn">立即评价</a>';
                                 }
								 /*   nextpagehtml +='<a href="javascript:void(0)" class="btn" onclick="addCar('+order.orderId+')">再次购买</a>';*/
                             }else if(order.orderStatus=="1" || order.orderStatus=="4" || order.orderStatus=="5" || order.orderStatus=="6") {
								 /*  nextpagehtml += '<a href="javascript:void(0)" class="btn" onclick="addCar(' + order.orderId + ')">再次购买</a>';*/
                             }
                         }
                     }

                     nextpagehtml +='</div>';
                     nextpagehtml +='</div>';
                     nextpagehtml +='</div>';
                     nextpagehtml +='</div>';
                 }
			 }
			 if(nextpagehtml != null && nextpagehtml != ""){
				 $('#items').append(nextpagehtml );
				 $newElems =$("#items .order-item");
				 // 渐显新的内容
				 $newElems.animate({ opacity: 1 });
				 if(returnjson.nextPageNo==pageNo){
					 clearInterval(iIntervalId);
					 $('#showmore').hide();
				 }else{
				/*	 $('#showmore').html('<a class="handle" href="javascript:show()">显示更多结果</a>');
					 $('#showmore').show();*/
                     $('#showmore').html(' <img src='+basePath+'/images/loading.gif /><span>加载中……</span>');
                     $('#showmore').show();
				 }
			 }else{
				 $('#showmore').html('<a class="handle" href="javascript:show()">已无更多结果</a>');
			 }
		 }else{
             $("#status").val(1);
			 $('#showmore').html('<a class="handle" href="javascript:show()">已无更多结果</a>');
		 }


 // 当前页码数小于3页时继续显示更多提示框
/* if(page < 2) {
   $('#showmore').html('<a class="handle" href="javascript:show()">显示更多结果</a>');
   clearInterval(iIntervalId);
   $('#showmore').hide();
 }*/
//bdShare.fn.init();
}


var comUrl="";
//确认收货
function comfirmgoods(orderId,flag) {
	/*$('#confirm_order').show();
	$('.opacity-bg-1').show();
	$("#tiptitle").html("是否确认收货？");*/
    var sureGet = dialog({
        width : 260,
        content : '<p class="tc">是否确认收货？</p>',
        okValue : '确定',
        cancelValue : '取消',
        ok : function(){
            comfirmGoodsSucc();
        },
        cancel : function(){
            cancelComfirmGoods();
        }
    });
    sureGet.showModal();
//	$("#go_pay_01").prop("href", url);
	comUrl=basePath+'/customer/comfirmofgoods-myorder-'+orderId+'-'+flag+'.html';

}

//取消订单
function cancelOrder(orderId,flag) {
    url =basePath+'/customer/cancelorder-myorder-'+orderId+'-'+flag+'.html'
	/*$('#confirm_order').show();
	$('.opacity-bg-1').show();
	$("#tiptitle").html("是否确认取消？");*/
    var sureGet = dialog({
        width : 260,
        content : '<p class="tc">是否确认取消？</p>',
        okValue : '确定',
        cancelValue : '取消',
        ok : function(){
            comfirmGoodsSucc();
        },
        cancel : function(){
            cancelComfirmGoods();
        }
    });
    sureGet.showModal();
	comUrl = url;
}
function comfirmGoodsSucc(){
	location.href=comUrl;
	$('#confirm_order').hide();
	$('.opacity-bg-1').hide();
}


function cancelComfirmGoods(){
	$('#confirm_order').hide();
	$('.opacity-bg-1').hide();
}

var tip = myAlertStr();
function addCar(id){
	$.ajax({
		url:basePath+'/addproducttoshopcarbyorderid.htm?orderId='+id,
        type:'post',
        success:function(data){
         if(data>0){
          window.location.href = basePath+"/myshoppingmcart.html";
         }else if(data==-1){
            tip("购物车商品种类已达20件上限");
         }
        }
	});
}

function expressInfo(orderNo){
	$("#orderNo").val(orderNo);
	var fillFlow = dialog({
		width : 300,
		title : '填写物流信息',
		content : $('.fill-flow-form'),
		okValue : '保存',
		cancelValue : '取消',
		ok : function(){
			quedingwl('00');
		},
		cancel : function(){
            doReset();
			return true;
		}
	});
	fillFlow.showModal();
}
//移动端退货操作中填写物流信息，取消时重置表单
function doReset(){
    for(i=0; i<$('.fill-flow-form').find("input").length;i++){
        $('.fill-flow-form').find("input")[i].value = "" ;
    }
    $("#yanzhengname").html("");
    $("#yanzhengno").html("")
}

//物流名称失去焦点
function wuliuname(){
	var value = $("#wlname").val();//物流名称
	if(value==''||value.length<0){
		$("#yanzhengname").addClass("red");
		$("#yanzhengname").html("&nbsp;<img src='../images/red_cha.png'/>物流公司名称不能为空！");
	}else{
		$("#yanzhengname").html("");
	}
}

//物流单号失去焦点
function wuliudanhao(){
	var reg = /^[0-9a-zA-Z]+$/;
	var no = $("#wlno").val(); //物流单号

	if(no==''||no.length<0){
		$("#yanzhengno").addClass("red");
		$("#yanzhengno").html("&nbsp;<img src='../images/red_cha.png'/>物流公司单号不能为空！");

	}else{
		if(!reg.test(no)){
			$("#yanzhengno").addClass("red");
			$("#yanzhengno").html("&nbsp;<img src='../images/red_cha.png'/>只能为数字或字母！");
		}else{
			$("#yanzhengno").html("");
		}

	}
}

//提交物流信息
function quedingwl(flag){//判断是我的订单跳转还是会员中心首页跳转
	var subflag = 0;
	var wlname = $("#wlname").val();//物流名称
	var wlno = $("#wlno").val(); //物流单号
	var orderNo = $("#orderNo").val(); //订单号
	if(checkValue(wlname,wlno)==0){//验证物流信息
		//var index = url.substring(url.length-6,url.length-5);//截取当前的页数
		//var yueindex = url.substring(url.length-10,url.length-9);//截取一月前订单
		if(subflag == 0){
			$.ajax({
				//提交数据的类型 POST GET
				type:"POST",
				//提交的网址
				url:basePath+"/saveMBackOrderGeneral.htm",
				//提交的数据
				data:{wlname:wlname,wlno:wlno,orderNo:orderNo},
				async:false,
				//返回数据的格式
				datatype: "post",
				//成功返回之后调用的函数
				success:function(data){
					subflag = 1;
					if(data==1){
						window.location.href =basePath+'/customer/myorder-6-1.html';
					}else if(data==0){
						window.location.href =basePath+'/loginm.html';
					}
				}
			});
		}
	}else{
		$("#fillForm").showModal();
	}
}

//验证物流信息
function checkValue(value,no){
    var reg = /^[0-9a-zA-Z]*$/g;
	var result = 0;
	if(value==''||value.length<0){
		$("#yanzhengname").addClass("red");
		$("#yanzhengname").html("&nbsp;<img src='../images/red_cha.png'/>物流公司名称不能为空！");
		result=1;
	}
	if(no==''||no.length<0){
		$("#yanzhengno").addClass("red");
		$("#yanzhengno").html("&nbsp;<img src='../images/red_cha.png'/>物流公司单号不能为空！");
		result=1;
	}else{
		if(!reg.test(no)){
			$("#yanzhengno").addClass("red");
			$("#yanzhengno").html("&nbsp;<img src='../images/red_cha.png'/>只能为数字或字符！");
            result=1;
		}else{
			$("#yanzhengno").html("");
		}
	}
	return result;
}

/*验证退货时间*/
function timeBackOrder(orderId){
	jQuery.ajax({
		type: 'post',
		url: basePath+'/customer/timeBackOrderByIdM.htm?orderId='+orderId,
		success:function(data) {
			if(data>0){
				location.href = basePath+"/customer/applybackgoods-"+orderId+".html";
			}else{
				var fillFlow = dialog({
					width : 300,
					height : 60,
					title : '提示',
					content : '<span style="margin-left: 80px;line-height: 60px;">该订单已超出退货限时</span>',
					okValue : '确定',
					ok : function(){
						return true;
					}
				});
				fillFlow.showModal();
			}
		}
	});
}