<div class="new_member_left">
    <div class="title" style="background-color: #666666"><a href="${basePath}/customer/index.html" onclick="_czc.push(['_trackEvent', '我的960', '查看', '个人中心',  'personal_center1']);" id="personal_center1">个人中心</a></div>
    <div class="menu_item">
        <a href="javascript:void(0)" class="item_title down" >
            <span>订单中心</span>
        </a>
        <ul class="item_list" style="display: block;">
            <li class=""><a href="${basePath}/customer/myorder.html" onclick="_czc.push(['_trackEvent', '个人中心', '订单中心', '我的订单',  'my_order1']);" id="my_order1">我的订单</a></li>
            <li class=""><a href="${basePath}/customer/giftorder.html" onclick="_czc.push(['_trackEvent', '个人中心', '订单中心', '积分兑换订单',  'exchange_order1']);" id="exchange_order1">积分兑换订单</a></li>
        <#--<li><a href="${basePath}/customer/marketorders.html">抢购订单</a></li>-->
        <#--<li><a href="${basePath}/customer/marketordergrounp.html">团购订单</a></li>-->
            <li><a href="${basePath}/customer/myfollw.html" onclick="_czc.push(['_trackEvent', '个人中心', '订单中心', '我的关注',  'my_interest1']);" id="my_interest1">我的关注</a></li>
            <li><a href="${basePath}/customer/browserecord.html" onclick="_czc.push(['_trackEvent', '个人中心', '订单中心', '浏览历史',  'borwsing_history1']);" id="borwsing_history1">浏览历史</a></li>
        </ul>
    </div>
    <div class="menu_item">
        <a href="javascript:void(0)" class="item_title down" >
            <span>客户服务</span>
        </a>
        <ul class="item_list" style="display: block;">
            <li><a href="${basePath}/customer/refundlist.html" onclick="_czc.push(['_trackEvent', '个人中心', '客户服务', '取消订单记录',  'cancel_record1']);" id="cancel_record1">取消订单记录</a></li>
            <li><a href="${basePath}/customer/ordercomplain.html" onclick="_czc.push(['_trackEvent', '个人中心', '客户服务', '我的投诉',  'my_complaint1']);" id="my_complaint1">我的投诉</a></li>
        </ul>
    </div>

    <!-- 预存款信息 -->
    <div class="menu_item">
        <a href="javascript:void(0)" class="item_title down" >
            <span>资产中心</span>
        </a>
        <ul class="item_list" style="display: block;">
            <#--<li><a href="${basePath}/deposit/mydeposit.htm">我的预存款</a></li>-->
            <li><a href="${basePath}/customer/mygiftcard.html" onclick="_czc.push(['_trackEvent', '个人中心', '资产中心', '我的礼品卡',  'my_gift_card1']);" id="my_gift_card1">我的礼品卡</a></li>
            <#--<li><a href="${basePath}/deposit/withdraw-list.htm">提现记录</a></li>-->
            <li id="menu_myintegral"><a href="${basePath}/customer/myintegral.html" onclick="_czc.push(['_trackEvent', '个人中心', '资产中心', '我的积分',  'my_bonus_points1']);" id="my_bonus_points1">我的积分</a></li>
            <li id="mycoupon"><a href="${basePath}/mycoupon-1.html" onclick="_czc.push(['_trackEvent', '个人中心', '资产中心', '我的优惠券',  'my_coupons1 ']);" id="my_coupons1">我的优惠券</a></li>
        </ul>
    </div>

    <div class="menu_item">
        <a href="javascript:void(0)" class="item_title down" >
            <span>账户中心</span>
        </a>
        <ul class="item_list" style="display: block;">
            <li><a href="${basePath}/customer/myinfo.html" onclick="_czc.push(['_trackEvent', '个人中心', '账户中心', '账户信息',  'account_information1 ']);" id="account_information1 ">账户信息</a></li>
            <li id="securitycenter"><a href="${basePath}/customer/securitycenter.html" onclick="_czc.push(['_trackEvent', '个人中心', '账户中心', '账户安全',  'account_security1 ']);" id="account_security1 ">账户安全</a></li>
            <li id="consume"><a href="${basePath}/customer/consume.html" onclick="_czc.push(['_trackEvent', '个人中心', '账户中心', '消费记录',  'expense_calendar1']);" id="expense_calendar1">消费记录</a></li>
            <!--
            <li><a href="${basePath}/customer/myintegral.html">我的积分</a></li>
            <li><a href="${basePath}/mycoupon-1.html">我的优惠券</a></li>
            -->
            <li><a href="${basePath}/customer/address.html" onclick="_czc.push(['_trackEvent', '个人中心', '账户中心', '收货地址',  'delivery_address1']);" id="delivery_address1">收货地址</a></li>
        </ul>
    </div>
    <div class="menu_item">
        <a href="javascript:void(0)" class="item_title down" >
            <span>消息中心</span>
        </a>
        <ul class="item_list" style="display: block;">
            <li><a href="${basePath}/customer/comment.html" onclick="_czc.push(['_trackEvent', '个人中心', '消息中心', '商品评价',  'comment_commodity1']);" id="comment_commodity1">商品评价</a></li>
            <li id="consult"><a href="${basePath}/customer/consult.html" onclick="_czc.push(['_trackEvent', '个人中心', '消息中心', '购买咨询',  'purchase_consulting1']);" id="purchase_consulting1">购买咨询</a></li>
            <li><a href="${basePath}/customer/insideletter.html" onclick="_czc.push(['_trackEvent', '个人中心', '消息中心', '站内信息',  'private_messages1']);" id="private_messages1">站内信息</a></li>
        </ul>
    </div>
</div>
<p style="display: none;">
    <script src="https://s13.cnzz.com/z_stat.php?id=1263930585&web_id=1263930585" language="JavaScript">
    //声明_czc对象:
    var _czc = _czc || [];
    //绑定siteid，请用您的siteid替换下方"XXXXXXXX"部分
    _czc.push(["_setAccount", "www.ge960.com"]);
</script>
</p>
<script>

    var href = window.location.href;
    $('.new_member_left a').each(function (index, item) {
        if (href.indexOf($(item).attr('href')) > 0) {
           $(item).parents('li').addClass('cur');
        }
    });

</script>
<!--new_member_left-->