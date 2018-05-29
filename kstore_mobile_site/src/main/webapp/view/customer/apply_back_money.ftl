<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>订单-申请退款</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="keywords" content="${(seo.meteKey)!''}">
    <meta name="description" content="${(seo.meteDes)!''}">
    <#assign basePath=request.contextPath>

    <link rel="stylesheet" href="${basePath}/css/style.min.css"/>
    <link rel="stylesheet" href="${basePath}/css/new_refund.css"/>
    <link rel="stylesheet" href="${basePath}/css/ui-dialog.css"/>
    <script src="${basePath}/js/jquery-1.10.1.js"></script>
    <script src="${basePath}/js/pageAction.js"></script>
    <script src="${basePath}/js/dialog-min.js"></script>

</head>
<style>
    .grey {
        line-height: 24px;
        border: none;
        border-radius: inherit;
        font-size: 0.87rem;
        height: 49px;
        line-height: 49px;
        padding: 0;
        background: -webkit-linear-gradient(left,#9B9B9B,#9B9B9B);
        background: -o-linear-gradient(left,#9B9B9B,#9B9B9B);
        background: -moz-linear-gradient(left,#9B9B9B,#9B9B9B);
        background: linear-gradient(left,#9B9B9B,#9B9B9B);
        margin-top: 15px;
        display: block;
        color: #fff;
        text-align: center;
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
<body>
    <input id="basePath" type="hidden" value="${basePath!''}"/>
    <#assign vtitle="申请退款" />
    <#assign backUrl="${basePath}/customer/myorder.html" />
    <#include "/common/head_back.ftl"/>
<div class="order content-order-aftersale">
 <form id="upload-form" name="upload-form" method="post" enctype="multipart/form-data" target="hidden_frame">
    <input id="customerId" type="hidden" value="${cusId!''}" name="customerId"/>
    <input id="backGoodsId" type="hidden" value="${backGoodsIdAndSum}" name="backGoodsIdAndSum"/>
     <input name="isBack" type="hidden" value="2" />
     <input id="applyCredentials" type="hidden" value="3" name="applyCredentials"/>
     <input id="backReason" type="hidden" value="" name="backReason"/>
    <div class="order-number">
        <div class="list-item" style="padding: 10px 15px 12px 15px">
           <#-- <h3 class="item-head text-them">申请退款</h3>-->

            <h3 class="item-head"><label for="">订单号：</label><span>${order.orderCode!''}</span></h3>

            <h3 class="item-head"><label for="">订单支付总额：</label><span class="text-them">￥&nbsp;${(order.orderPrice)?string('0.00')}</span></h3>
        </div>
    </div>
    <div class="mt10">
        <div class="order-info">
            <div class="list-body-line" style="background: #ffffff;">
                <#if backorder??>
                    <#list backorder.goods as border>
                        <#if border_index lt 2>
                            <div class="list-item" style="margin-left: 15px; padding:.8em 15px 0.2rem 0px;border-bottom: 1px solid #eeeeee; ">
                            <div class="pro-item">
                                <div class="propic">
                                <a href="javascript:;">
                                    <img alt="" src="${border.goodsImg!''}"  width="78" height="78"  title="${(border.goodsName)!''}" alt="${(border.goodsName)!''}" />
                                </div>
                                <div class="prodesc" style="padding-right:0px;">
                                    <h3 class="title">
                                        <#if border.isPresent?? && border.isPresent == '1'>
                                            <img src="../../images/v2/gift@2x.png" width="28" height="16" style="vertical-align: middle;margin-bottom: 2px;">
                                        </#if>
                                    ${border.goodsName!''}</h3>
                                    <#if border.countRush?? && border.countRush?number != 0 && border.goodsNum?number gt border.countRush?number>
                                    <#--双价格-->
                                        <p class="price">¥&nbsp;
                                            <span class="num">${border.goodsOldPrice?string('0.00')?substring(0,border.goodsOldPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${border.goodsOldPrice?string('0.00')?substring(border.goodsOldPrice?string('0.00')?index_of('.'))}</span>
                                            <span class="number">×<span class="num" style="display: initial;">${border.goodsNum?number - border.countRush?number}</span></span>
                                        </p>
                                        <p class="price">¥&nbsp;
                                            <span class="num">${border.goodsPrice?string('0.00')?substring(0,border.goodsPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${border.goodsPrice?string('0.00')?substring(border.goodsPrice?string('0.00')?index_of('.'))}</span>
                                            <span class="number">×<span class="num" style="display: initial;">${(border.countRush)!'0'}</span></span>
                                        </p>
                                    <#else>
                                    <#--双价格-->
                                        <p class="price"  style="visibility: hidden;">¥&nbsp;
                                            <span class="num">${border.goodsPrice?string('0.00')?substring(0,border.goodsPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${border.goodsPrice?string('0.00')?substring(border.goodsPrice?string('0.00')?index_of('.'))}</span>
                                            <span class="number">×<span class="num" style="display: initial;">${(border.goodsNum)!'0'}</span></span>
                                        </p>
                                        <p class="price">¥&nbsp;
                                            <span class="num">${border.goodsPrice?string('0.00')?substring(0,border.goodsPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${border.goodsPrice?string('0.00')?substring(border.goodsPrice?string('0.00')?index_of('.'))}</span>
                                            <span class="number">×<span class="num" style="display: initial;">${(border.goodsNum)!'0'}</span></span>
                                        </p>
                                    </#if>

                                </div>
                                </a>
                            </div>
                            <div class="return-num" style="display:none">
                                <h3>申请数量
                                    <div class="buy-num">
                                        <span class="reduce disabled">−</span>
                                        <input type="text" placeholder="0">
                                        <span class="add">+</span>
                                    </div>
                                </h3>
                            </div>
                            </div>
                        <#else>
                        <#--超过2个部分-->
                            <div class="list-item" style="display: none;margin-left: 15px; padding:.8em 15px 0.2rem 0px;border-bottom: 1px solid #eeeeee; ">
                                <div class="pro-item">
                                    <div class="propic">
                                        <a href="javascript:;">
                                            <img alt="" src="${border.goodsImg!''}"  width="78" height="78"  title="${(border.goodsName)!''}" alt="${(border.goodsName)!''}" />
                                    </div>
                                    <div class="prodesc" style="padding-right:0px;">
                                        <h3 class="title">
                                            <#if border.isPresent?? && border.isPresent == '1'>
                                                <img src="../../images/v2/gift@2x.png" width="28" height="16" style="vertical-align: middle;margin-bottom: 2px;">
                                            </#if>
                                        ${border.goodsName!''}</h3>
                                        <#if border.countRush?? && border.countRush?number != 0 && border.goodsNum?number gt border.countRush?number>
                                        <#--双价格-->
                                            <p class="price">¥&nbsp;
                                                <span class="num">${border.goodsOldPrice?string('0.00')?substring(0,border.goodsOldPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${border.goodsOldPrice?string('0.00')?substring(border.goodsOldPrice?string('0.00')?index_of('.'))}</span>
                                                <span class="number">×<span class="num" style="display: initial;">${border.goodsNum?number - border.countRush?number}</span></span>
                                            </p>
                                            <p class="price">¥&nbsp;
                                                <span class="num">${border.goodsPrice?string('0.00')?substring(0,border.goodsPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${border.goodsPrice?string('0.00')?substring(border.goodsPrice?string('0.00')?index_of('.'))}</span>
                                                <span class="number">×<span class="num" style="display: initial;">${(border.countRush)!'0'}</span></span>
                                            </p>
                                        <#else>
                                        <#--双价格-->
                                            <p class="price"  style="visibility: hidden;">¥&nbsp;
                                                <span class="num">${border.goodsPrice?string('0.00')?substring(0,border.goodsPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${border.goodsPrice?string('0.00')?substring(border.goodsPrice?string('0.00')?index_of('.'))}</span>
                                                <span class="number">×<span class="num" style="display: initial;">${(border.goodsNum)!'0'}</span></span>
                                            </p>
                                            <p class="price">¥&nbsp;
                                                <span class="num">${border.goodsPrice?string('0.00')?substring(0,border.goodsPrice?string('0.00')?index_of('.'))}</span><span class="num num1">${border.goodsPrice?string('0.00')?substring(border.goodsPrice?string('0.00')?index_of('.'))}</span>
                                                <span class="number">×<span class="num" style="display: initial;">${(border.goodsNum)!'0'}</span></span>
                                            </p>
                                        </#if>

                                    </div>
                                    </a>
                                </div>
                                <div class="return-num" style="display:none">
                                    <h3>申请数量
                                        <div class="buy-num">
                                            <span class="reduce disabled">−</span>
                                            <input type="text" placeholder="0">
                                            <span class="add">+</span>
                                        </div>
                                    </h3>
                                </div>
                            </div>
                        </#if>
                    </#list>
                </#if>
            </div>
        <#if (backorder.goods)?size gt 2>
            <div class="list-item see-all" style="border-top: none;">— 显示其他${backorder.goods?size-2}件商品 —</div>
        </#if>
        </div>
    </div>
    <div class="mt10">
       <#-- <div class="list-item">
            <a href="javascript:;" class="return_reason">
                <h3 class="item-head">
                    <label for="">退款原因</label>
                    <span class="curValue" id="backReasons">请选择<img style="float:right; display: inline-block;    height: 17px;
    margin-top: 0.31rem; margin-left: 3px;" src="../images/xiaoxiaojiantou.png"></span>


                    <span class="backReasonContent" style="color:red;"></span>
                </h3>
            </a>
        </div>-->
           <div class="list-item">
               <h3 class="item-head" style="margin-top: 0px;color: #333333;">申请理由</h3>
               <div class="list-value">
                   <ul class="yuanying">
                       <li><div class="check-box bumai"></div>不想买了</li>
                       <li><div class="check-box zhiliang"></div>收货信息有误</li>
                       <li><div class="check-box bufu"></div>商品未按时发货</li>
                       <li><div class="check-box qita"></div>其他</li>
                   </ul>
               </div>
           </div>
        <div class="list-item" style="display:none">
            <h3 class="item-head">申请凭据</h3>
            <div class="list-value">
                <ul class="pingju">
                    <li><div class="check-box checked noevidence"></div>无凭证</li>
                    <li><div class="check-box bill"></div>有发票</li>
                    <li><div class="check-box report"></div>有质检报告</li>
                </ul>
            </div>
        </div>
        <#--<div class="list-item">
            <h3 class="item-head pr0"><label for="">退款金额</label>
                <span class="curValue">您最多可退款${(order.orderPrice)?string('0.00')}元</span>
            </h3>
            <div class="list-value">
                <div class="shuoming">
                    <input type="text" placeholder="${(order.orderPrice)?string('0.00')}"  readonly>
                </div>
            </div>
        </div>-->
        <div class="list-item" style=" padding: .8em 15px 15px 15px;">
            <h3 class="item-head pr0"  style=" margin-top: 0px;"><label for="" style="float: left;color: #333333;">问题描述</label>
                <span class="curValue weui_textarea_counter">（<p id="num" style="display: inline-block;color: #333333;">0</p>/200）</span>
            </h3>
            <div class="list-value" style="margin-top: 0px;">
                <div class="shuoming">
                    <textarea name="backRemark" id="backRemark" onfocus="if(value=='请输入订单问题描述'){value=''}" onblur="if(value==''){value='请输入订单问题描述'}" cols="30" rows="3"  class="weui_textarea">请输入订单问题描述</textarea>
                     <span id="backRemark_tips"></span>
                     <span class="backRemarkContent" style="color:red;"></span>
                </div>
            </div>
        </div>
      <#--  <div class="list-item">
            <h3 class="item-head">商品返回方式</h3>
            <div class="list-value returen-way">
                <a class="btn-grey selected" href="javascript:;">快递</a>
                <!--<a class="btn-grey" href="javascript:;">上门取件</a>&ndash;&gt;
            </div>
        </div>-->
        <div class="list-item"  style="display:none">
            <h3 class="item-head">上传凭证</h3>
            <div class="updata-pic">
                <div class="pic-list">
                    <ul>
                        <li>
                            <a href="#">
                            <#--<img src="images/pro-recommend01.jpg" alt="">-->
                            </a></li>
                        <li><a href="#">
                            <#--<img src="images/pro-recommend02.jpg" alt="">-->
                        </a></li>
                        <li>
                            <div class="uppic">
                                <a href="javascript:;">
                                    <i></i>
                                </a>
                                <input type="file" accept="image/jpg,image/gif,image/png,image/jpeg">
                            </div>
                        </li>
                    </ul>
                </div>
                <p>最多上传3张，每张不超过5M，支持bmp，gif，jpg， png，jpeg</p>
            </div>
        </div>
    </div>
     	<input type="hidden" name="orderId" value="${order.orderId}"/>
     	<input type="hidden" name="orderCode" value="${order.orderCode}"/>
	    <input type="hidden" name="backPrice" value="${backorder.moneyPaid}"/>
    <div class="cancel">
        <div class="list-item" style="padding: 0px; ">
            <a class="btn grey" href="javascript:void(0);" id="submitButtonprice"><i></i>提交申请</a>
        </div>
    </div>
  </form>
</div>
<input type="hidden" class="flag_saved" value="0">
</body>
<script type="text/javascript" src="${basePath}/js/customer/applybackorder.js"></script>
<script>

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
                title : '选择一个退款原因',
                content : '<ul class="fav-list reasons"><li><a href="javascript:void(0);" value="1">不想买了<i class="check-box"></i></a></li><li><a href="javascript:void(0);" value="2">收货信息有误<i class="check-box"></i></a></li><li><a href="javascript:void(0);" value="3">商品未按时发货<i class="check-box"></i></a></li><li><a href="javascript:void(0);" value="4">其他<i class="check-box"></i></a></li></ul>',
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
        $(".leixing input").click(function () {
            $(".choosegood").removeClass("checked");
            checkmoney();
        })
        /* 退货原因 */
        $('.yuanying li').click(function(){
            $(this).find('div.check-box').addClass('checked');
            $(this).siblings().find('div.check-box').removeClass('checked');
            if($(this).find('div').hasClass('bumai')){
                $("#backReason").val("1");
            }else if($(this).find('div').hasClass('zhiliang')){
                $("#backReason").val("2");
            }else if($(this).find('div').hasClass('bufu')){
                $("#backReason").val("3");
            }else if($(this).find('div').hasClass('qita')){
                $("#backReason").val("4");
            }
            turnGreen();
        });
        //选中商品退货
        $(".choosegood").click(function(){
            if($(this).hasClass("checked")){
                $(this).removeClass("checked")
            }else{
                $(this).addClass("checked")
            }
            checkmoney();
        });
    });
    //检查申请理由、问题描述为必填项
    function turnGreen(){
        var backReason = $("#backReason").val();
        var backRemark = $("#backRemark").val();
        if(backReason != "" && backRemark != "" && backRemark != "请输入订单问题描述"){
            $("#submitButtonprice").removeClass("grey");
            $("#submitButtonprice").addClass("btn-full");
        }else{
            $("#submitButtonprice").removeClass("btn-full");
            $("#submitButtonprice").addClass("grey");
        }
    }


</script>

</html>