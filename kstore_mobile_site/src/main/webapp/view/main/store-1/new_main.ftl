<#assign basePath=request.contextPath>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, minimal-ui">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>中国960官方商城</title>
    <link rel="stylesheet" href="${basePath}/css/v1/css/index.css">

    <link rel="stylesheet" href="${basePath}/css/v1/css/css.css">
    <#include "app.ftl"></include>

    <script>
        (function (doc, win) {
            var docEl = doc.documentElement,
                    resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
                    recalc = function () {
                        var clientWidth = docEl.clientWidth;
                        if (!clientWidth) return;
                        if(clientWidth>=640){
                            docEl.style.fontSize = '100px';
                        }else{
                            docEl.style.fontSize = 100 * (clientWidth / 640) + 'px';
                        }
                    };

            if (!doc.addEventListener) return;
            win.addEventListener(resizeEvt, recalc, false);
            doc.addEventListener('DOMContentLoaded', recalc, false);
        })(document, window);
    </script>
</head>


<body>
<div class="views">
    <div class="view view-main">
        <div class="navbar">
            <div class="navbar-inner">
                <div class="left logo"></div>
                <div class="center sliding"><input type="text" value=""  placeholder="请输入商品名称"><img class="seach" src="img/seach.png" alt=""/></div>
                <div class="right">
                    <a href="#" data-panel="right"  class="link icon-only open-panel"> <i class="icon icon-bars"></i></a>

                </div>

            </div>
        </div>

        <div class="pages navbar-through toolbar-through">
            <div data-page="index" class="page">
                <div class="page-content">
                    <%--  banner--%>
                    <div id="homePromote" class="pagingArea">
                        <header>
                            <div id="slider" class="swipe" style="visibility: visible;">
                                <div class="swipe-wrap" id="bannerDIV">


                                </div>
                            </div>
                            <nav>
                                <ul id="position">


                                </ul>
                            </nav>
                        </header>
                    </div>
                    <div class="content-block-menu">
                        <div id="addfour">
                            <a href="javascript:;" class="tab-link menu1"><span class="tabbar-label">食品荟萃</span> <i class="icon menu-1"></i></a>
                            <a href="javascript:;" class="tab-link menu2"> <span class="tabbar-label">饮品总汇</span><i class="icon menu-2"></i></a>
                            <a href="javascript:;" class="tab-link menu3"><span class="tabbar-label">购物中心</span> <i class="icon menu-3"></i></a>
                            <a href="javascript:;" class="tab-link menu4"> <span class="tabbar-label">大药房</span><i class="icon menu-4"></i></a>
                        </div>
                    </div>
                    <div class="content-block-list content-block-menu" id="zhuantiDIV">

                    </div>

                </div>
            </div>
        </div>

        <div class="toolbar tabbar tabbar-labels">
            <div class="toolbar-inner">
                <a href="#view-1" class="tab-link active"> <i class="icon tabbar-demo-icon-1"></i><span class="tabbar-label">首页</span></a>
                <a href="#view-2" class="tab-link"><i class="icon tabbar-demo-icon-2"></i><span class="tabbar-label">分类</span></a>
                <a href="#view-3" class="tab-link"> <i class="icon tabbar-demo-icon-3"><span class="badge bg-red">4</span></i><span class="tabbar-label">购物车</span></a>
                <a href="#view-4" data-panel="left" class="tab-link open-panel"> <i class="icon tabbar-demo-icon-4"></i><span class="tabbar-label">我的</span></a>

            </div>
        </div>
    </div>
</div>
${mobIndexHtml}
<script type="text/javascript" src="${basePath}/js/v1/framework7.min.js"></script>
<script type="text/javascript" src="${basePath}/js/v1/index.js"></script>
<script src="${basePath}/js/v1/swipe.js"  type="text/javascript"></script>
<script type="text/javascript">

    var bullets = document.getElementById('position').getElementsByTagName('li');
    $(function(){
        /*<figure>
             <div class="wrap">
              <a href="javascript:;" class="image" ><img src="img/list.jpg"></a>
             </div>
          </figure>*/
        //banner
        var bannerDiv=$('#bannerDIV');
        var positonDiv=$('#position');
        alert($('.swiper-slide').size());
        $('.swiper-slide').each(function(index,item){
            var _this=$(item);
            var href=_this.children('a').attr("href");
            var src=_this.find('img').attr("src");
            var bannersb='<figure><div class="wrap"><a href="'+href+'" class="external"><img src="'+src+'"></a></div></figure>';
            bannerDiv.append(bannersb);
            var positonsb=$('<li></li>');
            positonDiv.append(positonsb);

        });
        //将第一个加上on状态
        $('#position li').eq(0).addClass("on");

        //初始化banner
        var slider = Swipe(document.getElementById('slider'), {
            auto: 3000,
            continuous: true,
            callback: function(pos) {
                var i = bullets.length;
                while (i--) {
                    bullets[i].className = ' ';
                }

                bullets[pos].className = 'on';
            }
        });
        //专题
        var count=0;
        var zhuantiDIV=$('#zhuantiDIV');
        var zhuantidiv;
        $('.zhuanti').each(function(i,el){
            $(el).children('a').each(function(index,item){
                if(count%3==0){
                    //当够三个专题的时候 换行
                    zhuantidiv=$("<div></div>");
                    zhuantiDIV.append(zhuantidiv);
                }
                var sb='';
                count++;
                var _this=$(item);
                var spanhtml=_this.children('span').html();
                var href=_this.attr("href");
                var img=_this.attr("data-img");

                sb+='<a href="'+href+'" class="tab-link"><i class="icon"><img src="'+img+'"/></i><span class="tabbar-label">'+spanhtml+'</span></a>';
                zhuantidiv.append(sb);
            })
        })

    })
</script>




</body>
</html>
