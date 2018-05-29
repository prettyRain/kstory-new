<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>收货地址-${topmap.systembase.bsetName}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="Keywords" content="${topmap.seo.meteKey}">
    <meta name="description" content="${topmap.seo.meteDes}">
<#assign basePath=request.contextPath>
<#if (topmap.systembase.bsetHotline)??>
    <link rel = "Shortcut Icon" href="${(topmap.systembase.bsetHotline)!''}">
<#else>
    <link rel = "Shortcut Icon" href="${basePath}/images/Paistore.ico">
</#if>
    <link rel="stylesheet" type="text/css" href="${basePath}/css/pages.css" />
<#--shf-->
    <link rel="stylesheet" href="${basePath}/index_960/css/style.css"/>
    <style>
        .section_headerTop{
            background: none!important;
            border-bottom: none!important;
        }
        /*shf*/
        .cartfd-mem {
            top: 9px!important;
        }
        /*未填项报错*/
        .tipserror{color:red}
        .dia_tit {
            height: 30px;
            line-height: 30px;
            padding: 0 0px;
            font-family: microsoft YaHei;
            font-size: 14px;
            color: #fff;
            background: #eb6122;
            border-radius: 5px 5px 0 0;
        }

        .dia_tit h4 {
            line-height: 30px;
        }

        .dia_tip{
            background: #fff;
            padding-bottom: 20px;
            min-height: 120px;
        }

        .go_pay {
            border-width: 1px;
            border-style: solid;
            color: #fff!important;
            background: #35a400;
        }
        .rightpar{
            display: none;
        }
        .tip_dia {
            width: 290px;
            min-height: 160px;
        }
    </style>
    <script type="text/javascript" src="${basePath}/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${basePath}/index_960/js/app.js"></script>
</head>

<body>

<input type=hidden name="basePath" id="basePath" value="${basePath}"/>
<#--一引入头部 <#include "/index/topnew.ftl" />  -->
<#--shf-->
<#include "../index/newheader3.ftl"/>
<#--<#if (topmap.temp)??>-->
    <#--<#if (topmap.temp.tempId==8)>-->
        <#--<#include "../index/newtop3.ftl">-->
    <#--<#elseif (topmap.temp.tempId==9)>-->
        <#--<#include "../index/newtop4.ftl">-->
    <#--<#elseif (topmap.temp.tempId==10)>-->
        <#--<#include "../index/newtop7.ftl">-->
    <#--<#elseif (topmap.temp.tempId==11)>-->
        <#--<#include "../index/newtop6.ftl">-->
    <#--<#elseif (topmap.temp.tempId==12)>-->
        <#--<#include "../index/newtop7.ftl">-->
    <#--<#elseif (topmap.temp.tempId==13)>-->
        <#--<#include "../index/newtop8.ftl">-->
    <#--<#elseif (topmap.temp.tempId==14)>-->
        <#--<#include "../index/newtop9.ftl">-->
    <#--<#elseif (topmap.temp.tempId==15)>-->
        <#--<#include "../index/newtop8.ftl">-->
    <#--<#elseif (topmap.temp.tempId==16)>-->
        <#--<#include "../index/newtop11.ftl">-->
    <#--<#elseif (topmap.temp.tempId==17)>-->
        <#--<#include "../index/newtop12.ftl">-->
    <#--<#elseif (topmap.temp.tempId==18)>-->
        <#--<#include "../index/newtop13.ftl">-->
    <#--<#elseif (topmap.temp.tempId==19)>-->
        <#--<#include "../index/newtop14.ftl">-->
    <#--<#elseif (topmap.temp.tempId==20)>-->
        <#--<#include "../index/newtop15.ftl">-->
    <#--<#elseif (topmap.temp.tempId==21)>-->
        <#--<#include "../index/newtop21.ftl">-->
    <#--<#else>-->
        <#--<#include "../index/newtop.ftl"/>-->
    <#--</#if>-->
<#--</#if>-->

