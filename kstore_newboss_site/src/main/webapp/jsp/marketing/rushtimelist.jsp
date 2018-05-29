<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/19
  Time: 16:47
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
<%@ taglib prefix="fm" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>抢购时段</title>
    <!-- Bootstrap -->
    <link href="<%=basePath %>css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=basePath %>css/font-awesome.min.css">
    <link href="<%=basePath %>iconfont/iconfont.css" rel="stylesheet">
    <link href="<%=basePath %>css/summernote.css" rel="stylesheet">
    <link href="<%=basePath %>css/bootstrap-select.min.css" rel="stylesheet">
    <link href="<%=basePath %>css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <link href="<%=basePath %>css/bootstrapValidator.css" rel="stylesheet">
    <link href="<%=basePath %>css/zTreeStyle/zTreeStyle.css" rel="stylesheet">
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

                <h2 class="main_title">${pageNameChild} <small>(共${pb.rows }条)</small></h2>

                <div class="common_data p20">
                    <div class="filter_area">
                        <botton class="center-text btn btn-primary" onclick="$('#addRushTime').modal('show')" >添加</botton>
                        <botton class="center-text btn btn-primary delRushTimes" >删除</botton>
                    </div>

                    <table class="table table-striped table-hover" style="font-size:12px;">
                        <thead>
                        <tr>
                            <th width="80">
                                <input type="checkbox" id="allxuan" name="all" value="1" style="position:relative;top:2px;">全选
                            </th>

                            <th>名称</th>
                            <th>抢购时间段(几点)</th>
                            <th>结束时间</th>
                            <th>是否启用</th>
                            <th>创建时间</th>
                            <th width="150">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${pageBean.list}" var="rushTime" varStatus="i">
                            <tr>
                                <td><input type="checkbox" value="${rushTime.tId}" class="checktId" name="tId" style="position:relative;top:2px;"></td>
                                <td>${rushTime.temp1}</td>
                                <td>${rushTime.tDate}点</td>
                                <td><c:if test="${rushTime.temp2 != null}">${rushTime.temp2}点</c:if> </td>
                                <td>
                                    <c:if test="${rushTime.flag==0}">是</c:if>
                                    <c:if test="${rushTime.flag==1}">否</c:if>
                                </td>
                                <td><fmt:formatDate value="${rushTime.createTime}" pattern="yyyy/MM/dd HH:mm:ss"/></td>
                                <td>
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-default" onclick="updateRushTimeFun(${rushTime.tId });">编辑</button>
                                        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                            <span class="caret"></span>
                                            <span class="sr-only">Toggle Dropdown</span>
                                        </button>
                                        <ul class="dropdown-menu" role="menu">
                                            <li><a href="javascript:void(0);" class="delRushTime" data_tId="${rushTime.tId }">删除</a></li>
                                        </ul>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>

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

