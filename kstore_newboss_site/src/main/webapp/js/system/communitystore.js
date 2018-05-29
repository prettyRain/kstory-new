$(function(){
    /* 为选定的select下拉菜单开启搜索提示 END */
    $("#addCommunityStoreForm").validate();
    $("#searchCommunityStoreForm").validate();
    $("#editCommunityStoreForm").validate();
});

/**
 * 弹框显示添加上门自提设置
 */
function showAddCommunityStore() {
    queryAllProvince();
    $("#cities").html("<option value=''>选择城市</option>");
    $("#districts").html("<option value=''>选择区县</option>");
    $('select[data-live-search="true"]').select2();
    $('#addCommunityStore').modal('show')
}
/**
 * 添加社区店
 */
function submitAddCommunityStoreForm() {
    if( $("#addCommunityStoreForm").valid()){
        $("#addCommunityStoreForm").submit();
     }
}
/**
 * 搜索社区店
 */
function searchCommunityStore() {
    $("#searchCommunityStoreForm").submit();
}
/**
 * 弹框显示社区店编辑框
 * @param communityStoreId 社区店id
 */
function showEditCommunityStoreForm(communityStoreId) {
    $("#communityStoreId").val(communityStoreId);
    var CSRFToken = $("#CSRFToken").val();
    $.ajax({
        url:'selectCommunityStore.htm?CSRFToken='+CSRFToken+'&communityStoreId='+communityStoreId,
        success:function(data) {
            //填充值
            $("#communityStoreName").val(data.communityStoreName);
            $("#contact").val(data.contact);
            $("#contactMobile").val(data.contactMobile);
            $("#communityStoreAddress").val(data.communityStoreAddress);
            if(data.openFlag==1) {
                $("#open1").click();
            } else {
                $("#open2").click();
            }

            $("#editTemp3").val(data.provinceId);
            $("#editTemp4").val(data.cityId);
            $("#editTemp5").val(data.districtId);
            editQueryAllProvince(-1);
        }
    });
    $('#editCommunityStore').modal('show')
}
/**
 * 确定修改社区店信息
 */
function submitEditCommunityStoreForm() {
    if($("#editCommunityStoreForm").valid()){
        $("#editCommunityStoreForm").submit();
    }

}

/**
 * 修改社区店启用状态
 * @param logComId 社区店主键id
 */
function changeUserdStatus(logComId){
    var CSRFToken = $("#CSRFToken").val();
    location.href = "changeUserdStatucForLogCom.htm?CSRFToken="+CSRFToken+"&logComId="+logComId;
}


/*查询所有的省份*/
function queryAllProvince(){
    $.get("queryAllProvince.htm?CSRFToken="+$("#CSRFToken").val(),function(data){
        var provinces="<option value=''>选择省份</option>";
        //$("#cities_county").html(provinces);
        for(var i=0;i<data.length;i++){
            provinces+="<option value='"+data[i].provinceId+"'>"+data[i].provinceName+"</option>";
        }
        $("#provinces").html(provinces);
        $('select[data-live-search="true"]').select2();
    });
}


/*根据省份ID查询城市ID*/
function queryCityByProvinceId(province){
    $("#provinces").val($(province).val());
    //设置省份名称
    $("#districts").html("<option value=''>选择区县</option>");

    $.get("queryCityByProvinceId.htm?CSRFToken="+$("#CSRFToken").val()+"&provinceId="+($(province).val()),function(data){
        var provinces="<option value=''>选择城市</option>";
        //$("#districts").html(provinces);
        for(var i=0;i<data.length;i++){
            provinces+="<option value='"+data[i].cityId+"'>"+data[i].cityName+"</option>";
        }
        $("#cities").html(provinces);
        $('select[data-live-search="true"]').select2();
    });
}

/*根据城市ID查询区县ID*/
function queryDistrictByCityId(city){
    $("#cities").val($(city).val());
    //设置城市名称
    $("#temp2").val($(city).find("option:selected").text());
    //城市id
    $("#temp5").val($(city).find("option:selected").val());


    $.get("queryDistrictByCityId.htm?CSRFToken="+$("#CSRFToken").val()+"&cityId="+($(city).val()),function(data){
        var provinces="<option value=''>选择区县</option>";
        for(var i=0;i<data.length;i++){

            provinces+="<option value='"+data[i].districtId+"'>"+data[i].districtName+"</option>";
        }

        $("#districts").html(provinces);
        $('select[data-live-search="true"]').select2();
    });
}

