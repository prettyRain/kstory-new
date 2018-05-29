/**
 * Created by houyichang on 2015/12/3.
 */

$(function(){
    /**
     * 点击全部好评时调用
     * */
    $(".haopingall").click(function(){
        $(this).addClass('active').siblings().removeClass('active');
        $(this).siblings("b").animate({"left":"7%"},"slow");
        loadComment(1,4);

    });

    /**
     * 点击好评时调用
     * */
    $(".haoping").click(function(){
        $(this).addClass('active').siblings().removeClass('active');
        $(this).siblings("b").animate({"left":"32%"},"slow");
        loadComment(1,0);

    });

    /**
     * 点击中评时调用
     * */
    $(".zhongping").click(function(){
        $(this).addClass('active').siblings().removeClass('active');
        $(this).siblings("b").animate({"left":"57%"},"slow");
        loadComment(1,1);

    });

    /**
     * 点击差评时调用
     * */
    $(".chaping").click(function(){
        $(this).addClass('active').siblings().removeClass('active');
        $(this).siblings("b").animate({"left":"83%"},"slow");
        loadComment(1,2);

    });

});


function countshow(ele){
    if(parseInt(ele)>1000){
        ele = "1000+";
    }else if(parseInt(ele)>100){
        ele = "100+";
    }else if(parseInt(ele)>10){
        ele = "10+";
    }
    return ele;
}
/**
 * 加载商品评论
 * */
function loadComment(pageNo,type){
    /*清空相关的div*/
    $("#commentBody").html("");
    var productId=$("#productId").val();
    var params="&productId="+productId;
    params+="&pageNo="+pageNo+"&pageSize=1";
    var allCount = 0;
    var haoCount=0;
    var zhongCount=0;
    var chaCount=0;
    //获取所有评论总数
    var count=0;
    /*AJAX查询商品好评*/
    var basePath = $("#basePath").val();

    if(type==4){
        $.ajax({
            url:basePath+"/queryProducCommentDetailForDetailHyc.htm?type=4"+params,
            type:"post",
            async:false,
            success:function(data) {
                /*设置所有的行数*/
                allCount = data.rows;
                putPageComment(type, data);
                allCount = countshow(allCount);
                $("#haopingall").text(allCount);
            }
        });

        //好评数
        $.ajax({
            url:basePath+"/queryCommentCountByType.htm?type=0"+params,
            type:"post",
            async:false,
            success:function(data){
                /*设置所有的行数*/
                haoCount=data;
                haoCount = countshow(haoCount);
                $("#haoping").text(haoCount);
            }
        });

        //中评数
        $.ajax({
            url:basePath+"/queryCommentCountByType.htm?type=1"+params,
            type:"post",
            async:false,
            success:function(data){
                /*设置所有的行数*/
                zhongCount=data;
                zhongCount = countshow(zhongCount);
                $("#zhongping").text(zhongCount);
            }
        });

        //差评数
        $.ajax({
            url:basePath+"/queryCommentCountByType.htm?type=2"+params,
            type:"post",
            async:false,
            success:function(data){
                /*设置所有的行数*/
                chaCount=data;
                chaCount = countshow(chaCount);
                $("#chaping").text(chaCount);
            }

        });
    }else if(type==0){
        $.ajax({
            url:basePath+"/queryCommentCountByType.htm?type=4"+params,
            type:"post",
            async:false,
            success:function(data) {
                /*设置所有的行数*/
                allCount = data;
                allCount = countshow(allCount);
                $("#haopingall").text(allCount);
            }
        });

        //好评数
        $.ajax({
            url:basePath+"/queryProducCommentDetailForDetailHyc.htm?type=0"+params,
            type:"post",
            async:false,
            success:function(data){
                /*设置所有的行数*/
                haoCount=data.rows;
                putPageComment(type, data);
                haoCount = countshow(haoCount);
                $("#haoping").text(haoCount);
            }
        });

        //中评数
        $.ajax({
            url:basePath+"/queryCommentCountByType.htm?type=1"+params,
            type:"post",
            async:false,
            success:function(data){
                /*设置所有的行数*/
                zhongCount=data;
                zhongCount = countshow(zhongCount);
                $("#zhongping").text(zhongCount);
            }
        });

        //差评数
        $.ajax({
            url:basePath+"/queryCommentCountByType.htm?type=2"+params,
            type:"post",
            async:false,
            success:function(data){
                /*设置所有的行数*/
                chaCount=data;
                chaCount = countshow(chaCount);
                $("#chaping").text(chaCount);
            }

        });
    }else if(type==1){
        $.ajax({
            url:basePath+"/queryCommentCountByType.htm?type=4"+params,
            type:"post",
            async:false,
            success:function(data) {
                /*设置所有的行数*/
                allCount = data;
                allCount = countshow(allCount);
                $("#haopingall").text(allCount);
            }
        });

        //好评数
        $.ajax({
            url:basePath+"/queryCommentCountByType.htm?type=0"+params,
            type:"post",
            async:false,
            success:function(data){
                /*设置所有的行数*/
                haoCount=data;
                haoCount = countshow(haoCount);
                $("#haoping").text(haoCount);
            }
        });

        //中评数
        $.ajax({
            url:basePath+"/queryProducCommentDetailForDetailHyc.htm?type=1"+params,
            type:"post",
            async:false,
            success:function(data){
                /*设置所有的行数*/
                zhongCount=data.rows;
                putPageComment(type, data);
                zhongCount = countshow(zhongCount);
                $("#zhongping").text(zhongCount);
            }
        });

        //差评数
        $.ajax({
            url:basePath+"/queryCommentCountByType.htm?type=2"+params,
            type:"post",
            async:false,
            success:function(data){
                /*设置所有的行数*/
                chaCount=data;
                chaCount = countshow(chaCount);
                $("#chaping").text(chaCount);
            }

        });
    }else if(type==2){
        $.ajax({
            url:basePath+"/queryCommentCountByType.htm?type=4"+params,
            type:"post",
            async:false,
            success:function(data) {
                /*设置所有的行数*/
                allCount = data;
                allCount = countshow(allCount);
                $("#haopingall").text(allCount);
            }
        });

        //好评数
        $.ajax({
            url:basePath+"/queryCommentCountByType.htm?type=0"+params,
            type:"post",
            async:false,
            success:function(data){
                /*设置所有的行数*/
                haoCount=data;
                haoCount = countshow(haoCount);
                $("#haoping").text(haoCount);
            }
        });

        //中评数
        $.ajax({
            url:basePath+"/queryCommentCountByType.htm?type=1"+params,
            type:"post",
            async:false,
            success:function(data){
                /*设置所有的行数*/
                zhongCount=data;
                zhongCount = countshow(zhongCount);
                $("#zhongping").text(zhongCount);
            }
        });

        //差评数
        $.ajax({
            url:basePath+"/queryProducCommentDetailForDetailHyc.htm?type=2"+params,
            type:"post",
            async:false,
            success:function(data){
                /*设置所有的行数*/
                chaCount=data.rows;
                putPageComment(type, data);
                chaCount = countshow(chaCount);
                $("#chaping").text(chaCount);
            }

        });
    }

}