<#--<#include "newtop.ftl"/>-->
<#--shf background: #fff;-->
<div style="background: #fff;">
    <div class="container clearfix pt20 pb10">
        <!--new_member_left-->
    <#include "newleftmenu.ftl"/>
        <div class="new_member-right">
            <div class="air-account-address">
                <div class="n-title">收货地址</div>
                <div class="simple mt20 clearfix">
                    <div class="fl">
                        <button  onclick="toaddAddress()">新增收货地址</button>
                        <span class="addressNum-tips ml10">您已创建<span id="addressesNum" class="red">${pb.rows!'0'}</span>个收货地址，最多可创建<span class="red">10</span>个</span>
                    </div>
                </div>
                <div class="content">
                    <div class="layout">
                        <div class="air-addressList">
                        <#if pb.list?size!=0>
                            <#list pb.list as address>
                                <#if address.addressType == '0'>
                                    <div class="air-addressInfo">
                                        <ul>
                                            <li>
                                                <label for=""> 收货人：</label><span><#if address.addressName??>${address.addressName}</#if></span>
                                            </li>
                                            <li>
                                                <label for=""> 所在地区：</label>
                                                <span>
                                                            <#if address.province??>
                                                            ${address.province.provinceName}
                                                            </#if>
                                                    <#if address.city??>
                                                        -${address.city.cityName}
                                                    </#if>
                                                    <#if address.district??>
                                                        -${address.district.districtName}
                                                    </#if>
                                                    <#if address.street??>
                                                        -${address.street.streetName}
                                                    </#if>
                                                        </span>
                                            </li>
                                            <li>
                                                <label for=""> 地址：</label>
                                                <span>
                                                    <#if address.addressDetail??>
                                                            ${address.addressDetail}
                                                            </#if>
                                                        </span>
                                            </li>
                                            <li>
                                                <label for="">手机：</label>
                                                <span>
                                                    <#if address.addressMoblie??>
                                                        <#if address.addressMoblie?length!=0>
                                                        ${address.addressMoblie}<br>
                                                        </#if>
                                                    </#if>
                                                        </span>
                                            </li>
                                        </ul>
                                        <span class="delete-address"><a onclick="deladdress(${address.addressId})"><img src="${basePath}/images/delete-address.png"/></a></span>
                                        <div class="address-toolbar">
                                            <#if address.isDefault=='0'>
                                                <button  onclick="modifyDefault('${address.addressId}','${customer.customerId}')">设为默认</button>
                                            <#else>
                                                <button style="border: none; color: red; background: none; cursor: default;">默认地址</button>
                                            </#if>
                                            <button onclick="updateAddress(${address.addressId})">编辑</button>
                                        </div>
                                    </div>
                                <#elseif address.addressType == '1'>
                                    <div class="air-addressInfo">
                                        <ul>
                                            <li>
                                                <label for=""> 收货人：</label><span><#if address.addressName??>${address.addressName}</#if></span>
                                                <label for=""> 社区店：</label><span><#if address.communityStore??>${address.communityStore.communityStoreName}</#if></span>
                                            </li>
                                            <li>
                                                <label for=""> 所在地区：</label>
                                                <span>
                                                            <#if address.province??>
                                                            ${address.province.provinceName}
                                                            </#if>
                                                    <#if address.city??>
                                                        -${address.city.cityName}
                                                    </#if>
                                                    <#if address.district??>
                                                        -${address.district.districtName}
                                                    </#if>
                                                    <#if address.street??>
                                                        -${address.street.streetName}
                                                    </#if>
                                                        </span>
                                                <label for=""> 社区店地址：</label>
                                                <span>
                                                    <#if address.communityStore??>
                                                    ${address.communityStore.province.provinceName
                                                    +address.communityStore.city.cityName
                                                    +address.communityStore.district.districtName+' '
                                                    +address.communityStore.communityStoreAddress}
                                                    </#if>
                                                </span>
                                            </li>
                                            <li>
                                                <label for=""> 地址：</label>
                                                <span>
                                                    <#if address.addressDetail??>
                                                            ${address.addressDetail}
                                                            </#if>
                                                </span>
                                                <label for=""> 联系人：</label>
                                                <span>
                                                    <#if address.communityStore??>
                                                            ${address.communityStore.contact}
                                                            </#if>
                                                </span>
                                            </li>
                                            <li>
                                                <label for="">手机：</label>
                                                <span>
                                                    <#if address.addressMoblie??>
                                                        <#if address.addressMoblie?length!=0>
                                                        ${address.addressMoblie}<br>
                                                        </#if>
                                                    </#if>
                                                </span>
                                                <label for="">联系电话：</label>
                                                <span>
                                                    <#if address.communityStore??>
                                                        <#if address.communityStore?length!=0>
                                                        ${address.communityStore.contactMobile}<br>
                                                        </#if>
                                                    </#if>
                                                </span>
                                            </li>
                                        </ul>
                                        <span class="delete-address"><a onclick="deladdress(${address.addressId})"><img src="${basePath}/images/delete-address.png"/></a></span>
                                        <div class="address-toolbar">
                                            <#if address.isDefault=='0'>
                                                <button  onclick="modifyDefault('${address.addressId}','${customer.customerId}')">设为默认</button>
                                            <#else>
                                                <button style="border: none; color: red; background: none; cursor: default;">默认地址</button>
                                            </#if>
                                            <button onclick="updateAddress(${address.addressId})">编辑</button>
                                        </div>
                                    </div>
                                </#if>
                            </#list>
                        <#else>
                            <div  style="margin-top:10px;border:1px #e8e8e8 solid; height:40px; text-align: center; font-size: 18px;line-height:40px;;">
                                暂无收货地址！
                            </div>
                        </#if>

                        </div>
                        <div class="paging_area">
                        <#if (pb.list?size!=0)>
                                    <#-- 分页 -->
                                    <#import "/pagination/pageBean.ftl" as page>
                                    <@page.pagination pb />
                                    </#if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="mask"></div>
