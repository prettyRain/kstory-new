$(function() {
	//验证码绑定onclick事件
	$("#checkCodeA").click(
		function(){
			$("#checkCodeImg").click();
		}
	);
	/*$("#code").focus(function(){
		$(this).parent().find(".patchca_tips").show().html("请输入验证码").css("color","#dd6330");
		getPatcha();
	});*/

	$("#code").blur(function(){
		//$(this).parent().find(".patchca_tips").hide().html("验证码错误").css("color","#dd6330");
	});
	$("#code").on("channgeproperty input",isbtn).focus(function(){
        $(this).css("border-color","#dddddd").parent().find(".patchca_tips").hide();
	})
	function isbtn(){
		var flag = true;
        $(".fl input[type='text']").each(function(){
        	if(!$(this).val()){
        		flag = false;
			}
		})
        $(".fl input[type='password']").each(function(){
            if(!$(this).val()){
                flag = false;
            }
        })
		if(flag){
        	$('.n_nextstep').attr("disabled",false).css("backgroundColor","#0d9901");
		}else{
            $('.n_nextstep').attr("disabled",true).css("backgroundColor","#999999");
		}
	}
	$("#username").focus(function(){
		//$(this).parent().find(".ne_tips").show().html("请输入用户名").css("color","#dd6330");
        $(this).css("border-color","#dddddd").parent().find(".ne_tips").hide();
	}).on("channgeproperty input",isbtn);

	$("#username").blur(function(){
		//$(this).parent().find(".ne_tips").hide().html("验证中,请稍后...").css("color","#dd6330");
	});

	$("#checkCode").on("input channgeproperty",isbtn).focus(function(){
            $(this).css("border-color","#dddddd").parent().find(".ne_tips").hide();
	})
	$("#mcode").on("input channgeproperty",isbtn).focus(
        function(){
            $(this).css("border-color","#dddddd").parent().find(".ne_tips").hide();
        })
	$("#npwd").on("input channgeproperty",isbtn).focus(function(){
		$(this).css("border-color","#dddddd").next().hide();
	});
    $("#repwd").on("input channgeproperty",isbtn).focus(function(){
        $(this).css("border-color","#dddddd").next().hide();
    });
});

function checkNewPwd(){
	var x=$("#npwd").val();

	if(x.length < 6 || x.length > 16){
        $("#npwd").css("border-color","#c33");
		$(".npwd_tip").show().html('<img src="/images/ero.png">&nbsp;&nbsp;密码为6-16位字母加数字的组合，不得含特殊字符').css("color","#c33");
		return false;
	}
    if(!(/^(([A-Za-z]+[0-9]+)|([0-9]+[A-Za-z]+))[A-Za-z0-9]*$/).test(x)){
        $("#npwd").css("border-color","#c33");
        $(".npwd_tip").show().html('<img src="/images/ero.png">&nbsp;&nbsp;密码为6-16位字母加数字的组合，不得含特殊字符').css("color","#c33");
        return false;
    }
	$(".npwd_tip").hide().html("请输入登录密码").css("color","#c33");
	return true;
}
function checkRePwd(){
	var x = $("#npwd").val();
	var y = $("#repwd").val();
	if($("#npwd").val().trim().length == 0 && $("#repwd").val().trim().length == 0 ){
		$(".repwd_tip").show().html("请输入登录密码!").css("color","#css");
		return false;
	}
	if(x != y){
        $("#repwd").css("border-color","#c33");
		$(".repwd_tip").show().html('<img src="/images/ero.png">&nbsp;&nbsp;您两次输入的密码不相同!').css("color","#c33");
		return false;
	}
	$(".repwd_tip").hide().html("请输入登录密码").css("color","#c33");
	return true;
}

//判断密码是否是数字加字母组合
function checkPass(obj) {
    var is = 0;
    if(obj.match(/([0-9])+/)) {
        is++;
    }
    if(obj.match(/([a-z])+/)) {
        is++;
    }
    if(obj.match(/([A-Z])+/)) {
        is++;
    }
    if(obj.match(/[^a-zA-Z0-9]+/)) {
        is++;
    }
    return is;
}

