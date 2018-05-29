<#assign basePath=request.contextPath>
<!DOCTYPE html>
<!--suppress ALL -->
<html>
<#--<link rel="stylesheet" href="${basePath}/css/tip-newbox.css">-->
<link rel="stylesheet" href="${basePath}/css/ui-dialog.css">
<style>
    .popup-about2 .search-close2{
        padding: 20px 0 10px 15px;
        background: #fff;
        position: fixed;
        top: 0;
        width:100%;
    }
    .popup-about2 .city{
        background: #fff;
        margin-top: 20px;
        padding: 22px 0;
    }
    .city.more{
        background: #fff url(../../images/icon_v1.0/btn_more_right@2x.png) no-repeat 6.72rem center;
        background-size: .44rem .44rem;
    }
    .popup-about2 .search-close2 img{  height:12px;  width:12px;  }
    .popup-about2 .city p{
        height: .44rem;
        line-height: .44rem;
        margin: 0 38px;
        font-size: .22rem;
        color: #7f7f7f;
        letter-spacing: 0.5px;
    }
    .popup-about2 .city>span{  display: inline-block;
        font-size: .3rem;
        color: #030303;
        font-weight: 600;
        letter-spacing: 0.5px;
        margin: 0 0 0 38px;
        width: 100%;
    }
    .popup-about2 .city>span img{  width:13px;  height:13px;  margin-right: 5px;     float: left;  margin-top: 5px; }
    .popup-about2 .city .warp{  margin:0 .18rem; 0 .18rem;  }
    .popup-about2 .city .warp>span{
        position: relative;
        display: block;
        color: #333;  font-size:13px;
        width:7.14rem;
        height:1.64rem;
        overflow: hidden;
        text-align: center;  line-height: 1.64rem;  border-radius: 5px;  float: left;
        margin:0 .4rem .2rem 0;
        background:#fff url(../../images/icon_v1.0/btn_more_right@2x.png) no-repeat 6.52rem center;
        background-size: .44rem .44rem;
    }
    .popup-about2 .city .warp .close-popup1 img{
        position: absolute;
        left:.48rem;
        top:.3rem;
        width:1.04rem;
        height:1.04rem;
    }
    .popup-about2 .city .warp .close-popup1 p,.popup-about2 .city .warp .close-popup1 b{
        position: absolute;
        left:2.04rem;
        top:.44rem;
        font-size: .3rem;
        color: #000000;
        letter-spacing: 0.5px;
        width:auto;
        height:.36rem;
        line-height:.36rem;

    }
    .popup-about2 .city .warp .close-popup1 p{
        top:.86rem;
        font-size: 12px;
        color: #7f7f7f;
        margin:0;
        padding:0;
    }
    .popup-about2  .page{  background: #f7f7f7; overflow-y: scroll;  overflow-x: hidden; }
    .clearfixed:after{content:".";clear:both;display:block;height:0;visibility:hidden}
    #baidu_geo span{
        height: 22px;
        line-height: 22px;
        display: inline-block;
        width: 100%;
    }
    .popup-about2 .city.choose{
        font-size: 13px;
        color: #6C6C6C;
        letter-spacing: 0.5px;
        background: #f7f7f7;
        margin:0;
        padding-top: 0;
    }
    .popup-about2 .city.choose p{
        height:auto;
        line-height: normal;
        padding: 10px 0;
        font-size: 13px;
        color: #7f7f7f;
        letter-spacing: 0.5px;

    }
    .ui-popup-backdrop,.ui-popup,.ui-popup-modal,.ui-popup-show,.ui-popup-focus{
        z-index: 99999!important;
    }
    .citynavbar{
        height:auto;
    }

