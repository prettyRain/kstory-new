<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<meta content="telephone=no" name="format-detection">
<link rel="stylesheet" href="${basePath}/css/v1/mycss/framework7.ios.min.css">
<link rel="stylesheet" href="${basePath}/css/v1/mycss/my.css">
<link rel="stylesheet" href="${basePath}/css/v1/mycss/css.css">
<script type="text/javascript" src="${basePath}/js/v1/jquery.min.js"></script>


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
                        docEl.style.fontSize =100 * (clientWidth / 640) + 'px';
                    }
                };

        if (!doc.addEventListener) return;
        win.addEventListener(resizeEvt, recalc, false);
        doc.addEventListener('DOMContentLoaded', recalc, false);
    })(document, window);
</script>
<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?94d81cec8c55272bd7081c5126331fc1";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>