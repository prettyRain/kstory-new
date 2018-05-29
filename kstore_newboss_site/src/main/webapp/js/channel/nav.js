
function showNavGoodsList(obj){
    $("#navIdGoods").val(obj);
    // $("#storeyTagId").val("");
    $('.nav_good_set').show();
    $('.nav_set').hide();
    $('.floor_set').hide();
    $("#addGoodsType").val('nav');
    $("#floorGoods").html('添加导航热销商品');
    showNavGoods();
}

function showNavGoods(pageNo){

    // $("#navId").val(navId);
    var pageSize=10;
    if($("#showChannelSotreyOpetion").val()!=null){
        pageSize=$(showNavGoodsOpetion).val();
    }

    $.post("querychannelstoreygoodsbypagebeanajax.htm", { channelId: $(channelId).val(),tempId: $(tempId).val(),CSRFToken:$(CSRFToken).val(),pageSize:pageSize,pageNo:pageNo ,navId:$("#navIdGoods").val()},

        function(data){
            $(navGoodsHtml).html("");
            if(data.pb.list.length==0){
                $(navGoodsHtml).append('<tr><td colspan="8"><p class="text-center">暂无可用数据</p> </td></tr>');
            }
            for(var i=0;i<data.pb.list.length;i++){
                var str="<tr>";
                str+=" <td><input  name='storeyGoodsId'  value="+data.pb.list[i].channelStoreyGoodsproductId+" type='checkbox'></td>";

                str+=' <td>导航商品</td>';
                str+=' <td>' +
                    '<div class="data_item"><img width="150px;" alt="" src="'+data.pb.list[i].goodsproductImgsrc+'" height="60px" >' +
                    '<p title="'+data.pb.list[i].goodsproductName +'">'+ data.pb.list[i].goodsproductName.substring(0,25)+'</p>  <p class="text-muted">'+data.pb.list[i].goodsproductPrice.toFixed(2) +'</p></div></td>';
                str+=" <td>"+data.pb.list[i].goodsproductNo +"</td>";
                str+=" <td>"+data.pb.list[i].sort +"</td>";
                str+= '<td><div class="btn-group"><button type="button" class="btn btn-default" onclick="updateNavGoods('+data.pb.list[i].channelStoreyGoodsproductId+')">编辑</button>'+
                    '<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">'+
                    '<span class="caret"></span>'+
                    '<span class="sr-only">Toggle Dropdown</span>'+
                    '</button><ul class="dropdown-menu" role="menu"><li><a onclick="delStoeryGoods(\'deleteChannelGoodsAjax.htm?CSRFToken='+$(CSRFToken).val()+'&storeyGoodsIds='+data.pb.list[i].channelStoreyGoodsproductId+'\',7)" href="javascript:;">删除</a></li></ul></div></td>';
                str+="</tr>";
                $(navGoodsHtml).append(str);
            }
            pageBeanNavGoods(data);
        });
}


function pageBeanNavGoods(data){
    var footStr='<div class="table_pagenav pull-right">';
    footStr+='<div class="meneame">';
    if(data.pb.pageNo==1){
        footStr+='<span class="disabled"> 上一页 </span>';
    }else{
        footStr+='<a  href="javascript:;" onclick="showNavGoods('+(data.pb.pageNo-1)+')"> 上一页 </a>';
    }
    $(navGoodsFootHtml).html("");
    for(var i = data.pb.startNo;i<data.pb.endNo+1;i++){
        if(i==data.pb.pageNo){
            footStr+=' <span class="current"> '+i+'</span>';
        }else{
            footStr+='<a href="javascript:;"  onclick="showNavGoods('+i+')">'+i+'</a>';
        }
    }
    if(data.pb.pageNo==data.pb.totalPages){
        footStr+='<span class="disabled"> 下一页 </span>';
    }else{
        footStr+='   <a href="javascript:;" onclick="showNavGoods('+(data.pb.pageNo+1)+')"> 下一页 </a>';
    }

    footStr+='</div>';
    footStr+='</div>';
    footStr+=' <div class="table_ctrl pull-left">';
    footStr+='<form role="form" class="form-inline"">';
    footStr+=' <label class="control-label ">每页显示：</label>';
    footStr+=' <select class="form-control" id="showNavGoodsOpetion" onchange="showNavGoods('+data.pb.pageNo+')">';
    if(data.pb.pageSize==10){
        footStr+='<option value="10" selected="selected">10</option>';
    }else{
        footStr+='<option value="10">10</option>';
    }
    if(data.pb.pageSize==20){
        footStr+='<option value="20" selected="selected">20</option>';
    }else{
        footStr+='<option value="20">20</option>';
    }
    if(data.pb.pageSize==50){
        footStr+='<option value="50" selected="selected">50</option>';
    }else{
        footStr+='<option value="50">50</option>';
    }
    if(data.pb.pageSize==100){
        footStr+='<option value="100" selected="selected">100</option>';
    }else{
        footStr+='<option value="100">100</option>';
    }
    footStr+='</select>';
    footStr+='</form>';
    footStr+='</div>';
    footStr+='<div class="clr"></div>';

    $(navGoodsFootHtml).append(footStr);
}


function updateNavGoods(channelStoreyGoodsproductId){
    $.post("showchannelgoodsajax.htm?CSRFToken="+$(CSRFToken).val(), { channelStoreyGoodsproductId:channelStoreyGoodsproductId },
        function(data){
            $(up_goodsproductImgsrc1).attr("src",data.goodsproductImgsrc);
            $(up_goodsproductImgsrcValue1).val(data.goodsproductImgsrc);
            $(up_goodsproductPrice1).val(data.goodsproductPrice);
            $(up_goodsproductName1).val(data.goodsproductName);
            $(up_goodsproductNo1).val(data.goodsproductNo);
            $(up_goodsSort1).val(data.sort);
            $(up_channelStoreyGoodsproductId).val(channelStoreyGoodsproductId);
            $(floorGoods).html("修改导航商品");
            $(floorGoodsType).val(data.temp3);
            $(navId).val(data.navId);
            $(upStoreyForm).val("updatechannelgoodsajax.htm");
        });
    //$('#floorGoods').html("修改楼层商品");
    $('#addFloorGoods').modal('show');
}


function  showChanneelStoreyGoodsList(){
    doByAjax();
    $('#addGoodsChoose').modal('show');
    $(goodsListTitle).html("添加楼层商品");
    $(singlButton).attr("onclick","checkFloorGoodsId()");

}

function checkFloorGoodsId(){
    var radionObj=document.getElementsByName("floorgoods");
    for(var i = 0; i < radionObj.length; i ++) {
        if (radionObj[i].checked) {
            str = radionObj[i];
            break;
        }
    }
    $(up_goodsproductImgsrc1).attr("src",$(str).attr("goodsImg"));
    $(up_goodsproductImgsrcValue1).val($(str).attr("goodsImg"));
    $(up_channelStoreyGoodsproductId1).val($(str).val());
    //$("#up_goodsproductId").val($(str).val());
    $(up_goodsproductPrice1).val($(str).attr("goodsPrice"));
    $(up_goodsproductName1).val($(str).attr("goodsName"));
    $(up_goodsproductNo1).val($(str).attr("goodsInfoNo"));
    $(singlQ).click();
}
function showNavPageAdver(){

}