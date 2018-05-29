<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>我的优惠券-${topmap.systembase.bsetName}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="Keywords" content="${topmap.seo.meteKey}">
    <meta name="description" content="${topmap.seo.meteDes}">
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
        .addCouponBox{
            display:none;
            position:fixed;
            top:0;
            left:0;
            z-index: 9999;
            width: 480px;
            height: 235px;
            border: 0px solid rgba(135, 135, 135, .3);
            background: #FFFFFF;
            box-shadow: 3px 1px 15px 0 rgba(0,0,0,0.07);
            border-radius: 4px;
        }
        .addCouponBox .head {
            width:100%;
            height:37px;
            border-radius: 4px;
            background-color:#ffffff;
        }
        .addCouponBox .content {
            position:relative;
            width:100%;
            height:198px;
            background-color:#fff;
            border-radius: 4px;
        }
        .addCouponBox .content .pcodeNo .new_span{
            font-size: 14px;
            color: #000000;
            font-style: normal;
            letter-spacing: 0.5px;
            margin-left: 52px;
            margin-top: 11px;
        }
        .addCouponBox .slf {
            float:left;
            font:bold 16px/40px "微软雅黑";
            padding-left:20px;
            color:#fff;
        }
        .addCouponBox .srg {
            cursor:pointer;
            width: 12px;
            height: 12px;
            margin-top: 25px;
            margin-right: 25px;
            float: right;
            text-indent: -9999px;
            line-height: 0;
            overflow: hidden;
            background: url(../images/popover_btn.png) no-repeat;
            background-size: 100%;
        }
        .pcodeNo {
            /*padding:55px 30px 0 30px;*/
            padding-top: 43px;
            width:480px;
            font:14px/34px "微软雅黑";
            position:relative;
        }
        .pcodeNo input{
            outline-style:none;
            margin-left:5px;
            display: inline-block;
            zoom: 1;
            border: 1px solid #EEEEEE;
            width: 288px;
            height: 38px;
            line-height: 38px;
            padding: 0 0px;
            vertical-align: middle;
            font-size: 14px;
            color: #000000;
            letter-spacing: 0.5px;
            text-indent: 15px;
        }
        .sclose{
            display:inline-block;
            position:absolute;
            right: 71px;
            bottom: 12px;
            cursor: pointer;
            width:16px;
            height:16px;
            float: right;
            text-indent: -9999px;
            line-height: 0;
            overflow: hidden;
            background: url(../images/x_btn.png) no-repeat;
            background-size: 100%;
        }
        .pbtn {
            width: 114px;
            height: 35px;
            line-height: 35px;
            font-size:14px;
            background-color:#199301;
            color:#fff;
            position:absolute;
            bottom:25px;
            left:50%;
            margin-left:-48px;
            cursor:pointer;
            text-align:center;
            border-radius:4px;
            cursor:pointer;
            letter-spacing: 0.5px;
        }
    </style>
    <script type="text/javascript" src="${basePath}/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${basePath}/index_960/js/app.js"></script>
