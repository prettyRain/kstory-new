<!doctype html>
<#assign basePath=request.contextPath>
<html lang="en"><head>
    <meta charset="UTF-8">
    <title>订单确认-优惠券选择</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <link rel="stylesheet" href="${basePath}/css/style.min.css">
    <style>
        .vheader span {
            margin-right: 0rem!important;
            margin-left: .8rem!important;
        }
        .no_coupon{
            padding: 0rem 0rem;
            height: 1.1rem;
            width: 100%;
            background: #ffffff;
            margin-top: 10px;
        }
        .yes_coupon{
            padding: 0rem 1rem;
            height: .63rem;
            width: 100%;
            background: #f7f7f7;
            text-align: center;
            line-height: .88rem;
        }
        .yes_coupon span{
            font-size: 14px;
            color: #999999;
        }
        .no_coupon .no_title{
            padding-left: .3rem;
            height: 1.1rem;
            line-height: 1.1rem;
            color: #000;
            font-size: .3rem;
        }
        .no_coupon .no_title .no_div .no_i{

            width:15px;
            height: 15px;
            background: url(../images/no_i1.png);
            background-size:100% 100% ;

            display: block;
        }
        .no_i2{
            background: url(../images/no_i2.png);
            background-size:100% 100% ;
            display: block;
            width: 15px;
            height:15px;
        }
        .no_coupon .no_title .no_div{
            width: 1rem;
            height: 1.1rem;
            float: right;
            padding-top: .4rem;
            padding-left: .45rem;

        }
        .order.content-order-confirm .chose-receive-info, .order.content-order-confirm .use-coupons{
            padding: 0px;
            margin-bottom: 30px;
        }
        .coupons-item .coupons-body .body-right dl dt {
            font-size: .48rem!important;
        }
      .coupons-item .coupons-body .body-right dl dt {
            line-height:.52rem;
            height:.52rem;
            overflow-y: hidden;
            display: block;
          font-weight: bold;

        }
        .coupons-item .coupons-body{
            height: 2.56rem;
        }
        .coupons-item .coupons-body .body-right dl dd{
            height: .28rem;
            line-height: .26rem;
            font-size:12px;
            display: block;
        }
        .coupons-item .coupons-body .body-right dl dd:first-of-type{
            margin-top: .14rem;
        }
        .coupons-item .coupons-body .body-right dl dd:nth-child(3){
            margin-top: .41rem;
        }
        .coupons-item .coupons-body .body-right dl dd:last-of-type{
            margin-top: .05rem;
        }
        .coupons-xin {
            padding: 10px 10px 10px 10px;
            margin-bottom: 0px;
        }
        .coupons-item .coupons-body .body-left .title p{
            font-size: 14px;
        }
        .coupons-item .coupons-body .body-left .title h1{
            margin-top: .15rem;
            height: 1.1rem;
        }
        .coupons-item + .coupons-item{
            margin-top: 10px;
        }
        .coupons-item .coupons-body .body-right {
            float: left;
            width: 60%;
            height: 100%;
            padding: .32rem 0px .3rem .2rem;
            font-family: "微软雅黑";
        }
    </style>
</head>
<script src="${basePath}/js/jquery-1.11.1.min.js"></script>
<script>
    (function (doc, win) {
        var docEl = doc.documentElement,
                resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
                recalc = function () {
                    var clientWidth = docEl.clientWidth;
                    if (!clientWidth) return;
                    docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
                };
        if (!doc.addEventListener) return;
        win.addEventListener(resizeEvt, recalc, false);
        doc.addEventListener('DOMContentLoaded', recalc, false);
    })(document, window);
</script>
<body>
<#assign vtitle="使用优惠券" />
<#assign backUrl="${basePath}/suborder.htm?ch_pay=${ch_pay!''}&typeId=${typeId!''}&codeNo=${codeNo!''}&deliveryPointId=${deliveryPointId!''}&addressId=${addressId!''}&invoiceTitle=${invoiceTitle!''}&taxpayerNumber=${taxpayerNumber!''}&invoiceType=${invoiceType!''}&orderComment=${orderComment!''}" />

<#assign voption="券码兑换" />
<#include "../common/head_back.ftl"/>
<#--<div class="bar-top">
    <a class="bar-item half active" onclick="showCouponList(this)">可用券（<span>${couponlist?size}</span>）</a>
    <a class="bar-item half" onclick="showCoupons(this)">不可用券（<span><#if coupons??&&coupons?size!=0>${coupons?size}<#else>0</#if></span>）</a>