//找回密码第一步
function gofindcode(){
	if($("#username").val().trim().length == 0){
		$("#username").parent().find(".uesrname_tips").show().html('<img src="/images/ero.png" alt="">&nbsp;请输入用户名').css("color","#c33");
		return;
	}
    //验证码
    var enterValue = $("#code").val();
    $("#enterValue").val(enterValue);
    $.ajax({
        url: "checkpatchca.htm?enterValue="+enterValue,
        context: document.body,
        success: function(data){
            if(enterValue != ''){
                if(data==0){
                    $("#code").css("border-color","#c33");
                    $(".patchca_tips").show().css("color","#c33");
                    $(".patchca_tips").html('<img src="/images/ero.png" alt="">&nbsp;&nbsp;验证码错误');
                    /*如果失败则更新验证码*/
                    $("#checkCodeImg").click();
                    return false
                }else{
                    var datas = "&username=" + $("#username").val()+"&enterValue=" + enterValue;
                    jQuery.ajax({
                        type : "get",
                        url : "checkusernameflag.htm",
                        data : datas,
                        timeout : 10000,
                        success : function(html) {
                            if (html == 1) {
                                $(".uesrname_tips").hide();
                                //location.href="validuser.html";
                                $("#enterValueForm").submit();
                            }else if(html == 2){
                                $("#code").css("border-color","#c33");
                                $(".patchca_tips").show().css("color","#c33");
                                $(".patchca_tips").html('<img src="/images/ero.png" alt="">&nbsp;&nbsp;验证码错误');
                                /*如果失败则更新验证码*/
                                $("#checkCodeImg").click();
                                return false
                            }else{
                                $("#username").css("border-color","#c33");
                                $(".uesrname_tips").show().html('<img src="/images/ero.png" alt="">&nbsp;&nbsp;用户名不存在!').css("color","#c33");
                                $("#checkCodeImg").click();
                            }
                        },
                        error:function(){

                        }
                    });
                }
            }else{
                $("#code").css("border-color","#c33");
                $(".patchca_tips").show().css("color","#dd6330");
                $(".patchca_tips").html("请输入验证码");
            }
        }
    });
}


//找回密码第二步（发送邮件）
function sendEmail(){
    //验证码
    var enterValue = $("#code").val();
    $.ajax({
        url: "checkpatchca.htm?enterValue="+enterValue,
        context: document.body,
        success: function(data){
            if(data==0){
                $("#code").css("border-color","#c33");
                $(".patchca_tips").show().css("color","#c33");
                $(".patchca_tips").html('<img src="/images/ero.png">&nbsp;&nbsp;验证码错误');
                /*如果失败则更新验证码*/
                $("#checkCodeImg").click();
                return false
            }else{
                $.ajax({
                    type: 'post',
                    url:'newsendeamil.htm',
                    //data:datas,
                    async:true,
                    success: function(obj) {
                        if(obj==1) {
                            location.href="sendsuccess.html";
                        }else{
                            $(".info1").text("提示");
                            $(".info2").text("验证邮箱失败，请稍后再试！");
                            dia(2);
                        }
                    },
                    error : function() {
                        $(".info1").text("提示");
                        $(".info2").text("验证邮箱失败，请稍后再试！");
                        dia(2);
                    }
                });
            }
        }
    });
}

//找回密码第三步（重置密码）
function updatePwd(){
    $("#resetpwd_btn").addClass("loading").removeClass("n_nextstep").html("");
	var flag = true;
	if(! checkNewPwd()){
		flag =false;
        $("#resetpwd_btn").removeClass("loading").addClass("n_nextstep").html("提交");
		return;
	}
	if(! checkRePwd()){
        $("#resetpwd_btn").removeClass("loading").addClass("n_nextstep").html("提交");
		flag =false;
	}
	if(!flag){
		return;
	}

	var datas = "1=1";
	datas += "&customerPassword=" + $("#npwd").val();
	//datas += "&customerId=" + $("#hi_id").val();
	jQuery.ajax({
		type : "post",
		url : "setpwd.htm",
		data : datas,
		timeout : 10000,
		success : function(html) {
			if (html == 1) {
				location.href="updatesucess.html";
			} else if(html == 4){
                $("#resetpwd_btn").html("提交").removeClass("loading").addClass("n_nextstep");
                location.href="validuser.html";
            } else{
				dia(2);
			}
		},
		error:function(){
			dia(2);
		}
	});
}

//加入收藏
function sdia(dname) {
    $(".bh-mask").fadeIn();
    $("#"+dname).fadeIn();
};
function scls(t) {
    $(".bh-mask").fadeOut();
    $(t).parents(".bh-dialog").fadeOut();
};

//加入收藏
function addToFavorite(siteName){
	try {
		window.external.AddFavorite($("#basePath").val(),siteName);
    } catch (e) {
        try {
            window.sidebar.addPanel($("#basePath").val(), siteName, "");
        } catch (e) {
            $(".collect_tip_cancel").click(function(){
            	cls();
            });
            sdia('ctDia');
        }
    }
}

/**
 * 购物车
 */
