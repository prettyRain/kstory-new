<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>礼品卡资金</title>

    <!-- Bootstrap -->
    <link href="<%=basePath %>css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=basePath %>css/font-awesome.min.css">
    <link href="<%=basePath %>iconfont/iconfont.css" rel="stylesheet">
    <link href="<%=basePath %>css/summernote.css" rel="stylesheet">
    <link href="<%=basePath %>css/bootstrap-select.min.css" rel="stylesheet">
    <link href="<%=basePath %>css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <link href="<%=basePath %>css/style.css" rel="stylesheet">
    <link href="<%=basePath %>css/style_new.css" rel="stylesheet">
    <link href="<%=basePath %>css/paystyle.css" rel="stylesheet">
    <link href="<%=basePath %>css/paystyle_new.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<!-- 引用头 -->
<jsp:include page="../page/header.jsp"></jsp:include>
<div class="page_body container-fluid">
    <div class="row">
        <jsp:include page="../page/left.jsp"></jsp:include>
        <div class="col-lg-20 col-md-19 col-sm-18 main">
            <jsp:include page="../page/left2.jsp"></jsp:include>
            <div class="main_cont">
                <jsp:include page="../page/breadcrumbs.jsp"></jsp:include>
                <h2 class="main_title">${pageNameChild}</h2>
                <%--<div class="data_overview row">
                    <div class="col-md-8">
                        <div class="data_overview_box">
                            <h4>礼品卡账户总额</h4>
                            <p class="number"></p>
                            <p class="unit">(单位：元)</p>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="data_overview_box">
                            <h4>余额</h4>
                            <p class="number red"></p>
                            <p class="unit">(单位：元)</p>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="data_overview_box">
                            <h4>冻结预总额</h4>
                            <p class="number"></p>
                            <p class="unit">(单位：元)</p>
                        </div>
                    </div>
                </div>--%>
                <div class="common_data p20">
                    <div class="filter_area mb10">
                        <form role="form" class="form-inline" action="initGiftcardInfoList.htm?CSRFToken=${token }" id="searchForm">
                            <input type="hidden" value="searchForm" id="formId">
                            <input type="hidden" value="${pageBean.url}" id="formName">
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">用户名</span>
                                    <input type="text" class="form-control" id="customerUsername" name="customerUsername" value="${pageBean.objectBean.customerUsername}">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">礼品卡卡号</span>
                                    <input type="text" class="form-control" id="giftcardNo" name="giftcardNo" value="${pageBean.objectBean.giftcardNo}">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">礼品卡状态</span>
                                    <select class="form-control cate_selector" id="activeFlag" name="activeFlag">
                                        <option value="" <c:if test="${empty pageBean.objectBean.activeFlag }">selected="selected"</c:if>>选择状态</option>
                                        <option value="-2" <c:if test="${not empty pageBean.objectBean.activeFlag && pageBean.objectBean.activeFlag==-2 }">selected="selected"</c:if>>已挂失</option>
                                        <option value="-1" <c:if test="${not empty pageBean.objectBean.activeFlag && pageBean.objectBean.activeFlag==-1 }">selected="selected"</c:if>>无效</option>
                                        <option value="0" <c:if test="${not empty pageBean.objectBean.activeFlag && pageBean.objectBean.activeFlag==0 }">selected="selected"</c:if>>未激活</option>
                                        <option value="1" <c:if test="${not empty pageBean.objectBean.activeFlag && pageBean.objectBean.activeFlag==1 }">selected="selected"</c:if>>已激活</option>
                                        <option value="2" <c:if test="${not empty pageBean.objectBean.activeFlag && pageBean.objectBean.activeFlag==2 }">selected="selected"</c:if>>已失效</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <button type="submit" class="btn btn-primary">搜索</button>
                            </div>
                        </form>
                    </div>
                    <table class="table table-striped table-hover">
                        <thead>
                        <tr>
                            <th>礼品卡号</th>
                            <th>状态</th>
                            <th>礼品卡余额</th>
                            <th>可用余额</th>
                            <th>冻结总额</th>
                            <th>绑定信息</th>
                            <th width="150">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:if test="${fn:length(pageBean.list)<=0}">
                            <tr>
                                <td style="text-align: center;" colspan="7">暂无数据</td>
                            </tr>
                        </c:if>
                        <c:forEach items="${pageBean.list}" var="giftcard" varStatus="i">
                            <tr>
                                <td>
                                    ${giftcard.giftcardNo}
                                </td>
                                <td>
                                    <c:if test="${giftcard.activeFlag ==-1}">无效</c:if>
                                    <c:if test="${giftcard.activeFlag ==-2}">已挂失</c:if>
                                    <c:if test="${giftcard.activeFlag ==0}">未激活</c:if>
                                    <c:if test="${giftcard.activeFlag ==1}">已激活</c:if>
                                    <c:if test="${giftcard.activeFlag ==2}">已失效</c:if>
                                </td>
                                <td><c:if test="${empty giftcard.customerUsername}">&yen;${giftcard.giftcardPrice}</c:if>
                                    <c:if test="${not empty giftcard.customerUsername}">
                                        &yen;<c:if test="${giftcard.totalDeposit ==0 or giftcard.totalDeposit == null}">0.00</c:if>${giftcard.totalDeposit}</td>
                                    </c:if>
                                <td><c:if test="${empty giftcard.customerUsername}">---</c:if>
                                    <c:if test="${not empty giftcard.customerUsername}">
                                        &yen;<c:if test="${giftcard.preDeposit ==0 or giftcard.preDeposit == null}">0.00</c:if>${giftcard.preDeposit}
                                    </c:if>
                                </td>
                                <td><c:if test="${empty giftcard.customerUsername}">---</c:if>
                                    <c:if test="${not empty giftcard.customerUsername}">
                                        &yen;<c:if test="${giftcard.freezePreDeposit ==0 or giftcard.freezePreDeposit == null}">0.00</c:if>${giftcard.freezePreDeposit}
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${empty giftcard.customerUsername}">未绑定</c:if>
                                    <c:if test="${not empty giftcard.customerUsername}">
                                        ${giftcard.customerUsername}
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${empty giftcard.customerUsername && giftcard.activeFlag !=1 && giftcard.activeFlag !=0 }">---</c:if>
                                    <c:if test="${not empty giftcard.customerUsername}">
                                        <a href="javascript:;" onclick="openProduct(${giftcard.customerId})" class="scan_member">查看</a>
                                    <c:if test="${giftcard.activeFlag > -2}">
                                        <a href="javascript:;" onclick="rechargeGiftcard('${giftcard.customerId}','${giftcard.customerUsername}','${giftcard.giftcardNo}')">充值</a>
                                        <a href="javascript:;" onclick="guaShiGiftcard('${giftcard.customerId}','${giftcard.giftcardNo}')">挂失</a>
                                    </c:if>
                                    </c:if>
                                    <c:if test="${giftcard.activeFlag ==1}"><a href="javascript:;" onclick="bindingGiftcard('${giftcard.giftcardNo}')">绑定</a></c:if>
                                    <c:if test="${giftcard.activeFlag ==0}"><a href="javascript:;" onclick="activeGiftcard('${giftcard.giftcardNo}')">激活</a></c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <c:import url="../page/searchPag.jsp">
                        <c:param name="pageBean" value="${pageBean }"/>
                        <c:param name="path" value="../"></c:param>
                    </c:import>
                </div>
                <form method="post" id="openDepositCustomerForm" action="selectDepositInfoById.htm">
                    <input type="hidden" name="pageNos" value="${pageBean.pageNo}"/>
                    <input name="customerId" value="" type="hidden"/>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="verifylogin"  role="dialog">
    <input type="hidden" id="form_name" />
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">验证身份</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="control-label col-sm-5">请输入登录密码：</label>
                        <div class="col-sm-1"></div>
                        <div class="col-sm-10">
                            <input type="password" class="form-control required" name="userkey" id="pwd" onkeydown="if(event.keyCode==13)return false;"/>
                            <label class="pwdtip"></label>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="verifylogin();">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="guaShiModal"  role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">操作提示</h4>
            </div>
            <div class="modal-body">
                <input type="hidden" id="gueShiCustomerId">
                <p>挂失卡号为：<span id="gueShiNo"></span></p>
                <div class="alert alert-danger" role="alert">
                    <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                    <span class="sr-only">Error:</span>
                    真的要挂失该礼品卡吗？<br>
                    挂失后该会员礼品卡账户将不能再正常使用，礼品卡剩余金额转至冻结状态！
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="confirmGuaShi();">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<%--激活--%>
<div class="modal fade" id="activeModal"  role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">操作提示</h4>
            </div>
            <div class="modal-body">
                <p>激活卡号为：<span id="activeNo"></span></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="confirmActive();">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="rechargeModal"  role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">礼品卡充值</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="rechargeForm">
                    <div class="alert alert-danger hide" id="rechargeMsg" role="alert" style="margin-bottom: 0px;">
                        <span class="glyphicon glyphicon-info-sign"></span>&nbsp;<strong></strong>
                    </div>
                    <input type="hidden" name="CSRFToken" id="CSRFToken" value="${token }" />
                    <input type="hidden" id="rechargeCustomerId">
                    <div class="form-group">
                        <label class="control-label col-sm-5">充值用户：</label>
                        <div class="col-sm-1"></div>
                        <div class="col-sm-10">
                            <p class="form-control-static rechargeCustomer">email@example.com</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-5">充值卡号：</label>
                        <div class="col-sm-1"></div>
                        <div class="col-sm-10">
                            <p class="form-control-static rechargeNo">email@example.com</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-5 required"><span class="text-danger">*</span>充值金额（&yen;）：</label>
                        <div class="col-sm-1"></div>
                        <div class="col-sm-10">
                                <input type="text" class="form-control required number" id="recharge_price" placeholder="请输入充值金额" onkeyup="value=value.replace(/\.\d{2,}$/,value.substr(value.indexOf('.'),3))">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-5 required"><span class="text-danger">*</span>支付方式：</label>
                        <div class="col-sm-1"></div>
                        <div class="col-sm-10">
                            <select class="form-control required" id="recharge_pay">
                                <option value="">请选择支付方式</option>
                                <option value="4">线下现金</option>
                                <option value="5">线下刷卡</option>
                                <option value="6">线下支付宝</option>
                                <option value="7">线下微信</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="rechargeBtn()">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="bindingModal"  role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">礼品卡绑定</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="bindingForm">
                    <div class="alert alert-danger hide" id="bindingMsg" role="alert" style="margin-bottom: 0px;">
                        <span class="glyphicon glyphicon-info-sign"></span>&nbsp;<strong></strong>
                    </div>
                    <input type="hidden" id="bindingNo" name="">
                    <div class="form-group">
                        <label class="control-label col-sm-5">礼品卡卡号：</label>
                        <div class="col-sm-1"></div>
                        <div class="col-sm-10">
                            <p class="form-control-static bindingNo">email@example.com</p>
                        </div>
                    </div>
                    <div class="form-group" id="binding_pwd">
                        <label class="control-label col-sm-5"><span class="text-danger">*</span>礼品卡密码：</label>
                        <div class="col-sm-1"></div>
                        <div class="col-sm-10">
                            <input type="text" class="form-control required" name="gcpwd" id="gcPwd" placeholder="请输入礼品卡密码">
                        </div>
                        &nbsp;&nbsp;<button type="button" class="btn btn-default validaPwd" onclick="validaPwd()"><span class="glyphicon glyphicon-zoom-in"></span>验证礼品卡密码</button>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-5"><span class="text-danger">*</span>会员手机号：</label>
                        <div class="col-sm-1"></div>
                        <div class="col-sm-10">
                            <input type="text" class="form-control required" name="mobile" id="bindingMob" placeholder="请输入会员手机号" maxlength="11">
                            <p class="hide SMSMsg">验证码已发送至会员手机，请注意查收短信！</p>
                        </div>
                        &nbsp;&nbsp;<button type="button" class="btn btn-default sendSMS" onclick="sendSMS()"><span class="glyphicon glyphicon-phone"></span>获取短信验证码</button>

                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-5 required"><span class="text-danger">*</span>短信验证码：</label>
                        <div class="col-sm-1"></div>
                        <div class="col-sm-10">
                            <input type="text" class="form-control required" name="smscode" id="smscode" placeholder="请输入短信验证码">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-5 required"><span class="text-danger">*</span>设置交易密码：</label>
                        <div class="col-sm-1"></div>
                        <div class="col-sm-10">
                            <input type="text" class="form-control required" name="pwd" id="paypwd" placeholder="请设置会员交易密码" maxlength="16">
                            支付密码必须是6-16位数字或字母或符号
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-5 required"><span class="text-danger">*</span>再次输入交易密码：</label>
                        <div class="col-sm-1"></div>
                        <div class="col-sm-10">
                            <input type="text" class="form-control required" name="repwd" id="repaypwd" placeholder="请再次输入会员交易密码" maxlength="16">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="bindingBtn()">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<script src="<%=basePath %>js/bootstrap.min.js"></script>
