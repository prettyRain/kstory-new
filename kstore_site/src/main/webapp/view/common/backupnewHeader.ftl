<#assign basePath=request.contextPath>
<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
<script type="text/javascript" src="${basePath}/js/jquery.slides.min.js"></script>
<script src="${basePath}/js/jsOperation.js"></script>
<link rel="stylesheet" href="${basePath}/index_960/css/style.css"/>
<link rel="stylesheet" href="${basePath}/index_960/css/newheader.css"/>

<div class="section_headerTop">
    <input type="hidden" id="basePath" value="${basePath}">
    <div class="slot slot_headerTop01">
        <div class="header_nv">
        <#if topmap.advs??>
            <#list topmap.advs as adv>
                <#if (adv.adverSort>=3) && (adv.adverSort<=6)>
                    <a style="margin-left: 20px" href="javascript:;" onclick="clickNav('${adv.adverHref!'#'}')" class="_color${adv.adverSort-2}">${adv.adverName!''}</a>
                    <span><img src="${basePath}/index_960/images/m${adv.adverSort-2}.png"></span>
                </#if>
            </#list>
        </#if>

        </div>
        <div class="navItem">
            <div class="topmenu" id="3">
                <p>网站导航</p>
                <div id="menucontent3" class="toplinkmenu toplinkmenu2">
                    <div><img src="${basePath}/index_960/images/sy.png" style="vertical-align: middle;"> <a href="#" style="font-weight: bold;">首页</a></div>
                    <div style="padding-left: 25px;">
                        <a href="#">茶馆</a> &nbsp;&nbsp;&nbsp;
                        <a href="#">960大聚惠</a> &nbsp;&nbsp;&nbsp;
                        <a href="#">狩猎时刻</a> &nbsp;&nbsp;&nbsp;
                        <a href="#">展览馆</a> &nbsp;&nbsp;&nbsp;
                    </div>
                    <div><img src="${basePath}/index_960/images/sp.png" style="vertical-align: middle;"> <a href="#" style="font-weight: bold;">食品荟萃</a></div>
                    <div style="padding-left: 25px;">
                        <a href="#">茶馆</a> &nbsp;&nbsp;&nbsp;
                        <a href="#">老字号</a> &nbsp;&nbsp;&nbsp;
                        <a href="#">菌临天下</a> &nbsp;&nbsp;&nbsp;
                    </div>
                    <div><img src="${basePath}/index_960/images/yd.png" style="vertical-align: middle;"> <a href="#" style="font-weight: bold;">饮品总汇</a></div>
                    <div style="padding-left: 25px;">
                        <a href="#">生命之源</a> &nbsp;&nbsp;&nbsp;
                        <a href="#">红酒庄园</a> &nbsp;&nbsp;&nbsp;
                        <a href="#">国际名酒廊</a> &nbsp;&nbsp;&nbsp;
                    </div>
                    <div><img src="${basePath}/index_960/images/jd.png" style="vertical-align: middle;"> <a href="#" style="font-weight: bold;">购物中心 </a></div>
                    <div style="padding-left: 25px;">
                    </div>
                    <div><img src="${basePath}/index_960/images/dd.png" style="vertical-align: middle;"> <a href="#" style="font-weight: bold;">大药房 </a></div>
                    <div style="padding-left: 25px;">
                    </div>
                </div>
            </div>
            <div class="topmenu" id="2">
                <p><a href="${basePath}/help.htm">帮助中心</a></p>
                <div id="menucontent2" class="toplinkmenu">
                    <div><a href="${basePath}/help/135">购物指南</a></div>
                    <div><a href="${basePath}/help/137">配送服务</a></div>
                    <div><a href="${basePath}/help/145">支付方式</a></div>
                    <div><a href="${basePath}/help/157">售后服务</a></div>
                    <div><a href="${basePath}/help/169">客户服务</a></div>
                </div>
            </div>
            <div class="topmenu last_topmenu" id="1">
                <p><a href="${basePath}/customer/index.html" class="login">我的960</a></p>
                <div id="menucontent1" class="toplinkmenu">
                    <div><a href="${basePath}/customer/myorder.html">我的订单</a></div>
                    <div><a href="${basePath}/customer/myintegral.html">我的积分</a></div>
                    <div><a href="${basePath}/customer/myfollw.html">我的收藏</a></div>
                    <div><a href="${basePath}/customer/insideletter.html">我的消息</a></div>
                </div>
            </div>
            <div class="topmenu first_topmenu" id="4">
                <p><a href="#" class="login">960微商城</a></p>
                <div id="menucontent4" class="toplinkmenu" style="display: none;">
                    <img style="width:140px;" src="http://www.ge960.com/pic/960ewm.png" alt="960微商城">
                </div>
            </div>
            <div class="register">
            <#if cust??>
                <a href="${basePath}/customer/index.html"><font color="red">${cust.customerNickname!''}</font></a>
                <a href=""><font color="red"></font></a> <a href="${basePath}/logout.html">退出</a>
            <#else>
                <a href="${basePath}/login.html">登录</a>
                <a href="${basePath}/register.html">注册</a>
            </#if>
            </div>
            <div class="clear"></div>
        </div>
    </div>
