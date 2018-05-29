<!doctype html>
<#assign basePath=request.contextPath>
<html>
<head>
    <meta charset="UTF-8">
    <title>订单确认-发票信息</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <link rel="stylesheet" href="${basePath}/css/style.min.css">
    <link rel="stylesheet" href="${basePath}/css/ui-dialog.css">
    <link rel="stylesheet" href="${basePath}/css/v2/invoice.css">
    <script src="${basePath}/js/jquery-1.10.1.js"></script>
    <script src="${basePath}/js/pageAction.js"></script>
    <script src="${basePath}/js/dialog-min.js"></script>
    <style>
        .order.content-order-confirm .list-item .list-value a.selected {
            color: #fff;
            background-color: #199301;
            border-color: #199301;
        }
        .btn-full, .btn-them {
            color: #fff;
            background-color: #199301;
            border: 1px solid #199301;


        }

        .order.content-order-confirm .fap-info .sure {
            margin: 1rem 40px;
            border-radius: 8px;
            font-size: 15px;
            padding: 13px;
        }

    </style>
</head>
<body>
<#assign vtitle="发票信息" />
<#assign backUrl="${basePath}/suborder.htm?ch_pay=${ch_pay!''}&typeId=${typeId!''}&codeNo=${codeNo!''}&deliveryPointId=${deliveryPointId!''}&addressId=${addressId!''}&invoiceTitle=${invoiceTitle!''}&taxpayerNumber=${taxpayerNumber!''}&invoiceType=${invoiceType!''}&orderComment=${orderComment!''}" />
<#include "../common/head_back.ftl"/>
<div class="order content-order-confirm">
    <form action="" method="post" id="subForm">
        <#--<input type="hidden" value="${invoiceType!''}" name="invoiceType" id="invoiceType">-->
        <input type="hidden" name="invoiceType" value="">
        <input type="hidden" value="${ch_pay!''}" name="ch_pay">
        <input type="hidden" value="${typeId!''}" name="typeId">
        <input type="hidden" value="${codeNo!''}" name="codeNo">
        <input type="hidden" value="${deliveryPointId!''}" name="deliveryPointId" >
        <input type="hidden" value="${addressId!''}" name="addressId" >
        <div class="fap-info">
        <div class="list-item mt10">
            <h3 class="item-head">类型</h3>
            <div class="list-value fap-options">
                <a class="btn-grey" href="javascript:;" data-status="close" id="person_id">个人</a>
                <a class="btn-grey selected" href="javascript:;" data-status="open" id="company_id">单位</a>
            </div>
        </div>
            <div class="list-item mt10">
                <h3 class="item-head">抬头</h3>
                <div class="list-value">
                    <input type="text" name="invoiceTitle" value="${invoiceTitle!''}" id="invoiceTitle" placeholder="请填写准确的抬头名称">
                </div>
            </div>
        <div class="list-item mt10 taitou">
            <h3 class="item-head">税号</h3>
            <div class="list-value">
                <input type="text" name="taxpayerNumber" value="${taxpayerNumber!''}" id="taxpayerNumber" placeholder="长度为15位、18位或20位且不含小写字母">
            </div>
        </div>
         <input type="hidden" name="orderComment" value="${orderComment!''}">

        <#--<div class="list-item mt10 neirong">-->
            <#--<a href="#" class="fap-cont">-->
                <#--<h3 class="item-head">-->
                    <#--<i class="arrow-right"></i>-->
                    <#--发票内容-->
                    <#--<span class="curValue">-->
                    <#--<#if invoiceType??&&invoiceType!=''>-->
                       <#--${invoiceType}-->
                       <#--<#else>-->
                        <#--商品明细-->
                    <#--</#if></span>-->
                <#--</h3>-->
            <#--</a>-->
        <#--</div>-->
        <a class="btn btn-full sure" onclick="checkForm()"><i></i>确&nbsp;定</a>
    </div>
        </form>
</div>

<div class="fap_cont_list" style="display: none;">
    <ul class="fav-list">
        <li <#if invoiceType??&&invoiceType=='商品明细'>class="selected" </#if>>
            <input type="hidden" value="商品明细"/>
            <a href="javascript:void(0);">
                商品明细 <i class="check-box"></i>
            </a>
        </li>
        <li <#if invoiceType??&&invoiceType=='设备耗材'>class="selected" </#if>>
            <input type="hidden" value="设备耗材"/>
            <a href="javascript:void(0);">
                设备耗材 <i class="check-box"></i>
            </a>
        </li>
        <li <#if invoiceType??&&invoiceType=='办公用品'>class="selected" </#if>>
            <input type="hidden" value="办公用品"/>
            <a href="javascript:void(0);">
                办公用品 <i class="check-box"></i>
            </a>
        </li>
        <li <#if invoiceType??&&invoiceType=='电脑配件'>class="selected" </#if>>
            <input type="hidden" value="电脑配件"/>
            <a href="javascript:void(0);">
                电脑配件 <i class="check-box"></i>
            </a>
        </li>
    </ul>
