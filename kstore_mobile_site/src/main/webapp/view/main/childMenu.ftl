<#assign basePath=request.contextPath>
<style>
    .badge {
        font-size: 13px;
        display: inline-block;
        color: #fff;
        background: red;
        border-radius: 20px;
        padding: 0 6px;
        height: 20px;
        line-height: 20px;
        box-sizing: border-box;
        text-align: center;
    }
</style>
<div class="toolbar tabbar tabbar-labels" style="position: fixed;left: 0;bottom: 0;">
    <div class="toolbar-inner" >
        <a href="${basePath}/main.html" class="external tab-link active"> <i class="icon tabbar-demo-icon-1"></i><span class="tabbar-label">首页</span></a>
        <a href="${basePath}/cates.html" class="external tab-link"><i class="icon tabbar-demo-icon-2"></i><span class="tabbar-label">分类</span></a>
        <a href="${basePath}/myshoppingmcart.html" class="external tab-link"> <i class="icon tabbar-demo-icon-3"></i><span class="tabbar-label">购物车</span></a>
        <a href="${basePath}/customercenter.html" data-panel="left" class="external tab-link open-panel"> <i class="icon tabbar-demo-icon-4"></i><span class="tabbar-label">我的</span></a>

    </div>
</div>
<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?94d81cec8c55272bd7081c5126331fc1";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>