/*
 * 作者：shf
 * 时间：2018-2-5
 * 描述：自动定位城市
 *
 */


var t;

function refresh() {
    $("#baidu_geo").addClass("baidu_map");
    $(".baidu_map").html('<span>正在获取定位...</span>');
    setTimeout(function(){
        if($("#baidu_geo").next("input").attr("value").length == 0){
            $("#baidu_geo").removeClass("baidu_map").html('<span onclick="refresh()" style="color: #ff3b2f;">定位获取失败,点击重试</span>');
        }
    },10000);
    baiduPosition(35);
}



$$('.position').on('click', function () {
    $(this).addClass("citychange");
    $$(this).find("input").blur();
    myApp.popup('.popup-about2');
    sessionStorage.setItem("citychange", "yes");
    // 定位城市信息
    clearTimeout(t);
    $("#baidu_geo").next("input").attr("value","");
    $("#baidu_geo").addClass("baidu_map");
    $(".baidu_map").html('<span>正在获取定位...</span>');
    t = setTimeout(function(){
        if($("#baidu_geo").next("input").attr("value").length == 0){
            $("#baidu_geo").removeClass("baidu_map").html('<span onclick="refresh()" style="color: #ff3b2f;">定位获取失败,点击重试</span>');
        }
    },10000);
    baiduPosition(35);
});



function setPresentAddressPrev(){
    var str;
    if($(".search_bg .position").hasClass("citychange")){
        str = $("#baidu_geo").next().val();
        // console.log($("#baidu_geo").next().val())
    }else{
        str = $("#positioncity").val();
        // console.log($("#positioncity").val())
    }

    setPresentAddress(str.split("-")[0],str.split("-")[1]);
}


function positionCity(cityName,districtName){
    $.ajax({
        url:"/setPresentAddress.htm",
        data:{cityName:cityName,districtName:districtName},
        synce:false,
        success:function(data){
            //console.log("data----"+data)
            $(".position span").html(cityName);
            $(".ch_distinctId").val(data)
            if($(".search_bg .position").hasClass("citychange")) {
                window.location.reload();
            }
        }
    })
}

//弹窗提示
function dialognew(tip,cityName,districtName){
    discountExit = dialog({
        width: 260,
        title: '提示',
        content: tip,
        okValue: '切换',
        cancelValue: '暂不',
        ok: function () {
            positionCity(cityName,districtName);
        },
        cancel: function () {
            return true;
        }
    });
    discountExit.showModal();
}


function setPresentAddress(cityName,districtName){
    var cityinfo = $(".popup-about2 .warp span b").text().split("市");
    var citychange = $(".search_bg .position").hasClass("citychange");
    var tips;
    var isarry= $.inArray(cityName.split("市")[0], cityinfo);

    if( isarry == -1 && citychange){
        //不在城市列表中&&定位页
        tips = "您选择的城市暂未开通配送服务，是否切换？";
        dialognew(tips,cityName,districtName)
    }else if($.inArray(cityName.split("市")[0], cityinfo) == -1){
        //不在城市列表中&&非定位页
        if(!(cityName == $("#defaultcity").html())){
            tips = "已检测到您当前在"+cityName+"，该城市未开通配送服务，是否切换？";
            dialognew(tips,cityName,districtName)
        }
    }else if(!citychange){
        //非定位页&&在城市列表中&&城市与默认城市不一样

        if(!(cityName == $("#defaultcity").html())){
            tips = "已检测到您当前在"+cityName+"，是否切换？";
            dialognew(tips,cityName,districtName)
        }
    }else{
        //定位页&&在城市列表中
        positionCity(cityName,districtName)
    }
}




// 定位城市信息
function positions(json, cid) {
    //可以获取到了地理位置，跳转页面，然后在跳转的页面在获取经纬度的值
    //window.location.href = "./index.php?i=5&amp;c=entry&amp;do=list&amp;m=weilive&amp;cid=" + cid + "&amp;lng=" + json['lng'] + "&amp;lat=" + json['lat'];
    //alert(json['lng']);
}


function baiduPosition(cid) {
    if($(".search_bg .position").hasClass("citychange")) {
        $(".baidu_map").html('<span>正在获取定位...</span>');
    }
    var geolocation = new BMap.Geolocation();
    geolocation.getCurrentPosition(function(r) {
        if (this.getStatus() == BMAP_STATUS_SUCCESS) {
            var position = {
                lng: r.point.lng,
                lat: r.point.lat
            }
            if (cid == 'sort') {
                sort(position);
            } else {
                positions(position, cid);
            }
            // console.log('您的位置：' + r.point.lng + ',' + r.point.lat)
            translateCallback(r.point.lng, r.point.lat)
        } else {
            //alert('获取当前位置失败,请确定您开启了定位服务');
            if($(".search_bg .position").hasClass("citychange")){
                $(".baidu_map").html('<span onclick="baiduPosition(35)" style="color: #ff3b2f;">定位获取失败,点击重试</span>');
            }
        }
    }, {
        enableHighAccuracy: true
    });
}

function translateCallback(lng, lat) {
    var latlon = lat + ',' + lng;
    //baidu
    var url = "http://api.map.baidu.com/geocoder/v2/?ak=ItDz5Ey45vZKcyhGCtPCB2L3xzzpkjNN&callback=renderReverse&location=" + latlon + "&output=json&pois=0";
    var xhr = $.ajax({
        type: "GET",
        dataType: "jsonp",
        url: url,
        beforeSend: function() {
            if($(".search_bg .position").hasClass("citychange")){
                $(".baidu_map").html('<span>正在获取定位...</span>');
            }
        },
        success: function(json) {
            if (json.status == 0) {
                var city = json.result.addressComponent.city;
                if($(".search_bg .position").hasClass("citychange")){
                    // console.log(this)
                    $(".baidu_map").siblings("input").val(json.result.addressComponent.city+"-"+json.result.addressComponent.district)
                    $(".baidu_map").html('<span class="close-popup1" onclick="setPresentAddressPrev(this)">'+city.split("市")[0]+'市</span>');
                    $(".city.location").addClass("more");
                }else{
                    $(".position").find("input").val(json.result.addressComponent.city+"-"+json.result.addressComponent.district)
                    setPresentAddressPrev()
                }
            }
        },
        error: function(XMLHttpRequest, textStatus, errorThrown){
            if($(".search_bg .position").hasClass("citychange")) {
                $(".baidu_map").html('<span onclick="baiduPosition(35)" style="color: #ff3b2f;">定位获取失败,点击重试</span>');
            }
        }
    });
//        setTimeout(function(){
//            xhr.abort()
//        },2000)
}



//
// if(!sessionStorage.getItem("citychange")){
//     baiduPosition(35);
//     sessionStorage.setItem("citychange", "yes");
// }

