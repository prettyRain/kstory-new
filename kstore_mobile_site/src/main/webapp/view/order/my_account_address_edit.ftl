<!DOCTYPE html>
<html>
<head>
    <#assign basePath=request.contextPath>  
  <meta charset="UTF-8">
  <title>会员中心 - 我的账户</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <meta content="telephone=no" name="format-detection">
  <link rel="stylesheet" href="${basePath}/css/style.min.css"/>
        <link rel="stylesheet" href="${basePath}/css/ui-dialog.css">
  <link rel="stylesheet" href="${basePath}/css/v2/my_account_address_add_edit.css">
  <link rel="stylesheet" href="${basePath}/css/tip-newbox.css">
  <script src="${basePath}/js/jquery-1.10.1.js"></script>
  <script src="${basePath}/js/idangerous.swiper.js"></script>
        <script src="${basePath}/js/dialog-min.js"></script>
        <script src="${basePath}/js/tip-newbox.js"></script>
    <style>
        body, html {
            background-color: #eee;
        }
    </style>

  <script type="text/javascript" src="${basePath}/js/tip-newbox.js"></script>

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
<#assign vtitle="编辑地址" />
<#if flag?? && flag?number==1>
    <#assign backUrl="${basePath}/addresslist.htm?flag=1&addressType=${orderaddress.addressType!''}">
<#else>
    <#assign backUrl="${basePath}/addresslist.html?mainAddress=${mainAddress!'2'}" />
</#if>

<#include "../common/head_back.ftl"/>
<form action="${basePath}/orderupdateaddress.htm" id="addForm" method="post">
    <input type="hidden" name="mainAddress" value="${mainAddress!'2'}">
    <input type="hidden" name="flag" value="${flag!''}"/>
<div class="member_form">
    <input type="hidden" id="basePath"  value="${basePath}"/>
    <input type="hidden" value="${orderaddress.addressId!''}" name="addressId">
    <input type='hidden' id="Province" value="${orderaddress.infoProvince!''}"/>
    <input type='hidden' id="City" value="${orderaddress.infoCity!''}" />
    <input type='hidden' id="County" value="${orderaddress.infoCounty!''}"/>
  
    <input type='hidden' id="provinceCh" name="infoProvince"/>
    <input type='hidden' id="cityCh" name="infoCity"/>
    <input type='hidden' id="countyCh" name="infoCounty"/>
    <input type='hidden' id="lodAddressType" value="${addressType!}"/>

<#if !addressType?? || addressType == '1'>
    <dl class="check_item" id="seleteCheck">
    <dt>社区服务中心</dt>
    <dd>
        <div class="fr mr15">
            <div class="checkbox <#if orderaddress.addressType??&&orderaddress.addressType=='1'>selected</#if>" id="addressTypeDiv">
                <input type="checkbox" id="addressType"  value="${orderaddress.addressType!''}"/>
                <input type="hidden" id="addressType1" name="addressType" value="${orderaddress.addressType!''}"/>
            </div>
        </div>
    </dd>
    </dl>
</#if>
    <input type="hidden" name="orderAddressType" value="<#if orderaddress.addressType??>${orderaddress.addressType!''}</#if>">


    <dl>
    <dt>收货人</dt>
    <dd>
      <input type="text" value="${orderaddress.addressName!''}" class="text" name="addressName" id="addressName"/>
    </dd>
  </dl>
  <dl>
    <dt>手机号</dt>
    <dd>
      <input type="text" value="${orderaddress.addressMoblie!''}" class="text" name="addressMoblie" id="addressMoblie"/>
    </dd>
  </dl>
  <dl>
    <dt>省市区</dt>
    <dd>
        <input type="hidden" id="proName" value="${orderaddress.province.provinceName!''}"/>
        <input type="hidden" id="cityName" value="${orderaddress.city.cityName!''}"/>
        <input type="hidden" id="districtName" value="${orderaddress.district.districtName!''}"/>
        <input type="hidden" id="streetName" value="<#if orderaddress.street??>${orderaddress.street.streetName!''}</#if>"/>
      <a href="javascript:;" class="choose_area" onclick="loadProvice('${orderaddress.province.provinceName!''}');">
        <span class="local" style="padding-left:0;text-indent: -0px">${orderaddress.province.provinceName!''}${orderaddress.city.cityName!''}${orderaddress.district.districtName!''}
        <#if orderaddress.street??>${orderaddress.street.streetName!''}</#if></span>
        <i class="ion-ios-arrow-right"></i>
      </a>
    </dd>
  </dl>
<#if !addressType?? || addressType == '1'>
    <dl id="communityStoreDl" style="padding-left:80px;<#if orderaddress.addressType?? && orderaddress.addressType=='1'>display: block;<#else>display: none;</#if>">
        <dt>社区店</dt>
        <dd>
            <select style="width:96%;border:0px;background: #ffffff;" name="communityStoreId">
            <#if communityStores??>
                <#list communityStores as store>
                    <option value="${store.communityStoreId}" <#if orderaddress.communityStoreId?? && store.communityStoreId==orderaddress.communityStoreId>selected</#if>>
                    ${store.communityStoreName}
                        (${store.province.provinceName}${store.city.cityName}${store.district.districtName}${store.communityStoreAddress!''})
                    </option>
                </#list>
            </#if>
            </select>
        </dd>
    </dl>
