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
                            <form class="form-horizontal" id="addForm">
                                <div class="form-group">
                                    <label for="title" class="col-sm-4 control-label">通知标题</label>
                                    <div class="col-sm-12">
                                        <input type="text" name="title" id="title" class="form-control w500 required" maxlength="64" placeholder="请在这里输入推送标题">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="content" class="col-sm-4 control-label">通知内容</label>
                                    <div class="col-sm-12">
                                        <textarea name="content" id="content" class="form-control w500 required" rows="5" maxlength="256" placeholder="请在这里输入推送内容"></textarea>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="urlType" class="col-sm-4 control-label">跳转链接</label>
                                    <div class="col-sm-12">
                                        <select class="form-control" name="urlType" id="urlType">
                                            <option value="">无（默认首页）</option>
                                            <option value="GoodsList">GoodsList（商品列表）</option>
                                            <option value="GoodsDetail">GoodsDetail（商品详情）</option>
                                            <option value="WebURL">WebURL（自定义）</option>
                                        </select>
                                        <input type="text" name="url" class="form-control w500 input_url hide" maxlength="64" placeholder="请输入相应参数">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="option1" class="col-sm-4 control-label">目标平台</label>
                                    <div class="col-sm-12">
                                        <div class="btn-group w500" data-toggle="buttons">
                                            <label class="btn btn-default active">
                                                <input type="radio" name="platform" id="option1" value="0" autocomplete="off" checked> 全部
                                            </label>
                                            <label class="btn btn-default">
                                                <input type="radio" name="platform" id="option2" value="1" autocomplete="off"> ios开发环境
                                            </label>
                                            <label class="btn btn-default">
                                                <input type="radio" name="platform" id="option3" value="2" autocomplete="off"> ios生产环境
                                            </label>
                                            <label class="btn btn-default">
                                                <input type="radio" name="platform" id="option4" value="3" autocomplete="off"> Android
                                            </label>
                                            <%--<label class="btn btn-default">--%>
                                                <%--<input type="radio" name="platform" id="option5" value="4" autocomplete="off"> Android生产环境--%>
                                            <%--</label>--%>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="option11" class="col-sm-4 control-label">目标人群</label>
                                    <div class="col-sm-12">
                                        <input type="hidden" name="crowd" id="crowd" />
                                        <div class="btn-group w500 crowdList" data-toggle="buttons">
                                            <label class="btn btn-default active crowd_item">
                                                <input type="radio" name="crowdType" id="option11" autocomplete="off" value="1" checked> 广播（所有人）
                                            </label>
                                            <label class="btn btn-default crowd_item">
                                                <input type="radio" name="crowdType" id="option12" autocomplete="off" value="2"> 设置标签（Tag）
                                            </label>
                                            <label class="btn btn-default crowd_item">
                                                <input type="radio" name="crowdType" id="option13" autocomplete="off" value="3"> Registration ID
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group tagsList hide">
                                    <label for="option11" class="col-sm-4 control-label">选择标签（多选）</label>
                                    <div class="col-sm-12">
                                        <div class="btn-group w500" data-toggle="buttons">
                                            <c:forEach var="tag" items="${tags}">
                                                <label class="btn btn-default tags_item" onclick="selTagsItem(this);">
                                                    <input type="checkbox" autocomplete="off" value="${tag.name}" name="tag"> ${tag.name}
                                                </label>
                                            </c:forEach>
                                        </div>
                                        <span class="error tagsMsg hide" style="color: #a94442;margin-top: 5px;font-weight: bold;">至少选择一个标签</span>
                                    </div>
                                </div>
                                <div class="form-group regId hide">
                                    <label for="option11" class="col-sm-4 control-label">Reg.ID</label>
                                    <div class="col-sm-12">
                                        <textarea class="form-control w500" name="registration" rows="2" placeholder="请输入Registration ID" onblur="inputRegId(this);"></textarea>
                                        <code>注：多个Registration ID用;隔开。此方式只用作于测试通知，将不会插入到商城消息中！</code>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="option33" class="col-sm-4 control-label">发送时间</label>
                                    <div class="col-sm-12">
                                        <div class="btn-group w500" data-toggle="buttons">
                                            <label class="btn btn-default timeType active">
                                                <input type="radio" name="sendType" id="option33" value="1" autocomplete="off" checked> 立即
                                            </label>
                                            <label class="btn btn-default timeType">
                                                <input type="radio" name="sendType" id="option44" value="2" autocomplete="off"> 定时
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group selTime hide">
                                    <label for="option33" class="col-sm-4 control-label">选择时间</label>
                                    <div class="col-sm-12">
                                        <div class="input-group date form_datetime w300">
                                            <input class="form-control" type="text" name="time" readonly>
                                            <span class="input-group-addon"><i class="glyphicon glyphicon-remove"></i></span>
                                            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-offset-4 col-sm-10">
                                        <button type="button" class="btn btn-primary" onclick="submitBtn()"><span class="glyphicon glyphicon-log-in">&nbsp;</span>发送</button>
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
</div>