</div>


<#--shf-->
<#--<div class="tm-content">-->
<#--<h1 id="logoz" style="display:inline-block">-->
<#--<a href="http://127.0.0.1:7070/site"><img alt="" src="http://tboss.ge960.com:80/upload/20170317/1489739915621.jpg" style="width: 165px;height: 70px;"></a>-->
<#--</h1>-->
<#--<div class="logoBanner" style="float:right;">-->
<#--<!-- 广告位置 &ndash;&gt;-->
<#--<a href="http://tkstore.ge960.com/item/7221.html" target="_blank">-->
<#--<img alt="" src="http://tboss.ge960.com:80/upload/20170314/1489488081314.jpg" style="max-width:480px;height:94px">-->
<#--</a>-->
<#--<a href="http://tkstore.ge960.com/item/7139.html" target="_blank">-->
<#--<img alt="" src="http://tboss.ge960.com:80/upload/20170315/1489550314355.jpg" style="max-width:480px;height:94px">-->
<#--</a>-->
<#--</div>-->

<#--</div>-->
<#--<div class="mainnavz">-->
<#--<div class="tm-content" style="height: 48px;">-->
<#--<div class="navLinks">-->
<#--<ul>-->
<#--<li><a class="navLink" onclick="clickNav('http://tkstore.ge960.com/subject/75','1')"  href="javascript:;">茶       馆</a></li>-->
<#--<li><a class="navLink" onclick="clickNav('http://tkstore.ge960.com/subject/77','2')"  href="javascript:;">960大聚惠</a></li>-->
<#--<li><a class="navLink" onclick="clickNav('http://tkstore.ge960.com/subject/79','3')"  href="javascript:;">狩猎时刻</a></li>-->
<#--<li><a class="navLink" onclick="clickNav('http://tkstore.ge960.com/subject/81','4')"  href="javascript:;">展览馆</a></li>-->
<#--</ul>-->
<#--</div>-->
<#--<div class="showlist">-->
<#--<strong class="btnnav menucat">-->
<#--<a class="hover" href="javascript:;">所有商品分类</a>-->
<#--</strong>-->
<#--</div>-->
<#--</div>-->
<#--</div>-->