<div class="jd-dialog dia2 address_dia" style="width: 700px;">
    <div class="jd-dialog-title"><p id="diaTitle">新增收货人信息</p><a href="javascript:void(0)" class="jd-dialog-close"
                                                                   onclick="cls(),setDefaultForm();">×</a></div>
    <form method="post"  id="addressFrom" onsubmit="return updateqqq()">
        <input type="hidden" name="CSRFToken" id="CSRFToken" value="${token}">
        <input type="hidden" name="customerId" id=hiden_customerId value=${(customer.customerId)!''} />
        <!--隐藏地址编号-->
        <input type="hidden" name="addressId" id="hiden_addressId" />
    <div class="jd-dialog-con clearfix p10">
        <div class="form" id="consignee-form" name="consignee-form">
            <div class="item clearfix" >
                <span class="label"><span style="color:red">*</span>&nbsp;地址类型：</span>

                <div class="fl">
                    <input type="radio" id="addressType1" name="addressType" value="1" style="width:14px;height: 30px;" onclick="$('#community_div').show()">社区店
                    <input type="radio" id="addressType0" name="addressType" value="0" style="width:14px;height: 30px;" onclick="$('#community_div').hide()" checked>自选地址
                </div>
            </div>
            <div class="item clearfix" id="community_div" style="display: none;">
                <span class="label"><span style="color:red">*</span>&nbsp;社区店：</span>
                <div class="fl">
                    <span id="span_province"><select class="selt" id=infoProvinceCommunity tabindex="2"><option value="">请选择：</option></select></span>
                    <span id="span_city"><select class="selt" id=infoCityCommunity tabindex="3"><option value="">请选择：</option></select></span>
                    <span id="span_county"><select class="selt" id=infoCountyCommunity tabindex="4"><option value="">请选择：</option></select></span>
                    <span id="span_area">
                      <span id="community_stores"><select id="community_stores_select" class="selt" name="communityStoreId" tabindex="2" onchange="checkCommunityStore()"><option value="">请选择：</option></select></span>
                    </span>
                </div>
                <span class="error-msg communityTips" id="community_div_error"></span>
            </div>
            <div class="item clearfix" id="name_div">
                <span class="label"><span style="color:red">*</span>&nbsp;收货人：</span>

                <div class="fl">
                    <input type="hidden" class="save_update_add_id">
                    <input type="hidden" id="consignee_form_id" name="consigneeParam.id" value="">
                    <input type="hidden" id="consignee_type" name="consigneeParam.type" value="">
                    <input type="hidden" id="consignee_ceshi1" name="consignee_ceshi1" value="">
                    <input type="text" class="itxt save_add_name" id="addressName" onblur="checkAddressName();"
                           name="addressName" maxlength="12" value="" tabindex="1">
                    <span class="error-msg addressNameTip" id="addressName_tips"></span>
                </div>
            </div>
            <div class="item clearfix" id="area_div">
                <span class="label"><span style="color:red">*</span>&nbsp;所在地区：</span>

                <div class="fl">
			<span id="span_area">
			  <span id="span_province"><select class="selt" name="infoProvince" id=infoProvince tabindex="2"><option value="">请选择：</option></select></span>
			   <span id="span_city"><select class="selt" name="infoCity" id=infoCity tabindex="3"><option value="">请选择：</option></select></span>
			   <span id="span_county"><select class="selt" name="infoCounty" id=infoCounty tabindex="4"><option value="">请选择：</option></select></span>
            <#--<span id="span_town"><select class="selt" name="infoStreet" id=infoStreet tabindex="5"><option value="">请选择：</option></select></span>-->
	        </span>
                <#--<span class="error-msg" id="area_div_error"></span>
                <div class="ftx-03">标“*”的为支持货到付款的地区，<a href="javascript:void(0)" target="_Blank" class="ftx-05" id="codHelpUrl">查看货到付款地区</a></div>-->
                </div>
            </div>
            <div class="item clearfix">
                <span class="label" id="address_div"><span style="color:red">*</span>&nbsp;详细地址：</span>

                <div class="fl">
                    <!--span id="areaNameTxt"></span-->
                    <input type="text" class="itxt itxt02 save_add_detail" name="addressDetail" id="addressDetail"
                           onblur="checkAddressDetail();" maxlength="40" onblur="check_Consignee('address_div')"
                           value="" tabindex="6">
                    <span class="error-msg addressDetailTip" id="addressDetail_tips"></span>
                </div>
            </div>
            <div class="item clearfix" id="call_div">
                <span class="label"><span style="color:red">*</span>&nbsp;手机号码：</span>

                <div class="fl">
                    <input type="text" class="itxt save_add_mobile" onblur="checkAddressMobile();" name="addressMoblie"
                           onblur="check_Consignee('call_mobile_div')" onfocus="if(value == defaultValue){value='';}"
                           maxlength="11" value="" tabindex="7" id="addressMoblie">
                </div>
                <div class="fl">
                    <span class="label">固定电话：</span>
                    <input type="text" class="itxt save_add_phone" onblur="checkAddressPhone();" size="30"
                           name="addressPhone" id="addressPhone" onblur="check_Consignee('call_phone_div')"
                           onfocus="if(value == defaultValue){value='';}" maxlength="20" value="" tabindex="8">
                </div>
                <span class="error-msg addressMoblieTip" id="addressMoblie_tips"></span>
                <span class="error-msg addressPhoneTip" id="addressPhone_tips"></span>
            </div>
        <#--<div class="item clearfix" id="email_div">
            <span class="label">邮箱：</span>
            <div class="fl">
                <input type="text" class="itxt save_add_email" name="addressEmail" onblur="" maxlength="50" onblur="check_Consignee('email_div')" value="" onfocus="if(value == defaultValue){value='';}" tabindex="9">
                <span class="error-msg addressEmailTip" id="email_div_error"></span>
                <div class="ftx-03">用来接收订单提醒邮件，便于您及时了解订单状态</div>
            </div>
        </div>
        <input class="text" name="addressAlias" id="addressAlias" type="text" placeholder="家/公司/...">
        <span class="red" id="addressAlias_tips"></span>
        -->
            <div class="item clearfix" id="addressZip_div">
                <span class="label">邮政编码：</span>

                <div class="fl">
                    <input type="text" class="itxt save_add_post" name="addressZip" maxlength="50" id="addressZip"
                           onblur="checkAddressPost();" value="" onfocus="if(value == defaultValue){value='';}"
                           tabindex="9">
                    <span class="error-msg addPostTips" id="addressZip_tips"></span>
                </div>
            </div>
            <div class="item clearfix">
                <span class="label">&nbsp;</span>

                <div class="fl">
                    <a href="javascript:void(0)" class="btn-9 save_address"><span
                            id="saveConsigneeTitleDiv">保存收货人信息</span></a>

                    <div class="loading loading-1" style="display:none"><b></b>正在提交信息，请等待！</div>
                    <!--a href="#none" class="btn-9 ml10">取消</a-->
                </div>
                <div style="display:none"><input id="consignee_form_reset" name="" type="reset"></div>
            </div>
        </div>
    </div>
    </form>
