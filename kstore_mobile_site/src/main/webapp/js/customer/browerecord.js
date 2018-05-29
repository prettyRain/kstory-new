var pageNo=1;
var iIntervalId = null;
var basePath = $("#basePath").val();
$(function(){
    window.onload=function(){
        $("#status").val(0);
    }
});
var browseTime = "";
function show(){
    if($("#status").val()==1){
        return;
    }
	 pageNo++;
    //获取最下面一个浏览日期
    browseTime = $(".rq_date:last").attr("name");
    $("#status").val(1);
  $.ajax({
    url: basePath+'/allbrowerecord.htm?pageNo='+pageNo,
    type: 'GET',
    dataType: 'text',
    async:'false',
	beforeSend: showLoadingImg,
    error: showFailure,
    success:showResponse
  });
}

function showLoadingImg() {
	 $('#showmore').html(' <img src='+basePath+'/images/loading.gif /><span>加载中……</span>');
	 $('#showmore').show();
}

function showFailure() {
	 $('#showmore').html('<font color=red> 获取查询数据出错 </font>');
    $("#status").val(0);
}
//根据ajax取出来的json数据转换成html
function showResponse(responseData) {

		 var returnjson = eval("(" +responseData+")");
		 var nextpagehtml = '';
    if(returnjson !=null && returnjson.list !=null && returnjson.list.length >0) {
        for (var i = 0; i < returnjson.list.length; i++) {
            var browere = returnjson.list[i];
            nextpagehtml += '  <a href="' + basePath + '/item/' + browere.goodsId + '.html">';
            if(browseTime != browere.isMobile ) {
                nextpagehtml += '<i class="rq_date" name="' + browere.isMobile + '">' + browere.isMobile.substring(5,browere.isMobile.length) + '</i>';
            }
            nextpagehtml += '  <div class="list-item pro-item';
            if (browere.goods.goodStock <= 0) {
                nextpagehtml += ' sell-out';
            }
            if(browseTime != browere.isMobile ) {
                nextpagehtml += ' list_item1';
            }
            nextpagehtml += ' " id="collection' + browere.likeId + '">';
            nextpagehtml += '<div class="propic';
            if(browseTime != browere.isMobile ) {
                nextpagehtml += ' list_item2';
                browseTime = browere.isMobile;
            }
            nextpagehtml += '"><img width="100" height="100"  alt=' + browere.goods.goodsName + ' title=' + browere.goods.goodsName + ' src=' + browere.goods.goodsImg + ' />';
            nextpagehtml += '</div>';
            nextpagehtml += '<div class="prodesc">';
            nextpagehtml += '<h3 class="title">';
            var goodsname = browere.goods.goodsName;
            if (goodsname.length > 50) {
                goodsname = goodsname.substring(0, 50);
            }
            nextpagehtml += '' + goodsname + '';
            nextpagehtml += '</h3>';
            nextpagehtml += '<p class="price">&yen;<span>';
            var goodsprice = browere.goods.goodsPrice.toFixed(2);
            nextpagehtml += '' + goodsprice + '';
            nextpagehtml += '</span></p>';
            nextpagehtml += '<i class="sc_del" name="'+ browere.likeId +'">删除</i>';
            nextpagehtml += '</div>';

            nextpagehtml += '</div>';
            nextpagehtml += '</a>';
        }
        if (nextpagehtml != null && nextpagehtml != "") {
            $('#items').append(nextpagehtml);
            $newElems = $("#items .list-item");
            // 渐显新的内容
            $newElems.animate({opacity: 1});
            $("#status").val(0);
            if (returnjson.nextPageNo == pageNo) {

                clearInterval(iIntervalId);
                $('#showmore').hide();
            } else {
                $('#showmore').html(' <img src=' + basePath + '/images/loading.gif /><span>加载中……</span>');
                $('#showmore').show();
            }
        } else {
            $("#status").val(1);
            $('#showmore').html('<a class="handle" href="javascript:show()">已无更多结果</a>');
        }
    }else{
        $("#status").val(1);
        $('#showmore').html('<a class="handle" href="javascript:show()">已无更多结果</a>');
    }
 // 当前页码数小于3页时继续显示更多提示框
/* if(page < 2) {
   $('#showmore').html('<a class="handle" href="javascript:show()">显示更多结果</a>');
 } else {
   clearInterval(iIntervalId);
   $('#showmore').hide();
 }*/
//bdShare.fn.init();
}

function cancelcollection(obj,id){
	$.ajax({
		url:basePath+"/cancelcollection.htm",
		data:"followId="+id,
		dataType:"text",
		type:"post",
		success:function(data){
			if(data>0){
				$("#collection"+id).remove();
			}
		}
	});

}