<!-- Modal -->
<div class="modal fade" id="addRushTime"  role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">添加抢购时间段</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" action="insertmaketinggroup.htm" method="post" id="defaultForm">
                    <div class="form-group">
                        <label class="control-label col-sm-5">名称：</label>
                        <div class="col-sm-1"></div>
                        <div class="col-sm-8">
                            <input type="hidden" name="CSRFToken" value="${token }">
                            <input type="text" class="form-control" name="rushTimename" id="rushTimename">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-5">抢购时间段：</label>
                        <div class="col-sm-1"></div>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" name="tDate" id="tDate" placeholder="整点">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-5">抢购结束时间：</label>
                        <div class="col-sm-1"></div>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" name="endrushTime" id="endDate" placeholder="整点">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-5">是否开启：</label>
                        <div class="col-sm-1"></div>
                        <div class="col-sm-8">
                            <label class="radio-inline">
                                <input type="radio" name="flag" class="flag" value="0" checked="true"> 是
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="flag" class="flag" value="1"> 否
                            </label>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">

                <button type="button" class="btn btn-primary " onclick="submitFun()">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <botton type="botton" class="btn btn-default resetBtn" onclick="resetFun()" >重置</botton>
            </div>
        </div>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="updateRushTime"  role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">添加抢购时间段</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" action="insertmaketinggroup.htm" method="post" id="updatedefaultForm" >
                    <input type="hidden" name="tId" id="uptId"/>
                    <div class="form-group">
                        <label class="control-label col-sm-5">名称：</label>
                        <div class="col-sm-1"></div>
                        <div class="col-sm-8">
                            <input type="hidden" name="CSRFToken" value="${token }">
                            <input type="text" class="form-control" name="rushTimename" id="updaterushTimename">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-5">抢购时间段：</label>
                        <div class="col-sm-1"></div>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" name="tDate" id="updatetDate" placeholder="整点">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-5">抢购结束时间：</label>
                        <div class="col-sm-1"></div>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" name="endrushTime" id="updatetEndDate" placeholder="整点">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-5">是否开启：</label>
                        <div class="col-sm-1"></div>
                        <div class="col-sm-8">
                            <label class="radio-inline">
                                <input type="radio" name="flag" class="upflag" value="0" checked="true" > 是
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="flag" class="upflag" value="1" > 否
                            </label>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary " id="updatesubmitFun">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal" >取消</button>
                <botton type="botton" class="btn btn-default resetBtn" id = "updateresetFun" >重置</botton>
            </div>
        </div>
    </div>
</div>




<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="<%=basePath %>js/bootstrap.min.js"></script>
<script src="<%=basePath %>js/bootstrapValidator.js"></script>
<script src="<%=basePath %>js/bootstrap-select.min.js"></script>
<script src="<%=basePath %>js/common/common_alert.js"></script>