/*编辑时查询所有的省份*/
function editQueryAllProvince(obj){
    if(obj==-1){
        provinceId=$("#editTemp3").val()
    }else{
        provinceId=$(obj).val();
    }
    $.get("queryAllProvince.htm?CSRFToken="+$("#CSRFToken").val(),function(data){
        var provinces="<option value=''>选择省份</option>";
        //$("#cities_county").html(provinces);

        for(var i=0;i<data.length;i++){
            if(provinceId==data[i].provinceId){
                provinces+="<option selected value='"+data[i].provinceId+"' >"+data[i].provinceName+"</option>";
                editQueryCityByProvinceId();
            }
            else{
                provinces+="<option value='"+data[i].provinceId+"' >"+data[i].provinceName+"</option>";
            }
        }
        $("#province").html(provinces);
        $('select[data-live-search="true"]').select2();
    });
}

/*编辑时根据省份ID查询城市ID*/
function editQueryCityByProvinceId(obj){
    var  provinceId=$(obj).val();
    var flag=0;
    if(isNaN(provinceId)){
        flag=1;
        provinceId=$("#editTemp3").val();
    }
    var cityId=$("#editTemp4").val();
    $.get("queryCityByProvinceId.htm?CSRFToken="+$("#CSRFToken").val()+"&provinceId="+provinceId,function(data){
        var provinces="";
        //$("#districts").html(provinces);
        for(var i=0;i<data.length;i++){
            if(cityId==data[i].cityId){
                provinces+="<option selected value='"+data[i].cityId+"'>"+data[i].cityName+"</option>";
                editQueryDistrictByCityId(obj);
            }else{
                provinces+="<option value='"+data[i].cityId+"'>"+data[i].cityName+"</option>";
            }
        }
        $("#city").html(provinces);
        $('select[data-live-search="true"]').select2();

        //城市名称
        $("#editTemp2").val($("#city").find("option:selected").text());

        //城市id
        $("#editTemp5").val($("#city").find("option:selected").val());
        //省份名称
        $("#editTemp1").val($("#province").find("option:selected").text());
        //省份id
        $("#editTemp4").val($("#province").find("option:selected").val());
        //强制掉onchange 事件
        if(flag==0) {
            $("#city").change();
        }
    });
}

/*编辑时根据城市ID查询区县ID*/
function editQueryDistrictByCityId(obj){
    var  cityId=$(obj).val();
    var flag=0;
    if(isNaN(cityId)){
        cityId=$("#editTemp4").val();
        var districtId=$("#editTemp5").val();
        flag=1;
    }
    if(!isNaN(cityId)&& "undefined" != typeof cityId && cityId !=null) {
        $.get("queryDistrictByCityId.htm?CSRFToken="+$("#CSRFToken").val()+"&cityId="+cityId,function(data){
            var provinces="";
            for(var i=0;i<data.length;i++){
                if(districtId==data[i].districtId){

                    provinces+="<option selected value='"+data[i].districtId+"'>"+data[i].districtName+"</option>";

                }else{
                    provinces+="<option value='"+data[i].districtId+"'>"+data[i].districtName+"</option>";
                }
            }
            $("#district").html(provinces);
            $('select[data-live-search="true"]').select2();
            //设置区县名称
            $("#editTemp3").val($("#district").find("option:selected").text());
            $("#districtId").val($("#district").find("option:selected").val());
            //城市名称
            $("#editTemp2").val($("#city").find("option:selected").text());
            //城市id
            $("#editTemp5").val($("#city").find("option:selected").val());
            if(flag=0){
                $("#district").change(obj);
            }
        });
    }
}

/**
 * 选择地区时，设置地区名称
 * @param district
 */
function selectDistrict(district) {
    //设置县区名称-添加用
    $("#temp3").val($(district).find("option:selected").text());
    //编辑用
    $("#editTemp3").val($(district).find("option:selected").text());
    $("#districtId").val($(district).val());
}
