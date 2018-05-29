<%--
  Created by IntelliJ IDEA.
  User: NP-Heh
  Date: 2015/4/13
  Time: 14:36
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
    <link rel="<%=basePath %>stylesheet" href="css/font-awesome.min.css">
    <link href="<%=basePath %>iconfont/iconfont.css" rel="stylesheet">
    <link href="<%=basePath %>css/summernote.css" rel="stylesheet">
    <link href="<%=basePath %>css/bootstrap-select.min.css" rel="stylesheet">
    <link href="<%=basePath %>css/select2.min.css" rel="stylesheet">
    <link href="<%=basePath %>css/style.css" rel="stylesheet">
    <link href="<%=basePath %>css/style_new.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=basePath %>css/addressManager.css">
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
        .btn{padding:6px 4px;}

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


                <div class="cate_set container-fluid mt20">
                    <div class="alert alert-warning alert-dismissible" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        地区修改和删除可能会对仓库产生影响，如修改或删除，请及时修改仓库管理中的分仓地区。
                    </div>

                    <div class="data_ctrl_area mb20">
                        <div class="data_ctrl_search pull-right"></div>
                        <div class="data_ctrl_brns pull-left">
                            <button type="button" class="btn btn-info" onclick=" $('#setdefault').modal('show')">
                                <i class="glyphicon glyphicon"></i> &nbsp;&nbsp;&nbsp;添加地址&nbsp;&nbsp;&nbsp;&nbsp;
                            </button>
                            <button type="button" class="btn btn-info" onclick="batchDeleteAddress()">
                                <i class="glyphicon glyphicon"></i> &nbsp;&nbsp;&nbsp;删除地址&nbsp;&nbsp;&nbsp;&nbsp;
                            </button>
                            <span class="showDefaultAddress">(默认地区：${defaultProvince.provinceName}-${defaultCity.cityName}-${defaultDistrict.districtName})</span>
                        </div>
                        <div class="clr"></div>
                    </div>
                    <div class="address_table" style="padding-bottom:33px;">
                        <table>
                            <thead>
                                <tr>
                                    <th style="width:60px;padding-left:5px;"><input type="checkbox" name="" class="addressAll">全选</th>
                                    <th>省份</th>
                                    <th>城市</th>
                                    <th>区县</th>
                                    <th>创建时间</th>
                                    <th>修改</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%--<tr>
                                    <td style="width:60px;padding-left:5px;"><input type="checkbox" name="" id="" ></td>
                                    <td>北京</td>
                                    <td>北京</td>
                                    <td>海淀区</td>
                                    <td class="tdbtn"><span>修改</span>-<span>删除</span>-<span>设为默认</span></td>
                                </tr>--%>
                            </tbody>
                        </table>
                        <div class="table_pagenav pull-right" id="rightPage">
                            <div class="meneame">
                               <%-- <span class="disabled"> 上一页 </span>
                                <a  href="javascript:void(0);"  onclick="changeNextPage(${pageBean.pageSize },1)" >1 </a>
                                <span class="current"> ...</span>
                                <span class="disabled"> 下一页 </span>--%>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <input type="hidden" value="${token}"/>
                        <div class="col-xs-6 cate_set_column">
                            <div class="cate_set_item">
                                <%--<div class="cate_set_ctrl">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <button type="button" class="btn btn-info btn-block round5" onClick="showAddProvince()"><span class="glyphicon glyphicon-plus-sign"></span> 新增省份</button>
                                        </div>
                                        <div class="col-sm-1"></div>
                                        <div class="col-sm-11">
                                            <button type="button" class="btn btn-info btn-block round5" onClick="showEditProvince()"><span class="glyphicon glyphicon-edit"></span> 修改省份</button>
                                        </div>
                                    </div>
                                </div>--%>
                                <div class="cate_set_cont">
                                    <div class="cate_search">
                                        <input type="hidden" id="provinceId"/>
                                        <input type="text" id="provinceName" class="cate_search_box" placeholder="输入名称查找">
                                        <a href="javascript:;" onclick="findProvince()"><span class="glyphicon glyphicon-search"></span></a>
                                    </div>
                                    <div class="cate_set_list" id="province_list">

                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-xs-6 cate_set_column">
                            <div class="cate_set_item">
                                <%--<div class="cate_set_ctrl">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <button type="button" class="btn btn-info btn-block round5" onClick="showAddCity()"><span class="glyphicon glyphicon-plus-sign"></span> 新增城市</button>
                                        </div>
                                        <div class="col-sm-1"></div>
                                        <div class="col-sm-11">
                                            <button type="button" class="btn btn-info btn-block round5" onClick="showEditCity()" id="modifyCityBtn"><span class="glyphicon glyphicon-edit"></span> 修改城市</button>
                                        </div>
                                    </div>
                                </div>--%>
                                <div class="cate_set_cont">
                                    <div class="cate_search">
                                        <input type="hidden" id="cityId"/>
                                        <input type="text" id="cityName" class="cate_search_box" placeholder="输入名称查找">
                                        <a href="javascript:;" onclick="findCity()"><span class="glyphicon glyphicon-search"></span></a>
                                    </div>
                                    <div class="cate_set_list" id="city_list">

                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-xs-6 cate_set_column">
                            <div class="cate_set_item">
                                <%--<div class="cate_set_ctrl">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <button type="button" class="btn btn-info btn-block round5" onClick="showAddCounty()"><span class="glyphicon glyphicon-plus-sign"></span> 新增县区</button>
                                        </div>
                                        <div class="col-sm-1"></div>
                                        <div class="col-sm-11">
                                            <button type="button" class="btn btn-info btn-block round5" onClick="showEditDistrict()" id="modifyDistrictBtn"><span class="glyphicon glyphicon-edit"></span> 修改县区</button>
                                        </div>
                                    </div>
                                </div>--%>
                                <div class="cate_set_cont">
                                    <div class="cate_search">
                                        <input type="hidden" id="districtId"/>
                                        <input type="text" id="districtName" class="cate_search_box" placeholder="输入名称查找">
                                        <a href="javascript:;" onclick="findDistrict()"><span class="glyphicon glyphicon-search"></span></a>
                                    </div>
                                    <div class="cate_set_list" id="district_list">

                                    </div>
                                </div>
                            </div>
                        </div>

                        <%--街道用不到 暂时隐藏掉--%>
                        <div class="col-xs-6 cate_set_column" style="display: none">
                            <div class="cate_set_item">
                                <%--<div class="cate_set_ctrl">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <button type="button" class="btn btn-info btn-block round5" onClick="showAddStreet()"><span class="glyphicon glyphicon-plus-sign"></span> 新增街道</button>
                                        </div>
                                        <div class="col-sm-1"></div>
                                        <div class="col-sm-11">
                                            <button type="button" class="btn btn-info btn-block round5" onClick="showEditStreet()" id="modifyStreetBtn"><span class="glyphicon glyphicon-edit"></span> 修改街道</button>
                                        </div>
                                    </div>
                                </div>--%>
                                <div class="cate_set_cont">
                                    <div class="cate_search">
                                        <input type="hidden" id="streetId"/>
                                        <input type="text" id="streetName" class="cate_search_box" placeholder="输入名称查找">
                                        <a href="javascript:;" onclick="findStreet()"><span class="glyphicon glyphicon-search"></span></a>
                                    </div>
                                    <div class="cate_set_list" id="street_list">

                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>

            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="addProvince"  role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">添加省份</h4>
            </div>
            <div class="modal-body">
                <div class="modal_form">
                    <form role="form" class="form-horizontal" method="post" action="saveProvince.htm" id="saveProvinceForm">
                        <input type="hidden" name="CSRFToken" value="${token}"/>
                        <div class="form-group">
                            <label class="col-sm-6 control-label">
                                <span class="text-danger">*</span>省份名称：
                            </label>
                            <div class="col-sm-13">
                                <input type="text" class="form-control required specstr" name="addressName">
                            </div>
                            <div class="col-sm-5">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-6 control-label">
                                <span class="text-danger">*</span>排序：
                            </label>
                            <div class="col-sm-13">
                                <input type="text" class="form-control w100 required number" name="addressSort">
                            </div>
                            <div class="col-sm-5">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="submitAreaAddForm('saveProvinceForm',this)">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="addCity"  role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">添加城市</h4>
            </div>
            <div class="modal-body">
                <div class="modal_form">
                    <form role="form" class="form-horizontal" action="saveCity.htm" method="post" id="saveCityForm">
                        <input type="hidden" name="CSRFToken" id="CSRFToken" value="${token}">
                        <div class="form-group">
                            <label class="col-sm-6 control-label">
                                <span class="text-danger">*</span>城市名称：
                            </label>
                            <div class="col-sm-13">
                                <input type="text" class="form-control required specstr" name="addressName">
                            </div>
                            <div class="col-sm-5">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-6 control-label">
                                <span class="text-danger">*</span>排序：
                            </label>
                            <div class="col-sm-13">
                                <input type="text" class="form-control w100 required number" name="addressSort">
                            </div>
                            <div class="col-sm-5">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-6 control-label">
                                <span class="text-danger">*</span>所属省份：
                            </label>
                            <div class="col-sm-13">
                                <select class="required w150" data-live-search="true" id="provinces_city" name="parentId">

                                </select>
                            </div>
                            <div class="col-sm-5">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="submitAreaAddForm('saveCityForm',this)">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="addCounty"  role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">添加区县</h4>
            </div>
            <div class="modal-body">
                <div class="modal_form">
                    <form role="form" class="form-horizontal" action="saveDistrict.htm" id="saveDistrictForm" method="post">
                        <input type="hidden" name="CSRFToken" value="${token}">
                        <div class="form-group">
                            <label class="col-sm-6 control-label">
                                <span class="text-danger">*</span>区县名称：
                            </label>
                            <div class="col-sm-13">
                                <input type="text" class="form-control required specstr" name="addressName">
                            </div>
                            <div class="col-sm-5">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-6 control-label">
                                <span class="text-danger">*</span>排序：
                            </label>
                            <div class="col-sm-13">
                                <input type="text" class="form-control w100 required number" name="addressSort">
                            </div>
                            <div class="col-sm-5">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-6 control-label">
                                <span class="text-danger">*</span>所属省份：
                            </label>
                            <div class="col-sm-13">
                                <select class=" w150" data-live-search="true" onChange="queryCityByProvinceId(this,'cities_county');" id="provinces_county">
                                    <option>--请选择--</option>
                                </select>
                            </div>
                            <div class="col-sm-5">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-6 control-label">
                                <span class="text-danger">*</span>所属城市：
                            </label>
                            <div class="col-sm-13">
                                <select class="required  w150"  data-live-search="true" id="cities_county" name="parentId">
                                    <option value="">--请选择--</option>
                                </select>
                            </div>
                            <div class="col-sm-5">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="submitAreaAddForm('saveDistrictForm',this)">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="addStreet"  role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">添加街道</h4>
            </div>
            <div class="modal-body">
                <div class="modal_form">
                    <form role="form" class="form-horizontal" method="post" id="saveStreetForm" action="saveStreet.htm">
                        <input type="hidden" name="CSRFToken" value="${token}">
                        <div class="form-group">
                            <label class="col-sm-6 control-label">
                                <span class="text-danger">*</span>街道名称：
                            </label>
                            <div class="col-sm-13">
                                <input type="text" class="form-control required specstr" name="addressName">
                            </div>
                            <div class="col-sm-5">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-6 control-label">
                                <span class="text-danger">*</span>排序：
                            </label>
                            <div class="col-sm-13">
                                <input type="text" class="form-control w100 required number" name="addressSort">
                            </div>
                            <div class="col-sm-5">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-6 control-label">
                                <span class="text-danger">*</span>所属省份：
                            </label>
                            <div class="col-sm-13">
                                <select class=" w150" data-live-search="true" id="provinces_street" onChange="queryCityByProvinceId(this,'cities_street');">
                                    <option>--请选择--</option>
                                </select>
                            </div>
                            <div class="col-sm-5">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-6 control-label">
                                <span class="text-danger">*</span>所属城市：
                            </label>
                            <div class="col-sm-13">
                                <select class=" w150" data-live-search="true" id="cities_street" onChange='queryDistrictByCityId(this);'>
                                    <option>--请选择--</option>
                                </select>
                            </div>
                            <div class="col-sm-5">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-6 control-label">
                                <span class="text-danger">*</span>所属区县：
                            </label>
                            <div class="col-sm-13">
                                <select class="required  w150" data-live-search="true"  id="districts" name="parentId">
                                    <option value="">--请选择--</option>
                                </select>
                            </div>
                            <div class="col-sm-5">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="submitAreaAddForm('saveStreetForm',this)">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<!-- 设为默认地址Modal -->
