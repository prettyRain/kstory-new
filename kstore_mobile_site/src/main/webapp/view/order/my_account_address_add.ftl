<!DOCTYPE html>
<html>
<head>
    <#assign basePath=request.contextPath>
  <meta charset="UTF-8">
  <title>会员中心 - 我的账户</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <meta content="telephone=no" name="format-detection">
  <link rel="stylesheet" href="${basePath}/css/style.min.css"/>
  <link rel="stylesheet" href="${basePath}/css/v2/my_account_address_add_edit.css">
  <link rel="stylesheet" href="${basePath}/css/tip-newbox.css">
  <script src="${basePath}/js/jquery-1.10.1.js"></script>
  <script src="${basePath}/js/idangerous.swiper.js"></script>
  <script src="${basePath}/js/tip-newbox.js"></script>
    <style>
        .btn-full {
            border-radius: 8px;
            width: 295px;
            margin: 0 auto;
            padding: 13px;
            font-size: 15px;
            /*background: linear-gradient(left , rgb(85, 204, 0) , rgb(25,147,1) 100%);*/
            /*background: -o-linear-gradient(left , rgb(85, 204, 0) , rgb(25,147,1) 100%);*/
            /*background: -ms-linear-gradient(left , rgb(85, 204, 0) , rgb(25,147,1) 100%);*/
            /*background: -moz-linear-gradient(left , rgb(85, 204, 0) , rgb(25,147,1) 100%);*/
            /*background: -webkit-linear-gradient(left , rgb(85, 204, 0) , rgb(25,147,1) 100%);*/
            background:#199301;
            color: #ffffff!important;
            border: none;
            line-height: 24px;
        }
        .member_form dl dd input.text, .member_form dl dd textarea.text{
            width: 93%;
        }

        /*.member_form dl dd a {*/
            /*display: block;*/
            /*padding-right: 1.2em;*/
            /*overflow: hidden;*/
        /*}*/



    </style>
</head>
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
<#assign vtitle="添加地址" />
<#if !addressType??>
    <#assign backUrl="${basePath}/addresslist.html?mainAddress=${mainAddress!'2'}" />
<#else>
    <#assign backUrl="${basePath}/addresslist.htm?flag=1&addressType=${addressType!}" />
</#if>
<#include "../common/head_back.ftl"/>

<form action="${basePath}/orderaddaddress.htm" id="addForm" method="post">
<div class="member_form">
    <input type="hidden" name="mainAddress" value="${mainAddress!'2'}">
    <input type="hidden" id="basePath"  value="${basePath}"/>
    <input type="hidden" name="flag" value="${flag!''}"/>
    <input type='hidden' id="provinceCh" name="infoProvince"/>
    <input type='hidden' id="cityCh" name="infoCity"/>
    <input type='hidden' id="countyCh" name="infoCounty"/>
    <input type='hidden' id="lodAddressType" value="${addressType!}"/>

    <#--var addressType = $("#lodAddressType").val();-->
    <#--if(addressType != "" && addressType == '1'){-->
    <#--$("#addressType1").val('1');-->
    <#--$("#addressTypeDiv").toggleClass('selected');-->
    <#--$("#seleteCheck").hide();-->
    <#--$("#communityStoreDl").show();-->
    <#--}-->

<#if !addressType?? || addressType == '1'>
    <dl class="check_item" id="seleteCheck">
        <dt>社区服务中心</dt>
        <dd>
            <div class="fr mr15">
                <div class="checkbox selected" id="addressTypeDiv">
                    <input type="checkbox" id="addressType"  value=""/>
                    <input type="hidden" id="addressType1" name="addressType" value="1"/>
                </div>
            </div>
        </dd>

    </dl>

<#else>
    <input type="hidden" id="addressType1" name="addressType" value="0"/>
</#if>
  <dl>
    <dt>收货人</dt>
    <dd>
      <input type="text" class="text" name="addressName" id="addressName" placeholder="请填写收货人姓名"/>
    </dd>
  </dl>
  <dl>
    <dt>手机号</dt>
    <dd>
      <input type="text" class="text" name="addressMoblie" id="addressMoblie" placeholder="请填写手机号码"/>
    </dd>
  </dl>
  <dl>
    <dt>省市区</dt>
    <dd >
      <a href="javascript:;" class="choose_area" onclick="loadProvice('');"><span class="local" style="padding-left:0;text-indent: -0px">请选择省市区县</span>
        <i class="ion-ios-arrow-right"></i>
      </a>
    </dd>
  </dl>
