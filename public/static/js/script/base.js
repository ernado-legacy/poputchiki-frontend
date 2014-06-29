$(window).load(function() {
	if (window.pageYOffset == 0) {
		$('.leftMenu').addClass('onload');
	}
});

$(window).scroll(function() {
	if (window.pageYOffset > 0) {
		$('.leftMenu').removeClass('onload');
	}
	else {
		$('.leftMenu').addClass('onload');
	}
});

$(window).scroll(function() {
	if (window.pageYOffset >= 270) {
		$('.menuBox').css('top', '30px');
		$('.menuBox').css('position', 'fixed');
	}
	else {
		$('.menuBox').removeAttr('style');
	}

});

$(function(){

	$('.search .searchBox input').focus(function() {
		$(this).parent().css('border','3px solid #52EDC7');
	});
	$('.search .searchBox input').focusout(function() {
		$(this).parent().css('border','3px solid #eee');
	});


	$('.leftMenu li').click(function(){
		$('.leftMenu li').removeClass('current');
		$(this).addClass('current');
	});

	$('.box').click(function(){
		$(this).toggleClass('checked');
	});

	var removeTag = function(cls){
		$(document).on("click",cls,function() {
			if (!$(this).parent().hasClass('newTag')) { 
				$(this).parent().remove();
			}
		});
	};

	removeTag('.close');
	removeTag('.closeY');

	$(document).on("scroll",".carouselBox",function() {
		p = p - 1;
		str = p.toString() + 'px'
		$('.carousel').css('left',str);
	});

	$('#profile-arrow-left').click(function(){
		$('.carouselBox').animate({scrollLeft: '+=480'}, 'slow');
	});
	$('#profile-arrow-right').click(function(){
		$('.carouselBox').animate({scrollLeft: '-=480'}, 'slow');
	});

	var showMenu = function(end){
		/* anim = document.getElementById("left-menu");
		anim.addEventListener(end,function( event ){
			if ($('.leftMenu li').width() > 60) {
				$('.leftMenu li span').addClass('visibleSpan');
			}
			else {
				$('.leftMenu li span').removeClass('visibleSpan');
			}
		},false); */
	};


	if ($('.leftMenu li').width() > 60) {
		$('.leftMenu li span').addClass('visibleSpan');
	}
	else {
		$('.leftMenu li span').removeClass('visibleSpan');
	}

	showMenu('webkitTransitionEnd');
	showMenu('oTransitionEnd');
	showMenu('MSAnimationEnd');
	showMenu('transitionend');

	var showProgress = function(button) {
		$('.wrapper').removeClass('wrapper1');
		$('.c_left').removeClass('circle1');
		$('.c_right').removeClass('circle2');
		$(button).parent().children('.wrapper').addClass('wrapper1');
		$(button).parent().children('.wrapper').children('.c_left').addClass('circle1');
		$(button).parent().children('.wrapper').children('.c_right').addClass('circle2');
	};

	var stopMedia = function(){
		$('.audio').children().each(function(){
			this.pause()
			this.currentTime = 0;
		});
		$('.video').parent().children('.videoBox').children('video').each(function(){
			this.pause();
			this.currentTime = 0;
			$('.video').parent().parent().children().children('img').removeAttr('style');
			$('.video').parent().parent().children().children('.videoBox').removeAttr('style');
		});
	};

	$('.audio').click(function() {
		stopMedia();
		showProgress(this);
		z = $(this);
		setTimeout(function() {z.children().get(0).play()}, 2000);
	});


	$('.video').click(function() {
		stopMedia();
		animImg = $(this).parent().children('img');
		animVideo = $(this).parent().children('.videoBox');
		showProgress(this);
		
		animImg.css('opacity','0');
		setTimeout(function() {animVideo.children('video').get(0).play()}, 2000);
		animVideo.children('video').get(0).onended = function() {
			setTimeout(function() {
				animVideo.removeAttr('style');
				animImg.removeAttr('style');
				$('.wrapper').removeClass('wrapper1');
				$('.c_left').removeClass('circle1');
				$('.c_right').removeClass('circle2');
			}, 1000);
		};
	});

	var activeAgeBox = function(cell){
		$(cell).children('input').focus(function(){
			$(cell).addClass('activeAgeBox');
		});
		$(cell).children('input').focusout(function(){
			$(cell).removeClass('activeAgeBox');
		});
	};
	activeAgeBox('.ageFrom');
	activeAgeBox('.ageTo');

	//code for registration form 2 (choose sex)
	var sex_checkbox = $('.step .box');
	$(sex_checkbox).click(function() {
		$(sex_checkbox).removeClass('checked');
		$(this).addClass('checked');
	});
	//registration 3st step photo upload
	$('.photo-load .button button').click(function() {
		$('.photo-load .button input').click();
	});
	//reg drop
	$('.step .mainSelectElement').click(function() {
		var drop_list = $(this).parent().find('.droped');
		if ($(drop_list).hasClass('hide')) {
			$(drop_list).removeClass('hide');
			$(drop_list).addClass('show');
		}
		else {
			$(drop_list).removeClass('show');
			$(drop_list).addClass('hide');
		}
	});

	var moneyIcon = function(cnt) {
        $(cnt).click(function() {
            $(this).toggleClass('mg-icon');
        });
    };
    var houseIcon = function(cnt) {
        $(cnt).click(function() {
            $(this).toggleClass('hg-icon');
        });
    };

    moneyIcon('#my-profile .money-icon');
    houseIcon('#my-profile .house-icon');
    moneyIcon('.nearBox .money-icon');
    houseIcon('.nearBox .house-icon');

    $('.season').click(function() {
        $(this).toggleClass('seasonChecked');
    });

	$('.addPhoto').click(function() {
		$('.addPhoto input').click();
	});
});