</div>

<div class="member-dialog dia1">
    <div class="member-dialog-body">
        <div class="title"><a href="javascript:;" onclick="cls()">×</a></div>
        <img src="${basePath}/images/btn_tips@2x.png" alt="" style="width: 45px;height: 45px;margin: 0 auto; margin-top:13px;display: block;">

        <div class="tc">
            <div class="que-delete clearfix">
                <div class="fl tl">
                    <p class="f16 new_p">确定设置为默认吗?</p>
                    <div class="m-btn">
                        <a class="info_tip_submit" href="javascript:;" onclick="cls()">取消</a>
                        <a class="info_tip_cancel bnt_ok" href="javascript:;" >确定</a>

                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
<div class="member-dialog dia4">
    <div class="member-dialog-body">
        <div class="title"><a href="javascript:;" onclick="cls()">×</a></div>
        <img src="${basePath}/images/btn_waringcopy@2x.png" alt="" style="width: 45px;height: 45px;margin: 0 auto; margin-top:13px;display: block;">
        <div class="tc">
            <div class="que-delete clearfix">
                <div class="fl tl">
                    <p class="f16 new_p">您确定要删除此收货地址?</p>
                    <div class="m-btn">
                        <a  href="javascript:;" onclick="cls()">取消</a>
                        <a  id="delUrl" href="javascript:;" class="bnt_ok">确定</a>

                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
<div class="member-dialog dia3">
    <div class="member-dialog-body">
        <div class="title"><a href="javascript:;" onclick="cls()">×</a></div>
        <img src="${basePath}/images/btn_tips@2x.png" alt="" style="width: 45px;height: 45px;margin: 0 auto; margin-top:13px;display: block;">
        <div class="tc">
            <div class="que-delete clearfix">
                <div class="fl tl">
                    <p class="f16 new_p">您最多可创建10个收货地址！</p>
                    <div class="m-btn  ">
                        <a  href="javascript:;" onclick="cls()" class="bnt_ok">确定</a>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<div class="jd-dialog tip_dia dia6">
    <input type="hidden" id="addressflag">
    <div class="dia_tit clearfix">
        <h4 class="fl">提示</h4>
        <a class="dia_close fr" href="javascript:void(0)" onclick="cls()"></a>
    </div>
    <!--/dia_tit-->
    <div class="dia_tip">
        <div class="dia_intro no_tc pt30 pl30">
            <img class="vm mr10" id="f_img" alt="" src="${basePath}/images/mod_war.png"/>
            <span id="con_00">修改成功！</span>
        </div>
        <div class="dia_ops mt20 tc">
            <a class="go_pay" id="go_pay_00" href="javascript:cls();" style='margin:auto'>确定</a>
        </div>
        <!--/dia_ops-->
    </div>
    <!--/dia_cont-->
</div>
<#--引入底部 <#include "/index/bottom.ftl" /> -->
<#--shf-->
<#--<div class="footer_tab">-->
    <#--<ul>-->

        <#--<li class="list1"><a href="http://www.ge960.com/channel/237.html">食品荟萃</a></li>-->
        <#--<li class="list2"><a href="http://www.ge960.com/channel/239.html">饮品总汇</a></li>-->
        <#--<li class="list3"><a href="http://www.ge960.com/channel/241.html">购物中心</a></li>-->
        <#--<li class="list4"><a href="http://www.ge960.com/channel/243.html">大药房</a></li>-->

    <#--</ul>-->
<#--</div>-->
<#if (topmap.temp)??>
    <#if (topmap.temp.tempId==1)>
        <#include "../index/bottom.ftl">
    <#else>
        <#include "../index/newbottom.ftl" />
    </#if>
