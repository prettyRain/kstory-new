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
        <c:set var="nowDate" value="<%=System.currentTimeMillis()%>"></c:set>
        <div class="col-lg-20 col-md-19 col-sm-18 main">
            <jsp:include page="../page/left2.jsp"></jsp:include>
            <div class="main_cont">
                <jsp:include page="../page/breadcrumbs.jsp"></jsp:include>

                <h2 class="main_title">${pageNameChild} <small>(共${pageBean.rows}条)</small></h2>
                <div class="common_data p20">
                    <div class="data_ctrl_area mb20">

                        <div class="data_ctrl_brns pull-left">
                            <a class="btn btn-info" href="/noticeAdd.htm" role="button"><i class="glyphicon glyphicon-plus"></i> 添加</a>
                        </div>
                        <div class="data_ctrl_search pull-right">
                            <form role="form" class="form-inline" action="/noticeList.htm" method="post">
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon">推送平台</span>
                                        <select class="form-control cate_selector w150" name="platform">
                                            <option value="-1" <c:if test="${platform == -1 }">selected="selected"</c:if>>ios_Android</option>
                                            <option value="1" <c:if test="${platform == 1 }">selected="selected"</c:if>>ios开发环境</option>
                                            <option value="2" <c:if test="${platform == 2 }">selected="selected"</c:if>>ios生产环境</option>
                                            <option value="3" <c:if test="${platform == 3 }">selected="selected"</c:if>>Android</option>
                                            <%--<option value="4" <c:if test="${platform == 4 }">selected="selected"</c:if>>Android生产环境</option>--%>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon">接受对象</span>
                                        <select class="form-control cate_selector w150" name="crowd">
                                            <option value="" <c:if test="${empty crowd}">selected="selected"</c:if>>所有人</option>
                                            <option value="Tags" <c:if test="${crowd == 'Tags' }">selected="selected"</c:if>>标签（Tag）</option>
                                            <option value="Reg.ID" <c:if test="${crowd == 'Reg.ID' }">selected="selected"</c:if>>Reg.ID</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon">推送方式</span>
                                        <select class="form-control cate_selector w150" name="sendType">
                                            <option value="0" <c:if test="${sendType == 0 }">selected="selected"</c:if>>全部</option>
                                            <option value="1" <c:if test="${sendType == 1 }">selected="selected"</c:if>>立即</option>
                                            <option value="2" <c:if test="${sendType == 2 }">selected="selected"</c:if>>定时</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <span class="input-group-addon">推送内容</span>
                                        <input type="text" value="${content}" name="content" class="form-control">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn btn-primary">搜索</button>
                                </div>
                            </form>
                        </div>

                    </div>
                        <table class="table table-striped table-hover" >
                            <thead>
                            <tr>
                                <th><input type="checkbox" onclick="allunchecked(this,'inforSubjectIds')"></th>
                                <th>发送时间</th>
                                <th>推送内容</th>
                                <th>推送平台</th>
                                <th>接受对象</th>
                                <th>跳转方式</th>
                                <th>推送方式</th>
                                <th>推送结果</th>
                                <th>创建时间</th>
                                <th width="150">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <input type="hidden" name="CSRFToken"  value="${token}">
                            <c:forEach var="notice" items="${pageBean.list }" varStatus="status">
                                <tr>
                                    <td><input type="checkbox" name="inforSubjectIds"  value="${notice.id }"/></td>
                                    <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${notice.sendTime }"/></td>
                                    <td width="200">${notice.content }</td>
                                    <td>
                                        <c:if test="${notice.platform==0}">ios_Android</c:if>
                                        <c:if test="${notice.platform==1}">ios</c:if>
                                        <c:if test="${notice.platform==2}">ios</c:if>
                                        <c:if test="${notice.platform==3}">Android</c:if>
                                        <c:if test="${notice.platform==4}">Android</c:if>
                                    </td>
                                    <td width="200">
                                        <c:choose>
                                            <c:when test="${empty notice.crowd}">
                                                所有人
                                            </c:when>
                                            <c:otherwise>
                                                ${notice.crowd}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td width="150">
                                        <c:choose>
                                            <c:when test="${empty notice.url}">
                                            默认首页
                                            </c:when>
                                            <c:otherwise>
                                                ${notice.url}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:if test="${notice.sendType==1}">立即</c:if>
                                        <c:if test="${notice.sendType==2}">定时</c:if>
                                    </td>
                                    <td>
                                        <c:if test="${notice.status==0}"><span class="label label-success">推送成功</span></c:if>
                                        <c:choose>
                                            <c:when test="${notice.pushStatus== 0}">
                                                <span class="label label-default">未发送</span>
                                            </c:when>
                                            <c:when test="${notice.pushStatus== 1}">
                                                <span class="label label-danger">正在发送</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="label label-success">已发送</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${notice.createTime }"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${notice.sendType == 2 && nowDate-notice.sendTime.getTime() < 0}">
                                                <a href="javascript:;" onclick="deleteNotice('${notice.msgId}','${notice.sendTime}');">删除</a>
                                            </c:when>
                                            <c:otherwise>
                                                --
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
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
</div>
</div>



<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="<%=basePath %>js/bootstrap.min.js"></script>
<script src="<%=basePath %>js/common.js"></script>
<script src="<%=basePath %>js/mobile/qrcode.min.js"></script>
<script src="<%=basePath %>js/common/common_alert.js"></script>
<script type="text/javascript">

    function deleteNotice(msgId,time){
        var sysDate = new Date();
        if(sysDate > time){
            showTipAlert("无法删除此条通知！");
            return;
        }
        simpleConfirm("确定要删除此条通知吗？",function(){
            $.ajax({
                type: "post",
                url:'ajaxDeleteNotice.htm?CSRFToken=${token}&scheduleId='+msgId,
                async:false,
                success: function (result) {
                    if(result == 1){
                        showTipAlert("删除成功");
                    }else{
                        showTipAlert("删除失败，请稍后重试！");
                    }
                    setTimeout(function() {window.location.href = location; },2000)
                }
            });
        });
    }

</script>
</body>
</html>