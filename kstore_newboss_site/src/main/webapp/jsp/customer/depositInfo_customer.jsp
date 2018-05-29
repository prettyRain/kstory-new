<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title></title>
    <!-- Bootstrap -->
    <link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=basePath%>css/font-awesome.min.css">
    <link href="<%=basePath%>iconfont/iconfont.css" rel="stylesheet">
    <link href="<%=basePath%>css/summernote.css" rel="stylesheet">
    <link href="<%=basePath%>css/bootstrap-select.min.css" rel="stylesheet">
    <link href="<%=basePath %>css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <link href="<%=basePath %>css/select2.min.css" rel="stylesheet">
    <link href="<%=basePath%>css/style.css" rel="stylesheet">
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
<jsp:include page="../page/header.jsp"></jsp:include>
<div class="page_body container-fluid">
    <div class="row">
        <jsp:include page="../page/left.jsp"></jsp:include>
        <div class="col-lg-20 col-md-19 col-sm-18 main">
            <jsp:include page="../page/left2.jsp"></jsp:include>
            <div class="main_cont">
                <jsp:include page="../page/breadcrumbs.jsp"></jsp:include>
                <h2 class="main_title">${pageNameChild}</h2>
                <div class="filter_area" style="margin-left:20px">
                    <button type="button" class="btn btn-info" onclick="godepositInfoList();">
                        返回礼品卡资金列表
                    </button>
                    <c:if test="${activeFlag == -2}">
                    <button type="button" class="btn btn-info" onclick="toNewGiftCard();">
                        <span class="glyphicon glyphicon-log-out"></span>&nbsp;转移至新卡号
                    </button>
                    </c:if>
                </div>
                <div class="data_list">
                    <ul>
                        <li>
                            <span>用户名：</span>
                            <p>${depositInfo.customerUsername}</p>
                        </li>
                        <li>
                            <span>预存款总额：</span>
                            <p class="freezePreDeposit">&yen;${depositInfo.totalDeposit}</p>
                        </li>
                        <li>
                            <span>可用预存款：</span>
                            <p >&yen;${depositInfo.preDeposit}</p>
                        </li>
                        <li>
                            <span>冻结预存款：</span>
                            <p>&yen;${depositInfo.freezePreDeposit}</p>
                </li>
                    </ul>
                </div>
                <div class="common_data p20">
                    <form role="form" class="form-inline" action="selectDepositInfoById.htm?CSRFToken=${token }" method="post"
                    id="searchForm">
                        <input type="hidden" value="searchForm" id="formId">
                        <input type="hidden" value="${pageBean.url}" id="formName">
                        <input type="hidden" id="customerId" name="customerId" value="${pageBean.objectBean.customerId}"/>
                        <div class="filter_area">
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">交易类型</span>
                                    <select class="form-control cate_selector" id="orderType" name="orderType">
                                        <option value=""
                                                <c:if test="${empty pageBean.objectBean.orderType }">selected="selected"</c:if>>
                                            全部
                                        </option>
                                        <option value="0"
                                                <c:if test="${not empty pageBean.objectBean.orderType && pageBean.objectBean.orderType==0 }">selected="selected"</c:if>>
                                            在线充值
                                        </option>
                                        <option value="1"
                                                <c:if test="${not empty pageBean.objectBean.orderType && pageBean.objectBean.orderType==1 }">selected="selected"</c:if>>
                                            订单退款
                                        </option>
                                        <option value="2"
                                                <c:if test="${not empty pageBean.objectBean.orderType && pageBean.objectBean.orderType==2 }">selected="selected"</c:if>>
                                            线下提现
                                        </option>
                                        <option value="3"
                                                <c:if test="${not empty pageBean.objectBean.orderType && pageBean.objectBean.orderType==3 }">selected="selected"</c:if>>
                                            订单消费
                                        </option>
                                        <option value="4"
                                                <c:if test="${not empty pageBean.objectBean.orderType && pageBean.objectBean.orderType==4 }">selected="selected"</c:if>>
                                            线下现金充值
                                        </option>
                                        <option value="5"
                                                <c:if test="${not empty pageBean.objectBean.orderType && pageBean.objectBean.orderType==5 }">selected="selected"</c:if>>
                                            线下刷卡充值
                                        </option>
                                        <option value="6"
                                                <c:if test="${not empty pageBean.objectBean.orderType && pageBean.objectBean.orderType==6 }">selected="selected"</c:if>>
                                            线下支付宝充值
                                        </option>
                                        <option value="7"
                                                <c:if test="${not empty pageBean.objectBean.orderType && pageBean.objectBean.orderType==7 }">selected="selected"</c:if>>
                                            线下微信充值
                                        </option>
                                        <option value="8"
                                                <c:if test="${not empty pageBean.objectBean.orderType && pageBean.objectBean.orderType==8 }">selected="selected"</c:if>>
                                            转卡工本费
                                        </option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">交易单号</span>
                                    <input type="text" class="form-control" name="orderCode"
                                           value="${pageBean.objectBean.orderCode}"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">交易状态</span>
                                    <select class="form-control cate_selector" id="orderStatus" name="orderStatus">
                                        <option value=""
                                                <c:if test="${empty pageBean.objectBean.orderStatus }">selected="selected"</c:if>>
                                            全部
                                        </option>
                                        <option value="0"
                                                <c:if test="${not empty pageBean.objectBean.orderStatus && pageBean.objectBean.orderStatus==0 }">selected="selected"</c:if>>
                                            待审核
                                        </option>
                                        <option value="1"
                                                <c:if test="${not empty pageBean.objectBean.orderStatus && pageBean.objectBean.orderStatus==1 }">selected="selected"</c:if>>
                                            打回
                                        </option>
                                        <option value="2"
                                                <c:if test="${not empty pageBean.objectBean.orderStatus && pageBean.objectBean.orderStatus==2 }">selected="selected"</c:if>>
                                            通过
                                        </option>
                                        <option value="3"
                                                <c:if test="${not empty pageBean.objectBean.orderStatus && pageBean.objectBean.orderStatus==3 }">selected="selected"</c:if>>
                                            确认
                                        </option>
                                        <option value="4"
                                                <c:if test="${not empty pageBean.objectBean.orderStatus && pageBean.objectBean.orderStatus==4 }">selected="selected"</c:if>>
                                            已完成
                                        </option>
                                        <option value="5"
                                                <c:if test="${not empty pageBean.objectBean.orderStatus && pageBean.objectBean.orderStatus==5 }">selected="selected"</c:if>>
                                            未支付
                                        </option>
                                        <option value="6"
                                                <c:if test="${not empty pageBean.objectBean.orderStatus && pageBean.objectBean.orderStatus==6 }">selected="selected"</c:if>>
                                            充值成功
                                        </option>
                                        <%--<option value="7"
                                                <c:if test="${not empty pageBean.objectBean.orderStatus && pageBean.objectBean.orderStatus==7 }">selected="selected"</c:if>>
                                            充值失败
                                        </option>--%>
                                        <option value="8"
                                                <c:if test="${not empty pageBean.objectBean.orderStatus && pageBean.objectBean.orderStatus==8 }">selected="selected"</c:if>>
                                            已取消
                                        </option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group date form_datetime w300" id="startpicker">
                                    <span class="input-group-addon">开始时间</span>
                                    <input class="form-control" type="text" id="startTime" name="startTime"
                                           value="${startTime}" readonly>
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-remove"></i></span>
                                    <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-calendar"></span></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group date form_datetime w300" id="endpicker">
                                    <span class="input-group-addon">结束时间</span>
                                    <input class="form-control" type="text" value="${endTime}"
                                           name="endTime" id="endTime" readonly>
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-remove"></i></span>
                                    <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-calendar"></span></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <button type="submit" class="btn btn-primary">搜索</button>
                            </div>
                        </div>
                    </form>
                    <table class="table table-striped table-hover">
                        <thead>
                        <tr>
                            <th>会员用户名</th>
                            <th>交易类型</th>
                            <th>交易时间</th>
                            <th>收入</th>
                            <th>支出</th>
                            <th>交易状态</th>
                            <th>当前预存款</th>
                            <th>交易单号</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:if test="${fn:length(pageBean.list)<=0 }">
                            <tr>
                                <td style="text-align: center;" colspan="8">暂无数据</td>
                            </tr>
                        </c:if>
                        <c:forEach items="${pageBean.list }" var="trade" varStatus="i">
                            <tr>
                                <td>
                                    <c:if test="${fn:length(trade.customerUsername)>12 }">
                                        ${fn:substring(trade.customerUsername,0,11) }...
                                    </c:if>
                                    <c:if test="${fn:length(trade.customerUsername)<=11 }">
                                        ${trade.customerUsername}
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${trade.orderType == 0}">在线充值</c:if>
                                    <c:if test="${trade.orderType == 1}">订单退款</c:if>
                                    <c:if test="${trade.orderType == 2}">线下提现</c:if>
                                    <c:if test="${trade.orderType == 3}">订单消费</c:if>
                                    <c:if test="${trade.orderType == 4}">线下现金充值</c:if>
                                    <c:if test="${trade.orderType == 5}">线下刷卡充值</c:if>
                                    <c:if test="${trade.orderType == 6}">线下支付宝充值</c:if>
                                    <c:if test="${trade.orderType == 7}">线下微信充值</c:if>
                                    <c:if test="${trade.orderType == 8}">转卡工本费</c:if>
                                </td>
                                <td>
                                    <fmt:formatDate value="${trade.createTime }" pattern="yyyy-MM-dd HH:mm:ss" var="createTime" />
                                    ${createTime}
                                </td>
                                <td style="color: #1BB974;"><c:if test="${trade.income !=0 && trade.income != null}">+${trade.income}</c:if></td>
                                <td style="color:red"><c:if test="${trade.cost !=0 && trade.cost != null}">-${trade.cost}</c:if></td>
                                <td>
                                    <c:if test="${trade.orderStatus == 0}">待审核</c:if>
                                    <c:if test="${trade.orderStatus == 1}">打回</c:if>
                                    <c:if test="${trade.orderStatus == 2}">通过</c:if>
                                    <c:if test="${trade.orderStatus == 3}">确认</c:if>
                                    <c:if test="${trade.orderStatus == 4}">已完成</c:if>
                                    <c:if test="${trade.orderStatus == 5}">未支付</c:if>
                                    <c:if test="${trade.orderStatus == 6}">充值成功</c:if>
                                    <%--<c:if test="${trade.orderStatus == 7}">充值失败</c:if>--%>
                                    <c:if test="${trade.orderStatus == 8}">已取消</c:if>
                                    <c:if test="${trade.orderStatus == null or trade.orderStatus eq ''}">已完成</c:if>
                                </td>
                                <td><c:if test="${trade.currentPrice ==0 or trade.currentPrice == null}">0.00</c:if>${trade.currentPrice}</td>
                                <td>${trade.orderCode}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <c:import url="../page/searchPag.jsp">
                        <c:param name="pageBean" value="${pageBean }"/>
                    </c:import>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="rechargeModal"  role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">转移至新卡</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="rechargeForm">
                    <div class="alert alert-danger hide" id="bindingMsg" role="alert">
                        <span class="glyphicon glyphicon-info-sign"></span>&nbsp;<strong></strong>
                    </div>
                    <div class="alert alert-danger hide" id="rechargeMsg" role="alert" style="margin-bottom: 0px;">
                        <span class="glyphicon glyphicon-info-sign"></span>&nbsp;<strong></strong>
                    </div>
                    <input type="hidden" name="CSRFToken" id="CSRFToken" value="${token }" />
                    <input type="hidden" id="rechargeCustomerId">
                    <div class="form-group">
                        <label class="control-label col-sm-5">新卡号：</label>
                        <div class="col-sm-1"></div>
                        <div class="col-sm-10">
                            <input type="text" class="form-control required" id="tonew_no" placeholder="请输入新卡号">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-5">再次输入新卡号：</label>
                        <div class="col-sm-1"></div>
                        <div class="col-sm-10">
                            <input type="text" class="form-control required" id="tonew_reno" placeholder="再次输入新卡号">
                        </div>
                    </div>


                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="toNewSave()">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
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
<!-- 返回会员资金列表-->
<form method="post" id="godepositInfoListForm" action="initGiftcardInfoList.htm?CSRFToken=${token }">
    <input type="hidden" name="pageNos" value="${pageNos}"/>
