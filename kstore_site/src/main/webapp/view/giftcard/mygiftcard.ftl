<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>我的礼品卡-${topmap.systembase.bsetName}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="Keywords" content="${topmap.seo.meteKey}">
    <meta name="description" content="${topmap.seo.meteDes}">
<#assign basePath=request.contextPath>
<#if (topmap.systembase.bsetHotline)??>
    <link rel="Shortcut Icon" href="${(topmap.systembase.bsetHotline)!''}">
<#else>
    <link rel="Shortcut Icon" href="${basePath}/images/Paistore.ico">
</#if>
    <link rel="stylesheet" type="text/css" href="${basePath}/css/pages.css"/>
    <#--<link rel="stylesheet" href="${basePath}/index_seven/css/style.css">-->
    <#--<link rel="stylesheet" href="${basePath}/index_twentyone/css/index_css.m.css"/>-->
    <#--<link rel="stylesheet" href="${basePath}/css/ui-dialog.css"/>-->
    <link rel="stylesheet" type="text/css" href="${basePath}/css/receive.m.css"/>
    <script type="text/javascript" src="${basePath}/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${basePath}/index_960/js/app.js"></script>
    <#--shf-->
    <link rel="stylesheet" href="${basePath}/index_960/css/style.css"/>
    <link rel="stylesheet" href="${basePath}/index_twentyone/css/index_css.m.css">
    <style>
        .cart-top {
            top: 5px !important;
        }
        /*shf*/
        .section_headerTop{
            background: none!important;
            border-bottom: none!important;
        }
        /*shf*/
        .section-header{
            height:auto;
        }
        .mainnav .showlist .btnnav{
            background: none;
        }
        /*.mainnav .showlist .btnnav a{
            text-indent: 50px;
        }*/
        #logo{
            padding-top: 0;
        }
        .mainnav{
            margin-top: 0;
        }
       /* .dropdown-menu{
            background: #0d9901!important;
        }*/
       /* .dropdown-menu li:hover{
            background-color:#fff!important;
        }*/
        .search{
            position: static!important;
            margin: 0!important;
        }
        .rightpar{
            display: none;
        }
    </style>

</head>
<body>

