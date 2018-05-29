<%--
  Created by IntelliJ IDEA.
  User: NP-Heh
  Date: 2015/4/1
  Time: 16:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title></title>

    <!-- Bootstrap -->
    <link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=basePath%>css/font-awesome.min.css">
    <link href="<%=basePath%>iconfont/iconfont.css" rel="stylesheet">
    <link href="<%=basePath%>css/summernote.css" rel="stylesheet">
    <link href="<%=basePath%>css/style.css" rel="stylesheet">
    <link href="<%=basePath %>css/style_new.css" rel="stylesheet">
    <link href="<%=basePath %>/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <link href="<%=basePath%>css/zTreeStyle/zTreeStyle.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
        .main_cont{
            background: #fff;
            overflow-y: visible;
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

                <h2 class="main_title">${pageNameChild} <small>(共${pageBean.rows}张)</small></h2>

                <div class="common_data p20">

                    <div class="filter_area" style="margin-left:8px;">
                        <input type="hidden" value="searchForm" id="formId">
                        <input type="hidden" value="queryImageManageByPbAndCid.htm" id="formName">
                        <form role="form" class="form-inline" id="searchForm" action="queryImageManageByPbAndCid.htm">
                            <input type="hidden" name="CSRFToken" value="${token}">
                            <%--<div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">图片分类</span>
                                    <input type="hidden" name="classifyId" id="search_classifyId" value="-1"/>
                                    <input type="text" class="form-control required" id="text_classifyId" data-toggle="dropdown"
                                           readonly>
                                    <div class="dropdown-menu" role="menu" id="cateChoose">
                                        <ul id="treeDemo" class="ztree"></ul>
                                    </div>
                                </div>
                            </div>--%>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">开始时间</span>

                                    <div class="input-group date form_datetime" id="startpicker">
                                        <input class="form-control" id="startDate" style="width: 150px" type="text"
                                               value="${startDate}" readonly>
                                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">结束时间</span>

                                    <div class="input-group date form_datetime" id="endpicker">
                                        <input class="form-control" type="text" style="width: 150px" id="endDate"
                                               value="${endDate}" readonly>
                                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <button type="button" class="btn btn-primary" onclick="queryNotRelateImages(1);">搜索</button>
                            </div>
                        </form>
                    </div>

                    <div class="data_ctrl_area mb20" style="margin-left:8px;">
                        <div class="data_ctrl_search pull-right"></div>
                        <div class="data_ctrl_brns pull-left">

                            <button type="button" class="btn btn-info" onclick="batchDeleteRelate()">
                                <i class="glyphicon glyphicon-trash"></i> 删除
                            </button>
                            <button type="button" class="btn btn-info" onclick="deleteAllUrl()">
                                <i class="glyphicon glyphicon-trash"></i> 一键删除未关联图片
                            </button>
                            <%--<button type="button" class="btn btn-info" onclick="$('#uploadImg').modal('show')">
                                <i class="glyphicon glyphicon-plus"></i> 添加图片
                            </button>--%>
                        </div>
                        <div class="clr"></div>
                    </div>
                    <form action="deleteimagemanageactiontoformerbath.htm?CSRFToken=${token }" method="post" id="picdelete">
                    <input id="classifyIdDelete" type="hidden" name="classifyId" value=""> </input>
                    <input type="checkbox"  onchange="allunchecked(this,'pids')">

                    <div class="pic_list" id="categoryProductContainer">

                    </div>

                    </form>
                    <div class="table_foot" style="display:inline">
                        <div class="table_pagenav ">
                            <div class="meneame" style="text-align: center;" id="pageDiv">
                               <%-- <a href="#">上一页</a><span class="current"> </span><a href="javascript:;">共：页</a><a href="#">下一页</a>--%>
                            </div>
                        </div>
                        <div class="clr"></div>
                    </div>


                </div>
            </div>

        </div>
    </div>
</div>





<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->

<!-- Include all compiled plugins (below), or include individual files as needed -->
<%--<script type="text/javascript" src="<%=basePath%>js/jquery.min.js" ></script>--%>
<%--<script type="text/javascript" src="<%=basePath%>js/jquery.validate.js"></script>--%>
<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js" ></script>
<script type="text/javascript" src="<%=basePath%>js/summernote.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/language/summernote-zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.pinbox.js"></script>
<script type="text/javascript" src="<%=basePath%>js/common/common_alert.js"></script>
<script type="text/javascript" src="<%=basePath%>js/common/common_date.js"></script>
<script src="<%=basePath%>js/common/common_checked.js"></script>
<script type="text/javascript" src="<%=basePath%>js/system/image_list.js"></script>
<script type="text/javascript" src="<%=basePath%>js/common.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.zclip.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.zclip.js"></script>
<script type="text/javascript" src="<%=basePath %>js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="<%=basePath %>js/language/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.ztree.excheck-3.5.min.js"></script>
<script type="text/javascript" type="text/javascript">

    queryNotRelateImages(1)
    function queryNotRelateImages(bigPageNo) {
        //$(".table_foot").hide();
        $('#pageDiv').html("");
        $('.span2').remove();
        $.ajax({
            url:'ajaxQueryRetaleImag.htm?pageSize=50&pageNo='+bigPageNo+'&startDate='+$("#startDate").val()+"&endDate="+$("#endDate").val(),
            async:false,
            success:function(data) {
                //var data=JSON.parse(data);
                var imageList = data.imageManageList;
                 var html = '';
                 for(var i=0;i<imageList.length;i++) {
                 imageCount ++;
                 var image = imageList[i];
                 var pid = image.imageManageId;
                 html =
                 '<div class="span2 pcon prodcont actioninside new" style="float:left">'+
                 '<input type="checkbox" name="pids" value="'+pid+'-'+image.imageManageUrl+'">'+
                 '   <img class="media-object cover" style="display:block;width:230px;" src="'+image.imageManageUrl+'">'+
                 '   <p class="mt20">'+
                 '       <span class="pull-right" id="imageCate'+image.imageManageId+'">'+(image.imgClassify==null?"未分配":(image.imgClassify.classifyName==null?"未分配":image.imgClassify.classifyName))+'</span>'+
                 (new Date(image.imageOnlineDate)).format("yyyy-MM-dd hh:mm:ss") +
                 '   </p>'+
                 '   <div class="pull-right">'+
                 '       <button type="button" class="btn btn-default copyClass copy'+(totalPageNo+miniPageNo)+'" rot-value="'+image.imageManageUrl+'" ><i class="glyphicon glyphicon-link"></i></button>'+
                 '    </div>'+
                 '   <div class="pull-left">'+
                 '       <div class="btn-group" role="group" aria-label="...">'+
                // '           <button type="button" class="btn btn-default" onclick="showUpdateImage(\''+image.imageManageId+'\',\''+image.classifyId+'\')">修改</button>'+
                 '           <button type="button" class="btn btn-default" onclick="DeleteOneConfirmAlert(\'deleteImageManageRelate.htm?infoImageManageId='+image.imageManageId+'&imageManageUrl='+image.imageManageUrl+'\')">删除</button>'+
                 '       </div>'+
                 '   </div>'+
                 '   <div class="clr"></div>'+
                 '</div>';
                 $('#categoryProductContainer').append(html);

                 }
                // 判断图片加载状况，加载完成后回调
                isImgLoad(function(){
                    // 加载完成
                    $.fn.pinbox.staticInfo.lastScrollIndex = false;
                    $.fn.pinbox.staticInfo.nextFillMatrixId = false;
                    $.fn.pinbox.staticInfo.firstRun = true;
                    $('#categoryProductContainer').pinbox({subcontainer:'.actioninside'}).hide(0).fadeIn(2000);
                    initCopy($(".copy"+(totalPageNo+miniPageNo)));
                    resizePageDiv();
                });
                loadPages(data.pb,data.totalPages);
                //loadPageDiv(data);
                miniPageNo = 1;
                //$("#classifyIdDelete").val($("#search_classifyId").val());
            }
        });
    }

    function loadPages(page,totalPages){
        var pageDiv = '';
        if(page.pageNo==1){
            pageDiv+='<a href="#">上一页</a>';
        }else{
            pageDiv+='<a href="javascript:queryNotRelateImages('+(page.pageNo-1)+')">上一页</a>';
        }

       for(var i=((page.pageNo-3)>0?(page.pageNo-3):1);i<=((page.pageNo+4)>totalPages?totalPages:(page.pageNo+4));i++){
            if(i==page.pageNo){
            pageDiv+='<span class="current">'+i+'</span>';
            }else{
                pageDiv+='<a href="javascript:queryNotRelateImages('+i+')">'+i+'</a>';
            }
        }
        if(totalPages>(page.pageNo+4)){
           pageDiv+='...<a href=javascript:queryNotRelateImages('+totalPages+')>尾页</a>';
        }
        if(page.pageNo==totalPages){
            pageDiv+='<a href="#">下一页</a>';
        }else{
            pageDiv+='<a href="javascript:queryNotRelateImages('+(page.pageNo+1)+')">下一页</a>';
        }

        $('#pageDiv').html(pageDiv);

    }
    //批量删除
    function batchDeleteRelate(){
        var arr=new Array();
        $('input[name=pids]:checked').each(function(index,item){
            var _this=$(item);
            arr.push(_this.val());
        })
        var str=arr.join(",");
        var data={
            "relate":str,
        };
       $.ajax({
            type:"post",
            data:data,
            url:'bachDeleteRelate.htm',
            success:function(result){
                queryNotRelateImages(1);
            }
        });
    }
    //一键删除
    function deleteAllUrl(){
        $.ajax({
           url:'deleteAllUrl.htm',
            success:function(){
                queryNotRelateImages(1);
            }
        })
    }

    /**
     * 删除单个记录的确认框
     * @param deleteUrl 删除链接。
     */
    function DeleteOneConfirmAlert(deleteUrl,tips) {
        $("#modalDialog").remove();
        var confirmDialog =
            '<div class="modal fade" id="modalDialog" tabindex="-1" role="dialog">'+
            '    <div class="modal-dialog">'+
            '        <div class="modal-content">'+
            '            <div class="modal-header">'+
            '                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>'+
            '               <h4 class="modal-title">系统提示</h4>'+
            '           </div>'+
            '           <div class="modal-body">';
        if(tips!='' && tips!=undefined){
            confirmDialog +=tips;
        }else{
            confirmDialog +='确认要删除这条记录吗？';
        }
        confirmDialog += '           </div>'+
            '           <div class="modal-footer">'+
            '               <button type="button" class="btn btn-primary" onclick="AjaxDeleteOne(\''+deleteUrl+'\');">确定</button>'+
            '               <button type="button" class="btn btn-default" data-dismiss="modal" onclick="$(\'#modalDialog\').modal(\'hide\');">取消</button>'+
            '           </div>'+
            '       </div>'+
            '   </div>'+
            '</div>';
        $(document.body).append(confirmDialog);
        $('#modalDialog').modal('show');
    }
    function AjaxDeleteOne(deleteUrl){
        $.ajax({
            url:deleteUrl,
            success:function(){
                $('#modalDialog').modal('hide');
                queryNotRelateImages(1);
            }
        })
    }
</script>
</body>
</html>

