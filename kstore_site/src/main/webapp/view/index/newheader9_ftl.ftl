<#assign basePath=request.contextPath>
<style>
    .divhide{
        display: none;
    }
    /*搜索提示-liangck-20151127*/
    .section-header .content .search{
        z-index: 999;
    }
    .ex_search {
        background: #fff;
        border: 1px solid #dcdcdc !important;
        border-top: none;
        position: absolute;
        top: 39px;
        width: 383px;
        z-index: 999;
        box-shadow: 0 4px 8px rgba(140, 140, 140, .5);
        display: none;
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

<input type="hidden" id="basePath" value="${basePath}"/>
<div id="sectionHeader" class="section-header">
            <div class="content">
                <h1 id="logo">
                    <a href="${topmap.systembase.bsetAddress}"><img alt="" src="${topmap.systembase.bsetLogo}" style="width: 165px;height: 70px;" /></a>
                </h1>
                <div class="cartfd">
                    <s class="cartBanner"></s>
                    <div class="cartit">
                        <span><i class="iconfont">&#xe601;</i><a href="${basePath}/myshoppingcart.html" target="_blank">购物车</a></span>
                        <strong class="cartNum">(0)</strong>
                    </div>
                    <div class="miniCart hide">
                        <div class="mCartBox">
                            <div class="mcBoxTop clearfix">
                                <#--<div class="mcChk"><input type="checkbox"/></div>
                                <label for="" class="mcElect">全选</label>-->
                            </div>
                            <div class="mcBoxList">                              
                            </div><!--mcBoxList-->
                            <div class="emCartBox hide">
                                <span>购物车中还没有商品，再去逛逛吧！</span>
                            </div>
                        </div><!--mCartBox-->
                        <div class="mcGenius bmcGenius"></div>
                        <div class="mCartError hide">
                            <p>正在为您加载数量！</p>
                        </div>
                        <div class="mCartHandler clearfix">
                            <span class="mcCashier">
                                <span class="mcTotal">
                                    <span class="mcRmb">¥</span>
                                    <span class="mcTotalFee">0.00</span>
                                </span>
                                <span class="mcGo"><a href="${basePath}/myshoppingcart.html" target="_blank">结算</a></span>
                            </span>
                            <h3>
                                <span class="mc_e1">购物车</span>
                                <span class="mc_e2">共</span>
                                <strong class="mcNumTotal">0</strong>
                                <strong class="mcNumChecked">0</strong>
                                <span class="mc_e2">件</span>
                            </h3>
                        </div><!--clearfix -->
                    </div><!--miniCart-->
                </div><!--cartfd-->
                <div class="search searchdiv">
                    <form action="${basePath}/goods/searchproduct2.html" class="mallSearch-form" method="get">
                        <label for=""></label>
                        <input type="text" class="inputSearch" name="title" placeholder="搜索您需要的商品" autocomplete="off" value="${(keyWorlds)!''}" />
                        <button class="btnSearch" type="button" onclick="checkSearch()"><i class="iconfont">&#xe600;</i></button>
                    </form>
                    <div class="search_link">
                        <#if (topmap.hotsearch)?? && (topmap.hotsearch?size>0)>
                    	<#list topmap.hotsearch as hots>

		                        <a href="javascript:;" onclick="changeSearchKey(this);">${(hots.keyword)!''}</a>

                        </#list>
                        </#if>
                    </div>
                <#--搜索提示-liangck-20151127-->
                    <div class="ex_search pa">
                        <ul>
                        </ul>
                        <p class="tr"><a class="close_ex" href="javascript:;">关闭</a></p>
                    </div>
                </div><!--searchdiv-->
                <div class="header-news">
                <#if (topmap.infoList)?? && (topmap.infoList?size>0)>
                <#list topmap.infoList as info>
                <#if info_index==0>
	                <a href="${basePath}/information/${info.infoId?c}"><i class="iconfont">&#xe606;</i>
	                <#if info.title?length gt 18>
	               	   ${info.title?substring(0,18)}
					<#else>
					   ${info.title}
					</#if>                
	                </a>
                </#if>
                </#list>
                </#if>
                </div>

                <div class="mainnav">
                    <div class="navLinks">
                        <ul>
                            <#if (topmap.navList)?? && (topmap.navList?size>0)>
	                		<#list topmap.navList as nav>
                            <#if (nav_index < 8) >
			                 	<#if (nav.barName=="首页") || (nav.barUrl=="index.html")>
			                    	<li><a class="navLink on" onclick="clickNav('${(nav.barUrl)!''}','${nav_index+1}');"  href="javascript:;">${(nav.barName)!''}</a></li>	                  
			                    <#else>
			                    	<#if (nav.openChannel)?? && (nav.openChannel=='0')>
			                    	<li><a class="navLink" onclick="clickNav('${(nav.barUrl)!''}','${nav_index+1}')" href="javascript:;">${(nav.barName)!''}</a></li>
			                    	<#else>
			                    	<li><a class="navLink" onclick="clickNav('barchannelview/${(nav.barId?c)!''}','${nav_index+1}')" href="javascript:;">${(nav.barName)!''}</a></li>
			                    	</#if>
			                    </#if>
                            </#if>
	                		</#list>
               				</#if> 
                        </ul>
                    </div><!--navLinks-->
                    <input type="hidden" id="tempcbshowflag" value="${(topmap.temp.expFleid5)!''}">
                <#if (topmap.temp.expFleid5)?? && (topmap.temp.expFleid5=='0')>

                <div class="showlist divhide">
                <#else>
                <div class="showlist">
                </#if>
                        <strong class="btnnav menucat">
                            <a href="javascript:;" class="hover">全部商品分类<em class="all"></em></a>
                        </strong>
                    </div><!--showlist -->
                </div><!--mainnav -->
            </div><!--content-->
        </div><!--sectionHeader-->
        
        <#--<div class="bh-mask"></div>
	    <div id="ctDia" class="bh-dialog">
	        <div class="dia-tit">
	            <h4>加入收藏</h4>
	            <a class="dia-close" href="javascript:;" onclick="scls(this)"></a>
	        </div>
	        <div class="dia-cont">
	            <p>加入收藏失败，请使用菜单栏或Ctrl+D进行添加！</p>
	        </div>
	        <div class="dia-btn"><a href="javascript:;" onclick="scls(this)">确定</a></div>
	    </div>-->
	    
  <script id="dropdownMenu" type="text/html">
        <ul class="list dropdown-menu">
            {{each sort as value i}}
            <li>
                {{each value.menuSort as value i}}
                <a href="{{value.sortHref}}" target="_blank">{{value.sortName}}</a>
                {{/each}}
                <div class="links">
                    {{each value.links as value i}}
                    <a href="{{value.linkHref}}" target="_blank">{{value.linkName}}</a>
                    {{/each}}
                </div>
            </li>
            {{/each}}
        </ul>
    </script>
    <script id="menuView" type="text/html">
        {{each menu as value i}}
        <div class="menuView hide" id="{{value.menuId}}">
            <ul>
                {{each value.menuList as value i}}
                <li>
                    <h3><a href="{{value.mainHref}}" target="_blank">{{value.mainName}}</a></h3>
                    <p>
                        {{each value.menus as value i}}
                        <a href="{{value.secHref}}" target="_blank">{{value.secName}}</a>
                        {{/each}}
                    </p>
                </li>
                {{/each}}
            </ul>
            <div class="menuImg"><img alt="" src="{{value.menuImg}}" /></div>
        </div>
        {{/each}}
    </script>
    <script>
        var data = {
            sort: [
            <#if (topmap.classifyBar.classifyBarList)?? && (topmap.classifyBar.classifyBarList?size>0)>
           	<#list topmap.classifyBar.classifyBarList as cBar>
            	<#if (cBar.barCate)?? && (cBar.barCate?size>0)>
            	
		                {"menuSort": [
		                <#list cBar.barCate as bcate>
				            <#if bcate.cateId==-1>
				            	<#if bcate.temp2=="">
				                {"sortHref": "javascript:;", "sortName": "${bcate.cateName}"}
				                </else>
				                {"sortHref": "${basePath}/${bcate.temp2!'0'}", "sortName": "${bcate.cateName}"}
				                </#if>
				            <#elseif bcate.cateId??>
				            	{"sortHref": "${basePath}/list/${bcate.cateId?c}-${bcate.cateId?c}.html", "sortName": "${bcate.cateName}"}
				            </#if>
				            <#if bcate_has_next>,</#if>
                       </#list>
                
                ],
                </#if>
                    "links": [
                    <#if (cBar.barQuick)?? && (cBar.barQuick?size>0)>
                	<#list cBar.barQuick as bquick>
                    	<#if bquick.cateId==0>
                    		<#if bquick.temp2=="">
                    		{"linkHref": "javascript:;", "linkName": "${bquick.cateName}"}
                    		<#else>
                    		{"linkHref": "${basePath}/${bquick.temp2!'0'}", "linkName": "${bquick.cateName}"}
                    		</#if>
                    	<#elseif bquick.cateId??>
                    		{"linkHref": "${basePath}/list/${bquick.cateId?c}-${bquick.temp1!'0'}.html", "linkName": "${bquick.cateName}"}
                    	</#if>
						<#if bquick_has_next>,</#if>
                     </#list>
                     </#if>
                    ]}
                <#if cBar_has_next>,</#if>     
            </#list>
            </#if>
            ],
            menu: [
            <#if (topmap.classifyBar.classifyBarList)?? && (topmap.classifyBar.classifyBarList?size>0)>
			<#list topmap.classifyBar.classifyBarList as cBar>
                {"menuId": "submenu-${cBar_index+1}", "menuImg": "../images/menuImg.png", "menuList": [
                
                <#list cBar.childs as cbtwo>
	            	<#if cbtwo.goodsCatId==-1>
		            	<#if !cbtwo.url??||cbtwo.url=="">
	                    {"mainHref": "javascript:;", "mainName": "${cbtwo.name}", 
	                    <#else>
	                     {"mainHref": "${basePath}/${cbtwo.url!'0'}", "mainName": "${cbtwo.name}", 
	                    </#if>
                    <#else>
                    {"mainHref": "${basePath}/list/${cbtwo.goodsCatId?c}-${cbtwo.temp3!'0'}.html", "mainName": "${cbtwo.name}", 
                    </#if>
                    
                    
                    
                    "menus": [
                    <#if (cbtwo.childs)?? && (cbtwo.childs?size>0)>
			        <#list cbtwo.childs as cbthird> 
                    <#if cbthird.goodsCatId==-1>
                    	<#if cbthird.url=="">
                    	{"secHref": "javascript:;", "secName": "${cbthird.name}"}
                    	<#else>
                    	{"secHref": "${basePath}/${cbthird.url!'0'}", "secName": "${cbthird.name}"}
                    	</#if>
                    
                    <#else>
                   		{"secHref": "${basePath}/list/${cbthird.goodsCatId?c}-${cbthird.temp3!'0'}.html", "secName": "${cbthird.name}"}
                    </#if>
                    	<#if cbthird_has_next>,</#if>
                    </#list>
                    </#if>
                    ]}
                    <#if cbtwo_has_next>,</#if>
                    </#list>
                    
                ]}
             <#if cBar_has_next>,</#if>  
            </#list>
            </#if>
            
            ]<!--menu-->
        };

        var sort = template('dropdownMenu', data),
            menu = template("menuView", data);
        $(".menucat").after(sort);
        $(".showlist").append(menu);
    </script>   
    
    <script type="text/javascript">
        <#--$(function(){-->
           <#--$.ajax({ url:"${basePath}/getnavsort.htm", async:false ,success: function(data){-->
                    <#--$(".navLinks ul").find("li").each(function(){-->
                    <#--$(this).find("a").removeClass("on");-->
                        <#--if($(this).index()+1==data){-->
                            <#--$(this).find("a").addClass("on");-->
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
        $(".inputSearch").bind('input propertychange', function () {
            $.getJSON("${basePath}/completionWords.htm?t="+new Date().getTime(), {keyWords: $.trim($(this).val())}, function (data) {
                if (data.length > 0) {
                    $(".ex_search ul").html("");
                    data.forEach(function(c){
                        $(".ex_search ul").append('<li class="search-item"><a href="javascript:;" class="completion-words">'+ c.substring(0,46)+'</a><a class="del_history" href="javascript:;"style="display: none;">删除</a></li>');
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
            $(".inputSearch").blur();
        });
        var _n = $(".search-item").length - 1;
        $("body").keydown(function(event){
            if(event.keyCode == 38) {
                if($(".search-item.cur").length > 0) {
                    var _index = $(".search-item.cur").index();
                    $(".search-item:eq("+ (_index - 1) +")").addClass("cur").siblings(".cur").removeClass("cur");
                    $(".inputSearch").val($(".search-item.cur").find(".completion-words").html());
                } else {
                    $(".search-item:eq("+ (_n) +")").addClass("cur");
                    $(".inputSearch").val($(".search-item.cur").find(".completion-words").html());
                };
            };
            if(event.keyCode == 40) {
                if($(".search-item.cur").length > 0 && $(".search-item.cur").index() !== _n) {
                    var _index = $(".search-item.cur").index();
                    $(".search-item:eq("+ (_index + 1) +")").addClass("cur").siblings(".cur").removeClass("cur");
                    $(".inputSearch").val($(".search-item.cur").find(".completion-words").html());
                } else if ($(".search-item.cur").index() == _n) {
                    $(".search-item:eq(0)").addClass("cur").siblings(".cur").removeClass("cur");
                    $(".inputSearch").val($(".search-item.cur").find(".completion-words").html());
                } else {
                    $(".search-item:eq(0)").addClass("cur");
                    $(".inputSearch").val($(".search-item.cur").find(".completion-words").html());
                };
            };
        });
</script>    
        
        