<div class="modal fade" id="setdefault" role="dialog" width="">
    <div class="modal-dialog">
        <div class="modal-content">


            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">操作提示</h4>
            </div>
            <div class="modal-body">
                你确定要把选中的地址添加到地址列表吗?
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-primary" onclick="addAddress()"> &nbsp;&nbsp;&nbsp;确定 &nbsp;&nbsp;&nbsp;</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">&nbsp;&nbsp;&nbsp;取消 &nbsp;&nbsp;&nbsp;</button>
            </div>

        </div>
    </div>
</div>
<div class="modal fade" id="alreadyAdd" role="dialog" width="">
    <div class="modal-dialog">
        <div class="modal-content">


            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">操作提示</h4>
            </div>
            <div class="modal-body">
                此地址已经添加过
            </div>
            <div class="modal-footer">
                <%--<button type="submit" class="btn btn-primary" onclick="addAddress()"> &nbsp;&nbsp;&nbsp;确定 &nbsp;&nbsp;&nbsp;</button>--%>
                <button type="button" class="btn btn-default" data-dismiss="modal">&nbsp;&nbsp;&nbsp;取消 &nbsp;&nbsp;&nbsp;</button>
            </div>

        </div>
    </div>
</div>

<!-- 修改地区弹框 -->
<div class="modal fade" id="did"  role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title">修改已选择的地址</h4>
            </div>
            <div class="modal-body">
                <input type="hidden" name="did" value="">
                        <div class="form-group update-group">
                            <div class="col-sm-8">
                                <select class="col-sm-15" name="" id="pro" style="border:1px solid #ccc;border-radius:5px; outline:none;padding:3px 5px;">
                                    <option value="1">北京</option>
                                </select>
                            </div>
                            <div class="col-sm-8">
                                <select class="col-sm-15" name="" id="cit" style="border:1px solid #ccc;border-radius:5px; outline:none;padding:3px 5px;">
                                    <option value="11">北京</option>
                                </select>
                            </div>
                            <div class="col-sm-8">
                                <select class="col-sm-15" name="" id="dis" style="border:1px solid #ccc;border-radius:5px; outline:none;padding:3px 5px;">
                                    <option value="111">海淀区</option>
                                </select>
                            </div>
                        </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="saveUpdateAddress()">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<%--修改地址--%>
