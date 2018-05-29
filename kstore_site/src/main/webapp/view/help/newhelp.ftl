<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>${topmap.systembase.bsetName}</title>
<meta name="Keywords" content="${topmap.seo.meteKey}">
<meta name="description" content="${topmap.seo.meteDes}">

<#assign basePath=request.contextPath>
<meta content="text/html; charset=UTF-8" http-equiv=Content-Type>

<link rel="stylesheet" type="text/css" href="${basePath}/css/base.min.css" />
<link rel="stylesheet" type="text/css" href="${basePath}/css/style.css" />
 <#--shf修正字体与后台编辑器显示一致	   -->
<link rel="stylesheet" type="text/css" href="${basePath}/css/reset-note-editor.css" />
<#if (topmap.systembase.bsetHotline)??>
	<link rel = "Shortcut Icon" href="${(topmap.systembase.bsetHotline)!''}">
<#else>
	<link rel = "Shortcut Icon" href="${basePath}/images/Paistore.ico">
</#if>
</head>
<style>
    .help_banner{background: url(${basePath}/images/help_banner.png) no-repeat;position: absolute;left: 0;top: 0;width: 100%;margin: 0 auto;background-position:50% 50%;  height: 500px;  }
    .help_content{position: relative;margin-bottom: 100px;}
    .menu{margin-bottom: 15px;display: inline-block;}
    .menu li:first-of-type{margin-left: 0px;}
    .menu li{color:#1e6dfd;float: left;display: block;margin-bottom: -1px;cursor:pointer;margin-left:213px;font-size: 14px;font-weight: bold; letter-spacing: 1px;}
    .menu>.current{}
    .content{padding: 10px 20px 20px 40px;}
    .content li{margin-top: 6px;}
    .menu li:first-of-type img{margin-left: 6px;}
    .menu li:nth-of-type(2) img{margin-left: 0px;}
    .menu li:nth-of-type(4) img{margin-left: 7px;}
    .menu li:nth-of-type(5) img{margin-left: 8px;}
    .content li a{color: #121212;width: 147px;height: 38px;border: 1px solid #121212;border-radius:20px;text-align: center;line-height: 38px;letter-spacing: 1px;display: block;  }
    .content .layout{float:left;width: 150px;height: 200px;display: none;}
    .content .layout:first-of-type{position: absolute;left: 0;top:-6px;}
    .content .layout:nth-of-type(2){position: absolute;left: 263px;top:-6px;}
    .content .layout:nth-of-type(3){position: absolute;left: 537px;top:-6px;}
    .content .layout:nth-of-type(4){position: absolute;left: 800px;top:-6px;}
    .content .layout:nth-of-type(5){position: absolute;left:1050px;top:-6px;}
    .location {    margin: 8px 0 5px 0;}
    .content li a:hover{color: #ebf1ff!important; background: linear-gradient(left , rgb(30, 109, 255) 1% , rgb(66, 131, 250) 100%);
        background: -o-linear-gradient(left , rgb(30, 109, 255) 1% , rgb(66, 131, 250) 100%);
        background: -ms-linear-gradient(left , rgb(30, 109, 255) 1% , rgb(66, 131, 250) 100%);
        background: -moz-linear-gradient(left , rgb(30, 109, 255) 1% , rgb(66, 131, 250) 100%);
        background: -webkit-linear-gradient(left , rgb(30, 109, 255) 1% , rgb(66, 131, 250) 100%);
        border: 1px solid #1d6dff;}
    .container_margin{margin-top: 57px;}
    .location .hover_a:hover{
        color: #666666!important;
    }
</style>
<body>
	<div>
	<#--一引入头部 <#include "/index/topnew.ftl" /> -->
		<#if (topmap.temp)??>
			<#if (topmap.temp.tempId==1)>
				<#include "../index/topnew.ftl">
			<#elseif (topmap.temp.tempId==3)>
				<#include "../index/newheader.ftl">
			<#elseif (topmap.temp.tempId==9)>
				<#include "../index/newheader4.ftl">
			<#elseif (topmap.temp.tempId==10)>
				<#include "../index/newheader5.ftl">
			<#elseif (topmap.temp.tempId==11)>
				<#include "../index/newheader6.ftl">
			<#elseif (topmap.temp.tempId==12)>
				<#include "../index/newheader7.ftl">
			<#elseif (topmap.temp.tempId==13)>
				<#include "../index/newheader8s.ftl">
			<#elseif (topmap.temp.tempId==14)>
				<#include "../index/newheader9.ftl">
			<#elseif (topmap.temp.tempId==15)>
				<#include "../index/newheader10.ftl">
			<#elseif (topmap.temp.tempId==16)>
				<#include "../index/newheader11.ftl">
			<#elseif (topmap.temp.tempId==17)>
				<#include "../index/newheader12.ftl">
			<#elseif (topmap.temp.tempId==18)>
				<#include "../index/newheader13.ftl">
			<#elseif (topmap.temp.tempId==19)>
				<#include "../index/newheader14.ftl">
            <#elseif (topmap.temp.tempId==20)>
                <#include "../index/newheader15.ftl">
			<#elseif (topmap.temp.tempId==21)>
				<#include "../index/newheader21.ftl">
			<#else>
				<#include "../index/newheader3.ftl">
			</#if>
		</#if>
	</div>
    <!-- 面包屑 -->
    <div class="container">
		<div class="location">
			<a  href="${basePath}/index.html">首页</a>
			<span>&gt;</span><a <#--href="${basePath}/help.htm"--> class="hover_a" style="cursor: default;">帮助中心</a>
		</div>
	</div>
    <div style="overflow: hidden;position: relative;height: 500px;" >
        <div class="help_banner">

        </div>
    </div>
    <div class="container container_margin">

		<div class="help_content">
        <div class="tagMenu">
            <ul class="menu">
				<#list map.helpCates as helpcate>
					<li <#--<#if (helpcate_index == 0)>class="current"</#if>-->>
						<img  style="display: block;margin-bottom: 30px;"alt="" height="50" src="${helpcate.helpcateImg }">
						${helpcate.helpcateName}>
					</li>
				</#list>
            </ul>
        </div>
        <div class="content">
			<#list map.helpCates as helpcate>
			<div class="layout">
				<ul>
					<#list helpcate.childs as content>
					<li><a style="font-size: 14px;" href="${basePath}/help/${content.helpId}">${content.helpTitle}</a></li>
					</#list>
                </ul>
            </div>
			</#list>
        </div>
        </div>

        <div class="cb"></div>

    </div>


<script type="text/javascript" src="${basePath}/js/jquery-1.7.2.min.js"></script>

<script type="text/javascript" src="${basePath}/js/default.js"></script>
<script type="text/javascript" src="${basePath}/js/jcarousellite_1.0.1.js"></script>
<#--<script type="text/javascript" src="${basePath}/js/tab-switch.js"></script>-->
<script type="text/javascript" src="${basePath}/js/information/information_comm.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(".pro_sort").addClass("pro_sort_close");
	$('.item_title').each(function(){
		$(this).click(function(){
			$(this).next().toggle('fast',function(){
				if($(this).is(':visible')){
					$(this).prev().removeClass('up');
					$(this).prev().addClass('down');
				}
				else{
					$(this).prev().removeClass('down');
					$(this).prev().addClass('up');
				}
			});
		});
	});
	$(".guess_goods_list").jCarouselLite({
        btnNext: ".next",
        btnPrev: ".prev",
		visible : 6,
		auto : 2000,
		speed : 800
    });

});
</script>
	<script>
        /*********************************************
         用途：tab标签点击切换的实现
         使用：头部引用，html代码按下面规则编写
         <div class="tagMenu">
         <ul class="menu">
         <li>第一个标签</li>
         <li>第二个标签</li>
         </ul>
         </div>
         <div class="content">
         <div class="layout">
         第一块内容
         </div>
         <div class="layout">
         第二块内容
         </div>
         </div>
         *********************************************/
        $(document).ready(function(){
            // $("div.content").find("div.layout:not(:first-child)").hide();
            $("div.content div.layout").attr("id", function(){return idNumber("No")+ $("div.content div.layout").index(this)});
            $("ul.menu li").mouseenter(function(){
                var c = $("ul.menu li");
                var index = c.index(this);
                var p = idNumber("No");
                show(c,index,p);
                $(c).css("visibility","visible");
                $(this).css("visibility","hidden").siblings().show();
            });
            function show(controlMenu,num,prefix){
                var content= prefix + num;
                $('#'+content).siblings().hide();
                $('#'+content).show();
                /*controlMenu.eq(num).addClass("current").siblings().removeClass("current");*/
            };
            function idNumber(prefix){
                var idNum = prefix;
                return idNum;
            };
            $(".layout").mouseleave(function () {
                $(this).hide();
                $("ul.menu li").css("visibility","visible");
            })
        });
        /*
        });*/

	</script>
<#--引入底部-->
    <#if (topmap.temp)??>
		<#if (topmap.temp.tempId==1)>
			<#include "../index/bottom.ftl">
		<#else>
		    <#include "../index/newbottom.ftl" />
		</#if>
	</#if>
</body>
</html>