<#if !addressType?? || addressType == '1'>
    <dl id="communityStoreDl" style="padding-left:80px;">
        <dt>社区店</dt>
        <dd>
            <select style="width:96%;border:0px;background: #ffffff;" name="communityStoreId">
            <#if communityStores??>
                <#list communityStores as store>
                    <option value="${store.communityStoreId}">
                    ${store.communityStoreName}
                        (${store.province.provinceName}${store.city.cityName}${store.district.districtName}${store.communityStoreAddress!''})
                    </option>
                </#list>
            </#if>
            </select>
        </dd>
    </dl>
</#if>
  <dl style="padding: 17px 0 17px 83px;" class="detailaddr">
    <dt>详细地址</dt>
    <dd>
      <textarea style="width: 96%;" rows="1" class="text" name="addressDetail" id="addressDetail" placeholder="请输入街道、楼牌、房号"></textarea>
    </dd>
  </dl>
<#if !addressType??>
  <dl class="check_item">
    <dt>设为默认</dt>
    <dd>
      <div class="fr mr15">
        <div class="checkbox selected" id="defaultDiv">
          <input type="hidden" id="isDefault1" name="isDefault" value="1"/>
        </div>
      </div>
    </dd>
  </dl>
</#if>

</div>
</form>
<div class="p10">
  <#--<div class="col-12">-->
    <#--<div class="pr15">-->
      <#--<a href="javascript:;" class="btn btn-full-grey" onClick="javascript :history.back(-1);">取消</a>-->
    <#--</div>-->
  <#--</div>-->
  <div class="col-12">
    <div class="pl15">
      <a href="javascript:;" class="btn btn-full" onclick="checkForm()" style="">保存</a>
    </div>
  </div>
</div>

<div class="screen area-box-lv1" style="display:none;">
  <div class="screen-header">
    <a class="back" href="javascript:;" id="back">取消</a>
    请选择省
  </div>
  <div class="screen-cont">
    <div class="lists province">
      <dl id="prodl">
      </dl>
    </div>
  </div>
</div>

<div class="screen area-box-lv2" style="display:none;">
  <div class="screen-header">
    <a class="back" href="javascript:;" onclick="back1();"><i class="back-icon"></i></a>
    请选择市
  </div>
  <div class="current-area">
    已选择：
    <span id="readypro"></span>
  </div>
  <div class="screen-cont">
    <div class="lists city">
      <dl id="citydl">
      </dl>
    </div>
  </div>
</div>

<div class="screen area-box-lv3" style="display:none;">
  <div class="screen-header">
    <a class="back" href="javascript:;" onclick="back2();"><i class="back-icon"></i></a>
    请选择地区
  </div>
  <div class="current-area">
    已选择：
    <span id="readycity"></span>
  </div>
  <div class="screen-cont">
    <div class="lists district">
      <dl id="areadl">
      </dl>
    </div>
  </div>
</div>

