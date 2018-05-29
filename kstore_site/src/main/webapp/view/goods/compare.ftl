<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>对比页-${topmap.systembase.bsetName}</title>
<meta name="description" content="${topmap.seo.meteDes}">
<meta name="Keywords" content="${topmap.seo.meteKey}">
<#assign basePath=request.contextPath>
<base href="${basePath}/">
<link rel="stylesheet" type="text/css" href="${basePath}/css/base.min.css" />
<link rel="stylesheet" type="text/css" href="${basePath}/css/compore.css" />
<#if (topmap.systembase.bsetHotline)??>
	<link rel = "Shortcut Icon" href="${(topmap.systembase.bsetHotline)!''}">
<#else>
	<link rel = "Shortcut Icon" href="${basePath}/images/Paistore.ico">
</#if>
</head>
<style>
    .good-operation a {
        display: inline-block;
        zoom: 1;
        height: 36px;
        line-height: 36px;
        border: 1px solid #31A420;
        padding: 0 10px;
        font-size: 14px;
        color: #FFFFFF;
        letter-spacing: 2px;
        background: #31A420;
        border-radius: 4px;
    }
</style>
<body>
<div>
	<#--一引入头部 <#include "/index/topnew.ftl" /> -->
		<#if (topmap.temp)??>
			<#if (topmap.temp.tempId==1)>
				<#include "../index/topnew.ftl">
			<#elseif (topmap.temp.tempId==3)>
				<#include "../index/newheader.ftl">
			<#elseif (topmap.temp.tempId==9)>
				<#include "../index/newheader4.ftl">
			<#elseif (topmap.temp.tempId==10)>
				<#include "../index/newheader5.ftl">
			<#elseif (topmap.temp.tempId==11)>
				<#include "../index/newheader6.ftl">
			<#elseif (topmap.temp.tempId==12)>
				<#include "../index/newheader7.ftl">
			<#elseif (topmap.temp.tempId==13)>
				<#include "../index/newheader8s.ftl">
			<#elseif (topmap.temp.tempId==14)>
				<#include "../index/newheader9.ftl">
			<#elseif (topmap.temp.tempId==15)>
				<#include "../index/newheader10.ftl">
			<#elseif (topmap.temp.tempId==16)>
				<#include "../index/newheader11.ftl">
			<#elseif (topmap.temp.tempId==17)>
				<#include "../index/newheader12.ftl">
			<#elseif (topmap.temp.tempId==18)>
				<#include "../index/newheader13.ftl">
			<#elseif (topmap.temp.tempId==19)>
				<#include "../index/newheader14.ftl">
            <#elseif (topmap.temp.tempId==20)>
                <#include "../index/newheader15.ftl">
			<#elseif (topmap.temp.tempId==21)>
				<#include "../index/newheader21.ftl">
			<#else>
				<#include "../index/newheader3.ftl">
			</#if>
		</#if>


<#list map.list as detail>
	<#if detail_index==0>
		<#assign goods0 = detail>
	</#if>
	<#if detail_index==1>
		<#assign goods1 = detail>
	</#if>
	<#if detail_index==2>
		<#assign goods2 = detail>
	</#if>
	<#if detail_index==3>
		<#assign goods3 = detail>
	</#if>
