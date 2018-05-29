// // * 作者：shf
// // * 时间：2017-05-22
// // * 描述：唤醒app的相关操作，及app唤醒协议和下载路径
//
// //唤醒协议及下载地址
// var env = {
//     agent: window.navigator.userAgent.toLowerCase(),
//     platform: navigator.platform,
//     openios: 'iOSge960shop://',
//     openand: 'schemedemo://',
//     iosURL: 'itms-apps://itunes.apple.com/app/id1224473452',
//     androidURL: 'http://m.ge960.com/appqrcode.htm',
//     falg: false,
//     isWechat: function() {
//         return this.agent.match(/MicroMessenger/i) == 'micromessenger';
//     },
//     isAndroid: function() {
//         return this.agent.match(/android/i) == 'android';
//     },
//     isIphone: function() {
//         return this.agent.match(/iphone/i) == 'iphone';
//     },
//     isIpad: function() {
//         return this.agent.match(/ipad/i) == 'ipad';
//     },
//     isPc: function () {
//         if(this.platform.indexOf("Win") == 0 || this.platform.indexOf("Mac") == 0){
//             return true
//         }
//     },
//     init: function() {
//         if (env.isWechat()) {
//             //提示打开浏览器
//             // $(".aatips").show()
//         } else if (env.isIphone()) {
//             //进入appstore
//             window.location.href = env.iosURL;
//
//         } else {
//             window.location.href = env.androidURL;
//         }
//     }
// }
// $(function() {
//     if(typeof(Storage)!=="undefined")
//     {
//         try {
//         localStorage.setItem('localStorage', 1);
//         localStorage.removeItem('localStorage');
//     } catch (e) {
//         Storage.prototype._setItem = Storage.prototype.setItem;
//         Storage.prototype.setItem = function() {};
//         alert('无痕模式浏览会影响个别功能使用，建议切换为常规模式。');
//     }
//         var aclose = sessionStorage.getItem("aclose");
//         var iarouse = sessionStorage.getItem("iarouse");
//
//         if(!env.isWechat() && !env.isIpad() && !env.isPc()  &&  aclose == null ){
//             aashow();
//         }
//         if(iarouse == null && !env.isIpad()){
//             //一进入浏览器就执行下面的代码
//             if (env.isIphone()) {
//                 window.location.href = env.openios;
//                 sessionStorage.setItem("iarouse", "yes");
//             } else if (env.isAndroid()) {
//                 window.location.href = env.openand;
//                 sessionStorage.setItem("iarouse", "yes");
//             };
//         }
//         // 下载条点击消失
//         $(".aaclose").click(function(){
//             aaclose();
//             sessionStorage.setItem("aclose", "yes");
//         })
//     } else {
//         $(".aaclose").click(function(){
//             aaclose();
//         })
//     };
//     function downApp(){
//         if (env.isIphone()) {
//             window.location.href = env.openios;
//         }else {
//             window.location.href = env.openand;
//         }
//         $(document).on('visibilitychange webkitvisibilitychange',function(){
//             env.falg = true;
//         });
//     }
// //点击下载按钮执行
//     $(".aa-down").click(function(){
//         downApp();
//         var timer = setTimeout(function(){
//             if (!env.falg){
//                 //解绑
//                 $(document).unbind( "visibilitychange webkitvisibilitychange")
//                 env.falg = false;
//                 if (env.isIphone()) {
//                     window.location.href = env.iosURL;
//                 } else {
//                     window.location.href = env.androidURL;
//                 }
//             }
//         },2000);//如果唤醒app又进入appstore,唤醒太慢超过秒数了
//     })
// })