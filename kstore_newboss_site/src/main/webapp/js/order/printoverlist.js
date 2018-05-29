/**
 * Created by Zhuoy on 2015/5/5.
 */

//拼接订单状态显示
function addstatusstr(str,time,num,cla){
	if(time != null){
		return '<li class="'+cla+'">'+
	    '<p class="name">'+str+'</p>'+
	    '<p class="bar"><i>'+num+'</i></p>'+
	    '<p class="time">'+timeObject(time)+'</p>'+
	    '</li>';
	}else{
		return '<li class="'+cla+'">'+
	    '<p class="name">'+str+'</p>'+
	    '<p class="bar"><i>'+num+'</i></p>'+
	    '<p class="time"></p>'+
	    '</li>';
	}

}

/*查看详细*/
/*function fnOpen(oId) {
    $.ajax({
        type : "POST",
        url:"orderdetailajax.htm",
        data : "orderId=" + oId,
        success:function(data){
            //清空列表
            $("#ordergoods").html("");
            $("#pageorder").html("");
            $("#orderLog").html("");
            //退款日志
            $("#ordertk").html("");
            if(data!="" && data!= null && data != undefined){
                /!*等的详情*!/
                //订单详细信息
                var order = data.order;
                if(order!= null){
                	var status = addstatusstr('已下单',order.createTime,1,'active');
                	if(order.payTime != null){
                		status += addstatusstr('已付款',order.payTime,2,'active');
                	}else{
                		status += addstatusstr('已付款',null,2,'');
                	}
                	if(order.sendExpressTime != null){
                		status += addstatusstr('已发货',order.sendExpressTime,3,'active');
                	}else{
                		status += addstatusstr('已发货',null,3,'');
                	}
                	if(order.getGoodsTime != null){
                		status += addstatusstr('已完成',order.getGoodsTime,4,'active');
                	}else{
                		status += addstatusstr('已完成',null,4,'');
                	}
                	$("#status").html(status);
                	$("#detailorderCodeNo").html("订单号："+notNull(order.orderCode));
                    $("#detailorderCode").html("订单编号："+notNull(order.orderCode));
                    $("#detailcreateTime").html("下单时间："+timeObject(order.createTime));
                    //判断状态
                    if(order.orderStatus == '0'){
                        $("#detailorderStatus").html("未付款");
                    }else if(order.orderStatus == '1'){
                        $("#detailorderStatus").html("已付款未发货");
                    }else if(order.orderStatus == '2'){
                        $("#detailorderStatus").html("已发货");
                    }else if(order.orderStatus == '3'){
                        $("#detailorderStatus").html("已完成");
                    }else if(order.orderStatus == '4'){
                        $("#detailorderStatus").html("已取消");
                    }else if(order.orderStatus == '7'){
                        $("#detailorderStatus").html("退单审核中");
                    }else if(order.orderStatus == '8'){
                        $("#detailorderStatus").html("同意退货");
                    }else if(order.orderStatus == '9'){
                        $("#detailorderStatus").html("拒绝退货");
                    }else if(order.orderStatus == '10'){
                        $("#detailorderStatus").html("待商家收货");
                    }else if(order.orderStatus == '11'){
                        $("#detailorderStatus").html("退单结束");
                    }else if(order.orderStatus == '12'){
                        $("#detailorderStatus").html("退款审核中");
                    }else if(order.orderStatus == '13'){
                        $("#detailorderStatus").html("拒绝退款");
                    }
                    if(order.invoiceType =="0"){
                    	var invoicestr = '<div class="col-sm-12">'+
                        '<p>发票类型：不需要发票</p>'+
                        '</div>'+
                        '<div class="col-sm-12">';
                   	 if(order.orderLinePay=='1'){
                   		 invoicestr+='<p>支付类型：在线支付</p>';
                        }else if(order.orderLinePay=='0'){
                       	 invoicestr+='<p>支付类型：货到付款</p>';
                        }
                   	 invoicestr +='</div>';
                    	$("#invoiceType").html(invoicestr);
                    }else if(order.invoiceType =="1"){
                    	var invoicestr = '<div class="col-sm-12">'+
                        '<p>发票类型：普通发票</p>'+
                        '</div>'+
                        '<div class="col-sm-12">'+
                          '<p>发票抬头：'+notNull(order.invoiceTitle)+'</p>'+
                        '</div>'+
                        '<div class="col-sm-12">'+
                          '<p>发票内容：'+notNull(order.invoiceContent)+'</p>'+
                        '</div>'+
                        '<div class="col-sm-12">';
                    	 if(order.orderLinePay=='1'){
                    		 invoicestr+='<p>支付类型：在线支付</p>';

                         }else if(order.orderLinePay=='0'){
                        	 invoicestr+='<p>支付类型：货到付款</p>';
                         }

                    	 invoicestr +='</div>';
                    	$("#invoiceType").html(invoicestr);
                    }else if(order.invoiceType =="2"){
                        var invoicestr = '<div class="col-sm-12">'+
                            '<p>发票类型：增值税发票</p>'+
                            '</div>'+
                            '<div class="col-sm-12">'+
                            '<p>发票抬头：'+notNull(order.invoiceTitle)+'</p>'+
                            '</div>'+
                            '<div class="col-sm-12">'+
                            '<p>发票内容：'+notNull(order.invoiceContent)+'</p>'+
                            '</div>'+
                            '<div class="col-sm-12">';
                        if(order.orderLinePay=='1'){
                            invoicestr+='<p>支付类型：在线支付</p>';

                        }else if(order.orderLinePay=='0'){
                            invoicestr+='<p>支付类型：货到付款</p>';
                        }

                        invoicestr +='</div>';
                        $("#invoiceType").html(invoicestr);
                    }
                    $("#detailcouponNo").html("使用优惠券："+notNull(order.couponNo));
                    $("#detailorderOldPrice").html("订单原始金额："+order.orderOldPrice.toFixed(2));
                    $("#detailorderPrePrice").html("订单优惠金额："+order.orderPrePrice.toFixed(2));
                    $("#detailorderPrice").html(order.orderPrice.toFixed(2));
                    if(order.modifyPrice == null){
                        $("#modifyPrice").html("订单修改金额：0.00");
                    }else{
                        $("#modifyPrice").html("订单修改金额："+order.modifyPrice.toFixed(2));
                    }
                    if(order.orderIntegral == null){
                        $("#detailorderIntegral").html("积分：0");
                    }else{
                        $("#detailorderIntegral").html("积分："+order.orderIntegral);
                    }
                    //物流信息
                    if(order.orderExpress.expressTypeId==0){
                        $("#detailorderExpress").html("配送方式：快递配送");
                    }else if(order.orderExpress.expressTypeId==1){
                        $("#detailorderExpress").html("配送方式：上门自提");
                    }
                    $("#detailexpressPrice").html("运费："+order.expressPrice.toFixed(2));

                    //收货信息
                    $("#detailshippingaddress").html("收货地址："+notNull(order.shippingProvince)+notNull(order.shippingCity)+notNull(order.shippingCounty));
                    $("#detailaddress").html("详细地址："+notNull(order.shippingAddress));
                    $("#detailshippingPerson").html("收货人："+notNull(order.shippingPerson));
                    $("#detailshippingPhone").html("联系电话："+notNull(order.shippingPhone));
                    $("#detailshippingMobile").html("手机："+notNull(order.shippingMobile));
                    $("#detailcustomerRemark").html("客户留言："+notNull(order.customerRemark));
                    /!*订单商品信息*!/

                    var str ="";
                    $.each(order.orderGoodsList,function(idx,item){

                        var presentStr = "";
                        if(null!=item.isPresent && item.isPresent=="1"){
                            presentStr = '<span style="color: white;background-color: lightgrey;">&nbsp;赠品&nbsp;</span>&nbsp;';
                        }

                        str+='<tr id="goodsnum'+idx+'" class="">';
                        str +='<td><div class="data_item"><img alt="" src="'+notNull(item.goodsProductVo.goodsInfoImgId)+'" height="50" >';
                        str += '<p>'+presentStr+notNull(item.goodsProductVo.goodsInfoName)+'</p></div>';
                      	str += '</td>';
                      	str+='<td>'+item.goodsInfoOldPrice.toFixed(2)+'</td>';
                      	str+='<td>'+item.goodsInfoNum+'</td>';
                        if(item.goodsProductReleSpecVoList!=null) {
                            str += '<td>';
                            for(var s = 0;s<item.goodsProductReleSpecVoList.length;s++){
                                    str+=item.goodsProductReleSpecVoList[s].spec.specName+':'+item.goodsProductReleSpecVoList[s].goodsSpecDetail.specDetailName
                            }
                            str += '</td>';
                        }

                        str +='</td><td>'+item.goodsInfoSumPrice.toFixed(2);
                        str =='</td></tr>';
                    });
                    $("#ordergoods").html(str);
                }
            }
            $('#orderDetails').modal('show');
        }
    });
}*/
function fnOpen(oId) {
    $.ajax({
        type : "POST",
        url:"orderdetailajax.htm",
        data : "orderId=" + oId,
        success:function(data){
            //清空列表
            $("#ordergoods").html("");
            $("#pageorder").html("");
            $("#orderLog").html("");
            //退款日志
            $("#ordertk").html("");
            if(data!="" && data!= null && data != undefined){
                /*等的详情*/
                //订单详细信息

                var order = data.order;
                var relations = data.relations;
                if(order!= null){
                    if(order.communityStoreId!=null) {
                        $.ajax({
                            url:'selectCommunityStoreVo.htm?communityStoreId='+order.communityStoreId+'&CSRFToken='+$("#CSRFToken").val(),
                            success:function (res) {
                                $("#communityStore").html("社区店："+notNull(res.communityStoreName)+"("+res.province.provinceName+res.city.cityName+res.district.districtName+res.communityStoreAddress+")");
                                $("#contact").html("联系人："+notNull(res.contact)+" "+res.contactMobile);
                            }
                        });
                        $("#communityStore").show();
                        $("#contact").show();
                    } else {
                        $("#communityStore").hide();
                        $("#contact").hide();
                    }
                    //旧的收获地址
                    var oldOrderAddress=data.oldOrderAddress;
                    if(oldOrderAddress !=null && oldOrderAddress !=undefined){
                        $("#oldAddress").css({display:"block"});
                        $("#oldAddress").next().show();
                        var expressType="";
                        if(oldOrderAddress.expressType=="1"&&!!oldOrderAddress.communityId){
                            expressType="社区店 自提"
                        }else if(oldOrderAddress.expressType=="0"){
                            if(!!oldOrderAddress.communityId){
                                expressType="社区店 送货上门"
                            }else if(!oldOrderAddress.communityId){
                                expressType="快递配送"
                            }
                        }
                        if(oldOrderAddress.communityId!=null) {
                            $.ajax({
                                url:'selectCommunityStoreVo.htm?communityStoreId='+oldOrderAddress.communityId+'&CSRFToken='+$("#CSRFToken").val(),
                                success:function (res) {
                                    $("#oldCommunityStore").html("社区店："+notNull(res.communityStoreName)+"("+res.province.provinceName+res.city.cityName+res.district.districtName+res.communityStoreAddress+")");
                                    $("#oldContact").html("联系人："+notNull(res.contact)+" "+res.contactMobile);
                                }
                            });
                            $("#oldCommunityStore").show();
                            $("#oldContact").show();
                        } else {
                            $("#oldCommunityStore").hide();
                            $("#oldContact").hide();
                        }
                        $("#oldDetailorderExpress").html("配送方式："+expressType);
                        $("#oldDetailshippingaddress").html("收货地址："+oldOrderAddress.province+oldOrderAddress.city+oldOrderAddress.county);
                        $("#oldDetailaddress").html("详细地址："+oldOrderAddress.address);
                        $("#oldDetailshippingPerson").html("收货人："+oldOrderAddress.person);
                        $("#oldDetailshippingPhone").html("联系电话："+oldOrderAddress.phone);
                        $("#oldDetailshippingMobile").html("手机："+oldOrderAddress.mobile);
                        $("#oldDetailshippingPostcode").html("邮编："+oldOrderAddress.postCode);

                    }else{
                        $("#oldAddress").css({display:"none"});
                        $("#oldAddress").next().hide();
                    }

                    var status = addstatusstr('已下单',order.createTime,1,'active');
                    if(order.payTime != null){
                        status += addstatusstr('已付款',order.payTime,2,'active');
                    }else{
                        status += addstatusstr('已付款',null,2,'');
                    }
                    if(order.sendExpressTime != null){
                        status += addstatusstr('已发货',order.sendExpressTime,3,'active');
                    }else{
                        status += addstatusstr('已发货',null,3,'');
                    }
                    if(order.getGoodsTime != null){
                        status += addstatusstr('已完成',order.getGoodsTime,4,'active');
                    }else{
                        status += addstatusstr('已完成',null,4,'');
                    }
                    $("#detailorderCodeNo").html("订单号："+notNull(order.orderCode));
                    $("#detailorderCode").html("订单编号："+notNull(order.orderCode));
                    $("#detailcreateTime").html("下单时间："+timeObject(order.createTime));
                    if(order.orderCancelTime == null) {
                        $("#detailorederRetime").html('');
                    }else{
                        $("#detailorederRetime").html("订单取消时间："+timeObject(order.orderCancelTime));
                    }
                    //判断状态
                    if(order.orderStatus == '0'){
                        $("#detailorderStatus").html("未付款");
                    }else if(order.orderStatus == '1'){
                        $("#detailorderStatus").html("已付款未发货");
                    }else if(order.orderStatus == '2'){
                        $("#detailorderStatus").html("已发货");
                    }else if(order.orderStatus == '3'){
                        $("#detailorderStatus").html("已完成");
                    }else if(order.orderStatus == '4'){
                        $("#detailorderStatus").html("已取消");
                    }else if(order.orderStatus == '14'){
                        $("#detailorderStatus").html("退单审核中");
                    }else if(order.orderStatus == '8'){
                        $("#detailorderStatus").html("同意退货");
                    }else if(order.orderStatus == '9'){
                        $("#detailorderStatus").html("拒绝退货");
                    }else if(order.orderStatus == '10'){
                        $("#detailorderStatus").html("待商家收货");
                    }else if(order.orderStatus == '11'){
                        $("#detailorderStatus").html("退单结束");
                    }else if(order.orderStatus == '15'){
                        $("#detailorderStatus").html("退款审核中");
                    }else if(order.orderStatus == '13'){
                        $("#detailorderStatus").html("拒绝退款");
                    }else if(order.orderStatus == '14'){
                        $("#detailorderStatus").html("已提交退货审核");
                    }else if(order.orderStatus == '16'){
                        $("#detailorderStatus").html("商家收货失败");
                    }else if(order.orderStatus == '17'){
                        $("#detailorderStatus").html("已退款");
                    }else if(order.orderStatus == '18'){
                        $("#detailorderStatus").html("退款成功");
                    }
                    $("#status").html(status);
                    $("#detailcouponNo").html("优惠券码："+notNull(order.couponNo));
                    $("#detailcouponName").html("优惠券名称："+notNull(order.couponName));
                    $("#detailorderOldPrice").html("订单原始金额："+order.orderOldPrice.toFixed(2));
                    $("#detailorderPrePrice").html("订单优惠金额："+order.orderPrePrice.toFixed(2));
                    $("#detailorderPrice").html(order.orderPrice.toFixed(2));
                    if(order.modifyPrice == null){
                        $("#modifyPrice").html("订单修改金额：0.00");
                    }else{
                        $("#modifyPrice").html("订单修改金额："+order.modifyPrice.toFixed(2));
                    }

                    if(order.orderIntegral == null){
                        $("#detailorderIntegral").html("订单使用积分：0");
                    }else{
                        $("#detailorderIntegral").html("订单使用积分："+order.orderIntegral);
                    }
                    if(order.orderCancelRemark == null){
                        $("#detailorederRemark").html("");
                    }else{
                        $("#detailorederRemark").html("取消订单原因："+order.orderCancelRemark);
                    }

                    //物流信息
                    var str = ""
                    var count = 0;
                    for(var i=0;i<relations.length;i++){
                        count++;
                        str+="<p>包裹["+count+"]</p>";
                        if(relations[i].expressName==null){
                            str+="<div class='col-sm-12'><p>物流公司：</p></div>"
                        }else{
                            str+="<div class='col-sm-12'><p>物流公司："+relations[i].expressName+"</p></div>"
                        }
                        if(relations[i].expressNo==null){
                            str+="<div class='col-sm-12'><p>物流单号：</p></div>"
                        }else{
                            str+="<div class='col-sm-12'><p>物流单号："+relations[i].expressNo+"</p></div>"
                        }
                    }

                    $("#relations").html(str);
                    if(order.orderExpressType==0&&!!order.communityStoreId){
                        $("#detailorderExpress").html("配送方式：社区店 送货上门");
                    }else if(order.orderExpressType==0&&!order.communityStoreId){
                        $("#detailorderExpress").html("配送方式：物流配送");
                    }else if(order.orderExpressType==1&&!!order.communityStoreId){
                        $("#detailorderExpress").html("配送方式：社区店 自提");
                    }
                    if(order.invoiceType =="0"){
                        var invoicestr = '<div class="col-sm-12">'+
                            '<p>发票类型：不需要发票</p>'+
                            '</div>'+
                            '<div class="col-sm-12">';
                        if(order.orderLinePay=='1'){
                            invoicestr+='<p>支付类型：在线支付</p>';
                        }else if(order.orderLinePay=='0'){
                            invoicestr+='<p>支付类型：货到付款</p>';
                        }
                        invoicestr +='</div>';
                        $("#invoiceType").html(invoicestr);
                    }else if(order.invoiceType =="1"){
                        var invoicestr = '<div class="col-sm-12">'+
                            '<p>发票类型：普通发票</p>'+
                            '</div>'+
                            '<div class="col-sm-12">'+
                            '<p>发票抬头：'+notNull(order.invoiceTitle)+'</p>'+
                            '</div>'+
                            '<div class="col-sm-12">'+
                            '<p>纳税人识别号：'+notNull(order.taxpayerNumber)+'</p>'+
                            '</div>'+
                            '<div class="col-sm-12">'+
                            '<p>发票内容：'+notNull(order.invoiceContent)+'</p>'+
                            '</div>'+
                            '<div class="col-sm-12">';
                        if(order.orderLinePay=='1'){
                            invoicestr+='<p>支付类型：在线支付</p>';

                        }else if(order.orderLinePay=='0'){
                            invoicestr+='<p>支付类型：货到付款</p>';
                        }

                        invoicestr +='</div>';
                        $("#invoiceType").html(invoicestr);
                    }else if(order.invoiceType =="2"){
                        var invoicestr = '<div class="col-sm-12">'+
                            '<p>发票类型：增值税发票</p>'+
                            '</div>'+
                            '<div class="col-sm-12">'+
                            '<p>发票抬头：'+notNull(order.invoiceTitle)+'</p>'+
                            '</div>'+
                            '<div class="col-sm-12">'+
                            '<p>纳税人识别号：'+notNull(order.taxpayerNumber)+'</p>'+
                            '</div>'+
                            '<div class="col-sm-12">'+
                            '<p>发票内容：'+notNull(order.invoiceContent)+'</p>'+
                            '</div>'+
                            '<div class="col-sm-12">';
                        if(order.orderLinePay=='1'){
                            invoicestr+='<p>支付类型：在线支付</p>';

                        }else if(order.orderLinePay=='0'){
                            invoicestr+='<p>支付类型：货到付款</p>';
                        }

                        invoicestr +='</div>';
                        $("#invoiceType").html(invoicestr);
                    }

                    $("#detailexpressPrice").html("运费："+order.expressPrice.toFixed(2));

                    //收货信息
                    $("#detailshippingaddress").html("收货地址："+notNull(order.shippingProvince)+notNull(order.shippingCity)+notNull(order.shippingCounty));
                    $("#detailaddress").html("详细地址："+notNull(order.shippingAddress));
                    $("#detailshippingPerson").html("收货人："+notNull(order.shippingPerson));
                    $("#detailshippingPhone").html("联系电话："+notNull(order.shippingPhone));
                    $("#detailshippingMobile").html("手机："+notNull(order.shippingMobile));
                    $("#detailshippingPostcode").html("邮编："+notNull(order.shippingPostcode));
                    $("#detailcustomerRemark").html("客户留言："+notNull(order.customerRemark));
                    /*订单商品信息*/

                    var str ="";
                    $.each(order.orderGoodsList,function(idx,item){

                        var imagId = "";

                        var name = "";

                        if (null != item.goodsProductVo) {
                            imagId = item.goodsProductVo.goodsInfoImgId;
                            name = item.goodsProductVo.goodsInfoName;
                        }
                        var presentStr = "";
                        if(null!=item.isPresent && item.isPresent=="1"){
                            presentStr = '<span style="color: white;background-color: lightgrey;">&nbsp;赠品&nbsp;</span>&nbsp;';
                        }

                        str+='<tr id="goodsnum'+idx+'" class="">';
                        str +='<td><div class="data_item"><img alt="" src="'+notNull(imagId)+'" height="50" >';
                        str += '<p>'+presentStr+notNull(name)+'</p></div>';
                        str += '</td>';
                        str+='<td>'+item.goodsInfoOldPrice.toFixed(2)+'</td>';
                        str+='<td>'+item.goodsInfoNum+'</td>';
                        if(item.goodsProductReleSpecVoList!=null) {
                            str += '<td>';
                            for(var s = 0;s<item.goodsProductReleSpecVoList.length;s++){
                                str+=item.goodsProductReleSpecVoList[s].spec.specName+':'+item.goodsProductReleSpecVoList[s].specValueRemark
                            }
                            str += '</td>';
                        }

                        str +='</td><td>'+item.goodsInfoSumPrice.toFixed(2);
                        str =='</td></tr>';
                    });
                    $("#ordergoods").html(str);
                    if((order.orderStatus == '0'&&!oldOrderAddress)||(order.orderStatus == '1'&&!oldOrderAddress)){
                        //当订单未付款和未发货时可以修改收货地址
                        $(".updateAddress").css("display","inline");
                        $(".updateAddressNot").css({display:"none"});
                        $("#updateAddressOrderId").val(order.orderId);
                    }else{
                        $(".updateAddress").css("display","none");
                        $(".updateAddressNot").css({display:"inline"});
                        $("#updateAddressOrderId").val(order.orderId);
                    }
                }
            }
            $('#orderDetails').modal('show');
        }
    });
}