<#--shf-->
<#include "../index/newheader3.ftl"/>
<div style="background: #fff;color:green;">
    <div class="container clearfix pt20 pb10">
        <#include "../customer/newleftmenu.ftl" />

            <div class="new_member-right">
                <div class="new_order_list">
                    <div class="n-title">我的礼品卡</div>
                    <div class="ex-bar-total ex-bar-lg clearfix">
                        <dl class="box">
                            <dt>礼品卡账户余额：</dt>
                            <dd>${(deposit.preDeposit+deposit.freezePreDeposit)?string('0.00')}元</dd>
                        </dl>
                        <dl class="box">
                            <dt>可用余额：</dt>
                            <dd><span class="red">${deposit.preDeposit?string('0.00')}</span>元</dd>
                        </dl>
                        <dl class="box">
                            <dt>冻结款总额：</dt>
                            <dd>${deposit.freezePreDeposit?string('0.00')}元</dd>
                        </dl>
                        <div class="buttons">
                            <#if deposit?? && deposit.giftcardNo?? && (deposit.giftcardNo?length>0)>
                                <#if activeFlag == '-2'>
                                    <a href="javascript:void(0);" onclick="_czc.push(['_trackEvent', '我的礼品卡', '查看', '已挂失',  'have_report_loss']);" id="have_report_loss">已挂失</a>
                                <#else>
                                    <a href="/giftcard/rechargeviewNew.htm" class="red" target="_blank" onclick="_czc.push(['_trackEvent', '我的礼品卡', '查看', '充值',  'top_up']);" id="top_up">充值</a>
                                </#if>
                            <#else>
                                <a href="/giftcard/bindGiftcardFirst.htm" class="red" target="_blank" onclick="_czc.push(['_trackEvent', '我的礼品卡', '查看', '绑定',  'bound_widget']);" id="bound_widget">绑定</a>
                            </#if>
                            <#--<a onclick="newWithdraw()">提现</a>-->
                        </div>
                    </div>
                    <div class="order-menu">
                        <ul class="menu clearfix">

                            <li>
                                <a href="${basePath}/deposit/mydeposit.htm" onclick="_czc.push(['_trackEvent', '我的礼品卡', '查看', '全部',  'all_quanbu']);" id="all_quanbu">全部</a>
                            </li>
                            <li>
                                <a href="${basePath}/deposit/mydeposit.htm?type=0" onclick="_czc.push(['_trackEvent', '我的礼品卡', '查看', '收入',  'income_shouru']);" id="income_shouru">收入</a>
                            </li>
                            <li>
                                <a href="${basePath}/deposit/mydeposit.htm?type=1" onclick="_czc.push(['_trackEvent', '我的礼品卡', '查看', '收入',  'expend_zhichu']);" id="expend_zhichu">支出</a>
                            </li>
                        </ul>
                        <div class="select-box" onmouseover="$(this).addClass('open')" onmouseout="$(this).removeClass('open')">
                            <span class="value"><!-- 时间段 -->
                                <#if time==''>
                                    近三个月收支明细
                                <#elseif time=='before3Month'>
                                    三个月前收支明细
                                <#elseif time=='before1Year'>
                                    一年前收支明细
                                </#if>
                                <i></i>
                            </span>
                            <div class="options">
                                <a href="javascript:;"
                                   <#if time==''>
                                   class="selected"
                                   </#if>
                                   onclick="addFormParam('')">
                                    近三个月收支明细
                                </a>
                                <a href="javascript:;"
                                    <#if time=='before3Month'>
                                       class="selected"
                                    </#if>
                                   onclick="addFormParam('before3Month')">
                                    三个月前收支明细
                                </a>
                                <a href="javascript:;"
                                    <#if time=='before1Year'>
                                       class="selected"
                                    </#if>
                                   onclick="addFormParam('before1Year')">
                                    一年前收支明细
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="content">
                        <div class="layout" id="No0">
                            <table class="bought-table mt10">
                                <thead>
                                <tr>
                                    <th>时间</th>
                                    <th>交易类型</th>
                                    <!--
                                    <th>收入金额</th>
                                    <th>支出金额</th>
                                    -->
                                    <#if type??><!-- type不空 -->
                                        <#if type == '0'>
                                            <th>收入金额</th>
                                        <#elseif type == '1'>
                                            <th>支出金额</th>
                                        <#elseif type == ''>
                                            <th>收入金额</th>
                                            <th>支出金额</th>
                                        </#if>
                                    <#else>

                                    </#if>
                                    <th>交易状态</th>
                                    <th>当前余额</th>
                                    <th>备注</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <#if pb.list??&&(pb.list?size!=0)>
                                        <#list pb.list as trade>
                                        <tr class="order-bd">
                                            <td>
                                                ${trade.createTime?string("yyyy-MM-dd HH:mm:ss")}
                                            </td>
                                            <td>
                                                <!-- 判断订单类型 -->
                                                <#if trade.orderType=='0'>
                                                    在线充值
                                                <#elseif trade.orderType=='1'>
                                                    订单退款
                                                <#elseif trade.orderType=='2'>
                                                    线下提现
                                                <#elseif trade.orderType=='3'>
                                                    订单消费
                                                <#else>
                                                    线下充值
                                                </#if>
                                            </td>

                                            <#if type??><!-- type不空 -->
                                                <#if type=='0'>
                                                    <td>
                                                        <#if trade.orderType=='0' || trade.orderType=='1' || trade.orderType=='4' || trade.orderType=='5' || trade.orderType=='6' || trade.orderType=='7'>
                                                            <span class="green">+￥${trade.orderPrice!''}</span>
                                                        </#if>
                                                    </td>
                                                <#elseif type=='1'>
                                                    <td>
                                                        <#if trade.orderType=='2' || trade.orderType=='3' || trade.orderType=='8'>
                                                            <span class="red">-￥${trade.orderPrice?string('0.00')}</span>
                                                        </#if>
                                                    </td>
                                                <#elseif type==''>
                                                    <td>
                                                        <#if trade.orderType=='0' || trade.orderType=='1' || trade.orderType=='4' || trade.orderType=='5' || trade.orderType=='6' || trade.orderType=='7'>
                                                            <span class="green">+￥${trade.orderPrice?string('0.00')}</span>
                                                        </#if>
                                                    </td>
                                                    <td>
                                                        <#if trade.orderType=='2' || trade.orderType=='3' || trade.orderType=='8'>
                                                            <span class="red">-￥${trade.orderPrice?string('0.00')}</span>
                                                        </#if>
                                                    </td>
                                                </#if>
                                            <#else>

                                            </#if>

                                            <td>
                                                <!-- 0【提现】待审核 1【提现】已打回 2【提现】已通过待打款 3【提现】已打款待确认 4【提现】已完成 5充值中 6充值成功 7充值失败 8已取消-->
                                                <#if trade.orderStatus??&&trade.orderStatus=='0'>
                                                    待审核
                                                <#elseif trade.orderStatus??&&trade.orderStatus=='1'>
                                                    已打回
                                                <#elseif trade.orderStatus??&&trade.orderStatus=='2'>
                                                    已通过
                                                <#elseif trade.orderStatus??&&trade.orderStatus=='3'>
                                                    待确认
                                                <#elseif trade.orderStatus??&&trade.orderStatus=='4'>
                                                    已完成
                                                <#elseif trade.orderStatus??&&trade.orderStatus=='5'>
                                                    <!--充值中 状态修改-->
                                                    未支付
                                                <#elseif trade.orderStatus??&&trade.orderStatus=='6'>
                                                    <#if trade.orderCode?index_of("G")!=-1><#--第一次礼品卡绑定提示不同-->
                                                        绑定成功
                                                    <#else>
                                                        充值成功
                                                    </#if>
                                                <#elseif trade.orderStatus??&&trade.orderStatus=='7'>
                                                    <!-- 充值失败 状态修改-->
                                                <#elseif trade.orderStatus??&&trade.orderStatus=='8'>
                                                    已取消
                                                <#else>
                                                    已完成
                                                </#if>
                                            </td>

                                            <td>
                                                ￥${trade.currentPrice?string('0.00')}
                                            </td>
                                            <td style="word-wrap: break-word;" title="${trade.tradeRemark!''}">
                                                <input class="tradeRemark" type="hidden" value="${trade.tradeRemark!''}">
                                                <!-- trade.tradeRemark!'' -->
                                                <#-- ${trade.tradeRemark!''}-->
                                                <!--  这段代码构建一个备注信息，由于这个信息只是一堆字符串 -->
                                            </td>
                                        </tr>
                                    </#list>
                                <#else>
                                    <tr>
                                        <td colspan=
                                            <#if type??>
                                                <#if type=='0'>
                                                    6
                                                <#elseif type=='1'>
                                                    6
                                                <#elseif type==''>
                                                    7
                                                </#if>
                                            <#else>

                                            </#if>
                                            >
                                            <center class="m10">暂无明细</center>
                                        </td>
                                    </tr>
                                </#if>
                            </tbody>
                        </table>

                        <#if pb?? && pb.list?? && (pb.list?size!=0)>
                            <#import "../deposit/pageable/pageable.ftl" as page>
                            <@page.pagination pb />
                        </#if>
                    </div>

                </div>
            </div>
        </div>

