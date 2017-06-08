// import {$} from "js/jquery.js"
var path = 0;
var inte = null;
// function $(tar){
// 	if (tar[0]=='#') {
// 		return document.getElementById(tar.substring(1,tar.length));		
// 	}else if(tar[0]=='.'){
// 		return document.getElementsByClassName(tar.substring(1,tar.length));	
// 	}
// }
var scrollNumber = 0;

function scrollBtnLeft() {
    if (scrollNumber == 1200) {
        setTimeout("scrollBtnRight()", 1000);
        return false;
    }
    scrollNumber += 240;
    $("#content-ul-itembox").css("transform", "translate3d(-" + scrollNumber + "px, 0, 0)");
    // clearInterval("scrollBtnLeft()");s
    setTimeout("scrollBtnLeft()", 2000);
    return false;
}

function scrollBtnRight() {
    if (scrollNumber == 0) {
        setTimeout("scrollBtnLeft()", 1000);
        return false;
    }
    scrollNumber -= 240
    $("#content-ul-itembox").css("transform", "translate3d(-" + scrollNumber + "px, 0, 0)");
    setTimeout("scrollBtnRight()", 2000);
    return false;
}
var fla = false;

function scrollStop() {
    // if (!fla) {
    //     alert("stop");
    //     fla = true;
    // }
}

function scrollStart() {
    // if (fla) {
    //     alert("start");
    //     fla = false;
    // }

}

function isFullScreen() {
    if (
        window.outerHeight === screen.availHeight
    ) {
        if (
            window.outerWidth === screen.availWidth
        ) {
            return true; // 全屏
        }
    }
    return false; // 不是全屏
};


window.onload = function() {
    setTimeout("scrollBtnLeft()", 1000);

    // window.scrollTo(0, 12);
    // $("#title1").css("font-size", window.screen.width * 50 / 1366 + "px"); 
    $("#title1").css("font-size", 3 + "em");
    $("#title1").css("opacity", "1");
    $('#content-start').css("margin-top", "5%");
    if (window.screen.width == document.body.scrollWidth) {
        $('#vdo').css("width", "100%");
    } else
        $('#vdo').css("width", "auto");

    for (var i = 1; i < $('.container').length; i++) {
        var element = $('.container')[i];
        if (element.id == 'container-itembox') continue;
        element.style.height = window.innerHeight + 'px';
    }

    var y = window.scrollY;
    var h = window.innerHeight;

    $("#container-toppanel").css("paddingTop", 25 - (y / ((h - 98) / 25)) + "px");
    $("#container-toppanel").css("paddingBottom", 25 - (y / ((h - 98) / 25)) + "px");
    $("#container-toppanel").css("backgroundColor", "transparent");
    $("#container-toppanel").css("boxShadow", "");

    $('.span-top-scroll').addClass("span-top-normal");
    $('.span-top-scroll').removeClass("span-top-scroll")
    $('#btn-login').removeClass("btn");
    $('#btn-login').addClass("btn-ontop");
    $('#logo-text').css("color", "#fff");

    // globalheight=window.innerHeight;
    // globalwidth=window.innerWidth;

    // document.getElementById('vdo').playbackRate=1.2;

    //     var scrollFunc = function (e) {  
    //     e = e || window.event;  
    //     if (e.wheelDelta) {  //判断浏览器IE，谷歌滑轮事件               
    //         if (e.wheelDelta > 0) { 
    // 			for(var i = 0;i<50;i+=5)
    // 			window.scrollTo(0,linh-=i);
    //         }  
    //         if (e.wheelDelta < 0) {
    // 			for(var i = 0;i<50;i+=5)
    // 			window.scrollTo(0,linh+=i);
    //         }  
    //     } else if (e.detail) {  //Firefox滑轮事件  
    //         if (e.detail> 0) { 
    // 			for(var i = 0;i<50;i+=5)
    // 			window.scrollTo(0,linh-=i);
    //         }  
    //         if (e.detail< 0) { 
    // 			for(var i = 0;i<50;i+=5)
    // 			window.scrollTo(0,linh+=i);
    //         }  
    //     }  
    // }  
    // //给页面绑定滑轮滚动事件  
    // if (document.addEventListener) {//firefox  
    //     document.addEventListener('DOMMouseScroll', scrollFunc, false);  
    // }  
    // //滚动滑轮触发scrollFunc方法  //ie 谷歌  
    // window.onmousewheel = document.onmousewheel = scrollFunc;   


    // $("#container-header").css("background-size",window.innerHeight+"px,"+window.innerWidth+"px");
}


