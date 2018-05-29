
/**
 * 中断订单
 * @param oId
 * @param sta
 * @param code
 */
function fnModifyOrder(oId,sta,code){
	$("#orReason").val("");
	$("#oStatus").val(sta);
	$("#orderCodex").val(code);
	$("#orId").val(oId);
	//确认中断框
	$('#updateOrderStatusYN').modal('show');
	}

/**
 * 验证登陆
 */
function updateOrderoStatus(){
	if($("#updateOrder").valid()){
		$('#updateOrderStatus').modal('hide');
		//验证登陆框
		$('#verifylogin').modal('show');
	}

}
/**
 * 验证登陆
 */
function verifylogin(){
	var reg = /^.*[A-Za-z0-9\\w_-]+.*$/;
	var pwd = $("#pwd").val();
	if(pwd != null && pwd.trim().length != 0){
		var url = 'checkUserKey.htm?userKey='+pwd+'&CSRFToken='+$("#csrf_token").val();
		$.ajax({
			type : 'post',
			url : url,
			async : false,
			success : function(data) {
				if (data > 0) {
					$("#updateOrder").attr("action","suspendorder.htm").submit();
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

//拣货
function pickingOrderIds(){
    $("#printNo").val("0");
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

                                var presentStr = "";
                                if(null!=item.isPresent && item.isPresent=="1"){
                                    presentStr = '<span">【赠品】</span>&nbsp;';
                                }

								str += '<div class="border_bottom mb10 row"><div class="col-xs-1"><p>'+(idx+1)+'</p></div>';
                                str += '<div class="col-xs-3"><p>'+item.goodsProductVo.goodsInfoItemNo+'</p></div>';
                                str += '<div style="padding-left: 30px;" class="col-xs-11"><p>'+presentStr+item.goodsProductVo.goodsInfoName+'</p></div>';
                                str += '<div class="col-xs-3"><p class="text-center">'+item.goodsInfoNum+'</p></div>';
								str += '<div class="col-xs-4"><p>';
								if(item.goodsProductVo.goodsSpecVo != null){
	                                $.each(item.goodsProductVo.goodsSpecVo,function(idxs,specVo){
	                                    str+= specVo.specName+':'+specVo.specValue+'</br>';
	                                });
								}
                                str+='</p></div>';
								str += '<div class="col-xs-2"><p>'+(item.goodsInfoPrice).toFixed(2)+'</p></div></div>';
							});
							str += '</div>';
						}
//						var gifts = data.gifts;
//						if(gifts != null && gifts != undefined && gifts != null){
//							str +='<div class="mb20"><div class="border_bottom mb10"><p>赠品列表</p></div><div class="border_bottom mb10 row"><div class="col-xs-8"><p>赠品编号</p></div><div class="col-xs-13"><p class="text-center">赠品名</p></div><div class="col-xs-3"><p class="text-right">数量</p></div></div>';
//							$.each(gifts,function(idx,item){
//								str += '<div class="border_bottom mb10 row"><div class="col-xs-8"><p>'+gifts.gift.giftCode+'</p></div>';
//								str += '<div class="col-xs-13"><p>'+gifts.gift.giftName+'</p></div>';
//								str += '<div class="col-xs-3"><p class="text-right">'+gifts.giftNum+'</p></div></div>';
//							});
//							str += '</div>';
//						}
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
 * 提示是否中断
 */
function updateOrderoYN(){
	$('#updateOrderStatusYN').modal('hide');
	$('#updateOrderStatus').modal('show');

}
$('.advanced_search').popover({
    html : true,
    title : '高级搜索',
    content : $('.advanced_search_cont').html(),
    trigger : 'click',
    placement : 'bottom'
  }).click(function(){
	  $('select[data-live-search="true"]').select2();
  });

/**
 * 打印
 */
function doPrint() {
	bdhtml=window.document.body.innerHTML;//获取当前页的html代码
	sprnstr="<!--startprint1-->";//设置打印开始区域
	eprnstr="<!--endprint1-->";//设置打印结束区域
	prnhtml=bdhtml.substring(bdhtml.indexOf(sprnstr)+18); //从开始代码向后取html
	prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));//从结束代码向前取html
    $("#printNo").val("1");
    $("#str").val(prnhtml);
    $("#printView").submit();
    //window.open("printView.htm?CSRFToken="+$("#csrf_token").val()+"&str="+prnhtml);
	//window.open($("#basePath").val()+"printorderpickinglist.htm?str="+prnhtml);
}

/**
 * 打印
 */
function doPrint2() {
    bdhtml=window.document.body.innerHTML;//获取当前页的html代码
    sprnstr="<!--startprint2-->";//设置打印开始区域
    eprnstr="<!--endprint2-->";//设置打印结束区域
    prnhtml=bdhtml.substring(bdhtml.indexOf(sprnstr)+18); //从开始代码向后取html
    prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));//从结束代码向前取html
    $("input[name=personName]").val($("input[name=person]").val());//业务员
    $("input[name=cartName]").val($("input[name=cart]").val());//送货车
    $("input[name=cartPersonName]").val($("input[name=cartPerson]").val());//送货司机
    $("input[name=logisticsName]").val($("input[name=logistics]").val());
    $("input[name=logisticsMobileName]").val($("input[name=logisticsMobile]").val());
    $("input[name=printType]").val("doPrint2");
    $("#printNo2").val("1");
    $("#str").val(prnhtml);
    $("#printView").submit();
    //window.open("printView.htm?CSRFToken="+$("#csrf_token").val()+"&str="+prnhtml);
    //window.open($("#basePath").val()+"printorderpickinglist.htm?str="+prnhtml);
}

