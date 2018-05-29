<%--
  Created by IntelliJ IDEA.
  User: NP-Heh
  Date: 2015/4/1
  Time: 16:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
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
    <link href="<%=basePath %>css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=basePath %>css/font-awesome.min.css">
    <link href="<%=basePath %>iconfont/iconfont.css" rel="stylesheet">
    <link href="<%=basePath %>css/summernote.css" rel="stylesheet">
    <link href="<%=basePath %>css/bootstrap-select.min.css" rel="stylesheet">
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
                <input type="hidden" value="${token}" class="token_val"/>
                <h2 class="main_title">${pageNameChild} <small>(共${pb.rows}条)</small></h2>

                <input type="hidden" name="CSRFToken" id="CSRFToken" value="${token}">
                <div class="common_data p20">

                    <div class="data_ctrl_area mb20">
                        <div class="data_ctrl_search pull-right"></div>
                        <div class="data_ctrl_brns pull-left">
                            <button type="button" class="btn btn-info" onclick="$('#addBrand').modal('show')">
                                <i class="glyphicon glyphicon-plus"></i> 添加
                            </button>
                            <button type="button" class="btn btn-info" onclick="deleteAuths()">
                                <i class="glyphicon glyphicon-trash"></i> 删除
                            </button>

                        </div>
                        <div class="clr"></div>
                    </div>
                    <form id="deleBrandForm" action="batchDelBrand.htm?CSRFToken=${token }" method="post">
                        <input type="hidden" value="${pb.pageNo}" name="pageNo"/>
                    <table class="table table-striped table-hover">
                        <thead>
                        <tr>
                            <th width="10"><input type="checkbox"  class="allcheck" /></th>
                            <th>认证标识</th>
                            <th>认证说明</th>
                           <%-- <th</th>--%>
                            <!-- <th>品牌网址</th> -->
                           <%-- <th>品牌排序</th>--%>
                            <th width="150">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${pb.list}" var="auth">
                        <tr>
                            <td><input type="checkbox"  value="${auth.id }" class="checkid"/></td>
                            <td><img alt="" src="${auth.authsrc}" height="36px"></td>
                            <td>${auth.authName}</td>
                            <td>
                                <%--<div class="btn-group">--%>
                                    <%--<input type="button" class="btn " onclick="deleteAuth(${auth.id})" value="删除"/>--%>
                                    <p class="btn" id="deleteA" val="${auth.id}" style="color:#3d85cc;">删除</p><br/>
                                    <p class="btn" id="updateA" val="${auth.id}" onclick="showEditAuthForm(${auth.id})" style="color:#3d85cc;">编辑</p>
                               <%-- </div>--%>
                            </td>
                        </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    </form>

                   <%-- <c:import url="../page/searchPag.jsp">
                        <c:param name="pageBean" value="${pb }"/>
                    </c:import>
--%>
                    <div class="table_pagenav pull-right" id="rightPage">
                        <div class="meneame">
                          <input type="hidden" class="pageNo" value="${pb.pageNo}">
                          <input type="hidden" class="totalPage" value="${pb.totalPages}">
                               <%--<c:if test="${pb.pageNo>1}">
                                <a  href="${pageContext.request.contextPath}/findAllAuth.htm?pageNo=${pb.pageNo-1}"> 上一页 </a>
                               </c:if>
                               <c:if test="${pb.pageNo==1}">
                                <span class="disabled"> 上一页 ${pb.startNo}</span>
                               </c:if>
                               <c:if test="${pb.pageNo-3>0}">
                                   <span class=""> ...</span>
                               </c:if>
                            <c:forEach begin="${pb.startNo}" end="${pb.endNo}" varStatus="vars">
                                <c:choose  >
                                    <c:when test="${(pb.startNo+vars.count-1)==pb.pageNo}">
                                        <span class="current">${pb.startNo+vars.count-1}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/findAllAuth.htm?pageNo=${pb.startNo+vars.count-1}">${pb.totalPages}${pb.startNo+vars.count-1}</a>
                                    </c:otherwise>
                                </c:choose>


                            </c:forEach>
                            <c:if test="${pb.pageNo+2<pb.totalPages}">
                                <span class=""> ...</span>
                            </c:if>
                            <c:if test="${pb.pageNo==pb.totalPages}">
                                    <span class="disabled"> 下一页 </span>
                            </c:if>
                            <c:if test="${pb.pageNo<pb.totalPages}">
                                   <a  href="${pageContext.request.contextPath}/findAllAuth.htm?pageNo=${pb.pageNo+1}"  > 下一页 </a>
                            </c:if>--%>

                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<!-- 编辑品牌 -->
