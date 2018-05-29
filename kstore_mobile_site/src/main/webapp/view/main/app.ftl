
<#assign basePath=request.contextPath>
<link rel="stylesheet" href="${basePath}/js/v1/isscroll/swiper.css">
<script type="text/javascript" src="${basePath}/js/v1/jquery.min.js"></script>
<script src="${basePath}/js/v1/960-utils.js"></script>
<script src="${basePath}/js/v1/swiper.js"  type="text/javascript"></script>
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
    $(function(){
        //滑动导航
        var swiper = new Swiper('.swiper-container', {
            pagination: '.swiper-pagination',
            paginationClickable: true
        });
    })
</script>