function pickingOrderIdTwo(orderId,num){
    $.ajax({
        url:"ordercontainerajax.htm?CSRFToken="+$("#csrf_token").val(),
        data:{orderId:orderId},
        type:"post",
        async:false,
        success:function(data){
            var str = "";
            if(notNull(data.order) != ""){
                var order = data.order;
                $('input[name=orderId]').val(order.orderId);
                //配送的信息
                var person='';
                var cart='';
                var cartPerson='';
                var logistics='';
                var logisticsMobile='';
                if(notNull(data.orderDistribution) !=''){
                    person=notNull(data.orderDistribution.salesman);
                    cart=notNull(data.orderDistribution.cart);
                    cartPerson=notNull(data.orderDistribution.motorman);
                    logistics=notNull(data.orderDistribution.logistics);
                    logisticsMobile=notNull(data.orderDistribution.logisticsMobile);
                }
                //社区店的信息
                var communityStoreName='';
                var communityStoreAddress="";
                var communityStoreMobile="";
                var totalSize=0;
                var totalMoney=0;
                if(order.communityStoreId!=null) {
                    $.ajax({
                        url: 'selectCommunityStoreVo.htm?communityStoreId=' + order.communityStoreId + '&CSRFToken=' + $("#CSRFToken").val(),
                        async:false,
                        success: function (res) {
                            if (res.communityStoreName!='') {
                                communityStoreName = res.communityStoreName;
                                communityStoreMobile=res.contactMobile;
                                communityStoreAddress=res.province.provinceName+res.city.cityName+res.district.districtName+res.communityStoreAddress;
                            }
                        }
                    });
                }
                var strorder="";
                var orderLinePay = '';
                if(order.orderLinePay ==1){
                    orderLinePay="在线支付";
                }else{
                    orderLinePay="货到付款";
                }
                    if(num=='2'){
                        strorder+='<h3 style="text-align:center;font-size:18px;margin-top:2px">玖陆零电子商务有限公司——销售订单</h3>';
                        strorder+='<div class="row">' +
                            '<p class="col-xs-7 col-sm-7 col-md-7">收货人：'+notNull(order.shippingPerson)+'</p>' +
                            '<p class="col-xs-10 col-sm-10 col-md-10">收货地址：'+notNull(order.shippingProvince)+notNull(order.shippingCity)+notNull(order.shippingCounty)+notNull(order.shippingAddress)+'</p>' +
                            '<p class="col-xs-7 col-sm-7 col-md-7">收货人电话：'+notNull(order.shippingMobile)+'</p>' +
                            '</div>'+
                            '<div class="row">' +
                            '<p class="col-xs-7 col-sm-7 col-md-7">付款方式：'+orderLinePay+'</p>' +
                            '<p class="col-xs-10 col-sm-10 col-md-10">订单号：'+order.orderCode+'</p>' +
                            '<p class="col-xs-7 col-sm-7 col-md-7">订购日期：'+timeObject(order.createTime)+'</p>' +
                            '</div>'+
                            '<div class="row">' +
                            '<p class="col-xs-7 col-sm-7 col-md-7">业务员：<input type="text" name="person" value="'+person+'" class="textClass" style="border:0px;border-bottom:1px solid #CCC;width:70px;outline-style:none;"></p>' +
                            '<p class="col-xs-10 col-sm-10 col-md-10">送货车辆：<input type="text" name="cart" value="'+cart+'" class="textClass" style="border:0px;border-bottom:1px solid #CCC;outline-style:none;"></p>' +
                            '<p class="col-xs-7 col-sm-7 col-md-7">送货司机：<input type="text" name="cartPerson" value="'+cartPerson+'" class="textClass" style="border:0px;border-bottom:1px solid #CCC;width:90px;outline-style:none;"></p>' +
                            '</div>';
                    }else if(num=='3'){
                        strorder+='<h3 style="text-align:center;font-size:18px;margin-top:2px">玖陆零电子商务有限公司——销售单</h3>';
                        strorder+='<div class="row">' +
                            '<p class="col-xs-7 col-sm-7 col-md-7">收货人：'+notNull(order.shippingPerson)+'</p>' +
                            '<p class="col-xs-10 col-sm-10 col-md-10">收货地址：'+notNull(order.shippingProvince)+notNull(order.shippingCity)+notNull(order.shippingCounty)+notNull(order.shippingAddress)+'</p>' +
                            '<p class="col-xs-7 col-sm-7 col-md-7">收货人电话：'+notNull(order.shippingMobile)+'</p>' +
                            '</div>'+
                            '<div class="row">' +
                            '<p class="col-xs-7 col-sm-7 col-md-7">付款方式：'+orderLinePay+'</p>' +
                            '<p class="col-xs-10 col-sm-10 col-md-10">订单号：'+order.orderCode+'</p>' +
                            '<p class="col-xs-7 col-sm-7 col-md-7">订购日期：'+timeObject(order.createTime)+'</p>' +
                            '</div>'+
                            '<div class="row">' +
                            '<p class="col-xs-7 col-sm-7 col-md-7">业务员：<input type="text" name="person" value="'+person+'" class="textClass" style="border:0px;border-bottom:1px solid #CCC;width:70px;outline-style:none;"></p>' +
                            '<p class="col-xs-10 col-sm-10 col-md-10">送货车辆：<input type="text" name="cart" value="'+cart+'" class="textClass" style="border:0px;border-bottom:1px solid #CCC;outline-style:none;"></p>' +
                            '<p class="col-xs-7 col-sm-7 col-md-7">送货司机：<input type="text" name="cartPerson" value="'+cartPerson+'" class="textClass" style="border:0px;border-bottom:1px solid #CCC;width:90px;outline-style:none;"></p>' +
                            '</div>'+
                            '<div class="row">'+
                            '<p class="col-xs-10 col-sm-10 col-md-10 col-xs-offset-7 col-sm-offset-7 col-md-offset-7">物流公司：<input type="text" name="logistics" value="'+logistics+'" class="textClass" style="border:0px;border-bottom:1px solid #CCC;outline-style:none;"></p>'+
                            '<p class="col-xs-7 col-sm-7 col-md-7">物流电话：<input type="text" name="logisticsMobile" value="'+logisticsMobile+'" class="textClass" style="border:0px;border-bottom:1px solid #CCC;width:90px;outline-style:none;"></p>'+
                            '</div>';
                    }
               /* strorder +='<div class="row" >'+
                    '<div class="" style="width:120px;margin:0;padding:0;float:left">'+
                    '<p>收货人：'+notNull(order.shippingPerson)+'</p>'+
                    '<p>付款方式：';

                    // '<p>邮编：'+notNull(order.shippingPostcode)+'</p>'+
                strorder+='<p>业务员：'+person+'</p>'+
                    '</div>'+
                    '<div class="" style="width:343px;margin:0;padding:0;float:left">'+
                    '<p>收货地址：'+notNull(order.shippingProvince)+notNull(order.shippingCity)+notNull(order.shippingCounty)+notNull(order.shippingAddress)+'</p>'+
                    '<p>订单号：'+order.orderCode+'</p>'+
                    '<p>送货车辆：'+cart+'</p>';
                if(num=='3'){
                    strorder+='<p>物流公司：'+logistics+'</p>';
                }
                strorder+='</div>';
                strorder+='<div class="" style="width:185px;margin:0;padding:0;float:left">'+
                        '<p>收货人电话：'+notNull(order.shippingMobile)+'</p>'+
                        '<p>订购日期：'+timeObject(order.createTime)+'</p>';


                strorder+='<p>送货司机：'+cartPerson+'</p>';
                if(num=='3'){
                    strorder+='<p>物流电话：'+logisticsMobile+'</p>';
                }
                strorder+='</div>'+
                          '</div>';*/
                str += strorder;
            }
            $.each(data.relations,function(index,relation){
                var strrel = "";
                strrel +=' <div class="mb20">'+
                    '<p>装箱单'+(index+1)+'</p>'+
                    '<div class="mb10">'+
                    '<table class="table border_bottom">'+
                    '<thead>'+
                    '<tr>'+
                    '<th class="col-sm-3 col-xs-3">商品编号</th>'+
                    '<th class="col-sm-8 col-xs-8">商品名称</th>'+
                    '<th class="col-sm-3 col-xs-3">商品规格</th>'+
                    '<th class="col-sm-2 col-xs-2">价格</th>'+
                    '<th class="col-sm-3 col-xs-3">数量</th>'+
                    '<th class="col-sm-2 col-xs-2">小计</th>'+
                    '<th class="col-sm-5  col-xs-5">所属类别</th>'+
                    '</tr>'+
                    '</thead>'+
                    '<tbody>';
                $.each(relation.containers,function(indexr,containers){
                    var strcon = "";
                    //判断是否是赠品
                    var presentStr = "";
                    //for(var i = 0;i<data.order.orderGoodsList.length;i++) {
                    //    var order = data.order.orderGoodsList[i];
                    //    if (order.goodsInfoId == containers.goodsProductDetailViewVo.goodsInfoId) {
                    //        if(null!=order.isPresent && order.isPresent=="1"){
                    //            presentStr = '<span">【赠品】</span>&nbsp;';
                    //        }
                    //    }
                    //}
                    if(notNull(containers.containerStatus)=="1"){
                        presentStr = '<span">【赠品】</span>&nbsp;';
                    }

                    strcon += '<tr>'+
                        '<td>'+containers.goodsProductDetailViewVo.goodsInfoItemNo+'</td>';
                    strcon +='<td>'+presentStr+containers.goodsProductDetailViewVo.goodsInfoName+'</td>';
                    for(var i = 0;i<data.order.orderGoodsList.length;i++){
                        var order = data.order.orderGoodsList[i];
                        if((notNull(order.isPresent)=="" && notNull(containers.containerStatus)=="0") || (notNull(order.isPresent)==notNull(containers.containerStatus))){
                            if(order.goodsInfoId == containers.goodsProductDetailViewVo.goodsInfoId){
                                if(order.goodsProductReleSpecVoList.length >0){
                                    var spec_date =order.goodsProductReleSpecVoList;
                                    strcon += '<td>';


                                    for(var s = 0;s<spec_date.length;s++){
                                        if(spec_date[s].specValueRemark!=null){
                                            strcon +=spec_date[s].spec.specName+":"+spec_date[s].specValueRemark;
                                        }
                                        else{

                                            strcon +=spec_date[s].spec.specName+":"+spec_date[s].goodsSpecDetail.specDetailName
                                        }
                                    }
                                    strcon += '</td>';
                                }
                                /*总数量*/
                                totalSize+=containers.goodsNum;
                                /*总金额*/
                                totalMoney+=containers.goodsNum*order.goodsInfoPrice;
                                strcon +='<td>'+(order.goodsInfoPrice).toFixed(2) +'</td>'+
                                    '<td>'+containers.goodsNum+'</td>'+
                                    '<td>'+(containers.goodsNum*order.goodsInfoPrice).toFixed(2)+'</td>';
                                strcon+='<td>'+containers.goodsProductDetailViewVo.goods.goodsCate.catName+'</td>'+'</tr>';
                            }
                        }
                    }
                    strrel += strcon;
                });
                strrel +='</tbody>'+
                    '</table>'+
                    '</div>';
                str += strrel;

            });
            var afteradd="";
            if(num=='3'){
               /* afteradd+='<div class="" style="margin:0 auto;overflow:hidden">'+
                    '<div class="" style="width:162px;margin:0;padding:0;float:left;">'+
                    '<p>总数量：'+totalSize+'</p>'+
                    '<p>社区店：'+communityStoreName+'</p>'+
                    '<p>备货员签字：</p>'+
                    '</div>'+
                    '<div class=""style="width:300px;margin:0;padding:0;float:left" >'+
                    '<p>总金额：'+(parseFloat(totalMoney).toFixed(2))+'</p>'+
                    '<p>社区店地址：'+communityStoreAddress+'</p>'+
                    '<p>司机签字：</p>'+
                    '</div>'+
                    '<div class="" style="width:186px;margin:0;padding:0;float:left">'+
                    '<p>&nbsp;&nbsp;</p>'+
                    '<p>社区店电话：'+communityStoreMobile+'</p>'+
                    '<p>社区店签字：</p>'+
                    '</div>'+
                    '</div>';*/
                var jfprice = (data.order.jfPrice ==null)?"0.00":data.order.jfPrice;
                var couponprice = (data.order.couponPrice ==null)?"0.00":data.order.couponPrice;
                var modifyprice = (data.order.modifyPrice ==null)?"0.00":data.order.modifyPrice;
                var promotionsprice = (data.order.promotionsPrice ==null)?"0.00":data.order.promotionsPrice;
                afteradd+='<div class="row">' +
                '<p class="col-xs-7 col-sm-7 col-md-7">总数量：'+totalSize+'</p>' +
                '<p class="col-xs-10 col-sm-10 col-md-10">运费：'+(parseFloat(data.order.expressPrice).toFixed(2))+'</p>' +
                '<p class="col-xs-7 col-sm-7 col-md-7">积分抵扣金额：-'+(parseFloat(jfprice).toFixed(2))+'</p>' +
                '</div>'+
                '<div class="row">' +
                '<p class="col-xs-7 col-sm-7 col-md-7">优惠抵扣金额：-'+((parseFloat(couponprice)+parseFloat(modifyprice)).toFixed(2))+'</p>' +
                '<p class="col-xs-10 col-sm-10 col-md-10">促销抵扣金额：-'+(Math.abs(parseFloat(promotionsprice).toFixed(2)))+'</p>' +
                '<p class="col-xs-7 col-sm-7 col-md-7">支付金额：'+(parseFloat(data.order.orderPrice).toFixed(2))+'</p>' +
                '</div>'+
                '<div class="row">' +
                '<p class="col-xs-7 col-sm-7 col-md-7">社区店：'+communityStoreName+'</p>' +
                '<p class="col-xs-10 col-sm-10 col-md-10">社区店地址：'+communityStoreAddress+'</p>' +
                '<p class="col-xs-7 col-sm-7 col-md-7">社区店电话：'+communityStoreMobile+'</p>' +
                '</div>'+
                '<div class="row">' +
                '<p class="col-xs-7 col-sm-7 col-md-7">备货员签字：</p>' +
                '<p class="col-xs-10 col-sm-10 col-md-10">司机签字：</p>' +
                '<p class="col-xs-7 col-sm-7 col-md-7">社区店签字：</p>' +
                '</div>'
                    afteradd+= '<p style="text-align:center">白联财务入账，粉联社区店留存，黄联仓库留存，绿联司机联</p>'
            }else if(num=='2'){
                /*afteradd+='<div class="" style="margin:0 auto;overflow:hidden">'+
                    '<div class="" style="width:162px;margin:0;padding:0;float:left">'+
                    '<p>社区店：'+communityStoreName+'</p>'+
                    '<p>总数量：'+totalSize+'</p>'+
                    '</div>'+
                    '<div class="" style="width:300px;margin:0;padding:0;float:left">'+
                    '<p>社区店地址：'+communityStoreAddress+'</p>'+
                    '<p>总金额：'+(parseFloat(totalMoney).toFixed(2))+'</p>'+
                    '</div>'+
                    '<div class="" style="width:186px;margin:0;padding:0;float:left">'+
                    '<p>社区店电话：'+communityStoreMobile+'</p>'+
                    '<p>客户签字：</p>'+
                    '</div>'+
                    '</div>';*/
                var jfprice = (order.jfPrice ==null)?"0.00":order.jfPrice;
                var couponprice = (order.couponPrice ==null)?"0.00":order.couponPrice;
                var modifyprice = (order.modifyPrice ==null)?"0.00":order.modifyPrice;
                var promotionsprice = (order.promotionsPrice ==null)?"0.00":order.promotionsPrice;
                afteradd+='<div class="row">' +
                    '<p class="col-xs-6 col-sm-6 col-md-6">社区店：'+communityStoreName+'</p>' +
                    '<p class="col-xs-6 col-sm-6 col-md-6">社区店电话：'+communityStoreMobile+'</p>' +
                    '<p class="col-xs-12 col-sm-12 col-md-12">社区店地址：'+communityStoreAddress+'</p>' +
                    '</div>'+
                    '<div class="row">' +
                    '<p class="col-xs-6 col-sm-6 col-md-6">总数量：'+totalSize+'</p>' +
                    '<p class="col-xs-6 col-sm-6 col-md-6">运费：'+(parseFloat(order.expressPrice.toFixed(2)).toFixed(2))+'</p>' +
                    '<p class="col-xs-12 col-sm-12 col-md-12 col-lg-12">积分抵扣金额：-'+(parseFloat(jfprice).toFixed(2))+'</p>'+
                    '<p class="col-xs-6 col-sm-6 col-md-6 col-lg-6">优惠抵扣金额：-'+((parseFloat(couponprice)+parseFloat(modifyprice)).toFixed(2))+'</p>'+
                    '<p class="col-xs-6 col-sm-6 col-md-6 col-lg-6">促销抵扣金额：-'+(Math.abs(parseFloat(promotionsprice).toFixed(2)))+'</p>'+
                    '<p class="col-xs-6 col-sm-6 col-md-6">支付金额：'+order.orderPrice.toFixed(2)+'</p>' +
                    '<p class="col-xs-6 col-sm-6 col-md-6">客户签字：</p>'+
                    '</div>';
                afteradd+='<p style="text-align:center">白联财务入账，粉联社区店/客户留存，黄联仓库留存，绿联司机联</p>';
            }

                 str+=afteradd;
            $("#changeOrderId").val(data.order.orderId);
            $("#addContainer").val(data.order.orderId);
            $("#ordermod").html(str);
            num2=0;
            $("#packing").modal("show");

        }
    })
}
function orderlog(oId){
	$.ajax({
        type : "POST",
        url:"orderdetailajax.htm",
        data : "orderId=" + oId,
        success:function(data){
        	$("#orderLog").html("");
        	//订单操作日志
            var orderLogs = data.orderLogs;
            var lognum=pageRows(orderLogs,4);
            if(orderLogs !=null && orderLogs != undefined){
                //清空列表
            	var str ="";
                var strLog = "";
                var strtk="";
                var lognum=pageRows(orderLogs,4);
                var strpagelog = "";
                $.each(orderLogs,function(idx,item){
                    if(idx<4){
                    	strLog+='<tr id="orderLognum'+idx+'" class="">';
                    }else{
                    	strLog+='<tr id="orderLognum'+idx+'" class="ordergoods">';
                    }
                    if(item.orderLogStatus =='0'){
                        strLog +='<td>修改金额</td>';
                    }else if(item.orderLogStatus =='1'){
                        strLog +='<td>中断订单</td>';
                    }else if(item.orderLogStatus =='2'){
                        strLog +='<td>进行拣货</td>';
                    }else if(item.orderLogStatus =='3'){
                        strLog +='<td>进行装箱</td>';
                    }else if(item.orderLogStatus =='4'){
                        strLog +='<td>进行出库</td>';
                    }
                    else if(item.orderLogStatus =='5'){
                        strtk +='<tr><td>退款</td>';
                        strtk +='<td>'+timeObject(item.orderLogTime)+'</td>';
                        strtk +='<td>'+item.orderLogReason+'</td></tr>';
                    }else if(item.orderLogStatus =='6'){
                        strLog +='<td>修改状态</td>';
                    }else if(item.orderLogStatus =='7'){
                        strLog +='<td>一键发货</td>';
                    }
                    strLog +='<td>'+item.orderLogPerson+'</td>';
                    strLog +='<td>'+timeObject(item.orderLogTime)+'</td>';
                    strLog +='<td>'+item.orderLogReason+'</td></tr>';
                });
                if(strtk != ""){
                    $("#ordertk").html(strtk);
                }else{
                    $("#ordertk").html('<tr><td colspan="3"><p class="text-center">暂无可用数据！</p></td></tr>');
                }
                if(strLog != ""){
                    $("#orderLog").html(strLog);
                }else{
                    $("#orderLog").html('<tr><td colspan="4"><p class="text-center">暂无可用数据！</p></td></tr>');
                }
            }
            $('#orderLogmodal').modal('show');
        }
	});
}
//判断数据是否为空为空返回“”
function notNull(obj){
    if(obj != null && obj != undefined){
        return obj;
    }else{
        return "";
    }
}