/*将查询到的评论加载到页面中*/
function putPageComment(type,data){
    var commentHtml="";
    if(data.list!=null && data.list.length>0){
        for(var l=0;l<data.list.length;l++){
            var comment = data.list[l];
            var star = "star"+comment.commentScore;
            /*if(comment.isAnonymous=='1'){
                commentHtml+="<div class='list-item'><div class='star'><div class='"+star+" cur'></div>" +
                "</div> <div class='user-item'><span>****</span>" +
                "&nbsp;<span>"+timeStamp2String(comment.buyTime)+"</span></div><p class='text'>"+comment.commentContent+"</p></div>";
            }else{*/
                if(comment.customerNickname == null){
                    comment.customerNickname = "null";
                }
                var str = comment.customerNickname;
                var newstr = "";
                //名字长度小于3位，显示第一个字后面加****；3位以上，显示首位字，中间****
                if(str.length<3){
                    newstr = str.substr(0,1)+"****";
                }else{
                    newstr = str.substr(0,1)+"****"+str.substr(str.length-1,1);
                }
                commentHtml+="<div class='list-item'><div class='star'><div class='"+star+" cur'></div>" +
                "</div> <div class='user-item'><span>"+newstr+"</span>" +
                "&nbsp;<span>"+timeStamp2String(comment.publishTime)+"</span></div><p class='text'>"+comment.commentContent+"</p></div>";
            /*}*/
        }
    }else{
        commentHtml+="<div class='list-item'><div class='user-item'><span></span></div><p class='text'>暂无商品评论</p></div>";
    }
    commentHtml+="<div class='all-evaluate'>以上为全部评论</div>"
    $("#commentBody").append(commentHtml);
}

/*处理时间格式化*/
function timeStamp2String(time){
    var date=new Date(parseFloat(time));
    var datetime = new Date();
    datetime.setTime(date);
    var year = datetime.getFullYear();
    var month = datetime.getMonth() + 1 < 10 ? "0" + (datetime.getMonth() + 1) : datetime.getMonth() + 1;
    var date = datetime.getDate() < 10 ? "0" + datetime.getDate() : datetime.getDate();
    var hour = datetime.getHours()< 10 ? "0" + datetime.getHours() : datetime.getHours();
    var minute = datetime.getMinutes()< 10 ? "0" + datetime.getMinutes() : datetime.getMinutes();
    var second = datetime.getSeconds()< 10 ? "0" + datetime.getSeconds() : datetime.getSeconds();
    //return year + "-" + month + "-" + date+" "+hour+":"+minute+":"+second;
    return year + "-" + month + "-" + date;
}