/**
 * 高级搜索
 */
function ordercxsubmit(){
	$("#orderCodestr").val("");
    $("#shippingPersonstr").val($("#shippingPerson").val());
    $("#shippingMobilestr").val($("#shippingMobile").val());
    $("#ordercxform").submit();

}

/**
 * 搜索
 */
function ordersssubmit(){
	$("#orderCodestr").val($("#orderCode").val());
    $("#shippingPersonstr").val($("#shippingPerson").val());
    $("#shippingMobilestr").val($("#shippingMobile").val());
    $("#ordercxform").submit();
}

/**
 * 弹框
 * @param deleteUrl 删除链接。
 */
function updateOrder(deleteUrl,text) {
    $("#modalDialog").remove();
    var confirmDialog =
    '<div class="modal fade" id="modalDialog" tabindex="-1" role="dialog">'+
    '    <div class="modal-dialog">'+
    '        <div class="modal-content">'+
    '            <div class="modal-header">'+
    '                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>'+
    '               <h4 class="modal-title">操作提示</h4>'+
    '           </div>'+
    '           <div class="modal-body">'+
    '               '+text+
    '           </div>'+
    '           <div class="modal-footer">'+
    '               <button type="button" class="btn btn-primary" onclick="doupdateorder(\''+deleteUrl+'\');">确定</button>'+
    '               <button type="button" class="btn btn-default" data-dismiss="modal" onclick="$(\'#modalDialog\').modal(\'hide\');">取消</button>'+
    '           </div>'+
    '       </div>'+
    '   </div>'+
    '</div>';
    $(document.body).append(confirmDialog);
    $('#modalDialog').modal('show');
}
function doupdateorder(deleteUrl){
	$(deleteUrl).submit();
}

/*拣货操作*/
function subOrder(){
    if($("#printNo").val() != "1"){
        showTipAlert("请先打印!");
        return;
    }
    var checkedList = new Array();
    var str = '<input  type="hidden" name="token" value="L" />';
    $("input[name='order_id']:checked").each(function() {
        str += '<input type="hidden" value="'+$(this).val()+'"  name="orderIds"/>'
    });
    str+= '<input type="hidden"  value="1"  name="status"/>';
    $("#sub_orders").html(str);
    $.ajax({
        cache: true,
        type: "POST",
        url: "changeorderbyfif.htm?CSRFToken="+$("#csrf_token").val(),
        data:  $("#sub_orders").serialize(),// 你的formid
        async: false,
        error: function (request) {
        },
        success: function (data) {
            if (data == 0) {
                showTipAlert("请注意，此行为非正常操作！！！");
                location.href = "orderpickinglist.htm";

            } else {
                showTipAlert("已拣货！");
                $(".btn-primary").hide();
                location.href = "orderpickinglist.htm";
            }
        }
    });
}

