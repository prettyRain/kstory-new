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
    <title>审核会员头像列表</title>

    <!-- Bootstrap -->
    <link href="<%=basePath %>css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=basePath %>css/font-awesome.min.css">
    <link href="<%=basePath %>iconfont/iconfont.css" rel="stylesheet">
    <link href="<%=basePath %>css/summernote.css" rel="stylesheet">
    <link href="<%=basePath %>css/bootstrap-select.min.css" rel="stylesheet">
    <link href="<%=basePath %>css/select2.min.css" rel="stylesheet">
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
			<input type="hidden" value="${token }" id="hi_token"/>
            <h2 class="main_title">${pageNameChild} <small>(共${pageBean.rows}条)</small></h2>
            <div class="common_data p20">
            <div class="data_ctrl_area mb20">
              <div class="data_ctrl_search pull-right"></div>
              <div class="data_ctrl_brns pull-left">
                <button type="button" class="btn btn-info" onclick="operation(1,0);">
                  <i class="glyphicon glyphicon-ok"></i> 批量通过
                </button>
                <button type="button" class="btn btn-info" onclick="operation(2,0);">
                  <i class="glyphicon glyphicon-remove"></i> 批量拒绝
                </button>
              </div>
              <div class="clr"></div>
            </div>
	<form action="deleteAllNewCustomer.htm?CSRFToken=${token}" id="delForm" method="post">
	   			<input type="hidden" value="delForm" id="formId">
                  <input type="hidden" value="deleteAllNewCustomer.htm" id="formName">
            <table class="table table-striped table-hover">
            <thead>
            <tr>
              <th width="10"><input type="checkbox" onclick="allunchecked(this,'customerId');"></th>
              <th>头像</th>
              <th>用户名</th>
              <th>操作</th>
            </tr>
            </thead>
            <tbody>
           
              <c:forEach items="${pageBean.list}" var="customer" varStatus="i">
		            <tr class="tr_${customer.customerId }">
		              <td><input type="checkbox" name="customerId"  value="${customer.customerId }"></td>
		              <td>
                          <img class="img_circle" onmouseover="this.style.cursor='pointer';this.style.cursor='hand'" onmouseout="this.style.cursor='default'" onclick="javascript:showimage(this.src);" src="${customer.toAuditImg}"  height="50" width="50" title="点击查看大图" />
		              </td>
		              <td>
		              	${customer.customerUsername}
		              </td>

		              <td>
                          <a class="btn btn-success" href="javascript:operation(1,${customer.customerId });" role="button"><span class="glyphicon glyphicon-ok"></span>&nbsp;通过</a>
                          <a class="btn btn-danger" href="javascript:operation(2,${customer.customerId });" role="button"><span class="glyphicon glyphicon-remove"></span>&nbsp;拒绝</a>
		              </td>
		            </tr>
          
          </c:forEach>
          
            </tbody>
            </table>
		</form>
            <div class="table_foot">
         		<c:import url="../page/searchPag.jsp">
				     <c:param name="pageBean" value="${pageBean }"/>
				     <c:param name="path" value="../"></c:param>
				</c:import>
         
            </div>

            </div>

          </div>
        </div>
      </div>
    </div>

   <div class="modal fade" id="ShowImage_Form" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
       <div class="modal-dialog" role="document">
           <div class="modal-content">
               <div class="modal-header">
                   <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                   <h4 class="modal-title" id="myModalLabel">查看头像</h4>
               </div>
               <div class="modal-body">
                   <div id="img_show">
               </div>
               <div class="modal-footer">
                   <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
               </div>
           </div>
       </div>
   </div>

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="<%=basePath %>js/bootstrap.min.js"></script>
    <script src="<%=basePath %>js/summernote.min.js"></script>
    <script src="<%=basePath %>js/language/summernote-zh-CN.js"></script>
    <script src="<%=basePath %>js/bootstrap-select.min.js"></script>
    <script src="<%=basePath %>js/common.js"></script>
    <script src="<%=basePath %>js/common/common_alert.js"></script>
    <script src="<%=basePath %>js/common/common_checked.js"></script>
    <script src="<%=basePath %>/js/select2.min.js"></script>
    <script>
        //显示大图
        function showimage(source){
            $("#ShowImage_Form").find("#img_show").html("<image src='"+source+"' height='500' width='500' />");
            $("#ShowImage_Form").modal("show");
        }

        //批量操作用户头像
        function operation(mark,cId){
            var ids=new Array();
            var imgpath=new Array();
            if(cId == 0){
                $("input[name='customerId']:checked").each(function(i){
                    ids[i]=$(this).val();
                    imgpath[i] = $(".tr_"+$(this).val()+" img").attr("src");
                });
            }else{
                 ids[0]=cId;
                imgpath[0] = $(".tr_"+cId+" img").attr("src");
            }
            jQuery.ajax({
                url: "customerAuditImg.htm?CSRFToken=${token}&customerIds="+ids+"&mark="+mark+"&imgpath="+imgpath,
                dataType: "json",
                type: "POST",
                success:function(data){
                    if(data > 0){
                        alert("操作成功");
                        window.location.href = location;
                    }else{
                        alert("操作失败");
                    }

                }
            });

        }

    </script>
  </body>
</html>
