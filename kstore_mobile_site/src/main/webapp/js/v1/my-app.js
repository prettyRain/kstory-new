// Initialize your app
var myApp = new Framework7();

// Export selectors engine
var $$ = Dom7;

// Add view
var mainView = myApp.addView('.view-main', {
    // Because we use fixed-through navbar we can enable dynamic navbar
    dynamicNavbar: true

});
cookie_text();

myApp.onPageInit('myindex', function (page) {
    cookie_text();
})
function cookie_text(){
    $(".menu-top a").on("click",function(){
        var ulr =$(this).attr("href");
        var keyUrl = ulr.substring(ulr.lastIndexOf('=') + 1);
        $.cookie('the_cookie',keyUrl);

    });
    $(".dd-more").on("click",function(){
        var ulr =$(this).attr("href");
        var keyUrl = ulr.substring(ulr.lastIndexOf('=') + 1);
        $.cookie('the_cookie',keyUrl);

    });
}
myApp.onPageInit('myorder', function (page) {

    var num=$.cookie('the_cookie');
    $$("#seleted a").on("click",function(){
        var ulr =$(this).attr("name");
        var keyUrl = ulr.substring(ulr.lastIndexOf('=') + 1);
        $.cookie('the_cookie',keyUrl);
        var num=$.cookie('the_cookie');
        $$("#seleted a").removeClass("active");
        $$(this).addClass("active");
        $$(".myorder-body-list").removeClass("active");
        $$(".myorder-body-list").eq(num).addClass("active");
    })

    if(num==0){

        $$(".dd-more").removeClass("on");
        $$("#seleted a").removeClass("active");
        $$("#seleted a").eq(num).addClass("active");
        $$(".myorder-body-list").removeClass("active");
        $$(".myorder-body-list").eq(num).addClass("active");
    }else{
        $$("#seleted a").removeClass("active");
        $$("#seleted a").eq(num).addClass("active");
        $$(".myorder-body-list").removeClass("active");
        $$(".myorder-body-list").eq(num).addClass("active");
    }
});