</style>
<div class="popup popup-about2">
	<div class="view">
        <div class="navbar citynavbar">
            <div class="close-popup search-close2"><img class="seach" src="/images/v3/btn_close@2x.png" alt=""/></div>

        </div>
		<div class="pages">
			<div class="page" style="padding-bottom:0;">
                <#--<div class="close-popup search-close2"><img class="seach" src="/images/v3/btn_close@2x.png" alt=""/></div>-->
                <div class="city location" >
                    <p style="border-top: none;">当前定位城市</p>
                    <span class="info baidu_map" id="baidu_geo"><span><img src="../../images/v2/Loading_icon2-2.gif">正在获取定位</span></span>
                    <input type="hidden" class="positioncity" value="">
                    <img src="../../images/v2/indexrefresh@2x.png" style="display: none;">
                </div>
                <div class="city choose">
                   <p>选择城市</p>
                    <div class="warp">

                    <#if map?? && map.addressList??>
                        <#list map.addressList as addressList>
                            <span class="close-popup1" onclick="setPresentAddress('${addressList.city.cityName}','${addressList.district.districtName}')">
                                <b>${addressList.city.cityName}</b>
                                <p>目前已开通配送服务</p>
                                <img src="../../images/v3/Group@2x.png">
                                <input type="hidden" value="${addressList.district.districtName}">
                            </span>
                        </#list>
                    </#if>
                   <#--<#if map?? && map.addressList??>-->
                       <#--<#list map.addressList as addressList>-->
                           <#--<span class="close-popup1" onclick="setPresentAddress('${addressList.city.cityName}','${addressList.district.districtName}')">${addressList.city.cityName}<input type="hidden" value="${addressList.district.districtName}"></span>-->
                       <#--</#list>-->
                   <#--</#if>-->
                       <div class="clearfixed"></div>
                   </div>
                </div>
			</div>
		</div>
	</div>
</div>
<#--<script type="text/javascript" src="${basePath}/js/v1/framework7.min.js"></script>-->
<#--<script type="text/javascript" src="${basePath}/js/tip-newbox.js"></script>-->

<script type="text/javascript" src="${basePath}/js/v1/index.js"></script>
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
                        docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
                    }
                };

        if (!doc.addEventListener) return;
        win.addEventListener(resizeEvt, recalc, false);
        doc.addEventListener('DOMContentLoaded', recalc, false);
    })(document, window);
//    $(".choose img").eq(0).attr("src","../../images/v3/icon_beijing@2x.png")
//    $(".choose img").eq(1).attr("src","../../images/v3/icon_wukanchabu@2x.png")

    var citylist = $(".city.choose span").find("b");
    for(var i=0;i<citylist.length;i++){
        citylistname = $(citylist).eq(i).html()
        if(citylistname == "北京市"){
            $(".choose img").eq(i).attr("src","../../images/v3/icon_beijing@2x.png")
        }else if(citylistname == "乌兰察布市"){
            $(".choose img").eq(i).attr("src","../../images/v3/icon_wukanchabu@2x.png")
        }
    }

    $(".close-popup1").on("click",function(){
        $(".close-popup1").css("background-color","#fff");
        $(this).css("background-color","#eee");
    })