//订单商品信息分页显示
function pagegoods(pageNo,rows){
    $("#pageorder").html("");
    var strpage = "";
    if(pageNo>1){
        strpage +='<a href="javascript:;" onclick="pagegoods('+(pageNo-1)+','+rows+')"> 上一页 </a>';
    }else{
        strpage +='<span class="disabled"> 上一页 </span>';
    }
    for(var i=1;i<=rows;i++){
        if(i== pageNo){
            strpage +='<span class="current"> '+i+'</span>';
        }else{
            strpage +='<a href="javascript:;" onclick="pagegoods('+i+','+rows+')">'+i+' </a>';
        }
    }
    if(pageNo<rows){
        strpage+='<a href="javascript:;" onclick="pagegoods('+(pageNo+1)+','+rows+')"> 下一页 </a>';
    }else{
        strpage+='<span class="disabled"> 下一页 </span>';
    }
    $("#pageorder").html(strpage);
    $("#ordergoods tr").attr("class","ordergoods");
    $("#goodsnum"+(pageNo*4-1)).attr("class","");
    $("#goodsnum"+(pageNo*4-2)).attr("class","");
    $("#goodsnum"+(pageNo*4-3)).attr("class","");
    $("#goodsnum"+(pageNo*4-4)).attr("class","");
}