<script>

    $(function () {
        $('.sub_menu dt').click(function(){
            var theIndex = $(this).parent().index('.sub_menu dl');
            $('.sub_menu dl:not('+theIndex+') dd').slideUp('fast');
            if($(this).next().is(':visible')){
                $(this).next().slideUp('fast');
            }
            else{
                $(this).next().slideDown('fast');
            }

        });
    });
    function openProduct(customerId){
        $("#openDepositCustomerForm").find("input[name='customerId']").val(customerId);
        $("#openDepositCustomerForm").submit();
    }

    function rechargeGiftcard(customerId,customerUsername,giftcardNo){
        $("#verifylogin").modal("show");
        $("#form_name").val("rechargeModal");
        $("#rechargeForm")[0].reset();
        $("#rechargeForm input").removeClass("error");
        $("#rechargeForm label[class='error']").remove();
        $("#rechargeCustomerId").val(customerId);
        $('.rechargeCustomer').html(customerUsername);
        $('.rechargeNo').html(giftcardNo);
        $("#rechargeMsg").addClass("hide");
    }

    function rechargeBtn() {

        if($("#rechargeForm").valid()){
            $.ajax({
                url: "/saveRechargeGiftcard.htm",
                async: false,
                type: 'POST',
                data: {customerId: $('#rechargeCustomerId').val(), price: $("#recharge_price").val(),payId: $("#recharge_pay").val()},
                success: function (data) {
                    if(data == 1){
                        alert("充值成功！");
                        setTimeout(function() {window.location.href = location; },2000)
                    }else{
                        $("#rechargeMsg").removeClass("hide");
                        $("#rechargeMsg strong").html("充值失败，请稍后重试！");
                    }
                }
            });
        }

    }

    function bindingBtn(){
        if($("#bindingForm").valid()){
            var mobile = $("#bindingMob").val();
            var paypwd = $("#paypwd").val();
            var repaypwd = $("#repaypwd").val();
            if(paypwd != repaypwd){
                $("#bindingMsg").removeClass("hide");
                $("#bindingMsg strong").html("两次支付密码不一致，请检查后重新输入！");
                return;
            }
            $.ajax({
                url: "/saveBindingGift.htm",
                async: false,
                type: 'POST',
                data: {gcNo: $('#bindingNo').val(), gcPwd: $("#gcPwd").val(),mobile:mobile,smscode:$("#smscode").val(),pwd:paypwd},
                success: function (data) {
                    if(data == -1){
                        $("#bindingMsg").removeClass("hide");
                        $("#bindingMsg strong").html("没有匹配到相应的礼品卡，请检查后重新验证！");
                    }else if(data == -2){
                        $("#bindingMsg").removeClass("hide");
                        $("#bindingMsg strong").html("该手机号尚未注册成为960会员，请先注册！");
                    }else if(data == -3){
                        $("#bindingMsg").removeClass("hide");
                        $("#bindingMsg strong").html("短信验证码错误，请检查后重新输入！");
                    }else if(data == 0){
                        $("#bindingMsg").removeClass("hide");
                        $("#bindingMsg strong").html("该会员手机号已绑定礼品卡！");
                    }else if(data == 1){
                        alert("绑定成功！");
                        setTimeout(function() {window.location.href = location; },2000)

                    }else{
                        $("#bindingMsg").removeClass("hide");
                        $("#bindingMsg strong").html("绑定失败，请稍后重试！");
                    }
                }
            });
        }
    }

    function bindingGiftcard(giftcardNo){
        if($("#binding_pwd").find(".glyphicon-ok").length > 0){
            $(".glyphicon-ok").parent().append('<button type="button" class="btn btn-default validaPwd" onclick="validaPwd()"><span class="glyphicon glyphicon-zoom-in"></span>验证礼品卡密码</button>');
            $(".glyphicon-ok").remove();
        }
        $("#verifylogin").modal("show");
        $("#form_name").val("bindingModal");
        $("#bindingForm")[0].reset();
        $("#bindingForm input").removeClass("error");
        $("#bindingForm label[class='error']").remove();
        $('.bindingNo').html(giftcardNo);
        $('#bindingNo').val(giftcardNo);
        $("#bindingMsg").addClass("hide");
    }

    var countdown = 60;
    function sendSMS() {
        if($("#binding_pwd").find(".glyphicon-ok").length == 0){
            $("#bindingMsg").removeClass("hide");
            $("#bindingMsg strong").html("请先输入礼品卡密码并进行验证！");
           return;
        }
        var mobile = $("#bindingMob").val();
        if(mobile == "" || mobile.length != 11 || !(/^0?1[3|4|5|8|7][0-9]\d{8}$/).test(mobile)){
            $("#bindingMsg").removeClass("hide");
            $("#bindingMsg strong").html("请输入正确的会员手机号码！");
            return;
        }
        $.ajax({
            url: "/sendGiftBindingSMS.htm",
            async: false,
            type: 'POST',
            data: {mob: mobile},
            success: function (data) {
                if(data == -1){
                    $("#bindingMsg").removeClass("hide");
                    $("#bindingMsg strong").html("该手机号尚未注册成为960会员，请先注册！");
                }else if(data == 0){
                    $("#bindingMsg").removeClass("hide");
                    $("#bindingMsg strong").html("该会员手机号已绑定礼品卡！");
                }else{
                    $("#bindingMsg").addClass("hide");
                    settime();
                    $(".SMSMsg").removeClass("hide");
                }
            }
        });

    }

    function settime(){
        var obj = $(".sendSMS");
        if (countdown == 0) {
            obj.removeAttr("disabled");
            obj.html("<span class='glyphicon glyphicon-phone'></span>获取短信验证码");
            countdown = 60;
            return;
        } else {
            obj.attr("disabled", true);
            obj.html("重新发送验证码（" + countdown + "）s");
            countdown--;
        }
        setTimeout(function() {settime() },1000)
    }

    function validaPwd(){
        var pwd = $("#gcPwd").val();
        if(pwd == ""){
            $("#bindingMsg").removeClass("hide");
            $("#bindingMsg strong").html("请输入礼品卡密码！");
            return;
        }
        $.ajax({
            url: "/validaGiftcard.htm",
            async: false,
            type: 'POST',
            data: {gcNo: $('#bindingNo').val(), gcPwd: $("#gcPwd").val()},
            success: function (data) {
                if(data == 1){
                    $("#bindingMsg").addClass("hide");
                    $(".validaPwd").parent().append("<span class='glyphicon glyphicon-ok' style='color: #3c763d;'>&nbsp;验证通过</span>");
                    $(".validaPwd").remove();
                }else{
                    $("#bindingMsg").removeClass("hide");
                    $("#bindingMsg strong").html("没有匹配到相应的礼品卡，请检查后重新验证！");
                }
            }
        });

    }

    //验证身份
    function verifylogin(){
        var pwd = $("#pwd").val();
        var token=$("#CSRFToken").val();
        var formName = $("#form_name").val();
        if(pwd != null && pwd.trim().length != 0){
            var url = 'checkUserKey.htm?userKey='+pwd+'&CSRFToken='+token;
            $.ajax({
                type : 'post',
                url : url,
                async : false,
                success : function(data) {
                    if (data > 0) {
                        $("#verifylogin").modal("hide");
                        $("#pwd").val("");
                        $(".pwdtip").text("");
                        $('#'+formName).modal('show');
                    } else if(data == 0) {
                        $(".pwdtip").text("密码错误!");
                        $(".pwdtip").addClass("alert-danger");
                        return;
                    }
                },
                error:function(){
                    $(".pwdtip").text("网络连接异常!");
                    $(".pwdtip").addClass("alert-danger");
                }
            });
        }else{
            $(".pwdtip").text("请输登录密码!");
            $(".pwdtip").addClass("alert-danger");
        }
    }

    function guaShiGiftcard(customerId,giftCardNo){
        $("#verifylogin").modal("show");
        $("#form_name").val("guaShiModal");
        $("#gueShiNo").html(giftCardNo);
        $("#gueShiCustomerId").val(customerId);
    }

    function confirmGuaShi(){
        $.ajax({
            url: "/saveGuaShiGiftcard.htm",
            async: false,
            type: 'POST',
            data: {gcNo: $('#gueShiNo').html(), customerId: $("#gueShiCustomerId").val()},
            success: function (data) {
                if(data == 1){
                    $("#guaShiModal").addClass("hide");
                    alert("挂失成功！！");
                    setTimeout(function() {window.location.href = location; },2000)
                }else{
                    alert("挂失失败，请稍后重新操作");
                }
            }
        });
    }

    function activeGiftcard(giftcardNo) {
        $("#form_name").val("activeModal");
        $("#activeNo").text(giftcardNo);
        $("#verifylogin").modal("show");
    }

    function confirmActive() {
        $("#activeModal").modal("hide");
        var giftcardNo = $("#activeNo").text();
        var token=$("#CSRFToken").val();
        $.post(
            "/activeGiftcard.htm",
            "giftcardNo="+giftcardNo+"&CSRFToken="+token,
            function (data) {
                if(data==1){
                    //激活成功
                    alert("激活成功");
                    location.reload();
                }else if(data==2){
                    //已经激活过
                    alert("已经激活过");
                }else{
                    //无效卡号
                    alert("无效卡号");
                }
            }
        );
    }
</script>
</body>

</html>