<#--shfnew-->
<div id="sectionHeader" class="section-header">
    <div class="tm-content">
        <h1 id="logo">
            <a href="http://127.0.0.1:7070/site"><img alt="" src="http://tboss.ge960.com:80/upload/20170317/1489739915621.jpg" style="width: 181px;height: 72px;"></a>
        </h1>
        <div class="logoBanner">
            <!-- 广告11111位置 -->
            <a href="http://www.ge960.com/item/7221.html" target="_blank">
                <img alt="" src="http://tboss.ge960.com:80/upload/20170314/1489488081314.jpg" style="max-width:480px;height:94px">
            </a>
            <a href="http://www.ge960.com/item/7139.html" target="_blank">
                <img alt="" src="http://tboss.ge960.com:80/upload/20170315/1489550314355.jpg" style="max-width:480px;height:94px">
            </a>
        </div>

    </div>
    <div class="mainnav">
        <div class="tm-content" style="height: 48px;">
            <div class="navLinks">
                <ul>
                    <li><a class="navLink" onclick="clickNav('http://www.ge960.com/subject/75','1')"  href="javascript:;">茶       馆</a></li>
                    <li><a class="navLink" onclick="clickNav('http://www.ge960.com/subject/77','2')"  href="javascript:;">960大聚惠</a></li>
                    <li><a class="navLink" onclick="clickNav('marketingrushlist-1.html','3')"  href="javascript:;">狩猎时刻</a></li>
                    <li><a class="navLink" onclick="clickNav('http://www.ge960.com/subject/81','4')"  href="javascript:;">展览馆</a></li>
                </ul>
            </div>
            <div class="searchID searchbuttonarea">
                <img src="/index_960/images/index2_06.png" style="padding-top:3px;" onclick="showSearch()"/>&nbsp;&nbsp;
                <span>&nbsp;<img id="shopcartid" class="searchbuttonarea_gw" src="/index_960/images/index2_08.png"></span>
                <div class="shopcarright_list headMiniShopcart" style="right:43px; display: none;top:0;">
                    <div class="form cart-goods" style="margin:0;">

                    </div>

                    <div class="li_btn" style="text-align: left;">
                        <p style="float:left;padding-left:5px;">
                            <span>共 <i class="li_g mcNumTotal">1</i> 件商品</span>&nbsp;&nbsp;
                            <span>共计：<font style="font-weight: bold; color: #ff4e01;">¥<b class="li_m mcTotalFee">0.00</b></font></span>&nbsp;&nbsp;
                        </p>
                        <a style="color:#fff;background: #35a400;" href="/myshoppingcart.html" class="login submit_btn1">去购物车</a>
                    </div>
                </div>
            </div>
            <div class="searchdiv">
                <!-- 搜索框 -->
                <form id="mallSearch-form" action="/goods/searchproduct2.html" method="get" >
                    <div style="float: right; padding: 5px 6px;" onclick="hideSearch()">
                        <img src="/index_960/images/index3_03.png" style="cursor: pointer;">
                    </div>
                    <div id="search" style="float: right;">
                        <input type="text" id="wd" class="search hotsearchInput" name="title" placeholder="搜索GE960.COM">
                        <div class="searchcont">
                            <div class="history_list">
                                <p><span>历史记录</span><a class="move" href="javascript:;">删除</a></p>
                                <ul>
                                    <li><a href="javascript:;"></a></li>
                                </ul>
                            </div>
                            <div class="hot_list">
                                <dl>
                                    <dt>热门搜索</dt>
                                </dl>
                            </div>
                        </div>
                    </div>
                    <div style="float: right; padding: 4px 6px;" onclick="checkSearch()">
                        <img src="/index_960/images/index2_06.png" tppabs="http://ge960.com/pic/index2_06.png">
                    </div>

                    <div class="clear"></div>
                </form>
            </div>
            <div class="showlist">
                <strong class="btnnav menucat">
                    <a class="hover" href="javascript:;">所有商品分类</a>
                </strong>
                <ul class="list dropdown-menu">
                    <li>
                        <div class="links">
                            <a href="javascript:;">新鲜蔬菜　菌菇</a>

                        </div>
                    </li>
                    <li>
                        <div class="links">
                            <a href="javascript:;">时令水果 进口水果</a>

                        </div>
                    </li>
                    <li>
                        <div class="links">
                            <a href="javascript:;">牛羊肉 猪鸭鸡 禽蛋</a>

                        </div>
                    </li>
                    <li>
                        <div class="links">
                            <a href="javascript:;">海鲜水产  肉制品</a>

                        </div>
                    </li>
                    <li>
                        <div class="links">
                            <a href="javascript:;">米面　杂粮　食用油　调味品</a>

                        </div>
                    </li>
                    <li>
                        <div class="links">
                            <a href="javascript:;">方便食品　膨化　冷冻食品</a>

                        </div>
                    </li>
                    <li>
                        <div class="links">
                            <a href="javascript:;">腌渍　罐头　烘焙　可可</a>

                        </div>
                    </li>
                    <li>
                        <div class="links">
                            <a href="javascript:;">薯类　糖果　蜜饯　坚果　茶</a>

                        </div>
                    </li>
                    <li>
                        <div class="links">
                            <a href="javascript:;">白酒　啤酒　红酒　洋酒</a>

                        </div>
                    </li>
                    <li>
                        <div class="links">
                            <a href="javascript:;">黄酒　预调酒　清酒　保健酒</a>

                        </div>
                    </li>
                    <li>
                        <div class="links">
                            <a href="javascript:;">碳酸饮料　饮用水　果蔬汁</a>

                        </div>
                    </li>
                    <li>
                        <div class="links">
                            <a href="javascript:;">蛋白饮料　功能饮料</a>

                        </div>
                    </li>
                    <li>
                        <div class="links">
                            <a href="javascript:;">冲饮　咖啡　冲调饮品</a>

                        </div>
                    </li>
                </ul>
                <div class="menuView hide">

                    <ul>
                        <li>
                            <h3><a href="/list/5775-5773.html">叶菜类</a></h3>
                            <p>
                                <a href="/list/5777-5773.html">白菜</a>
                                <a href="/list/6319-5773.html">油菜</a>
                                <a href="/list/5855-5773.html">菠菜</a>
                                <a href="/list/5857-5773.html">娃娃菜</a>
                                <a href="/list/5859-5773.html">穿心莲</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/5779-5773.html">根茎类</a></h3>
                            <p>
                                <a href="/list/5861-5773.html">笋尖</a>
                                <a href="/list/5863-5773.html">蒜苗</a>
                                <a href="/list/5865-5773.html">彩椒</a>
                                <a href="/list/5867-5773.html">萝卜</a>
                                <a href="/list/5889-5773.html">玉米</a>
                                <a href="/list/5893-5773.html">土豆</a>
                                <a href="/list/5897-5773.html">山药</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/5781-5773.html">茄果类</a></h3>
                            <p>
                                <a href="/list/5923-5773.html">西红柿</a>
                                <a href="/list/5925-5773.html">黄瓜</a>
                                <a href="/list/5927-5773.html">青椒</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/5783-5773.html">菌菇类</a></h3>
                            <p>
                                <a href="/list/5929-5773.html">猴头菇</a>
                                <a href="/list/5931-5773.html">茶树菇</a>
                                <a href="/list/5933-5773.html">杏鲍菇</a>
                                <a href="/list/5935-5773.html">金针菇</a>
                                <a href="/list/5937-5773.html">白玉菇</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/5785-5773.html">葱蒜类</a></h3>
                            <p>
                                <a href="/list/5939-5773.html">葱</a>
                            </p>
                        </li>
                    </ul>

                </div>

                <div class="menuView hide">

                    <ul>
                        <li>
                            <h3><a href="/list/5789-5787.html">浆果类</a></h3>
                            <p>
                                <a href="/list/5941-5787.html">奇异果</a>
                                <a href="/list/5943-5787.html">草莓</a>
                                <a href="/list/5945-5787.html">香蕉</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/5791-5787.html">柑橘类</a></h3>
                            <p>
                                <a href="/list/5947-5787.html">橙子</a>
                                <a href="/list/5951-5787.html">柠檬</a>
                                <a href="/list/5949-5787.html">丑柑</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/5793-5787.html">核果类</a></h3>
                            <p>
                                <a href="/list/5953-5787.html">苹果</a>
                                <a href="/list/5955-5787.html">梨</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/5795-5787.html">瓜类</a></h3>
                            <p>
                                <a href="/list/5957-5787.html">西瓜</a>
                                <a href="/list/5959-5787.html">木瓜</a>
                                <a href="/list/5961-5787.html">香瓜</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/5797-5787.html">其他</a></h3>
                            <p>
                                <a href="/list/5963-5787.html">百香果</a>
                                <a href="/list/5965-5787.html">芒果</a>
                                <a href="/list/5967-5787.html">芭乐</a>
                                <a href="/list/5969-5787.html">菠萝</a>
                            </p>
                        </li>
                    </ul>

                </div>

                <div class="menuView hide">

                    <ul>
                        <li>
                            <h3><a href="/list/5801-5799.html">牛肉</a></h3>
                            <p>
                                <a href="/list/5813-5799.html">牛排</a>
                                <a href="/list/5815-5799.html">牛里脊（外里）</a>
                                <a href="/list/5817-5799.html">牛腩</a>
                                <a href="/list/5819-5799.html">牛上脑</a>
                                <a href="/list/5821-5799.html">牛眼肉</a>
                                <a href="/list/5823-5799.html">肥牛</a>
                                <a href="/list/5825-5799.html">牛肉馅</a>
                                <a href="/list/5827-5799.html">牛柳</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/5803-5799.html">羊肉</a></h3>
                            <p>
                                <a href="/list/5829-5799.html">羊肉卷</a>
                                <a href="/list/5831-5799.html">羊排</a>
                                <a href="/list/5833-5799.html">羊前棒</a>
                                <a href="/list/5835-5799.html">羊蝎子</a>
                                <a href="/list/5837-5799.html">羊尾尖</a>
                                <a href="/list/5839-5799.html">羊肉切片</a>
                                <a href="/list/5841-5799.html">羊前腿</a>
                                <a href="/list/5843-5799.html">羊后腿包肉</a>
                                <a href="/list/5845-5799.html">羊元宝肉</a>
                                <a href="/list/5847-5799.html">羊棒骨</a>
                                <a href="/list/5849-5799.html">羊肉馅</a>
                                <a href="/list/5851-5799.html">羊肉切块</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/5805-5799.html">猪肉</a></h3>
                            <p>
                                <a href="/list/5971-5799.html">五花肉</a>
                                <a href="/list/5973-5799.html">肋排</a>
                                <a href="/list/5975-5799.html">前尖肉</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/5807-5799.html">鸡肉</a></h3>
                            <p>
                                <a href="/list/5977-5799.html">鸡胗</a>
                                <a href="/list/5979-5799.html">鸡翅</a>
                                <a href="/list/5981-5799.html">整鸡</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/5809-5799.html">鸭肉</a></h3>
                            <p>
                                <a href="/list/5985-5799.html">鸭掌</a>
                                <a href="/list/5987-5799.html">半片鸭</a>
                                <a href="/list/5989-5799.html">鸭翅中</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/5811-5799.html">禽蛋</a></h3>
                            <p>
                                <a href="/list/5991-5799.html">鸡蛋</a>
                                <a href="/list/5993-5799.html">咸鸭蛋</a>
                                <a href="/list/5995-5799.html">乌鸡蛋</a>
                            </p>
                        </li>
                    </ul>

                </div>

                <div class="menuView hide">

                    <ul>
                        <li>
                            <h3><a href="/list/5891-5869.html">海鲜水产</a></h3>
                            <p>
                                <a href="/list/5997-5869.html">三文鱼</a>
                                <a href="/list/5999-5869.html">黄花鱼</a>
                                <a href="/list/6001-5869.html">墨鱼</a>
                                <a href="/list/6003-5869.html">带鱼</a>
                                <a href="/list/6005-5869.html">鲍鱼</a>
                                <a href="/list/6007-5869.html">鳕鱼</a>
                                <a href="/list/6009-5869.html">白虾</a>
                                <a href="/list/6011-5869.html">青口贝</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/5895-5869.html">肉制品</a></h3>
                            <p>
                                <a href="/list/6013-5869.html">天福号</a>
                                <a href="/list/6015-5869.html">肠类</a>
                                <a href="/list/6017-5869.html">北京烤鸭</a>
                            </p>
                        </li>
                    </ul>

                </div>

                <div class="menuView hide">

                    <ul>
                        <li>
                            <h3><a href="/list/5899-5871.html">米</a></h3>
                            <p>
                                <a href="/list/6019-5871.html">大米</a>
                                <a href="/list/6021-5871.html">香米</a>
                                <a href="/list/6023-5871.html">糙米</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/5901-5871.html">面</a></h3>
                            <p>
                                <a href="/list/6025-5871.html">富强粉</a>
                                <a href="/list/6027-5871.html">低筋小麦粉</a>
                                <a href="/list/6029-5871.html">面包粉</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/5903-5871.html">杂粮</a></h3>
                            <p>
                                <a href="/list/6031-5871.html">小米</a>
                                <a href="/list/6033-5871.html">红豆</a>
                                <a href="/list/6035-5871.html">黑米</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/5905-5871.html">食用油</a></h3>
                            <p>
                                <a href="/list/6037-5871.html">花生油</a>
                                <a href="/list/6039-5871.html">橄榄油</a>
                                <a href="/list/6037-5871.html">花生油</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/5907-5871.html">调味品</a></h3>
                            <p>
                                <a href="/list/6043-5871.html">酱油</a>
                                <a href="/list/6045-5871.html">醋</a>
                                <a href="/list/6047-5871.html">料酒</a>
                                <a href="/list/6049-5871.html">香油</a>
                                <a href="/list/6051-5871.html">黄酱</a>
                                <a href="/list/6053-5871.html">甜面酱</a>
                                <a href="/list/6055-5871.html">芝麻酱</a>
                            </p>
                        </li>
                    </ul>

                </div>

                <div class="menuView hide">

                    <ul>
                        <li>
                            <h3><a href="/list/5909-5873.html">方便食品</a></h3>
                            <p>
                                <a href="/list/6297-5873.html">方便面</a>
                                <a href="/list/6299-5873.html">方便粉丝</a>
                                <a href="/list/6301-5873.html">方便汤</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/5911-5873.html">膨化</a></h3>
                            <p>
                                <a href="/list/6303-5873.html">薯片</a>
                                <a href="/list/6305-5873.html">锅巴</a>
                                <a href="/list/6307-5873.html">爆米花</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/5913-5873.html">冷冻食品</a></h3>
                            <p>
                                <a href="/list/6309-5873.html">汤圆</a>
                                <a href="/list/6311-5873.html">水饺</a>
                                <a href="/list/6313-5873.html">云吞</a>
                            </p>
                        </li>
                    </ul>

                </div>

                <div class="menuView hide">

                    <ul>
                        <li>
                            <h3><a href="/list/5915-5875.html">腌渍</a></h3>
                            <p>
                                <a href="/list/6057-5875.html">韭菜花</a>
                                <a href="/list/6059-5875.html">酱菜</a>
                                <a href="/list/6061-5875.html">腐乳</a>
                                <a href="/list/6063-5875.html">榨菜</a>
                                <a href="/list/6065-5875.html">腊肠</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/5917-5875.html">罐头</a></h3>
                            <p>
                                <a href="/list/6067-5875.html">水果罐头</a>
                                <a href="/list/6069-5875.html">肉罐头</a>
                                <a href="/list/6071-5875.html">水产罐头</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/5919-5875.html">烘焙</a></h3>
                            <p>
                                <a href="/list/6121-5875.html">蛋糕</a>
                                <a href="/list/6123-5875.html">面包</a>
                                <a href="/list/6125-5875.html">饼干</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/5921-5875.html">可可</a></h3>
                            <p>
                                <a href="/list/6127-5875.html">可可粉</a>
                                <a href="/list/6129-5875.html">巧克力豆</a>
                                <a href="/list/6131-5875.html">白巧克力</a>
                            </p>
                        </li>
                    </ul>

                </div>

                <div class="menuView hide">

                    <ul>
                        <li>
                            <h3><a href="/list/6085-5877.html">薯类</a></h3>
                            <p>
                                <a href="/list/6133-5877.html">紫薯干</a>
                                <a href="/list/6135-5877.html">地瓜干</a>
                                <a href="/list/6137-5877.html">魔芋</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/6087-5877.html">糖果</a></h3>
                            <p>
                                <a href="/list/6139-5877.html">口香糖</a>
                                <a href="/list/6141-5877.html">硬糖</a>
                                <a href="/list/6143-5877.html">梨膏糖</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/6089-5877.html">蜜饯</a></h3>
                            <p>
                                <a href="/list/6145-5877.html">话梅</a>
                                <a href="/list/6147-5877.html">杏干</a>
                                <a href="/list/6149-5877.html">芒果干</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/6091-5877.html">坚果</a></h3>
                            <p>
                                <a href="/list/6151-5877.html">花生</a>
                                <a href="/list/6153-5877.html">瓜子</a>
                                <a href="/list/6155-5877.html">夏威夷果</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/6093-5877.html">茶</a></h3>
                            <p>
                                <a href="/list/6095-5877.html">灵山云雾红茶</a>
                                <a href="/list/6157-5877.html">绿茶</a>
                                <a href="/list/6159-5877.html">白茶</a>
                                <a href="/list/6161-5877.html">红茶</a>
                                <a href="/list/6163-5877.html">黑茶</a>
                                <a href="/list/6165-5877.html">黄茶</a>
                                <a href="/list/6167-5877.html">花草茶</a>
                                <a href="/list/6169-5877.html">乌龙茶</a>
                                <a href="/list/6171-5877.html">其它</a>
                            </p>
                        </li>
                    </ul>

                </div>

                <div class="menuView hide">

                    <ul>
                        <li>
                            <h3><a href="/list/6073-5879.html">白酒</a></h3>
                            <p>
                                <a href="/list/6173-5879.html">五粮液</a>
                                <a href="/list/6175-5879.html">茅台</a>
                                <a href="/list/6177-5879.html">牛栏山</a>
                                <a href="/list/6179-5879.html">剑南春</a>
                                <a href="/list/6315-5879.html">洋河</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/6075-5879.html">啤酒</a></h3>
                            <p>
                                <a href="/list/6181-5879.html">黄啤</a>
                                <a href="/list/6183-5879.html">果味酒</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/6077-5879.html">红酒</a></h3>
                            <p>
                                <a href="/list/6081-5879.html">红葡萄酒</a>
                                <a href="/list/6083-5879.html">白葡萄酒</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/6079-5879.html">洋酒</a></h3>
                            <p>
                                <a href="/list/6185-5879.html">威士忌</a>
                                <a href="/list/6187-5879.html">白兰地</a>
                                <a href="/list/6189-5879.html">朗姆酒</a>
                                <a href="/list/6191-5879.html">伏特加</a>
                            </p>
                        </li>
                    </ul>

                </div>

                <div class="menuView hide">

                    <ul>
                        <li>
                            <h3><a href="/list/6097-5881.html">黄酒</a></h3>
                            <p>
                                <a href="/list/6193-5881.html">古越龙山</a>
                                <a href="/list/6195-5881.html">会稽山</a>
                                <a href="/list/6197-5881.html">绍兴女儿红</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/6099-5881.html">预调酒</a></h3>
                            <p>
                                <a href="/list/6199-5881.html">RIO锐澳</a>
                                <a href="/list/6201-5881.html">Mixxtail魅夜</a>
                                <a href="/list/6203-5881.html">百加得</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/6101-5881.html">清酒</a></h3>
                            <p>
                                <a href="/list/6207-5881.html">日本盛</a>
                                <a href="/list/6209-5881.html">梅子酒</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/6103-5881.html">保健酒</a></h3>
                            <p>
                                <a href="/list/6317-5881.html">劲酒</a>
                                <a href="/list/6213-5881.html">竹叶青</a>
                                <a href="/list/6215-5881.html">宁夏红</a>
                            </p>
                        </li>
                    </ul>

                </div>

                <div class="menuView hide">

                    <ul>
                        <li>
                            <h3><a href="/list/6105-5883.html">碳酸饮料</a></h3>
                            <p>
                                <a href="/list/6217-5883.html">雪碧</a>
                                <a href="/list/6219-5883.html">北冰洋</a>
                                <a href="/list/6221-5883.html">可乐</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/6227-5883.html">矿泉水</a></h3>
                            <p>
                                <a href="/list/6233-5883.html">百岁山</a>
                                <a href="/list/6235-5883.html">依云</a>
                                <a href="/list/6237-5883.html">昆仑山</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/6229-5883.html">矿物质水</a></h3>
                            <p>
                                <a href="/list/6239-5883.html">润田</a>
                                <a href="/list/6241-5883.html">5100西藏冰川</a>
                                <a href="/list/6243-5883.html">泉阳泉</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/6231-5883.html">纯净水</a></h3>
                            <p>
                                <a href="/list/6245-5883.html">屈臣氏</a>
                                <a href="/list/6247-5883.html">怡宝</a>
                                <a href="/list/6249-5883.html">景田</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/6109-5883.html">果蔬汁</a></h3>
                            <p>
                                <a href="/list/6251-5883.html">橙汁</a>
                                <a href="/list/6253-5883.html">葡萄汁</a>
                                <a href="/list/6255-5883.html">苹果汁</a>
                            </p>
                        </li>
                    </ul>

                </div>

                <div class="menuView hide">

                    <ul>
                        <li>
                            <h3><a href="/list/6111-5885.html">蛋白饮料</a></h3>
                            <p>
                                <a href="/list/6257-5885.html">椰子汁</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/6113-5885.html">功能饮料</a></h3>
                            <p>
                                <a href="/list/6259-5885.html">健力宝</a>
                                <a href="/list/6261-5885.html">乐虎</a>
                            </p>
                        </li>
                    </ul>

                </div>

                <div class="menuView hide">

                    <ul>
                        <li>
                            <h3><a href="/list/6115-5887.html">冲饮谷物</a></h3>
                            <p>
                                <a href="/list/6263-5887.html">豆浆粉</a>
                                <a href="/list/6269-5887.html">麦片</a>
                                <a href="/list/6271-5887.html">芝麻糊</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/6117-5887.html">速溶咖啡</a></h3>
                            <p>
                                <a href="/list/6273-5887.html">黑咖啡</a>
                                <a href="/list/6275-5887.html">白咖啡</a>
                                <a href="/list/6277-5887.html">三合一</a>
                                <a href="/list/6279-5887.html">摩卡</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/6265-5887.html">咖啡豆/粉</a></h3>
                            <p>
                                <a href="/list/6281-5887.html">蓝山</a>
                                <a href="/list/6283-5887.html">猫屎咖啡</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/6267-5887.html">咖啡伴侣</a></h3>
                            <p>
                                <a href="/list/6285-5887.html">方糖</a>
                                <a href="/list/6287-5887.html">奶精</a>
                                <a href="/list/6289-5887.html">奶油球</a>
                            </p>
                        </li>
                    </ul>

                    <ul>
                        <li>
                            <h3><a href="/list/6119-5887.html">冲调饮品</a></h3>
                            <p>
                                <a href="/list/6291-5887.html">红茶饮料</a>
                                <a href="/list/6293-5887.html">绿茶饮料</a>
                                <a href="/list/6295-5887.html">蜂蜜柠檬茶</a>
                            </p>
                        </li>
                    </ul>

                </div>


            </div>
        </div>
    </div>