<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="<%=basePath %>js/bootstrap.min.js"></script>
<script src="<%=basePath %>js/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>js/language/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="<%=basePath %>js/common.js"></script>
<script src="<%=basePath %>js/common/common_alert.js"></script>
<script type="text/javascript">

    $.fn.serializeObject = function()
    {
        var o = {};
        var a = this.serializeArray();
        $.each(a, function() {
            if (o[this.name]) {
                if (!o[this.name].push) {
                    o[this.name] = [o[this.name]];
                }
                o[this.name].push(this.value || '');
            } else {
                o[this.name] = this.value || '';
            }
        });
        return o;
    };

    $('.form_datetime').datetimepicker({
        format: 'yyyy-mm-dd hh:ii:00',
        weekStart : 1,
        autoclose : true,
        language : 'zh-CN',
        pickerPosition : 'bottom-left',
        todayBtn : true,
        viewSelect : 'hour',
        startDate:new Date()
    });

    $(function(){

        $("#urlType").change(function(){
            $(".input_url").val("");
            if($(this).val() == ""){
                $(".input_url").addClass("hide").removeClass("required");
                $(".input_url").parent().find("label[class='error']").remove();
            }else{
                $(".input_url").removeClass("hide").addClass("required");
            }
        });

        $(".crowd_item").click(function(){
            var itemId = $(this).find("input").val();
            $("#crowd").val("");
            $('[name="registration"]').removeClass("required");
            $(".tagsMsg").addClass("hide");
            if(itemId == 1){
                $(".tagsList").addClass("hide");
                $(".regId").addClass("hide");
            }else if(itemId == 2){
                $(".tagsList").button('reset');
                $(".tagsList").removeClass("hide");
                $(".regId").addClass("hide");
            }else if(itemId == 3){
                $(".tagsList").addClass("hide");
                $(".regId").removeClass("hide");
                $('[name="registration"]').addClass("required");
            }
        });

        $(".timeType").click(function() {
            if($(this).find("input").val() == 1){
                $(".selTime").addClass("hide");
                $('[name="time"]').removeClass("required");
            }else{
                $(".selTime").removeClass("hide");
                $('input[name="time"]').val("");
                $('[name="time"]').addClass("required");
            }
        });
    });

    function selTagsItem(n) {
        $(".tagsMsg").addClass("hide");
        if($(n).hasClass("active")){
            var tags = "";
        }else{
            var tags = $(n).find("input").val();
        }
        $(".tags_item").each(function(){
            if($(this).hasClass("active")){
                tags = $(this).find("input").val() + ";" + tags;
            }
        });
        $("#crowd").val(tags);
    }

    function inputRegId(n){

        $("#crowd").val($(n).val());
    }

    function submitBtn() {


        if($("#addForm").valid()){

            var selTagsCount = $(".tags_item").parent().find(".active").length;
            if($(".crowdList").find(".active").find("input").val() == 2 && selTagsCount == 0){
                $(".tagsMsg").removeClass("hide");
                return;
            }
            var param = $("#addForm").serializeObject();
            if(selTagsCount == 1){
                param["tag"] = new Array(param["tag"]);
            }
            $.ajax({
                type: "post",
                dataType: "json",
                url:'ajaxSaveNotice.htm?CSRFToken=${token}',
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(param),
                success: function (result) {
                    if(result == 1){
                        showTipAlert("推送成功");
                        setTimeout(function() {window.location.href = "/noticeList.htm"; },1500)
                    }else{
                        showTipAlert("推送失败，请稍后重试！");
                    }
                }
            });

        }


        }

</script>
</body>
</html>