</div>-->
<div class="no_coupon">
    <div class="no_title">
        <span>不使用优惠券</span>
        <div class="no_div">
            <i class="no_i"></i>
        </div>

    </div>
</div>
<div class="yes_coupon">
    <#if couponlist?? && couponlist?size gt 0>
        <span>可用的优惠券</span>
    </#if>
</div>
<div class="order content-order-confirm">
    <div class="use-coupons">
        <div class="coupons-xin">
            <#list couponlist as coupon>
                <#if (coupon.couponRulesType=="1") >
                    <div class="coupons-item  coupons" style="background:url(../../images/coupon_red1.png) no-repeat;background-size: 100% 100%;" onclick="changeCoupon(this)">
                        <#--对号注释-->
                       <#-- <i class="select-box2 <#if codeNo??&& coupon.codeNo==codeNo>selected</#if>"></i>-->
                        <input value="${coupon.codeNo}" class="codeNo" type="hidden"/>
                        <div class="coupons-body">
                            <div class="body-right">
                                <dl>
                                    <dt>${coupon.couponName!''}</dt>
                                    <dd>无门槛使用</dd>
                                <#--<dd><a href="javascript:;" class="show-range">查看适用范围 &gt;&gt;</a></dd>-->
                                    <dd><label for="">有效期至</label><#--${coupon.couponStartTime?string("YYYY-MM-dd")}-->${coupon.couponEndTime?string("YYYY-MM-dd")}</dd>
                               <#--     <dd><label for="">券号:</label>${coupon.codeNo}</dd>-->
                                    <dd>
                                        <#if coupon.couponRemark??>

                                               ${coupon.couponRemark}

                                        </#if>
                                    </dd>
                                </dl>
                            </div>
                            <div class="body-left">
                                <div class="title">
                                    <h1>
                                        <span class="num">
                                            ${coupon.couponStraightDown.downPrice}
                                        </span>
                                        <span>元</span>
                                    </h1>
                                    <p class="pclick span_red <#if codeNo??&& coupon.codeNo==codeNo>select</#if>">
                                        <#if codeNo??&& coupon.codeNo==codeNo>
                                            当前使用
                                        <#else>
                                            点击使用
                                        </#if>
                                    </p>
                                </div>
                            </div>

                        </div>
                    </div>
                <#elseif coupon.couponRulesType=="2" && coupon.couponFullReduction.fullPrice?number==0>
                    <div class="coupons-item  coupons" style="background:url(../../images/coupon_red1.png) no-repeat;background-size: 100% 100%" onclick="changeCoupon(this)">
                    <#--对号注释-->
                    <#-- <i class="select-box2 <#if codeNo??&& coupon.codeNo==codeNo>selected</#if>"></i>-->
                        <input value="${coupon.codeNo}" class="codeNo" type="hidden"/>
                        <div class="coupons-body">
                            <div class="body-right">
                                <dl>
                                    <dt>${coupon.couponName!''}</dt>
                                    <dd>
                                            无门槛使用
                                    </dd>
                                    <dd><label for="">有效期至</label>${coupon.couponEndTime?string("YYYY- MM-dd")}</dd>
                                    <dd>
                                        <#if coupon.couponRemark??>

                                        ${coupon.couponRemark}

                                        </#if>
                                    </dd>
                                </dl>
                            </div>
                            <div class="body-left">
                                <div class="title">
                                    <h1>
                                        <span class="num">
                                        ${((coupon.couponFullReduction.reductionPrice)!'0.00')}
                                        </span>
                                        <span>元</span>
                                    </h1>
                                    <p class="pclick span_red <#if codeNo??&& coupon.codeNo==codeNo>select</#if>">
                                        <#if codeNo??&& coupon.codeNo==codeNo>
                                            当前使用
                                        <#else>
                                            点击使用
                                        </#if>
                                    </p>
                                </div>
                            </div>

                        </div>
                    </div>
                <#elseif coupon.couponRulesType=="2">
                    <div class="coupons-item  coupons" style="background:url(../../images/coupon_yellow1.png) no-repeat;background-size: 100% 100%" onclick="changeCoupon(this)">
                    <#--对号注释-->
                    <#-- <i class="select-box2 <#if codeNo??&& coupon.codeNo==codeNo>selected</#if>"></i>-->
                        <input value="${coupon.codeNo}" class="codeNo" type="hidden"/>
                        <div class="coupons-body">
                            <div class="body-right">
                                <dl>
                                    <dt>${coupon.couponName!''}</dt>
                                    <dd>
                                        <#if coupon.couponFullReduction.fullPrice?number==0>
                                            无门槛使用
                                        <#else>
                                            满${((coupon.couponFullReduction.fullPrice)!'0.00')}元可用
                                        </#if>
                                    </dd>
                                    <dd><label for="">有效期至</label>${coupon.couponEndTime?string("YYYY-MM-dd")}</dd>
                                    <dd>
                                        <#if coupon.couponRemark??>

                                            ${coupon.couponRemark}

                                        </#if>
                                    </dd>
                                </dl>
                            </div>
                            <div class="body-left">
                                <div class="title">
                                    <h1>
                                        <span class="num">
                                        ${((coupon.couponFullReduction.reductionPrice)!'0.00')}
                                        </span>
                                        <span>元</span>
                                    </h1>
                                    <p class="pclick span_yellow <#if codeNo??&& coupon.codeNo==codeNo>select</#if>">
                                        <#if codeNo??&& coupon.codeNo==codeNo>
                                            当前使用
                                        <#else>
                                            点击使用
                                        </#if>
                                    </p>
                                </div>
                            </div>

                        </div>
                    </div>
                </#if>
            </#list>
                <#--不可用的优惠券-->
                <#--<#if coupons??&&coupons?size!=0>
                    <#list coupons as coupon>
                        <div class="coupons-item  update" style="display: none;">
                            <i class="select-box2 <#if codeNo??&& coupon.codeNo==codeNo>selected</#if>"></i>
                            <input value="${coupon.codeNo}" class="codeNo" type="hidden"/>
                            <div class="coupons-body">
                                <div class="body-left">
                                    <div class="title">
                                        <h1>
                                            <span class="num">
                                                   <#if coupon.couponRulesType=='1'>
                                            ${coupon.couponStraightDown.downPrice}
                                            <#elseif coupon.couponRulesType=='2'>
                                                   ${coupon.couponFullReduction.reductionPrice}
                                                   </#if>
                                            </span>
                                            <span>元</span>

                                        </h1>
                                        <p>
                                            <#if coupon.couponRulesType=='1'>
                                                直降${coupon.couponStraightDown.downPrice}
                                            <#elseif coupon.couponRulesType=='2'>
                                                满${coupon.couponFullReduction.fullPrice}减${coupon.couponFullReduction.reductionPrice}
                                            </#if>
                                        </p>
                                    </div>
                                </div>
                                <div class="body-right">
                                    <dl>
                                        <dt>${coupon.couponName!''}</dt>
                                        &lt;#&ndash;<dd><a href="javascript:;" class="show-range">查看适用范围 &gt;&gt;</a></dd>&ndash;&gt;
                                        <dd><label for="">有效期:</label>${coupon.couponStartTime?string("YYYY.MM.dd")}-${coupon.couponEndTime?string("YYYY.MM.dd")}</dd>
                                        <dd><label for="">券号:</label>${coupon.codeNo}</dd>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </#list>
                <#else>
                </#if>-->

        </div>
      <#--  <div class="list-item bottom-full">
            <a class="btn btn-full" href="${basePath}/toaddcoupons.htm?flag=1<#if codeNo??>&codeNo=${codeNo}</#if><#if invoiceTitle??>&invoiceTitle=${invoiceTitle}</#if><#if invoiceType??>&invoiceType=${invoiceType}</#if>"><i></i>添加优惠卷</a>
        </div>-->
    </div>