</div>
<#--<div class="rightpar">-->
<#--<div class="rightbar on0" style="padding:0;z-index:99;">-->
<#--<div class="rightbar_body">-->
<#--<div style="padding:0 2px">-->
<#--<div><a href="/index.html"><img src="/index_960/images/fixiconzhuye.png"></a></div>-->

<#--<div class="rightbar_list1"><a href="localhost:7070/site/channel/237.html">食品荟萃</a></div>-->
<#--<div class="rightbar_list2"><a href="http://tkstore.ge960.com/channel/239.html">饮品总汇</a></div>-->
<#--<div class="rightbar_list3"><a href="http://tkstore.ge960.com/channel/241.html">购物中心</a></div>-->
<#--<div class="rightbar_list4"><a href="http://tkstore.ge960.com/channel/243.html">大药房</a></div>-->

<#--<div style="display: none" name="showMy960"><a href="/customer/index.html"><img src="/index_960/images/fixicon4.png"></a></div>-->
<#--</div>-->
<#--<div class="shopcarright">-->
<#--<a class="login shopcarright_img" style="display:block;" href="#">-->
<#--<img style="margin-right:5px;" src="/index_960/images/fixiconche.png">-->
<#--<a href="/myshoppingcart.html"><span  style="color:#fff;font-size: 12px">购<br>物<br>车</span></a>-->
<#--</a>-->
<#--<div class="shopcaritemnum"></div>-->
<#--<div class="shopcarright_list headMiniShopcart" style="right:43px; display: none;top:0;">-->
<#--<div class="form cart-goods" style="margin:0;">-->