//订单操作日志分页显示
function pagelogs(pageNo,rows){
    $("#pagelog").html("");
    var strpage = "";
    if(pageNo>1){
        strpage +='<a href="javascript:;" onclick="pagelogs('+(pageNo-1)+','+rows+')"> 上一页 </a>';
    }else{
        strpage +='<span class="disabled"> 上一页 </span>';
    }
    for(var i=1;i<=rows;i++){
        if(i== pageNo){
            strpage +='<span class="current"> '+i+'</span>';
        }else{
            strpage +='<a href="javascript:;" onclick="pagelogs('+i+','+rows+')">'+i+' </a>';
        }
    }
    if(pageNo<rows){
        strpage+='<a href="javascript:;" onclick="pagelogs('+(pageNo+1)+','+rows+')"> 下一页 </a>';
    }else{
        strpage+='<span class="disabled"> 下一页 </span>';
    }
    $("#pagelog").html(strpage);
    $("#orderLog tr").attr("class","ordergoods");
    $("#orderLognum"+(pageNo*4-1)).attr("class","");
    $("#orderLognum"+(pageNo*4-2)).attr("class","");
    $("#orderLognum"+(pageNo*4-3)).attr("class","");
    $("#orderLognum"+(pageNo*4-4)).attr("class","");
}