</div>

<form id="subForm" method="post">
    <input type="hidden" name="codeNo" id="codeNo" >
    <input type="hidden" value="${invoiceType!''}" name="invoiceType" >
    <input type="hidden" name="invoiceTitle" value="${invoiceTitle!''}" >
    <input type="hidden" name="ch_pay" value="${ch_pay!''}">
    <input type="hidden" name="typeId" value="${typeId!''}">
    <input type="hidden" name="deliveryPointId" value="${deliveryPointId!''}">
    <input type="hidden" name="addressId" value="${addressId!''}">
    <input type="hidden" name="taxpayerNumber" value="${taxpayerNumber!''}">
    <input type="hidden" name="orderComment" value="${orderComment!''}">
</form>
<script>
    $("#icon-option").attr("href","${basePath}/toaddcoupons.htm?flag=1<#if codeNo??>&codeNo=${codeNo}</#if>&invoiceTitle=${invoiceTitle!''}&invoiceType=${invoiceType!''}&addressId=${addressId!''}&typeId=${typeId!''}&ch_pay=${ch_pay!''}&deliveryPointId=${deliveryPointId!''}&taxpayerNumber=${taxpayerNumber!''}&orderComment=${orderComment!''}")
    /*不使用优惠卷按钮效果，同时所有当前使用变成点击使用 并且返回键链接去掉优惠券参数*/
    $(function () {
        $(".no_div").on("touchstart",function(e) {
            $(".no_i").addClass("no_i2").removeClass("no_i");
            e.preventDefault();
            $(".pclick.select").each(function(index,item){
                var $this = $(item);
                $this.removeClass("select");
                $this.html("点击使用");
                if($this.hasClass("span_yellow")){
                    $this.parents(".coupons-item").css({background:"url(../../images/coupon_yellow1.png)",backgroundSize:"100% 100%"});
                }else if($this.hasClass("span_red")){
                    $this.parents(".coupons-item").css({background:"url(../../images/coupon_red1.png)",backgroundSize:"100% 100%"});
                }
            })
            //如果选中取消优惠券  那么返回键和添加优惠券都将失去codeNo参数
            <#assign backUrl="${basePath}/suborder.htm?ch_pay=${ch_pay!''}&typeId=${typeId!''}&deliveryPointId=${deliveryPointId!''}&addressId=${addressId!''}&invoiceTitle=${invoiceTitle!''}&taxpayerNumber=${taxpayerNumber!''}&invoiceType=${invoiceType!''}&orderComment=${orderComment!''}" />
            $("#icon-option").attr("href","${basePath}/toaddcoupons.htm?flag=1&invoiceTitle=${invoiceTitle!''}&invoiceType=${invoiceType!''}&addressId=${addressId!''}&typeId=${typeId!''}&ch_pay=${ch_pay!''}&deliveryPointId=${deliveryPointId!''}&taxpayerNumber=${taxpayerNumber!''}&orderComment=${orderComment!''}")

            $(".vheader a").eq(0).click(function(){
                window.location.href="${backUrl}";
            })

        });

        pclick2select();
    })
    //如果是当前使用的就显示当前使用
    function pclick2select(){
        var count = 0;
        $(".pclick").each(function(index,item){
            var $this = $(item);
            if($this.hasClass("select")){
                count++;
                $this.html("当前使用");
                if($this.hasClass("span_yellow")){
                    $this.parents(".coupons-item").css({background:"url(../../images/coupon_yellow2.png)",backgroundSize:"100% 100%"});
                }else if($this.hasClass("span_red")){
                    $this.parents(".coupons-item").css({background:"url(../../images/coupon_red2.png)",backgroundSize:"100% 100%"});
                }
            }
        })
        if(count>0){
            $(".no_i2").removeClass("no_i2").addClass("no_i");
        }else{
            $(".no_i").addClass("no_i2").removeClass("no_i");
        }
    }