<#--</div>-->
<#--<div class="li_btn" style="text-align: left;">-->
<#--<p style="float:left;padding-left:5px;">-->
<#--<span>共 <i class="li_g mcNumTotal">1</i> 件商品</span>&nbsp;&nbsp;-->
<#--<span>共计：<font style="font-weight: bold; color: #ff4e01;">¥<b class="li_m mcTotalFee">0.00</b></font></span>&nbsp;&nbsp;-->
<#--</p>-->
<#--<a style="color:#fff;background: #35a400;" href="/myshoppingcart.html" class="login submit_btn1">去购物车</a>-->
<#--</div>-->
<#--</div>-->
<#--</div>-->
<#--</div>-->
<#--</div>-->
<#--<div class="scroll_top"><a href="javascript:;" title="回到顶部"><img src="/index_960/images/head_top.png"></a></div>-->
<#--</div>-->


<script type="text/javascript">
    function clickNav(url,sort){
        if(url.indexOf("http://")!=-1){
            window.open(url);
        }else{
            window.open("/"+url);
        }
    }
    //点击热门搜索的时候
    function changeSearchKey(obj){
        $(".inputSearch").val($(obj).html());
        $(".mallSearch-form").submit();
    }
    //搜索
    function checkSearch(){
        /* var search=$.trim($(".inputSearch").val());
         if(search==""){
             $(".inputSearch").val($(".inputSearch").attr("placeholder"));
         }else if(search.length>100){
             //限制长度，过长截取
             $(".inputSearch").val(search.substring(0,100));
         }*/
        var hotsearch = $(".hotsearch").val();
        if(hotsearch != "" && hotsearch != "undefined" && ($(".hotsearchInput").val() == "" || $(".hotsearchInput").val() == "undefined")){
            $(".hotsearchInput").val(hotsearch);
        }
        $("#mallSearch-form").submit();
    }



</script>
