<!DOCTYPE html>
<html>
<head>
 <#assign basePath=request.contextPath>
  <meta charset="UTF-8">
  <title>会员中心 - 个人资料</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <meta content="telephone=no" name="format-detection">
  <link rel="stylesheet" href="${basePath}/css/style.css"/><link rel="stylesheet" href="${basePath}/css/style.min.css"/>
     <link rel="stylesheet" href="${basePath}/css/mobiscroll.custom-2.6.2.min.css"/>
  <script src="${basePath}/js/jquery-1.10.1.js"></script>
  <script src="${basePath}/js/idangerous.swiper.js"></script>
    <script src="${basePath}/js/customer/mycollections.js"></script>
    <script type="text/javascript" src="${basePath}/js/jquery.zclip.min.js"></script>
    <script type="text/javascript" src="${basePath}/js/jquery.zclip.js"></script>
     <script type="text/javascript" src="${basePath}/js/mobiscroll.custom-2.6.2.min.js"></script>

    <style>
        .list-block li {
            box-sizing: border-box;
            position: relative;
        }
        .list-block .item-link {
            -webkit-transition-duration: .3s;
            transition-duration: .3s;
            display: block;
            color: inherit;
        }
        .list-block {
            color: #333;
        }
        .list-block .item-content {
            box-sizing: border-box;
            padding-left: .3rem;
            height: 1.1rem;
            display: -webkit-box;
            display: -ms-flexbox;
            display: -webkit-flex;
            display: flex;
            -webkit-box-pack: justify;
            -ms-flex-pack: justify;
            -webkit-justify-content: space-between;
            justify-content: space-between;
            -webkit-box-align: center;
            -ms-flex-align: center;
            -webkit-align-items: center;
            align-items: center;
        }
        .mysetting .item-title {
            font-size: .24rem;
            color: #1D1D1D;
            letter-spacing: 0;
            -webkit-flex-shrink: 1;
            -ms-flex: 0 1 auto;
            flex-shrink: 1;
            min-width: 0;
            white-space: nowrap;
            position: relative;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 100%;


        }
        .list-block .item-link .item-inner {
            /*height: 3.76em;*/
            height: 1.1rem;
        }

        .list-block .item-inner {
            padding-right: .3rem;
            position: relative;
            width: 100%;
            box-sizing: border-box;
            display: -webkit-box;
            display: -ms-flexbox;
            display: -webkit-flex;
            display: flex;
            -webkit-box-flex: 1;
            -ms-flex: 1;
            overflow: hidden;
            -webkit-box-pack: justify;
            -ms-flex-pack: justify;
            -webkit-justify-content: space-between;
            justify-content: space-between;
            -webkit-box-align: center;
            -ms-flex-align: center;
            -webkit-align-items: center;
            align-items: center;
            -ms-flex-item-align: stretch;
            -webkit-align-self: stretch;
            align-self: stretch;
        }
         /*.list-block .item-inner:after {*/
            /*background-color: #eee;*/
            /*height: 0;*/
        /*}*/
        .mysetting .item-title {
            font-size: .24rem;
            color: #1D1D1D;
            letter-spacing: 0;
        }
        /*.list-block .item-inner:after {*/
            /*content: '';*/
            /*position: absolute;*/
            /*left: 0;*/
            /*bottom: 0;*/
            /*right: auto;*/
            /*top: auto;*/
            /*height: 1px;*/
            /*width: 100%;*/
            /*display: block;*/
            /*z-index: 15;*/
            /*-webkit-transform-origin: 50% 100%;*/
            /*transform-origin: 50% 100%;*/
        /*}*/
        .list-block .item-link .item-inner {
            padding-right: 35px;
            background-image: url(/images/icon_v1.0/btn_more_right@2x.png);
            background-size: 22px 22px;
            background-repeat: no-repeat;
            background-position: 95% center;
            background-position: -webkit-calc(100% - 10px) center;
            background-position: calc(100% - 10px) center;
            border-bottom: 1px solid #eee;
        }
        .myabout-bottom {
            margin-top: .9rem;
            left: 0;
            text-align: center;
            width: 100%;
            font-size: .22rem;
            line-height: .5rem;
            color: #a6a6a6;
        }
        .list-block .item-link .item-inner span:first-of-type{
            color: #000;letter-spacing: 0;font-size: 15px;
        }
        .list-block .item-link .item-inner span:nth-of-type(2){
            width: 4.5rem;color: #000;letter-spacing: 0;font-size: 15px; text-align: right; display: block
        }
    </style>
    <style>
        #sex-list_dummy{
            width: 0px!important;
            border: none;
            background:#fff;
            position: absolute;
            left: 31px;
            top: 0px;

        }
        .list-block li:last-of-type .item-inner:after,.list-block ul:last-of-type .item-inner:after{
            background-color:transparent;
        }
        .android-ics .dwv{
            color: #199301!important;
            border-bottom: 2px solid #199301;
        }

        .android-ics .dw .dwwol{
            border-top: 2px solid #199301;
            border-bottom: 2px solid #199301;
        }
    </style>