</script>
<script>

    function changeCoupon(obj){
        /*if($(obj).find(".selected").length==0){
            $(".select-box2").removeClass("selected");
            $(obj).find(".select-box2:first").addClass("selected");
            $("#codeNo").val($(obj).find(".codeNo").val())
            $("#subForm").attr("action","suborder.htm").submit();
        }else{
            $(".select-box2").removeClass("selected");
            $("#codeNo").val("")
            $("#subForm").attr("action","suborder.htm").submit();
        }*/
        $(".pclick.select").each(function(index,item){
            var $this = $(item);
            $this.removeClass("select");
            $this.html("点击使用");
            if($this.hasClass("span_yellow")){
                $this.parents(".coupons-item").css({background:"url(../../images/coupon_yellow1.png)",backgroundSize:"100% 100%"});
            }else if($this.hasClass("span_red")){
                $this.parents(".coupons-item").css({background:"url(../../images/coupon_red1.png)",backgroundSize:"100% 100%"});
            }
        })
        //改变状态 变为当前使用
        var that = $(obj).find(".pclick").addClass("select");
        pclick2select();
        setTimeout(function(){
            $("#codeNo").val($(obj).find(".codeNo").val());
            $("#subForm").attr("action","suborder.htm").submit();
        },500)
    }

    function showCoupons(obj){
        $(".bar-item").removeClass("active");
        $(obj).addClass("active");
        $(".coupons").hide();
        $(".update").show();
    }
    function showCouponList(obj){
        $(".bar-item").removeClass("active");
        $(obj).addClass("active");
        $(".update").hide();
        $(".coupons").show();
    }
</script>
</body>

</html>