//转换时间格式
function timeObject(obj){
    var date = "/Date(" +notNull(obj)+")/";
    var time = new Date(parseInt(date.replace("/Date(", "").replace(")/", ""), 10));
    var result = time.getFullYear() + "-" + (time.getMonth() + 1 < 10 ? "0" + (time.getMonth() + 1) : time.getMonth() + 1) + "-" + (time.getDate() < 10 ? "0" + time.getDate() : time.getDate()) + " " + (time.getHours() < 10 ? "0" + time.getHours() : time.getHours()) + ":" + (time.getMinutes() < 10 ? "0" + time.getMinutes() : time.getMinutes())+ ":" + (time.getSeconds() < 10 ? "0" + time.getSeconds() : time.getSeconds());
    return result;
}

//判断数据是否为空为空返回“”
function notNull(obj){
    if(obj != null && obj != undefined){
        return obj;
    }else{
        return "";
    }
}
//修改订单的状态 修改地址的状态 1：修改中,2：修改结束
function updateOrderUpdateStateOne(oid,token,updateState){
    var date={orderId:oid,
        updateState:updateState };
    $.get("updateOrderAddressState.htm?CSRFToken="+token,date,function(result){
    })
}

//装箱操作
function goOrderPincking(orderId,statu){
    goOrderPinc(orderId,statu,function(){
       $('.modal-backdrop').each(function(index,item){
           if($(item).next().attr('id')=='updatexcy'){
               $(item).hide();
           }
       });
    });
}
function goOrderPinc(orderId,statu,fn){
    $('#orderIdId').val(orderId);
    //查看是否在修改过程中
    $.ajax({
        url:"queryUpdateStateByOrderId.htm?CSRFToken="+$("#csrf_token").val()+"&statu="+statu,
        data:{orderId:orderId,page:"warehouse"},
        async:false,
        type:"get",
        success:function(result){
            if(result=="1"){
                showTipAlert("订单地址正在修改中，请稍后再试。。。");
                return;
            }else if(result=="3"){
                showTipAlert("订单正在装箱中，请稍后再试。。。");
                return;
            }else{
                $("#printNo2").val("0");
               /* $.post("ordercontainerajax.htm?CSRFToken="+$("#csrf_token").val(),{orderId:orderId},function(data){*/

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
                        if(notNull(data.orderDistribution) !=''){
                            person=notNull(data.orderDistribution.salesman);
                            cart=notNull(data.orderDistribution.cart);
                            cartPerson=notNull(data.orderDistribution.motorman);
                        }
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
                         strorder+='<h3 style="text-align:center;font-size:18px;margin-top:2px">玖陆零电子商务有限公司——销售订单</h3>';
                         var orderLinePay='';
                        if(order.orderLinePay ==1){
                            orderLinePay="在线支付";
                        }else{
                            orderLinePay="货到付款";
                        }
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
                         '<p class="col-xs-7 col-sm-7 col-md-7">送货司机：<input type="text" name="cartPerson" value="'+cartPerson+'" class="textClass" style="border:0;border-bottom:1px solid #CCC;width:90px;outline-style:none;"></p>' +
                         '</div>'
                   /*      strorder +='<div class="row">'+
                            '<div class="" style="width:120px;margin:0;padding:0;float:left">'+
                            '<p>收货人：'+notNull(order.shippingPerson)+'</p>'+
                            '<p>付款方式：';
                        if(order.orderLinePay ==1){
                            strorder+="在线支付";
                        }else{
                            strorder+="货到付款";
                        }
                            // '<p>邮编：'+notNull(order.shippingPostcode)+'</p>'+
                        strorder +='<p>业务员：<input type="text" name="person" value="'+person+'" class="textClass" style="border:0px;border-bottom:1px solid #CCC;width:70px"></p>'+


                            '</div>'+
                            '<div class="" style="width:343px;margin:0;padding:0;float:left">'+
                             '<p>收货地址：'+notNull(order.shippingProvince)+notNull(order.shippingCity)+notNull(order.shippingCounty)+notNull(order.shippingAddress)+'</p>'+
                             '<p>订单号：'+order.orderCode+'</p>'+
                         '<p>送货车辆：<input type="text" name="cart" value="'+cart+'" class="textClass" style="border:0px;border-bottom:1px solid #CCC;"></p>';

                        strorder+='</div>'+
                                  '<div class="" style="width:185px;margin:0;padding:0;float:left">'+
                                  '<p>收货人电话：'+notNull(order.shippingMobile)+'</p>'+
                                  '<p>订购日期：'+timeObject(order.createTime)+'</p>';
                        strorder+='<p>送货司机：<input type="text" name="cartPerson" value="'+cartPerson+'" class="textClass" style="border:0;border-bottom:1px solid #CCC;width:90px"></p>'+
                                '</div>'+
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
                            '<th class="col-sm-5  col-xs-5" ">所属类别</th>'+
                            '<th class="Noprint">操作</th>'+
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
                                        strcon+='<td>'+containers.goodsProductDetailViewVo.goods.goodsCate.catName+'</td>';
                                    }
                                }
                            }

                            var relations = "";
                            $.each(data.relations,function(index,item){
                                relations+=item.relationId+"-";
                            });
                            relations = relations.substring(0,relations.length-1);
                            strcon += '<td class="Noprint">'+
                                '<button type="button" class="btn btn-primary btn-sm" onclick="changeContainers('+data.order.orderId+',\''+relations+'\','+containers.containerId+','+containers.goodsNum +','+relation.relationId+');">更换包裹</button>'+
                                '</td>'+
                                '</tr>';
                            strrel += strcon;
                        });
                        strrel +='</tbody>'+
                            '</table>'+
                            '<div class="text-right Noprint"><button type="button" class="btn btn-default" onclick="delContainers('+relation.relationId+','+data.order.orderId+')">删除此装箱单</button> </div>'+
                            '</div>'+
                            '</div>';
                        str += strrel;

                    });
                       var jfprice = (order.jfPrice ==null)?"0.00":order.jfPrice;
                       var couponprice = (order.couponPrice ==null)?"0.00":order.couponPrice;
                       var modifyprice = (order.modifyPrice ==null)?"0.00":order.modifyPrice;
                       var promotionsprice = (order.promotionsPrice ==null)?"0.00":order.promotionsPrice;
                    var afteradd="";
                    afteradd+='<p class="" style="margin:0 auto;overflow:hidden">'+
                             /* '<div class="" style="width:162px;margin:0;padding:0;float:left">'+
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
                              '<div class="" style="width:186px;margin:0;padding:0;float:left">'+
                              '<p>社区店电话：'+communityStoreMobile+'</p>'+
                              '<p>客户签字：</p>'+
                              '</div>'+*/
                              '<p class="col-xs-6 col-sm-6 col-md-6 col-lg-6">社区店：'+communityStoreName+'</p>'+
                            '<p class="col-xs-6 col-sm-6 col-md-6 col-lg-6">社区店电话：'+communityStoreMobile+'</p>'+
                            '<p class="col-xs-12 col-sm-12 col-md-6 col-lg-12">社区店地址：'+communityStoreAddress+'</p>'+
                            '<p class="col-xs-6 col-sm-6 col-md-6 col-lg-6">总数量：'+totalSize+'</p>'+
                            '<p class="col-xs-6 col-sm-6 col-md-6 col-lg-6">运费：'+order.expressPrice.toFixed(2)+'</p>'+
                            '<p class="col-xs-12 col-sm-12 col-md-12 col-lg-12">积分抵扣金额：-'+(parseFloat(jfprice).toFixed(2))+'</p>'+
                            '<p class="col-xs-6 col-sm-6 col-md-6 col-lg-6">优惠抵扣金额：-'+((parseFloat(couponprice)+parseFloat(modifyprice)).toFixed(2))+'</p>'+
                            '<p class="col-xs-6 col-sm-6 col-md-6 col-lg-6">促销抵扣金额：-'+(Math.abs(parseFloat(promotionsprice).toFixed(2)))+'</p>'+
                            '<p class="col-xs-6 col-sm-6 col-md-6 col-lg-6">支付金额：'+order.orderPrice.toFixed(2)+'</p>'+
                            '<p class="col-xs-6 col-sm-6 col-md-6 col-lg-6">客户签字：</p>'+
                              '</div>'+
                              '<p style="text-align:center">白联财务入账，粉联社区店/客户留存，黄联仓库留存，绿联司机联</p>';
                    str+=afteradd;
                    $("#changeOrderId").val(data.order.orderId);
                    $("#addContainer").val(data.order.orderId);
                    $("#ordermod").html(str);
                    num2=0;
                    $("#packing").modal("show");
                    //$("#updatexcy").prev().remove();
                     fn&&fn();
                   }
               })
            }
        }
    })

}
function ordercontainerajaxFn(orderId){
    var html='';
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
                var communityStoreName='';
                var communityStoreAddress="";
                var communityStoreMobile="";
                var totalSize=0;
                var totalMoney=0;
                if(order.communityStoreId!=null) {
                    /*获取社区店*/
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
                var strorder="<!--startprint2-->";
                strorder+='<h3 style="text-align:center;font-size:18px;margin-top:2px">玖陆零电子商务有限公司——销售单</h3>';
                var orderLinePay = '';
                if(order.orderLinePay ==1){
                    orderLinePay="在线支付";
                }else{
                    orderLinePay="货到付款";
                }
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
                /*strorder +='<div class="row">'+
                    '<div class="" style="width:120px;margin:0;padding:0;float:left">'+
                    '<p>收货人：'+notNull(order.shippingPerson)+'</p>'+
                    '<p>付款方式：';
                if(order.orderLinePay ==1){
                    strorder+="在线支付";
                }else{
                    strorder+="货到付款";
                }
                     // '<p>邮编：'+notNull(order.shippingPostcode)+'</p>'+
                strorder+='<p>业务员：<input type="text" name="person" value="'+person+'" class="textClass" style="border:0px;border-bottom:1px solid #CCC;width:70px"></p>'+
                    '</div>'+
                    '<div class="" style="width:343px;margin:0;padding:0;float:left">'+
                    '<p>收货地址：'+notNull(order.shippingProvince)+notNull(order.shippingCity)+notNull(order.shippingCounty)+notNull(order.shippingAddress)+'</p>'+
                    '<p>订单号：'+order.orderCode+'</p>'+
                    // '<p>社区店：'+communityStoreName+'</p>'+
                    '<p>送货车辆：<input type="text" name="cart" value="'+cart+'" class="textClass" style="border:0px;border-bottom:1px solid #CCC;"></p>'+
                    '<p>物流公司：<input type="text" name="logistics" value="'+logistics+'" class="textClass" style="border:0px;border-bottom:1px solid #CCC;"></p>'+
                          '</div>';
                strorder+='<div class="" style="width:185px;margin:0;padding:0;float:left">'+
                          '<p>收货人电话：'+notNull(order.shippingMobile)+'</p>'+
                          '<p>订购日期：'+timeObject(order.createTime)+'</p>';

                strorder+='<p>送货司机：<input type="text" name="cartPerson" value="'+cartPerson+'" class="textClass" style="border:0px;border-bottom:1px solid #CCC;width:90px"></p>'+
                          '<p>物流电话：<input type="text" name="logisticsMobile" value="'+logisticsMobile+'" class="textClass" style="border:0px;border-bottom:1px solid #CCC;width:90px"></p>';
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

                    var relations = "";
                    $.each(data.relations,function(index,item){
                        relations+=item.relationId+"-";
                    });
                    relations = relations.substring(0,relations.length-1);
                    strrel += strcon;
                });
                strrel +='</tbody>'+
                    '</table>'+
                    '</div>';
                str += strrel;

            });
            var jfprice = (data.order.jfPrice ==null)?"0.00":data.order.jfPrice;
            var couponprice = (data.order.couponPrice ==null)?"0.00":data.order.couponPrice;
            var modifyprice = (data.order.modifyPrice ==null)?"0.00":data.order.modifyPrice;
            var promotionsprice = (data.order.promotionsPrice ==null)?"0.00":data.order.promotionsPrice;
            var afteradd="";
            afteradd+='<div class="" style="margin:0 auto;overflow:hidden">'+
                    '<div class="row">' +
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
                /*'<div class="" style="width:162px;margin:0;padding:0;float:left;">'+
                '<p>总数量：'+totalSize+'</p>'+
                '<p>社区店：'+communityStoreName+'</p>'+
                '<p>备货员签字：</p>'+
                '</div>'+
                '<div class="" style="width:300px;margin:0;padding:0;float:left" >'+
                '<p>运费：'+(parseFloat(data.order.expressPrice).toFixed(2))+'</p>'+
                '<p>社区店地址：'+communityStoreAddress+'</p>'+
                '<p>司机签字：</p>'+
                '</div>'+
                '<div class="" style="width:186px;margin:0;padding:0;float:left">'+
                '<p>支付金额：'+(parseFloat(data.order.orderPrice).toFixed(2))+'</p>'+
                '<p>社区店电话：'+communityStoreMobile+'</p>'+
                '<p>社区店签字：</p>'+
                '</div>'+*/
                '</div>'+
                '<p style="text-align:center">白联财务入账，粉联社区店留存，黄联仓库留存，绿联司机联</p>'+
                '<!--endprint2-->';
            str+=afteradd;
            html=str;
        }
    })
    return html;
}