<input type="hidden" id="deleteLocation">


<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="<%=basePath%>js/bootstrap.min.js"></script>
<script src="<%=basePath%>js/summernote.min.js"></script>
<script src="<%=basePath%>js/language/summernote-zh-CN.js"></script>
<script src="<%=basePath%>js/bootstrap-select.min.js"></script>
<script src="<%=basePath%>js/bootstrap-select.min.js"></script>
<script src="<%=basePath%>js/common.js"></script>
<script src="<%=basePath%>js/common/common_alert.js"></script>
<script src="<%=basePath%>js/system/addressNew.js"></script>
<script src="<%=basePath %>js/select2.min.js"></script>
<script>
    var currentPage = 1;
    var pageSize = 5;
    queryAddressList(currentPage,pageSize);
    function pageNumber(countPage,currentPage){
        var  meneame = $('.meneame');
        var stringHTML = "";
        if(currentPage==1){
            stringHTML += '<span class="disabled"> 上一页 </span>';
        }else{
            stringHTML += '<a  href="javascript:void(0);"  onclick="queryAddressList(currentPage-1,pageSize)" >上一页</a>';
        }
        for(var i = currentPage-2>0?currentPage-2:1;i <= (currentPage+3>countPage?countPage:currentPage+3);i++){
            if(i == currentPage){
                stringHTML += '<span class="current">'+i+'</span>';
            }else{
                stringHTML += '<a  href="javascript:void(0);"  onclick="queryAddressList( '+i+',pageSize)" >'+i+'</a>';
            }
        }
        if(currentPage+3<countPage){
            stringHTML += '<span>...</span>';
        }
        if(countPage <= currentPage){
            stringHTML += '<span class="disabled"> 下一页 </span>';
        }else{
            stringHTML += '<a  href="javascript:void(0);"  onclick="queryAddressList(currentPage+1,pageSize)" >下一页</a>';
        }
        meneame.html(stringHTML);
    }
    function queryAddressList(currentpage,pageSize){
        currentPage = currentpage;
        $.ajax({
            url:"queryAddressList.htm?CSRFToken=${token}",
            data:{currentPage:currentPage,pageSize:pageSize},
            success:function(data){
                if(!!data){
                    var json = data;
                    var addressList = json.addressList;
                    if(addressList.length > 0){
                        var address_table = $(".address_table tbody");
                        var innerHTML = "";
                        for(var i = 0;i < addressList.length;i++){
                            innerHTML +='<tr>';
                            if(addressList[i].deFalg == 0){
                                innerHTML +='<td style="width:60px;padding-left:5px;"></td>'

                            }else{
                                innerHTML +='<td style="width:60px;padding-left:5px;"><input type="checkbox" name="" class="addressCheck" onclick="addressCheck();" ><input type="hidden" name="" value="'+addressList[i].districtId+'" ></td>'
                            }

                            innerHTML +='<td>'+addressList[i].province.provinceName+'</td>'
                                        +'<td>'+addressList[i].city.cityName+'</td>'
                                        +'<td>'+addressList[i].district.districtName+'</td>'
                                        +'<td>'+addressList[i].timeString+'</td>';
                                            if(addressList[i].deFalg == 0){
                                        innerHTML += '<td class="tdbtn"><span onclick="updateAddressSpan('+addressList[i].dId+','+addressList[i].province.provinceId+','+addressList[i].city.cityId+','+addressList[i].district.districtId+')">修改</span></td>';
                                            }else{
                                        innerHTML += '<td class="tdbtn"><span onclick="updateAddressSpan('+addressList[i].dId+','+addressList[i].province.provinceId+','+addressList[i].city.cityId+','+addressList[i].district.districtId+')">修改</span>-<span onclick="deleteAddress('+addressList[i].districtId+')">删除</span>-<span onclick="setDefaultAddress('+addressList[i].districtId+')">设为默认</span></td>';
                                            }
                                        innerHTML +='</tr>';
                        }
                        address_table.html(innerHTML);
                        //设置页码
                        pageNumber(json.countPage,currentPage);
                    }
                }

            }
        })
    }
    //单个选中
    function addressCheck(){
        var $addressCheck = $(".addressCheck");
        var count = 0;
        var size = $addressCheck.length;
         $addressCheck.each(function(index,value){
             console.log(value.checked);
             if(value.checked == true){
                    count++;
             }
         })
         if(count == size){
             $(".addressAll").get(0).checked=true;
         }else{
             $(".addressAll").get(0).checked=false;
         }
    }
    //全选
    $('.addressAll').click(function(){
        if(this.checked==true){
            $('.addressCheck').each(function(index,value){
                value.checked = true;
            })
        }else if(this.checked == false){
            $('.addressCheck').each(function(index,value){
                value.checked = false;
            })
        }
    })

    $(function(){

        /* 为选定的select下拉菜单开启搜索提示 */
        $('select[data-live-search="true"]').select2();
        /* 为选定的select下拉菜单开启搜索提示 END */

        /* 下面是表单里面的填写项提示相关的 */
        $('.xiaoshoujia').popover({
            content : '此价格只用于显示，以商品定价为商品销售价',
            trigger : 'hover'
        });

        /* 双击编辑分类 */
        $('.cate_item').dblclick(function(){
            $('#cateEdit').modal('show');
        });
        $('.cate_item').click(function(){
            $(this).parent().find("div.cate_item").each(function () {
                $(this).removeClass("active");
            });
            $(this).addClass("active");
        });

    });
    //添加地址到 地址列表
    function addAddress(){
        var curDistrictId = $("#districtId").val();
        var streetId = $("#streetId").val();
        $.ajax({
            url:"addAddressToAddressList.htm?CSRFToken=${token}&districtId=" + curDistrictId,
            async:false,
            success:function(data){
                 if(data == "9"){
                     //已经存在 添加失败
                     $('#alreadyAdd').modal('show');
                     $('#setdefault').modal('hide');
                 }else if(data=='1'){
                     //添加成功
                     $('#setdefault').modal('hide');
                     queryAddressList(currentPage,pageSize);
                 }
            }
        })
    }
    //设为默认 new
    function setDefaultAddress(districtId){
        $.ajax({
            url: "setthedefault.htm?CSRFToken=${token}&districtId=" + districtId,
            async:false,
            success:function(data){
                if(!!data){

                    var showDefaultAddressHTML = '(默认地区 ：'+data.province.provinceName+'-'+data.city.cityName+'-'+data.district.districtName+')'
                    $('.showDefaultAddress').html(showDefaultAddressHTML);
                }
                queryAddressList(currentPage,pageSize);
            }
        });
    }
    //删除地址
    function batchDeleteAddress(){
        var arr = [];
        $('.addressCheck').each(function(index,value){
            var $this = $(value);
            if(value.checked==true){
                arr.push($this.next().val());
            }
        })
        if(arr.length==0){
            return;
        }
        deleteAddress(null,arr);
    }
    function deleteAddress(districtId,districtIdArr){
        var arr = [];
         if(!!districtIdArr){
            arr = districtIdArr;
         }else{
             arr.push(districtId)
         }
         $.ajax({
             url:"deleteAddress.htm?CSRFToken=${token}",
             data:{arrString:arr.join(",")},
             success:function(data){
                 queryAddressList(currentPage,pageSize);
             }
         })
    }
     //编辑地址
    function updateAddressSpan(did,provinceid,cityId,distictId){
          $("#did").modal('show');
          $("input[name=did]").val(did);
        queryAllProvinceSpan("pro",provinceid);
        queryCityByProvinceIdSpan(provinceid,"cit",cityId);
        queryDistrictByCityIdSpan(cityId,"dis",distictId);
        $("#pro").change(function(){
            queryCityByProvinceIdSpan($(this).val(),"cit",cityId,function(){
                    queryDistrictByCityIdSpan($('#cit').val(), "dis", distictId);
                });


        })
        $("#cit").change(function(){
                queryDistrictByCityIdSpan($(this).val(),"dis",distictId);
        })
    }
    /*查询所有的省份*/
    function queryAllProvinceSpan(selectId,addressId){
        $.get("queryAllProvince.htm?CSRFToken="+$("#CSRFToken").val(),function(data){
            var provinces = '';
            for(var i=0;i<data.length;i++){
                provinces+="<option value='"+data[i].provinceId+"'>"+data[i].provinceName+"</option>";
            }
            $("#"+selectId).html(provinces).val(addressId);

        });
    }

    /*根据省份ID查询城市ID*/
    function queryCityByProvinceIdSpan(province,selectId,addressId,fn){
        $.get("queryCityByProvinceId.htm?CSRFToken="+$("#CSRFToken").val()+"&provinceId="+province,function(data){
            var provinces="";
            var flag = false;
            //$("#districts").html(provinces);
            for(var i=0;i<data.length;i++){
                provinces+="<option value='"+data[i].cityId+"'>"+data[i].cityName+"</option>";
                if(data[i].cityId == addressId){
                    flag = true;
                }
            }
            $("#"+selectId).html(provinces);
            if(flag){
                $("#"+selectId).val(addressId);
            }
            fn&&fn();
        });
    }
    /*根据城市ID查询区县ID*/
    function queryDistrictByCityIdSpan(cityId,selectId,addressId){
        $.get("queryDistrictByCityId.htm?CSRFToken="+$("#CSRFToken").val()+"&cityId="+cityId,function(data){
            var provinces = "";
            var flag = false;
            for(var i=0;i<data.length;i++){
                provinces+="<option value='"+data[i].districtId+"'>"+data[i].districtName+"</option>";
                console.log(data[i].districtId +"=="+ addressId);
                if(data[i].districtId == addressId){
                    flag = true;
                }
            }
            $("#"+selectId).html(provinces);
            if(flag){
                $("#"+selectId).val(addressId);
            }
        });
    }
     /*保存修改后的地址*/
     function saveUpdateAddress(){
         var did = $("input[name=did]").val();
         var distictId = $("#dis").val();
         $("#did").modal('hide');
         $.get("/saveUpdateAddress.htm?CSRFToken=${token}",{distictId:distictId,did:did},function(data){
             queryAddressList(currentPage,pageSize);
                if(data == "1"){
                    //已经存在 修改失败
                    $('#alreadyAdd').modal('show');
                }else{
                    window.location.reload();
                }

         });
     }
    /*设为默认*/
    function batdefault() {
        var curDistrictId = $("#districtId").val();
        var streetId = $("#streetId").val();
        $.ajax({
            url: "setthedefault.htm?CSRFToken=${token}&districtId=" + curDistrictId,
            async: false,
            success: function (data) {
                $('#setdefault').modal('hide');
                location.reload();
            }


        });


    }
</script>
</body>
</html>

