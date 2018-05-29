$(function() {
	win();
	$(window).resize(function() {
		win();
	});
});
//图片路径
var img_src=$("#customer_imgs").attr("src");

/**
 *  修改头像
 */
$(function (){
			//选择上传文件后触发
			$(".upload_file").change(function() {
				if($(this).val()!=""){
					var customerId = $(this).attr("customer_id");
					$("#upload_form"+customerId).submit();
                    alert($("#customer_imgs").attr());
					$("#customer_imgs").attr("src","../images/load.jpg");
				}
			});
});


/**
 * 上传文件成功后，触发。
 * @param msg
 */
function callback(msg) {  
	//上传失败
	if(msg.split(",").length<2) {
		if(msg=='101') {
			$("#titleerr").text("每张图片不超过4M，请检查后重新上传!");
			dia(4);
			$("#customer_imgs").attr("src",img_src);
		} else if(msg=='102') {
			$("#titleerr").text("图片格式不正确，请检查后重新上传!");
			dia(4);
			$("#customer_imgs").attr("src",img_src);
		}
	}else{
        $("#titleerr").text("您的头像已上传成功，审核完毕后将会展示。");
        dia(4);
	}


} 

function win() {
	var _wd = $(window).width();
	var _hd = $(window).height();
	$(".s_dia").css("top", (_hd - $(".dialog").height()) / 2).css("left",
			(_wd - $(".s_dia").width()) / 2);

};

function dia(n) {
	$(".mask").fadeIn();
	$(".dia" + n).fadeIn();
};

function cls() {
	$(".dialog").fadeOut();
	$(".mask").fadeOut();
};