<#if codeStatus=='2'||codeStatus=='3'>
    <style> .air-discountTic{background-color: #b2b2b2;  cursor: not-allowed;  }
    .air-discountTic:hover{background-color: #b2b2b2;  cursor: not-allowed;  }</style>
</#if>


</head>

<body>
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
            <div class="air-account-discount">
                <div class="n-title">我的优惠券</div>
                <div class="tagMenu air-account-menu">
                    <ul class="menu clearfix" style="float:left">
                        <li  <#if codeStatus=='1'>class="current"</#if>  onclick="javascript:location='${basePath}/mycoupon-1.html'"><a href="javascript:;" onclick="_czc.push(['_trackEvent', '我的优惠券', '查看', '未使用优惠券',  'unused_coupons']);" id="unused_coupons">未使用优惠券</a></li>
                        <li <#if codeStatus=='2'>class="current"</#if>  onclick="javascript:location='${basePath}/mycoupon-2.html'"><a href="javascript:;" onclick="_czc.push(['_trackEvent', '我的优惠券', '查看', '已使用优惠券',  'unused_coupons']);" id="used_coupons">已使用优惠券</a>
                        </li>
                        <li <#if codeStatus=='3'>class="current"</#if>  onclick="javascript:location='${basePath}/mycoupon-3.html'"><a href="javascript:;" onclick="_czc.push(['_trackEvent', '我的优惠券', '查看', '已过期优惠券',  'expired_coupons']);" id="expired_coupons">已过期优惠券</a></li>
                    </ul>
                    <botton style="float:right;color: #2272c8;font: 14px/34px 微软雅黑;cursor:pointer;" onclick="addcoupon()">券码兑换</botton>
                </div>
                <div class="content">
                    <div class="layout">
                        <div class="air-discountList">
                        <#if (pb.list?size>0) >
                            <#list pb.list as coupen>
                                <div class="air-discountTic mr20" style="cursor: default;">
                                    <div class="ticTitle">
                                        <div class="tl">
                                            <span class="ticValue">&yen;</span>
                                            <span class="ticValue"><#if coupen.couponRulesType??><#if coupen.couponRulesType=="1" &&(coupen.couponStraightDown.downPrice)??>${coupen.couponStraightDown.downPrice}<#elseif coupen.couponRulesType=="2" &&coupen.couponFullReduction.reductionPrice??>${coupen.couponFullReduction.reductionPrice}</#if></#if></span>
                                        </div>
                                    </div>
                                    <ul>
                                        <li><#if coupen.couponName??>${coupen.couponName}</#if></li>
                                        <li>使用条件：
                                            <#if coupen.couponRulesType??>
                                                <#if coupen.couponRulesType=="1" &&(coupen.couponStraightDown.downPrice)??>
                                                       无门槛使用
                                                <#elseif coupen.couponRulesType=="2" &&coupen.couponFullReduction.fullPrice?? && coupen.couponFullReduction.fullPrice?number==0>
                                                       无门槛使用
                                                <#elseif coupen.couponRulesType=="2" &&coupen.couponFullReduction.fullPrice?? >
                                                    满
                                                    ${coupen.couponFullReduction.fullPrice?string.currency}
                                                </#if>
                                            </#if>
                                        </li>
                                        <#if coupen.timeType?? && coupen.timeType=='1'>
                                            <li>使用日期：有效期&nbsp;至&nbsp;${coupen.couponEndTime?string("yyyy-MM-dd")}</li>
                                        <#else>
                                            <li>使用日期：${coupen.couponStartTime?string("yyyy-MM-dd")}&nbsp;至&nbsp;${coupen.couponEndTime?string("yyyy-MM-dd")}</li>
                                        </#if>



                                            <li>品类限制：<#if coupen.couponRemark??&&coupen.couponRemark?length gt 0>
                                                              ${coupen.couponRemark}
                                                        <#else>
                                                            商城通用券
                                                       </#if>
                                            </li>
                                            <li>平台限制：<#if coupen.businessId==0>${basicSet.bsetName}<#elseif coupen.thirdName??>${coupen.thirdName}</#if></li>

                                    </ul>
                                </div>

                            <#--<div class="air-discountTic mr20">
                                <div class="ticTitle">
                                    <div class="tl">
                                        <span class="ticValue">&yen;</span>
                                        <span class="ticValue"><#if coupen.couponRulesType??><#if coupen.couponRulesType=="1" &&(coupen.couponStraightDown.downPrice)??>${coupen.couponStraightDown.downPrice}<#elseif coupen.couponRulesType=="2" &&coupen.couponFullReduction.reductionPrice??>${coupen.couponFullReduction.reductionPrice}</#if></#if></span>
                                    </div>
                                </div>
                                <ul>
                                    <li><#if coupen.businessId==0>${basicSet.bsetName}自营<#elseif coupen.thirdName??>${coupen.thirdName}</#if></li>
                                    <li>使用条件：<#if coupen.couponRulesType??><#if coupen.couponRulesType=="1" &&(coupen.couponStraightDown.downPrice)??>不限制<#elseif coupen.couponRulesType=="2" &&coupen.couponFullReduction.fullPrice??>满
                                    ${coupen.couponFullReduction.fullPrice?string.currency}
                                    </#if></#if></li>
                                    <li>使用日期：${coupen.couponStartTime?string("yyyy-MM-dd")}&nbsp;至&nbsp;${coupen.couponEndTime?string("yyyy-MM-dd")}</li>
                                    <#if coupen.gclist??>
                                        <li>品类限制：仅可购买指定分类商品</li>
                                        <li>平台限制：<#list coupen.gclist as gclist>${gclist.catName} </#list></li>
                                    </#if>
                                    <#if coupen.gblist??>
                                        <li>品类限制：仅可购买指定品牌商品</li>
                                        <li>平台限制：<#list coupen.gblist as gblist>${gblist.brandName} </#list></li>
                                    </#if>
                                    <#if coupen.gplist??>
                                        <li>品类限制：仅可购买指定商品</li>
                                        <li>平台限制：<#list coupen.gplist as gplist>${gplist.goodsInfoName} </#list></li>
                                    </#if>
                                </ul>
                            </div>-->

                            </#list>
                        <#else>
                            <div  style="margin-top:10px;border:1px #e8e8e8 solid; height:40px; text-align: center; font-size: 18px;line-height:40px;;">
                                暂无优惠券！
                            </div>
                        </#if>

                        </div>
                        <div class="paging_area">
                        <#if pb.list?? && (pb.list?size!=0)>
                                    <#-- 分页 -->
                                        <#import "../pagination/pageBean.ftl" as page>
                                        <@page.pagination pb />
                                    </#if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>  <div class="mask"></div>
<div class="member-dialog dia3">
    <div class="member-dialog-body">
        <div class="title"><a href="javascript:;" onclick="cls()">×</a></div>
        <div class="tc">
            <img src="${basePath}/images/btn_waringcopy@2x.png" alt="" style="width: 45px;height: 45px;margin: 0 auto; margin-top:13px;display: block;">
            <div class="que-delete clearfix">
                <div class="fl tl">
                    <p class="f16 new_p">确定要删除此优惠券吗？</p>
                    <div class="m-btn">

                        <a class="" href="javascript:cls();">取消</a>
                        <a  href="javascript:;" id="delMyCoupon()" class="bnt_ok">确定</a>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
<dl class="addCouponBox clearfix">
    <dt class="head" ><span class="slf"></span><span class="srg" onclick="mycls()">×</span></dt>
    <dd class="content">
        <p class="pcodeNo"><span class="new_span">请输入券码&nbsp;:</span><input type="text" name="codeNo" id="codeNo_id" placeholder="请输入券码"/><span class="sclose">×</span></p>
        <p class="warnComment" style="position:absolute;top:90px;left:136px;color:red"></p>
        <p class="pbtn">确认兑换</p>
    </dd>
</dl>
<#--引入底部 <#include "/index/bottom.ftl" /> -->
<#--shf-->
<#--<div class="footer_tab">-->
    <#--<ul>-->

        <#--<li class="list1"><a href="http://www.ge960.com/channel/237.html">食品荟萃</a></li>-->
        <#--<li class="list2"><a href="http://www.ge960.com/channel/239.html">饮品总汇</a></li>-->
        <#--<li class="list3"><a href="http://www.ge960.com/channel/241.html">购物中心</a></li>-->
        <#--<li class="list4"><a href="http://www.ge960.com/channel/243.html">大药房</a></li>-->

    <#--</ul>-->
<#--</div>-->
<#if (topmap.temp)??>
    <#if (topmap.temp.tempId==1)>
        <#include "../index/bottom.ftl">
    <#else>
        <#include "../index/newbottom.ftl" />
    </#if>
</#if>


<script type="text/javascript" src="${basePath}/js/default.js"></script>
<script type="text/javascript" src="${basePath}/js/jcarousellite_1.0.1.js"></script>
<script type="text/javascript" src="${basePath}/js/tab-switch.js"></script>
<script type="text/javascript" src="${basePath}/js/newapp.js"></script>
<script type="text/javascript" src="${basePath}/js/customer/findcode.js"></script>
<script type="text/javascript" src="${basePath}/js/jsOperation.js"></script>
<script type="text/javascript">
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
        //选择标签
        var codeStatus = $("#codeStatus").val();
        if(codeStatus==1){
            $("#tag1").addClass('current');
            $("#tag2").removeClass('current');
            $("#tag3").removeClass('current');
        }else if(codeStatus==2){
            $("#tag1").removeClass('current');
            $("#tag2").addClass('current');
            $("#tag3").removeClass('current');
        }else if(codeStatus==3){
            $("#tag1").removeClass('current');
            $("#tag2").removeClass('current');
            $("#tag3").addClass('current');
        }
        $(".pro_sort").addClass("pro_sort_close");
        $(".new_member_left div:eq(3) ul li:eq(4)").addClass("cur");
    });
    function showDialog(n){
        $(".mask").fadeIn();
        //$(".promotion_dialog_"+n).fadeIn();
        $(".addCouponBox").show();
        toMoveCouponBox();
    };
    function cls(){
        $(".dialog").fadeOut();
        $(".mask").fadeOut();
    };
    $("#mycoupon").addClass("cur");
    function addcoupon(){
        showDialog()
    }
    function mycls(){
        $(".mask").fadeOut();
        $(".addCouponBox").hide();
    }
    $(".sclose").click(function(){
        $("#codeNo_id").val("");
    })
    window.onresize = function(){
        toMoveCouponBox();
    }
    function toMoveCouponBox(){
        var addCouponBox = document.getElementsByClassName("addCouponBox")[0];
        var couponBoxWidth = addCouponBox.offsetWidth;
        var couponBoxHeight = addCouponBox.offsetHeight;
        addCouponBox.style.left = getXY().x/2-couponBoxWidth/2+"px";
        addCouponBox.style.top = getXY().y/2-couponBoxHeight/2+"px";
    }
    function getXY(){
        if(window.innerHeight){
            return{x:window.innerWidth,
                   y:window.innerHeight}
        }else if(document.compatMode == "CSS1Compat"){
            return{x:document.documentElement.clientWidth,y:document.documentElement.clientHeight}
        }else{
            return {x:document.body.clientWidth,y:document.body.clientHeight}
        }
    }
    document.getElementById("codeNo_id").oninput=document.getElementById("codeNo_id").onpropertychange=function(){
        var couponCode = $("#codeNo_id").val();
        if(couponCode == "" || couponCode == null){
            $(".warnComment").html("<em>* </em>请输入券号");
        }else if(!(/^[A-Za-z0-9]{16}$/).test(couponCode)){
            $(".warnComment").html("<em>* </em>券号格式不正确");
        }else{
            $(".warnComment").html("");
        }
    }
    $(".pbtn").click(function(){
        var couponCode = $("#codeNo_id").val();
        if(couponCode == "" || couponCode == null){
            $(".warnComment").html("<em>* </em>请输入券号");
            return false;
        }
        if(!(/^[A-Za-z0-9]{16}$/).test(couponCode)){
            $(".warnComment").html("<em>* </em>券号格式不正确");
            return false;
        }
        $.ajax({
            url:"addSiteCoupons.htm",
            type:"post",
            data:{couponCode:couponCode},
            success:function(data){
                if(data == 2){
                    $(".warnComment").html("<em>* </em>添加成功");
                    setTimeout(function(){
                        window.location.reload();
                    },500)
                }else if(isNaN(data)){
                    window.location.href="${basePath}/"+data;
                }else if(data == 3){
                    $(".warnComment").html("<em>* </em>您领取的该优惠券已达上限");
                }else{
                    $(".warnComment").html("<em>* </em>输入的券码无效");
                }
            }
        });

    });
</script>
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