</div>
</div>

<#if (topmap.temp)??>
    <#if (topmap.temp.tempId==1)>
        <#include "../index/bottom.ftl">
    <#else>
        <#include "../index/newbottom.ftl" />
    </#if>
</#if>

<div class="mask">
    <form id="queryForm" method="get">
        <input type='hidden' name='time' value='${time!''}'><!-- 查询分类 -->
    </form>
</div>

<script type="text/javascript" src="${basePath}/js/default.js"></script>
<script type="text/javascript" src="${basePath}/js/tab-switch.js"></script>
<script type="text/javascript" src="${basePath}/js/customer/customer.js"></script>
<script type="text/javascript" src="${basePath}/js/newapp.js"></script>
<script type="text/javascript" src="${basePath}/js/customer/findcode.js"></script>
<script type="text/javascript" src="${basePath}/js/jsOperation.js"></script>

<script src="${basePath}/js/plugin/artDialog/dialog.js"></script>

<script>

    var pwdExist = ${pwdExist?c};

    function newWithdraw() {
        if (pwdExist) {
            window.open('/deposit/withdraw/new.htm');
        }
        else {
            dialog({
                title: '提示信息',
                content: '必须先设置支付密码后才可提现',
//                skin: 'warning',
                width: 200,
                height: 40,
                okValue: '去设置',
                cancelValue: '取消',
                ok: function () {
                    window.open('/customer/securitycenter.html');
                },
                cancel: function () {
                    return true;
                }
            }).showModal();
        }
    }

    //添加form查询条件
    var pageSize = '${pb.pageSize}';
    var pageNo = '${pb.pageNo}';
    var type = '${type!''}';
    function addFormParam(time){
        $("#queryForm")
                .empty()
                .attr('action','/deposit/mydeposit.htm')
                .append("<input type='hidden' name='pageSize' value='"+pageSize+"'>")
                .append("<input type='hidden' name='pageNo' value='1'>")
                .append("<input type='hidden' name='time' value='"+time+"'>")
                .append("<input type='type' name='type' value='"+type+"'>")
                .submit();
    }
    //分页函数，js控制，来控制多参数
    function page(pageNo,pageSize) {
        $("#queryForm").attr('action','/deposit/mydeposit.htm')
                .append("<input type='hidden' name='pageSize' value='"+pageSize+"'>")
                .append("<input type='hidden' name='pageNo' value='"+pageNo+"'>")
                .append("<input type='type' name='type' value='"+type+"'>")
                .submit();
    }

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

    if(type){
        if(type=="0"){
            $(".menu.clearfix li:eq(1)").addClass("current");
        }else if(type=="1"){
            $(".menu.clearfix li:eq(2)").addClass("current");
        }
    }else{
        $(".menu.clearfix li:eq(0)").addClass("current");
    }
    //li 点击
    $(".menu.clearfix li").click(function(){
        var $this = $(this);
        window.location.href = $this.find("a").attr("href");
    });
    //设置备注信息
    function setTradeRemark(){
        var trs = $(".tradeRemark");
        var count = trs.length;
        var oneTr = null;
        for(var i=0;i<count;i++){
            oneTr = $(trs[i]);
            if(!oneTr){continue;}
            var val = oneTr.val();
            var rs = val.split(",");
            var html = "";
            //订单编号:2016101914405910,订单编号:2016101914405910，这种格式
            if(rs.length>=2){
                for(var j=0;j<rs.length;j++){
                    var k = rs[j];
                    var splits = k.split(":");
                    if(splits.length>=2){
                        html+=splits[0]+":<br>";
                        html+=splits[1]+"<br>";
                    }else{
                        html+=splits[0]+"<br>";
                    }
                }
            }else{
                var splits = val.split(":");
                if(splits.length>=2){
                    html+=splits[0]+":<br>";
                    html+=splits[1]+"<br>";
                }else{
                    html+=splits[0]+"<br>";
                }
            }
            $(oneTr).parent().html(html);
        }
    }
    setTradeRemark();
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