//删除包裹
function delContainers(relationId,orderId){
    $.post("verifycount.htm", { relationId: relationId,CSRFToken: $("#csrf_token").val() },
        function(data){
            if(data>0){
                showTipAlert("该包裹下存下商品，不可删除!");
            }else{
                $("#orderIdu").val(orderId);
                $("#del_relation_id").val(relationId);
                $.ajax({
                    type: "POST",
                    url: "delrelationbyidajax.htm?CSRFToken="+$("#csrf_token").val(),
                    data:  $("#del_relation").serialize(),// 你的formid
                    async: false,
                    success: function (data) {
                        goOrderPincking(orderId,"1");
                    }
                });
            }
        });
}

//添加包裹
function addContainers(){
    var obj = $("#addContainer").val();
    $.post("addcontainerajax.htm?CSRFToken="+$("#csrf_token").val(),{orderId:obj},function(data){
        goOrderPincking(obj,"1");
    });

}

//更换包裹
function changeContainers(orderId,relation,containerId,num,relationId){
    $("#updatecontainer input[name=containerId]").val(containerId);
    $("#updatecontainer input[name=orderId]").val(orderId);
    var str = "";
    var relations = relation.split("-");
    for(var i=0;i<relations.length;i++){
        if(relations[i] != "" && relations[i] != relationId){
            str += '<option value="'+(relations[i])+'">装箱单'+(i+1)+'</option>';
        }
    }
    $("#updatecontainer select[name=relationId]").html(str);
    $('#changePackage').modal('show');
    $("#errorInfo").text("");
    $("#goodsNums").val(num);
}