$(function(){
$(".cartit").live("mouseover",minicartonload);
$("#delect_minicart").live("click", function(){
		var emp1 = $(this).next().val();
		var emp2 = $(this).next().next().val();
		$.ajax({ url: "../delshoppingcartbyid.htm?shoppingCartId="+emp1+"&goodsInfoId="+emp2,async:false, success: function(dats){
			if(dats == 1){
				minicartonload();
			}
		}});
	});
	//预加载mini购物车
	minicartonload();

});


function minicartonload(){
	$.ajaxSetup({ cache: false });
	$.ajax({ url: "../minisscart.htm",type:"post",  async:false ,success: function(datee){
  		var cartgoods = datee.shopcart.miniGoodsList;
  		//alert("cartgoods"+cartgoods);
  		var cust= datee.cust;
  		//alert("cust"+cust);
  		if(cust!=null){
  			$(".cart_empty").html("<p style='height:35px;'>您的购物车是空的<br /></p>");
  		}
  		var empvalue = 0;
		//设置我的购物车显示购物车商品数量
  		if(cartgoods != null){
			$(".sc_num em").html(cartgoods.length);
		}else{
			$(".sc_num em").html("0");
		}

        //比如一件商品买了3件,详细统计购买商品数量
        var countgoods=0;
		//购物车中有商品
		if(cartgoods != null && cartgoods.length>0){
			$(".cart_empty").addClass("none");
			$(".cart_cont").removeClass("none");
			//mini购物车头部
			//循环输出购物车中的商品
			$(".mcBoxList").html("");
			for(var i = 0 ; i < cartgoods.length ; i++){
                countgoods+=cartgoods[i].buNum;
				var cartgood=' <div class="mcOrder clearfix">'+

                           ' <div class="mcItem">'+
                           	'<a  href="item/'+cartgoods[i].goodsInfoId+'" class="img">'+
                                    '<div class="table-cell">'+
                                     '   <i></i><img src="'+cartgoods[i].productPic+'" alt="">'+
                                  '  </div>'+
                               ' </a>'+
                            '</div>'+
                            '<div class="mcSqe">'+
                                '<p><a  href="item/'+cartgoods[i].goodsInfoId+'">'+cartgoods[i].productName+'</a></p>'+
                            '</div>'+
                           ' <div class="mcAmount" style="position:relative;left:30px;">'+
                                //'<span class="minus"></span>'+
                                '<span class="amount">'+cartgoods[i].buNum+'</span>'+
                                //'<span class="plus"></span>'+
                            '</div>'+
                            '<div class="mcCost">'+
                                '<a href="" class="del"  id = "delect_minicart">删除</a>'+
                                	"<input type= 'hidden' class= 'goodsid' value = '"+cartgoods[i].shoppingCartId+"'>"+
                                "<input type= 'hidden' class= 'goodsinfo' value = '"+cartgoods[i].goodsInfoId+"'>"+
                                '<span class="mcPrice">&yen;'+cartgoods[i].productPrice+'<em style="color:#666">×'+cartgoods[i].buNum+'</em></span>'+
                           ' </div>'+
                        '</div>';


				$(".mcBoxList").append(cartgood);
				$(".mcOrder").each(function(){
			        var $this = $(this);
			        $this.mouseover(function(){
			            $this.find(".minus, .plus").css("visibility","visible");
			            $this.find(".del").show();
			        }).mouseout(function(){
			            $this.find(".minus, .plus").css("visibility","hidden");
			            $this.find(".del").hide();
			        });
			    });
				//计算总价格
				empvalue =accAdd(empvalue,accMul(cartgoods[i].productPrice,cartgoods[i].buNum));
			}
			//设置mini购物车底部
			$(".mcNumTotal").text(countgoods);
			$(".mcNumChecked").text(countgoods);
			$(".cartNum").text(countgoods);
			$(".mcTotalFee").text(empvalue);
				$(".emCartBox").hide();
		}else{
			$(".emCartBox").show();
		}
	}});
};


