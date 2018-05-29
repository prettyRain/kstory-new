<#assign basePath=request.contextPath>
<style>
.divhide{
	 display: none;
}
/*搜索提示-liangck-20151127*/
.section-header .content .search{
    z-index: 999;
}

.ex_search ul {
    border-bottom: 1px solid #ddd;
}

.ex_search li {
    position: relative;
}

.ex_search li a {
    display: block;
    height: 25px;
    line-height: 25px;
    padding: 0 10px;
    color: #666;
}

.ex_search li:hover {
    background: #f2f2f2;
}

.ex_search li a span {
    color: #ccc;
    float: right;
}

.ex_search li .del_history {
    position: absolute;
    top: 0;
    right: 0;
    color: #369;
    display: none;
}

.ex_search p {
    height: 25px;
    line-height: 25px;
    padding: 0 10px;
}

.cur {background: #f2f2f2;}
</style>
	<div class="container">
    	<div class="header clearfix">
    		<div class="logo fl">
    			<a href="${topmap.systembase.bsetAddress}"><img src="${topmap.systembase.bsetLogo}" alt="" style="width:165px;height:70px;" /></a>
    			<a class="ml30" href="${basePath}/${(topmap.logoAdv.adverHref)!'#'}">
    				<img src="${(topmap.logoAdv.adverPath)!'${basePath}/index_two/images/hd_img.gif'}" alt="" 
    				width="150px" height="80px"/></a>
    		</div><!--/logo-->
			<div class="search_wp fl mt15 pr">
            	<div class="search_box clearfix">
            		<form id="topSearchForm" action = "${basePath}/goods/searchproduct2.html" method = "get">
            		<#if (keyWorlds)??>
	                	<input class="search_text fl c999" type="text" name="title" autocomplete="off" value="${(keyWorlds)!''}"/>
            		<#else>
            			<#if (topmap.hotsearch)?? && (topmap.hotsearch?size>0)>
	                	<input class="search_text fl c999" type="text" name="title" autocomplete="off" value="" placeholder="${(topmap.hotsearch[0].keyword)!''}"/>
                        <#else>
                            <input class="search_text fl c999" type="text" name="title" autocomplete="off" value=""/>
            			</#if>
            		</#if>
                	<input class="search_btn fl" type="button" onclick="checkSearch()" value="" />
            		</form>
                </div><!--/search_box-->
                <div class="hot_word mt10">
                	热门搜索：
                <#if (topmap.hotsearch)?? && (topmap.hotsearch?size>0)>
                    <#list topmap.hotsearch as hots>
                        <#if (hots_index==0)>
                            <#if (hots.keyword?length>7)>
                                <a class="hot" href="javascript:;" onclick="changeSearchKey(this);">${(hots.keyword)?substring(0,7)}</a>
                            <#else>
                                <a class="hot" href="javascript:;" onclick="changeSearchKey(this);">${(hots.keyword)!''}</a>
                            </#if>
                        </#if>
                    </#list>
                    <#list topmap.hotsearch as hots>
                        <#if (hots_index>=1) && (hots_index<=5)>
                            <#if (hots.keyword?length>7)>
                                <a href="javascript:;" onclick="changeSearchKey(this);">${(hots.keyword)?substring(0,7)}</a>
                            <#else>
                                <a href="javascript:;" onclick="changeSearchKey(this);">${(hots.keyword)!''}</a>
                            </#if>
                        </#if>
                    </#list>
                </#if>
                </div><!--/hot_word-->
                <div class="ex_search pa">
                    <ul id="searchList">
                    </ul>
                    <p class="tr"><a class="close_ex" href="javascript:;">关闭</a></p>
                </div><!--/ex_search-->
            </div><!--/search_wp-->
            <div class="shopping_cart fr mt20">
            	<dl class="pr" id="loadcart">
            		<dt class="pr" id="mminicart">
            			<span class="sc_num"><em>0</em></span>
                    	<a href="${basePath}/myshoppingcart.html" target="_blank">我的购物车</a>
            		</dt>
            		<dd>
            			<div class="cart_empty">
            				<!--<#if cust?? >
            				<p>您的购物车是空的<br /></p>
            				<#else>
            				<p>您的购物车是空的<br />如您已添加过商品，可<a href="${basePath}/login.html">登录</a>后查看</p>
            				</#if>-->
            				<p>您的购物车是空的<br />如您已添加过商品，可<a href="${basePath}/login.html">登录</a>后查看</p>
            			</div><!--/cart_empty-->
            			<div class="cart_cont none">
            				<div class="cart_tit clearfix mt5">
            					<#--
            					<label class="select_all fl ml10"><input class="vm mr5" type="checkbox" />全选，共1件商品</label>
            					<a class="cart_delete fr mr10" href="javascript:;">删除</a>
            					-->
            				</div><!--/cart_tit-->
            				<ul class="cart_list mt10">
            					<#--
            					<li class="clearfix">
									<input class="ct_check fl" type="checkbox" />
									<a class="ct_img fl ml5" href="javascript:;"><img alt="" src="${basePath}/index_two/images/images_01.jpg" /></a>
									<div class="ct_info fl ml10 mt15">
										<p class="ct_name"><a href="javascript:;">三星手机 I9500（皓月白）</a></p>
										<span class="ct_price"><b>¥</b>2878.00</span>
									</div>
									<div class="cart_cout clearfix pa">
										<a class="minus fl" href="javascript:;"></a>
										<input class="min_text fl" type="text" value="1" />
										<a class="plus fl" href="javascript:;"></a>
									</div>
									<div class="cout_text pa"></div>
									<a class="cart_del pa" href="javascript:;"></a>
            					</li>
            					-->
            				</ul><!--/cart_list-->
            				<div class="settle_accounts tr mt10">
            					<span class="mr10">共1件商品</span>
            					共计
            					<em><b>¥</b>2878.00</em>
            				</div><!--/settle_accounts-->
            				<div class="tr mt10 mb10"><a class="settle_btn" href="${basePath}/myshoppingcart.html" target="_blank">去购物车结算</a></div>
            			</div><!--/cart_cont-->
            		</dd>
            	</dl>
            </div><!--/shopping_cart-->
    	</div><!--/header-->
</div>
<div style="width:100%;height:38px;" id="navbg" class="">
<div class="container">
    	<div class="nav clearfix">
    		<input type="hidden" id="tempcbshowflag" value="${(topmap.temp.expFleid5)!''}">
    		<#if (topmap.temp.expFleid5)?? && (topmap.temp.expFleid5=='0')>
    		<div class="pro_sort fl pr divhide">
    		<#else>
    		<div class="pro_sort fl pr">
    		</#if>
			<#--
    		<div class="pro_sort fl pr ">
			-->
    			<h2><a href="javascript:;">全部商品分类</a><b></b></h2>
    			<div class="sort_cont pa none">
    				<#if (topmap.classifyBar.classifyBarList)?? && (topmap.classifyBar.classifyBarList?size>0)>
    				<#list topmap.classifyBar.classifyBarList as cBar>
    				<#if (cBar_index<12)>
    				<dl>
    					<dt>
    						<img class="vm" alt="" src="${cBar.imgSrc!''}" width="20px" height="20px"/>
    						<#if (cBar.barCate)?? && (cBar.barCate?size>0)>
    						<#list cBar.barCate as bcate>
    							<!--判断是否自定义分类导航-->
	    						<#if bcate.cateId==-1>
	    							<!--是否有自定义URL-->
	    							<#if bcate.temp2=="">
	    								<a href="javascript:;">${bcate.cateName}</a>
	    							<#else>
	    								<a href="${basePath}/${bcate.temp2!'0'}" target="_blank">${bcate.cateName}</a>
	    							</#if>
	    						<#elseif bcate.cateId??>
	    							<#--<a href="${basePath}/list/${bcate.temp1!'0'}-${bcate.cateId?c}.html">${bcate.cateName}</a>-->
                                    <a href="${basePath}/list/${bcate.cateId?c}-${bcate.cateId?c}.html" target="_blank">${bcate.cateName}</a>
	    						</#if>
    						</#list>
    						</#if>
    					</dt>
    					<dd>
    						<#if (cBar.barQuick)?? && (cBar.barQuick?size>0)>
    						<#list cBar.barQuick as bquick>
	    						<!--判断是否自定义分类导航-->
	    						<#if bquick.cateId==0>
	    							<!--是否有自定义URL-->
	    							<#if bquick.temp2=="">
	    								<a href="javascript:;">${bquick.cateName}</a>
	    							<#else>
	    								<a href="${basePath}/${bquick.temp2!'0'}" target="_blank">${bquick.cateName}</a>
	    							</#if>
	    						<#elseif bquick.cateId??>
	    							<#--${bquick.cateName}</a>-->
	    						</#if>
    						</#list>
    						</#if>
    					</dd>
    					<dd class="sort_line"></dd>
    				</dl>
    					<!--分类导航不足时，显示图片-->
    					<#if !(cBar_has_next)>
    						<#if (cBar_index)<11>
	    						<#if (topmap.classifyBar.indexAdvertList)?? && (topmap.classifyBar.indexAdvertList?size>0)>
			    					<#list topmap.classifyBar.indexAdvertList as adver>
			    					<#--取第一个广告-->
			    					<#if adver_index==0>
			    						<img alt="${adver.adverName}" src="${adver.adverPath}"  height="35px" width="100%"/>
			    					</#if>
			    					</#list>
			    				</#if>
		    				</#if>
	    				</#if>
    				</#if>
    				</#list>
    				</#if>
    			</div><!--/sort_cont-->
    			<div class="sort_open pa">
    				<#if (topmap.classifyBar.classifyBarList)?? && (topmap.classifyBar.classifyBarList?size>0)>
    				<#list topmap.classifyBar.classifyBarList as cBar>
                    <#if (cBar_index<12)>
                    <div class="ct_item clearfix">
        				<div class="sub_category clearfix fl">
                            <#if (cBar.childs)?? && (cBar.childs?size>0)>
                            <#assign cbtwoRows="${((cBar.childs?size)/2)?round}"/>
                            <div class="category_box fl">
                            	<#list cBar.childs as cbtwo>
                            	<#if (cbtwo_index < cbtwoRows?number)>
                            	<dl>
                                    <dt>
                                    	<!--判断是否自定义分类导航-->
                                    	<#if cbtwo.goodsCatId==-1>

                                    		<!--是否有自定义URL-->
			    							<#if !cbtwo.url?? || cbtwo.url=="">
			    								<a href="javascript:;" style="cursor:default;">${cbtwo.name}</a>
			    							<#else>
			    								<#--<a href="${basePath}/${cbtwo.url!'0'}">--><a href="javascript:void(0);"style="cursor:default;">${cbtwo.name}</a>
			    							</#if>
                                    	<#else>
                                            <a href="javascript:void(0)" style="cursor:default;">${cbtwo.name}</a>

										<#--<a href="${basePath}/list/${cbtwo.goodsCatId?c}-${cbtwo.temp3!'0'}.html">${cbtwo.name}</a>-->
                                    	</#if>
                                    <dt/>
                                    <dd>
	                            	<#if (cbtwo.childs)?? && (cbtwo.childs?size>0)>
	                            	<#list cbtwo.childs as cbthird>
	                            		<!--判断是否自定义分类导航-->
	                            		<#if cbthird.goodsCatId==-1>
                                    		<!--是否有自定义URL-->
			    							<#if cbthird.url=="">
			    								<a href="javascript:;">${cbthird.name}</a>
			    							<#else>
			    								<a href="${basePath}/${cbthird.url!'0'}">${cbthird.name}</a>
			    							</#if>
                                    	<#else>
                                    		<a href="${basePath}/list/${cbthird.goodsCatId?c}-${cbthird.temp3!'0'}.html">${cbthird.name}</a>
                                    	</#if>

	                            	</#list>
	                            	</#if>
                                    </dd>
                                </dl>
                            	</#if>
                            	</#list>
                            </div><!--/category_box-->
                            <div class="category_box fl">
                                <#list cBar.childs as cbtwo>
                            	<#if (cbtwo_index >= cbtwoRows?number)>
                            	<dl>
                                    <dt>
                                    	<#--<a href="${basePath}/list/${cbtwo.temp4!'0'}-${cbtwo.temp3!'0'}.html">${cbtwo.name}</a></dt>-->
                                   		 <!--判断是否自定义分类导航-->
                                   		 <#if cbtwo.goodsCatId==-1>
                                    		<!--是否有自定义URL-->
			    							<#if !cbtwo.url??|| cbtwo.url=="">
			    								<a href="javascript:;">${cbtwo.name}</a>
			    							<#else>
			    								<a href="${basePath}/${cbtwo.url!'0'}">${cbtwo.name}</a>
			    							</#if>
                                    	<#else>
                                    		<a href="${basePath}/list/${cbtwo.goodsCatId?c}-${cbtwo.temp3!'0'}.html">${cbtwo.name}</a>
                                    	</#if>
                                    </dt>
                                    <dd>
	                            	<#if (cbtwo.childs)?? && (cbtwo.childs?size>0)>
	                            	<#list cbtwo.childs as cbthird>
                                        <#--<a href="${basePath}/list/${cbthird.goodsCatId?c}-${cbthird.temp3!'0'}.html">${cbthird.name}</a>-->
                                       	<!--判断是否自定义分类导航-->
                                        <#if cbthird.goodsCatId==-1>
                                    		<!--是否有自定义URL-->
			    							<#if cbthird.url=="">
			    								<a href="javascript:;">${cbthird.name}</a>
			    							<#else>
			    								<a href="${basePath}/${cbthird.url!'0'}">${cbthird.name}</a>
			    							</#if>
                                    	<#else>
                                    		<a href="${basePath}/list/${cbthird.goodsCatId?c}-${cbthird.temp3!'0'}.html">${cbthird.name}</a>
                                    	</#if>
	                            	</#list>
	                            	</#if>
                                    </dd>
                                </dl>
                            	</#if>
                            	</#list>
                            </div><!--/category_box-->
                            </#if>
                        </div><!--/sub_category-->
                        <div class="sub_brands fl">
                            <dl>
                                <dt>推荐品牌</dt>
                                <dd>
                                	<#if (cBar.indexBrandList)?? && (cBar.indexBrandList?size>0)>
                                	<#list cBar.indexBrandList as cbBrand>
                                	<#if (cbBrand.sort>0) && (cbBrand.sort<7)>
	                                    <a href="${(cbBrand.url)!''}"><img alt="" src="${cbBrand.logoSrc}" width="90px" height="30px"/></a>
                                	</#if>
                                	</#list>
                                	</#if>
                                </dd>
                            </dl>
                            <#if (cBar.indexAdvertList)?? && (cBar.indexAdvertList?size>0)>
                            <div class="brand_img mt10">
                            <#list cBar.indexAdvertList as cbAdvert>
                            <#if (cbAdvert.adverSort==1)>
                            <a href="${cbAdvert.adverHref}"><img alt="" src="${cbAdvert.adverPath}" width="210px" height="330px"/></a>
                            </#if>
                            </#list>
                            </div>
                            </#if>
                        </div><!--/sub_brands-->
                    </div><!--/ct_item-->
                    </#if>
                    </#list>
                    </#if>
                    <a class="close_category pa" href="javascript:;"></a>
    			</div><!--/sort_open-->
    		</div><!--/pro_sort-->

    		<ul class="sort_list clearfix">
    			<#if (topmap.navList)?? && (topmap.navList?size>0)>
    			<#list topmap.navList as nav>
                <#if (nav_index < 8)>
    				<#if (nav.barName=="首页") || (nav.barUrl=="index.html")>
	    			<li class="cur"><a   onclick="clickNav('${(nav.barUrl)!''}','${nav_index+1}');" href="javascript:void(0);">${(nav.barName)!''}</a></li>
    				<#else>
    					<#if (nav.openChannel)?? && (nav.openChannel=='0')>
			    			<li  class=""><a   onclick="clickNav('${(nav.barUrl)!''}','${nav_index+1}')"  href="javascript:void(0);">${(nav.barName)!''}</a></li>
    					<#else>
			    			<li class=""><a onclick="clickNav('barchannelview/${(nav.barId?c)!''}','${nav_index+1}')"  href="javascript:void(0);">${(nav.barName)!''}</a></li>
    					</#if>
    				</#if>
                </#if>
    			</#list>
    			</#if>
    		</ul><!--/sort_list-->
    	</div><!--/nav-->
    </div>
    </div><!--/container-->
    <#--
	<div class="mask"></div>
    <div class="dialog dia9">
        <div class="dia_tit clearfix">
            <h4 class="fl collect_title">加入收藏</h4>
            <a class="dia_close fr" href="javascript:;" onclick="cls()"></a>
        </div>
        <div class="dia_cont">
            <div class="dia_collect_intro tc pt30"><img class="vm collect_img" alt="" src="" />
            <em class="collect_content">加入收藏失败，请使用菜单栏或Ctrl+D进行添加!</em></div>
            <div class="dia_ops mt20 tc">
                <a class="collect_ok collect_tip_cancel" href="javascript:;">确定</a>
            </div>
        </div>
    </div>
    -->

	<script type="text/javascript">
		<#--$(function(){-->
			<#--$.ajax({ url:"${basePath}/getnavsort.htm", async:false ,success: function(data){-->
					<#--$(".sort_list").find("li").each(function(){-->
		    		<#--$(this).removeClass("cur");-->
			    		<#--if($(this).index()+1==data){-->
			    			<#--$(this).addClass("cur");-->
			    		<#--}-->
		    		<#--});-->
			<#--}-->
			<#--});-->
		<#--});-->
	   function clickNav(url,sort){
			$.ajax({ url:"${basePath}/navsort.htm?navsort="+sort, async:false ,success: function(date){
				}
			});
			//window.location.href="${basePath}/"+url;
           if(url.indexOf("ttp://")!=-1){
               window.open(url);
           }else{
               window.open("${basePath}/"+url);
           }
		}
        //------------------搜索提示-liangck-20151127
        $(".search_text").bind('input propertychange', function () {
            $.getJSON("${basePath}/completionWords.htm?t="+new Date().getTime(), {keyWords: $.trim($(this).val())}, function (data) {
                if (data.length > 0) {
                    $(".ex_search ul").html("");
                    data.forEach(function(c){
                        $(".ex_search ul").append('<li class="search-item"><a href="javascript:;" class="completion-words">'+c.substring(0,46)+'</a><a class="del_history" href="javascript:;"style="display: none;">删除</a></li>');
                    });
                    $(".ex_search").show();
                }else {
                    $(".ex_search").hide();
                }
            });
        })
        ;
        $(".ex_search").on("click","ul li",function(){
            window.location.href="${basePath}/goods/searchproduct2.html?title="+$(this).find(".completion-words").html();
        });
        $(".close_ex").click(function () {
            $(".ex_search").hide();
            $(".search_text").blur();
        });
        var _n = $(".search-item").length - 1;
        $("body").keydown(function(event){
            if(event.keyCode == 38) {
                if($(".search-item.cur").length > 0) {
                    var _index = $(".search-item.cur").index();
                    $(".search-item:eq("+ (_index - 1) +")").addClass("cur").siblings(".cur").removeClass("cur");
                    $(".search_text").val($(".search-item.cur").find(".completion-words").html());
                } else {
                    $(".search-item:eq("+ (_n) +")").addClass("cur");
                    $(".search_text").val($(".search-item.cur").find(".completion-words").html());
                };
            };
            if(event.keyCode == 40) {
                if($(".search-item.cur").length > 0 && $(".search-item.cur").index() !== _n) {
                    var _index = $(".search-item.cur").index();
                    $(".search-item:eq("+ (_index + 1) +")").addClass("cur").siblings(".cur").removeClass("cur");
                    $(".search_text").val($(".search-item.cur").find(".completion-words").html());
                } else if ($(".search-item.cur").index() == _n) {
                    $(".search-item:eq(0)").addClass("cur").siblings(".cur").removeClass("cur");
                    $(".search_text").val($(".search-item.cur").find(".completion-words").html());
                } else {
                    $(".search-item:eq(0)").addClass("cur");
                    $(".search_text").val($(".search-item.cur").find(".completion-words").html());
                };
            };
        });
		</script>


