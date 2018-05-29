<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>会员中心 - 浏览记录</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <meta name="keywords" content="${(seo.meteKey)!''}">
  <meta name="description" content="${(seo.meteDes)!''}">
  <meta content="telephone=no" name="format-detection">
  <#assign basePath=request.contextPath>
  <link rel="stylesheet" href="${basePath}/css/style.min.css"/>
  <link rel="stylesheet" href="${basePath}/css/ui-dialog.css">
  <script src="${basePath}/js/jquery-1.10.1.js"></script>
  <script src="${basePath}/js/dialog-min.js"></script>
    <style>
        .vheader span {
            text-align: center;
            /*  margin: 0;*/
            margin-right: 0rem!important;
            margin-left: 1.4em!important;
            font-size: 16px;
            position: relative;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            -webkit-flex-shrink: 10;
            -ms-flex: 0 10 auto;
            flex-shrink: 10;
            display: -webkit-box;
            display: -ms-flexbox;
            display: -webkit-flex;
            display: flex;
            -webkit-box-align: center;
            -ms-flex-align: center;
            -webkit-align-items: center;
            align-items: center;
        }
        .vheader{
            position: fixed;
            left: 0;
            top:0;
            padding: 5px 15px 5px 5px!important;
        }
        .content .stick{
            width: 100%;
            height: 60px;
            position: fixed;
            left: 0;
            top: 50px;
            z-index: 99;
            background: #FFFFFF;
            box-shadow: 0 2px 3px 0 rgba(0,0,0,0.09);
        }
        .content .stick p{
            text-align: center;
            font-size: 12px;
            color: #000000;
            letter-spacing: 1px;
            opacity: 0.48;
            margin-top: 11px;
            display: block;
            height: 17px;
        }
        .content .stick span{
            text-align: center;
            display: block;
            font-size: 14px;
            color: #000000;
            letter-spacing: 1px;
            font-weight: bold;
            height: 20px;
        }
        .content .prolist{
            border-top: none;
            margin-bottom: 0px;
        }
        .content .prolist .rq_date{

            font-size: 12px;
            display: block;
            color: #000000;
            letter-spacing: 1px;
            opacity: 0.48;
            margin: 8px 15px 0px 15px;

            width: 92%;
          /*  position: absolute;
            left:0;
            top:0;*/
        }
        .content .prolist.list-line .list-item{
            margin: 0px 15px 0px 15px;
            width: 92%;
            border-bottom: 1px solid #ececec;
            padding:23px 0 23px 83px;
        }
        .content .prolist.list-line .list-item .propic img {
            width: 68px;
            height: auto;
            margin-top: -56px;
        }
        .content .prolist.list-line .list-item .propic{
            width: 68px;
            top: 26px;
            height: 68px;

        }
        .content .prolist.list-line .list-item .prodesc .title{
            font-size: 14px;
            color: #000000;
            letter-spacing: 1.17px;
            width: 98%;
            margin-top:1px;
            line-height: 20px;
            height: 39px;
        }
        .content .prolist.list-line .list-item .prodesc{
            height: 66px;
        }
        .content .prolist.list-line .list-item .prodesc .price{
            font-size: 14px;
            color: #199301;
            letter-spacing: 0.58px;
            bottom: -6px;

        }
        .content .prolist.list-line .list-item .prodesc .sc_del{
            z-index: 999;
            width: 50px;
            height: 30px;
            text-align: right;
            padding-top: 10px;
            font-size: 12px;
            color: #8F8F8F;
            letter-spacing: 1px;
            /*padding-right: 8px;*/
            display: block;
            float: right;
            font-family: Ionicons;
        }

        .content .prolist.list-line .list_item1{
            padding-top: 8px;
            padding-bottom: 18px;
        }
        .content .prolist.list-line .list-item .list_item2{
            top:10px;
        }
        .content, .content-class ,html,body{
            background: #ffffff;
        }
    </style>
</head>
<body>
<#assign vtitle="浏览记录" />
<#assign voption="清空" />
<#assign backUrl="${basePath}/customercenter.html" />
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
<input id="status" value="0" type="hidden">
 <input id="basePath" type="hidden" value="${basePath}" />
<div class="content" style="padding-top:112px; background: #ffffff; overflow: scroll;">
    <#if (pb?? && pb.list?size!=0)>
        <div class="stick">
            <p>当前显示</p>
            <span class="stick_span">${pb.list[0].isMobile}</span>
        </div>
    <#else>
    <style>
        .content{
            padding-top:50px!important;}
    </style>
    </#if>
