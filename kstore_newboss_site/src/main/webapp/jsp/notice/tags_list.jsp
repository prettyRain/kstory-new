<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>移动站点信息</title>

    <!-- Bootstrap -->
    <link href="<%=basePath %>css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=basePath %>iconfont/iconfont.css" rel="stylesheet">
    <link href="<%=basePath %>css/style.css" rel="stylesheet">
    <link href="<%=basePath %>css/style_new.css" rel="stylesheet">
    <link href="<%=basePath %>css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
        .form-group label{padding-right: 15px;}
        .btn-default:focus, .btn-default.focus, .btn-default:active, .btn-default.active{
            color: #fff;
            background-color: #3071a9;
            border-color: #285e8e;
        }
    </style>
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
                    <div class="row">
                        <div class="col-md-12 col-md-offset-5">
                            <button type="button" class="btn btn-primary" onclick="getNoticeTags();"><span class="glyphicon glyphicon-repeat"></span>同步消息通知标签</button>
                            <hr>


                            <table class="table table-bordered">
                                <caption>标签列表</caption>
                                <thead>
                                <tr>
                                    <th>编号</th>
                                    <th>标签名称</th>
                                    <th>更新时间</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="tag" items="${tags}" varStatus="s">
                                    <tr>
                                        <th scope="row">${s.index+1}</th>
                                        <td>${tag.name}</td>
                                        <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${tag.createTime }"/></td>
                                    </tr>
                                </c:forEach>

                                </tbody>
                            </table>

                        </div>



                    </div>

                </div>

            </div>
        </div>
    </div>

</div>
</div>
</div>



<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="<%=basePath %>js/bootstrap.min.js"></script>
<script src="<%=basePath %>js/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>js/language/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="<%=basePath %>js/common.js"></script>
<script src="<%=basePath %>js/common/common_alert.js"></script>
<script type="text/javascript">
    $('.form_datetime').datetimepicker({
        format: 'yyyy-mm-dd hh:ii:00',
        weekStart : 1,
        autoclose : true,
        language : 'zh-CN',
        pickerPosition : 'bottom-left',
        todayBtn : true,
        viewSelect : 'hour'
    });

    function getNoticeTags(){
        $.ajax({
            url:'ajaxGetNoticeTags.htm?CSRFToken=${token}',
            async:false,
            success: function (data) {
                if(data == 1){
                    showTipAlert("同步成功");
                    setTimeout(function() {window.location.href = location; },1500)
                }else{
                    showTipAlert("同步失败，请稍后重试！");
                }
            }
        });
    }

</script>
</body>
</html>