<div class="modal fade" id="editBrand"  role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">编辑商品认证标识</h4>
            </div>
            <form role="form" class="form-horizontal" id="editBrandForm" enctype="multipart/form-data" action="updateAuth.htm?CSRFToken=${token}" method="post">
                <input type="hidden" name="authId" id="brandId"/>
                <div class="modal-body">
                    <div class="modal_form">
                        <div class="form-group">
                            <label class="col-sm-6 control-label">
                                <span class="text-danger">*</span>认证说明：
                            </label>
                            <div class="col-sm-13">
                                <input type="text" class="form-control required" name="authName" id="authName">换行请用"&amp;#10;"
                            </div>
                            <div class="col-sm-5">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-6">认证图片：</label>
                            <div class="col-sm-12">
                                <p class="pt5"><input type="file" name="picFile" id="logoFile_update"></p>
                            </div>
                            <div class="col-sm-1"></div>
                            <div class="col-sm-3">
                                <a href="javascript:;" class="np_brandLogo help_tips">
                                    <i class="icon iconfont">&#xe611;</i>
                                </a>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-6">预览图片：</label>
                            <div class="col-sm-12">
                                <img alt="" src="" id="preview_image_update" width="90px">
                            </div>
                            <div class="col-sm-1"></div>
                        </div>
                    </div>
                    <input type="hidden" name="authsrc" id="updateauthsrc"/>
                    <input type="hidden" name="id" id="updateauthid" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="submitUpdateAuthForm();">保存</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="addBrand"  role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">添加商品认证标识</h4>
            </div>
            <form role="form" class="form-horizontal" id="saveBrandForm" enctype="multipart/form-data" action="saveAuth.htm?CSRFToken=${token}" method="post">
            <div class="modal-body">
                <div class="modal_form">
                        <div class="form-group">
                            <label class="col-sm-6 control-label">
                                <span class="text-danger">*</span>认证说明：
                            </label>
                            <div class="col-sm-13">
                                <input type="text" class="" name="authName" id="addBrandName">换行请用"&amp;#10;"
                                <%--<span style='color:#a94442;font-weight: bold;display: none' id='helpTip' >品牌名称重复，请重新输入</span>--%>
                            </div>
                            <div class="col-sm-5">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-6">认证图片：</label>
                            <div class="col-sm-12">
                                <p class="pt5"><input type="file" name="picFile" id="logoFile"></p>
                                <iframe id="uploadFrame" name="uploadFrame" style="display:none;"></iframe>
                            </div>
                            <div class="col-sm-3">
                                <a href="javascript:;" class="brandLogo help_tips">
                                    <i class="icon iconfont">&#xe611;</i>
                                </a>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-6">预览：</label>
                            <div class="col-sm-12">
                                <img alt="" src="" id="preview_image" width="90px">
                            </div>
                            <div class="col-sm-1"></div>
                        </div>

                       <input type="hidden" name="authsrc" id="authsrc" />
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="submitSaveAuthForm();">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
            </form>
        </div>
    </div>
</div>

<script src="<%=basePath%>js/bootstrap.min.js"></script>
<script src="<%=basePath%>js/summernote.min.js"></script>
<script src="<%=basePath%>js/language/summernote-zh-CN.js"></script>
<script src="<%=basePath%>js/bootstrap-select.min.js"></script>
<script src="<%=basePath%>js/common.js"></script>
<script src="<%=basePath%>js/common/common_alert.js"></script>
<script src="<%=basePath%>js/common/common_checked.js"></script>
<script src="<%=basePath%>js/goods/goods_brand.js"></script>
<script src="<%=basePath%>js/goods/syngoodbrand.js"></script>


<script style="text/javascript">
    $(function () {
        var pageNo=parseInt($('.pageNo').val());
        var totalPages=parseInt($('.totalPage').val());

        var str="";
        if(pageNo==1){
        str+='<span class="disabled"> 上一页</span>'
        }
        if(pageNo>1){
            str+='<a  href="${pageContext.request.contextPath}/findAllAuth.htm?pageNo='+(pageNo-1)+'"> 上一页 </a>'
        }
        if(pageNo-2>1){
             str+='<span class=""> ...</span>'
        }
        for(var i=((pageNo-2)>0?(pageNo-2):1);i<=(pageNo+2<totalPages?(pageNo+2):totalPages);i++){
            if(i==pageNo){
                str+='<span class="current">'+i+'</span>'
            }else{
                str+='<a href="${pageContext.request.contextPath}/findAllAuth.htm?pageNo='+i+'">'+i+'</a>'
            }
        }
       if(pageNo+2<totalPages){
           str+='<span class=""> ...</span>'
       }
        if(pageNo==totalPages){
            str+='<span class="disabled"> 下一页</span>'
        }
        if(pageNo<totalPages){
            str+='<a  href="${pageContext.request.contextPath}/findAllAuth.htm?pageNo='+(pageNo+1)+'"> 下一页 </a>'
        }
        $('.meneame').empty();
        $('.meneame').append(str);
        //单个删除
        $('#deleteA').click(function(){
            var id=$(this).attr('val');
            var url="deleteAuth.htm?CSRFToken="+$("#CSRFToken").val();
            $.ajax({
                data:{"id":id},
                url:url,
                success:function(result){
                    if(result=="ok"){
                        window.location.reload();
                    }
                }
            })
        });
        //当全选 或 全不选
        $(".allcheck").click(function(){
                var flag=(this.checked);
                if(flag){
                   $('.checkid').each(function(){
                       this.checked=true;
                   })
                }else{
                    $('.checkid').each(function(){
                        this.checked=false;
                    })
                }
        });
        /*如果全部都勾选的时候那么全部选择也勾选 如果没有勾选全部的时候全部选择取消勾选*/
        $(".checkid").click(function(){
            var _this=document.getElementsByClassName("allcheck")[0];
            var size=$(".checkid").size();
            var count=0;
            $(".checkid").each(function(){
                if(this.checked==true){
                    count++;
                }
            })
            if(size==count){
                _this.checked=true;
            }else{
                _this.checked=false;
            }
        });
    })
    function deleteAuths(){
        var arrids=new Array;
        $('.checkid').each(function(){
            if(this.checked==true){
                arrids.push($(this).val());
            }
        })
        var ids=arrids.join(",");
        var url="deleteAuth.htm?CSRFToken="+$("#CSRFToken").val();
        $.ajax({
            data:{"ids":ids},
            url:url,
            success:function(result){
                if(result=="ok"){
                    window.location.reload();
                }
            }
        })
    }



</script>
</body>
</html>