<#assign browseTime="" />
  <div class="prolist list-line" id="items">
    <#if (pb?? && pb.list?size!=0)>
     <#list pb.list as browse>
       <a href="${basePath}/item/${browse.goodsId}.html">
           <#if browse.isMobile != browseTime>
               <i class="rq_date" name="${browse.isMobile}">${browse.isMobile?substring(5,browse.isMobile?length)}</i>
           </#if>
           <div class="list-item<#if browse.goods.goodStock?? ><#if (browse.goods.goodStock>0)><#else> sell-out</#if></#if> <#if browse.isMobile != browseTime>list_item1</#if>" id="browere${browse.likeId}">

            <div class="propic<#if browse.isMobile != browseTime> list_item2 <#assign browseTime=browse.isMobile /></#if>">
	        <img width="100" height="100" alt="<#if browse.goods.goodsName??> ${browse.goods.goodsName}</#if>"
	        		src="<#if browse.goods.goodsImg??> ${browse.goods.goodsImg}</#if>" />
	      </div>
	      <div class="prodesc">
	        <h3 class="title">
	        <#if (browse.goods.goodsName)?length gt 50>
	          ${(browse.goods.goodsName)?substring(0,50)}
	          <#else> ${browse.goods.goodsName}
	        </#if>
	       </h3>
	        <p class="price">&yen;<span>${browse.goods.goodsPrice?string('0.00')}</span></p>
              <i class="sc_del" name="${browse.likeId}">删除</i>
	      </div>

	    </div>
	    </a>
     </#list>
     <#else>
		<div class="content">
		  <div class="no_tips">
		    <p>木有浏览记录哦</p>
		  </div>
		</div>
    </#if>
  </div>
    <div class="list-loading" style="display:none" id="showmore">
        <img alt="" src="${basePath}/images/loading.gif">
        <span>加载中……</span>
    </div>
</div>


<script src="${basePath}/js/customer/browerecord.js?v=0.04"></script>
<script>
  $(function(){
  /*    $(window).scroll(function(){
          var distance=$(document).scrollTop();
          if(distance>10){
                $(".zhiding").css("top","0px");
          }else{
              $(".zhiding").css("top","50px");
          }
      })*/
    //删除单个浏览记录
    $(".prolist").delegate(".sc_del","click",function(event){
        var likeId = $(this).attr("name");
        var discountBox = dialog({
            width: 260,
            title: '删除浏览记录',
            content: "确定删除该浏览记录吗？",
            okValue: '确定',
            cancelValue: '取消',
            ok: function () {
                $.ajax({
                    url:"${basePath}/browerecord/remove.htm",
                    type:"post",
                    data:"likeId="+likeId,
                    success:function(data){
                        if(data > 0){
                            setTimeout(function () {
                                $('.tip-box').remove();
                                $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><i class="success"></i><h3>浏览记录删除成功！</h3></div></div>');
                            }, 10);
                            setTimeout(function () {
                                $(".tip-box").hide();
                                location.reload();
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
      event.preventDefault();
    })
    $(".bar-bottom  a").removeClass("selected");
    $(".bar-bottom:eq(0) a:eq(3) ").addClass("selected");
    /* 排序 */
    $('.sort_choose').click(function(){
      if($('.opacity-bg-1').length == 0){
        $('body').append('<div class="opacity-bg-1"></div>');
        $('.sort-list').slideDown('fast');
      }
    });
    $('.sort-list li').click(function(){
      $(this).addClass('selected').siblings().removeClass('selected');
      $('.opacity-bg-1').remove();
      $('.sort-list').hide();
    });

    /* 筛选 */
    $('.filter_choose').click(function(){
      if($('.opacity-bg-3').length == 0){
        $('body').append('<div class="opacity-bg-3"></div>');
        $('.screen').show();
      }
    });
    $('a.sure').click(function(){
      $('.opacity-bg-3').remove();
      $('.screen').hide();
    });

 	$(window).scroll(function(){
	    if($(this).scrollTop() >= ($('body').height() - $(window).height())){
	      show();
	    }
        $(".rq_date").each(function () {
            var rq_this = $(this).attr("name");
            var top_distance = $(this).offset().top - $(document).scrollTop();
            console.log(1)
            if(top_distance <= 120){
                $(".stick_span").html(rq_this);
            }
        })

    });

  });
  $(function(){
      $("#icon-option").click(function(){
          var discountBox = dialog({
              width: 260,
              title: '删除浏览记录',
              content: "确定删除全部浏览记录吗？",
              okValue: '确定',
              cancelValue: '取消',
              ok: function () {
                  $.ajax({
                      url:"${basePath}/browerecord/remove.htm",
                      type:"post",
                      success:function(data){
                          if(data > 0){
                              setTimeout(function () {
                                  $('.tip-box').remove();
                                  $('body').append('<div class="tip-box" style="z-index:99999"><div class="tip-body"><i class="success"></i><h3>浏览记录删除成功！</h3></div></div>');
                              }, 10);
                              setTimeout(function () {
                                  $(".tip-box").hide();
                                  location.reload();
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
      });
  });
</script>
</body>
</html>