</div>
<script>
    $(function(){
//        $('#person_id').click(function(){
//           $('#invoiceTitle').val('个人').attr('readonly','true');
//        })
        $('#company_id').click(function(){
            if(($('#invoiceTitle').val().indexOf('个人'))!=-1){
                $('#invoiceTitle').val('');
            }
            $('#invoiceTitle').removeAttr('readonly');
        })
        if($('#invoiceTitle').val().indexOf('个人')!=-1){
            $('#person_id').addClass('selected').siblings().removeClass('selected');
            $('.taitou input').attr('disabled',true);
            $('.neirong').hide();
            $('.taitou').hide();
        }else{
            $('#company_id').addClass('selected').siblings().removeClass('selected');
            $('.taitou input').removeAttr('disabled');
            $('.neirong').show();
            $('.taitou').show();
        }
        /*选择是否开发票*/
        $('.fap-options a').click(function(){
            $(this).addClass('selected').siblings().removeClass('selected');
            if($(this).attr('data-status') == 'open'){
                $('.taitou input').removeAttr('disabled');
                $('.neirong').show();
                $('.taitou').show();
            }
            else if($(this).attr('data-status') == 'close'){
                $('.taitou input').attr('disabled',true);
                $('.neirong').hide();
                $('.taitou').hide();
            }
        });
        var r = window.location.href;
        arr=r.split("=");
        r = arr[arr.length-1];
        if(r.length>0){
            console.log(1212)
            $("#company_id").addClass("selected");
            $("#person_id").removeClass("selected");
            $('.neirong').show();
            $('.taitou').show();
        }else{
            $("#person_id").addClass("selected");
            $("#company_id").removeClass("selected");
            $('.neirong').hide();
            $('.taitou').hide();
        }





        /* 选择发票内容 */
//        $('.fap-cont').click(function(){
//           ;
//            $(".fap_cont_list ul li").each(function () {
//               var text= $(this).find("input").val();
//                if($(".curValue").text().trim()==text){
//                    $(".fap_cont_list").find(".selected").removeClass("selected")
//                    $(this).addClass("selected");
//                }
//            })
//            var chooseFap = dialog({
//                width : 260,
//                title : '选择一个发票内容',
//                content : $('.fap_cont_list'),
//                okValue : '确定',
//                cancelValue : '取消',
//                onshow : function(){
//                    $('body').on('click','.fap_cont_list ul li',function(){
//                        $(this).addClass('selected').siblings().removeClass('selected');
//                    });
//                },
//                ok : function(){
//                    var theValue = $('.fap_cont_list .selected a').text();
//                    $('.fap-info .fap-cont span.curValue').text(theValue);
//                    return true;
//                },
//                cancel : function(){
//                    return true;
//                }
//            });
//            chooseFap.showModal();
//        });

    });