//转换时间格式
function timeObject(obj){
    var date = "/Date(" +notNull(obj)+")/";
    var time = new Date(parseInt(date.replace("/Date(", "").replace(")/", ""), 10));
    var result = time.getFullYear() + "-" + (time.getMonth() + 1 < 10 ? "0" + (time.getMonth() + 1) : time.getMonth() + 1) + "-" + (time.getDate() < 10 ? "0" + time.getDate() : time.getDate()) + " " + (time.getHours() < 10 ? "0" + time.getHours() : time.getHours()) + ":" + (time.getMinutes() < 10 ? "0" + time.getMinutes() : time.getMinutes())+ ":" + (time.getSeconds() < 10 ? "0" + time.getSeconds() : time.getSeconds());
    return result;
}

function pageRows(obj,pageSize){
    //计算页数
    var num = 0;
    if(obj.length<=pageSize){
        num =1;
    }else if(obj.length%pageSize == 0){
        num = obj.length/pageSize;
    }else{
        num = obj.length/pageSize+1;
    }
    return num;
}

function ssorder(){
    $("#orderCodestr").val($("#orderCode").val());
    $("#shippingPersonstr").val($("#shippingPerson").val());
    $("#shippingMobilestr").val($("#shippingMobile").val());
    $("#printoverlist").submit();
}

