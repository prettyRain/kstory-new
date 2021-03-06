<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>站内信息-${topmap.systembase.bsetName}</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Keywords" content="${topmap.seo.meteKey}">
<meta name="description" content="${topmap.seo.meteDes}">
<meta name="renderer" content="webkit">
<#assign basePath=request.contextPath>
<#if (topmap.systembase.bsetHotline)??>
	<link rel = "Shortcut Icon" href="${(topmap.systembase.bsetHotline)!''}">
<#else>
	<link rel = "Shortcut Icon" href="${basePath}/images/Paistore.ico">
</#if>
<link rel="stylesheet" type="text/css" href="${basePath}/css/pages.css" />
<#--shf-->
    <link rel="stylesheet" href="${basePath}/index_960/css/style.css"/>
    <style>
        .section_headerTop{
            background: none!important;
            border-bottom: none!important;
        }
        .cartfd-mem {
            top: 9px!important;
        }
        .rightpar{
            display: none;
        }
    </style>
    <script type="text/javascript" src="${basePath}/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${basePath}/index_960/js/app.js"></script>
</head>
<body>

	<input type="hidden" name="CSRFToken" value="${token}">

    <#--一引入头部 <#include "/index/topnew.ftl" />  -->
    <#--shf-->
    <#include "../index/newheader3.ftl"/>
    <#--<#if (topmap.temp)??>-->
        <#--<#if (topmap.temp.tempId==8)>-->
            <#--<#include "../index/newtop3.ftl">-->
        <#--<#elseif (topmap.temp.tempId==9)>-->
            <#--<#include "../index/newtop4.ftl">-->
        <#--<#elseif (topmap.temp.tempId==10)>-->
            <#--<#include "../index/newtop7.ftl">-->
        <#--<#elseif (topmap.temp.tempId==11)>-->
            <#--<#include "../index/newtop6.ftl">-->
        <#--<#elseif (topmap.temp.tempId==12)>-->
            <#--<#include "../index/newtop7.ftl">-->
        <#--<#elseif (topmap.temp.tempId==13)>-->
            <#--<#include "../index/newtop8.ftl">-->
        <#--<#elseif (topmap.temp.tempId==14)>-->
            <#--<#include "../index/newtop9.ftl">-->
        <#--<#elseif (topmap.temp.tempId==15)>-->
            <#--<#include "../index/newtop8.ftl">-->
        <#--<#elseif (topmap.temp.tempId==16)>-->
            <#--<#include "../index/newtop11.ftl">-->
        <#--<#elseif (topmap.temp.tempId==17)>-->
            <#--<#include "../index/newtop12.ftl">-->
        <#--<#elseif (topmap.temp.tempId==18)>-->
            <#--<#include "../index/newtop13.ftl">-->
        <#--<#elseif (topmap.temp.tempId==19)>-->
            <#--<#include "../index/newtop14.ftl">-->
        <#--<#elseif (topmap.temp.tempId==20)>-->
            <#--<#include "../index/newtop15.ftl">-->
        <#--<#elseif (topmap.temp.tempId==21)>-->
            <#--<#include "../index/newtop21.ftl">-->
        <#--<#else>-->
            <#--<#include "../index/newtop.ftl"/>-->
        <#--</#if>-->
    <#--</#if>-->

    <#--<#include "newtop.ftl"/>-->


    <#--shf background: #fff;-->
    <div style="background: #fff;">
        <div class="container clearfix pt20 pb10">
            <!--new_member_left-->
            <#include "newleftmenu.ftl"/>
            <div class="new_member-right">
                <div class="air-info-msg">
                    <div class="n-title">站内信息</div>
                    <div class="tagMenu air-msg-menu">
                        <ul class="menu clearfix">
                            <li class="current">收到的站内信</li>
                        </ul>
                    </div>
                    <div class="content">
                        <div class="layout">
                            <div class="air-msgList">
                                <div class="msg-toolbar mt10 clearfix">
                                    <div class="fl">
                                        <input type="checkbox" class="check_all" onclick="selectAll(this);"/><label>全选本页</label>
                                        <button class="btn-sm" onclick="readAll()">标记为已读</button>
                                        <button  class="btn-sm"  onclick="deleteAll()">删除</button>
                                    </div>
                                </div>
                                <ul>
                                <#if (pb.list?size!=0)>
                                    <#list pb.list as letter>
                                        <li>
                                            <input type="checkbox"  name="selectletter"  value="${letter.letterId}" onclick="oncheck()"/>
                                            <i <#if letter.relaId??>class="read"</#if>></i>
                                            <a id="show" onclick="showContent(${letter.letterId});">${letter.letterTitle}</a>
                                        </li>
                                        <li class="letterContent${letter.letterId}" style="display: none;">${letter.letterContent}
                                            <#if letter.hrefUrl??>
                                                <#if letter.hrefUrl?index_of('list-') !=-1>
                                                    <a href="${basePath}/list/${letter.hrefUrl?substring(5)}.html" style="cursor:pointer;padding-left:10px;">查看详情</a>
                                                <#elseif letter.hrefUrl?index_of('item-') !=-1>
                                                    <a href="${basePath}/item/${letter.hrefUrl?substring(5)}.html" style="cursor:pointer;padding-left:10px;">查看详情</a>
                                                </#if>
                                            </#if>
                                            <#if letter.pcUrl??>
                                                <#if letter.pcUrl?index_of('http') !=-1>
                                                    <a href="${letter.pcUrl}" style="cursor:pointer;padding-left:10px;">查看详情</a>
                                                </#if>
                                            </#if>
                                        </li>
                                    </#list>
                                <#else>
                                    <div  style="margin-top:10px;border:1px #e8e8e8 solid; height:40px; text-align: center; font-size: 18px;line-height:40px;;">
                                        暂无站内信息！
                                    </div>
                                </#if>
                                </ul>
                            </div>
                            <div class="paging_area">
                                <#if (pb.list?size!=0)>
                                    <#-- 分页 -->
                                    <#import "/pagination/pageBean.ftl" as page>
                                    <@page.pagination pb />
                                </#if>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </div>
    <div class="mask"></div>
    <div class="member-dialog dia2">
        <div class="member-dialog-body">
            <div class="title"><a href="javascript:;" onclick="cls()">×</a></div>
            <div class="tc">
                <img src="${basePath}/images/btn_tips@2x.png" alt="" style="width: 45px;height: 45px;margin: 0 auto; margin-top:13px;display: block;">
                <div class="que-delete clearfix">
                    <div class="fl tl">
                        <p class="f16 new_p" id="con_00">操作失败！</p>
                        <div class="m-btn ">
                            <a  id="go_pay_00" href="javascript:cls();" class="bnt_ok">确定</a>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <div class="member-dialog dia3">
        <div class="member-dialog-body">
            <div class="title"><a href="javascript:;" onclick="cls()">×</a></div>
            <div class="tc">
                <img src="${basePath}/images/btn_tips@2x.png" alt="" style="width: 45px;height: 45px;margin: 0 auto; margin-top:13px;display: block;">
                <div class="que-delete clearfix">
                    <div class="fl tl">
                        <p class="f16 new_p" id="con_00">已读成功！</p>
                        <div class="m-btn">
                            <a  id="go_pay_00" href="javascript:clas();" class="bnt_ok">确定</a>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <div class="member-dialog dia4">
        <div class="member-dialog-body">
            <div class="title"><a href="javascript:;" onclick="cls()">×</a></div>
            <div class="tc">
                <img src="${basePath}/images/btn_tips@2x.png" alt="" style="width: 45px;height: 45px;margin: 0 auto; margin-top:13px;display: block;">
                <div class="que-delete clearfix">
                    <div class="fl tl">
                        <p class="f16 new_p " id="con_00">已经全部为已读状态！</p>
                        <div class="m-btn">
                            <a  id="go_pay_00" href="javascript:cls();" class="bnt_ok">确定</a>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <div class="member-dialog dia5">
        <div class="member-dialog-body">
            <div class="title"><a href="javascript:;" onclick="cls()">×</a></div>
            <div class="tc">
                <img src="${basePath}/images/btn_tips@2x.png" alt="" style="width: 45px;height: 45px;margin: 0 auto; margin-top:13px;display: block;">
                <div class="que-delete clearfix">
                    <div class="fl tl">
                        <p class="f16 new_p" id="con_00">请选择一行！</p>
                        <div class="m-btn">
                            <a id="go_pay_00" href="javascript:cls();" class="bnt_ok">确定</a>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <#--引入底部 <#include "/index/bottom.ftl" /> -->
    <#--shf-->
    <#--<div class="footer_tab">-->
        <#--<ul>-->

            <#--<li class="list1"><a href="http://www.ge960.com/channel/237.html">食品荟萃</a></li>-->
            <#--<li class="list2"><a href="http://www.ge960.com/channel/239.html">饮品总汇-->
            <#--</a></li>-->
            <#--<li class="list3"><a href="http://www.ge960.com/channel/241.html">购物中心-->
            <#--</a></li>-->
            <#--<li class="list4"><a href="http://www.ge960.com/channel/243.html">大药房-->
            <#--</a></li>-->

        <#--</ul>-->
    <#--</div>-->
    <#if (topmap.temp)??>
        <#if (topmap.temp.tempId==1)>
            <#include "../index/bottom.ftl">
        <#else>
            <#include "../index/newbottom.ftl" />
        </#if>
    </#if>
    <script type="text/javascript" src="${basePath}/js/letter.js"></script>
    <script type="text/javascript" src="${basePath}/js/default.js"></script>
    <script type="text/javascript" src="${basePath}/js/jcarousellite_1.0.1.js"></script>
    <script type="text/javascript" src="${basePath}/js/tab-switch.js"></script>
    <script type="text/javascript" src="${basePath}/js/customer/customer.js"></script>
    <script type="text/javascript" src="${basePath}/js/newapp.js"></script>
    <script type="text/javascript" src="${basePath}/js/customer/findcode.js"></script>
    <script type="text/javascript" src="${basePath}/js/jsOperation.js"></script>
    <#--shf-->
    <script type="text/javascript" src="${basePath}/index_960/js/app.js"></script>
    <script>
        $(document).ready(function(){
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
            $(".pro_sort").addClass("pro_sort_close");
            jQuery.fn.isChildAndSelfOf = function(b){ return (this.closest(b).length > 0); };
        });
        function showContent(id){
            var flag=false;
            if(!$(".letterContent"+id).prev().find("i").hasClass("read")){
                $("input[value='"+id+"']").prop("checked","checked");
                flag=read(id);
            }
            if(!flag){
                if($(".letterContent"+id).css("display")=="none"){
                    $(".letterContent"+id).show();
                }else{
                    $(".letterContent"+id).hide();
                }
            }
        }
            function read(id){
                var letterId=id;
                letterIsRead(letterId);
                $(".letterContent"+letterId).prev().find("i").addClass("read");
                $(".letterContent"+letterId).show();
                return true;
            }
    </script>
</body>
</html>
