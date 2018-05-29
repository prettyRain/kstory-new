/*点击修改页码的时候触发*/
$(".changePages").click(function ()
{
    /*设置页码为点击的自定义属性pages,并提交查询表单*/
    $(".pageNo").val($(this).attr("pages"));
    $("#searchForm").submit();
});

$.ajax({
    type : 'get',
    url : $("#basePath").val()+'/myshoppingmcartNum.htm',
    async : false,
    success : function(data) {
    	if(data == 0){
            $("#cartNum").hide();
		}else{
    		if(data>99){
                $("#cartNum").html("99+").width("25px");
			}else{
                $("#cartNum").html(data).width("20px");
			}

		}


    }
});

/*点击排序按钮操作*/
$(".change_sort").click(function(){
	var sort = $(".list_sort");
	if(sort.val()==""){
		sort.val($(this).attr("val"));
	}else if($(this).attr("val")=="2D"){
		if(sort.val()=="2D"){
			sort.val("2D");
		}else{
			sort.val($(this).attr("val"));
		}
	}/*else if($(this).attr("val")=="22D"){
		if(sort.val()=="22D"){
			sort.val("2D");
		}else{
			sort.val($(this).attr("val"));
		}
	}*/else if($(this).attr("val")=="1D"){
		if(sort.val()=="1D"){
			sort.val("11D");
		}else{
			sort.val($(this).attr("val"));
		}
	}else if($(this).attr("val")=="11D"){
		if(sort.val()=="11D"){
			sort.val("1D");
		}else{
			sort.val($(this).attr("val"));
		}
	}else if($(this).attr("val")==""){
			sort.val("");
	}else if($(this).attr("val")=="5D"){
		sort.val("5D");
	}else if($(this).attr("val")=="4D"){
		if(sort.val()=="4D"){
			sort.val("44D");
		}else{
			sort.val($(this).attr("val"));
		}
	}else if($(this).attr("val")=="44D"){
		if(sort.val()=="44D"){
			sort.val("4D");
		}else{
			sort.val($(this).attr("val"));
		}
	}
	/*提交表单*/
	$(".pageNo").val("1");
	$("#searchForm").submit();
});

function addCart(goodsInfoId,tip,ele,fn) {

    $.ajax({
        url: $("#basePath").val()+"/addproducttoshopcarnew.htm?goodsNum=1&productId=" + goodsInfoId + "&distinctId="+ $(".ch_distinctId").val() +"&mark=0",
        type: "post",
		async:false,
        success: function (data) {
            if (data > 0) {
            	fn&&fn(ele,event);
                $.ajax({
                    type : 'get',
                    url : $("#basePath").val()+'/myshoppingmcartNum.htm',
                    async : false,
                    success : function(data) {
                        if(data > 0){

                            setTimeout(function () {
                            	if(data>99){
                                    data = "99+";
                                    $("#cartNum").css("width","25px");
								}else{
                                    $("#cartNum").css("width","20px");
								}
                                $("#cartNum").html(data);
                                $("#cartNum").show();
                            },700)
                        }
                    }
                });
                return true;
            }else if (data == -1) {
                tip("购物车商品种类已达20件上限");
                return false;
            }else if(data == -5){
            	tip("库存不足");
            	return false;
			} else if(data == -3){
                tip("货品已下架");
                return false;
			}else {
                tip("加入购物车失败");
                return false;
            }
        }
    });
}