//    $(function(){
//        //发票抬头验证
//        $("#invoiceTitle").blur(function(){
//            if($(this).val().trim()==''){
//                $("#invoiceTitle").parent().addClass("error");
//            }else{
//                $("#invoiceTitle").parent().removeClass("error");
//            }
//        })
//    })


    function checkForm(){
        if($("#person_id").hasClass("selected")){
            if(!$('#invoiceTitle').val()){
                $("#invoiceTitle").attr({"placeholder":"您尚未填写该项"});
                $("#invoiceTitle").addClass("tj");
                return;
            }else{
                $("#invoiceType").val("明细");
                $('#taxpayerNumber').val("");
                $("#subForm").attr("action","suborder.htm").submit();
            }
        }else{
            if(!$('#invoiceTitle').val() && !$('#taxpayerNumber').val()){
                $("#invoiceTitle").attr({"placeholder":"您尚未填写该项"});
                $("#invoiceTitle").addClass("tj");
                $("#taxpayerNumber").attr({"placeholder":"您尚未填写该项"});
                $("#taxpayerNumber").addClass("tj");
            }else if($('#invoiceTitle').val() && !$('#taxpayerNumber').val()){
                $("#taxpayerNumber").attr({"placeholder":"您尚未填写该项"});
                $("#taxpayerNumber").addClass("tj");
            }else if(!$('#invoiceTitle').val() && !(/^[0-9-A-Z]{15}$|^[0-9-A-Z]{18}$|^[A-Z-0-9]{20}$/).test($('#taxpayerNumber').val())){
                $("#invoiceTitle").attr({"placeholder":"您尚未填写该项"});
                $("#invoiceTitle").addClass("tj");
                $("#taxpayerNumber").val("");
                $("#taxpayerNumber").attr({"placeholder":"长度为15位、18位或20位且不含小写字母"});
                $("#taxpayerNumber").addClass("tj");
                return;
            }else if($('#invoiceTitle').val() && !(/^[0-9-A-Z]{15}$|^[0-9-A-Z]{18}$|^[A-Z-0-9]{20}$/).test($('#taxpayerNumber').val())){
                $("#taxpayerNumber").val("");
                $("#taxpayerNumber").attr({"placeholder":"长度为15位、18位或20位且不含小写字母"});
                $("#taxpayerNumber").addClass("tj");
                return;
            }else if(!$('#invoiceTitle').val() && (/^[0-9-A-Z]{15}$|^[0-9-A-Z]{18}$|^[A-Z-0-9]{20}$/).test($('#taxpayerNumber').val())){
                $("#invoiceTitle").attr({"placeholder":"您尚未填写该项"});
                $("#invoiceTitle").addClass("tj");
                return;
            }else{
                $("#subForm").attr("action","suborder.htm").submit();
            }

        }
    }


//    function checkForm(){
//        if($("#person_id").hasClass("selected")){
//            if(!$('#invoiceTitle').val()){
//                $("#invoiceTitle").attr({"placeholder":"您尚未填写该项"});
//                $("#invoiceTitle").addClass("tj");
//                return;
//            }else{
//                $("#invoiceType").val("明细");
//                $('#taxpayerNumber').val("");
//                $("#subForm").attr("action","suborder.htm").submit();
//            }
//        }else{
//            if(!$('#invoiceTitle').val()){
//                $("#invoiceTitle").attr({"placeholder":"您尚未填写该项"});
//                $("#invoiceTitle").addClass("tj");
//                return;
//            }
//            if(!(/^[0-9-A-Z]{15}$|^[0-9-A-Z]{18}$|^[A-Z-0-9]{20}$/).test($('#taxpayerNumber').val())){
//                $("#taxpayerNumber").val("")
//                $("#taxpayerNumber").attr({"placeholder":"长度为15位、18位或20位且不含小写字母"});
//                $("#taxpayerNumber").addClass("tj");
//                return;
//            }else{
//                $("#subForm").attr("action","suborder.htm").submit();
//            }
//
//        }
//    }


//    function checkForm(){
//       if($(".list-value .selected").attr("data-status")=='close'){
//           $("#invoiceType").val("明细");
//           $('#taxpayerNumber').val("");
//           $("#subForm").attr("action","suborder.htm").submit();
//       }else{
//           //$("#invoiceType").val($(".curValue").text())
//           $('#invoiceType').val("明细");
//           if(!$('#invoiceTitle').val()){
//               //showDiv('    抬头不能为空');
//               $("#invoiceTitle").attr({"placeholder":"您尚未填写该项"});
//               $("#invoiceTitle").addClass("tj");
//               return;
//           }
//           if(!(/^[0-9-A-Z]{15}$|^[0-9-A-Z]{18}$|^[A-Z-0-9]{20}$/).test($('#taxpayerNumber').val())){
//               //showDiv('纳税人识别号长度为16位、18位或20位且不能有小写字母');
//               $("#taxpayerNumber").attr({"placeholder":"您尚未填写该项"});
//               $("#taxpayerNumber").addClass("tj");
//               return;
//               }
//
//           $("#subForm").attr("action","suborder.htm").submit();
//       }
//    }
    function showDiv(con){
        var chooseFap = dialog({
            width : 260,
            title : '消息提醒',
            content : con,
            okValue : '确定',
            cancelValue : '取消',
            onshow : function(){
                /* $('body').on('click','.fap_cont_list ul li',function(){
                     $(this).addClass('selected').siblings().removeClass('selected');
                 });*/
            },
            ok : function(){
                return true;
            },
            cancel : function(){
                return true;
            }
        });
        chooseFap.showModal();
    }
</script>
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

    $(".fap-info .sure").on('touchstart', function () {  $(this).css({"opacity":"0.6"})});
    $(".fap-info .sure").on('touchend', function () {$(this).css({"opacity":"1"})});
</script>


</body>
</html>