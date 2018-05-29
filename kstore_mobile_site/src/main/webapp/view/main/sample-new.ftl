<!DOCTYPE html>
<#assign basePath=request.contextPath>
<html>
    <head>
        <title>微信Js API Demo：简便模式</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="dns-prefetch" href="http://mmbiz.qpic.cn">
        <link rel="dns-prefetch" href="http://res.wx.qq.com">
        <meta name="viewport" content="width=device-width,height=device-height,inital-scale=1.0;">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="black">
        <meta name="format-detection" content="telephone=no">
        <style type="text/css">
            p {
                padding: 5px 10px;
            }
        </style>

        <script type="text/javascript" src="/js/v1/WeixinApi.js?v=4.3"></script>
    </head>
    <body>
        <p>这是一个测试页面！请直接分享到微信好友、朋友圈、腾讯微博看效果吧！（async为false，即：分享过程中，wxData是固定的，不会被修改）</p>

        <p>
            <a href="?" id="refresh">点击这里刷新！！！！</a>
        </p>

        <script type="text/javascript">

            // 开启Api的debug模式
            WeixinApi.enableDebugMode();

            // 给按钮增加click事件：请不要太纠结这个写法，demo而已
            var addEvent = function(elId,listener){
                document.getElementById(elId)
                        .addEventListener('click',function(e){
                            if(!window.WeixinApi || !window.WeixinJSBridge) {
                                alert('请确认您是在微信内置浏览器中打开的，并且WeixinApi.js已正确引用');
                                e.preventDefault();
                                return false;
                            }
                            listener(this,e);
                        },false);
            };

            // 刷新
            addEvent('refresh',function(el,e){
                e.preventDefault();
                location.replace('?' + Math.random(),true);
            });

            // 微信分享的数据
            var wxData = {
                "appId": "wx54348d130baacafd", // 服务号可以填写appId
                "imgUrl" : '${basePath}/images/v1/img/1.jpg',
                "link" : 'http://www.baidufe.com',
                "desc" : '大家好，我是Alien，Web前端&Android客户端码农，喜欢技术上的瞎倒腾！欢迎多交流',
                "title" : "Hell,title"
            };

            // 分享的回调
            var wxCallbacks = {
                // 收藏操作是否触发回调，默认是开启的
                favorite : false,

                // 分享操作开始之前
                ready : function() {
                    // 你可以在这里对分享的数据进行重组
                    alert("准备分享");
                },
                // 分享被用户自动取消
                cancel : function(resp) {
                    // 你可以在你的页面上给用户一个小Tip，为什么要取消呢？
                    alert("分享被取消，msg=" + resp.err_msg);
                },
                // 分享失败了
                fail : function(resp) {
                    // 分享失败了，是不是可以告诉用户：不要紧，可能是网络问题，一会儿再试试？
                    alert("分享失败，msg=" + resp.err_msg);
                },
                // 分享成功
                confirm : function(resp) {
                    // 分享成功了，我们是不是可以做一些分享统计呢？
                    alert("分享成功，msg=" + resp.err_msg);
                },
                // 整个分享过程结束
                all : function(resp,shareTo) {
                    // 如果你做的是一个鼓励用户进行分享的产品，在这里是不是可以给用户一些反馈了？
                    alert("分享" + (shareTo ? "到" + shareTo : "") + "结束，msg=" + resp.err_msg);
                }
            };
            WeixinApi.share(wxData,wxCallbacks);

        </script>
    </body>
</html>
