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
    <title>礼品卡制作</title>

    <!-- Bootstrap -->
    <link href="<%=basePath %>css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=basePath %>css/font-awesome.min.css">
    <link href="<%=basePath %>iconfont/iconfont.css" rel="stylesheet">
    <link href="<%=basePath %>css/summernote.css" rel="stylesheet">
    <link href="<%=basePath %>css/bootstrap-select.min.css" rel="stylesheet">
    <link href="<%=basePath %>css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <link href="<%=basePath %>css/bootstrapValidator.css" rel="stylesheet">
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
    <style>
        .giftcardNoList{
            display: none;
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
                    <div class="filter_area mb10">
                        <%--分页提交的表单--%>
                        <form role="form" class="form-inline" id="searchForm2">
                            <input type="hidden" value="searchForm2" id="formId">
                            <input type="hidden" value="${pageBean.url}" id="formName">
                        </form>
                        <form role="form" class="form-inline" id="searchForm">
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">卡号前段</span>
                                    <input type="text" class="form-control" id="cardPrefix" name="cardPrefix">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">卡号中段</span>
                                    <input type="text" class="form-control" id="cardMid" name="cardMid">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">卡号后段</span>
                                    <input type="text" class="form-control" id="cardSuffix" name="cardSuffix" >
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">礼品卡金额</span>
                                    <input type="text" class="form-control" id="cardPrice" name="cardPrice" min="0.00" step="0.01">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">礼品卡张数</span>
                                    <input type="text" class="form-control" id="cardNum" name="cardNum" min="1">
                                </div>
                            </div>
                            <div class="form-group">
                                <button type="submit" class="btn btn-primary" id="submitMake">制作礼品卡</button>
                            </div>
                        </form>
                    </div>

                    <table class="table table-striped table-hover">
                        <thead>
                        <tr>
                            <th>卡段序号</th>
                            <th>卡号前段</th>
                            <th>卡号中段</th>
                            <th>卡号后段</th>
                            <th>礼品卡金额</th>
                            <th>礼品卡张数</th>
                            <th width="150">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:if test="${fn:length(pageBean.list)<=0}">
                            <tr>
                                <td style="text-align: center;" colspan="7">暂无数据</td>
                            </tr>
                        </c:if>
                        <c:forEach items="${pageBean.list}" var="giftcard" varStatus="i">
                            <tr>
                                <td>
                                        ${i.count}
                                </td>
                                <td>
                                    ${giftcard.cardPrefix}
                                </td>
                                <td>
                                    ${giftcard.cardMid}
                                </td>
                                <td>
                                    ${giftcard.cardSuffix}
                                </td>
                                <td>
                                    ${giftcard.cardPrice}
                                </td>
                                <td>
                                    ${giftcard.cardNum}
                                </td>
                                <td>
                                    <div class="btn-group">
                                        <a href="javascript:;" onclick="openSegment(${giftcard.id})" class="scan_member">查看</a>
                                        <a href="javascript:void(0);" class="btn btn-default dropdown-toggle" data-toggle="dropdown" >
                                            <span class="caret"></span>
                                            <span class="sr-only">Toggle Dropdown</span>
                                        </a>
                                        <ul class="dropdown-menu" role="menu">
                                            <li><a href="javascript:void(0);" onclick="window.open('exportCardNo.htm?CSRFToken=${token}&id=${giftcard.id }');" style="padding-right: 20px;">导出</a></li>
                                            <%--<li><a href="javascript:void(0);" onclick="deleteSegment('${giftcard.id }');">删除</a></li>--%>
                                        </ul>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <c:import url="../page/searchPag.jsp">
                        <c:param name="pageBean" value="${pageBean }"/>
                        <c:param name="path" value="../"></c:param>
                    </c:import>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="scanGiftcard"  role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">礼品卡列表</h4>
            </div>
            <div class="modal-body">
                <div class="common_info common_tabs mt20">
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane active" id="tab1">
                            <table class="table table-striped table-hover table-bordered">
                                <thead>
                                <tr>
                                    <th>礼品卡号</th>
                                    <th width="100">状态</th>
                                    <th>激活时间</th>
                                    <th>激活人</th>
                                </tr>
                                </thead>
                                <tbody id="giftcardNoList">

                                </tbody>
                            </table>
                            <div class="table_foot">
                                <div class="table_pagenav pull-right">
                                    <div class="meneame" id="giftcardNoPage">

                                    </div>
                                </div>
                                <div class="clr"></div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<script src="<%=basePath %>js/bootstrap.min.js"></script>
<script src="<%=basePath %>js/bootstrapValidator.js"></script>
<script src="<%=basePath %>js/bootstrap-select.min.js"></script>
<script src="<%=basePath %>js/common/common_alert.js"></script>
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
        //表单非空验证
        $("#searchForm").bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                cardPrefix: {
                    validators: {
                        notEmpty: {
                            message: '卡号前段不能为空'
                        },
                        regexp: {
                            regexp: /^[1-35-9][0-35-9]{2}$/,
                            message: '卡号前段为不包含4的3位数字'
                        }
                    }
                },
                cardMid: {
                    validators: {
                        notEmpty: {
                            message: '卡号中段不能为空'
                        },
                        regexp: {
                            regexp: /^[0-35-9]{4}$/,
                            message: '卡号中段为不包含4的4位数字'
                        }
                    }
                },
                cardSuffix: {
                    validators: {
                        notEmpty: {
                            message: '卡号后段不能为空'
                        },
                        regexp: {
                            regexp: /^[1-35-9][0-35-9]{5}$/,
                            message: '卡号后段为不以0开头且不包含4的6位数字'
                        }
                    }
                },
                cardPrice: {
                    validators: {
                        notEmpty: {
                            message: '金额不能为空'
                        }
                    }
                },
                cardNum: {
                    validators: {
                        notEmpty: {
                            message: '张数不能为空'
                        }
                    }
                }
            },
            submitButtons: 'button[type="submit"]',
            submitHandler: function (validator, form, submitButton) {

            }
        });


        $("#submitMake").click(function () {
            var form = $("#searchForm");
            //进行表单验证
            var bv = form.data('bootstrapValidator');
            bv.validate();
            if (bv.isValid()) {
                $.ajax({
                    url: "makeGiftcard.htm?CSRFToken=${token }",
                    async: false,
                    type: "post",
                    data: form.serialize(),
                    success: function (result) {
                        if (result==1) {
                            showTipAlert("生成卡号成功！", function () {
                                location.href = "/toMakeGiftcard.htm";
                            });
                        } else if(result==-1) {
                            showTipAlert("您要生成的卡号已存在，请核对后再重新生成！", function () {
                                $("#submitMake").removeAttr("disabled");
                            });
                        } else if(result==2) {
                            showTipAlert("您要生成的卡号会超出位数，请重新填写！", function () {
                                $("#submitMake").removeAttr("disabled");
                            });
                        }
                    }, error: function () {
                        showTipAlert("生成卡号失败，请联系管理员！", function () {
                            $("#submitMake").removeAttr("disabled");
                        });
                    }
                })
            }
        });
    });
    /* 查看卡段下礼品卡列表 */
    function openSegment(id) {
        $.ajax({
            url:'selectCardSegmentAjax.htm?id='+id,
            async : false,
            success:function(data){
                if(data != ""){
                    if(data.pageBean != "") {
                        var str ="";
                        var strpage="";
                        $("#giftcardNoList").html("");
                        $("#giftcardNoPage").html("");
                        var num = pageRows(data.pageBean,10);
                        $.each(data.pageBean,function(idx,item){
                            if(idx<10){
                                str+='<tr id="couponsnonum'+idx+'" class="">';
                            }else{
                                str+='<tr id="couponsnonum'+idx+'" class="giftcardNoList">';
                            }
                            str +='<td>'+item.giftcardNo;
                            if(item.activeFlag == '-1') {
                                str +='</td><td>无效';
                            }else if(item.activeFlag == '0') {
                                str +='</td><td>未激活';
                            }else if(item.activeFlag == '1') {
                                str +='</td><td>已激活';
                            }else if(item.activeFlag == '2') {
                                str +='</td><td>已失效';
                            }
                            if(item.activeTime == null) {
                                str +='</td><td>';
                            }else{
                                str +='</td><td>'+timeObject(item.activeTime);
                            }
                            if(item.activeName == null) {
                                str +='</td><td>';
                            }else{
                                str +='</td><td>'+item.activeName;
                            }
                            str =='</td></tr>';
                        });
                        $("#giftcardNoList").html(str);
                        var start = parseInt(getStart(1,num));
                        var end = parseInt(getEnd(1,num));
                        strpage +='<span class="disabled"> 上一页 </span>';
                        if(start>2){
                            strpage +='<a href="javascript:;" onclick="pagecouponsno(1,'+parseInt(num)+')">1</a>';
                            strpage +='<span class="current">...</span>';
                        }
                        for(var i=start;i<=end;i++){
                            if(1==i){
                                strpage +='<span class="current">'+i+' </span>';
                            }else{
                                strpage +='<a href="javascript:;" onclick="pagecouponsno('+i+','+parseInt(num)+')">'+i+' </a>';
                            }
                        }

                        if(num>end+1){
                            strpage +='<span class="current">...</span>';
                            strpage +='<a href="javascript:;" onclick="pagecouponsno('+parseInt(num)+','+parseInt(num)+')">'+parseInt(num)+'</a>';
                        }
                        if(num>1){
                            strpage+='<a href="javascript:;" onclick="pagecouponsno(2,'+num+')">下一页 </a>';
                        }else{
                            strpage+='<span class="disabled"> 下一页 </span>';
                        }
                        $("#giftcardNoPage").html(strpage);
                    }
                }
                $('#scanGiftcard').modal('show');
            }
        });
    }

    function pagecouponsno(pageNo,rows) {
        var start = parseInt(getStart(pageNo,rows));
        var end = parseInt(getEnd(pageNo,rows));
        $("#giftcardNoPage").html("");
        var strpage = "";
        if(pageNo>1){
            strpage +='<a href="javascript:;" onclick="pagecouponsno('+(pageNo-1)+','+rows+')"> 上一页 </a>';
        }else{
            strpage +='<span class="disabled"> 上一页 </span>';
        }
        if(start>2){
            strpage +='<a href="javascript:;" onclick="pagecouponsno(1,'+parseInt(rows)+')">1</a>';
            strpage +='<span class="current">...</span>';
        }
        for(var i=start;i<=end;i++){
            if(pageNo==i){
                strpage +='<span class="current">'+i+' </span>';
            }else{
                strpage +='<a href="javascript:;" onclick="pagecouponsno('+i+','+parseInt(rows)+')">'+i+' </a>';
            }
        }

        if(rows>end+1){
            strpage +='<span class="current">...</span>';
            strpage +='<a href="javascript:;" onclick="pagecouponsno('+parseInt(rows)+','+parseInt(rows)+')">'+parseInt(rows)+'</a>';
        }

        if(pageNo<rows){
            strpage+='<a href="javascript:;" onclick="pagecouponsno('+(pageNo+1)+','+rows+')"> 下一页 </a>';
        }else{
            strpage+='<span class="disabled"> 下一页 </span>';
        }


        $("#giftcardNoPage").html(strpage);
        $("#giftcardNoList tr").attr("class","giftcardNoList");
        $("#couponsnonum"+(pageNo*10-1)).attr("class","");
        $("#couponsnonum"+(pageNo*10-2)).attr("class","");
        $("#couponsnonum"+(pageNo*10-3)).attr("class","");
        $("#couponsnonum"+(pageNo*10-4)).attr("class","");
        $("#couponsnonum"+(pageNo*10-5)).attr("class","");
        $("#couponsnonum"+(pageNo*10-6)).attr("class","");
        $("#couponsnonum"+(pageNo*10-7)).attr("class","");
        $("#couponsnonum"+(pageNo*10-8)).attr("class","");
        $("#couponsnonum"+(pageNo*10-9)).attr("class","");
        $("#couponsnonum"+(pageNo*10-10)).attr("class","");
    }
    // 数字 15
    var FIFTEEN = 15;
    // 数字 10
    var TEN = 10;
    // 数字 9
    var  NINE = 9;
    // 数字 5
    var  FIVE = 5;
    // 数字 4
    var  FOUR = 4;
    /**
     * 获取显示的开始页码数与 @see {@link com.ningpai.util.PageBean#getEnd()} 相对存在
     *
     * @return 页码显示10个 {@link java.lang.Integer}
     */
    function getStart(pageNo,totalPages) {
        if (pageNo / TEN < 1) {
            return 1;
        } else {
            if (pageNo == totalPages) {
                return pageNo - NINE;
            } else {
                if (totalPages - pageNo < TEN) {
                    return totalPages - NINE;
                } else {
                    return pageNo - FOUR;
                }
            }

        }
    }

    /**
     * 获取显示的结束页码数 {@link com.ningpai.util.PageBean#getStart()}
     *
     * @return 结束的页码数
     */
    function  getEnd(pageNo,totalPages) {
        if (pageNo / FIVE < 1) {
            if (totalPages > FIVE) {
                return FIVE;
            } else {
                return totalPages;
            }
        } else {
            if (pageNo == FIVE) {
                return FIVE;
            }
            if (pageNo == totalPages) {
                return totalPages;
            }else{
                if (totalPages - pageNo < FIVE) {
                    return totalPages;
                } else {
                    return pageNo + FIVE;
                }
            }
        }
    }
    //判断数据是否为空为空返回“”
    function notNull(obj){
        if(obj != null && obj != undefined){
            return obj;
        }else{
            return "";
        }
    }

    //转换时间格式
    function timeObject(obj){
        var date = "/Date(" +notNull(obj)+")/";
        var time = new Date(parseInt(date.replace("/Date(", "").replace(")/", ""), 10));
        var result = time.getFullYear() + "-" + (time.getMonth() + 1 < 10 ? "0" + (time.getMonth() + 1) : time.getMonth() + 1) + "-" + (time.getDate() < 10 ? "0" + time.getDate() : time.getDate()) + " " + (time.getHours() < 10 ? "0" + time.getHours() : time.getHours()) + ":" + (time.getMinutes() < 10 ? "0" + time.getMinutes() : time.getMinutes())+ ":" + (time.getSeconds() < 10 ? "0" + time.getSeconds() : time.getSeconds());
        return result;
    }

    function pageRows(obj,pageSize){
        //计算页数
        var num = 0;
        if(obj.length<=pageSize){
            num =1;
        }else if(obj.length%pageSize == 0){
            num = obj.length/pageSize;
        }else{
            num = obj.length/pageSize+1;
        }
        return num;
    }
</script>
</body>
</html>