
<#if shopKuaiShang?? && shopKuaiShang.operation?? && shopKuaiShang.isuseing?? && shopKuaiShang.isuseing =='0'>
${shopKuaiShang.operation !''}
</#if>
<#assign basePath=request.contextPath>
	<link rel="stylesheet" type="text/css" href="${basePath}/index_two/css/footer.css" />
   <link rel="stylesheet" type="text/css" href="${basePath}/index_960/css/style.css"/>
    <style>
        .mt20 {
            /*margin-top: 20px;*/
        }
		.svc_box{
			float:left;
		}
        .cursor_a{
            cursor: default;
        }
    </style>
<link rel="stylesheet" type="text/css" href="${basePath}/index_960/css/style_mend.css"/>
    <div style="background-color: #fff;">
            <div class="footer_tab">
               <#-- <ul>

                <#if topmap.advs??>
                    <#list topmap.advs as adv>
                        <#if (adv.adverSort>=11) && (adv.adverSort<=14)>
                            <#setting number_format="0">
                            <li class="list${adv.adverSort-10}"><a href="${adv.adverHref!'#'}"></a></li>
                        </#if>
                    </#list>
                </#if>
                &lt;#&ndash;<li class="list4"><a style="text-indent:17px;" href="#" target="_self">大 药 房</a></li>&ndash;&gt;
                </ul>-->
            </div>



    <div class="wp" >
        <div class="line iconlist" style="border: none;height: 8px;padding: 0;margin: 0;width: 100%;max-width: 100%;background-size: 100%;"></div>
        <div class="service mt20 clearfix" >
            <#--style="padding-left:125px"-->

        	<#if (bottom.helpCates)?? && (bottom.helpCates?size>0)>
        	<#list bottom.helpCates as helpcate>
        	<#if (helpcate_index>=0) && (helpcate_index<5)>
        	<dl class="svc_box svc_01 fl" style="background-image: url(${(helpcate.helpcateImg)!''});width:175px;">
                <dt <#--style="width: 85px;display: inline-block;text-align: left;"-->>${(helpcate.helpcateName)!''}</dt>
                <dd>
                	<#if (helpcate.helpCenters)?? && (helpcate.helpCenters?size>0)>
                	<#list helpcate.helpCenters as helpcenter>
                	<#if (helpcenter_index>=0) && (helpcenter_index<6)>
                	<#if (helpcenter.isFoot=='1')>
                        <#setting number_format="0">
                		<div><a <#--style="width: 85px;display: inline-block;text-align: left;" -->href="${basePath}/help/${helpcenter.helpId}" target="_blank" onclick="_czc.push(['_trackEvent', '首页', '底部', '${(helpcenter.helpTitle)!''}',  'dibu_bottom']);" id="dibu_bottom">${(helpcenter.helpTitle)!''}</a></div>
                	</#if>
                	</#if>
                	</#list>
                	</#if>

                </dd>
            </dl>
        	</#if>
        	</#list>
        	</#if>
             <#--   <div style="float:left;">
                    <p style=" margin-left: 5px;"> 960手机APP</p>
                    <img src="${basePath}/images/erweima1.png">
                </div>
                <div style="float:left; margin-left: 15px;">
                    <p> 960微信公众号</p>
                    <img style="width: 82px;height: 80px;"src="${basePath}/images/erweima2.png">
                </div>-->
        	<#--
            <div class="service_intro fr">
                <h3>宁派自营覆盖区县</h3>
                <p>宁派已向全国1739个区县提供自营配送服务，支持货到付款、POS机刷卡和售后上门服务。</p>
                <p class="tr"><a class="view_more" href="${basePath}/help/1">查看详情 &gt;</a></p>
            </div>
        	-->
        </div>
        <div style="border-bottom: 1px solid #e9e9e9; width: 100%;"></div>
        <div class="line iconlist" style="background: none; border-bottom: none;">
            <div style="width:1200px;margin:0 auto;">
                <a href="http://www.aqyp.org.cn/index.htm" class="a1" onclick="_czc.push(['_trackEvent', '首页', '底部', '安全饮品图标',  'security_drinks']);" id="security_drinks"><img style="width: 73px;height: 80px;" src="${basePath}/index_960/images/icon_menu1.png"></a>
                <a href="http://www.aqyp.org.cn/index.htm" style="margin-left: 171px;" onclick="_czc.push(['_trackEvent', '首页', '底部', '安全食品图标',  'safe_food']);" id="safe_food"><img style="width: 73px;height: 80px;" src="${basePath}/index_960/images/icon_menu6.png"></a>
                <a  href="http://www.aqspw.org/code.html" style="margin-left: 193px;" onclick="_czc.push(['_trackEvent', '首页', '底部', '多维彩码图标',  'color_code']);" id="color_code"><img style="width: 69px;height: 78px;" src="${basePath}/index_960/images/icon_menu5.png"></a>
                <a href="javascript:;" class="cursor_a" style="margin-left: 179px;" <#--onclick="_czc.push(['_trackEvent', '首页', '底部', '地理标志保护产品',  'geographical']);" id="geographical"-->><img style="width: 120px;height: 80px;" src="${basePath}/index_960/images/menu_icon1.png"></a>
                <a href="javascript:;" class="cursor_a" style="margin-left: 181px;" <#--onclick="_czc.push(['_trackEvent', '首页', '底部', '生态原产地保护产品',  'shengtaiyuanchandi']);" id="shengtaiyuanchandi"-->><img style="width: 133px;height: 80px;" src="${basePath}/index_960/images/menu_icon2.png"></a>
            <#--<a href="javascript:;" class="cursor_a"><img style="width: 73px;height: 80px;"   src="${basePath}/index_960/images/icon_menu4.png"></a>-->
            <#--       <a href="javascript:;" style="cursor:default;margin-left: 147px;"><img src="${basePath}/images/shentaiyuanchandi.png"></a>-->
            </div>
        </div>
        <div class="line iconlist" style="border: none;height: 8px;padding: 0;margin: 0;width: 100%;max-width: 100%;background-size: 100%;"></div>
		<!--/service-->

        <div class="footer mt20">
            <ul class="ft_links tc">
            <#--
            	<#if helpCenters?? && (helpCenters?size>0)>
            	<#list helpCenters as hc>
            	<#if (hc_index>=0) && (hc_index<11)>
	            	<li><a href="${basePath}/help/${hc.helpId}">${hc.helpTitle}</a></li>
	            	<#if (hc_index<(11-1))>|</#if>
            	</#if>
            	</#list>
            	</#if>
            -->
            </ul><!--/ft_links-->

            <div style="margin: 0 auto;margin-top: 15px; width: 1200px;" id="bq">
            ${topmap.systembase.bsetCopyright}

		    <ul style="text-align:center;margin-top:20px;">
        	<!--站长统计-->
            	<#--<li>-->
            	<#--<#if sCodeList?? && (sCodeList?size>0)>-->
			    	<#--<#list sCodeList as sCode>-->
			    		<#--<#if (sCode.code)??>-->
						<#--<#if (sCode.code?starts_with("<script") && sCode.code?ends_with("</script>"))>-->
							<#--${(sCode.code)!''}-->
						<#--</#if>-->
			    		<#--</#if>-->
			    	<#--</#list>-->
				<#--</#if>-->
            	<#--</li>-->
        </ul>
        	</div>

        </div><!--/footer-->
    </div><!--/wp-->

    </div>

<script>
	<#if cust??>
	    $(".rightbar_body").find("div[name='showMy960']").show();
	</#if>

</script>
<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?f3f6849d9a09fbba55460140f3b889c5";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>