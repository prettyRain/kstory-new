<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>我的预存款-${topmap.systembase.bsetName}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="Keywords" content="${topmap.seo.meteKey}">
    <meta name="description" content="${topmap.seo.meteDes}">
<#assign basePath=request.contextPath>
<#if (topmap.systembase.bsetHotline)??>
    <link rel="Shortcut Icon" href="${(topmap.systembase.bsetHotline)!''}">
<#else>
    <link rel="Shortcut Icon" href="${basePath}/images/Paistore.ico">
</#if>
    <link rel="stylesheet"href="${basePath}/css/pages.css"/>
    <link rel="stylesheet" href="${basePath}/index_twentyone/css/index_css.m.css"/>
    <link rel="stylesheet" href="${basePath}/index_seven/css/style.css"/>
    <link rel="stylesheet" href="${basePath}/css/receive.m.css"/>
    <script type="text/javascript" src="${basePath}/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${basePath}/index_960/js/app.js"></script>
    <style>
        .cart-top {
            top: 5px !important;
        }
        #logo{
            padding-top:0;
        }
        label.error {
            display: block;
            line-height: 20px;
            padding-left: 18px;
            background: url('../images/ero.png') no-repeat left center;
            color: #E45050;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<#--一引入头部 <#include "/index/topnew.ftl" />
<#if (topmap.temp)??>
    <#if (topmap.temp.tempId==8)>
        <#include "../index/newtop3.ftl">
    <#elseif (topmap.temp.tempId==9)>
        <#include "../index/newtop4.ftl">
    <#elseif (topmap.temp.tempId==10)>
        <#include "../index/newtop7.ftl">
    <#elseif (topmap.temp.tempId==11)>
        <#include "../index/newtop6.ftl">
    <#elseif (topmap.temp.tempId==12)>
        <#include "../index/newtop7.ftl">
    <#elseif (topmap.temp.tempId==13)>
        <#include "../index/newtop8.ftl">
    <#elseif (topmap.temp.tempId==14)>
        <#include "../index/newtop9.ftl">
    <#elseif (topmap.temp.tempId==15)>
        <#include "../index/newtop8.ftl">
    <#elseif (topmap.temp.tempId==16)>
        <#include "../index/newtop11.ftl">
    <#elseif (topmap.temp.tempId==17)>
        <#include "../index/newtop12.ftl">
    <#elseif (topmap.temp.tempId==18)>
        <#include "../index/newtop13.ftl">
    <#elseif (topmap.temp.tempId==19)>
        <#include "../index/newtop14.ftl">
    <#elseif (topmap.temp.tempId==20)>
        <#include "../index/newtop15.ftl">
    <#elseif (topmap.temp.tempId==21)>
        <#include "../index/newtop21.ftl">
    <#else>
        <#include "../index/newtop.ftl"/>
    </#if>
</#if>

<#include "../customer/newtop.ftl"/>
-->
<div style="">
<#--shf引入头-->
<#include "../common/newHeaderShopcart.ftl"/>
<#--<div class="container clearfix pr">
    <div class="mini_head">
        <h1 class="logo">
            <a href="${topmap.systembase.bsetAddress}">
                <img src="${topmap.systembase.bsetLogo}" alt="" width="165px" height="70px"/>
            </a>
            <span>提现</span>
        </h1>
    </div>
</div>-->

    <div style="background: #f5f5f5;">
        <div class="container clearfix pt20 pb10">
            <div class="recharge-box">
                <div class="title">
                    <p class="h2">充值到预存款</p>
                    <p class="light">当前预存款总额：<strong>￥${totalDeposit?string('0.00')} </strong></p>
                </div>
                <div class="body">
                    <form action="${basePath}/customer/deposit/recharge" id="rechargeForm" method="post"
                          target="_blank">
                        <div class="box">
                            <p class="h4">请选择充值方式：</p>
                            <ul class="types clearfix">
                                <#if map.payList??>
                                    <#list map.payList as pay>
                                        <#if pay.payDefault=="1">
                                            <input type="hidden" value="${pay.payId}" name="payId" id="payId"/>
                                        </#if>
                                    </#list>
                                 </#if>

                            <#if map.payList??>
                                <#list map.payList as pay>
                                    <#if (pay.payType=='1' && pay.isOpen=='1')>
                                        <li title="${pay.payName}">
                                        <a
                                            <#if pay.payDefault=="1">
                                                    class="selected"
                                            </#if>
                                                    href="javascript:;">
                                            <img src="${basePath}/images/payment1.jpg" alt=""
                                                 onclick="changethis(this,${pay.payId});" alt="${pay.payName}">
                                        </a>
                                    </li>
                                    </#if>

                                    <#if (pay.payType=='7' && pay.isOpen=='1')>
                                        <li title="${pay.payName}">
                                            <a
                                                <#if pay.payDefault=="1">
                                                        class="selected"
                                                </#if>
                                                        href="javascript:;">
                                                <img src="${basePath}/images/weixin_pay.png" alt=""
                                                     onclick="changethis(this,${pay.payId});" alt="${pay.payName}">
                                            </a>
                                        </li>
                                    </#if>

                                        <#if (pay.payType=='2' && pay.isOpen=='1')><!-- 银联 -->
                                        <li title="${pay.payName}">
                                            <a
                                                <#if pay.payDefault=="1">
                                                        class="selected"
                                                </#if>
                                                        href="javascript:;">
                                                <img src="${basePath}/images/payment4.jpg" alt=""
                                                     onclick="changethis(this,${pay.payId});" alt="${pay.payName}">
                                            </a>
                                        </li>
                                    </#if>

                                        <#if (pay.payType=='4' && pay.isOpen=='1')><!-- 千米收银台 -->
                                        <li title="${pay.payName}">
                                            <a
                                                <#if pay.payDefault=="1">
                                                        class="selected"
                                                </#if>
                                                        href="javascript:;">
                                                <img src="${basePath}/images/payment5.jpg" alt=""
                                                     onclick="changethis(this,${pay.payId});" alt="${pay.payName}">
                                            </a>
                                        </li>
                                    </#if>

                                </#list>
                            </#if>

                            </ul>
                        </div>
                        <div class="box">
                            <p class="h4">充值金额：</p>
                            <div class="charge-form">
                                <input type="text" class="text" style="display: none"/>
                                <input type="text" class="text" placeholder="0.00" id="totalFee" name="totalFee"/>
                                <span>元</span>
                            </div>
                        <#--<p class="error" style="display: none;">金额必须为整数或小数，小数点后不超过2位</p>-->
                        </div>
                        <div class="box">
                            <a href="javascript:;" class="charge-btn" id="submitRecharge"
                               onclick="validateForm();">确认充值</a>
                        </div>
                    </form>
                </div>
                <div class="charge-tips">
                    <p class="h4">充值提示</p>
                    <p>1.充值成功后，预存款可能存在延迟现象，一般1到5分钟内到账，如有问题，请咨询客服；</p>
                    <p>2.充值金额必须大于0，且不得超过1,000,000元；</p>
                    <p>3.支付密码输错3次将锁定预存款账户，锁定后可充值，不可消费和提现，第二天系统自动解锁。</p>
                </div>
            </div>
        </div>
    </div>

    <div class="member-dialog dia1" id="dia1">
        <div class="member-dialog-body">
            <div class="title"><a href="javascript:;" onclick="cls()">×</a>提示</div>
            <div class="dia-tips">
                <p class="txt">
                    请确认是否已经完成支付
                </p>
            </div>
            <div class="dia-btn">
            <a class="btn active" href="${basePath}/deposit/mydeposit.htm">完成支付</a>
            <a class="btn" href="javascript:void(0)" onclick="showHelp()" id="payhelp">付款遇到问题</a>
        </div>
        </div>
    </div>
    <div class="dialog dia2 agreement_dia" id="dia2">
        <div class="dia_tit clearfix">
            支付问题描述
            <a class="dia_close fr" href="javascript:;" onclick="cls()"></a>
        </div>
        <div class="dia_cont" style="padding-bottom:15px;">
            <div class="agreement_wp no_tc pt30" id="payHelpDesc" style="width:auto">
                <input type="hidden" id="customer_id" value="${cust.customerId}"/>
                <input type="hidden" value="${token!''}" id="hi_token" />
                <div class="content">
                    <div class="layout">
                        <table class="complain-table">
                            <tr>
                                <td id="rOrderCode">涉及订单：</td>
                            </tr>
                            <tr>
                                <td>问题描述：<textarea id="complaincon" maxlength="250" style="height: 60px;"></textarea><br/>
                                    <p style="margin-left: 70px;">请输入您支付时遇到的问题，以便我们能够及时协助您！</td></tr>
                            <tr>
                                <td><a class="complain-submit" onclick="addcomplain1()" style="margin-left: 70px;">提交</a></td>
                            </tr>
                        </table>
                    </div>
                    <p>
                        <br />
                    </p>
                    <p style="font-size:13px;color:#6B717A;font-family:&quot;">
                        <strong>支付中遇到问题</strong>
                    </p>
                    <p style="font-size:13px;color:#6B717A;font-family:&quot;">
                        <strong>1、页面提示“支付密码错误，请重试”怎么办？</strong>
                    </p>
                    <p style="font-size:13px;color:#6B717A;font-family:&quot;">
                        <strong>答：点击“重试”，输入正确支付密码！</strong>
                    </p>
                    <p style="font-size:13px;color:#6B717A;font-family:&quot;">
                        <strong>2、页面提示“银行卡可用余额不足（如信用卡则为可透支额度不足），请核实后再试“怎么办？</strong>
                    </p>
                    <p style="font-size:13px;color:#6B717A;font-family:&quot;">
                        <strong>答：点击“添加新卡支付”添加一张余额可以支付的银行卡。重新支付！</strong>
                    </p>
                    <p style="font-size:13px;color:#6B717A;font-family:&quot;">
                        <strong>3、系统繁忙或网络连接错误怎么办？</strong>
                    </p>
                    <p style="font-size:13px;color:#6B717A;font-family:&quot;">
                        <strong>答：请检查网络状态是否正常，正常状态下重新支付！</strong>
                    </p>
                    <p>
                        <br />
                    </p>
                </div>
            </div>
            <div class="dia_ops mt20 tc">
            </div>
        </div>
    </div>
    <div class="member-dialog dia3">
        <div class="member-dialog-body">
            <div class="title"><a href="javascript:;" onclick="cls1()">×</a>提示</div>
            <div class="tc">
                <div class="que-delete clearfix">
                    <img src="${basePath}/images/images_l6.png"/>
                    <div class="fl tl">
                        <p class="f16 red" id="errorContent"></p>

                        <div class="m-btn mt20">
                            <a href="javascript:;" onclick="cls1()">确定</a>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<#--引入底部 <#include "/index/bottom.ftl" />  -->
<#if (topmap.temp)??>
    <#if (topmap.temp.tempId==1)>
        <#include "../index/bottom.ftl">
    <#else>
        <#include "../index/newbottom.ftl" />
    </#if>
</#if>

<div class="mask"></div>

<script type="text/javascript" src="${basePath}/js/default.js"></script>
<script type="text/javascript" src="${basePath}/js/tab-switch.js"></script>
<script type="text/javascript" src="${basePath}/js/customer/customer.js"></script>
<script type="text/javascript" src="${basePath}/js/jsOperation.js"></script>

<script type="text/javascript" src="${basePath}/js/common/jquery.validate.js"></script>
<script type="text/javascript" src="${basePath}/js/common/jquery.validate_extend.js"></script>

<script>
    function changethis(obj, id) {
        $("#payId").val(id);
        $(".types li>a").removeClass("selected");
        $(obj).parent('a').addClass("selected");
    }


    var $form = $("#rechargeForm");
    $form.validate({
        rules: {
            payId: {
                required: true
            },
            totalFee: {
                required: true,
                money: true,
                min:0.01,
                max: 1000000,
            },
        },
        messages: {
            payId: {
                required: '请选择支付方式'
            },
            totalFee: {
                required: '请输入充值金额',
                money: '金额必须为整数或小数，小数点后不超过2位',
                max: '充值金额不可超过1,000,000元',
            },
        },
        errorPlacement: function (error, element) {
            $(element).parents('.box').append(error);
        },
    });

    $form.validate();

    function validateForm() {
        if ($form.valid()) {
            var payId = $("#payId").val();
            if(payId == 38){
                $("#rechargeForm").attr("action", "${basePath}/weixinpay_recharge.htm");
            }else{
                $("#rechargeForm").attr("action", "${basePath}/customer/deposit/recharge");
            }
            dia(1);
            $form.submit();
        }
    }


    $(function () {
        if ($('.types li>a.selected').size() == 0) {
            $('.types li:eq(0)>a>img').click();
        }
        else{
            $('.types li>a.selected').click();
        }

    });
    function resultClient(){
        if(window.innerWidth!=null){  //ie9以上  及谷歌 火狐
            return {
                width:window.innerWidth,
                height:window.innerHeight
            }
        }else if(document.compatMode=="CSS1Compat"){ //ie678
            return {
                width:document.documentElement.clientWidth,
                height:document.documentElement.clientHeight
            }
        }else {   //怪异文档  没有头
            return {
                width:document.body.clientWidth,
                height:document.body.clientHeight
            }
        }
    }
    function showHelp(){
        var dia1 = document.getElementById("dia1");
        var dia2 = document.getElementById("dia2");
        dia1.style.display = "none";
        dia2.style.display = "block";
        dia2.style.width="910px";
        dia2.style.height="446px";
        var _wd = resultClient().width;
        var _hd = resultClient().height;
        dia2.style.left = (_wd-dia2.offsetWidth)/2 + "px";
        dia2.style.top = (_hd-dia2.offsetHeight)/2 + "px";
        var rOrderCodee = document.getElementById("rOrderCode");
        $.ajax({
            url:"/queryRorderCode.htm",
            data:{
                CSRFToken:$("#hi_token").val()
            },
            type:"get",
            success:function(result){
                rOrderCodee.innerHTML=rOrderCodee.innerHTML+ result;
            }
        })
    }
    function cls1(){
        $(".dia3").fadeOut();
    };
    function addcomplain1() {
        var reg1=/^(([^\^\.<>%&',;=?$"'#~\]\[{}\\/`\|])*)$/;
        var orderNo = "";
        var str = document.getElementById("rOrderCode").innerHTML;
        orderNo = str.substring(str.indexOf("R"));
        var comType = "其他方面";
        var comCon = $("#complaincon").val();
        var customerId=$("#customer_id").val();

        if (comCon == null || $.trim(comCon).length < 10 || $.trim(comCon).length > 250) {
            $("#errorContent").html("字数在10-250字内!");
            dia(3)
            return;
        } else {
            if(!reg1.test(comCon)){
                $("#errorContent").html("不能包含特殊字符!");
                dia(3)
                return;
            }
            $(".c_tip").removeClass("m_tip").html("不能包含特殊字符请您如实填写原因，字数在10-250字内且不要包含特殊字符。");

        }
        var paramStr = "complainType=" + comType;
        paramStr += "&complainContext=" + comCon;
        paramStr += "&orderNo=" + orderNo;
        if("undefined" != typeof(customerId)){
            paramStr += "&customerId=" + parseInt(customerId);
        }
        paramStr += "&CSRFToken="+$("#hi_token").val();
        $.ajax({
            type : 'post',
            url : '/customer/addcomplain.html',
            data : paramStr,
            async : false,
            success : function(data) {
                if (data > 0) {
                    $("#errorContent").html("提交成功！");
                    dia(3);
                    setTimeout(function(){
                        //跳转到结果页面，并传递状态
                        window.location.href= "/deposit/mydeposit.htm"
                    },1000)
                } else {
                    $("#errorContent").html("提交失败，请稍后重试！");
                    dia(3);
                }
            },
            error : function(){
                $("#errorContent").html("系统繁忙，请稍后重试！");
                dia(3);
            }
        });
    }
</script>

</body>
</html>