</#if>
  <dl style="padding: 17px 0 17px 82px;" class="detailaddr">
    <dt>详细地址</dt>
    <dd>
      <textarea style="width: 96%;" rows="1" class="text" name="addressDetail" id="addressDetail" >${orderaddress.addressDetail!''}</textarea>
    </dd>
  </dl>
<#if !addressType??>
  <dl class="check_item">
    <dt>设为默认</dt>
    <dd>
      <div class="fr mr15">
        <div class="checkbox <#if orderaddress.isDefault??&&orderaddress.isDefault=='1'>selected</#if>" id="defaultDiv">
          <input type="checkbox" id="isDefault"  value="${orderaddress.isDefault!''}"/>
          <input type="hidden" id="isDefault1" name="isDefault" value="${orderaddress.isDefault!''}"/>
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
      <a href="javascript:;" class="btn btn-full" style="line-height: inherit;" onclick="doCancel(this,'${orderaddress.addressId}')">删除地址</a>
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
  $(function(){
    $("#icon-option").html("<span onclick='checkForm()'>完成</span>");
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
          //社区店，零售商品
          $("#addressType1").val('1');
          $("#addressTypeDiv").toggleClass('selected');
          $("#seleteCheck").hide();
          $("#communityStoreDl").show();
//          communityStoreDl addressTypeDiv
      }
  });
  var tip = myAlertStr();
  //验证表单
      function checkForm(){
           var bl=true;
          //收件人姓名
          if( $("#addressName").val().trim()==''){
               /*$('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>请填写收货人</h3></div></div>');
                setTimeout(function(){
                    $('.tip-box').remove();
                },1000);*/
               tip("请填写收货人");
              bl=false;
          }else if(! /^[a-zA-Z0-9\u4e00-\u9fa5]+$/.test( $("#addressName").val())){
              /* $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>收货人不能包含特殊字符</h3></div></div>');
                setTimeout(function(){
                    $('.tip-box').remove();
                },1000);*/
              tip("收货人不能包含特殊字符");
              bl=false;
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
          if($("#addressMoblie").val().trim()==''){
              /*$('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>请填写手机号码</h3></div></div>');
                setTimeout(function(){
                    $('.tip-box').remove();
                },1000);*/
              tip("请填写手机号码");
              bl=false;
          }else if(!(/^(13|14|15|18|17)\d{9}$/.test( $("#addressMoblie").val()))){
              /* $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>手机号格式错误</h3></div></div>');
                setTimeout(function(){
                    $('.tip-box').remove();
                },1000);*/
              tip("手机号格式错误");
              bl=false;
          }
          //详细地址
          if($("#addressDetail").val().trim()==''){
               /*$('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>请填写详细地址</h3></div></div>');
                setTimeout(function(){
                    $('.tip-box').remove();
                },1000);*/
               tip("请填写详细地址");
              bl=false;
          }else if($("#addressDetail").val().trim().length>40){
               /*$('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>详细地址请不要多于100字符</h3></div></div>');
                setTimeout(function(){
                    $('.tip-box').remove();
                },1000);*/
               tip("详细地址请不要多于40个字");
              bl=false;
          }
//          if($("#isDefault").val()==1){
//            if($("#isDefault1").val()==0){
//                $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><h3>必须要有一个默认收货地址</h3></div></div>');
//                setTimeout(function(){
//                    $('.tip-box').remove();
//                },1000);
//                bl=false;
//            }
//          }
          if(bl){
              //添加收件地址
              $("#addForm").submit();
          }
      }

      
      $(".bar-bottom a").removeClass("selected");
      $(".bar-bottom a:eq(3)").addClass("selected");



  function doCancel(obj,id){
      var discountBox = dialog({
          width: 260,
          title: '删除地址',
          content: "确定删除该收货地址吗？",
          okValue: '确定',
          cancelValue: '取消',
          ok: function () {
              $.ajax({
                  url:"${basePath}/delAddress.html?addressId="+id,
                  type:"post",
                  success:function(data){
                      if(data == 1){
                          /*setTimeout(function () {
                              $('.tip-box').remove();
                              $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><i class="success"></i><h3>地址删除成功！</h3></div></div>');
                          }, 10);*/
                          tip("地址删除成功");
                          setTimeout(function () {
                              // $(".tip-box").hide();
                              //location.reload();
                              var flag = $('input[name=flag]').val();
                              if(flag=='1'){
                                  window.location.href = "${basePath}/addresslist.htm?flag=1&addressType=${orderaddress.addressType!''}";
                              }else{
                                  window.location.href = "${basePath}/addresslist.html?mainAddress=${mainAddress!'2'}";
                              }
                          }, 1000)
                          return true;
                      }else{
                          window.location.href = "${basePath}/loginm.html";
                      }
                  }
              });
          },
          cancel: function () {
              return true;
          }
      });
      discountBox.showModal();
  };

  //详细地址输入框位置
  var env = {
      agent: window.navigator.userAgent.toLowerCase(),
      isAndroid: function() {
          return this.agent.match(/android/i) == 'android';
      }
  }
  if(env.isAndroid()){
      console.log("dsfifhdiohdvjffffffff");
      $(".detailaddr").css({"padding-left":"85px"})
  }
</script>
</body>
 <script src="${basePath}/js/customer/myacountaddress.js"></script>
</html>