$(function(){
    /* 高级搜索 */
    $('.advanced_search').popover({
        html : true,
        title : '高级搜索',
        content : $('.advanced_search_cont').html(),
        trigger : 'click',
        placement : 'bottom'
    }).click(function(){
    	 $('select[data-live-search="true"]').select2();
    });
    /* 下面是表单里面的日期时间选择相关的 */
    $('.form_datetime').datetimepicker({
        format: 'yyyy-mm-dd hh:ii:00',
        weekStart : 1,
        autoclose : true,
        language : 'zh-CN',
        pickerPosition : 'bottom-left',
        todayBtn : true,
        viewSelect : 'hour'
    });
    $('.form_date').datetimepicker({
        format : 'yyyy-mm-dd',
        weekStart : 1,
        autoclose : true,
        language : 'zh-CN',
        pickerPosition : 'bottom-left',
        minView : 2,
        todayBtn : true
    });
    /* 下面是表单里面的日期时间选择相关的 END */

    /*下面是时间选择器开始时间不能大于结束时间设置  START*/
    var startTime = $("#startTime").val();
    var endTime = $("#endTime").val();
    $('#endpicker').datetimepicker('setStartDate', startTime);
    $('#startpicker').datetimepicker('setEndDate', endTime);
    $('#endpicker')
        .datetimepicker()
        .on('show', function (ev) {
            startTime = $("#startTime").val();
            endTime = $("#endTime").val();
            $('#endpicker').datetimepicker('setStartDate', startTime);
            $('#startpicker').datetimepicker('setEndDate', endTime);
        });
    $('#startpicker')
        .datetimepicker()
        .on('show', function (ev) {
            endTime = $("#endTime").val();
            startTime = $("#startTime").val();
            $('#startpicker').datetimepicker('setEndDate', endTime);
            $('#endpicker').datetimepicker('setStartDate', startTime);
        });
    /*下面是时间选择器开始时间不能大于结束时间设置  END*/

});
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
                    if(order.giftcardPrice != null && order.giftcardPrice > 0){
                        $("#detailorderPrice").html(order.orderPrice.toFixed(2)+" （使用礼品卡支付 " + order.giftcardPrice.toFixed(2) +"）");
                    }else{
                        $("#detailorderPrice").html(order.orderPrice.toFixed(2));
                    }
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

                    if(order.giftcardEmail != null){
                        $("#giftCardEmail").removeClass("hide");
                        $("#giftCardEmail span").html(order.giftcardEmail);
                    }else{
                        $("#giftCardEmail").addClass("hide");
                        $("#giftCardEmail span").html("");
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
                   	 /*if(order.orderLinePay=='1'){
                   		 invoicestr+='<p>支付类型：在线支付</p>';
                        }else if(order.orderLinePay=='0'){
                       	 invoicestr+='<p>支付类型：货到付款</p>';
                        }
                   	 invoicestr +='</div>';
                    	$("#invoiceType").html(invoicestr);*/
                    }else if(order.invoiceType =="1"){
                        var pstr = '';
                        if(!notNull(order.taxpayerNumber)){
                            pstr = '(个人)';
                        }else{
                            pstr = '(单位)';
                        }
                    	var invoicestr = '<div class="col-sm-12">'+
                        '<p>发票类型：普通发票 '+pstr+'</p>'+
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
                    	 /*if(order.orderLinePay=='1'){
                    		 invoicestr+='<p>支付类型：在线支付</p>';

                         }else if(order.orderLinePay=='0'){
                        	 invoicestr+='<p>支付类型：货到付款</p>';
                         }

                    	 invoicestr +='</div>';
                    	$("#invoiceType").html(invoicestr);*/
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
                        /*if(order.orderLinePay=='1'){
                            invoicestr+='<p>支付类型：在线支付</p>';

                        }else if(order.orderLinePay=='0'){
                            invoicestr+='<p>支付类型：货到付款</p>';
                        }

                        invoicestr +='</div>';
                        $("#invoiceType").html(invoicestr);*/
                    }
                    if(order.orderLinePay=='1'){
                        invoicestr+='<p>支付类型：在线支付</p>';
                    }else if(order.orderLinePay=='0'){
                        invoicestr+='<p>支付类型：货到付款</p>';
                    }

                    invoicestr +='</div>';
                    //访问客户端
                    invoicestr +='<div class="col-sm-12">';
                    invoicestr+='<p>访问客户端：';
                    if(order.orderMType=='0'){
                        invoicestr+='PC端';
                    }else if(order.orderMType=='1'){
                        invoicestr+='H5端';
                    }else if(order.orderMType=='2'){
                        invoicestr+='APP端';
                    }
                    invoicestr +='</p></div>';
                    //支付方式
                    invoicestr +='<div class="col-sm-12">';
                    if(order.orderStatus == '0'){
                        invoicestr+='<p>支付方式：未付款</p>';
                    }else {
                        invoicestr += '<p>支付方式：' + data.payName;
                        if(order.giftcardPrice != null && order.giftcardPrice > 0 && order.payId != "5"){
                            invoicestr += '、礼品卡支付';
                        }
                        invoicestr += '</p>';
                    }
                    invoicestr +='</div>';
                    $("#invoiceType").html(invoicestr);

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
                      	str+='<td>'+item.goodsInfoPrice.toFixed(2)+'</td>';
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
                    if((order.orderStatus == '0'&&!oldOrderAddress&&order.orderCargoStatus!='2'&&order.orderCargoStatus!='3')||(order.orderStatus == '1'&&!oldOrderAddress&&order.orderCargoStatus!='2'&&order.orderCargoStatus!='3')){
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
/*订单拆单*/
function fnSplitOrder(oId){
    $.ajax({
        type : "POST",
        url:"orderdetailajax.htm",
        data : "orderId=" + oId,
        success:function(data){
            $("#ordergoods2").html("");
            $("[name=split3]").hide();
            $("#splitOrderId").val(oId);
            if(data!="" && data!= null && data != undefined){
                //订单详细信息
                var order = data.order;
                var relations = data.relations;
                if(order!= null){
                    //拆分订单
                    /*订单商品信息*/
                    var str ="";
                    var totalNum = 0;
                    $.each(order.orderGoodsList,function(idx,item){
                        totalNum += item.goodsInfoNum;
                        var imagId = "";
                        var name = "";
                        if (null != item.goodsProductVo) {
                            imagId = item.goodsProductVo.goodsInfoImgId;
                            name = item.goodsProductVo.goodsInfoName;
                        }
                        var presentStr = "";
                        var presentTips = "";
                        var isPresent = "0";
                        if(null!=item.isPresent && item.isPresent=="1"){
                            presentStr = '<span style="color: white;background-color: lightgrey;">&nbsp;赠品&nbsp;</span>&nbsp;';
                            presentTips = '<br><span style="color: #ff0000;">请仔细核对赠品所在的订单</span>';
                            isPresent = "1";
                        }

                        str += '<tr id="goodsnum'+idx+'" class="">';
                        str += '<td><div class="data_item"><img alt="" src="'+notNull(imagId)+'" height="50" >';
                        str += '<p>'+presentStr+notNull(name)+'</p>'+presentTips+'<input type="hidden" name="isPresent" value='+isPresent+'></div>';
                        str += '</td>';
                        str += '<td id="sum_'+idx+'">'+item.goodsInfoNum+'<input type="hidden" name="goodsInfoId" value='+item.goodsInfoId+'><input type="hidden" name="goodsprice" value='+item.goodsInfoPrice+'></td>';
                        str += '<td name="split1"><input alt="newnum1" name="newnum1" onchange="splitChange('+idx+','+item.goodsInfoNum+')" class="split_'+idx+'" value='+item.goodsInfoNum+'></td>';
                        str += '<td name="split2"><input alt="newnum2" name="newnum2" onchange="splitChange('+idx+','+item.goodsInfoNum+')" class="split_'+idx+'" value=0 readonly></td>';
                        str += '<td name="split3" style="display: none;"><input alt="newnum3" name="newnum3" onchange="splitChange('+idx+','+item.goodsInfoNum+')" class="split_'+idx+'" value=0></td>';

                        str =='</tr>';
                    });
                    $("#ordergoods2").html(str);
                    $("#splitMessage").empty();
                    $("#addSplit").removeAttr("style");
                    $("#addSplit").attr("disabled",false);
                    $("#splitSubmit").removeAttr("style");
                    $("#splitSubmit").attr("disabled",false);
                    if(order.orderCode.indexOf("A")>0 || order.orderCode.indexOf("B")>0 || order.orderCode.indexOf("C")>0){
                        $("#addSplit").css("display","none");
                        $("#splitSubmit").css("display","none");
                        $("#splitMessage").append("<font color='red'>已拆分订单无法再次拆分！</font>");
                    }else if(totalNum<=1){
                        $("#addSplit").css("display","none");
                        $("#splitSubmit").css("display","none");
                        $("#splitMessage").append("<font color='red'>该订单无法继续拆分！</font>");
                    }
                }
            }
            $('#splitOrder').modal('show');
        }
    });
}
/*拆单中变更商品数量*/
function splitChange(idx,sum){
    var num = sum;
    $(".split_"+idx).each(function(){
        num = num - $(this).val();
    });
    var num0 = $(".split_"+idx+"[alt='newnum2']").val();
    if(eval(num +"+"+ num0) < 0){

    }else{
        $(".split_"+idx+"[alt='newnum2']").val(eval(num +"+"+ num0));
    }
}
/*追加一列拆单列*/
function addSplit(obj){
    $("[name=split3]").show();
    $(obj).attr("disabled",true);
}
/*提交拆单请求*/
function splitSubmit(obj){
    $(obj).attr("disabled",true);
    $("#splitMessage").empty();
    var goodNum = $("[name=split1]").length-1;
    var token=$('input[name=CSRFToken]').val();
    var num1 = 0;
    var num2 = 0;
    var num3 = 0;
    for(var i=0;i<goodNum;i++){
        $("#splitMessage").empty();
        var sum = eval( $(".split_"+i+"[alt='newnum1']").val()) + eval( $(".split_"+i+"[alt='newnum2']").val()) + eval( $(".split_"+i+"[alt='newnum3']").val());
        var oldSum = eval($("#sum_"+i).text());
        if(sum!=oldSum){
            $("#splitMessage").append("<font color='red'>拆分后订单的各商品总数必须一致！</font>");
            $(obj).attr("disabled",false);
            return;
        }
        num1 += eval($(".split_"+i+"[alt='newnum1']").val());
        num2 += eval($(".split_"+i+"[alt='newnum2']").val());
        num3 += eval($(".split_"+i+"[alt='newnum3']").val());
    }
    var flag = 0;
    if(num1==0){
        $("[alt='newnum1']").removeAttr("name");
        flag ++;
    }
    if(num2==0){
        $("[alt='newnum2']").removeAttr("name");
        flag ++;
    }
    if(num3==0){
        $("[alt='newnum3']").removeAttr("name");
        flag ++;
    }
    if(flag>=2){
        $("#splitMessage").append("<font color='red'>请至少将订单拆分成2份！</font>");
        $(obj).attr("disabled",false);
        return;
    }
    $.ajax({
        url: "splitOrder.htm?CSRFToken="+token,
        type: "POST",
        data: $("#splitForm").serialize(),
        success:function (data) {
            if(data=="success"){
                $('#splitOrder').modal('hide');
                $(obj).attr("disabled",false);
                showTipAlert("订单已拆分");
                submitOrder();
            }else{
                $("#splitOrder_body").html("对不起您暂时没有权限，请与管理员联系!");
                $("#splitMessage").hide();
                $(obj).attr("disabled",false);
                $(obj).on("click",function () {
                    location.reload();
                })
            }
        }
    });
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
                    }else if(item.orderLogStatus =='7'){
                        strLog +='<td>一键发货</td>';
                    }
                    else if(item.orderLogStatus =='5'){
                        strtk +='<tr><td>退款</td>';
                        strtk +='<td>'+timeObject(item.orderLogTime)+'</td>';
                        strtk +='<td>'+item.orderLogReason+'</td></tr>';
                    }else if(item.orderLogStatus =='6'){
                        strLog +='<td>修改状态</td>';
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

//订单备注列表查询
var currentPage=1;
var pageSize=4;

function orderremarksbefore(oId,orderCode){
    orderremarks(oId,orderCode,currentPage,pageSize);
}
function orderremarks(oId,orderCode,currentPage,pageSize) {
    var data={
        orderId:oId,
        currentPage:currentPage,
        pageSize:pageSize
    }
    var token=$('input[name=CSRFToken]').val();
    $.ajax({
        type: "POST",
        url: "orderremarksajax.htm?CSRFToken="+token,
        data: data,
        success: function (data) {
            //订单备注集合
            var orderRemarks=data.orderRemarks;
            //清空列表
            $('#remarktr').empty();
            var sb='';
            //遍历生成列表
            if(orderRemarks.length>0){
                $.each(orderRemarks,function(index,item){
                    var time=new Date(item.creatTime).toLocaleString();
                    $('#remarktr').append('' +
                        '<tr>'
                        +'<td>'+item.orderCode+'</td>'
                        +'<td>'+item.remarkContent+'</td>'
                        +'<td>'+item.ordercustomer+'</td>'
                        +'<td>'+time+'</td>'
                        +'</tr>'
                    );
                })
                //分页逻辑
                if(currentPage>1){
                    sb+="<a  href='javascript:orderremarks("+oId+','+orderCode+','+(currentPage-1)+','+pageSize+");'> 上一页 </a>";
                }
                var totalPage=parseInt(data.totalPage);

                for(var i=((currentPage-2)>0?(currentPage-2):1) ; i<=((currentPage+3)<totalPage?(currentPage+3):totalPage) ; i++){
                    if(i==currentPage){
                        sb+="<span class='current'> "+i+" </span>";
                    }else{
                        sb+="<a  href='javascript:orderremarks("+oId+','+orderCode+','+i+','+pageSize+");'> "+i+" </a>";
                    }
                }

                if(currentPage<totalPage){
                    sb+="<a  href='javascript:orderremarks("+oId+','+orderCode+','+(currentPage+1)+','+pageSize+");'> 下一页 </a>";
                }
                $('#pagefenye').empty();
                $('#pagefenye').html(sb);

            }else{
                //如果列表没有数据
                $('#remarktr').append('' +
                    '<tr >'
                    +'<td colspan="4"><p class="text-center">暂无可用数据！</p></td>'
                    +'</tr>');
            }

            $('input[name=ordercode]').val(oId+'-'+orderCode);
            $('#orderremarks').modal('show');

        }
    })
}
function addremark(){
    $("#orderremarks").modal('hide');
    $('#remarktext').val("");
    $("#addremarkcontent").modal('show');
}
function remarkcommit(){
    $("#addremarkcontent").modal('hide');
    var data={};
    var ordersms=$("input[name=ordercode]").val();
    var remarktext=$('#remarktext').val();
    if(remarktext==''){
        alert("备注不能为空");
        return;
    }
    var token=$('input[name=CSRFToken]').val()
    data.ordersms=ordersms;
    data.remarktext=remarktext;
    $.ajax({
        type:'POST',
        url:'addremarksajax.htm?CSRFToken='+token,
        data:data,
        success:function(data){
            if(data=="ok"){

            }
        }
    })
}
//修改地址
function updateAddressNew(obj,token,oid) {
    $.ajax({
        url: "queryUpdateStateByOrderId.htm?CSRFToken=" + token,
        data: {orderId: oid,
               page:"orderPage"
        },
        async: false,
        type: "get",
        success: function (result) {
            if (result == "1") {
                showTipAlert("订单地址正在修改中，请稍后再试");
                return;
            } else if(result=="3"){
                showTipAlert("准备装箱中，请稍后再试");
                return;
            }else{
                queryModal(function(){
                    var out=setTimeout("queryProvince("+"'"+token+"'"+")",1000);
                    //clearTimeout(out);
                })

            }
        }
    });
}
function queryModal(fn){
    $("#updateAddressModal").modal('show');
    showAndHideAdress();
    $("#citiessId").html("<option value=''>选择城市</option>");
    $("#cities").html("<option value=''>选择城市</option>");
    $("#districts").html("<option value=''>选择区县</option>");
    $("#districtssId").html("<option value=''>选择区县</option>");
    $("#communityssId").html("<option value=''>选择社区店</option>");
    $("input[name=addressName]").val("");
    $("input[name=addressDetail]").val("");
    $("input[name=addressPhone]").val("");
    $("input[name=addressZip]").val("");
    $('.modal-backdrop').each(function(index,item){
        if($(item).next().attr('id')=='updatexcy'){
            $(item).hide();
        }
    });
    fn&&fn();
}
//加载省份
function queryProvince(token){
    var provinceflag = '';
    $.get("queryAllProvince.htm?CSRFToken=" + token, function (data) {
     var provinces = "<option value=''>选择省份</option>";
     for (var i = 0; i < data.length; i++) {
        provinces += "<option ";
         if (data[i].provinceId == provinceflag) {
            checked = " selected ";
         } else {
             checked = '';
        }
        provinces += checked + " value='" + data[i].provinceId + "'>" + data[i].provinceName + "</option>";
     }
     $("#provinces").html(provinces);
     //$('select[data-live-search="true"]').select2();

     $("#provincessId").html(provinces);
     //$('select[data-live-search="true"]').select2();
     //updateOrderUpdateStateOne(oid, token, '1');
 })
}

/*根据省份ID查询城市*/
function queryCityByProvinceId(province,token){
    provinceflag=$(province).val();
    //设置省份名称
    $.get("queryCityByProvinceId.htm?CSRFToken="+token+"&provinceId="+($(province).val()),function(data){
        var provinces="<option value=''>选择城市</option>";
        for(var i=0;i<data.length;i++){
            provinces+="<option value='"+data[i].cityId+"'>"+data[i].cityName+"</option>";
        }
        $("#cities").html(provinces);
        //$('select[data-live-search="true"]').select2();
    });
}

/*社区店根据省份ID查询城市*/
function queryCommCityByProvinceId(province,token){
    provinceflag=$(province).val();
    //设置省份名称
    $.get("queryCityByProvinceId.htm?CSRFToken="+token+"&provinceId="+($(province).val()),function(data){
        var provinces="<option value=''>选择城市</option>";
        for(var i=0;i<data.length;i++){
            provinces+="<option value='"+data[i].cityId+"'>"+data[i].cityName+"</option>";
        }
        $("#citiessId").html(provinces);
       // $('select[data-live-search="true"]').select2();
    });
}
/*根据城市ID查询区县*/
function queryDistrictByCityId(city,token){
    //设置城市名称
    $("#temp2").val($(city).find("option:selected").text());
    //城市id
    $("#temp5").val($(city).find("option:selected").val());
    $.get("queryDistrictByCityId.htm?CSRFToken="+token+"&cityId="+($(city).val()),function(data){
        var provinces="<option value='0'>选择区县</option>";
        for(var i=0;i<data.length;i++){

            provinces+="<option value='"+data[i].districtId+"'>"+data[i].districtName+"</option>";
        }

        $("#districts").html(provinces);
        //$('select[data-live-search="true"]').select2();
    });
}
/*社区店根据城市ID查询区县*/
function queryCommDistrictByCityId(city,token){

    //设置城市名称
    $("#temp2").val($(city).find("option:selected").text());
    //城市id
    $("#temp5").val($(city).find("option:selected").val());
    $.get("queryDistrictByCityId.htm?CSRFToken="+token+"&cityId="+($(city).val()),function(data){
        var provinces="<option value='0'>选择区县</option>";
        for(var i=0;i<data.length;i++){

            provinces+="<option value='"+data[i].districtId+"'>"+data[i].districtName+"</option>";
        }

        $("#districtssId").html(provinces);
       // $('select[data-live-search="true"]').select2();
    });
}
function queryCommCommunityByDistrictId(district,token){
    provinceflag=$(district).val();
    $.get("loadAllCommunityStores.htm?CSRFToken="+token+"&districtId="+($(district).val()),function(data){
        var provinces="<option value='0'>选择社区店</option>";
        for(var i=0;i<data.length;i++){

            provinces+="<option value='"+data[i].communityStoreId+"'>"+data[i].communityStoreName+"</option>";
        }

        $("#communityssId").html(provinces);
        //$('select[data-live-search="true"]').select2();
    });

}
//查看是否在配送范围之内  是否有货
function isGualified(obj,oid,token,fn){
    var data={
        district:obj,
        orderId:oid,
        CSRFToken:token
    }
    $.get("isGualified.htm",data,function(result){
        if(result=='notWare'){
            $("#hintSpan").html("");
            $("#updateAddressHint").modal('show');
            $("#hintSpan").html("此区域暂时不支持配送");
            return;
        }else if(result=='notProduct'){
            $("#hintSpan").html("");
            $("#updateAddressHint").modal('show');
            $("#hintSpan").html("您选择的商品在此区域暂时无货");
            result;
        }else{

        }
        fn&&fn();
    })
}
function saveAddress(oid,token){
    //如果选择的是社区店 那么必须填写社区店地址
    var $addressType=$("input[name=addressType]:checked").val();
    if($addressType=='1'||$addressType=='2'){
        if($("#communityssId").val()==''||$("#communityssId").val()==null){
            $("#hintSpan").html("");
            $("#updateAddressHint").modal('show');
            $("#hintSpan").html("请选择社区店");
            return;
        }
    }
    //校验地址是否为空
    var obj=$("#districts").val();
    if(obj==null||obj==''){
        $("#hintSpan").html("");
        $("#updateAddressHint").modal('show');
        $("#hintSpan").html("请选择配送地址");
        return ;
    }
    //校验该区域是否配送  是否有货
    isGualified(obj,oid,token,function(){
        if(!$("#formUpdateAddress").valid()){
            return;
        };
        $.ajax({
            data:$("#formUpdateAddress").serialize(),
            type:"post",
            url:'saveAddressAfterUpdate.htm?CSRFToken='+token,
            success:function(result){
                if("2"==result){
                    $("#hintSpan").html("");
                    $("#updateAddressHint").modal('show');
                    $("#hintSpan").html("已装箱");
                    return;
                }else if("3"==result){
                    $("#hintSpan").html("");
                    $("#updateAddressHint").modal('show');
                    $("#hintSpan").html("已出库");
                    return;
                }else if("9"==result){
                    $("#hintSpan").html("");
                    $("#updateAddressHint").modal('show');
                    $("#hintSpan").html("订单地址已被修改过一次");
                    return;
                }else{
                    $("#updateAddressModal").modal('hide');
                    $("#orderDetails").modal('hide');
                    window.location.reload();
                    // fnOpen(oid);
                    //$('#orderDetailOnClick').trigger('click');
                    updateOrderUpdateStateOne(oid,token,'2');
                }

            }
        })
    });
}
//修改订单的状态 修改地址的状态 1：修改中,2：修改结束
function updateOrderUpdateStateOne(oid,token,updateState){
    var date={orderId:oid,
        updateState:updateState };
    $.get("updateOrderAddressState.htm?CSRFToken="+token,date,function(result){
    })
}
function showAndHideAdress(){
    if($('input[type=radio]:checked').val()=="1"||$('input[type=radio]:checked').val()=="2"){
        $(".community").show();
    }else{
        $(".community").hide();
    }
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

//修改状态
function fnModifyOrder(oId,sta,orderLinePay){
    var h='';
    $("#oStatusst option").remove();
    if(orderLinePay==0){
        if(sta==3){
            h+='<option value="3">已收货完成</option>';
        }
    }else{
        //h+='<option value="0">未付款</option>';
        h+='<option value="1">已付款</option>';
    }
    $("#oStatusst").html(h);
    $("#oStatusst").val(sta);
    $("#updateOrderst").attr("action","modifyOrderStatus.htm?orderId="+oId+'&CSRFToken='+$("#CSRFToken").val());
    $('#changeOrderStatus').modal('show');
}

function updateOrdersub(){
    $("#updateOrderst").submit();
}

//修改金额
function modifyPrice(orderId,orderCodex,orderPrice,expressPrice){
    $("#o_order_price").attr("value",orderPrice);
    $("#o_order_expressprice").attr("value",expressPrice);
    $(".modify_order_id").attr("value",orderId);
    $(".modify_order_codex").attr("value",orderCodex);
    $('#upmoneyYN').modal('show');
}
//提示框确定
function upmoneyYN(){
    $('#upmoneyYN').modal('hide');
    $('#order_price').val('');
    $('#up_orReason').val('');
    $("#moneytip").html("");
    $("#reasontip").html("");
    $('#changeOrderMoney').modal('show');
}
function upmoney(){
    var flag = false;
    //非空判断
    if($("#order_price").val()==''){
        $("#moneytip").html("不能为空");
        if($("#up_orReason").val()==''){
            $("#reasontip").html("不能为空");
            return false;
        }else{
            $("#reasontip").html("");
            return false;
        }
    }else{
        if($("#up_orReason").val()==''){
            $("#reasontip").html("不能为空");
            return false;
        }
        if($("#up_orReason").val().length >20){
            $("#reasontip").html("中断原因字数不能大于20个");
            return false;
        }
    }

    if($("#order_price").val()!='' && $("#order_price").val().match(/^([0-9][0-9]*(\.[0-9]{1,2})?|0\.(?!0+$)[0-9]{1,2})$/) == null){
        $("#moneytip").html("金额格式不正确");
        $("#moneytip").attr("style","");
        if($("#up_orReason").val()==''){
            $("#reasontip").html("不能为空");
            return false;
        }else{
            $("#reasontip").html("");
            return false;
        }
    }
    $("#modify_order_price").attr("value",$("#order_price").val());
    var price=$("#o_order_price").val()-$("#modify_order_price").val();
    $("#o_order_price").val()
    var expressprice =$("#o_order_price").val()-$("#modify_order_price").val()-$("#o_order_expressprice").val();
    if(price>0){
        $("#moneytip").html("");
        checkReason();
        flag = true;
    }else{
        $("#moneytip").html("金额不能高于等于订单金额");
        $("#moneytip").attr("style","");
        flag = false;
        return false;
        checkReason();
    }

    if(expressprice>0){
        $("#moneytip").html("");
        checkReason();
        flag = true;
    }else{
        $("#moneytip").html("修改后金额必须大于运费");
        flag = false;
        return false;
        $("#moneytip").attr("style","");
        checkReason();
    }
    if(flag){
        $("#changeOrderMoney").modal("hide");
        $("#changeOrderMoneypwd").modal("show");
    }
}
function checkReason(){
    if($("#up_orReason").val()==''){
        $("#reasontip").html("不能为空");
        return false;
    }else{
        $("#reasontip").html("");
        return true;
    }
}

//验证身份
function upmoneypwd(){
    var reg = /^.*[A-Za-z0-9\\w_-]+.*$/;
    var pwd = $("#changepwd").val();
    var token=$("#CSRFToken").val();
    if(pwd != null && pwd.trim().length != 0){
        var url = 'checkUserKey.htm?userKey='+pwd+'&CSRFToken='+token;
        $.ajax({
            type : 'post',
            url : url,
            async : false,
            success : function(data) {
                if (data > 0) {
                    $("#upmoneyform").attr("action","modifyorderprice.htm").submit();
                } else if(data == 0) {
                    $(".pwdtip").text("密码错误!");
                    $(".pwdtip").addClass("alert-danger");
                    $(".col-sm-10").addClass("has-error");
                    return;
                }
            },
            error:function(){
                $(".pwdtip").text("网络连接异常!");
                $(".pwdtip").addClass("alert-danger");
                $(".col-sm-10").addClass("has-error");
            }
        });
    }else{
        $(".pwdtip").text("请输登录密码!");
        $(".pwdtip").addClass("alert-danger");
        $(".col-sm-10").addClass("has-error");
    }
}

/**
 * 中断订单
 * @param oId
 * @param sta
 * @param code
 */
function fnModifyOrderCancel(oId,sta,code){
    $("#orReason").val("");
    $("#oStatus").val(sta);
    $("#orderCodex").val(code);
    $("#orId").val(oId);
    //确认中断框
    $('#updateOrderStatusYN').modal('show');
}

/**
 * 提示是否中断
 */
function updateOrderoYN(){
    $('#updateOrderStatusYN').modal('hide');
    $('#updateOrderStatus').modal('show');

}

/**
 * 验证登陆
 */
function updateOrderoStatus(){
    if($("#updateOrder").valid()){
        if($("#orReason").val().length <= 20){
            $("#reasonError").html("");
            $('#updateOrderStatus').modal('hide');
            //验证登陆框
            $('#verifylogin').modal('show');
        }else{
            $("#reasonError").show();
            $("#reasonError").html("中断原因字数不能大于20个");
        }
    }

}

/**
 * 验证登陆
 */
var digit = 0;
function verifylogin(){
    var reg = /^.*[A-Za-z0-9\\w_-]+.*$/;
    var pwd = $("#pwd").val();
    if(pwd != null && pwd.trim().length != 0){
        var url = 'checkUserKey.htm?userKey='+pwd+'&CSRFToken='+$("#CSRFToken").val();
        $.ajax({
            type : 'post',
            url : url,
            async : false,
            success : function(data) {
                if (data > 0) {
                    if(digit == 0){
                        $("#updateOrder").attr("action","suspendorder.htm").submit();
                        digit++;
                    }

                } else if(data == 0) {
                    $(".pwdtip").text("密码错误!");
                    $(".col-sm-10").addClass("has-error");
                    $(".pwdtip").addClass("alert-danger");
                    return;
                }
            },
            error:function(){
                $(".pwdtip").text("网络连接异常!");
                $(".col-sm-10").addClass("has-error");
                $(".pwdtip").addClass("alert-danger");
            }
        });
    }else{
        $(".pwdtip").text("请输登录密码!");
        $(".col-sm-10").addClass("has-error");
        $(".pwdtip").addClass("alert-danger");
    }
}

function submitOrderCode(){
    $("#orderCodestr").val($("#orderCode").val());
    $("#shippingPersonstr").val($("#shippingPerson").val());
    $("#storeNamestr").val($("#storeName").val());
    $("#shippingMobilestr").val($("#shippingMobile").val());
    $("#startTimestr").val($("#startTime").val());
    $("#orderStatusstr").val($("#orderStatus").val());
    $("#customerUsernamestr").val($("#customerUsername").val());
    $("#endTimestr").val($("#endTime").val());
    $("#ordercxform").submit();
}

function submitOrder(){
    $("#orderCodestr").val($("#orderCode").val());
    $("#shippingPersonstr").val($("#shippingPerson").val());
    $("#storeNamestr").val($("#storeName").val());
    $("#shippingMobilestr").val($("#shippingMobile").val());
    $("#startTimestr").val($("#startTime").val());
    $("#orderStatusstr").val($("#orderStatus").val());
    $("#customerUsernamestr").val($("#customerUsername").val());
    $("#endTimestr").val($("#endTime").val());
    $("#wareIdstr").val($("#wareId").val());
    $("#communityStoreId").val($("#community").val());
    $("#ordercxform").submit();
}
/**
 * 打印订单详情
 * */
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
/**
 * 展示一键发货dialog
 */
function showOneKeyDelivery(orderId,orderMType){
    var token=$("#CSRFToken").val();
    $.ajax({
        url:"queryUpdateStateByOrderId.htm?CSRFToken="+token,
        data:{orderId:orderId},
        async:false,
        type:"get",
        success:function(result) {
            if (result == "1") {
                showTipAlert("订单地址正在修改中，请稍后再试");
                return;
            } else {
                $.ajax({
                    type: 'get',
                    url: 'expressdetail.htm?orderId=' + orderId + '&CSRFToken=' + token,
                    async: false,
                    success: function (data) {
                        if (data != null) {
                            $("#expressId").val(data.expressId);
                            $("#expressName").text(data.expressName);
                            $("#deliveryId").val(orderId);
                            $("#orderMType").val(orderMType);
                            $("#oneKeyDelivery").modal('show');
                        }
                    },
                    error: function () {
                        $(".express_tip").text("网络连接异常!");
                        $(".col-sm-10").addClass("has-error");
                        $(".express_tip").addClass("alert-danger");
                    }
                });
            }
        }
            });
}



/**
 * 一键发货
 */
function oneKeyDelivery(){
    if($("#oneKeyDeliveryForm").valid()){
        var noReg = new RegExp("^[0-9a-zA-Z]+$");
        if($("#expressNo").val() == ""){
            showTipAlert("请填写运单号");
        }else if(!noReg.test($("#expressNo").val())){
            showTipAlert("请填写正确的物流单号");
        }else{
            $.ajax({
                type:'post',
                url:'onekeydelivery.htm?CSRFToken'+$("#CSRFToken").val(),
                data: $("#oneKeyDeliveryForm").serialize(),
                async: false,
                success: function(data){
                    if(data == true){
                        showTipAlert("一键发货成功！");
                        if($("#orderMType").val() == '1'){
                            $.post("sendgoodsnotify.htm?CSRFToken="+$("#CSRFToken").val(), $("#oneKeyDeliveryForm").serialize(),
                                function(data){
                                    location.reload();
                                });
                        }else{
                            location.reload();
                        }
                    }
                },
                error: function(){
                    showTipAlert("Connection error");
                }
            });
        }
    }
}