
// Extend the default Number object with a formatMoney() method:
    // usage: someVar.formatMoney(decimalPlaces, symbol, thousandsSeparator, decimalSeparator)
    // defaults: (2, "$", ",", ".")
    Number.prototype.formatMoney = function (places, symbol, thousand, decimal) {
        places = !isNaN(places = Math.abs(places)) ? places : 2;
        symbol = symbol !== undefined ? symbol : "";
        thousand = thousand || ",";
        decimal = decimal || ".";
        var number = this,
            negative = number < 0 ? "-" : "",
            i = parseInt(number = Math.abs(+number || 0).toFixed(places), 10) + "",
            j = (j = i.length) > 3 ? j % 3 : 0;
        return symbol + negative + (j ? i.substr(0, j) + thousand : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thousand) + (places ? decimal + Math.abs(number - i).toFixed(places).slice(2) : "");
    };
    
    
    String.prototype.rebackMoney = function () {
        return this.replace(/\,/g, "");
    };
    
    
    function getSimpleName( name , l ){
    	if( !l   ){
    		l = 30;
    	}
    	
    	if( name.length > l){
			return name.substring(0,l) + "...";
		}else{
			return name;
		}
		
	}

var re = /^[1-9]+[0-9]*]*$/;
var zhengnum = /^[1-9]+[0-9]*]*$/;

function randurl(url){
    if(url.indexOf("?")>0){
        return url+"&r="+Math.random();
    }else{
        return url+"?r="+Math.random();
    }
}

//获取数据
function getResultAjax( parameter,url){
    var getResult;
    $.ajax({
        async:false,
        type: "POST",
        url: url,
        data: parameter,
        dataType: "json",
        success: function( result ){
            getResult = result;
        }
    });
    return getResult;
}

//换回链接的字符串，如果不为空，则返回链接地址，为空则返回#
function getLinkStr(link){
    //var linkFlag = link != null && link != '';

    //var linkStr = "";
    if( link != null && link != '' ){
        return link;
    }else{
        return "#";
    }
}