<script>
var tip = myAlertStr();
$(".bar-bottom a").removeClass("selected");
      $(".bar-bottom a:eq(3)").addClass("selected");
  $(function(){

    /* 选择性别 */
    $('.gender_set').click(function(){
      if($('.opacity-bg-3').length == 0){
        $('body').append('<div class="opacity-bg-3"></div>');
        $('.gender_choose').show();
      }
    });
    $('a.gender_close').click(function(){
      $('.opacity-bg-3').remove();
      $('.gender_choose').hide();
    });

    /* 选择地区 */
    $('.choose_area').click(function(){
      $('body').append('<div class="opacity-bg-3"></div>');
      $('.area-box-lv1').show();
    });
    
    $('#back').click(function(){
      $('.opacity-bg-3').remove();
      $('.screen').hide();
      $("#provinceCh").val("");
    });

      /* 滑动选框 */
      $('#defaultDiv').click(function(){
          $(this).toggleClass('selected');
          if ($('#defaultDiv').hasClass('selected')) {
              $("#isDefault1").val('1');
          }else{
              $("#isDefault1").val('0');
          }
      });

      /* 滑动选框 */
      $('#addressTypeDiv').click(function(){
          $(this).toggleClass('selected');
          if ($('#addressTypeDiv').hasClass('selected')) {
              $("#addressType1").val('1');
              $("#communityStoreDl").show();
          }else{
              $("#addressType1").val('0');
              $("#communityStoreDl").hide();
          }
      });
      var addressType = $("#lodAddressType").val();
      if(addressType != "" && addressType == '1'){
          $("#addressType1").val('1');
          $("#addressTypeDiv").addClass('selected');
          $("#seleteCheck").hide();
          $("#communityStoreDl").show();
      }
  });
  //验证表单
      function checkForm(){
          console.log($("#lodAddressType").val())
           var bl=true;
          //收件人姓名
          if($("#lodAddressType").val() == '1' && !$('#addressTypeDiv').hasClass('selected')){
              /*$('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>请选择社区店地址</h3></div></div>');
              setTimeout(function(){
                  $('.tip-box').remove();
              },1000);*/
             tip("请选择社区店地址");
              bl=false;
              return;
          }
          if( $("#addressName").val().trim()==''|| $("#addressName").val()==null){
              /* $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>请填写收货人</h3></div></div>');
                setTimeout(function(){
                    $('.tip-box').remove();
                },1000);*/
              tip("请填写收货人");
              bl=false;
              return;
          }else if(! /^[a-zA-Z0-9\u4e00-\u9fa5]+$/.test( $("#addressName").val())){
               /*$('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>收货人不能包含特殊字符</h3></div></div>');
                setTimeout(function(){
                    $('.tip-box').remove();
                },1000);*/
               tip("收货人不能包含特殊字符");
              bl=false;
              return;
          }else if($("#addressName").val().trim().length>12){
              /*$('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>详细地址请不要多于100字符</h3></div></div>');
               setTimeout(function(){
                   $('.tip-box').remove();
               },1000);*/
              tip("收货人请不要多于12个字");
              bl=false;
              return;
          }
          //收件人电话
          if($("#addressMoblie").val().trim()==''||$("#addressMoblie").val()==null){
             /* $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>请填写手机号码</h3></div></div>');
                setTimeout(function(){
                    $('.tip-box').remove();
                },1000);*/
             tip("请填写手机号码");
              bl=false;
              return;
          }else if(!(/^(13|14|15|18|17)\d{9}$/.test( $("#addressMoblie").val()))){
               /*$('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>手机号格式错误</h3></div></div>');
                setTimeout(function(){
                    $('.tip-box').remove();
                },1000);*/
               tip("手机号格式错误");
              bl=false;
              return;
          }
          if($(".local").html()=='请选择省市区县'){
             /*$('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>请选择省市区县</h3></div></div>');
                setTimeout(function(){
                    $('.tip-box').remove();
                },1000);*/
             tip("请选择省市区县");
              bl=false;
              return;
          }
          //详细地址
          if($("#addressDetail").val().trim()=='' ||$("#addressDetail").val()==null){
               /*$('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>请填写详细地址</h3></div></div>');
                setTimeout(function(){
                    $('.tip-box').remove();
                },1000);*/
               tip("请填写详细地址");
              bl=false;
              return;
          }else if($("#addressDetail").val().trim().length>40){
               /*$('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>详细地址请不要多于100字符</h3></div></div>');
                setTimeout(function(){
                    $('.tip-box').remove();
                },1000);*/
               tip("详细地址请不要多于40个字");
              bl=false;
              return;
          }
          if(bl){
              //添加收件地址
              $("#addForm").submit();
          }
      }


//        var u = navigator.userAgent;
//        var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
//        if(isAndroid) {
//            var oHeight = $(document).height();//获取当前窗口的高度
//            $(window).resize(function () {
//                if ($(document).height() >= oHeight) {
//                    $(".p10").show()
//                } else {
//                    $(".p10").hide()
//                }
//            })
//        }
//详细地址输入框位置
    var env = {
        agent: window.navigator.userAgent.toLowerCase(),
         isAndroid: function() {
             return this.agent.match(/android/i) == 'android';
         }
    }
    if(env.isAndroid()){
        $(".detailaddr").css({"padding-left":"85px"})
    }

</script>
</body>
<script src="${basePath}/js/customer/myacountaddress.js"></script>
</html>