//获取手机验证码
function getCode(){

	/*if(! checkMobile()){
		return;
	}
	var mobile = $("#mobile").val();
	var datas = "moblie=" + mobile;*/
	if($('#sendCode').attr("disabled")=="disabled"){
	    return;
    }

	$.ajax({
        type: 'get',
        url:'sendcodefindpwd.htm?checkCode='+$("#checkCode").val(),
        //data:datas,
        async:true,
        success: function(data) {
        	if(data==1) {
        	    $("#mcode").css("border-color","#dddddd");
                $(".mcode_tip").hide();
				$(".ju_s").text(59);
				$("#code_tip").show();
                $("#code_tip").html('校验码已发出，请注意查收短信，如果没有收到，你可以在<span class="ju_s">60</span>秒后要求系统重新发送');
				setTimeout(countDown, 1000);
				$("#mcode").removeAttr("disabled");
				$(".sub_btn").removeAttr("disabled");
				$("#mobile").attr("disabled","disabled");
				$("#sendCode").attr("disabled","disabled");

			}else if(data==0){
				//网络异常
                $("#mcode").css("border-color","#dddddd");
				$(".mcode_tip").html('发送验证码失败,请稍后重试').show().css("color","#666666");
				dia(3);
				$("#sendMobileCode").removeAttr("disabled");
			}else if(data==-1){
                $("#mcode").css("border-color","#dddddd");
                $(".mcode_tip").hide();
				$("#code_tip").hide();
				$(".ju_s").text(59);
				if($(".ju_s").text()==59){
					$(".resend").text("");
					$("#code_tip").find(".resend").remove();
					$("#code_tip").find("br").remove();
					$("#code_tip").html("<span class='resend'>60秒内只能获取一次验证码,请稍后重试</span>").show();
					$(".checkCode_tip").hide();
				}else{
					$(".resend").text("");
					$("#code_tip").find(".resend").remove();
					$("#code_tip").find("br").remove();
					$("#code_tip").append("<span class='resend'>60秒内只能获取一次验证码,请稍后重试</span>").show();
				}

			}else if(data==-4){
				$("#checkCodeImg").click();
                $("#checkCode").css("border-color","#c33");
				$(".checkCode_tip").show().html('<img src="/images/ero.png">&nbsp;&nbsp;验证码有误').css("color","#c33");
			}
        },
        error : function() {
        	//网络异常
			$("#submitCode").removeAttr("disabled");
			dia(2);
    	}
    });

	function countDown(){
		var time = $(".ju_s").text();
		$(".ju_s").text(time - 1);
		if (time == 1) {
			$("#code_tip").hide();
			$("#sendCode").removeAttr("disabled");
			$("#mobile").removeAttr("disabled");
		} else {
			setTimeout(countDown, 1000);
		}
	}
}

//找回密码第二步 （发送短信）
function tofindpwd(type){
	if(!checkCurrentCodefindcode()){
		return;
	}
	if(checkMCodefindcode()){
		$("#resetpwdForm").submit();
	}
}

function checkMCodefindcode(){
	var checkCode = $("#mcode").val();

	if(checkCode == ""){
        $("#mcode").css("border-color","#c33");
		$(".mcode_tip").show().css("color","#dd6330");
		$(".mcode_tip").html("请输入短信验证码");
		return false;
	}
    var res=1;
    $.ajax({
        url: "/validate/getMCodeFindPwd.htm?code="+checkCode,
        context: document.body,
        async:false,
        success: function(data){
            res=data;
        }});
    if(res == 1){
        $("#mcode").css("border-color","#c33");
        $(".mcode_tip").hide().css("color","#c33");
        $(".mcode_tip").html('<img src="/images/ero.png">&nbsp;&nbsp;请输入短信验证码');
        return true;
    }else if(res == -1){
        $("#mcode").css("border-color","#c33");
        $(".mcode_tip").show();
        $(".mcode_tip").html('<img src="/images/ero.png">&nbsp;&nbsp;短信验证码已经失效').css("color","#c33");
        return false;
    }else if(res == 0){
        $("#mcode").css("border-color","#c33");
        $(".mcode_tip").show();
        $(".mcode_tip").html('<img src="/images/ero.png">&nbsp;&nbsp;短信验证码错误').css("color","#c33");
        return false;
    }
}

function checkCurrentCodefindcode(){
    var flag = true;
    var checkCode = $("#checkCode").val();
    if(checkCode == ''||checkCode==null){
        $(".checkCode_tip").show().html('<img src="/images/ero.png">&nbsp;&nbsp;请输入验证码').css("color","#c33");
        $("#checkCode").css("border-color","#c33");
        //$(".code_tip").html("请输入验证码").css("color","#dd6330");
        return false;
    }else{
        $.ajax({
            url: "/checkpatchca.htm?enterValue=" + checkCode, async: false, success: function (data) {
                if (data == 0) {
                    $(".checkCode_tip").show().html('<img src="/images/ero.png">&nbsp;&nbsp;验证码错误').css("color","#c33");
                    $("#checkCode").css("border-color","#c33");
                    //$(".code_tip").html("验证码错误").css("color", "#dd6330");
					/*如果失败则更新验证码*/
                    $("#checkCodeImg").click();
                    flag = false;
                }
            }
        });
        return flag;

    }
}