window.onscroll = function() {

    var y = window.scrollY;
    var h = window.innerHeight;
    if (y < h) {
        $("#container-header").css("margin-top", y + "px");
        // $("#container-header").css("background-size",h-y+"px");
        $("#container-header").css("height", h - y + "px");

        // 		if(null==inte){
        // 	inte=setInterval(function(){
        // 		if(document.documentElement.scrollTop==path){
        // 			document.body.style.overflowY="hidden";

        // 			// clearInterval(inte);
        // 			// inte=null;
        // 		}
        // 	},1000);
        // }
        // path=document.documentElement.scrollTop;


    }
    if (y < h - 98) {
        $("#container-toppanel").css("paddingTop", 25 - (y / ((h - 98) / 25)) + "px");
        $("#container-toppanel").css("paddingBottom", 25 - (y / ((h - 98) / 25)) + "px");
        $("#container-toppanel").css("backgroundColor", "transparent");
        $("#container-toppanel").css("boxShadow", "");

        $('.span-top-scroll').addClass("span-top-normal");
        $('.span-top-scroll').removeClass("span-top-scroll")
        $('#btn-login').removeClass("btn");
        $('#btn-login').addClass("btn-ontop");
        $('#logo-text').css("color", "#fff");

    } else {
        $("#container-toppanel").css("paddingTop", 0 + "px");
        $("#container-toppanel").css("paddingBottom", 0 + "px");
        $("#container-toppanel").css("backgroundColor", "white");
        $("#container-toppanel").css("boxShadow", "rgba(0, 0, 0, 0.0980392) 0px 2px 2px 0px");

        $('.span-top-normal').addClass("span-top-scroll");
        $('.span-top-normal').removeClass("span-top-normal");
        $('#btn-login').removeClass("btn-ontop");
        $('#btn-login').addClass("btn");
        $('#logo-text').css("color", "#545763");
    }
    if (y > h && y < 2 * h + 380) {

        $('.picbox').addClass('picbox-onhold');
        $('.picbox').removeClass('picbox');

        $('#pic_1').addClass('p1');
        $('#pic_2').addClass('p2');
        $('#pic_3').addClass('p3');
        $('#pic_4').addClass('p4');
        $('#pic_5').addClass('p5');
        $('#pic_6').addClass('p6');
        $('#pic_7').addClass('p7');
        $('#pic_8').addClass('p8');
        // $('#pic_1').css("height","55px");
        // $('#pic_1').css("width","80px");
        // $('#pic_2').css("height","80px");
        // $('#pic_2').css("width","115px");
        // $('#pic_3').css("height","90px");
        // $('#pic_3').css("width","140px");
        // $('#pic_4').css("height","120px");
        // $('#pic_4').css("width","180px");
        // $('#pic_5').css("height","150px");
        // $('#pic_5').css("width","230px");
        // $('#pic_6').css("height","200px");
        // $('#pic_6').css("width","300px");
        // $('#pic_7').css("height","220px");
        // $('#pic_7').css("width","360px");
        // $('#pic_8').css("height","260px");
        // $('#pic_8').css("width","420px");

    } else {
        $('.picbox-onhold').addClass('picbox');
        $('.picbox-onhold').removeClass('picbox-onhold');
    }


}



window.onwheel = function() {
    document.body.style.overflowY = "visible";
}

window.onresize = function() {

    if (window.screen.width == document.body.scrollWidth)
        $('#vdo').css("width", "100%");
    else
        $('#vdo').css("width", "auto");



    // $('#vdo').css("width",window.innerWidth+"px");

}

// document.addEventListener("mousewheel",window.onmousewheel=document.onmousewheel=function(e){
// 	e = e||window.event;
// },false);

// window.onmousewheel=function(){
// 	document.body.style.overflowY="visible";

// }