</head>
<body>
<#assign vtitle="个人资料" />
<#if main??&&main == '1'>
    <#--返回个人中心-->
    <#assign backUrl="${basePath}/customercenter.html" />
<#else>
    <#--返回个人设置页面-->
    <#assign backUrl="${basePath}/intoPage.htm?pageName=member/mysetting" />
</#if>

<#include "/common/head_back.ftl"/>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>

<script>
    var localUrl = window.location.href;
    $(function(){
        $.ajax({
            url: "${basePath}/queryWxConfig.htm",
            data:{curUrl: localUrl},
            success: function (data) {
                console.info(data);
                wx.config({
                    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                    appId: data.appId, // 必填，公众号的唯一标识
                    timestamp: data.timestamp, // 必填，生成签名的时间戳
                    nonceStr: data.nonceStr, // 必填，生成签名的随机串
                    signature: data.signature,// 必填，签名，见附录1
                    jsApiList: ['onMenuShareAppMessage','onMenuShareTimeline'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
                });
            },
            async:false
        });
    });

    wx.ready(function () {
        /*wx.onMenuShareAppMessage({
            title: '<%=shareTitle %>',
            desc: '<%=shareContent %>',
            link: '<%=currentUrl %>',
            imgUrl: '<%=shareImageUrl %>'
        });*/

        wx.onMenuShareTimeline({
            title: '中国960官方商城',
            link: 'http://m.ge960.com/',
            imgUrl: 'http://boss.ge960.com:80/upload/20170327/1490602121555.jpg'
        });
    })
</script><#--自定义分享到朋友圈-->

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
<div class="member_info" style="margin-bottom: 0;  ">
    <input type="hidden" id="basePath" value="">
    <div class="list-block">
    <ul>
        <li>
            <a href="${basePath}/changenickname.html?main=${main!''}" class="item-link">
                <div class="item-content">
                    <div class="item-inner">
                        <span>昵称</span>
                       <#-- <div class="item-title">&lt;#&ndash;<img src="images/v1/myimages/set-1.png" alt=""/>&ndash;&gt;昵称</div>-->
                        <span >${cust.customerNickname!''}</span>
                    </div>
                </div>
            </a>
        </li>
        <li id="sex">
            <a href="javascript:;" class="item-link">
                <div class="item-content">
                    <div class="item-inner">
                        <span class="mbase-menu-title">性别</span><input type="hidden" id="sexSelect" value="${cust.infoGender}">
                        <span><#if cust.infoGender??>
                            <#switch cust.infoGender>
                                <#case '2'>
                                    保密
                                    <#break>
                                <#case '0'>
                                    男
                                    <#break>
                                <#case '1'>
                                    女
                                    <#break>
                                <#default>
                            </#switch>
                        </#if></span>
                        <ul id="sex-list" style="display: none">
                            <li>男</li>
                            <li>女</li>
                            <li>保密</li>
                        </ul>
                    </div>
                </div>
            </a>
        </li>
        <#--<li>
            <a  href="javascript:;" class=" gender_set item-link " >
                <div class="item-content">
                    <div class="item-inner">
                        <span >性别</span>
                    &lt;#&ndash;    <div class="item-title">&lt;#&ndash;<img src="images/v1/myimages/set-1.png" alt=""/>&ndash;&gt;性别</div>&ndash;&gt;
                        <span><#if cust.infoGender??>
                            <#switch cust.infoGender>
                                <#case '2'>
                                    保密
                                    <#break>
                                <#case '0'>
                                    男
                                    <#break>
                                <#case '1'>
                                    女
                                    <#break>
                                <#default>
                            </#switch>
                        </#if>
        </span>
                    </div>
                </div>
            </a>
        </li>-->
        <li>
            <a href="javascript:;" class="item-link">
                <div class="item-content">
                    <div class="item-inner">
                        <span >生日</span>
                        <#--<div class="item-title">&lt;#&ndash;<img src="images/v1/myimages/set-1.png" alt=""/>&ndash;&gt;生日</div>-->
                        <input style="background:#fff;height: .9rem;width: 4.9rem;text-align: right;border: none;padding: 0;font-size: 15px;color: #000;letter-spacing: 0;" type="text"   id="txtBirthday" name="birthday" readonly="readonly" placeholder="${cust.infoBirthday!''}"/>
                      <input type="hidden" id="defaultBirth" value="${cust.infoBirthday!''}">
                    </div>
                </div>
            </a>
        </li>

    </ul>
        <ul>
            <li>
                <a href="${basePath}/changeemail.html?main=${main!''}" class="item-link">
                    <div class="item-content">
                        <div class="item-inner">
                            <span>邮箱</span>
                     <#-- <div class="item-title">&lt;#&ndash;<img src="images/v1/myimages/set-1.png" alt=""/>&ndash;&gt;邮箱</div>-->
                            <span>
                            <#if (cust.infoEmail?? && cust.infoEmail?length>0)>
                            ${cust.infoEmail!''}
                            <#else>
                                <p style="display:inline;color:#2283F6;">点击添加</p>
                            </#if>
                         </span>
                        </div>
                    </div>
                </a>
            </li>
        </ul>


    </div>
  <#--<dl>
    <dt>用户名</dt>
    <dd>
      <a href="#">
        <span>${cust.customerUsername!''}</span>
      </a>
    </dd>
  </dl>-->
  <#--<dl>-->
    <#--<dt>会员级别</dt>-->
    <#--<dd>-->
      <#--<a href="#">-->
        <#--<span class="label">${cust.pointLevelName!''}</span>-->
      <#--</a>-->
    <#--</dd>-->
  <#--</dl>-->
 <#-- <dl>
    <dt>昵称</dt>
    <dd>
      <a href="${basePath}/changenickname.html">
        <span>${cust.customerNickname!''}</span>
        <i class="ion-ios-arrow-right1"></i>
      </a>
    </dd>
  </dl>-->
 <#-- <dl>
    <dt>姓名</dt>
    <dd>
      <a href="${basePath}/changename.html">
        <span>${cust.infoRealname!''}</span>
        <i class="ion-ios-arrow-right"></i>
      </a>
    </dd>
  </dl>-->
 <#-- <dl>
    <dt>性别</dt>
    <dd>
      <a href="javascript:;" class="gender_set">
        <span><#if cust.infoGender??>
                <#switch cust.infoGender>
                <#case '0'>
                                                                保密
                <#break>
                <#case '1'>
                                                               男
                <#break>
                <#case '2'>
                                                                女
                <#break>
                <#default>
                </#switch>
              </#if>
        </span>
        <i class="ion-ios-arrow-right1"></i>
      </a>
    </dd>
  </dl>-->
  <#--  <dl >
        <dt>生日</dt>
        <dd>
            <a href="&lt;#&ndash;${basePath}/phonevalidate1.html&ndash;&gt;javascript:;">
                <span>
                <#if (cust.infoEmail??)>
                ${cust.infoEmail!''}
                <#else>
                    点击添加
                </#if>
                </span>
            </a>
        </dd>
    </dl>-->

  <#--<dl>-->
    <#--<dt>QQ号码</dt>-->
    <#--<dd>-->
      <#--<a href="${basePath}/changeqq.htm">-->
        <#--<span>${cust.infoQQ!''}</span>-->
        <#--<i class="ion-ios-arrow-right"></i>-->
      <#--</a>-->
    <#--</dd>-->
  <#--</dl>-->
    <#--<dl>-->
        <#--<dt>推荐注册</dt>-->
        <#--<dd>-->
            <#--<a href="javascript:;" class="recommend_register">-->
                <#--<i class="ion-ios-arrow-right"></i>-->
                <#--<input type="hidden" id="customer_id" value="${customerId!''}">-->
            <#--</a>-->
        <#--</dd>-->
    <#--</dl>-->
</div>
<#--<div class="member_info" style="    border-top: .2rem solid #f7f7f7;  ">

    <dl >
        <dt>邮箱</dt>
        <dd>
            <a href="${basePath}/changeemail.html">
                <span>
                    <#if (cust.infoEmail??)>
                        ${cust.infoEmail!''}
                    <#else>
                        点击添加
                    </#if>
                </span>
                <i class="ion-ios-arrow-right1"></i>
            </a>
        </dd>
    </dl>

</div>-->
<#--<div class="member_info">-->
  <#--<dl>-->
    <#--<dt>收货地址管理</dt>-->
    <#--<dd>-->
      <#--<a href="${basePath}/addresslist.html">-->
        <#--<i class="ion-ios-arrow-right"></i>-->
      <#--</a>-->
    <#--</dd>-->
  <#--</dl>-->
  <#--<dl>-->
    <#--<dt>账号安全</dt>-->
    <#--<dd>-->
      <#--<a href="${basePath}/accountsafe.html">-->
        <#--<i class="ion-ios-arrow-right"></i>-->
      <#--</a>-->
    <#--</dd>-->
  <#--</dl>-->
  <#--
  <dl>
    <dt>账号绑定</dt>
    <dd>
      <a href="${basePath}/phonevalidate4.htm">
        <i class="ion-ios-arrow-right"></i>
      </a>
    </dd>
  </dl>
  -->
<#--</div>-->

<#--<div class="p10 mb50">-->
  <#--<a href="#" class="btn btn-full" id="loginout">退出当前登录</a>-->
<#--</div>-->
<#--
<div class="gender_choose" style="display:none;">
  <a href="${basePath}/changegender.html?gender=1" class="btn btn-full-grey">
    <i class="iconfont icon-unie040"></i> 男
  </a>
  <a href="${basePath}/changegender.html?gender=2" class="btn btn-full-grey">
    <i class="iconfont icon-unie041"></i> 女
  </a>
  <a href="${basePath}/changegender.html?gender=0" class="btn btn-full-grey">
    <i class="iconfont icon-mibao"></i> 保密
  </a>
  <a href="javascript:;" class="btn btn-full gender_close">取消</a>
</div>-->

<div class="recommend_choose" style="display:none;">
    <div class="member_form">
            <dl>
                <dt>选中复制</dt>
                <dd>
                    <input type="text" id="content" readonly="readonly">
                </dd>
            </dl>
            <p class="help_block" style="display:none;" id="nickName_msg"></p>
            <p class="help_block">亲！如果您的好友成功注册会员，会有积分送给您哦！</p>
    </div>
    <a href="javascript:;" class="btn btn-full recommend_close">取消</a>
</div>
<#--<div class="myabout-bottom">
&lt;#&ndash;Copyright© 2015  中国960官方商城<br/>  版权所有  京ICP备14057741号  京ICP证150185号&ndash;&gt;
    <img style="    width: 2.2rem;" src="/images/v1/myimages/jiuliulingcom.png">

</div>-->
<script>

    $("#sex").click(function () {
        var that = this;
        $("#sex-list").mobiscroll().treelist({
            theme: "android-ics light",
            lang: "zh",
            mode: "scroller",
            display: 'modal',
            closeOnSelect: false,
            inputClass: 'tmp',
            headerText: '请您选择',


        /*    onBeforeShow: function (inst) {
                $("#sex-list_dummy").attr("readonly",true);
            },*/
            onSelect: function (valueText) {
                var m = $(this).find("li").eq(valueText).html();
                $("#sex").focus();
                $("#sex-list_dummy").hide();
                location.href = "/changegender.html?gender="+valueText+"&main=${main}";
                /*$.post("inc/person.org.php", {apart: "resume_base", sex: m}, function (result) {
                    if (result == 'ok') {
                        $(that).find(".mbase-menu-txt").html(m);
                    }
                    else {
                        error('网络繁忙，请您稍后再试');
                    }
                });*/后端入库部分
            },

            onCancel: function (event, inst) {
                $("#sex-list_dummy").hide();
                $("#sex").focus();
            }
        });

        $("input[id^=sex-list]").focus();
       /* $("#sex-list_dummy").keydown(function () {
            $("#sex-list_dummy").focus();
        })
        $("#sex-list_dummy").attr("readonly",true);*/
    });
</script>
<script>
    $(function () {

        /*var opt = {
            theme: "android-ics light",
            display: 'modal', //显示方式
            lang: "zh",
            setText: '确定', //确认按钮名称
            cancelText: "取消",
            dateFormat: 'yyyy-mm-dd', //返回结果格式化为年月格式
            dateOrder: 'yyyymmdd', //面板中日期排列格式
            closeOnSelect: false,
            onBeforeShow: function (inst) {
            },
            headerText: function (valueText) { //自定义弹出框头部格式
                //	console.info(valueText);
                array = $("#defaultBirth").val().split('-');
                return array[0] + "年" + array[1] + "月" + array[2] + "日";
            },
            onSelect:function(valueText,inst){
                location.href = "/changebirthday.html?birthday="+valueText;
            }
        };

        $("#txtBirthday").mobiscroll().date(opt).val($("#defaultBirth").val());*/
        $('#txtBirthday').val($("#defaultBirth").val());
        if($.trim($("#defaultBirth").val()).length == 0){
            $('#txtBirthday').scroller(
                    $.extend({preset : 'date'},
                            {   theme: "android-ics light",
                                mode: "scroller",
                                display: 'modal',
                                lang: 'zh',
                                setText: '确定', //确认按钮名称
                                cancelText: "取消",
                                dateFormat : "yy-mm-dd",
                                dateOrder: 'yymmdd',
                                /* closeOnSelect: false,*/
                                headerText: function (valueText) { //自定义弹出框头部格式
                                    //	console.info(valueText);
                                    array = valueText.split('-');
                                    return array[0] + "年" + array[1] + "月" + array[2] + "日";
                                },
                                onSelect:function(valueText,inst){
                                    $("#txtBirthday").blur();
                                    location.href = "/changebirthday.html?birthday="+valueText+"&main=${main!''}";

                                },
                                onCancel: function (event, inst) {

                                    $("#txtBirthday").blur();
                                }
                            })
            );
        }


    });

</script>

<script>
  $(function(){

    /* 选择性别 */
    $('.gender_set').click(function(){
      if($('.opacity-bg-3').length == 0){
          $('body').append('<div class="opacity-bg-3"></div>');
          $('.gender_choose').show();
      }
    });

    /* 推荐注册 */
    $('.recommend_register').click(function(){
      var basePath = $('#basePath').val();
      var str = window.location.href;
      var b = str.indexOf('/',str.indexOf('/',str.indexOf('/')+2)+1);
    //		var a = str.indexOf("//")+2;
      var local = str.substring(0,b);
      var customerId = $('#customer_id').val();
      if(customerId==null||customerId==""){
      }else{
          //给会员id加密
          var b = new Base64();
          var result = 'customer_id='+customerId;
          var str = b.encode('"'+result+'"');
          var url = local+basePath+'/register.html?'+str;
          $('#content').val(url);
      }
      if($('.opacity-bg-3').length == 0){
          $('body').append('<div class="opacity-bg-3"></div>');
          $('.recommend_choose').show();
      }

        //复制成功弹出复制成功窗口
        $('#copy').zclip({
            path:'/js/ZeroClipboard.swf',
            copy:function(){
                return $("#content").html();
            },
            afterCopy:function(){
                $('.opacity-bg-3').remove();
                $('.recommend_choose').hide();
            }
        });
    });

    $('a.gender_close').click(function(){
    $('.opacity-bg-3').remove();
    $('.gender_choose').hide();
    });

    $('a.recommend_close').click(function(){
      $('.opacity-bg-3').remove();
      $('.recommend_choose').hide();
    });

  });

  $(".bar-bottom a").removeClass("selected");
      $(".bar-bottom a:eq(3)").addClass("selected");
</script>
</body>
</html>