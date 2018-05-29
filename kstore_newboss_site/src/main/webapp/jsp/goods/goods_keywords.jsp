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
    <style>
        #addBig {
            width:100%;
            height:100%;
            position:fixed;
            top:0;
            left:0;
            background:rgba(0,0,0,0.3);
            display:none;
            z-index:1000;
        }
        #updateKeywords {
            width:900px;
            height:600px;
            position:fixed;
            top:50%;
            left:50%;
            margin-left:-450px;
            margin-top:-300px;
            background-color:#fff;
            display:none;
            z-index:1001;
            border-radius:5px;
        }
        /*addkeywords  start*/
        #addKeywords {
            width:900px;
            height:600px;
            position:fixed;
            top:50%;
            left:50%;
            margin-left:-450px;
            margin-top:-300px;
            background-color:#fff;
            display:none;
            z-index:1001;
            border-radius:5px;
        }
        .addKeywordsHead {
            width:100%;
            position:relative;
            overflow:hidden;
            border-bottom:1px solid #ccc;
        }
        .addKeywordsHead h3 {
            font:500 18px/20px "微软雅黑";
            float:left;
            padding:0 0 0 10px;
        }
        .addKeywordsHead span {
            float:right;
            position:absolute;
            top:14px;
            right:4px;
            width:16px;
            height:16px;
            background-color:#00b7ee;
            color:#fff;
            font:600 16px/16px "宋体";
            border-radius:50%;
            cursor:pointer;
        }
        .addKeywordsContent {
            width:100%;
            padding:0 20px;
        }
        .addKeywordsContent .keywordsOne {
            width:100%;
            padding-top:30px;
            font:14px/20px "微软雅黑" ;
            margin-bottom:30px;
        }
        .addKeywordsContent .keywordsOne i,
        .addKeywordsContent .keywordsTwo i,
        .keywordsThree i{
            font-style:normal;
            font:12px/20px "宋体"
        }
        .keywordsOne input {
            outline:none;
            width:200px;
            height:28px;
            border-radius:5px;
            padding-left:5px;
            margin-left:3px;
        }
        .cateOne select{
            min-width:198px;
            height:28px;
            outline:none;
            border-radius:5px;
        }
        .addKeywordsContent {
            overflow:hidden;
        }
        .addKeywordsContent .keywordsTwo .cateOne {
             width:100%;
             hieght:50px;
        }
        .addKeywordsContent .keywordsTwo .cateTwo {
            width:100%;
            margin-top:30px;
        }
        .cateTwo .lf,.keywordsThree .lf{
            float:left;
        }
        .cateTwo .rg {
            float:right;
            width:780px;
            overflow-y:auto;
            height:60px;
        }
        .keywordsThree .rg{
            float:right;
            width:780px;
            overflow-y:auto;
            height:100px;
        }
        .cateTwo p ,.keywordsThree p{
            float:left;
            width:150px;
            height:20px;
            margin-right:10px;
            cursor:pointer;
        }
        .keywordsThree {
            margin-top:30px;
        }
        .btnsave {
            width:60px;
            height:30px;
            margin:0 auto;
            text-align:center;
        }
        .btnsave span {
            font:14px/30px "微软雅黑";
        }
        .emend ,.emstart {
            font-style:normal;
        }
        .emend input {
            font:12px/16px "微软雅黑";
            width:30px;
            outline-style:none;
            border-radius:5px;
            padding-left:3px;
        }
        .btnsave {
            width:60px;
            height:30px;
            margin:0 auto;
            background-color:#2aabd2;
            position:absolute;
            bottom:8px;
            left:50%;
            margin-left:-30px;
            border-radius:5px;
            text-align:center;
            font:600 14px/30px "微软雅黑";
            color:#fff;
            cursor:pointer;
        }
        .keywordsTwoNew{
            margin-top:30px;
            width:100%;
            min-height:20px;
        }
        .keywordsTwoNew .lf {
            float:left;
            height:20px;
            width:63px;
        }
        .keywordsTwoNew .lf i {
            font-style:normal;
            font:12px/20px "宋体";
        }
        .keywordsTwoNew .rg {
            float:right;
            width:780px;
            height:100px;
            overflow-y:auto;
        }
        .keywordsTwoNew .rg p {
            float:left;
            width:150px;
            height:20px;
            margin:0 10px 10px 0;
        }
        .keywordsTwoNew .rg p i {
            font-style:normal;
            font:12px/20px "宋体";
        }
        /*addkeywords  end*/
        .ton {
            width:60px;
            height:30px;
            background-color:#5bc0de;
            font:600 14px/30px "宋体";
            color:#fff;
            text-align:center;
            border-radius:2px;
            display:inline-block;
            cursor:pointer;
            margin-bottom:5px;
            margin-left:5px;
        }
        #searchText {
            float:left;
            width:100px;
            height:30px;
            outline-style:none;
            line-height:30px;
            padding-left:5px;
            margin-left:0 !important;
        }
        .workname {
            float:left;
            width:79px;
            height:30px;
            font:14px/30px "微软雅黑";
            colro:#555;
            text-align:center;
            background-color:#eee;
            display:inline-block;
            margin-left:0 !important;
            border:1px solid #ccc;
            border-right-width:0;
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
                <input type="hidden" value="${token}" class="token_val"/>
                <h2 class="main_title">${pageNameChild} <small>(共${pb.rows}条)</small></h2>

                <input type="hidden" name="CSRFToken" id="CSRFToken" value="${token}">
                <div class="common_data p20">
                   <%-- <div class="searchkeywords">
                        <input type="text" name="searchText" id="searchText">
                        <botton class="ton">搜索</botton>
                    </div>--%>
                    <div class="data_ctrl_area mb20">
                        <div class="data_ctrl_search pull-right">
                            <div class="searchkeywords">
                                <botton class="workname">关键字名称</botton>
                                <input type="text" name="searchText" id="searchText" onkeypress="searchkeyname()"/>
                                <botton class="ton" onclick="searchkeyname()">搜索</botton>
                            </div>
                        </div>
                        <div class="data_ctrl_brns pull-left">
                            <button type="button" class="btn btn-info" onclick="addKeywordsShowFun()">
                                <i class="glyphicon glyphicon-plus"></i> 添加
                            </button>
                            <button type="button" class="btn btn-info" onclick="deleteKeyword('ids')">
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
                                <th width="10"><input type="checkbox"  class="allcheck" id="allcheckId"/></th>
                                <th>关键字</th>
                                <th>相关分类</th>
                                <th>相关品牌</th>
                                <th width="150">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${pb.list}" var="search">
                                <tr>
                                    <td><input type="checkbox"  value="${search.searchId }" class="checkid"/></td>
                                    <td>${search.searchKeyword}</td>
                                    <td>
                                        <c:forEach items="${search.cates}" var="cate">
                                            ${cate.catName}
                                        </c:forEach>
                                    </td>
                                    <td>
                                        <c:forEach items="${search.brands}" var="brand">
                                            ${brand.brandName}
                                        </c:forEach>
                                    </td>
                                    <td>
                                            <%--<div class="btn-group">--%>
                                            <%--<input type="button" class="btn " onclick="deleteAuth(${auth.id})" value="删除"/>--%>
                                        <p class="btn" id="deleteA" val="${search.searchId}" style="color:#3d85cc;" onclick="deleteKeyword(${search.searchId})">删除</p><br/>
                                        <p class="btn" id="updateA" val="${search.searchId}" onclick="showEditAuthForm(${search.searchId})" style="color:#3d85cc;">编辑</p>
                                            <%-- </div>--%>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                </form>
                    <%--<c:import url="../page/searchPag.jsp">
                        <c:param name="pageBean" value="${pb }"/>
                    </c:import>--%>

                <div class="table_pagenav pull-right" id="rightPage">
                    <div class="meneame">
                        <input type="hidden" class="pageNo" value="${pb.pageNo}">
                        <input type="hidden" class="totalPage" value="${pb.totalPages}">
                        <c:if test="${pb.pageNo>1}">
                        <a  href="${pageContext.request.contextPath}/findAllKeyword.htm?pageNo=${pb.pageNo-1}"> 上一页 </a>
                        </c:if>
                        <c:if test="${pb.pageNo==1}">
                            <span class="disabled"> 上一页 </span>
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
                                    <a href="${pageContext.request.contextPath}/findAllKeyword.htm?pageNo=${pb.startNo+vars.count-1}">${pb.startNo+vars.count-1}</a>
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
                            <a  href="${pageContext.request.contextPath}/findAllKeyword.htm?pageNo=${pb.pageNo+1}"  > 下一页 </a>
                        </c:if>

                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
</div>

<!-- 编辑关键字 -->
<div id="updateKeywords">
    <form action="" id="updateKeywordsform" onsubmit="return updateformchecked()">
        <input type="hidden" id="upsearchKeyword" name="searchKeyword" value="" />
        <input type="hidden" id="upcatId" name="catId"/>
        <input type="hidden" id="upbrandId" name="brandId"/>
        <input type="hidden" id="upCSRFToken" name="CSRFToken"/>
        <input type="hidden" id="upsearchId" name="searchId"/>
    </form>
    <div class="addKeywordsHead">
        <h3>关键字搜索编辑</h3><span class="closespan">×</span>
    </div>
    <div class="addKeywordsContent">
        <div class="keywordsOne">
            <i>关键字&nbsp;:</i><input  name="updatekeywordName" type="text"  value="" placeholder="请输入关键字" id="upkd"/><span id="uptx"></span>
        </div>
        <div class="keywordsTwo clearfix">
            <div class="cateOne">
                <i>一级分类:</i>
                <select name="" id="updatecateIdOneItem">
                    <option value=""></option>
                </select>
            </div>
            <div class="cateTwo">
                <div class="lf">
                    <i>二级分类:</i>
                </div>
                <div class="rg" id="updatecateTwoIds">
                    <p>
                        <em calss="emstart"><input type="checkbox" name="cateTwoId" value="" /></em>
                        <i>dd</i>
                        <em class="emend"><input type="text" name="cateTwoSort" value="" /></em>
                    </p>
                </div>
            </div>
        </div>
        <div class="keywordsTwoNew clearfix" style="">
            <div class="lf">
                <i>关联分类:</i>
            </div>
            <div class="rg" id="updatecateTwoIdsNew">
                <%--<p>
                <em calss="emstart"><input type="checkbox" name="brandId" value="" /></em>
                <i>dd</i>
                <em class="emend"><input type="text" name="brandSort" value="" /></em>
                </p>--%>
            </div>
        </div>
        <div class="keywordsThree clearfix">
            <div class="lf">
                <i>关联品牌:</i>
            </div>
            <div class="rg" id="updatebrandIds">
                <p>
                    <em calss="emstart"><input type="checkbox" name="updatebrandId" value="" /></em>
                    <i>dd</i>
                    <em class="emend"><input type="text" name="updatebrandSort" value="" /></em>
                </p>
            </div>
        </div>
        <div class="btnsave" onclick="updateSearch()">
            <span>保存</span>
        </div>
    </div>
</div>
<!-- Modal -->
<div id="addBig">
</div>
<%-- 添加关键字 --%>
<div id="addKeywords">
    <form action="" id="addKeywordsform" onsubmit="return formchecked()">
        <input type="hidden" name="searchKeyword" value="" />
        <input type="hidden" name="catId"/>
        <input type="hidden" name="brandId"/>
        <input type="hidden" name="CSRFToken"/>
    </form>
   <div class="addKeywordsHead">
       <h3>关键字搜索添加</h3><span class="closespan">×</span>
   </div>
    <div class="addKeywordsContent">
        <div class="keywordsOne">
            <i>关键字&nbsp;:</i><input id="kdinput" name="keywordName" type="text"  value="" placeholder="请输入关键字"/> <span id="kd"></span>
        </div>
        <div class="keywordsTwo clearfix">
            <div class="cateOne">
                <i>一级分类:</i>
                <select name="" id="cateIdOneItem">
                   <option value=""></option>
                </select>
            </div>
            <div class="cateTwo">
                <div class="lf">
                    <i>二级分类:</i>
                </div>
                <div class="rg" id="cateTwoIds">
                    <p>
                        <em calss="emstart"><input type="checkbox" name="cateTwoId" value="" /></em>
                        <i>dd</i>
                        <em class="emend"><input type="text" name="cateTwoSort" value="" /></em>
                    </p>
                </div>
            </div>
        </div>
        <div class="keywordsTwoNew clearfix" style="">
            <div class="lf">
                <i>关联分类:</i>
            </div>
            <div class="rg" id="cateTwoIdsNew">
                <%--<p>
                <em calss="emstart"><input type="checkbox" name="brandId" value="" /></em>
                <i>dd</i>
                <em class="emend"><input type="text" name="brandSort" value="" /></em>
                </p>--%>
            </div>
        </div>
        <div class="keywordsThree clearfix">
            <div class="lf">
                <i>关联品牌:</i>
            </div>
            <div class="rg" id="brandIds">
                <p>
                <em calss="emstart"><input type="checkbox" name="brandId" value="" /></em>
                <i>dd</i>
                <em class="emend"><input type="text" name="brandSort" value="" /></em>
                </p>
            </div>
        </div>
        <div class="btnsave" onclick="saveSearch()">
            <span>保存</span>
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
<script>
    function searchkeyname(){
        var searchText=document.getElementById("searchText").value;
        window.location.href='<%=basePath%>/findAllKeyword.htm?searchText='+searchText;
    }
    <%--updatekeywords start--%>
    function showEditAuthForm(keywordId){
        $("#addBig").show();
        $("#updateKeywords").show();
        updateloadFirstCate(0);
        updatefindBrans();
        queryKeywordById(keywordId);
    }
    $("#updatecateIdOneItem").change(function(){
        updateloadSecondCate($(this).val(),null);
    })
    var upkd=document.getElementById("upkd");
    var uptx=document.getElementById("uptx");
    var yz="";
    upkd.onblur=function(){
        if(yz!=this.value){
        if(this.value!=""){
            if($ajaxChecked(this.value)=="1"){
               uptx.innerHTML="  关键字已被占用";
               uptx.style.color="red";
            }
        }else if(this.value==""){
            uptx.innerHTML=" 关键字不能为空";
            uptx.style.color="red";
        }
    }
    }
    upkd.oninput=upkd.onpropertychanges=function(){
        if(this.value!=""){
            uptx.innerHTML="输入正确";
            uptx.style.color="#ccc";
            if(yz!=this.value){
            if($ajaxChecked(this.value)=="1"&&yz!=this.value){
                uptx.innerHTML="  关键字已被占用";
                uptx.style.color="red";
            }
            }
        }
    }
    function queryKeywordById(keywordId){
        //清空关联分类
        $('#updatecateTwoIdsNew').html("");
        $.ajax({
            type:"get",
            data:{
                keywordId:keywordId,
                CSRFToken:$(".token_val").val()
            },
            url:"queryKeywordById.htm",
            success:function(result){
              if(!!result){
                  var searchId=result.searchId;
                  var searchKeyword=result.searchKeyword;
                  var cates=result.cates;
                  var brands=result.brands;
                  $('input[name=updatekeywordName]').val(searchKeyword);
                  yz=searchKeyword;/*初始化关键字值*/
                  $('#upsearchId').val(searchId);
                  if(!!cates&& cates.length>0){
                      for(var i=0 ; i<cates.length ; i++){
                          var catId=cates[i].catId;
                          var catName=cates[i].catName;
                          var catSort=cates[i].catSort;
                          var str='<p>'
                              +'<em calss="emstart"><input type="checkbox" checked=true name="updatecateTwoIdNew" value="'+catId+'" id="'+catId+'" /></em>'
                              +'<label for="'+catId+'"><i>'+catName+'</i></label>'
                              +'<em class="emend"><input type="text" name="updatecateTwoSortNew" value="'+catSort+'" /></em>'
                              +'</p>';
                          $('#updatecateTwoIdsNew').append(str);
                      }
                  }
                  if(!!brands && brands.length>0){
                      for(var i=0 ; i<brands.length ; i++){
                          var brandId=brands[i].brandId;
                          var brandName=brands[i].brandName;
                          var brandSort=brands[i].brandSort;
                          $('#updatebrandIds').find('p').each(function(index,item){
                              if($(this).find('input[name=updatebrandId]').val()==brandId){
                                  item.getElementsByTagName("input")[0].checked=true;
                                  item.getElementsByTagName("input")[1].value=brandSort;
                              }
                          })
                      }

                  }
              }
            }
        })
    }
    function updateloadFirstCate(parentId,cateName){
        var url = 'querySonCateByCatIdAndName.htm?CSRFToken='+$(".token_val").val()+'&catId='+parentId;
        if(cateName!=''&&cateName!=undefined) {
            url += '&cateName='+cateName;
        }
        $("#updatecateIdOneItem").html("");
        $.ajax({
            url:url,
            success: function (data) {
                if(!!data){
                    var str;
                    for(var i=0 ; i<data.length ;i++){
                        if(i==0){
                            str+='<option value="'+data[i].catId+'" selected="selected">'+data[i].catName+'</option>'
                        }else{
                            str+='<option value="'+data[i].catId+'">'+data[i].catName+'</option>'
                        }
                    }
                    $("#updatecateIdOneItem").html(str);
                    updateloadSecondCate(data[0].catId,null);
                }
            }
        });
    }
    function updateloadSecondCate(parentId,cateName){
        var url = 'querySonCateByCatIdAndName.htm?CSRFToken='+$("#CSRFToken").val()+'&catId='+parentId;
        if(cateName!=''&& cateName!=undefined) {
            url += '&cateName='+cateName;
        }
        $("#updatecateTwoIds").html("");
        $.ajax({
            url:url,
            success: function (data) {
                var html = '';
                for(var i=0;i<data.length;i++) {
                    html+='<p onclick="onckickupdateCateTwo(this)" valname="'+data[i].catName+'" valId="'+data[i].catId+'">'
                        +'<i>'+data[i].catName+'</i>'
                        +'</p>';
                }
                $("#updatecateTwoIds").html(html);
            }
        });
    }
    function updatefindBrans(){
        $("#updatebrandIds").html("");
        $.ajax({
            url:'findBrands.htm?CSRFToken='+$(".token_val").val(),
            scyn:false,
            type:"get",
            success:function(result){
                var str="";

                if(!!result){
                    for(var i=0 ; i<result.length ; i++){
                        str+='<p>'
                            +'<em calss="emstart"><input type="checkbox" id="'+result[i].brandId+'" name="updatebrandId" value="'+result[i].brandId+'" /></em>'
                            +'<label for="'+result[i].brandId+'"><i >'+result[i].brandName+'</i></label>'
                            +'<em class="emend"><input type="text" name="updatebrandSort" value="" /></em>'
                            +'</p>';
                    }
                    $("#updatebrandIds").html(str);
                }
            }
        })
    }
    function onckickupdateCateTwo(obj){
        var flag=true;
        var cateName=$(obj).attr("valName");
        var cateId=$(obj).attr("valId");
        $('#updatecateTwoIdsNew').find("p").find("i").each(function(index,item){
            if($(item).html()==cateName){
                flag=false;
            }
        })
        if(flag){
            var str='<p>'
                +'<em calss="emstart"><input type="checkbox" id="'+cateId+'"name="updatecateTwoIdNew" value="'+cateId+'" /></em>'
                +'<label for="'+cateId+'"><i>'+cateName+'</i></label>'
                +'<em class="emend"><input type="text" name="updatecateTwoSortNew" value="" /></em>'
                +'</p>';
            $('#updatecateTwoIdsNew').append(str);
        }
    }
    function updateSearch(){
        $('#upsearchKeyword').val($('input[name=updatekeywordName]').val());
        var arrcates=[];
        var arrbrands=[];
        $('#updatecateTwoIdsNew').find('p').each(function(index,item){
            var _this=$(item);
            var flag=item.getElementsByTagName("input")[0].checked;
            if(flag){
                arrcates.push(_this.find('input[name=updatecateTwoIdNew]').val()+"-"+_this.find('input[name=updatecateTwoSortNew]').val());
            }
        })
        $('#updatebrandIds').find('p').each(function(index,item){
            var _this=$(item);
            var falg=item.getElementsByTagName("input")[0].checked;
            if(falg){
                arrbrands.push(_this.find('input[name=updatebrandId]').val()+"-"+_this.find('input[name=updatebrandSort]').val());
            }
        })
        $('#upcatId').val(arrcates.join(","));
        $('#upbrandId').val(arrbrands.join(","));
        $('#upCSRFToken').val($(".token_val").val());
        $('#updateKeywordsform').attr("action","updateKeywordsform.htm?CSRFToken="+$(".token_val").val()).submit();
    }
    function updateformchecked(){
        if(yz!=upkd.value){
            if(upkd.value!=""){
                if($ajaxChecked(upkd.value)=="1"){
                   alert("关键字已被占用");
                   return false;
                }
            }else if(upkd.value==""){
               alert(" 关键字不能为空");
               return false;
            }
        }
        var _flag=true;
        $('#updatecateTwoIdsNew').find('p').each(function(index,item){
            var _this=$(item);
            var flag=item.getElementsByTagName("input")[0].checked;
            if(flag){
                if(!_this.find('input[name=updatecateTwoSortNew]').val()){
                    _flag = false;
                };
            }
        })
        $('#updatebrandIds').find('p').each(function(index,item){
            var _this=$(item);
            var falg=item.getElementsByTagName("input")[0].checked;
            if(falg){
                if(!_this.find('input[name=updatebrandSort]').val()){
                    _flag = false;
                };
            }
        })
        if(_flag){
            return true;
        }else{
            alert("如果选择了分类或品牌那么排序为必填项");
            return false;
        }
    }
    <%--updatekeywords end--%>
    <%--addkeywords start--%>
    function addKeywordsShowFun(){
        $("#addBig").show();
        $("#addKeywords").show();
        loadFirstCate(0);
        findBrans();
    }
    $('.closespan').click(function(){
        $(this).parent().parent().hide();
        $('#addBig').hide();
    })
    function $ajaxChecked(titleVal){
        var checked="";
        $.ajax({
            type:"post",
            async:false,
            data:{
                titleVal:titleVal,
                CSRFToken:$(".token_val").val()
                 },
            url:"checkedTitleVal.htm",
            success:function(result){
              checked=result;
            }
        })
        return checked;
    }
    var kdinput=document.getElementById("kdinput");
    var kd=document.getElementById("kd");
    kdinput.onblur=function(){
        if(this.value!=""){
            if($ajaxChecked(this.value)=="1"){
                kd.innerHTML="关键字已被占用";
                kd.style.color="red";
            }
        }else if(this.value==''){
            kd.innerHTML="关键字不能为空";
            kd.style.color="red";
        }
    }
    kdinput.onfocus=kdinput.oninput=kdinput.onpropertychanges=function(){
        if(this.value!=''){
            kd.innerHTML="输入正确";
            kd.style.color="#ccc";
            if($ajaxChecked(this.value)=="1"){
                kd.innerHTML="关键字已被占用";
                kd.style.color="red";
            }
        }
    }
    $("#cateIdOneItem").change(function () {
        loadSecondCate($(this).val(),null);
    })
    //加载品牌
    function findBrans(){
        $("#brandIds").html("");
        $.ajax({
            url:'findBrands.htm?CSRFToken='+$(".token_val").val(),
            type:"get",
            success:function(result){
                var str="";

                if(!!result){
                    for(var i=0 ; i<result.length ; i++){
                    str+='<p>'
                        +'<em calss="emstart"><input type="checkbox" id="'+result[i].brandId+'" name="brandIdOld" value="'+result[i].brandId+'" /></em>'
                        +'<label for="'+result[i].brandId+'"><i>'+result[i].brandName+'</i></label>'
                        +'<em class="emend"><input type="text" name="brandSort" value="" /></em>'
                        +'</p>';
                    }
                    $("#brandIds").html(str);
                }
            }
        })
    }
     //ajax 查询一级分类
    function loadFirstCate(parentId,cateName) {
        var url = 'querySonCateByCatIdAndName.htm?CSRFToken='+$(".token_val").val()+'&catId='+parentId;
        if(cateName!=''&&cateName!=undefined) {
            url += '&cateName='+cateName;
        }
        $("#cateIdOneItem").html("");
        $.ajax({
            url:url,
            success: function (data) {
                  if(!!data){
                      var str;
                      for(var i=0 ; i<data.length ;i++){
                          if(i==0){
                              str+='<option value="'+data[i].catId+'" selected="selected">'+data[i].catName+'</option>'
                          }else{
                              str+='<option value="'+data[i].catId+'">'+data[i].catName+'</option>'
                          }
                      }
                      $("#cateIdOneItem").html(str);
                      loadSecondCate(data[0].catId,null);
                  }
            }
        });
    }
    //ajax 查询二级分类
    function loadSecondCate(parentId,cateName) {
        var url = 'querySonCateByCatIdAndName.htm?CSRFToken='+$("#CSRFToken").val()+'&catId='+parentId;
        if(cateName!=''&& cateName!=undefined) {
            url += '&cateName='+cateName;
        }
        $("#cateTwoIds").html("");
        $.ajax({
            url:url,
            success: function (data) {
                var html = '';
                for(var i=0;i<data.length;i++) {
                   html+='<p onclick="onckickCateTwo(this)" valname="'+data[i].catName+'" valId="'+data[i].catId+'">'
//                       +'<em calss="emstart"><input type="checkbox" name="cateTwoId" value="'+data[i].catId+'" /></em>'
                       +'<i>'+data[i].catName+'</i>'
//                       +'<em class="emend"><input type="text" name="cateTwoSort" value="" /></em>'
                       +'</p>';
                }
            $("#cateTwoIds").html(html);
            }
        });
    }
    //提交添加
    function saveSearch(){
         $('input[name=searchKeyword]').val($('input[name=keywordName]').val());
         var arrcates=[];
         var arrbrands=[];
         $('#cateTwoIdsNew').find('p').each(function(index,item){
             var _this=$(item);
            var flag=item.getElementsByTagName("input")[0].checked;
             if(flag){
                 arrcates.push(_this.find('input[name=cateTwoIdNew]').val()+"-"+_this.find('input[name=cateTwoSortNew]').val());
             }
         })
        $('#brandIds').find('p').each(function(index,item){
            var _this=$(item);
            var falg=item.getElementsByTagName("input")[0].checked;
            if(falg){
                arrbrands.push(_this.find('input[name=brandIdOld]').val()+"-"+_this.find('input[name=brandSort]').val());
            }
        })
        $('input[name=catId]').val(arrcates.join(","));
        $('input[name=brandId]').val(arrbrands.join(","));
        $('input[name=CSRFToken]').val($(".token_val").val());
        $('#addKeywordsform').attr("action","addKeywordsform.htm?CSRFToken="+$(".token_val").val()).submit();
    }
    //添加校验
    function formchecked(){
        if($ajaxChecked($('input[name=searchKeyword]').val())=="1"){
            alert("关键字已被占用");
            return false;
        }
        if(!$('input[name=searchKeyword]').val()){
            alert("关键字不能为空");
            return false;
        }
        var _flag=true;
        $('#cateTwoIdsNew').find('p').each(function(index,item){
            var _this=$(item);
            var flag=item.getElementsByTagName("input")[0].checked;
            if(flag){
                if(!_this.find('input[name=cateTwoSortNew]').val()){
                    _flag = false;
                };
            }
        })
        $('#brandIds').find('p').each(function(index,item){
            var _this=$(item);
            var falg=item.getElementsByTagName("input")[0].checked;
            if(falg){
                if(!_this.find('input[name=brandSort]').val()){
                    _flag = false;
                };
            }
        })
        if(_flag){
            return true;
        }else{
            alert("如果选择了分类或品牌那么排序为必填项");
            return false;
        }

    }
    //从二级分类添加到关联分类
    function onckickCateTwo(obj){
        var flag=true;
        var cateName=$(obj).attr("valName");
        var cateId=$(obj).attr("valId");
        $('#cateTwoIdsNew').find("p").find("i").each(function(index,item){
            if($(item).html()==cateName){
                flag=false;
            }
        })
        if(flag){
            var str='<p>'
                +'<em calss="emstart"><input type="checkbox" id="'+cateId+'" name="cateTwoIdNew" value="'+cateId+'" /></em>'
                +'<label for="'+cateId+'"><i>'+cateName+'</i></label>'
                +'<em class="emend"><input type="text" name="cateTwoSortNew" value="" /></em>'
                +'</p>';
            $('#cateTwoIdsNew').append(str);
        }
    }
    <%--addkeywords end--%>
    <%--删除 start--%>
    $('.allcheck').click(function(){
        $('.checkid').each(function(index,item){
            item.checked=document.getElementById("allcheckId").checked;
        })
    })
    $('.checkid').click(function(){
        if(this.checked){
            var _len=$('.checkid').length;
            var _size=0;
            console.log(_len);
            $('.checkid').each(function(index,item){
                if(item.checked){
                    _size++;
                }
            })
            if(_len==_size){
                document.getElementById("allcheckId").checked=true;
            }
        }else{
            document.getElementById("allcheckId").checked=false;
        }

    })
    function  deleteKeyword(keywordId){
        var url="deleteGoodsSearch.htm";
        if(keywordId=="ids"){
            //批量删除
            var ids=[];
            $('.checkid').each(function(index,item){
                if(item.checked){
                    ids.push($(item).val());
                }
            })
            if(ids.length<1){
                alert("请选择要删除的关键字");
                return;
            }else{
                var data={
                    CSRFToken:$(".token_val").val(),
                    ids:ids.join(",")
                }
            }
        }else{
            //单个删除
            var data={
                CSRFToken:$(".token_val").val(),
                ids:keywordId
            }
        }

        $ajax(url,data);
    }
    function $ajax(url,data){
        $.ajax({
            url:url,
            data:data,
            type:"post",
            success:function(result){
                if(result=="ok"){
                    window.location.reload();
                }else if(result=="no"){
                    alert("删除失败");
                    window.location.reload();
                }

            }
        })
    }
    <%--删除 end--%>
</script>
</body>
</html>