function changeContainerRe(){

    if($("#relationIds").val() != null){
        if(!isNaN($("#goodsNum").val()) && $("#goodsNum").val()>0 && $("#goodsNum").val() != "" && parseInt($("#goodsNums").val()) >= parseInt($("#goodsNum").val()) ){
            if($("#updatecontainer select[name=relationId]").val()!=""){
                    $.post("updatecontainer.htm?CSRFToken="+$("#csrf_token").val(),{goodsNum:$("#goodsNum").val(), containerId:$("#updatecontainer input[name=containerId]").val(),orderId:$("#updatecontainer input[name=orderId]").val(),relationId:$("#updatecontainer select[name=relationId]").val()},function(){
                        $('#changePackage').modal('hide');
                        goOrderPincking($("#updatecontainer input[name=orderId]").val(),"1");
                    });
            }
        }else{
            $("#errorInfo").text("请输入正整数，且不能大于此包裹中商品的数量!");
        }
    }else{
        $("#errorInfo").text("没有可更换的包裹,请新增装箱单!");
    }
}
var num2=0;
function changeOrder(){
    var flag = true;
    if($("#printNo2").val()!="1"){
        showTipAlert("请先打印！");
        return;
    }
    //有空白装箱单禁止装箱
    $(".border_bottom tbody").each(function(){
       if($(this).find("tr").length <= 0){
           showTipAlert("请先删除空白装箱单！");
           flag = false;
           return;
       }
    });
    if(num2==0 && flag){
        num2+=1;
        $.post("modifyorderbyparam.htm", { orderId: $("#changeOrderId").val(), orderStatus: "2", CSRFToken: $("#csrf_token").val(),token:"L" },
            function(data){
                showTipAlert("装箱成功！");
                updateOrderUpdateStateOne($('#orderIdId').val(),$('#csrf_token').val()+'','2');
                $(".btn-primary").hide();
                window.location.href="orderdeliverylist.htm?stauts='1'";
            });
    }

}

