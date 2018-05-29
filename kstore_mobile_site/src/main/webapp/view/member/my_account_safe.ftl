<!DOCTYPE html>
<html>
<head>
    <#assign basePath=request.contextPath/>
  <meta charset="UTF-8">
  <title>会员中心 - 账户安全</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <meta content="telephone=no" name="format-detection">
  <link rel="stylesheet" href="${basePath}/css/style.min.css"/>
        <link rel="stylesheet" href="${basePath}/css/add-ons.min.css"/>
        <link rel="stylesheet" href="${basePath}/css/ui-dialog.css"/>
  <script src="${basePath}/js/jquery-1.10.1.js"></script>
  <script src="${basePath}/js/idangerous.swiper.js"></script>
        <script src="${basePath}/js/dialog-min.js"></script>
    <style>
        .safe_list, .safe_list .safe_item h4{float: none;}
        .safe_list .safe_item {
            position: relative;
            width: 100%;
            padding: .8em 1.5em .8em 0em;
        }
        .safe_list .safe_item h4 span {
            margin-right: 1em;
            font-size: .9em;
            color: #393939;
        }
    </style>
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
            .list-block .item-inner:after {
                background-color: #eee;
                height: 1px;
            }
            .list-block li:last-of-type .item-inner:after {  background-color: transparent;  }
            .mysetting .item-title {
                font-size: .24rem;
                color: #1D1D1D;
                letter-spacing: 0;
            }
            .list-block .item-inner:after {
                content: '';
                position: absolute;
                left: 0;
                bottom: 0;
                right: auto;
                top: auto;
                height: 1px;
                width: 100%;
                display: block;
                z-index: 15;
                -webkit-transform-origin: 50% 100%;
                transform-origin: 50% 100%;
            }
            .list-block .item-link .item-inner {
                padding-right: 35px;
                background-image: url(/images/icon_v1.0/btn_more_right@2x.png);
                background-size: 22px 22px;
                background-repeat: no-repeat;
                background-position: 95% center;
                background-position: -webkit-calc(100% - 10px) center;
                background-position: calc(100% - 10px) center;
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


        </style>
</head>
<body>
<#assign vtitle="账户安全" />
<#assign backUrl="${basePath}/intoPage.htm?pageName=member/mysetting" />
<#include "/common/head_back.ftl"/>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script>
    var localUrl = window.location.href;
    $(function(){
        $.ajax({
            url: "${basePath}/queryWxConfig.htm",
            type: "POST",
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
        wx.onMenuShareAppMessage({
            title: '中国960官方商城',
            desc: '中国960官方商城',
            link: 'http://m.ge960.com/',
            imgUrl: 'http://boss.ge960.com:80/upload/20170327/1490602121555.jpg'
        });

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

<div class="safe_list" style="    ">
    <div class="list-block">
        <ul>
            <li>
                <a <#--href="${basePath}/phonevalidate1.html"--> class="item-link">
                    <div class="item-content">
                        <div class="item-inner" style="background: none;padding-right: 15px;">
                            <span style="color: #000;letter-spacing: 0;    font-size:15px;">已绑定手机号</span>
                            <span class="right" ><em style=" margin-left: 42px; width: 3.5rem;color: #000;letter-spacing: 0;font-size: 15px; text-align: right; display: block"><#if cust.infoMobile??&&cust.infoMobile!=''>
                                <#assign mo="${cust.infoMobile?substring(3,cust.infoMobile?length-4)}" />
                                <#assign mob="${cust.infoMobile?replace(mo,'****')}" />
                            ${mob}
                            <#else>未绑定</#if></em></span>
                        </div>
                    </div>
                </a>
            </li>
            <li>
                <a href="${basePath}/tochangepassword.html" class="item-link">
                    <div class="item-content">
                        <div class="item-inner" >
                            <span style="color: #000;letter-spacing: 0;    font-size: 15px;">账号密码</span>
                            <span class="right"  ><em style=" margin-left: 55px;    width: 3.5rem;color: #000;letter-spacing: 0;font-size:15px; text-align: right; display: block">修改</em></span>
                        </div>
                    </div>
                </a>
            </li>
        </ul>
    </div>
  <#--<div class="safe_item">
    <a href="${basePath}/phonevalidate1.html">
      <h4>
        <span style="color: #1D1D1D;letter-spacing: 0;    font-size: .9rem;">已绑定手机号</span>
        <span class="right"><em style="color: #858585;letter-spacing: 0;font-size: .9rem;"><#if cust.infoMobile??&&cust.infoMobile!=''>
            <#assign mo="${cust.infoMobile?substring(3,cust.infoMobile?length-4)}" />
            <#assign mob="${cust.infoMobile?replace(mo,'****')}" />
        ${mob}
        <#else>未绑定</#if></em></span>
      </h4>
 &lt;#&ndash;     <p>
        若您的验证手机已丢失或停用，请立即修改
      </p>&ndash;&gt;
      <i class="ion-ios-arrow-right"></i>
    </a>
  </div>-->
  <#--  <div class="safe_item">
        <a href="${basePath}/tochangepassword.html">
            <h4>
                <span style="color: #1D1D1D;letter-spacing: 0;    font-size: .9rem;">账号密码</span>
                <span class="right"><em style="color: #858585;letter-spacing: 0;font-size: .9rem;">修改</em></span>
            </h4>
           &lt;#&ndash; <p>
                建议您定期更改密码以保护账户安全
            </p>&ndash;&gt;

            <i class="ion-ios-arrow-right"></i>
        </a>
    </div>-->
    <#--<div class="safe_item">-->
        <#--<a href="javascript:;" id="setPayPassword">-->
            <#--<h4>-->
                <#--<span>支付密码</span>-->
            <#--</h4>-->
            <#--<p>设置支付密码用户可进行预存款支付</p>-->
            <#--<i class="ion-ios-arrow-right"></i>-->
        <#--</a>-->
    <#--</div>-->
  <#--
  <div class="safe_item">
    <a href="my_account_pay_password1.htm">
      <h4>
        <span>支付密码</span>
        <span class="right">安全程度 <em>高</em></span>
      </h4>
      <i class="ion-ios-arrow-right"></i>
    </a>
  </div>
  -->
</div>

<#--<div class="safe_list mb50">
  <div class="safe_item">
    <a href="${basePath}/tosafetips.html">
      <h4>
        <span>安全提示</span>
      </h4>
      <i class="ion-ios-arrow-right"></i>
    </a>
  </div>
</div>-->
<script>
  $(function(){
      /*
    * 设置支付密码前提示
    * */
      $('#setPayPassword').click(function(){
          $.ajax({
              url:'${basePath}/mobilevalidation.htm',
              type:'GET',
              dataType:'text',
              async:true,
              success:mobileValidate
          });


      });

  });
  
  $(".bar-bottom a").removeClass("selected");
      $(".bar-bottom a:eq(3)").addClass("selected");

    function mobileValidate(responseData){
      if(responseData == 'false'){
          var setPayPassword = dialog({
              width : 260,
              content : '<div style="padding:0 15px"><p class="tc">设置支付密码，必须先验证手机，请先验证手机</p></div> ',
              okValue : '立即验证',
              cancelValue : '稍后再说',
              ok : function(){
                  //确认离开，跳转到下一页面
                  window.location.href="${basePath}/phonevalidate1.html";
                  return false;
              },
              cancel : function(){
                  //演示需要，跳转到密码支付页面
//                  window.location.href="my_account_pay_password1.html";
                  return true;
              }
          });
          setPayPassword.showModal();
      }else{
          window.location.href="${basePath}/member/topaypassword.html";
      }
    }
</script>
</body>
</html>