</#list>
</div>
<div class="compare_details w1200 mt20 mb20" style="margin-top: 40px;">
	<div class="basic_compare">
    <#--	<h2>基本信息对比</h2>-->
        <table width="100%">
			<tr>
                <th>商品名称</th>
				<td><a style="color: #000000;" href="${basePath}/item/${goods0.productVo.goodsInfoId!''}.html" target="_blank">${goods0.productVo.productName!''}</a></td>
                <td><a style="color: #000000;" href="${basePath}/item/${goods1.productVo.goodsInfoId!''}.html" target="_blank">${goods1.productVo.productName!''}</a></td>
				<#if goods2??>
					<td>
                        <a style="color: #000000;" href="${basePath}/item/${goods2.productVo.goodsInfoId!''}.html" target="_blank">
						${goods2.productVo.productName!''}
						</a>
					</td>
				<#else>
					<td style="font-weight: normal">--</td>
				</#if>
				<#if goods3??>
					<td >
                        <a style="color: #000000;" href="${basePath}/item/${goods3.productVo.goodsInfoId!''}.html" target="_blank">
						${goods3.productVo.productName!''}
						</a>
					</td>
				<#else>
					<td style="font-weight: normal">--</td>
				</#if>
			</tr>
        	<tr>
            	<th>商品图片</th>
                <td style="vertical-align: top;">
                	<a href="${basePath}/item/${goods0.productVo.goodsInfoId!''}.html" target="_blank">
                    	<img alt="" width="226" height="226"  src="<#if goods0.productVo.imageList?size gt 0>${goods0.productVo.imageList[0].imageBigName!'${basePath}/images/blank.gif'}<#else>${basePath}/images/blank.gif</#if>" />

                    </a>
                </td>
                <td style="vertical-align: top;">
                	<a href="${basePath}/item/${goods1.productVo.goodsInfoId!''}.html" target="_blank">
                    	<img alt="" width="226" height="226"  src="<#if goods1.productVo.imageList?size gt 0>${goods1.productVo.imageList[0].imageBigName!'${basePath}/images/blank.gif'}<#else>${basePath}/images/blank.gif</#if>" />

                    </a>
                </td>
                <#if goods2??>

	                 <td style="vertical-align: top;">
	                	<a href="${basePath}/item/${goods2.productVo.goodsInfoId!''}.html" target="_blank">
	                    	<img alt="" width="226" height="226" src="<#if goods2.productVo.imageList?size gt 0>${goods2.productVo.imageList[0].imageBigName!'${basePath}/images/blank.gif'}<#else>${basePath}/images/blank.gif</#if>" />

	                    </a>
	                </td>
                <#else>
                    <td>--</td>
                </#if>
                 <#if goods3??>
                 <td style="vertical-align: top;">
                	<a href="${basePath}/item/${goods3.productVo.goodsInfoId!''}.html" target="_blank">
                    	<img alt=""  width="226" height="226" src="<#if goods3.productVo.imageList?size gt 0>${goods3.productVo.imageList[0].imageBigName!'${basePath}/images/blank.gif'}<#else>${basePath}/images/blank.gif</#if>" />

                    </a>
                </td>
                <#else>
                    <td>--</td>
                </#if>
            </tr>
            <tr>
            	<th>商品价格</th>
                <td ><#--设置该商品的库存-->
				<#assign stock=0>
				<#if goods0.productVo.productWares??&&goods0.productVo.productWares?size &gt;0>
					<#list goods0.productVo.productWares as ware>
						<#assign stock=stock + ware.wareStock>
					</#list>
				</#if>
                	<span class="red fb f14 yanse"><span style="font-family:Arial;">¥</span>${goods0.productVo.goodsInfoPreferPrice?string('0.00')}</span>
                	<div class="good-operation"><a class="add_shop_cart" product_id="${goods0.productVo.goodsInfoId}" product_stock="${stock}" distinct_id="${distinctId!'3'}"  href="javascript:;">加入购物车</a></div>
                </td>
                <td><#--设置该商品的库存-->
				<#assign stock=0>
				<#if goods1.productVo.productWares??&&goods1.productVo.productWares?size &gt;0>
					<#list goods1.productVo.productWares as ware>
						<#assign stock=stock + ware.wareStock>
					</#list>
				</#if>
                	<span class="red fb f14 yanse"><span style="font-family:Arial;">¥</span>${goods1.productVo.goodsInfoPreferPrice?string('0.00')}</span>
                	<div class="good-operation"><a class="add_shop_cart" product_id="${goods1.productVo.goodsInfoId}" product_stock="${stock}" distinct_id="${distinctId!'3'}"  href="javascript:;">加入购物车</a></div>
                </td>
               <#if goods2??>
                 <td>
				 <#--设置该商品的库存-->
					 <#assign stock=0>
					 <#if goods2.productVo.productWares??&&goods2.productVo.productWares?size &gt;0>
						 <#list goods2.productVo.productWares as ware>
							 <#assign stock=stock + ware.wareStock>
						 </#list>
					 </#if>
                	<span class="red fb f14 yanse"><span style="font-family:Arial;">¥</span>${goods2.productVo.goodsInfoPreferPrice?string('0.00')}</span>
                	<div class="good-operation"><a class="add_shop_cart" product_id="${goods2.productVo.goodsInfoId}" product_stock="${stock}" distinct_id="${distinctId!'3'}"  href="javascript:;">加入购物车</a></div>
                </td>
                <#else>
                <td>--</td>
                </#if>
                <#if goods3??>
                 <td>
				 <#--设置该商品的库存-->
					 <#assign stock=0>
					 <#if goods3.productVo.productWares??&&goods3.productVo.productWares?size &gt;0>
						 <#list goods3.productVo.productWares as ware>
							 <#assign stock=stock + ware.wareStock>
						 </#list>
					 </#if>
                	<span class="red fb f14 yanse"><span style="font-family:Arial;">¥</span>${goods3.productVo.goodsInfoPreferPrice?string('0.00')}</span>
                	<div class="good-operation"><a class="add_shop_cart" product_id="${goods3.productVo.goodsInfoId}" product_stock="${stock}" distinct_id="${distinctId!'3'}" href="javascript:;">加入购物车</a></div>
                </td>
                <#else>
                <td>--</td>
                </#if>
            </tr>
            <tr>
                <th>品牌</th>
                <td>
                    <input type="hidden"  id="brand1" value="${goods0.brand.brandUrl!''}" />
					<span >${goods0.brand.brandName!''}</span>
                    <#--<a class="blue" >${goods0.brand.brandName!''}</a>-->
                </td>
            <#--品牌路径跳转-->
                <td>
                    <input type="hidden"  id="brand2" value="${goods1.brand.brandUrl!''}" />
                    <span >${goods1.brand.brandName!''}</span>
                </td>
            <#if goods2??>
                <td>
                    <input type="hidden"  id="brand3" value="${goods2.brand.brandUrl!''}" />
                    <span >${goods2.brand.brandName!''}</span>
                </td>
            <#else>
                <td>--</td>
            </#if>
            <#if goods3??>
                <td>
                    <input type="hidden"  id="brand4" value="${goods3.brand.brandUrl!''}" />
                    <span <#--class="blue"-->>${goods3.brand.brandName!''}</span>
                </td>
            <#else>
                <td>--</td>
            </#if>
            </tr>
			<#list goods0.productVo.specVo as spec>
				<#if spec.spec.specName=="规格">
					<tr>
						<th>${spec.spec.specName}</th>
						<td>${spec.specValueRemark}</td>
						<#if goods1?? && goods1.productVo.goods.typeId==goods0.productVo.goods.typeId>
							<td>
								<!--判断该商品有没有这个参数-->
								<#assign hasParam=false>
								<#list goods1.productVo.specVo as spec1>
									<#if spec1.spec.specName==spec.spec.specName>
										<#if spec1.specValueRemark==''>-<#else>${spec1.specValueRemark}</#if>
										<#assign hasParam=true>
									</#if>
								</#list>
								<!--没有这个参数，就用“--”代替-->
								<#if hasParam==false>--</#if>
							</td>
						<#else>
							<td>--</td>
						</#if>
						<#if goods2?? && goods2.productVo.goods.typeId==goods0.productVo.goods.typeId>
							<td>
								<!--判断该商品有没有这个参数-->
								<#assign hasParam=false>
								<#list goods2.productVo.specVo as spec2>
									<#if spec2.spec.specName==spec.spec.specName>
										<#if spec2.specValueRemark==''>-<#else>${spec2.specValueRemark}</#if>
										<#assign hasParam=true>
									</#if>
								</#list>
								<!--没有这个参数，就用“--”代替-->
								<#if hasParam==false>--</#if>
							</td>
						<#else>
							<td>--</td>
						</#if>
						<#if goods3?? && goods3.productVo.goods.typeId==goods0.productVo.goods.typeId>
							<td>
								<!--判断该商品有没有这个参数-->
								<#assign hasParam=false>
								<#list goods3.productVo.specVo as spec3>
									<#if spec3.spec.specName==spec.spec.specName>
										<#if spec3.specValueRemark==''>-<#else>${spec3.specValueRemark}</#if>
										<#assign hasParam=true>
									</#if>
								</#list>
								<!--没有这个参数，就用“--”代替-->
								<#if hasParam==false>--</#if>
							</td>
						<#else>
							<td>--</td>
						</#if>
					</tr>
				</#if>
			</#list>
			<#list goods0.expandPrams as expandPram>
				<#if expandPram.expandParamVo.expandparamName=="产地">
                <tr>
                    <th>${expandPram.expandParamVo.expandparamName}</th>
                    <td>${expandPram.expangparamValue.expandparamValueName}</td>
					<#if goods1?? && goods1.productVo.goods.typeId==goods0.productVo.goods.typeId>
                        <td>
                            <!--判断该商品有没有这个参数-->
							<#assign hasParam=false>
							<#list goods1.expandPrams as exp>
								<#if exp.expandParamVo.expandparamName==expandPram.expandParamVo.expandparamName>
									<#if exp.expangparamValue.expandparamValueName==''>-<#else>${exp.expangparamValue.expandparamValueName}</#if>
									<#assign hasParam=true>
								</#if>
							</#list>
                            <!--没有这个参数，就用“--”代替-->
							<#if hasParam==false>--</#if>
                        </td>
					<#else>
                        <td>--</td>
					</#if>
					<#if goods2?? && goods2.productVo.goods.typeId==goods0.productVo.goods.typeId>
                        <td>
                            <!--判断该商品有没有这个参数-->
							<#assign hasParam=false>
							<#list goods2.expandPrams as exp>
								<#if exp.expandParamVo.expandparamName==expandPram.expandParamVo.expandparamName>
									<#if exp.expangparamValue.expandparamValueName==''>-<#else>${exp.expangparamValue.expandparamValueName}</#if>
									<#assign hasParam=true>
								</#if>
							</#list>
                            <!--没有这个参数，就用“--”代替-->
							<#if hasParam==false>--</#if>
                        </td>
					<#else>
                        <td>--</td>
					</#if>
					<#if goods3?? && goods3.productVo.goods.typeId==goods0.productVo.goods.typeId>
                        <td>
                            <!--判断该商品有没有这个参数-->
							<#assign hasParam=false>
							<#list goods3.expandPrams as exp>
								<#if exp.expandParamVo.expandparamName==expandPram.expandParamVo.expandparamName>
									<#if exp.expangparamValue.expandparamValueName==''>-<#else>${exp.expangparamValue.expandparamValueName}</#if>
									<#assign hasParam=true>
								</#if>
							</#list>
                            <!--没有这个参数，就用“--”代替-->
							<#if hasParam==false>--</#if>
                        </td>
					<#else>
                        <td>--</td>
					</#if>
                </tr>
				</#if>
			</#list>
            <tr>
            	<tr>
            	<th>重量</th>
                <td>
                	${goods0.productVo.goodsInfoWeight/1000}kg
                </td>
                <#if goods1??>
                <td>
                	${goods1.productVo.goodsInfoWeight/1000}kg
                </td>
                </#if>
                <#if goods2??>
                 <td>
                	${goods2.productVo.goodsInfoWeight/1000}kg
                </td>
                <#else>
                <td>--</td>
                </#if>
                <#if goods3??>
                 <td>
                	${goods3.productVo.goodsInfoWeight/1000}kg
                </td>
                <#else>
                <td>--</td>
                </#if>
            </tr>
            <tr>
            	<tr>
            	<th>销售属性</th>
                <td>
					<#if goods0.productVo.productName?? && goods0.productVo.productName?index_of("零售")!=-1>零售
					<#elseif goods0.productVo.productName?? && goods0.productVo.productName?index_of("批发")!=-1>批发
					<#else>--</#if>
                </td>
				<td>
					<#if goods1.productVo.productName?? && goods1.productVo.productName?index_of("零售")!=-1>零售
					<#elseif goods1.productVo.productName?? && goods1.productVo.productName?index_of("批发")!=-1>批发
					<#else>--</#if>
				</td>
				<#if goods2??>
				<td>
					<#if goods2.productVo.productName?? && goods2.productVo.productName?index_of("零售")!=-1>零售
					<#elseif goods2.productVo.productName?? && goods2.productVo.productName?index_of("批发")!=-1>批发
					<#else>--</#if>
				</td>
				<#else>
				<td style="font-weight: normal">--</td>
				</#if>
				<#if goods3??>
				<td >
					<#if goods3.productVo.productName?? && goods3.productVo.productName?index_of("零售")!=-1>零售
					<#elseif goods3.productVo.productName?? && goods3.productVo.productName?index_of("批发")!=-1>批发
					<#else>--</#if>
				</td>
				<#else>
				<td style="font-weight: normal">--</td>
				</#if>
            </tr>
		<#list goods0.param as param>
			<#if param.param.paramName=="贮存条件" >
                <tr>
                    <th>${param.param.paramName}</th>
                    <td>${param.paramValue}</td>
					<#if goods1?? &&goods1.productVo.goods.typeId==goods0.productVo.goods.typeId>
                        <td>
                            <!--判断该商品有没有这个参数-->
							<#assign hasParam=false>
							<#list goods1.param as pa>
                                <!--有这个参数，就把对应的参数值取出来-->
								<#if pa.param.paramName==param.param.paramName>
									<#if pa.paramValue==''>-<#else>${pa.paramValue}</#if>
									<#assign hasParam=true>
								</#if>
							</#list>
                            <!--没有这个参数，就用“--”代替-->
							<#if hasParam==false>--</#if>
                        </td>
					<#else>
                        <td>--</td>
					</#if>
					<#if goods2?? &&goods2.productVo.goods.typeId==goods0.productVo.goods.typeId>
                        <td>
                            <!--判断该商品有没有这个参数-->
							<#assign hasParam=false>
							<#list goods2.param as pa>
                                <!--有这个参数，就把对应的参数值取出来-->
								<#if pa.param.paramName==param.param.paramName>
									<#if pa.paramValue==''>--<#else>${pa.paramValue}</#if>
									<#assign hasParam=true>
								</#if>
							</#list>
                            <!--没有这个参数，就用“--”代替-->
							<#if hasParam==false>--</#if>
                        </td>
					<#else>
                        <td>--</td>
					</#if>
					<#if goods3?? &&goods3.productVo.goods.typeId==goods0.productVo.goods.typeId>
                        <td>
                            <!--判断该商品有没有这个参数-->
							<#assign hasParam=false>
							<#list goods3.param as pa>
                                <!--有这个参数，就把对应的参数值取出来-->
								<#if pa.param.paramName==param.param.paramName>
									<#if pa.paramValue==''>--<#else>${pa.paramValue}</#if>
									<#assign hasParam=true>
								</#if>
							</#list>
                            <!--没有这个参数，就用“--”代替-->
							<#if hasParam==false>--</#if>
                        </td>
					<#else>
                        <td>--</td>
					</#if>
                </tr>
			</#if>
		</#list>
        </table>
    </div><!-- /basic_compare -->
    <div class="detail_compare">
    	<#--<table width="100%">
        	&lt;#&ndash;<thead>
            	<tr class="hover">
                	<th><span class="red f14">详细参数</span></th>
                    <td>
                    	<a class="blue" href="${basePath}/item/${goods0.productVo.goodsInfoId}.html" target="_blank">
                       ${goods0.productVo.productName}
                    	</a>
                    </td>
                    <td>
                    	<a class="blue" href="${basePath}/item/${goods1.productVo.goodsInfoId}.html" target="_blank">
                      ${goods1.productVo.productName}
                    	</a>
                    </td>
                    <#if goods2??>
	                 <td>
	                	<a class="blue" href="${basePath}/item/${goods2.productVo.goodsInfoId}.html" target="_blank">
	                    	${goods2.productVo.productName}
	                    </a>
	                </td>
	                <#else>
	                <td>--</td>
                	</#if>
                 <#if goods3??>
                 <td>
                	<a class="blue" href="${basePath}/item/${goods3.productVo.goodsInfoId}.html">
                    	${goods3.productVo.productName}
                    </a>
                </td>
                <#else>
                <td>--</td>
                </#if>
                </tr>
            </thead>&ndash;&gt;
            <tbody>
            <#list goods0.param as param>
			<#if param.param.paramName=="贮存条件" >
            	<tr>
                	<th>${param.param.paramName}</th>
                    <td>${param.paramValue}</td>
                    <#if goods1?? &&goods1.productVo.goods.typeId==goods0.productVo.goods.typeId>
                    <td>
                    	<!--判断该商品有没有这个参数&ndash;&gt;
                    	<#assign hasParam=false>
                    	<#list goods1.param as pa>
                    		<!--有这个参数，就把对应的参数值取出来&ndash;&gt;
                    		<#if pa.param.paramName==param.param.paramName>
                    			<#if pa.paramValue==''>-<#else>${pa.paramValue}</#if>
                    		<#assign hasParam=true>
                    		</#if>
                    	</#list>
                    	<!--没有这个参数，就用“--”代替&ndash;&gt;
                    	<#if hasParam==false>--</#if>
                    </td>
                    <#else>
	                <td>--</td>
	                </#if>
                    <#if goods2?? &&goods2.productVo.goods.typeId==goods0.productVo.goods.typeId>
                    <td>
                    	<!--判断该商品有没有这个参数&ndash;&gt;
                    	<#assign hasParam=false>
                    	<#list goods2.param as pa>
                    		<!--有这个参数，就把对应的参数值取出来&ndash;&gt;
                    		<#if pa.param.paramName==param.param.paramName>
                    		<#if pa.paramValue==''>-<#else>${pa.paramValue}</#if>
                    		<#assign hasParam=true>
                    		</#if>
                    	</#list>
                    	<!--没有这个参数，就用“--”代替&ndash;&gt;
                    	<#if hasParam==false>--</#if>
                    </td>
                    <#else>
	                <td>--</td>
	                </#if>
                    <#if goods3?? &&goods3.productVo.goods.typeId==goods0.productVo.goods.typeId>
                    <td>
                    	<!--判断该商品有没有这个参数&ndash;&gt;
                    	<#assign hasParam=false>
                    	<#list goods3.param as pa>
                    		<!--有这个参数，就把对应的参数值取出来&ndash;&gt;
                    		<#if pa.param.paramName==param.param.paramName>
                    		<#if pa.paramValue==''>-<#else>${pa.paramValue}</#if>
                    		<#assign hasParam=true>
                    		</#if>
                    	</#list>
                    	<!--没有这个参数，就用“--”代替&ndash;&gt;
                    	<#if hasParam==false>--</#if>
                    </td>
                    <#else>
	                <td>--</td>
	                </#if>
                </tr>
			</#if>
            </#list>
            </tbody>
        </table>-->
	<#--<table width="100%">
        <thead>
            <tr class="hover">
                <th><span class="red f14">扩展参数</span></th>
                <td>
                    <a class="blue" href="${basePath}/item/${goods0.productVo.goodsInfoId}.html" target="_blank">
                   ${goods0.productVo.productName}
                    </a>
                </td>
                <#if goods1??>
                <td>
                    <a class="blue" href="${basePath}/item/${goods1.productVo.goodsInfoId}.html" target="_blank">
                  ${goods1.productVo.productName}
                    </a>
                </td>
                <#else>
                <td>--</td>
                </#if>
                <#if goods2??>
                 <td>
                    <a class="blue" href="${basePath}/item/${goods2.productVo.goodsInfoId}.html" target="_blank">
                        ${goods2.productVo.productName}
                    </a>
                </td>
                <#else>
                <td>--</td>
                </#if>
                 <#if goods3??>
                 <td>
                    <a class="blue" href="${basePath}/item/${goods3.productVo.goodsInfoId}.html" target="_blank">
                        ${goods3.productVo.productName}
                    </a>
                </td>
                <#else>
                <td>--</td>
            </#if>
            </tr>
        </thead>
            <tbody>
            <#list goods0.expandPrams as expandPram>
            	<tr>
                	<th>${expandPram.expandParamVo.expandparamName}</th>
                    <td>${expandPram.expangparamValue.expandparamValueName}</td>
                    <#if goods1?? && goods1.productVo.goods.typeId==goods0.productVo.goods.typeId>
                    <td>
                    	<!--判断该商品有没有这个参数&ndash;&gt;
                    	<#assign hasParam=false>
                    	<#list goods1.expandPrams as exp>
                    		<#if exp.expandParamVo.expandparamName==expandPram.expandParamVo.expandparamName>
                    			<#if exp.expangparamValue.expandparamValueName==''>-<#else>${exp.expangparamValue.expandparamValueName}</#if>
                    			<#assign hasParam=true>
                    		</#if>
                    	</#list>
                    	<!--没有这个参数，就用“--”代替&ndash;&gt;
                    	<#if hasParam==false>--</#if>
                    </td>
                    <#else>
	                <td>--</td>
	                </#if>
                    <#if goods2?? && goods2.productVo.goods.typeId==goods0.productVo.goods.typeId>
                    <td>
                    	<!--判断该商品有没有这个参数&ndash;&gt;
                    	<#assign hasParam=false>
                    	<#list goods2.expandPrams as exp>
                    		<#if exp.expandParamVo.expandparamName==expandPram.expandParamVo.expandparamName>
                    			<#if exp.expangparamValue.expandparamValueName==''>-<#else>${exp.expangparamValue.expandparamValueName}</#if>
                    			<#assign hasParam=true>
                    		</#if>
                    	</#list>
                    	<!--没有这个参数，就用“--”代替&ndash;&gt;
                    	<#if hasParam==false>--</#if>
                    </td>
                    <#else>
	                <td>--</td>
	                </#if>
                    <#if goods3?? && goods3.productVo.goods.typeId==goods0.productVo.goods.typeId>
                    <td>
                    	<!--判断该商品有没有这个参数&ndash;&gt;
                    	<#assign hasParam=false>
                    	<#list goods3.expandPrams as exp>
                    		<#if exp.expandParamVo.expandparamName==expandPram.expandParamVo.expandparamName>
                    			<#if exp.expangparamValue.expandparamValueName==''>-<#else>${exp.expangparamValue.expandparamValueName}</#if>
                    			<#assign hasParam=true>
                    		</#if>
                    	</#list>
                    	<!--没有这个参数，就用“--”代替&ndash;&gt;
                    	<#if hasParam==false>--</#if>
                    </td>
                    <#else>
	                <td>--</td>
	                </#if>
                </tr>
            </#list>
            </tbody>
        </table>-->
    </div><!-- /detail_compare -->
