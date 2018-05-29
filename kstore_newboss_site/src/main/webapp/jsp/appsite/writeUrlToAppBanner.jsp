<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/9/15
  Time: 15:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title></title>
    <style>
        *{margin:0;padding:0;}
        .box {
            width:340px;
            padding:30px;
            margin:0 auto;
            position:relative;
        }
        p{
            line-height:30px;
        }
        p input{
            padding-left:5px;
            width:226px;
            height:30px;
            border-radius:3px;
            border:1px solid #ccc;
            outline-style:none;
        }
        p.btn{
            position:absolute;
            left:50%;
            margin:-60px;
            top:210px;
            width:120px;
        }
        p .btnOne {
            line-height:25px;
            text-align:center;
            background-color: #7b6ecc;
            font-weight:bold;
            margin-right:10px;
            border-radius:3px;
            width:50px;
            text-align:center;
            display:inline-block;
        }
        p .btnTwo {
            line-height:25px;
            text-align:center;
            background-color: #7b6ecc;
            font-weight:bold;
            border-radius:3px;
            width:50px;
            text-align:center;
            display:inline-block;
        }
    </style>
</head>
<body>
<div class="box">
    <p><span>自定义链接：</span><input type="text" name="bannerUrl" /></p>
    <p class="btn"><span class="btnOne" onclick="deteleUrl()">取消</span><span class="btnTwo" onclick="saveUrl()">保存</span></p>
</div>
</body>
</html>
<script type="text/javascript" src="<%=basePath%>js/artDialog4.1.7/artDialog.source.js?skin=default"></script>
<script type="text/javascript" src="<%=basePath%>js/artDialog4.1.7/plugins/iframeTools.js"></script>
<script>
    function deteleUrl(){
        art.dialog.close();
    }
    function saveUrl(){
        var api = art.dialog.open.api;
        var win = art.dialog.open.origin;//来源页面
        var strUrl = document.getElementsByTagName("input")[0].value;
        var strRegex = '^((https|http|ftp|rtsp|mms)?://)'
            + '?(([0-9a-z_!~*\'().&=+$%-]+: )?[0-9a-z_!~*\'().&=+$%-]+@)?' //ftp的user@
            + '(([0-9]{1,3}.){3}[0-9]{1,3}' // IP形式的URL- 199.194.52.184
            + '|' // 允许IP和DOMAIN（域名）
            + '([0-9a-z_!~*\'()-]+.)*' // 域名- www.
            + '([0-9a-z][0-9a-z-]{0,61})?[0-9a-z].' // 二级域名
            + '[a-z]{2,6})' // first level domain- .com or .museum
            + '(:[0-9]{1,4})?' // 端口- :80
            + '((/?)|' // a slash isn't required if there is no file name
            + '(/[0-9a-z_!~*\'().;?:@&=+$,%#-]+)+/?)$';
        var re=new RegExp(strRegex);
        if(re.test(strUrl)){
            win.window.saveAppSliderUrl(strUrl,api.config.id);
            art.dialog.close();
        }else{
            art.dialog.alert("不是正确的网址吧，请注意检查一下");
        }
    }

</script>