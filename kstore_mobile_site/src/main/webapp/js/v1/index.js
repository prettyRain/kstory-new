// Initialize your app
var myApp = new Framework7();

// Export selectors engine
var $$ = Dom7;

// Add view
var mainView = myApp.addView('.view-main', {
    // Because we use fixed-through navbar we can enable dynamic navbar
    dynamicNavbar: true

});
$$('.open-about').on('click', function () {
    $$(this).find("input").blur();
    myApp.popup('.popup-about');
});

//
//
// function refresh() {
//     $("#baidu_geo").addClass("baidu_map");
//     $(".baidu_map").html('<span><img src="../../images/v2/Loading_icon2-2.gif">2222正在获取定位</span>');
//     setTimeout(function(){
//         if($("#baidu_geo").next("input").attr("value").length == 0){
//             $("#baidu_geo").removeClass("baidu_map").html('<span onclick="refresh()" style="color: #f05156;"><img src="../../images/v2/indexrefresh@2x.png">定位获取超时,请点击重试</span>');
//         }
//     },10000);
//     baiduPosition(35);
// }
//
// var t;
//
// $$('.position').on('click', function () {
//     $(this).addClass("citychange");
//     $$(this).find("input").blur();
//     myApp.popup('.popup-about2');
//     // 定位城市信息
//     clearTimeout(t);
//     $("#baidu_geo").next("input").attr("value","");
//     $("#baidu_geo").addClass("baidu_map");
//     $(".baidu_map").html('<span><img src="../../images/v2/Loading_icon2-2.gif">1111正在获取定位</span>');
//     t = setTimeout(function(){
//         if($("#baidu_geo").next("input").attr("value").length == 0){
//             $("#baidu_geo").removeClass("baidu_map").html('<span onclick="refresh()" style="color: #f05156;"><img src="../../images/v2/indexrefresh@2x.png">定位获取超时,请点击重试</span>');
//          }
//        },10000);
//         baiduPosition(35);
// });