<script src="<%=basePath%>js/summernote.min.js"></script>
<script src="<%=basePath%>js/language/summernote-zh-CN.js"></script>
<script src="<%=basePath%>js/common.js"></script>
<script src="<%=basePath%>js/common/common_alert.js"></script>
<script src="<%=basePath%>js/select2.min.js"></script>
<script>
    /*校验 添加  编辑*/
    function MarketingRushTime(option){
        this.validateForm = option.defaultForm;
        this._init();
    }
    MarketingRushTime.prototype={
        _init:function(){
            this.validateFun();
        },
        validateFun:function(){
            var _this = this;
            $(this.validateForm).bootstrapValidator({
                message: 'This value is not valid',
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    rushTimename: {
                        message: '名称无效',
                        validators: {
                            notEmpty: {
                                message: '名称不能位空'
                            },
                            regexp: {
                                regexp: /^[^.]{1,20}$/,
                                message: '不能超过20位'
                            },
                        }
                    },
                    endrushTime: {
                        validators: {
                            callback: {
                                message: '结束时间必须大于开始时间且为数字',
                                callback: function (value, validator, $field) {
                                    var tDate = validator.getFieldElements("tDate").val();//获得另一个的值
                                    if (value == '' ) {
                                        return true;
                                    } else {
                                        //不是数字
                                        if(isNaN(value)){
                                            return false;
                                        }
                                        if (parseInt(tDate) < parseInt(value)) {
                                            return true;
                                        } else {
                                            return false;
                                        }
                                    }
                                }
                            }
                        }
                    },
                    tDate: {
                        validators: {
                            notEmpty: {
                                message: '时间不能位空'
                            },
                            regexp: {
                                regexp: /^((\d)|(1\d)|(2[0-4]))$/,
                                message: '时间只能是0-24的数字'
                            },
                            callback: {
                                message: '时间不合法（已被占用或大于结束时间）',
                                callback: function(value, validator) {
                                    var endrushTime = validator.getFieldElements("endrushTime").val();//获得另一个的值
                                    if (endrushTime !='') {
                                        if (parseInt(endrushTime) <= parseInt(value)) {
                                                return false;
                                        }
                                    }

                                    var flag = true;
                                    $.ajax({
                                        url:'queryTDates.htm?CSRFToken=${token}',
                                        async:false,
                                        success:function(data){
                                            console.log(data);
                                            if(data!=null || data.length>0){
                                                for(var i in data){
                                                    if(parseInt(data[i])==parseInt(value)&&parseInt(data[i])!=parseInt(_this.tDate)){
                                                        flag = false;
                                                    }
                                                }
                                            }
                                        }
                                    })
                                    return flag;
                                }
                            }
                        }
                    },
                }
            });
        },
        submitAdd:function(){
            $(this.validateForm).bootstrapValidator('validate');
            var flag = $(this.validateForm).data('bootstrapValidator').isValid();
            console.log(flag);
            if(flag){
                $.ajax({
                    data:$(this.validateForm).serialize(),
                    type:'post',
                    url:"/addmarketrushtime.htm?CSRFToken=${token}",
                    success:function(data){
                        console.log(data);
                        window.location.reload();
                    }
                })
            }
        },
        resetAdd:function(){
            $(this.validateForm).data('bootstrapValidator').resetForm(true);
        },
        submitUpdate:function(){
            $(this.validateForm).bootstrapValidator('validate');
            var flag = $(this.validateForm).data('bootstrapValidator').isValid();
            console.log(flag);
            if(flag){
                $.ajax({
                    data:$(this.validateForm).serialize(),
                    type:'post',
                    url:"/updatemarketrushtime.htm?CSRFToken=${token}",
                    success:function(data){
                        window.location.reload();
                    }
                })
            }
        }
    }
    var addObject = new MarketingRushTime({defaultForm:"#defaultForm"})
    function submitFun(){
            addObject.submitAdd();
    }
    function resetFun(){
            addObject.resetAdd();
    }

    function updateRushTimeFun(timeId){
         $.get("queryrushtimeById.htm",{tId:timeId,CSRFToken:"${token}"},function(data){
             console.log(data);
             $('#updaterushTimename').val(data.temp1);
             $('#updatetDate').val(data.tDate);
             if(data.flag=='0'){
                 $('.upflag:eq(0)').attr("checked",true);
             }else{
                 $('.upflag:eq(1)').attr("checked",true);
             }
             $('#updatetEndDate').val(data.temp2);
             !!data.temp2&&$('#updatetEndDate').val(data.temp2);

             $('#uptId').val(timeId);
             $('#updateRushTime').modal('show');
             var updateObject = new MarketingRushTime({defaultForm:"#updatedefaultForm"})
             updateObject.tDate = data.tDate;
             $("#updateresetFun").click(function(){
                 updateObject.resetAdd();
             })
             $("#updatesubmitFun").click(function(){
                updateObject.submitUpdate();
             })
         })



    }
    /*删除*/
   $('.delRushTime').click(function(event){
       event.preventDefault;
       window.location.href="/delrushtime.htm?tId="+$(this).attr("data_tId")+"&CSRFToken=${token}";
   })
    /*批量删除*/
    $('.delRushTimes').click(function(event){
        console.log(22);
        var arr=[];
        $('.checktId:checked').each(function(index,item){
             arr.push(item.value);
        })
        if(arr.length>0){
            window.location.href="/delrushtimes.htm?tId="+arr+"&CSRFToken=${token}";
        }

    })
   /*全选*/
   $('#allxuan').on('click',function(event){

       if($(this).is(':checked')){
           $('input[name="tId"]').each(function(item,index){
               this.checked=true;
           })
       }else{
           $('input[name="tId"]').each(function(item,index){
               this.checked=false;
           })
       }
   })
    $('.checktId').click(function(){
        var len = $('.checktId').length;
         var checkedlen = $('.checktId:checked').length;
         console.log(len+"--"+checkedlen);
         if(len==checkedlen){
             $('#allxuan').get(0).checked=true;
         }else{
             $('#allxuan').get(0).checked=false;
         }
    })


</script>
</body>
</html>
