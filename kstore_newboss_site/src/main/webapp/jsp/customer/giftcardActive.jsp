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
    <title>礼品卡激活</title>

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
                <div class="common_data p20">
                    <div class="filter_area mb10">
                            <div class="form-group">
                                <div class="input-group">
                                    <input type="hidden" id="CSRFToken" value="${token }">
                                    <span class="input-group-addon">礼品卡号</span>
                                    <input type="text" class="form-control" id="giftcardNo" autocomplete="off">
                                </div>
                            </div>
                            <div class="form-group">
                                <button onclick="activeThis()" class="btn btn-primary">激活</button>
                            </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
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
    //绑定回车事件
    $("#giftcardNo").on("keydown",function (e) {
        if(e.keyCode == 13){
            activeThis();
        }
    })
    function activeThis(){
        var giftcardNo = $("#giftcardNo").val();
        if(giftcardNo!=''){
            $("#activeNo").text(giftcardNo);
            $("#activeModal").modal('show');
        }else{
            alert("请输入要激活的卡号");
        }
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