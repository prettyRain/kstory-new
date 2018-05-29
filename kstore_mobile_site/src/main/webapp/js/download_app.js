$(function() {
	//下载地址
	var env = {
		agent: window.navigator.userAgent.toLowerCase(),
		iosURL: 'itms-apps://itunes.apple.com/app/id1224473452',
		androidURL: 'http://m.ge960.com/appqrcode.htm',
		isWechat: function() {
			return this.agent.match(/MicroMessenger/i) == 'micromessenger';
		},
		isAndroid: function() {
			return this.agent.match(/android/i) == 'android';
		},
		isIphone: function() {
			return this.agent.match(/iphone/i) == 'iphone';
		},
		init: function() {
			if (env.isWechat() && env.isAndroid()) {
				window.location.href = env.androidURL;
			} else if (env.isIphone()) {
				window.location.href = env.iosURL;
			} else {
				window.location.href = env.androidURL;
			}
		}
	};
	//点击下载按钮执行
	$(".down").on("click", function() {
		env.init();
	});
	//微信环境点击下载弹出提示切换到浏览器图片
	//$(".aatips").on("click", function() {
	//	$(".aatips").toggle()
	//});
	//切换图片
	//检查浏览器支持性?按顺序展示图片:随机图片
	if (typeof(Storage) !== "undefined") {
		var imgSource = localStorage.getItem("imgSource");
		if (imgSource == null) {
			$(".warp").find("img").attr({
				src: "/images/download_1.jpg"
			});
			localStorage.setItem("imgSource", 1);
		} else if (1 <= parseInt(imgSource) && parseInt(imgSource) <= 4) {
			localStorage.removeItem("imgSource");
			localStorage.setItem("imgSource", parseInt(imgSource) + 1);
		} else {
			localStorage.removeItem("imgSource");
			localStorage.setItem("imgSource", 1);
		}
		var imgSource = localStorage.getItem("imgSource");
		$(".warp").find("img").attr({
			src: "/images/download_" + imgSource + ".jpg"
		});

	} else {
		var stack = [1,2,3,4,5];
		var imgSource2 = stack.splice(parseInt(Math.random() * stack.length), 1)[0];
		console.log(imgSource2);
		$(".warp").find("img").attr({
			src: "/images/download_" + imgSource2 + ".jpg"
		});
	}

})