function goSendGoods(id){
    $("#printNo3").val("0");
    $("#addForm").html("");
    $.ajax({
        type: "POST",
        url: "sendgoodsorder.htm?CSRFToken=" + $("#CSRFToken").val(),
        data: { orderId: id },
        async: false,
        success: function (data) {
            $("#order_m_type").val(data.order.orderMType);
            var indexs = 0;
            var ord = '';
            var html = '';
            for (var i = 0; i < data.relations.length; i++) {
                if (data.relations[i].isGoodsInfos == '1') {
                    var name = "";
                    indexs = indexs + 1;
                    for (var j = 0; j < data.relations[i].containers.length; j++) {
                        //定义赠品
                        var presentStr = "";
                        //for(var k = 0;k<data.order.orderGoodsList.length;k++) {
                        //    var order = data.order.orderGoodsList[k];
                        //    if (order.goodsInfoId == data.relations[i].containers[j].goodsProductDetailViewVo.goodsInfoId) {
                        //        if(null!=order.isPresent && order.isPresent=="1"){
                        //            presentStr = '<span">【赠品】</span>&nbsp;';
                        //        }
                        //    }
                        //}
                        //判断是否是赠品
                        if(notNull(data.relations[i].containers[j].containerStatus)=="1"){
                            presentStr = '<span">【赠品】</span>&nbsp;';
                        }
                        name += presentStr+data.relations[i].containers[j].goodsProductDetailViewVo.goodsInfoName + "<br/>";
                    }
                    if (data.logisticsSingle == null) {
                        showTipAlert("该模板里面的物流公司没有配置单据! ");
                        return;
                    }
                    var content = data.logisticsSingle.logisticsSingleContent;
                    if (content != null) {
                        content = content.replace("收件人-姓名", notNull(data.order.shippingPerson));
                        content = content.replace("收件人-地区1级", notNull(data.order.shippingProvince));
                        content = content.replace("收件人-地区2级", notNull(data.order.shippingCity));
                        content = content.replace("收件人-地区3级", notNull(data.order.shippingCounty));
                        content = content.replace("收件人-地址", notNull(data.order.shippingAddress));
                        content = content.replace("货品名称", notNull(name));
                        content = content.replace("收件人-联系电话", notNull(data.order.shippingPhone));
                        content = content.replace("收件人-手机号码", notNull(data.order.shippingMobile));
                        content = content.replace("收件人-邮政编号", notNull(data.order.shippingPostcode));
                        content = content.replace("发件人-姓名", notNull(data.basicSet.bsetName));
                        content = content.replace("发件人-地址", notNull(data.ware.wareAddress));
                        /*content = content.replace("发件人-地区1级",'');
                         content = content.replace("发件人-地区2级",'');
                         content = content.replace("发件人-地区3级",'');*/
                        //content = content.replace("发件人-手机号码",data.basicSet.bsetPhone);
                        content = content.replace("发件人-联系电话", data.basicSet.bsetPhone);
                        content = content.replace(/express_label/g, "");
                    }
                    html = '<div class="packages">' + ord +
                    '<div class="mb20">' +
                    '<h4>包裹' + indexs + '</h4>' +
                    '<div class="form-horizontal">' +
                    '<div class="form-group">' +
                    '<label class="control-label col-sm-3">物流公司：</label>' +
                    '<div class="col-sm-1"></div>' +
                    '<div class="col-sm-6">' +
                    '<input type="hidden" name="expressId" value="' + data.order.orderExpress.expressId + '"><label class="control-label col-sm-7">' + notNull(data.order.orderExpress.expressName) + '</label>' +
                    '</div></div>' +
                    '<div class="form-group">' +
                    '<label class="control-label col-sm-3"><span style="color: #ff0000">*</span>运单号：</label>' +
                    '<div class="col-sm-1"></div>' +
                    '<div class="col-sm-10">' +
                    '<input maxlength="20" class="ihtext" minlength="6" type="text" id="iq_text' + i + '" class="form-control required" name="expressNo" onkeydown="if(event.keyCode==13)return false;" ><span style="color: #ff0000" class="span_tip"></span>' +
                    '<input value="' + data.relations[i].relationId + '" type="hidden" name="relationIds"/>' +
                    '</div></div></div><!--startprint' + (3+i) + '--><div class="mb10"><div class="express_board"><img class="express_img Noprint" alt="" src="' + data.logisticsSingle.logisticsSingleImg + '">' + notNull(content) +
                    '</div><!--endprint' + (3+i) + '--></div></div></div>';
                }


                $("#addForm").append(html);
            }
            $("#addForm").append(ordercontainerajaxFn(id));
            $("#addForm").append('<input name="orderId" class="order_id_wx" type="hidden" value="' + data.order.orderId + '"/><input type="hidden" name="token" value="L">');
            $("#outWarehouse").modal('show');
        }
        });
}


