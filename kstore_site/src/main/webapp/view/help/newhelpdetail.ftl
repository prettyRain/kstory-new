<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>${map.help.helpTitle}-${topmap.systembase.bsetName}</title>
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
    <div class="container">
        <!-- 面包屑 -->
        <div class="location">
            <a  href="${basePath}/index.html">首页</a>
            <span>&gt;</span><a href="${basePath}/help.htm">帮助中心</a>
            <span>&gt;</span><a href="${basePath}/help/${map.help.helpId}">${map.help.helpTitle}</a>
        </div>

        <div class="help_cont fr">
        	<div class="title">
            	<h2 style="line-height: inherit;">${map.help.helpTitle}</h2>
            </div>
            <div class="body">
                ${(map.help.helpContent)?default("暂无")}
            </div>
        </div><!-- /help_cont -->

        <div class="help_menu fl">
        	<#list map.helpCates as helpcate>
        	<div class="help_menu_item">
            	<div class="top_link">${helpcate.helpcateName}</div>
                <ul>
                	<#if (helpcate.childs)?? && (helpcate.childs?size>0)>
                	<#list helpcate.childs as content>
                        <#if content.helpId !=112>
                            <li <#if (content.helpId==map.help.helpId)>class="cur"</#if>><a href="${basePath}/help/${content.helpId}" onclick="_czc.push(['_trackEvent', '首页', '帮助中心', '${content.helpTitle}',  'support_center']);" id="support_center">${content.helpTitle}</a></li>
                        <#elseif content.helpId ==112&& map.thirdId??>
                            <li <#if (content.helpId==map.help.helpId)>class="cur"</#if>><a href="${basePath}/help/${content.helpId}" onclick="_czc.push(['_trackEvent', '首页', '帮助中心', '${content.helpTitle}',  'support_center']);" id="support_center">${content.helpTitle}</a></li>
                        </#if>
                	</#list>
                	</#if>
                </ul>
            </div>
        	</#list>

        </div><!-- /help_menu -->
        <div class="cb"></div>

        <#--
        <div class="member_box mb20">
            <div class="memeber_left fl">
                <h2><span class="f14 fb">帮助中心</span></h2>
                <#list map.helpCates as helpcate>
                	<div class="menu_item">

	                    <ul class="item_list">
						<li <#if (helpcate.helpcateId==map.cHelpCate.helpcateId)>class="cur"</#if>>
							<a href="${basePath}/help/list/${helpcate.helpcateId}">
									${helpcate.helpcateName!''}</a>
						</li>
	                    </ul>
                	</div>
				</#list>
            </div>
            <div class="member_right fl ml10">
                <div class="order_list switch_border">
                	<div class="tagMenu" style="height:0px;">
                    </div>
                    <div class="article_details">
						<div class="title">
					    	<h1>${map.help.helpTitle}</h1>
					        <div class="light tc">时间：${map.help.createTime?string("yyyy-MM-dd HH:mm:ss")}</div>
					    </div>
					    <div class="body">
					    	${(map.help.helpContent)?default("暂无")}
					    </div>
					</div>
                </div>
            </div>
            <div class="cb"></div>
        </div>
        -->

    </div>



<script type="text/javascript" src="${basePath}/js/jquery-1.7.2.min.js"></script>

<script type="text/javascript" src="${basePath}/js/default.js"></script>
<script type="text/javascript" src="${basePath}/js/jcarousellite_1.0.1.js"></script>
<script type="text/javascript" src="${basePath}/js/tab-switch.js"></script>
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
<#--引入底部-->
    <#if (topmap.temp)??>
		<#if (topmap.temp.tempId==1)>
			<#include "../index/bottom.ftl">
		<#else>
		    <#include "../index/newbottom.ftl" />
		</#if>
	</#if>

    <p style="display: none;">
	<#--友盟CNZZ统计-->
        <script src="https://s13.cnzz.com/z_stat.php?id=1263930585&web_id=1263930585" language="JavaScript">
            //声明_czc对象:
            var _czc = _czc || [];
            //绑定siteid，请用您的siteid替换下方"XXXXXXXX"部分
            _czc.push(["_setAccount", "www.ge960.com"]);
        </script>
    </p>
</body>
</html>