</#if>
<script type="text/javascript" src="${basePath}/js/jcarousellite_1.0.1.js"></script>
<script type="text/javascript" src="${basePath}/js/tab-switch.js"></script>
<script type="text/javascript" src="${basePath}/js/newapp.js"></script>
<script type="text/javascript" src="${basePath}/js/customer/findcode.js"></script>
<script type="text/javascript" src="${basePath}/js/customer/customaddress.js"></script>
<script type="text/javascript" src="${basePath}/js/jsOperation.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        /*var num=0;
        $("#submitBtn").click(function(){
            if(num==0){
                num+=1;
                $("#addressFrom").submit();
            }
        })
        $('.item_title').each(function(){
            $(this).click(function(){
                $(this).next().toggle('fast',function(){
                    if($(this).is(':visible')){
                        $(this).prev().removeClass('up');
                        $(this).prev().addClass('down');
                    }
                    else{
                        $(this).prev().removeClass('down');
                        $(this).prev().addClass('up');
                    }
                });
            });
        });
        $(".pro_sort").addClass("pro_sort_close");
        $(".new_member_left div:eq(3) ul li:eq(5)").addClass("cur");*/
        //弹窗
        win();
        $(window).resize(function(){
            win();
        });
    });
    //删除收货地址
    function deladdress(addressId){
        $("#delUrl").attr("href","${basePath}/customer/address/delete/"+addressId);
        dia(4);
    }

    //添加收货地址，文本框清空
    function toaddAddress(){

        var num = $("#addressesNum").text();
        if (num >= 10) {
            dia(3);
            return false;
        }

        $("#diaTitle").html("添加收货地址");
        $("#hiden_addressId").val("");
        $("#addressName").val("");
        $("#addressDetail").val("");
        $("#addressMoblie").val("");
        $("#addressPhone").val("");
        $("#addressZip").val("");
        $("#addressName_tips").text("").removeClass("tipserror");
        $("#addressDetail_tips").text("").removeClass("tipserror");
        $("#addressMoblie_tips").text("").removeClass("tipserror");
        $("#addressPhone_tips").text("").removeClass("tipserror");
        $("#addressZip_tips").text("").removeClass("tipserror");
        dia(2);
    }

    //判断是否达到数量上限
    function checkAddressesNum(){
        var num = $("#addressesNum").text();
        if(num>=10){
            cls();
            dia(3);
            return false;
        }else{
            return true;
        }
    }
    //验证特殊字符，将调试显示到页面中
    function checkSpecSymb(inputobj,Tipobj){
        var regexp=new RegExp("[`~!@#$^&*()={}':;',\\[\\]<>/?~！@#￥……&*（）{}【】‘；：”“'。，、？]");
        if (regexp.test( $("#"+inputobj).val() ) ) {
            $("#"+inputobj).addClass( "ui-state-error" );
            updateTips( "输入的内容包含特殊字符!", $("#"+Tipobj));
            $("#"+inputobj).focus();
            return false;
        }
        else {
            $("#"+Tipobj).text("").removeClass( "ui-state-highlight");
            $("#"+inputobj).removeClass( "ui-state-error" );
            return true;
        }
    }
    //特殊字符
    /*var regexp=new RegExp("[`~!@#$^&*()={}':;',\\[\\]<>/?~！@#￥……&*（）{}【】‘；：”“'。，、？]");
    //var regexpPhone = new RegExp("[\d{3}-\d{8}|\d{4}-\d{7,8}]");
    //var regexpMoblie = new RegExp("[1\d{10}]");
    function checkField(){
        var flag = true;
        if($("#addressName").val()==""){
            $("#addressName_tips").text("请填写收货人").addClass("tipserror");
            flag = flag && false;
        }else{
            if (regexp.test( $("#addressName").val() ) ) {
                $("#addressName_tips").text("输入的内容包含特殊字符!").addClass("tipserror");
                flag = flag && false;
            }else{
                $("#addressName_tips").text("").removeClass("tipserror");
                flag = flag && true;
            }
        }
        if($("#addressDetail").val()==""){
            $("#addressDetail_tips").text("请填写详细地址").addClass("tipserror");
            flag = flag && false;
        }else{
            if (regexp.test( $("#addressDetail").val() ) ) {
                $("#addressDetail_tips").text("输入的内容包含特殊字符!").addClass("tipserror");
                flag = flag && false;
            }else{
                $("#addressDetail_tips").text("").removeClass("tipserror");
                flag = flag && true;
            }
        }
        if($("#addressMoblie").val()==""){
            $("#addressMoblie_tips").text("请填写手机号码").addClass("tipserror");
            flag = flag && false;
        }else{
            if (/^1[3|4|5|7|8][0-9]\d{8}$/.test( $("#addressMoblie").val() ) ) {
                $("#addressMoblie_tips").text("").removeClass("tipserror");
                flag = flag && true;
            }else{
                $("#addressMoblie_tips").text("手机号码格式不对!").addClass("tipserror");
                flag = flag && false;
            }
        }
        if($("#addressPhone").val()!=""){
            if (/^((0[0-9]{2,3}\-)|(\(0[0-9]{2,3}\)))?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$/.test( $("#addressPhone").val() ) ) {
                $("#addressPhone_tips").text("").removeClass("tipserror");
                flag = flag && true;
            }else{
                $("#addressPhone_tips").text("固定电话格式不对!").addClass("tipserror");
                flag = flag && false;
            }
        }
        if($("#addressZip").val()!=""){
            if(/^[1-9]\d{5}(?!\d)$/.test($("#addressZip").val())){
                $("#addressZip_tips").text("").removeClass("tipserror");
                flag = flag && true;
            }else{
                $("#addressZip_tips").text("邮政编码格式不对!").addClass("tipserror");
                flag = flag && false;
            }
        }
        if($("#community_stores_select").val()==""){
            $("#community_div_error").text("请选择社区店").addClass("tipserror");
            flag = flag && false;
        }else {
            flag = flag && true;
        }
        return flag;
    }*/

    //判断是修改还是添加,设置提交的控制器方法
    /*function updateqqq(){
        if($("#hiden_addressId").val()!=""){
            $("#addressFrom").prop("action",$("#basePath").val()+"/customer/address/update");
            return checkField();
        }else{
            $("#addressFrom").prop("action",$("#basePath").val()+"/customer/address/add");
            if(checkAddressesNum()){
                checkField();
                if(checkField()){
                    $("#submitBtn").attr("disabled","disabled");
                }
                return checkField();
            }else{
                return false;
            }
        }

    }*/
    function win(){
        var _wd = $(window).width();
        var _hd = $(window).height();
        $(".member-dialog").css("top",(_hd - $(".member-dialog").height())/2).css("left",(_wd - $(".member-dialog").width())/2);
        $(".jd-dialog").css("top",(_hd - $(".jd-dialog").height())/2).css("left",(_wd - $(".jd-dialog").width())/2);
        $(".dialog").css("top",(_hd - $(".dialog").height())/2).css("left",(_wd - $(".dialog").width())/2);

    }
    function dia(n) {
        win();
        $(".mask").fadeIn();
        $(".dia"+n).fadeIn();
        center([".dia"+n]);
    }
    function cls() {
        $(".dialog").fadeOut();
        $(".member-dialog").fadeOut();
        $(".jd-dialog").fadeOut();
        $(".mask").fadeOut();
    }
    function center(selectors) {
        var _wd = $(window).width();
        var _hd = $(window).height();
        selectors.forEach(function (selector) {
            var $node = $(selector);
            $node.css("top", (_hd - $node.height()) / 2)
                    .css("left", (_wd - $node.width()) / 2);
        })
    }
        /*点击保存收货地址的时候*/
   $(".save_address").click(function(){
        //获取所有的收货地址选项
        var addressName=$(".save_add_name");
        var infoProvince=$("#infoProvince");
        var infoCity=$("#infoCity");
        var infoCounty=$("#infoCounty");
        var infoStreet=$("#infoStreet");
        var addressDetail=$(".save_add_detail");
        var addressMoblie=$(".save_add_mobile");
        var addressPhone=$(".save_add_phone");
//		var addressEmail=$(".save_add_email");
        var addressZip=$(".save_add_post");
        /*拼接参数*/
        var params="";
        var bool=true;
        if($("#addressType1").attr("checked")) {
            if($("#community_stores_select").val()=='') {
                $(".communityTips").text("请选择社区店").addClass("tipserror");
                $(".communityTips").text("请选择社区店").removeClass("error-msg");
                bool=false;
            } else {
                $(".communityTips").text("").removeClass("tipserror");
                $(".communityTips").text("").addClass("error-msg");
                params+='communityStoreId='+$("#community_stores_select").val();
            }
        }
        /*判断参数不为空就拼接参数*/
        if($(addressName).val()!=null &&$.trim($(addressName).val())!=""){
            var regexp=new RegExp("[`~!@#$^&*()={}':;',\\[\\]<>/?~！@#￥……&*（）{}【】‘；：”“'。，、？]");
            if (regexp.test($(addressName).val()) ) {
                $(".addressNameTip").text("存在特殊字符").addClass("tipserror");
                $(".addressNameTip").text("存在特殊字符").removeClass("error-msg");
                return false;
            }
            $("addressNameTip").text("").removeClass("tipserror");
            params+="&addressName="+$(addressName).val();
        }else{
            $(".addressNameTip").text("收货人名称不能为空!").addClass("tipserror");
            $(".addressNameTip").text("收货人名称不能为空!").removeClass("error-msg");
            bool=false;
            return;
        }


        if($(infoProvince).val()!="" && $(infoProvince).val()!=null){
            params+="&infoProvince="+$(infoProvince).val();
        }
        if($(infoCity).val()!="" && $(infoCity).val()!=null){
            params+="&infoCity="+$(infoCity).val();
        }
        if($(infoCounty).val()!="" && $(infoCounty).val()!=null){
            params+="&infoCounty="+$(infoCounty).val();
        }
        if($(infoStreet).val()!="" && $(infoStreet).val()!=null){
            params+="&infoStreet="+$(infoStreet).val();
        }

        if($(addressDetail).val()!=null && $.trim($(addressDetail).val())!=""){
            var regexp=new RegExp("[`~!@#$^&*()={}':;',\\[\\]<>/?~！@#￥……&*（）{}【】‘；：”“'。，、？]");
            if (regexp.test(addressDetail.val() ) ) {
                $(".addressDetailTip").text("包含特殊字符!").addClass("tipserror");
                $(".addressDetailTip").text("包含特殊字符!").removeClass("error-msg");
                return false;
            }
            $(".addressDetailTip").text("").removeClass("tipserror");
            $(".addressDetailTip").text("").addClass("error-msg");
            params+="&addressDetail="+$(addressDetail).val();
        }else{
            $(".addressDetailTip").text("详细地址不能为空!").addClass("tipserror");
            $(".addressDetailTip").text("详细地址不能为空!").removeClass("error-msg");
            bool=false;
            return;
        }
        if($(addressMoblie).val()!="" && $(addressMoblie).val()!=null){
            if (/^0?(13|15|18|14|17)[0-9]{9}$/.test( $(addressMoblie).val() ) ) {

                $(".addressMoblieTip").text("").removeClass("tipserror");
                $(".addressMoblieTip").text("").addClass("error-msg");
                params+="&addressMoblie="+$(addressMoblie).val();
            }else{
                $(".addressMoblieTip").text("手机号码格式不对!").addClass("tipserror");
                $(".addressMoblieTip").text("手机号码格式不对!").removeClass("error-msg");
                return;
            }
        }else{
            $(".addressMoblieTip").text("手机号码不能为空!").addClass("tipserror");
            $(".addressMoblieTip").text("手机号码不能为空!").removeClass("error-msg");
            bool=false;
            return;
        }

        //判断临时用户的手机是否已经存在
        var conditions="mobel="+addressMoblie.val();
        $.ajax({
            type: "POST",
            url: "../isshowmobelexist.htm",
            data: conditions,
            async: false,
            success: function(msg){
                if(msg=="1"){
                    bool=false;
                    $(".addressMoblieTip").html("手机号码已存在,请更换号码，或者<a href='../login.html'>登陆 </a>").addClass("tipserror");
                    $(".addressMoblieTip").html("手机号码已存在,请更换号码，或者<a href='../login.html'>登陆 </a>").removeClass("error-msg");
                }
            }
        });
        //判断临时用户的手机是否已经存在end

        if( $(addressPhone).val() !="" && $(addressPhone).val() !=null){
            if (/^((0[0-9]{2,3}\-)|(\(0[0-9]{2,3}\)))?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$/.test( $(addressPhone).val() ) ) {
                if($(addressPhone).val()!="" && $(addressPhone).val()!=null){
                    $(".addressPhoneTip").text("").removeClass("tipserror");
                    $(".addressPhoneTip").text("").addClass("error-msg");
                    params+="&addressPhone="+$(addressPhone).val();
                }
            }else{
                $(".addressPhoneTip").text("电话格式不正确!").addClass("tipserror");
                $(".addressPhoneTip").text("电话格式不正确!").removeClass("error-msg");
                bool=false;
            }
        }
		/*if($(".save_add_email").val() != "" && $(".save_add_email").val()!=null){
			if(/^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$/.test($(".save_add_email").val())){
				$(".addressEmailTip").text("").removeClass("tipserror");
				$(".addressEmailTip").text("").addClass("error-msg");
				params+="&addressEmail="+$(addressEmail).val();
			}else{
				$(".addressEmailTip").text("邮箱格式不正确!").addClass("tipserror");
				$(".addressEmailTip").text("邮箱格式不正确!").removeClass("error-msg");
				bool=false;
			}
		}*/

        //判断邮政编码格式
        if($(".save_add_post").val() != "" && $(".save_add_post").val()!=null){
            if(/^\d{6}$/.test($(".save_add_post").val())){
                $(".addPostTips").text("").removeClass("tipserror");
                $(".addPostTips").text("").addClass("error-msg");
                params+="&addressZip="+$(addressZip).val();
            }else{
                $(".addPostTips").text("邮政编码格式不正确").addClass("tipserror");
                $(".addPostTips").text("邮政编码格式不正确").removeClass("error-msg");
                bool=false;
            }
        }

        params+='&addressType='+$("input[name='addressType']:checked").val();
        /*end*/
        if(bool){
            if($("#hiden_addressId").val()>0){
                params+="&addressId="+$("#hiden_addressId").val();
                if($(".save_add_post").val()==""){
                    params+="&addressZip=";
                }
                $.ajax({
                    type: 'post',
                    url:'../goods/modiCustAddress.html?CSRFToken='+$("#CSRFToken").val(),
                    data: encodeURI(params),
                    async:false,
                    success: function(data) {
                        if(data){
                            location.href = "/customer/address.html";
                        }else{
                            $("#con_00").html("更新地址失败!");
                            dia(6);
                        }
                    }
                });
            }else{
                if(checkAddressesNum()){
                    $.ajax({
                        type: 'post',
                        url:'../goods/ajaxAddCustomerAddressFromOrder.html?CSRFToken='+$("#CSRFToken").val(),
                        data:encodeURI(params),
                        async:false,
                        success: function(data) {
                            if(data){
                                location.href = "/customer/address.html";
                            }else{
                                $("#con_00").html("新增地址失败!");
                                dia(6);
                            }
                        }
                    });
                }
            }
        }
    })
    //重置添加地址的表单
    function setDefaultForm(){
        $(".save_add_name").val("");
        $(".save_add_detail").val("");
        $(".save_add_mobile").val("");
        $(".save_add_phone").val("");
        $(".save_add_post").val("");
        //$(".save_add_email").val("");
        $(".addressNameTip").text("");
        $(".addressDetailTip").text("");
        $(".addressMoblieTip").text("");
        $(".addressPhoneTip").text("");
        $(".addressZip_tips").text("");
        //$(".addressEmailTip").text("");
        loadProvice();
    }
    //验证添加收货地址的姓名
    function checkAddressName(){
        var addressName=$(".save_add_name");
        /*判断参数不为空就拼接参数*/
        if($(addressName).val()!=""){
            $(".addressNameTip").text("").removeClass("tipserror");
            $(".addressNameTip").text("").addClass("error-msg");
        }else{
            $(".addressNameTip").text("收货人名称不能为空!").addClass("tipserror");
            $(".addressNameTip").text("收货人名称不能为空!").removeClass("error-msg");
        }
    }
    //验证社区店
    function checkCommunityStore() {
        if($("#addressType1").attr("checked")) {
            if($("#community_stores_select").val()=='') {
                $(".communityTips").text("请选择社区店").addClass("tipserror");
                $(".communityTips").text("请选择社区店").removeClass("error-msg");
            } else {
                $(".communityTips").text("").removeClass("tipserror");
                $(".communityTips").text("").addClass("error-msg");
            }
        }
    }
    //详细地址
    function checkAddressDetail(){
        var addressDetail=$(".save_add_detail");

        if($(addressDetail).val()!=""){
            var regexp=new RegExp("[`~!@#$^&*()={}':;',\\[\\]<>/?~！@#￥……&*（）{}【】‘；：”“'。，、？]");
            if (regexp.test(addressDetail.val() ) ) {
                $(".addressDetailTip").text("包含特殊字符!").addClass("tipserror");
                $(".addressDetailTip").text("包含特殊字符!").removeClass("error-msg");
                return false;
            }
            $(".addressDetailTip").text("").removeClass("tipserror");
            $(".addressDetailTip").text("").addClass("error-msg");
        }else{
            $(".addressDetailTip").text("详细地址不能为空!").addClass("tipserror");
            $(".addressDetailTip").text("详细地址不能为空!").removeClass("error-msg");
        }

    }

    //手机号码
    function checkAddressMobile(){
        var addressMoblie=$(".save_add_mobile");
        if($(addressMoblie).val()!=""){
            if (/^0?(13|15|18|14|17)[0-9]{9}$/.test( $(addressMoblie).val() ) ) {
                $(".addressMoblieTip").text("").removeClass("tipserror");
                $(".addressMoblieTip").text("").addClass("error-msg");
            }else{
                $(".addressMoblieTip").text("手机号码格式不对!").addClass("tipserror");
                $(".addressMoblieTip").text("手机号码格式不对!").removeClass("error-msg");
                return;
            }
        }else{
            $(".addressMoblieTip").text("手机号码不能为空!").addClass("tipserror");
            $(".addressMoblieTip").text("手机号码不能为空!").removeClass("error-msg");
            return;

        }
        //判断临时用户的手机是否已经存在
        var conditions="mobel="+addressMoblie.val();
        $.ajax({
            type: "POST",
            url: "../isshowmobelexist.htm",
            data: conditions,
            success: function(msg){
                if(msg=="1"){
                    $(".addressMoblieTip").html("手机号码已存在,请更换号码，或者<a href='../login.html'>登陆 </a>").addClass("tipserror");
                    $(".addressMoblieTip").html("手机号码已存在,请更换号码，或者<a href='../login.html'>登陆 </a>").removeClass("error-msg");
                }

            }
        });
        //判断临时用户的手机是否已经存在end
    }
    //固定电话
    function checkAddressPhone(){
        var addressPhone=$(".save_add_phone");
        if( $(addressPhone).val() !=""){
            if (/^((0[0-9]{2,3}\-)|(\(0[0-9]{2,3}\)))?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$/.test( $(addressPhone).val() ) ) {
                if($(addressPhone).val()!=""){
                    $(".addressPhoneTip").text("").removeClass("tipserror");
                    $(".addressPhoneTip").text("").addClass("error-msg");
                }
            }else{
                $(".addressPhoneTip").text("电话格式不正确!").addClass("tipserror");
                $(".addressPhoneTip").text("电话格式不正确!").removeClass("error-msg");
            }
        }
    }

    //邮箱
    /*function checkAddressEmail(){
        if($(".save_add_email").val() != "" && $(".save_add_email").val()!=null){
            if(/^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$/.test($(".addEmailTips").val())){
                $(".addEmailTips").text("").removeClass("tipserror");
                $(".addEmailTips").text("").addClass("error-msg");
                params+="&addressEmail="+$(addressZip).val();
            }else{
                $(".addEmailTips").text("邮箱格式不正确!").addClass("tipserror");
                $(".addEmailTips").text("邮箱格式不正确!").removeClass("error-msg");
            }
        }
    }*/

    //邮政编码
    function checkAddressPost(){
        var addressZip=$(".save_add_post");
        if($(addressZip).val() != "" && $(addressZip).val()!=null){
            if(/^\d{6}$/.test($(addressZip).val())){
                $(".addPostTips").text("").removeClass("tipserror");
                $(".addPostTips").text("").addClass("error-msg");;
            }else{
                $(".addPostTips").text("邮政编码格式不正确").addClass("tipserror");
                $(".addPostTips").text("邮政编码格式不正确").removeClass("error-msg");
            }
        }
    }

</script>
</body>
</html>