//拣货
function pickingOrderIds(){
    var bool = false;
    var checks = $(".input_orderId");
    var checkGroup = new Array();
    for (var i = 0; i < checks.length; i++) {
        var e = checks[i];
        if (e.checked == true) {
            bool = true;
            checkGroup.push(e.value);
        }
    }
    $(".order_p_id").attr("value",checkGroup);
    if(bool){
        $.ajax({
            type : "POST",
            url:"orderpickingajax.htm?orderId=" + checkGroup+"&CSRFToken="+$("#csrf_token").val(),
            success:function(data){
                $("#orderGoodsInfolist").html("");
                if(data != null && data != undefined && data != ""){
                    var orderGoodsInfos = data.orderGoodsInfos;
                    var str= '';
                    if(orderGoodsInfos != null && orderGoodsInfos != undefined && orderGoodsInfos != null){
                        str += '<div class="mb20"><div class="border_bottom mb10 row">'+
                        '<div class="col-sm-1 col-xs-1"><p>序号</p></div>'+
                        '<div class="col-sm-3 col-xs-3"> <p>商品编号</p> </div>'+
                        '<div class="col-sm-11 col-xs-11"><p class="text-center">商品名称</p></div>'+
                        '<div class="col-sm-3 col-xs-3"> <p class="text-center">数量</p> </div>'+
                        '<div class="col-sm-4 col-xs-4"> <p>商品属性</p> </div>'+
                        '<div class="col-sm-2 col-xs-2"> <p>价格</p> </div>'+
                        '</div>';
                        $.each(orderGoodsInfos,function(idx,item){
                            str += '<div class="border_bottom mb10 row"><div class="col-xs-1"><p>'+(idx+1)+'</p></div>';
                            str += '<div class="col-xs-3"><p>'+item.goodsProductVo.goodsInfoItemNo+'</p></div>';
                            str += '<div class="col-xs-11"><p>'+item.goodsProductVo.goodsInfoName+'</p></div>';
                            str += '<div class="col-xs-3"><p class="text-center">'+item.goodsInfoNum+'</p></div>';
                            str += '<div class="col-xs-4"><p>';
                            if(item.goodsProductVo.goodsSpecVo != null){
	                            $.each(item.goodsProductVo.goodsSpecVo,function(idxs,specVo){
	                                str+= specVo.specName+':'+specVo.specValue+'</br>';
	                            });
                            }
                            str+='</p></div>';
                            str += '<div class="col-xs-2"><p>'+item.goodsInfoPrice+'</p></div></div>';
                        });
                        str += '</div>';
                    }

                    $("#orderGoodsInfolist").html(str);
                }
                $('#pickUp').modal('show')
            }
        });
    }else{
        showTipAlert("请选择一行");
    }

}

