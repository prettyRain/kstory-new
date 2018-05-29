<#assign basePath=request.contextPath>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="${basePath}/css/tip-newbox.css">
<link rel="stylesheet" type="text/css" href="${basePath}/css/v1/css/popup.css">
<div class="popup popup-about">
	<div class="view">
		<div class="pages">
			<div class="page" style="padding-bottom:0;">
				<form action="${basePath}/searchProduct.htm" method="get" data-search-list=".search-here" data-search-in=".item-title" class="searchbar searchbar-init" id="searchProductForm">
					<#-- class=searchbar-cancel -->
					<#--<a href="#" class="close-popup search-close">×</a>-->
					<div class="searchbar-input">
						<input type="search" name="keyWords" placeholder="搜索960商品 按类别 按属性" onfocus="this.placeholder=''" onblur="this.placeholder='搜索'" id="title"/>
						<a href="#" class="searchbar-clear"></a>
						<#--<button id="searchBtn" class="search-btn">搜索</button>-->
                        <input type="hidden" value="0" name="storeId" id="storeId">

					</div>
                    <a href="#" class="close-popup search-close">取消</a>
                    <#--<button id="searchBtn" class="search-btn">搜索</button>-->
				</form>
				<div class="searchbar-overlay"></div>
				<div class="page-content" style="background:#fff;">

					<div class="list-block searchbar-not-found">
						<ul>
							<li class="item-content">
								<div class="item-inner">
									<div class="item-title">0</div>
								</div>
							</li>
						</ul>
					</div>
					<div class="list-block searchbar-found">
						<div class="hot-search">
							<div class="title">热门搜索</div>
							<ul>
								<li class="item-content">
									<div class="item-inner">
										<div class="item-title"><a class="external" href="${basePath}/intoPage.htm?pageName=main/childMallOne">食品荟萃</a></div>
									</div>
								</li>
								<li class="item-content">
									<div class="item-inner">
										<div class="item-title "><a class="external" href="${basePath}/intoPage.htm?pageName=main/childMallTwo">饮品总汇</a></div>
									</div>
								</li>
							</ul>
							<div class="clearfixed"></div>
						</div>
						<div class="history-search">
							<div class="title">搜索历史 <a id="deletehistory"><span ></span></a></div>
							<ul id="historySearch"></ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<#--<script type="text/javascript" src="${basePath}/js/v1/framework7.js"></script>-->
<script type="text/javascript" src="${basePath}/js/tip-newbox.js"></script>
<#--<script type="text/javascript" src="${basePath}/js/v1/index.js"></script>-->
<script type="text/javascript">
    $("#title").on('keypress',function(e) {
        var keycode = e.keyCode;
        var searchName = $(this).val();

        if(keycode=='13') {
            e.preventDefault();
            if(searchName == ''){
                return;
            }
            //请求搜索接口
            if($("#title").val()==''){
                $("#title").val($("#title").attr("placeholder"));
            }
            setcookie("selectTitle",$('#title').val(),1);
            $("#searchProductForm").submit();

        }
    });

    $(function(){
        //查询历史搜索
        getcookie('selectTitle');
        $("#searchBtn").click(function(){
            //.$("#storeId")val($(".storeId").val());
            if($("#title").val()==''){
                $("#title").val($("#title").attr("placeholder"));
            }
            setcookie("selectTitle",$('input[name=keyWords]').val(),1);
            $("#searchProductForm").submit();
        })
         //删除历史记录
		$('#deletehistory').click(function(){
			cleancookie("selectTitle","",0);
            getcookie('selectTitle');
		})
		$('.history').click(function(){
		    var content=$(this).html();
            $("#title").val(content);
            $("#searchProductForm").submit();
		})
    })
	//清空历史搜索
	function cleancookie(name,value,outTime){

        var nameandvalues=document.cookie.split(";");
         $.each(nameandvalues,function (i,e) {
             if(e.indexOf(name)!=-1){

                 var date=new Date();
                 date.setTime(date.getTime()+outTime*1000*60*60*0);

                 document.cookie=name+"="+value+";"+"expires="+date.toUTCString()+";path=/;";
                 getcookie(name);
             }
         })

	}
	//设置cookie
	function setcookie(name,value,outTime){
        var str='';

        var cookiearr=document.cookie.split(";");
            if(cookiearr.length>0){
        for(var i=0;i<cookiearr.length;i++ ){
           var nameandvalue=cookiearr[i];

           if(nameandvalue.indexOf(name)!=-1){
           str+=decodeURIComponent(nameandvalue.substring(nameandvalue.indexOf("=")+1,nameandvalue.length));
		   }
		}
        }
        if(!!str){
                //如果已经搜索过  就不会添加到搜索列表
                if(str==value){
                    return;
				}
				if(str.indexOf('---')!=-1){

                    var arr=str.split("---");
					for(var i=0;i<arr.length;i++){
                      // alert(arr[i]==value)
                       if(arr[i]==value){
                           return;
                       }
				   }
				   //大于十五条时停止添加
				   if(arr.length>15){
					    return;
				   }
				}
            value=str+"---"+value;

		}
		var date=new Date();
		date.setTime(date.getTime()+(outTime*1000*60*60*24));
		document.cookie=name+"="+encodeURIComponent(value)+";"+"expires="+date.toUTCString()+";path=/;";
	}
	//获取历史搜索
	function getcookie(name){
        $('#historySearch').empty();
        var cookiearr=document.cookie.split(";");
        if(cookiearr.length>0){
            for(var i=0;i<cookiearr.length;i++ ){
                var nameandvalue=cookiearr[i];

                if(nameandvalue.indexOf(name)!=-1){
                    var values=decodeURIComponent(nameandvalue.substring(nameandvalue.indexOf("=")+1,nameandvalue.length));

                    var arr=new Array();
                     arr=values.split("---");

                     $.each(arr,function(i,e){
						 $('#historySearch').append('<li class="item-content" ><div class="item-inner">' +
                                 '<div class="item-title"><a href="#" class="history">'+e+'</a></div></div></li>');
					 })

					}
                }
            }
        }

</script>
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
</script>

