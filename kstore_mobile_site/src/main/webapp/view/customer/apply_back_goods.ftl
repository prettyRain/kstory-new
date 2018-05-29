<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>订单-申请退货</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="keywords" content="${(seo.meteKey)!''}">
    <meta name="description" content="${(seo.meteDes)!''}">
    <#assign basePath=request.contextPath>
    <link rel="stylesheet" href="${basePath}/css/style.min.css"/>
    <link rel="stylesheet" href="${basePath}/css/ui-dialog.css"/>
    <link rel="stylesheet" href="${basePath}/css/new_returns.css"/>
    <script src="${basePath}/js/jquery-1.10.1.js"></script>
    <script src="${basePath}/js/pageAction.js"></script>
    <script src="${basePath}/js/dialog-min.js"></script>
    <style>
        .checkType{
            color: #199301!important;
        }
        <#--新弹窗样式-->

        .tip-box {
            position: fixed;
            top:1%;
            /* margin-top: -50px;*/
            width: 100%;
            z-index: 9999;
            text-align: center
        }

        .tip-box .tip-body {
            align-items: center;
            display: inline-block;
            margin: 0 auto;
            padding: 0.91em 0.34em 1.01em 0.34em;
            -webkit-border-radius: 15px;
            -moz-border-radius: 15px;
            height: .46rem;
            /*    background-color: rgba(51, 51, 51, .9)*/
            background-image: linear-gradient(-228deg, #FFAC4C 0%, #FE7425 100%);
            box-shadow: 0 2px 7px 0 rgba(254,116,37,0.46);
            border-radius: 15px;
        }

        .tip-box .tip-body:after {
            content: '';
            display: block;
            clear: both
        }

        .tip-box .tip-body h3 {
            line-height: 0.3em;
            vertical-align: middle;
            font-size: .8em;
            color: #FFFFFF;
            letter-spacing: 0.86px;
        }
    </style>
</head>
<body>
<#assign vtitle="申请退货" />
<#assign backUrl="${basePath}/customer/myorder.html" />
<#include "/common/head_back.ftl"/>
    <input id="basePath" type="hidden" value="${basePath!''}"/>
<div class="order content-order-aftersale">
 <form id="upload-form" name="upload-form" method="post" enctype="multipart/form-data" target="hidden_frame">
    <input name="isBack" type="hidden" value="1" />
    <input id="customerId" type="hidden" value="${cusId!''}" name="customerId"/>
    <input id="backGoodsId" type="hidden" value="" name="backGoodsIdAndSum"/>
    <input id="applyCredentials" type="hidden" value="3" name="applyCredentials"/>
    <input id="backReason" type="hidden" value="" name="backReason"/>
     <input type="hidden" id="returnType" name="returnType" value="0" >
    <input id="isUseCoupon" type="hidden" value="${(isUseCoupon)!0}" name="isUseCoupon"/>
  <#--  <div class="order-number">
        <div class="list-item">
            <h3 class="item-head text-them">申请退货</h3>

            <h3 class="item-head"><label for="">订单号：</label><span>${order.orderCode!''}</span></h3>

            <h3 class="item-head"><label for="">订单总额：</label><span class="text-them">￥${(order.orderPrice)?string('0.00')}</span></h3>
            <h3 class="item-head"><label for="">退款金额：</label><span class="text-them" id="backorderprice">￥0.00</span></h3>
            &lt;#&ndash;<span class="backPriceContent" style="color:red;"><#if isUseCoupon?? && isUseCoupon='1'>注:此订单使用了优惠券，请整单进行退货。</#if></span>&ndash;&gt;
        </div>
    </div>-->
     <div <#--class="mt10"-->>
         <div class="list-item" style="padding: 0;">
             <div class="list-value">
                 <ul class="leixing">
                     <li class="checkType" name="0">退货退款</li>
                     <li name="1">仅退款</li>
                 </ul>
             </div>
         </div>
     </div>
    <div class="mt10">
        <div class="order-info">
            <div class="list-body-line" style="background: #ffffff;">
             <span class="backGoodsContent" style="color:red;"></span>
                <#if backorder??>
                    <#list backorder.goods as border>
                        <#if border_index lt 2>
                                <div class="list-item" style="margin-left: 15px;padding: .8em 15px 0rem 0px;">
                                    <#if border.goodsName??&& (border.goodsName?index_of("电子卡") == -1 && border.goodsName?index_of("实体卡") == -1)>
                                        <#if isUseCoupon?? && isUseCoupon='1'><#else><div class="check-box choosegood"  backprice="${border.goodsBackPrice!0}" backstr="${border.goodsId!0},${border.goodsNum!0},${border.orderGoodsId}"></div></#if>
                                    </#if>

                                <div class="pro-item <#if !(isUseCoupon?? && isUseCoupon='1')>pro-items</#if>" style="border-bottom: 1px solid #eeeeee;">
                                    <div class="propic">
                                    <a href="javascript:;">
                                        <img alt="" src="${border.goodsImg!''}"  width="78" height="78"  title="${(border.goodsName)!''}" alt="${(border.goodsName)!''}" />
                                    </div>
                                    <div class="prodesc" style="padding-right: 20px;!important;">
                                        <h3 class="title " id="prodesctitle">
                                            <#if border.isPresent?? && border.isPresent == '1'>
                                                <img src="../../images/v2/gift@2x.png" width="26" height="14" style="vertical-align: middle;margin-bottom: 3px;">
                                            </#if> ${border.goodsName!''}</h3>
                                        <#if border.countRush?? && border.countRush?number != 0 && border.goodsNum?number gt border.countRush?number>
                                            <p class="price" id="prodescprice">
                                                <span class="num">¥&nbsp;${border.goodsOldPrice?string('0.00')?substring(0,border.goodsOldPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${border.goodsOldPrice?string('0.00')?substring(border.goodsOldPrice?string('0.00')?index_of('.'))}</span>
                                                <span class="pro-num">×${border.goodsNum?number - border.countRush?number}</span>
                                            </p>
                                            <p class="price" id="prodescprice">
                                                <span class="num">¥&nbsp;${border.goodsPrice?string('0.00')?substring(0,border.goodsPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${border.goodsPrice?string('0.00')?substring(border.goodsPrice?string('0.00')?index_of('.'))}</span>
                                                <span class="pro-num">×${border.countRush}</span>
                                            </p>

                                        <#else>
                                            <p class="price" id="prodescprice" style="    visibility: hidden;">
                                                <span class="num">¥&nbsp;${border.goodsPrice?string('0.00')?substring(0,border.goodsPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${border.goodsPrice?string('0.00')?substring(border.goodsPrice?string('0.00')?index_of('.'))}</span>
                                                <span class="pro-num">×${border.goodsNum}</span>
                                            </p>
                                            <p class="price" id="prodescprice">
                                                <span class="num">¥&nbsp;${border.goodsPrice?string('0.00')?substring(0,border.goodsPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${border.goodsPrice?string('0.00')?substring(border.goodsPrice?string('0.00')?index_of('.'))}</span>
                                                <span class="pro-num">×${border.goodsNum}</span>
                                            </p>

                                        </#if>
                                        <#--<p class="price">¥&nbsp;<span class="num" style="display: initial;"> <#if border.goodsPrice??>
                                        ${border.goodsPrice?string('0.00')}
                                        </#if></span></p>

                                        <p class="number">×<span class="num" style="display: initial;">${(border.goodsNum)!'0'}</span></p>-->
                                    </div>
                                    </a>
                                </div>
                                <#--<div class="return-num">
                                    <h3>申请数量
                                        <div class="buy-num">
                                            &lt;#&ndash;<span class="reduce disabled" onclick="mit(this)">−</span>
                                            <input type="text" class="back_goods_id" placeholder="<#if staCheck??&staCheck='1'>${(border.goodsNum)!'0'}<#else>0</#if>" attr-maxnum="${(border.goodsNum)!'0'}" value="<#if staCheck??&staCheck='1'>${(border.goodsNum)!'0'}<#else>0</#if>" attr-price="${border.goodsPrice?string('0.00')}" attr-goods="${(border.goodsId)!''}" <#if staCheck??&staCheck='1'>readonly</#if>>
                                            <span class="add <#if staCheck??&staCheck='1'>disabled</#if>" onclick="add(this)">+</span>&ndash;&gt;
                                            <span>${(border.goodsNum)!'0'}</span>
                                        </div>
                                        <span class="numError" style="color: red; "></span>
                                    </h3>
                                </div>-->
                            </div>
                        <#else>
                        <#--超过2个部分-->
                            <div class="list-item" style="display: none;margin-left: 15px;padding: .8em 15px 0rem 0px;">
                                <#if border.goodsName??&& (border.goodsName?index_of("电子卡") == -1 && border.goodsName?index_of("实体卡") == -1)>
                                    <#if isUseCoupon?? && isUseCoupon='1'><#else><div class="check-box choosegood"  backprice="${border.goodsBackPrice!0}" backstr="${border.goodsId!0},${border.goodsNum!0},${border.orderGoodsId}"></div></#if>
                                </#if>

                                <div class="pro-item <#if !(isUseCoupon?? && isUseCoupon='1')>pro-items</#if>" style="border-bottom: 1px solid #eeeeee;">
                                    <div class="propic">
                                        <a href="javascript:;">
                                            <img alt="" src="${border.goodsImg!''}"  width="78" height="78"  title="${(border.goodsName)!''}" alt="${(border.goodsName)!''}" />
                                    </div>
                                    <div class="prodesc" style="padding-right: 20px;!important;">
                                        <h3 class="title " id="prodesctitle"><#if border.isPresent?? && border.isPresent == '1'><span style="display: inline-block;color: white;background-color: lightgrey;">&nbsp;赠品&nbsp;</span></#if> ${border.goodsName!''}</h3>
                                        <#if border.countRush?? && border.countRush?number != 0 && border.goodsNum?number gt border.countRush?number>
                                            <p class="price" id="prodescprice">
                                                <span class="num">¥&nbsp;${border.goodsOldPrice?string('0.00')?substring(0,border.goodsOldPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${border.goodsOldPrice?string('0.00')?substring(border.goodsOldPrice?string('0.00')?index_of('.'))}</span>
                                                <span class="pro-num">×${border.goodsNum?number - border.countRush?number}</span>
                                            </p>
                                            <p class="price" id="prodescprice">
                                                <span class="num">¥&nbsp;${border.goodsPrice?string('0.00')?substring(0,border.goodsPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${border.goodsPrice?string('0.00')?substring(border.goodsPrice?string('0.00')?index_of('.'))}</span>
                                                <span class="pro-num">×${border.countRush}</span>
                                            </p>

                                        <#else>
                                            <p class="price" id="prodescprice" style="    visibility: hidden;">
                                                <span class="num">¥&nbsp;${border.goodsPrice?string('0.00')?substring(0,border.goodsPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${border.goodsPrice?string('0.00')?substring(border.goodsPrice?string('0.00')?index_of('.'))}</span>
                                                <span class="pro-num">×${border.goodsNum}</span>
                                            </p>
                                            <p class="price" id="prodescprice">
                                                <span class="num">¥&nbsp;${border.goodsPrice?string('0.00')?substring(0,border.goodsPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${border.goodsPrice?string('0.00')?substring(border.goodsPrice?string('0.00')?index_of('.'))}</span>
                                                <span class="pro-num">×${border.goodsNum}</span>
                                            </p>

                                        </#if>
                                    <#--<p class="price">¥&nbsp;<span class="num" style="display: initial;"> <#if border.goodsPrice??>
                                    ${border.goodsPrice?string('0.00')}
                                    </#if></span></p>

                                    <p class="number">×<span class="num" style="display: initial;">${(border.goodsNum)!'0'}</span></p>-->
                                    </div>
                                    </a>
                                </div>
                            <#--<div class="return-num">
                                <h3>申请数量
                                    <div class="buy-num">
                                        &lt;#&ndash;<span class="reduce disabled" onclick="mit(this)">−</span>
                                        <input type="text" class="back_goods_id" placeholder="<#if staCheck??&staCheck='1'>${(border.goodsNum)!'0'}<#else>0</#if>" attr-maxnum="${(border.goodsNum)!'0'}" value="<#if staCheck??&staCheck='1'>${(border.goodsNum)!'0'}<#else>0</#if>" attr-price="${border.goodsPrice?string('0.00')}" attr-goods="${(border.goodsId)!''}" <#if staCheck??&staCheck='1'>readonly</#if>>
                                        <span class="add <#if staCheck??&staCheck='1'>disabled</#if>" onclick="add(this)">+</span>&ndash;&gt;
                                        <span>${(border.goodsNum)!'0'}</span>
                                    </div>
                                    <span class="numError" style="color: red; "></span>
                                </h3>
                            </div>-->
                            </div>
                        </#if>
                    </#list>
                </#if>

            </div>
        <#if (backorder.goods)?size gt 2>
            <div class="list-item see-all">— 显示其他${backorder.goods?size-2}件商品 —</div>
        </#if>
        </div>
    </div>
    <div class="mt10">
        <div class="list-item">
            <h3 class="item-head">申请理由</h3>
            <div class="list-value">
                <ul class="yuanying">
                    <li><div class="check-box bumai"></div>不想买了</li>
                    <li><div class="check-box zhiliang"></div>商品质量问题</li>
                    <li><div class="check-box bufu"></div>收到商品与描述不符</li>
                    <li><div class="check-box qita"></div>其他</li>
                </ul>
            </div>
        </div>
     <#--   <div class="list-item">
            <h3 class="item-head">申请凭据</h3>
            <div class="list-value">
                <ul class="pingju">
                    <li><div class="check-box checked noevidence"></div>无凭证</li>
                    <li><div class="check-box bill"></div>有发票</li>
                    <li><div class="check-box report"></div>有质检报告</li>
                </ul>
            </div>
        </div>-->
        <div class="list-item">
            <h3 class="item-head pr0"  style=" margin-top: 0px;"><label for="" style="float: left;color: #333333;">问题描述</label>
                <span class="curValue weui_textarea_counter">（<p id="num">0</p>/200）</span>
            </h3>
            <div class="list-value">
                <div class="shuoming">
                    <textarea name="backRemark" id="backRemark" onfocus="if(value=='请输入订单问题描述'){value=''}" onblur="if(value==''){value='请输入订单问题描述'}" cols="30" rows="3"  class="weui_textarea">请输入订单问题描述</textarea>
                     <span id="backRemark_tips"></span>
                     <span class="backRemarkContent" style="color:red;"></span>
                </div>
            </div>
        </div>
        <div class="list-item" style="display:none">
            <h3 class="item-head">商品返回方式</h3>
            <div class="list-value returen-way">
                <a class="btn-grey selected" href="javascript:;" backway="0"><#--快递-->上门取件</a>
                <!--<a class="btn-grey" href="javascript:;">上门取件</a>-->
            </div>
        </div>
        <div class="list-item" id="pubevidence" style="display:none">
            <h3 class="item-head">上传凭证</h3>
            <div class="updata-pic">
                <div class="pic-list">
                    <ul id="show_pics${order.orderId}">
                        <li>
                            <div class="uppic">
                                <a href="javascript:;">
                                    <i></i>
                                </a>
                                <input type="file"class="upload_pics" id="uploadDocuments" name="uploadDocument" accept="image/jpg,image/gif,image/png,image/jpeg" order-id="${order.orderId}">
                               <input type="hidden" name="uploadDocuments" class="upload_documents"/>
                            </div>
                        </li>
                    </ul>
                </div>
                <p style="padding-left: 0;">最多上传3张，每张不超过5M，支持bmp，gif，jpg， png，jpeg</p>
            </div>
        </div>
        <div class="list-item" style=" padding: .8em 15px .6em 15px;">
            <#--<h3 class="item-head pr0" ><label for="" style="float: left; line-height: 13px;">该订单的退额上限为</label>
                <input type="hidden" class="back_price" value="${newprice!0}">
                <span class="curValue" style="float: left;     line-height: 13px; color:#E63D59;">￥${(newprice)?string('0.00')}</span>
            </h3>-->
            <h3 class="item-head pr0" ><label for="" style="float: left;     line-height: 15px;
    margin-bottom: 20px;color: #333333;">请输入退款金额</label>  <span class="curValue" style="float: left;line-height: 15px;">（最高&nbsp;￥&nbsp;<b id="maxBackPrice" style="font-weight: normal;">0.00</b>）</span>
                <input name="backPrice" id="backPrice"  placeholder="请输入退款金额" >
                <#--<input type="hidden" id="maxBackPrice" value="${(newprice)?string('0.00')}">-->

            </h3>
           <#-- <div class="list-value">
                <div class="shuoming">
                    <input type="text" id="backorderprice" <#if isUseCoupon?? && isUseCoupon='1'>placeholder="${(newprice)?string('0.00')}" value="${newprice!0}"<#else>placeholder="0.00"</#if>>
                </div>
            </div>-->
        </div>
    </div>
       <input type="hidden" name="backWay" id="backWay">
     	<input type="hidden" name="orderId" value="${order.orderId}"/>
     	<input type="hidden" name="orderCode" value="${order.orderCode}"/>
	    <#--<input type="hidden" name="backPrice" id="backPrice" value="${(newprice)?string('0.00')}"/>-->
    <div class="cancel">
        <div class="list-item" style="padding: 0;">
            <a class="btn grey" href="javascript:void(0);" id="submitButtongoods"><i></i>提交申请</a>
        </div>
    </div>
  </form>
   <iframe name="hidden_frame" style="display:none"></iframe>
</div>
<input type="hidden" class="flag_saved" value="0">
</body>
<script src="${basePath}/js/shoppingcart/jsOperation.js"></script>
<script type="text/javascript" src="${basePath}/js/customer/applybackorder.js"></script>
<script>
    $("#backPrice").focus(function(){
        $(this).attr("placeholder","");
    });
    $("#backPrice").blur(function(){
        if ($(this).val()==null || $(this).val()=='') {
            $(this).attr("placeholder","请输入退款金额");
        }
    });
    $("#backRemark").bind("input propertychange",function () {
        // 获取要显示已经输入字数文本框对象
        var content = document.getElementById('num');
        if (content && this) {
            // 获取输入框输入内容长度并更新到界面
            var value = this.value;
            // 将换行符不计算为单词数
            value = value.replace(/\n|\r/gi,"");
            // 更新计数
            content .innerText = value.length;

            if(value.length > 200){
                $(".weui_textarea_counter").css("color","red");
                $("#num").css("color","red");
            }
            if(value.length <= 200){
                $(".weui_textarea_counter").css("color","#666666");
                $("#num").css("color","#666666");
            }
        }
        turnGreen();
    })
    $("#backPrice").bind("input propertychange",function () {
        turnGreen();
    })
    //检查申请理由、问题描述为必填项
    function turnGreen(){
        //申请理由
        var backReason = $("#backReason").val();
        //问题描述
        var backRemark = $("#backRemark").val();
        //退款金额
        var backPrice = $("#backPrice").val();
        //商品列表勾选
        var _checkStatus=$("#isUseCoupon").val();
        if(_checkStatus=='0'){
            var goods = $(".choosegood");
            var isOk = false;
            for(var i=0;i<goods.length;i++){
                if($(goods[i]).hasClass("checked")){
                    isOk = true;
                }
            }
        }
        if(backReason != "" && backRemark != "" && backPrice != "" && isOk  && backRemark != "请输入订单问题描述"){
            $("#submitButtongoods").removeClass("grey");
            $("#submitButtongoods").addClass("btn-full");
        }else{
            $("#submitButtongoods").removeClass("btn-full");
            $("#submitButtongoods").addClass("grey");
        }
    }
    $(function(){
        /* 显示隐藏的商品 */
        $('.see-all').click(function(){
            $(this).prev('.list-body-line').find('.list-item').show();
            $(this).remove();
        });
        /* 选择退货原因 */
        $('.return_reason').click(function(){
            var reasonBox = dialog({
                width : 260,
                title : '选择一个退货原因',
                content : '<ul class="fav-list reasons"><li><a href="javascript:void(0);" value="1">不想买了<i class="check-box"></i></a></li><li><a href="javascript:void(0);" value="5">商品质量问题<i class="check-box"></i></a></li><li><a href="javascript:void(0);" value="6">收到商品与描述不符<i class="check-box"></i></a></li><li><a href="javascript:void(0);" value="4">其他<i class="check-box"></i></a></li></ul>',
                okValue : '确定',
                cancelValue : '取消',
                ok : function(){
                    $('.return_reason .curValue').text($('.reasons li.selected a').text());
                    $('#backReason').val($('.reasons li.selected a').attr('value'));
                    $(".backReasonContent").text("");
                    return true;
                },
                cancel : function(){
                    return true;
                }
            });
            reasonBox.showModal();
        });
        $('body').on('click','.reasons li',function(){
           $(this).addClass('selected').siblings().removeClass('selected');
        });

        /*退换货类型选择*/
        $(".leixing li").click(function () {
            $(this).addClass("checkType").siblings().removeClass("checkType");
            $("#returnType").val($(this).attr("name"));
            checkmoney();
        })

        /* 凭据选择 */
        $('.pingju li').click(function(){
            $(this).find('div.check-box').addClass('checked');
            $(this).siblings().find('div.check-box').removeClass('checked');
            if($(this).find('div').hasClass('noevidence')){
                $("#applyCredentials").val(3);
                $("#pubevidence").hide();
            }else if($(this).find('div').hasClass('bill')){
                $("#applyCredentials").val(1);
                $("#pubevidence").show();
            }else if($(this).find('div').hasClass('report')){
                $("#applyCredentials").val(2);
                $("#pubevidence").show();
            }
        });

        /* 退货原因 */
        $('.yuanying li').click(function(){
            $(this).find('div.check-box').addClass('checked');
            $(this).siblings().find('div.check-box').removeClass('checked');
            if($(this).find('div').hasClass('bumai')){
                $("#backReason").val(1);
            }else if($(this).find('div').hasClass('zhiliang')){
                $("#backReason").val(5);
            }else if($(this).find('div').hasClass('bufu')){
                $("#backReason").val(6);
            }else if($(this).find('div').hasClass('qita')){
                $("#backReason").val(4);
            }
            turnGreen();
        });
    });

    //选中商品退货
    $(".choosegood").click(function(){
        if($(this).hasClass("checked")){
            $(this).removeClass("checked")
        }else{
            $(this).addClass("checked")
        }
        checkmoney();
        turnGreen();
    });

    //计算退货金额
    function checkmoney(){
        var goods = $(".choosegood");
        var backStrs = "";
        var backprice = 0;
        for(var i=0;i<goods.length;i++){
            if($(goods[i]).hasClass("checked")){
                var price = $(goods[i]).attr("backprice");
                backprice = parseFloat(backprice)+parseFloat(price);
                var backStr = $(goods[i]).attr("backstr");
                backStrs +=  backStr + "-";

            }
        }

        //$("#backorderprice").html('￥'+backprice.toFixed(2));
        //$(".back_price").val(backprice);
        //$("#backPrice").val(backprice.toFixed(2));
        $("#maxBackPrice").text(backprice.toFixed(2));
        $("#backGoodsId").val(backStrs);
    }
</script>
</html>