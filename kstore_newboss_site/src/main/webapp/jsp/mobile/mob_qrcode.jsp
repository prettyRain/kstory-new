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
                    <div class="alert alert-warning alert-dismissible" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
                        提示：输入网址生成二维码后，鼠标放在二维码上右键选择图片另存为可下载二维码。
                    </div>
                    <div class="common_form p20" style="width:1000px;">

                                <form class="form-horizontal" action="updateMobSiteBasic.htm" method="post" id="addForm" >
                                    <div class="form-group">
                                        <label class="control-label col-sm-6"><span class="text-danger">*</span>二维码网址：</label>
                                        <div class="col-sm-1"></div>
                                        <div class="col-sm-11">
                                            <input type="url" id="ip_code" class="form-control required" placeholder="http://www.xxxx.com/xxx" />
                                        </div>
                                        <p id="error_msg" style="color: #a94442;display: none;">请输入正确的网址</p>
                                    </div>



                                    <div class="form-group">
                                        <div class="col-sm-offset-7 col-sm-5">
                                            <button type="button" class="btn btn-primary" onclick="getCode();">生成二维码</button>
                                        </div>
                                    </div>

                                    <br />

                                    <div class="form-group">
                                        <div class="col-sm-offset-7 col-sm-5">
                                        <div id="qrcode"></div>
                                        </div>
                                    </div>

                                </form>

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
<script src="<%=basePath %>js/common.js"></script>
<script src="<%=basePath %>js/mobile/qrcode.min.js"></script>
<script type="text/javascript">
    function getCode(){
        var code = $("#ip_code").val();
        $("#qrcode").empty();
        //验证url网址
        if(code != "") {
            var Expression=/http(s)?:\/\/([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/;
            var objExp=new RegExp(Expression);
            if(objExp.test(code) != true){
                $("#error_msg").show();
                return false;
            } else {
                $("#error_msg").hide();
                new QRCode(document.getElementById("qrcode"), code);
            }

        }else{
            $("#error_msg").show();
        }

    }

</script>
</body>
</html>