/**
 * 打印
 */
function doPrint3() {
	$("input[name=expressNo]").each(function(index,item){
		$(item).attr("value",$(item).val());
	});


    var bdhtml=window.document.body.innerHTML;

    var printHtml="";

    var prnhtml='';
    //给物流单编号赋值
    var intext=$(".ihtext");

    for (var i = 0; i < intext.length; i++) {
        var sprnstr="<!--startprint"+(3+i)+"-->";
        var eprnstr="<!--endprint"+(3+i)+"-->";
        prnhtml = bdhtml.substring(bdhtml.indexOf(sprnstr) + 18); //从开始代码向后取html
        prnhtml = prnhtml.substring(0, prnhtml.indexOf(eprnstr));//从结束代码向前取html
        printHtml = printHtml+prnhtml;
        if (i != intext.length -1)
        {
            printHtml = printHtml+'<div style="page-break-after: always;"></div>';
        }
    }
    $("input[name=printType]").val("");
    $("#printNo3").val("1");
    $("#str").val(printHtml);
    $("#printView").submit();
    //window.open("printView.htm?CSRFToken="+$("#csrf_token").val()+"&str="+prnhtml);
    //window.open($("#basePath").val()+"printorderpickinglist.htm?str="+prnhtml);
}

function subSendGoods(){
    var reg = new RegExp("^[0-9a-zA-Z]+$");
    if($("#printNo3").val()=="0"){
        showTipAlert("请先打印物流单！");
        return null;
    }
    if($("#printNo2").val()=="0"){
        showTipAlert("请先打印出库单！");
        return null;
    }
    var expressNo=document.getElementsByName("expressNo");
    var expressNos=new Array();
    for(var i =0;i<expressNo.length;i++){
        if(expressNo[i].value==""){
            showTipAlert("请填写运单号！");
            return null;
        }else if(!reg.test(expressNo[i].value)){
            showTipAlert("请填写正确的运单号！");
            return null;
        }else{
            expressNos.push(expressNo[i].value);
        }
    }
    var relationId = document.getElementsByName("relationIds");
    var relationIds=new Array();
    for(var i =0;i<relationId.length;i++){
        relationIds.push(relationId[i].value);
    }
    if($("#addForm").valid()){
    $.ajax({
        cache: true,
        type: "POST",
        url:"subsendgoodsorder.htm?CSRFToken="+$("#csrf_token").val(),
        data:$('.sub_sendGoods').serialize(),// 你的formid
        async: false,
        error: function(request) {
        },
        success: function(data) {
            if(data==1){
                showTipAlert("请注意，此行为非正常操作！！！");
                location.href="ordersendgoods.htm";
            }else{
                showTipAlert("已发货！");
                $(".btn-primary").hide();
                if($(".order_m_type").val()==2){
                    var oId=$(".order_id_wx").val();
                    var csrf=$("#CSRFToken").val();
                    $.post("sendgoodsnotify.htm?CSRFToken="+$("#csrf_token").val(), { orderId: oId,CSRFToken:csrf},
                        function(data){
                            location.href="ordersendgoods.htm";
                        });
                }else{
                    location.href="ordersendgoods.htm";
                }
            }
        }
    });
    }
}

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
 $("#detailorderCodeNo").html("订单号："+notNull(order.orderCode));
 $("#detailorderCode").html("订单编号："+notNull(order.orderCode));
 $("#detailcreateTime").html("下单时间："+timeObject(order.createTime));
 //判断状态
 if(order.orderStatus == '0'){
 if(order.orderLinePay=='1'){
 $("#detailorderStatus").html("未付款");
 }else if(order.orderLinePay=='0'){
 $("#detailorderStatus").html("待发货");
 }
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