//    var citychange=$(".search_bg .position").hasClass("citychange");
//    function setPresentAddressPrev(){
//          var str = $("#baidu_geo").next().val();
//          console.log($("#baidu_geo").next().val())
//          setPresentAddress(str.split("-")[0],str.split("-")[1]);
//    }
//
//
//    function positionCity(cityName,districtName){
//            $.ajax({
//                url:"/setPresentAddress.htm",
//                data:{cityName:cityName,districtName:districtName},
//                synce:false,
//                success:function(data){
//                    console.log("data"+data)
//                    if($(".search_bg .position").hasClass("citychange")) {
//                        window.location.reload();
//                    }
//                }
//            })
//    }
//
//    //弹窗提示
//    function dialognew(tip,cityName,districtName){
//        discountExit = dialog({
//            width: 260,
//            title: '提示',
//            content: tip,
//            okValue: '确定',
//            cancelValue: '取消',
//            ok: function () {
//                positionCity(cityName,districtName)
//            },
//            cancel: function () {
//                return true;
//            }
//        });
//        discountExit.showModal();
//    }
//
//
//    function setPresentAddress(cityName,districtName){
//        var cityinfo = $(".popup-about2 .warp span b").text().split("市");
//        var citychange = $(".search_bg .position").hasClass("citychange");
//        var tips;
//        var isarry= $.inArray(cityName.split("市")[0], cityinfo)
//        if( isarry == -1 && citychange){
//            //不在城市列表中&&定位页
//            tips = "您选择的该地无服务，切换？"
//            dialognew(tips,cityName,districtName)
//        }else if($.inArray(cityName.split("市")[0], cityinfo) == -1){
//            //不在城市列表中&&非定位页
//            tips = "检测您在"+cityName+"，该地无服务，切换？"
//            dialognew(tips,cityName,districtName)
//        }else if(!citychange){
//            //非定位页&&在城市列表中
//            tips = "检测您在"+cityName+"，切换？"
//            dialognew(tips,cityName,districtName)
//        }else{
//            //定位页&&在城市列表中
//            positionCity(cityName,districtName)
//        };
//    };
//
//    $(".choose img").eq(0).attr("src","../../images/v3/icon_beijing@2x.png")
//    $(".choose img").eq(1).attr("src","../../images/v3/icon_wukanchabu@2x.png")
//
//
//    // 定位城市信息
//    function positions(json, cid) {
//        //可以获取到了地理位置，跳转页面，然后在跳转的页面在获取经纬度的值
//        //window.location.href = "./index.php?i=5&amp;c=entry&amp;do=list&amp;m=weilive&amp;cid=" + cid + "&amp;lng=" + json['lng'] + "&amp;lat=" + json['lat'];
//        //alert(json['lng']);
//    };
//    function baiduPosition(cid) {
//        if($(".search_bg .position").hasClass("citychange")) {
//            $(".baidu_map").html('<span><img src="../../images/v2/Loading_icon2-2.gif">3333正在获取定位</span>');
//        }
//        var geolocation = new BMap.Geolocation();
//        geolocation.getCurrentPosition(function(r) {
//            if (this.getStatus() == BMAP_STATUS_SUCCESS) {
//                var position = {
//                    lng: r.point.lng,
//                    lat: r.point.lat
//                }
//                if (cid == 'sort') {
//                    sort(position);
//                } else {
//                    positions(position, cid);
//                }
//                console.log('您的位置：' + r.point.lng + ',' + r.point.lat)
//                translateCallback(r.point.lng, r.point.lat)
//            } else {
//                //alert('获取当前位置失败,请确定您开启了定位服务');
//                if($(".search_bg .position").hasClass("citychange")){
//                    $(".baidu_map").html('<span onclick="baiduPosition(35)" style="color: #f05156;"><img src="../../images/v2/indexrefresh@2x.png">111定位获取失败,请点击重试</span>');
//                }
//            }
//        }, {
//            enableHighAccuracy: true
//        });
//    };
//
//    function translateCallback(lng, lat) {
//        var latlon = lat + ',' + lng;
//        //baidu
//        var url = "http://api.map.baidu.com/geocoder/v2/?ak=ItDz5Ey45vZKcyhGCtPCB2L3xzzpkjNN&callback=renderReverse&location=" + latlon + "&output=json&pois=0";
//        var xhr = $.ajax({
//            type: "GET",
//            dataType: "jsonp",
//            url: url,
//            beforeSend: function() {
//                if($(".search_bg .position").hasClass("citychange")){
//                    $(".baidu_map").html('<span><img src="../../images/v2/Loading_icon2-2.gif">4444正在获取定位</span>');
//                }
//            },
//            success: function(json) {
//                if (json.status == 0) {
//                    var city = json.result.addressComponent.city;
//                    if($(".search_bg .position").hasClass("citychange")){
//                        console.log(this)
//                        $(".baidu_map").siblings("input").val(json.result.addressComponent.city+"-"+json.result.addressComponent.district)
//                        $(".baidu_map").html('<span class="close-popup1" onclick="setPresentAddressPrev(this)">'+city.split("市")[0]+'市</span>');
//                    }else{
//                        setPresentAddressPrev()
//                    }
//                }
//            },
//            error: function(XMLHttpRequest, textStatus, errorThrown){
//                if($(".search_bg .position").hasClass("citychange")) {
//                    $(".baidu_map").html('<span onclick="baiduPosition(35)" style="color: #f05156;"><img src="../../images/v2/indexrefresh@2x.png">333定位获取失败,请点击重试</span>');
//                }
//            }
//        });
////        setTimeout(function(){
////            xhr.abort()
////        },2000)
//    };

</script>