/**
 * 打印
 */


function doPrint() {
    bdhtml=window.document.body.innerHTML;//获取当前页的html代码
    sprnstr="<!--startprint1-->";//设置打印开始区域
    eprnstr="<!--endprint1-->";//设置打印结束区域
    prnhtml=bdhtml.substring(bdhtml.indexOf(sprnstr)+18); //从开始代码向后取html
    prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));//从结束代码向前取html
    //window.open($("#basePath").val()+"printorderpickinglist.htm?str="+prnhtml);
    $("#str").val(prnhtml);
    $("#printView").submit();
}
function doPrint5(){
    bdhtml=window.document.body.innerHTML;//获取当前页的html代码
    sprnstr="<!--startprint2-1-->";//设置打印开始区域
    eprnstr="<!--endprint2-1-->";//设置打印结束区域
    prnhtml=bdhtml.substring(bdhtml.indexOf(sprnstr)+18); //从开始代码向后取html
    prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));//从结束代码向前取html
    //window.open($("#basePath").val()+"printorderpickinglist.htm?str="+prnhtml);
    $("#str").val(prnhtml);
    $("#printView").submit();
}
function pickingOrderId(id){
    var checkGroup = new Array();
    checkGroup.push(id);
    $(".order_p_id").attr("value",checkGroup);
        $.ajax({
            type : "POST",
            url:"orderpickingajax.htm?orderId=" + checkGroup+"&CSRFToken="+$("#csrf_token").val(),
            success:function(data){
                $("#orderGoodsInfolist").html("");
                if(data != null && data != undefined && data != ""){
                    var orderGoodsInfos = data.orderGoodsInfos;
                    var str= '';
                    if(orderGoodsInfos != null && orderGoodsInfos != undefined && orderGoodsInfos != null){
                        str += '<div class="mb20"><div class="border_bottom mb10 row">'+
                        '<div class="col-sm-1 col-xs-1"><p>序号</p></div>'+
                        '<div class="col-sm-3 col-xs-3"> <p>商品编号</p> </div>'+
                        '<div class="col-sm-11 col-xs-11"><p class="text-center">商品名称</p></div>'+
                        '<div class="col-sm-3 col-xs-3"> <p class="text-center">数量</p> </div>'+
                        '<div class="col-sm-4 col-xs-4"> <p>商品属性</p> </div>'+
                        '<div class="col-sm-2 col-xs-2"> <p>价格</p> </div>'+
                        '</div>';
                        $.each(orderGoodsInfos,function(idx,item){

                            var presentStr = "";
                            if(null!=item.isPresent && item.isPresent=="1"){
                                presentStr = '&nbsp;<span">【赠品】</span>&nbsp;';
                            }

                            str += '<div class="border_bottom mb10 row"><div class="col-xs-1"><p>'+(idx+1)+'</p></div>';
                            str += '<div class="col-xs-3"><p>'+item.goodsProductVo.goodsInfoItemNo+'</p></div>';
                            str += '<div class="col-xs-11"><p>'+presentStr+item.goodsProductVo.goodsInfoName+'</p></div>';
                            str += '<div class="col-xs-3"><p class="text-center">'+item.goodsInfoNum+'</p></div>';
                            str += '<div class="col-xs-4"><p>';
                            $.each(item.goodsProductVo.goodsSpecVo,function(idxs,specVo){
                                str+= specVo.specName+':'+specVo.specValue+'</br>';
                            });
                            str+='</p></div>';
                            str += '<div class="col-xs-2"><p>'+item.goodsInfoPrice+'</p></div></div>';
                        });
                        str += '</div>';
                    }

                    $("#orderGoodsInfolist").html(str);
                }
                $('#pickUp').modal('show')
            }
        });
}