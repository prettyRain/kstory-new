var infoList = document.getElementById("infoList"),
    //mockHTML = infoList.innerHTML,
    scroller = document.getElementById("scroller"),
    header = document.getElementById("header"),
    userLogo = document.getElementById("user-logo-wrapper"),
    loading = false,
    alloyTouch = null;

Transform(scroller, true);
Transform(header);
header.originY = -102;
header.translateY = -102;
Transform(userLogo);


alloyTouch = new AlloyTouch({
    touch: "#wrapper",
    vertical: true,
    target: scroller,
    property: "translateY",
    sensitivity:0.8,
    // step: 45,
    maxSpeed: 0.1,
    outFactor: 0.7,
    min: 160 * -20 + window.innerHeight -70,
    max: 0,
    touchStart: function (ev) {
        reastMin();
    },
    touchMove: function (ev, value) {

    },
    touchEnd:function(evt,value){

    },
    animationEnd:function(value){

    },
    // lockDirection: false,
    change: function (v) {
        //手指从下往上滑，
        var scaleY;
        var navopacity = 1-((100 + v) / 100);
        if(navopacity>  1){
            navopacity = 1;
        }else if(navopacity<0){
            navopacity = 0;
        }
        // console.log(v)
        $('.top-nav').css('opacity',navopacity);
        $(".setting img").eq(1).css('opacity',navopacity);
        $(".personal-details").css('opacity',1-navopacity);

        if (v < 0) {
            scaleY = (200 + v) / 200;
            header.scaleY = scaleY;
            userLogo.scaleX = userLogo.scaleY = scaleY;
            userLogo.translateY = v / 1.7;
        }
        else {
            scaleY = 1 + v / 200;
            //header.scaleY = scaleY;
            header.scaleY = header.scaleX = scaleY;
            userLogo.scaleX = userLogo.scaleY = scaleY;
            userLogo.translateY = v / 1.7;
        }
    }
});


function loadMore() {
    setTimeout(function () {
        // infoList.innerHTML += mockHTML;
        loading = false;
        reastMin();
    }, 500)
}

function reastMin() {
    alloyTouch.min = -1 * parseInt(getComputedStyle(scroller).height) + window.innerHeight - 70;
}

document.addEventListener("touchmove", function (evt) {
    evt.preventDefault();
}, false);