</div><!-- /compare_details -->
<!--页脚-->
<#if (topmap.temp)??>
		<#if (topmap.temp.tempId==1)>
			<#include "../index/bottom.ftl">
		<#else>
		    <#include "../index/newbottom.ftl" />
		</#if>
		</#if>

		<!-- 提示框-->
	<#include "../infotips.ftl">

<script type="text/javascript" src="${basePath}/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${basePath}/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${basePath}/js/jquery.slides.min.js"></script>
<script type="text/javascript" src="${basePath}/js/jcarousellite_1.0.1.js"></script>
<script type="text/javascript" src="${basePath}/js/jquery.lazyload.min.js"></script>
<script type="text/javascript" src="${basePath}/js/index.js"></script>
    <script>
    	 /*加入购物车绑定事件*/
	$(".add_shop_cart").click(function(){
		if($(this).attr("product_stock")<=0){
			/*初始化弹框样式*/
			$(".info_tip_content2").html("库存不足！");
			$(".info_tip_img2").attr("src","images/outstock.png");
			$(".info_tip_cancel2").attr("href","javascript:;").hide();
			$(".info_tip_submit2").attr("href","javascript:;").show().html("确定").unbind("click");
			$(".info_tip_submit2").click(function(){
				cls();
			});
			dia(2);
			return 0;
		}
		var num = 1;
		var productId = $(this).attr("product_id");
		var params = "goodsNum="+num;
		params += "&productId="+productId;
		if($(this).attr("distinct_id")>0){
			params += "&distinctId="+$(this).attr("distinct_id");
		}
		/*请求加入购物车控制器*/
		$.get("goods/addProductToShopCar.html?"+params,function(data){
			if(data){
				/*初始化弹框样式*/
			/*	$(".info_tip_title").html("加入购物车");*/
				$(".info_tip_content").html("加入购物车成功！");
				$(".info_tip_img").attr("src","images/cart_img.png");
                //继续购物 重新调用购物车鼠标悬浮事件  实时刷新购物车商品
                $(".info_tip_cancel").attr("href","javascript:;").attr("onclick","minicartonload();").html("继续购物").show();
				$(".info_tip_submit").attr("href","myshoppingcart.html").html("立即结算").show().unbind("click");
				$(".info_tip_cancel").click(function(){
					cls();
				});
				dia(1);
			}else{
				/*初始化弹框样式*/
				/*$(".info_tip_title").html("加入购物车");*/
				$(".info_tip_content").html("购物车已满，无法加入购物车");
				$(".info_tip_img").attr("src","images/error.png");
				$(".info_tip_cancel").attr("href","javascript:;").hide();
				$(".info_tip_submit").attr("href","javascript:;").html("确定").show().unbind("click");
				$(".info_tip_submit").click(function(){
					cls();
				});
				dia(1);
			}
		});
	});
    </script>
</body>
</html>