myApp.onPageInit('myress', function (page) {

    $$(".ress-xz span").on("click",function(){
        new TipBox({
            type: 'success',
            str: '操作成功',
            setTime:1500,
            hasMask:false,
            hasBtn: false
        });
        $$(".mui-table-view-cell").removeClass("main");
        $$(".mui-table-view-cell .ress-xz").removeClass("active").find("span").text("设置为默认地址");
        $$(this).parents(".mui-table-view-cell").addClass("main");
        $$(this).parent().addClass("active");
        $$(this).text("默认地址");
        var $one_li = $(".mui-table-view-cell:eq(0)");
        $$(this).parents(".mui-table-view-cell").insertBefore($one_li);


    })
    mui.init();
    (function($) {

        //第一个demo，拖拽后显示操作图标，点击操作图标删除元素；
        $('#OA_task_1').on('tap', '.mui-btn', function(event) {

            var elem = this;
            var li = elem.parentNode.parentNode;
            mui.confirm('确认删除该条地址？', ' ', btnArray, function(e) {

                if (e.index == 0) {
                    li.parentNode.removeChild(li);
                } else {
                    $.swipeoutClose(li);
                }
            });
        });
        var btnArray = ['确认', '取消'];
    })(mui);
})
myApp.onPageInit('myfav', function (page) {
    $$(".myorder-list-l span").on("click",function(){

        if($$(this).hasClass("active")) {
            $$(this).removeClass("active");
        }else{
            $$(this).addClass("active");
        }
    })
    $$(".fav-delete").on("click",function(){

        if ($$(".myorder-list-l span.active").length){
            myApp.confirm('确认删除已选收藏商品?', function () {
                $$(".myorder-list-l span").each(function (index) {
                    if ($$(".myorder-list-l span").hasClass("active")) {
                        $$(this).parents("li").remove();
                    }
                })
            });
        }else{
            myApp.alert('您未选择要删除的商品！');
        }
    })
    mui.init();
    (function($) {
        //第一个demo，拖拽后显示操作图标，点击操作图标删除元素；
        $('#OA_task_1').on('tap', '.mui-btn', function(event) {
            var elem = this;
            var li = elem.parentNode.parentNode;
            mui.confirm('确认删除该商品？', ' ', btnArray, function(e) {

                if (e.index == 0) {
                    li.parentNode.removeChild(li);
                } else {
                    $.swipeoutClose(li);
                }
            });
        });
        var btnArray = ['确认', '取消'];
    })(mui);
})
myApp.onPageInit('myhistory', function (page) {

    $$('.fav-delete').on('click', function () {
        myApp.confirm('确定要删除全部浏览记录?', function () {
            $$("#OA_task_1 li").remove();
        });
    });


})
myApp.onPageInit('myordergrade', function (page) {
    $$(".myordergrade-pf span").on("click",function(){
        $$(this).parent().find("span").removeClass("on");
        $$(this).addClass("on");
        $$(this).prevAll().addClass("on");
    })

})
myApp.onPageInit('myaddress', function (page) {

    (function($, doc) {

        $.init();
        $.ready(function() {

            //					//级联示例
            var cityPicker3 = new $.PopPicker({
                layer: 3
            });
            cityPicker3.setData(cityData3);
            var showCityPickerButton = doc.getElementById('showCityPicker3');
            var cityResult3 = doc.getElementById('cityResult3');
            showCityPickerButton.addEventListener('tap', function(event) {

                cityPicker3.show(function(items) {
                    cityResult3.innerText = (items[0] || {}).text + " " + (items[1] || {}).text + " " + (items[2] || {}).text;
                    //返回 false 可以阻止选择框的关闭
                    //return false;
                });
            }, false);
        });
    })(mui, document);
})
myApp.onPageInit('mymessage', function (page) {
    $$(".myorder-list-l span").on("click",function(){
        $$(this).toggleClass("active");
    })

    $$("#btn-fixed-ress .left").on("click",function(){
        if($$("#btn-fixed-ress .left").hasClass("active")) {
            $$(".myorder-list-l span").removeClass("active");
            $$(this).removeClass("active");
        }else{
            $$(".myorder-list-l span").addClass("active");
            $$(this).addClass("active");
        }
    })
    $$("#btn-fixed-ress .right").on("click",function(){
        if ($$(".myorder-list-l span.active").length){
            myApp.confirm('确认删除已选收藏商品?', function () {
                $$(".myorder-list-l span").each(function (index) {
                    if ($$(".myorder-list-l span").hasClass("active")) {
                        $$(this).parents("li").remove();
                    }
                })
            });
        }else{
            myApp.alert('您未选择要删除的商品！');
        }
    })

    mui.init();
    (function($) {

        //第一个demo，拖拽后显示操作图标，点击操作图标删除元素；
        $('#OA_task_1').on('tap', '.mui-btn', function(event) {

            var elem = this;
            var li = elem.parentNode.parentNode;
            mui.confirm('确认删除该条记录？', ' ', btnArray, function(e) {

                if (e.index == 0) {
                    li.parentNode.removeChild(li);
                } else {
                    $.swipeoutClose(li);
                }
            });
        });
        var btnArray = ['确认', '取消'];
    })(mui);
})

myApp.onPageInit('myinfo', function (page) {

    (function($) {
        $.init();
        var result = $('#cityResult3')[0];
        var btns = $('.btn');
        btns.each(function(i, btn) {
            btn.addEventListener('tap', function() {
                var optionsJson = this.getAttribute('data-options') || '{}';
                var options = JSON.parse(optionsJson);
                var id = this.getAttribute('id');
                var picker = new $.DtPicker(options);
                picker.show(function(rs) {
                    result.innerText = rs.text;
                    picker.dispose();
                });
            }, false);
        });
    })(mui);
})