</form>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="<%=basePath%>js/bootstrap.min.js"></script>
<script src="<%=basePath%>js/summernote.min.js"></script>
<script src="<%=basePath%>js/language/summernote-zh-CN.js"></script>
<script src="<%=basePath%>js/bootstrap-select.min.js"></script>
<script src="<%=basePath %>js/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>js/language/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="<%=basePath%>js/common.js"></script>
<script src="<%=basePath %>js/common/common_alert.js"></script>
<script src="<%=basePath %>js/common/common_checked.js"></script>
<script src="<%=basePath %>js/customer/commonDate.js"></script>
<script src="<%=basePath %>js/select2.min.js"></script>
<script>
    function godepositInfoList() {
        $("#godepositInfoListForm").submit();
    }
    function toNewGiftCard(){
        var freezePreDeposit = $(".freezePreDeposit").html();
        if(parseInt(freezePreDeposit.substr(1,freezePreDeposit.length)) < 10){
            alert("该用户礼品卡中金额不足 10.00 元，不能进行转至新卡操作！！");
            return;
        }
        $("#verifylogin").modal("show");
        $("#form_name").val("rechargeModal");
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

    function toNewSave(){
        if($("#rechargeForm").valid()) {
            var gcNo = $("#tonew_no").val();
            var regcNo = $("#tonew_reno").val();
            if (gcNo != regcNo) {
                $("#bindingMsg").removeClass("hide");
                $("#bindingMsg strong").html("两次卡号不一致，请检查后重新输入！");
                return;
            }
            $.ajax({
                url: "/savetoNewGiftCard.htm",
                async: false,
                type: 'POST',
                data: {gcNo: regcNo, customerId: $("#customerId").val()},
                success: function (data) {
                    if (data == 1) {
                        alert("转移新卡成功！！");
                        setTimeout(function() {searchForm.submit();; },2000)
                    }else if(data == -1){
                        $("#bindingMsg").removeClass("hide");
                        $("#bindingMsg strong").html("没有匹配到相应的礼品卡，请检查后重新输入！");
                    }else if(data == -2){
                        $("#bindingMsg").removeClass("hide");
                        $("#bindingMsg strong").html("转移至的新卡只能是未激活的礼品卡，请检查后重新输入！");
                    } else {
                        alert("转移至新卡失败，请稍后重新操作");
                    }
                }
            });
        }
    }
</script>
</body>
</html>
